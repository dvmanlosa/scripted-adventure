-- Tirisfal Glades (1-12) - Horde route - generated from data/starters.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Tirisfal Glades (1-12)
route:    Horde
faction:  Horde
levels:   1-12
zone:     Tirisfal Glades
next:     The Barrens (12-15)
races:    Undead

accept     Rude Awakening                            #363
           The guy right outside of the starting crypt
turnin     Rude Awakening                            #363
           Right down the hill
accept     The Mindless Ones                         #364
accept     Piercing the Veil                         #1470  [Warlock]
complete   The Mindless Ones                         #364
complete   Piercing the Veil                         #1470  [Warlock]
turnin     The Mindless Ones                         #364
turnin     Piercing the Veil                         #1470  [Warlock]

accept     Rattling the Rattlecages                  #3901
accept     The Damned                                #376
accept     Encrypted Scroll                          #3096  [Rogue]
accept     Tainted Scroll                            #3099  [Warlock]
turnin     Encrypted Scroll                          #3096  [Rogue]
turnin     Tainted Scroll                            #3099  [Warlock]

complete   The Damned                                #376
complete   Rattling the Rattlecages                  #3901

turnin     Rattling the Rattlecages                  #3901
turnin     The Damned                                #376
accept     Marla's Last Wish                         #6395
accept     Night Web's Hollow                        #380
accept     Scavenging Deathknell                     #3902

complete   Night Web's Hollow                        #380  @27.5,58
           Cave to the north
kill       Samuel Fipps                              @36,62  loot:16333
           Take the road north, then east. Samuel's in a little camp just south of the road
complete   Scavenging Deathknell                     #3902
           Boxes all over Deathknell
complete   Marla's Last Wish                         #6395  @31.2,65
           Bury Samuel's remains at Marla's Grave

turnin     Scavenging Deathknell                     #3902
turnin     Night Web's Hollow                        #380
accept     The Scarlet Crusade                       #381
turnin     Marla's Last Wish                         #6395

complete   The Scarlet Crusade                       #381  @36,67.5
           In a camp east of town
turnin     The Scarlet Crusade                       #381
accept     The Red Messenger                         #382
complete   The Red Messenger                         #382  @36.5,68.8
           Kill Meven Korgal at the camp
turnin     The Red Messenger                         #382
accept     Vital Intelligence                        #383
accept     A Rogue's Deal (Part 1)                   #8
           On the way out of Deathknell
accept     Fields of Grief (Part 1)                  #365
accept     Gordo's Task                              #5481
           Along the road to Brill

goto       Brill
accept     A Putrid Task                             #404
accept     A New Plague (Part 1)                     #367
           In the house near the herbalism trainer, this quest requires level 6.
turnin     Vital Intelligence                        #383
accept     At War With The Scarlet Crusade (Part 1)  #427
accept     Wanted: Maggot Eye                        #398
accept     Graverobbers                              #358
turnin     A Rogue's Deal (Part 1)                   #8
sethearth  Gallows' End Tavern

complete   Gordo's Task                              #5481
           Pick weeds, all over the area between Deathknell and Brill.
complete   A Putrid Task                             #404
           Kill rotting dead and ravaged corpses west of Brill.

turnin     A Putrid Task                             #404
accept     The Mills Overrun                         #426
turnin     Gordo's Task                              #5481
           Wandering around in the graveyard
accept     Doom Weed                                 #5482

complete   Graverobbers                              #358
           Mongrels are at Garren's Haunt, graverobbers to the south.
complete   Doom Weed                                 #5482
complete   Wanted: Maggot Eye                        #398  @58.7,31.7
           In the house at the north end of Garren's Haunt
complete   A New Plague (Part 1)                     #367
           You can find a bunch on the hill southwest of Brill.

turnin     Wanted: Maggot Eye                        #398
turnin     Graverobbers                              #358
accept     Forsaken Duties                           #359
accept     The Prodigal Lich                         #405
turnin     A New Plague (Part 1)                     #367
accept     A New Plague (Part 2)                     #368
turnin     Doom Weed                                 #5482

