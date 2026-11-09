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
    if step.optional then text = text .. " |cff888888(optional)|r" end
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
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing(); savePosition(self) end)
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
    f.title:SetWidth(WIDTH - PAD * 2 - 110)
    f.title:SetWordWrap(false)

    f.close = smallButton(f, "x", "Hide (/sa to show)", function() UI:Toggle() end)
    f.close:SetPoint("TOPRIGHT", -PAD + 2, -PAD + 3)
    f.skip = smallButton(f, ">", "Tick the current step", function() SA:Skip() end)
    f.skip:SetPoint("RIGHT", f.close, "LEFT", -2, 0)
    f.back = smallButton(f, "<", "Undo the last tick", function() SA:Back() end)
    f.back:SetPoint("RIGHT", f.skip, "LEFT", -2, 0)
    f.progress = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.progress:SetPoint("RIGHT", f.back, "LEFT", -6, 0)

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

    self.rows = {}
end

function UI:Row(i)
    local row = self.rows[i]
    if row then return row end
    local f = self.frame
    row = CreateFrame("Button", nil, f)
    row:SetWidth(WIDTH - PAD * 2)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    row:RegisterForDrag("LeftButton")
    row:SetScript("OnDragStart", function() f:StartMoving() end)
    row:SetScript("OnDragStop", function() f:StopMovingOrSizing(); savePosition(f) end)
    row:SetScript("OnClick", function(self, button)
        if not self.step then return end
        if button == "RightButton" then UI:OpenMenu(self) else SA:ToggleStep(self.step) end
    end)

    row.bg = row:CreateTexture(nil, "BACKGROUND")
    row.bg:SetAllPoints()
    row.bg:SetColorTexture(1, 0.82, 0, 0.10)
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
    row.check:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")

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

    self.rows[i] = row
    return row
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

    local steps = SA:UpcomingSteps(SA.db.shown)
    for i, step in ipairs(steps) do
        local row = self:Row(i)
        row.step = step
        local current = i == 1
        row.text:SetText(stepTitle(step))
        local detail = stepDetail(step, guide)
        row.detail:SetText(detail)
        row.detail:SetShown(detail ~= "")
        row.icon:SetTexture(stepIcon(step))
        row.bg:SetShown(current)
        row.bar:SetShown(current)
        row:SetAlpha(current and 1 or 0.6)
        local h = row.text:GetStringHeight() + (detail ~= "" and (row.detail:GetStringHeight() + 2) or 0) + 7
        h = math.max(h, ICON + 6)
        row:SetHeight(h)
        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", PAD, -y)
        row:Show()
        y = y + h + 2
    end
    for i = #steps + 1, #self.rows do
        self.rows[i]:Hide()
        self.rows[i].step = nil
    end

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
    f:SetHeight(y + PAD - 2)
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
end

function UI:Init()
    if not self.frame then self:Build() end
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
