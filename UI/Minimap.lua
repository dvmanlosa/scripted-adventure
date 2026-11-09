-- ScriptedAdventure minimap button (drag it around the minimap edge) and the addon
-- compartment entry on clients that have one.
--   left-click: show/hide the guide   right-click: settings   shift-click: history

local _, SA = ...
local M = {}
SA.Minimap = M

-- our own round badge (Media/icon.tga, drawn by tools/make_icon.py); it has its own gold ring
local ICON = "Interface\\AddOns\\ScriptedAdventure\\Media\\icon"

local function position(b)
    local angle = math.rad(SA.db.minimapAngle or 210)
    local x, y = math.cos(angle), math.sin(angle)
    local shape = GetMinimapShape and GetMinimapShape() or "ROUND"
    local r = ((Minimap:GetWidth() or 140) / 2) + 6
    if shape == "SQUARE" then
        -- push to the square's edge instead of the circle's
        local m = math.max(math.abs(x), math.abs(y))
        x, y = x / m, y / m
        r = r - 4
    end
    b:ClearAllPoints()
    b:SetPoint("CENTER", Minimap, "CENTER", x * r, y * r)
end

local function click(button)
    if button == "RightButton" then
        if SA.Settings then SA.Settings:Toggle() end
    elseif IsShiftKeyDown and IsShiftKeyDown() then
        if SA.History then SA.History:Toggle() end
    elseif SA.UI then
        SA.UI:Toggle()
    end
end
M.Click = click

local function tooltip(owner)
    GameTooltip:SetOwner(owner, "ANCHOR_LEFT")
    GameTooltip:AddLine("Scripted Adventure")
    if SA.guide then
        local done, total = SA:Progress()
        GameTooltip:AddLine(SA.guide.name .. "  " .. done .. "/" .. total, 1, 1, 1)
        local step = SA:CurrentStep()
        if step then
            local label = SA.VERB_LABEL and SA.VERB_LABEL[step.verb]
            GameTooltip:AddLine((label and (label .. " ") or "") .. step.title, 1, 0.82, 0)
        end
    end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Left-click: show / hide the guide", 0.7, 0.7, 0.7)
    GameTooltip:AddLine("Shift-click: history", 0.7, 0.7, 0.7)
    GameTooltip:AddLine("Right-click: settings", 0.7, 0.7, 0.7)
    GameTooltip:AddLine("Drag: move this button", 0.7, 0.7, 0.7)
    GameTooltip:Show()
end
M.Tooltip = tooltip

function M:Build()
    if self.button or not Minimap then return end
    local b = CreateFrame("Button", "ScriptedAdventureMinimapButton", Minimap)
    self.button = b
    b:SetSize(31, 31)
    b:SetFrameStrata("MEDIUM")
    b:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 8)
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b:RegisterForDrag("LeftButton")
    b:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetAllPoints()
    b.icon:SetTexture(ICON)

    b:SetScript("OnClick", function(_, button) click(button) end)
    b:SetScript("OnEnter", function(self) tooltip(self) end)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
    b:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", function(selfb)
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            SA.db.minimapAngle = math.deg(math.atan2(cy / scale - my, cx / scale - mx))
            position(selfb)
        end)
    end)
    b:SetScript("OnDragStop", function(self) self:SetScript("OnUpdate", nil) end)
    position(b)
end

function M:Refresh()
    if SA.db.minimap == false then
        if self.button then self.button:Hide() end
        return
    end
    self:Build()
    if self.button then position(self.button); self.button:Show() end
end

-- Addon compartment (the addon list button on newer minimaps); set in the .toc
function ScriptedAdventure_OnCompartmentClick(_, button) click(button) end
function ScriptedAdventure_OnCompartmentEnter(_, owner) tooltip(owner) end
function ScriptedAdventure_OnCompartmentLeave() GameTooltip:Hide() end
