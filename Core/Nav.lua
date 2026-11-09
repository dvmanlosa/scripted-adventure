-- ScriptedAdventure navigation: points the game's own map pin / on-screen waypoint (and TomTom,
-- if installed) at the current step's coordinates.

local _, SA = ...
local N = {}
SA.Nav = N

local function secret(v) return issecretvalue ~= nil and issecretvalue(v) or false end

local function norm(s)
    if type(s) ~= "string" or secret(s) then return "" end
    s = s:lower():gsub("^the%s+", "")
    return (s:gsub("[^%w]", ""))
end

---------------------------------------------------------------------------
-- Zone name -> map ID, from the game's own map list (works for Forever's new zones too)
---------------------------------------------------------------------------

local ZONE_TYPES = { [3] = 1, [4] = 2, [5] = 3, [6] = 4 } -- zone, dungeon, micro, orphan: lower wins

function N:AddMap(info)
    if type(info) ~= "table" or type(info.mapID) ~= "number" then return end
    local rank = ZONE_TYPES[info.mapType or 3]
    local key = norm(info.name)
    if not rank or key == "" then return end
    local have = self.maps[key]
    if not have or rank < have.rank then self.maps[key] = { id = info.mapID, rank = rank } end
end

function N:BuildMaps()
    self.maps = {}
    if not (C_Map and C_Map.GetMapChildrenInfo) then return end
    -- Azeroth, Kalimdor, Eastern Kingdoms, and the cosmic root for anything else
    for _, root in ipairs({ 947, 1414, 1415, 946 }) do
        local ok, kids = pcall(C_Map.GetMapChildrenInfo, root, nil, true)
        if ok and type(kids) == "table" then
            for _, info in ipairs(kids) do self:AddMap(info) end
        end
    end
end

-- Last resort for a zone the tree walk missed: look at every map ID once.
function N:ScanAllMaps()
    if self.scannedAll or not (C_Map and C_Map.GetMapInfo) then return end
    self.scannedAll = true
    for id = 1, 3000 do
        local ok, info = pcall(C_Map.GetMapInfo, id)
        if ok and info then self:AddMap(info) end
    end
end

function N:MapID(zone)
    if not self.maps then self:BuildMaps() end
    local key = norm(zone)
    local hit = self.maps[key]
    if not hit and key ~= "" then
        self:ScanAllMaps()
        hit = self.maps[key]
    end
    return hit and hit.id
end

---------------------------------------------------------------------------
-- Waypoints
---------------------------------------------------------------------------

local function mapOpen()
    return WorldMapFrame and WorldMapFrame.IsShown and WorldMapFrame:IsShown() or false
end

local function stepLabel(step)
    return ((SA.VERB_LABEL and SA.VERB_LABEL[step.verb]) and (SA.VERB_LABEL[step.verb] .. " ") or "") .. step.title
end

-- Put the game pin (and TomTom arrow) on a step. Returns true if anything was set.
-- 'force' pins even while the world map is open (used right before we open it ourselves).
function N:Pin(step, force)
    local mapID = step and step.x and self:MapID(step.zone)
    if not mapID then return false end
    if mapOpen() and not force then
        -- setting a waypoint while the world map is open makes it jump; do it once it closes
        self.pending = step
        return true
    end
    self.pending = nil
    local x, y = step.x / 100, step.y / 100
    local done = false
    if C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates then
        local ok = pcall(function()
            if C_Map.CanSetUserWaypointOnMap and not C_Map.CanSetUserWaypointOnMap(mapID) then error("no pin here") end
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(mapID, x, y))
            if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
                C_SuperTrack.SetSuperTrackedUserWaypoint(true)
            end
        end)
        done = ok
        self.ownPin = ok or self.ownPin
    end
    if TomTom and TomTom.AddWaypoint then
        pcall(function()
            if self.tomtom and TomTom.RemoveWaypoint then TomTom:RemoveWaypoint(self.tomtom) end
            self.tomtom = TomTom:AddWaypoint(mapID, x, y,
                { title = stepLabel(step), persistent = false, minimap = true, world = true, from = "Scripted Adventure" })
        end)
        done = true
    end
    return done
end

function N:Clear()
    self.pending = nil
    if self.ownPin and C_Map and C_Map.ClearUserWaypoint then pcall(C_Map.ClearUserWaypoint) end
    self.ownPin = nil
    if self.tomtom and TomTom and TomTom.RemoveWaypoint then pcall(TomTom.RemoveWaypoint, TomTom, self.tomtom) end
    self.tomtom = nil
end

-- Follow the current step. Only acts when the target changes, so a pin you set yourself on the
-- map stays until the guide moves on.
function N:Update()
    if not SA.db or SA.db.nav == false or not SA.guide then return end
    local step = SA:CurrentStep()
    local key = step and step.x and (step.zone .. ":" .. step.x .. ":" .. step.y) or false
    if key == self.lastKey then return end
    self.lastKey = key
    if key then self:Pin(step) else self:Clear() end
end

function N:Reset() self.lastKey = nil; self:Update() end

-- Open the world map on a step's zone and pin the step there.
function N:ShowOnMap(step)
    local mapID = step and self:MapID(step.zone or (SA.guide and SA.guide.zone))
    if not mapID then return SA.Print("Can't find the map for " .. tostring(step and step.zone)) end
    if step.x then self:Pin(step, true) end -- pin first, then open the map on it
    if C_Map and C_Map.OpenWorldMap then
        pcall(C_Map.OpenWorldMap, mapID)
    elseif WorldMapFrame then
        if ShowUIPanel then ShowUIPanel(WorldMapFrame) else WorldMapFrame:Show() end
        if WorldMapFrame.SetMapID then WorldMapFrame:SetMapID(mapID) end
    end
end

-- deferred pin once the world map closes
local f = CreateFrame("Frame")
local elapsed = 0
f:SetScript("OnUpdate", function(_, dt)
    elapsed = elapsed + dt
    if elapsed < 0.5 then return end
    elapsed = 0
    if N.pending and not mapOpen() then N:Pin(N.pending) end
end)
