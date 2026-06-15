-- scripts/normalize_evidence_type.sql
-- Normalize entity_sources.evidence_type from 25 ad-hoc values to a controlled vocabulary
-- of 5 (v1.50.1), mirroring the earlier source_type normalization. Controlled terms:
--   direct attestation        -- the entity is directly named/described in a primary text
--   inscriptional attestation -- attested in a primary inscription or material artifact
--   scholarly attestation     -- established or discussed via secondary scholarship
--   index attestation         -- listed in a reference index/aggregator (Theoi indices, DDD, ...)
--   probable attestation      -- uncertain / probable identification
--
-- (entity_id, source_id) is already unique across entity_sources, so these UPDATEs cannot
-- collide on the (entity_id, source_id, evidence_type) primary key. Inconsistent evidence_type
-- strings were the root cause of recurring duplicate (entity_id, source_id) pairs (the same
-- citation slipping in twice under e.g. 'primary_attestation' and 'Direct attestation');
-- folding them to a single controlled term makes future ON CONFLICT inserts dedupe correctly.

BEGIN;

-- → direct attestation (all primary-literary / direct variants)
UPDATE entity_sources SET evidence_type='direct attestation'
WHERE evidence_type IN (
  'primary_attestation','Direct attestation','Primary text','Primary literary',
  'Primary literary text','Primary text (contextual)'
);

-- → inscriptional attestation (all the epigraphic / archaeological primary variants,
--   including the "Primary epigraphic ... / secondary scholarly" combinations)
UPDATE entity_sources SET evidence_type='inscriptional attestation'
WHERE evidence_type ILIKE 'Primary epigraphic%'
   OR evidence_type ILIKE 'Primary archaeological%';

-- → scholarly attestation
UPDATE entity_sources SET evidence_type='scholarly attestation'
WHERE evidence_type IN (
  'secondary_reference','Secondary analysis','Secondary scholarly',
  'Secondary scholarly (primary literary texts analysed)'
);

-- → probable attestation
UPDATE entity_sources SET evidence_type='probable attestation'
WHERE evidence_type IN ('Probable attestation');

-- ('index attestation' is already the controlled term — left unchanged.)

-- ── Verify: exactly the 5 controlled values remain; no duplicate pairs; nothing unsourced ─
SELECT evidence_type, count(*) FROM entity_sources GROUP BY 1 ORDER BY 2 DESC;
SELECT count(DISTINCT evidence_type) AS distinct_evidence_types,
       count(*) FILTER (WHERE evidence_type IS NULL OR evidence_type='') AS missing_type
FROM entity_sources;
SELECT count(*) AS dup_source_pairs FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);

COMMIT;
