"""Load every guide through Core/Parser.lua in a real Lua 5.1 runtime and check it.

Usage:  python tools/check_guides.py            (needs: pip install lupa)

Checks
  - every file parses with no errors (unknown verbs, tags, classes, races, headers)
  - each route's start -> next chain reaches every guide, in <Route>.xml order
  - every step matches the source JSON in out/ (action, title, quest ID, coordinate,
    class/race filter, item tags, flags), so the conversion is lossless
Also reports quest steps that have no quest ID (auto-completion will need one).
"""
import json
import re
import sys
from pathlib import Path

from lupa import lua51

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "tools"))
from convert_routes import ROUTES, CLASSES, apply_fixes, apply_edits  # noqa: E402

lua = lua51.LuaRuntime(unpack_returned_tuples=True)
SA = lua.eval("{}")


def run_file(path):
    chunk = lua.execute(f"return function(src, name) return loadstring(src, name) end")(
        path.read_text(encoding="utf-8"), "@" + path.name)
    if chunk is None:
        raise SystemExit(f"{path}: Lua syntax error")
    chunk("ScriptedAdventure", SA)


def lua_list(t):
    return [t[i] for i in range(1, len(t) + 1)] if t else []


def filt(t):
    if t is None:
        return None
    keys = sorted(k for k in t.keys() if k != "negate")
    return (bool(t["negate"]), keys)


run_file(ROOT / "Core" / "Parser.lua")
problems = []
no_qid = []
for route, starters, json_name, _ in ROUTES:
    faction = route
    xml = (ROOT / "Guides" / route / f"{route}.xml").read_text()
    for f in re.findall(r'file="([^"]+)"', xml):
        run_file(ROOT / "Guides" / route / f)
    data = apply_edits(route, apply_fixes(route, json.loads((ROOT / "out" / json_name).read_text(encoding="utf-8"))))

    json_names = [g["name"] for g in data["guides"]]
    # a starter race walks the whole JSON route; a race with no starter skips the starter guides
    starter_race = {"Night Elf": "NightElf", "Undead": "Scourge"}.get(next(iter(starters.values()))[0])
    starter_race = starter_race or next(iter(starters.values()))[0]
    for race, expect in ((starter_race, json_names),
                         ("NoStarter", [n for n in json_names if n not in starters])):
        chain_t, broken = SA.RouteGuides(SA, route, race)
        names = [g["name"] for g in lua_list(chain_t)]
        if broken:
            problems.append(f"{route}/{race}: chain breaks at '{broken}'")
        if names != expect:
            problems.append(f"{route}/{race}: chain differs from JSON order")
        print(f"{route} as {race}: {names[0]} -> {names[-1]} ({len(names)} guides)")
    chain = lua_list(SA.RouteGuides(SA, route, starter_race)[0])

    allc = CLASSES[faction]
    tok = {"Night Elf": "NightElf", "Undead": "Scourge"}
    for g, jg in zip(chain, data["guides"]):
        steps = lua_list(g["steps"])
        if len(steps) != len(jg["steps"]):
            problems.append(f"{g['name']}: {len(steps)} steps, JSON has {len(jg['steps'])}")
            continue
        for s, j in zip(steps, jg["steps"]):
            where = f"{g['name']} line {s['line']}"
            exp = {
                "action": j["action"], "title": re.sub(r"\s+", " ", j["title"]).strip(),
                "qid": j.get("qid"), "useItem": int(j["use_item"]) if "use_item" in j else None,
                "lootItem": int(str(j["loot"]).split()[0]) if "loot" in j else None,
                "lootCount": int(str(j["loot"]).split()[1]) if len(str(j.get("loot", "")).split()) > 1 else None,
                "level": int(j["level"]) if "level" in j else None,
                "forever": True if j.get("origin") == "forever" else None,
                "optional": True if (j.get("optional") or j.get("advisory")) else None,
                "unverified": True if j.get("unverified") else None,
            }
            for k, v in exp.items():
                if s[k] != v:
                    problems.append(f"{where}: {k} is {s[k]!r}, JSON {v!r}")
            if "coord" in j:
                c = j["coord"]
                if s["zone"] != c["zone"] or abs(s["x"] - c["x"]) > 0.051 or abs(s["y"] - c["y"]) > 0.051:
                    problems.append(f"{where}: coord {s['zone']} {s['x']},{s['y']} vs {c}")
            elif s["x"] is not None:
                problems.append(f"{where}: unexpected coordinate")
            # class filter: compare the effective set of classes the step applies to
            if "class" in j:
                want = {c.strip().title() for c in j["class"].split(",")} & set(allc)
                f = filt(s["classes"])
                got = set(allc) if f is None else (
                    {c for c in allc if c.upper() not in f[1]} if f[0] else {c for c in allc if c.upper() in f[1]})
                if want != got:
                    problems.append(f"{where}: classes {sorted(got)} vs JSON {sorted(want)}")
            elif s["classes"] is not None:
                problems.append(f"{where}: unexpected class filter")
            want_r = sorted(tok.get(r.strip(), r.strip()) for r in j["race"].split(",") if r.strip() != "Draenei") if "race" in j else None
            got_r = filt(s["races"])
            if got_r != (None if want_r is None else (False, want_r)):
                problems.append(f"{where}: races {got_r} vs JSON {want_r}")
            if s["action"] in ("A", "C", "T") and s["qid"] is None:
                no_qid.append(f"{route} / {g['name']} line {s['line']}: {s['verb']} {s['title']}")
    total = sum(len(lua_list(g["steps"])) for g in chain)
    print(f"{route}: {len(chain)} guides, {total} steps, chain {chain[0]['name']} -> {chain[-1]['name']}")

for e in lua_list(SA.parseErrors):
    problems.insert(0, f"parse error {e['source']} line {e['line']}: {e['message']}  | {e['text']}")

print(f"\nquest steps without a quest ID: {len(no_qid)}")
for n in no_qid[:10]:
    print("  " + n)
if len(no_qid) > 10:
    print(f"  ... {len(no_qid) - 10} more")
print(f"\nproblems: {len(problems)}")
for p in problems[:40]:
    print("  " + p)
sys.exit(1 if problems else 0)
