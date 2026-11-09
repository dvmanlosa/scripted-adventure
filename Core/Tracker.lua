-- ScriptedAdventure tracker: ticks steps automatically from what the game reports.
--
--  Any step in the current guide (so steps you did out of order, or on an earlier play
--  session, tick on login):
--    accept    quest is in your log, or already turned in
--    complete  quest in your log is complete, or already turned in   (kill with a quest ID too)
--    turnin    quest is flagged completed / was just turned in
--    grind     your level reached level:N
--    loot:IDxN on a non-quest step: you carry N of the item
--  Only the current step (these depend on where you are right now):
--    goto / boat   you're in the named zone or subzone, or near the step's @x,y
--    fly           you landed after a flight, or you're at the destination
--    flightpath    you opened a flight map or discovered a new flight path
--    sethearth     your hearthstone is bound to the named place
--    hearth        you used your hearthstone, or you're at the destination
--    die           you died
-- A step you untick yourself is never auto-ticked again (so "back" sticks).

local _, SA = ...
local T = {}
SA.Tracker = T

local isFlaggedCompleted = (C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted) or IsQuestFlaggedCompleted

-- Newer clients can hand back "secret" values that raise an error when compared; treat them as unknown.
local function secret(v) return issecretvalue ~= nil and issecretvalue(v) or false end
local function num(v) return type(v) == "number" and not secret(v) end
local function str(v) return type(v) == "string" and not secret(v) end
local HEARTHSTONE_SPELL = 8690

local function norm(s)
    if not s then return "" end
    s = s:lower():gsub("%s*%(part %d+%)%s*$", ""):gsub("^the%s+", "")
    return (s:gsub("[^%w]", ""))
end

---------------------------------------------------------------------------
-- What the game knows
---------------------------------------------------------------------------

T.turnedIn = {} -- quest IDs turned in this session (the completed flag can lag the event)

-- One quest log line -> title, isHeader, isComplete, questID. Supports the classic
-- GetQuestLogTitle API and the newer C_QuestLog.GetInfo API, whichever this client has.
local modernLog = C_QuestLog and C_QuestLog.GetInfo and C_QuestLog.GetNumQuestLogEntries and true or false

local function logLine(i)
    if modernLog then
        local ok, info = pcall(C_QuestLog.GetInfo, i)
        if not ok or type(info) ~= "table" then return end
        local qid = num(info.questID) and info.questID or nil
        local complete
        if qid and C_QuestLog.IsComplete then
            local okC, c = pcall(C_QuestLog.IsComplete, qid)
            if okC and not secret(c) then complete = c end
        end
        if complete == nil then complete = info.isComplete end
        return str(info.title) and info.title or nil, info.isHeader == true, complete == 1 or complete == true, qid
    end
    if GetQuestLogTitle then
        local title, _, _, isHeader, _, isComplete, _, questID = GetQuestLogTitle(i)
        return str(title) and title or nil, isHeader and true or false,
            isComplete == 1 or isComplete == true, num(questID) and questID or nil
    end
end

local function logCount()
    local fn = modernLog and C_QuestLog.GetNumQuestLogEntries or GetNumQuestLogEntries
    if not fn then return 0 end
    local ok, n = pcall(fn)
    return (ok and num(n)) and n or 0
end
T.LogLine, T.LogCount = logLine, logCount

