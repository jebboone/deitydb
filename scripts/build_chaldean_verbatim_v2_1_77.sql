-- ============================================================================
-- DeityDB — Chaldean Oracles VERBATIM sourcing (Westcott, PD)  (v2.1.77)
-- scripts/build_chaldean_verbatim_v2_1_77.sql
-- ----------------------------------------------------------------------------
-- Upgrades `primary-uncited` placeholders to primary-verbatim for four Chaldean
-- entities, with located excerpts from the PUBLIC-DOMAIN Chaldean Oracles, trans.
-- W. Wynn Westcott (1895). Quotes verified 2026-07-05 by whitespace-normalized
-- substring gate against the extracted PD text (nothing from memory; leading
-- "The" trimmed off two quotes only to skip an OCR spacing artifact). Two rows
-- also had mis-attributed source_ids (Iamblichus / Plotinus) corrected to the
-- Chaldean Oracles, the actual source of the quote. All needs_review=true.
-- (NB: Idel & Dan, The Early Kabbalah, was also checked for the Jewish-mystical
-- gaps but yielded nothing clean — its Bahir/Gerona vocabulary and sefirot are
-- already sourced, while the remaining gaps are Hekhalot/Enochic/Hasidic figures
-- absent from that anthology. Majercik's Chaldean Oracles is not on disk, so the
-- PD Westcott edition was used for verbatim quotes instead.)
-- ============================================================================

BEGIN;

UPDATE entity_citations SET
  work_title='The Chaldean Oracles', locus='frag. 54 (Westcott numbering)',
  quote='Intelligible Iynges themselves understand from the Father',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The Intelligible Iynges, the transmitting/connecting powers, understanding from the Father.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.77]'
 WHERE citation_id='CIT_HER_IYNGES_SEC';

UPDATE entity_citations SET
  work_title='The Chaldean Oracles', locus='frag. 58 (Westcott numbering)',
  quote='Teletarchs are comprehended in the Synoches',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The Teletarchs (perfecting rulers) comprehended within the Synoches (connectors).',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.77]'
 WHERE citation_id='CIT_HER_TELETARCHS_SEC';

UPDATE entity_citations SET
  source_id='SRC_CHALDEAN_ORACLES',
  work_title='The Chaldean Oracles', locus='frag. 75 (Westcott numbering)',
  quote='There are certain Irrational Demons (mindless elementals), which derive their subsistence from the Aerial Rulers',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The irrational/material daemons subsisting from the Aerial Rulers (the "terrestrial dogs").',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.77]'
 WHERE citation_id='CIT_HER_MATERIAL_DAIMONES_SEC';

UPDATE entity_citations SET
  source_id='SRC_CHALDEAN_ORACLES',
  work_title='The Chaldean Oracles', locus='frag. 148 (Westcott numbering)',
  quote='Invoke not the visible Image of the Soul of Nature',
  translator='W. Wynn Westcott', translation_year=1895,
  source_url='https://sacred-texts.com/eso/coz/index.htm',
  evidence_grade='primary-verbatim',
  evidence_note='The Soul of Nature (the World Soul), whose visible image must not be invoked.',
  verified_on=DATE '2026-07-05',
  verify_method='verbatim from W. Wynn Westcott, The Chaldaean Oracles of Zoroaster (1895), public domain; substring-verified',
  needs_review=true, review_reason='sourced from PD primary [v2.1.77]'
 WHERE citation_id='CIT_HER_WORLD_SOUL_SEC';

COMMIT;
