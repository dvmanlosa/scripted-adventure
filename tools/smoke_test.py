"""Load the whole addon (TOC order) against a fake WoW API and drive it like a player.

Usage:  python tools/smoke_test.py            (needs: pip install lupa)

Catches Lua errors and logic bugs (route choice, class/race filtering, ticking, guide
advance, saved progress). It does not check how the window looks; that needs the game.
"""
import re
import sys
from pathlib import Path

from lupa import lua51

ROOT = Path(__file__).resolve().parent.parent

MOCK = r"""
local function mock(kind)
  local o = { _kind = kind, _shown = true, _scripts = {}, _text = "" }
  return setmetatable(o, { __index = function(t, k)
    if k:match("^Create") then return function(self) return mock(k) end end
    if k == "SetScript" then return function(self, n, f) self._scripts[n] = f end end
    if k == "GetScript" then return function(self, n) return self._scripts[n] end end
    if k == "Show" then return function(self) self._shown = true end end
    if k == "Hide" then return function(self) self._shown = false end end
    if k == "SetShown" then return function(self, v) self._shown = not not v end end
    if k == "IsShown" then return function(self) return self._shown end end
    if k == "SetText" then return function(self, v) self._text = v or "" end end
    if k == "GetText" then return function(self) return self._text end end
    if k == "GetStringHeight" then return function(self) return 12 end end
    if k == "RegisterEvent" then return function(self, e) if UNKNOWN_EVENTS[e] then error("Attempt to register unknown event \"" .. e .. "\"") end end end
    if k == "GetFrameLevel" then return function(self) return rawget(self, "_level") or 1 end end
    if k == "SetFrameLevel" then return function(self, v) self._level = v end end
    if k == "SetAlpha" then return function(self, v) self._alpha = v end end
    if k == "GetAlpha" then return function(self) return rawget(self, "_alpha") or 1 end end
    if k == "SetChecked" then return function(self, v) self._checked = v and true or false end end
    if k == "GetChecked" then return function(self) return self._checked end end
    if k == "GetPoint" then return function() return "CENTER", nil, "CENTER", 10, 20 end end
    return function() end
  end })
end
FRAMES, UNKNOWN_EVENTS = {}, {}
CLOCK = 1000
time = function() return 1700000000 end
date = function(fmt, t) return "12:34" end
function GetTime() return CLOCK end
REGISTERED = {}
Settings = {
  RegisterCanvasLayoutCategory = function(frame, name) return { frame = frame, name = name } end,
  RegisterAddOnCategory = function(cat) REGISTERED[#REGISTERED + 1] = cat.name end,
}
function CreateFrame(kind, name) local f = mock(kind); FRAMES[#FRAMES + 1] = f; if name then _G[name] = f end; return f end
UIParent, GameTooltip = mock("UIParent"), mock("GameTooltip")
BackdropTemplateMixin = {}
CHAT = {}
DEFAULT_CHAT_FRAME = { AddMessage = function(_, m) CHAT[#CHAT + 1] = m end }
SlashCmdList = {}
PLAYER = { race = "Orc", class = "WARRIOR", faction = "Horde", level = 1 }
function UnitRace() return PLAYER.race, PLAYER.race end
function UnitClass() return PLAYER.class, PLAYER.class end
function UnitFactionGroup() return PLAYER.faction end
function UnitLevel() return PLAYER.level end
XP, XPMAX = 0, 100
function UnitXP() return XP end
function UnitXPMax() return XPMAX end
function GetItemInfo(id) if id == 16114 then return "Foreman's Blackjack" end end
function GetItemIcon() return 134400 end
-- quest log, completed quests, location, bags
QUESTLOG, COMPLETED, ITEMS = {}, {}, {}
ZONE, SUBZONE, BIND, TAXI, MAPZONE, POSX, POSY = "Durotar", "Valley of Trials", "Valley of Trials", false, "Durotar", 0, 0
C_QuestLog = { IsQuestFlaggedCompleted = function(id) return COMPLETED[id] == true end,
               GetQuestObjectives = function(id) return OBJECTIVES[id] end }
function GetNumQuestLogEntries() return #QUESTLOG end
function GetQuestLogTitle(i)
  local q = QUESTLOG[i]
  return q.title, 10, nil, false, false, q.complete and 1 or nil, nil, q.id
end
function GetZoneText() return ZONE end
function GetSubZoneText() return SUBZONE end
function GetMinimapZoneText() return SUBZONE end
function GetBindLocation() return BIND end
function GetItemCount(id) return ITEMS[id] or 0 end
function UnitOnTaxi() return TAXI end
ERR_NEWTAXIPATH = "New flight path discovered!"
MAPS = { {mapID=1411, name="Durotar", mapType=3}, {mapID=1413, name="The Barrens", mapType=3},
         {mapID=1454, name="Orgrimmar", mapType=3}, {mapID=1429, name="Elwynn Forest", mapType=3} }
PINS, TT, TTREM, CLEARED, SUPER, OPENED, OBJECTIVES = {}, {}, {}, 0, nil, nil, {}
C_Map = {
  GetBestMapForUnit = function() return 1 end,
  GetMapInfo = function(id) return { name = MAPZONE, mapID = id, mapType = 3 } end,
  GetPlayerMapPosition = function() return { GetXY = function() return POSX / 100, POSY / 100 end } end,
  GetMapChildrenInfo = function(root) if root == 947 then return MAPS end return {} end,
  SetUserWaypoint = function(pt) PINS[#PINS + 1] = pt end,
  ClearUserWaypoint = function() CLEARED = CLEARED + 1 end,
  OpenWorldMap = function(m) OPENED = m end,
}
UiMapPoint = { CreateFromCoordinates = function(m, x, y) return { m = m, x = x, y = y } end }
C_SuperTrack = { SetSuperTrackedUserWaypoint = function(v) SUPER = v end }
WorldMapFrame = mock("WorldMapFrame"); WorldMapFrame._shown = false
function TICK() for _, f in ipairs(FRAMES) do local u = f._scripts.OnUpdate; if u then u(f, 1.1) end end end
function FIRE(event, ...)
  for _, f in ipairs(FRAMES) do
    local h = f._scripts.OnEvent
    if h then h(f, event, ...) end
  end
end
"""


