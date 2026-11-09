-- Dun Morogh (1-11) - Alliance route - generated from data/starters.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Dun Morogh (1-11)
route:    Alliance
faction:  Alliance
levels:   1-11
zone:     Dun Morogh
next:     Darkshore (12-17)
races:    Dwarf, Gnome

accept     Dwarven Outfitters                       #179
complete   Dwarven Outfitters                       #179
turnin     Dwarven Outfitters                       #179

accept     Encrypted Rune                           #3109  [Rogue]  [Dwarf]
accept     Etched Rune                              #3108  [Hunter]  [Dwarf]
accept     Hallowed Rune                            #3110  [Priest]  [Dwarf]
accept     Simple Rune                              #3106  [Warrior]  [Dwarf]
accept     Consecrated Rune                         #3107  [Paladin]  [Dwarf]

accept     Tainted Memorandum                       #3115  [Warlock]  [Gnome]
accept     Glyphic Memorandum                       #3114  [Mage]  [Gnome]
accept     Encrypted Memorandum                     #3113  [Rogue]  [Gnome]
accept     Simple Memorandum                        #3112  [Warrior]  [Gnome]

accept     Coldridge Valley Mail Delivery (Part 1)  #233
accept     A New Threat                             #170
complete   A New Threat                             #170
turnin     A New Threat                             #170

turnin     Encrypted Rune                           #3109  [Rogue]  [Dwarf]
turnin     Etched Rune                              #3108  [Hunter]  [Dwarf]
turnin     Hallowed Rune                            #3110  [Priest]  [Dwarf]
turnin     Simple Rune                              #3106  [Warrior]  [Dwarf]
turnin     Consecrated Rune                         #3107  [Paladin]  [Dwarf]

turnin     Tainted Memorandum                       #3115  [Warlock]  [Gnome]
turnin     Glyphic Memorandum                       #3114  [Mage]  [Gnome]
turnin     Encrypted Memorandum                     #3113  [Rogue]  [Gnome]
turnin     Simple Memorandum                        #3112  [Warrior]  [Gnome]

accept     A Refugee's Quandary                     #3361

turnin     Coldridge Valley Mail Delivery (Part 1)  #233
accept     Coldridge Valley Mail Delivery (Part 2)  #234
accept     The Boar Hunter                          #183
complete   The Boar Hunter                          #183
turnin     The Boar Hunter                          #183

turnin     Coldridge Valley Mail Delivery (Part 2)  #234
accept     The Troll Cave                           #182
accept     Scalding Mornbrew Delivery               #3364
turnin     Scalding Mornbrew Delivery               #3364  @28.8,66.4
           Run back to Anvilmar
accept     Bring Back the Mug                       #3365

accept     Beginnings                               #1599  [Warlock]
complete   Beginnings                               #1599  @27.5,80  [Warlock]
turnin     Beginnings                               #1599  [Warlock]

turnin     Bring Back the Mug                       #3365
complete   A Refugee's Quandary                     #3361  @26.3,79.3
           At the troll camps to the southwest. Bucket, Chest (22.8, 78), Box (20.9, 76.1)
complete   The Troll Cave                           #182
turnin     The Troll Cave                           #182
accept     The Stolen Journal                       #218
complete   The Stolen Journal                       #218  @31,80
           Back of the cave, lower level
turnin     The Stolen Journal                       #218
accept     Senir's Observations (Part 1)            #282

turnin     A Refugee's Quandary                     #3361
           Back in Anvilmar.
turnin     Senir's Observations (Part 1)            #282  @33.5,71.8
           East of Anvilmar
accept     Senir's Observations (Part 2)            #420
accept     Supplies to Tannok                       #2160
accept     In Favor of the Light                    #5626  [Priest]

goto       Kharanos                                 #420
           You should be able to just run thru the tunnel.
turnin     Senir's Observations (Part 2)            #420
accept     Beer Basted Boar Ribs                    #384
turnin     Supplies to Tannok                       #2160
sethearth  Thunderbrew Distillery                   #320
accept     Tools for Steelgrill                     #400

turnin     In Favor of the Light                    #5626  [Priest]
accept     Garments of the Light                    #5625  [Priest]
complete   Garments of the Light                    #5625  @45.8,54.6  [Priest]
           South of town
accept     Flintfire's Shipment                     #98321  @45.2,52  forever
           Tognus Flintfire
complete   Flintfire's Shipment                     #98321  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Flintfire's Shipment                     #98321  @45.2,52  forever
           Tognus Flintfire
accept     Dawn in the Mountains                    #99158  @47.2,52.2  forever
           Maxan Anvol
turnin     Garments of the Light                    #5625  [Priest]

