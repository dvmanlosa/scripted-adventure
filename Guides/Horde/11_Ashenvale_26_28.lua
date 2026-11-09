-- Ashenvale (26-28) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Ashenvale (26-28)
route:    Horde
faction:  Horde
levels:   26-28
zone:     Ashenvale
next:     Stonetalon Mountains (28)

accept     Satyr Horns                      #6441
accept     Stonetalon Standstill            #25
sethearth  Splintertree Post

accept     Ashenvale Outrunners             #6503  @71.2,68.1
           At the camp southwest of Splintertree Post
kill       Sharptalon                       @74,71  loot:16305
           South of Splintertree Post. He's level 31, so try kiting him to the guards at the
           nearby outpost.
accept     Sharptalon's Claw                #2  use:16305
complete   Ashenvale Outrunners             #6503  @70,76
           South of Splintertree Post, stealth mobs!

accept     Torek's Assault                  #6544  @68.3,75.3
           Take the road west, then southeast at the fork to Torek
complete   Torek's Assault                  #6544
           Let Torek and his bodyguard go in front of you, and join in fights that they start,
           otherwise they don't help you

complete   Stonetalon Standstill            #25  @49,69.5
           The gazebo is the shrine on the island in the middle of Mystral Lake.
kill       Tideress                         loot:16408
           Find him patrolling the bottom of Mystral Lake and occasionally on the island in the
           centre.
accept     The Befouled Element             #1918  use:16408
           From the water globe Tidress dropped.
kill       Ursangous                        @42.1,66.2  loot:16303
           Find him patrolling the area northwest of Mystral Lake
accept     Ursangous's Paw                  #23  use:16303
kill       Shadumbra                        @56.1,57.4  loot:16304
           Find him patrolling the area between the path towards Astranaar and the path towards
           Felwood (63.1, 48.6)
accept     Shadumbra's Head                 #24  use:16304

kill       Laughing Sisters                 @61,51  loot:5867
           Near the Raynewood Retreat, looking for [Etched Phial]
complete   The Sacred Flame                 #1195  @60.2,72.9  use:5867
           Use the phial at the moonwell
hearth     Splintertree Post

turnin     Sharptalon's Claw                #2
turnin     Ursangous's Paw                  #23
turnin     Shadumbra's Head                 #24
accept     The Hunt Completed               #247
turnin     The Hunt Completed               #247
turnin     Stonetalon Standstill            #25
turnin     The Befouled Element             #1918
accept     Je'neu of the Earthen Ring       #824
turnin     Torek's Assault                  #6544  @73.1,62.5
           Back at Splintertree Post
fly        Zoram'gar Outpost

turnin     Je'neu of the Earthen Ring       #824  @11.6,34.3
           Fly back to Zoram'gar Outpost.
accept     Troll Charm                      #6462
accept     Between a Rock and a Thistlefur  #216
accept     Vorsha the Lasher                #6641
complete   Vorsha the Lasher                #6641  @9.5,27.5
           Follow the NPC, help him kill Vorsha.
complete   Between a Rock and a Thistlefur  #216  @31.2,45.3
           At the Thistlefur camp west of Astranaar.
complete   Troll Charm                      #6462  @38.5,30.6
           In the cave at the back of the Thistlefur camp.

accept     Freedom to Ruul                  #6482  @41.5,34.6
           In the cave at the back of the Thistlefur camp.
complete   Freedom to Ruul                  #6482

turnin     Vorsha the Lasher                #6641  @12.2,34.1
           Back at Zoram'gar Outpost
turnin     Between a Rock and a Thistlefur  #216
turnin     Troll Charm                      #6462
hearth     Splintertree Post

turnin     Freedom to Ruul                  #6482
note       Stable Pet                       [Hunter]
           Make sure you are level 27 right now
turnin     Ashenvale Outrunners             #6503  @71.2,68.2
petskill   Bite (Rank 4)                    [Hunter]
           Tame a Ghostpaw Alpha west of Splintertree Post, then abandon.
petskill   Claw (Rank 4)                    [Hunter]
           Tame an Elder Ashenvale Bear along the river

complete   Ordanus                          #1088  @62.1,51
           Fight to the top of the tower at Raynewood Retreat. Kill Ordanus, loot the head and
           jump out of there.
goto       Splintertree Post
note       Get your cat                     [Hunter]
           Abandon the bear

complete   Satyr Horns                      #6441  @79.5,49.7
           Take the road east to Satyrnaar.
turnin     Satyr Horns                      #6441
]==]
