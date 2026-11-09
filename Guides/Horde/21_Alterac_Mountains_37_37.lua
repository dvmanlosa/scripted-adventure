-- Alterac Mountains (37) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Alterac Mountains (37)
route:    Horde
faction:  Horde
levels:   37-37
zone:     Alterac Mountains
next:     Thousand Needles (37-38)

fly        Tarren Mill
zone: Hillsbrad Foothills
accept     Prison Break In              #544  @61.6,20.9
           From Magus Wordeen Voidglare
accept     Stone Tokens                 #556
           From Keeper Bel'varil
zone: Alterac Mountains
kill       Mountain Lion                @37,66  loot:5810
           Acquire Fresh Carcass from Mountain Lion, while heading towards
complete   Helcular's Revenge (Part 2)  #553  @41.7,6.4
           Flame located at
complete   Frostmaw                     #1136  @37,69
           up north

zone: Hillsbrad Foothills
complete   Stone Tokens                 #556  @20,85
           At Dalaran
zone: Alterac Mountains
complete   Prison Break In              #544  @20,85
           At

turnin     Helcular's Revenge (Part 2)  #553

goto       Tarren Mill
turnin     Prison Break In              #544
turnin     Stone Tokens                 #556
accept     Dalaran Patrols              #545
accept     Bracers of Binding           #557

complete   Bracers of Binding           #557
complete   Dalaran Patrols              #545
die        Die
           Take Rez Sickness. Back to Tarren Mill

turnin     Dalaran Patrols              #545
turnin     Bracers of Binding           #557

fly        Undercity
turnin     To Steal From Thieves        #1164
buy        Delicious Cave Mold          @63.5,39.4  [Hunter]  loot:4607x3
           Buy 3 to feed a turtle soon, at Mushroom Vendor
buy        Soothing Spices              loot:3713x3
           Buy 3 for future quest

note       Forever extras               optional  forever
           New Forever quests in this zone, givers not yet in the database: Key to the City
           (33); Friend of the Kirin Tor (33); Shrewd Negotiations (33); Blood in the Streets
           (34); Strahnbrad Mystery (36)
]==]
