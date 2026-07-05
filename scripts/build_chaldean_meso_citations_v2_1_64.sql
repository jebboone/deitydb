-- ============================================================================
-- DeityDB — Chaldean (verbatim) + Mesopotamian (secondary pointer) sourcing (v2.1.64)
-- scripts/build_chaldean_meso_citations_v2_1_64.sql
-- ----------------------------------------------------------------------------
-- (A) Hermetic/Theurgic: verbatim from the public-domain Chaldean Oracles,
--     trans. W. Wynn Westcott (1895). Quotes verified 2026-07-05 by verbatim
--     extraction from the PD text; nothing from memory.
-- (B) Mesopotamian primordials: SECONDARY pointer citations to Dalley, Myths
--     from Mesopotamia (in-copyright) — bibliographic pointers only, NO text
--     reproduced (quote NULL). Entity presence confirmed in the translation.
-- All land needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

-- (A) Chaldean Oracles verbatim ---------------------------------------------
UPDATE entity_citations SET
  work_title='The Chaldean Oracles', locus='frag. 55 (Westcott numbering)',
  quote='it filleth the Life-producing bosom of Hecate',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='Hecate as the life-producing source in the fiery cosmology.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.64]'
 WHERE citation_id='CIT_HER_HECATE_CHALDEAN_SEC';

UPDATE entity_citations SET
  work_title='The Chaldean Oracles', locus='frag. 55 (Westcott numbering)',
  quote='instilleth into the Synoches the enlivening strength of Fire, endued with mighty Power',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The Synoches (Connectors) receive the enlivening fire.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.64]'
 WHERE citation_id='CIT_HER_SYNOCHEIS_SEC';

UPDATE entity_citations SET
  work_title='The Chaldean Oracles', locus='frag. 47 (Westcott numbering)',
  quote='For this Paternal Intellect, which comprehendeth the Intelligibles and adorneth things ineffable, hath sowed symbols through the World.',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The Paternal Intellect sows symbols through the cosmos.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain',
  needs_review=true, review_reason='sourced from PD primary [v2.1.64]'
 WHERE citation_id='CIT_HER_PATERNAL_INTELLECT_SEC';

-- (B) Mesopotamian secondary pointers (Dalley) ------------------------------
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_DALLEY_MYTHS','Stephanie Dalley, Myths from Mesopotamia: Creation, the Flood, Gilgamesh, and Others (Oxford University Press, rev. ed. 2000)',NULL,'secondary scholarship','Akkadian')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_'||eid||'_DALLEY', 'ENT_MES_'||eid, 'SRC_DALLEY_MYTHS',
  'Myths from Mesopotamia', 'Epic of Creation (Enuma Elish)', NULL,
  'Stephanie Dalley', 2000, NULL, 'secondary',
  'Primordial/theogonic figure named in the Epic of Creation.', DATE '2026-07-05',
  'entity presence confirmed in Dalley trans. (in-copyright) — bibliographic pointer, no text reproduced',
  2, true, 'secondary pointer [v2.1.64]'
FROM (VALUES ('ANSHAR'),('KISHAR'),('LAHMU'),('LAHAMU'),('MUMMU'),('KAKKA'),('DAMKINA')) AS t(eid)
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
