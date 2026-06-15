-- scripts/source_greek_hesiodic_v1.sql
-- Greek rigor pass I (v1.36.0): attach primary-text attestation to the Greek catalogue
-- clusters that were sourced only to the Theoi.com index. Additive — the Theoi reference
-- is kept; the actual primary source (already in the registry) is added with its locus.
--
-- Each cluster is matched to its correct primary source, NOT blanket-assigned by type:
--   Muses, Moirai, Charites, Nereids, Oceanids, the cosmogonic primordials, the astral
--   deities, and Ker/Moros -> Hesiod, Theogony (specific passages); the Nereids also
--   -> Homer, Iliad 18. The Athenian Horai (Auxo/Carpo/Thallo) -> Pausanias, not Hesiod;
--   the individually-named Hesperides -> Apollodorus, not Hesiod. The Orphic primordials
--   (Phanes, Chronos, Ophion, Hydros, Thesis, Physis, Ananke, Eurynome, Thalassa, Nesoi)
--   are deliberately deferred — they need an Orphic source, not Hesiod.

BEGIN;

-- Muses → Hesiod, Theogony 75-79, 915-917
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 75-79, 915-917 (the nine Muses named, daughters of Zeus and Mnemosyne).'
FROM entities WHERE tradition='Greek' AND entity_type='Muse'
ON CONFLICT DO NOTHING;

-- Moirai (Fates) → Hesiod, Theogony 217-219, 904-906
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 217-219, 904-906 (Clotho, Lachesis, and Atropos).'
FROM entities WHERE tradition='Greek' AND entity_type='Fate goddess'
ON CONFLICT DO NOTHING;

-- Charites (Graces) → Hesiod, Theogony 907-911
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 907-911 (Aglaia, Euphrosyne, and Thalia, daughters of Zeus and Eurynome).'
FROM entities WHERE tradition='Greek' AND entity_type='Grace goddess'
ON CONFLICT DO NOTHING;

-- Nereids → Hesiod, Theogony 240-264 + Homer, Iliad 18.39-49
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 240-264 (the catalogue of the Nereids, daughters of Nereus and Doris).'
FROM entities WHERE tradition='Greek' AND entity_type='Nereid'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMER_ILIAD_ODYSSEY', 'Direct attestation', 'Homer, Iliad 18.39-49 (the Nereids who attend Thetis in her mourning).'
FROM entities WHERE tradition='Greek' AND entity_type='Nereid'
ON CONFLICT DO NOTHING;

-- Oceanids → Hesiod, Theogony 346-366
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 346-366 (the catalogue and genealogy of the Oceanids, daughters of Oceanus and Tethys).'
FROM entities WHERE tradition='Greek' AND entity_type='Oceanid'
ON CONFLICT DO NOTHING;

-- The Athenian Horai (Auxo, Carpo, Thallo) → Pausanias 9.35.2 (NOT Hesiod's Eunomia/Dike/Eirene)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_PAUSANIAS_DESCRIPTION', 'Direct attestation', 'Pausanias 9.35.1-2 (the Athenian Horai/Seasons Auxo, Carpo, and Thallo).'
FROM entities WHERE tradition='Greek' AND entity_type='Hora/seasonal goddess'
ON CONFLICT DO NOTHING;

-- The individually-named Hesperides → Apollodorus 2.5.11 (Hesiod names them only as a group)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_APOLLODORUS_LIBRARY', 'Direct attestation', 'Apollodorus, Library 2.5.11 (the named Hesperides: Aigle, Erytheia, Hesperia, Arethusa).'
FROM entities WHERE tradition='Greek' AND entity_type='Hesperid'
ON CONFLICT DO NOTHING;

-- The cosmogonic primordials → Hesiod, Theogony 116-138 (named subset only; Orphic ones excluded)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 116-138 (the first beings: Chaos, Gaia, Tartarus, Eros, Erebus, Night, and their first offspring).'
FROM entities WHERE tradition='Greek' AND canonical_name IN
  ('Chaos','Gaia','Tartarus','Eros Primordial','Erebus','Nyx','Aether','Hemera','Ouranos','Uranus','Ourea','Pontus')
ON CONFLICT DO NOTHING;

-- The astral deities → Hesiod, Theogony 371-382
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 371-382 (Helios, Selene, and Eos, children of Hyperion and Theia; Eosphorus and the stars from Eos and Astraeus).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Helios','Selene','Eos','Eosphorus','Hesperus')
ON CONFLICT DO NOTHING;

-- Ker and Moros (children of Night) → Hesiod, Theogony 211-212
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_THEOGONY', 'Direct attestation', 'Hesiod, Theogony 211-212 (Moros and Ker among the children of Night).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Ker','Moros')
ON CONFLICT DO NOTHING;

-- ── Verify: the Greek primary-sourcing gap should shrink markedly ────────────
SELECT
  count(*) AS greek_entities,
  count(*) FILTER (WHERE has_primary) AS with_primary,
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
