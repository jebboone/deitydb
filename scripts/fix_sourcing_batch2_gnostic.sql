-- Sourcing batch 2: Gnostic cluster
-- Covers Valentinian, Sethian, Ophite/Archontic, Gnostic, Gnostic/Platonic,
-- Christian/Gnostic, Thomasine/Christian-Gnostic, Sethian/Ophite variants.
-- Greek/Orphic entities (ENT_PROTOGONOS, ENT_ADRASTEIA) deferred to Greek batch.
-- Entities covered: 61

BEGIN;

-- SRC_NHC as primary_attestation for all Gnostic-cluster entities
-- (Nag Hammadi Library contains the primary textual sources for all of these)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_NHC', 'primary_attestation',
       'Named or attested in the Nag Hammadi Library.'
FROM entities e
WHERE e.tradition IN (
    'Gnostic','Valentinian','Sethian','Ophite/Archontic',
    'Gnostic/Platonic','Christian/Gnostic',
    'Thomasine/Christian-Gnostic','Sethian/Ophite',
    'Sethian/Ophite/Jewish','Ophite/Sethian'
)
  AND e.entity_id NOT IN ('ENT_PROTOGONOS','ENT_ADRASTEIA')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_NHC'
  )
ON CONFLICT DO NOTHING;

-- SRC_LAYTON_GNOSTIC as secondary_reference for all
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_LAYTON_GNOSTIC', 'secondary_reference',
       'Attested in Layton, The Gnostic Scriptures.'
FROM entities e
WHERE e.tradition IN (
    'Gnostic','Valentinian','Sethian','Ophite/Archontic',
    'Gnostic/Platonic','Christian/Gnostic',
    'Thomasine/Christian-Gnostic','Sethian/Ophite',
    'Sethian/Ophite/Jewish','Ophite/Sethian'
)
  AND e.entity_id NOT IN ('ENT_PROTOGONOS','ENT_ADRASTEIA')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_LAYTON_GNOSTIC'
  )
ON CONFLICT DO NOTHING;

-- SRC_MEYER_GNOSTIC_BIBLE as additional secondary for Ophite and Thomasine
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_MEYER_GNOSTIC_BIBLE', 'secondary_reference',
       'Attested in Meyer, The Gnostic Bible.'
FROM entities e
WHERE e.tradition IN (
    'Ophite/Archontic','Thomasine/Christian-Gnostic',
    'Sethian/Ophite','Ophite/Sethian','Sethian/Ophite/Jewish'
)
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_MEYER_GNOSTIC_BIBLE'
  )
ON CONFLICT DO NOTHING;

-- Verify
SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition IN (
    'Gnostic','Valentinian','Sethian','Ophite/Archontic',
    'Gnostic/Platonic','Christian/Gnostic',
    'Thomasine/Christian-Gnostic','Sethian/Ophite',
    'Sethian/Ophite/Jewish','Ophite/Sethian'
)
GROUP BY e.tradition
ORDER BY e.tradition;

COMMIT;