def toc_files():
    files = []
    for line in (ROOT / "ScriptedAdventure.toc").read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        path = ROOT / line.replace("\\", "/")
        if path.suffix == ".xml":
            files += [path.parent / f for f in re.findall(r'file="([^"]+)"', path.read_text())]
        else:
            files.append(path)
    return files


def login(race, cls, faction, level, char_db=None, setup=None, client=None):
    lua = lua51.LuaRuntime(unpack_returned_tuples=True)
    lua.execute(MOCK)
    if client:  # Lua run before the addon loads, to fake a different client API
        lua.execute(client)
    g = lua.globals()
    g.PLAYER.race, g.PLAYER["class"], g.PLAYER.faction, g.PLAYER.level = race, cls, faction, level
    ns = lua.eval("{}")
    load = lua.eval("function(src, name) local f, e = loadstring(src, name); if not f then error(e) end; return f end")
    for f in toc_files():
        load(f.read_text(encoding="utf-8"), "@" + f.name)("ScriptedAdventure", ns)
    if char_db is not None:  # SavedVariables: a plain copy, as WoW writes them to disk and reads them back
        def copy(v):
            return lua.table_from({k: copy(x) for k, x in v.items()}) if lua51.lua_type(v) == "table" else v
        g.ScriptedAdventureCharDB = copy(char_db)
    if setup:
        setup(lua, g)
    g.FIRE("PLAYER_LOGIN")
    return lua, g, g.ScriptedAdventure


def chat(g):
    return [g.CHAT[i] for i in range(1, len(g.CHAT) + 1)]


failures = []


def check(cond, what):
    print(("  ok   " if cond else "  FAIL ") + what)
    if not cond:
        failures.append(what)


print("Orc warrior, level 1")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1)
check(SA.guide.name == "Durotar (1-12)", f"starts in Durotar (got {SA.guide.name})")
check(len(chat(g)) == 1 and "Starting with" in chat(g)[0], "one welcome line, no guide errors")
frame = g.ScriptedAdventureFrame
check(frame is not None and frame._shown, "window built and shown")
check(not frame.warn._shown, "no level hint in a guide that fits")
titles = [s.title for s in SA.guide.visible.values()]
check("Simple Tablet" in titles, "sees Orc Warrior class quest")
check("Etched Tablet" not in titles, "hunter quest hidden")
row1 = SA.UI.rows[1]
check(row1.step.title == "Your Place In The World", f"row 1 is first step ({row1.step.title})")
check(sum(1 for r in SA.UI.rows.values() if r._shown) == 4, "4 rows shown by default")
row1._scripts.OnClick(row1)                       # click the current step
check(SA.CurrentStep(SA)[0].title == "Your Place In The World" and SA.CurrentStep(SA)[0].action == "T",
      "clicking row 1 ticks it; next is the turn-in")
g.SlashCmdList.SCRIPTEDADVENTURE("back")
check(SA.CurrentStep(SA)[0].action == "A", "/sa back un-ticks it")
done_before = SA.Progress(SA)[0]
g.SlashCmdList.SCRIPTEDADVENTURE("skip")
check(SA.Progress(SA)[0] == done_before + 1, "/sa skip ticks one step")
check("1/" in frame.progress._text, f"header progress updates ({frame.progress._text})")

# tick every step: should roll into The Barrens and announce it
while SA.guide.name == "Durotar (1-12)":
    SA.Skip(SA)
check(SA.guide.name == "The Barrens (12-15)", "finishing Durotar moves on to The Barrens")
check(any("Finished" in m for m in chat(g)), "announces the next guide")
g.SlashCmdList.SCRIPTEDADVENTURE("back")
check(SA.guide.name == "Durotar (1-12)" and SA.CurrentIndex(SA) == len(SA.guide.visible),
      "/sa back at the start of a guide reopens the previous guide's last step")
saved = g.ScriptedAdventureCharDB

