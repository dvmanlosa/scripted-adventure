-- Redridge Mountains (18-20) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Redridge Mountains (18-20)
route:    Alliance
faction:  Alliance
levels:   18-20
zone:     Redridge Mountains
next:     The Deadmines (20-22)

goto       Stormwind City
           Use the Deeprun Tram
zone: Stormwind City
turnin     Expanding Horizons                    #97914  @57.6,47.8  forever
           Baros Alexston, Cathedral Square
note       Contingency Plan                      [Priest]  forever
           New level 20 priest chain (3 steps); ask your trainer
turnin     Stormpike's Order                     #1338

goto       Redridge Mountains
zone: Redridge Mountains
turnin     The Defias Brotherhood                #65  @21.4,45.4  forever
           Wiley the Black, Lakeshire
accept     The Defias Brotherhood (Part 2)       #132  forever
           Turns in at Sentinel Hill in the Deadmines chapter
accept     Show of Force                         #98407  @25.7,60  forever
           Deputy Feldon
complete   Show of Force                         #98407  forever  unverified
           Follow the quest text; objective not yet in the database
turnin     Show of Force                         #98407  @25.7,60  forever
           Deputy Feldon
note       Alther's Mill and Blackrock Blockade  @27.1,48.6  forever
           New level 21 quests from Foreman Oslow and Marshal Marris (28.3, 48.8) in Lakeshire
accept     Encroaching Gnolls                    #244
turnin     Encroaching Gnolls                    #244
           Follow the road east until you are at the bridge
accept     Assessing the Threat                  #246
accept     The Lost Tools                        #125
accept     Hilary's Necklace                     #3741
           On the dock
accept     Selling Fish                          #127
           Man next to the shed
accept     A Free Lunch                          #129
           Inside the inn
accept     Redridge Goulash                      #92
           West of Lakeshire, inside the big house

kill       Great Goretusks                       loot:2296x5
           West of the lake, need [Great Goretusk Snout] x5 for "Redridge Goulash"
complete   Hilary's Necklace                     #3741
           Glinting Mud, underwater
complete   The Lost Tools                        #125
           Box is east of the bridge, underwater
complete   Selling Fish                          #127
           Kill the murlocks
kill       Murlocs                               loot:1468x8
           Need [Murloc Fin] x8 for later

turnin     The Lost Tools                        #125
accept     The Everstill Bridge                  #89
turnin     Hilary's Necklace                     #3741
turnin     Selling Fish                          #127
turnin     A Free Lunch                          #129
           Return to the guard at Three Corners, South of Lakeshire
accept     Visit the Herbalist                   #130

kill       Spiders                               loot:1081x5
           Around the Three Corners. Need [Crisp Spider Meat] x5 for "Redridge Goulash"
complete   Assessing the Threat                  #246
complete   Redridge Goulash                      #92  loot:1080x5
           Condors are east from the gnoll camps

turnin     Assessing the Threat                  #246
           South of Lakeshire, next the the bridge
turnin     Visit the Herbalist                   #130
           West of Lakeshire
accept     Delivering Daffodils                  #131
turnin     Redridge Goulash                      #92
turnin     Delivering Daffodils                  #131
           Inside the inn
complete   The Everstill Bridge                  #89
           Camps are north of Lakeshire
turnin     The Everstill Bridge                  #89

accept     Murloc Poachers                       #150
           Man next to the shed. This quest requires level 20!
complete   Murloc Poachers                       #150  @34.9,45
           Northern part of Lake Everstill (50.9, 53.0)
turnin     Murloc Poachers                       #150

accept     Messenger to Stormwind (Part 1)       #120
           In the town hall
fly        Stormwind City
turnin     Messenger to Stormwind (Part 1)       #120
           At the entrance to Stormwind
accept     Messenger to Stormwind (Part 2)       #121

accept     The Tome of Valor (Part 1)            #1649  [Paladin]
           You must Speak with Duthorian Rall in the Cathedral of Light and he will give you the
           Tome of Valor, use it to start the quest.
turnin     The Tome of Valor (Part 1)            #1649  [Paladin]
accept     The Tome of Valor (Part 2)            #1650  [Paladin]

fly        Sentinel Hill                         [Paladin]
zone: Westfall
turnin     The Tome of Valor (Part 2)            #1650  @41.3,88.5  [Paladin]
           Southwest of Moonbrook
accept     The Tome of Valor (Part 3)            #1651  [Paladin]
complete   The Tome of Valor (Part 3)            #1651  [Paladin]
turnin     The Tome of Valor (Part 3)            #1651  [Paladin]
accept     The Tome of Valor (Part 4)            #1652  [Paladin]
turnin     The Tome of Valor (Part 4)            #1652  [Paladin]
           Back in the Cathedral of Light, Stormwind

accept     Devourer of Souls                     #1716  [Warlock]
           Mage Quarter in Stormwind
boat       Theramore Isle                        [Warlock]
           Fly to Menethil Harbor, take the boat on the south dock
zone: The Barrens
turnin     Devourer of Souls                     #1716  @49.3,57.1  [Warlock]
           Follow the road west into the Barrens, then north
accept     Heartswood                            #1738  [Warlock]
flightpath Get the Ratchet flightpoint           @62,37  [Warlock]
           You'll need it later. Take the road north, then east before the Crossroads
]==]
