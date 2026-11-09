"""Find quest IDs for guide steps that lack one, and check the IDs that are there,
against QuestieDB's Forever quest database.

Usage:
    git clone --depth 1 --filter=blob:none --sparse https://github.com/Questie/QuestieDB.git <dir>
    git -C <dir> sparse-checkout set data/Forever
    python -I tools/match_quest_ids.py <dir>/data/Forever

Writes tools/quest_id_fixes.json, which tools/convert_routes.py applies on the next run:
    { "<route>": { "<guide>": { "<step index>": {"qid": 1234, "title": ..., "why": ...} } } }
Prints every match with the reason, every step it couldn't settle, and existing IDs whose
quest name in the database doesn't match the step title.

QuestieDB files are only read as data (out/tools/questie.py parses the Lua table text;
nothing is executed).
"""
import difflib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "out" / "tools"))
sys.path.insert(0, str(ROOT / "tools"))
from questie import QuestieDB  # noqa: E402  (out/tools/questie.py, read-only literal parser)
from convert_routes import ROUTES  # noqa: E402

FIXES = ROOT / "tools" / "quest_id_fixes.json"

FACTION_RACES = {"Horde": 2 | 16 | 32 | 128, "Alliance": 1 | 4 | 8 | 64}   # Orc Undead Tauren Troll / Human Dwarf NE Gnome
CLASS_BITS = {"WARRIOR": 1, "PALADIN": 2, "HUNTER": 4, "ROGUE": 8, "PRIEST": 16,
              "SHAMAN": 64, "MAGE": 128, "WARLOCK": 256, "DRUID": 1024}
ZONE_IDS = {
    "Dun Morogh": 1, "Badlands": 3, "Blasted Lands": 4, "Swamp of Sorrows": 8, "Duskwood": 10,
    "Wetlands": 11, "Elwynn Forest": 12, "Durotar": 14, "Dustwallow Marsh": 15, "Azshara": 16,
    "The Barrens": 17, "Western Plaguelands": 28, "Stranglethorn Vale": 33, "Alterac Mountains": 36,
    "Loch Modan": 38, "Westfall": 40, "Redridge Mountains": 44, "Arathi Highlands": 45,
    "Burning Steppes": 46, "The Hinterlands": 47, "Hinterlands": 47, "Searing Gorge": 51,
    "Tirisfal Glades": 85, "Silverpine Forest": 130, "Eastern Plaguelands": 139, "Teldrassil": 141,
    "Darkshore": 148, "Mulgore": 215, "Hillsbrad Foothills": 267, "Ashenvale": 331, "Feralas": 357,
    "Felwood": 361, "Thousand Needles": 400, "Desolace": 405, "Stonetalon Mountains": 406,
    "Tanaris": 440, "Un'Goro Crater": 490, "Winterspring": 618, "Silithus": 1377,
    "Undercity": 1497, "Stormwind City": 1519, "Ironforge": 1537, "The Deadmines": 1581,
    "Orgrimmar": 1637, "Thunder Bluff": 1638, "Darnassus": 1657,
}


def norm(s):
    return re.sub(r"[^a-z0-9]+", "", s.lower())


def base_title(t):
    """'Sarkoth (Part 2)' -> ('Sarkoth', 2)"""
    m = re.match(r"^(.*?)\s*\(Part (\d+)\)\s*$", t)
    return (m.group(1), int(m.group(2))) if m else (t, None)


def as_list(v):
    if v is None:
        return []
    if isinstance(v, dict):
        return list(v.values())
    return v if isinstance(v, list) else [v]


