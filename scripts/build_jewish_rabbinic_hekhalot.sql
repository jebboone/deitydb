-- scripts/build_jewish_rabbinic_hekhalot.sql
-- Content normalization III (v1.45.0): Jewish rabbinic + Hekhalot/Merkavah build-out.
-- The late-antique rabbinic and Hekhalot strata (the Babylonian Talmud, the midrashim,
-- the Apocalypse of Abraham, 3 Enoch and the Hekhalot literature) — the demon-queens,
-- the throne-princes of the Merkavah mystics, and the infernal realm. Completes the
-- Jewish-tradition rebalancing (Jewish Mystical 24 -> ~39; total Jewish ~93). Each
-- entity to a primary locus; relationships wired into the existing Jewish cast.

BEGIN;

-- ── New rabbinic/Hekhalot sources (3 Enoch, Hekhalot, Zohar already registered) ──
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_BABYLONIAN_TALMUD','The Babylonian Talmud (Talmud Bavli), c. 500-600 CE','','primary text','The foundational rabbinic compendium; its angelology and demonology'),
('SRC_APOCALYPSE_ABRAHAM','The Apocalypse of Abraham, c. 1st-2nd c. CE','','primary text','The apocalypse of Abraham''s heavenly ascent, guided by the angel Yahoel'),
('SRC_MIDRASH','Classical Midrash (Genesis Rabbah, Lamentations Rabbah, Pesikta, etc.), late antique','','primary text','The classical aggadic midrashim of late antiquity')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- rabbinic demonology
 ('ENT_JM_DUMAH','Dumah','Jewish Mystical','Angel','Angel of the dead','silence; the grave; the prince of Gehenna','Jewish','A','candidate_verified_name','Rabbinic angel',0,true,false,'The angel of silence and of the dead, prince over the souls in Gehenna.'),
 ('ENT_JM_KETEV_MERIRI','Ketev Meriri','Jewish Mystical','Demon','Plague demon','the noonday plague; bitter destruction','Jewish','A','candidate_verified_name','Rabbinic demon',0,true,false,'The bitter noonday demon of pestilence (Psalm 91:6; Lamentations Rabbah).'),
 ('ENT_JM_AGRAT','Agrat bat Mahlat','Jewish Mystical','Demon','Demon queen','the night; the dancing-demons of the air','Jewish','B','candidate_verified_name','Rabbinic/Zoharic demon-queen',0,true,false,'A queen of demons who rides the night air with myriads of destroying spirits.'),
 ('ENT_JM_NAAMAH','Naamah','Jewish Mystical','Demon','Demon queen','seduction; the troubling of men in sleep','Jewish','B','candidate_verified_name','Zoharic demon-queen',0,true,false,'A demoness of seduction, one of the queens of the qliphoth alongside Lilith.'),
 ('ENT_JM_SHEDIM','Shedim','Jewish Mystical','Demonic collective','Demons','the wild places; harm and misfortune','Jewish','A','candidate_verified_name','Rabbinic demon class',0,true,false,'The shedim, the demons of rabbinic lore, partaking of both angels and humans.'),
 ('ENT_JM_MAZZIKIN','Mazzikin','Jewish Mystical','Demonic collective','Harmful spirits','injury; nocturnal danger','Jewish','A','candidate_verified_name','Rabbinic demon class',0,true,false,'The mazzikin, the "harmers," invisible spirits that crowd and injure the living.'),
 ('ENT_JM_LILIN','Lilin','Jewish Mystical','Demonic collective','Night-demons','night; the strangling of infants','Jewish','B','candidate_verified_name','Rabbinic/Zoharic demon brood',0,true,false,'The lilin, the demonic brood of Lilith who menace women in childbirth and infants.'),
 ('ENT_JM_AF_HEMAH','Af and Hemah','Jewish Mystical','Angelic pair','Angels of wrath','divine anger; destruction','Jewish','B','candidate_verified_name','Rabbinic destroying angels',0,false,false,'Af (Anger) and Hemah (Wrath), the two destroying angels of divine judgment.'),
 -- Hekhalot / Merkavah throne-princes
 ('ENT_JM_ANAFIEL','Anafiel','Jewish Mystical','Archangel','Throne-prince','the divine seal; the keeping of the palaces','Jewish','A','candidate_verified_name','Hekhalot throne-prince',0,false,false,'The mighty prince who bears the divine seal, set even above Metatron in 3 Enoch.'),
 ('ENT_JM_AKATRIEL','Akatriel','Jewish Mystical','Divine title/form','Enthroned Name','the throne of glory; the divine Name','Jewish','A','candidate_verified_name','Enthroned Name-form',0,false,false,'Akatriel Yah, the crowned Name enthroned in glory, seen by R. Ishmael in the sanctuary.'),
 ('ENT_JM_YAHOEL','Yahoel','Jewish Mystical','Archangel','Name-bearing angel','the divine Name; the guidance of the seer','Jewish','A','candidate_verified_name','Name-bearing angel',0,false,false,'The angel in whom the ineffable Name dwells, guide of Abraham and a precursor of Metatron.'),
 ('ENT_JM_ZAGZAGEL','Zagzagel','Jewish Mystical','Archangel','Prince of Torah','wisdom; the teaching of the Name; the burning bush','Jewish','B','candidate_verified_name','Hekhalot prince of Torah',0,false,false,'The prince of Torah and angel of the burning bush, teacher of the seventy tongues.'),
 ('ENT_JM_SAR_HAPANIM','Sar ha-Panim','Jewish Mystical','Archangel','Prince of the Presence','the divine Presence; the adjurations of the mystic','Jewish','A','candidate_verified_name','Hekhalot office',0,false,false,'The Prince of the Presence invoked in the Hekhalot adjurations; identified with Metatron.'),
 ('ENT_JM_SAR_HAOLAM','Sar ha-Olam','Jewish Mystical','Archangel','Prince of the World','the governance of the created world','Jewish','A','candidate_verified_name','Rabbinic cosmic prince',0,false,false,'The Prince of the World who governs creation; identified with Metatron, the youth.'),
 -- cosmological realm and primordial creature
 ('ENT_JM_GEHENNA','Gehenna','Jewish Mystical','Cosmological realm','Infernal realm','the fiery purgation; the punishment of the wicked','Jewish','A','candidate_verified_name','Rabbinic netherworld',0,true,false,'The fiery realm of post-mortem purgation and punishment, developed from biblical Sheol.'),
 ('ENT_ISR_ZIZ','Ziz','Israelite/Second Temple','Monster','Primordial bird','the sky; the primordial creatures of the air','Jewish','B','candidate_verified_name','Primordial creature',0,false,false,'The giant primordial bird, third of the great creatures with Behemoth and Leviathan.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_JM_DUMAH','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Berakhot 18b; b. Hagigah 5a: Dumah, the angel set over the spirits of the dead.'),
 ('ENT_JM_KETEV_MERIRI','SRC_MIDRASH','Direct attestation','Lamentations Rabbah 1:3; Pesikta on Psalm 91:6: Ketev Meriri, the noonday demon of plague.'),
 ('ENT_JM_AGRAT','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Pesachim 112b: Agrat bat Mahlat and her myriads of harmful angels who roam the night.'),
 ('ENT_JM_NAAMAH','SRC_ZOHAR','Direct attestation','Zohar I.55a; III.76b-77a: Naamah, a demoness of seduction among the queens of the qliphoth.'),
 ('ENT_JM_SHEDIM','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Hagigah 16a; b. Berakhot 6a: the shedim, who share three traits with angels and three with humans.'),
 ('ENT_JM_MAZZIKIN','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Berakhot 6a: the mazzikin (harmers) that throng unseen about the living.'),
 ('ENT_JM_LILIN','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Shabbat 151b; b. Eruvin 100b; Zohar: the lilin, the night-brood of Lilith.'),
 ('ENT_JM_AF_HEMAH','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Shabbat 55a; b. Nedarim 32a: Af (Anger) and Hemah (Wrath), the destroying angels.'),
 ('ENT_JM_ANAFIEL','SRC_3_ENOCH','Direct attestation','3 Enoch 6:1; 18:25: Anafiel YHWH, the prince whose splendour exceeds even Metatron''s.'),
 ('ENT_JM_AKATRIEL','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Berakhot 7a: R. Ishmael sees Akatriel Yah, Lord of Hosts, enthroned in the sanctuary.'),
 ('ENT_JM_YAHOEL','SRC_APOCALYPSE_ABRAHAM','Direct attestation','Apocalypse of Abraham 10-11: Yahoel, in whom the ineffable Name dwells, guides Abraham aloft.'),
 ('ENT_JM_ZAGZAGEL','SRC_MIDRASH','Direct attestation','Deuteronomy Rabbah 11:10; the Hekhalot: Zagzagel, prince of Torah and angel of the bush.'),
 ('ENT_JM_ZAGZAGEL','SRC_HEKHALOT_SCHAFER_SYNOPSE','Direct attestation','The Hekhalot literature: Zagzagel among the princes who teach the secrets of Torah.'),
 ('ENT_JM_SAR_HAPANIM','SRC_HEKHALOT_SCHAFER_SYNOPSE','Direct attestation','Hekhalot Rabbati; the Sar ha-Panim adjuration: the Prince of the Presence compelled to descend.'),
 ('ENT_JM_SAR_HAOLAM','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Yevamot 16b; b. Hullin 60a: the Prince of the World (Sar ha-Olam), "the youth."'),
 ('ENT_JM_GEHENNA','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Eruvin 19a; b. Pesachim 54a; Mishnah Avot 5:19: Gehenna, the fiery place of punishment.'),
 ('ENT_ISR_ZIZ','SRC_BABYLONIAN_TALMUD','Direct attestation','b. Bava Batra 73b; Leviticus Rabbah 22:10 (on Psalm 50:11): the Ziz, the great bird of the primordial triad.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_JM_DUMAH','presides_over','ENT_JM_GEHENNA','high','Dumah is the angel-prince set over the souls in Gehenna.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_JM_GEHENNA','reception_of','ENT_ISR_SHEOL','medium','Rabbinic Gehenna develops from the biblical netherworld Sheol.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_JM_SAR_HAOLAM','identified_with','ENT_JM_METATRON','high','The Prince of the World ("the youth") is identified with Metatron.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_JM_SAR_HAPANIM','identified_with','ENT_JM_METATRON','high','The Prince of the Presence of the Hekhalot is Metatron.','SRC_HEKHALOT_SCHAFER_SYNOPSE','reviewed'),
 ('ENT_JM_METATRON','reception_of','ENT_JM_YAHOEL','medium','Metatron develops from the earlier Name-bearing angel Yahoel.','SRC_APOCALYPSE_ABRAHAM','reviewed'),
 ('ENT_JM_ANAFIEL','aligned_with','ENT_JM_METATRON','medium','Anafiel is the throne-prince set above Metatron in 3 Enoch.','SRC_3_ENOCH','reviewed'),
 ('ENT_JM_AKATRIEL','cult_form_of','ENT_ISR_YAHWEH','high','Akatriel Yah is a crowned, enthroned Name-form of the God of Israel.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_JM_ZAGZAGEL','aligned_with','ENT_JM_SAR_TORAH','medium','Zagzagel and the Sar Torah are both princes who impart the secrets of Torah.','SRC_HEKHALOT_SCHAFER_SYNOPSE','reviewed'),
 ('ENT_JM_LILITH','consort_of','ENT_GNO_SAMAEL','high','In rabbinic and Zoharic lore Lilith is the consort of Samael, the demonic couple.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_AGRAT','aligned_with','ENT_JM_LILITH','high','Agrat bat Mahlat is one of the demon-queens alongside Lilith.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_NAAMAH','aligned_with','ENT_JM_LILITH','high','Naamah is one of the demon-queens alongside Lilith.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_LILIN','child_of','ENT_JM_LILITH','high','The lilin are the demonic brood of Lilith.','SRC_ZOHAR','reviewed'),
 ('ENT_JM_LILIN','member_of','ENT_JM_SHEDIM','high','The lilin are a class of the shedim.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_JM_KETEV_MERIRI','member_of','ENT_JM_SHEDIM','high','Ketev Meriri is counted among the harmful demons.','SRC_MIDRASH','reviewed'),
 ('ENT_JM_MAZZIKIN','aligned_with','ENT_JM_SHEDIM','high','The mazzikin and shedim are parallel classes of rabbinic harmful spirits.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_JM_AF_HEMAH','aligned_with','ENT_ISR_ANGEL_OF_DEATH','medium','Af and Hemah act with the destroying/death angels of judgment.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_ISR_ZIZ','aligned_with','ENT_ISR_LEVIATHAN','high','Ziz, Behemoth and Leviathan form the primordial triad of sky, land and sea.','SRC_BABYLONIAN_TALMUD','reviewed'),
 ('ENT_ISR_ZIZ','aligned_with','ENT_ISR_BEHEMOTH','high','Ziz, Behemoth and Leviathan form the primordial triad of sky, land and sea.','SRC_BABYLONIAN_TALMUD','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Jewish Mystical' AS label, count(*) FROM entities WHERE tradition='Jewish Mystical'
UNION ALL SELECT 'Jewish total (all strata)', count(*) FROM entities
  WHERE tradition IN ('Jewish Mystical','Israelite/Second Temple','Israelite','Jewish');
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
