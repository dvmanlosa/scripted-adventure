"""Audit the generated routes against QuestieDB's Forever quest data.

Usage:  python -I tools/audit_routes.py <QuestieDB>/data/Forever

Reports, per route:
  - accept steps for quests the route's faction can't take (race mask)
  - quests accepted in a guide whose top level is below the quest's required level
  - quests that will be grey: quest level well below the guide's starting level
  - quest IDs missing from QuestieDB (Forever-only quests are expected here)
Read-only: prints a report, changes nothing.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "out" / "tools"))
sys.path.insert(0, str(ROOT / "tools"))
from questie import QuestieDB  # noqa: E402
from convert_routes import ROUTES, OUT, apply_fixes, apply_edits  # noqa: E402
from match_quest_ids import FACTION_RACES  # noqa: E402

GREY_GAP = 6   # quest level this far under the guide's start level gives little or no XP


def main(qdb):
    db = QuestieDB(qdb)
    for route, starters, json_name, _ in ROUTES:
        data = apply_edits(route, apply_fixes(route, json.loads((OUT / json_name).read_text(encoding="utf-8"))))
        fmask = FACTION_RACES[route]
        wrong_side, too_high, grey, unknown = [], [], [], []
        seen = set()
        for g in data["guides"]:
            m = re.search(r"\((\d+)(?:-(\d+))?\)", g["name"])
            lo, hi = (int(m.group(1)), int(m.group(2) or m.group(1))) if m else (1, 60)
            for s in g["steps"]:
                if s["action"] != "A" or "qid" not in s or s["qid"] in seen:
                    continue
                seen.add(s["qid"])
                q = db.quest(s["qid"])
                where = f"{g['name']}: {s['title']} #{s['qid']}"
                if q is None:
                    if s.get("origin") != "forever":
                        unknown.append(where)
                    continue
                races = q["races"] or 0
                if races and not races & fmask:
                    wrong_side.append(where)
                req = q["req_level"] if isinstance(q["req_level"], int) else 0
                if req > hi + 1:
                    too_high.append(f"{where}: needs level {req}, guide ends at {hi}")
                lvl = q["level"] if isinstance(q["level"], int) else 0
                if 0 < lvl <= lo - GREY_GAP and not s.get("class"):
                    grey.append(f"{where}: level {lvl} quest in a {lo}-{hi} guide")
        print(f"== {route}: {len(seen)} quests accepted")
        for label, items in (("other faction only", wrong_side), ("required level above the guide", too_high),
                             (f"grey (quest level {GREY_GAP}+ under the guide start)", grey),
                             ("not in QuestieDB", unknown)):
            print(f"  {label}: {len(items)}")
            for it in items[:15]:
                print("    " + it)
            if len(items) > 15:
                print(f"    ... {len(items) - 15} more")


if __name__ == "__main__":
    main(sys.argv[1])
