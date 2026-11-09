-- Tanaris (44-45) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Tanaris (44-45)
route:    Horde
faction:  Horde
levels:   44-45
zone:     Tanaris
next:     Feralas (45-46)

fly        Gadgetzan
turnin     Tran'rek                     #2864
           Skip the follow-up
accept     WANTED: Caliph Scorpidsting  #2781
           Wanted poster in front of the cage
accept     WANTED: Andre Firebeard      #2875

sethearth  Gadgetzan
accept     Wastewander Justice          #1690  @52.5,28.5
           Between the bank and the inn
accept     Water Pouch Bounty           #1707
accept     Gadgetzan Water Survey       #992  @50.2,27.5
           Southwest side of town on a hill

zone: Thousand Needles
goto       Mirage Raceway               @77.8,77.3
           In the Shimmering Flats
turnin     Rumors for Kravel            #1117
accept     Back to Booty Bay            #1118
turnin     News for Fizzle              #1137
turnin     Razzeric's Tweaking          #1187
accept     Safety First                 #1188
accept     Keeping Pace                 #1190
turnin     Keeping Pace                 #1190  @79.8,77
           At Zamek, then go pick up Rizzle's Plans
accept     Rizzle's Schematics          #1194

turnin     Rizzle's Schematics          #1194
           At Pozzik

hearth     Gadgetzan
turnin     Safety First                 #1188
           Skip the follow-up

zone: Tanaris
note       Noonshade Ruins              @60,24
           Begin Wastewander Justice & Water Pouch Bounty

goto       Steamwheedle Port
accept     Pirate Hats Ahoy!            #8365
accept     Screecher Spirits            #3520
turnin     Stoley's Debt                #2872
accept     Stoley's Shipment            #2873
accept     Southsea Shakedown           #8366

complete   Water Pouch Bounty           #1707  @64,29
           At Waterspring Field
complete   Wastewander Justice          #1690
           Watch for Caliph Scorpidsting as well

complete   WANTED: Andre Firebeard      #2875  @73.4,47.1
           At Lost Rigger Cove
complete   Stoley's Shipment            #2873  @72.1,46.7
           Upstairs in the northern building
complete   Pirate Hats Ahoy!            #8365
complete   Southsea Shakedown           #8366

hearth     Gadgetzan
turnin     Water Pouch Bounty           #1707
turnin     Wastewander Justice          #1690
accept     More Wastewander Justice     #1691
complete   Gadgetzan Water Survey       #992  @38,29
           Grind mobs along the way, at
turnin     Gadgetzan Water Survey       #992
           Skip the follow-up

turnin     Pirate Hats Ahoy!            #8365
           Back at Steamwheedle Port
turnin     Stoley's Shipment            #2873
accept     Deliver to MacKinley         #2874
turnin     Southsea Shakedown           #8366
turnin     WANTED: Andre Firebeard      #2875
accept     Ship Schedules               #2876  use:9250  optional
turnin     Ship Schedules               #2876  optional

complete   More Wastewander Justice     #1691  @59,37
           At Waterspring Field
complete   WANTED: Caliph Scorpidsting  #2781

hearth     Gadgetzan
turnin     More Wastewander Justice     #1691
turnin     WANTED: Caliph Scorpidsting  #2781
note       Save Pouches
           Keep 5x Wastewander Water Pouches for later

note       Forever extras               optional  forever
           New Forever quests in this zone, givers not yet in the database: Overseas Delivery
           (38); Gritty Business (45); Dunemaul Dues (47)
]==]
