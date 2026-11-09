-- Thousand Needles (25-26) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Thousand Needles (25-26)
route:    Horde
faction:  Horde
levels:   25-26
zone:     Thousand Needles
next:     Ashenvale (26-28)

turnin     Message to Freewind Post  #4542  @45.5,50.8
           Follow the road southeast to Freewind Post.
accept     Pacify the Centaur        #4841
accept     Wanted - Arnak Grimtotem  #5147
accept     Alien Egg                 #4821
accept     Wind Rider                #4767
flightpath Flight Path

complete   Pacify the Centaur        #4841
           Just north of Freewind
accept     Test of Faith             #1149  @54,41.6
           In the Weathered Nook, northeast of Freewind.
complete   Test of Faith             #1149
           *WALK* off the platform, do *NOT* jump.
turnin     Test of Faith             #1149
           Skip the follow-up
complete   A New Ore Sample          #1153
           Kill kobolds around the east end of the needles. Skip this if you can't get the drop,
           the mobs are sparse.
complete   Alien Egg                 #4821  @56.5,50.4
           Look for windserpent nests. There are two east of Freewind (52.5, 55.2) and one
           southwest (37.7, 56.1).

turnin     Pacify the Centaur        #4841  @45.7,50.6
           Back at Freewind Post
accept     Grimtotem Spying          #5064
turnin     Alien Egg                 #4821
accept     Serpent Wild              #4865

hearth     Camp Taurajo
zone: The Barrens
turnin     A New Ore Sample          #1153  @45.1,57.8
           Back at Camp Taurajo.
turnin     Enraged Thunder Lizards   #907
accept     Cry of the Thunderhawk    #913
complete   Cry of the Thunderhawk    #913
turnin     Cry of the Thunderhawk    #913
           Skip the follow-up

zone: Thunder Bluff
note       Get Cooking               @51,53
           If you haven't already, go to the trainer at

accept     The Sacred Flame          #1195
turnin     Melor Sends Word          #1130  @61.4,80.4
           Fly to Thunder Bluff, on Hunter Rise.
accept     Steelsnap                 #1131
fly        Splintertree Post
]==]
