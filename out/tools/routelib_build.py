"""Generic route build: assemble guides from a profile, filter, place Forever quests, validate, write.

A profile module provides:
  NAME, FACTION ("Alliance"/"Horde"), RACE ("Human"/"Orc"), TGV_DIR, MODULE (output folder name),
  NEW_QUESTS (tsv path), ZONE_ALIAS {wowhead zone key: route zone key}, KEEP_TBC_TRAVEL, TITLE_FIX,
  SKIP_NEW (regex of new quest names never to place), AUTO_PLACE (bool),
  assemble(tgv) -> (order, sources)   sources[name] = (lines, from_tgv)
"""
import csv
import difflib
import json
import math
import re
from collections import OrderedDict, defaultdict
from pathlib import Path

from questie import QuestieDB
from routelib import (COORD, OUT, QDB, ZONE_AREA, convert_coords, guide_zone, load_tgv, parse_step, render_step)

CLASS_BITS = {1: "Warrior", 2: "Paladin", 4: "Hunter", 8: "Rogue", 16: "Priest", 64: "Shaman",
              128: "Mage", 256: "Warlock", 1024: "Druid"}
RACE_ID = {"Human": 1, "Orc": 2, "Dwarf": 3, "Night Elf": 4, "Undead": 5, "Tauren": 6, "Gnome": 7, "Troll": 8}
OPPOSITE_SIDE = {"Alliance": "2", "Horde": "1"}
TBC_PLACES = {"Forest Song", "Mudsprocket"}   # TBC-only hubs: travel there is dropped with its quests
PART = re.compile(r"\s*\(Part \d+\)$")


def zkey_of(zone_name):
    return zone_name.lower().replace(" ", "-").replace("'", "")


def load_new_quests(path):
    rows = {}
    for r in csv.DictReader(open(path, encoding="utf-8"), delimiter="|"):
        r["id"] = int(r["id"])
        r["level"] = int(r["level"] or 0)
        rows[r["id"]] = r
    return rows


def classes_of(mask):
    mask = int(mask or 0)
    return ", ".join(n for b, n in CLASS_BITS.items() if mask & b) if mask else ""


def race_ok(r, race, use_tags=True):
    """Wowhead lists race restrictions ascending; the first ID tells us if `race` can be included.
    Quests that start on Zephras Isle are Skyborne-only and never apply."""
    if (r.get("startcoord") or "").startswith("Zephras Isle"):
        return False
    if not use_tags:
        return True
    first = (r.get("racemask") or "").strip()
    if not first:
        return True
    first = int(first)
    if first == 95:          # Skyborne-only intro quests
        return False
    return first <= RACE_ID[race]


def pt(s):
    """'Zone@x,y' -> (zone, x, y)"""
    if not s:
        return None
    zone, xy = s.split("@")
    x, y = xy.split(",")
    return zone, float(x), float(y)


def ent_name(s):
    """'npc:123:Name' -> 'Name'"""
    return s.split(":", 2)[2] if s and s.count(":") >= 2 else ""


# ---------------------------------------------------------------- automatic placement
def line_coords(lines, gzone):
    """[(index, zone, x, y)] for guide lines that carry a coordinate."""
    out = []
    for i, raw in enumerate(lines):
        s = parse_step(raw) if raw.strip() else None
        if not s:
            continue
        note = s["tags"].get("N", "")
        m = COORD.search(note)
        if m:
            out.append((i, s["tags"].get("Z", gzone), float(m.group(1)), float(m.group(2))))
    return out


def nearest(coords, p, lo=-1):
    """Index of the coordinate line nearest to point p (zone, x, y), at or after lo; None if no same-zone line."""
    if not p:
        return None
    best = None
    for i, z, x, y in coords:
        if z != p[0] or i < lo:
            continue
        d = math.hypot(x - p[1], y - p[2])
        if best is None or d < best[0]:
            best = (d, i)
    return best[1] if best else None


def fmt_xy(p):
    return f"({p[1]:g}, {p[2]:g})"


