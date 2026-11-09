"""Build the starting-zone guides for the other races with the original route pipeline (out/tools).

Usage:
    python -I tools/build_starters.py <TourGuideVanilla clone> <QuestieDB>/data/Forever

Same method as the Orc and Human routes: TourGuideVanilla's guide, quests that don't exist in
Forever removed (QuestieDB), coordinates converted for zones Forever redrew (Mulgore), and new
Forever quests with known givers placed next to the nearest step. Writes data/starters.json,
which tools/convert_routes.py adds to each faction's route.

The pipeline in out/tools is copied to a temporary folder with its input paths pointed at the
arguments (out/ itself is never written). Two tweaks for guides that serve several races
(Dun Morogh: Dwarf and Gnome): race-tagged steps are kept for every race the guide serves (our
guide format filters them in game), and a new quest is placed if any of those races can take it.
"""
import importlib
import json
import re
import shutil
import sys
import tempfile
import types
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
PIPELINE = ROOT / "out" / "tools"
DATA = ROOT / "out" / "data"
OUTFILE = ROOT / "data" / "starters.json"

SKIP_NEW = re.compile(r"^(Economic Warfare|A Donation of|Sign Me Up|Shipping Label|Learning to Ride|Your First|"
                      r"Welcome to Azeroth|Exploring the|Journey to|Legacy Reward)")

# Orc/Troll (Durotar) and Human (Elwynn) come with the main routes. Skyborne is left out on purpose.
STARTERS = [
    {"route": "Horde", "guide": "Tirisfal Glades (1-12)", "races": ["Undead"], "tgv": "TourGuide_Horde",
     "quests": "forever_new_quests_horde.tsv", "next": "The Barrens (12-15)"},
    {"route": "Horde", "guide": "Mulgore (1-12)", "races": ["Tauren"], "tgv": "TourGuide_Horde",
     "quests": "forever_new_quests_horde.tsv", "next": "The Barrens (12-15)"},
    {"route": "Alliance", "guide": "Dun Morogh (1-11)", "races": ["Dwarf", "Gnome"], "tgv": "TourGuide_Alliance",
     "quests": "forever_new_quests.tsv", "next": "Darkshore (12-17)"},
    {"route": "Alliance", "guide": "Teldrassil (1-12)", "races": ["Night Elf"], "tgv": "TourGuide_Alliance",
     "quests": "forever_new_quests.tsv", "next": "Darkshore (12-17)"},
]


def stage_pipeline(tmp, tgv, qdb):
    """Copy out/tools into tmp with its hard-coded input paths replaced."""
    for f in PIPELINE.glob("*.py"):
        shutil.copy(f, tmp / f.name)
    lib = (tmp / "routelib.py").read_text(encoding="utf-8")
    for name, value in (("TGV_ROOT", tgv), ("AUTH", PIPELINE / "authored"), ("DATA", DATA),
                        ("QDB", qdb), ("OUT", tmp / "out")):
        line = f'{name} = Path("{Path(value).resolve().as_posix()}")'
        lib, n = re.subn(rf'^{name} = Path\(".*?"\)$', lambda _m: line, lib, flags=re.M)
        assert n == 1, f"routelib.py: {name} path not found"
    (tmp / "routelib.py").write_text(lib, encoding="utf-8")
    b = (tmp / "routelib_build.py").read_text(encoding="utf-8")
    old_tag = 'if "R" in s["tags"] and P.RACE not in s["tags"]["R"]:'
    assert old_tag in b
    b = b.replace(old_tag, 'if "R" in s["tags"] and not any(r in s["tags"]["R"] for r in P.RACES):')
    n = b.count("race_ok(r, P.RACE, ")
    assert n == 2, "race_ok calls changed"
    b = b.replace("race_ok(r, P.RACE, ", "any_race_ok(r, P.RACES, ")
    b += '\n\ndef any_race_ok(r, races, use_tags=True):\n    return any(race_ok(r, x, use_tags) for x in races)\n'
    (tmp / "routelib_build.py").write_text(b, encoding="utf-8")
    (tmp / "out").mkdir()


