-- Sourcing batch 1: eight fully-unsourced traditions
-- Applies the most appropriate encyclopedic or primary reference to each
-- tradition's unsourced entities. evidence_type:
--   primary_attestation  — entity named in this primary text
--   secondary_reference  — entity attested within the scope of this scholarly work
--
-- Traditions: Germanic/Norse, Canaanite/Ugaritic, Zoroastrian, Manichaean,
--             Mandaean, Celtic/Irish, Roman, Hermetic/Theurgic
-- Entities covered: 101

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- Germanic / Norse (20) — Simek, Dictionary of Northern Mythology
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_SIMEK_NORTHERN_MYTH', 'secondary_reference',
       'Attested in Simek, Dictionary of Northern Mythology.'
FROM entities e
WHERE e.tradition = 'Germanic/Norse'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_SIMEK_NORTHERN_MYTH'
  )
ON CONFLICT DO NOTHING;

-- Prose Edda as primary attestation for the core mythological figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_PROSE_EDDA', 'primary_attestation',
       'Named in Snorri Sturluson, Prose Edda.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_NOR_ODIN','ENT_NOR_THOR','ENT_NOR_FREYJA','ENT_NOR_FREYR',
    'ENT_NOR_FRIGG','ENT_NOR_LOKI','ENT_NOR_BALDR','ENT_NOR_TYR',
    'ENT_NOR_NJORD','ENT_NOR_HEL','ENT_NOR_FENRIR','ENT_NOR_JORMUNGANDR',
    'ENT_NOR_NIDHOGG','ENT_NOR_YGGDRASIL','ENT_NOR_NORNS',
    'ENT_NOR_VALKYRIES','ENT_NOR_AESIR','ENT_NOR_VANIR',
    'ENT_NOR_JOTNAR','ENT_NOR_DWARVES'
)
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Canaanite / Ugaritic (12) — DDD Bible NW Semitic + Pardee
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_UGARIT_DDD', 'secondary_reference',
       'Attested in DDD Bible, Canaanite/Ugaritic entries.'
FROM entities e
WHERE e.tradition = 'Canaanite/Ugaritic'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_UGARIT_DDD'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_UGARIT_PARDON', 'secondary_reference',
       'Attested in Pardee, Ritual and Cult at Ugarit.'
FROM entities e
WHERE e.tradition = 'Canaanite/Ugaritic'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_UGARIT_PARDON'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Zoroastrian (15) — Boyce + Avesta
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_BOYCE_ZOROASTRIANS', 'secondary_reference',
       'Attested in Mary Boyce, Zoroastrians.'
FROM entities e
WHERE e.tradition = 'Zoroastrian'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_BOYCE_ZOROASTRIANS'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_AVESTA', 'primary_attestation',
       'Named in the Avesta.'
FROM entities e
WHERE e.tradition = 'Zoroastrian'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_AVESTA'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Manichaean (15) — Kephalaia (primary) + Lieu (secondary)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_MANICHAEAN_KEPHALAIA', 'primary_attestation',
       'Named in the Manichaean Kephalaia.'
FROM entities e
WHERE e.tradition = 'Manichaean'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_MANICHAEAN_KEPHALAIA'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_LIEU_MANICHAEISM', 'secondary_reference',
       'Attested in Lieu, Manichaeism in the Later Roman Empire and Medieval China.'
FROM entities e
WHERE e.tradition = 'Manichaean'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_LIEU_MANICHAEISM'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Mandaean (15) — Ginza Rba (primary) + Drower (secondary)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_GINZA_RBA', 'primary_attestation',
       'Named in the Ginza Rba.'
FROM entities e
WHERE e.tradition = 'Mandaean'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_GINZA_RBA'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_DROWER_MANDAEANS', 'secondary_reference',
       'Attested in Drower, The Mandaeans of Iraq and Iran.'
FROM entities e
WHERE e.tradition = 'Mandaean'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_DROWER_MANDAEANS'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Celtic / Irish (12) — Mac Cana (secondary) + Lebor Gabála (primary)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_MACCANA_CELTIC_MYTH', 'secondary_reference',
       'Attested in Mac Cana, Celtic Mythology.'
FROM entities e
WHERE e.tradition = 'Celtic/Irish'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_MACCANA_CELTIC_MYTH'
  )
ON CONFLICT DO NOTHING;

-- Lebor Gabála as primary for the Tuatha Dé Danann and named Irish gods
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_LEBOR_GABALA', 'primary_attestation',
       'Named in Lebor Gabála Érenn.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_CEL_TUATHA','ENT_CEL_DAGDA','ENT_CEL_LUGH','ENT_CEL_NUADA',
    'ENT_CEL_BRIGID','ENT_CEL_GOIBNIU','ENT_CEL_DIANCECHT',
    'ENT_CEL_AENGUS','ENT_CEL_MANANNAN','ENT_CEL_FOMORIANS'
)
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Roman (22) — Oxford Classical Dictionary + Ovid Fasti
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ROMAN_OCD', 'secondary_reference',
       'Attested in Oxford Classical Dictionary, Roman Religion entries.'
FROM entities e
WHERE e.tradition = 'Roman'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_ROMAN_OCD'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_BEARD_ROMAN_RELIGIONS', 'secondary_reference',
       'Attested in Beard, North, Price, Religions of Rome.'
FROM entities e
WHERE e.tradition = 'Roman'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_BEARD_ROMAN_RELIGIONS'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Hermetic / Theurgic (5) — Corpus Hermeticum (primary)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_CORPUS_HERMETICUM', 'primary_attestation',
       'Named or central concept in the Corpus Hermeticum.'
FROM entities e
WHERE e.tradition = 'Hermetic/Theurgic'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_CORPUS_HERMETICUM'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify: unsourced count by tradition before and after
-- ─────────────────────────────────────────────────────────────────────────────

SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition IN (
    'Germanic/Norse','Canaanite/Ugaritic','Zoroastrian','Manichaean',
    'Mandaean','Celtic/Irish','Roman','Hermetic/Theurgic'
)
GROUP BY e.tradition
ORDER BY still_unsourced DESC, e.tradition;

COMMIT;
