-- Un'Goro Crater (51-52) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Un'Goro Crater (51-52)
route:    Alliance
faction:  Alliance
levels:   51-52
zone:     Un'Goro Crater
next:     Felwood (53-54)

zone: Tanaris
goto       Un'Goro Crater                       #3844  @27,58
           The entrance is in the soutwest corner of Tanaris. Look for two large stone pillars.
note       Look for loot...                     #3781
           There are many loot nodes scattered across this zone. You'll need 7 of each color of
           power crystals. Also loot any dirt piles or sprouts you find.

zone: Un'Goro Crater
accept     The Apes of Un'Goro                  #4289  @69,77
           Tauren on the hill to the left of the ramp from Tanaris
accept     The Fare of Lar'korwi                #4290

accept     It's a Secret to Everybody (Part 1)  #3844  @63,68.5
           Find the wrecked raft
turnin     It's a Secret to Everybody (Part 1)  #3844
           Just underwater nearby
accept     It's a Secret to Everybody (Part 2)  #3845
complete   The Fare of Lar'korwi                #4290  @68.8,56.7
           Find the Threshadon Carcass amongst the raptors.

turnin     The Fare of Lar'korwi                #4290
accept     The Scent of Lar'korwi               #4291
complete   The Scent of Lar'korwi               #4291  @60,72
           Find the egg nests and stand on them (62,65) (63,77) (67,73) (67,67) (58,78) (70,61)
turnin     The Scent of Lar'korwi               #4291
accept     The Bait for Lar'korwi               #4292
accept     Williden's Journal                   #3884  use:11116
           Kill raptors until the journal drops to start this quest

note       Find 7 Red power crystals            #4284  loot:11186x7
note       Find 7 Yellow power crystals         #4284  loot:11188x7
note       Find 7 Green power crystals          #4284  loot:11185x7
note       Find 7 Blue power crystals           #4284  loot:11184x7

accept     Chasing A-Me 01                      #4243  @46,13
           At the entrance to Marshal's Refuge
accept     Shizzle's Flyer                      #4503
accept     Muigin and Larion                    #4141
accept     Lost!                                #4492
           Near the sign
accept     Beware of Pterrordax                 #4501
accept     Roll the Bones                       #3882
accept     Alien Ecology                        #3883
turnin     Williden's Journal                   #3884
accept     Expedition Salvation                 #3881
complete   It's a Secret to Everybody (Part 2)  #3845  use:11107
           Open "A Small Pack"
turnin     It's a Secret to Everybody (Part 2)  #3845
accept     It's a Secret to Everybody (Part 3)  #3908
flightpath Get flight point                     #4284
           Up on the hill, easy to miss
accept     Crystals of Power                    #4284
           In the back of the cave
turnin     Crystals of Power                    #4284
accept     The Northern Pylon                   #4285
accept     The Eastern Pylon                    #4287
accept     The Western Pylon                    #4288

note       Kill stuff...                        #4141
           Kill any bloodpetals, diametradons, and pterrordaxes you come across

complete   The Northern Pylon                   #4285  @56.5,12.5
           Along the north edge of the zone to the east. Kill pterrordaxes here.
turnin     Chasing A-Me 01                      #4243  @63,17
           East in the gorilla cave. Skip the follow-up.
complete   The Apes of Un'Goro                  #4289
complete   Super Sticky                         #4504
           At the tarpits in the north half of the zone
note       Find [Crate of Foodstuffs]           #3881  @68.5,36.6  loot:11113
           At the abandoned camp in the east side of the zone
complete   Muigin and Larion                    #4141
           Kill lasher around the camp area. Also kill any diemetradons or pterrordaxes you come
           across
complete   The Eastern Pylon                    #4287  @77.2,50
           To the east, of course
use        Open Torwa's Pouch                   #4292  use:11568
use        Place the meat                       #4292  @79.9,49.9  use:11569
           At the flat rock behind the east pylon
complete   The Bait for Lar'korwi               #4292  use:11570
           Use the pheromone mixture, kill him!
turnin     The Apes of Un'Goro                  #4289
           Skip the follow-up
turnin     The Bait for Lar'korwi               #4292

complete   Alien Ecology                        #3883  @50,77  use:11132
           Down in the Slithering Scar. Head left inside to the big room (48.62, 85.33), use the
           vial
complete   Bungle in the Jungle                 #4496
complete   Expedition Salvation                 #3881  @38.5,66
           At camp to the west. Beware of the elite Stegodons.
complete   The Western Pylon                    #4288  @23.8,59.1
           Up the hill, west of the camp
accept     Finding the Source                   #974  @30.9,50.4
           From a goblin near the hot springs

complete   Roll the Bones                       #3882  @31.3,77.4
           Scattered all over the west half of the zone and drop from diemetradons. Kill
           pterrordaxes over here too. There is usually a good stash of bones at a threshadon
           carcass to the southwest of the camp.
complete   Beware of Pterrordax                 #4501
           You can find the Frenzied Pterrordaxes all over the west half of the zone, more
           towards the northwest part. Normal Pterrordaxes are in the south half of the zone,
           and a few near the North pylon.
complete   Shizzle's Flyer                      #4503
           Kill diemetradons and pterrordaxes, all over the zone.

complete   Finding the Source                   #974  @49.8,45.8  use:12472
           At the volcano in the center of the zone. Use the thermometer at the "Hot Spot" at
           the top of the mountain.
complete   Volcanic Activity                    #4502
           Kill elementals, mainly around the cave on the south side of the volcano.
turnin     Lost!                                #4492  @51,49
           In the cave on the south side of the volcano
accept     A Little Help From My Friends        #4491
complete   A Little Help From My Friends        #4491  use:11804
           Use the canteen on him if he faints. Run back to Marshal's Refuge.
turnin     A Little Help From My Friends        #4491
turnin     Beware of Pterrordax                 #4501
turnin     Shizzle's Flyer                      #4503
turnin     Muigin and Larion                    #4141
           Skip the follow-up
turnin     Roll the Bones                       #3882
turnin     Alien Ecology                        #3883
turnin     Expedition Salvation                 #3881
turnin     The Northern Pylon                   #4285
turnin     The Eastern Pylon                    #4287
turnin     The Western Pylon                    #4288
accept     Making Sense of It                   #4321
turnin     Making Sense of It                   #4321

turnin     Finding the Source                   #974  @30.9,50.4
           Back at the hot springs
accept     The New Springs                      #980

goto       Silithus                             #4504  @29,22
           Take the path up out of the crater in the northwest corner of the zone
goto       Cenarion Hold                        #4504
           Follow the road
fly        Gadgetzan
           Flightpoint is up the big hill
turnin     Bungle in the Jungle                 #4496
           Skip the follow-up
turnin     Super Sticky                         #4504

fly        Ratchet                              #4502
turnin     Volcanic Activity                    #4502

note       Forever extras                       optional  forever
           New Forever quests in this zone, givers not yet in the database: Microcrystal
           Contamination (55)
]==]
