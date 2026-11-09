-- Tanaris (43) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Tanaris (43)
route:    Alliance
faction:  Alliance
levels:   43-43
zone:     Tanaris
next:     Feralas (43-45)

goto       Gadgetzan                    #1690
           Boat to Ratchet, fly down to Dustwallow, run west into the Barrens, then south thru
           Thousand Needles and Shimmering Flats to Tanaris.
accept     Wastewander Justice          #1690
accept     Water Pouch Bounty           #1707
sethearth  Gadgetzan                    #2781
accept     WANTED: Andre Firebeard      #2875
           Wanted sign in front of the cage
turnin     Tran'rek                     #2864
           Don't accept the follow-up
accept     Gadgetzan Water Survey       #992
           Southwest side of town on a hill

goto       Steamwheedle Port            #8365
accept     WANTED: Caliph Scorpidsting  #2781
turnin     Stoley's Debt                #2872
accept     Stoley's Shipment            #2873
accept     Southsea Shakedown           #8366
accept     Pirate Hats Ahoy!            #8365
accept     Screecher Spirits            #3520

complete   Wastewander Justice          #1690  @61,24
           At Noonshade Ruins or to the southeast (63,30).
complete   Water Pouch Bounty           #1707
complete   WANTED: Andre Firebeard      #2875  @68,41
           Thru the cave on the shore, Andre is in the center of the port (73,47)
complete   Stoley's Shipment            #2873  @72,46
           On the second floor of the house
complete   Southsea Shakedown           #8366
complete   Pirate Hats Ahoy!            #8365

hearth     Gadgetzan                    #1690
turnin     Water Pouch Bounty           #1707
turnin     Wastewander Justice          #1690
accept     More Wastewander Justice     #1691

complete   Gadgetzan Water Survey       #992  @39,29  use:8584
           To the west at a pool past the troll outpost. Two big bugs spawn, be ready to run.
turnin     Gadgetzan Water Survey       #992
accept     Noxious Lair Investigation   #82
complete   More Wastewander Justice     #1691  @60,35
           Around the western Wastewander camp.
complete   WANTED: Caliph Scorpidsting  #2781  @59,39.3
           Spawns at the far-west camp and patrols to the other camps.

turnin     Stoley's Shipment            #2873
           Back at Steamwheedle Port
accept     Deliver to MacKinley         #2874
accept     Ship Schedules               #2876  use:9250  optional
turnin     Ship Schedules               #2876  optional
turnin     WANTED: Andre Firebeard      #2875
turnin     Southsea Shakedown           #8366
turnin     Pirate Hats Ahoy!            #8365

hearth     Gadgetzan                    #2781
turnin     More Wastewander Justice     #1691
turnin     WANTED: Caliph Scorpidsting  #2781
accept     Handle With Care             #3022

note       Forever extras               optional  forever
           New Forever quests in this zone, givers not yet in the database: Overseas Delivery
           (38); Gnomish Garbage (45)
]==]
