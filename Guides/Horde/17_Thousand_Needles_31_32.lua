-- Thousand Needles (31-32) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Thousand Needles (31-32)
route:    Horde
faction:  Horde
levels:   31-32
zone:     Thousand Needles
next:     Desolace (32-34)

hearth     Orgrimmar
fly        The Crossroads
zone: The Barrens
accept     The Swarm Grows (Part 1)       #1145  @51.1,29.6
           From Korran, west of windrider
turnin     Regthar Deathgate              #1361  @45.3,28.4
           West of the Crossroads in the bunker
accept     The Kolkar of Desolace         #1362  @45.3,28.4
           West of the Crossroads in the bunker

goto       The Shimmering Flats
           Run back to Crossroads and fly down to Thousand Needles, then follow the road east.
accept     Hemet Nesingwary               #5762
accept     Wharfmaster Dizzywig (Part 2)  #1111
accept     Rocket Car Parts               #1110
accept     Salt Flat Venom                #1104
accept     Hardened Shells                #1105
accept     Load Lightening                #1176
accept     A Bump in the Road             #1175

zone: Thousand Needles
kill       Saltstone Basilisk             @73,57
           All over the northwest quadrant of the flats. Kill all the other mobs you come across
           as well, and gather parts.
complete   Hardened Shells                #1105  @73,57
           All over the northwest quadrant of the flats.
complete   Salt Flat Venom                #1104  @73,57
           All over the northwest quadrant of the flats. There is also a nice group due west of
           the raceway NPCs (72,75).
complete   A Bump in the Road             #1175  @79,88
           Kill basilisks at Tahonda Ruins, the little lake due south of the raceway.
complete   Rocket Car Parts               #1110
complete   Load Lightening                #1176  @84.5,81.7
           There's a nice group of vultures around some bones on the southeast edge of the race
           track.

turnin     Rocket Car Parts               #1110
turnin     Hardened Shells                #1105
turnin     Salt Flat Venom                #1104

turnin     Load Lightening                #1176
accept     Goblin Sponsorship (Part 1)    #1178
turnin     A Bump in the Road             #1175  @81.6,78
           Back at the Mirage Raceway

goto       Gadgetzan
           Due south out of the zone.
flightpath Flight Path
]==]
