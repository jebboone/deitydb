-- ============================================================================
-- DeityDB — Greco-Roman mystery SECONDARY pointer sourcing (Meyer)  (v2.1.74)
-- scripts/build_meyer_mysteries_pointers_v2_1_74.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Marvin W. Meyer (ed.), The
-- Ancient Mysteries: A Sourcebook of Sacred Texts (in-copyright) for Greek/Roman
-- entities with only `primary-uncited` placeholders. NO TEXT reproduced (quote
-- NULL). Presence VERIFIED 2026-07-05 in context by extraction (pdftotext);
-- rejected substring false positives (Carna->"incarnate", Eleos->"Keleos",
-- Tellus->"Metellus", Lares->"declares", Diana->"Sogdiana"). display_order 2.
-- All needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_MEYER_MYSTERIES','Marvin W. Meyer (ed.), The Ancient Mysteries: A Sourcebook of Sacred Texts (HarperSanFrancisco, 1987)',NULL,'secondary scholarship','Greco-Roman mystery religions')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_ROM_ATTIS_MEYER','ENT_ROM_ATTIS','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','The mysteries of Cybele and Attis (the dying-and-rising god)',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','Attis, consort of the Great Mother, a dying-and-rising mystery god.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]'),
 ('CIT_KORYBANTES_MEYER','ENT_KORYBANTES','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','The Korybantes celebrating the rites of the Mother',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','The Korybantes, ecstatic dancers of the Phrygian Mother''s rites.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]'),
 ('CIT_KOURETES_MEYER','ENT_KOURETES','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','The Kouretes (Dioskouroi) of Samothrace',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','The Kouretes, armed guardian-daimones of the Samothracian and Cretan mysteries.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]'),
 ('CIT_MAENADS_MEYER','ENT_MAENADS','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','The maenads in the Dionysiac mysteries',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','The maenads, ecstatic female devotees of Dionysos.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]'),
 ('CIT_LETHE_MEYER','ENT_LETHE','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','The plain of Lethe (Oblivion) in the underworld',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','Lethe (Oblivion), the underworld river/plain of forgetfulness.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]'),
 ('CIT_ROM_CUPID_MEYER','ENT_ROM_CUPID','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','Cupid (Eros) in the tale of Cupid and Psyche',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','Cupid (Eros), the divine lover in the Cupid-and-Psyche mystery allegory.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]'),
 ('CIT_ROM_APOLLO_MEYER','ENT_ROM_APOLLO','SRC_MEYER_MYSTERIES','The Ancient Mysteries: A Sourcebook','Apollo in the Greco-Roman sacred texts',NULL,'Marvin W. Meyer (ed.)',1987,NULL,'secondary','Apollo, oracular and solar god named in the mystery sources.',DATE '2026-07-05','presence verified in context by extraction of Meyer, The Ancient Mysteries (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.74]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