-- Quest log -> byId[qid] / byTitle[norm(title)] = { complete = bool, title = ..., id = ... }
function T:ScanLog()
    local byId, byTitle, list = {}, {}, {}
    for i = 1, logCount() do
        local title, isHeader, complete, questID = logLine(i)
        if title and not isHeader then
            local entry = { complete = complete, title = title, id = questID }
            if questID and questID > 0 then byId[questID] = entry end
            byTitle[norm(title)] = entry
            list[#list + 1] = entry
        end
    end
    self.byId, self.byTitle, self.logList = byId, byTitle, list
end

-- All turned-in quest IDs in one call, when the client has it (once per session; turn-ins
-- after that arrive through QUEST_TURNED_IN).
function T:LoadCompleted()
    if self.completedLoaded or not (C_QuestLog and C_QuestLog.GetAllCompletedQuestIDs) then return end
    local ok, ids = pcall(C_QuestLog.GetAllCompletedQuestIDs)
    if not ok or type(ids) ~= "table" or #ids == 0 then return end
    for _, q in ipairs(ids) do
        if num(q) then self.turnedIn[q] = true end
    end
    self.completedLoaded = true
end

function T:QuestDone(qid)
    if not qid then return false end
    if self.turnedIn[qid] then return true end
    if self.completedLoaded or not isFlaggedCompleted then return false end
    local ok, v = pcall(isFlaggedCompleted, qid)
    return ok and v == true
end

-- Live objective lines for a quest in the log: { {text = "Mottled Boar slain: 3/10", done = bool}, ... }
function T:Objectives(qid)
    if not qid then return nil end
    local out = {}
    if C_QuestLog and C_QuestLog.GetQuestObjectives then
        local ok, objs = pcall(C_QuestLog.GetQuestObjectives, qid)
        if not ok or type(objs) ~= "table" then return nil end
        for _, o in ipairs(objs) do
            if type(o) == "table" and str(o.text) and o.text ~= "" then
                out[#out + 1] = { text = o.text, done = o.finished == true }
            end
        end
    elseif GetQuestLogIndexByID and GetNumQuestLeaderBoards and GetQuestLogLeaderBoard then
        local index = GetQuestLogIndexByID(qid)
        if not num(index) or index < 1 then return nil end
        for j = 1, GetNumQuestLeaderBoards(index) or 0 do
            local text, _, finished = GetQuestLogLeaderBoard(j, index)
            if str(text) and text ~= "" then out[#out + 1] = { text = text, done = finished and true or false } end
        end
    end
    return #out > 0 and out or nil
end

-- Find the step's quest in the log: by quest ID, then by title (covers clients that don't
-- return quest IDs from the log, and quests whose ID differs on this server).
function T:LogEntry(step)
    if step.qid and self.byId[step.qid] then return self.byId[step.qid] end
    return self.byTitle[norm(step.title)]
end

-- Same place? Tolerates "Travel to Mulgore", "City of Ironforge" vs "Ironforge",
-- "Theramore" vs "Theramore Isle".
local function samePlace(a, b)
    if a == "" or b == "" then return false end
    if a == b then return true end
    local short, long = a, b
    if #short > #long then short, long = long, short end
    return #short >= 6 and long:find(short, 1, true) ~= nil
end

local function hereMatches(name)
    local want = (name or ""):lower()
    for _, prefix in ipairs({ "travel to ", "go to ", "run to ", "head to " }) do
        if want:sub(1, #prefix) == prefix then want = want:sub(#prefix + 1) end
    end
    want = norm(want)
    for _, text in ipairs({ GetSubZoneText and GetSubZoneText(), GetZoneText and GetZoneText(),
                            GetMinimapZoneText and GetMinimapZoneText() }) do
        if str(text) and text ~= "" and samePlace(norm(text), want) then return true end
    end
    return false
end

-- Player position in the step's zone, in the guide's 0-100 coordinates, or nil.
local function playerPos(zone)
    if not (C_Map and C_Map.GetBestMapForUnit) then return end
    local mapID = C_Map.GetBestMapForUnit("player")
    local info = mapID and C_Map.GetMapInfo(mapID)
    if not info or norm(info.name) ~= norm(zone) then return end
    local pos = C_Map.GetPlayerMapPosition(mapID, "player")
    if not pos then return end
    local x, y = pos:GetXY()
    if not (num(x) and num(y)) then return end
    return x * 100, y * 100
end

local ARRIVE_DISTANCE = 1.5 -- map percent; roughly 30-60 yards depending on zone size

local function nearStep(step)
    if not step.x then return false end
    local x, y = playerPos(step.zone)
    if not x then return false end
    local dx, dy = x - step.x, y - step.y
    return dx * dx + dy * dy <= ARRIVE_DISTANCE * ARRIVE_DISTANCE
end

---------------------------------------------------------------------------
-- Rules
---------------------------------------------------------------------------

-- Checks that hold for any step in the guide, whenever they're evaluated.
function T:AnyStepDone(step)
    local a = step.action
    if a == "A" or a == "C" or a == "T" or (a == "K" and step.qid) then
        if self:QuestDone(step.qid) then return true end
        if a == "T" then return false end
        local entry = self:LogEntry(step)
        if a == "A" then return entry ~= nil end
        return entry ~= nil and entry.complete
    end
    if a == "G" and step.level then
        -- level:N alone = reach level N; with xp:P = P% of the way through level N
        local lvl = UnitLevel("player") or 0
        if lvl ~= step.level or not step.xp then return lvl >= step.level end
        local cur, max = UnitXP and UnitXP("player"), UnitXPMax and UnitXPMax("player")
        return num(cur) and num(max) and max > 0 and cur / max * 100 >= step.xp or false
    end
    if step.lootItem and GetItemCount then
        return GetItemCount(step.lootItem) >= (step.lootCount or 1)
    end
    return false
end

-- Checks that only make sense for the step you're on now. 'event' is what just happened.
function T:CurrentStepDone(step, event)
    local a = step.action
    if a == "R" or a == "b" then
        return hereMatches(step.title) or nearStep(step)
    elseif a == "F" then
        return event == "LANDED" or hereMatches(step.title)
    elseif a == "f" then
        return event == "TAXIMAP_OPENED" or event == "NEW_FLIGHT_PATH"
    elseif a == "h" then
        local bind = GetBindLocation and GetBindLocation()
        return str(bind) and samePlace(norm(bind), norm(step.title))
    elseif a == "H" then
        return event == "HEARTH" or hereMatches(step.title)
    elseif a == "D" then
        return event == "PLAYER_DEAD"
    end
    return false
end

-- Tick whatever is now done. Called (throttled) after relevant game events.
function T:Evaluate(event)
    if not SA.guide or not SA.db or SA.db.auto == false then return end
    self:LoadCompleted()
    SA.removedCache = nil -- a turn-in can bring back follow-ups of quests you did after all
    self:ScanLog()
    local set, changed = SA:DoneSet(SA.guide), false
    for _, step in ipairs(SA.guide.visible) do
        if set[step.key] == nil and self:AnyStepDone(step) then -- nil: not done, not unticked by hand
            set[step.key] = true
            changed = true
        end
    end
    -- current-step rules; once one ticks, the new current step gets a location check too
    -- (the event itself, e.g. LANDED, only counts for the step that was current when it happened)
    for _ = 1, 10 do
        local step = SA:CurrentStep()
        if not step or set[step.key] ~= nil or not self:CurrentStepDone(step, event) then break end
        set[step.key] = true
        changed, event = true, nil
    end
    if changed then
        SA:Changed() -- may move to the next guide, which evaluates again
    elseif SA.UI then
        SA.UI:Update() -- objective counts may have moved
    end
end

-- Coalesce bursts of events (QUEST_LOG_UPDATE fires a lot) into one evaluation.
function T:Schedule(event)
    if event and event ~= "UPDATE" then self.pendingEvent = event end
    if self.pending then return end
    self.pending = true
    local run = function()
        T.pending = false
        local ev = T.pendingEvent
        T.pendingEvent = nil
        -- WoW hides Lua errors by default; catch them so a failure is visible in chat and /sa debug
        local ok, err = pcall(T.Evaluate, T, ev)
        if not ok then
            T.lastError = tostring(err)
            if not T.errorShown then
                T.errorShown = true
                SA.Print("|cffff6060auto-tick error:|r " .. T.lastError .. "  (/sa debug for details)")
            end
        end
    end
    if C_Timer and C_Timer.After then C_Timer.After(0.3, run) else run() end
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local f = CreateFrame("Frame")
T.frame = f
local EVENTS = {
    "QUEST_ACCEPTED", "QUEST_LOG_UPDATE", "QUEST_REMOVED", "QUEST_TURNED_IN", "UNIT_QUEST_LOG_CHANGED",
    "PLAYER_LEVEL_UP", "BAG_UPDATE_DELAYED", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA", "PLAYER_ENTERING_WORLD", "TAXIMAP_OPENED", "UI_INFO_MESSAGE",
    "CHAT_MSG_SYSTEM", "UNIT_SPELLCAST_SUCCEEDED", "PLAYER_CONTROL_GAINED", "PLAYER_DEAD",
    "HEARTHSTONE_BOUND", "PLAYER_XP_UPDATE",
}
-- An event this client doesn't know would raise an error and stop this file loading, so
-- register each one safely and remember which failed (shown by /sa debug).
T.badEvents = {}
for _, e in ipairs(EVENTS) do
    if not pcall(f.RegisterEvent, f, e) then T.badEvents[#T.badEvents + 1] = e end
end

f:SetScript("OnEvent", function(_, event, ...)
    if not SA.guide then return end
    if event == "QUEST_TURNED_IN" then
        local qid = ...
        if qid then T.turnedIn[qid] = true end
        T:Schedule("UPDATE")
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellID = ...
        if unit == "player" and spellID == HEARTHSTONE_SPELL then T:Schedule("HEARTH") end
    elseif event == "UI_INFO_MESSAGE" then
        local _, text = ...
        if text and ERR_NEWTAXIPATH and text == ERR_NEWTAXIPATH then T:Schedule("NEW_FLIGHT_PATH") end
    elseif event == "PLAYER_CONTROL_GAINED" then
        if T.wasOnTaxi then T.wasOnTaxi = false; T:Schedule("LANDED") end
    elseif event == "TAXIMAP_OPENED" or event == "PLAYER_DEAD" then
        T:Schedule(event)
    elseif event == "UNIT_QUEST_LOG_CHANGED" then
        if ... == "player" then T:Schedule("UPDATE") end
    else
        T:Schedule("UPDATE")
    end
end)

-- Taxi state and "goto" arrival by coordinates need a light poll (no event for either).
local elapsed = 0
f:SetScript("OnUpdate", function(_, dt)
    elapsed = elapsed + dt
    if elapsed < 1 then return end
    elapsed = 0
    if UnitOnTaxi and UnitOnTaxi("player") then T.wasOnTaxi = true end
    local step = SA.guide and SA:CurrentStep()
    if step and (step.action == "R" or step.action == "b") and step.x and nearStep(step) then
        T:Schedule("UPDATE")
    end
end)

---------------------------------------------------------------------------
-- /sa debug: what the tracker sees right now
---------------------------------------------------------------------------

function T:Debug()
    local say = SA.Print
    local version, build, _, iface = (GetBuildInfo or function() end)()
    say(string.format("client %s build %s interface %s, auto-tick %s",
        tostring(version), tostring(build), tostring(iface), SA.db.auto == false and "OFF" or "on"))
    say("quest log API: " .. (modernLog and "C_QuestLog.GetInfo" or
        (GetQuestLogTitle and "GetQuestLogTitle" or "|cffff6060none found|r"))
        .. ", completed quests: " .. (self.completedLoaded and "bulk list" or (isFlaggedCompleted and "per quest" or "|cffff6060none|r"))
        .. (issecretvalue and ", secret values: yes" or ""))
    if #self.badEvents > 0 then say("|cffff6060events not available:|r " .. table.concat(self.badEvents, ", ")) end
    if self.lastError then say("|cffff6060last error:|r " .. self.lastError) end

    local ok, err = pcall(self.ScanLog, self)
    if not ok then return say("|cffff6060quest log scan failed:|r " .. tostring(err)) end
    say("quest log: " .. #self.logList .. " quest(s)")
    for i, e in ipairs(self.logList) do
        if i > 8 then say("  ...") break end
        say(string.format("  #%s %s%s", tostring(e.id), e.title, e.complete and " |cff40ff40(complete)|r" or ""))
    end

    local step = SA:CurrentStep()
    if not step then return say("no current step") end
    say(string.format("current step: %s %s #%s", step.verb, step.title, tostring(step.qid)))
    if step.qid then
        local byId, byTitle = self.byId[step.qid], self.byTitle[norm(step.title)]
        say(string.format("  in log by ID: %s, by title: %s%s, completed flag: %s",
            byId and "yes" or "no", byTitle and "yes" or "no",
            (byTitle and byTitle.id and byTitle.id ~= step.qid) and (" (log ID #" .. byTitle.id .. ")") or "",
            tostring(isFlaggedCompleted and isFlaggedCompleted(step.qid) or false)))
    end
    say("  ticks now: " .. tostring(self:AnyStepDone(step) or self:CurrentStepDone(step, nil)))
end
