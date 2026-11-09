-- Searing Gorge (47-48) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Searing Gorge (47-48)
route:    Horde
faction:  Horde
levels:   47-48
zone:     Searing Gorge
next:     Swamp of Sorrows (48-49)

fly        Kargath
goto       Searing Gorge
           West!
accept     Caught!                                   #4449  @65,62
           Guy in the outhouse southeast of map
complete   Caught!                                   #4449  @63,61
           Geologists at the Grimesilt Dig Site
turnin     Caught!                                   #4449
accept     Ledger from Tanaris                       #4450
note       Loot the ledger                           #4450
note       Kill Glassweb Spiders                     #4450
accept     Divine Retribution                        #3441  @39,38
           Talk to Kalaran Windblade at
turnin     Divine Retribution                        #3441
           Talk to him to complete quest
accept     The Flawless Flame                        #3442

goto       Thorium Point
accept     WANTED: Overseer Maltorius                #7701
accept     STOLEN: Smithing Tuyere and Lookout's Spyglass  #7728
accept     JOB OPPORTUNITY: Culling the Competition  #7729
accept     Curse These Fat Fingers                   #7723
accept     Fiery Menace!                             #7724
accept     Incendosaurs? Whateverosaur is More Like It  #7727
accept     What the Flux?                            #7722
flightpath Flight Path

complete   Fiery Menace!                             #7724
           West side of zone
complete   Curse These Fat Fingers                   #7723
           Just south of Thorium Point
complete   STOLEN: Smithing Tuyere and Lookout's Spyglass  #7728  @39,49
           Kill Dark Iron Steamsmiths to the south and Lookouts at the towers
complete   The Flawless Flame                        #3442

turnin     The Flawless Flame                        #3442  @39,38
           At Kalaran Windblade
accept     Forging the Shaft                         #3443

complete   JOB OPPORTUNITY: Culling the Competition  #7729  @41,54
           Head down into the cauldren. Enter the second cave from the west end. Keep working
           your way towards the exit.
complete   Forging the Shaft                         #3443
complete   Incendosaurs? Whateverosaur is More Like It  #7727  @51,36
           Jump down after the bridge over the lava, you'll find dino in the big room to the
           north Grind here for a while if you want.

accept     The Key to Freedom                        #4451  use:11818  optional
turnin     The Key to Freedom                        #4451  optional
           Back at the outhouse!

turnin     Forging the Shaft                         #3443
accept     The Flame's Casing                        #3452

goto       Thorium Point
turnin     Fiery Menace!                             #7724
turnin     Curse These Fat Fingers                   #7723
turnin     WANTED: Overseer Maltorius                #7701
turnin     STOLEN: Smithing Tuyere and Lookout's Spyglass  #7728
turnin     JOB OPPORTUNITY: Culling the Competition  #7729
           SE of Thorium, just east of prev quest
turnin     Incendosaurs? Whateverosaur is More Like It  #7727

complete   The Flame's Casing                        #3452  @24,36
           Around kill til item drops
turnin     The Flame's Casing                        #3452  @39,38
           Kalaran Windblade
accept     The Torch of Retribution (Part 1)         #3453
complete   The Torch of Retribution (Part 1)         #3453
turnin     The Torch of Retribution (Part 1)         #3453
accept     The Torch of Retribution (Part 2)         #3454
complete   The Torch of Retribution (Part 2)         #3454
           Just pick up the torch on the ground
turnin     The Torch of Retribution (Part 2)         #3454
accept     Squire Maltrake                           #3462
turnin     Squire Maltrake                           #3462
accept     Set Them Ablaze!                          #3463
complete   Set Them Ablaze!                          #3463  @33,54
           north= south=(44,61) east=(50,54) west=(35,60)
turnin     Set Them Ablaze!                          #3463
accept     Trinkets...                               #3481  @38,38
           click on the chest on the ground
turnin     Trinkets...                               #3481
           Click on the chest again
note       [Black Dragonflight Molt]
           Keep in inventory for later
note       [Solid Crystal Leg Shafts]                loot:11725x20
           Have 20x Shafts for later

goto       Burning Steppes
           You have to go through Black Rock Mountain, SW of map
zone: Burning Steppes
flightpath Flight Path                               @65,25
           at
]==]
