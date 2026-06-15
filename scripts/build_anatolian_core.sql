-- scripts/build_anatolian_core.sql
-- Content deepening (v1.56.0, part 2): the Anatolian pantheons. Closes the second thin
-- pre-Christ pantheon from the audit. Hittite/Hittite-Hurrian/Luwian ~13 -> ~34: the
-- Hurrian Kumarbi-cycle gods, the Hittite cult pantheon ("the thousand gods of Hatti"),
-- and the Luwian Iron Age gods. Each to Hoffner's Hittite Myths or Taracha's Anatolia;
-- period-linked (Hittite Empire / Neo-Hittite Luwian); the theogony and families wired.

BEGIN;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- Hittite / Hurrian (the Kumarbi cycle and the Hurrian pantheon)
 ('ENT_HTT_SHARRUMA','Sharruma','Hittite/Hurrian','God','Mountain god','the mountains; kingship; the son of the storm-god','Anatolian','A','candidate_verified_name','Hurrian god',1,false,false,'The mountain-god son of Teshub and Hepat, protector of the Hittite king.'),
 ('ENT_HTT_KUSHUH','Kushuh','Hittite/Hurrian','God','Moon god','the moon; oaths','Anatolian','B','candidate_verified_name','Hurrian moon-god',0,false,false,'Kushuh, the Hurrian moon-god and guarantor of oaths.'),
 ('ENT_HTT_SHIMIGE','Shimige','Hittite/Hurrian','God','Sun god','the sun; justice','Anatolian','B','candidate_verified_name','Hurrian sun-god',0,false,false,'Shimige, the Hurrian sun-god.'),
 ('ENT_HTT_HUTENA','Hutena and Hutellura','Hittite/Hurrian','Goddess collective','Fate and midwife goddesses','fate; birth; the allotment of life','Anatolian','B','candidate_verified_name','Hurrian fate-goddesses',0,false,false,'The Hurrian goddesses of fate and birth who determine the destiny of the newborn.'),
 ('ENT_HTT_ARANZAH','Aranzah','Hittite/Hurrian','God','Deified river','the river Tigris','Anatolian','B','candidate_verified_name','Deified Tigris',2,false,false,'Aranzah, the deified river Tigris, born of Anu''s seed in the Song of Kumarbi.'),
 ('ENT_HTT_SERI_HURRI','Seri and Hurri','Hittite/Hurrian','Divine collective','The bulls of the storm-god','the drawing of the storm-god''s chariot','Anatolian','B','candidate_verified_name','Bulls of Teshub',1,false,false,'Seri ("Day") and Hurri ("Night"), the two bulls that draw the chariot of Teshub.'),
 ('ENT_HTT_HAZZI','Hazzi','Hittite/Hurrian','God','Deified mountain','the holy mountain; the seat of the storm-god','Anatolian','B','candidate_verified_name','Deified Mt Hazzi (Casius)',3,false,false,'Hazzi, the deified Mount Hazzi (Casius), the mountain of the storm-god Teshub.'),
 ('ENT_HTT_TASHMISHU','Tashmishu','Hittite/Hurrian','God','Vizier of the storm-god','war; the service of Teshub','Anatolian','B','candidate_verified_name','Brother-vizier of Teshub',0,false,false,'Tashmishu, the brother and vizier of Teshub, his attendant in battle.'),
 -- Hittite (the cult pantheon of Hatti)
 ('ENT_HTT_MEZZULLA','Mezzulla','Hittite','Goddess','Daughter of the Sun Goddess','intercession; the Arinna cult','Anatolian','B','candidate_verified_name','Hittite goddess',0,false,false,'Mezzulla, daughter of the Sun Goddess of Arinna, an intercessor of the royal cult.'),
 ('ENT_HTT_KAMRUSEPA','Kamrusepa','Hittite','Goddess','Goddess of magic and healing','magic; healing; ritual incantation','Anatolian','A','candidate_verified_name','Hittite goddess of magic',0,false,false,'Kamrusepa, the goddess of magic and healing who soothes the wrath of Telipinu.'),
 ('ENT_HTT_HALKI','Halki','Hittite','God','Grain deity','grain; the harvest','Anatolian','B','candidate_verified_name','Hittite grain deity',2,false,false,'Halki, the deity of grain and the harvest.'),
 ('ENT_HTT_WURUNKATTE','Wurunkatte','Hittite','God','War god','war; victory','Anatolian','B','candidate_verified_name','Hittite war-god',0,false,false,'Wurunkatte ("King of the Land"), the Hattian-Hittite god of war.'),
 ('ENT_HTT_LELWANI','Lelwani','Hittite','Deity','Deity of the underworld','the underworld; the dead','Anatolian','B','candidate_verified_name','Hittite underworld deity',0,true,false,'Lelwani, the Hittite deity of the underworld and the dead.'),
 ('ENT_HTT_ISTANU','Istanu','Hittite','God','Sun-god of the day','the sun; justice; the daily journey','Anatolian','A','candidate_verified_name','Hittite sun-god',0,false,false,'Istanu, the Hittite sun-god of the day and judge of mankind, distinct from the Sun Goddess of Arinna.'),
 -- Luwian (the Iron Age pantheon)
 ('ENT_LUW_TARHUNZ','Tarhunz','Luwian','God','Storm god','the storm; rain; the vine; sovereignty','Anatolian','A','candidate_verified_name','Luwian chief god',1,false,false,'Tarhunz, the Luwian storm-god and chief deity, cognate of the Hittite Tarhunna.'),
 ('ENT_LUW_TIWAZ','Tiwaz','Luwian','God','Sun god','the sun; justice; oaths','Anatolian','A','candidate_verified_name','Luwian sun-god',0,false,false,'Tiwaz, the Luwian sun-god, guarantor of justice and oaths.'),
 ('ENT_LUW_ARMA','Arma','Luwian','God','Moon god','the moon; months','Anatolian','B','candidate_verified_name','Luwian moon-god',0,false,false,'Arma, the Luwian moon-god.'),
 ('ENT_LUW_RUNTIYA','Runtiya','Luwian','God','Stag/tutelary god','the stag; the hunt; the protection of the wild','Anatolian','B','candidate_verified_name','Luwian tutelary god',1,false,false,'Runtiya (Kurunta), the Luwian stag-god of the hunt and tutelary protector.'),
 ('ENT_LUW_SANTA','Santa','Luwian','God','Plague and war god','plague; war; the underworld','Anatolian','B','candidate_verified_name','Luwian god',0,true,false,'Santa, the Luwian god of plague and war, ancestor of the Cilician Sandas.'),
 ('ENT_LUW_IYARRI','Iyarri','Luwian','God','Plague god','plague; the bow; war','Anatolian','B','candidate_verified_name','Luwian/Hittite plague-god',0,false,false,'Iyarri (Yarri), the Hittite-Luwian god of plague and the battlefield bow.'),
 ('ENT_LUW_MALIYA','Maliya','Luwian','Goddess','Goddess of rivers and gardens','rivers; gardens; crafts','Anatolian','B','candidate_verified_name','Luwian goddess',2,false,false,'Maliya, the Luwian goddess of rivers and gardens.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_HTT_SHARRUMA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Religions of Second Millennium Anatolia: Sharruma, son of Teshub and Hepat.'),
 ('ENT_HTT_KUSHUH','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths (the Kumarbi cycle): Kushuh, the Hurrian moon-god.'),
 ('ENT_HTT_SHIMIGE','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths (the Kumarbi cycle): Shimige, the Hurrian sun-god.'),
 ('ENT_HTT_HUTENA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Hutena and Hutellura, the Hurrian fate and birth goddesses.'),
 ('ENT_HTT_ARANZAH','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths (Song of Kumarbi): Aranzah, the deified Tigris.'),
 ('ENT_HTT_SERI_HURRI','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths; Taracha: Seri and Hurri, the bulls of the storm-god.'),
 ('ENT_HTT_HAZZI','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths (Song of Ullikummi): Mount Hazzi, the storm-god''s mountain.'),
 ('ENT_HTT_TASHMISHU','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths (the Kumarbi cycle): Tashmishu, vizier and brother of Teshub.'),
 ('ENT_HTT_MEZZULLA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Mezzulla, daughter of the Sun Goddess of Arinna.'),
 ('ENT_HTT_KAMRUSEPA','SRC_HOFFNER_HITTITE_MYTHS','direct attestation','Hoffner, Hittite Myths (the Telipinu myth): Kamrusepa, goddess of magic who heals the god.'),
 ('ENT_HTT_HALKI','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Halki, the Hittite grain deity.'),
 ('ENT_HTT_WURUNKATTE','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Wurunkatte, the Hattian-Hittite war god.'),
 ('ENT_HTT_LELWANI','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Lelwani, the Hittite deity of the underworld.'),
 ('ENT_HTT_ISTANU','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Istanu, the Hittite sun-god of the day and judge.'),
 ('ENT_LUW_TARHUNZ','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Tarhunz, the Luwian storm-god and chief deity.'),
 ('ENT_LUW_TIWAZ','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Tiwaz, the Luwian sun-god.'),
 ('ENT_LUW_ARMA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Arma, the Luwian moon-god.'),
 ('ENT_LUW_RUNTIYA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Runtiya (Kurunta), the Luwian stag-god.'),
 ('ENT_LUW_SANTA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Santa, the Luwian plague-and-war god.'),
 ('ENT_LUW_IYARRI','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Iyarri, the Hittite-Luwian plague-god.'),
 ('ENT_LUW_MALIYA','SRC_TARACHA_ANATOLIA','scholarly attestation','Taracha, Anatolia: Maliya, the Luwian goddess of rivers and gardens.')
