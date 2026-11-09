-- Swamp of Sorrows (41-42) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Swamp of Sorrows (41-42)
route:    Horde
faction:  Horde
levels:   41-42
zone:     Swamp of Sorrows
next:     Stranglethorn Vale (42-43)

goto       Swamp of Sorrows

kill       Dreaming Whelp                  @15,56  loot:5803
           Just clear the area, will return later
kill       Mire Lord                       @6,31  loot:6081
           Inside cave
complete   Dream Dust in the Swamp         #1116
           Kill Scalebane Dragons along the east and northern shores of the big lake

kill       Noboru the Cudgel               loot:6196
accept     Noboru the Cudgel               #1392  use:6196
turnin     Noboru the Cudgel               #1392
accept     Draenethyst Crystals            #1389

goto       Stonard                         @45,54
sethearth  Stonard
accept     Lack of Surplus (Part 1)        #698
accept     Fresh Meat                      #1430
note       Stable Pet                      @97.4,35.9  [Hunter]
           At
turnin     Report to Helgrum               #1420
accept     Pool of Tears                   #1424

petskill   Bite (Rank 6)                   @56,61  [Hunter]
           Tame a Deathstrike Tarauntula
note       Abandon Pet                     [Hunter]
petskill   Claw (Rank 6)                   @80.5,93.9  [Hunter]
           Tame a Silt Crawler
hearth     Stonard                         [Hunter]
note       Abandon Pet                     [Hunter]
           Get original pet back

complete   Pool of Tears                   #1424  @65,54
           Artifacts in the water around the big lake
complete   Lack of Surplus (Part 1)        #698
           Just north-east of Stonard
note       Nothing But the Truth (Part 2)  #1383
           Kill any Shadow Panthers you see
turnin     Lack of Surplus (Part 1)        #698
accept     Lack of Surplus (Part 2)        #699
complete   Lack of Surplus (Part 2)        #699  @81,20
           Sawtooth Snappers to the north east

accept     Galen's Escape                  #1393
           An escort quest, skip if you'd like
complete   Galen's Escape                  #1393  optional
complete   Draenethyst Crystals            #1389
complete   Ongeku                          #1373  @65.1,22
           Found at
turnin     Galen's Escape                  #1393  optional

turnin     Draenethyst Crystals            #1389  @26,31.6
           Back at The Harborage

turnin     Pool of Tears                   #1424
accept     The Atal'ai Exile               #1429

turnin     Lack of Surplus (Part 2)        #699
accept     Threat From the Sea (Part 1)    #1422
turnin     Threat From the Sea (Part 1)    #1422
accept     Threat From the Sea (Part 2)    #1426

complete   Threat From the Sea (Part 2)    #1426
           Head to the shoreline
complete   Fresh Meat                      #1430
           Monstrous Crawlers on the shoreline
note       Nothing But the Truth (Part 2)  #1383
           Get remaining Hearts

turnin     Threat From the Sea (Part 2)    #1426
accept     Threat From the Sea (Part 3)    #1427
turnin     Threat From the Sea (Part 3)    #1427
hearth     Stonard

turnin     Fresh Meat                      #1430

note       Forever extras                  optional  forever
           New Forever quests in this zone, givers not yet in the database: My Little Friends
           (35); Taking the Bait Back (35); Lost in Transit (35); The Visiting Mage (38)
]==]
