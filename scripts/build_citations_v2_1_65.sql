-- ============================================================================
-- DeityDB — sourcing batch v2.1.65
--   Hermetic (Anthropos, Logos) + Jewish Mystical (Shekhinah): PD verbatim.
--   Mesopotamian (Anu, Belet-ili): secondary pointers to Dalley (no text).
-- Quotes verified 2026-07-05 by verbatim extraction from PD texts. Idempotent.
-- ============================================================================
BEGIN;

UPDATE entity_citations SET
  work_title='The Corpus Hermeticum, I (Poemandres, the Shepherd of Men)', locus='CH I.12',
  quote='the Father of all things, the Mind being Life and Light, brought forth Man, like unto himself',
  translator='G.R.S. Mead', translation_year=1906, source_url='https://archive.org/details/pdfy-jcWLRBnyXg-DUcMH',
  evidence_grade='primary-verbatim', evidence_note='The primal Anthropos (Man) begotten by the Father-Mind.',
  verified_on=DATE '2026-07-05', verify_method='verbatim from G.R.S. Mead trans., The Corpus Hermeticum (1906), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.65]'
 WHERE citation_id='CIT_HER_ANTHROPOS_SEC';

UPDATE entity_citations SET
  work_title='The Corpus Hermeticum, I (Poemandres, the Shepherd of Men)', locus='CH I.5',
  quote='out of the Light a Holy Word (Logos) descended on that Nature',
  translator='G.R.S. Mead', translation_year=1906, source_url='https://archive.org/details/pdfy-jcWLRBnyXg-DUcMH',
  evidence_grade='primary-verbatim', evidence_note='The Holy Logos descends upon Nature.',
  verified_on=DATE '2026-07-05', verify_method='verbatim from G.R.S. Mead trans., The Corpus Hermeticum (1906), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.65]'
 WHERE citation_id='CIT_HER_LOGOS_SEC';

UPDATE entity_citations SET
  work_title='The Zohar', locus='Zohar, Genesis (Noah), fol. 66b',
  quote='the divine spirit or Shekinah is ever with him and abides in him',
  translator='Harry Sperling & Maurice Simon', translation_year=1934,
  source_url='https://sacred-texts.com/jud/zdm/index.htm',
  evidence_grade='primary-verbatim', evidence_note='The Shekhinah abides with the righteous (Rabbi Simeon).',
  verified_on=DATE '2026-07-05', verify_method='verbatim from Sperling & Simon trans., The Zohar (Soncino, 1934); public domain (sacred-texts)',
  needs_review=true, review_reason='sourced from PD primary [v2.1.65]'
 WHERE citation_id='CIT_JM_SHEKHINAH_SEC';

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_'||e.entity_id||'_DALLEY', e.entity_id, 'SRC_DALLEY_MYTHS',
  'Myths from Mesopotamia', 'Epic of Creation (Enuma Elish)', NULL,
  'Stephanie Dalley', 2000, NULL, 'secondary',
  'Named in the Epic of Creation / Akkadian myth corpus.', DATE '2026-07-05',
  'entity presence confirmed in Dalley trans. (in-copyright) — bibliographic pointer, no text reproduced',
  2, true, 'secondary pointer [v2.1.65]'
FROM entities e
WHERE e.tradition LIKE '%Mesopotamian%' AND e.canonical_name IN ('Anu','Belet-ili')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
