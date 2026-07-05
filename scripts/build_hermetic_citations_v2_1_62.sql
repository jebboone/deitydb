-- ============================================================================
-- DeityDB — Hermetic citation sourcing, batch 1  (v2.1.62)
-- scripts/build_hermetic_citations_v2_1_62.sql
-- ----------------------------------------------------------------------------
-- Replaces `primary-uncited` placeholders (locus 'per cited source', no quote)
-- with located VERBATIM excerpts from the public-domain Corpus Hermeticum,
-- trans. G.R.S. Mead (1906). Quotes verified 2026-07-05 by verbatim extraction
-- from the Mead text (Apache Tika from the PD PDF); NOTHING quoted from memory.
-- Loci follow standard Corpus Hermeticum treatise/section numbering (CH I =
-- Poimandres/"Poemandres, the Shepherd of Men"). Everything lands
-- needs_review=true for human confirmation. Idempotent.
-- ============================================================================

BEGIN;

UPDATE entity_citations SET
  work_title = 'The Corpus Hermeticum, I (Poemandres, the Shepherd of Men)',
  locus = 'CH I.2',
  quote = 'I am Man-Shepherd (Poemandres), Mind of all-masterhood; I know what thou desirest and I''m with thee everywhere.',
  translator = 'G.R.S. Mead', translation_year = 1906,
  source_url = 'https://archive.org/details/pdfy-jcWLRBnyXg-DUcMH',
  evidence_grade = 'primary-verbatim',
  evidence_note = 'The revealer Poimandres names himself as the divine Nous.',
  verified_on = DATE '2026-07-05',
  verify_method = 'verbatim from G.R.S. Mead trans., The Corpus Hermeticum (1906), public domain',
  needs_review = true, review_reason = 'sourced from PD primary [v2.1.62]'
 WHERE citation_id = 'CIT_HER_POIMANDRES_SEC';

UPDATE entity_citations SET
  work_title = 'The Corpus Hermeticum, I (Poemandres, the Shepherd of Men)',
  locus = 'CH I.6',
  quote = 'That Light, He said, am I, thy God, Mind, prior to Moist Nature which appeared from Darkness',
  translator = 'G.R.S. Mead', translation_year = 1906,
  source_url = 'https://archive.org/details/pdfy-jcWLRBnyXg-DUcMH',
  evidence_grade = 'primary-verbatim',
  evidence_note = 'Nous (Mind) identified as God, the primal Light.',
  verified_on = DATE '2026-07-05',
  verify_method = 'verbatim from G.R.S. Mead trans., The Corpus Hermeticum (1906), public domain',
  needs_review = true, review_reason = 'sourced from PD primary [v2.1.62]'
 WHERE citation_id = 'CIT_HER_NOUS_SEC';

UPDATE entity_citations SET
  work_title = 'The Corpus Hermeticum, I (Poemandres, the Shepherd of Men)',
  locus = 'CH I.9',
  quote = 'formed Seven Rulers who enclose the cosmos that the sense perceives',
  translator = 'G.R.S. Mead', translation_year = 1906,
  source_url = 'https://archive.org/details/pdfy-jcWLRBnyXg-DUcMH',
  evidence_grade = 'primary-verbatim',
  evidence_note = 'The Demiurge-Mind fashions the Seven Rulers/Governors (the planetary administrators).',
  verified_on = DATE '2026-07-05',
  verify_method = 'verbatim from G.R.S. Mead trans., The Corpus Hermeticum (1906), public domain',
  needs_review = true, review_reason = 'sourced from PD primary [v2.1.62]'
 WHERE citation_id = 'CIT_HER_SEVEN_GOVERNORS_SEC';

UPDATE entity_citations SET
  work_title = 'The Corpus Hermeticum, I (Poemandres, the Shepherd of Men)',
  locus = 'CH I.9',
  quote = 'Men call their ruling Fate.',
  translator = 'G.R.S. Mead', translation_year = 1906,
  source_url = 'https://archive.org/details/pdfy-jcWLRBnyXg-DUcMH',
  evidence_grade = 'primary-verbatim',
  evidence_note = 'The government of the Seven Rulers is named Fate (Heimarmene).',
  verified_on = DATE '2026-07-05',
  verify_method = 'verbatim from G.R.S. Mead trans., The Corpus Hermeticum (1906), public domain',
  needs_review = true, review_reason = 'sourced from PD primary [v2.1.62]'
 WHERE citation_id = 'CIT_HER_HEIMARMENE_SEC';

COMMIT;
