-- Felwood (53-54) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Felwood (53-54)
route:    Alliance
faction:  Alliance
levels:   53-54
zone:     Felwood
next:     Winterspring (54-55)

hearth     Darnassus                        #3781
turnin     Un'Goro Soil                     #3764
           Behind the druids' treehouse.
accept     Morrowgrain Research (Part 1)    #3781
           Upstairs!
turnin     Morrowgrain Research (Part 1)    #3781
           Downstairs!
accept     Morrowgrain Research (Part 2)    #3785
note       Morrowgrain...                   #3785
           Use the Evergreen Pouch whenever it's cooldown is up until you get all your
           Morrowgrain.
accept     Moontouched Wildkin              #978
           Down in Rut'theran Village

zone: Ashenvale
goto       Felwood                          #4101  @55.8,29.5
           Fly to Astranaar then head east out of town. At the fork near the retreat head north
           out of the zone
zone: Felwood
accept     Cleansing Felwood                #4101  @54,86
           On the north side of the road

goto       Emerald Sanctuary                #5155  @51,81
           Just ahead, north of the road
accept     Forces of Jaedenar               #5155
accept     The Corruption of the Jadefire   #4421
accept     Verifying the Corruption         #5156

accept     Timbermaw Ally                   #8460  @51,85
           Down by the road
complete   Timbermaw Ally                   #8460
           Just to the southwest
turnin     Timbermaw Ally                   #8460
accept     Speak to Nafien                  #8462

use        Open your ooze containers        #4512  use:11912
kill       Cursed Oozes                     #4512  @40,69  use:11914
           Follow the road north to the Ruins of Constellas. Use the vials after you kill and
           loot.
complete   The Corruption of the Jadefire   #4421  @32,67
           To the west, Xavathras can be found at the far west end of the ruins
complete   A Little Slime Goes a Long Way   #4512  @40,59  use:11948
           At the next set of ponds north along the road
complete   Forces of Jaedenar               #5155  @37,59
           To the west, outside the caves

turnin     Forces of Jaedenar               #5155
           Back at Emerald Sanctuary
accept     Collection of the Corrupt Water  #5157
turnin     The Corruption of the Jadefire   #4421
accept     Further Corruption               #4906

complete   Collection of the Corrupt Water  #5157  @35.2,59.8  use:12922
           Fill the vial at the corrupted moonwell in Jaedenar
complete   Verifying the Corruption         #5156  @40.5,41.8
           North at Shatter Scar Vale. Watch out for the elite infernals!
kill       Kill Xavaric                     #939  @39,22  loot:11668
           North in Jadefire Run
accept     Flute of Xavaric                 #939  use:11668
           From the item he dropped, naturally
complete   Further Corruption               #4906
complete   Flute of Xavaric                 #939
complete   Cleansing Felwood                #4101  @55,17
           Kill elementals at Irontree Cavern

goto       Talonbranch Glade                #5156  @62,24
           At the northeast edge of the zone, south of the road
fly        Emerald Sanctuary                #5156
turnin     Collection of the Corrupt Water  #5157
turnin     Further Corruption               #4906
turnin     Flute of Xavaric                 #939
turnin     Verifying the Corruption         #5156
turnin     Cleansing Felwood                #4101
           South along the road
accept     To Winterspring!                 #5249
           You can't get this quest if you already have "Starfall".

fly        Talonbranch Glade                #8465
turnin     Speak to Nafien                  #8462  @64.8,8.2
           North, at the end of the road
accept     Deadwood of the North            #8461
complete   Deadwood of the North            #8461
turnin     Deadwood of the North            #8461
accept     Speak to Salfa                   #8465
]==]
