-- Redridge Mountains (27-28) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Redridge Mountains (27-28)
route:    Alliance
faction:  Alliance
levels:   27-28
zone:     Redridge Mountains
next:     Duskwood (28-29)

fly        Stormwind City                   forever
           On the way to Redridge
zone: Stormwind City
turnin     A Friend of the Family           #98190  @80,38.4  forever
           Highlord Bolvar Fordragon, Stormwind Keep
accept     A Friend of the Family (Part 2)  #98191  forever
turnin     A Friend of the Family (Part 2)  #98191  @48.5,50  forever
           Lord Grayson Shadowbreaker, Cathedral
accept     The Shamed Lieutenant            #98219  forever
           Turns in at Southshore

fly        Stormwind City                   [Warlock]

turnin     Heartswood                       #1738  [Warlock]
           Warlock Trainer in the Mage Quarter
accept     The Binding                      #1739  [Warlock]
complete   The Binding                      #1739  [Warlock]  use:6913
turnin     The Binding                      #1739  [Warlock]

fly        Redridge Mountains               #34
accept     Blackrock Bounty                 #128
accept     Blackrock Menace                 #20
           From Marshal Marris across the bridge, he probably won't have an! over his head.
turnin     Messenger to Stormwind (Part 2)  #121
accept     Solomon's Law                    #91
           In the town hall
accept     Wanted: Lieutenant Fangore       #180
           Poster in front of the inn
zone: Redridge Mountains
accept     WANTED: Incinerator Gar'im       #95999  @19.3,46.3  forever
           Wanted poster in Lakeshire
sethearth  Lakeshire                        #180

accept     An Unwelcome Guest               #34
           West of lakeshire
complete   An Unwelcome Guest               #34
turnin     An Unwelcome Guest               #34

complete   Blackrock Menace                 #20  @30.9,10
           Follow the road north to Render's Camp
complete   Blackrock Bounty                 #128
accept     Missing In Action                #219  @23.3,12.6
           Escort in the cave
complete   Missing In Action                #219

turnin     Missing In Action                #219
turnin     Blackrock Menace                 #20
turnin     Blackrock Bounty                 #128

complete   Wanted: Lieutenant Fangore       #180  @73.9,39
           Far east, in a gnoll camp in Galardell Valley
complete   Solomon's Law                    #91

complete   WANTED: Incinerator Gar'im       #95999  forever  unverified
           Location not yet in the database; Blackrock territory
hearth     Lakeshire                        #180
turnin     Solomon's Law                    #91
turnin     Wanted: Lieutenant Fangore       #180
turnin     WANTED: Incinerator Gar'im       #95999  @24.9,44.2  forever
           Magistrate Solomon in the town hall

note       Forever extras                   optional  forever
           New Forever quests in this zone, givers not yet in the database: Shipping Label (60)
]==]
