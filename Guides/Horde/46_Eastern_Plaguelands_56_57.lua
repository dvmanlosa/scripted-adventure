-- Eastern Plaguelands (56-57) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Eastern Plaguelands (56-57)
route:    Horde
faction:  Horde
levels:   56-57
zone:     Eastern Plaguelands
next:     Western Plaguelands (57-59)

accept     Demon Dogs                   #5542  @2.5,30.7
           Fly to the east edge of WPL, run across the bridge into EPL and follow the river
           north.
accept     Blood Tinged Skies           #5543
accept     Carrion Grubbage             #5544

note       Kill crap...
           Kill any plaguehounds, carrion worms, and plaguebats you encounter.
accept     Un-Life's Little Annoyances  #6042  @19,57.6
           Follow the road east to the Marris Stead.
accept     To Kill With Purpose         #6022

turnin     Sister Pamela                #5601
accept     Pamela's Doll                #5149
complete   Pamela's Doll                #5149
           Parts are found in the houses nearby. Ghosts spawn when you get near them.
turnin     Pamela's Doll                #5149
accept     Auntie Marlene               #5152
accept     Uncle Carlin                 #5241

kill       Plaguehounds                 #5542
           All over the southwestern section of the zone
complete   Blood Tinged Skies           #5543

turnin     Uncle Carlin                 #5241  @71.2,48.4
           East at Light's Hope Chapel
accept     Defenders of Darrowshire     #5211
accept     The Restless Souls           #5281
turnin     Duke Nicholas Zverenhoff     #6030
sethearth  Light's Hope Chapel
accept     Zaeldarr the Outcast         #6021  @69.4,52.9
           Southwest near the corpse pits

note       Free Spirits...
           Kill any cannibal ghouls, gibbering ghouls and diseased flayers you come across.
           Speak to any ghosts that spawn for "Defenders of Darrowshire".
complete   Demon Dogs                   #5542
complete   A Plague Upon Thee (Part 1)  #5901

complete   To Kill With Purpose         #6022
complete   Defenders of Darrowshire     #5211
complete   Carrion Grubbage             #5544
complete   Un-Life's Little Annoyances  #6042

turnin     The Restless Souls           #5281
accept     Augustus' Receipt Book       #6164
complete   Augustus' Receipt Book       #6164
turnin     Augustus' Receipt Book       #6164

hearth     Light's Hope Chapel
turnin     Defenders of Darrowshire     #5211

turnin     Demon Dogs                   #5542
           Fly back over to the border of WPL/EPL, of course.
turnin     Blood Tinged Skies           #5543
turnin     Carrion Grubbage             #5544
accept     Redemption                   #5742
complete   Redemption                   #5742
           Blah blah blah... he talks to much.
turnin     Redemption                   #5742
accept     Of Forgotten Memories        #5781

turnin     To Kill With Purpose         #6022
turnin     Un-Life's Little Annoyances  #6042

complete   Of Forgotten Memories        #5781  @20.5,68.3
           South at the Undercroft. Talk to the grave and Mercutio and his adds will walk in
           (not spawn). Try to pull him away from the adds, kill and loot him, and get out. You
           might need help.
complete   Zaeldarr the Outcast         #6021  @19.8,66.8
           Inside the crypt at the bottom

turnin     Of Forgotten Memories        #5781
]==]
