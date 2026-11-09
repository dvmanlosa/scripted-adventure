"""Orc profile: Durotar -> TourGuideVanilla Horde order from The Barrens (12-15) on.

New Forever quests with Wowhead giver data are placed automatically next to the nearest
TourGuide step (see routelib_build.auto_place). Class and travel notes are added here.
"""
import re

from routelib import DATA, FV

NAME = "orc"
FACTION = "Horde"
RACE = "Orc"
TGV_DIR = "TourGuide_Horde"
MODULE = "TourGuide_ForeverOrc"
NEW_QUESTS = DATA / "forever_new_quests_horde.tsv"
ZONE_ALIAS = {
    "orgrimmar": lambda lvl: "durotar" if lvl <= 12 else "the-barrens",
    "thunder-bluff": "the-barrens",
    "undercity": "hillsbrad-foothills",
}
KEEP_TBC_TRAVEL = set()   # filled after reviewing the first build report
TITLE_FIX = {}
SKIP_NEW = re.compile(r"^(Economic Warfare|A Donation of|Sign Me Up|Shipping Label|Learning to Ride|Your First|"
                      r"Welcome to Azeroth|Exploring the Horde|Journey to the Crossroads|Legacy Reward)")
AUTO_PLACE = True
RACE_FILTER = True
MANUAL_QIDS = set()


def notes(name, L):
    """Class and travel notes for Forever changes that have no quest data to place."""
    if name == "Hillsbrad Foothills (29-30)":
        L[0:0] = [
            FV("N Syndicate Sabotage |C|Rogue| |N|New rogue chain (24-36) around Alterac and Ravenholdt; giver not yet in the database|"),
            FV("N Call of Air |C|Shaman| |N|Forever has a new Call of Air version (35); check your trainer if the Classic chain is gone|"),
        ]
    elif name == "Badlands (40-41)":
        L[0:0] = [FV("N Learning to Ride |N|Level 40: Learning to Ride and Your First Riding Wolf from the wolf riding trainer outside Orgrimmar|")]
    elif name == "Dustwallow Marsh (38)":
        L[0:0] = [FV("N Riverglades option |N|Forever's Riverglades (36-44, Rog'mar for the Horde) is an alternative for the late 30s; see the route JSON for its quest list|")]


def assemble(tgv):
    chain, name = [], "The Barrens (12-15)"
    while name:
        chain.append(name)
        name = tgv[name]["next"]
    order = ["Durotar (1-12)"] + chain
    sources = {}
    for g in order:
        L = list(tgv[g]["lines"])
        notes(g, L)
        sources[g] = (L, True)
    return order, sources
