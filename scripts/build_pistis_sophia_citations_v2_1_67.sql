-- ============================================================================
-- DeityDB — Pistis Sophia (Gnostic) citation sourcing, batch  (v2.1.67)
-- scripts/build_pistis_sophia_citations_v2_1_67.sql
-- ----------------------------------------------------------------------------
-- Replaces `primary-uncited` placeholders with located VERBATIM excerpts from
-- the public-domain Pistis Sophia, trans. G.R.S. Mead (1896). Quotes verified
-- 2026-07-05 by verbatim extraction from the PD text (Apache Tika); NOTHING
-- quoted from memory. Chapter numbers are not reliably recoverable from the
-- extracted text, so loci are descriptive (no fabricated chapter numbers).
-- Everything lands needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on Authades (the Self-willed) and his powers',
  quote='the great triple-powered Authades',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='Authades (the Self-willed / arrogant one) named as the triple-powered adversary.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_AUTHADES_SEC';

UPDATE entity_citations SET
  source_id='SRC_PISTIS_SOPHIA',
  work_title='Pistis Sophia', locus='on Jeu, the Overseer of the Light',
  quote='Jeu, the Overseer of the Light',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='Jeu named as the Overseer of the Light (quote located in Pistis Sophia, not the Books of Jeu).',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_JEU_SEC';

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on Pistis Sophia in the thirteenth aeon',
  quote='the Pistis Sophia was in the thirteenth aeon in the place',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='Pistis Sophia, the fallen and repentant Aeon, dwelling in the thirteenth aeon.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_PISTIS_SOPHIA_SEC';

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on the lion-faced power of Authades',
  quote='a great lion-faced power',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The lion-faced power emanated by Authades that deceives Pistis Sophia.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_LION_FACED_SEC';

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on Zorokothora Melchisedek, the Receiver of the Light',
  quote='Zorokothora Melchisedek takes what is purified of the lights',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='Melchizedek (Zorokothora), the great Receiver who gathers the purified light.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_MELCHIZEDEK_SEC';

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on Adamas the Tyrant and Authades',
  quote='the Pistis Sophia by the Authades and Adamas, the Tyrant',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='Adamas the Tyrant, ruler of the twelve aeons, oppressing Pistis Sophia alongside Authades.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_ADAMAS_TYRANT_SEC';

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on the command of the First Mystery',
  quote='until the command came forth from the First Mystery',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The First Mystery as supreme source from which command proceeds.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_FIRST_MYSTERY_SEC';

UPDATE entity_citations SET
  work_title='Pistis Sophia', locus='on those in the thirteenth aeon',
  quote='all those who are in the thirteenth aeon',
  translator='G.R.S. Mead', translation_year=1896,
  source_url='https://sacred-texts.com/chr/ps/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The thirteenth aeon, dwelling of the twenty-four invisibles and of Pistis Sophia.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from G.R.S. Mead trans., Pistis Sophia (1896), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.67]'
 WHERE citation_id='CIT_PS_THIRTEENTH_AEON_SEC';

COMMIT;