complete   Fields of Grief (Part 1)                  #365  @35,50
           At the farm north of Deathknell
complete   At War With The Scarlet Crusade (Part 1)  #427
           West of the farm.
complete   A New Plague (Part 2)                     #368  @60,29
           Along the shore. Murlocs.... joy.

hearth     Brill
accept     Deaths in the Family                      #354
accept     The Haunted Mills                         #362
accept     The Chill of Death                        #375  @61.9,52.6
           Upstairs in the inn
turnin     At War With The Scarlet Crusade (Part 1)  #427
accept     At War With The Scarlet Crusade (Part 2)  #370
accept     Proof of Demise                           #374
turnin     Fields of Grief (Part 1)                  #365
accept     Fields of Grief (Part 2)                  #407
turnin     A New Plague (Part 2)                     #368
accept     A New Plague (Part 3)                     #369

complete   The Mills Overrun                         #426
           At Agamand Mills
complete   The Haunted Mills                         #362  @47.3,40.8
           He is at
complete   Deaths in the Family                      #354  @49.7,36.3
           These are at (46.74,29.31) (44,33.64)

die        Die
           Take Rez Sickness
turnin     The Mills Overrun                         #426
accept     A Letter Undelivered                      #361  use:2839  optional
turnin     Deaths in the Family                      #354
turnin     The Haunted Mills                         #362
accept     Speak with Sevren                         #355
turnin     A Letter Undelivered                      #361  optional
turnin     Fields of Grief (Part 2)                  #407
           Downstairs in the inn

accept     Halgar's Summons                          #1478  [Warlock]

turnin     Speak with Sevren                         #355
accept     The Family Crypt                          #408
complete   The Chill of Death                        #375
           Work your way north from town killing greater duskbats near the road.
buy        [Coarse Thread]                           loot:2320
           Just one is required
turnin     The Chill of Death                        #375

goto       Undercity
turnin     Halgar's Summons                          #1478  [Warlock]
accept     Creature of the Void                      #1473  [Warlock]
turnin     The Prodigal Lich                         #405
           In the magic quarter

complete   At War With The Scarlet Crusade (Part 2)  #370
           Leave Undercity through the sewers and you'll end up near the mobs for this quest.
complete   Creature of the Void                      #1473  @51,67  [Warlock]
           Loot the chest at
turnin     Creature of the Void                      #1473  [Warlock]
accept     The Binding                               #1471  [Warlock]
complete   The Binding                               #1471  [Warlock]
turnin     The Binding                               #1471  [Warlock]

turnin     At War With The Scarlet Crusade (Part 2)  #370
           Back in Brill. Hearth if you can.
accept     At War With The Scarlet Crusade (Part 3)  #371
turnin     Forsaken Duties                           #359  @65.5,60
           Southeast of Brill at the campfire
accept     Return to the Magistrate                  #360
accept     Rear Guard Patrol                         #356
complete   Rear Guard Patrol                         #356  @75,60
           At the farm further east down the road.
complete   At War With The Scarlet Crusade (Part 3)  #371
complete   A New Plague (Part 3)                     #369

turnin     Rear Guard Patrol                         #356
turnin     At War With The Scarlet Crusade (Part 3)  #371
accept     At War With The Scarlet Crusade (Part 4)  #372
turnin     A New Plague (Part 3)                     #369
accept     A New Plague (Part 4)                     #492
accept     Delivery to Silverpine Forest             #445

complete   The Family Crypt                          #408
           At Agamand Mills

die        Die
           Take Rez Sickness
turnin     Return to the Magistrate                  #360
turnin     The Family Crypt                          #408
turnin     A New Plague (Part 4)                     #492
complete   At War With The Scarlet Crusade (Part 4)  #372  @79.5,25.1
           You can find him at
complete   Proof of Demise                           #374

turnin     At War With The Scarlet Crusade (Part 4)  #372
           Back in Brill. Hearth if you can.
turnin     Proof of Demise                           #374

fly        Orgrimmar
           Take the zeppelin outside Undercity
flightpath Grab flight point
]==]
