-- Badlands (40-41) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Badlands (40-41)
route:    Horde
faction:  Horde
levels:   40-41
zone:     Badlands
next:     Swamp of Sorrows (41-42)

note       Learning to Ride                      forever
           Level 40: Learning to Ride and Your First Riding Wolf from the wolf riding trainer
           outside Orgrimmar

goto       Badlands
           Take the zeppelin to Undercity, fly to Hammerfall, then make the long run south
           through Wetlands and Loch Modan.

turnin     Martek the Exiled                     #1106
accept     Indurium                              #1108
accept     Barbecued Buzzard Wings               #703
complete   Indurium                              #1108  @51,67
           At
turnin     Indurium                              #1108
accept     News for Fizzle                       #1137
accept     Study of the Elements: Rock (Part 1)  #710
accept     Coolant Heads Prevail                 #713  loot:3829  optional
turnin     Coolant Heads Prevail                 #713  optional
           Turn it in now if you brought what it asks for: Gyro... What? and its follow-ups need
           it
accept     Gyro... What?                         #714  loot:4389  optional
turnin     Gyro... What?                         #714  optional
           Turn it in now if you brought what it asks for: Liquid Stone and This Is Going to Be
           Hard need it

goto       Kargath
flightpath Flight Path                           @4,45
           At
accept     Coyote Thieves                        #1419
accept     Report to Helgrum                     #1420
accept     Broken Alliances                      #782
accept     Badlands Reagent Run                  #2258

complete   Study of the Elements: Rock (Part 1)  #710  @19,42
           Lessers
turnin     Study of the Elements: Rock (Part 1)  #710
accept     Study of the Elements: Rock (Part 2)  #711
complete   Study of the Elements: Rock (Part 2)  #711  @41,78
           Regulars
turnin     Study of the Elements: Rock (Part 2)  #711
accept     Study of the Elements: Rock (Part 3)  #712

complete   Barbecued Buzzard Wings               #703  @16,61
           Giant Buzzards
complete   Coyote Thieves                        #1419
           Elder Crag Coyotes
complete   Badlands Reagent Run                  #2258
complete   Broken Alliances                      #782
           If you haven't yet found him, kill Boss Tho'grun patrolling
complete   Study of the Elements: Rock (Part 3)  #712  @15,88
           Greaters

turnin     Coyote Thieves                        #1419
turnin     Broken Alliances                      #782
           Skip the follow-up
turnin     Badlands Reagent Run                  #2258
           Skip the follow-up
turnin     Study of the Elements: Rock (Part 3)  #712
accept     This Is Going to Be Hard              #734  optional
turnin     This Is Going to Be Hard              #734  optional
accept     This Is Going to Be Hard (Part 2)     #777  optional
turnin     This Is Going to Be Hard (Part 2)     #777  optional
accept     This Is Going to Be Hard (Part 3)     #778  optional
complete   This Is Going to Be Hard (Part 3)     #778  optional
           Kill the summoned elemental
turnin     This Is Going to Be Hard (Part 3)     #778  optional
accept     Liquid Stone                          #715  loot:3823  optional
turnin     Liquid Stone                          #715  optional
accept     Stone Is Better than Cloth            #716  loot:2868  optional
turnin     Stone Is Better than Cloth            #716  optional
turnin     Barbecued Buzzard Wings               #703

note       Grind                                 @70,53  level:41
           Get to lvl 41 from Scalding Whelps

hearth     Grom'gol Base Camp
zone: Duskwood
accept     Nothing But The Truth (Part 1)        #1372  @87.8,35.7
           Follow the road north into Duskwood
turnin     Nothing But The Truth (Part 1)        #1372
accept     Nothing But The Truth (Part 2)        #1383

note       Forever extras                        optional  forever
           New Forever quests in this zone, givers not yet in the database: Supplies and Studies
           (40); Mirage Mirror (42)
]==]
