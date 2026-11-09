-- ScriptedAdventure widgets: small controls built from plain frames, so they don't depend on
-- which Blizzard templates this client ships.

local _, SA = ...
local W = {}
SA.W = W

W.BACKDROP = {
    bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 12, insets = { left = 3, right = 3, top = 3, bottom = 3 },
}
W.TEMPLATE = BackdropTemplateMixin and "BackdropTemplate" or nil

function W.Panel(name, parent, strata)
    local f = CreateFrame("Frame", name, parent or UIParent, W.TEMPLATE)
    if f.SetBackdrop then
        f:SetBackdrop(W.BACKDROP)
        f:SetBackdropColor(0.05, 0.05, 0.07, 0.92)
        f:SetBackdropBorderColor(0.4, 0.4, 0.45, 1)
    end
    if strata then f:SetFrameStrata(strata) end
    f:SetClampedToScreen(true)
    return f
end

local function tooltip(widget, text)
    if not text then return end
    widget:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(type(text) == "function" and text() or text, 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    widget:SetScript("OnLeave", function() GameTooltip:Hide() end)
end
W.Tooltip = tooltip

-- Text button with a dark background.
function W.Button(parent, label, width, onClick, tip)
    local b = CreateFrame("Button", nil, parent, W.TEMPLATE)
    b:SetSize(width or 90, 20)
    if b.SetBackdrop then
        b:SetBackdrop(W.BACKDROP)
        b:SetBackdropColor(0.15, 0.15, 0.18, 1)
        b:SetBackdropBorderColor(0.45, 0.45, 0.5, 1)
    end
    b:SetNormalFontObject("GameFontHighlightSmall")
    b:SetHighlightFontObject("GameFontNormalSmall")
    b:SetText(label)
    b:SetScript("OnClick", function(self) onClick(self) end)
    tooltip(b, tip)
    return b
end

-- Small square icon button (header controls).
function W.Icon(parent, texture, tip, onClick)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(16, 16)
    b:SetNormalTexture(texture)
    b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    b:SetScript("OnClick", function(self) onClick(self) end)
    tooltip(b, tip)
    return b
end

-- Checkbox with a label. get() returns the value; set(v) stores it.
function W.Check(parent, label, get, set, tip)
    local c = CreateFrame("CheckButton", nil, parent)
    c:SetSize(20, 20)
    c:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
    c:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
    c:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight", "ADD")
    c:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
    c.label = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    c.label:SetPoint("LEFT", c, "RIGHT", 4, 0)
    c.label:SetText(label)
    c:SetScript("OnClick", function(self) set(self:GetChecked() and true or false) end)
    c.Refresh = function(self) self:SetChecked(get() and true or false) end
    tooltip(c, tip)
    return c
end

-- "Label   [-] value [+]" number stepper (no slider template needed).
function W.Stepper(parent, label, get, set, min, max, step, fmt)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(260, 20)
    f.label = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    f.label:SetPoint("LEFT", 0, 0)
    f.label:SetText(label)
    f.value = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    f.value:SetPoint("LEFT", 170, 0)
    f.value:SetWidth(44)
    local function bump(d)
        local v = get() + d * (step or 1)
        v = math.max(min, math.min(max, math.floor(v / (step or 1) + 0.5) * (step or 1)))
        set(v)
        f:Refresh()
    end
    f.minus = W.Button(f, "-", 20, function() bump(-1) end)
    f.minus:SetPoint("RIGHT", f.value, "LEFT", -2, 0)
    f.plus = W.Button(f, "+", 20, function() bump(1) end)
    f.plus:SetPoint("LEFT", f.value, "RIGHT", 2, 0)
    f.Refresh = function(self) self.value:SetText(fmt and fmt(get()) or tostring(get())) end
    return f
end

function W.Header(parent, text)
    local h = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    h:SetText(text)
    return h
end

function W.Text(parent, font)
    local t = parent:CreateFontString(nil, "OVERLAY", font or "GameFontHighlightSmall")
    t:SetJustifyH("LEFT")
    return t
end
