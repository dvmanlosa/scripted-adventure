-- The Hinterlands (46-47) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    The Hinterlands (46-47)
route:    Alliance
faction:  Alliance
levels:   46-47
zone:     The Hinterlands
next:     Feralas (47)

fly        Southshore
           Fly to Theramore, boat to Menethil, fly to Southshore
zone: Hillsbrad Foothills
goto       The Hinterlands           @84,33
           Path is behind Durnholde Keep, look for two gryphons.
zone: The Hinterlands
accept     Witherbark Cages          #2988  @11,46
           Up the big-ass hill
accept     Skulk Rock Clean-up       #2877
           In the inn, to the right
accept     Troll Necklace Bounty     #2880
sethearth  Wildhammer Keep           #2989

note       Check First Cage          #2988  @23,58
           At the troll camp
note       Check Second Cage         #2988  @23,58
           At the troll camp
complete   Witherbark Cages          #2988  @31,57
           Last cage is to the east
complete   Troll Necklace Bounty     #2880
           Kill any trolls you can find if you don't have all your necklaces
complete   Skulk Rock Clean-up       #2877  @46,42
           Northeast at Agor'watha
complete   The Super Snapper FX      #2944  @81,46  use:9328
           Jump off the waterfall at the east edge of the zone. Run south along the shore. Find
           tho aggro turtle and take it's picture.
complete   Whiskey Slim's Lost Grog  #580

hearth     Aerie Peak                #2989
turnin     Skulk Rock Clean-up       #2877
turnin     Troll Necklace Bounty     #2880
turnin     Witherbark Cages          #2988
           Up in the cave
accept     The Altar of Zul          #2989

complete   The Altar of Zul          #2989  @48,68
           East at the Altar of Zul. Just run up the altar and back down, the mob at the top is
           level 50.
complete   Favored of Elune?         #3661

accept     Find OOX-09/HL!           #485  use:8704  optional
turnin     Find OOX-09/HL!           #485  @49,37  optional
           On an island north of Agor'watha
accept     Rescue OOX-09/HL!         #836  optional
complete   Rescue OOX-09/HL!         #836  optional
           Just abandon if you fail.

hearth     Aerie Peak                #2989
turnin     The Altar of Zul          #2989
           Cave again
accept     Thadius Grimshade         #2990

fly        Rut'theran Village        #2943
turnin     Favored of Elune?         #3661
turnin     The Super Snapper FX      #2944
accept     Return to Troyas          #2943

buy        [Elixir of Fortitude] x2  #3842  loot:3825x2
           From the auction house or find yourself an alchemist. You can skip this if you did
           not do the "Freedom for All Creatures" questline or don't plan to continue it.
]==]
