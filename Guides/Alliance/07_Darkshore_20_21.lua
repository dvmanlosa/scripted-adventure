-- Darkshore (20-21) - Alliance route - generated from out/forever_human_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Darkshore (20-21)
route:    Alliance
faction:  Alliance
levels:   20-21
zone:     Darkshore
next:     Ashenvale (22-24)

hearth     Auberdine
accept     Journey to Astranaar                   #1133
           On the dock
turnin     Onu                                    #948
           South at Grove of the Ancients
accept     The Master's Glaive                    #944
complete   The Master's Glaive                    #944
           Southwest from Grove of the Ancients
turnin     The Master's Glaive                    #944  use:5251
           Use the [Phial of Scrying]
accept     The Twilight Camp                      #949
turnin     The Twilight Camp                      #949
           Click the Twilight Tome in the middle of island
accept     Return to Onu                          #950
accept     Therylune's Escape                     #945  @45.3,33.8
           Escort near the Twilight Tome, southeast from it at the same island.
complete   Therylune's Escape                     #945

turnin     The Absent Minded Prospector           #729
           West from The Twilight Camp at Remtravel's Excavation
accept     The Absent Minded Prospector (Part 2)  #731
           Pain in the ass escort around the excavation. You might want to just abandon this
           (and skip the follow-up quests in the upcoming guides).
complete   The Absent Minded Prospector (Part 2)  #731
complete   WANTED: Murkdeep!                      #4740  @36.6,76.7
           Follow the shore north to the murloc camp. Clear the camp, after that there's 3 waves
           of murlocs. Murkdeep is in the last wave.

turnin     Return to Onu                          #950
           Back at Grove of the Ancients
accept     The Sleeper Has Awakened               #5321
           Escort quest
note       Get his horn                           loot:13536
           In the box near where he was sleeping
complete   The Sleeper Has Awakened               #5321  use:13536
           Escort him south. Use the [Horn of Awakening] when he falls asleep.

note       Forever extras                         optional  forever
           New Forever quests in this zone, givers not yet in the database: Baron Marinous (21)
]==]
