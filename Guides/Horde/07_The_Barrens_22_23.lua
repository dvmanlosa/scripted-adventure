-- The Barrens (22-23) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    The Barrens (22-23)
route:    Horde
faction:  Horde
levels:   22-23
zone:     The Barrens
next:     Stonetalon Mountains (23-25)

hearth     The Crossroads

note       Abandon crab                   [Hunter]
           Get your cat back out; train new abilities

accept     Egg Hunt                       #868
fly        Camp Taurajo

turnin     Ken'zigla's Draught            #1511  [Warlock]
accept     Dogran's Captivity             #1515  [Warlock]

turnin     Jorn Skyseer                   #3261
accept     Ishamuhale                     #882
accept     Melor Sends Word               #1130
           If you haven't grabbed it already
sethearth  Camp Taurajo
note       Give Blood Shards              @45,59
           Gnoll in the cage

turnin     Dogran's Captivity             #1515  @43.3,47.9  [Warlock]
           North at one of the quilboar camps
accept     Love's Gift                    #1512  [Warlock]

kill       Owatanka                       @49,60
           He drops Owatanka's Tailspike
accept     Owatanka                       #884

complete   Egg Hunt                       #868  @43.5,71
           Southwest of Camp Taurajo at the Field of Giants.
complete   Chen's Empty Keg (Part 3)      #822
kill       Washte Pawne                   @43.1,80.9
           He drops Washte Pawne's Feather
accept     Washte Pawne                   #885
complete   Betrayal from Within (Part 1)  #879  @44.1,80
           South at Blackthorn Ridge. Kuz wanders around, Lok is in a hut on the hill to the
           west (40.13, 80.55), and Nak wanders around to the south (43.74, 83.12).
complete   Weapons of Choice              #893
           Wand is dropped by the seers, shield by warfrenzies, and backstabber by stalkers
           (stealth) and pathfinders.
accept     Gann's Reclamation             #843  @46.1,79.6
           Patrolling along Southern Gold Road
complete   Gann's Reclamation             #843  @47.2,85.2
           Southeast at Bael Modan. Kill Prospector Khazgorm for his journal, and a dozen or so
           dorfs for good measure. If you can't find Khazgorm he may be stuck in a pillar. Use
           '/target pros' to find him.
turnin     Gann's Reclamation             #843
accept     Revenge of Gann (Part 1)       #846

hearth     Camp Taurajo
turnin     Weapons of Choice              #893
turnin     Owatanka                       #884
turnin     Betrayal from Within (Part 1)  #879
           Back at Camp Taurajo (44.56, 5F9.22)
accept     Betrayal from Within (Part 2)  #906
fly        The Crossroads

turnin     Egg Hunt                       #868
turnin     Betrayal from Within (Part 2)  #906  @51.5,30.8
           Back at the Crossroads

complete   Ishamuhale                     #882  @59.7,29.9  use:10338
           Kill a Zhevra to get a carcas, then use it at the tree northwest of Ratchet to summon
           the raptor.

turnin     Further Instructions (Part 1)  #1094
           Down in Ratchet
accept     Further Instructions (Part 2)  #1095
turnin     Deepmoss Spider Eggs           #1069
turnin     Chen's Empty Keg (Part 3)      #822
turnin     The Guns of Northwatch         #891

fly        Orgrimmar                      [Warlock]
zone: Orgrimmar
turnin     Love's Gift                    #1512  @48.2,45.7  [Warlock]
           Back in the Cleft of Shadow
accept     The Binding (Part 2)           #1513  [Warlock]
complete   The Binding (Part 2)           #1513  @49.2,50  [Warlock]  use:6626
           Use the pendant and kill the sucky bus at Neeru's hut
turnin     The Binding (Part 2)           #1513  @48.2,45.6  [Warlock]
           Back at the warlock trainer

fly        Sun Rock Retreat
]==]
