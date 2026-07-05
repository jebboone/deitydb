-- ============================================================================
-- DeityDB — Gnostic/Sethian/Valentinian SECONDARY pointer sourcing  (v2.1.71)
-- scripts/build_vandenbroek_pointers_v2_1_71.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Roelof van den Broek,
-- Gnostic Religion in Antiquity (Cambridge University Press, 2013; in-copyright)
-- for Sethian/Valentinian/Ophite entities with only `primary-uncited`
-- placeholders. NO TEXT reproduced (quote NULL). Presence VERIFIED 2026-07-05 in
-- context by extraction (pdftotext); the catalogue of attendant aeons of the
-- Four Luminaries (van den Broek's discussion of the Gospel of the Egyptians /
-- Zostrianos) names each aeon in Greek — read directly since ASCII grep drops
-- the macrons (Aisthēsis, Mnēmē, Agapē). Rejected Teleios-as-"Logos Teleios"
-- (Hermetic title) but retained via the aeon-catalogue "Perfection (Teleiotēs)".
-- Added display_order 2. All needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_VDBROEK_GNOSTIC','Roelof van den Broek, Gnostic Religion in Antiquity (Cambridge University Press, 2013)',NULL,'secondary scholarship','Gnostic')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 -- Platonizing-Sethian powers within the Barbelo aeon -----------------------
 ('CIT_SET_KALYPTOS_VDB','ENT_SET_KALYPTOS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The divine powers within the Barbelo aeon (Zostrianos): Kalyptos, Protophanes',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Kalyptos (the Hidden One), a power within Barbelo.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_PROTOPHANES_VDB','ENT_SET_PROTOPHANES','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The divine powers within the Barbelo aeon (Zostrianos): Kalyptos, Protophanes',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Protophanes (the First-Appearing), a power within Barbelo.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_DOXOMEDON_VDB','ENT_SET_DOXOMEDON','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The aeon Doxomedon Domedon, named with Barbelo (Gospel of the Egyptians)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Doxomedon (Domedon), the great aeon of the Sethian theogony.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_ADAMAS_VDB','ENT_SET_ADAMAS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The heavenly Adamas / Pigeradamas of the Sethian system',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Adamas (Pigeradamas), the heavenly primal man of the Sethians.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_OPH_HORAIOS_VDB','ENT_OPH_HORAIOS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The seven archons of the Ophite system (Yaldabaoth, Yao, Sabaoth, Adonaios, Eloaios, Horaios, Astaphaios)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Horaios, one of the seven planetary archons in the Ophite diagram.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 -- The catalogue of attendant aeons of the Four Luminaries ------------------
 ('CIT_SET_CHARIS_VDB','ENT_SET_CHARIS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Grace (Charis)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Charis (Grace), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_ALETHEIA_VDB','ENT_SET_ALETHEIA','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Truth (Alētheia)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Aletheia (Truth), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_MORPHE_VDB','ENT_SET_MORPHE','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Form (Morphē)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Morphe (Form), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_AISTHESIS_VDB','ENT_SET_AISTHESIS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Perception (Aisthēsis)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Aisthesis (Perception), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_MNEME_VDB','ENT_SET_MNEME','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Memory (Mnēmē)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Mneme (Memory), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_SYNESIS_VDB','ENT_SET_SYNESIS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Understanding (Synesis)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Synesis (Understanding), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_AGAPE_VDB','ENT_SET_AGAPE','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Love (Agapē)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Agape (Love), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_IDEA_VDB','ENT_SET_IDEA','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Idea',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Idea, attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_EIRENE_VDB','ENT_SET_EIRENE','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Peace (Eirēnē)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Eirene (Peace), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_SET_TELEIOS_VDB','ENT_SET_TELEIOS','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The catalogue of attendant aeons of the Four Luminaries — Perfection (Teleiotēs / tmnttelios)',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','Teleios/Teleiotes (Perfection), attendant aeon of the Sethian luminaries.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 -- Valentinian anthropological classes --------------------------------------
 ('CIT_VAL_PNEUMATIC_VDB','ENT_VAL_PNEUMATIC','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The three natures of humanity in the Valentinian system — the pneumatics',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','The pneumatics (spiritual ones, the gnostics who are saved).',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_VAL_PSYCHIC_VDB','ENT_VAL_PSYCHIC','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The three natures of humanity in the Valentinian system — the psychics',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','The psychics (animate ones), the middle nature in Valentinianism.',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]'),
 ('CIT_VAL_HYLIC_VDB','ENT_VAL_HYLIC','SRC_VDBROEK_GNOSTIC','Gnostic Religion in Antiquity',
  'The three natures of humanity in the Valentinian system — the hylics',NULL,
  'Roelof van den Broek',2013,NULL,'secondary','The hylics (material people, who will be lost).',
  DATE '2026-07-05','presence verified in context by extraction of van den Broek, Gnostic Religion in Antiquity (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.71]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
