-- ScriptedAdventure settings: everything the slash commands do, as a page. Opens from the gear
-- on the guide window, and also appears in the game's AddOns settings when the client has them.

local _, SA = ...
local W = SA.W
local S = {}
SA.Settings = S

local WIDTH = 340
local MAX_DUNGEONS = 8

local function refreshUI()
    if SA.UI then SA.UI:Update() end
end

-- Build the controls into 'parent'. Returns a page object with :Refresh().
local function BuildPage(parent)
    local page = { controls = {} }
    local y = -12
    local function place(widget, x, gap)
        widget:SetPoint("TOPLEFT", parent, "TOPLEFT", x or 14, y)
        y = y - (gap or 24)
        return widget
    end
    local function header(text)
        y = y - 6
        place(W.Header(parent, text), 12, 20)
    end
    local function add(widget, x, gap)
        page.controls[#page.controls + 1] = widget
        return place(widget, x, gap)
    end

    -- Window
    header("Window")
    add(W.Check(parent, "Show the guide window",
        function() return not SA.db.hidden end,
        function(v) SA.db.hidden = not v; if SA.UI and SA.UI.frame then SA.UI.frame:SetShown(v) end end))
    add(W.Check(parent, "Lock window position",
        function() return SA.db.locked end,
        function(v) SA.db.locked = v end, "Stops the window being dragged by accident."))
    add(W.Check(parent, "Animations",
        function() return SA.db.anim ~= false end,
        function(v) SA.db.anim = v end, "Ticked steps slide out, the rest glide up, and the next step pulses."))
    add(W.Stepper(parent, "Steps shown",
        function() return SA.db.shown end,
        function(v) SA.db.shown = v; refreshUI() end, 1, 8))
    add(W.Stepper(parent, "Window size",
        function() return math.floor((SA.db.scale or 1) * 100 + 0.5) end,
        function(v) SA.db.scale = v / 100; if SA.UI and SA.UI.frame then SA.UI.frame:SetScale(SA.db.scale) end end,
        70, 150, 10, function(v) return v .. "%" end))

    -- Tracking
    header("Tracking")
    add(W.Check(parent, "Tick steps automatically",
        function() return SA.db.auto ~= false end,
        function(v) SA.db.auto = v; if v and SA.Tracker then SA.Tracker:Schedule("UPDATE") end end,
        "Quests accepted, completed and turned in, flight paths, hearthstone, travel, levels."))
    add(W.Check(parent, "Waypoint on the current step",
        function() return SA.db.nav ~= false end,
        function(v)
            SA.db.nav = v
            if SA.Nav then if v then SA.Nav:Reset() else SA.Nav:Clear() end end
        end, "Puts the game's map pin and on-screen waypoint (and TomTom, if installed) on the step's location."))

    -- Guide
    header("Guide")
    local guideRow = CreateFrame("Frame", nil, parent)
    guideRow:SetSize(WIDTH - 28, 20)
    guideRow.prev = W.Button(guideRow, "<", 22, function() SA:ShiftGuide(-1); page:Refresh() end, "Previous guide")
    guideRow.prev:SetPoint("LEFT", 0, 0)
    guideRow.name = W.Text(guideRow, "GameFontHighlight")
    guideRow.name:SetPoint("LEFT", guideRow.prev, "RIGHT", 6, 0)
    guideRow.name:SetWidth(WIDTH - 90)
    guideRow.name:SetWordWrap(false)
    guideRow.next = W.Button(guideRow, ">", 22, function() SA:ShiftGuide(1); page:Refresh() end, "Next guide")
    guideRow.next:SetPoint("LEFT", guideRow.name, "RIGHT", 6, 0)
    guideRow.Refresh = function(self)
        local i = SA:GuideIndex()
        self.name:SetText(SA.guide and (i .. "/" .. #SA.chain .. "  " .. SA.guide.name) or "-")
    end
    page.guideRow = add(guideRow, 14, 26)

    local jump = W.Button(parent, "Jump to my level", 130, function()
        local g = SA:GuideForLevel(UnitLevel("player") or SA.level or 1)
        if g then SA:SetGuide(g.name) end
        page:Refresh()
    end, "The first guide whose level range still fits your character.")
    place(jump, 14, 0)
    local armedAt -- two clicks within 4 s, so a stray click doesn't wipe a guide's progress
    local reset = W.Button(parent, "Reset this guide", 130, function(self)
        local t = GetTime and GetTime() or 0
        if armedAt and t - armedAt < 4 then
            armedAt = nil
            SA:ResetGuide()
            self:SetText("Reset this guide")
        else
            armedAt = t
            self:SetText("Click again to reset")
        end
    end, "Clears every tick in the current guide.")
    reset:SetPoint("LEFT", jump, "RIGHT", 8, 0)
    y = y - 28

    -- Dungeons
    header("Dungeons")
    page.noDungeons = W.Text(parent)
    page.noDungeons:SetText("This route has no dungeon steps.")
    page.noDungeons:SetPoint("TOPLEFT", parent, "TOPLEFT", 14, y)
    page.dungeons = {}
    for i = 1, MAX_DUNGEONS do
        local c = W.Check(parent, "",
            function() return page.dungeonNames[i] and not SA.char.dungeonsOff[page.dungeonNames[i]] end,
            function(v) if page.dungeonNames[i] then SA:SetDungeon(page.dungeonNames[i], v) end end,
            "Off hides this dungeon's steps and its follow-up quests, and shows solo alternatives where the route has them.")
        c:SetPoint("TOPLEFT", parent, "TOPLEFT", 14, y - (i - 1) * 24)
        c:Hide()
        page.dungeons[i] = c
    end
    page.dungeonTop = y

    -- Skipped quests (placed under the dungeon list in Refresh)
    page.skipHeader = W.Header(parent, "Skipped quests")
    page.skipText = W.Text(parent, "GameFontHighlight")
    page.unskip = W.Button(parent, "Bring them all back", 140, function() SA:UnskipAll(); page:Refresh() end)
    page.history = W.Button(parent, "Open history", 140, function() if SA.History then SA.History:Toggle() end end,
        "Recent ticks; click one to go back to it.")

    function page:Refresh()
        if not SA.db or not SA.char then return end
        for _, c in ipairs(self.controls) do if c.Refresh then c:Refresh() end end
        -- dungeon checkboxes follow the route
        self.dungeonNames = SA.RouteDungeons and SA:RouteDungeons() or {}
        local n = math.min(#self.dungeonNames, MAX_DUNGEONS)
        for i, c in ipairs(self.dungeons) do
            if i <= n then c.label:SetText(self.dungeonNames[i]); c:Refresh(); c:Show() else c:Hide() end
        end
        self.noDungeons:SetShown(n == 0)
        local yy = self.dungeonTop - math.max(n, 1) * 24 - 6
        self.skipHeader:ClearAllPoints()
        self.skipHeader:SetPoint("TOPLEFT", parent, "TOPLEFT", 12, yy)
        local skipped = 0
        for _ in pairs(SA.char.skipped or {}) do skipped = skipped + 1 end
        self.skipText:ClearAllPoints()
        self.skipText:SetPoint("TOPLEFT", parent, "TOPLEFT", 14, yy - 20)
        self.skipText:SetText(skipped == 0 and "None. Right-click a step to skip its quest."
            or (skipped .. " quest(s) skipped, with their follow-ups."))
        self.unskip:ClearAllPoints()
        self.unskip:SetPoint("TOPLEFT", parent, "TOPLEFT", 14, yy - 42)
        self.unskip:SetShown(skipped > 0)
        self.history:ClearAllPoints()
        self.history:SetPoint("TOPLEFT", parent, "TOPLEFT", skipped > 0 and 162 or 14, yy - 42)
        self.height = -(yy - 72)
    end

    page:Refresh()
    return page
end

---------------------------------------------------------------------------
-- Standalone window (gear button, /sa options)
---------------------------------------------------------------------------

function S:Build()
    local f = W.Panel("ScriptedAdventureSettings", UIParent, "DIALOG")
    self.frame = f
    f:SetSize(WIDTH, 500)
    f:SetPoint("CENTER")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:Hide()
    if UISpecialFrames then table.insert(UISpecialFrames, "ScriptedAdventureSettings") end -- Escape closes it

    f.title = W.Header(f, "Scripted Adventure")
    f.title:SetPoint("TOPLEFT", 12, -10)
    f.close = W.Icon(f, "Interface\\Buttons\\UI-StopButton", "Close", function() f:Hide() end)
    f.close:SetPoint("TOPRIGHT", -8, -8)

    f.body = CreateFrame("Frame", nil, f)
    f.body:SetPoint("TOPLEFT", 0, -22)
    f.body:SetPoint("BOTTOMRIGHT")
    self.page = BuildPage(f.body)
    f:SetScript("OnShow", function() S:Refresh() end)
end

function S:Refresh()
    if self.page and self.frame and self.frame:IsShown() then
        self.page:Refresh()
        self.frame:SetHeight(self.page.height + 30)
    end
    if self.canvasPage and self.canvas and self.canvas:IsShown() then self.canvasPage:Refresh() end
end

function S:Toggle()
    if not self.frame then self:Build() end
    self.frame:SetShown(not self.frame:IsShown())
end

---------------------------------------------------------------------------
-- The game's own AddOns settings list (when this client has it)
---------------------------------------------------------------------------

local canvas = CreateFrame("Frame")
canvas.name = "Scripted Adventure"
canvas:Hide()
S.canvas = canvas
canvas:SetScript("OnShow", function(self)
    if not SA.db then return end
    if not S.canvasPage then S.canvasPage = BuildPage(self) end
    S.canvasPage:Refresh()
end)
pcall(function()
    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        Settings.RegisterAddOnCategory(Settings.RegisterCanvasLayoutCategory(canvas, "Scripted Adventure"))
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(canvas)
    end
end)