print("Same character after /reload")
lua2, g2, SA2 = login("Orc", "WARRIOR", "Horde", 12, saved)
check(SA2.guide.name == "Durotar (1-12)", "resumes the saved guide")
check(SA2.CurrentIndex(SA2) == len(SA2.guide.visible), "resumes at the saved step")

print("Orc warlock")
_, g, SA = login("Orc", "WARLOCK", "Horde", 1)
titles = [s.title for s in SA.guide.visible.values()]
check("Vile Familiars (Part 1)" in titles and "Vile Familiars" not in titles,
      "warlock sees the warlock version of Vile Familiars only")

print("Tauren druid, level 1 (no starting-zone guide yet)")
_, g, SA = login("Tauren", "DRUID", "Horde", 1)
check(SA.guide.name == "The Barrens (12-15)", f"starts at the shared Horde route ({SA.guide.name})")
check(g.ScriptedAdventureFrame.warn._shown and "No starting-zone guide" in g.ScriptedAdventureFrame.warn._text,
      "window explains the level gap")
g.FIRE("PLAYER_LEVEL_UP", 11)
check(not g.ScriptedAdventureFrame.warn._shown, "hint goes away at level 11")

print("Undead mage, level 33")
_, g, SA = login("Scourge", "MAGE", "Horde", 33)
check(SA.guide.minLevel <= 33 <= SA.guide.maxLevel or SA.guide.maxLevel >= 33,
      f"picks a guide for level 33 ({SA.guide.name})")

print("Human paladin and Night Elf hunter")
_, g, SA = login("Human", "PALADIN", "Alliance", 1)
check(SA.guide.name == "Elwynn Forest (1-12)", "human starts in Elwynn")
_, g, SA = login("NightElf", "HUNTER", "Alliance", 1)
check(SA.guide.name == "Westfall (11-17)", f"night elf starts at the shared Alliance route ({SA.guide.name})")

print("Auto-tick: an alt that already did some quests")


def history(lua, g):
    for qid in (4641, 788, 790, 804):
        g.COMPLETED[qid] = True
    lua.execute('QUESTLOG = { {title="Sting of the Scorpid", id=789, complete=false},'
                ' {title="Lazy Peons", id=5441, complete=true} }')


lua, g, SA = login("Orc", "WARRIOR", "Horde", 3, setup=history)


def state(title, action):
    for s in SA.guide.visible.values():
        if s.title == title and s.action == action:
            return SA.DoneSet(SA, SA.guide)[s.key]
    raise KeyError(title)


check(all(state(t, a) for t, a in [("Your Place In The World", "A"), ("Your Place In The World", "T"),
                                   ("Cutting Teeth", "A"), ("Cutting Teeth", "C"), ("Cutting Teeth", "T"),
                                   ("Sarkoth (Part 2)", "T")]), "turned-in quests tick their accept/complete/turn-in")
check(state("Sting of the Scorpid", "A") and not state("Sting of the Scorpid", "C"),
      "quest in log: accept ticked, unfinished objectives not")
check(state("Lazy Peons", "C") and not state("Lazy Peons", "T"), "finished quest in log: complete ticked, turn-in not")
check(not state("Wayward Weapons", "A"), "quests not started stay open")

lua.execute("table.insert(QUESTLOG, {title=[[Galgar's Cactus Apple Surprise]], id=4402, complete=false})")
g.FIRE("QUEST_ACCEPTED", 3, 4402)
check(state("Galgar's Cactus Apple Surprise", "A"), "QUEST_ACCEPTED ticks the accept step")
g.FIRE("QUEST_TURNED_IN", 5441, 100, 0)
check(state("Lazy Peons", "T"), "QUEST_TURNED_IN ticks the turn-in step")

# untick by hand -> auto-tick leaves it alone
for st in SA.guide.visible.values():
    if st.title == "Lazy Peons" and st.action == "T":
        SA.SetDone(SA, st, False)
g.FIRE("QUEST_LOG_UPDATE")
check(state("Lazy Peons", "T") is False, "a step unticked by hand isn't re-ticked")


def make_current(guide_name, action, title=None):
    """Switch to a guide (None: the first one with such a step) and tick everything before that step."""
    if guide_name is None:
        guide_name = next(gd.name for gd in SA.chain.values()
                          if any(x.action == action and SA.StepApplies(SA, x) for x in gd.steps.values()))
    SA.SetGuide(SA, guide_name)
    done = SA.DoneSet(SA, SA.guide)
    target = None
    for st in SA.guide.visible.values():
        if target is None and st.action == action and (title is None or st.title == title):
            target = st
        done[st.key] = True if target is None else None
    SA.Changed(SA, True)
    assert target is not None, (guide_name, action)
    return target


print("Auto-tick: current-step rules")
st = make_current(None, "h")
lua.globals().BIND = st.title
g.FIRE("CHAT_MSG_SYSTEM", "x")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, f"sethearth ticks when bound to {st.title}")

st = make_current(None, "f")
check(SA.CurrentStep(SA)[0].key == st.key, "flight path step is current")
g.FIRE("TAXIMAP_OPENED")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, "flightpath ticks when the flight map opens")

