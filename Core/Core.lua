-- ScriptedAdventure core: picks the route for this character, filters steps by class/race,
-- tracks which steps are done (saved per character) and moves through the guide chain.

local ADDON, SA = ...
ScriptedAdventure = SA -- global handle for macros and /dump

local DEFAULTS = { shown = 4, point = nil, hidden = false, auto = true, nav = true, locked = false, scale = 1, anim = true } -- account-wide

local function msg(text) DEFAULT_CHAT_FRAME:AddMessage("|cff33ccffScripted Adventure:|r " .. text) end
SA.Print = msg

local HISTORY_MAX = 50                                  -- history entries kept per character
local function now() return time and time() or 0 end

---------------------------------------------------------------------------
-- Player and step filtering
---------------------------------------------------------------------------

function SA:LoadPlayer()
    local _, race = UnitRace("player")
    local _, class = UnitClass("player")
    self.race, self.class = race, class
    self.faction = UnitFactionGroup("player")
    self.level = UnitLevel("player")
end

-- step.classes / step.races are sets of tokens with an optional 'negate' flag
local function passes(filter, token)
    if not filter then return true end
    local hit = filter[token] == true
    if filter.negate then return not hit end
    return hit
end

function SA:StepApplies(step)
    if not (passes(step.classes, self.class) and passes(step.races, self.race)) then return false end
    local off = self.char and self.char.dungeonsOff or {}
    if step.dungeon and off[step.dungeon] then return false end -- dungeon turned off
    if step.alt and not off[step.alt] then return false end     -- alternative, only while it's off
    return true
end

-- Rebuild every guide's visible steps (after a dungeon is switched on or off).
function SA:Refilter()
    for _, guide in ipairs(self.chain) do guide.visible = nil end
    self:PrepareGuide(self.guide)
    self:Changed()
end

