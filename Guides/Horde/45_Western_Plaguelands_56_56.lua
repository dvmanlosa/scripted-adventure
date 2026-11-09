-- Western Plaguelands (56) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Western Plaguelands (56)
route:    Horde
faction:  Horde
levels:   56-56
zone:     Western Plaguelands
next:     Eastern Plaguelands (56-57)

fly        Undercity
accept     A Call to Arms: The Plaguelands!   #5094
           From Harbinger Balthazad, he patrols around the center and middle rings of the city.
sethearth  Undercity

goto       The Bulwark
turnin     A Call to Arms: The Plaguelands!   #5094
accept     Scarlet Diversions                 #5096
note       Get a Flame in a Bottle            loot:12814
           From the Box of Incendiaries
turnin     The Everlook Report                #6029
note       Get a Commission                   loot:12846
           Talk to the quartermaster and get a commission, you should have this equipped any
           time you are in the plaguelands. Turn in any scourgestones you get when you are in
           town if you have a full stack.
accept     A Plague Upon Thee (Part 1)        #5901

complete   Scarlet Diversions                 #5096
           Burn the tent, plant the banner. Note that if you have a partner he will not get
           credit, you must wait for the tent to respawn.

turnin     Scarlet Diversions                 #5096
           Back at the Bulwark
accept     All Along the Watchtowers          #5098
accept     The Scourge Cauldrons              #5228
turnin     The Scourge Cauldrons              #5228
accept     Target: Felstone Field             #5229

complete   Target: Felstone Field             #5229
turnin     Target: Felstone Field             #5229
accept     Return to the Bulwark (Part 1)     #5230

accept     Better Late Than Never (Part 1)    #5021  @38,54
           In the house on the northeast side of the field, upstairs
turnin     Better Late Than Never (Part 1)    #5021  @38.8,55.2
           Next door in the barn, talk to the box
accept     Better Late Than Never (Part 2)    #5023

hearth     Undercity
turnin     Better Late Than Never (Part 2)    #5023
accept     The Jeremiah Blues                 #5049
turnin     The Jeremiah Blues                 #5049
accept     Good Luck Charm                    #5050

turnin     Return to the Bulwark (Part 1)     #5230
accept     Target: Dalson's Tears             #5231

turnin     Good Luck Charm                    #5050
accept     Two Halves Become One              #5051
complete   Two Halves Become One              #5051
           Go out in the field and kill the Jabbering Ghoul (only one with a pitchfork), then
           combine the pieces.
turnin     Two Halves Become One              #5051

complete   Target: Dalson's Tears             #5231
turnin     Target: Dalson's Tears             #5231
accept     Return to the Bulwark (Part 2)     #5232

note       Read Mrs. Dalson's Diary           @47.8,50.7
           On the floor in the barn. Nothing to accept, just read the book.
kill       Wandering Skeleton                 loot:12738
           Patrols around the house and barn, you are looking for the outhouse key. Scarlets
           might kill this mob.
kill       Farmer Dalson                      loot:12739
           Open the outhouse, get his key
note       Open cabinet                       loot:13474
           Locked cabinet upstairs in the house.

turnin     Return to the Bulwark (Part 2)     #5232
accept     Target: Writhing Haunt             #5233

complete   Target: Writhing Haunt             #5233
turnin     Target: Writhing Haunt             #5233
accept     Return to the Bulwark (Part 3)     #5234

accept     The Wildlife Suffers Too (Part 1)  #4984  @54,65
           In the house by the field
complete   The Wildlife Suffers Too (Part 1)  #4984
turnin     The Wildlife Suffers Too (Part 1)  #4984
accept     The Wildlife Suffers Too (Part 2)  #4985
complete   The Wildlife Suffers Too (Part 2)  #4985

flightpath New flight point!                  @69.2,49.7
           There is now a flight point on the east end of the road. Zip over there and fly back
           to the WARK!
turnin     Return to the Bulwark (Part 3)     #5234
accept     Target: Gahrron's Withering        #5235

complete   Target: Gahrron's Withering        #5235
turnin     Target: Gahrron's Withering        #5235
accept     Return to the Bulwark (Part 4)     #5236

turnin     The Wildlife Suffers Too (Part 2)  #4985

turnin     Return to the Bulwark (Part 4)     #5236
]==]
