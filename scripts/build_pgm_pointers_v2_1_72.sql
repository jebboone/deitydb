-- ============================================================================
-- DeityDB — Greco-Egyptian magical SECONDARY pointer sourcing (PGM)  (v2.1.72)
-- scripts/build_pgm_pointers_v2_1_72.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Hans Dieter Betz (ed.), The
-- Greek Magical Papyri in Translation (in-copyright) for Greek/Egyptian/Hermetic
-- entities with only `primary-uncited` placeholders. NO TEXT reproduced (quote
-- NULL). Presence VERIFIED 2026-07-05 in context by extraction (pdftotext);
-- rejected voces-magicae false positives (Anael->"ATHANAEL", Mormo->"MORMORON",
-- Alala->"SANTALALA") and OCR noise (Neith vs "neither" — Neith retained via
-- Betz's explicit note on "the Egyptian goddess Neith"). display_order 2. All
-- needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_BETZ_PGM','Hans Dieter Betz (ed.), The Greek Magical Papyri in Translation, Including the Demotic Spells (2nd ed., University of Chicago Press, 1992)',NULL,'secondary scholarship','Greco-Egyptian magic')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_AGATHOS_DAIMON_PGM','ENT_AGATHOS_DAIMON','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'Hymn invoking Agathos Daimon ("for whom heaven has become the processional way")',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Agathos Daimon (the Good Spirit) invoked as a cosmic serpent-god.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_BRIMO_PGM','ENT_BRIMO','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'Hymn to Hecate/Selene, Brimo among her invoked names',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Brimo, chthonic epithet invoked in the Hecate hymns.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_EGY_MONTU_PGM','ENT_EGY_MONTU','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'Har-Monthis / Horus-Montu, the Egyptian god of war',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Montu, Egyptian war-god, in the syncretic Horus-Montu figure.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_EGY_NEITH_PGM','ENT_EGY_NEITH','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'A magical name referring to the Egyptian goddess Neith',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Neith, the Egyptian goddess, underlying a voces-magicae name.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_HER_OGDOAD_PGM','ENT_HER_OGDOAD','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'The outermost celestial sphere conceived as god (the Ogdoad)',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','The Ogdoad, the eighth (outermost) celestial sphere deified.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_KAIROS_PGM','ENT_KAIROS','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'The cosmogony of the "Eighth Book of Moses": Kairos (Time) appears',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Kairos (Time) arising in the laughter-cosmogony of PGM XIII.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_SYN_HARPOCRATES_PGM','ENT_SYN_HARPOCRATES','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'Harpokrates (Harpocrates) holding the flail, symbol of royalty',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Harpocrates (Horus-the-child) in the magical iconography.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_SYN_SERAPIS_PGM','ENT_SYN_SERAPIS','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'Prayer to "master Oserapis and the gods who sit with Oserapis"',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Serapis (Oserapis) invoked as enthroned master of the gods.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]'),
 ('CIT_TYCHE_PGM','ENT_TYCHE','SRC_BETZ_PGM','The Greek Magical Papyri in Translation',
  'Invocation assuring that "the goddess Tyche is with you"',NULL,
  'Hans Dieter Betz (ed.)',1992,NULL,'secondary','Tyche (Fortune) invoked for profit and success.',
  DATE '2026-07-05','presence verified in context by extraction of Betz, Greek Magical Papyri (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.72]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
