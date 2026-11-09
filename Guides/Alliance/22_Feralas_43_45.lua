-- Feralas (43-45) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Feralas (43-45)
route:    Alliance
faction:  Alliance
levels:   43-45
zone:     Feralas
next:     The Hinterlands (46-47)

zone: Desolace
goto       Feathermoon Stronghold            #4124  @43,98
           Fly to Desolace and run southwest into Feralas. Follow the road until the path down
           to the docks. Take the boat if it's there, or swim due west.

accept     The Mark of Quality               #2821
sethearth  Feathermoon Stronghold            #4266
accept     The Ruins of Solarsal             #2866
accept     The Missing Courier (Part 1)      #4124
accept     The High Wilderness               #2982
accept     In Search of Knowledge            #2939
turnin     The Missing Courier (Part 1)      #4124
accept     The Missing Courier (Part 2)      #4125

zone: Feralas
turnin     The Ruins of Solarsal             #2866  @26,52
           Southwest to the Ruins of Solarsal, at the "Solar Gazebo"
accept     Return to Feathermoon Stronghold  #2867
turnin     Return to Feathermoon Stronghold  #2867
accept     Against the Hatecrest (Part 1)    #3130
turnin     Against the Hatecrest (Part 1)    #3130
accept     Against the Hatecrest (Part 2)    #2869
complete   Against the Hatecrest (Part 2)    #2869
           Kill naga back at the ruins
turnin     Against the Hatecrest (Part 2)    #2869
accept     Against Lord Shalzaru             #2870
complete   Against Lord Shalzaru             #2870  @26,67
           South thru the ruins, across the water, in a cave. He is level 47, so he might be
           hard to solo.

goto       Feathermoon Stronghold            #2871
           Or die and rez there
turnin     Against Lord Shalzaru             #2870
accept     Delivering the Relic              #2871
turnin     Delivering the Relic              #2871

complete   Screecher Spirits                 #3520  use:10699
           Back on the main shore, avoid elementals and giants while killing Rogue Vale
           Screechers. Use Yeh'Kinya's Bramble on their corpses and talk to the spirits. Work
           your way south.
turnin     The Missing Courier (Part 2)      #4125  @45.5,65
           Find the boat wreckage to the south
accept     Boat Wreckage                     #4127

turnin     Boat Wreckage                     #4127
           Back at the stronghold
accept     The Knife Revealed                #4129
turnin     The Knife Revealed                #4129
accept     Psychometric Reading              #4130
turnin     Psychometric Reading              #4130
accept     The Woodpaw Gnolls                #4131

accept     Find OOX-22/FE!                   #2766  use:8705  optional
complete   The Mark of Quality               #2821  @56,56
           Back on mainland, follow the road to the yeti cave.
turnin     Find OOX-22/FE!                   #2766  optional
           At the back of the yeti cave. Don't accept the escort!
complete   The High Wilderness               #2982  @59,73
           Shamans are to the south at the temple. Brutes at Ruins of Isildien (62,54). If you
           have issues finding warlocks, you should be shot.
accept     Freedom for All Creatures         #2969  @65.6,46.8
           Clear around the cage in the camp, then head up the path behind the camp
complete   Freedom for All Creatures         #2969
           Lead Kindal Moonweaver down to the cage, open it, and protect the Sprite Darters as
           they escape.
turnin     Freedom for All Creatures         #2969
accept     Doling Justice (Part 1)           #2970
complete   Doling Justice (Part 1)           #2970
turnin     Doling Justice (Part 1)           #2970
accept     Doling Justice (Part 2)           #2972

turnin     The Woodpaw Gnolls                #4131  @73,56
           Look for a backpack hanging on a tree in one of the gnoll camps
accept     The Writhing Deep                 #4135
turnin     The Writhing Deep                 #4135  @73,63
           In the hive to the south. At the bottom, take the southern tunnel and stay right.
           Turnin at the Zukk'Ash Pod
accept     Freed from the Hive               #4265

hearth     Feathermoon Stronghold            #4266
turnin     The Mark of Quality               #2821
accept     Improved Quality                  #7733
turnin     The High Wilderness               #2982
turnin     Freed from the Hive               #4265
accept     A Hero's Welcome                  #4266
turnin     A Hero's Welcome                  #4266
accept     Rise of the Silithid              #4267

fly        Rut'theran Village                #2940
           Darnassus you dingus
turnin     Handle With Care                  #3022
accept     Favored of Elune?                 #3661
turnin     In Search of Knowledge            #2939
accept     Feralas: A History                #2940
           From the green book
turnin     Feralas: A History                #2940
accept     The Borrower                      #2941

zone: Darnassus
turnin     Rise of the Silithid              #4267  @39,86
           In the temple of the moon, upstairs
turnin     Doling Justice (Part 2)           #2972

fly        Gadgetzan                         #2944
           Hearth to Feathermoon Stronghold to cut down time, if it's up.
turnin     The Borrower                      #2941
accept     The Super Snapper FX              #2944

note       Forever extras                    optional  forever
           New Forever quests in this zone, givers not yet in the database: WANTED: Ohk'zi (43)
]==]
