-- ============================================================================
-- DeityDB — Egyptian citation sourcing, batch 1  (v2.1.63)
-- scripts/build_egyptian_citations_v2_1_63.sql
-- ----------------------------------------------------------------------------
-- Adds located VERBATIM citations from the public-domain Book of the Dead
-- (Papyrus of Ani), trans. E. A. Wallis Budge (1895), for Egyptian entities
-- that previously had only `primary-uncited` placeholders. Existing citation
-- rows are kept; these are added as display_order 2. Quotes verified 2026-07-05
-- by verbatim extraction from the PD Budge text (Apache Tika); nothing from
-- memory. All land needs_review=true. Idempotent (ON CONFLICT DO NOTHING).
-- ============================================================================

BEGIN;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_EGY_NEPHTHYS_BUDGE','ENT_EGY_NEPHTHYS','SRC_BUDGE_PAPYRUS_ANI',
  'The Book of the Dead: The Papyrus of Ani','Hymn to Osiris (Papyrus of Ani)',
  'Isis and Nephthys salute thee, they sing unto thee songs of joy at thy rising in the boat',
  'E. A. Wallis Budge',1895,'https://archive.org/details/bookofdeadpapyru00budg',
  'primary-verbatim','Nephthys named beside Isis in the opening Hymn to Osiris.',
  DATE '2026-07-05','verbatim from Budge, Book of the Dead (Papyrus of Ani, 1895), public domain',
  2,true,'sourced from PD primary [v2.1.63]'),

 ('CIT_EGY_ANUBIS_BUDGE','ENT_EGY_ANUBIS','SRC_BUDGE_PAPYRUS_ANI',
  'The Book of the Dead: The Papyrus of Ani','Judgment Scene / Weighing of the Heart (Papyrus of Ani)',
  'Speech of the Dweller in the Embalmment Chamber (Anubis): Pay good heed, O righteous Judge, to the Balance to support the testimony thereof',
  'E. A. Wallis Budge',1895,'https://archive.org/details/bookofdeadpapyru00budg',
  'primary-verbatim','Anubis as overseer of the balance in the weighing of the heart.',
  DATE '2026-07-05','verbatim from Budge, Book of the Dead (Papyrus of Ani, 1895), public domain',
  2,true,'sourced from PD primary [v2.1.63]'),

 ('CIT_EGY_SETH_BUDGE','ENT_EGY_SETH','SRC_BUDGE_PAPYRUS_ANI',
  'The Book of the Dead: The Papyrus of Ani','Chapter (Spell) 17, gloss (Papyrus of Ani)',
  'It is Suti, but others say that it is Smamur, the soul of Keb',
  'E. A. Wallis Budge',1895,'https://archive.org/details/bookofdeadpapyru00budg',
  'primary-verbatim','Set (Suti) glossed in the Chapter 17 commentary.',
  DATE '2026-07-05','verbatim from Budge, Book of the Dead (Papyrus of Ani, 1895), public domain',
  2,true,'sourced from PD primary [v2.1.63]'),

 ('CIT_EGY_MAUAA_BUDGE','ENT_EGY_MAUAA','SRC_BUDGE_PAPYRUS_ANI',
  'The Book of the Dead: The Papyrus of Ani','Chapter (Spell) 17 (Papyrus of Ani)',
  'I am the Great Cat which dwelleth in the Seat of Truth, wherein the god Shu riseth',
  'E. A. Wallis Budge',1895,'https://archive.org/details/bookofdeadpapyru00budg',
  'primary-verbatim','The Great Cat (Mau-aa) of Ra, from the Chapter 17 self-declaration.',
  DATE '2026-07-05','verbatim from Budge, Book of the Dead (Papyrus of Ani, 1895), public domain',
  2,true,'sourced from PD primary [v2.1.63]'),

 ('CIT_EGY_SEKHET_AARU_BUDGE','ENT_EGY_SEKHET_AARU','SRC_BUDGE_PAPYRUS_ANI',
  'The Book of the Dead: The Papyrus of Ani','Hymn to Osiris Un-Nefer (Papyrus of Ani)',
  'a permanent homestead in Sekhet-Aaru, with wheat and barley therein',
  'E. A. Wallis Budge',1895,'https://archive.org/details/bookofdeadpapyru00budg',
  'primary-verbatim','Sekhet-Aaru (the Field of Reeds) as the blessed afterlife homestead.',
  DATE '2026-07-05','verbatim from Budge, Book of the Dead (Papyrus of Ani, 1895), public domain',
  2,true,'sourced from PD primary [v2.1.63]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