def auto_place(lines, gzone, quests, part_names, report, gname):
    """Insert A/C/T steps for `quests` into `lines` next to the nearest TourGuide steps.

    quests: new-quest rows (with start/end/startcoord/endcoord/reqcoord/objective) assigned to this guide.
    Returns the new line list. Chains (series) keep their order; A <= C <= T for each quest.
    """
    coords = line_coords(lines, gzone)
    n = len(lines)
    first_anchor = next((i for i, raw in enumerate(lines) if raw.strip() and raw.strip()[0] in "AhHf"), 0)
    inserts = []          # (anchor_index, seq, line)
    done_t = {}           # qid -> anchor index of its turn-in
    seq = 0
    by_id = {q["id"]: q for q in quests}

    def chain_pos(q):
        s = [int(x) for x in (q.get("series") or "").split(";") if x]
        return s

    # order: chain predecessors first, then level
    def sort_key(q):
        return (q["level"], q["id"])

    for q in sorted(quests, key=sort_key):
        title = part_names.get(q["id"], q["name"])
        sp, ep, rp = pt(q.get("startcoord")), pt(q.get("endcoord")), pt(q.get("reqcoord"))
        cls = classes_of(q.get("reqclass"))
        ctag = f" |C|{cls}|" if cls else ""
        # earliest allowed: after the turn-in of any chain predecessor placed in this guide
        lo = -1
        for pid in chain_pos(q):
            if pid in done_t and pid != q["id"] and pid < q["id"]:
                lo = max(lo, done_t[pid])
        a_i = nearest(coords, sp, lo)
        if a_i is None:
            a_i = max(first_anchor, lo)
        c_i = nearest(coords, rp, a_i) if rp else None
        t_i = nearest(coords, ep, (c_i if c_i is not None else a_i))
        if c_i is None and (q.get("objective") or rp):
            c_i = a_i
        if t_i is None:
            t_i = c_i if c_i is not None else a_i
        cf = lambda p: " |CF|" if p and p[0] in ZONE_AREA else ""
        z = lambda p: f" |Z|{p[0]}|" if p and p[0] != gzone else ""
        giver = ent_name(q.get("start"))
        ender = ent_name(q.get("end"))
        seq += 1
        inserts.append((a_i, seq, f"A {title}{ctag} |N|{giver} {fmt_xy(sp) if sp else ''}|{z(sp)} |QID|{q['id']}| |FV|{cf(sp)}"))
        obj = (q.get("objective") or "").strip()
        same_npc = q.get("start") and q.get("start") == q.get("end")
        delivery = not rp and re.match(r"^(Read the|Speak (to|with)|Find |Report to|Deliver |Take )", obj)
        if (obj or rp or same_npc) and not delivery:
            note = obj.rstrip(".") if obj else "Follow the quest text"
            if rp:
                note += f" {fmt_xy(rp)}"
            unv = "" if obj else " |UNV|"
            seq += 1
            inserts.append((c_i, seq, f"C {title}{ctag} |N|{note.replace('|', '/')}|{z(rp)} |QID|{q['id']}| |FV|{unv}{cf(rp)}"))
        seq += 1
        inserts.append((t_i, seq, f"T {title}{ctag} |N|{ender} {fmt_xy(ep) if ep else ''}|{z(ep)} |QID|{q['id']}| |FV|{cf(ep)}"))
        done_t[q["id"]] = t_i
        report["auto_placed"].setdefault(gname, []).append({"qid": q["id"], "name": title, "A": a_i, "C": c_i, "T": t_i})
    out = []
    ins = defaultdict(list)
    for a, s, l in inserts:
        ins[a].append((s, l))
    for i in range(-1, n):
        if i >= 0:
            out.append(lines[i])
        for _, l in sorted(ins.get(i, [])):
            out.append(l)
    return out


def part_names_for(rows):
    """Same quest name under several IDs -> 'Name (Part N)' in ID order (TourGuide strips the suffix)."""
    by = defaultdict(list)
    for r in rows:
        by[r["name"]].append(r["id"])
    out = {}
    for name, ids in by.items():
        if len(ids) > 1:
            for k, i in enumerate(sorted(ids)):
                out[i] = name if k == 0 else f"{name} (Part {k + 1})"
    return out


