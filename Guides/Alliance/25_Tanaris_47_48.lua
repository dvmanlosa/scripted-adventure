-- Tanaris (47-48) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Tanaris (47-48)
route:    Alliance
faction:  Alliance
levels:   47-48
zone:     Tanaris
next:     Blasted Lands (49-50)

fly        Gadgetzan                        #3445
accept     The Thirsty Goblin               #2605
sethearth  Gadgetzan                        #113
accept     The Dunemaul Compound            #5863
accept     Thistleshrub Valley              #3362
turnin     The Sunken Temple                #3445  @52.7,45.9
           South of town at the Broken Pillar
accept     The Stone Circle                 #3444
accept     Gahz'ridian                      #3161

use        Put on the helmet                #3161  use:9978
complete   The Dunemaul Compound            #5863  @41.5,57.8
           Kill Gor'marok in a small cave at the Dunemaul Compound, then head to the ruins
           (47,66). Collect stuff for "Gahz'ridian" anytime it shows up on the minimap.
complete   Gahz'ridian                      #3161  @40,73
           Find large clusters of these in the ruins (47,66)

complete   Thistleshrub Valley              #3362  @29,66
           To the west
complete   The Thirsty Goblin               #2605

note       If you find Tooga...             #1560
           Accept his quest. He'll follow you, so you can complete "Noxious Lair Investigation"
           with him on your tail. Just make sure you leave there with at least 10 minutes left
           on his timer.
complete   Noxious Lair Investigation       #82  @34,46
           At the Noxious Lair
turnin     Tooga's Quest                    #1560  optional
accept     Yuka Screwspigot                 #4324
           Back at Steamwheedle Port
turnin     Screecher Spirits                #3520
           Skip the follow-up

turnin     The Thirsty Goblin               #2605
           Back at Gadgetzan
accept     In Good Taste                    #2606
turnin     The Dunemaul Compound            #5863
turnin     Thistleshrub Valley              #3362
turnin     In Good Taste                    #2606
accept     Sprinkle's Secret Ingredient     #2641
turnin     Noxious Lair Investigation       #82
accept     The Scrimshank Redemption        #10
           Goblin on the hill to the west
turnin     Gahz'ridian                      #3161  @52,45
           To the south

complete   The Scrimshank Redemption        #10  @55,70
           To the south at The Gaping Chasm, go to the bottom. Take the southewest entrance,
           hang left until you get to the gear (55.96, 71.17)

accept     Find OOX-17/TN!                  #351  optional
turnin     Find OOX-17/TN!                  #351  @60,64  optional
           Up in the hills north on the silithid at
accept     Rescue OOX-17/TN!                #648  optional
complete   Rescue OOX-17/TN!                #648  optional

hearth     Gadgetzan                        #113
turnin     The Scrimshank Redemption        #10
accept     Insect Part Analysis (Part 1)    #110
turnin     Insect Part Analysis (Part 1)    #110
accept     Insect Part Analysis (Part 2)    #113
turnin     Insect Part Analysis (Part 2)    #113
accept     Rise of the Silithid (Part 2)    #162

zone: Thousand Needles
turnin     An Orphan Looking For a Home     #3841  @78.4,74.7
           Up at the raceway in Shimmering Flats
accept     A Short Incubation               #3842
turnin     A Short Incubation               #3842
note       The next quest is timed!         #3843
accept     The Newest Member of the Family  #3843

fly        Theramore                        #623
turnin     Akiris by the Bundle (Part 2)    #623

fly        City of Ironforge
           Boat to Menethil, fly to IF
sethearth  Ironforge                        #3182

fly        Aerie Peak                       #4298
           Hinterlands!
turnin     The Newest Member of the Family  #3843
           In the inn, downstairs
accept     Food for Baby                    #4297

zone: The Hinterlands
complete   Sprinkle's Secret Ingredient     #2641  @40,59
           At the bottom of a lake to the east near the Altar of Zul
complete   Food for Baby                    #4297
           Kill stealth wolves to the east

turnin     Food for Baby                    #4297
           Back at the inn
accept     Becoming a Parent                #4298
turnin     Becoming a Parent                #4298

note       Forever extras                   optional  forever
           New Forever quests in this zone, givers not yet in the database: Dunemaul Dues (47)
]==]
