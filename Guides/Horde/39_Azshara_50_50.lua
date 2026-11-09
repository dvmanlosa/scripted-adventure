-- Azshara (50) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Azshara (50)
route:    Horde
faction:  Horde
levels:   50-50
zone:     Azshara
next:     The Hinterlands (50-51)

fly        Orgrimmar
sethearth  Orgrimmar
note       [Box of Empty Vials]           loot:10695
           Have this ready

fly        Azshara
accept     Stealing Knowledge             #3517
complete   Stealing Knowledge             #3517  @36,54
           At Ruins of Eldarath
complete   Seeping Corruption (Part 1)    #3568  @47,61
           Tide Pools at: 1- 2-(47,51) 3-(48,48) 4-(47,46)
turnin     Stealing Knowledge             #3517
accept     Delivery to Archmage Xylem     #3561
accept     Delivery to Magatha            #3518
accept     Delivery to Jes'rimon          #3541
accept     Delivery to Andron Gant        #3542
turnin     Delivery to Archmage Xylem     #3561  @28,50
           Take teleporter at
accept     Xylem's Payment to Jediga      #3565

fly        Thunder Bluff
turnin     Delivery to Magatha            #3518
           Elder Rise
accept     Magatha's Payment to Jediga    #3562

hearth     Orgrimmar
turnin     Rise of the Silithid           #32
accept     March of the Silithid          #4494
zone: Orgrimmar
turnin     Delivery to Jes'rimon          #3541  @55,34
           at
accept     Jes'rimon's Payment to Jediga  #3563
accept     Bone-Bladed Weapons            #4300

fly        Undercity
turnin     Delivery to Andron Gant        #3542
           Apothecarium Quarter
accept     Andron's Payment to Jediga     #3564
turnin     Seeping Corruption (Part 1)    #3568
accept     Vivian Lagrave                 #4133
accept     Seeping Corruption (Part 2)    #3569
turnin     Seeping Corruption (Part 2)    #3569

note       Forever extras                 optional  forever
           New Forever quests in this zone, givers not yet in the database: Remote Contact (52)
]==]