ON CONFLICT DO NOTHING;

-- ── Periods ──────────────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_HTT_EMPIRE', 'A', 'Second-millennium Hittite/Hurrian deity.', 'reviewed'
FROM entities WHERE tradition IN ('Hittite','Hittite/Hurrian')
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=entities.entity_id)
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_LUW_NEO_HITTITE', 'A', 'Luwian Iron Age deity.', 'reviewed'
FROM entities WHERE tradition='Luwian'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=entities.entity_id)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- the Kumarbi cycle and the household of Teshub
 ('ENT_HTT_SHARRUMA','child_of','ENT_HTT_TESHUB','high','Sharruma is the son of Teshub and Hepat.','SRC_TARACHA_ANATOLIA','reviewed'),
 ('ENT_HTT_SHARRUMA','child_of','ENT_HTT_HEPAT','high','Sharruma is the son of Hepat and Teshub.','SRC_TARACHA_ANATOLIA','reviewed'),
 ('ENT_HTT_ARANZAH','child_of','ENT_HTT_KUMARBI','medium','Aranzah (the Tigris) is born of Anu''s seed within Kumarbi (Song of Kumarbi).','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 ('ENT_HTT_TASHMISHU','child_of','ENT_HTT_KUMARBI','medium','Tashmishu is born of Anu''s seed within Kumarbi alongside Teshub.','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 ('ENT_HTT_TASHMISHU','aligned_with','ENT_HTT_TESHUB','high','Tashmishu serves as the brother and vizier of Teshub.','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 ('ENT_HTT_SERI_HURRI','aligned_with','ENT_HTT_TESHUB','high','Seri and Hurri draw the chariot of the storm-god Teshub.','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 ('ENT_HTT_HAZZI','aligned_with','ENT_HTT_TESHUB','high','Mount Hazzi is the holy mountain of Teshub.','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 ('ENT_HTT_KUSHUH','aligned_with','ENT_HTT_SHIMIGE','medium','Kushuh (moon) and Shimige (sun) are the Hurrian astral pair.','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 -- the Hittite cult pantheon
 ('ENT_HTT_KAMRUSEPA','aligned_with','ENT_HTT_TELIPINU','high','Kamrusepa works the magic that calms the wrath of Telipinu.','SRC_HOFFNER_HITTITE_MYTHS','reviewed'),
 ('ENT_HTT_MEZZULLA','child_of','ENT_HTT_ARINNA','high','Mezzulla is the daughter of the Sun Goddess of Arinna.','SRC_TARACHA_ANATOLIA','reviewed'),
 ('ENT_HTT_ISTANU','aligned_with','ENT_HTT_ARINNA','medium','Istanu (the sun-god of the day) stands beside the Sun Goddess of Arinna in the pantheon.','SRC_TARACHA_ANATOLIA','reviewed'),
 ('ENT_HTT_WURUNKATTE','embodies','ENT_WAR','high','Wurunkatte is the deified power of war.','SRC_TARACHA_ANATOLIA','reviewed'),
 -- the Luwian Iron Age pantheon
 ('ENT_LUW_TARHUNZ','aligned_with','ENT_HTT_TARHUNNA','high','Tarhunz is the Luwian form of the storm-god, cognate of the Hittite Tarhunna.','SRC_TARACHA_ANATOLIA','reviewed'),
 ('ENT_LUW_TIWAZ','aligned_with','ENT_LUW_ARMA','medium','Tiwaz (sun) and Arma (moon) are the Luwian astral pair.','SRC_TARACHA_ANATOLIA','reviewed'),
 ('ENT_LUW_SANTA','aligned_with','ENT_LUW_IYARRI','medium','Santa and Iyarri are the Luwian gods of plague and the battlefield.','SRC_TARACHA_ANATOLIA','reviewed')
ON CONFLICT DO NOTHING;

SELECT 'Anatolian (Hittite/Hurrian/Luwian)' AS k,
  count(*) v FROM entities WHERE tradition IN ('Hittite','Hittite/Hurrian','Luwian');
SELECT count(*) AS anat_undated FROM entities e WHERE e.tradition IN ('Hittite','Hittite/Hurrian','Luwian')
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id);

COMMIT;
