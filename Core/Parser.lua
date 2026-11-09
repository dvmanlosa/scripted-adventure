-- ScriptedAdventure guide parser.
-- Turns the plain-text guide format (docs/GUIDE_FORMAT.md) into step tables.
-- Lua 5.1, no WoW API calls, so tools/check_guides.py can run it outside the game.

local _, SA = ...
SA.guides, SA.routes, SA.parseErrors = SA.guides or {}, SA.routes or {}, SA.parseErrors or {}

-- verb -> TourGuide-style action letter (kept so step types stay compact in code)
local VERBS = {
    accept = "A", complete = "C", turnin = "T", kill = "K",
    ["goto"] = "R", fly = "F", flightpath = "f", boat = "b",
    hearth = "H", sethearth = "h", grind = "G", note = "N",
    buy = "B", use = "U", petskill = "P", die = "D",
}
SA.VERBS = VERBS

-- display name -> token returned by UnitClass / UnitRace (2nd return value)
local CLASS_TOKENS = {
    warrior = "WARRIOR", paladin = "PALADIN", hunter = "HUNTER", rogue = "ROGUE", priest = "PRIEST",
    shaman = "SHAMAN", mage = "MAGE", warlock = "WARLOCK", druid = "DRUID",
}
local RACE_TOKENS = {
    human = "Human", dwarf = "Dwarf", ["night elf"] = "NightElf", nightelf = "NightElf", gnome = "Gnome",
    orc = "Orc", undead = "Scourge", scourge = "Scourge", tauren = "Tauren", troll = "Troll",
    skyborne = "Skyborne", -- WoW Forever race, playable on both factions
}
local FLAGS = { optional = true, forever = true, unverified = true }
local NUM_TAGS = { use = "useItem", loot = "lootItem", level = "level", xp = "xp" }
local NAME_TAGS = { dungeon = "dungeon", alt = "alt" } -- dungeon:The_Deadmines (underscores = spaces)
local GUIDE_HEADERS = { guide = true, route = true, faction = true, levels = true, zone = true, next = true, races = true }

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function fail(errs, src, lineNo, msg, text)
    errs[#errs + 1] = { source = src, line = lineNo, message = msg, text = text }
end

-- "[not Warlock, Mage]" body -> fills step.classes / step.races
local function parseFilter(step, body, err)
    local negate = false
    local rest = body:match("^%s*not%s+(.*)$")
    if rest then negate, body = true, rest end
    for item in body:gmatch("[^,]+") do
        local key = trim(item):lower()
        if CLASS_TOKENS[key] then
            step.classes = step.classes or { negate = negate }
            step.classes[CLASS_TOKENS[key]] = true
        elseif RACE_TOKENS[key] then
            step.races = step.races or { negate = negate }
            step.races[RACE_TOKENS[key]] = true
        else
            err("unknown class or race '" .. trim(item) .. "'")
        end
    end
end

local function parseTags(step, tags, err)
    local pos, len = 1, #tags
    while pos <= len do
        local s = tags:find("%S", pos)
        if not s then break end
        if tags:sub(s, s) == "[" then
            local close = tags:find("]", s, true)
            if not close then err("unclosed [ in tags"); return end
            parseFilter(step, tags:sub(s + 1, close - 1), err)
            pos = close + 1
        else
            local tok = tags:match("^%S+", s)
            pos = s + #tok
            local qid = tok:match("^#(%d+)$")
            local x, y = tok:match("^@(%d+%.?%d*),(%d+%.?%d*)$")
            local key, val = tok:match("^(%a+):(%d+)$")
            local lootId, lootCount = tok:match("^loot:(%d+)x(%d+)$")
            local nameKey, name = tok:match("^(%a+):(%S+)$")
            if lootId then
                step.lootItem, step.lootCount = tonumber(lootId), tonumber(lootCount)
            elseif qid then
                step.qid = tonumber(qid)
            elseif x then
                step.x, step.y = tonumber(x), tonumber(y)
            elseif key and NUM_TAGS[key] then
                step[NUM_TAGS[key]] = tonumber(val)
            elseif nameKey and NAME_TAGS[nameKey] then
                step[NAME_TAGS[nameKey]] = (name:gsub("_", " "))
            elseif FLAGS[tok] then
                step[tok] = true
            else
                err("unknown tag '" .. tok .. "'")
            end
        end
    end
end

-- Parse one guide's text. Returns guide table (or nil) and a list of errors.
function SA.ParseGuide(text, src)
    local errs = {}
    local guide = { steps = {} }
    local zone, section, gap, last
    local lineNo = 0
    for raw in (text .. "\n"):gmatch("([^\n]*)\n") do
        lineNo = lineNo + 1
        local line = raw:gsub("\r$", "")
        local function err(msg) fail(errs, src or guide.name, lineNo, msg, line) end

        if line:match("^%s*$") then
            gap = #guide.steps > 0
        elseif line:match("^%s*%-%-") then
            -- comment
        elseif line:match("^%s") then
            -- indented line: note text for the step above
            if last then
                last.note = last.note and (last.note .. " " .. trim(line)) or trim(line)
            else
                err("note line before any step")
            end
        elseif line:match("^==") then
            section = trim(line:match("^=+%s*(.-)%s*=*$") or "")
            gap = true
        elseif line:match("^%a+:") then
            local key, val = line:match("^(%a+):%s*(.-)%s*$")
            if key == "zone" then
                zone = val
                guide.zone = guide.zone or val
            elseif GUIDE_HEADERS[key] then
                if #guide.steps > 0 then err("header '" .. key .. ":' after the first step") end
                if key == "guide" then guide.name = val
                elseif key == "races" then
                    -- starting-zone guide: only these races begin the route here
                    guide.races = {}
                    for item in val:gmatch("[^,]+") do
                        local tok = RACE_TOKENS[trim(item):lower()]
                        if tok then guide.races[tok] = true else err("unknown race '" .. trim(item) .. "'") end
                    end
                elseif key == "levels" then
                    local lo, hi = val:match("^(%d+)%s*%-%s*(%d+)$")
                    lo = lo or val:match("^(%d+)$")
                    guide.minLevel, guide.maxLevel = tonumber(lo), tonumber(hi or lo)
                    if not lo then err("levels must look like 1-12") end
                else guide[key] = val end
            else
                err("unknown header '" .. key .. ":'")
            end
        else
            local verb, rest = line:match("^(%a+)%s+(.-)%s*$")
            if not verb then verb, rest = line:match("^(%a+)$"), "" end
            local action = verb and VERBS[verb]
            if not action then
                err("unknown step verb '" .. tostring(verb or line) .. "'")
            else
                -- title and tags are separated by two or more spaces
                local title, tags = rest:match("^(.-)%s%s+(.*)$")
                if not title then
                    -- forgiving fallback: tags start at the first " #", " @" or " ["
                    local cut = rest:find("%s[#@%[]")
                    if cut then title, tags = rest:sub(1, cut - 1), rest:sub(cut + 1)
                    else title, tags = rest, "" end
                end
                local step = {
                    action = action, verb = verb, title = trim(title), zone = zone,
                    section = section, gap = gap or nil, line = lineNo,
                }
                parseTags(step, tags, err)
                if step.title == "" then err("step has no title") end
                guide.steps[#guide.steps + 1] = step
                last, gap = step, false
            end
        end
    end
    if not guide.name then fail(errs, src, 0, "missing 'guide:' header") end
    if not guide.zone then fail(errs, src or guide.name, 0, "missing 'zone:' header") end
    for i, step in ipairs(guide.steps) do step.index = i end
    return guide.name and guide or nil, errs
end

local function collect(errs)
    for _, e in ipairs(errs) do SA.parseErrors[#SA.parseErrors + 1] = e end
end

function SA:RegisterGuide(text)
    local guide, errs = SA.ParseGuide(text)
    collect(errs)
    if not guide then return end
    if not guide.route then
        collect({ { source = guide.name, line = 0, message = "missing 'route:' header" } })
        return
    end
    -- guides are keyed by route, so two routes can both have "Winterspring (54-55)"
    local byName = SA.guides[guide.route] or {}
    SA.guides[guide.route] = byName
    if byName[guide.name] then
        collect({ { source = guide.name, line = 0, message = "guide registered twice in route " .. guide.route } })
    end
    byName[guide.name] = guide
    return guide
end

-- Quest prerequisites for a route (Guides/<Route>/QuestInfo.lua):
--   "804 needs 790"               804 needs 790 first
--   "6383 needs 235 or 742 or 6382"   any one of them
--   "X needs A and B"             both
-- Stored as SA.requires[route][qid] = { {all = {...}} / {any = {...}}, ... } (every group must hold).
SA.requires = SA.requires or {}
function SA:RegisterQuestInfo(routeName, text)
    local byQuest = SA.requires[routeName] or {}
    SA.requires[routeName] = byQuest
    local errs, lineNo = {}, 0
    for line in (text .. "\n"):gmatch("([^\n]*)\n") do
        lineNo = lineNo + 1
        if not (line:match("^%s*$") or line:match("^%s*%-%-")) then
            local q, rest = line:match("^%s*(%d+)%s+needs%s+(.-)%s*$")
            if not q then
                fail(errs, "QuestInfo " .. routeName, lineNo, "expected '<quest> needs <quest> ...'", line)
            else
                local kind = rest:find("%sor%s") and "any" or "all"
                local group = { kind = kind }
                for id in rest:gmatch("%d+") do group[#group + 1] = tonumber(id) end
                local list = byQuest[tonumber(q)] or {}
                list[#list + 1] = group
                byQuest[tonumber(q)] = list
            end
        end
    end
    collect(errs)
end

function SA:RegisterRoute(text)
    local route, errs = {}, {}
    local lineNo = 0
    for line in (text .. "\n"):gmatch("([^\n]*)\n") do
        lineNo = lineNo + 1
        local key, val = line:match("^(%a+):%s*(.-)%s*$")
        if key == "races" or key == "classes" then
            route[key] = {}
            for item in val:gmatch("[^,]+") do
                local k = trim(item):lower()
                local tok = key == "races" and RACE_TOKENS[k] or CLASS_TOKENS[k]
                if tok then route[key][tok] = true
                else fail(errs, "route", lineNo, "unknown " .. key .. " entry '" .. trim(item) .. "'", line) end
            end
        elseif key == "route" or key == "faction" or key == "start" then
            route[key] = val
        elseif key then
            fail(errs, "route", lineNo, "unknown route header '" .. key .. ":'", line)
        elseif not line:match("^%s*$") and not line:match("^%s*%-%-") then
            fail(errs, "route", lineNo, "expected 'key: value'", line)
        end
    end
    for _, k in ipairs({ "route", "faction", "start" }) do
        if not route[k] then fail(errs, "route", 0, "missing '" .. k .. ":'") end
    end
    collect(errs)
    if route.route then SA.routes[route.route] = route end
    return route
end

-- The starting-zone guide for a race in a route, if one exists.
function SA:StarterGuide(routeName, race)
    for _, guide in pairs(SA.guides[routeName] or {}) do
        if guide.races and guide.races[race] then return guide end
    end
end

-- A route's guide chain for one race: its starting-zone guide (if any), then each 'next:'.
-- Races without a starting guide begin at the route's 'start:'.
-- Returns the list of guides, plus the name the chain broke on (nil when it ended cleanly).
function SA:RouteGuides(routeName, race)
    local route, byName, list, seen = SA.routes[routeName], SA.guides[routeName] or {}, {}, {}
    local starter = race and SA:StarterGuide(routeName, race)
    local name = starter and starter.name or (route and route.start)
    while name and byName[name] and not seen[name] do
        seen[name] = true
        list[#list + 1] = byName[name]
        name = byName[name].next
    end
    return list, name
end
