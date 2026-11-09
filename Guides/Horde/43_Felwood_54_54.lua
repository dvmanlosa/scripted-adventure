-- Felwood (54) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Felwood (54)
route:    Horde
faction:  Horde
levels:   54-54
zone:     Felwood
next:     Winterspring (54-55)

fly        Splintertree Post

zone: Ashenvale
goto       Felwood                              @55.8,29.5
           Head west out of town. At the fork near the retreat head north out of the zone

zone: Felwood
goto       Emerald Sanctuary                    @51,81
           Just ahead, north of the road
accept     Forces of Jaedenar                   #5155
accept     Verifying the Corruption             #5156
accept     Timbermaw Ally                       #8460  @51,85
           Down by the road

accept     Cleansing Felwood                    #4102  @46.8,83.1
           On the west side of the road to the north

goto       Bloodvenom Post                      @34,52
accept     Well of Corruption                   #4505
accept     A Husband's Last Battle              #6162

complete   Forces of Jaedenar                   #5155  @37,59
           To the west, outside the caves
complete   Well of Corruption                   #4505  @32,66
           To the west at the far west end of the ruins

complete   A Husband's Last Battle              #6162
complete   Timbermaw Ally                       #8460

turnin     Timbermaw Ally                       #8460
accept     Speak to Nafien                      #8462
turnin     Forces of Jaedenar                   #5155
accept     Collection of the Corrupt Water      #5157

turnin     Well of Corruption                   #4505
accept     Corrupted Sabers                     #4506
turnin     A Husband's Last Battle              #6162
accept     Wild Guardians                       #4741

complete   Collection of the Corrupt Water      #5157  @35.2,59.8  use:12922
           Fill the vial at the corrupted moonwell in Jaedenar
complete   Verifying the Corruption             #5156
complete   Cleansing Felwood                    #4102

turnin     Speak to Nafien                      #8462  @64.8,8.2
           North, at the end of the road
accept     Deadwood of the North                #8461
complete   Deadwood of the North                #8461
turnin     Deadwood of the North                #8461
accept     Speak to Salfa                       #8465

goto       Winterspring
           Thru the cave!
turnin     Speak to Salfa                       #8465
accept     Winterfall Activity                  #8464
zone: Winterspring
turnin     The New Springs                      #980  @31.3,45.2
           To the south near the hot springs
accept     Strange Sources                      #4842
turnin     It's a Secret to Everybody (Part 3)  #3908
accept     Threat of the Winterfall             #5082
]==]
