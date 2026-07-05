-- ============================================================================
-- DeityDB — Hermetic SECONDARY pointer sourcing (Copenhaver)  (v2.1.75)
-- scripts/build_copenhaver_pointers_v2_1_75.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Brian P. Copenhaver,
-- Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius (in-copyright)
-- for Hermetic entities with only `primary-uncited` placeholders. NO TEXT
-- reproduced (quote NULL). Presence VERIFIED 2026-07-05 in context by extraction
-- (pdftotext). Held Ennead (only an intro title-reference to the "Eighth and
-- Ninth", a tractate not included in Copenhaver) and Henads (commentary-only).
-- display_order 2. All needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_COPENHAVER_HERMETICA','Brian P. Copenhaver, Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius in a New English Translation (Cambridge University Press, 1992)',NULL,'secondary scholarship','Hermetic')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_HER_COSMOS_COPENHAVER','ENT_HER_COSMOS','SRC_COPENHAVER_HERMETICA','Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius',
  'On the cosmos as a second god (the cosmos contrasted with god)',NULL,'Brian P. Copenhaver',1992,NULL,'secondary',
  'The Cosmos as a Hermetic hypostasis / "second god" in the Corpus Hermeticum.',
  DATE '2026-07-05','presence verified in context by extraction of Copenhaver, Hermetica (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.75]'),
 ('CIT_HER_DEMIURGE_COPENHAVER','ENT_HER_DEMIURGE','SRC_COPENHAVER_HERMETICA','Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius',
  'On the Demiurge (Craftsman) who fashions the physical world',NULL,'Brian P. Copenhaver',1992,NULL,'secondary',
  'The Demiurge / Craftsman-Mind of the Hermetic cosmogony.',
  DATE '2026-07-05','presence verified in context by extraction of Copenhaver, Hermetica (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.75]'),
 ('CIT_HER_TRISMEGISTUS_COPENHAVER','ENT_HER_TRISMEGISTUS','SRC_COPENHAVER_HERMETICA','Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius',
  'Hermes Trismegistus, revealer of the Hermetic discourses',NULL,'Brian P. Copenhaver',1992,NULL,'secondary',
  'Hermes Trismegistus (the Thrice-Great), teacher of the Hermetica.',
  DATE '2026-07-05','presence verified in context by extraction of Copenhaver, Hermetica (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.75]'),
 ('CIT_HER_THE_ONE_COPENHAVER','ENT_HER_THE_ONE','SRC_COPENHAVER_HERMETICA','Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius',
  'On the Monad (CH IV, "the bowl or the monad")',NULL,'Brian P. Copenhaver',1992,NULL,'secondary',
  'The One / Monad as the source and beginning of all number and being.',
  DATE '2026-07-05','presence verified in context by extraction of Copenhaver, Hermetica (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.75]'),
 ('CIT_LAT_AGATHOS_DAIMON_HERMETIC_COPENHAVER','ENT_LAT_AGATHOS_DAIMON_HERMETIC','SRC_COPENHAVER_HERMETICA','Hermetica: The Greek Corpus Hermeticum and the Latin Asclepius',
  'Agathodaimon, "the second Hermes, father of Tat"',NULL,'Brian P. Copenhaver',1992,NULL,'secondary',
  'Agathodaimon (the Good Daimon), Hermetic teacher named as the second Hermes.',
  DATE '2026-07-05','presence verified in context by extraction of Copenhaver, Hermetica (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.75]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
