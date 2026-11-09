-- Feralas (47) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Feralas (47)
route:    Alliance
faction:  Alliance
levels:   47-47
zone:     Feralas
next:     Tanaris (47-48)

fly        Feathermoon Stronghold        #2879
sethearth  Feathermoon Stronghold        #2942
turnin     Return to Troyas              #2943
accept     The Stave of Equinex          #2879
accept     The Sunken Temple             #3445
accept     Zapped Giants                 #7003
           On the mainland at the dock
accept     Fuel for the Zapping          #7721

complete   Zapped Giants                 #7003  use:18904
complete   Fuel for the Zapping          #7721
turnin     Zapped Giants                 #7003
turnin     Fuel for the Zapping          #7721

complete   Improved Quality              #7733  @51,31
           North at Rage Scar Hold

accept     The Giant Guardian            #2844  @42,22
           Find the giant "Rockbiter" north near the twin colossals
complete   The Stave of Equinex          #2879  @38.5,15.8  use:9263
           Northwest at the Ruins of Ravenwind. Find the essences, (40.55, 12.64), (39.93,
           9.46), (37.76, 12.15). Use the staff at the monolith (38.8, 13.1)
turnin     The Stave of Equinex          #2879
accept     The Morrow Stone              #2942
turnin     The Giant Guardian            #2844  @38.2,10.3
           Back near the last flame
accept     Wandering Shay                #2845
complete   Wandering Shay                #2845  use:9189
           Grab the bell from the chest, use it if she wanders away
turnin     Wandering Shay                #2845

hearth     Feathermoon Stronghold        #2942
turnin     Improved Quality              #7733
accept     Pristine Yeti Hide            #7735  use:18969  optional
turnin     Pristine Yeti Hide            #7735  optional
turnin     The Morrow Stone              #2942
accept     The Sunken Temple             #3445

accept     An Orphan Looking For a Home  #3841  @65.9,45.6
           East at the grimtotem camp
goto       Thalanaar                     #4281
           Follow the road east to the border of Thousand Needles. Watch out for the horde town!
accept     Thalanaar Delivery            #4281  use:11463
           You should have recieved a quest starting item when you raided the leather backpacks
           in an earlier guide. If not, skip this
turnin     Thalanaar Delivery            #4281

note       Forever extras                optional  forever
           New Forever quests in this zone, givers not yet in the database: Mirrorscale (50)
]==]
