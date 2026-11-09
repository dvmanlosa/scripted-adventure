-- Thousand Needles (37-38) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Thousand Needles (37-38)
route:    Horde
faction:  Horde
levels:   37-38
zone:     Thousand Needles
next:     Dustwallow Marsh (38)

fly        Orgrimmar
           Take the zeppelin!
zone: Orgrimmar
turnin     Alliance Relations (Part 4)  #1436  @21,53
           Keldran in the Valley of Spirits
fly        The Crossroads
sethearth  The Crossroads

fly        Freewind Post
note       Stable Pet                   [Hunter]
zone: Thousand Needles
turnin     The Swarm Grows (Part 2)     #1146  @67.6,64
           Follow the road east to the edge of the flats. There's a little camp to the south.
accept     The Swarm Grows (Part 3)     #1147
petskill   Bite (Rank 5)                @78,70  [Hunter]
           Tame a Sparkleshell Snapper

turnin     Parts for Kravel             #1112  @77.8,77.2
           At the Mirage Raceway
accept     Delivery to the Gnomes       #1114
turnin     Delivery to the Gnomes       #1114
accept     Martek the Exiled            #1106
accept     The Rumormonger              #1115
turnin     Goblin Sponsorship (Part 5)  #1183
accept     The Eighteenth Pilot         #1186
turnin     The Eighteenth Pilot         #1186
accept     Razzeric's Tweaking          #1187

complete   The Swarm Grows (Part 3)     #1147

accept     Parts of the Swarm (Part 1)  #1148  use:5877
           Kill silithid to the south until the item drops to start this.
complete   Parts of the Swarm (Part 1)  #1148

turnin     The Swarm Grows (Part 3)     #1147

hearth     The Crossroads
note       Abandon Pet                  [Hunter]
           Get original pet back
turnin     Parts of the Swarm (Part 1)  #1148
accept     Parts of the Swarm (Part 2)  #1184

note       Forever extras               optional  forever
           New Forever quests in this zone, givers not yet in the database: Lost Shipping Crate
           (38)
]==]
