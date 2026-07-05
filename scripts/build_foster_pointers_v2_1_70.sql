-- ============================================================================
-- DeityDB — Mesopotamian SECONDARY pointer sourcing (Foster)  (v2.1.70)
-- scripts/build_foster_pointers_v2_1_70.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Benjamin R. Foster, Before
-- the Muses: An Anthology of Akkadian Literature (in-copyright) for Mesopotamian
-- entities with only `primary-uncited` placeholders. NO TEXT reproduced (quote
-- NULL) — pointers to the scholarly anthology in which the entity is named.
-- Presence VERIFIED 2026-07-05 in context by extraction (pdftotext); rejected
-- Bashmu (a bibliography-title substring, not the serpent). Added display_order
-- 2 alongside the placeholder. All needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_FOSTER_MUSES','Benjamin R. Foster, Before the Muses: An Anthology of Akkadian Literature (3rd ed., CDL Press, 2005; ISBN 9781883053765)',NULL,'secondary scholarship','Akkadian')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_MES_PAZUZU_FOSTER','ENT_MES_PAZUZU','SRC_FOSTER_MUSES',
  'Before the Muses: An Anthology of Akkadian Literature','The self-predication of Pazuzu ("I am Pazuzu, son of Hanbu"); anti-demonic spell',NULL,
  'Benjamin R. Foster',2005,NULL,'secondary',
  'Pazuzu, son of Hanbu, king of the evil wind-demons, in his self-predication spell.',
  DATE '2026-07-05','presence verified in context by extraction of Foster, Before the Muses (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.70]'),

 ('CIT_MES_RABISU_FOSTER','ENT_MES_RABISU','SRC_FOSTER_MUSES',
  'Before the Muses: An Anthology of Akkadian Literature','Incantation naming Rabisu among the lurking demons',NULL,
  'Benjamin R. Foster',2005,NULL,'secondary',
  'Rabisu (the "croucher"/lurker) named in the demon-list of an Akkadian incantation.',
  DATE '2026-07-05','presence verified in context by extraction of Foster, Before the Muses (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.70]'),

 ('CIT_MES_SARPANIT_FOSTER','ENT_MES_SARPANIT','SRC_FOSTER_MUSES',
  'Before the Muses: An Anthology of Akkadian Literature','Prayer invoking Marduk and Sarpanitum',NULL,
  'Benjamin R. Foster',2005,NULL,'secondary',
  'Sarpanitum (Sarpanit), consort of Marduk, invoked in prayer as "my lady".',
  DATE '2026-07-05','presence verified in context by extraction of Foster, Before the Muses (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.70]'),

 ('CIT_MES_NINISINA_FOSTER','ENT_MES_NINISINA','SRC_FOSTER_MUSES',
  'Before the Muses: An Anthology of Akkadian Literature','Note on Ninisina (Nininsina), the healing goddess',NULL,
  'Benjamin R. Foster',2005,NULL,'secondary',
  'Ninisina (Nininsina) identified as a healing goddess in Foster''s apparatus.',
  DATE '2026-07-05','presence verified in context by extraction of Foster, Before the Muses (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.70]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
