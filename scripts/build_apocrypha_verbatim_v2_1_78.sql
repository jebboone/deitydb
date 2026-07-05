-- ============================================================================
-- DeityDB — Second-Temple (Apocrypha) VERBATIM sourcing  (v2.1.78)
-- scripts/build_apocrypha_verbatim_v2_1_78.sql
-- ----------------------------------------------------------------------------
-- Upgrades `primary-uncited` placeholders to primary-verbatim for six
-- deuterocanonical narrative figures, with located excerpts from the
-- PUBLIC-DOMAIN King James Version Apocrypha (Authorized Version, 1611). Quotes
-- verified 2026-07-05 by whitespace-normalized substring gate against the
-- extracted PD text (via Wikisource raw wikitext, markup stripped); nothing from
-- memory. Existing rows pointed at the in-copyright NRSV Apocrypha (unquotable);
-- source_id repointed to the new PD KJV source. All needs_review=true.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_KJV_APOCRYPHA','The Holy Bible, King James Version (Authorized Version, 1611) — Apocrypha (Tobit, Judith, 1-2 Maccabees)','https://en.wikisource.org/wiki/Bible_(King_James)','primary scripture','Second Temple Jewish')
ON CONFLICT (source_id) DO NOTHING;

UPDATE entity_citations SET
  source_id='SRC_KJV_APOCRYPHA', work_title='1 Maccabees (KJV Apocrypha)', locus='1 Maccabees 1:10',
  quote='there came out of them a wicked root, Antiochus surnamed Epiphanes',
  translator='King James translators (Authorized Version)', translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/1_Maccabees',
  evidence_grade='primary-verbatim',
  evidence_note='Antiochus IV Epiphanes, the "wicked root" persecutor of the Maccabean revolt.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from KJV Apocrypha (1611), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.78]'
 WHERE citation_id='CIT_STJ_ANTIOCHUS_IV_SEC';

UPDATE entity_citations SET
  source_id='SRC_KJV_APOCRYPHA', work_title='Tobit (KJV Apocrypha)', locus='Tobit 1:1',
  quote='The book of the words of Tobit, son of Tobiel, the son of Ananiel',
  translator='King James translators (Authorized Version)', translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/Tobit',
  evidence_grade='primary-verbatim',
  evidence_note='Tobit of the tribe of Naphtali, the pious exile whose book bears his name.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from KJV Apocrypha (1611), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.78]'
 WHERE citation_id='CIT_TOBIT_SEC';

UPDATE entity_citations SET
  source_id='SRC_KJV_APOCRYPHA', work_title='Tobit (KJV Apocrypha)', locus='Tobit 1:9',
  quote='of her I begat Tobias',
  translator='King James translators (Authorized Version)', translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/Tobit',
  evidence_grade='primary-verbatim',
  evidence_note='Tobias, son of Tobit, who journeys with the angel Raphael.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from KJV Apocrypha (1611), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.78]'
 WHERE citation_id='CIT_STJ_TOBIAS_SEC';

UPDATE entity_citations SET
  source_id='SRC_KJV_APOCRYPHA', work_title='Judith (KJV Apocrypha)', locus='Judith 2:4',
  quote='Nabuchodonosor king of the Assyrians called Holofernes the chief captain of his army',
  translator='King James translators (Authorized Version)', translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/Judith',
  evidence_grade='primary-verbatim',
  evidence_note='Holofernes, the Assyrian general beheaded by Judith.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from KJV Apocrypha (1611), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.78]'
 WHERE citation_id='CIT_STJ_HOLOFERNES_SEC';

UPDATE entity_citations SET
  source_id='SRC_KJV_APOCRYPHA', work_title='1 Maccabees (KJV Apocrypha)', locus='1 Maccabees 2:3-5',
  quote='Simon, called Thassi: Judas, who was called Maccabeus: Eleazar, called Avaran: and Jonathan, whose surname was Apphus',
  translator='King James translators (Authorized Version)', translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/1_Maccabees',
  evidence_grade='primary-verbatim',
  evidence_note='The Maccabee brothers, the sons of Mattathias who led the revolt.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from KJV Apocrypha (1611), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.78]'
 WHERE citation_id='CIT_STJ_MACCABEE_BROTHERS_SEC';

UPDATE entity_citations SET
  source_id='SRC_KJV_APOCRYPHA', work_title='2 Maccabees (KJV Apocrypha)', locus='2 Maccabees 7:20',
  quote='But the mother was marvellous above all, and worthy of honourable memory',
  translator='King James translators (Authorized Version)', translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/2_Maccabees',
  evidence_grade='primary-verbatim',
  evidence_note='The mother of the seven Maccabean martyrs (later named Hannah / Solomonia).',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from KJV Apocrypha (1611), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.78]'
 WHERE citation_id='CIT_STJ_MACCABEAN_MOTHER_SEC';

COMMIT;
