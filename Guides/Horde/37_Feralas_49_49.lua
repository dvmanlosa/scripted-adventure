-- Feralas (49) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Feralas (49)
route:    Horde
faction:  Horde
levels:   49-49
zone:     Feralas
next:     Tanaris (49-50)

fly        Camp Mojache
           to Feralas!
turnin     Testing the Vessel            #3123
accept     Hippogryph Muisek             #3124
accept     The Sunken Temple             #3380
accept     Improved Quality              #7734
accept     Dark Heart                    #3062
accept     Vengeance on the Northspring  #3063
accept     The Strength of Corruption    #4120
sethearth  Camp Mojache

complete   Hippogryph Muisek             #3124  @56,64  use:9619
           Use Vessel on corpses

hearth     Camp Mojache
turnin     Hippogryph Muisek             #3124
accept     Faerie Dragon Muisek          #3125

complete   Faerie Dragon Muisek          #3125  @68,48  use:9620
           Use Vessel on corpses

turnin     Faerie Dragon Muisek          #3125
           Back at Camp Mojache
accept     Treant Muisek                 #3126

complete   Treant Muisek                 #3126  @73.9,38.8  use:9606
           Use Vessel on corpses and (73.5,54.5)

turnin     Treant Muisek                 #3126
           Back at Camp Mojache
accept     Mountain Giant Muisek         #3127
note       Stable Pet                    [Hunter]

accept     Zapped Giants                 #7003
accept     Fuel for the Zapping          #7721
petskill   Claw (Rank 7)                 @46,38  [Hunter]
           Tame an Ironfur Patriarch

complete   Fuel for the Zapping          #7721  @44,38
           Kill Sea Elementals and Sea Sprays on the shore
turnin     Fuel for the Zapping          #7721

complete   Improved Quality              #7734  @52,32
           Rage Scar Yetis until you get [Perfect Yeti Hide] as well
accept     Perfect Yeti Hide             #7738  use:18972  optional
complete   Vengeance on the Northspring  #3063  @40,14
           Kill Harpies around until you get [Horn of Hatetalon] as well
complete   Dark Heart                    #3062  @41,8  use:9530
           Use the Horn at to summon
complete   Mountain Giant Muisek         #3127  use:18904
           Use the Shrinker to assist killing, then the vessel on the corpses
complete   Zapped Giants                 #7003  use:18904

turnin     Zapped Giants                 #7003
note       [Hippogryph Egg]              @57,78  loot:141931
           Grab one of these for later

hearth     Camp Mojache
note       Abandon Pet                   [Hunter]
           Get your original pet back
turnin     Mountain Giant Muisek         #3127
accept     Weapons of Spirit             #3129
turnin     Weapons of Spirit             #3129
turnin     Improved Quality              #7734
turnin     Perfect Yeti Hide             #7738
turnin     Dark Heart                    #3062
turnin     Vengeance on the Northspring  #3063

note       Forever extras                optional  forever
           New Forever quests in this zone, givers not yet in the database: Mirrorscale (50)
]==]
