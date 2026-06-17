-- build_abrahamic_dupreview.sql — homonym duplicate-review rows for the v1.70.0 Abrahamic build.
-- Biblical Seth collides with Egyptian Set (ENT_EGY_SETH) and Sethian Seth (ENT_SET_SETH, both
-- already reviewed); the NT apostle Thomas collides with the Thomasine/Gnostic Thomas. All are
-- intentionally distinct tradition-specific figures. Idempotent.
BEGIN;
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Seth','ENT_ISR_SETH','Biblical patriarch Seth (third son of Adam), distinct from the Egyptian god Set and the Sethian-Gnostic Seth.','intentional_distinct'),
 ('Thomas','ENT_NT_THOMAS','The New Testament apostle Thomas (Didymus), distinct from the Thomasine/Gnostic revealer figure.','intentional_distinct'),
 ('Thomas','ENT_THO_THOMAS','The Thomasine/Gnostic Thomas (revealer of the Gospel of Thomas), distinct from the NT apostle.','intentional_distinct')
ON CONFLICT (entity_id, canonical_name) DO NOTHING;

\echo '--- unreviewed_duplicates (must be 0) ---'
SELECT count(*) FROM v_unreviewed_duplicate_entities;
COMMIT;