turnin     Tools for Steelgrill                     #400  @50.4,49.1
           Northeast of Kharanos
turnin     Dawn in the Mountains                    #99158  @57.6,44.8  forever
           Father Gavin
accept     Finding Warmth                           #99159  @57.6,44.8  forever
           Father Gavin
complete   Finding Warmth                           #99159  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Finding Warmth                           #99159  @57.6,44.8  forever
           Father Gavin
accept     Rime's Wrath                             #99160  @57.6,44.8  forever
           Father Gavin
complete   Rime's Wrath                             #99160  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Rime's Wrath                             #99160  @57.6,44.8  forever
           Father Gavin
accept     Rime's Wrath (Part 2)                    #99161  @57.6,44.8  forever
           Father Gavin
complete   Rime's Wrath (Part 2)                    #99161  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Rime's Wrath (Part 2)                    #99161  @57.6,44.8  forever
           Father Gavin
accept     Treacherous Cold                         #99162  @57.6,44.8  forever
           Father Gavin
complete   Treacherous Cold                         #99162  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Treacherous Cold                         #99162  @57.6,44.8  forever
           Father Gavin
accept     Never Saddle on Quality                  #95212  @63,49.8  forever
           Rudra Amberstill
complete   Never Saddle on Quality                  #95212  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Never Saddle on Quality                  #95212  @63,49.8  forever
           Rudra Amberstill
accept     Ammo for Rumbleshot                      #5541
accept     The Grizzled Den                         #313
accept     Stocking Jetsteam                        #317

complete   Ammo for Rumbleshot                      #5541  @44.1,56.9
           Open the crate
accept     Secure the Mountain                      #98319  @44,57  forever
           Mountaineer Gretchen
complete   Secure the Mountain                      #98319  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Secure the Mountain                      #98319  @44,57  forever
           Mountaineer Gretchen
accept     Secure the Mountain (Part 2)             #98322  @46.6,53.8  forever
           Senir Whitebeard
turnin     Secure the Mountain (Part 2)             #98322  @44,57  forever
           Mountaineer Gretchen
accept     Secure the Mountain (Part 3)             #98323  @44,57  forever
           Mountaineer Gretchen
turnin     Secure the Mountain (Part 3)             #98323  @46.6,53.8  forever
           Senir Whitebeard
complete   The Grizzled Den                         #313  @42.5,54.4
           Southwest of Kharanos
turnin     Ammo for Rumbleshot                      #5541  @40.7,65.1
           South of Kharanos

goto       Brewnall Village                         #310  @30.3,46.3
           Go northwest, near the frozen lake
accept     Frosthowl                                #98326  @31.4,44.6  forever
           Gretta Ganter
complete   Frosthowl                                #98326  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Frosthowl                                #98326  @31.4,44.6  forever
           Gretta Ganter
accept     The Perfect Stout                        #315
accept     Bitter Rivals                            #310
complete   The Perfect Stout                        #315  @38,36
           Northeast across the lake

complete   Stocking Jetsteam                        #317
           Go southeast towards Kharanos to find more mobs.
kill       Boars                                    #384  loot:2886x6
           For [Crag Boar Rib] x6.

turnin     The Grizzled Den                         #313
           At Steelgrill's Depot, east of Kharanos.
turnin     Stocking Jetsteam                        #317
accept     Evershine                                #318

buy        [Rhapsody Malt]                          #384  loot:2894
           From innkeeper or general supplier in Kharanos's inn.
buy        [Thunder Ale]                            #310  loot:2686
turnin     Bitter Rivals                            #310
           Give the Thunder Ale to Jarven downstairs, then talk to the barrel.
accept     Return to Marleth                        #311
turnin     Beer Basted Boar Ribs                    #384
accept     Frostmane Hold                           #287
           He's a little south of the inn.
accept     Operation Recombobulation                #412  @45.8,49.4
           In a house a bit northwest of the inn

turnin     Evershine                                #318
           At Brewnall Village
accept     A Favor for Evershine                    #319
turnin     The Perfect Stout                        #315
accept     Shimmer Stout                            #413
turnin     Return to Marleth                        #311

complete   Frostmane Hold                           #287  @21,51
           Go southwest, into the back of the cave to complete
complete   Operation Recombobulation                #412
           The green leper gnomes near the moving cog objects.
complete   A Favor for Evershine                    #319  @28,48.5
           A bit west of Brewnall Village
turnin     A Favor for Evershine                    #319
accept     Return to Bellowfiz                      #320

accept     Tundra MacGrann's Stolen Stash           #312  @34.6,51.6
           South of Brewnall, reach him from the southern part of the hill.
complete   Tundra MacGrann's Stolen Stash           #312
           Wait until Old Icebeard leaves his cave and then run in to loot the chest.