# ---------------------------------------------------------------- build
def build(P):
    db = QuestieDB(QDB)
    tgv = load_tgv(P.TGV_DIR)
    new_q = load_new_quests(P.NEW_QUESTS)
    report = {"tbc_removed": [], "tbc_kept_travel": [], "coords_converted": [], "inserted": defaultdict(list),
              "advisories": defaultdict(list), "extras_not_in_route": defaultdict(list), "auto_placed": {},
              "validation": {}}
    tgv_qids = {int(q) for g in tgv.values() for l in g["lines"] for q in re.findall(r"\|QID\|(\d+)\|", l)}
    tbc = {q for q in tgv_qids if db.quest(q) is None}
    norm = lambda s: re.sub(r"[^a-z0-9]", "", re.sub(r"\s*\(Part \d+\)", "", s).lower())
    forever_names = {norm(db.quest(q)["name"]) for q in db._quests} | {norm(r["name"]) for r in new_q.values()}
    name_index = defaultdict(list)
    for q in db._quests:
        name_index[norm(db.quest(q)["name"])].append(q)

    order, sources = P.assemble(tgv)
    tgv_lines = {l.strip() for gg in tgv.values() for l in gg["lines"] if l.strip()}

    # ---- assign new quests with giver data to guides, then auto-place (profiles that opt in)
    zone_guides = defaultdict(list)
    for g in order:
        m = re.search(r"\((\d+)(?:-(\d+))?\)", g)
        lo, hi = int(m.group(1)), int(m.group(2) or m.group(1))
        zone_guides[zkey_of(guide_zone(g))].append((g, lo, hi))

    def pick_guide(zkey, lvl):
        zkey = P.ZONE_ALIAS.get(zkey, zkey)
        if callable(zkey):
            zkey = zkey(lvl)
        c = zone_guides.get(zkey)
        if not c:
            return None
        return min(c, key=lambda c: 0 if c[1] - 3 <= lvl <= c[2] + 3 else min(abs(lvl - c[1]), abs(lvl - c[2])))[0]

    placed_auto = set()
    if getattr(P, "AUTO_PLACE", False):
        eligible = [r for r in new_q.values()
                    if r["side"] != OPPOSITE_SIDE[P.FACTION] and race_ok(r, P.RACE, getattr(P, "RACE_FILTER", True)) and not P.SKIP_NEW.match(r["name"])
                    and r.get("start") and r.get("end") and r.get("startcoord") and r["id"] not in P.MANUAL_QIDS]
        part_names = part_names_for(eligible)
        per_guide = defaultdict(list)
        for r in eligible:
            sp = pt(r["startcoord"])
            zk = zkey_of(sp[0]) if sp else r["zone"].split(":", 1)[1]
            g = pick_guide(zk, max(r["level"], int(r["reqlevel"] or 0)))
            if g is None and not r["zone"].startswith("CLASS:"):
                g = pick_guide(r["zone"].split(":", 1)[1], r["level"])
            if g is None:
                continue
            per_guide[g].append(r)
            placed_auto.add(r["id"])
        for g, qs in per_guide.items():
            lines, from_tgv = sources[g]
            sources[g] = (auto_place(lines, guide_zone(g), qs, part_names, report, g), from_tgv)

    route = OrderedDict()
    canon, title_owner = {}, {}   # one title per quest ID; one quest ID per title
    for gi, g in enumerate(order):
        lines, _ = sources[g]
        gzone = guide_zone(g)
        steps, out_lines = [], []
        for raw in lines:
            s = parse_step(raw)
            if s is None:
                if raw.strip() == "" and out_lines and out_lines[-1] != "":
                    out_lines.append("")
                continue
            if "R" in s["tags"] and P.RACE not in s["tags"]["R"]:
                continue  # another race's step
            if s["title"] in P.TITLE_FIX:
                report.setdefault("title_fixes", []).append([g, s["title"], P.TITLE_FIX[s["title"]]])
                s["title"] = P.TITLE_FIX[s["title"]]
            qid = int(s["tags"]["QID"]) if s["tags"].get("QID", "").isdigit() else None
            # Typo fix: the step's quest ID exists and its title is a near-match of the real name.
            if s["code"] in "ACT" and qid and db.quest(qid):
                dbname = db.quest(qid)["name"]
                pm = PART.search(s["title"])
                base = s["title"][:pm.start()] if pm else s["title"]
                nb, nd = norm(base), norm(dbname)
                if nb != nd and (difflib.SequenceMatcher(None, nb, nd).ratio() >= 0.8 or nb.startswith(nd)):
                    fixed = dbname + (pm.group(0) if pm else "")
                    report.setdefault("title_fixes", []).append([g, s["title"], fixed])
                    s["title"] = fixed
                elif nb != nd and name_index.get(nb):
                    # The ID belongs to a different quest; the title names a real one. Use that quest's ID.
                    alts = name_index[nb]
                    better = next((a for a in alts if a in tgv_qids), alts[0])
                    report.setdefault("qid_fixes", []).append([g, s["title"], qid, better])
                    s["tags"]["QID"] = str(better)
                    qid = better
            if s["code"] in "ACT" and norm(s["title"]) not in forever_names:
                report.setdefault("not_in_forever_by_name", []).append({"guide": g, "qid": qid, "step": raw.strip()})
                continue
            if qid in tbc:
                travel = s["code"] in "RFHbhf" and s["title"] not in TBC_PLACES
                if travel or (g, s["code"], s["title"]) in P.KEEP_TBC_TRAVEL:
                    del s["tags"]["QID"]
                    qid = None
                    report["tbc_kept_travel"].append([g, raw.strip()])
                else:
                    report["tbc_removed"].append({"guide": g, "qid": qid, "step": raw.strip()})
                    continue
            # Canonical title per quest ID, so accept/complete/turn-in always match (TourGuide pairs by title).
            if s["code"] in "ACT" and qid:
                same = qid in canon and (norm(PART.sub("", canon[qid])) == norm(PART.sub("", s["title"])) or
                                         difflib.SequenceMatcher(None, norm(canon[qid]), norm(s["title"])).ratio() >= 0.8)
                if qid in canon and same:
                    if canon[qid] != s["title"]:
                        report.setdefault("canonicalized", []).append([g, s["title"], canon[qid]])
                    s["title"] = canon[qid]
                elif qid in canon:
                    # TourGuide data put this quest ID on a different quest; keep the title, drop the bad ID.
                    report.setdefault("qid_conflicts", []).append([g, s["title"], qid, canon[qid]])
                    del s["tags"]["QID"]
                    qid = None
                else:
                    tt = s["title"]
                    if title_owner.get(tt, qid) != qid:
                        base = PART.sub("", tt)
                        k = 2
                        while f"{base} (Part {k})" in title_owner:
                            k += 1
                        tt = f"{base} (Part {k})"
                        report.setdefault("canonicalized", []).append([g, s["title"], tt])
                    canon[qid] = tt
                    title_owner[tt] = qid
                    s["title"] = tt
            origin = "forever" if "FV" in s["flags"] else ("tgv" if raw.strip() in tgv_lines else "authored")
            convert_coords(s, gzone, origin == "tgv", report)
            if "FV" in s["flags"]:
                report["inserted"][g].append(s["code"] + " " + s["title"])
            rec = {"action": s["code"], "title": s["title"], "origin": origin}
            if qid:
                rec["qid"] = qid
            for k, key in (("C", "class"), ("R", "race"), ("N", "note"), ("U", "use_item"), ("L", "loot"), ("LV", "level")):
                if k in s["tags"]:
                    rec[key] = s["tags"][k]
            if "coord" in s:
                rec["coord"] = {"zone": s.get("zone"), "x": s["coord"][0], "y": s["coord"][1]}
            for f, key in (("O", "optional"), ("T", "in_town"), ("UNV", "unverified"), ("NODEBUG", "nodebug")):
                if f in s["flags"]:
                    rec[key] = True
            steps.append(rec)
            out_lines.append(render_step(s))
        nxt = order[gi + 1] if gi + 1 < len(order) else None
        route[g] = {"order": gi + 1, "zone": gzone, "next": nxt, "steps": steps, "lua": out_lines}

    # ---- advisory notes for new quests we could not place
    placed = {st["qid"] for g in route.values() for st in g["steps"] if st.get("qid")}
    adv_by_guide = defaultdict(list)
    for qid, r in sorted(new_q.items()):
        if qid in placed or r["zone"].startswith("CLASS:") or P.SKIP_NEW.match(r["name"]):
            continue
        if r["side"] == OPPOSITE_SIDE[P.FACTION] or not race_ok(r, P.RACE, getattr(P, "RACE_FILTER", True)):
            continue
        zk = r["zone"].split(":", 1)[1]
        g = pick_guide(zk, r["level"])
        if g is None:
            report["extras_not_in_route"][zk].append({"qid": qid, "name": r["name"], "level": r["level"]})
            continue
        adv_by_guide[g].append(r)
    for g, rows in adv_by_guide.items():
        mentioned = " ".join(st["title"] + " " + st.get("note", "") for st in route[g]["steps"])
        seen = {r["name"] for r in rows if r["name"] in mentioned or not r["level"]}
        names = []
        for r in sorted(rows, key=lambda r: r["level"]):
            if r["name"] in seen:
                continue
            seen.add(r["name"])
            names.append(f"{r['name']} ({r['level']})")
            report["advisories"][g].append({"qid": r["id"], "name": r["name"], "level": r["level"]})
        if not names:
            continue
        text = "New Forever quests in this zone, givers not yet in the database: " + "; ".join(names)
        route[g]["steps"].append({"action": "N", "title": "Forever extras", "origin": "forever", "note": text, "advisory": True})
        route[g]["lua"].append(f"N Forever extras |N|{text.replace('|', '/')}| |FV|")

    report["validation"] = validate(route)
    write(P, route, report)
    return route, report


