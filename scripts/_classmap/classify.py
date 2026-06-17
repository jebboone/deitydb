#!/usr/bin/env python3
"""One-off: map free-text entity_type -> controlled entity_class.

Reads /tmp/types.tsv (lines: "<entity_type>\\t<count>", the \\t is the literal
two chars backslash-t as emitted by psql -F). Applies ordered keyword rules over
the lowercased type string. Emits:
  - /tmp/classmap.tsv   : entity_type<TAB>entity_class   (only matched)
  - prints UNMATCHED types (with counts) for manual classification.

Rule order matters: earlier rules win. Rules are (substring, class). We test the
lowercased type against each substring in order; first hit assigns the class.
"""
import sys

CLASSES = {
    "deity","angel","demon","spirit","monster","aeon","sefirah","abstraction",
    "hero","saint","prophet","sage","ruler","scriptural-figure","collective",
    "realm","ritual","title",
}

# Ordered (substring, class). FIRST match wins, so put specific before generic.
RULES = [
    # --- collectives first (a "nymph collective" must not match nymph->spirit) ---
    ("collective", "collective"),
    ("pantheon", "collective"),
    (" set", "collective"),          # "angel-set", "god-set" style (leading space avoids 'sethian')
    ("heptad", "collective"),
    ("ennead", "collective"),
    ("triad", "collective"),
    ("group", "collective"),
    ("assembly", "collective"),
    ("choir", "collective"),

    # --- realms / places (before 'world'->? and before being-words) ---
    ("realm", "realm"),
    ("cosmolog", "realm"),
    ("underworld", "realm"),
    ("netherworld", "realm"),
    ("heaven", "realm"),
    ("hell", "realm"),
    ("paradise", "realm"),
    ("world", "realm"),
    ("place", "realm"),
    ("location", "realm"),
    ("palace", "realm"),
    ("region", "realm"),

    # --- ritual ---
    ("ritual", "ritual"),
    ("rite", "ritual"),
    ("sacrament", "ritual"),
    ("liturg", "ritual"),
    ("practice", "ritual"),
    ("prayer", "ritual"),
    ("festival", "ritual"),
    ("ceremon", "ritual"),

    # --- title / devotional ---
    ("title", "title"),
    ("apparition", "title"),
    ("epithet", "title"),
    ("marian", "title"),
    ("invocation", "title"),

    # --- sefirah ---
    ("sefir", "sefirah"),
    ("sephir", "sefirah"),

    # --- aeon / gnostic emanation (archon before demon) ---
    ("aeon", "aeon"),
    ("archon", "aeon"),
    ("pleroma", "aeon"),
    ("emanation", "aeon"),
    ("syzygy", "aeon"),

    # --- angel (before demon? no: 'fallen angel' should be demon) ---
    ("fallen angel", "demon"),
    ("archangel", "angel"),
    ("angel", "angel"),
    ("seraph", "angel"),
    ("cherub", "angel"),
    ("watcher", "angel"),
    ("shem", "angel"),

    # --- demon ---
    ("demon", "demon"),
    ("devil", "demon"),
    ("goet", "demon"),          # goetic / goetia
    ("go"+"ët", "demon"),
    ("fiend", "demon"),
    ("infernal", "demon"),
    ("hell-", "demon"),
    ("ifrit", "demon"),
    ("shedim", "demon"),
    ("qliphoth", "demon"),
    ("qlippoth", "demon"),

    # --- monster ---
    ("monster", "monster"),
    ("dragon", "monster"),
    ("serpent", "monster"),
    ("jötunn", "monster"),
    ("jotunn", "monster"),
    ("jotun", "monster"),
    ("giant", "monster"),
    ("titan", "deity"),         # Titans are divine -> deity (after giant)
    ("beast", "monster"),
    ("chimera", "monster"),
    ("hydra", "monster"),
    ("gorgon", "monster"),
    ("sea monster", "monster"),
    ("brood", "monster"),

    # --- spirit (nature spirits, daimones, folkloric) ---
    ("nymph", "spirit"),
    ("nereid", "spirit"),
    ("oceanid", "spirit"),
    ("naiad", "spirit"),
    ("dryad", "spirit"),
    ("oread", "spirit"),
    ("sprite", "spirit"),
    ("jinn", "spirit"),
    ("jinni", "spirit"),
    ("genie", "spirit"),
    ("genius", "spirit"),
    ("daimon", "spirit"),
    ("daemon", "spirit"),
    ("folkloric", "spirit"),
    ("folk being", "spirit"),
    ("lightworld", "spirit"),
    ("light-world", "spirit"),
    ("light being", "spirit"),
    ("astral", "spirit"),
    ("elemental", "spirit"),
    ("fairy", "spirit"),
    ("faerie", "spirit"),
    ("ancestor", "spirit"),
    ("ghost", "spirit"),
    ("psychopomp", "spirit"),
    ("planetary spirit", "spirit"),
    ("spirit", "spirit"),
    ("being", "spirit"),        # generic "...being" fallback within spirit family

    # --- saint ---
    ("saint", "saint"),
    ("blessed", "saint"),
    ("martyr", "saint"),
    ("monk", "saint"),
    ("ascetic", "saint"),
    ("hermit", "saint"),
    ("sanctified", "saint"),
    ("desert father", "saint"),

    # --- prophet ---
    ("prophet", "prophet"),
    ("messenger", "prophet"),
    ("seer", "prophet"),

    # --- sage / religious human ---
    ("sage", "sage"),
    ("mystic", "sage"),
    ("rabbi", "sage"),
    ("sufi", "sage"),
    ("imam", "sage"),
    ("disciple", "sage"),
    ("apostle", "sage"),
    ("evangelist", "sage"),
    ("theolog", "sage"),
    ("church father", "sage"),
    ("doctor", "sage"),         # Doctor of the Church
    ("teacher", "sage"),
    ("founder", "sage"),
    ("patriarch (church", "sage"),
    ("clergy", "sage"),
    ("priest", "sage"),
    ("scholar", "sage"),
    ("philosopher", "sage"),
    ("guru", "sage"),
    ("master", "sage"),         # ascended master, sufi master
    ("pir", "sage"),

    # --- ruler ---
    ("king", "ruler"),
    ("queen", "ruler"),
    ("pharaoh", "ruler"),
    ("emperor", "ruler"),
    ("empress", "ruler"),
    ("ruler", "ruler"),
    ("monarch", "ruler"),
    ("sultan", "ruler"),
    ("caliph", "ruler"),

    # --- hero ---
    ("hero", "hero"),
    ("knight", "hero"),
    ("companion", "hero"),
    ("saga", "hero"),
    ("legendary", "hero"),
    ("deified mortal", "hero"),
    ("warrior", "hero"),
    ("champion", "hero"),
    ("cult figure", "hero"),

    # --- scriptural figure ---
    ("biblical", "scriptural-figure"),
    ("patriarch", "scriptural-figure"),
    ("matriarch", "scriptural-figure"),
    ("mother of the believers", "scriptural-figure"),
    ("scriptural", "scriptural-figure"),
    ("companion of", "scriptural-figure"),

    # --- abstraction (before deity 'personification'? personification can be deity-like;
    #     but 'Daimon/personification' & 'Aeon/personification' already matched above) ---
    ("abstract", "abstraction"),
    ("personification", "abstraction"),
    ("concept", "abstraction"),
    ("principle", "abstraction"),
    ("category", "abstraction"),
    ("quality", "abstraction"),
    ("virtue", "abstraction"),
    ("force", "abstraction"),
    ("power", "abstraction"),

    # --- deity (broad, last so specific kinds win) ---
    ("god", "deity"),           # God, Goddess, river god, sun-god...
    ("deity", "deity"),
    ("divin", "deity"),         # divinity, divine being already caught by 'being'
    ("yazata", "deity"),
    ("protogenos", "deity"),
    ("protogenoi", "deity"),
    ("primordial", "deity"),
    ("olympian", "deity"),
    ("assessor", "deity"),
    ("yaksha", "deity"),
    ("loa", "deity"),
    ("lwa", "deity"),
    ("orisha", "deity"),
    ("orisa", "deity"),
    ("kami", "deity"),
    ("numen", "deity"),
    ("idol", "deity"),
    ("supreme", "deity"),
    ("creator", "deity"),
]


