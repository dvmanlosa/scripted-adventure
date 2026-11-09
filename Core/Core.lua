-- ScriptedAdventure core: picks the route for this character, filters steps by class/race,
-- tracks which steps are done (saved per character) and moves through the guide chain.

local ADDON, SA = ...
ScriptedAdventure = SA -- global handle for macros and /dump

local DEFAULTS = { shown = 4, point = nil, hidden = false, auto = true, nav = true } -- account-wide (ScriptedAdventureDB)

local function msg(text) DEFAULT_CHAT_FRAME:AddMessage("|cff33ccffScripted Adventure:|r " .. text) end
SA.Print = msg

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
    return passes(step.classes, self.class) and passes(step.races, self.race)
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
    return step.qid ~= nil and self.char.skipped[step.qid] == true
end

-- Skip a quest: every remaining step of it, in this guide and later ones, drops out of the list.
function SA:SkipQuest(qid, title)
    if not qid then return end
    self.char.skipped[qid] = true
    msg("Skipping |cffffffff" .. tostring(title or ("quest " .. qid)) .. "|r. /sa unskip brings skipped quests back.")
    self:Changed()
end

function SA:UnskipAll()
    local n = 0
    for _ in pairs(self.char.skipped) do n = n + 1 end
    self.char.skipped = {}
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

-- true = done; false = unticked by hand (auto-tick leaves it alone); nil = not done yet
function SA:SetDone(step, value)
    self:DoneSet(self.guide)[step.key] = value and true or false
    self:Changed()
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
    "/sa skip | back - tick the current step / undo the last tick",
    "/sa guides - list the guides in your route",
    "/sa guide <number> | next | prev - switch guide",
    "/sa shown <1-8> - how many steps the window shows",
    "/sa reset - clear progress in the current guide",
    "/sa auto on | off - tick steps automatically (quests, flight paths, hearth, travel)",
    "/sa nav on | off - map pin / waypoint (and TomTom) on the current step",
    "/sa map - show the current step on the world map",
    "/sa unskip - bring back quests you skipped",
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
    elseif cmd == "shown" and tonumber(arg) then
        SA.db.shown = math.max(1, math.min(8, math.floor(tonumber(arg))))
        if SA.UI then SA.UI:Update() end
    else
        for _, line in ipairs(HELP) do msg(line) end
    end
end
