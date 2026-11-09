-- ScriptedAdventure step window: the current step plus the next few, click a row to tick it.

local _, SA = ...
local UI = {}
SA.UI = UI

local WIDTH, PAD, ICON, HEADER = 320, 8, 16, 26
local TEXT_W = WIDTH - PAD * 2 - ICON - 22 -- row text width (check box + icon + gaps)

-- verb -> label shown before the title, its color, and icon
local VERB_STYLE = {
    accept     = { "Accept",          "ffd100", "Interface\\GossipFrame\\AvailableQuestIcon" },
    turnin     = { "Turn in",         "40ff40", "Interface\\GossipFrame\\ActiveQuestIcon" },
    complete   = { "Complete",        "ff9933", "Interface\\Icons\\INV_Sword_04" },
    kill       = { "Kill",            "ff5533", "Interface\\Icons\\Ability_DualWield" },
    grind      = { "Grind",           "ff5533", "Interface\\Icons\\Ability_DualWield" },
    ["goto"]   = { "Go to",           "66ccff", "Interface\\Icons\\INV_Misc_Map_01" },
    fly        = { "Fly to",          "66ccff", "Interface\\Minimap\\Tracking\\FlightMaster" },
    flightpath = { "Get flight path", "66ccff", "Interface\\Minimap\\Tracking\\FlightMaster" },
    boat       = { "Take the boat to","66ccff", "Interface\\Icons\\INV_Misc_Map_01" },
    hearth     = { "Hearth to",       "cc99ff", "Interface\\Icons\\INV_Misc_Rune_01" },
    sethearth  = { "Set hearth at",   "cc99ff", "Interface\\Icons\\INV_Misc_Rune_01" },
    buy        = { "Buy",             "ffffff", "Interface\\Icons\\INV_Misc_Coin_01" },
    use        = { "Use",             "ffffff", "Interface\\Icons\\INV_Misc_Bag_08" },
    petskill   = { "Pet skill",       "ffffff", "Interface\\Icons\\Ability_Hunter_BeastTraining" },
    die        = { "Die",             "aaaaaa", "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01" },
    note       = { nil,               "ffffff", "Interface\\Icons\\INV_Misc_Note_01" },
}

SA.VERB_LABEL = {}
for verb, style in pairs(VERB_STYLE) do SA.VERB_LABEL[verb] = style[1] end

local getItemInfo = (C_Item and C_Item.GetItemInfo) or GetItemInfo
local getItemIcon = (C_Item and C_Item.GetItemIconByID) or GetItemIcon

local function itemName(id)
    local name = getItemInfo and getItemInfo(id)
    if not name then UI.waitingForItems = true end
    return name or ("item " .. id)
end

local function fmt(n) return (string.format("%.1f", n):gsub("%.0$", "")) end

local function stepTitle(step)
    local style = VERB_STYLE[step.verb] or VERB_STYLE.note
    local text = step.title
    if style[1] then text = "|cff" .. style[2] .. style[1] .. "|r " .. text end
    if step.xp then text = text .. ", " .. step.xp .. "% in" end
    if step.optional then text = text .. " |cff888888(optional)|r" end
    if step.dungeon then text = text .. " |cff9999ff(" .. step.dungeon .. ")|r" end
    return text
end

