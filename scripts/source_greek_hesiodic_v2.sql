-- scripts/source_greek_hesiodic_v2.sql
-- Greek rigor pass II (v1.37.0): the Orphic primordials, the river-gods, and the
-- Hesiodic daimon-personifications. Additive primary attestation, each matched to its
-- correct source. Uses the newly-added Orphic Hymns.

BEGIN;

-- New source: the Orphic Hymns (the user added the Taylor and a numbered edition)
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_ORPHIC_HYMNS','The Orphic Hymns (87 hymns; with the Orphic cosmogony), trans. Thomas Taylor (1792) and Athanassakis & Wolkow (2013)','','primary text','Orphic theology: Protogonos/Phanes, Physis, Chronos, Nyx, Ouranos, Aether and the Orphic pantheon')
ON CONFLICT (source_id) DO NOTHING;

-- ── Orphic primordials → Orphic Hymns ────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_ORPHIC_HYMNS', 'Direct attestation', src_note FROM (VALUES
 ('Phanes','Orphic Hymn 6 (To Protogonos/Phanes/Erikepaios), the firstborn of the cosmic egg.'),
 ('Physis','Orphic Hymn 10 (To Nature/Physis).'),
 ('Chronos','The Orphic cosmogony: unaging Chronos (Time) as the first principle, from whom the cosmic egg is formed.'),
 ('Ananke','The Orphic cosmogony: Ananke (Necessity) entwined with Chronos at the beginning.')
) AS t(name, src_note)
JOIN entities e ON e.tradition='Greek' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;
-- Orphic Hymn attestation for the primordials who also have hymns (already Hesiod-sourced)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_ORPHIC_HYMNS', 'Direct attestation', 'Hymned in the Orphic Hymns (Nyx H.3, Ouranos H.4, Aether H.5).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Nyx','Ouranos','Uranus','Aether')
ON CONFLICT DO NOTHING;

-- ── River-gods (Potamoi) → Hesiod, Theogony 337-345 (sons of Oceanus and Tethys) ──
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 337-345 (the river-gods, sons of Oceanus and Tethys; the chief streams named).'
FROM entities WHERE tradition='Greek' AND entity_type='River god/Potamos'
ON CONFLICT DO NOTHING;
-- The rivers that appear/act in the Iliad → Homer
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMER_ILIAD_ODYSSEY', 'Direct attestation', 'Named among the rivers of the Troad and the wider Iliad (e.g. Il. 12.20-22, 21).'
FROM entities WHERE tradition='Greek' AND canonical_name IN
  ('Scamander','Xanthus','Simoeis','Aesepus','Granicus','Rhesus River','Satnioeis','Titaresius','Spercheios','Axius','Caicus')
ON CONFLICT DO NOTHING;

-- ── Hesiodic daimones, by genealogy ──────────────────────────────────────────
-- Children of Night (Nyx) — Hesiod, Theogony 211-225
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 211-225 (among the children of Night).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Apate','Geras','Momos','Momus','Oizys','Philotes','Eris')
ON CONFLICT DO NOTHING;
-- Children of Strife (Eris) — Hesiod, Theogony 226-232
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 226-232 (the grim children of Strife).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Ponos','Limos','Algea','Hysminai','Machai','Neikea','Pseudologoi','Amphilogiai','Dysnomia','Ate','Atë','Horkos')
ON CONFLICT DO NOTHING;
-- Children of Styx — Hesiod, Theogony 383-385
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 383-385 (Zelos, Nike, Kratos, and Bia, children of Styx).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Zelos','Kratos','Bia')
ON CONFLICT DO NOTHING;
-- Children of Ares and Aphrodite — Hesiod, Theogony 933-937
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 933-937 (Deimos and Phobos, sons of Ares; Harmonia, daughter of Ares and Aphrodite).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Deimos','Phobos','Harmonia')
ON CONFLICT DO NOTHING;
-- Eros and Himeros attending Aphrodite — Hesiod, Theogony 201
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 201 (Eros and Himeros attend Aphrodite at her birth).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Eros','Himeros')
ON CONFLICT DO NOTHING;
-- War daimones named by Homer — Iliad
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMER_ILIAD_ODYSSEY', 'Direct attestation', 'Homer, Iliad (Enyo the war-goddess, Il. 5; Kydoimos the Din of Battle on the Shield of Achilles, Il. 18.535).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Enyo','Kydoimos')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT
  count(*) AS greek_entities,
  round(100.0*count(*) FILTER (WHERE has_primary)/count(*),0) AS pct_w_primary,
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
