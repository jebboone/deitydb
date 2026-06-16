-- audit_fixes_v1.sql — completeness fixes from the v1.63 dataset audit (v1.63.1)
-- (1) fill 85 missing evidence_confidence by a transparent, source-tied rule;
-- (2) retype the 15 'associated_with' code-smell edges to precise typed relations.
BEGIN;

-- (1) evidence_confidence: Cross-traditional abstraction → 'A' (matches the layer's
--     other 117); any primary source → 'B'; reference/secondary-only → 'C'.
UPDATE entities e SET evidence_confidence = (
  CASE WHEN e.tradition='Cross-traditional' THEN 'A'
       WHEN EXISTS (SELECT 1 FROM entity_sources es JOIN sources s ON s.source_id=es.source_id
                    WHERE es.entity_id=e.entity_id AND s.source_type LIKE 'primary%') THEN 'B'
       ELSE 'C' END)
WHERE e.evidence_confidence IS NULL OR e.evidence_confidence='';

-- (2) retype associated_with → typed relations (by relationship_id, mark reviewed)
-- bull / manifestation cults → cult_form_of
UPDATE entity_relationships SET relationship_type='cult_form_of', review_status='reviewed' WHERE relationship_id=3304; -- Apis → Ptah (ba/herald)
UPDATE entity_relationships SET relationship_type='cult_form_of', review_status='reviewed' WHERE relationship_id=3307; -- Buchis → Montu (ka)
UPDATE entity_relationships SET relationship_type='cult_form_of', review_status='reviewed' WHERE relationship_id=3306; -- Mnevis → Ra (ba of Ra-Atum)
-- minor functional deities within a greater god's sphere → presided_over_by
UPDATE entity_relationships SET relationship_type='presided_over_by', review_status='reviewed' WHERE relationship_id=3375; -- Cardea (hinges) → Janus
UPDATE entity_relationships SET relationship_type='presided_over_by', review_status='reviewed' WHERE relationship_id=3373; -- Forculus (doors) → Janus
UPDATE entity_relationships SET relationship_type='presided_over_by', review_status='reviewed' WHERE relationship_id=3374; -- Limentinus (thresholds) → Janus
UPDATE entity_relationships SET relationship_type='presided_over_by', review_status='reviewed' WHERE relationship_id=3380; -- Robigus (crop-rust) → Ceres
UPDATE entity_relationships SET relationship_type='presided_over_by', review_status='reviewed' WHERE relationship_id=3379; -- Seia (grain) → Ceres
-- counterparts / shared-cult / cosmic associates → paired_with
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3378; -- Summanus (night thunder) ↔ Jupiter
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3464; -- Nemausus ↔ Matres Nemausicae (Nîmes spring)
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3296; -- Amenhotep son of Hapu ↔ Imhotep (shared healing-oracle cult)
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3282; -- Ankh-neteru ↔ Khepri (solar rebirth)
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3274; -- Nebet-wia (barque) ↔ Ra
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3302; -- Wenut ↔ Thoth (Hermopolitan nome)
UPDATE entity_relationships SET relationship_type='paired_with', review_status='reviewed' WHERE relationship_id=3483; -- Vanth ↔ Aita (Etruscan underworld)

COMMIT;
