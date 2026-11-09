-- Ashenvale (21-22) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Ashenvale (21-22)
route:    Horde
faction:  Horde
levels:   21-22
zone:     Ashenvale
next:     The Barrens (22-23)

goto       Splintertree Post         @73,65
           Follow the road north, then east
turnin     The Ashenvale Hunt        #6382
accept     The Ashenvale Hunt        #6383
turnin     The Ashenvale Hunt        #6383

note       Stable Pet                [Hunter]
flightpath Flight Path
petskill   Bite (Rank 3)             @76,67  [Hunter]
           Tame a Ghostpaw Runner

goto       The Zoram Strand          @13,31
           Follow the main road west as far as you can, then break off and run to the coast.
           Don't get too close to the ally towns!
flightpath Flight Path
turnin     Trouble in the Deeps      #6562
           Skip "The Essence of Aku'Mai"

accept     Naga at the Zoram Strand  #6442
petskill   Claw (Rank 3)             [Hunter]
           Tame a Clattering Crawler
complete   Naga at the Zoram Strand  #6442
turnin     Naga at the Zoram Strand  #6442
]==]
