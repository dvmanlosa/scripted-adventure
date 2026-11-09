-- Searing Gorge (50-51) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Searing Gorge (50-51)
route:    Alliance
faction:  Alliance
levels:   50-51
zone:     Searing Gorge
next:     Kalimdor (51)

hearth     City of Ironforge                         #3182
buy        15 Silk Cloth                             #4449  loot:4306x15
           If you don't already have them, that is

zone: Badlands
goto       Searing Gorge                             #4449  @1,62
           Fly to Thelsamar, run down through the badlands to the west edge of the zone

zone: Searing Gorge
accept     Caught!                                   #4449  @65.6,62.3
           At an outhouse
accept     Suntara Stones (Part 1)                   #3367  @63.8,60.9
           Dorf down in the dig. This is another crummy escort.
turnin     Suntara Stones (Part 1)                   #3367
accept     Suntara Stones (Part 2)                   #3368
           Read the letter he dropped

complete   Caught!                                   #4449

turnin     Caught!                                   #4449
           Back at the outhouse
note       Kill Margol the Rager                     #3181  @73,75  loot:10000
           Wanders around southeast of the outhouse
accept     The Horn of the Beast                     #3181  use:10000
           From the item he drops, of course

accept     Divine Retribution                        #3441  @39,38.9
           North of the cauldren
complete   Divine Retribution                        #3441
           Talk to him a bit
turnin     Divine Retribution                        #3441
accept     The Flawless Flame                        #3442

goto       Thorium Point                             #7722  @32,33
           Take the path to the west
accept     STOLEN: Smithing Tuyere and Lookout's Spyglass  #7728
           From the wanted sign
accept     JOB OPPORTUNITY: Culling the Competition  #7729
           From the wanted sign
accept     WANTED: Overseer Maltorius                #7701
           From that same sign
accept     Curse These Fat Fingers                   #7723
accept     Fiery Menace!                             #7724
accept     Incendosaurs? Whateverosaur is More Like It  #7727
accept     What the Flux?                            #7722

fly        City of Ironforge                         #3371
turnin     Suntara Stones (Part 2)                   #3368
           In the Hall of Explorers
accept     Dwarven Justice                           #3371

fly        Thelsamar                                 #3182
zone: Loch Modan
turnin     The Horn of the Beast                     #3181  @18.2,84.1
           Down in the Valley of Kings, by the locked gate
accept     Proof of Deed                             #3182

hearth     City of Ironforge                         #3182
turnin     Proof of Deed                             #3182
           In the Hall of Explorers
accept     At Last!                                  #3201
zone: Ironforge
accept     A Little Slime Goes a Long Way            #4512  @75.8,23.2
           In the Hall of Explorers museum

fly        Thelsamar                                 #3201
zone: Loch Modan
turnin     At Last!                                  #3201  @18.2,84.1
           Valley of Kings again

fly        Searing Gorge                             #7724
           Run back up to Thelsamar and fly over.
zone: Searing Gorge
complete   STOLEN: Smithing Tuyere and Lookout's Spyglass  #7728  @39,49
           Kill Dark Iron Steamsmiths to the south and Lookouts at the towers
complete   Curse These Fat Fingers                   #7723
           All over the place, mostly above the cauldren
complete   The Flawless Flame                        #3442
           Kill elementals and golums
complete   Fiery Menace!                             #7724
           All over the western side of the zone

turnin     The Flawless Flame                        #3442
accept     Forging the Shaft                         #3443

accept     The Key to Freedom                        #4451  use:11818  optional
turnin     The Key to Freedom                        #4451  optional
           Back at the outhouse!

turnin     Dwarven Justice                           #3371  @41,54
           Head down into the cauldren. Enter the second cave from the west end, find the Dying
           Archaeologist (41.19, 25.72). Kill DI Taskmasters and Slavers on the way, of course!
accept     Release Them                              #3372
complete   JOB OPPORTUNITY: Culling the Competition  #7729
           Keep working your way towards the exit
complete   WANTED: Overseer Maltorius                #7701  @40.8,35.7
           Up the top in the room to the right
complete   What the Flux?                            #7722
           On the table behind him
complete   Forging the Shaft                         #3443
complete   Incendosaurs? Whateverosaur is More Like It  #7727  @51,36
           Jump down after the bridge over the lava, you'll find dino in the big room to the
           north Grind here for a while if you want.

turnin     Curse These Fat Fingers                   #7723
           Back at Thorium Point
turnin     Fiery Menace!                             #7724
turnin     Incendosaurs? Whateverosaur is More Like It  #7727
turnin     STOLEN: Smithing Tuyere and Lookout's Spyglass  #7728
turnin     JOB OPPORTUNITY: Culling the Competition  #7729
turnin     WANTED: Overseer Maltorius                #7701
turnin     What the Flux?                            #7722

turnin     Forging the Shaft                         #3443
accept     The Flame's Casing                        #3452

complete   Release Them                              #3372  @24,32
           Run up the path to the east of the cave at the Twilight Hammer camp. In the center of
           a lava pool is the Twilight Artifact (29.2, 25.9)
accept     Prayer to Elune (Part 1)                  #3377  @29.5,26.5
           From an NPC in a cage nearby
turnin     Prayer to Elune (Part 1)                  #3377
accept     Prayer to Elune (Part 2)                  #3378
complete   Prayer to Elune (Part 2)                  #3378
complete   The Flame's Casing                        #3452
           Keep killing Twilight Hammer guys

turnin     The Flame's Casing                        #3452
accept     The Torch of Retribution (Part 1)         #3453
turnin     The Torch of Retribution (Part 1)         #3453
           You have to wait a moment for him to create it
accept     The Torch of Retribution (Part 2)         #3454
turnin     The Torch of Retribution (Part 2)         #3454
           Grab the torch he just made, duh.
accept     Squire Maltrake                           #3462
turnin     Squire Maltrake                           #3462
accept     Set Them Ablaze!                          #3463
turnin     Release Them                              #3372  @41.2,25.7
           Head back down to the Dying Archaeologist. You can drop through the hole if you want
           (35.15,43.18). Talk to the alter near him. Don't accept the followup unless you have
           a group to help.
complete   Set Them Ablaze!                          #3463  @33,53  use:10515
           Light the brazier at each tower (36,60) (44,61) (50,54)

turnin     Set Them Ablaze!                          #3463
           Back at Thorium Point
accept     Trinkets...                               #3481
           Talk to the chest near him
turnin     Trinkets...                               #3481
           Talk to the chest again
note       Save the molt                             #4024
           You'll need it later
]==]
