-- ============================================================================
-- DeityDB — Egyptian (Pyramid Texts) SECONDARY pointer sourcing (Allen)  (v2.1.76)
-- scripts/build_allen_pyramid_pointers_v2_1_76.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to James P. Allen, The Ancient
-- Egyptian Pyramid Texts (in-copyright) for Egyptian entities with only
-- `primary-uncited` placeholders. NO TEXT reproduced (quote NULL). Presence
-- VERIFIED 2026-07-05 in context by extraction (pdftotext); Allen renders these
-- descriptively — Hraf-haf as "Face Behind Him" (the ferryman) and Sekhet-Hetepet
-- as the "Marsh of Offerings". Rejected Aten (a substring of "eaten"/"beaten";
-- the Aten cult also postdates the Old Kingdom Pyramid Texts). Most other
-- Egyptian-tagged gaps are Greco-Egyptian magical figures absent from the PT.
-- display_order 2. All needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_ALLEN_PYRAMID_TEXTS','James P. Allen, The Ancient Egyptian Pyramid Texts (Writings from the Ancient World; Society of Biblical Literature, 2005)',NULL,'secondary scholarship','Ancient Egyptian')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_EGY_HRAFHAF_ALLEN','ENT_EGY_ASSESSOR_12','SRC_ALLEN_PYRAMID_TEXTS','The Ancient Egyptian Pyramid Texts',
  'Address to the Ferryman — "Face Behind Him" (Hraf-haf)',NULL,'James P. Allen',2005,NULL,'secondary',
  'Hraf-haf ("His-Face-Is-Behind-Him"), the ferryman of the beyond, rendered by Allen as "Face Behind Him".',
  DATE '2026-07-05','presence verified in context by extraction of Allen, Pyramid Texts (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.76]'),
 ('CIT_EGY_SEKHET_HETEPET_ALLEN','ENT_EGY_SEKHET_HETEPET','SRC_ALLEN_PYRAMID_TEXTS','The Ancient Egyptian Pyramid Texts',
  'The Marsh of Offerings (Sekhet-Hetepet, the Field of Offerings)',NULL,'James P. Allen',2005,NULL,'secondary',
  'Sekhet-Hetepet, the celestial Field/Marsh of Offerings, destination of the transfigured king.',
  DATE '2026-07-05','presence verified in context by extraction of Allen, Pyramid Texts (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.76]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