-- Build the step list this character sees for a guide, with stable keys for saving progress.
-- Keys survive edits that add or remove other steps: action + quest ID (or title) + occurrence.
function SA:PrepareGuide(guide)
    if guide.visible then return guide.visible end
    local seen, visible = {}, {}
    for _, step in ipairs(guide.steps) do
        local base = step.action .. ":" .. (step.qid or step.title)
        seen[base] = (seen[base] or 0) + 1
        step.key = base .. ":" .. seen[base]
        if self:StepApplies(step) then visible[#visible + 1] = step end
    end
    guide.visible = visible
    return visible
end

---------------------------------------------------------------------------
-- Progress
---------------------------------------------------------------------------

function SA:DoneSet(guide)
    local done = self.char.done
    done[guide.name] = done[guide.name] or {}
    return done[guide.name]
end

-- Done if ticked; a step of a skipped quest counts as done unless you unticked that step by hand.
function SA:IsDone(step)
    local v = self:DoneSet(self.guide)[step.key]
    if v ~= nil then return v == true end
    return step.qid ~= nil and self:QuestRemoved(step.qid)
end

---------------------------------------------------------------------------
-- Removed quests: skipped by hand, part of a dungeon that's turned off, or a follow-up whose
-- prerequisites were removed (Guides/<Route>/QuestInfo.lua). Their steps count as done.
---------------------------------------------------------------------------

-- quest ID -> dungeon name, from the dungeon-tagged steps of the route
function SA:QuestDungeon(qid)
    if not self.questDungeon then
        self.questDungeon = {}
        for _, guide in ipairs(self.chain) do
            for _, st in ipairs(guide.steps) do
                if st.qid and st.dungeon then self.questDungeon[st.qid] = st.dungeon end
            end
        end
    end
    return self.questDungeon[qid]
end

function SA:QuestRemoved(qid)
    local cache = self.removedCache
    if not cache then cache = {}; self.removedCache = cache end
    if cache[qid] ~= nil then return cache[qid] end
    cache[qid] = false -- guards against prerequisite loops
    if self.Tracker and self.Tracker:QuestDone(qid) then return false end -- you did it anyway
    local removed = self.char.skipped[qid] == true
    if not removed then
        local d = self:QuestDungeon(qid)
        removed = d ~= nil and self.char.dungeonsOff[d] == true
    end
    if not removed then
        local reqs = SA.requires and SA.requires[self.routeName] and SA.requires[self.routeName][qid]
        for _, group in ipairs(reqs or {}) do
            if group.kind == "all" then
                for _, pre in ipairs(group) do
                    if self:QuestRemoved(pre) then removed = true; break end
                end
            else
                local allGone = #group > 0
                for _, pre in ipairs(group) do
                    if not self:QuestRemoved(pre) then allGone = false; break end
                end
                removed = allGone
            end
            if removed then break end
        end
    end
    cache[qid] = removed
    return removed
end

-- Quest IDs in the whole route (to count follow-ups when skipping).
function SA:RouteQuests()
    if not self.routeQuests then
        local seen, list = {}, {}
        for _, guide in ipairs(self.chain) do
            for _, st in ipairs(guide.steps) do
                if st.qid and not seen[st.qid] then seen[st.qid] = true; list[#list + 1] = st.qid end
            end
        end
        self.routeQuests = list
    end
    return self.routeQuests
end

local function countRemoved()
    local n = 0
    for _, q in ipairs(SA:RouteQuests()) do
        if SA:QuestRemoved(q) then n = n + 1 end
    end
    return n
end

-- Skip a quest: its remaining steps, and those of its follow-ups, drop out of the list.
function SA:SkipQuest(qid, title)
    if not qid then return end
    self.removedCache = nil
    local before = countRemoved()
    self.char.skipped[qid] = true
    self.removedCache = nil
    local extra = countRemoved() - before - 1
    local h = self.char.history
    table.insert(h, 1, { skip = true, qid = qid, title = title or ("quest " .. qid), extra = extra, t = now() })
    while #h > HISTORY_MAX do table.remove(h) end
    if self.History then self.History:Update() end
    msg("Skipping |cffffffff" .. tostring(title or ("quest " .. qid)) .. "|r"
        .. (extra > 0 and (" and " .. extra .. " follow-up quest(s)") or "")
        .. ". /sa unskip brings skipped quests back.")
    self:Changed()
end

---------------------------------------------------------------------------
-- Dungeons
---------------------------------------------------------------------------

-- Dungeons that have steps in this route, in route order.
function SA:RouteDungeons()
    local seen, list = {}, {}
    for _, guide in ipairs(self.chain) do
        for _, st in ipairs(guide.steps) do
            local d = st.dungeon or st.alt
            if d and not seen[d] then seen[d] = true; list[#list + 1] = d end
        end
    end
    return list
end

function SA:SetDungeon(name, on)
    self.char.dungeonsOff[name] = (not on) or nil
    msg(name .. (on and " is on: its steps are back in the route."
        or " is off: its steps are hidden (and alternatives shown, where the route has them)."))
    self:Refilter()
end

function SA:UnskipAll()
    local n = 0
    for _ in pairs(self.char.skipped) do n = n + 1 end
    self.char.skipped = {}
    local h = self.char.history
    for i = #h, 1, -1 do if h[i].skip then table.remove(h, i) end end
    if self.History then self.History:Update() end
    msg(n == 0 and "No skipped quests." or ("Brought back " .. n .. " skipped quest(s)."))
    self:Changed()
end

-- Index (into guide.visible) of the first step not done, or nil when the guide is finished.
function SA:CurrentIndex()
    for i, step in ipairs(self.guide.visible) do
        if not self:IsDone(step) then return i end
    end
end

function SA:CurrentStep()
    local i = self:CurrentIndex()
    return i and self.guide.visible[i], i
end

-- The current step and the next not-done steps after it, up to 'count'.
function SA:UpcomingSteps(count)
    local list = {}
    for _, step in ipairs(self.guide.visible) do
        if not self:IsDone(step) then
            list[#list + 1] = step
            if #list >= count then break end
        end
    end
    return list
end

function SA:Progress()
    local done = 0
    for _, step in ipairs(self.guide.visible) do
        if self:IsDone(step) then done = done + 1 end
    end
    return done, #self.guide.visible
end

-- true = done; false = unticked by hand (auto-tick leaves it alone); nil = not done yet.
-- 'how' ("manual" or "auto") goes into the history.
function SA:SetDone(step, value, how)
    self:DoneSet(self.guide)[step.key] = value and true or false
    if value then self:RecordHistory(step, how or "manual") else self:ForgetHistory(self.guide.name, step.key) end
    self:Changed()
end

---------------------------------------------------------------------------
-- History: the last ticks (and quest skips), newest first, saved per character
---------------------------------------------------------------------------


function SA:RecordHistory(step, how)
    local h = self.char.history
    table.insert(h, 1, { guide = self.guide.name, key = step.key, verb = step.verb, title = step.title,
                         how = how, t = now() })
    while #h > HISTORY_MAX do table.remove(h) end
    if self.History then self.History:Update() end
end

function SA:ForgetHistory(guideName, key)
    local h = self.char.history
    for i = #h, 1, -1 do
        if h[i].guide == guideName and h[i].key == key then table.remove(h, i) end
    end
    if self.History then self.History:Update() end
end

-- Undo one history entry: untick that step (switching back to its guide), or un-skip the quest.
function SA:UndoHistory(entry)
    if entry.skip then
        self.char.skipped[entry.qid] = nil
        local h = self.char.history
        for i = #h, 1, -1 do if h[i] == entry then table.remove(h, i) end end
        msg("Brought back |cffffffff" .. tostring(entry.title) .. "|r.")
        if self.History then self.History:Update() end
        return self:Changed()
    end
    if self.guide.name ~= entry.guide and not self:SetGuide(entry.guide) then
        self:ForgetHistory(entry.guide, entry.key)
        return msg("That guide isn't in your route any more.")
    end
    for _, step in ipairs(self.guide.steps) do
        if step.key == entry.key then return self:SetDone(step, false) end
    end
    self:ForgetHistory(entry.guide, entry.key) -- the step is gone from the guide
end

function SA:ToggleStep(step) self:SetDone(step, not self:IsDone(step)) end

function SA:Skip()
    local step = self:CurrentStep()
    if step then self:SetDone(step, true) end
end

-- Un-tick the last ticked step before the current one.
function SA:Back()
    local cur = self:CurrentIndex() or (#self.guide.visible + 1)
    for i = cur - 1, 1, -1 do
        local step = self.guide.visible[i]
        if self:IsDone(step) then return self:SetDone(step, false) end
    end
    -- nothing to undo here: step back into the previous guide's last step
    local idx = self:GuideIndex()
    if idx > 1 then
        self:SetGuide(self.chain[idx - 1].name)
        local last = self.guide.visible[#self.guide.visible]
        if last then self:SetDone(last, false) end
    end
end

function SA:ResetGuide()
    self.char.done[self.guide.name] = nil
    self:Changed()
end

---------------------------------------------------------------------------
-- Guide chain
---------------------------------------------------------------------------

function SA:GuideIndex()
    for i, guide in ipairs(self.chain) do
        if guide == self.guide then return i end
    end
    return 1
end

function SA:SetGuide(name)
    for _, guide in ipairs(self.chain) do
        if guide.name == name then
            self.guide = guide
            self.char.guide = name
            self:PrepareGuide(guide)
            self:Changed(true)
            if self.Tracker then self.Tracker:Schedule("UPDATE") end -- tick what's already done
            return true
        end
    end
end

function SA:ShiftGuide(delta)
    local target = self.chain[self:GuideIndex() + delta]
    if target then self:SetGuide(target.name) end
end

-- First guide whose level range still fits the character (so a level 30 alt doesn't start in Durotar).
function SA:GuideForLevel(level)
    for _, guide in ipairs(self.chain) do
        if not guide.maxLevel or guide.maxLevel >= level then return guide end
    end
    return self.chain[#self.chain]
end

-- Called after any progress change. Moves to the next guide once this one is finished.
function SA:Changed(guideSwitched)
    self.removedCache = nil -- skips, dungeon switches and turn-ins all change what's removed
    if not guideSwitched and not self:CurrentIndex() then
        local nextGuide = self.chain[self:GuideIndex() + 1]
        if nextGuide then
            msg("Finished |cffffffff" .. self.guide.name .. "|r. Next: |cffffffff" .. nextGuide.name .. "|r")
            return self:SetGuide(nextGuide.name)
        elseif not self.routeDoneShown then
            self.routeDoneShown = true
            msg("You've reached the end of the " .. self.routeName .. " route.")
        end
    end
    if self.UI then self.UI:Update() end
    if self.Nav then self.Nav:Update() end
    if self.Settings then self.Settings:Refresh() end
end

---------------------------------------------------------------------------
-- Startup
---------------------------------------------------------------------------

function SA:Init()
    ScriptedAdventureDB = ScriptedAdventureDB or {}
    for k, v in pairs(DEFAULTS) do
        if ScriptedAdventureDB[k] == nil then ScriptedAdventureDB[k] = v end
    end
    ScriptedAdventureCharDB = ScriptedAdventureCharDB or {}
    self.db, self.char = ScriptedAdventureDB, ScriptedAdventureCharDB
    self.char.done = self.char.done or {}
    self.char.skipped = self.char.skipped or {}
    self.char.dungeonsOff = self.char.dungeonsOff or {}
    self.char.history = self.char.history or {}

    self:LoadPlayer()
    self.routeName = self.faction -- routes are per faction; starting-zone guides pick the race
    self.chain = self:RouteGuides(self.routeName, self.race)
    if #SA.parseErrors > 0 then
        msg("|cffff6060" .. #SA.parseErrors .. " guide error(s).|r Type /sa errors to list them.")
    end
    if #self.chain == 0 then
        msg("No guide route for " .. tostring(self.faction) .. " yet.")
        return
    end

    local saved = self.char.guide
    if not (saved and self:SetGuide(saved)) then
        local guide = self:GuideForLevel(self.level)
        self:SetGuide(guide.name)
        msg("Starting with |cffffffff" .. guide.name .. "|r. Type /sa for commands.")
    end
    if self.UI then self.UI:Init() end
    if self.History then self.History:Update() end
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_LEVEL_UP")
events:SetScript("OnEvent", function(_, event, arg1)
    if event == "PLAYER_LOGIN" then
        SA:Init()
    elseif event == "PLAYER_LEVEL_UP" then
        SA.level = arg1
        if SA.UI then SA.UI:Update() end
    end
end)

---------------------------------------------------------------------------
-- Slash commands
---------------------------------------------------------------------------

local HELP = {
    "/sa - show or hide the guide window",
    "/sa options - settings (everything below is also there)",
    "/sa history - recent ticks; click one to go back to it",
    "/sa skip | back - tick the current step / undo the last tick",
    "/sa guides - list the guides in your route",
    "/sa guide <number> | next | prev - switch guide",
    "/sa shown <1-8> - how many steps the window shows",
    "/sa reset - clear progress in the current guide",
    "/sa auto on | off - tick steps automatically (quests, flight paths, hearth, travel)",
    "/sa nav on | off - map pin / waypoint (and TomTom) on the current step",
    "/sa map - show the current step on the world map",
    "/sa unskip - bring back quests you skipped",
    "/sa dungeons - list the route's dungeons; /sa dungeon <name> | all on | off",
    "Right-click a step for more (skip quest, show on map, waypoint).",
    "/sa errors - list guide file errors",
    "/sa debug - show what auto-tick sees (quest log, current step)",
}

SLASH_SCRIPTEDADVENTURE1, SLASH_SCRIPTEDADVENTURE2 = "/sa", "/scriptedadventure"
SlashCmdList.SCRIPTEDADVENTURE = function(input)
    local cmd, arg = (input or ""):lower():match("^%s*(%S*)%s*(.-)%s*$")
    if cmd == "errors" then
        if #SA.parseErrors == 0 then return msg("No guide errors.") end
        for _, e in ipairs(SA.parseErrors) do
            msg(string.format("%s line %d: %s", tostring(e.source), e.line or 0, e.message))
        end
        return
    elseif cmd == "help" or cmd == "?" then
        for _, line in ipairs(HELP) do msg(line) end
        return
    end
    if not SA.guide then return msg("No guide loaded.") end
    if cmd == "" then
        if SA.UI then SA.UI:Toggle() end
    elseif cmd == "skip" or cmd == "next" then
        SA:Skip()
    elseif cmd == "back" then
        SA:Back()
    elseif cmd == "reset" then
        SA:ResetGuide()
        msg("Progress cleared for " .. SA.guide.name .. ".")
    elseif cmd == "guides" then
        local cur = SA:GuideIndex()
        for i, guide in ipairs(SA.chain) do
            msg(string.format("%s%d. %s|r", i == cur and "|cff00ff00" or "|cffffffff", i, guide.name))
        end
    elseif cmd == "guide" then
        if arg == "next" then SA:ShiftGuide(1)
        elseif arg == "prev" then SA:ShiftGuide(-1)
        elseif tonumber(arg) and SA.chain[tonumber(arg)] then SA:SetGuide(SA.chain[tonumber(arg)].name)
        else msg("Usage: /sa guide <number> | next | prev  (see /sa guides)") end
    elseif cmd == "options" or cmd == "settings" or cmd == "config" then
        if SA.Settings then SA.Settings:Toggle() end
    elseif cmd == "history" then
        if SA.History then SA.History:Toggle() end
    elseif cmd == "debug" then
        if SA.Tracker then SA.Tracker:Debug() else msg("Tracker didn't load.") end
    elseif cmd == "auto" and (arg == "on" or arg == "off") then
        SA.db.auto = arg == "on"
        msg("Auto-tick " .. (SA.db.auto and "on." or "off."))
        if SA.db.auto and SA.Tracker then SA.Tracker:Schedule("UPDATE") end
    elseif cmd == "nav" and (arg == "on" or arg == "off") then
        SA.db.nav = arg == "on"
        msg("Waypoints " .. (SA.db.nav and "on." or "off."))
        if SA.Nav then if SA.db.nav then SA.Nav:Reset() else SA.Nav:Clear() end end
    elseif cmd == "map" then
        local step = SA:CurrentStep()
        if SA.Nav and step then SA.Nav:ShowOnMap(step) end
    elseif cmd == "unskip" then
        SA:UnskipAll()
    elseif cmd == "dungeons" then
        local list = SA:RouteDungeons()
        if #list == 0 then return msg("This route has no dungeon steps.") end
        for _, d in ipairs(list) do
            msg(d .. ": " .. (SA.char.dungeonsOff[d] and "|cffff6060off|r" or "|cff40ff40on|r"))
        end
    elseif cmd == "dungeon" then
        local which, state = arg:match("^(.-)%s+(%a+)$")
        if not (which and (state == "on" or state == "off")) then
            return msg("Usage: /sa dungeon <name> | all on | off  (see /sa dungeons)")
        end
        local hits = {}
        for _, d in ipairs(SA:RouteDungeons()) do
            if which == "all" or d:lower():find(which, 1, true) then hits[#hits + 1] = d end
        end
        if #hits == 0 then return msg("No dungeon matching '" .. which .. "' in this route (see /sa dungeons).") end
        for _, d in ipairs(hits) do SA.char.dungeonsOff[d] = (state == "off") or nil end
        if #hits == 1 then SA:SetDungeon(hits[1], state == "on") else
            msg(#hits .. " dungeons turned " .. state .. ".")
            SA:Refilter()
        end
    elseif cmd == "shown" and tonumber(arg) then
        SA.db.shown = math.max(1, math.min(8, math.floor(tonumber(arg))))
        if SA.UI then SA.UI:Update() end
    else
        for _, line in ipairs(HELP) do msg(line) end
    end
end
