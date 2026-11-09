-- ScriptedAdventure item button: click (or keybind) to use the current step's item, e.g. the
-- Foreman's Blackjack on "Lazy Peons". A secure button, so it can use items; the game only lets
-- it be changed out of combat, so updates wait for combat to end. It is placed on UIParent next
-- to the guide window rather than anchored to it: anchoring would make the (animated) guide
-- window protected in combat.

local _, SA = ...
local B = {}
SA.ItemButton = B

local SIZE = 36
local getItemIcon = (C_Item and C_Item.GetItemIconByID) or GetItemIcon
local getCooldown = (C_Container and C_Container.GetItemCooldown) or GetItemCooldown

local function inCombat() return InCombatLockdown and InCombatLockdown() or false end

function B:Build()
    if self.button then return end
    local b = CreateFrame("Button", "ScriptedAdventureItemButton", UIParent, "SecureActionButtonTemplate")
    self.button = b
    b:SetSize(SIZE, SIZE)
    b:SetFrameStrata("MEDIUM")
    b:RegisterForClicks("AnyUp", "AnyDown")
    b:SetAttribute("type", "item")
    b:Hide()

    b.icon = b:CreateTexture(nil, "ARTWORK")
    b.icon:SetAllPoints()
    b.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    b.border = b:CreateTexture(nil, "OVERLAY")
    b.border:SetPoint("TOPLEFT", -2, 2)
    b.border:SetPoint("BOTTOMRIGHT", 2, -2)
    b.border:SetColorTexture(1, 0.82, 0, 0.35)
    b.border:SetDrawLayer("BACKGROUND")
    b:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    b:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
    b.count = b:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    b.count:SetPoint("BOTTOMRIGHT", -2, 2)
    local ok, cd = pcall(CreateFrame, "Cooldown", nil, b, "CooldownFrameTemplate")
    if ok and cd then cd:SetAllPoints(); b.cooldown = cd end

    b:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        if self.itemID and GameTooltip.SetItemByID then GameTooltip:SetItemByID(self.itemID)
        else GameTooltip:SetText("Use the step's item") end
        GameTooltip:AddLine("Click (or your keybind) to use it for this step.", 0.7, 0.7, 0.7, true)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-- Next to the guide window's top-left corner, in UIParent coordinates.
function B:Place()
    local b, main = self.button, SA.UI and SA.UI.frame
    b:ClearAllPoints()
    local left, top = main and main:GetLeft(), main and main:GetTop()
    if type(left) == "number" and type(top) == "number" then
        local ratio = main:GetEffectiveScale() / UIParent:GetEffectiveScale()
        b:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", left * ratio - 6, top * ratio - 26 * ratio)
    else
        b:SetPoint("CENTER", UIParent, "CENTER", -200, 0)
    end
end

-- Counts and cooldowns are plain regions: safe to refresh even in combat.
function B:Refresh()
    local b = self.button
    if not (b and b.itemID) then return end
    local n = GetItemCount and GetItemCount(b.itemID) or 0
    b.count:SetText(n > 1 and n or "")
    b.icon:SetDesaturated(n == 0)
    if b.cooldown and getCooldown then
        local ok, start, duration = pcall(getCooldown, b.itemID)
        if ok and type(start) == "number" then b.cooldown:SetCooldown(start, duration or 0) end
    end
end

function B:Update()
    if inCombat() then self.pending = true; return end -- the game blocks changes until combat ends
    self.pending = nil
    self:Build()
    local b = self.button
    local step = SA.guide and SA:CurrentStep()
    local id = SA.db and SA.db.itemButton ~= false and step and step.useItem
    local mainShown = SA.UI and SA.UI.frame and SA.UI.frame:IsShown()
    if not (id and mainShown) then
        b.itemID = nil
        b:Hide()
        return
    end
    b.itemID = id
    b:SetAttribute("item", "item:" .. id)
    b.icon:SetTexture(getItemIcon and getItemIcon(id) or "Interface\\Icons\\INV_Misc_QuestionMark")
    self:Place()
    self:Refresh()
    b:Show()
end

local f = CreateFrame("Frame")
for _, e in ipairs({ "PLAYER_REGEN_ENABLED", "BAG_UPDATE_DELAYED", "BAG_UPDATE_COOLDOWN", "GET_ITEM_INFO_RECEIVED" }) do
    pcall(f.RegisterEvent, f, e)
end
f:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_REGEN_ENABLED" then
        if B.pending then B:Update() end
    elseif event == "GET_ITEM_INFO_RECEIVED" then
        if B.button and B.button.itemID and not inCombat() then B:Update() end
    else
        B:Refresh()
    end
end)
