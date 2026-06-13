-- Sourcing batch 4: Israelite/Second Temple and Jewish traditions
-- 22 entities

BEGIN;

-- DDD Bible as base secondary_reference for all
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_DDD_BIBLE', 'secondary_reference',
       'Attested in Dictionary of Deities and Demons in the Bible.'
FROM entities e
WHERE e.tradition IN ('Israelite/Second Temple','Jewish')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_DDD_BIBLE'
  )
ON CONFLICT DO NOTHING;

-- 1 Enoch as primary_attestation for Watcher-tradition figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_1_ENOCH', 'primary_attestation',
       'Named in 1 Enoch.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_ISR_WATCHERS','ENT_ISR_AZAZEL','ENT_ISR_SHEMIHAZAH',
    'ENT_ENOCH','ENT_ISR_URIEL','ENT_ISR_RAPHAEL',
    'ENT_ISR_GABRIEL','ENT_ISR_MICHAEL'
)
ON CONFLICT DO NOTHING;

-- Verify
SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition IN ('Israelite/Second Temple','Jewish')
GROUP BY e.tradition ORDER BY e.tradition;

COMMIT;
