"""Human profile: Elwynn -> Westfall (authored) -> TourGuideVanilla Alliance order, Deadmines after Redridge."""
import re

from routelib import AUTH, FV, find, insert_after, insert_before


def elwynn_ops(L):
    """Insert Forever's new Elwynn quests (Wowhead givers/coords) into TGV's Elwynn order."""
    insert_after(L, r"^A Wolves Across the Border", [
        FV("N Hunter trainer |C|Hunter| |N|Tordrin Sternblade beside the abbey (51.2, 40.8) trains you; Josephine Carson takes over in Goldshire (41.1, 66.2)|"),
        FV("A Book Inventory |N|Brother Paxton inside the abbey (49.4, 40.4)| |QID|92124|"),
        FV("T Book Inventory |N|Daniel, next room (49.4, 40.6)| |QID|92124|"),
        FV("A Nibbled-On Book |N|Starts from a Nibbled-On Book looted near the abbey| |O| |QID|91741|"),
        FV("T Nibbled-On Book |N|Brother Paxton (49.4, 40.4)| |O| |QID|91741|"),
        FV("A Rascally Rodents |N|Brother Paxton (49.4, 40.4)| |QID|91743|"),
    ])
    insert_after(L, r"^C Investigate Echo Ridge", [
        FV("C Rascally Rodents |N|Stolen books in and around Echo Ridge Mine (50.8, 37.9)| |QID|91743|"),
    ])
    insert_after(L, r"^T Investigate Echo Ridge", [
        FV("T Rascally Rodents |N|Brother Paxton (49.4, 40.4)| |QID|91743|"),
        FV("A Mining Consultant |QID|91745|"),
    ])
    insert_after(L, r"^C Skirmish at Echo Ridge", [
        FV("T Mining Consultant |N|Kelsey Fargo by the mine (47.2, 32.2)| |QID|91745|"),
        FV("A The Big Picture |QID|91752|"),
        FV("C The Big Picture |N|Sack of Picture Books on the ridge (49.2, 28.0)| |QID|91752|"),
    ])
    insert_after(L, r"^T Skirmish at Echo Ridge", [
        FV("T The Big Picture |N|Marshal McBride (48.8, 41.6)| |QID|91752|"),
        FV("A Follow That Kobold! |QID|91758|"),
        FV("T Follow That Kobold! |N|Tordrin Sternblade (51.2, 40.8)| |QID|91758|"),
        FV("A Shhh! We're Hunting Kobolds |QID|91772|"),
    ])
    insert_after(L, r"^T Report to Goldshire", [
        FV("T Shhh! We're Hunting Kobolds |N|Marshal Dughan (42.2, 65.8)| |QID|91772|"),
        FV("A Book Return |N|Rewards the Book Bag| |QID|91775|"),
    ])
    insert_after(L, r"^A Kobold Candles", [
        FV("A A Net Disaster |N|Jason Mathers by Crystal Lake (47.4, 62.2)| |QID|99127|"),
        FV("A Slimy Menace |QID|99128|"),
        FV("A Bottles and Baubles |N|Lee Brown (47.4, 62.2)| |QID|99143|"),
        FV("A Rough Wolf Pelts |N|Helene Peltskinner (46.2, 62.2); she can also teach Skinning| |QID|91751|"),
    ])
    insert_after(L, r"^C Kobold Candles", [
        FV("C Book Return |N|Lost Books from the same Fargodeep kobolds| |QID|91775|"),
    ])
    insert_after(L, r"^T The Fargodeep Mine", [
        FV("T Book Return |N|Marshal Dughan (42.2, 65.8). Equip the Book Bag| |QID|91775|"),
        FV("A Rare Books |QID|91777|"),
    ])
    insert_after(L, r"^A Shipment to Stormwind", [
        FV("T Rare Books |N|Short ride north to Brother Paxton in Northshire (49.4, 40.4). Choice of five militia weapons| |QID|91777|"),
    ])
    insert_after(L, r"^C Collecting Kelp", [
        FV("C A Net Disaster |N|Around Crystal Lake| |QID|99127|"),
        FV("C Slimy Menace |N|Murlocs around Crystal Lake (49.8, 66.4)| |QID|99128|"),
        FV("C Bottles and Baubles |N|Shiny Junk on the east shore (54.3, 66.8)| |QID|99143|"),
        FV("T A Net Disaster |N|Jason Mathers (47.4, 62.2)| |QID|99127|"),
        FV("T Slimy Menace |QID|99128|"),
        FV("T Bottles and Baubles |N|Lee Brown (47.4, 62.2)| |QID|99143|"),
        FV("A A Man About a Murloc |QID|99129|"),
    ])
    insert_before(L, r"^T Further Concerns", [
        FV("A Delicate Instruments |N|Hamish Bergwort at the Tower of Azora (65.0, 69.8)| |QID|91723|"),
        FV("A Stolen Enchanting Supplies |N|Blixie Fitzwink (63.2, 72.6)| |QID|91725|"),
    ])
    insert_after(L, r"^A Protect the Frontier", [
        FV("A Downstream |N|Ormin Pelford by the bridge (76.4, 72.0)| |QID|91733|"),
    ])
    insert_after(L, r"^A A Bundle of Trouble", [
        FV("A Good Steel |N|Hagar Lowe (82.4, 63.8)| |QID|91732|"),
    ])
    insert_after(L, r"^C The Jasperlode Mine", [
        FV("C Good Steel |N|Mining tools inside Jasperlode Mine (61.3, 50.1)| |QID|91732|"),
    ])
    insert_after(L, r"^A Report to Thomas", [
        FV("C Delicate Instruments |N|Defias Rogue Wizards north of the road (74.0, 55.6)| |QID|91723|"),
        FV("C Stolen Enchanting Supplies |N|Crates near (68.7, 51.1)| |QID|91725|"),
        FV("C Downstream |N|Lost supplies washed down the river; watch for murlocs and wolves| |QID|91733| |UNV|"),
        FV("C Rough Wolf Pelts |N|Wolves east of the road (58.4, 62.1)| |QID|91751|"),
    ])
    insert_after(L, r"^T A Bundle of Trouble", [
        FV("T Good Steel |N|Hagar Lowe (82.4, 63.8)| |QID|91732|"),
    ])
    insert_after(L, r"^T Report to Thomas", [
        FV("T Downstream |N|Ormin Pelford (76.4, 72.0)| |QID|91733|"),
    ])
    insert_after(L, r"^T Red Linen Goods", [
        FV("T Delicate Instruments |N|Tower of Azora on the way west (65.0, 69.8)| |QID|91723|"),
        FV("T Stolen Enchanting Supplies |N|Blixie Fitzwink (63.2, 72.6)| |QID|91725|"),
    ])
    insert_after(L, r"^H Goldshire", [
        FV("T Rough Wolf Pelts |N|Helene Peltskinner by the lake (46.2, 62.2)| |QID|91751|"),
        FV("T A Man About a Murloc |N|Remy \"Two Times\" (42.2, 67.2)| |QID|99129|"),
        FV("N Taming the Beast |C|Hunter| |N|Level 10: Josephine Carson (41.1, 66.2) starts the Human hunter pet quests. Follow the quest text; their steps are not yet in the database|"),
    ], nth=2)
    insert_after(L, r"^T Westbrook Garrison Needs Help!", [
        FV("N Optional rares |N|Croaky (level 11 group) drops Croaky's Head for Merell Ross (84.6, 79.2); Elmpaw (level 12) drops Elmpaw's Head for Helene Peltskinner (46.2, 62.2)|"),
        FV("N An Apple Treat |N|Sergeant De Vries (24.0, 73.0) offers a new level 10 quest; objective not yet in the database|"),
    ])


