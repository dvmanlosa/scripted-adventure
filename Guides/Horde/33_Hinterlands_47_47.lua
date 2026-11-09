-- Hinterlands (47) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Hinterlands (47)
route:    Horde
faction:  Horde
levels:   47-47
zone:     Hinterlands
next:     Stranglethorn Vale (47)

fly        Tarren Mill
sethearth  Tarren Mill
zone: Hillsbrad Foothills
goto       The Hinterlands                    @86,30
           Entrance at
zone: Hinterlands
turnin     Ripple Recovery (Part 2)           #650  @26,48
           Go to
accept     A Sticky Situation                 #77
accept     Vilebranch Hooligans               #7839
accept     Cannibalistic Cousins              #7844
accept     Message to the Wildhammer          #7841
accept     Stalking the Stalkers              #7828
accept     Hunt the Savages                   #7829
accept     Avenging the Fallen                #7830

complete   Stalking the Stalkers              #7828
           The Stalkers are east, Howlers central Hinterlands
complete   Cannibalistic Cousins              #7844  @45,65
           Located in groups at (54,38.6) (66,43) (71.6,46.8)
complete   Testing the Vessel                 #3123  @53.8,48.9  use:9618
           Kill Savages and use vessel once dead (62.6,40.9) (60.4,53.8)
complete   Hunt the Savages                   #7829
           Continue killing Savage Owlbeast
complete   Vilebranch Hooligans               #7839  @72.5,52.9
           Potential spawns include (71,48.7) (66.5,44.6) (57.4,42.5) (53.3,38.7)
complete   A Sticky Situation                 #77  @57,39
           Crates found within Skull Rock
complete   Avenging the Fallen                #7830  @54.2,49.3
           Look around and (63.8,52)
complete   Lines of Communication             #2995  @32,46.8
           At Quel'Danil Lodge (29.6,48.7) (28.6,46)
complete   Message to the Wildhammer          #7841
           All around the lodge
accept     Rin'ji is Trapped!                 #2742
complete   Rin'ji is Trapped!                 #2742
turnin     Rin'ji is Trapped!                 #2742
complete   Grim Message                       #2932  @30.6,56.7  use:15002
           Get the skulls around and combine/place at Hiri'watha village
accept     Venom Bottles                      #2933
           Found from tables in troll village

turnin     A Sticky Situation                 #77  @21,48
           Start of path at
accept     Ripple Delivery                    #81
turnin     Rin'ji is Trapped!                 #2742
           Turn-in at the tablet
accept     Rin'ji's Secret                    #2782

turnin     Vilebranch Hooligans               #7839
           Back at Revantusk Village
note       [Long Elegant Feathers]
           Save 10 for later, if you have them
turnin     Cannibalistic Cousins              #7844
turnin     Message to the Wildhammer          #7841
accept     Another Message to the Wildhammer  #7842  loot:4589x10  optional
turnin     Another Message to the Wildhammer  #7842  optional
turnin     Stalking the Stalkers              #7828
turnin     Hunt the Savages                   #7829
turnin     Avenging the Fallen                #7830

fly        Hammerfall
zone: Arathi Highlands
note       Train First Aid                    @73.4,36.9
           If you have enough Mageweave Cloth, level up to 260 for Runecloth Bandage

fly        Tarren Mill
turnin     Venom Bottles                      #2933
accept     Undamaged Venom Sac                #2934

zone: Hillsbrad Foothills
goto       Hinterlands                        @88,28
           Enter around
turnin     The Atal'ai Exile                  #1429
           At the top of the Shadra'Alor temple
accept     Return to Fel'Zerul                #1444
zone: Hinterlands
complete   Undamaged Venom Sac                #2934  @35.4,71.3
           Kill spiders around
accept     Find OOX-09/HL!                    #485  use:8704  optional
turnin     Find OOX-09/HL!                    #485  @49,38  optional
           AT the north lake Skip the follow-up escort

hearth     Tarren Mill
turnin     Undamaged Venom Sac                #2934
accept     Consult Master Gadrin              #2935  [Orc, Troll]
           If you haven't yet purchased your mount, grab this

fly        Undercity
turnin     Rin'ji's Secret                    #2782
turnin     Lines of Communication             #2995
turnin     Oran's Gratitude                   #8273
]==]
