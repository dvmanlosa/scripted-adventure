-- Duskwood (28-29) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Duskwood (28-29)
route:    Alliance
faction:  Alliance
levels:   28-29
zone:     Duskwood
next:     Ashenvale (29-30)

fly        Stormwind City                  #1243
accept     The Missing Diplomat (Part 1)   #1274
           From altar boy Thomas in the Cathedral
zone: Stormwind City
turnin     The Missing Diplomat (Part 1)   #1274  @79.8,42.6
           In Stormwind Keep
accept     The Missing Diplomat (Part 2)   #1241
turnin     The Missing Diplomat (Part 2)   #1241  @76.2,84.8
           At the entrance to Stormwind, fishing
accept     The Missing Diplomat (Part 3)   #1242
turnin     The Missing Diplomat (Part 3)   #1242  @66.2,74.3
           In the cheese shop in the Trade District
accept     The Missing Diplomat (Part 4)   #1243

buy        [Bronze Tube]                   #174  loot:4371
           Engineering vendor sells this sometimes, but auction or an engineer are your best
           bets. Needed for "Look To The Stars".

goto       Darkshire                       #66
           Usually faster to fly to Redridge and take the road southwest
turnin     The Missing Diplomat (Part 4)   #1243
           North of Darkshire walking along the road
accept     The Missing Diplomat (Part 5)   #1244
accept     The Legend of Stalvan (Part 1)  #66
accept     The Totem of Infliction         #101
sethearth  Darkshire                       #158
accept     The Night Watch (Part 1)        #56
turnin     The Legend of Stalvan (Part 1)  #66
           Skip the follow-up
accept     Worgen in the Woods (Part 1)    #173
accept     Raven Hill                      #163
accept     The Hermit                      #165
accept     Deliveries to Sven              #164
accept     Look To The Stars (Part 1)      #174
           Southeast from flight point in the house
complete   Look To The Stars (Part 1)      #174
           If you don't have have a tube, Herble Baubbletump sells them in limited supply.
turnin     Look To The Stars (Part 1)      #174
accept     Look To The Stars (Part 2)      #175

zone: Duskwood
complete   Worgen in the Woods (Part 1)    #173  @64,46
           West of Darkshire in the Brightwood Grove

turnin     Worgen in the Woods (Part 1)    #173
           Back in Darkshire
accept     Worgen in the Woods (Part 2)    #221

complete   Worgen in the Woods (Part 2)    #221
           West of Darkshire in the Brightwood Grove again

turnin     Worgen in the Woods (Part 2)    #221
accept     Worgen in the Woods (Part 3)    #222
turnin     Look To The Stars (Part 2)      #175  @82,59.4
           Southeast of Duskwood in a small farmhouse
accept     Look To The Stars (Part 3)      #177

complete   Look To The Stars (Part 3)      #177  @80.8,71.5
           Southwest, up the hill from the farm in the Tranquil Gardens Cemetery chapel
complete   The Night Watch (Part 1)        #56
complete   Worgen in the Woods (Part 3)    #222  @72.8,73.4
           Southwest of Tranquil Gardens Cemetery

hearth     Darkshire                       #158
turnin     The Night Watch (Part 1)        #56
accept     The Night Watch (Part 2)        #57
turnin     Worgen in the Woods (Part 3)    #222
accept     Worgen in the Woods (Part 4)    #223
turnin     Worgen in the Woods (Part 4)    #223

turnin     Look To The Stars (Part 3)      #177  @79.8,47.9
           Southeast of Darkshire, in a shack
accept     Look To The Stars (Part 4)      #181

complete   Look To The Stars (Part 4)      #181  @36.1,80.5
           At Vol'Gol Ogre Mound southwest of the crossroads at the center of the zone, in a
           cave
complete   The Missing Diplomat (Part 5)   #1244  @24,72.2
           West of the orge mound at Adlle's Stead

turnin     Raven Hill                      #163
           In Raven Hill Cemetery
complete   The Night Watch (Part 2)        #57
turnin     The Hermit                      #165  @28,31.5
           Shack northeast of the cemetery
accept     Supplies from Darkshire         #148
accept     The Weathered Grave             #225  @17.7,29
           Grave to the west on the Darkened Bank
turnin     Deliveries to Sven              #164  @8,34
           Further west at the Hushed Bank
accept     Sven's Revenge                  #95

hearth     Darkshire                       #158
turnin     The Night Watch (Part 2)        #57
accept     The Night Watch (Part 3)        #58
turnin     The Weathered Grave             #225
accept     Morgan Ladimore                 #227
turnin     Morgan Ladimore                 #227
turnin     Supplies from Darkshire         #148
accept     Ghost Hair Thread               #149
turnin     The Missing Diplomat (Part 5)   #1244
           North of Darkshire walking along the road
accept     The Missing Diplomat (Part 6)   #1245
turnin     Look To The Stars (Part 4)      #181

turnin     Ghost Hair Thread               #149  @82,59.4
           Southeast of Duskwood in a small farmhouse
accept     Return the Comb                 #154

turnin     Return the Comb                 #154
           Back in Durkshire
accept     Deliver the Thread              #157

turnin     Sven's Revenge                  #95  @49,77
           Find the dirt mound at The Yorgen Farmstead
accept     Sven's Camp                     #230

turnin     Deliver the Thread              #157
           Shack north of the cemetery
accept     Zombie Juice                    #158

complete   The Night Watch (Part 3)        #58  @23.5,35.4
           Down in the Dawning Wood Catacombs
complete   The Totem of Infliction         #101  @32,38
           Ghoul fangs only seem to drop in the catacombs. If you don't get enough venom in the
           cemetery, kill Black Widow Hatchlings on the ridge east of the cemetery.

turnin     Sven's Camp                     #230  @8,34
           Camp to the west
accept     The Shadowy Figure              #262

goto       Stranglethorn Vale              #158
           Take the road east towards Darkshire, but head south at the fork in the center of the
           zone.
zone: Stranglethorn Vale
fly        Darkshire                       @38.1,3.8
           There is a flight point at the Rebel Camp along the north edge of STV
turnin     The Totem of Infliction         #101
turnin     The Shadowy Figure              #262
accept     The Shadowy Search Continues    #265
turnin     The Night Watch (Part 3)        #58
turnin     The Shadowy Search Continues    #265
accept     Inquire at the Inn              #266
turnin     Inquire at the Inn              #266
turnin     Zombie Juice                    #158

fly        Stormwind City                  #1248
turnin     The Missing Diplomat (Part 6)   #1245
           Back at the cheese shop
accept     The Missing Diplomat (Part 7)   #1246
turnin     The Missing Diplomat (Part 7)   #1246
           In an alley in Old Town
accept     The Missing Diplomat (Part 8)   #1447
complete   The Missing Diplomat (Part 8)   #1447
turnin     The Missing Diplomat (Part 8)   #1447
accept     The Missing Diplomat (Part 9)   #1247
accept     An Old History Book             #337  use:2794  optional
turnin     An Old History Book             #337  optional
           Turn in to the Stormwind Library.
accept     Southshore                      #538  optional
turnin     The Missing Diplomat (Part 9)   #1247
           Back at the cheese shop
accept     The Missing Diplomat (Part 10)  #1248

note       Forever extras                  optional  forever
           New Forever quests in this zone, givers not yet in the database: The Valor Family
           (23); Ira's Dagger (25); Merrick's Bow (30)
]==]
