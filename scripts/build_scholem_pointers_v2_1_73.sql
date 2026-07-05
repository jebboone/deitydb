-- ============================================================================
-- DeityDB — Jewish-mystical SECONDARY pointer sourcing (Scholem)  (v2.1.73)
-- scripts/build_scholem_pointers_v2_1_73.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Gershom Scholem, Kabbalah
-- (in-copyright) for Jewish-mystical/Israelite entities with only
-- `primary-uncited` placeholders. NO TEXT reproduced (quote NULL). Presence
-- VERIFIED 2026-07-05 in context by extraction (pdftotext); rejected Dumah
-- (substring of "Kedumah") and held Elohim (ambiguous). display_order 2. All
-- needs_review=true. Idempotent.
-- ============================================================================

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_SCHOLEM_KABBALAH','Gershom Scholem, Kabbalah (Keter Publishing House / Meridian, 1974)',NULL,'secondary scholarship','Jewish mysticism')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
VALUES
 ('CIT_JM_ADAM_KADMON_SCHOLEM','ENT_JM_ADAM_KADMON','SRC_SCHOLEM_KABBALAH','Kabbalah','On Adam Kadmon, the primordial man',NULL,'Gershom Scholem',1974,NULL,'secondary','Adam Kadmon, the primordial anthropos of the sefirotic world.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_KETER_SCHOLEM','ENT_JM_KETER','SRC_SCHOLEM_KABBALAH','Kabbalah','On the Sefirot — Keter (Crown)',NULL,'Gershom Scholem',1974,NULL,'secondary','Keter, the highest sefirah.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_GEVURAH_SCHOLEM','ENT_JM_GEVURAH','SRC_SCHOLEM_KABBALAH','Kabbalah','On the Sefirot — Gevurah (Might/Judgment)',NULL,'Gershom Scholem',1974,NULL,'secondary','Gevurah, the sefirah of might and stern judgment.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_DAAT_SCHOLEM','ENT_JM_DAAT','SRC_SCHOLEM_KABBALAH','Kabbalah','On Da''at (Knowledge), between Hokhmah and Binah',NULL,'Gershom Scholem',1974,NULL,'secondary','Da''at (Knowledge), the hidden sefirah between Hokhmah and Binah.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_SHEDIM_SCHOLEM','ENT_JM_SHEDIM','SRC_SCHOLEM_KABBALAH','Kabbalah','On the shedim (demons)',NULL,'Gershom Scholem',1974,NULL,'secondary','The shedim, demons of Jewish demonology.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_GEHENNA_SCHOLEM','ENT_JM_GEHENNA','SRC_SCHOLEM_KABBALAH','Kabbalah','On Gehenna, the fire of judgment',NULL,'Gershom Scholem',1974,NULL,'secondary','Gehenna, the place/fire of punishment in Kabbalistic cosmology.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_VITAL_SCHOLEM','ENT_JM_VITAL','SRC_SCHOLEM_KABBALAH','Kabbalah','On Hayyim Vital, disciple of Isaac Luria',NULL,'Gershom Scholem',1974,NULL,'secondary','Hayyim Vital, chief transmitter of Lurianic Kabbalah.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_JM_TORAH_SCHOLEM','ENT_TORAH','SRC_SCHOLEM_KABBALAH','Kabbalah','On the mystical conception of the Torah',NULL,'Gershom Scholem',1974,NULL,'secondary','The Torah as a mystical/divine hypostasis in Kabbalah.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_ISR_MICHAEL_SCHOLEM','ENT_ISR_MICHAEL','SRC_SCHOLEM_KABBALAH','Kabbalah','On the archangel Michael',NULL,'Gershom Scholem',1974,NULL,'secondary','The archangel Michael in Jewish angelology.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_ISR_ASMODEUS_SCHOLEM','ENT_ISR_ASMODEUS','SRC_SCHOLEM_KABBALAH','Kabbalah','On Ashmedai (Asmodeus), king of the demons',NULL,'Gershom Scholem',1974,NULL,'secondary','Ashmedai (Asmodeus), king of the shedim.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]'),
 ('CIT_ENOCH_SCHOLEM','ENT_ENOCH','SRC_SCHOLEM_KABBALAH','Kabbalah','On Enoch and his transformation into Metatron',NULL,'Gershom Scholem',1974,NULL,'secondary','Enoch, the patriarch translated and transformed into the angel Metatron.',DATE '2026-07-05','presence verified in context by extraction of Scholem, Kabbalah (in-copyright) — bibliographic pointer, no text reproduced',2,true,'secondary pointer [v2.1.73]')
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
