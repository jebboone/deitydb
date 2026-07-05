-- ============================================================================
-- DeityDB — Coptic Christian ritual-power SECONDARY pointer sourcing  (v2.1.69)
-- scripts/build_acm_pointers_v2_1_69.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Marvin Meyer & Richard
-- Smith (eds.), Ancient Christian Magic: Coptic Texts of Ritual Power
-- (in-copyright, 1994) for Gnostic/Sethian/Jewish-angelic entities that
-- previously had only `primary-uncited` placeholders. NO TEXT is reproduced
-- (quote NULL) — pointers to the scholarly edition in which the entity is
-- named/invoked. Presence of each entity was VERIFIED 2026-07-05 in context by
-- text extraction of the edition (pdftotext); substring false positives were
-- rejected by hand (Haniel→"Bakthaniel", Charis→"eucharist", Hormos→"Hormosiel",
-- Adamas→editor's emendation note only). Added as display_order 2 alongside the
-- existing placeholder. All land needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_ACM_MEYER_SMITH','Marvin Meyer & Richard Smith (eds.), Ancient Christian Magic: Coptic Texts of Ritual Power (HarperSanFrancisco, 1994; ISBN 9780060655785)',NULL,'secondary scholarship','Coptic Christian / Gnostic')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_SET_ELELETH_ACM','ENT_SET_ELELETH','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Text 42 (Prayers, hymns, and invocations); the luminaries Oroiael, Daveithe, and Eleleth',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Eleleth, the fourth of the Sethian luminaries, named among Oroiael and Daveithe in the invocations.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_SET_SETH_ACM','ENT_SET_SETH','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Introduction to the Sethian ritual texts (Seth, third son of Adam, ancestor of the Gnostic race)',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Seth, the Gnostic forefather from whom the Sethians traced their spiritual descent.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_GNO_SABAOTH_ACM','ENT_GNO_SABAOTH','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Invoked as a divine power (with Iao and Adonai) throughout the ritual-power texts',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Sabaoth invoked as a power of God across the Coptic ritual texts.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_JM_CHERUBIM_ACM','ENT_JM_CHERUBIM','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Liturgical invocation (the Sanctus: "Holy is god, whom the cherubim...")',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'The cherubim named in the sanctifying acclamation of the Coptic ritual liturgy.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_JEU_PROTETH_ACM','ENT_JEU_PROTETH','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Text 39 (Spell for ascending through the heavens); archon of the first aeon',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Proteth, named among the archons of the first aeon in the ascent spell.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_JEU_PERSOMPHON_ACM','ENT_JEU_PERSOMPHON','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Text 39 (Spell for ascending through the heavens); archon of the first aeon',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Persomphon, named among the archons of the first aeon in the ascent spell.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_JEU_CHOUS_ACM','ENT_JEU_CHOUS','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Text 39 (Spell for ascending through the heavens); archon of the first aeon',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Chous, named among the archons of the first aeon in the ascent spell.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_JEU_CHOUNCHEOCH_ACM','ENT_JEU_CHOUNCHEOCH','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Text 39 (Spell for ascending through the heavens); archon of the second aeon',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Chouncheoch, named as archon of the second aeon in the ascent spell.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]'),

 ('CIT_JEU_CHOUCHO_ACM','ENT_JEU_CHOUCHO','SRC_ACM_MEYER_SMITH',
  'Ancient Christian Magic: Coptic Texts of Ritual Power','Text 39 (Spell for ascending through the heavens); archon named with Yaldabaoth',NULL,
  'Marvin Meyer & Richard Smith',1994,NULL,'secondary',
  'Choucho, named among the aeon-archons (with Yaldabaoth) in the ascent spell.',
  DATE '2026-07-05','presence verified in context by extraction of Meyer & Smith, Ancient Christian Magic (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.69]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
