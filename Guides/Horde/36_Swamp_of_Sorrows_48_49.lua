-- Swamp of Sorrows (48-49) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Swamp of Sorrows (48-49)
route:    Horde
faction:  Horde
levels:   48-49
zone:     Swamp of Sorrows
next:     Feralas (49)

fly        Stonard
           Swamp of Sorrows
accept     Fall From Grace                 #2784
turnin     Fall From Grace                 #2784
accept     The Disgraced One               #2621  @34,66
           Talk to Fallen Hero of the Horde until he gives you the quest
turnin     Cortello's Riddle (Part 1)      #624  @22,48
           Under the bridge
accept     Cortello's Riddle (Part 2)      #625
turnin     Nothing But The Truth (Part 2)  #1383
accept     Nothing But the Truth (Part 3)  #1388
turnin     Nothing But the Truth (Part 3)  #1388
accept     Nothing But The Truth (Part 4)  #1391

hearth     Stonard
turnin     Nothing But The Truth (Part 4)  #1391
turnin     The Disgraced One               #2621
           Back at Stonard
accept     The Missing Orders              #2622
turnin     Return to Fel'Zerul             #1444
           Skip the follow-up
turnin     The Missing Orders              #2622
           At the Inn
accept     The Swamp Talker                #2623

accept     Continued Threat                #1428
complete   Continued Threat                #1428  @65,78
           At the cave at
complete   The Swamp Talker                #2623

turnin     Continued Threat                #1428
kill       Jarquia                         @94,50  loot:11723
           At around or (92,65)
die        Die

turnin     The Swamp Talker                #2623  @34,66
           Back in Stonard at Fallen Hero of the horde
accept     A Tale of Sorrow                #2801
           Talk to him
turnin     A Tale of Sorrow                #2801
           talk talk, skip the follow-up

fly        Booty Bay
accept     Whiskey Slim's Lost Grog        #580

fly        Brackenwall Village
           Boat to Ratchet and fly down
accept     The Brood of Onyxia             #1172

zone: Dustwallow Marsh
note       Get Overdue Package             @54,55  loot:11724
           From the zeppelin crash for "Ledger from Tanaris"
complete   The Brood of Onyxia             #1172  @53,72
           Eggs at and (48,75)
turnin     Cortello's Riddle (Part 2)      #625  @31,67
           West to Bloodfen Cave
accept     Cortello's Riddle (Part 3)      #626

turnin     The Brood of Onyxia             #1172
           Back at Brackenwall Village
accept     Challenge Overlord Mok'Morokk   #1173
complete   Challenge Overlord Mok'Morokk   #1173
           Elite 45
turnin     Challenge Overlord Mok'Morokk   #1173
]==]
