-- scripts/deepen_islamic_shia.sql
-- Content deepening (v1.53.0): Islam — the Shi'a Imamate and the remaining angels. The
-- Islamic core was strong (Allah, the archangels, the jinn, Iblis, the eschatological
-- figures, a rich Sufi layer) but Shi'a had only 4 entities and the Prophet Muhammad was
-- missing entirely. This adds the nine missing Twelve Imams, the Prophet, Fatima, the
-- Ahl al-Bayt / Fourteen Infallibles collectives, and the paradise/hell angels. Each to a
-- primary source (the Quran, al-Mufid's Irshad, Ibn Ishaq's Sira, al-Kafi, Sahih al-Bukhari);
-- the Imamate lineage and the holy household wired as typed relationships; all period-linked.

BEGIN;

-- ── New primary sources (Quran, al-Kafi, Nahj al-Balagha, al-Tabari already registered) ──
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_MUFID_IRSHAD','al-Shaykh al-Mufid, Kitab al-Irshad (The Book of Guidance into the Lives of the Twelve Imams), c. 1000 CE','','primary text','The canonical Twelver Shi''a biography of the Twelve Imams'),
('SRC_IBN_ISHAQ_SIRA','Ibn Ishaq, Sirat Rasul Allah (the Life of the Messenger of God), c. 760 CE (recension of Ibn Hisham)','','primary text','The earliest biography of the Prophet Muhammad'),
('SRC_SAHIH_BUKHARI','Sahih al-Bukhari, the canonical Sunni hadith collection, c. 850 CE','','primary text','The foremost Sunni hadith compendium; the angels, paradise and hell in prophetic tradition')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- the Prophet and the Lady of the household
 ('ENT_ISL_MUHAMMAD','Muhammad','Islamic','Prophet','Seal of the Prophets','prophethood; the Quranic revelation; intercession','Islamic','A','candidate_verified_name','The Prophet of Islam',0,false,false,'The Prophet Muhammad, the Seal of the Prophets, recipient of the Quranic revelation.'),
 ('ENT_ISL_FATIMA','Fatima al-Zahra','Islamic/Shi''a','Holy figure','Ahl al-Bayt','the holy household; intercession; "the Radiant"','Shi''a','A','candidate_verified_name','Daughter of the Prophet, mother of the Imams',0,false,false,'Fatima al-Zahra, daughter of the Prophet, wife of Ali, mother of the Imams; "Mistress of the Women of the Worlds."'),
 -- the Twelve Imams not yet present (the 2nd and 4th-11th)
 ('ENT_ISL_HASAN','Hasan ibn Ali','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; forbearance','Shi''a','A','candidate_verified_name','The 2nd Imam',0,false,false,'Hasan ibn Ali, the second Imam, who abdicated the caliphate to Mu''awiya.'),
 ('ENT_ISL_ZAYN_ABIDIN','Ali Zayn al-Abidin','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; devotion; the Sahifa Sajjadiyya','Shi''a','A','candidate_verified_name','The 4th Imam',0,false,false,'Ali Zayn al-Abidin ("Ornament of the Worshippers"), the fourth Imam, survivor of Karbala.'),
 ('ENT_ISL_BAQIR','Muhammad al-Baqir','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; the opening of knowledge','Shi''a','A','candidate_verified_name','The 5th Imam',0,false,false,'Muhammad al-Baqir ("the Splitter-open of Knowledge"), the fifth Imam.'),
 ('ENT_ISL_SADIQ','Ja''far al-Sadiq','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; jurisprudence; transmitted knowledge','Shi''a','A','candidate_verified_name','The 6th Imam',0,false,false,'Ja''far al-Sadiq, the sixth Imam, founder of the Ja''fari school and major transmitter of Shi''a hadith.'),
 ('ENT_ISL_KAZIM','Musa al-Kazim','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; patient endurance','Shi''a','A','candidate_verified_name','The 7th Imam',0,false,false,'Musa al-Kazim ("the Forbearing"), the seventh Imam, who died imprisoned in Baghdad.'),
 ('ENT_ISL_RIDA','Ali al-Rida','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; the shrine of Mashhad','Shi''a','A','candidate_verified_name','The 8th Imam',0,false,false,'Ali al-Rida, the eighth Imam, named heir by al-Ma''mun; his shrine is at Mashhad.'),
 ('ENT_ISL_JAWAD','Muhammad al-Jawad','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; youthful wisdom','Shi''a','B','candidate_verified_name','The 9th Imam',0,false,false,'Muhammad al-Jawad ("the Generous"), the ninth Imam, who succeeded as a child.'),
 ('ENT_ISL_HADI','Ali al-Hadi','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; guidance under surveillance','Shi''a','B','candidate_verified_name','The 10th Imam',0,false,false,'Ali al-Hadi ("the Guide"), the tenth Imam, held under watch at Samarra.'),
 ('ENT_ISL_ASKARI','Hasan al-Askari','Islamic/Shi''a','Imam','Twelve Imams','the Imamate; the father of the Hidden Imam','Shi''a','A','candidate_verified_name','The 11th Imam',0,false,false,'Hasan al-Askari, the eleventh Imam, father of the awaited Mahdi.'),
 -- the holy collectives
 ('ENT_ISL_AHL_BAYT','Ahl al-Bayt','Islamic/Shi''a','Holy collective','The People of the House','the purified household; intercession; walaya','Shi''a','A','candidate_verified_name','The Five of the Cloak (Panjtan)',0,false,false,'The People of the House: the Five of the Cloak (Muhammad, Ali, Fatima, Hasan, Husayn), purified in Quran 33:33.'),
 ('ENT_ISL_INFALLIBLES','The Fourteen Infallibles','Islamic/Shi''a','Holy collective','Ma''sumin','infallibility (isma); the chain of guidance','Shi''a','A','candidate_verified_name','The Ma''sumin',0,false,false,'The Fourteen Infallibles (Ma''sumin): the Prophet, Fatima, and the Twelve Imams.'),
 ('ENT_ISL_IMAMAH','Imamah','Islamic/Shi''a','Doctrine','The Imamate','divinely-appointed leadership; the succession to the Prophet','Shi''a','A','candidate_verified_name','Core Shi''a doctrine',0,false,false,'The Imamate: the doctrine of the divinely-appointed succession of the Imams after the Prophet.'),
 -- the angels of paradise and hell
 ('ENT_ISL_MALIK','Malik','Islamic','Angel','Angel of Hell','the keeping of Hell (Jahannam)','Islamic','A','candidate_verified_name','Keeper of Hell',0,true,false,'Malik, the angel who keeps the Fire (Jahannam), over the guardians of hell.'),
 ('ENT_ISL_RIDWAN','Ridwan','Islamic','Angel','Angel of Paradise','the keeping of Paradise (Janna)','Islamic','B','candidate_verified_name','Keeper of Paradise',0,false,false,'Ridwan, the angel who keeps the gates of Paradise.'),
 ('ENT_ISL_ZABANIYA','Zabaniya','Islamic','Angelic collective','Guardians of Hell','the punishment of the damned','Islamic','A','candidate_verified_name','The wardens of Hell',0,true,false,'The Zabaniya, the stern angels who guard and punish in Hell; the Nineteen over the Fire.'),
 ('ENT_ISL_HAMALAT_ARSH','Hamalat al-Arsh','Islamic','Angelic collective','Bearers of the Throne','the bearing of the divine Throne; praise','Islamic','A','candidate_verified_name','The Throne-bearers',0,false,false,'The Bearers of the Throne, the angels who carry the Throne of God and glorify him.'),
 ('ENT_ISL_HUR','Hur','Islamic','Paradise beings','Houris','the rewards of Paradise','Islamic','A','candidate_verified_name','The maidens of Paradise',0,false,false,'The Hur (houris), the pure companions promised to the blessed in Paradise.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_ISL_MUHAMMAD','SRC_QURAN','direct attestation','Quran 33:40 (the Seal of the Prophets); 48:29; throughout as the Messenger.'),
 ('ENT_ISL_MUHAMMAD','SRC_IBN_ISHAQ_SIRA','direct attestation','Ibn Ishaq, Sirat Rasul Allah: the life of the Prophet.'),
 ('ENT_ISL_FATIMA','SRC_QURAN','direct attestation','Quran 33:33 (the verse of purification, on the Ahl al-Bayt); 3:61 (the mubahala).'),
 ('ENT_ISL_FATIMA','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Fatima al-Zahra, wife of Ali and mother of the Imams.'),
 ('ENT_ISL_HASAN','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: al-Hasan ibn Ali, the second Imam.'),
 ('ENT_ISL_ZAYN_ABIDIN','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Ali Zayn al-Abidin, the fourth Imam.'),
 ('ENT_ISL_BAQIR','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Muhammad al-Baqir, the fifth Imam.'),
 ('ENT_ISL_SADIQ','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Ja''far al-Sadiq, the sixth Imam.'),
 ('ENT_ISL_SADIQ','SRC_KULAYNI_KAFI','direct attestation','al-Kulayni, al-Kafi: Ja''far al-Sadiq as the major transmitter of the Shi''a hadith corpus.'),
 ('ENT_ISL_KAZIM','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Musa al-Kazim, the seventh Imam.'),
 ('ENT_ISL_RIDA','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Ali al-Rida, the eighth Imam.'),
 ('ENT_ISL_JAWAD','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Muhammad al-Jawad, the ninth Imam.'),
 ('ENT_ISL_HADI','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Ali al-Hadi, the tenth Imam.'),
 ('ENT_ISL_ASKARI','SRC_MUFID_IRSHAD','direct attestation','al-Mufid, Irshad: Hasan al-Askari, the eleventh Imam.'),
 ('ENT_ISL_AHL_BAYT','SRC_QURAN','direct attestation','Quran 33:33 (the verse of purification); the hadith of the cloak (Kisa).'),
 ('ENT_ISL_INFALLIBLES','SRC_KULAYNI_KAFI','direct attestation','al-Kulayni, al-Kafi (Kitab al-Hujja): the Prophet, Fatima and the Twelve as the Ma''sumin.'),
 ('ENT_ISL_IMAMAH','SRC_KULAYNI_KAFI','direct attestation','al-Kulayni, al-Kafi (Kitab al-Hujja): the doctrine of the divinely-appointed Imamate.'),
 ('ENT_ISL_MALIK','SRC_QURAN','direct attestation','Quran 43:77: "They will cry, O Malik, let your Lord put an end to us."'),
 ('ENT_ISL_RIDWAN','SRC_SAHIH_BUKHARI','direct attestation','Sahih al-Bukhari (the gates of Paradise); Ridwan named in the tradition as its keeper; cf. Quran 9:21 (ridwan).'),
 ('ENT_ISL_ZABANIYA','SRC_QURAN','direct attestation','Quran 96:18 (the zabaniya); 74:30-31 (the Nineteen over the Fire); 66:6.'),
 ('ENT_ISL_HAMALAT_ARSH','SRC_QURAN','direct attestation','Quran 40:7; 69:17 (the bearers of the Throne who glorify God and seek forgiveness for the believers).'),
 ('ENT_ISL_HUR','SRC_QURAN','direct attestation','Quran 44:54; 52:20; 55:72; 56:22 (the hur al-ayn of Paradise).')
