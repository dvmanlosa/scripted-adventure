-- ScriptedAdventure history panel: the latest ticks, newest first. Click one to untick that step
-- and go back to it (or bring back a skipped quest), instead of pressing "<" step by step.

local _, SA = ...
local W = SA.W
local H = {}
SA.History = H

local WIDTH, ROWS, ROW_H = 300, 15, 30

local function when(t)
    if not (t and t > 0 and date) then return "" end
    return date("%H:%M", t)
end

local function entryText(e)
    if e.skip then
        return "|cffff9933Skipped|r " .. tostring(e.title)
            .. ((e.extra or 0) > 0 and (" |cffaaaaaa(+" .. e.extra .. " follow-up)|r") or "")
    end
    local label = SA.VERB_LABEL and SA.VERB_LABEL[e.verb]
    return (label and ("|cffffd100" .. label .. "|r ") or "") .. tostring(e.title)
end

local function entryDetail(e)
    local how = e.skip and "skip" or (e.how == "auto" and "auto-ticked" or "ticked by you")
    local guide = e.guide and e.guide:gsub("%s*%(.-%)$", "") or ""
    return when(e.t) .. "  " .. how .. (guide ~= "" and ("  -  " .. guide) or "")
end

function H:Build()
    local f = W.Panel("ScriptedAdventureHistory", UIParent, "MEDIUM")
    self.frame = f
    f:SetSize(WIDTH, 60)
    f:Hide()

    f.title = W.Header(f, "History")
    f.title:SetPoint("TOPLEFT", 10, -9)
    f.close = W.Icon(f, "Interface\\Buttons\\UI-StopButton", "Close", function() H:Toggle() end)
    f.close:SetPoint("TOPRIGHT", -8, -7)
    f.hint = W.Text(f)
    f.hint:SetPoint("TOPLEFT", 10, -26)
    f.hint:SetWidth(WIDTH - 20)
    f.hint:SetTextColor(0.7, 0.7, 0.7)
    f.hint:SetText("Click a step to untick it and go back to it.")
    f.empty = W.Text(f, "GameFontHighlight")
    f.empty:SetPoint("TOPLEFT", 10, -46)
    f.empty:SetText("Nothing ticked yet.")

    f.rows = {}
    for i = 1, ROWS do
        local row = CreateFrame("Button", nil, f)
        row:SetSize(WIDTH - 16, ROW_H)
        row:SetPoint("TOPLEFT", 8, -42 - (i - 1) * ROW_H)
        local hl = row:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAllPoints()
        hl:SetColorTexture(1, 1, 1, 0.07)
        row.text = W.Text(row, "GameFontHighlight")
        row.text:SetPoint("TOPLEFT", 4, -2)
        row.text:SetWidth(WIDTH - 28)
        row.text:SetWordWrap(false)
        row.detail = W.Text(row)
        row.detail:SetPoint("TOPLEFT", row.text, "BOTTOMLEFT", 0, -1)
        row.detail:SetTextColor(0.6, 0.65, 0.7)
        row:SetScript("OnClick", function(self) if self.entry then SA:UndoHistory(self.entry) end end)
        W.Tooltip(row, function()
            local e = row.entry
            if not e then return "" end
            return e.skip and "Click to bring this quest (and its follow-ups) back."
                or "Click to untick this step. You go back to it, and the steps after it stay ticked."
        end)
        f.rows[i] = row
    end
end

function H:Anchor()
    local main = SA.UI and SA.UI.frame
    local f = self.frame
    f:ClearAllPoints()
    if main and main:IsShown() then
        -- open on whichever side of the guide window has room
        local left = main:GetLeft() or 0
        if left > WIDTH + 10 then f:SetPoint("TOPRIGHT", main, "TOPLEFT", -4, 0)
        else f:SetPoint("TOPLEFT", main, "TOPRIGHT", 4, 0) end
    else
        f:SetPoint("CENTER", UIParent, "CENTER")
    end
end

function H:Update()
    local f = self.frame
    if not f or not f:IsShown() or not SA.char then return end
    local list = SA.char.history or {}
    local shown = math.min(#list, ROWS)
    for i, row in ipairs(f.rows) do
        local e = list[i]
        row.entry = e
        if e then
            row.text:SetText(entryText(e))
            row.detail:SetText(entryDetail(e))
            row:Show()
        else
            row:Hide()
        end
    end
    f.empty:SetShown(shown == 0)
    f:SetHeight(math.max(70, 48 + shown * ROW_H))
end

function H:Toggle()
    if not self.frame then self:Build() end
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self:Anchor()
        self.frame:Show()
        self:Update()
    end
end
