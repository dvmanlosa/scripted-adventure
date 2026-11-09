-- Feralas (45-46) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Feralas (45-46)
route:    Horde
faction:  Horde
levels:   45-46
zone:     Feralas
next:     Azshara (46-47)

fly        Freewind Post
goto       Camp Mojache
           West in Feralas
accept     A New Cloak's Sheen               #2973
accept     The Ogres of Feralas (Part 1)     #2975
accept     Gordunni Cobalt                   #2987
flightpath Flight Path
accept     War on the Woodpaw                #2862
accept     The Mark of Quality               #2822
accept     A Strange Request                 #3121
sethearth  Camp Mojache

complete   War on the Woodpaw                #2862  @71,37
           North of Camp Mojache
complete   Gordunni Cobalt                   #2987  @75,31  use:9466
           North of Camp Mojache, up the path by the waterfall
complete   The Ogres of Feralas (Part 1)     #2975
accept     The Gordunni Scroll               #2978  use:9370
           From the scrolls lying around. They don't sparkle so they may be hard to find.

complete   A New Cloak's Sheen               #2973  @70,47
           West of Camp Mojache, on the north side of the path

turnin     War on the Woodpaw                #2862
           Back at Camp Mojache
accept     Alpha Strike                      #2863
turnin     Gordunni Cobalt                   #2987
turnin     The Ogres of Feralas (Part 1)     #2975
accept     The Ogres of Feralas (Part 2)     #2980
turnin     The Gordunni Scroll               #2978
accept     Dark Ceremony                     #2979
turnin     A New Cloak's Sheen               #2973
accept     A Grim Discovery (Part 1)         #2974

complete   Alpha Strike                      #2863  @72,56
           Southwest of Camp Mojache
turnin     Alpha Strike                      #2863
accept     Woodpaw Investigation             #2902
complete   Woodpaw Investigation             #2902  @71.6,55.9
           Southwest of Camp Mojache
turnin     Woodpaw Investigation             #2902
accept     The Battle Plans                  #2903

complete   A Grim Discovery (Part 1)         #2974  @66,46
           West of Camp Mojache
hearth     Camp Mojache

turnin     The Battle Plans                  #2903
accept     Zukk'ash Infestation              #7730
accept     Stinglasher                       #7731
turnin     A Grim Discovery (Part 1)         #2974
accept     A Grim Discovery (Part 2)         #2976

complete   Stinglasher                       #7731  @74,62
           Both in the hive area south of Camp Mojache
complete   Zukk'ash Infestation              #7730
complete   Screecher Spirits                 #3520  @55,56  use:10699
           South of Dire Maul
complete   The Ogres of Feralas (Part 2)     #2980  @59,68
           South of Dire Maul
complete   Dark Ceremony                     #2979  @59,68
           In the ruins to the south
complete   The Mark of Quality               #2822  @55.4,56.4
           Southwest of Dire Maul

turnin     The Mark of Quality               #2822
           Back at Camp Mojache
turnin     Stinglasher                       #7731
turnin     Zukk'ash Infestation              #7730
accept     Zukk'ash Report                   #7732
turnin     The Ogres of Feralas (Part 2)     #2980
turnin     Dark Ceremony                     #2979
accept     The Gordunni Orb                  #3002

fly        Orgrimmar
zone: Orgrimmar
turnin     Zukk'ash Report                   #7732  @56,46
           In The Drag
accept     A Donation of Silk (Part 2)       #7827
           Easy exp, but prices may be bad on your server. Skip these quests if the prices suck.
turnin     A Donation of Silk (Part 2)       #7827
accept     A Donation of Mageweave           #7831
turnin     A Donation of Mageweave           #7831
accept     Ripple Recovery (Part 1)          #649  @59.4,36.9
           From Dran Droffers in The Drag
turnin     Ripple Recovery (Part 1)          #649
           The other guy in the same building
accept     Ripple Recovery (Part 2)          #650
turnin     Parts of the Swarm (Part 2)       #1184  @75,34
           At Belgrom Rockmaul in the Valley of Honor
turnin     A Grim Discovery (Part 2)         #2976
accept     Betrayed (Part 1)                 #3504
turnin     A Strange Request                 #3121
accept     Return to Witch Doctor Uzer'i     #3122
turnin     Report to Zor                     #1262
accept     Service to the Horde              #7541
turnin     Service to the Horde              #7541
turnin     The Gordunni Orb                  #3002
accept     A Donation of Silk (Part 3)       #7834
           Easy exp, but prices may be bad on your server. Skip these quests if the prices suck.
turnin     A Donation of Silk (Part 3)       #7834
accept     A Donation of Mageweave (Part 2)  #7835
turnin     A Donation of Mageweave (Part 2)  #7835

hearth     Camp Mojache
turnin     Return to Witch Doctor Uzer'i     #3122
accept     Testing the Vessel                #3123
accept     Natural Materials                 #3128

kill       Sprite Darters                    #3128
           Need [Encrusted Minerals] for "Natural Materials"
note       [Long Elegant Feathers]
           As you kill Hippogryphs, keep 10x of these for later
zone: Feralas
complete   Natural Materials                 #3128  @55,61
           Hippogryph for sinew, Walker for logs (57.4,73.3)
note       [Hippogryph Egg]                  @57,78  loot:141931
           Grab one of these for later
grind      Level 46                          @54,59  level:46
           Kill Hippogryphs and Yetis

accept     Find OOX-22/FE!                   #2766  use:8705  optional
turnin     Find OOX-22/FE!                   #2766  @51,57  optional
           Cave at
accept     Rescue OOX-22/FE!                 #2767  optional
           Long escort, you can skip if interested
complete   Rescue OOX-22/FE!                 #2767  optional

hearth     Camp Mojache
turnin     Natural Materials                 #3128

note       Forever extras                    optional  forever
           New Forever quests in this zone, givers not yet in the database: Lost for Words (43)
]==]