-- live objective lines for complete/kill steps whose quest is in the log
local function objectiveLines(step)
    if not (step.qid and (step.action == "C" or step.action == "K") and SA.Tracker) then return nil end
    local objs = SA.Tracker:Objectives(step.qid)
    if not objs then return nil end
    local lines = {}
    for _, o in ipairs(objs) do
        lines[#lines + 1] = (o.done and "|cff40ff40" or "|cffffffff") .. "- " .. o.text .. "|r"
    end
    return table.concat(lines, "\n")
end

local function stepDetail(step, guide)
    local parts = {}
    if step.note then parts[#parts + 1] = step.note end
    if step.useItem then parts[#parts + 1] = "|cffffffffUse:|r " .. itemName(step.useItem) end
    if step.lootItem then
        parts[#parts + 1] = "|cffffffffCollect:|r " .. itemName(step.lootItem)
            .. (step.lootCount and (" x" .. step.lootCount) or "")
    end
    if step.action == "G" and step.level and UnitLevel then
        local lvl = UnitLevel("player") or 0
        local cur, max = UnitXP and UnitXP("player"), UnitXPMax and UnitXPMax("player")
        local pct = (type(cur) == "number" and type(max) == "number" and max > 0) and math.floor(cur / max * 100) or nil
        parts[#parts + 1] = "|cff8899aa(you: level " .. lvl .. (pct and (", " .. pct .. "%") or "") .. ")|r"
    end
    if step.x then
        local where = fmt(step.x) .. ", " .. fmt(step.y)
        if step.zone and step.zone ~= guide.zone then where = where .. " " .. step.zone end
        parts[#parts + 1] = "|cff8899aa(" .. where .. ")|r"
    end
    local text = table.concat(parts, "  ")
    local objs = objectiveLines(step)
    if objs then text = text ~= "" and (text .. "\n" .. objs) or objs end
    return text
end

local function stepIcon(step)
    if step.useItem and getItemIcon then
        local icon = getItemIcon(step.useItem)
        if icon then return icon end
    end
    return (VERB_STYLE[step.verb] or VERB_STYLE.note)[3]
end

---------------------------------------------------------------------------
-- Frame
---------------------------------------------------------------------------

local function savePosition(frame)
    local point, _, relPoint, x, y = frame:GetPoint(1)
    SA.db.point = { point, relPoint, x, y }
end

local function smallButton(parent, label, tip, onClick)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(18, 18)
    b:SetNormalFontObject("GameFontNormal")
    b:SetHighlightFontObject("GameFontHighlight")
    b:SetText(label)
    b:SetScript("OnClick", onClick)
    b:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(tip)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
    return b
end

function UI:Build()
    local f = CreateFrame("Frame", "ScriptedAdventureFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
    self.frame = f
    f:SetSize(WIDTH, 100)
    f:SetFrameStrata("MEDIUM")
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self) if not SA.db.locked then self:StartMoving() end end)
    f:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing(); savePosition(self)
        if SA.ItemButton then SA.ItemButton:Update() end -- it sits beside the window
    end)
    if f.SetBackdrop then
        f:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 },
        })
        f:SetBackdropColor(0.05, 0.05, 0.07, 0.82)
        f:SetBackdropBorderColor(0.4, 0.4, 0.45, 1)
    end

    local p = SA.db.point
    if p then f:SetPoint(p[1], UIParent, p[2], p[3], p[4]) else f:SetPoint("RIGHT", UIParent, "RIGHT", -60, 80) end

    -- header: guide name, progress, back / skip / close
    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.title:SetPoint("TOPLEFT", PAD, -PAD)
    f.title:SetJustifyH("LEFT")
    f.title:SetWidth(WIDTH - PAD * 2 - 150)
    f.title:SetWordWrap(false)

    f.close = smallButton(f, "x", "Hide (/sa to show)", function() UI:Toggle() end)
    f.close:SetPoint("TOPRIGHT", -PAD + 2, -PAD + 3)
    f.skip = smallButton(f, ">", "Tick the current step", function() SA:Skip() end)
    f.skip:SetPoint("RIGHT", f.close, "LEFT", -2, 0)
    f.back = smallButton(f, "<", "Undo the last tick", function() SA:Back() end)
    f.back:SetPoint("RIGHT", f.skip, "LEFT", -2, 0)
    f.hist = SA.W.Icon(f, "Interface\\Icons\\INV_Misc_PocketWatch_01", "History: recent ticks. Click one to go back to it.",
        function() if SA.History then SA.History:Toggle() end end)
    f.hist:SetPoint("RIGHT", f.back, "LEFT", -4, 0)
    f.gear = SA.W.Icon(f, "Interface\\Icons\\INV_Misc_Gear_01", "Settings",
        function() if SA.Settings then SA.Settings:Toggle() end end)
    f.gear:SetPoint("RIGHT", f.hist, "LEFT", -4, 0)
    f.progress = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.progress:SetPoint("RIGHT", f.gear, "LEFT", -6, 0)

    f.divider = f:CreateTexture(nil, "ARTWORK")
    f.divider:SetColorTexture(1, 1, 1, 0.12)
    f.divider:SetHeight(1)
    f.divider:SetPoint("TOPLEFT", PAD, -HEADER)
    f.divider:SetPoint("TOPRIGHT", -PAD, -HEADER)

    f.warn = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.warn:SetPoint("TOPLEFT", PAD, -HEADER - 5)
    f.warn:SetWidth(WIDTH - PAD * 2)
    f.warn:SetJustifyH("LEFT")

    f.empty = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.empty:SetPoint("TOPLEFT", PAD, -HEADER - 8)  -- re-anchored in Update
    f.empty:SetWidth(WIDTH - PAD * 2)
    f.empty:SetJustifyH("LEFT")

    self.rows = {}   -- visible rows in order (1 = current step)
    self.byKey = {}  -- step key -> its row, so a row stays with its step while things move
    self.live = {}   -- every row on screen, including ones animating out
    self.pool = {}   -- spare rows
    f:SetScript("OnUpdate", function(_, dt) UI:Animate(dt) end)
end

---------------------------------------------------------------------------
-- Rows and animation
--   tick:     check fills, green flash, row slides left and fades
--   removed:  (skipped quest, dungeon off) row fades out
--   others glide into place, new rows fade in from below, the window height eases
--   new current step: gold pulse x3
-- Driven by OnUpdate with plain position/alpha changes (no AnimationGroup dependency).
---------------------------------------------------------------------------

local CHECK_EMPTY, CHECK_DONE = "Interface\\Buttons\\UI-CheckBox-Up", "Interface\\Buttons\\UI-CheckBox-Check"
local EXIT_HOLD, EXIT_TIME, EXIT_SHIFT = 0.25, 0.3, 28 -- show the tick, then slide/fade out
local ENTER_DROP = 14                                    -- new rows rise this far into place
local FLASH_TIME = 1.5                                   -- three pulses

local function animOn() return SA.db and SA.db.anim ~= false end

local function place(row)
    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", PAD + row.st.x, -row.st.y)
    row:SetAlpha(row.st.a)
end

function UI:Acquire()
    local row = table.remove(self.pool)
    if row then return row end
    local f = self.frame
    row = CreateFrame("Button", nil, f)
    row.st = { x = 0, y = 0, a = 1, ty = 0, ta = 1 } -- animation state, kept off the frame itself
    row:SetWidth(WIDTH - PAD * 2)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    row:RegisterForDrag("LeftButton")
    row:SetScript("OnDragStart", function() if not SA.db.locked then f:StartMoving() end end)
    row:SetScript("OnDragStop", function()
        f:StopMovingOrSizing(); savePosition(f)
        if SA.ItemButton then SA.ItemButton:Update() end
    end)
    row:SetScript("OnEnter", function(self) UI:StepTooltip(self) end)
    row:SetScript("OnLeave", function() GameTooltip:Hide() end)
    row:SetScript("OnClick", function(self, button)
        if not self.step or self.st.leaving then return end
        if button == "RightButton" then UI:OpenMenu(self) else SA:ToggleStep(self.step) end
    end)

    row.bg = row:CreateTexture(nil, "BACKGROUND")
    row.bg:SetAllPoints()
    row.bg:SetColorTexture(1, 0.82, 0, 0.10)
    row.flash = row:CreateTexture(nil, "BORDER") -- gold pulse on a new current step
    row.flash:SetAllPoints()
    row.flash:SetColorTexture(1, 0.82, 0, 1)
    row.flash:SetBlendMode("ADD")
    row.flash:SetAlpha(0)
    row.glow = row:CreateTexture(nil, "BORDER")  -- green flash when ticked
    row.glow:SetAllPoints()
    row.glow:SetColorTexture(0.25, 1, 0.25, 1)
    row.glow:SetBlendMode("ADD")
    row.glow:SetAlpha(0)
    row.bar = row:CreateTexture(nil, "ARTWORK")
    row.bar:SetColorTexture(1, 0.82, 0, 0.9)
    row.bar:SetWidth(2)
    row.bar:SetPoint("TOPLEFT")
    row.bar:SetPoint("BOTTOMLEFT")
    row.hl = row:CreateTexture(nil, "HIGHLIGHT")
    row.hl:SetAllPoints()
    row.hl:SetColorTexture(1, 1, 1, 0.06)

    row.check = row:CreateTexture(nil, "ARTWORK")
    row.check:SetSize(16, 16)
    row.check:SetPoint("TOPLEFT", 4, -3)
    row.check:SetTexture(CHECK_EMPTY)

    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(ICON, ICON)
    row.icon:SetPoint("LEFT", row.check, "RIGHT", 2, 0)

    row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    row.text:SetPoint("TOPLEFT", row.icon, "TOPRIGHT", 4, -1)
    row.text:SetWidth(TEXT_W)
    row.text:SetJustifyH("LEFT")

    row.detail = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    row.detail:SetPoint("TOPLEFT", row.text, "BOTTOMLEFT", 0, -2)
    row.detail:SetWidth(TEXT_W)
    row.detail:SetJustifyH("LEFT")
    row.detail:SetTextColor(0.75, 0.75, 0.75)
    return row
end

function UI:Recycle(row)
    row:Hide()
    row.step, row.st.leaving, row.st.flashT = nil, nil, nil
    row.flash:SetAlpha(0)
    row.glow:SetAlpha(0)
    row.check:SetTexture(CHECK_EMPTY)
    self.live[row] = nil
    self.pool[#self.pool + 1] = row
end

-- Start a row's exit: 'done' = it was ticked (show the tick and a green flash first).
-- Every other row waits until the exit has finished, so nothing slides over it.
function UI:Leave(row, done)
    row.st.leaving = { t = 0, done = done, a0 = row.st.a }
    local finish = (self.clock or 0) + (done and EXIT_HOLD or 0) + EXIT_TIME
    self.holdUntil = math.max(self.holdUntil or 0, finish)
    row:SetFrameLevel(self.frame:GetFrameLevel() + 1) -- under the rows moving into its place
    if done then row.check:SetTexture(CHECK_DONE); row.glow:SetAlpha(0.5) end
    self.animating = true
end

-- true while a row is still animating out (the rest wait for it)
function UI:Holding()
    return self.holdUntil ~= nil and (self.clock or 0) < self.holdUntil
end

function UI:Animate(dt)
    if not self.animating then return end
    self.clock = (self.clock or 0) + (dt or 0)
    local holding = self:Holding()
    local busy = false
    local k = math.min(1, (dt or 0) * 14) -- ease toward the target each frame
    for row in pairs(self.live) do
        local L = row.st.leaving
        if L then
            L.t = L.t + dt
            local hold = L.done and EXIT_HOLD or 0
            local p = math.min(1, math.max(0, (L.t - hold) / EXIT_TIME))
            if L.done then row.glow:SetAlpha(math.max(0, 0.5 * (1 - L.t / (hold + EXIT_TIME * 0.6)))) end
            row.st.x = -EXIT_SHIFT * p * p
            row.st.a = L.a0 * (1 - p)
            if p >= 1 then self:Recycle(row) else busy = true; place(row) end
        elseif holding then
            busy = true -- wait in place until the leaving row is gone
        else
            if row.st.wantCur ~= nil then -- current-step highlight moves once the wait is over
                row.bg:SetShown(row.st.wantCur)
                row.bar:SetShown(row.st.wantCur)
                row.st.wantCur = nil
            end
            local dy, da, dx = row.st.ty - row.st.y, row.st.ta - row.st.a, -row.st.x
            if math.abs(dy) > 0.5 or math.abs(da) > 0.02 or math.abs(dx) > 0.5 then
                row.st.y, row.st.a, row.st.x = row.st.y + dy * k, row.st.a + da * k, row.st.x + dx * k
                busy = true
            else
                row.st.y, row.st.a, row.st.x = row.st.ty, row.st.ta, 0
            end
            if row.st.flashT then
                row.st.flashT = row.st.flashT + dt
                if row.st.flashT >= FLASH_TIME then
                    row.st.flashT = nil
                    row.flash:SetAlpha(0)
                else
                    row.flash:SetAlpha(0.35 * math.abs(math.sin(row.st.flashT * math.pi * 2)))
                    busy = true
                end
            end
            place(row)
        end
    end
    local dh = (self.th or 0) - (self.h or 0)
    if holding then
        busy = true
    elseif math.abs(dh) > 0.5 then
        self.h = self.h + dh * k
        busy = true
    else
        self.h = self.th
    end
    self.frame:SetHeight(self.h)
    self.animating = busy
end

function UI:FillRow(row, step, current, guide)
    row.step = step
    row.text:SetText(stepTitle(step))
    local detail = stepDetail(step, guide)
    row.detail:SetText(detail)
    row.detail:SetShown(detail ~= "")
    row.icon:SetTexture(stepIcon(step))
    row:SetFrameLevel(self.frame:GetFrameLevel() + 2)
    local h = row.text:GetStringHeight() + (detail ~= "" and (row.detail:GetStringHeight() + 2) or 0) + 7
    h = math.max(h, ICON + 6)
    row:SetHeight(h)
    return h
end

function UI:Update()
    local f = self.frame
    if not f or not SA.guide then return end
    local guide = SA.guide
    self.waitingForItems = false

    local levels = guide.minLevel and (guide.minLevel == guide.maxLevel and guide.minLevel
        or (guide.minLevel .. "-" .. guide.maxLevel))
    f.title:SetText((guide.name:gsub("%s*%(.-%)$", "")) .. (levels and ("  |cffaaaaaa" .. levels .. "|r") or ""))
    local done, total = SA:Progress()
    f.progress:SetText(done .. "/" .. total)

    local y = HEADER + 4
    -- under-level hint, e.g. a level 1 Tauren whose route starts at The Barrens (12-15)
    if guide.minLevel and SA.level and SA.level < guide.minLevel - 1 then
        local starter = SA:StarterGuide(SA.routeName, SA.race)
        f.warn:SetText("You're level " .. SA.level .. "; this guide starts at " .. guide.minLevel .. "."
            .. (starter and "" or " No starting-zone guide for your race yet: quest at home until then."))
        f.warn:Show()
        y = y + f.warn:GetStringHeight() + 6
    else
        f.warn:Hide()
    end

    -- animate only for changes inside the same guide, while the window is on screen
    local anim = animOn() and self.drawn and self.lastGuide == guide.name and f:IsShown()
    local steps = SA:UpcomingSteps(SA.db.shown)
    local keep = {}
    for _, step in ipairs(steps) do keep[step.key] = true end

    for key, row in pairs(self.byKey) do
        if not keep[key] then
            self.byKey[key] = nil
            -- ticked rows get the tick animation; skipped / switched-off ones just fade
            local ticked = SA:DoneSet(guide)[key] == true
            if anim then self:Leave(row, ticked) else self:Recycle(row) end
        end
    end
    if not anim then
        for row in pairs(self.live) do if row.st.leaving then self:Recycle(row) end end
        self.holdUntil = nil
    end
    local holding = anim and self:Holding()

    local list = {}
    for i, step in ipairs(steps) do
        local row = self.byKey[step.key]
        local new = row == nil
        if new then
            row = self:Acquire()
            self.byKey[step.key] = row
            self.live[row] = true
        end
        local current = i == 1
        local h = self:FillRow(row, step, current, guide)
        if holding then
            row.st.wantCur = current -- applied when the leaving row has gone
        else
            row.bg:SetShown(current)
            row.bar:SetShown(current)
            row.st.wantCur = nil
        end
        row.st.ty, row.st.ta = y, current and 1 or 0.6
        if new or not anim then
            row.st.y = (new and anim) and (y + ENTER_DROP) or y
            row.st.a = (new and anim) and 0 or row.st.ta
            row.st.x = 0
        end
        place(row)
        row:Show()
        list[i] = row
        y = y + h + 2
    end
    self.rows = list

    -- pulse the step that just became current
    local curKey = steps[1] and steps[1].key
    if curKey and curKey ~= self.lastCurrent and animOn() and self.drawn and f:IsShown() then
        list[1].st.flashT = 0
        self.animating = true
    end
    self.lastCurrent = curKey

    if #steps == 0 then
        local isLast = SA:GuideIndex() == #SA.chain
        f.empty:ClearAllPoints()
        f.empty:SetPoint("TOPLEFT", PAD, -y - 4)
        f.empty:SetText(isLast and "Route complete. Well played!"
            or "All steps in this guide are done.\nType |cffffffff/sa guide next|r to continue.")
        f.empty:Show()
        y = y + f.empty:GetStringHeight() + 8
    else
        f.empty:Hide()
    end
    self.th = y + PAD - 2
    if anim then
        self.h = self.h or self.th
        self.animating = true
    else
        self.h = self.th
        f:SetHeight(self.th)
    end
    self.drawn = true
    self.lastGuide = guide.name
end

-- Hover tooltip: everything about the step, and what the mouse buttons do.
function UI:StepTooltip(row)
    local step = row.step
    if not step or row.st.leaving then return end
    GameTooltip:SetOwner(row, "ANCHOR_LEFT")
    GameTooltip:SetText(stepTitle(step), 1, 1, 1, 1, true)
    if step.note then GameTooltip:AddLine(step.note, 0.85, 0.85, 0.85, true) end
    local objs = step.qid and SA.Tracker and SA.Tracker:Objectives(step.qid)
    for _, o in ipairs(objs or {}) do
        GameTooltip:AddLine("- " .. o.text, o.done and 0.25 or 1, 1, o.done and 0.25 or 1)
    end
    if step.qid then GameTooltip:AddLine("Quest #" .. step.qid, 0.55, 0.6, 0.7) end
    if step.x then
        GameTooltip:AddLine(string.format("%s %s, %s", step.zone or "", fmt(step.x), fmt(step.y)), 0.55, 0.6, 0.7)
    end
    if step.useItem then GameTooltip:AddLine("Use: " .. itemName(step.useItem), 0.55, 0.6, 0.7) end
    if step.forever then GameTooltip:AddLine("New in WoW Forever", 0.4, 0.8, 1) end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Left-click: tick / untick", 0.6, 0.6, 0.6)
    GameTooltip:AddLine("Right-click: skip quest, map, waypoint" .. (step.dungeon and ", dungeon" or ""), 0.6, 0.6, 0.6)
    GameTooltip:Show()
end

---------------------------------------------------------------------------
-- Right-click menu (a small frame of our own: no dependency on the client's menu API)
---------------------------------------------------------------------------

function UI:MenuItems(step)
    local items = {}
    local function add(label, fn) items[#items + 1] = { label = label, fn = fn } end
    if SA:IsDone(step) then
        add("Mark not done", function() SA:SetDone(step, false) end)
    else
        add("Mark done", function() SA:SetDone(step, true) end)
    end
    if step.qid then
        add("Skip this quest", function() SA:SkipQuest(step.qid, step.title) end)
    end
    if step.dungeon then
        add("Turn off " .. step.dungeon, function() SA:SetDungeon(step.dungeon, false) end)
    elseif step.alt then
        add("Turn " .. step.alt .. " back on", function() SA:SetDungeon(step.alt, true) end)
    end
    if step.x and SA.Nav then
        add("Show on map", function() SA.Nav:ShowOnMap(step) end)
        add("Set waypoint here", function() SA.Nav:Pin(step) end)
    end
    add("Cancel", function() end)
    return items
end

function UI:OpenMenu(row)
    local m = self.menu
    if not m then
        m = CreateFrame("Frame", "ScriptedAdventureMenu", UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil)
        m:SetFrameStrata("DIALOG")
        m:SetClampedToScreen(true)
        m:EnableMouse(true)
        if m.SetBackdrop then
            m:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                            edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 } })
            m:SetBackdropColor(0.08, 0.08, 0.1, 0.95)
        end
        m.buttons = {}
        if UISpecialFrames then table.insert(UISpecialFrames, "ScriptedAdventureMenu") end -- Escape closes it
        m:SetScript("OnUpdate", function(selfm, dt)
            -- close when the mouse has been away for a moment
            if selfm:IsMouseOver() or (selfm.owner and selfm.owner:IsMouseOver()) then selfm.away = 0; return end
            selfm.away = (selfm.away or 0) + dt
            if selfm.away > 1.5 then selfm:Hide() end
        end)
        self.menu = m
    end
    local items = self:MenuItems(row.step)
    local width = 150
    for i, item in ipairs(items) do
        local b = m.buttons[i]
        if not b then
            b = CreateFrame("Button", nil, m)
            b:SetSize(width - 12, 18)
            b:SetPoint("TOPLEFT", 6, -6 - (i - 1) * 18)
            b:SetNormalFontObject("GameFontHighlightSmall")
            b:SetHighlightFontObject("GameFontNormalSmall")
            local hl = b:CreateTexture(nil, "HIGHLIGHT")
            hl:SetAllPoints()
            hl:SetColorTexture(1, 1, 1, 0.08)
            m.buttons[i] = b
        end
        b:SetText(item.label)
        local fs = b.GetFontString and b:GetFontString()
        if fs then fs:ClearAllPoints(); fs:SetPoint("LEFT", 6, 0) end
        b:SetScript("OnClick", function() m:Hide(); item.fn() end)
        b.label = item.label
        b:Show()
    end
    for i = #items + 1, #m.buttons do m.buttons[i]:Hide() end
    m:SetSize(width, #items * 18 + 12)
    m.owner, m.away = row, 0
    m:ClearAllPoints()
    m:SetPoint("TOPLEFT", row, "TOPRIGHT", 4, 0)
    m:Show()
end

function UI:Toggle()
    if not self.frame then return end
    SA.db.hidden = self.frame:IsShown()
    self.frame:SetShown(not SA.db.hidden)
    if SA.db.hidden and self.menu then self.menu:Hide() end
    if SA.db.hidden and SA.History and SA.History.frame then SA.History.frame:Hide() end
    if SA.Settings then SA.Settings:Refresh() end
    if SA.ItemButton then SA.ItemButton:Update() end
end

function UI:Init()
    if not self.frame then self:Build() end
    self.frame:SetScale(SA.db.scale or 1)
    self.frame:SetShown(not SA.db.hidden)
    self:Update()
    if SA.Nav then SA.Nav:Update() end
end

-- item names arrive asynchronously; redraw once they're cached
local items = CreateFrame("Frame")
items:RegisterEvent("GET_ITEM_INFO_RECEIVED")
items:SetScript("OnEvent", function()
    if UI.waitingForItems then UI:Update() end
end)
