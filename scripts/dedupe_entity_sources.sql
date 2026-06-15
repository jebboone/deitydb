-- scripts/dedupe_entity_sources.sql
-- Remove duplicate (entity_id, source_id) attestations from entity_sources (v1.38.1).
--
-- The entity_sources primary key is (entity_id, source_id, evidence_type), so the same
-- source attached to the same entity under two different evidence_type strings did not
-- collide. The Greek rigor passes (v1.36-1.38) bulk-added sources by entity_type with
-- evidence_type='Direct attestation'; where an entity already carried that source under
-- a different evidence_type, a redundant row resulted. Two further duplicates were
-- pre-existing in the original data (inconsistent evidence_type spellings).
--
-- Fix: keep the pre-existing (usually more specific) citation, drop the redundant copy.
-- Idempotent — a no-op once clean. NOTE: the evidence_type vocabulary itself is still
-- inconsistent across the dataset (snake_case 'primary_attestation' vs 'Primary text' vs
-- 'Direct attestation'); a normalisation pass (as was done for source_type) is a TODO.

BEGIN;

-- 1. Redundant rows added by the rigor passes: 'Direct attestation' where the same
--    (entity_id, source_id) already had another citation.
DELETE FROM entity_sources es
WHERE es.evidence_type='Direct attestation'
  AND EXISTS (SELECT 1 FROM entity_sources es2
              WHERE es2.entity_id=es.entity_id AND es2.source_id=es.source_id
                AND es2.evidence_type<>'Direct attestation');

-- 2. Pre-existing original-data duplicates (keep the more specific note).
DELETE FROM entity_sources WHERE entity_id='ENT_ATTIS' AND source_id='SRC_ROLLER_CYBELE' AND evidence_type='Secondary scholarly';
DELETE FROM entity_sources WHERE entity_id='ENT_ISR_SHEMIHAZAH' AND source_id='SRC_1_ENOCH' AND evidence_type='primary_attestation';

-- Verify: no (entity_id, source_id) appears more than once.
SELECT count(*) AS remaining_dup_pairs
FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;

COMMIT;
