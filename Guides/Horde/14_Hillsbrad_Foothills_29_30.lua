-- Hillsbrad Foothills (29-30) - Horde route - generated from out/forever_orc_route.json
-- Format: docs/GUIDE_FORMAT.md
local _, SA = ...
SA:RegisterGuide [==[
guide:    Hillsbrad Foothills (29-30)
route:    Horde
faction:  Horde
levels:   29-30
zone:     Hillsbrad Foothills
next:     Arathi Highlands (30)

note       Syndicate Sabotage            [Rogue]  forever
           New rogue chain (24-36) around Alterac and Ravenholdt; giver not yet in the database
note       Call of Air                   [Shaman]  forever
           Forever has a new Call of Air version (35); check your trainer if the Classic chain
           is gone

note       Grind to 30...                [Warrior]  level:30

fly        Orgrimmar
sethearth  Orgrimmar

zone: Orgimmar
accept     The Islander                  #1718  @80.4,32.4  [Warrior]  level:30
note       Liferoot                      [Warrior]  loot:3357x8  level:30
           Acquire 8 Liferoot somehow.
note       Thundering Charm              [Warrior]  loot:4480x8
           Can be skipped if you want farm them yourself.
note       Cresting Charm                [Warrior]  loot:4481x8
           Can be skipped if you want farm them yourself.
note       Burning                       [Warrior]  loot:4479x8
           Can be skipped if you want farm them yourself.
flightpath Ratchet                       [Warrior]
zone: The Barrens
turnin     The Islander                  #1718  @68.6,49.2  [Warrior]  level:30
accept     The Affray                    #1719  [Warrior]  level:30
complete   The Affray                    #1719  [Warrior]  level:30
turnin     The Affray                    #1719  [Warrior]  level:30
accept     The WindWatcher               #1791  [Warrior]  level:30

die        Die                           [Warrior]
           Take Rez Sickness
fly        Orgrimmar                     [Warrior]
sethearth  Orgrimmar                     [Warrior]

goto       Hillsbrad Foothills
           Take the zeppelin outside Orgrimmar to Undercity. Run down thru Silverpine.
zone: Hillsbrad Foothills
accept     Time To Strike                #494  @20.8,47.3
           At Southpoint Tower just as you enter the zone.

accept     Elixir of Suffering           #496
turnin     Time To Strike                #494  @62.3,20.3
           Follow the road east then north to Tarren Mill.
accept     Battle of Hillsbrad           #527
accept     Helcular's Revenge            #552
accept     Dangerous!                    #567

turnin     The WindWatcher               #1791  @79.3,7  [Warrior]

accept     Cyclonian                     #1712  [Warrior]
           This quest involves killing NPCs level 33-34, return to this quest when you feel
           comfortable.
accept     Essence of the Exile          #1714  [Warrior]
           This quest involves killing NPCs level 38-39, return to this quest when you feel
           comfortable or purchase the required items from someone. Ideally working your way
           towards Hammerfall while completing this.

fly        Undercity                     [Warrior]
fly        Grom'gol Base Camp            [Warrior]
           Take zeppelin to Grom'Gol
flightpath Flight Path                   [Warrior]

zone: Stranglethorn Vale
kill       Bloodscalp Scout              #1712  @29.8,21.6  [Warrior]
           Bloodscalp trolls (34.0, 16.8).

goto       Grom'gol                      [Warrior]
           Take the zepplin inside Grom'gol to Undercity.
fly        Hillsbrad Foothills           [Warrior]
goto       The Arathi Highlands          [Warrior]

complete   Essence of the Exile          #1714  [Warrior]
flightpath Hammerfall                    [Warrior]
fly        Tarren Mill                   [Warrior]

turnin     Essence of the Exile          #1714  [Warrior]
turnin     Cyclonian                     #1712  [Warrior]

accept     The Summoning                 #1713  [Warrior]
turnin     The Summoning                 #1713  [Warrior]
           This quest involves killing a level 40 elite wind elemental. Bring friends or skip
           until ready.

accept     Whirlwind Weapon              #1792  [Warrior]
turnin     Whirlwind Weapon              #1792  [Warrior]
           Get the Whirlwind Axe as a reward.

complete   Elixir of Suffering           #496
turnin     Elixir of Suffering           #496
accept     Elixir of Suffering (Part 2)  #499
turnin     Elixir of Suffering (Part 2)  #499
accept     Elixir of Pain                #501
accept     Soothing Turtle Bisque        #7321
           Requires cooking
buy        [Soothing Spices]             loot:3713
turnin     Soothing Turtle Bisque        #7321

zone: Hillsbrad Foothills
complete   Helcular's Revenge            #552  @46,32
           Go to the yeti cave
complete   Elixir of Pain                #501

turnin     Elixir of Pain                #501
accept     Elixir of Pain (Part 2)       #502
turnin     Helcular's Revenge            #552
accept     Helcular's Revenge (Part 2)   #553

note       Flame of Azel                 #553
note       Flame of Veraz                #553
turnin     Elixir of Pain (Part 2)       #502

complete   Battle of Hillsbrad           #527
complete   Dangerous!                    #567  @33,35
           Farmer Ray Citizen Wilkes (33,38) Farmer Getz (37,39) Farmer Kalaba (35,47) Clerk
           Horrace Whitesteed (31,42) Miner Hackett (27,59)
die        Die
           Take Rez Sickness

turnin     Battle of Hillsbrad           #527
           Skip follow-up quest
turnin     Dangerous!                    #567

accept     Regthar Deathgate             #1361

goto       The Arathi Highlands

note       Forever extras                optional  forever
           New Forever quests in this zone, givers not yet in the database: Prompt Potion Runner
           (16); Unending Torment (21); Scout Support (25); Valuable Vantages (25); Thundering
           Hearts (33)
]==]
