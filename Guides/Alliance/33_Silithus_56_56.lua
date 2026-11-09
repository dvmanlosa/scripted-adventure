-- Silithus (56) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Silithus (56)
route:    Alliance
faction:  Alliance
levels:   56-56
zone:     Silithus
next:     Western Plaguelands (56-57)

fly        Gadgetzan                  #5163
note       Scare Sprinkle             #5163  use:12928
           Northwest side of town, use the Yeti

fly        Un'Goro Crater             #5163
note       Scare Quixxil              #5163  use:12928

fly        Silithus                   #8275
accept     The Twilight Mystery       #8284
turnin     Taking Back Silithus       #8275
accept     Securing the Supply Lines  #8280
sethearth  Cenarion Hold              #8287
accept     Deadly Desert Venom        #8277

complete   The Twilight Mystery       #8284  @22,9
           Far to the west. Kill stuff along the way for other quests. Avoid the hive and the
           silithid mobs.
complete   Deadly Desert Venom        #8277
complete   Securing the Supply Lines  #8280

hearth     Cenarion Hold              #8285
turnin     Deadly Desert Venom        #8277
accept     Noggle's Last Hope         #8278
turnin     Securing the Supply Lines  #8280
accept     Stepping Up Security       #8281
turnin     The Twilight Mystery       #8284
accept     The Deserter               #8285

turnin     Wasteland                  #1124  @81.8,18.3
           Take the road northwest to Valor's Rest
accept     The Spirits of Southwind   #1125
complete   The Spirits of Southwind   #1125  @62,53
           Follow the road southwest until you're almost back at the hold, then south to
           Southwind. Stick to the outskirts, working your way around to the south side of the
           outpost.
turnin     The Deserter               #8285  @67,69
           In a cave. Kill stuff along the way, of course.
accept     The Twilight Lexicon       #8279
complete   Noggle's Last Hope         #8278
           Work your way counter-clockwise from the cave around Hive'Regal. You can find lots of
           mobs around the south of the zone and near the road south of Cenarion Hold.
complete   Stepping Up Security       #8281

hearth     Cenarion Hold              #8281
           Or deathport
turnin     Noggle's Last Hope         #8278
accept     Noggle's Lost Satchel      #8282
turnin     Stepping Up Security       #8281

kill       Twilight Keeper Manya      #8279  @29,35  loot:20394
           Far west at the Twilight Post. Patrols along the east side. Pull her back so you
           don't get links if she fears.
kill       Twilight Keeper Havanuth   #8279  @41,41  loot:20396
           East at Twilight Base Camp. Patrols along the northeast side.
complete   Noggle's Lost Satchel      #8282  @44.6,91.3
           South on the hill behind the camp. Sneak in when Deathclasp is away.
kill       Twilight Keeper Exeter     #8279  @16,87  loot:20395
           Southwest side of Twilight Outpost. Follow the mountains along the south edge of the
           camp to avoid aggro.

turnin     The Twilight Lexicon       #8279  @67.2,69.8
           In that cave again
accept     A Terrible Purpose         #8287

turnin     The Spirits of Southwind   #1125
           At Valor's Rest
accept     Hive in the Tower          #1126
complete   Hive in the Tower          #1126  @61,52
           In the tower. Watch out for the spawns when you enter. Loot the pod, kill and loot
           one of the spawns, and get the hell out of there! After you get the encrusted object,
           you can drop the goo.
turnin     Hive in the Tower          #1126
           At Valor's Rest
accept     Umber, Archivist           #6844

hearth     Cenarion Hold              #8287
turnin     Noggle's Lost Satchel      #8282
turnin     A Terrible Purpose         #8287

fly        Moonglade                  #6845
turnin     Umber, Archivist           #6844
accept     Uncovering Past Secrets    #6845
turnin     Uncovering Past Secrets    #6845
]==]
