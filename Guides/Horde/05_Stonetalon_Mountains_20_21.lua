-- Stonetalon Mountains (20-21) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Stonetalon Mountains (20-21)
route:    Horde
faction:  Horde
levels:   20-21
zone:     Stonetalon Mountains
next:     Ashenvale (21-22)

zone: Orgrimmar
accept     Devourer of Souls              #1507  @48.3,45.6  [Warlock]
           At the warlock trainer in Orgrimmar
turnin     Devourer of Souls              #1507  [Warlock]
accept     Blind Cazul                    #1508  [Warlock]
turnin     Blind Cazul                    #1508  @37.4,59.7  [Warlock]
           In a building on the way to the flight master
accept     News of Dogran (Part 1)        #1509  [Warlock]
zone: Stonetalon Mountains
turnin     News of Dogran (Part 1)        #1509  @53.5,54  [Warlock]
           In from of the inn at the Crossroads
accept     News of Dogran (Part 2)        #1510  [Warlock]

goto       Honor's Stand
           Take the road west out of the Crossroads to the edge of Stonetalon Mountains

turnin     Letter to Jin'Zil              #1060
accept     Jin'Zil's Forest Magic         #1058
accept     Blood Feeders                  #6461  @71,95
           At Malaka'Jin
turnin     News of Dogran (Part 2)        #1510  [Warlock]
accept     Ken'zigla's Draught            #1511  [Warlock]

accept     Arachnophobia                  #6284  @59.1,75.8
           From a sign outside Sishir Canyon
complete   Arachnophobia                  #6284  @52.2,73.9
           In Sishir Canyon
complete   Blood Feeders                  #6461

turnin     Ziz Fizziks                    #1483  @60,63
           In a hut at Windshear Crag
accept     Super Reaper 6000              #1093

complete   Super Reaper 6000              #1093  @62,53
           Kill operators on the broken down super reaper
complete   Goblin Invaders                #1062
complete   Deepmoss Spider Eggs           #1069

turnin     News of Dogran (Part 2)        #1510  [Warlock]
turnin     Super Reaper 6000              #1093
accept     Further Instructions (Part 1)  #1094

turnin     Arachnophobia                  #6284
           Back at Sun Rock Retreat
turnin     Kaya's Alive                   #6401
accept     Cycle of Rebirth               #6301
flightpath Flight Path

accept     Boulderslide Ravine            #6421
accept     Trouble in the Deeps           #6562

complete   Boulderslide Ravine            #6421  @61,92
           Far south down the road, hidden little cave up in the mountains

turnin     Blood Feeders                  #6461
turnin     Goblin Invaders                #1062
accept     Shredding Machines             #1068
turnin     Wenikee Boltbucket             #3921
           Skip "Nugget Slugs"
turnin     Report to Kadrak               #6541
           Skip "The Warsong Reports"
]==]
