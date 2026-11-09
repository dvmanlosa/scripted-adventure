"""Build a WoW Forever leveling route.

Usage: python3 -I build_route.py human|orc
Profiles live in route_<name>.py; the engine is routelib.py + routelib_build.py.
"""
import importlib
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from routelib_build import build  # noqa: E402


def main(name):
    P = importlib.import_module(f"route_{name}")
    route, r = build(P)
    v = r["validation"]
    removed = len({x["qid"] for x in r["tbc_removed"]} | {x["step"].split("|")[0][2:].strip() for x in r.get("not_in_forever_by_name", [])})
    print(f"[{P.RACE}] guides: {len(route)}  steps: {sum(len(g['steps']) for g in route.values())}")
    print(f"  quests not in Forever removed: {removed} ({len(r['tbc_removed']) + len(r.get('not_in_forever_by_name', []))} steps); travel kept: {len(r['tbc_kept_travel'])}")
    print(f"  coords converted: {len(r['coords_converted'])}  forever steps: {sum(len(x) for x in r['inserted'].values())}"
          f"  auto-placed quests: {sum(len(x) for x in r['auto_placed'].values())}  advisory quests: {sum(len(x) for x in r['advisories'].values())}")
    print("  extras not in route:", {k: len(x) for k, x in r["extras_not_in_route"].items()})
    print(f"  title fixes: {len(r.get('title_fixes', []))}  canonicalized: {len(r.get('canonicalized', []))}")
    print("  validation:", {k: len(x) for k, x in v.items()})


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "human")
