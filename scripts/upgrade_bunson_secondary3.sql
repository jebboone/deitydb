BEGIN;
UPDATE entity_citations SET quote='Greek god who was in time accepted by the Romans.', work_title='Matthew Bunson, Encyclopedia of Ancient Rome (Facts on File, 1994), s.v. Apollo', verify_method='secondary-scholarship excerpt; substring-gated against Bunson Encyclopedia of Ancient Rome OCR', needs_review=true, review_reason='Reference encyclopedia (general reference publisher, not academic press) — brief attributed excerpt; verify against the print edition.', verified_on=DATE '2026-06-26' WHERE citation_id='CIT_ROM_APOLLO_SEC';
COMMIT;
