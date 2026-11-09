"""Load every generated guide in a real Lua runtime and re-check the chain.

Only the generated files (our own output) are executed, with a stub TourGuide
object; no TourGuideVanilla or Questie code runs.
Checks: Lua syntax, RegisterGuide arguments, Guides.xml order matches the
next-zone chain, every step line parses with TourGuide's action letters, and
the step count matches the canonical JSON.
"""
import json
import re
import sys
from pathlib import Path

import lupa

RACE = sys.argv[1] if len(sys.argv) > 1 else "human"
MOD = Path(f"/root/work/out/TourGuide_Forever{RACE.capitalize()}")
JSON = Path(f"/root/work/out/forever_{RACE}_route.json")
ACTIONS = set("ACTKRHhGFfNBbUPD")

lua = lupa.LuaRuntime(unpack_returned_tuples=True)
lua.execute("""
TourGuide = { reg = {} }
function TourGuide:RegisterGuide(name, nextzone, faction, fn)
  table.insert(self.reg, {name = name, nextzone = nextzone, faction = faction, text = fn()})
end
""")
xml_order = re.findall(r'file="([^"]+)"', (MOD / "Guides.xml").read_text())
errors = []
for f in xml_order:
    try:
        lua.execute((MOD / f).read_text(encoding="utf-8"))
    except lupa.LuaError as e:
        errors.append(f"{f}: Lua error {e}")
reg = lua.eval("TourGuide.reg")
guides = [reg[i] for i in range(1, len(reg) + 1)]
names = [g["name"] for g in guides]
for i, g in enumerate(guides):
    expected = names[i + 1] if i + 1 < len(names) else None
    if g["nextzone"] != expected:
        errors.append(f"{g['name']}: next is {g['nextzone']!r}, expected {expected!r}")
    if g["faction"] not in ("Alliance", "Horde"):
        errors.append(f"{g['name']}: faction {g['faction']}")
steps = 0
for g in guides:
    for line in g["text"].split("\n"):
        line = line.strip()
        if not line:
            continue
        m = re.match(r"^(\w) ([^|]*)(.*)$", line)
        if not m or m.group(1) not in ACTIONS:
            errors.append(f"{g['name']}: bad step {line!r}")
        steps += 1
data = json.loads(JSON.read_text())
json_steps = sum(len(g["steps"]) for g in data["guides"])
if steps != json_steps:
    errors.append(f"step count mismatch: lua {steps} vs json {json_steps}")
if [g["name"] for g in data["guides"]] != names:
    errors.append("guide order differs between Lua and JSON")
print(f"loaded {len(guides)} guides, {steps} steps; first {names[0]!r} -> last {names[-1]!r}")
print("errors:", len(errors))
for e in errors[:20]:
    print("  ", e)
sys.exit(1 if errors else 0)