st = make_current(None, "F")
lua.globals().TAXI = True
g.TICK()
lua.globals().TAXI = False
g.FIRE("PLAYER_CONTROL_GAINED")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, f"fly ticks on landing ({st.title})")

st = make_current(None, "H")
g.FIRE("UNIT_SPELLCAST_SUCCEEDED", "player", "cast", 8690)
check(SA.DoneSet(SA, SA.guide)[st.key] is True, f"hearth ticks when the hearthstone is used ({st.title})")

goto = None
for gd in SA.chain.values():
    for x in gd.steps.values():
        if x.action == "R" and x.x and SA.StepApplies(SA, x):
            goto = (gd.name, x.title, x.zone, x.x, x.y)
            break
    if goto:
        break
st = make_current(goto[0], "R", goto[1])
g.FIRE("ZONE_CHANGED")
check(SA.DoneSet(SA, SA.guide)[st.key] is None, f"goto '{goto[1]}' stays open while elsewhere")
lua.globals().MAPZONE, lua.globals().POSX, lua.globals().POSY = goto[2], goto[3] + 0.5, goto[4]
g.TICK()
g.FIRE("UPDATE")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, f"goto ticks within range of @{goto[3]},{goto[4]}")

st = make_current("The Barrens (16-20)", "R", "Travel to Mulgore")
lua.globals().ZONE, lua.globals().SUBZONE = "The Barrens", "The Crossroads"
g.FIRE("ZONE_CHANGED")
check(SA.DoneSet(SA, SA.guide)[st.key] is None, "'Travel to Mulgore' stays open in The Barrens")
lua.globals().ZONE, lua.globals().SUBZONE = "Mulgore", "Red Rocks"
g.FIRE("ZONE_CHANGED_NEW_AREA")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, "'Travel to Mulgore' ticks on entering Mulgore")

print("Auto-tick off")
g.SlashCmdList.SCRIPTEDADVENTURE("auto off")
st = make_current(None, "f")
g.FIRE("TAXIMAP_OPENED")
check(SA.DoneSet(SA, SA.guide)[st.key] is None, "/sa auto off stops auto-ticking")

print("Client variations")


def accept_ticks(client, label):
    lua, g, SA = login("Orc", "WARRIOR", "Horde", 1, client=client)
    lua.execute("QUESTLOG = { {title=[[Your Place In The World]], id=4641, complete=false} }")
    g.FIRE("QUEST_ACCEPTED", 1, 4641)
    first = SA.guide.visible[1]
    check(SA.DoneSet(SA, SA.guide)[first.key] is True, label)
    return lua, g, SA


accept_ticks("""
local real = GetQuestLogTitle
GetQuestLogTitle = function(i) local t, l, s, h, c, done = real(i); return t, l, s, h, c, done, nil, nil end
""", "quest log without quest IDs: accept ticks by title")
accept_ticks("""
local count, title = GetNumQuestLogEntries, GetQuestLogTitle
C_QuestLog.GetNumQuestLogEntries = function() return count() end
C_QuestLog.GetInfo = function(i) local t, _, _, h, _, done, _, id = title(i); return { title = t, isHeader = h, questID = id } end
C_QuestLog.IsComplete = function() return false end
GetQuestLogTitle, GetNumQuestLogEntries = nil, nil
""", "client with only C_QuestLog.GetInfo: accept ticks")
lua, g, SA = accept_ticks("UNKNOWN_EVENTS.BAG_UPDATE_DELAYED = true",
                          "client missing an event: tracker still loads and ticks")
check(len(SA.Tracker.badEvents) == 1, "the missing event is recorded")
n = len(chat(g))
g.SlashCmdList.SCRIPTEDADVENTURE("debug")
out = chat(g)[n:]
check(any("BAG_UPDATE_DELAYED" in m for m in out) and any("current step" in m for m in out),
      "/sa debug reports missing events and the current step")
lua.execute("GetQuestLogTitle = function() error('boom') end")
g.FIRE("QUEST_LOG_UPDATE")
check(any("auto-tick error" in m for m in chat(g)), "an error during auto-tick is shown in chat, not swallowed")

print("Client like FlowUp's target (modern quest API, bulk completed list, secret values)")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1, client="""
local count, title = GetNumQuestLogEntries, GetQuestLogTitle
C_QuestLog.GetNumQuestLogEntries = function() return count() end
C_QuestLog.GetInfo = function(i) local t, _, _, h, _, done, _, id = title(i); return { title = t, isHeader = h, questID = id } end
C_QuestLog.IsComplete = function(id) for _, q in ipairs(QUESTLOG) do if q.id == id then return q.complete end end return false end
-- the old function still exists but returns junk in the questID slot
GetQuestLogTitle = function(i) local t = title(i); return t, 1, nil, false, false, nil, nil, "junk" end
C_QuestLog.GetAllCompletedQuestIDs = function() return { 4641, 788 } end
C_QuestLog.IsQuestFlaggedCompleted = function() error("should use the bulk list") end
SECRET = {}
issecretvalue = function(v) return SECRET[v] == true end
""")
step = lambda t, a: next(x for x in SA.guide.visible.values() if x.title == t and x.action == a)
done = lambda t, a: SA.DoneSet(SA, SA.guide)[step(t, a).key]
check(done("Your Place In The World", "T") and done("Cutting Teeth", "T"), "bulk completed list ticks turned-in quests on login")
lua.execute("QUESTLOG = { {title=[[Sarkoth]], id=790, complete=true} }")
g.FIRE("QUEST_LOG_UPDATE")
check(done("Sarkoth (Part 1)", "A") and done("Sarkoth (Part 1)", "C"), "modern quest log API preferred over the old one")
lua.execute("SECRET[ [[Valley of Trials]] ] = true")
st = make_current("Durotar (1-12)", "h")
lua.globals().BIND = "Razor Hill"
lua.execute("SECRET[ [[Razor Hill]] ] = true")
g.FIRE("HEARTHSTONE_BOUND")
check(SA.DoneSet(SA, SA.guide)[st.key] is None and not any("auto-tick error" in m for m in chat(g)),
      "secret values are ignored instead of raising errors")
