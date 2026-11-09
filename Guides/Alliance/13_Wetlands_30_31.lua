-- Wetlands (30-31) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Wetlands (30-31)
route:    Alliance
faction:  Alliance
levels:   30-31
zone:     Wetlands
next:     Hillsbrad Foothills (31-32)

fly        Menethil Harbor             #290
           Fly to Auberdine, boat to SW, fly to Menethil.

sethearth  Deepwater Tavern            [Warlock]
           In Menethil Harbor
accept     Seeking Strahad             #1798  [Warlock]
           In the Mage Quarter, Stormwind

fly        Ratchet                     [Warlock]
           Boat to Theramore Isle and fly up
turnin     Seeking Strahad             #1798  @62.6,35.5  [Warlock]
           Ratchet
accept     Tome of the Cabal (Part 1)  #1758  [Warlock]

fly        City of Ironforge           [Warlock]
           Fly to Theramore, boat to Menethil and fly to IF
turnin     Tome of the Cabal (Part 1)  #1758  [Warlock]
           Hall of Explorers
accept     Tome of the Cabal (Part 2)  #1802  [Warlock]
           Hall of Explorers

boat       Theramore Isle              [Warlock]
           Fly to Menethil and boat over
zone: Thousand Needles
note       Tattered Manuscript         @43.5,32.7  [Warlock]  loot:6997
           In cave east of the Great Lift in Thousand Needles
hearth     Menethil Harbor             [Warlock]

accept     Fall of Dun Modr            #472
           In front of the keep

zone: Wetlands
complete   Lifting the Curse           #290  @15.5,23.5
           Kill the Captain for the key, walk up the rudder to reach him
turnin     Lifting the Curse           #290
           Open the box on bottom floor of the boat, it's underwater.
accept     The Eye of Paleth           #292
turnin     Nek'rosh's Gambit           #465  @47.5,46.9
           Talk to the catapault. Skip the follow-up.

turnin     Fall of Dun Modr            #472
accept     The Dark Iron War           #303
accept     A Grim Task                 #304

accept     The Thandol Span (Part 1)   #631
turnin     The Thandol Span (Part 1)   #631  @51.2,8
           Head out to the middle of Thandol Span, head down the stairs to the right.
accept     The Thandol Span (Part 2)   #632
turnin     The Thandol Span (Part 2)   #632
accept     The Thandol Span (Part 3)   #633

complete   A Grim Task                 #304  @60,27
           Look for a dorf with a voidwalker. If he isn't in the area near the questgiver check
           at the camp to the east. If you don't find him, abandon this.
complete   The Dark Iron War           #303

turnin     A Grim Task                 #304
turnin     The Dark Iron War           #303

zone: Arathi Highlands
complete   The Thandol Span (Part 3)   #633  @48,88
           Across Thandol Span, then across the small bridge to the east
turnin     The Thandol Span (Part 3)   #633
accept     Plea To The Alliance        #634

note       Forever extras              optional  forever
           New Forever quests in this zone, givers not yet in the database: Bring Back a Bang
           (31); Understanding Our Present (31); Old Habits (31); Gleaning Our Future (32); For
           Further Study (32); Hearts of the Lost (33); Accessories of the Lost (33); Sentiments
           of the Lost (33); Stopping the Cycle (34); Word to Ironforge (34); Findings for the
           Explorer's League (40)
]==]