def stormwind_trip(L):
    """TGV's Stormwind class-quest trip, reused inside the Westfall chapter."""
    i = find(L, r"^F Stormwind City$|^F Stormwind City\s")
    trip = L[i:]
    drop = [r"^F Westfall \|R\|Human\|", r"^T Return to Lewis", r"^F Stormwind City \|R\|Human\|"]
    trip = [l for l in trip if not any(re.search(p, l) for p in drop)]
    insert_after(trip, r"^h Stormwind City", [
        FV("T Elmore's Task |N|Grimand Elmore, Dwarven District (51.7, 12.1)| |Z|Stormwind City| |QID|1097| |CF|"),
        FV("A Stormpike's Delivery |N|Turns in at Algaz Station in Loch Modan| |QID|353|"),
    ])
    insert_after(trip, r"^A Mirror Lake", [
        FV("N Confounding Flash and Divine Grace |C|Priest| |N|New level 10 priest quest chains; ask your trainer in the Cathedral|"),
    ])
    return trip


def later_inserts(name, L):
    """Inserts into TGV guides after Westfall, keyed by guide name."""
    if name == "Darkshore (12-17)":
        insert_after(L, r"^h Auberdine", [
            FV("A Expanding Horizons |N|Thundris Windweaver (37.4, 40.2); turns in at Stormwind| |QID|97914|"),
        ])
    elif name == "Loch Modan (17-18)":
        insert_after(L, r"^R Algaz Station", [
            FV("T Stormpike's Delivery |N|Mountaineer Stormpike (24.76, 18.4)| |QID|353|"),
            FV("N New Loch Modan quests |N|Banner of the Fallen from Mountaineer Ylva (31.8, 86.4); Twisting the Knife from Marek Ironheart (81.8, 61.8); Silver of the Waves starts from a fishing toolbox (48.1, 39.7)|"),
        ])
    elif name == "Redridge Mountains (18-20)":
        insert_after(L, r"^R Stormwind City", [
            FV("T Expanding Horizons |N|Baros Alexston, Cathedral Square (49.0, 30.2)| |Z|Stormwind City| |QID|97914| |CF|"),
            FV("N Contingency Plan |C|Priest| |N|New level 20 priest chain (3 steps); ask your trainer|"),
        ])
        insert_after(L, r"^R Redridge Mountains", [
            FV("T The Defias Brotherhood |N|Wiley the Black, Lakeshire (26.5, 45.4)| |Z|Redridge Mountains| |QID|65| |CF|"),
            FV("A The Defias Brotherhood (Part 2) |N|Turns in at Sentinel Hill in the Deadmines chapter| |QID|132|"),
            FV("A Show of Force |N|Deputy Feldon (30.8, 60.0)| |Z|Redridge Mountains| |QID|98407| |CF|"),
            FV("C Show of Force |N|Follow the quest text; objective not yet in the database| |QID|98407| |UNV|"),
            FV("T Show of Force |N|Deputy Feldon (30.8, 60.0)| |Z|Redridge Mountains| |QID|98407| |CF|"),
            FV("N Alther's Mill and Blackrock Blockade |N|New level 21 quests from Foreman Oslow (32.2, 48.6) and Marshal Marris (33.4, 48.8) in Lakeshire| |Z|Redridge Mountains| |CF|"),
        ])
    elif name == "Wetlands (25-27)":
        insert_after(L, r"^T Return the Statuette", [
            FV("A A Friend of the Family |N|Captain Stoutfist (9.8, 57.4); turns in at Stormwind| |QID|98190|"),
        ])
    elif name == "Redridge Mountains (27-28)":
        L[0:0] = [
            FV("F Stormwind City |N|On the way to Redridge|"),
            FV("T A Friend of the Family |N|Highlord Bolvar Fordragon, Stormwind Keep (78.0, 18.0)| |Z|Stormwind City| |QID|98190| |CF|"),
            FV("A A Friend of the Family (Part 2) |QID|98191|"),
            FV("T A Friend of the Family (Part 2) |N|Lord Grayson Shadowbreaker, Cathedral (37.2, 33.0)| |Z|Stormwind City| |QID|98191| |CF|"),
            FV("A The Shamed Lieutenant |N|Turns in at Southshore| |QID|98219|"),
        ]
        insert_after(L, r"^A Wanted: Lieutenant Fangore", [
            FV("A WANTED: Incinerator Gar'im |N|Wanted poster in Lakeshire (24.4, 46.3)| |Z|Redridge Mountains| |QID|95999| |CF|"),
        ])
        insert_before(L, r"^H Lakeshire", [
            FV("C WANTED: Incinerator Gar'im |N|Location not yet in the database; Blackrock territory| |QID|95999| |UNV|"),
        ])
        insert_after(L, r"^T Wanted: Lieutenant Fangore", [
            FV("T WANTED: Incinerator Gar'im |N|Magistrate Solomon in the town hall (30.0, 44.2)| |Z|Redridge Mountains| |QID|95999| |CF|"),
        ])
    elif name == "Hillsbrad Foothills (31-32)":
        insert_after(L, r"^R Southshore", [
            FV("T The Shamed Lieutenant |N|Lieutenant Farren Orinelle (51.4, 58.4)| |QID|98219|"),
            FV("N Syndicate Sabotage |C|Rogue| |N|New rogue chain (24-36) around Alterac and Ravenholdt; giver not yet in the database|"),
        ])
    elif name == "Desolace (33-34)":
        L[0:0] = [FV("N Battle at the Mannoroc Coven |C|Paladin| |N|New paladin quest here at level 40 (requires 35); come back later|")]
    elif name == "Dustwallow Marsh (37-38)":
        L[0:0] = [FV("N Riverglades option |N|This guide lost 51 TBC-only quests. Forever's Riverglades (36-44, Farholde Keep) is the alternative; see the route JSON for its quest list|")]
    elif name == "Badlands (40-41)":
        L[0:0] = [FV("N Learning to Ride |N|Level 40: Learning to Ride and Your First Horse from the riding trainer at Eastvale Logging Camp, Elwynn (84.3, 65.0)|")]




