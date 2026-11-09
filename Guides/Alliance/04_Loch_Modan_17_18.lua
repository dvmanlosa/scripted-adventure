-- Loch Modan (17-18) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Loch Modan (17-18)
route:    Alliance
faction:  Alliance
levels:   17-18
zone:     Loch Modan
next:     Redridge Mountains (18-20)

goto       Loch Modan                    [Human, Night Elf]
           Boat to Stormwind, take the tram to IF, then run to Loch. Make sure you grab flight
           points along the way.
goto       Algaz Station
           In the north of Loch Modan.
turnin     Stormpike's Delivery          #353  @24.8,18.4  forever
           Mountaineer Stormpike
note       New Loch Modan quests         @31.8,86.4  forever
           Banner of the Fallen from Mountaineer Ylva; Twisting the Knife from Marek Ironheart
           (81.8, 61.8); Silver of the Waves starts from a fishing toolbox (48.1, 39.7)

accept     Filthy Paws                   #307
           Upstairs, inside the tower
accept     Stormpike's Order             #1338
complete   Filthy Paws                   #307
           In the mine east of the tower
turnin     Filthy Paws                   #307
goto       Thelsamar
accept     Ironband's Excavation         #436
           Last house
turnin     Stout to Kadrell              #414  optional

turnin     Ironband's Excavation         #436  @64.9,66.6
           Along the south shore of the loch
accept     Gathering Idols               #297
accept     Excavation Progress Report    #298
complete   Gathering Idols               #297
turnin     Gathering Idols               #297

goto       The Farstrider Lodge          @83.8,62.4
           East of Excavation site
accept     Crocolisk Hunting             #385
accept     A Hunter's Boast              #257
complete   A Hunter's Boast              #257
turnin     A Hunter's Boast              #257
accept     A Hunter's Challenge          #258
complete   A Hunter's Challenge          #258
turnin     A Hunter's Challenge          #258
accept     Vyrin's Revenge (Part 1)      #271
accept     Bingles' Missing Supplies     #2038  @63.5,47.9
           The NPC can be found at the easternmost shore of The Loch
complete   Crocolisk Hunting             #385  @55,55
           Lots on the islands (54,40)
complete   Bingles' Missing Supplies     #2038  @54.2,26.6
           The supplies are scattered around northernmost islands. Blastencapper, Hammer (51.78,
           24.09), Screwdriver (48.37, 20.50), Wrench (48.73, 30.10)

accept     A Dark Threat Looms (Part 1)  #250
           Middle of the Stonewrought Dam
turnin     A Dark Threat Looms (Part 1)  #250
           Barrel at the east of dam
accept     A Dark Threat Looms (Part 2)  #199
turnin     A Dark Threat Looms (Part 2)  #199

turnin     Excavation Progress Report    #298
           Back at Thelsamar
accept     Report to Ironforge           #301
complete   Vyrin's Revenge (Part 1)      #271  @39.7,66.6
           Cave top of the mountain south of Thelsamar

turnin     Crocolisk Hunting             #385
           Back at Farstrider Lodge
turnin     Vyrin's Revenge (Part 1)      #271
accept     Vyrin's Revenge (Part 2)      #531
turnin     Vyrin's Revenge (Part 2)      #531
turnin     Bingles' Missing Supplies     #2038
           Remember Bingles at the shore?

fly        City of Ironforge             [Human, Dwarf, Gnome]
turnin     Report to Ironforge           #301
           Hall of Explorers. Skip the follow-up.

note       Forever extras                optional  forever
           New Forever quests in this zone, givers not yet in the database: Snowbound (10);
           Excavation Tools (18); Ingredients for the Forge (30)
]==]
