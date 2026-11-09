-- Hillsbrad Foothills (31-32) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Hillsbrad Foothills (31-32)
route:    Alliance
faction:  Alliance
levels:   31-32
zone:     Hillsbrad Foothills
next:     Desolace (33-34)

zone: Arathi Highlands
goto       Refuge Pointe                     #634  @44.5,49.3
           In Arathi Highlands
turnin     Plea To The Alliance              #634

zone: Hillsbrad Foothills
goto       Southshore                        #564  @50.8,51.2
           In Hillsbrad Foothills
turnin     The Shamed Lieutenant             #98219  @51.4,58.4  forever
           Lieutenant Farren Orinelle
note       Syndicate Sabotage                [Rogue]  forever
           New rogue chain (24-36) around Alterac and Ravenholdt; giver not yet in the database
turnin     Southshore                        #538  optional
sethearth  Southshore                        #525
accept     Down the Coast                    #536
accept     Soothing Turtle Bisque            #555
accept     Bartolo's Yeti Fur Cloak          #565
accept     Costly Menace                     #564
accept     Syndicate Assassins               #505

complete   Tome of the Cabal (Part 2)        #1802  @27.7,72.8  [Warlock]  loot:6931
           Get the Moldy Tome, on the beach west of Southshore

complete   Down the Coast                    #536
           On beach west of Southshore
turnin     Down the Coast                    #536
accept     Farren's Proof (Part 1)           #559
complete   Farren's Proof (Part 1)           #559
           Murlocs, again, ugh
turnin     Farren's Proof (Part 1)           #559
accept     Farren's Proof (Part 2)           #560
turnin     Farren's Proof (Part 2)           #560
accept     Farren's Proof (Part 3)           #561
turnin     Farren's Proof (Part 3)           #561
accept     Stormwind Ho!                     #562
complete   Stormwind Ho!                     #562
           On beach east of Southshore
turnin     Stormwind Ho!                     #562
accept     Reassignment                      #563

note       Kill turtles                      #555  loot:3712x10
           All along the creek. Need [Turtle Meat] x10 for "Soothing Turtle Bisque"

zone: Alterac Mountains
accept     Encrypted Letter (Part 2)         #511  @58,67
           Take the road north from the tower to the edge of the Alterac Mountains, then east.
           Examine documents on the table in the camp to the east
accept     Foreboding Plans                  #510
           Examine documents on the table in the camp
complete   Syndicate Assassins               #505
           On this plateau and the next one to the west
complete   Costly Menace                     #564  @46,81
           West on another plateau

zone: Hillsbrad Foothills
note       Kill yetis                        #565  @45.6,31.4  loot:3720x10
           In the yeti cave. Need [Yeti Fur] x10 for "Bartolo's Yeti Fur Cloak".

turnin     Encrypted Letter (Part 2)         #511
accept     Letter to Stormpike               #514
turnin     Syndicate Assassins               #505
turnin     Foreboding Plans                  #510
           Skip the follow-up
turnin     Soothing Turtle Bisque            #555
turnin     Costly Menace                     #564

fly        Menethil Harbor                   #293
turnin     The Eye of Paleth                 #292
accept     Cleansing the Eye                 #293

fly        City of Ironforge                 #514
turnin     Letter to Stormpike               #514
accept     Further Mysteries                 #525
turnin     Tome of the Cabal (Part 2)        #1802  [Warlock]
           Hall of Explorers
accept     Tome of the Cabal (Part 3)        #1804  [Warlock]
           Hall of Explorers
accept     Reclaimers' Business in Desolace  #1453
           From Roetten Stonehammer who walks around nearby
accept     In Search of Menara Voidrender    #4737  @50.2,6.2  [Warlock]
           In The Forlorn Cavern

fly        Stormwind City                    #293
zone: Stormwind City
turnin     Reassignment                      #563  @76.7,38.1
           In Stormwind Keep
turnin     Cleansing the Eye                 #293  @49.9,45.3
           In Stormwind Cathedral
accept     Brother Anton                     #6141  optional
           Downstairs in Stormwind Cathedral. Needs level 34: skip it if you can't take it yet
buy        Hillman's Cloak                   #565  loot:3719
           Buy from auction or a leatherworker. If you can't find one, skip buying the other
           items and the quest "Bartolo's Yeti Fur Cloak".
buy        Bolt of Woolen Cloth              #565  loot:2997
           Buy from auction or a tailor.

hearth     Southshore                        #525
zone: Hillsbrad Foothills
buy        Fine Thread                       #565  @49,55.1  loot:2321
           From vendor in Southshore. Skip if you couldn't find a Hillman's Cloak.
turnin     Bartolo's Yeti Fur Cloak          #565
turnin     Further Mysteries                 #525
           Skip the follow-up

fly        Menethil Harbor                   [Warlock]
zone: Wetlands
complete   Tome of the Cabal (Part 3)        #1804  @47,47  [Warlock]
           Kill Dragonmaw Bonewarders and Shadowwarders to the east

fly        Ratchet                           [Warlock]
           Boat to Theramore Isle and fly down
turnin     In Search of Menara Voidrender    #4737  [Warlock]
turnin     Tome of the Cabal (Part 3)        #1804  [Warlock]
zone: Hillsbrad Foothills
accept     The Binding                       #1795  @62.6,35.5  [Warlock]
           Ratchet
complete   The Binding                       #1795  [Warlock]  use:6999
turnin     The Binding                       #1795  [Warlock]

note       Forever extras                    optional  forever
           New Forever quests in this zone, givers not yet in the database: Hillsbrad's Hoard
           (27); Brewer's Trade (27)
]==]
