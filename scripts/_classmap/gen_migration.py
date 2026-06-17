#!/usr/bin/env python3
"""Emit upgrade_v2_0_entity_class.sql from the verified /tmp/classmap_full.tsv.

Adds the controlled entity_class lookup (19 rows), the entity_type_class_map
(888 verified rows + 6 new types created by filling the 57 blank entity_types
from their category), the ALTER/backfill, FK + index, and a fail-closed
verification block. Idempotent (IF NOT EXISTS / ON CONFLICT)."""

CLASSES = [
    ("deity","Deity","Gods, goddesses, and powers worshipped as divine (incl. primordials, Titans, river & nature gods, deified divine animals).",1),
    ("angel","Angel","Angelic beings of all ranks: archangels, angelic princes, Shem angels, planetary & zodiacal angels, Mandaean uthras.",2),
    ("demon","Demon","Demons, devils, fallen angels, and Goetic spirits of every rank.",3),
    ("aeon","Aeon","Gnostic aeons, archons, and structured emanations of the pleroma.",4),
    ("sefirah","Sefirah","Kabbalistic sefirot and ordered emanation-configurations (partzufim).",5),
    ("spirit","Spirit","Lesser and intermediary spirits: nature spirits (nymphs, nereids, oceanids), daimones, jinn, folkloric and light-world beings.",6),
    ("monster","Monster","Monstrous and chaos beings: dragons, serpents, jotnar, the Echidna/Typhon brood, sea-monsters, mythic beasts.",7),
    ("hero","Hero","Heroes, deified mortals, legendary and saga figures, knights, and cult heroes.",8),
    ("ruler","Ruler","Kings, queens, and rulers as human or legendary figures.",9),
    ("prophet","Prophet","Prophets, messengers, and revealers of divine teaching.",10),
    ("sage","Sage","Religious founders, teachers, theologians, mystics, sages, and clergy.",11),
    ("saint","Saint","Canonized or venerated saints, blesseds, martyrs, and holy ascetics.",12),
    ("scriptural-figure","Scriptural figure","Narrative persons of scripture (patriarchs, matriarchs, biblical and apostolic figures).",13),
    ("abstraction","Abstraction","Personified abstractions, abstract powers and categories, principles, doctrines, and concepts.",14),
    ("collective","Collective","Collectives, groups, orders, movements, and institutional bodies of beings.",15),
    ("realm","Realm","Cosmological places, realms, worlds, and cosmic structures.",16),
    ("ritual","Ritual","Ritual and practice categories, initiatory grades, and ritual abstractions.",17),
    ("title","Title","Devotional titles and apparitions treated as entities (e.g. Marian titles).",18),
    ("object","Object","Sacred objects, relics, betyls, cult images, constructs, and sacred texts.",19),
]

# Fill rule for the 57 blank entity_types: category -> (normalized entity_type, class).
# Reuse existing type strings where one exists (Demon / Angelic being / Ritual category)
# to avoid introducing new case-variants; only 6 genuinely-new types are created.
BLANK_FILL = [
    ("Disease Demon",        "Disease demon",        "demon"),
    ("Demon",                "Demon",                "demon"),
    ("Angelic Being",        "Angelic being",        "angel"),
    ("Dragon Demon",         "Dragon demon",         "monster"),
    ("Sea Monster",          "Sea monster",          "monster"),
    ("Ritual Category",      "Ritual category",      "ritual"),
    ("Child-Harming Spirit", "Child-harming spirit", "spirit"),
    ("Wind Demon",           "Wind demon",           "demon"),
    ("Wind Spirit",          "Wind spirit",          "spirit"),
]

def q(s): return "'" + s.replace("'", "''") + "'"