def main(qdb_dir):
    db = QuestieDB(qdb_dir)
    by_name = {}
    for qid in db._quests:
        q = db.quest(qid)
        if q and q["name"]:
            by_name.setdefault(norm(q["name"]), []).append(qid)
    names = list(by_name)
    print(f"QuestieDB Forever: {len(db._quests)} quests")

    fixes, unresolved, wrong = {}, [], []
    for route, _starters, json_name, _ in ROUTES:
        data = json.loads((ROOT / "out" / json_name).read_text(encoding="utf-8"))
        fmask = FACTION_RACES[route]
        used = {}                                   # qid -> title, for IDs already in the route
        for g in data["guides"]:
            for s in g["steps"]:
                if "qid" in s:
                    used.setdefault(s["qid"], s["title"])

        # 1. existing IDs: does the database name match the title?
        for g in data["guides"]:
            for i, s in enumerate(g["steps"]):
                if "qid" not in s or s["action"] not in "ACT":
                    continue
                q = db.quest(s["qid"])
                title, _ = base_title(s["title"])
                if q is None:
                    if s.get("origin") != "forever":   # Forever-only quests aren't all in Questie yet
                        wrong.append(f"{route} / {g['name']}: #{s['qid']} {s['title']!r} not in QuestieDB")
                elif norm(q["name"]) != norm(title):
                    wrong.append(f"{route} / {g['name']}: #{s['qid']} is {q['name']!r} in QuestieDB, step says {s['title']!r}")

        # 2. missing IDs. Walk the route in order, tracking accepted (open) and turned-in (done)
        # quests, so same-name quests resolve the way a player would meet them: a turn-in picks the
        # quest that's open, an accept picks one whose prerequisites are done and isn't taken yet.
        open_q, done_q = set(), set()

        def advance(action, qid):
            if action == "A":
                open_q.add(qid)
            elif action == "T":
                open_q.discard(qid)
                done_q.add(qid)

        def prereqs_met(qid):
            q = db.quest(qid)
            single, group = as_list(q["pre_single"]), as_list(q["pre_group"])
            return (not single or any(p in done_q for p in single)) and all(p in done_q for p in group)

        for g in data["guides"]:
            lv = re.search(r"\((\d+)(?:-(\d+))?\)", g["name"])
            lo, hi = (int(lv.group(1)), int(lv.group(2) or lv.group(1))) if lv else (1, 60)
            zone_id = ZONE_IDS.get(g["zone"])
            for i, s in enumerate(g["steps"]):
                if s["action"] not in "ACT":
                    continue
                if "qid" in s:
                    advance(s["action"], s["qid"])
                    continue
                where = f"{route} / {g['name']} step {i + 1}: {s['action']} {s['title']}"
                title, part = base_title(s["title"])
                key, fuzzy = norm(title), False
                if key not in by_name:
                    close = difflib.get_close_matches(key, names, n=1, cutoff=0.88)
                    if not close:
                        unresolved.append(f"{where}  -> no quest with this name")
                        continue
                    key, fuzzy = close[0], True
                cands = []
                for qid in by_name[key]:
                    q = db.quest(qid)
                    races = q["races"] or 0
                    if races and not races & fmask:
                        continue
                    cls = q["classes"] or 0
                    if "class" in s and cls:
                        want = sum(CLASS_BITS.get(c.strip().upper(), 0) for c in s["class"].split(","))
                        if want and not cls & want:
                            continue
                    if qid in used and norm(base_title(used[qid])[0]) != key:
                        continue
                    cands.append(qid)
                if not cands:
                    unresolved.append(f"{where}  -> name matches {by_name[key]} but none fit {route}/class")
                    continue
                how = []
                if s["action"] in "CT":
                    opened = [c for c in cands if c in open_q]
                    if opened:
                        cands, _ = opened, how.append("accepted earlier in the route")
                else:
                    fresh = [c for c in cands if c not in open_q and c not in done_q]
                    ready = [c for c in fresh if prereqs_met(c)]
                    if ready and len(ready) < len(cands):
                        how.append("prerequisites done")
                    cands = ready or fresh or cands

                def score(qid):
                    q = db.quest(qid)
                    lvl = q["level"] if isinstance(q["level"], int) and q["level"] > 0 else (lo + hi) // 2
                    gap = 0 if lo - 2 <= lvl <= hi + 3 else min(abs(lvl - lo), abs(lvl - hi))
                    zone_hit = 1 if zone_id and q["zone"] == zone_id else 0
                    return (gap, -zone_hit)

                cands.sort(key=score)
                best = cands[0]
                if len(cands) > 1 and score(cands[1]) == score(best):
                    opts = ", ".join(f"#{c} lvl {db.quest(c)['level']}" for c in cands)
                    unresolved.append(f"{where}  -> ambiguous: {opts}")
                    continue
                q = db.quest(best)
                why = (f"fuzzy name '{q['name']}'" if fuzzy else "name") + f", level {q['level']}"
                if len(by_name[key]) > 1:
                    why += f", 1 of {len(by_name[key])} with this name" + (f" ({', '.join(how)})" if how else "")
                advance(s["action"], best)
                used.setdefault(best, s["title"])
                fixes.setdefault(route, {}).setdefault(g["name"], {})[str(i)] = {
                    "qid": best, "title": s["title"], "why": why}

    FIXES.write_text(json.dumps(fixes, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    n = sum(len(v) for r in fixes.values() for v in r.values())
    print(f"\nmatched {n} steps -> {FIXES.relative_to(ROOT)}")
    for route, guides in fixes.items():
        for guide, steps in guides.items():
            for idx, f in steps.items():
                print(f"  {route} / {guide} step {int(idx) + 1}: {f['title']} -> #{f['qid']} ({f['why']})")
    print(f"\nunresolved: {len(unresolved)}")
    for u in unresolved:
        print("  " + u)
    print(f"\nexisting IDs that look wrong: {len(wrong)}")
    for w in wrong:
        print("  " + w)


if __name__ == "__main__":
    main(sys.argv[1])
