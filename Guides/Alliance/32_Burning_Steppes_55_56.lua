-- Burning Steppes (55-56) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Burning Steppes (55-56)
route:    Alliance
faction:  Alliance
levels:   55-56
zone:     Burning Steppes
next:     Silithus (56)

fly        City of Ironforge                         #8275
           Fly to Auberdine, boat to Stormwind, tram to Ironforge
sethearth  Ironforge                                 #3701
turnin     A Little Slime Goes a Long Way            #4512
           In the Hall of Explorers, skip the follow-up.
accept     The Smoldering Ruins of Thaurissan (Part 1)  #3702
           In the throne room
turnin     The Smoldering Ruins of Thaurissan (Part 1)  #3702
accept     The Smoldering Ruins of Thaurissan (Part 2)  #3701
accept     Taking Back Silithus                      #8275
           Near the flight master

zone: Redridge Mountains
goto       Burning Steppes                           #3823  @40.9,6
           Fly to Lakeshire then follow the road north
zone: Burning Steppes
flightpath Grab flight point                         #3823  @83,63
           Up in Morgan's Vigil
accept     Extinguish the Firegut                    #3823
accept     FIFTY! YEP!                               #4283

complete   Extinguish the Firegut                    #3823  @82,54
           Kill ogres down at the mountain. Most of the mages can be found in the cave on the
           northern face (83,39)
turnin     Extinguish the Firegut                    #3823
accept     Gor'tesh the Brute Lord                   #3824

turnin     Yuka Screwspigot                          #4324  @65,24
           In the cave up north at Flame Crest. Skip the follow-up
accept     Tablet of the Seven                       #4296
accept     Broodling Essence                         #4726

complete   Tablet of the Seven                       #4296  @54,40
           Talk to the dorf statue
complete   The Smoldering Ruins of Thaurissan (Part 2)  #3701
           Poke the relics around this area.
complete   Gor'tesh the Brute Lord                   #3824  @40,55
           At Pillar of Ash
complete   FIFTY! YEP!                               #4283  @43,36
           Kill orcs at Blackrock Stronghold or Pillar of Ash (49,55)

complete   Broodling Essence                         #4726  use:12284
           Dragons to the northeast. Use the device on them, then kill them. Get help if you
           can.

accept     A Taste of Flame                          #4024  @94,31
           In the cave at Slither Rock
turnin     A Taste of Flame                          #4024
           Skip the follow-up

turnin     FIFTY! YEP!                               #4283  @84,68
           Back at Morgan's Vigil
turnin     Gor'tesh the Brute Lord                   #3824
accept     Ogre Head On A Stick = Party              #3825

complete   Ogre Head On A Stick = Party              #3825  @81,46.8
           Up on the ogre mountain
turnin     Ogre Head On A Stick = Party              #3825

turnin     Tablet of the Seven                       #4296  @65,23
           Back at Flame Crest to the north
turnin     Broodling Essence                         #4726

hearth     City of Ironforge                         #3701
turnin     The Smoldering Ruins of Thaurissan (Part 2)  #3701
           In the throne room
]==]