lua.execute("SECRET[ [[Razor Hill]] ] = nil")
g.FIRE("HEARTHSTONE_BOUND")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, "HEARTHSTONE_BOUND ticks the set-hearth step")
sky = SA.ParseGuide("guide: Sky (1-5)\nroute: Horde\nzone: Zephras Isle\nraces: Skyborne\naccept  X  #1  [Skyborne]\n", "t")
check(len(sky[1]) == 0 and sky[0].races.Skyborne, "Skyborne is a known race")

print("Navigation")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1)
G = lua.globals()
check(len(G.PINS) == 0, "no pin while the current step has no coordinates")
make_current("Durotar (1-12)", "C", "Cutting Teeth")
pin = G.PINS[len(G.PINS)]
check(pin is not None and pin.m == 1411 and abs(pin.x - 0.406) < 1e-6 and G.SUPER is True,
      "step with @40.6,62.6 pins Durotar (map 1411) and turns on the on-screen waypoint")
lua.execute("""TomTom = { AddWaypoint = function(self, m, x, y, o) TT[#TT + 1] = { m = m, x = x, y = y, title = o.title }; return #TT end,
                          RemoveWaypoint = function(self, uid) TTREM[#TTREM + 1] = uid end }""")
make_current("Durotar (1-12)", "C", "Sarkoth (Part 1)")
check(len(G.TT) == 1 and G.TT[1].m == 1411 and "Sarkoth" in G.TT[1].title, "TomTom gets a waypoint too when installed")
make_current("Durotar (1-12)", "T", "Sarkoth (Part 2)")
check(len(G.TT) == 2 and G.TTREM[1] == 1, "the previous TomTom waypoint is removed when the step moves on")
before = G.CLEARED
make_current("Durotar (1-12)", "T", "Sarkoth (Part 1)")  # no coordinates
check(G.CLEARED == before + 1, "a step without coordinates clears our pin")
G.WorldMapFrame._shown = True
n = len(G.PINS)
make_current("Durotar (1-12)", "C", "Cutting Teeth")
check(len(G.PINS) == n, "no pin while the world map is open (it would make the map jump)")
G.WorldMapFrame._shown = False
g.TICK()
check(len(G.PINS) == n + 1, "pin is set once the map closes")
g.SlashCmdList.SCRIPTEDADVENTURE("map")
check(G.OPENED == 1411, "/sa map opens the world map on the step's zone")
g.SlashCmdList.SCRIPTEDADVENTURE("nav off")
n = len(G.PINS)
make_current("Durotar (1-12)", "C", "Sarkoth (Part 1)")
check(len(G.PINS) == n, "/sa nav off stops pinning")
g.SlashCmdList.SCRIPTEDADVENTURE("nav on")

print("Objective counts, right-click menu, skipping a quest")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1)
G = lua.globals()
lua.execute("""QUESTLOG = { {title=[[Cutting Teeth]], id=788, complete=false} }
OBJECTIVES[788] = { {text=[[Mottled Boar slain: 3/10]], finished=false} }""")
make_current("Durotar (1-12)", "C", "Cutting Teeth")
g.FIRE("QUEST_LOG_UPDATE")
row1 = SA.UI.rows[1]
check("Mottled Boar slain: 3/10" in row1.detail._text, "complete step shows live objective counts")
lua.execute("OBJECTIVES[788][1].text = [[Mottled Boar slain: 4/10]]")
g.FIRE("QUEST_LOG_UPDATE")
check("4/10" in row1.detail._text, "counts refresh on quest log updates")

sark = next(r for r in SA.UI.rows.values() if r._shown and r.step.qid == 790)
sark._scripts.OnClick(sark, "RightButton")
menu = SA.UI.menu
labels = [b.label for b in menu.buttons.values() if b._shown]
check(menu._shown and labels[:2] == ["Mark done", "Skip this quest"] and "Show on map" in labels,
      f"right-click opens the step menu ({', '.join(labels)})")
