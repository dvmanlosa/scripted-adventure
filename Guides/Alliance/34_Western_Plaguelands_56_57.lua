-- Western Plaguelands (56-57) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Western Plaguelands (56-57)
route:    Alliance
faction:  Alliance
levels:   56-57
zone:     Western Plaguelands
next:     Eastern Plaguelands (57-58)

fly        Stormwind City                      #5066
sethearth  Stormwind City                      #5163
accept     A Call to Arms: The Plaguelands!    #5066
           From Crier Goodman, he patrols all over the city.

turnin     Return to Tymor                     #3461  optional
           In Ironforge, of course

goto       Western Plaguelands                 #5066
           Fly to Southshore then follow the road north out of the zone, east thru Alterac until
           you come to Chillwind Camp.
accept     A Plague Upon Thee (Part 1)         #5903
turnin     A Call to Arms: The Plaguelands!    #5066
accept     Clear the Way                       #5092
turnin     The Everlook Report                 #6028
note       Get a Commission                    #5092  loot:12846
           Talk to the quartermaster and get a commission, you should have this equipped any
           time you are in the plaguelands. Turn in any scourgestones you get when you are in
           town if you have a full stack.

complete   Clear the Way                       #5092
           To the northeast at Sorrow Hill
turnin     Clear the Way                       #5092
accept     All Along the Watchtowers           #5097
accept     The Scourge Cauldrons               #5215
turnin     The Scourge Cauldrons               #5215
accept     Target: Felstone Field              #5216

complete   All Along the Watchtowers           #5097  @47,71  use:12815
           Mark each tower in Andorhal, you can get close enough to mark without aggroing mobs
           inside if you are careful. (40,71) (42,66) (44,63)
complete   Target: Felstone Field              #5216  @37,56
           To the northwest at Felstone Field. Kill Cauldron Lord Bilemaw for the key, then talk
           to the cauldren.
turnin     Target: Felstone Field              #5216
           Talk to the cauldren
accept     Return to Chillwind Camp (Part 1)   #5217

accept     Better Late Than Never (Part 1)     #5021  @38,54
           In the house on the northeast side of the field, upstairs
turnin     Better Late Than Never (Part 1)     #5021  @38.8,55.2
           Next door in the barn, talk to the box
accept     Better Late Than Never (Part 2)     #5022

turnin     All Along the Watchtowers           #5097
           Back in Chillwind Camp
accept     Scholomance                         #5533
turnin     Scholomance                         #5533
accept     Skeletal Fragments                  #5537
turnin     Return to Chillwind Camp (Part 1)   #5217
accept     Target: Dalson's Tears              #5219

complete   Target: Dalson's Tears              #5219  @46,52
           To the north at Dalson's Tears. Kill Cauldron Lord Malvinious for the key, then talk
           to the cauldren.
turnin     Target: Dalson's Tears              #5219
           Talk to the cauldren
accept     Return to Chillwind Camp (Part 2)   #5220

note       Read Mrs. Dalson's Diary            #5060  @47.8,50.7
           On the floor in the barn. Nothing to accept, just read the book.
kill       Wandering Skeleton                  #5060  loot:12738
           Patrols around the house and barn, you are looking for the outhouse key. Scarlets
           might kill this mob.
kill       Farmer Dalson                       #5060  loot:12739
           Open the outhouse, get his key
note       Open cabinet                        #5060  loot:13475
           Locked cabinet upstairs in the house.

turnin     Return to Chillwind Camp (Part 2)   #5220
accept     Target: Writhing Haunt              #5222

hearth     Stormwind City                      #6184
zone: Stormwind City
turnin     Better Late Than Never (Part 2)     #5022  @64,61.7
           On the northeast side of Cathedral Square
accept     Good Natured Emma                   #5048
turnin     Good Natured Emma                   #5048
           She patrols between the cathedral and trade district
accept     Good Luck Charm                     #5050
accept     The First and the Last              #6182  @81.5,54.2
           In Stormwind Keep
turnin     The First and the Last              #6182  @80.3,79.3
           Old Town
accept     Honor the Dead                      #6183
turnin     Honor the Dead                      #6183
accept     Flint Shadowmore                    #6184

fly        Western Plaguelands                 #6185
turnin     Flint Shadowmore                    #6184
accept     The Eastern Plagues                 #6185

zone: Western Plaguelands
turnin     Good Luck Charm                     #5050  @38,54
           At the house at Felstone Field
accept     Two Halves Become One               #5051
complete   Two Halves Become One               #5051  use:12722
           Go out in the field and kill the Jabbering Ghoul (only one with a pitchfork), then
           combine the pieces.
turnin     Two Halves Become One               #5051

complete   Target: Writhing Haunt              #5222  @53,65
           To the southeast at Writhing Haunt. Kill Cauldron Lord Razarch for the key, then talk
           to the cauldren.
turnin     Target: Writhing Haunt              #5222
           Talk to the cauldren
accept     Return to Chillwind Camp (Part 3)   #5223

accept     The Wildlife Suffers Too (Part 1)   #4984  @53.7,64.7
           In the house by the field
complete   The Wildlife Suffers Too (Part 1)   #4984
           To the north, between the Felstone and Dalson's Fields, and north of Dalson's Field.
turnin     The Wildlife Suffers Too (Part 1)   #4984
accept     The Wildlife Suffers Too (Part 2)   #4985

turnin     Return to Chillwind Camp (Part 3)   #5223
           Back at Chillwind Camp
accept     Target: Gahrron's Withering         #5225

complete   The Wildlife Suffers Too (Part 2)   #4985  @52,56
           East, between Writhing Haunt and Gahrron's Withering

complete   Target: Gahrron's Withering         #5225  @62,58
           To the east at Writhing Haunt. Kill Cauldron Lord Soulwrath for the key, then talk to
           the cauldren.
turnin     Target: Gahrron's Withering         #5225
           Talk to the cauldren
accept     Return to Chillwind Point (Part 4)  #5226

turnin     The Wildlife Suffers Too (Part 2)   #4985

turnin     Return to Chillwind Point (Part 4)  #5226
           Back at Chillwind Camp, of course.
note       Mission Accomplished!               #5238
           Talk to Commander Ashlam Valorfist
]==]
