-- reclassify_associated_with.sql
-- Reclassify the small subset of vague `associated_with` edges where the
-- rationale unambiguously gives both a precise relationship_type AND the correct
-- direction (verified by object entity_class + symmetric-type guards). The other
-- ~90 flagged edges need a per-edge domain call — see docs/associated_with_triage.md.
-- The 14 associated_ritual->ritual edges are correctly typed and left as-is.

BEGIN;
UPDATE entity_relationships SET relationship_type='member_of'  WHERE relationship_id=7385;  -- Kadmilos -> Cabeiri (their member)
UPDATE entity_relationships SET relationship_type='paired_with' WHERE relationship_id=7376;  -- Eumolpus <-> Triptolemus (paired Eleusinian founders)
UPDATE entity_relationships SET relationship_type='taught_by'  WHERE relationship_id=6974;  -- Quddús (disciple) -> the Báb
UPDATE entity_relationships SET relationship_type='taught_by'  WHERE relationship_id=6975;  -- Táhirih (disciple) -> the Báb
COMMIT;