next(b for b in menu.buttons.values() if b.label == "Skip this quest")._scripts.OnClick()
sarkoth = [x for x in SA.guide.visible.values() if x.qid == 790]
check(all(SA.IsDone(SA, x) for x in sarkoth) and not menu._shown,
      f"'Skip this quest' passes over all {len(sarkoth)} Sarkoth (Part 1) steps")
check(all(r.step.qid != 790 for r in SA.UI.rows.values() if r._shown), "skipped quest's steps leave the window")
g.SlashCmdList.SCRIPTEDADVENTURE("unskip")
check(not any(SA.IsDone(SA, x) for x in sarkoth), "/sa unskip brings them back")
row1._scripts.OnClick(row1, "RightButton")
next(b for b in menu.buttons.values() if b.label == "Mark done")._scripts.OnClick()
check(SA.CurrentStep(SA)[0].title != "Cutting Teeth" or SA.CurrentStep(SA)[0].action != "C", "'Mark done' ticks the step")

print("Skipping a quest drops its follow-ups")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1)
G = lua.globals()
steps_of = lambda q: [x for x in SA.guide.visible.values() if x.qid == q]
n = len(chat(g))
SA.SkipQuest(SA, 790, "Sarkoth")
check(all(SA.IsDone(SA, x) for x in steps_of(790) + steps_of(804)),
      "skipping Sarkoth (Part 1) also drops Sarkoth (Part 2), which needs it")
check(any("1 follow-up" in m for m in chat(g)[n:]), "the chat line says how many follow-ups went with it")
check(not any(SA.IsDone(SA, x) for x in steps_of(788)), "unrelated quests stay")
g.SlashCmdList.SCRIPTEDADVENTURE("unskip")
check(not any(SA.IsDone(SA, x) for x in steps_of(804)), "/sa unskip brings the follow-up back too")
SA.RegisterQuestInfo(SA, "Horde", "9001 needs 790 or 788\n")
SA.SkipQuest(SA, 790, "Sarkoth")
check(SA.QuestRemoved(SA, 9001) is False, "'needs A or B': still available while one option is left")
SA.SkipQuest(SA, 788, "Cutting Teeth")
check(SA.QuestRemoved(SA, 9001) is True, "'needs A or B': removed once both are skipped")
g.SlashCmdList.SCRIPTEDADVENTURE("unskip")
G.COMPLETED[790] = True
SA.SkipQuest(SA, 790, "Sarkoth")
check(not any(SA.IsDone(SA, x) for x in steps_of(804) if SA.DoneSet(SA, SA.guide)[x.key] is None),
      "a skipped quest you turned in anyway doesn't drop its follow-ups")
g.SlashCmdList.SCRIPTEDADVENTURE("unskip")

print("XP-percent grind steps")
grind = next(x for x in SA.guide.visible.values() if x.action == "G" and x.level == 8)
grind.xp = 70
st = make_current("Durotar (1-12)", "G")
G.PLAYER.level, G.XP = 8, 50
g.FIRE("PLAYER_XP_UPDATE")
row1 = SA.UI.rows[1]
check(SA.DoneSet(SA, SA.guide)[st.key] is None and "70% in" in row1.text._text and "level 8, 50%" in row1.detail._text,
      "grind to level 8 +70% shows your progress and waits at 50%")
G.XP = 75
g.FIRE("PLAYER_XP_UPDATE")
check(SA.DoneSet(SA, SA.guide)[st.key] is True, "ticks at 75% of level 8")
G.PLAYER.level, G.XP = 1, 0

print("Dungeons on/off with alternatives")
lua, g, SA = login("Human", "WARRIOR", "Alliance", 20)
G = lua.globals()
n = len(chat(g))
g.SlashCmdList.SCRIPTEDADVENTURE("dungeons")
check(any("The Deadmines" in m and "on" in m for m in chat(g)[n:]), "/sa dungeons lists The Deadmines (on)")
SA.SetGuide(SA, "The Deadmines (20-22)")
titles = lambda: [x.title for x in SA.guide.visible.values()]
check("Run the Deadmines" in titles() and "Level 20" not in titles(), "dungeon on: the run shows, the alternative doesn't")
dm_row = None
for x in SA.guide.visible.values():
    if x.title == "Run the Deadmines":
        dm = x
labels = [it.label for it in SA.UI.MenuItems(SA.UI, dm).values()]
check("Turn off The Deadmines" in labels, "a dungeon step's menu offers to turn the dungeon off")
g.SlashCmdList.SCRIPTEDADVENTURE("dungeon deadmines off")
t = titles()
check("Run the Deadmines" not in t and "Level 20" in t and "Underground Assault" not in t,
      "dungeon off: run and dungeon quests hidden, the alternative appears")
check("The Defias Brotherhood (Part 6)" in t and "Explosive Consultation (Part 2)" in t,
      "the chapter's solo quests stay")
alt = next(x for x in SA.guide.visible.values() if x.title == "Level 20")
labels = [it.label for it in SA.UI.MenuItems(SA.UI, alt).values()]
check("Turn The Deadmines back on" in labels, "the alternative's menu offers to turn it back on")
SA.SetGuide(SA, "Westfall (11-17)")
check("Underground Assault" not in [x.title for x in SA.guide.visible.values()],
      "earlier guides drop the dungeon quest accepts too")