turnin     Tundra MacGrann's Stolen Stash           #312

hearth     Kharanos                                 #320
turnin     Frostmane Hold                           #287
accept     The Reports                              #291
turnin     Operation Recombobulation                #412
turnin     Return to Bellowfiz                      #320
           Northeast of Kharanos.

accept     Taming the Beast (Part 1)                #6064  [Hunter]
complete   Taming the Beast (Part 1)                #6064  [Hunter]
turnin     Taming the Beast (Part 1)                #6064  [Hunter]
accept     Taming the Beast (Part 2)                #6084  [Hunter]
complete   Taming the Beast (Part 2)                #6084  [Hunter]
turnin     Taming the Beast (Part 2)                #6084  [Hunter]
accept     Taming the Beast (Part 3)                #6085  [Hunter]
complete   Taming the Beast (Part 3)                #6085  [Hunter]
turnin     Taming the Beast (Part 3)                #6085  [Hunter]
accept     Training the Beast                       #6086  [Hunter]

accept     Speak with Bink                          #1879  [Mage]
accept     Road to Salvation                        #2218  [Rogue]
accept     Muren Stormpike                          #1679  [Warrior]

goto       City of Ironforge                        #291
zone: Ironforge
turnin     The Reports                              #291  @39.6,57.1
           The High Seat
accept     Data Hoarders                            #95041  @67.8,43.8  forever
           Jemma Quikswitch
complete   Data Hoarders                            #95041  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Data Hoarders                            #95041  @67.8,43.8  forever
           Jemma Quikswitch

turnin     Training the Beast                       #6086  [Hunter]

turnin     Speak with Bink                          #1879  [Mage]
accept     Mage-tastic Gizmonitor                   #1880  [Mage]
goto       Dun Morogh                               [Mage]
zone: Dun Morogh
complete   Mage-tastic Gizmonitor                   #1880  @27.7,36.4  [Mage]
turnin     Mage-tastic Gizmonitor                   #1880  [Mage]

turnin     Road to Salvation                        #2218  [Rogue]
accept     Simple Subterfugin'                      #2238  [Rogue]
goto       Dun Morogh                               [Rogue]
turnin     Simple Subterfugin'                      #2238  @25.2,44.4  [Rogue]
accept     Onin's Report                            #2239  [Rogue]
turnin     Onin's Report                            #2239  [Rogue]

turnin     Muren Stormpike                          #1679  [Warrior]
accept     Vejrek                                   #1678  [Warrior]
goto       Dun Morogh                               [Warrior]
complete   Vejrek                                   #1678  @27.7,57.7  [Warrior]
turnin     Vejrek                                   #1678  [Warrior]
accept     Tormus Deepforge                         #1680  [Warrior]
turnin     Tormus Deepforge                         #1680  [Warrior]
accept     Ironband's Compound                      #1681  [Warrior]
goto       Dun Morogh                               [Warrior]
complete   Ironband's Compound                      #1681  @77.9,62.2  [Warrior]
accept     Stolen Blasting Powder                   #95214  @69,54.8  forever
           Quarrymaster Thesten
complete   Stolen Blasting Powder                   #95214  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Stolen Blasting Powder                   #95214  @69,54.8  forever
           Quarrymaster Thesten
accept     The Quarry's Smith                       #95217  @68.8,55.8  [Warrior, Paladin, Shaman]  forever
           Frast Dokner
complete   The Quarry's Smith                       #95217  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     The Quarry's Smith                       #95217  @68.8,55.8  [Warrior, Paladin, Shaman]  forever
           Frast Dokner
accept     Nip 'Em in the Bud                       #96390  @64.8,58.4  forever
           Earthseer Farsen
complete   Nip 'Em in the Bud                       #96390  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Nip 'Em in the Bud                       #96390  @64.8,58.4  forever
           Earthseer Farsen
accept     Farsen's Watch                           #96392  @64.8,58.4  forever
           Earthseer Farsen
complete   Farsen's Watch                           #96392  forever  unverified
           Do what the quest asks (no objective data for this Forever quest yet: follow the
           quest text)
turnin     Farsen's Watch                           #96392  @64.8,58.4  forever
           Earthseer Farsen
accept     A Visitor to Dun Morogh                  #96408  @50.4,49  forever
           Beldin Steelgrill
turnin     A Visitor to Dun Morogh                  #96408  @64.8,58.4  forever
           Earthseer Farsen
turnin     Ironband's Compound                      #1681  [Warrior]

note       Forever extras                           optional  forever
           New Forever quests in this zone, givers not yet in the database: Underground Map
           (15); The Treaty of Understanding (16)
]==]
