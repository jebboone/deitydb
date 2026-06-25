-- scripts/add_isis_lactans_citation.sql
-- Attach the missing source citation to the Isis Lactans entity.
--
-- Isis Lactans (ENT_ISIS_LACTANS) was added in v2.1.12 as a reception-chain
-- intermediate (Isis -> Mary Theotokos). Its relationship edges were sourced,
-- but the entity itself had zero rows in entity_citations -- the only fully
-- uncited entity in the database (surfaced by the v2.1.13 live-site audit).
--
-- Isis Lactans is an iconographic TYPE (Isis suckling Harpocrates), catalogued
-- in Tran Tam Tinh's definitive corpus of Greco-Roman monuments. There is no
-- single quotable primary text, so this is a secondary-scholarship pointer
-- (no verbatim quote, flagged) -- mirroring the established pointer pattern and
-- honest under the project's citation policy. SRC_TRAN_ISIS_LACTANS already
-- exists (added by add_reception_bridges.sql).

BEGIN;

INSERT INTO entity_citations
  (citation_id, entity_id, source_id, work_title, locus, quote,
   evidence_grade, evidence_note, verify_method, display_order,
   needs_review, review_reason)
SELECT
  'CIT_ISIS_LACTANS_SEC', 'ENT_ISIS_LACTANS', 'SRC_TRAN_ISIS_LACTANS',
  'Isis lactans: Corpus des monuments greco-romains d''Isis allaitant Harpocrate',
  'per cited source', '',
  'secondary', '',
  'Track-2 formalization of the entity''s existing source attestation (no verbatim quote -- pointer + grade + flag)',
  1, TRUE,
  'Iconographic type catalogued in a scholarly corpus of monuments (no quotable running primary text); cited at the corpus.'
WHERE NOT EXISTS (
  SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ISIS_LACTANS_SEC'
);

COMMIT;