g.SlashCmdList.SCRIPTEDADVENTURE("dungeon all on")
check("Underground Assault" in [x.title for x in SA.guide.visible.values()], "/sa dungeon all on brings them back")
saved = g.ScriptedAdventureCharDB
g.SlashCmdList.SCRIPTEDADVENTURE("dungeon deadmines off")
lua2, g2, SA2 = login("Human", "WARRIOR", "Alliance", 20, g.ScriptedAdventureCharDB)
SA2.SetGuide(SA2, "The Deadmines (20-22)")
check("Level 20" in [x.title for x in SA2.guide.visible.values()], "the dungeon switch is saved per character")

print("History")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1)
G = lua.globals()
hist = lambda: [G.ScriptedAdventureCharDB.history[i] for i in range(1, len(G.ScriptedAdventureCharDB.history) + 1)]
for _ in range(3):
    r = SA.UI.rows[1]
    r._scripts.OnClick(r, "LeftButton")
h = hist()
check(len(h) == 3 and h[0].how == "manual" and h[0].title == SA.guide.visible[3].title,
      "ticks go into the history, newest first")
lua.execute("QUESTLOG = { {title=[[Cutting Teeth]], id=788, complete=false} }")
g.FIRE("QUEST_ACCEPTED", 1, 788)
check(hist()[0].how == "auto" and hist()[0].title == "Cutting Teeth", "auto-ticks are recorded as auto")
g.SlashCmdList.SCRIPTEDADVENTURE("history")
hf = g.ScriptedAdventureHistory
check(hf._shown and "Cutting Teeth" in hf.rows[1].text._text and "auto-ticked" in hf.rows[1].detail._text,
      "/sa history shows the panel with the latest entry first")
oldest = hf.rows[4]
target = oldest.entry.key
oldest._scripts.OnClick(oldest)
check(SA.CurrentStep(SA)[0].key == target and len(hist()) == 3,
      "clicking an older entry unticks that step and makes it current; the entry leaves the history")
check(SA.IsDone(SA, SA.guide.visible[2]) and SA.IsDone(SA, SA.guide.visible[3]),
      "steps ticked after it stay ticked")
while SA.guide.name == "Durotar (1-12)":
    SA.Skip(SA)
durotar_entry = next(r for r in hf.rows.values() if r._shown and r.entry.guide == "Durotar (1-12)")
durotar_key = durotar_entry.entry.key
durotar_entry._scripts.OnClick(durotar_entry)
check(SA.guide.name == "Durotar (1-12)" and not any(x.key == durotar_key and SA.IsDone(SA, x) for x in SA.guide.visible.values()),
      "an entry from an earlier guide switches back to that guide")
SA.SkipQuest(SA, 790, "Sarkoth")
check("Skipped" in hf.rows[1].text._text and "+1 follow-up" in hf.rows[1].text._text, "quest skips are in the history")
hf.rows[1]._scripts.OnClick(hf.rows[1])
check(not G.ScriptedAdventureCharDB.skipped[790], "clicking a skip entry brings the quest back")
for _ in range(60):
    SA.Skip(SA)
check(len(hist()) == 50, "history keeps the last 50")
_, g2, SA2 = login("Orc", "WARRIOR", "Horde", 1, G.ScriptedAdventureCharDB)
check(len(g2.ScriptedAdventureCharDB.history) == 50, "history is saved per character")

print("Settings page")
lua, g, SA = login("Human", "WARRIOR", "Alliance", 1)
G = lua.globals()
check(list(G.REGISTERED.values()) == ["Scripted Adventure"], "registered in the game's AddOns settings")
g.SlashCmdList.SCRIPTEDADVENTURE("options")
sf = g.ScriptedAdventureSettings
page = SA.Settings.page
check(sf._shown and page is not None, "/sa options (and the gear button) opens the settings window")
ctrl = lambda label: next(c for c in page.controls.values() if c.label and c.label._text == label)
auto = ctrl("Tick steps automatically")
check(auto._checked is True, "checkboxes show the current values")
auto._checked = False
auto._scripts.OnClick(auto)
check(G.ScriptedAdventureDB.auto is False, "unticking 'Tick steps automatically' turns auto-tick off")
shown = ctrl("Steps shown")
shown.plus._scripts.OnClick(shown.plus)
check(G.ScriptedAdventureDB.shown == 5 and shown.value._text == "5" and sum(1 for r in SA.UI.rows.values() if r._shown) == 5,
      "'Steps shown' + shows 5 steps")
size = ctrl("Window size")
size.minus._scripts.OnClick(size.minus)
check(abs(G.ScriptedAdventureDB.scale - 0.9) < 1e-9 and size.value._text == "90%", "'Window size' steps by 10%")
lock = ctrl("Lock window position")
lock._checked = True
lock._scripts.OnClick(lock)
check(G.ScriptedAdventureDB.locked is True, "lock window position")
guide_row = page.guideRow
guide_row.next._scripts.OnClick(guide_row.next)
check(SA.GuideIndex(SA) == 2 and "Westfall" in guide_row.name._text, "guide picker moves to the next guide")
check(page.dungeons[1]._shown and page.dungeons[1].label._text == "The Deadmines" and page.dungeons[1]._checked,
      "dungeons are listed with their on/off state")