# ---------------------------------------------------------------- profile
from routelib import DATA  # noqa: E402

NAME = "human"
FACTION = "Alliance"
RACE = "Human"
TGV_DIR = "TourGuide_Alliance"
MODULE = "TourGuide_ForeverHuman"
NEW_QUESTS = DATA / "forever_new_quests.tsv"
ZONE_ALIAS = {"stormwind-city": "westfall", "ironforge": "wetlands"}
KEEP_TBC_TRAVEL = {("The Hinterlands (46-47)", "F", "Southshore"), ("The Hinterlands (46-47)", "R", "The Hinterlands"),
                   ("Dustwallow Marsh (37-38)", "F", "Theramore Isle"), ("Dustwallow Marsh (37-38)", "H", "Theramore Isle"),
                   ("Kalimdor (51)", "F", "Darnassus")}
TITLE_FIX = {"The Alagaz Gauntlet": "The Algaz Gauntlet", "OOX-17/TN Distress Beacon": "Find OOX-17/TN!"}
SKIP_NEW = re.compile(r"^(Economic Warfare|A Donation of|Sign Me Up|Rotgath Stonebeard|A Quick Craft|Learning to Ride|Your First|Journey to Sentinel Hill|Welcome to Azeroth|Exploring the Alliance|Legacy Reward)")
AUTO_PLACE = False
RACE_FILTER = False      # Wowhead race tags on the Alliance scrape are unreliable; Human route places by hand
MANUAL_QIDS = set()


