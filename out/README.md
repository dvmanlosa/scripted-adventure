# WoW Forever — leveling routes 1–60 (addon data)

Built 2026-11-07 from TourGuideVanilla's guides, merged with WoW Forever quest data. Two routes, same format:

| Route | Start → order | Guides | Steps | Forever steps |
| --- | --- | --- | --- | --- |
| **Human** (Alliance) | Elwynn → Westfall (new chapter) → TourGuideVanilla Alliance order from Darkshore; optional Deadmines after Redridge | 38 | 2,109 | 122 |
| **Orc** (Horde) | Durotar → TourGuideVanilla Horde order from The Barrens | 47 | 2,103 | 40 |

## What's in the package

| Path | What it is |
| --- | --- |
| `TourGuide_ForeverHuman/`, `TourGuide_ForeverOrc/` | Guide modules in TourGuide's step format: `.toc`, `Guides.xml`, one `.lua` per guide chained by "next zone" |
| `forever_human_route.json`, `forever_orc_route.json` | The same routes as structured data (one object per step). Use these for your own addon |
| `build_report_human.json`, `build_report_orc.json` | Every change against TourGuideVanilla: removed quests, fixed titles and IDs, converted coordinates, inserts, validation |
| `data/forever_new_quests.tsv`, `data/forever_new_quests_horde.tsv` | New Forever quests from Wowhead (Alliance/neutral 392, Horde/neutral 260), with giver, ender, coordinates and objective text where available |
| `tools/` | Build engine and profiles (see Rebuilding) |

## Step format

Each line is one step: `<action> <quest or place> |TAG|value| ...`, exactly as TourGuideVanilla's parser reads it.

| Action | Meaning | Action | Meaning |
| --- | --- | --- | --- |
| A | Accept | R | Run to |
| C | Complete | F / f | Fly / get flight path |
| T | Turn in | H / h | Hearth / set hearth |
| K | Kill | b | Boat |
| N | Note (manual tick) | G | Grind (`LV` = level gate) |

Standard tags: `N` note, `QID` quest ID, `C` class filter, `R` race filter, `Z` zone, `U` use item, `L` loot item, `O` optional, `T` in town, `NODEBUG`. Added for these routes (TourGuide ignores unknown tags):

- `|FV|`: step added for WoW Forever.
- `|UNV|`: Forever quest whose objective or location isn't in any database yet; follow the quest text.

In the JSON, each step carries `action`, `title`, `qid`, `note`, `coord {zone, x, y}`, `class`, `race`, flags (`optional`, `unverified`), and `origin` (`tgv`, `authored` or `forever`).

## What the build fixes in TourGuideVanilla (both routes)

- **Quests that don't exist in Forever are removed.** Human: 74 TBC-era quests, mostly the 2.3 Dustwallow revamp (139 steps), Forest Song, the Featherbeard chain and the Lightbringer quests. Orc: only the two Lightbringer quests. Presence is checked by quest ID and by name against Questie's Forever database. Travel steps are kept unless they lead to a TBC-only hub (Forest Song, Mudsprocket).
- **Coordinates re-projected.** Forever redrew Stormwind, Redridge, Eastern Plaguelands and Mulgore. Human: 50 converted; Orc: 6 (Eastern Plaguelands).
- **Misspelled titles fixed.** TourGuide matches the quest log by name, so a typo means the step never completes. Human: *The Alagaz Gauntlet*, *OOX-17/TN Distress Beacon*, *Return to Chillwind Camp*. Orc: *Khan Kehn*, *Nothing But the Turth*, *The Sunkey Temple*, *Hemet Nesingwary Jr.*, and the four *A Donation of …* quests whose suffixes broke matching.
- **Wrong quest IDs corrected (Orc).** *Forged Steel* 1502 → 1503, *The Ashenvale Hunt* 1131 → 6382, *Cycle of Rebirth* 1087 → 6301, *Rin'ji's Secret* 2742 → 2782.
- **One title per quest ID.** Steps that accepted a quest as *(Part 4)* and turned it in as *(Part 5)* never paired; every quest ID now has a single title, and different quests sharing a name get *(Part N)* suffixes.
- **Result:** validation warnings drop from 9 to 3 (Human) and from 74 to 36 (Orc). The rest are TourGuideVanilla chain endings that continue outside the route and title-case flags on real quest names.

## What's new from Forever

- **Human:** a full Westfall chapter with Alba Fairmoon's Deadmines chain, 65 Forever steps in Elwynn (the Paxton book chain, Book Bag, lake errands), Redridge, Loch Modan and Wetlands inserts, and class notes.
- **Orc:** 13 new Durotar quests placed automatically (Sen'jin Village, Razor Hill, Tiragarde Keep, Orgrimmar), the new Orc Mage letter *Glyphic Parchment* (Mai'ah at the Den), and class and riding notes.
- **Both:** an end-of-guide note lists new quests whose givers aren't published yet (Human 100, Orc 86).

Automatic placement (Orc) puts each accept after the TourGuide step nearest the giver, the complete step after the step nearest the objective, and the turn-in after the step nearest the ender, keeping chains and accept → complete → turn-in in order.

## Before this runs in game

- **The engine needs porting.** TourGuideVanilla targets the 1.12 client (`## Interface: 11200`, Ace2, Lua 5.0 APIs). Forever runs on the modern Classic client; Wowhead tags Forever content as patch 16001, so the TOC interface is probably `16001`. For your own addon, read the route JSON directly; nothing in the data depends on TourGuide.
- **Load a route instead of TourGuideVanilla's own Alliance or Horde module**, not alongside it: guide names overlap.

## Known gaps

- Wowhead throttles quest-page reads after a few dozen requests. Givers and objectives are in hand for new quests up to about level 20 (Human) and for Durotar (Orc). Later new quests appear only as end-of-guide notes until the data is re-pulled.
- Riverglades (36–44) and Shen'dralas (38–43) aren't routed; their quests are under `extras_not_in_route` in each JSON.
- The Human route runs 2–4 levels ahead of the guide names after Westfall. Skip grey quests.
- Human hunter pet quests are a note only. Forever's "Taming the Beast" IDs on Wowhead belong to Skyborne hunters on Zephras Isle.

## Rebuilding

Needs clones of `cralor/TourGuideVanilla` and `Questie/QuestieDB` at the paths at the top of `tools/routelib.py`, plus the `data/` files.

```
python3 -I tools/build_route.py human     # or: orc
python3 tools/verify_lua.py human         # loads every guide in a real Lua runtime and checks the chain
python3 -I tools/baseline.py orc          # validation of raw TourGuideVanilla, to compare warnings
```

Adding a race: copy `tools/route_orc.py`, change `RACE`, `TGV_DIR` and the start guide in `assemble()`, and set `AUTO_PLACE = True` to place new quests automatically.
