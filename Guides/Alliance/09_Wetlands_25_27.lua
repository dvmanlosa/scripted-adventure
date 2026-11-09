-- Wetlands (25-27) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Wetlands (25-27)
route:    Alliance
faction:  Alliance
levels:   25-27
zone:     Wetlands
next:     Redridge Mountains (27-28)

fly        Auberdine                                 #741
turnin     WANTED: Murkdeep!                         #4740
turnin     The Absent Minded Prospector (Part 2)     #731
accept     The Absent Minded Prospector (Part 3)     #741
fly        Darnassus                                 #741
zone: Darnassus
turnin     The Absent Minded Prospector (Part 3)     #741  @31.4,84.2
           Outside the Temple of the Moon, Darnassus
accept     The Absent Minded Prospector (Part 4)     #942

fly        Loch Modan                                #455
           Boat to Stormwind, then fly to Loch Modan.
zone: Loch Modan
accept     The Algaz Gauntlet                        #455  @25.4,10.4
           North at North Gate Pass
complete   The Algaz Gauntlet                        #455

goto       Menethil Harbor                           #455
accept     Claws from the Deep                       #279
accept     Young Crocolisk Skins                     #484
turnin     The Algaz Gauntlet                        #455
           In the keep
accept     War Banners                               #464
           Upstairs
accept     Digging Through the Ooze                  #470
accept     The Third Fleet                           #288
accept     The Greenwarden                           #463
sethearth  Deepwater Tavern                          #286
complete   The Third Fleet                           #288
           Buy a flagon of mead from the innkeeper
turnin     The Absent Minded Prospector (Part 4)     #942
           Upstairs in the inn
accept     The Absent Minded Prospector (Part 5)     #943
turnin     The Third Fleet                           #288
accept     The Cursed Crew                           #289
accept     In Search of The Excavation Team (Part 1)  #305
           On your way out of town

note       Kill young crocs...                       #484
           Kill any Young Crocolisks you come across for "Young Crocolisk Skins"
complete   Claws from the Deep                       #279

zone: Wetlands
turnin     In Search of The Excavation Team (Part 1)  #305  @38.8,52.3
           At Whelgar's Excavation Site
accept     In Search of The Excavation Team (Part 2)  #306
accept     Ormer's Revenge (Part 1)                  #294
note       Get the fossil                            #943  loot:5234
           For "The Absent Minded Prospector (Part 5)"

complete   Ormer's Revenge (Part 1)                  #294  @30,45
           Outside the excavation site to the west
turnin     Ormer's Revenge (Part 1)                  #294
accept     Ormer's Revenge (Part 2)                  #295
accept     Uncovering the Past                       #299
note       Keep an eye out for relics                #299
complete   Uncovering the Past                       #299
           If you can't find the Neru Fragment (loose dirt), check the tree near the ramp up to
           the questgiver. If you can't find the Modr Fragment (tall vase), check up on the
           ledge to the west-southwest side of the dig.
complete   Ormer's Revenge (Part 2)                  #295
turnin     Ormer's Revenge (Part 2)                  #295
accept     Ormer's Revenge (Part 3)                  #296
complete   Ormer's Revenge (Part 3)                  #296
turnin     Uncovering the Past                       #299
turnin     Ormer's Revenge (Part 3)                  #296

complete   The Absent Minded Prospector (Part 5)     #943
           Keep killing raptors

complete   War Banners                               #464  @42.9,41.1
           East of Excavation Site
accept     Daily Delivery                            #469  @49.9,39.4
           North of the Angerfang Encampment at the fork in the road
turnin     The Greenwarden                           #463  @56.3,40.3
           East of the fork
accept     Tramping Paws                             #276
complete   Tramping Paws                             #276  @56,74
           Camps far south near Dun Algaz (61,75)
turnin     Tramping Paws                             #276
accept     Fire Taboo                                #277
complete   Fire Taboo                                #277
complete   Young Crocolisk Skins                     #484
turnin     Fire Taboo                                #277
accept     Blisters on The Land                      #275

hearth     Menethil Harbor                           #286
turnin     The Absent Minded Prospector (Part 5)     #943
           Inn, upstairs
turnin     Claws from the Deep                       #279
accept     Reclaiming Goods                          #281
turnin     Young Crocolisk Skins                     #484
accept     Apprentice's Duties                       #471
turnin     Daily Delivery                            #469
turnin     War Banners                               #464
           In the keep
accept     Nek'rosh's Gambit                         #465
turnin     In Search of The Excavation Team (Part 2)  #306
           On your way out of town

note       Kill stealth elementals...                #275
           Kill any Fen Creepers you come across for "Blisters on The Land". They stealth and
           follow the shallow waters in the west half of the zone.

turnin     Reclaiming Goods                          #281  @13.5,41.4
           Damaged Crate at the murloc camp north of Menethil Harbor
accept     The Search Continues                      #284
turnin     The Search Continues                      #284
           Sealed Barrel at the next murloc camp to the north
accept     Search More Hovels                        #285
turnin     Search More Hovels                        #285
           Half-buried Barrel at the next murloc camp to the north
accept     Return the Statuette                      #286

complete   The Cursed Crew                           #289  @13,30
           On the southern shipwreck. Snellig is in the bottom of the ship, you can enter thru a
           hole on the side nearest the shore.
complete   Apprentice's Duties                       #471  @19,59
           North of the murloc camps and east of Menethil Harbor (25,22). Kill giant crocs near
           the shore, normal ones don't drop the item.
complete   Blisters on The Land                      #275
           Just run around in the water, they stealth.
complete   Digging Through the Ooze                  #470  @44,25
           Around Ironbeard's Tomb

turnin     Blisters on The Land                      #275

hearth     Menethil Harbor                           #286
turnin     The Cursed Crew                           #289
accept     Lifting the Curse                         #290
turnin     Digging Through the Ooze                  #470
turnin     Apprentice's Duties                       #471
turnin     Return the Statuette                      #286
accept     A Friend of the Family                    #98190  @9.8,57.4  forever
           Captain Stoutfist; turns in at Stormwind

note       Forever extras                            optional  forever
           New Forever quests in this zone, givers not yet in the database: Your Package Has
           Arrived (2); A Lack of Virtue (21); Unrequited Love (21); Spoils of War (22);
           Alchemical Hazards (22); Crocs of the Sky (27); From the Ashes (28); Bloom of the
           Heavens (29); This Land Was Their Land (29); Crimson Crate Delivery (29); Razormaw
           Needling (29); Trying Times (29); Spark of Freedom (30); Carnage (30); Death to the
           Dragonmaw (30); Forced Disarmament (30)
]==]