d = page.dungeons[1]
d._checked = False
d._scripts.OnClick(d)
check(G.ScriptedAdventureCharDB.dungeonsOff["The Deadmines"] is True, "unticking a dungeon turns it off")
SA.SkipQuest(SA, SA.guide.visible[1].qid or 109, "Test")
SA.Settings.Refresh(SA.Settings)
check("1 quest(s) skipped" in page.skipText._text and page.unskip._shown, "skipped quests are counted")
page.unskip._scripts.OnClick(page.unskip)
check(len(list(G.ScriptedAdventureCharDB.skipped.items())) == 0, "'Bring them all back' unskips")
SA.SetGuide(SA, "Elwynn Forest (1-12)")
r = SA.UI.rows[1]
r._scripts.OnClick(r, "LeftButton")
reset = next(f for f in G.FRAMES.values() if f._text in ("Reset this guide",))
reset._scripts.OnClick(reset)
check(SA.Progress(SA)[0] == 1 and reset._text == "Click again to reset", "reset asks for a second click")
reset._scripts.OnClick(reset)
check(SA.Progress(SA)[0] == 0, "second click resets the guide")
G.PLAYER.level = 30
jump = next(f for f in G.FRAMES.values() if f._text == "Jump to my level")
jump._scripts.OnClick(jump)
check(SA.guide.minLevel <= 30 <= SA.guide.maxLevel or SA.guide.maxLevel >= 30, f"'Jump to my level' picks a level 30 guide ({SA.guide.name})")

print("Animations")
lua, g, SA = login("Orc", "WARRIOR", "Horde", 1)
G = lua.globals()
UI = SA.UI
live = lambda: [r for r in UI.live.keys()]
first, second = UI.rows[1], UI.rows[2]
first._scripts.OnClick(first, "LeftButton")                      # tick the current step
check(first.st.leaving is not None and first.st.leaving.done is True and first._shown,
      "a ticked row stays on screen to animate out")
check(UI.rows[1] is second or UI.rows[1].step.key == second.step.key, "the next step moves into first place")
check(second.st.y > second.st.ty, "it glides up from where it was (not a jump)")
y0 = second.st.y
check(second.st.flashT == 0, "the new current step starts its pulse")
newest = UI.rows[len(UI.rows)]
check(newest.st.a == 0 and newest.st.y > newest.st.ty, "a new row at the bottom fades in from below")
UI.Animate(UI, 0.1)
check(first.st.leaving is not None and first._alpha == 1 and first.glow._alpha > 0,
      "first the tick shows (full alpha, green flash) ...")
UI.Animate(UI, 0.35)
check(first.st.leaving is not None and first.st.x < 0 and first._shown, "... then the row slides left")
check(second.st.y == y0 and not second.bg._shown and second.flash._alpha == 0,
      "while it fades, the next step waits in place (no overlap, no highlight or pulse yet)")
UI.Animate(UI, 0.05)
check(second.st.y == y0, "still waiting until the ticked row has fully faded")
UI.Animate(UI, 0.3)
check(not first._shown and first not in live() and second.st.y == second.st.ty and second.bg._shown,
      "then the ticked row is gone and the next step moves up and takes the highlight")
check(second.flash._alpha > 0 and second.st.flashT is not None, "the current step is still pulsing")
for _ in range(20):
    UI.Animate(UI, 0.1)
check(second.st.flashT is None and second.flash._alpha == 0 and not UI.animating,
      "pulse ends after three flashes and the window goes idle")

SA.SkipQuest(SA, UI.rows[1].step.qid, "test")
gone = [r for r in UI.live.keys() if r.st.leaving is not None]
check(len(gone) >= 1 and all(r.st.leaving.done is False for r in gone),
      "skipped steps fade out without the tick animation")
g.SlashCmdList.SCRIPTEDADVENTURE("unskip")
UI.Animate(UI, 5)

G.ScriptedAdventureDB.anim = False
row = UI.rows[1]
key = row.step.key
row._scripts.OnClick(row, "LeftButton")
check(not any(r.st.leaving is not None for r in UI.live.keys()) and all(r.step.key != key for r in UI.rows.values()),
      "with Animations off, a ticked row disappears at once")
G.ScriptedAdventureDB.anim = True
SA.SetGuide(SA, "The Barrens (12-15)")
check(not any(r.st.leaving is not None for r in UI.live.keys()), "switching guides redraws without animating")

print("Commands")
for c in ["", "", "guides", "guide next", "guide prev", "guide 3", "shown 2", "reset", "errors", "help", "nonsense"]:
    g.SlashCmdList.SCRIPTEDADVENTURE(c)
check(SA.guide.name == SA.chain[3].name, "/sa guide 3 switches guide")
check(sum(1 for r in SA.UI.rows.values() if r._shown) == 2, "/sa shown 2 shows two rows")

print(f"\n{len(failures)} failure(s)")
sys.exit(1 if failures else 0)
