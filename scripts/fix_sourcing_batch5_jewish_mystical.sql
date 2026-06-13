-- Sourcing batch 5: Jewish Mystical tradition
-- 14 entities; split between Hekhalot and Kabbalistic subcorpora

BEGIN;

-- Scholem as broad secondary_reference for all Jewish Mystical entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_SCHOLEM_KABBALAH', 'secondary_reference',
       'Attested in Gershom Scholem, Kabbalah.'
FROM entities e
WHERE e.tradition = 'Jewish Mystical'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_SCHOLEM_KABBALAH'
  )
ON CONFLICT DO NOTHING;

-- Hekhalot / Merkabah primary_attestation for throne-world and celestial beings
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_HEKHALOT_SCHAFER_SYNOPSE', 'primary_attestation',
       'Named in Hekhalot literature (Schäfer Synopse).'
FROM entities e
WHERE e.entity_id IN (
    'ENT_JM_METATRON','ENT_JM_SAR_TORAH','ENT_JM_MERKABAH',
    'ENT_JM_CHAYYOT','ENT_JM_OPHANIM','ENT_JM_HASHMALLIM',
    'ENT_JM_RAZIEL','ENT_JM_SANDALPHON','ENT_JM_SERAPHIM'
)
ON CONFLICT DO NOTHING;

-- 3 Enoch for Metatron and Sar Torah specifically
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_3_ENOCH', 'primary_attestation',
       'Named in 3 Enoch / Sefer Hekhalot.'
FROM entities e
WHERE e.entity_id IN ('ENT_JM_METATRON','ENT_JM_SAR_TORAH')
ON CONFLICT DO NOTHING;

-- Zohar as primary_attestation for Kabbalistic sefirot entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_ZOHAR', 'primary_attestation',
       'Named or central concept in the Zohar.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_JM_SEFIROT','ENT_JM_BINAH','ENT_JM_HOKHMAH',
    'ENT_JM_KETER','ENT_JM_SHEKHINAH','ENT_JM_ADAM_KADMON'
)
ON CONFLICT DO NOTHING;

-- Verify
SELECT tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE tradition = 'Jewish Mystical'
GROUP BY tradition;

COMMIT;
