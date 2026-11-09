"""Convert the TourGuide-style route JSON in out/ into ScriptedAdventure guide files.

Usage:  python -I tools/convert_routes.py            (converts every route below)
Output: Guides/<Route>/NN_<Zone>_<levels>.lua, Guides/<Route>/Route.lua, Guides/<Route>/<Route>.xml

The JSON holds the step data. The TourGuide .lua files are read only to keep their
blank-line grouping, which the JSON doesn't record. See docs/GUIDE_FORMAT.md.
"""
import json
import re
import sys
import textwrap
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "out"
GUIDES = ROOT / "Guides"
FIXES = ROOT / "tools" / "quest_id_fixes.json"   # from tools/match_quest_ids.py


def load_fixes():
    """Quest IDs QuestieDB filled in for steps the JSON left without one."""
    return json.loads(FIXES.read_text(encoding="utf-8")) if FIXES.exists() else {}


def apply_fixes(route, data):
    fixes = load_fixes().get(route, {})
    for g in data["guides"]:
        for idx, f in fixes.get(g["name"], {}).items():
            step = g["steps"][int(idx)]
            if "qid" not in step and step["title"] == f["title"]:
                step["qid"] = f["qid"]
    return data


EDITS = ROOT / "tools" / "route_edits.json"     # hand reordering / notes on top of the JSON


def apply_edits(route, data):
    """Apply tools/route_edits.json (see its _about) to the route's guides, in file order."""
    edits = json.loads(EDITS.read_text(encoding="utf-8")).get(route, {}) if EDITS.exists() else {}
    for g in data["guides"]:
        for e in edits.get(g["name"], []):
            if "replace_qid" in e:              # wrong quest ID on every step of a quest in this guide
                old, new = e["replace_qid"]["from"], e["replace_qid"]["to"]
                hits = [s for s in g["steps"] if s.get("qid") == old]
                assert hits, f"route_edits: {g['name']}: no steps with quest {old}"
                for s in hits:
                    s["qid"] = new
                continue

            def find(ref):
                hits = [s for s in g["steps"] if s["action"] == ref["action"] and s.get("qid") == ref["qid"]]
                assert len(hits) == 1, f"route_edits: {g['name']}: {ref} matches {len(hits)} steps"
                return hits[0]
            step = find(e["step"])
            if e.get("optional"):
                step["optional"] = True
            if "note" in e:
                step["note"] = e["note"]
            if "after" in e:
                anchor = find(e["after"])
                g["steps"].remove(step)
                g["steps"].insert(g["steps"].index(anchor) + 1, step)
                step["_gap"] = False                 # a moved step joins its new group
    return data


ROUTES = [
    # route (= faction), starting-zone guides -> races they serve, json, TourGuide module folder.
    # Races without a starting guide begin at the first shared guide (the one after the starters).
    ("Horde", {"Durotar (1-12)": ["Orc", "Troll"]}, "forever_orc_route.json", "TourGuide_ForeverOrc"),
    ("Alliance", {"Elwynn Forest (1-12)": ["Human"]}, "forever_human_route.json", "TourGuide_ForeverHuman"),
]

VERBS = {
    "A": "accept", "C": "complete", "T": "turnin", "K": "kill",
    "R": "goto", "F": "fly", "f": "flightpath", "b": "boat",
    "H": "hearth", "h": "sethearth", "G": "grind", "N": "note",
    "B": "buy", "U": "use", "P": "petskill", "D": "die",
}
CLASSES = {
    "Horde": ["Warrior", "Hunter", "Rogue", "Priest", "Shaman", "Mage", "Warlock", "Druid"],
    "Alliance": ["Warrior", "Paladin", "Hunter", "Rogue", "Priest", "Mage", "Warlock", "Druid"],
}
VANILLA_RACES = {"Human", "Dwarf", "Night Elf", "Gnome", "Orc", "Undead", "Tauren", "Troll"}
VERB_W = 11      # verb column width
TITLE_MAX = 40   # title column is padded to the longest title in the guide, capped here
WRAP = 96        # notes wrap at this column


def fmt_num(v):
    s = f"{round(float(v), 1):.1f}"
    return s[:-2] if s.endswith(".0") else s


def class_filter(raw, faction):
    names = [c.strip().title() for c in raw.split(",") if c.strip()]
    names = [n for n in names if n != "Death Knight"]          # TourGuide leftover
    allc = CLASSES[faction]
    missing = [c for c in allc if c not in names]
    if not missing:
        return None
    if len(names) >= 5 and len(missing) <= 2:
        return "[not " + ", ".join(missing) + "]"
    return "[" + ", ".join(names) + "]"


COORD_IN_NOTE = re.compile(r"\s*\(\s*(-?\d+(?:\.\d+)?)\s*,\s*(-?\d+(?:\.\d+)?)\s*\)")


def clean_note(note, coord):
    """Drop the parenthesised coordinate that was lifted into the step's @x,y tag."""
    if not note:
        return ""
    if coord:
        def drop(m):
            same = abs(float(m.group(1)) - coord["x"]) < 0.06 and abs(float(m.group(2)) - coord["y"]) < 0.06
            return "" if same else m.group(0)
        note = COORD_IN_NOTE.sub(drop, note, count=1)
    note = re.sub(r"\s+", " ", note).strip()
    note = re.sub(r"\s+([.,;:!?])", r"\1", note)
    return note


