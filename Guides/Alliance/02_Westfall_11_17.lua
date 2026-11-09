-- Westfall (11-17) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Westfall (11-17)
route:    Alliance
faction:  Alliance
levels:   11-17
zone:     Westfall
next:     Darkshore (12-17)

goto       Westfall                                  forever
           Follow the road west out of Elwynn
turnin     Furlbrow's Deed                           #184  optional
           Only if a Westfall Deed dropped for you in Elwynn
accept     The Forgotten Heirloom                    #64  @60,19.4
           Farmer Furlbrow
accept     Westfall Stew                             #36  @59.9,19.4
           Verna Furlbrow
accept     Poor Old Blanchy                          #151
accept     The Killing Fields                        #9  @56,31.2
           Farmer Saldean, south along the road
accept     Report to Gryan Stoutmantle               #109
turnin     Westfall Stew                             #36  @56.4,30.5
           Salma Saldean in the house
accept     Westfall Stew (Part 2)                    #38
accept     Goretusk Liver Pie                        #22
accept     Harvesting the Harvesters                 #92909  @51.6,32.2  forever
           Ozwin Ironsprocket in the barn to the west

goto       Sentinel Hill
           Follow the road south to the stone tower
flightpath Sentinel Hill                             @56.5,52.6
           Thor at the bottom of the hill
turnin     Report to Gryan Stoutmantle               #109  @56.3,47.5
           Top of the tower
accept     The People's Militia                      #12
accept     Patrolling Westfall                       #102  @56.4,47.6
           Captain Danuvin
accept     Red Leather Bandanas                      #153  @54,53
           Scout Galiaan, south side of the hill
accept     Testing the Wells                         #92742  @52.4,53  forever
           Alba Fairmoon by the inn
accept     Murloc Gills                              #92744  forever
accept     The State of the Mines                    #92745  forever
accept     A Swift Message                           #6181  @57,47.2  [Human]
           Quartermaster Lewis by the tower
turnin     A Swift Message                           #6181  @56.5,52.6  [Human]
           Thor, the flight master
accept     Continue to Stormwind                     #6281  [Human]

fly        Stormwind City
zone: Stormwind City
turnin     Shipment to Stormwind                     #61  @63,74
           In the Trade District
accept     Wine Shop Advert                          #332
           In front of the Apothecary. He won't have a '!' because this is a "Low Level"
           quest... but hey, free EXP
accept     Harlan Needs a Resupply                   #333  @62.3,67.9
           North of Weller's Arsenal
sethearth  Stormwind City
turnin     Elmore's Task                             #1097  @59.7,33.8  forever
           Grimand Elmore, Dwarven District
accept     Stormpike's Delivery                      #353  forever
           Turns in at Algaz Station in Loch Modan
turnin     Wine Shop Advert                          #332  @60.2,76.8
           Outside the Trade District along the Canals
turnin     Harlan Needs a Resupply                   #333  @58,67.5
           Also along the Canals, to the north
accept     Package for Thurman                       #334
           Same person, again she won't have a '!'
turnin     Package for Thurman                       #334  @52.5,83.5
           In the Mage Quarter at Larson Clothiers

turnin     Speak with Jennea                         #1860  [Mage]  [Human]
           In the Mage Quarter
accept     Mirror Lake                               #1861  [Mage]  [Human]
note       Confounding Flash and Divine Grace        [Priest]  forever
           New level 10 priest quest chains; ask your trainer in the Cathedral

turnin     Gakin's Summons                           #1685  [Warlock]  [Human]
           In the Mage Quarter
accept     Surena Caledon                            #1688  [Warlock]  [Human]

turnin     Continue to Stormwind                     #6281  @77.1,61.1  [Human]
           In Old Town at Limited Immunity
accept     Dungar Longdrink                          #6261  [Human]

turnin     Seek out SI: 7                            #2205  [Rogue]  [Human]
           In Old Town
accept     Snatch and Grab                           #2206  [Rogue]  [Human]

turnin     A Warrior's Training                      #1638  [Warrior]  [Human]
           In Old Town
accept     Bartleby the Drunk                        #1639  [Warrior]  [Human]
turnin     Bartleby the Drunk                        #1639  [Warrior]  [Human]
accept     Beat Bartleby                             #1640  [Warrior]  [Human]
turnin     Beat Bartleby                             #1640  [Warrior]  [Human]
accept     Bartleby's Mug                            #1665  [Warrior]  [Human]
turnin     Bartleby's Mug                            #1665  [Warrior]  [Human]
accept     Marshal Haggard                           #1666  [Warrior]  [Human]

note       Get a Tome of Divinity                    [Paladin]  [Human]  loot:6775
           Go see Duthorian Rall in the Cathedral of Light
accept     The Tome of Divinity (Part 1)             #1642  [Paladin]  [Human]  use:6775
turnin     The Tome of Divinity (Part 1)             #1642  [Paladin]  [Human]
accept     The Tome of Divinity (Part 2)             #1643  [Paladin]  [Human]
turnin     The Tome of Divinity (Part 2)             #1643  [Paladin]  [Human]
           In Trade District