def validate(route):
    val = {"unknown_actions": [], "duplicates": [], "bad_title_case": [], "unclosed_comments": [],
           "accept_without_turnin": [], "turnin_without_accept": []}
    titlematches = ["For", "A", "The", "Or", "In", "Then", "From", "To"]
    accepts, turnins = OrderedDict(), OrderedDict()
    for g, v in route.items():
        seen = set()
        for line in v["lua"]:
            if not line:
                continue
            s = parse_step(line)
            key = (s["code"], s["title"], s["tags"].get("C"))
            if s["code"] in "ACT" and key in seen and "NODEBUG" not in s["flags"]:
                val["duplicates"].append([g, line])
            seen.add(key)
            if s["code"] in "ACT":
                q = s["title"]
                for wd in titlematches:
                    if re.search(rf"[^:]\s{wd}\s", q) or re.search(rf"[^:]\s{wd}$", q):
                        val["bad_title_case"].append([g, q])
                k = (q, s["tags"].get("C", ""))
                if s["code"] == "A":
                    accepts.setdefault(k, g)
                if s["code"] == "T":
                    turnins.setdefault(k, g)
                    if k not in accepts and "O" not in s["flags"] and "NODEBUG" not in s["flags"]:
                        val["turnin_without_accept"].append([g, q, k[1]])
            if re.search(r"(\|[NLUC]V?\|[^|]+)$", line):
                val["unclosed_comments"].append([g, line])
    for k, g in accepts.items():
        if k not in turnins:
            val["accept_without_turnin"].append([g, k[0], k[1]])
    return val


