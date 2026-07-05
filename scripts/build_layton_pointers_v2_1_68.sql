-- ============================================================================
-- DeityDB — Sethian/Valentinian SECONDARY pointer sourcing  (v2.1.68)
-- scripts/build_layton_pointers_v2_1_68.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Bentley Layton, The Gnostic
-- Scriptures (in-copyright) for Sethian/Valentinian entities that previously had
-- only `primary-uncited` placeholders. NO TEXT is reproduced (quote NULL) — these
-- are pointers to the standard scholarly edition of the Nag Hammadi tractate in
-- which the entity is named. Presence of each entity was VERIFIED 2026-07-05 by
-- text extraction of the edition (Apache Tika / pdftotext); nothing asserted from
-- memory. Loci name the primary tractate. Added as display_order 2 alongside the
-- existing placeholder. All land needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_LAYTON_GNOSTIC','Bentley Layton (with David Brakke), The Gnostic Scriptures (Doubleday / Yale Anchor, 1987; rev. 2021)',NULL,'secondary scholarship','Gnostic')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_SET_BARBELO_LAYTON','ENT_SET_BARBELO','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','The Secret Book According to John (Apocryphon of John)',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'Barbelo, the first emanation / Forethought of the Invisible Spirit, named in the Apocryphon of John.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]'),

 ('CIT_SET_PROTENNOIA_LAYTON','ENT_SET_PROTENNOIA','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','Trimorphic Protennoia (The First Thought in Three Forms)',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'Protennoia (the First Thought), speaker of the Trimorphic Protennoia.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]'),

 ('CIT_SET_NOREA_LAYTON','ENT_SET_NOREA','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','The Reality of the Rulers (Hypostasis of the Archons) / The Thought of Norea',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'Norea, the incorruptible daughter of Eve, named in the Sethian tractates.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]'),

 ('CIT_SET_TRIPLE_POWER_LAYTON','ENT_SET_TRIPLE_POWER','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','Allogenes the Stranger / Zostrianos (Platonizing Sethian)',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'The Triple-Powered One, mediating principle in the Platonizing Sethian treatises.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]'),

 ('CIT_SET_FOUR_LUMINARIES_LAYTON','ENT_SET_FOUR_LUMINARIES','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','The Secret Book According to John (the four luminaries Harmozel, Oroiael, Daveithai, Eleleth)',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'The Four Luminaries (Harmozel and the others) of the Sethian aeonology; Harmozel verified present in the edition.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]'),

 ('CIT_VAL_HOROS_LAYTON','ENT_VAL_HOROS','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','The Valentinian system (Ptolemaic exposition; Horos, the Limit)',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'Horos (the Limit/Boundary) that restores the Pleroma in the Valentinian system.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]'),

 ('CIT_VAL_STAUROS_LAYTON','ENT_VAL_STAUROS','SRC_LAYTON_GNOSTIC',
  'The Gnostic Scriptures','The Valentinian system (Horos also called Stauros, the Cross)',NULL,
  'Bentley Layton',1987,NULL,'secondary',
  'Stauros (the Cross), the fixing aspect of the Limit in the Valentinian Pleroma.',
  DATE '2026-07-05','presence verified by extraction of Layton, The Gnostic Scriptures (in-copyright) — bibliographic pointer, no text reproduced',
  2,true,'secondary pointer [v2.1.68]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
