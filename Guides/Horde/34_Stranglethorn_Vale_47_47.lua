-- Stranglethorn Vale (47) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Stranglethorn Vale (47)
route:    Horde
faction:  Horde
levels:   47-47
zone:     Stranglethorn Vale
next:     Searing Gorge (47-48)

fly        Booty Bay
           via zeppelin to Grom'gol
turnin     Grim Message                       #2932

complete   Raptor Mastery (Part 4)            #197  @28.7,44.9
           Kill Tethis
turnin     Raptor Mastery (Part 4)            #197
           At Nessingwary's Camp
accept     Big Game Hunter                    #208
complete   Big Game Hunter                    #208  @38.2,35.6
           On top of a small hill south-east of Grom'gol on the other side of the river. Clear
           the tigers nearby first, otherwise they'll join in. If you fail, skip this.
turnin     Big Game Hunter                    #208
           Back at Nessingwary's Camp

fly        Booty Bay
accept     The Bloodsail Buccaneers (Part 5)  #608
sethearth  Booty Bay
turnin     Back to Booty Bay                  #1118
turnin     Deliver to MacKinley               #2874
turnin     Rescue OOX-22/FE!                  #2767  optional
accept     The Captain's Chest                #8551

complete   The Captain's Chest                #8551  @36.3,69.7
           On the beach east of Booty Bay, head north when you reach the sea
note       Loot the bottles on the beach      loot:4098
accept     Message in a Bottle (Part 1)       #594  use:4098
turnin     Message in a Bottle (Part 1)       #594  @38.5,80.6
           On the large island east of Booty Bay
accept     Message in a Bottle (Part 2)       #630
           May require assistance to complete
complete   Message in a Bottle (Part 2)       #630  @40.4,82.7
           South-east side of the island
turnin     Message in a Bottle (Part 2)       #630
complete   The Bloodsail Buccaneers (Part 5)  #608
           In the three ships off the coast - make sure to check downstairs in each one for the
           riddle.
accept     Cortello's Riddle (Part 1)         #624  use:4056
           Check downstairs in the ships, scroll is usually in the middle ship.

hearth     Booty Bay
           or die on purpose
turnin     The Captain's Chest                #8551
note       [Silk Cloth]                       loot:4306x15
           Have 15x Silk Cloth for a later quest, if possible
turnin     The Bloodsail Buccaneers (Part 5)  #608

accept     The Green Hills of Stranglethorn   #338
           If you have all the pages
turnin     The Green Hills of Stranglethorn   #338
]==]