def classify(et: str):
    s = et.lower()
    for sub, cls in RULES:
        if sub in s:
            return cls
    return None


def main():
    rows = []
    with open("/tmp/types.tsv", encoding="utf-8") as fh:
        for line in fh:
            line = line.rstrip("\n")
            if not line:
                continue
            # psql emitted the literal two chars backslash-t as the separator
            if "\\t" in line:
                et, n = line.rsplit("\\t", 1)
            elif "\t" in line:
                et, n = line.rsplit("\t", 1)
            else:
                et, n = line, "0"
            rows.append((et, int(n)))

    matched, unmatched = [], []
    for et, n in rows:
        cls = classify(et)
        if cls:
            matched.append((et, cls, n))
        else:
            unmatched.append((et, n))

    with open("/tmp/classmap.tsv", "w", encoding="utf-8") as out:
        for et, cls, n in matched:
            assert cls in CLASSES, cls
            out.write(f"{et}\t{cls}\n")

    tot = sum(n for _, n in rows)
    mtot = sum(n for _, _, n in matched)
    print(f"types: {len(rows)}  matched: {len(matched)} ({mtot} entities)  "
          f"UNMATCHED: {len(unmatched)} ({tot-mtot} entities)")
    print("\n=== UNMATCHED (type | count) ===")
    for et, n in sorted(unmatched, key=lambda x: -x[1]):
        print(f"{n:4d}  {et}")

    # class distribution preview
    from collections import Counter
    c = Counter()
    for _, cls, n in matched:
        c[cls] += n
    print("\n=== class distribution (matched only) ===")
    for cls, n in c.most_common():
        print(f"{n:5d}  {cls}")


if __name__ == "__main__":
    main()
