"""Shared engine for building WoW Forever leveling routes from TourGuideVanilla + Forever data.

Used by build_route.py with a profile (route_human.py, route_orc.py). Reads all inputs as data only.
"""
import csv
import json
import re
import sys
from collections import OrderedDict, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

TGV_ROOT = Path("/root/TourGuideVanilla")
AUTH = Path("/root/work/authored")
DATA = Path("/root/work/data")
QDB = Path("/root/src/questiedb/data/Forever")
OUT = Path("/root/work/out")

ACTIONS = set("ACTKRHhGFfNBbUPD")
REG = re.compile(r'RegisterGuide\(\s*"([^"]+)",\s*(?:nil|"([^"]*)"),\s*"(\w+)",\s*function\(\)\s*return \[\[(.*?)\]\]', re.S)
COORD = re.compile(r"\((\d{1,2}(?:\.\d+)?),\s*(\d{1,2}(?:\.\d+)?)\)")

# Zones whose map frame changed in Forever (from Questie's conversion manifest).
ZONE_AREA = {"Stormwind City": 1519, "Redridge Mountains": 44, "Eastern Plaguelands": 139, "Mulgore": 215}


def load_transforms():
    conv = json.loads((QDB / "conversion.json").read_text())
    out = {}
    for t in conv["geometry"]["transforms"]:
        if t["changed"]:
            out[t["area_id"]] = t["coefficients"]
    return out


TRANSFORMS = load_transforms()


def to_forever(zone, x, y):
    c = TRANSFORMS.get(ZONE_AREA.get(zone))
    if not c:
        return x, y, False
    return round(c["scale_x"] * x + c["offset_x"], 1), round(c["scale_y"] * y + c["offset_y"], 1), True


# ---------------------------------------------------------------- guide text
def load_tgv(subdir):
    guides = {}
    for p in sorted((TGV_ROOT / subdir).glob("*.lua")):
        m = REG.search(p.read_text(encoding="utf-8", errors="replace"))
        if m:
            guides[m.group(1)] = {"next": m.group(2), "lines": m.group(4).split("\n"), "file": p.name}
    return guides


def find(lines, pattern, start=0):
    rx = re.compile(pattern)
    for i in range(start, len(lines)):
        if rx.search(lines[i]):
            return i
    raise KeyError(f"anchor not found: {pattern}")


def insert_after(lines, pattern, new, nth=1):
    i = -1
    for _ in range(nth):
        i = find(lines, pattern, i + 1)
    lines[i + 1:i + 1] = new


def insert_before(lines, pattern, new):
    i = find(lines, pattern)
    lines[i:i] = new


def FV(s):
    return s if "|FV|" in s else s + " |FV|"


# ---------------------------------------------------------------- step parsing
VALUE_TAGS = ["N", "Z", "SZ", "C", "R", "U", "L", "QO", "Q", "LV", "PRE", "QID"]
FLAG_TAGS = ["O", "T", "S", "NODEBUG", "FV", "UNV", "CF"]


def parse_step(line):
    """Parse one TourGuide step the way TourGuide itself reads tags (search each tag by name)."""
    line = line.strip()
    if not line or line.startswith("--"):
        return None
    m = re.match(r"^(\w) ([^|]*)(.*)$", line)
    if not m or m.group(1) not in ACTIONS:
        raise ValueError(f"bad step: {line}")
    code, title, rest = m.group(1), m.group(2).strip(), m.group(3)
    tags = {}
    for k in VALUE_TAGS:
        tm = re.search(rf"\|{k}\|([^|]*)\|", rest)
        if tm and tm.group(1).strip():
            tags[k] = tm.group(1).strip()
    flags = [f for f in FLAG_TAGS if re.search(rf"\|{f}\|(?=\s|$)", rest)]
    return {"code": code, "title": title, "tags": tags, "flags": flags}


def render_step(s):
    parts = [f"{s['code']} {s['title']}"]
    order = ["N", "Z", "SZ", "C", "R", "U", "L", "QO", "LV", "PRE"]
    for k in order:
        if k in s["tags"]:
            parts.append(f"|{k}|{s['tags'][k]}|")
    for f in s["flags"]:
        if f in ("O", "T", "S", "NODEBUG"):
            parts.append(f"|{f}|")
    if "QID" in s["tags"]:
        parts.append(f"|QID|{s['tags']['QID']}|")
    if "FV" in s["flags"]:
        parts.append("|FV|")
    if "UNV" in s["flags"]:
        parts.append("|UNV|")
    return " ".join(parts)


SW_HINT = re.compile(r"Trade District|Old Town|Mage Quarter|Dwarven District|Cathedral|Stormwind Keep|Canals|Park\b")
REDRIDGE_HINT = re.compile(r"Lakeshire")


def guide_zone(name):
    return re.sub(r" \(.*\)$", "", name)


def convert_coords(step, gzone, from_tgv, report):
    note = step["tags"].get("N")
    if not note:
        return
    zone = step["tags"].get("Z")
    if not zone:
        if SW_HINT.search(note) and gzone not in ZONE_AREA:
            zone = "Stormwind City"
        elif REDRIDGE_HINT.search(note) and gzone != "Redridge Mountains":
            zone = "Redridge Mountains"
        else:
            zone = gzone
    step["zone"] = zone
    if not COORD.search(note):
        return
    classic_frame = from_tgv or "CF" in step["flags"]
    points = []

    def conv(m):
        x, y = float(m.group(1)), float(m.group(2))
        if classic_frame and zone in ZONE_AREA:
            nx, ny, changed = to_forever(zone, x, y)
            if changed:
                report["coords_converted"].append({"zone": zone, "from": [x, y], "to": [nx, ny], "step": step["title"]})
                points.append([nx, ny])
                return f"({nx}, {ny})"
        points.append([x, y])
        return m.group(0)

    step["tags"]["N"] = COORD.sub(conv, note)  # every coordinate in the note, not just the first
    step["coord"] = points[0]
    if "CF" in step["flags"]:
        step["flags"].remove("CF")
