-- Sourcing batch 9: remaining tradition-specific entities
-- Mesopotamian (28), Celtic/Gaulish (7), Greco-Egyptian (4),
-- Late Antique Ritual (6), Roman/Persian reception (1)
-- Total: 47 entities

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- Mesopotamian (28) — Black & Green base + ETCSL + ORACC
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_BLACK_GREEN_MESO', 'secondary_reference',
       'Attested in Black and Green, Gods, Demons and Symbols of Ancient Mesopotamia.'
FROM entities e
WHERE e.tradition = 'Mesopotamian'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_BLACK_GREEN_MESO'
  )
ON CONFLICT DO NOTHING;

-- ETCSL for Sumerian literary tradition figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ETCSL', 'primary_attestation',
       'Named in Electronic Text Corpus of Sumerian Literature.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_MES_INANNA_ISHTAR','ENT_MES_DUMUZI_TAMMUZ','ENT_MES_ENKI_EA',
    'ENT_MES_ENLIL','ENT_MES_NINHURSAG','ENT_MES_ERESHKIGAL',
    'ENT_MES_UTU_SHAMASH','ENT_MES_NANNA_SIN','ENT_MES_ANUNNAKI',
    'ENT_MES_IGIGI','ENT_MES_NISABA','ENT_MES_GESHTINANNA',
    'ENT_MES_NINURTA','ENT_MES_GALLA','ENT_MES_KINGU',
    'ENT_MES_APSU','ENT_MES_TIAMAT'
)
ON CONFLICT DO NOTHING;

-- ORACC for Akkadian tradition figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ORACC', 'primary_attestation',
       'Named in Open Richly Annotated Cuneiform Corpus (Akkadian texts).'
FROM entities e
WHERE e.entity_id IN (
    'ENT_MES_MARDUK','ENT_MES_ASHUR','ENT_MES_NABU',
    'ENT_MES_ADAD_ISHKUR','ENT_MES_ANU','ENT_MES_NERGAL',
    'ENT_MES_LAMASHTU','ENT_MES_PAZUZU','ENT_MES_RABISU',
    'ENT_MES_UTUKKU','ENT_MES_APKALLU','ENT_MES_TIAMAT',
    'ENT_MES_APSU','ENT_MES_KINGU'
)
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Celtic/Gaulish (7) — Green Celtic Gods
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_GREEN_CELTIC_GODS', 'secondary_reference',
       'Attested in Miranda Green, Dictionary of Celtic Myth and Legend.'
FROM entities e
WHERE e.tradition IN ('Celtic/Gaulish','Celtic/Gaulish/Roman')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_GREEN_CELTIC_GODS'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Greco-Egyptian syncretic deities (4)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_WILKINSON_EGYPTIAN_GODS', 'secondary_reference',
       'Attested in Wilkinson, The Complete Gods and Goddesses of Ancient Egypt.'
FROM entities e
WHERE e.tradition IN ('Greco-Egyptian','Greco-Egyptian/Libyan')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_WILKINSON_EGYPTIAN_GODS'
  )
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ROMAN_OCD', 'secondary_reference',
       'Attested in Oxford Classical Dictionary, Roman Religion entries.'
FROM entities e
WHERE e.tradition IN ('Greco-Egyptian','Greco-Egyptian/Libyan')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_ROMAN_OCD'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Hermetic/Greco-Egyptian (1 — Agathos Daimon Hermetic)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES (
    'ENT_LAT_AGATHOS_DAIMON_HERMETIC', 'SRC_CORPUS_HERMETICUM', 'primary_attestation',
    'Agathos Daimon appears as revealer figure in Hermetic literature.'
)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES (
    'ENT_LAT_AGATHOS_DAIMON_HERMETIC', 'SRC_ASCLEPIUS_HERMETICA', 'secondary_reference',
    'Attested in Asclepius (Hermetic corpus).'
)
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Late Antique Ritual (6) — Iamblichus De Mysteriis
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_IAMBLICHUS_DE_MYSTERIIS', 'primary_attestation',
       'Named or classified in Iamblichus, De Mysteriis.'
FROM entities e
WHERE e.tradition = 'Late Antique Ritual'
  AND e.entity_id IN (
    'ENT_THEURGIC_ASENT','ENT_THEURGY','ENT_LAT_PLANETARY_RULERS',
    'ENT_LAT_HEROES','ENT_LAT_PURIFIED_SOULS','ENT_LAT_DAIMONES'
  )
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_IAMBLICHUS_DE_MYSTERIIS'
  )
ON CONFLICT DO NOTHING;

-- Greek Magical Papyri as additional for planetary rulers and daimones
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_GREEK_MAGICAL_PAPYRI', 'secondary_reference',
       'Attested in Greek Magical Papyri (late antique ritual tradition).'
FROM entities e
WHERE e.entity_id IN ('ENT_LAT_PLANETARY_RULERS','ENT_LAT_DAIMONES')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_GREEK_MAGICAL_PAPYRI'
  )
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Roman/Persian reception (1 — Mithras)
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES (
    'ENT_SYN_MITHRAS', 'SRC_ROMAN_OCD', 'secondary_reference',
    'Attested in Oxford Classical Dictionary, Roman Religion entries.'
),
(
    'ENT_SYN_MITHRAS', 'SRC_BEARD_ROMAN_RELIGIONS', 'secondary_reference',
    'Attested in Beard, North, Price, Religions of Rome.'
)
ON CONFLICT DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify all affected traditions
-- ─────────────────────────────────────────────────────────────────────────────

SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition IN (
    'Mesopotamian','Celtic/Gaulish','Celtic/Gaulish/Roman',
    'Greco-Egyptian','Greco-Egyptian/Libyan','Hermetic/Greco-Egyptian',
    'Late Antique Ritual','Roman/Persian reception'
)
GROUP BY e.tradition
ORDER BY still_unsourced DESC, e.tradition;

COMMIT;
