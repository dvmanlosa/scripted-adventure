"""Pull quest prerequisites and dungeon membership for every quest in the routes from QuestieDB.

Usage:  python -I tools/quest_meta.py <QuestieDB>/data/Forever
Writes tools/quest_meta.json, which tools/convert_routes.py uses:
  requires   quest -> {"all": [...]} and/or {"any": [...]}: quests that must be done first.
             Used in game to drop a skipped quest's follow-ups.
  dungeon    quest -> dungeon name, when every objective source (creature, item drop, object)
             only exists inside that dungeon.
QuestieDB is only parsed as data (out/tools/questie.py), never executed.
"""
import json
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "out" / "tools"))
sys.path.insert(0, str(ROOT / "tools"))
from questie import QuestieDB, parse_lua_literal  # noqa: E402
from convert_routes import ROUTES, OUT, apply_fixes, apply_edits  # noqa: E402

META = ROOT / "tools" / "quest_meta.json"

DUNGEONS = {
    2437: "Ragefire Chasm", 718: "Wailing Caverns", 1581: "The Deadmines", 209: "Shadowfang Keep",
    719: "Blackfathom Deeps", 717: "The Stockade", 721: "Gnomeregan", 491: "Razorfen Kraul",
    796: "Scarlet Monastery", 722: "Razorfen Downs", 1337: "Uldaman", 1176: "Zul'Farrak",
    2100: "Maraudon", 1477: "Sunken Temple", 1584: "Blackrock Depths", 1583: "Blackrock Spire",
    2557: "Dire Maul", 2057: "Scholomance", 2017: "Stratholme",
}


def as_list(v):
    if v is None:
        return []
    if isinstance(v, dict):
        return list(v.values())
    return v if isinstance(v, list) else [v]


class Meta:
    def __init__(self, qdb):
        self.db = QuestieDB(qdb)
        self.items = self.db._index("foreverItemDB.lua")

    def raw(self, idx, key, n):
        text = idx.get(key)
        if text is None:
            return None
        rec = parse_lua_literal(text)
        return self.db._f(rec, n)

    def spawn_zones(self, kind, eid):
        ent = self.db.npc(eid) if kind == "npc" else self.db.obj(eid)
        spawns = ent and ent["spawns"]
        return set(spawns) if isinstance(spawns, dict) else set()

    def source_zones(self, qid):
        """Zones where the quest's objectives can be done, or None if any source is unknown/vendor."""
        objectives = self.raw(self.db._quests, qid, 10)
        if not objectives:
            return None
        get = lambda n: as_list(self.db._f(objectives, n)) if objectives else []
        zones = set()
        for entry in get(1):                                   # creatures to kill
            zones |= self.spawn_zones("npc", as_list(entry)[0])
        for entry in get(2):                                   # objects to use
            zones |= self.spawn_zones("obj", as_list(entry)[0])
        for entry in get(3):                                   # items to collect
            item = as_list(entry)[0]
            if self.raw(self.items, item, 14):                 # sold by a vendor: not dungeon-only
                return None
            for npc in as_list(self.raw(self.items, item, 2)):
                zones |= self.spawn_zones("npc", npc)
            for obj in as_list(self.raw(self.items, item, 3)):
                zones |= self.spawn_zones("obj", obj)
        for entry in get(5):                                   # kill credit groups
            for npc in as_list(as_list(entry)[0]):
                zones |= self.spawn_zones("npc", npc)
        return zones or None

    def dungeon(self, qid):
        zones = self.source_zones(qid)
        if not zones or not zones <= set(DUNGEONS):
            return None
        return DUNGEONS[Counter(zones).most_common(1)[0][0]] if len(zones) == 1 else DUNGEONS[sorted(zones)[0]]


def main(qdb):
    meta = Meta(qdb)
    out = {}
    for route, _starters, json_name, _ in ROUTES:
        data = apply_edits(route, apply_fixes(route, json.loads((OUT / json_name).read_text(encoding="utf-8"))))
        qids = sorted({s["qid"] for g in data["guides"] for s in g["steps"] if "qid" in s})
        in_route = set(qids)
        requires, dungeon = {}, {}
        for q in qids:
            rec = meta.db.quest(q)
            if not rec:
                continue
            req = {}
            group = [p for p in as_list(rec["pre_group"]) if p in in_route]
            if group:
                req["all"] = group
            single = as_list(rec["pre_single"])
            # an any-of group with an option outside the route can always be met another way: skip it
            if single and all(p in in_route for p in single):
                req["any"] = single
            if req:
                requires[str(q)] = req
            d = meta.dungeon(q)
            if d:
                dungeon[str(q)] = d
        out[route] = {"requires": requires, "dungeon": dungeon}
        names = {}
        for g in data["guides"]:
            for s in g["steps"]:
                if str(s.get("qid")) in dungeon:
                    names.setdefault(dungeon[str(s["qid"])], set()).add(s["title"])
        print(f"{route}: {len(requires)} quests with prerequisites in the route, {len(dungeon)} dungeon quests")
        for d, titles in sorted(names.items()):
            print(f"  {d}: {', '.join(sorted(titles))}")
    META.write_text(json.dumps(out, indent=1, sort_keys=True) + "\n", encoding="utf-8")
    print(f"-> {META.relative_to(ROOT)}")


if __name__ == "__main__":
    main(sys.argv[1])
