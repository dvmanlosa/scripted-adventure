-- Ashenvale (29-30) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Ashenvale (29-30)
route:    Alliance
faction:  Alliance
levels:   29-30
zone:     Ashenvale
next:     Wetlands (30-31)

fly        Menethil Harbor                       #1264
turnin     The Missing Diplomat (Part 10)        #1248
           In the inn
accept     The Missing Diplomat (Part 11)        #1249
complete   The Missing Diplomat (Part 11)        #1249
turnin     The Missing Diplomat (Part 11)        #1249
accept     The Missing Diplomat (Part 12)        #1250
           At the guy you just fought
turnin     The Missing Diplomat (Part 12)        #1250
accept     The Missing Diplomat (Part 13)        #1264
fly        Astranaar                             #4581
           Take the boat to Theramore Isle and fly up
accept     Kayneth Stillwind                     #4581
sethearth  Astranaar                             #1035

goto       Forest Song                           #1031
           Easternmost part of Ashenvale, Northeast from Satyrnaar
accept     Vile Satyr! Dryads in Danger!         #1021
flightpath Grab flight point                     #1031  @85,43
           Up on the hill

turnin     Vile Satyr! Dryads in Danger!         #1021  @78,45
           To the west of Forest Song in Xavian
accept     The Branch of Cenarius                #1031

complete   The Branch of Cenarius                #1031  @78,42
           Kill Geltharis behind the camp

turnin     The Branch of Cenarius                #1031
           Back in Forest Song.
accept     Satyr Slaying!                        #1032
turnin     Kayneth Stillwind                     #4581
accept     Forsaken Diseases                     #1011
accept     The Howling Vale                      #1022

note       Freedom! Horrible, horrible freedom!  #1140  @81.6,48.6
           Find the crystal behind the structure where you found the chalice

complete   Forsaken Diseases                     #1011  @75,71
           Go southwest across the river
complete   Fallen Sky Lake                       #1035  @66.7,82.2
           Kill the Shadethicket Oracle at Fallen Sky Lake to the southwest past the road

complete   The Tower of Althalaxx (Part 6)       #1140  @64.8,43.8
           Follow the road northwest from Fallen Sky Lake past Raynewood Retreat, then double
           back along the ridge east of the road to the crystal in Night Run (67,54).
complete   Satyr Slaying!                        #1032
complete   Raene's Cleansing (Part 4)            #1026  @54,35
           To the northeast, just before entering felwood. Kill treants for the key and open the
           box
complete   The Howling Vale                      #1022  @54,32.5
           Path starts just north of the box for "Raene's Cleansing". Head thru the cave, find
           the tome on a table near the shrine (50.54, 39.07)

hearth     Astranaar                             #1035
turnin     Fallen Sky Lake                       #1035

turnin     The Tower of Althalaxx (Part 6)       #1140
           Back at Maestra's Post, skip the follow-up.
turnin     Raene's Cleansing (Part 4)            #1026  @53,46
           Back at the Moonwell. Skip the follow-up.

turnin     Forsaken Diseases                     #1011
turnin     The Howling Vale                      #1022
turnin     Satyr Slaying!                        #1032

note       Forever extras                        optional  forever
           New Forever quests in this zone, givers not yet in the database: Vengeful Trail (28);
           Slowing the Orc Advance (30); Shared Fury (30)
]==]