def write(P, route, report):
    mod = OUT / P.MODULE
    mod.mkdir(parents=True, exist_ok=True)
    for old in mod.glob("*.lua"):
        old.unlink()
    files = []
    for g, v in route.items():
        fname = f"{v['order']:02d}_" + re.sub(r"[^A-Za-z0-9]+", "_", g).strip("_") + ".lua"
        files.append(fname)
        nxt = f'"{v["next"]}"' if v["next"] else "nil"
        body = "\n".join(v["lua"]).strip("\n")
        (mod / fname).write_text(
            f'TourGuide:RegisterGuide("{g}", {nxt}, "{P.FACTION}", function()\nreturn [[\n{body}\n]]\nend)\n', encoding="utf-8")
    (mod / "Guides.xml").write_text('<Ui xmlns="http://www.blizzard.com/wow/ui/">\n' +
                                    "".join(f'\t<Script file="{f}"/>\n' for f in files) + "</Ui>\n", encoding="utf-8")
    replaces = "TourGuide_Alliance" if P.FACTION == "Alliance" else "TourGuide_Horde"
    (mod / f"{P.MODULE}.toc").write_text(
        f"## Interface: 11200\n## Title: TourGuide |cff7fff7fForever {P.RACE}|r\n"
        f"## Notes: WoW Forever {P.RACE} route 1-60 built from TourGuideVanilla + Forever quest data. Replaces {replaces}; do not load both.\n"
        "## Dependencies: TourGuide\n## X-Interface-Forever: 16001 (expected; engine port required)\n\nGuides.xml\n", encoding="utf-8")
    slug = P.RACE.lower()
    out = {
        "schema": 1, "title": f"WoW Forever {P.RACE} leveling route 1-60", "faction": P.FACTION, "race": P.RACE,
        "built": "2026-11-07",
        "sources": {"tourguide": "github.com/cralor/TourGuideVanilla (Classic 1.12 data)",
                    "forever_new_quests": "wowhead.com/forever quest listings and quest pages, scraped 2026-11-07",
                    "classic_quests_in_forever": "Questie/QuestieDB data/Forever (Era-seeded, Forever coordinates)",
                    "coordinate_transform": "QuestieDB data/Forever/conversion.json"},
        "step_legend": {"A": "accept", "C": "complete", "T": "turn in", "K": "kill", "R": "run to", "H": "hearth",
                        "h": "set hearth", "G": "grind", "F": "fly", "f": "get flight path", "N": "note",
                        "B": "buy", "b": "boat", "U": "use", "P": "pet skill", "D": "die"},
        "guides": [{"name": g, "order": v["order"], "zone": v["zone"], "next": v["next"], "steps": v["steps"]}
                   for g, v in route.items()],
        "extras_not_in_route": report["extras_not_in_route"],
    }
    (OUT / f"forever_{slug}_route.json").write_text(json.dumps(out, indent=1, ensure_ascii=False), encoding="utf-8")
    (OUT / f"build_report_{slug}.json").write_text(json.dumps(report, indent=1, ensure_ascii=False, default=list), encoding="utf-8")
