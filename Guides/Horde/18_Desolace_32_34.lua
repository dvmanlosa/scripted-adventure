-- Desolace (32-34) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Desolace (32-34)
route:    Horde
faction:  Horde
levels:   32-34
zone:     Desolace
next:     Stranglethorn Vale (34-36)

hearth     Orgrimmar
zone: Orgrimmar
turnin     The Swarm Grows (Part 1)       #1145  @75,34.1
           Valley of Honor
accept     The Swarm Grows (Part 2)       #1146
accept     Alliance Relations (Part 1)    #1431  @50.4,47.2
           From Craven Drok in the Cleft of Shadow
turnin     Alliance Relations (Part 1)    #1431  @22.3,53.7
           From Keldran, in a hut near the west gate of Orgimmar
accept     Alliance Relations (Part 2)    #1432

goto       Desolace
           Fly to Stonetalon Mountains and run southwest

zone: Desolace
accept     Kodo Roundup                   #5561  @60.8,61.9
           Follow the road southeast to Scrabblescrew's Camp.
complete   Kodo Roundup                   #5561
           In the Kodo Graveyard

turnin     The Kolkar of Desolace         #1362
accept     Khan Dez'hepah                 #1365
accept     Gelkis Alliance                #1368
           Skip "Magram Alliance"
accept     Catch of the Day               #5386
turnin     Alliance Relations (Part 2)    #1432  @52.6,54.2
           Southwest at Ghost Walker Post, you probably want to stick to the road.
accept     Alliance Relations (Part 3)    #1433
accept     Befouled by Satyr              #1434
turnin     Alliance Relations (Part 3)    #1433
accept     The Burning of Spirits         #1435

complete   Khan Dez'hepah                 #1365  @73.5,48.6
           In a big hut in the Kolkar Village.
complete   Gelkis Alliance                #1368  @69.1,71.1
           Kill Magram centaurs until you are friendly with the Gelkis centaurs.
turnin     Kodo Roundup                   #5561

turnin     Khan Dez'hepah                 #1365  @56.2,59.5
           Back at Ghost Walker Post
accept     Centaur Bounty                 #1366
turnin     Gelkis Alliance                #1368  @36.3,79.2
           Find Uthek the Wise outside the Gelkis Village.
accept     Stealing Supplies              #1370
accept     Hunting in Stranglethorn       #5763
accept     Hand of Iruxos                 #5381
sethearth  Shadowprey Village             #6143

accept     Other Fish to Fry              #6143
accept     Clam Bait                      #6142
note       Get Shellfish
           loot the Shellfish Traps in the water to collect 10x Shellfish, then go to docks to
           receive 2x Bloodbelly Fish
flightpath Grab flight point
           Out on the pier
accept     Claim Rackmore's Treasure!     #6161  @36.1,30.4
           Down on the shore
accept     Sceptre of Light               #5741  @38.9,27.1
           From Azore Aldamort on the hill

complete   The Burning of Spirits         #1435  use:6436
complete   Sceptre of Light               #5741  @55.2,30.2  use:6436
           At the top of the tower.
complete   Hand of Iruxos                 #5381  @55,26.7  use:6436
           At Thunder Axe Fortress in the eastern building. Use the pick on the red crystal,
           kill the demon.
accept     The Corrupter (Part 1)         #1480  use:20310
           From the [Flayed Demon Skin] that dropped. If you didn't get one, kill more cultists.

turnin     The Burning of Spirits         #1435  @52.2,53.5
           Back at Ghost Walker Post
turnin     The Corrupter (Part 1)         #1480
accept     The Corrupter (Part 2)         #1481

complete   Befouled by Satyr              #1434
           In the northeast corner of the zone at Sargeron.
complete   The Corrupter (Part 2)         #1481
           Kill Hatefury Shadowstalkers for the scalp.

accept     Bone Collector                 #5501  @62.3,38.9
           From Bibbly F'utzbuckle at Kormek's Hut.
turnin     Befouled by Satyr              #1434
accept     Alliance Relations (Part 4)    #1436
turnin     The Corrupter (Part 2)         #1481
accept     The Corrupter (Part 3)         #1482

turnin     Sceptre of Light               #5741  @39,27.3
           Back at Ethel Rethor
accept     Book of the Ancients           #6027

complete   Claim Rackmore's Treasure!     #6161
           Kill Drysnap Pincers and Crawlers for the silver key, Slitherblade Naga for the
           golden key.
complete   Book of the Ancients           #6027  @28.3,6.5
           Clear the area around the statue, then talk to it and kill the naga that spawns.
turnin     Claim Rackmore's Treasure!     #6161  @30.1,8.7
           Behind a tree on Ranazjar Isle.
complete   The Corrupter (Part 3)         #1482
           Kill Slitherblade Oracles for the crystal.
complete   Other Fish to Fry              #6143
           Myrmidon and SorceressesAre mostly near the island and between it and the shore. Naga
           are mostly near the shore.
complete   Clam Bait                      #6142
           Collect clam meat from the clams on the sea floor.

turnin     Book of the Ancients           #6027  @38.9,27.2
           Back at Ethel Rethor

turnin     The Corrupter (Part 3)         #1482  @52.2,53.6
           Back at Ghost Walker Post
accept     The Corrupter (Part 4)         #1484
turnin     The Corrupter (Part 4)         #1484
           Skip last follow-up

complete   Bone Collector                 #5501
complete   Centaur Bounty                 #1366
complete   Stealing Supplies              #1370  @70,74
           In the Magram village with Centaur Bounty

turnin     Centaur Bounty                 #1366
turnin     Bone Collector                 #5501
           Back at Bibbly F'utzbuckle.

hearth     Shadowprey Village             #6143
note       Stable Pet                     [Hunter]
turnin     Hand of Iruxos                 #5381
           Skip the follow-up
turnin     Other Fish to Fry              #6143
turnin     Clam Bait                      #6142
turnin     Stealing Supplies              #1370
accept     Ongeku                         #1373
petskill   Claw (Rank 5)                  @38,74.5  [Hunter]
           Tame a Scorpashi Lasher

fly        Camp Taurajo
accept     Suspicious Hoofprints          #1268  @51,79
           At the Shady Rest Inn in Dustwallow Marsh on the ground
accept     Lieutenant Paval Reethe        #1269
           On a plank
accept     The Black Shield               #1251
           On fireplace

goto       Brackenwall Village            @36,32
turnin     The Black Shield               #1251
accept     The Black Shield (Part 2)      #1321
turnin     Suspicious Hoofprints          #1268
turnin     Lieutenant Paval Reethe        #1269
turnin     The Black Shield (Part 2)      #1321
           Skip the follow-up
note       Buy First Aid Books
           From Balai Lok'Wein

fly        Ratchet
turnin     Goblin Sponsorship (Part 1)    #1178
accept     Goblin Sponsorship (Part 2)    #1180
zone: The Barrens
turnin     Wharfmaster Dizzywig (Part 2)  #1111  @63.4,38.4
           Out on the dock.
accept     Parts for Kravel               #1112

note       Forever extras                 optional  forever
           New Forever quests in this zone, givers not yet in the database: Hate the Hatefury
           (33); A New Need for Shadow Protection (35); I Need a Tailor (35); Leather Technique
           (35); A Cleansing Cry (38); Test Your Theory (38); Lost Shipping Crate (38)
]==]
