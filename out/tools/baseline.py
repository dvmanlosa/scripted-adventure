"""Validation of the raw TourGuideVanilla chain for a race (no Forever changes), to separate pre-existing warnings."""
import importlib, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from routelib import load_tgv, parse_step, render_step
from routelib_build import validate

P = importlib.import_module(f"route_{sys.argv[1]}")
tgv = load_tgv(P.TGV_DIR)
order = list(P.assemble.__globals__["assemble"](tgv)[0]) if False else None
start = {"human": ["Elwynn Forest (1-12)", "Darkshore (12-17)"], "orc": ["Durotar (1-12)", "The Barrens (12-15)"]}[sys.argv[1]]
chain, n = [start[0]], start[1]
while n:
    chain.append(n); n = tgv[n]["next"]
route = {}
for g in chain:
    lua = []
    for raw in tgv[g]["lines"]:
        s = parse_step(raw)
        if s and not ("R" in s["tags"] and P.RACE not in s["tags"]["R"]):
            lua.append(render_step(s))
    route[g] = {"lua": lua}
v = validate(route)
print({k: len(x) for k, x in v.items()})
import json; json.dump(v, open(f"/root/work/out/baseline_{sys.argv[1]}.json", "w"), indent=1)
