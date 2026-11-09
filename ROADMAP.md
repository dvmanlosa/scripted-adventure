# ScriptedAdventure roadmap

A step-by-step leveling guide for WoW Forever: picks the route for your faction (and the starting zone for your race), shows the current steps, and ticks them off as you do them.

| Phase | Scope | Status |
| --- | --- | --- |
| 1 | Readable guide format, converter from `out/` JSON, Lua parser, checker | Done |
| 2 | Addon skeleton: `.toc`, faction routes with per-race starting zones, step window (current + next steps), manual tick/skip/back, saved progress per character, slash commands | Done, needs in-game test |
| 3 | Auto-completion: quest accepted / objectives done / turned in, flight path, hearth, level, zone, item counts; already-done quests tick on login; modern quest API first, secret-value safe | Done, needs in-game test |
| 4 | Navigation: game map pin + on-screen waypoint on the current step, TomTom if installed, "show on map"; live objective counts; right-click step menu; skip a whole quest | Done, needs in-game test |
| 5 | Polish: settings page (gear button / game AddOns settings) with guide picker, dungeons, skipped quests; history panel (click an entry to go back to it); window lock and size; step animations; minimap button + addon-list entry; item button for the step's item (secure, combat-safe); keybindings; step hover tooltip. Still to do: compact view | **Mostly done, needs in-game test** |
| Content | Improve the shared 12-60 routes first; starting zones for other races later | Ongoing |

## Route data tools

| Tool | Does |
| --- | --- |
| `tools/match_quest_ids.py` | Fills missing quest IDs from QuestieDB -> `tools/quest_id_fixes.json` |
| `tools/quest_meta.py` | Quest prerequisites and dungeon quests from QuestieDB -> `tools/quest_meta.json` |
| `tools/route_edits.json` | Hand fixes on top of the JSON: reorder/insert steps, notes, optional, wrong quest IDs and zones, xp gates, dungeon tags and alternatives |
| `tools/audit_routes.py` | Flags wrong-faction quests, quests taken under their required level, grey quests |
| `tools/convert_routes.py` | JSON + fixes + edits -> `Guides/` |
| `tools/check_guides.py`, `tools/smoke_test.py` | Parser/route checks, and the whole addon against a fake WoW API |

## Done from the FlowUp ideas (their routes are All Rights Reserved and not used)

- Skipping a quest also skips its follow-ups (`Guides/<Route>/QuestInfo.lua`, from QuestieDB).
- Grind steps by XP percent (`xp:70`).
- Dungeon steps that can be switched off, with `alt:` alternatives (Deadmines has one).

## Ideas

- Compact view (current step only, smaller font).
- Optional side chains switched like dungeons.
- Fill in `xp:` gates on grind steps; review the grey-quest audit.
- Starting zones for Tauren, Undead, Dwarf/Gnome, Night Elf.
- Not planned: auto accept/turn-in, Skyborne starting zone.

## Open items

- Trolls use Durotar, but Troll-only class quests aren't in the data yet.
- Grey-quest audit (13 Horde, 7 Alliance) lists low-XP breadcrumbs; review case by case.