def tags_for(step, faction):
    t = []
    if "qid" in step:
        t.append(f"#{step['qid']}")
    if "coord" in step:
        t.append(f"@{fmt_num(step['coord']['x'])},{fmt_num(step['coord']['y'])}")
    if "class" in step:
        f = class_filter(step["class"], faction)
        if f:
            t.append(f)
    if "race" in step:
        races = [r.strip() for r in step["race"].split(",") if r.strip() in VANILLA_RACES]
        if races:
            t.append("[" + ", ".join(races) + "]")
    if "use_item" in step:
        t.append(f"use:{step['use_item']}")
    if "loot" in step:
        item, _, count = str(step["loot"]).partition(" ")
        t.append(f"loot:{item}x{count}" if count else f"loot:{item}")
    if "level" in step:
        t.append(f"level:{step['level']}")
    if step.get("optional") or step.get("advisory"):
        t.append("optional")
    if step.get("origin") == "forever":
        t.append("forever")
    if step.get("unverified"):
        t.append("unverified")
    return "  ".join(t)


def tgv_breaks(lua_path):
    """Indexes of steps that follow a blank line in the TourGuide file."""
    text = lua_path.read_text(encoding="utf-8")
    body = text.split("[[", 1)[1].rsplit("]]", 1)[0]
    breaks, idx, gap = set(), 0, False
    for line in body.split("\n"):
        if not line.strip():
            gap = idx > 0
            continue
        if gap:
            breaks.add(idx)
        gap = False
        idx += 1
    return breaks, idx


def slug(s):
    return re.sub(r"[^A-Za-z0-9]+", "_", s).strip("_")


def convert(route, starters, json_name, tgv_dir):
    faction = route
    data = apply_fixes(route, json.loads((OUT / json_name).read_text(encoding="utf-8")))
    tgv_files = re.findall(r'file="([^"]+)"', (OUT / tgv_dir / "Guides.xml").read_text())
    assert len(tgv_files) == len(data["guides"]), "Guides.xml and JSON disagree on guide count"
    # blank-line grouping is by position in the TourGuide file: attach it before steps move
    for g, tgv_file in zip(data["guides"], tgv_files):
        breaks, n = tgv_breaks(OUT / tgv_dir / tgv_file)
        assert n == len(g["steps"]), f"{g['name']}: step count differs from {tgv_file}"
        for si, st in enumerate(g["steps"]):
            st["_gap"] = si in breaks
    data = apply_edits(route, data)

    dest = GUIDES / route
    dest.mkdir(parents=True, exist_ok=True)
    for old in dest.glob("*.lua"):
        old.unlink()

    files = []
    for gi, g in enumerate(data["guides"], 1):

        m = re.match(r"^(.*?)\s*\((\d+)(?:-(\d+))?\)$", g["name"])
        levels = f"{m.group(2)}-{m.group(3) or m.group(2)}" if m else "?"
        out = [
            f"-- {g['name']} - {route} route - generated from out/{json_name}",
            "-- Format: docs/GUIDE_FORMAT.md",
            "local _, SA = ...",
            "SA:RegisterGuide [==[",
            f"guide:    {g['name']}",
            f"route:    {route}",
            f"faction:  {faction}",
            f"levels:   {levels}",
            f"zone:     {g['zone']}",
        ]
        if g.get("next"):
            out.append(f"next:     {g['next']}")
        if g["name"] in starters:
            out.append(f"races:    {', '.join(starters[g['name']])}")

        width = min(TITLE_MAX, max((len(s["title"]) for s in g["steps"]), default=0)) + 2
        cur_zone = g["zone"]
        out.append("")
        for si, s in enumerate(g["steps"]):
            if s.get("_gap"):
                out.append("")
            coord = s.get("coord")
            if coord and coord["zone"] != cur_zone:
                cur_zone = coord["zone"]
                out.append(f"zone: {cur_zone}")
            title = re.sub(r"\s+", " ", s["title"]).strip()
            tags = tags_for(s, faction)
            line = VERBS[s["action"]].ljust(VERB_W) + (title + " " * max(2, width - len(title)) + tags if tags else title)
            out.append(line.rstrip())
            note = clean_note(s.get("note"), coord)
            if note:
                out.extend(textwrap.wrap(note, WRAP, initial_indent=" " * VERB_W,
                                         subsequent_indent=" " * VERB_W, break_on_hyphens=False))
        out += ["]==]", ""]
        text = "\n".join(out)
        assert "]==]" not in text[text.index("[==[") + 4:text.rindex("]==]")], "note contains ]==]"
        fname = f"{gi:02d}_{slug(g['zone'])}_{levels.replace('-', '_')}.lua"
        (dest / fname).write_text(text, encoding="utf-8", newline="\n")
        files.append(fname)

    start = next(g["name"] for g in data["guides"] if g["name"] not in starters)
    (dest / "Route.lua").write_text("\n".join([
        f"-- WoW Forever {route} leveling route. Starting-zone guides carry a 'races:' header.",
        "local _, SA = ...",
        "SA:RegisterRoute [==[",
        f"route:    {route}",
        f"faction:  {faction}",
        f"start:    {start}",
        "]==]", "",
    ]), encoding="utf-8", newline="\n")
    xml = ['<Ui xmlns="http://www.blizzard.com/wow/ui/">', '\t<Script file="Route.lua"/>']
    xml += [f'\t<Script file="{f}"/>' for f in files] + ["</Ui>", ""]
    (dest / f"{route}.xml").write_text("\n".join(xml), encoding="utf-8", newline="\n")
    steps = sum(len(g["steps"]) for g in data["guides"])
    print(f"{route}: {len(files)} guides, {steps} steps -> {dest.relative_to(ROOT)}")


if __name__ == "__main__":
    want = {a.lower() for a in sys.argv[1:]}
    for r in ROUTES:
        if not want or r[0].lower() in want:
            convert(*r)
