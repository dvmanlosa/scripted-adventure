-- Eastern Plaguelands (57-58) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Eastern Plaguelands (57-58)
route:    Alliance
faction:  Alliance
levels:   57-58
zone:     Eastern Plaguelands
next:     Western Plaguelands (58)

goto       Eastern Plaguelands          #5601
           Don't mis the flight point on the river!
accept     Demon Dogs                   #5542  @2.5,30.9
           Follow the river north
accept     Blood Tinged Skies           #5543
accept     Carrion Grubbage             #5544

note       Kill crap...                 #5544
           Kill any plaguehounds, carrion worms, and plaguebats you encounter in EPL for each
           respective quest.
complete   The Eastern Plagues          #6185  @21,62
           Around the Marris Stead, just north of the road. Rutger, Fredo (19.6, 57.9), Turyen
           (21.0, 57.8)

turnin     Sister Pamela                #5601  @27.6,71.5
           In a house in Darrowshire
accept     Pamela's Doll                #5149
complete   Pamela's Doll                #5149
           Parts are found in the houses nearby. Ghosts spawn when you get near them.
turnin     Pamela's Doll                #5149
accept     Auntie Marlene               #5152
accept     Uncle Carlin                 #5241

kill       Plaguehound Runts            #5542
           All over the southwestern section of the zone
complete   Blood Tinged Skies           #5543

turnin     Uncle Carlin                 #5241  @66.4,44.7
           East at Light's Hope Chapel
accept     Defenders of Darrowshire     #5211
turnin     Duke Nicholas Zverenhoff     #6030
accept     Zaeldarr the Outcast         #6021  @64.9,48.2
           Southwest near the corpse pits

note       Free Spirits...              #5211
           Kill any cannibal ghouls, gibbering ghouls and diseased flayers you come across.
           Speak to any ghosts that spawn for "Defenders of Darrowshire".
complete   Demon Dogs                   #5542
           Plaguehounds near Light's Hope to the east, Frenzied Plaguehound in the north half of
           the zone.
complete   A Plague Upon Thee (Part 1)  #5903
           Find termite mounds all around the northern part of the zone.
complete   Carrion Grubbage             #5544
]==]
