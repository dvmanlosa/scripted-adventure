-- Winterspring (54-55) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Winterspring (54-55)
route:    Horde
faction:  Horde
levels:   54-55
zone:     Winterspring
next:     Western Plaguelands (56)

goto       Everlook
           Follow the road east.
accept     Are We There, Yeti? (Part 1)     #3783
accept     The Everlook Report              #6029
accept     Duke Nicholas Zverenhoff         #6030
accept     Sister Pamela                    #5601
accept     Ursius of the Shardtooth         #5054
turnin     Felnok Steelspring               #4808
accept     Chillwind Horns                  #4809
sethearth  Everlook

complete   Ursius of the Shardtooth         #5054
           Grind mobs north of everlook til he shows up
turnin     Ursius of the Shardtooth         #5054
accept     Brumeran of the Chillwind        #5055
complete   Brumeran of the Chillwind        #5055  @60,60
           Pats near

complete   Strange Sources                  #4842  @59,73
           Take the road south to Darkwhisper Gorge

hearth     Everlook
turnin     Brumeran of the Chillwind        #5055
complete   Are We There, Yeti? (Part 1)     #3783
complete   Threat of the Winterfall         #5082
complete   Wild Guardians                   #4741
           Ragged Owls are west of Everlook, Raging are just north
complete   Chillwind Horns                  #4809  @66,29
           Large Chimera concentration around

turnin     Threat of the Winterfall         #5082  @31,45
           at
turnin     Strange Sources                  #4842
accept     Winterfall Firewater             #5083  use:12771
turnin     Winterfall Firewater             #5083
accept     Falling to Corruption            #5084

turnin     Are We There, Yeti? (Part 1)     #3783  @61,38
           Everlook
accept     Are We There, Yeti? (Part 2)     #977
turnin     Chillwind Horns                  #4809

complete   Winterfall Activity              #8464  @67,37
complete   Are We There, Yeti? (Part 2)     #977  @66,43
           pristine horns

hearth     Everlook
turnin     Are We There, Yeti? (Part 2)     #977

fly        Bloodvenom Post
turnin     Wild Guardians                   #4741
           Skip the follow-up

fly        Emerald Sanctuary
turnin     Collection of the Corrupt Water  #5157
           Skip the follow-up
turnin     Verifying the Corruption         #5156
turnin     Cleansing Felwood                #4102
           North along the road

complete   Corrupted Sabers                 #4506
turnin     Corrupted Sabers                 #4506
           First talk to the cat

zone: Felwood
turnin     Falling to Corruption            #5084  @60,5
           The cauldron at
accept     Mystery Goo                      #5085
accept     Deadwood Ritual Totem            #8470  use:20741  optional
turnin     Deadwood Ritual Totem            #8470  optional
           Turn-in at a furblog halfway thru the hold

goto       Winterspring
turnin     Winterfall Activity              #8464
zone: Winterspring
turnin     Mystery Goo                      #5085  @31,45
           in Winterspring, skip the follow-up

hearth     Everlook
]==]
