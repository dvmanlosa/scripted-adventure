-- Winterspring (54-55) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Winterspring (54-55)
route:    Alliance
faction:  Alliance
levels:   54-55
zone:     Winterspring
next:     Burning Steppes (55-56)

goto       Moonglade                            #8465  [not Druid]
           You need to be Unfriendly or higher and not At War with the Timbermaw Hold to go
           through the cave
zone: Moonglade
flightpath Get Fight Point                      #8465  @48.1,67.3  [not Druid]

goto       Winterspring                         #8465
           You need to be Unfriendly or higher and not At War with the Timbermaw Hold to go
           through the cave
turnin     Speak to Salfa                       #8465
accept     Winterfall Activity                  #8464
note       Grab feathers you see                #978
           For "Moontouched Wildkin"
zone: Winterspring
turnin     The New Springs                      #980  @31.3,45.2
           To the south near the hot springs
accept     Strange Sources                      #4842
turnin     It's a Secret to Everybody (Part 3)  #3908
           Skip the follow-up.
accept     Threat of the Winterfall             #5082

goto       Everlook
           Follow the road east
accept     Enraged Wildkin (Part 1)             #6604
sethearth  Everlook                             #977
accept     The Everlook Report                  #6028
accept     Duke Nicholas Zverenhoff             #6030
accept     Sister Pamela                        #5601
accept     Are We There, Yeti? (Part 1)         #3783

complete   Strange Sources                      #4842  @60.1,73.4
           Follow the road far to the south

hearth     Everlook                             #977
complete   Are We There, Yeti? (Part 1)         #3783
           Just southeast of town. Kill yeti outside the cave.
turnin     Are We There, Yeti? (Part 1)         #3783
           Back in Everlook
accept     Are We There, Yeti? (Part 2)         #977
complete   Are We There, Yeti? (Part 2)         #977  @67,42
           Back in the yeti cave
turnin     Are We There, Yeti? (Part 2)         #977
accept     Are We There, Yeti? (Part 3)         #5163
note       Scare Legacki                        #5163  use:12928
           East of the inn, use the Yeti

complete   Winterfall Activity                  #8464  @66,34
           East of town
turnin     To Winterspring!                     #5249  optional
turnin     Starfall                             #5250  optional
accept     The Ruins of Kel'Theril              #5244
turnin     Enraged Wildkin (Part 1)             #6604
           Skip the follow-up
turnin     The Ruins of Kel'Theril              #5244
accept     Troubled Spirits of Kel'Theril       #5245

complete   Troubled Spirits of Kel'Theril       #5245  @55.1,42.9
           Find the relics scattered around Ruins of Kel'Theril, (53.34, 43.41), (52.43, 41.52)
           (50.89, 41.73)
complete   Threat of the Winterfall             #5082  @30,37
           Kill furblogs near the hot springs or south of the road east of the springs (39,43)
complete   Moontouched Wildkin                  #978
accept     Winterfall Firewater                 #5083  use:12771
           Kill furblogs until you get an Empty Firewater Flask
turnin     Strange Sources                      #4842
           Back at the camp near the south spring
turnin     Threat of the Winterfall             #5082
turnin     Winterfall Firewater                 #5083
accept     Falling to Corruption                #5084
turnin     Winterfall Activity                  #8464
           Back up at the entrance to Timbermaw Hold

goto       Felwood                              #5085
zone: Felwood
turnin     Falling to Corruption                #5084  @60.2,5.9
           Talk to the cauldron in the Deadwood furbolg camp
accept     Mystery Goo                          #5085
turnin     Mystery Goo                          #5085
           Back in Winterspring. Skip the follow-up.

fly        Rut'theran Village                   #6762
turnin     Moontouched Wildkin                  #978
           Skip the follow-up

accept     The New Frontier (Part 1)            #1047
           From Herald Moonstalker in Darnassus, she wanders in a figure eight around town and
           across the bridge. From the bank run north and around coming back across the bridge,
           then south and around until you find her. She also walks behind the bank!
turnin     The New Frontier (Part 1)            #1047
accept     The New Frontier (Part 2)            #6761
turnin     The New Frontier (Part 2)            #6761
accept     Rabine Saturna                       #6762

fly        Moonglade                            #1124
           Teleport there if you are a Druid, or fly to Talonbranch Glade and run there if you
           didn't get the flight path earlier
zone: Moonglade
turnin     Rabine Saturna                       #6762  @51.7,45
           In Nighthaven
accept     Wasteland                            #1124
]==]