accept     The Tome of Divinity (Part 3)             #1644  [Paladin]  [Human]
turnin     The Tome of Divinity (Part 3)             #1644  [Paladin]  [Human]
accept     The Tome of Divinity (Part 4)             #1780  [Paladin]  [Human]
turnin     The Tome of Divinity (Part 4)             #1780  [Paladin]  [Human]
           In the Cathedral of Light
accept     The Tome of Divinity (Part 5)             #1781  [Paladin]  [Human]
turnin     The Tome of Divinity (Part 5)             #1781  [Paladin]  [Human]
accept     The Tome of Divinity (Part 6)             #1786  [Paladin]  [Human]

turnin     Dungar Longdrink                          #6261  [Human]
           Back at the flight point
accept     Return to Lewis                           #6285  [Human]

accept     The Collector                             #123  use:1307  optional
turnin     The Collector                             #123  optional
           In Goldshire

zone: Westfall
complete   Mirror Lake                               #1861  @28.6,61.4  [Mage]  [Human]  use:7207
           Directly south of Stormwind at Mirror Lake
complete   Snatch and Grab                           #2206  @48,87  [Rogue]  [Human]
           Sap & Pickpocket the Dockmaster at Jerod's Landing
complete   Surena Caledon                            #1688  @71,80  [Warlock]  [Human]
           In the house at the Brackwell Pumpkin Patch

turnin     Marshal Haggard                           #1666  @84.6,69.4  [Warrior]  [Human]
           At the Eastvale Logging Camp
accept     Dead-tooth Jack                           #1667  [Warrior]  [Human]
complete   Dead-tooth Jack                           #1667  @89.2,78.7  [Warrior]  [Human]
           To the southeast
turnin     Dead-tooth Jack                           #1667  [Warrior]  [Human]

turnin     The Tome of Divinity (Part 6)             #1786  @72.6,51.5  [Paladin]  [Human]  use:6866
           West side of the island on Stonecaire Lake in Elwynn Forest
accept     The Tome of Divinity (Part 7)             #1787  [Paladin]  [Human]
complete   The Tome of Divinity (Part 7)             #1787  [Paladin]  [Human]
           Center of island in Stonecaire Lake in Elwynn Forest

hearth     Stormwind City
turnin     Mirror Lake                               #1861  [Mage]  [Human]
turnin     Snatch and Grab                           #2206  [Rogue]  [Human]
turnin     Surena Caledon                            #1688  [Warlock]  [Human]
accept     The Binding                               #1689  [Warlock]  [Human]
complete   The Binding                               #1689  [Warlock]  [Human]  use:6928
           Summoning circle downstairs
turnin     The Binding                               #1689  [Warlock]  [Human]
turnin     The Tome of Divinity (Part 7)             #1787  [Paladin]  [Human]
           In the Cathedral of Light
accept     The Tome of Divinity (Part 8)             #1788  [Paladin]  [Human]
turnin     The Tome of Divinity (Part 8)             #1788  [Paladin]  [Human]

fly        Westfall                                  forever
           Fly back to Sentinel Hill
turnin     Return to Lewis                           #6285  @57,47.2  [Human]
           Quartermaster Lewis
sethearth  Sentinel Hill
           Bind at the Sentinel Hill inn for the rest of the zone

complete   The People's Militia                      #12  @44.8,23.1
           Defias Trappers and Smugglers around Jangolode Mine
complete   Red Leather Bandanas                      #153
           Same Defias as the Militia kills
complete   The State of the Mines                    #92745  forever
           4 Kobold Diggers inside Jangolode Mine; the Riverpaw Miners come later
complete   The Forgotten Heirloom                    #64  @49.3,19.3
           Wardrobe in the Jansen Stead house. Pull Benny Blanco away first
complete   Murloc Gills                              #92744  @53,11.3  forever
           Murlocs on the north coast; keep 3 Murloc Eyes for the stew
complete   Patrolling Westfall                       #102  @52.2,14.1
           Gnoll Paws from Riverpaw gnolls just inland
note       Testing the Wells: first sample           @56.6,18.6  forever
           Fill the sample at the well on Furlbrow's farm
complete   Poor Old Blanchy                          #151
           Handfuls of Oats from the sacks along the farm fences
turnin     The Forgotten Heirloom                    #64  @60,19.4
           Farmer Furlbrow
turnin     Poor Old Blanchy                          #151  @59.9,19.4
           Verna Furlbrow

complete   Goretusk Liver Pie                        #22  @44,39.6
           Goretusks in the fields south of Saldean's Farm
complete   Westfall Stew (Part 2)                    #38
           Vulture meat, goretusk snouts, murloc eyes and okra from Harvest Watchers
complete   Testing the Wells                         #92742  @46.1,38.2  forever
           Second sample at the Molsen Farm well
complete   The Killing Fields                        #9
           Harvest Watchers around the Molsen Farm. Keep 5 Flasks of Oil for the lighthouse
complete   Harvesting the Harvesters                 #92909  optional  forever
           Rare parts from Harvest Watchers; skip if they don't drop
complete   The State of the Mines                    #92745  @30.8,46.2  forever
           6 Riverpaw Miners at the Gold Coast Quarry
