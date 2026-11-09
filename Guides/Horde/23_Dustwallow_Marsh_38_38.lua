-- Dustwallow Marsh (38) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Dustwallow Marsh (38)
route:    Horde
faction:  Horde
levels:   38-38
zone:     Dustwallow Marsh
next:     Stranglethorn Vale (38-40)

note       Riverglades option         forever
           Forever's Riverglades (36-44, Rog'mar for the Horde) is an alternative for the late
           30s; see the route JSON for its quest list

fly        Thunder Bluff              #1205
turnin     Frostmaw                   #1136
accept     Deadmire                   #1205

fly        Brackenwall Village
accept     Theramore Spies            #1201
accept     The Black Shield (Part 3)  #1322
accept     Hungry!                    #1177

complete   Theramore Spies            #1201
           Stealthed mobs all around Brackenwall Village
complete   The Black Shield (Part 3)  #1322
complete   Hungry!                    #1177
           North of the house, along the coast.

accept     Soothing Spices            #1218
turnin     Soothing Spices            #1218
accept     Jarl Needs Eyes            #1206
accept     The Lost Report            #1238
           Click on Loose Dirt

accept     Stinky's Escape            #1270  @46.9,17.6
           North of the tower. You may want to clear the area first.
complete   Stinky's Escape            #1270

complete   Jarl Needs Eyes            #1206  @35,21
           Kill spiders to the southwest at Darkmist Cavern.
complete   Deadmire                   #1205
turnin     Hungry!                    #1177  @35,38
           Southwest at Mudcrush Durtfeet

turnin     Theramore Spies            #1201
           Back in Brackenwall Village
turnin     The Lost Report            #1238
accept     The Theramore Docks        #1202
turnin     The Black Shield (Part 3)  #1322
accept     The Black Shield (Part 4)  #1323
turnin     Jarl Needs Eyes            #1206
accept     The Severed Head           #1239
           Dig in the dirt near the cabin again.

complete   The Theramore Docks        #1202  @71.5,51.1
           Swim around the north side of Theramore, find the box under the northeast pier.
die        Die
           Take Rez Sickness back to Brackenwall Village
turnin     The Theramore Docks        #1202
turnin     The Severed Head           #1239
accept     The Troll Witchdoctor      #1240

fly        Thunder Bluff
zone: Thunder Bluff
turnin     The Black Shield (Part 5)  #1276  @54.6,80.1
           Down on Hunter Rise
turnin     Deadmire                   #1205
           Hunter's Rise

hearth     The Crossroads
fly        Ratchet
turnin     Stinky's Escape            #1270
]==]
