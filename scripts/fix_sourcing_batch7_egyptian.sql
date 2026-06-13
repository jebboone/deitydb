-- Sourcing batch 7: Egyptian tradition (unsourced entities)
-- 35 entities. Category normalization plan in docs already resolved in DB.
-- Sources: Wilkinson (base), Pinch (secondary), Hornung (funerary/Duat).

BEGIN;

-- Wilkinson as base secondary_reference for all unsourced Egyptian entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_WILKINSON_EGYPTIAN_GODS', 'secondary_reference',
       'Attested in Wilkinson, The Complete Gods and Goddesses of Ancient Egypt.'
FROM entities e
WHERE e.tradition = 'Egyptian'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_WILKINSON_EGYPTIAN_GODS'
  )
ON CONFLICT DO NOTHING;

-- Pinch as additional secondary_reference
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_PINCH_EGYPTIAN_MYTH', 'secondary_reference',
       'Attested in Pinch, Egyptian Mythology.'
FROM entities e
WHERE e.tradition = 'Egyptian'
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_PINCH_EGYPTIAN_MYTH'
  )
ON CONFLICT DO NOTHING;

-- Hornung as primary_attestation for netherworld/funerary/solar-journey entities
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_HORNUNG_DUAT', 'primary_attestation',
       'Named in Egyptian Books of the Afterlife (Hornung).'
FROM entities e
WHERE e.entity_id IN (
    'ENT_EGY_DUAT','ENT_EGY_SEKER','ENT_EGY_PTAH_SEKER_OSIRIS',
    'ENT_EGY_FOUR_SONS_OF_HORUS','ENT_EGY_NUN','ENT_EGY_NAUNET',
    'ENT_EGY_OGDOAD','ENT_EGY_AMUNET','ENT_EGY_KEK','ENT_EGY_KAUKET',
    'ENT_EGY_HEH','ENT_EGY_HAUHET','ENT_EGY_KHEPRI',
    'ENT_EGY_HARAKHTY','ENT_EGY_RA_HORAKHTY'
)
ON CONFLICT DO NOTHING;

-- Verify
SELECT tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE tradition = 'Egyptian'
GROUP BY tradition;

COMMIT;
