-- Badlands (40-41) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Badlands (40-41)
route:    Alliance
faction:  Alliance
levels:   40-41
zone:     Badlands
next:     Stranglethorn Vale (41-42)

note       Learning to Ride                      @84.3,65  forever
           Level 40: Learning to Ride and Your First Horse from the riding trainer at Eastvale
           Logging Camp, Elwynn

fly        City of Ironforge                     #738
buy        [Frost Oil]                           #715
           From AH
buy        [Gyrochronatom]                       #715
           Don't buy if you didn't find a Frost Oil
buy        [Healing Potion]                      #715
           Don't buy if you didn't find a Frost Oil and Gyrochronatom
buy        [Lesser Invisibility Potion]          #715
           Don't buy if you didn't find a Frost Oil and Gyrochronatom
zone: Ironforge
accept     Ironband Wants You!                   #707  @74,12
           From Prospector Stormpike in the Hall of Explorers

fly        Loch Modan                            #738
zone: Loch Modan
accept     Badlands Reagent Run                  #2500  @37,49
           In the house behind the Inn
turnin     Ironband Wants You!                   #707  @65,65
           Down at Ironband's Excavation Site
accept     Find Agmond                           #738

goto       Badlands                              #718  @46,76
           Southwest of Ironband's
zone: Badlands
accept     Fiery Blaze Enchantments              #706  @54,43
           To the south, up a hill after the dark iron dig
accept     Mirages                               #718
accept     A Dwarf and His Tools                 #719
accept     Barbecued Buzzard Wings               #703  @42,52
           West, in the center of the zone

note       Kill any buzzards you see             #2500
           For "Barbecued Buzzard Wings" and "Badlands Reagent Run"

complete   Mirages                               #718  @66,21
           Grind your way to the crate in the northwest at Camp Kosh
accept     A Sign of Hope (Part 1)               #720  @53,33
           At Hammertoe's Digsite. Note is on the right side of the dig
complete   A Dwarf and His Tools                 #719  @43,31
           Kill the dwarfs at Hammertoe's Digsite or Angor Fortress

turnin     Mirages                               #718
           Back up the hill
accept     Scrounging                            #733
turnin     A Dwarf and His Tools                 #719
turnin     A Sign of Hope (Part 1)               #720

accept     Tremors of the Earth (Part 1)         #732  @61,54
           From a blood elf to the southeast.
note       Keep an eye out for the ogre pack     #732  @62,70
           They spawn to the south of the questgiver. They patrol down to the southwest side of
           the zone and back in a circle. You should be able to pick Boss Tho'grun off the back
           of the pack easily.

turnin     Find Agmond                           #738  @50,62
           Dead dorf to the southwest at Agmond's End
accept     Murdaloc                              #739
complete   Murdaloc                              #739
           To the south in the trogg camp
complete   Barbecued Buzzard Wings               #703

turnin     Barbecued Buzzard Wings               #703  @42,52
           Back at the neutral camp in the center of the zone

accept     Study of the Elements: Rock (Part 1)  #710  @24,44
           From Lotwil Veriatus to the west
accept     Coolant Heads Prevail                 #713  loot:3829  optional
turnin     Coolant Heads Prevail                 #713  optional
accept     Gyro... What?                         #714  loot:4389  optional
turnin     Gyro... What?                         #714  optional
accept     Liquid Stone                          #715  loot:3823  optional
turnin     Liquid Stone                          #715  optional

complete   Study of the Elements: Rock (Part 1)  #710  @18,41
           Kill Lesser Rock Elementals to the west near Kargath
turnin     Study of the Elements: Rock (Part 1)  #710  @26,44
accept     Study of the Elements: Rock (Part 2)  #711
complete   Study of the Elements: Rock (Part 2)  #711
           Rock Elementals in the same area as the last step
turnin     Study of the Elements: Rock (Part 2)  #711
accept     Study of the Elements: Rock (Part 3)  #712

complete   Badlands Reagent Run                  #2500
           Kill buzzards and coyotes south of the gnomes.
complete   Scrounging                            #733  @11,77
           Kill ogres at Camp Cagg to the southwest
complete   Study of the Elements: Rock (Part 3)  #712  @14,88
           Greater Rock Elements

turnin     Study of the Elements: Rock (Part 3)  #712
accept     This Is Going to Be Hard (Part 1)     #734  optional
turnin     This Is Going to Be Hard (Part 1)     #734  optional
accept     This Is Going to Be Hard (Part 2)     #777  optional
turnin     This Is Going to Be Hard (Part 2)     #777  optional
accept     This Is Going to Be Hard (Part 3)     #778  optional
complete   This Is Going to Be Hard (Part 3)     #778  optional
           Kill the summoned elemental!
turnin     This Is Going to Be Hard (Part 3)     #778  optional

turnin     Scrounging                            #733  @53,43
           Back at the dwarfs on the hill
turnin     Tremors of the Earth (Part 1)         #732  @61,54
           Back at the blood elf. Skip the follow-up
complete   Fiery Blaze Enchantments              #706
           Kill whelps in the ravine to the east. Droprate kind sucks, you may want to skip
           this.
turnin     Fiery Blaze Enchantments              #706

zone: Loch Modan
turnin     Murdaloc                              #739  @65,65
           Back at Ironband's Excavation Site in Loch Modan. Skip the follow-up.
turnin     Badlands Reagent Run                  #2500
           Back at Thelsamar, skip the follow-up.

note       Forever extras                        optional  forever
           New Forever quests in this zone, givers not yet in the database: Safety Checks (40);
           Supplies and Studies (40); Mirage Mirror (42)
]==]
