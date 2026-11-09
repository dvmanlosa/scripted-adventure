# Guide format

Each guide is one `.lua` file holding plain text. The Lua wrapper is three lines; everything between `[==[` and `]==]` is the guide, readable in any text editor or on GitHub.

```
local _, SA = ...
SA:RegisterGuide [==[
guide:    Durotar (1-12)
route:    Horde
faction:  Horde
levels:   1-12
zone:     Durotar
next:     The Barrens (12-15)

accept     Cutting Teeth                       #788
complete   Cutting Teeth                       #788  @40.6,62.6
           Head towards Sarkoth while completing this quest
accept     Glyphic Parchment                   #98576  @42,68.4  [Mage]  forever
complete   Lazy Peons                          #5441  use:16114
           Run around and beat the sleeping peons.
]==]
```

## Lines

| Line | Meaning |
| --- | --- |
| `key: value` at the start of a line | Header (see below) |
| `verb  Title  tags` | A step |
| Indented text | Note for the step above. Several indented lines join into one note |
| Blank line | Visual group break (kept, so the UI can show groups too) |
| `== Name ==` | Named section, e.g. `== Razor Hill ==` |
| `-- text` | Comment, ignored by the addon |

Separate the title from its tags with **two or more spaces**. (If you use one space, tags are still found from the first `#`, `@` or `[`, but bare flags like `optional` need the two spaces.)

## Headers

| Header | Meaning |
| --- | --- |
| `guide:` | Guide name, unique within its route. `next:` points to this name |
| `route:` | Which route the guide belongs to: `Horde` or `Alliance` |
| `faction:` | `Horde` or `Alliance` |
| `levels:` | Level range, `1-12` or `25` |
| `zone:` | Zone for the coordinates that follow. Can appear again mid-guide when coordinates move to another zone |
| `next:` | The guide that follows this one |
| `races:` | Only on starting-zone guides: the races that begin the route here, e.g. `races: Orc, Troll` |

## Verbs

| Verb | Do this | Verb | Do this |
| --- | --- | --- | --- |
| `accept` | Accept the quest | `goto` | Travel to a place |
| `complete` | Finish the quest's objectives | `fly` | Take a flight to |
| `turnin` | Turn the quest in | `flightpath` | Learn the flight path |
| `kill` | Kill a target | `boat` | Take the boat/zeppelin to |
| `grind` | Grind (to `level:N`) | `hearth` | Use your hearthstone to |
| `buy` | Buy an item | `sethearth` | Set your hearthstone at |
| `use` | Use an item | `petskill` | Learn a pet skill (hunter) |
| `note` | Read and tick off | `die` | Die and resurrect |

## Tags

| Tag | Meaning |
| --- | --- |
| `#788` | Quest ID |
| `@40.6,62.6` | Map coordinate in the current `zone:` |
| `[Mage]`, `[Warrior, Shaman]` | Only these classes |
| `[not Warlock]` | Every class except these |
| `[Orc]`, `[Night Elf, Human]` | Only these races. A class and a race filter on the same step must both match |
| `use:16114` | Item to use for this step |
| `loot:3357x8` | Item to collect, and how many (`loot:3357` without a count) |
| `level:8` | Level this step is about (grind targets) |
| `xp:70` | With `level:8` on a grind step: done at 70% of the way through level 8 |
| `dungeon:The_Deadmines` | Part of a dungeon (underscores stand for spaces). Hidden while that dungeon is turned off |
| `alt:The_Deadmines` | Alternative step, shown only while that dungeon is turned off |
| `optional` | Can be skipped |
| `forever` | Content added by WoW Forever (not in vanilla) |
| `unverified` | Forever quest whose location or objective isn't confirmed yet |

## Dungeons

Players turn a dungeon off by right-clicking one of its steps, or with `/sa dungeon deadmines off` (`/sa dungeons` lists them). Its `dungeon:` steps disappear, quests that need a dungeon quest go with them, and `alt:` steps for it appear: for example a grind step that makes up the missed levels. Only the dungeon parts of a chapter are tagged, so its solo quests stay.

## Routes

There is one route per faction. `Guides/<Route>/Route.lua` names it and says where the shared part starts:

```
SA:RegisterRoute [==[
route:    Horde
faction:  Horde
start:    The Barrens (12-15)
]==]
```

A character starts at the starting-zone guide whose `races:` include their race, and that guide's `next:` leads into the shared chain. Races with no starting-zone guide yet start at `start:`. To add a starting zone (say Mulgore), write a guide with `races: Tauren` and `next: The Barrens (12-15)`, and add it to `<Route>.xml`.

`Guides/<Route>/<Route>.xml` lists the files in load order.

`Guides/<Route>/QuestInfo.lua` lists quest prerequisites, one per line: `804 needs 790` (790 first), `X needs A and B` (both), `X needs A or B` (either). When a player skips a quest, every quest that can no longer be taken because of it is skipped too. Generated from QuestieDB by `tools/quest_meta.py`.

## Regenerating and checking

The Orc and Human guides are generated from `out/forever_*_route.json`. After editing the generator, or by hand:

```
python -I tools/match_quest_ids.py <QuestieDB>/data/Forever   # optional: fill missing quest IDs -> tools/quest_id_fixes.json
python -I tools/convert_routes.py          # JSON (+ ID fixes) -> Guides/ (overwrites generated guides)
python tools/check_guides.py               # needs: pip install lupa
python tools/smoke_test.py                 # loads the whole addon against a fake WoW API
```

`check_guides.py` runs `Core/Parser.lua` in Lua 5.1 (the same Lua as WoW), reports parse errors with line numbers, follows each route's `next:` chain, and compares every step to the source JSON.

Once guides are edited by hand, stop regenerating them from JSON, or the edits are overwritten.