def assemble(tgv):
    """Elwynn -> Westfall (authored) -> TGV from Darkshore (12-17); Deadmines after Redridge (18-20)."""
    chain, name = [], "Darkshore (12-17)"
    while name:
        chain.append(name)
        name = tgv[name]["next"]
    order = ["Elwynn Forest (1-12)", "Westfall (11-17)"]
    for g in chain:
        order.append(g)
        if g == "Redridge Mountains (18-20)":
            order.append("The Deadmines (20-22)")
    elwynn = list(tgv["Elwynn Forest (1-12)"]["lines"])
    sw_trip = stormwind_trip(elwynn)
    elwynn_ops(elwynn)
    elwynn = elwynn[:find(elwynn, r"^R Westfall")]
    westfall = (AUTH / "westfall.guide").read_text().split("\n")
    w = westfall.index("@@TGV_STORMWIND_TRIP@@")
    westfall[w:w + 1] = sw_trip
    sources = {
        "Elwynn Forest (1-12)": (elwynn, True),
        "Westfall (11-17)": (westfall, False),
        "The Deadmines (20-22)": ((AUTH / "deadmines.guide").read_text().split("\n"), False),
    }
    for g in chain:
        L = list(tgv[g]["lines"])
        later_inserts(g, L)
        sources[g] = (L, True)
    return order, sources
