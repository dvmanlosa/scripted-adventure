-- Azshara (46-47) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Azshara (46-47)
route:    Horde
faction:  Horde
levels:   46-47
zone:     Azshara
next:     Hinterlands (47)

fly        Splintertree Post
           Ashenvale
goto       Azshara
           Go east dur!

accept     Spiritual Unrest                      #5535  @11.4,78.2
           To the south of the road as you enter the zone
accept     A Land Filled with Hatred             #5536
complete   Spiritual Unrest                      #5535  @17,66
           Ghosts in the ruins north of the road
complete   A Land Filled with Hatred             #5536  @20,62
           Further north, more ruins containing satyrs
turnin     Spiritual Unrest                      #5535
turnin     A Land Filled with Hatred             #5536

goto       Valormok                              @21,52
           North of the road, on the mountain's edge
turnin     Betrayed (Part 1)                     #3504
           Skip the follow-up

hearth     Orgrimmar
fly        Undercity
accept     Seeping Corruption (Part 1)           #3568
           Apothecarium Quarter
accept     Errand for Apothecary Zinge (Part 1)  #232
turnin     Errand for Apothecary Zinge (Part 1)  #232
           Out in other room
accept     Errand for Apothecary Zinge (Part 2)  #238
turnin     Errand for Apothecary Zinge (Part 2)  #238
accept     Into the Field                        #243

note       Forever extras                        optional  forever
           New Forever quests in this zone, givers not yet in the database: Sisters In Duty (47)
]==]
