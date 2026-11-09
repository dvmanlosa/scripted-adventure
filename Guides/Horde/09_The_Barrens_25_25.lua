-- The Barrens (25) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    The Barrens (25)
route:    Horde
faction:  Horde
levels:   25-25
zone:     The Barrens
next:     Thousand Needles (25-26)

turnin     Ishamuhale                #882
accept     Enraged Thunder Lizards   #907

sethearth  Camp Taurajo
accept     A New Ore Sample          #1153
           You need to be level 25 to get this

kill       Silithid Harvester        @43,70  loot:5138  optional
           If you haven't already killed him, go ahead and do so at
accept     The Harvester             #897  use:5138  optional

complete   Enraged Thunder Lizards   #907
complete   Revenge of Gann (Part 1)  #846  @49.3,84.5
           Keel two dorfs at Bael'dun Keep, it'll make you feel alright.
turnin     Revenge of Gann (Part 1)  #846  @46.2,81.2
           Back up patroling on Southern Gold Road
accept     Revenge of Gann (Part 2)  #849
complete   Revenge of Gann (Part 2)  #849  @47,85.7
           Blow up the Flying Machine
turnin     Revenge of Gann (Part 2)  #849
goto       The Great Lift
turnin     Calling in the Reserves   #5881
accept     Message to Freewind Post  #4542
]==]
