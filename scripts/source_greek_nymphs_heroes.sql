-- scripts/source_greek_nymphs_heroes.sql
-- Greek rigor pass III (v1.38.0): nymphs, heroes/deified mortals, and the daimon
-- stragglers now coverable by the newly-added Plato Symposium and Hesiod Works & Days.
-- Additive primary attestation, each matched to its correct source.

BEGIN;

-- New sources (user added the texts)
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_PLATO_SYMPOSIUM','Plato, Symposium (c. 385-370 BCE), trans. various','','primary text','Greek philosophical dialogue; the genealogy of Eros, and Penia and Poros'),
('SRC_HESIOD_WORKS_DAYS','Hesiod, Works and Days (c. 700 BCE), trans. Evelyn-White','','primary text','Greek didactic epic; the two Strifes, Pandora, the Five Ages, and the personifications Aidos, Nemesis, Elpis, Pheme, Dike, Arete')
ON CONFLICT (source_id) DO NOTHING;

-- ── Heroes / deified mortals → Apollodorus, Library (the mythographic handbook) ──
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_APOLLODORUS_LIBRARY', 'Direct attestation', 'Apollodorus, Library/Epitome (the standard mythographic compendium of the Greek heroes).'
FROM entities WHERE tradition='Greek' AND entity_type='Hero/deified mortal/cult figure'
ON CONFLICT DO NOTHING;
-- The heroes of the Trojan and Odyssean cycles → also Homer
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMER_ILIAD_ODYSSEY', 'Direct attestation', 'A protagonist of the Homeric epics.'
FROM entities WHERE tradition='Greek' AND canonical_name IN
  ('Achilles','Ajax','Hector','Diomedes','Odysseus','Menelaus','Helen','Aeneas Greek reception','Memnon','Protesilaus','Rhadamanthys Hero','Idomeneus','Nestor','Patroclus')
ON CONFLICT DO NOTHING;

-- ── Nymphs ───────────────────────────────────────────────────────────────────
-- The nymph classes/collectives → Homeric Hymns (Hymn to Aphrodite 256-275 on the nymphs)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMERIC_HYMNS', 'Direct attestation', 'Homeric Hymn to Aphrodite 256-275 (the mountain/tree nymphs) and Hymn 19 to Pan (the nymph-classes of spring, mountain, and woodland).'
FROM entities WHERE tradition='Greek' AND entity_type='Nymph collective'
  AND canonical_name NOT IN ('Hesperides','Nereids','Oceanids')  -- already primary-sourced elsewhere
ON CONFLICT DO NOTHING;
-- The Meliae → Hesiod, Theogony 187 (the ash-tree nymphs from the blood of Ouranos)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 187 (the Meliae, ash-tree nymphs born from the blood of Ouranos).'
FROM entities WHERE tradition='Greek' AND canonical_name='Meliae'
ON CONFLICT DO NOTHING;
-- Calypso → Homer, Odyssey 5
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMER_ILIAD_ODYSSEY', 'Direct attestation', 'Homer, Odyssey 5 (Calypso, the nymph of Ogygia who detains Odysseus).'
FROM entities WHERE tradition='Greek' AND canonical_name='Calypso'
ON CONFLICT DO NOTHING;
-- Genealogical nymphs → Apollodorus
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_APOLLODORUS_LIBRARY', 'Direct attestation', 'Apollodorus, Library (genealogy of the nymph).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Aegina','Cyrene','Adrasteia Nymph','Idaia')
ON CONFLICT DO NOTHING;
-- Local-cult nymphs → Pausanias
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_PAUSANIAS_DESCRIPTION', 'Direct attestation', 'Pausanias, Description of Greece (the local nymph and her cult).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Corycia','Corycian Nymphs','Neda','Dirce')
ON CONFLICT DO NOTHING;

-- ── Daimon stragglers ────────────────────────────────────────────────────────
-- Penia and Poros → Plato, Symposium 203b-e
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_PLATO_SYMPOSIUM', 'Direct attestation', 'Plato, Symposium 203b-e (Poros and Penia as the parents of Eros in Diotima''s speech).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Penia','Poros')
ON CONFLICT DO NOTHING;
-- Aidos, Elpis, Pheme, Arete → Hesiod, Works and Days
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_WORKS_DAYS', 'Direct attestation', src_note FROM (VALUES
 ('Aidos','Hesiod, Works and Days 197-201 (Aidos and Nemesis abandon humankind in the Iron Age).'),
 ('Elpis','Hesiod, Works and Days 90-99 (Elpis/Hope remains in Pandora''s jar).'),
 ('Pheme','Hesiod, Works and Days 760-764 (Pheme/Rumor, who never wholly dies).'),
 ('Arete','Hesiod, Works and Days 287-292 (Arete/Excellence, set by the gods at the end of a steep path).')
) AS t(name, src_note)
JOIN entities e ON e.tradition='Greek' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;
-- The two Strifes (Eris) → also Works and Days 11-26
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_WORKS_DAYS', 'Direct attestation', 'Hesiod, Works and Days 11-26 (the two Strifes, the harmful and the wholesome).'
FROM entities WHERE tradition='Greek' AND canonical_name='Eris'
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS greek, round(100.0*count(*) FILTER (WHERE has_primary)/count(*),0) AS pct_w_primary,
  count(*) FILTER (WHERE NOT has_primary AND NOT has_secondary) AS ref_only
FROM (
  SELECT e.entity_id,
    bool_or(s.source_type IN ('primary text','primary inscription/artifact','heresiological source')) AS has_primary,
    bool_or(s.source_type='secondary scholarship') AS has_secondary
  FROM entities e JOIN entity_sources es ON es.entity_id=e.entity_id JOIN sources s ON s.source_id=es.source_id
  WHERE e.tradition='Greek' GROUP BY e.entity_id) g;
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