ON CONFLICT DO NOTHING;

-- ── Periods ──────────────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_ISL_EARLY', 'A', 'Early Islamic period (the Prophet, the holy household, the Quranic angels).', 'reviewed'
FROM entities WHERE canonical_name IN
 ('Muhammad','Fatima al-Zahra','Hasan ibn Ali','Ali Zayn al-Abidin','Muhammad al-Baqir',
  'Ahl al-Bayt','The Fourteen Infallibles','Imamah','Malik','Ridwan','Zabaniya','Hamalat al-Arsh','Hur')
  AND tradition LIKE 'Islamic%'
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_ISL_CLASSICAL', 'A', 'Classical Islamic period (the later Imams, 8th-9th c.).', 'reviewed'
FROM entities WHERE canonical_name IN
 ('Ja''far al-Sadiq','Musa al-Kazim','Ali al-Rida','Muhammad al-Jawad','Ali al-Hadi','Hasan al-Askari')
  AND tradition='Islamic/Shi''a'
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 -- the Imamate lineage (each Imam the son of the last)
 ('ENT_ISL_HASAN','child_of','ENT_ISL_ALI','high','Hasan, the 2nd Imam, is the son of Ali.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_ZAYN_ABIDIN','child_of','ENT_ISL_HUSAYN','high','Zayn al-Abidin, the 4th Imam, is the son of Husayn.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_BAQIR','child_of','ENT_ISL_ZAYN_ABIDIN','high','al-Baqir, the 5th Imam, is the son of Zayn al-Abidin.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_SADIQ','child_of','ENT_ISL_BAQIR','high','al-Sadiq, the 6th Imam, is the son of al-Baqir.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_KAZIM','child_of','ENT_ISL_SADIQ','high','al-Kazim, the 7th Imam, is the son of al-Sadiq.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_RIDA','child_of','ENT_ISL_KAZIM','high','al-Rida, the 8th Imam, is the son of al-Kazim.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_JAWAD','child_of','ENT_ISL_RIDA','high','al-Jawad, the 9th Imam, is the son of al-Rida.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_HADI','child_of','ENT_ISL_JAWAD','high','al-Hadi, the 10th Imam, is the son of al-Jawad.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_ASKARI','child_of','ENT_ISL_HADI','high','al-Askari, the 11th Imam, is the son of al-Hadi.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_MAHDI','child_of','ENT_ISL_ASKARI','high','the Mahdi, the 12th Imam, is the son of al-Askari.','SRC_MUFID_IRSHAD','reviewed'),
 -- the holy household
 ('ENT_ISL_FATIMA','child_of','ENT_ISL_MUHAMMAD','high','Fatima is the daughter of the Prophet.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_FATIMA','consort_of','ENT_ISL_ALI','high','Fatima is the wife of Ali.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_FATIMA','parent_of','ENT_ISL_HASAN','high','Fatima is the mother of Hasan.','SRC_MUFID_IRSHAD','reviewed'),
 ('ENT_ISL_FATIMA','parent_of','ENT_ISL_HUSAYN','high','Fatima is the mother of Husayn.','SRC_MUFID_IRSHAD','reviewed'),
 -- the Panjtan (Five of the Cloak) as members of the Ahl al-Bayt
 ('ENT_ISL_MUHAMMAD','member_of','ENT_ISL_AHL_BAYT','high','The Prophet heads the Five of the Cloak.','SRC_QURAN','reviewed'),
 ('ENT_ISL_ALI','member_of','ENT_ISL_AHL_BAYT','high','Ali is one of the Five of the Cloak.','SRC_QURAN','reviewed'),
 ('ENT_ISL_FATIMA','member_of','ENT_ISL_AHL_BAYT','high','Fatima is one of the Five of the Cloak.','SRC_QURAN','reviewed'),
 ('ENT_ISL_HASAN','member_of','ENT_ISL_AHL_BAYT','high','Hasan is one of the Five of the Cloak.','SRC_QURAN','reviewed'),
 ('ENT_ISL_HUSAYN','member_of','ENT_ISL_AHL_BAYT','high','Husayn is one of the Five of the Cloak.','SRC_QURAN','reviewed'),
 -- the Fourteen Infallibles
 ('ENT_ISL_MUHAMMAD','member_of','ENT_ISL_INFALLIBLES','high','The Prophet is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_FATIMA','member_of','ENT_ISL_INFALLIBLES','high','Fatima is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_ALI','member_of','ENT_ISL_INFALLIBLES','high','Ali is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_HASAN','member_of','ENT_ISL_INFALLIBLES','high','Hasan is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_HUSAYN','member_of','ENT_ISL_INFALLIBLES','high','Husayn is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_ZAYN_ABIDIN','member_of','ENT_ISL_INFALLIBLES','high','Zayn al-Abidin is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_BAQIR','member_of','ENT_ISL_INFALLIBLES','high','al-Baqir is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_SADIQ','member_of','ENT_ISL_INFALLIBLES','high','al-Sadiq is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_KAZIM','member_of','ENT_ISL_INFALLIBLES','high','al-Kazim is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_RIDA','member_of','ENT_ISL_INFALLIBLES','high','al-Rida is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_JAWAD','member_of','ENT_ISL_INFALLIBLES','high','al-Jawad is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_HADI','member_of','ENT_ISL_INFALLIBLES','high','al-Hadi is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_ASKARI','member_of','ENT_ISL_INFALLIBLES','high','al-Askari is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_MAHDI','member_of','ENT_ISL_INFALLIBLES','high','the Mahdi is one of the Fourteen Infallibles.','SRC_KULAYNI_KAFI','reviewed'),
 -- doctrine and angels
 ('ENT_ISL_IMAMAH','aligned_with','ENT_WALAYA','high','The Imamate (imamah) and walaya are the paired core doctrines of Shi''a Islam.','SRC_KULAYNI_KAFI','reviewed'),
 ('ENT_ISL_MALIK','rules','ENT_ISL_ZABANIYA','high','Malik commands the Zabaniya, the wardens of Hell.','SRC_QURAN','reviewed'),
 ('ENT_ISL_RIDWAN','paired_with','ENT_ISL_MALIK','medium','Ridwan (keeper of Paradise) and Malik (keeper of Hell) are the two gate-angels.','SRC_SAHIH_BUKHARI','reviewed'),
 ('ENT_ISL_HUR','aligned_with','ENT_ISL_RIDWAN','medium','The houris dwell in the Paradise kept by Ridwan.','SRC_QURAN','reviewed'),
 ('ENT_ISL_HAMALAT_ARSH','aligned_with','ENT_ISL_ALLAH','high','The Throne-bearers carry the Throne of God and glorify him.','SRC_QURAN','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Islamic (all)' AS k, count(*) v FROM entities WHERE tradition LIKE 'Islamic%'
UNION ALL SELECT 'Islamic/Shi''a', count(*) FROM entities WHERE tradition='Islamic/Shi''a';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS undated FROM entities e WHERE e.tradition LIKE 'Islamic%' AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
