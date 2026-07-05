-- ============================================================================
-- DeityDB — Jewish angelology/demonology SECONDARY pointer sourcing (Davidson) (v2.1.79)
-- scripts/build_davidson_pointers_v2_1_79.sql
-- ----------------------------------------------------------------------------
-- Adds SECONDARY bibliographic pointer citations to Gustav Davidson, A Dictionary
-- of Angels (in-copyright) for Jewish-mystical/Israelite angels and demons with
-- only `primary-uncited` placeholders. NO TEXT reproduced (quote NULL). Presence
-- VERIFIED 2026-07-05 in context by extraction (pdftotext) — a dictionary, so
-- each is a headword/entry; substring-risky ones were checked by hand (Haniel =
-- "chief of principalities", Ishim = "Aishim, the flames", Elohim = the angelic
-- order, Agrat = wife of Samael, Mazzikin = "mazikeen, evil spirits"). Held
-- Dumah/Lilin/Spirit-of-Truth (unverified). display_order 2. needs_review=true.
-- ============================================================================

BEGIN;

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order,
  needs_review, review_reason)
SELECT 'CIT_'||t.eid||'_DAVIDSON', t.eid, 'SRC_DAVIDSON_ANGELS',
  'A Dictionary of Angels', 's.v. '||e.canonical_name, NULL,
  'Gustav Davidson', 1967, NULL, 'secondary', t.note, DATE '2026-07-05',
  'presence verified in context by extraction of Davidson, A Dictionary of Angels (in-copyright) — bibliographic pointer, no text reproduced',
  2, true, 'secondary pointer [v2.1.79]'
FROM (VALUES
 ('ENT_ISR_ANGEL_DARKNESS','The Angel of Darkness, leader of the sons of darkness in the dualistic angelology.'),
 ('ENT_ISR_ANGEL_PRESENCE','The Angel of the Presence (Sar ha-Panim), who stands before the throne.'),
 ('ENT_ISR_BARAQIEL','Baraqiel (Barakiel), a ruling/fallen angel of lightning.'),
 ('ENT_ISR_MASTEMA','Mastema, the accusing and hostile angel (Book of Jubilees).'),
 ('ENT_ISR_PENEMUE','Penemue, a fallen Watcher who taught mortals writing.'),
 ('ENT_ISR_PRINCE_LIGHT','The Prince of Light, leader of the sons of light (identified with Michael).'),
 ('ENT_JM_AF_HEMAH','Af and Hemah, the twin angels of anger and wrath.'),
 ('ENT_JM_AGRAT','Agrat bat Mahlat, a queen of demons and consort of Samael.'),
 ('ENT_JM_AKATRIEL','Akatriel (Aktariel), a high angel associated with the divine crown.'),
 ('ENT_JM_ANPIEL','Anpiel, the angel who binds the crown upon Metatron.'),
 ('ENT_JM_ELOHIM_RANK','The Elohim, an order/rank of angels in the celestial hierarchy.'),
 ('ENT_JM_ERELIM','The Erelim (Arelim), an angelic order, the "valiant ones".'),
 ('ENT_JM_HADRANIEL','Hadraniel, a mighty porter-angel of the second heaven.'),
 ('ENT_JM_HANIEL','Haniel (Anael), chief of principalities, "the tallest angel in Heaven".'),
 ('ENT_JM_HEAVENLY_HOST','The heavenly host (tzeva''ot), the assembled armies of angels.'),
 ('ENT_JM_ISHIM','The Ishim (Aishim, "the flames"), an angelic order of manlike beings.'),
 ('ENT_JM_MALACHIM','The Malachim, an angelic order ("messengers").'),
 ('ENT_JM_MAZZIKIN','The mazzikin (mazikeen), harmful spirits of Jewish demonology.'),
 ('ENT_JM_SAR_HAOLAM','Sar ha-Olam, the "Prince of the World" (identified with Metatron/Michael).'),
 ('ENT_JM_SHAMSHIEL','Shamshiel, an angel of the day / a ruling angel.'),
 ('ENT_JM_ZAGZAGEL','Zagzagel, angel of the burning bush and teacher of Moses.')
) AS t(eid,note)
JOIN entities e ON e.entity_id=t.eid
ON CONFLICT (citation_id) DO NOTHING;

COMMIT;