accept     Captain Sander's Hidden Treasure          #136  use:1357  optional
           Treasure map dropped by coast murlocs

turnin     The Killing Fields                        #9  @56,31.2
           Farmer Saldean
turnin     Goretusk Liver Pie                        #22  @56.4,30.5
           Salma Saldean
turnin     Westfall Stew (Part 2)                    #38
turnin     Harvesting the Harvesters                 #92909  @51.6,32.2  optional  forever
           Ozwin Ironsprocket
turnin     The People's Militia                      #12  @56.3,47.5
           Gryan Stoutmantle
accept     The People's Militia (Part 2)             #13
turnin     Patrolling Westfall                       #102
turnin     Red Leather Bandanas                      #153
turnin     Testing the Wells                         #92742  @52.4,53  forever
           Alba Fairmoon
turnin     Murloc Gills                              #92744  forever
turnin     The State of the Mines                    #92745  forever
accept     Moonbrook Espionage                       #92747  forever

complete   The People's Militia (Part 2)             #13  @45.4,70.2
           Defias Pillagers and Looters in Moonbrook
complete   Moonbrook Espionage                       #92747  forever
           Suspicious Industrial Supplies around Moonbrook
accept     Keeper of the Flame                       #103  @30,86
           Captain Grayson at the lighthouse
turnin     Keeper of the Flame                       #103
           Needs the 5 Flasks of Oil
turnin     Captain Sander's Hidden Treasure          #136  @25.9,47.8  optional
           Footlocker on the coast
accept     Captain Sander's Hidden Treasure (Part 2)  #138  optional
turnin     Captain Sander's Hidden Treasure (Part 2)  #138  @40.5,47.8  optional
           Broken Barrel
accept     Captain Sander's Hidden Treasure (Part 3)  #139  optional
turnin     Captain Sander's Hidden Treasure (Part 3)  #139  @40.6,17  optional
           Old Jug
accept     Captain Sander's Hidden Treasure (Part 4)  #140  optional
turnin     Captain Sander's Hidden Treasure (Part 4)  #140  @26,16.9  optional
           Locked Chest on the north coast
turnin     The People's Militia (Part 2)             #13  @56.3,47.5
           Gryan Stoutmantle
accept     The People's Militia (Part 3)             #14
turnin     Moonbrook Espionage                       #92747  @52.4,53  forever
           Alba Fairmoon

grind      Grind to level 16                         level:16
           The Dagger Hills Highwaymen are level 17-18. Grind or finish leftovers until 16
complete   The People's Militia (Part 3)             #14  @51.7,77.2
           Highwaymen, Pathstalkers and Knuckledusters in the Dagger Hills
turnin     The People's Militia (Part 3)             #14  @56.3,47.5
           Gryan Stoutmantle
accept     The Defias Brotherhood                    #65
accept     Explosive Consultation                    #92748  @52.4,53  forever
           Alba Fairmoon

fly        Stormwind City
zone: Stormwind City
turnin     Explosive Consultation                    #92748  @61.9,30.6  forever
           Sprite Jumpsprocket, Dwarven District
accept     A Dynamite Plan                           #92749  forever
complete   A Dynamite Plan                           #92749  forever
           Follow Sprite's instructions
turnin     A Dynamite Plan                           #92749  forever
accept     Detonation at a Distance                  #92750  forever
turnin     Detonation at a Distance                  #92750  @80.2,69.9  forever
           Jasper Fel in Old Town
accept     Detonation at a Distance (Part 2)         #92751  forever
turnin     Detonation at a Distance (Part 2)         #92751  @61.9,30.6  forever
           Back to Sprite Jumpsprocket
accept     Explosive Consultation (Part 2)           #92752  forever
           Turns in to Alba in Westfall later
accept     Collecting Memories                       #168  @70.3,40.8  dungeon:The_Deadmines
           Wilder Thistlenettle, Dwarven District
accept     Oh Brother. . .                           #167  dungeon:The_Deadmines
accept     Underground Assault                       #2040  @62.6,34.1  dungeon:The_Deadmines
           Shoni the Shilent
accept     Philmor's Favor                           #97220  @43.2,46.9  forever
           Manifest Clerk Philmor
turnin     Philmor's Favor                           #97220  @66.4,73.5  forever
           Elaine Trias, Trade District
accept     Gatehouse Goods                           #97222  forever
complete   Gatehouse Goods                           #97222  forever  unverified
           Follow the quest text; Wowhead has no objective data yet
turnin     Gatehouse Goods                           #97222  @66.4,73.5  forever
           Elaine Trias
note       Deadmines prep                            dungeon:The_Deadmines  forever
           Defias Brotherhood, Collecting Memories, Oh Brother and Underground Assault are for
           the Deadmines run after Redridge
boat       Auberdine                                 forever
           Forever adds a direct ship from Stormwind Harbor to Auberdine

note       Forever extras                            optional  forever
           New Forever quests in this zone, givers not yet in the database: My First Alchemy Set
           (10); My First Real Potion (10); Fishin' Time (12); Of Mice and Milk (15); Reading
           Room (18); Shelf Picked (18)
]==]
