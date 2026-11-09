"""Read-only parser for QuestieDB Forever data files (Lua table literals).

Never executes Lua: tokenizes the `[id] = {...},` records and converts the
literal (nil, numbers, strings, nested tables) into Python values.

API:
    db = QuestieDB("/root/src/questiedb/data/Forever")
    db.quest(64) -> dict(name, start_npcs, start_objs, start_items, end_npcs,
                         end_objs, req_level, level, objectives, pre_group,
                         pre_single, next_in_chain, zone)
    db.npc(237)  -> dict(name, spawns={zoneId: [(x, y), ...]}, zone)
    db.loc(kind, id, zone=None) -> (zoneId, x, y) or None  (first spawn)
"""
import re
from functools import lru_cache
from pathlib import Path

# Questie zone (AreaTable) IDs for the zones we care about.
ZONES = {
    12: "Elwynn Forest", 40: "Westfall", 1519: "Stormwind City",
    1537: "Ironforge", 1: "Dun Morogh", 38: "Loch Modan",
    44: "Redridge Mountains", 10: "Duskwood", 11: "Wetlands",
    148: "Darkshore", 331: "Ashenvale", 267: "Hillsbrad Foothills",
}

_TOKEN = re.compile(r"""
    (?P<ws>\s+) |
    (?P<lb>\{) | (?P<rb>\}) | (?P<comma>,) | (?P<eq>=) |
    (?P<lk>\[) | (?P<rk>\]) |
    (?P<num>-?\d+(?:\.\d+)?) |
    (?P<nil>nil\b) | (?P<true>true\b) | (?P<false>false\b) |
    (?P<str>"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*')
""", re.X)


def _unescape(s):
    body = s[1:-1]
    return re.sub(r"\\(.)", lambda m: {"n": "\n", "t": "\t"}.get(m.group(1), m.group(1)), body)


def parse_lua_literal(text):
    toks = []
    pos = 0
    while pos < len(text):
        m = _TOKEN.match(text, pos)
        if not m:
            raise ValueError(f"bad token at {pos}: {text[pos:pos+30]!r}")
        kind = m.lastgroup
        if kind != "ws":
            toks.append((kind, m.group()))
        pos = m.end()
    i = 0

    def value():
        nonlocal i
        kind, tok = toks[i]
        if kind == "lb":
            return table()
        i += 1
        if kind == "num":
            return float(tok) if "." in tok else int(tok)
        if kind == "str":
            return _unescape(tok)
        if kind == "nil":
            return None
        if kind == "true":
            return True
        if kind == "false":
            return False
        raise ValueError(f"unexpected {tok}")

    def table():
        nonlocal i
        i += 1  # {
        arr, keyed = [], {}
        while toks[i][0] != "rb":
            if toks[i][0] == "lk":  # [key] = value
                i += 1
                k = value()
                i += 2  # ] =
                keyed[k] = value()
            else:
                arr.append(value())
            if toks[i][0] == "comma":
                i += 1
        i += 1  # }
        return keyed if keyed and not arr else (arr if not keyed else {**dict(enumerate(arr, 1)), **keyed})

    return value()


class QuestieDB:
    def __init__(self, root):
        self.root = Path(root)
        self._quests = self._index("foreverQuestDB.lua")
        self._npcs = self._index("foreverNpcDB.lua")
        self._objs = self._index("foreverObjectDB.lua")

    def _index(self, fname):
        idx = {}
        for line in (self.root / fname).read_text(encoding="utf-8", errors="replace").splitlines():
            m = re.match(r"^\[(\d+)\] = (\{.*\}),\s*$", line)
            if m:
                idx[int(m.group(1))] = m.group(2)
        return idx

    @staticmethod
    def _f(rec, n):
        if isinstance(rec, dict):
            return rec.get(n)
        return rec[n - 1] if len(rec) >= n else None

    @lru_cache(maxsize=None)
    def quest(self, qid):
        raw = self._quests.get(qid)
        if raw is None:
            return None
        r = parse_lua_literal(raw)
        f = lambda n: self._f(r, n)
        sb, fb = f(2) or [], f(3) or []
        g = lambda t, n: (self._f(t, n) or []) if t else []
        return {
            "id": qid, "name": f(1),
            "start_npcs": g(sb, 1), "start_objs": g(sb, 2), "start_items": g(sb, 3),
            "end_npcs": g(fb, 1), "end_objs": g(fb, 2),
            "req_level": f(4), "level": f(5), "races": f(6), "classes": f(7),
            "objectives": f(8), "pre_group": f(12), "pre_single": f(13),
            "zone": f(17), "next_in_chain": f(22),
        }

    @lru_cache(maxsize=None)
    def npc(self, nid):
        raw = self._npcs.get(nid)
        if raw is None:
            return None
        r = parse_lua_literal(raw)
        return {"id": nid, "name": self._f(r, 1), "spawns": self._f(r, 7) or {}, "zone": self._f(r, 9)}

    @lru_cache(maxsize=None)
    def obj(self, oid):
        raw = self._objs.get(oid)
        if raw is None:
            return None
        r = parse_lua_literal(raw)
        return {"id": oid, "name": self._f(r, 1), "spawns": self._f(r, 4) or {}, "zone": self._f(r, 5)}

    def loc(self, kind, eid, zone=None):
        ent = self.npc(eid) if kind == "npc" else self.obj(eid)
        if not ent or not isinstance(ent["spawns"], dict):
            return None
        zones = [zone] if zone in ent["spawns"] else list(ent["spawns"])
        for z in zones:
            pts = ent["spawns"].get(z) or []
            if pts and isinstance(pts[0], list) and pts[0][0] != -1:
                return (z, pts[0][0], pts[0][1])
        return None

    def giver(self, qid, end=False, zone=None):
        """Return (name, zoneId, x, y) for the quest's first start (or end) NPC/object."""
        q = self.quest(qid)
        if not q:
            return None
        npcs = q["end_npcs"] if end else q["start_npcs"]
        objs = q["end_objs"] if end else q["start_objs"]
        for kind, ids in (("npc", npcs), ("obj", objs)):
            for eid in ids or []:
                ent = self.npc(eid) if kind == "npc" else self.obj(eid)
                l = self.loc(kind, eid, zone)
                if ent:
                    return (ent["name"],) + (l if l else (None, None, None))
        return None


if __name__ == "__main__":
    import sys
    db = QuestieDB(sys.argv[1] if len(sys.argv) > 1 else "/root/src/questiedb/data/Forever")
    for qid in (64, 109, 36, 12):
        q = db.quest(qid)
        print(qid, q["name"], q["level"], "start:", db.giver(qid), "end:", db.giver(qid, end=True))
