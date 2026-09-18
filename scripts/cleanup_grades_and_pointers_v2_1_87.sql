-- cleanup_grades_and_pointers_v2_1_87.sql — grade corrections and false pointers
-- Idempotent: every statement is guarded on current state.

BEGIN;

-- 1. False source attributions: Babalon and Choronzon carried pointers to
--    Liber AL vel Legis, which names neither figure (verified: 0 occurrences of
--    either across the full 48,042-character text). Both entities now carry a
--    genuine verbatim citation to The Vision and the Voice, so these can go.
DELETE FROM entity_citations
WHERE citation_id IN ('CIT_THL_BABALON_SEC','CIT_THL_CHORONZON_SEC')
  AND source_id = 'SRC_CROWLEY_BOOK_OF_LAW'
  AND quote IS NULL;

-- 2. Empty-string quotes written by the v2.1.24 cleanup. '' is not NULL: any
--    `quote IS NOT NULL` filter — including the UI's "has a quote" logic —
--    counts these as quoted when they are not.
UPDATE entity_citations SET quote = NULL WHERE quote = '';

-- 3. Rows graded 'primary-uncited' that actually carry a quote from a secondary
--    reference work. 'primary-uncited' means a pointer to a primary text with no
--    quote; these are neither. Grade them for what they are.
UPDATE entity_citations SET
    evidence_grade = 'secondary',
    verify_method  = COALESCE(verify_method,'') || ' | grade corrected 2026-09-18: quote is from a secondary reference work',
    needs_review   = true
WHERE evidence_grade = 'primary-uncited'
  AND quote IS NOT NULL AND quote <> '';

-- 4. Dictionary of Deities and Demons in the Bible: signed scholarly articles,
--    graded 'reference' (a grade otherwise used for website category indexes).
UPDATE entity_citations SET
    evidence_grade = 'secondary',
    verify_method  = COALESCE(verify_method,'') || ' | grade corrected 2026-09-18: signed scholarly dictionary article',
    needs_review   = true
WHERE citation_id IN ('CIT_LEV_ADRAMMELECH_SEC','CIT_LEV_ANAMMELECH_SEC','CIT_LEV_NIBHAZ_SEC')
  AND evidence_grade = 'reference';

-- 5. Mis-anchored quote: CIT_SAINT_CATHERINE_ALEX_GOLDEN displayed the Life of
--    S. Eugenia under Catherine of Alexandria. Blank the wrong text; the
--    attribution stays for a later re-anchor.
UPDATE entity_citations SET
    quote = NULL,
    evidence_grade = 'primary-uncited',
    verify_method = 'apparatus-cleanup v2 re-point (2026-09-18)',
    needs_review = true
WHERE citation_id = 'CIT_SAINT_CATHERINE_ALEX_GOLDEN' AND quote IS NOT NULL;

COMMIT;