def profile(st):
    guide = st["guide"]

    def assemble(tgv):
        return [guide], {guide: (list(tgv[guide]["lines"]), True)}

    return types.SimpleNamespace(
        NAME=st["races"][0].lower().replace(" ", ""), FACTION=st["route"], RACE=st["races"][0], RACES=st["races"],
        TGV_DIR=st["tgv"], MODULE="TourGuide_Forever" + st["races"][0].replace(" ", ""),
        NEW_QUESTS=DATA / st["quests"], ZONE_ALIAS={}, KEEP_TBC_TRAVEL=set(), TITLE_FIX={},
        SKIP_NEW=SKIP_NEW, AUTO_PLACE=True, RACE_FILTER=True, MANUAL_QIDS=set(), assemble=assemble)


def gaps_from_lua(lua_lines):
    """Indexes of steps that follow a blank line (kept for visual grouping)."""
    gaps, idx, gap = [], 0, False
    for line in lua_lines:
        if not line.strip():
            gap = idx > 0
            continue
        if gap:
            gaps.append(idx)
        gap, idx = False, idx + 1
    return gaps


def add_missing_objectives(steps):
    """Forever quests placed without objective data come out as accept -> turn in. When the same
    NPC gives and takes the quest there is work in between: add a 'complete' step for it."""
    who = lambda s: (s.get("note") or "").split("(")[0].strip()
    out, added = [], 0
    for i, s in enumerate(steps):
        if s["action"] == "T" and s.get("origin") == "forever" and s.get("qid"):
            q = s["qid"]
            accept = next((x for x in steps if x["action"] == "A" and x.get("qid") == q), None)
            has_c = any(x["action"] == "C" and x.get("qid") == q for x in steps)
            if accept and not has_c and who(accept) and who(accept) == who(s):
                out.append({"action": "C", "title": s["title"], "origin": "forever", "qid": q, "unverified": True,
                            "note": "Do what the quest asks (no objective data for this Forever quest yet: follow the quest text)"})
                added += 1
        out.append(s)
    return out, added


def main(tgv, qdb):
    out = {"_about": "Starting-zone guides built by tools/build_starters.py from TourGuideVanilla + QuestieDB + "
                     "Forever quest data. Used by tools/convert_routes.py.", "Horde": [], "Alliance": []}
    with tempfile.TemporaryDirectory() as t:
        tmp = Path(t)
        stage_pipeline(tmp, Path(tgv), Path(qdb))
        sys.path.insert(0, str(tmp))
        build = importlib.import_module("routelib_build").build
        for st in STARTERS:
            route, report = build(profile(st))
            g = route[st["guide"]]
            gaps = gaps_from_lua(g["lua"])
            steps, added = add_missing_objectives(g["steps"])
            if added:  # shift the blank-line positions past the inserted steps
                orig = g["steps"]
                pos = {id(x): i for i, x in enumerate(steps)}
                gaps = [pos[id(orig[i])] for i in gaps if i < len(orig)]
            out[st["route"]].append({
                "name": st["guide"], "zone": g["zone"], "next": st["next"], "races": st["races"],
                "gaps": gaps, "steps": steps,
            })
            removed = len(report["tbc_removed"]) + len(report.get("not_in_forever_by_name", []))
            placed = sum(len(x) for x in report["auto_placed"].values())
            print(f"{st['route']:8} {st['guide']:24} {len(steps):3} steps  "
                  f"removed (not in Forever) {removed}, coords converted {len(report['coords_converted'])}, "
                  f"Forever quests placed {placed} (+{added} objective steps), advisories {sum(len(x) for x in report['advisories'].values())}")
        sys.path.remove(str(tmp))
    OUTFILE.parent.mkdir(exist_ok=True)
    OUTFILE.write_text(json.dumps(out, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"-> {OUTFILE.relative_to(ROOT)}")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
