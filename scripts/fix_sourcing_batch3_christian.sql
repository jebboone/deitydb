-- Sourcing batch 3: Christian traditions
-- Covers Christian, Christian/Biblical, Christian reception
-- 43 entities; source mapping by category

BEGIN;

-- SRC_DDD_CHRISTIAN as base secondary_reference for all
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_DDD_CHRISTIAN', 'secondary_reference',
       'Attested in Dictionary of Deities and Demons in the Bible, Christian entries.'
FROM entities e
WHERE e.tradition IN ('Christian','Christian/Biblical','Christian reception')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_DDD_CHRISTIAN'
  )
ON CONFLICT DO NOTHING;

-- Pseudo-Dionysius for the angelic orders (primary_attestation)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_PSEUDO_DIONYSIUS_CELESTIAL_HIERARCHY', 'primary_attestation',
       'Named in Pseudo-Dionysius, Celestial Hierarchy.'
FROM entities e
WHERE e.entity_id IN (
    'ENT_CHR_SERAPHIM','ENT_CHR_CHERUBIM','ENT_CHR_THRONES',
    'ENT_CHR_DOMINIONS','ENT_CHR_VIRTUES','ENT_CHR_POWERS',
    'ENT_CHR_PRINCIPALITIES','ENT_CHR_ARCHANGELS','ENT_CHR_ANGELS',
    'ENT_CHR_GUARDIAN_ANGELS',
    'ENT_SAINT_MICHAEL_CHR','ENT_SAINT_GABRIEL_CHR','ENT_SAINT_RAPHAEL_CHR'
)
ON CONFLICT DO NOTHING;

-- Butler's Lives of the Saints for hagiographic saints
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_BUTLER_SAINTS', 'secondary_reference',
       'Attested in Butler''s Lives of the Saints.'
FROM entities e
WHERE e.category IN ('Saint','Holy Figure')
  AND e.tradition IN ('Christian','Christian/Biblical','Christian reception')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_BUTLER_SAINTS'
  )
ON CONFLICT DO NOTHING;

-- Catholic Encyclopedia for saints, ritual categories, and angelic collectives
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_CATHOLIC_ENCYCLOPEDIA_SAINTS', 'secondary_reference',
       'Attested in Catholic Encyclopedia.'
FROM entities e
WHERE e.tradition IN ('Christian','Christian/Biblical','Christian reception')
  AND e.category IN (
      'Saint','Holy Figure','Angelic Being','Angelic Collective',
      'Ritual Category','Ritual Collective','Craft Deity'
  )
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_CATHOLIC_ENCYCLOPEDIA_SAINTS'
  )
ON CONFLICT DO NOTHING;

-- Christian demonology for adversarial and fallen angel figures
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e.entity_id, 'SRC_CHRISTIAN_DEMONOLOGY_GENERAL', 'secondary_reference',
       'Attested in Christian demonology reference layer.'
FROM entities e
WHERE e.tradition IN ('Christian','Christian/Biblical','Christian reception')
  AND e.category IN ('Adversarial Being','Demonic Collective','Fallen Angel','Monster')
  AND NOT EXISTS (
      SELECT 1 FROM entity_sources es
      WHERE es.entity_id = e.entity_id AND es.source_id = 'SRC_CHRISTIAN_DEMONOLOGY_GENERAL'
  )
ON CONFLICT DO NOTHING;

-- Verify
SELECT e.tradition,
       COUNT(*) AS total,
       COUNT(*) FILTER (WHERE NOT EXISTS (
           SELECT 1 FROM entity_sources es WHERE es.entity_id = e.entity_id
       )) AS still_unsourced
FROM entities e
WHERE e.tradition IN ('Christian','Christian/Biblical','Christian reception')
GROUP BY e.tradition ORDER BY e.tradition;

COMMIT;