def main():
    valid = {c[0] for c in CLASSES}
    mp = {}
    for line in open("/tmp/classmap_full.tsv", encoding="utf-8"):
        line = line.rstrip("\n")
        if not line: continue
        et, cls = line.split("\t")
        assert cls in valid, (et, cls)
        mp[et] = cls
    # add the normalized blank-fill target types to the map
    for _cat, etype, cls in BLANK_FILL:
        assert cls in valid
        mp[etype] = cls

    out = []
    w = out.append
    w("-- upgrade_v2_0_entity_class.sql")
    w("-- DeityDB v2.0.0 — schema epoch: controlled entity_class over free-text entity_type.")
    w("-- Adds entity_class lookup (19 classes) + entity_type_class_map, fills the 57 blank")
    w("-- entity_types from category, adds entities.entity_class (FK + index), backfills, and")
    w("-- verifies fail-closed. Idempotent. Apply with: psql -v ON_ERROR_STOP=1 -f this file.")
    w("")
    w("BEGIN;")
    w("")
    w("-- 1. controlled vocabulary")
    w("CREATE TABLE IF NOT EXISTS entity_class (")
    w("  class_id    text PRIMARY KEY,")
    w("  label       text NOT NULL,")
    w("  description text,")
    w("  sort_order  integer NOT NULL DEFAULT 0")
    w(");")
    w("INSERT INTO entity_class (class_id,label,description,sort_order) VALUES")
    rows = [f"  ({q(cid)},{q(lab)},{q(desc)},{so})" for cid,lab,desc,so in CLASSES]
    w(",\n".join(rows))
    w("ON CONFLICT (class_id) DO UPDATE SET")
    w("  label=EXCLUDED.label, description=EXCLUDED.description, sort_order=EXCLUDED.sort_order;")
    w("")
    w("-- 2. free-text entity_type -> controlled class map")
    w("CREATE TABLE IF NOT EXISTS entity_type_class_map (")
    w("  entity_type  text PRIMARY KEY,")
    w("  entity_class text NOT NULL REFERENCES entity_class(class_id)")
    w(");")
    w("INSERT INTO entity_type_class_map (entity_type,entity_class) VALUES")
    rows = [f"  ({q(et)},{q(mp[et])})" for et in sorted(mp)]
    w(",\n".join(rows))
    w("ON CONFLICT (entity_type) DO UPDATE SET entity_class=EXCLUDED.entity_class;")
    w("")
    w("-- 3. fill the 57 blank entity_types from their category (normalized)")
    for cat, etype, _cls in BLANK_FILL:
        w(f"UPDATE entities SET entity_type={q(etype)} "
          f"WHERE (entity_type IS NULL OR btrim(entity_type)='') AND btrim(category)={q(cat)};")
    w("")
    w("-- 4. add the column and backfill from the map")
    w("ALTER TABLE entities ADD COLUMN IF NOT EXISTS entity_class text;")
    w("UPDATE entities e SET entity_class = m.entity_class")
    w("  FROM entity_type_class_map m WHERE e.entity_type = m.entity_type;")
    w("")
    w("-- 5. constraints + index")
    w("CREATE INDEX IF NOT EXISTS idx_entities_class ON entities(entity_class);")
    w("ALTER TABLE entities DROP CONSTRAINT IF EXISTS entities_entity_class_fkey;")
    w("ALTER TABLE entities ADD CONSTRAINT entities_entity_class_fkey")
    w("  FOREIGN KEY (entity_class) REFERENCES entity_class(class_id);")
    w("")
    w("-- 6. fail-closed verification")
    w("DO $$")
    w("DECLARE n int;")
    w("BEGIN")
    w("  SELECT count(*) INTO n FROM entities WHERE entity_type IS NULL OR btrim(entity_type)='';")
    w("  IF n<>0 THEN RAISE EXCEPTION 'v2.0 gate: % blank entity_type remain', n; END IF;")
    w("  SELECT count(*) INTO n FROM entities WHERE entity_class IS NULL;")
    w("  IF n<>0 THEN RAISE EXCEPTION 'v2.0 gate: % entities with NULL entity_class', n; END IF;")
    w("  SELECT count(DISTINCT e.entity_type) INTO n FROM entities e")
    w("    LEFT JOIN entity_type_class_map m ON e.entity_type=m.entity_type WHERE m.entity_type IS NULL;")
    w("  IF n<>0 THEN RAISE EXCEPTION 'v2.0 gate: % entity_types not in the class map', n; END IF;")
    w("END $$;")
    w("")
    w("COMMIT;")
    w("")
    w("-- post-commit report")
    w("SELECT ec.sort_order, e.entity_class, ec.label, count(*) AS entities")
    w("  FROM entities e JOIN entity_class ec ON e.entity_class=ec.class_id")
    w("  GROUP BY 1,2,3 ORDER BY 1;")
    w("")

    open("upgrade_v2_0_entity_class.sql","w",encoding="utf-8").write("\n".join(out))
    print(f"wrote upgrade_v2_0_entity_class.sql  ({len(mp)} map rows, {len(CLASSES)} classes)")

if __name__ == "__main__":
    main()
