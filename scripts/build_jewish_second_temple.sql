-- scripts/build_jewish_second_temple.sql
-- Content normalization II (v1.44.0): Jewish Second Temple build-out. Deepens the
-- apocalyptic angelology and demonology (1 Enoch, Jubilees, Tobit, the Dead Sea
-- Scrolls, Daniel) toward solid canonical depth, balancing the Gnostic over-weighting.
-- Notable additions: Asmodeus (was missing entirely), the full 1QS "Two Spirits"
-- dualism (a direct structural parallel to the Zoroastrian Spenta/Angra Mainyu axis),
-- named Watcher-chiefs and giants (cross-linking the Manichaean Book of Giants), and
-- the Danielic heavenly figures. Every entity to a primary locus; relationships wired.

BEGIN;

-- ── New Second Temple primary sources (1 Enoch, Jubilees, Tobit already present) ─
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_DSS_COMMUNITY_RULE','The Community Rule (Serekh ha-Yahad, 1QS), Dead Sea Scrolls, c. 100 BCE','','primary text','The Qumran sectarian rule, incl. the Treatise of the Two Spirits (1QS 3:13-4:26)'),
('SRC_DSS_MELCHIZEDEK','11QMelchizedek (11Q13), Dead Sea Scrolls, c. 1st c. BCE','','primary text','The Qumran midrash on Melchizedek as the heavenly eschatological deliverer'),
('SRC_DSS_WAR_SCROLL','The War Scroll (Milhamah, 1QM), Dead Sea Scrolls, c. 1st c. BCE','','primary text','The eschatological war of the Sons of Light and the Sons of Darkness'),
('SRC_DSS_BOOK_OF_GIANTS','The Book of Giants (4Q203, 1Q23 etc.), Dead Sea Scrolls; also the Manichaean Book of Giants','','primary text','The Enochic narrative of the Watchers'' giant offspring; later adopted by Mani'),
('SRC_2_ENOCH','2 Enoch (the Slavonic Apocalypse of Enoch), c. 1st c. CE','','primary text','The Slavonic apocalypse of Enoch''s ascent through the heavens')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_ISR_ASMODEUS','Asmodeus','Israelite/Second Temple','Demon','Demon','lust; jealousy; the slaying of bridegrooms','Jewish','A','candidate_verified_name','Named demon (Tobit)',0,true,false,'The demon Ashmedai who slew Sarah''s seven husbands, bound by Raphael in Egypt.'),
 ('ENT_ISR_PRINCE_LIGHT','Prince of Light','Israelite/Second Temple','Angel','Angelic prince','light; truth; the rule of the Sons of Light','Jewish','A','candidate_verified_name','Qumran angelic prince',0,false,false,'The sar ha-or who rules the children of righteousness; identified with Michael.'),
 ('ENT_ISR_ANGEL_DARKNESS','Angel of Darkness','Israelite/Second Temple','Adversarial being','Angelic adversary','darkness; deceit; the rule of the Sons of Darkness','Jewish','A','candidate_verified_name','Qumran adversary',0,true,false,'The mal''akh hoshekh who rules the children of deceit; identified with Belial.'),
 ('ENT_ISR_SPIRIT_TRUTH','Spirit of Truth','Israelite/Second Temple','Spirit','Cosmic spirit','truth; uprightness; the way of light','Jewish','A','candidate_verified_name','Qumran cosmic spirit',0,false,false,'The ruach emet that guides the heart toward righteousness (1QS Two Spirits).'),
 ('ENT_ISR_SPIRIT_DECEIT','Spirit of Deceit','Israelite/Second Temple','Spirit','Cosmic spirit','falsehood; perversity; the way of darkness','Jewish','A','candidate_verified_name','Qumran cosmic spirit',0,true,false,'The ruach avel that leads the heart into wickedness (1QS Two Spirits).'),
 ('ENT_ISR_MELCHIZEDEK','Melchizedek (Heavenly)','Israelite/Second Temple','Heavenly redeemer','Eschatological judge','heavenly judgment; liberty; the defeat of Belial','Jewish','A','candidate_verified_name','Heavenly redeemer (11Q13)',0,false,false,'The exalted heavenly Melchizedek (elohim) who proclaims liberty and judges Belial.'),
 ('ENT_ISR_KOKABIEL','Kokabiel','Israelite/Second Temple','Fallen angel','Watcher-chief','the stars; forbidden astrology','Jewish','A','candidate_verified_name','Named Watcher',0,false,false,'A chief of the Watchers who taught humankind the constellations.'),
 ('ENT_ISR_BARAQIEL','Baraqiel','Israelite/Second Temple','Fallen angel','Watcher-chief','lightning; astrology of the air','Jewish','A','candidate_verified_name','Named Watcher',0,false,false,'A chief of the Watchers who taught the signs of the lightnings.'),
 ('ENT_ISR_PENEMUE','Penemue','Israelite/Second Temple','Fallen angel','Watcher-chief','writing; ink and paper; bitter knowledge','Jewish','A','candidate_verified_name','Named Watcher',0,false,false,'The Watcher who taught humankind writing with ink and paper (1 Enoch 69).'),
 ('ENT_ISR_GADREEL','Gadreel','Israelite/Second Temple','Fallen angel','Watcher-chief','weapons of war; the leading astray of Eve','Jewish','A','candidate_verified_name','Named Watcher',0,false,false,'The Watcher who showed the weapons of death and led Eve astray (1 Enoch 69).'),
 ('ENT_ISR_OHYAH','Ohyah','Israelite/Second Temple','Giant','Nephil','the giants; violence; prophetic dreams','Jewish','A','candidate_verified_name','Named giant (Book of Giants)',1,false,false,'A son of Shemihazah and a leading giant of the Book of Giants; also in Mani''s recension.'),
 ('ENT_ISR_HAHYAH','Hahyah','Israelite/Second Temple','Giant','Nephil','the giants; the dream of the coming flood','Jewish','A','candidate_verified_name','Named giant (Book of Giants)',1,false,false,'A son of Shemihazah, brother of Ohyah, who dreams of the destroying flood.'),
 ('ENT_ISR_MAHAWAY','Mahaway','Israelite/Second Temple','Giant','Nephil','the giants; the messenger flight to Enoch','Jewish','A','candidate_verified_name','Named giant (Book of Giants)',1,false,false,'The giant son of the Watcher Baraqel, sent to Enoch to interpret the dreams.'),
 ('ENT_ISR_PHANUEL','Phanuel','Israelite/Second Temple','Archangel','Angel of the Presence','repentance; hope; warding off the satans','Jewish','A','candidate_verified_name','Archangel (1 Enoch)',0,false,false,'The fourth presence-angel, set over repentance and the hope of eternal life.'),
 ('ENT_ISR_SARAQAEL','Saraqael','Israelite/Second Temple','Archangel','Holy watcher','the spirits of erring souls','Jewish','A','candidate_verified_name','Archangel (1 Enoch 20)',0,false,false,'One of the seven holy angels, set over the spirits who sin in the spirit.'),
 ('ENT_ISR_ANGEL_PRESENCE','Angel of the Presence','Israelite/Second Temple','Angel','Angel of the Face','the heavenly tablets; revelation to Moses','Jewish','A','candidate_verified_name','Angel of the Face (Jubilees)',0,false,false,'The Angel of the Presence who dictates the heavenly tablets to Moses on Sinai.'),
 ('ENT_ISR_PRINCES_NATIONS','Princes of the Nations','Israelite/Second Temple','Angelic collective','National guardian angels','the seventy nations; angelic patronage of empires','Jewish','A','candidate_verified_name','The sarim of Daniel',0,false,false,'The angelic princes of the nations (e.g. the Prince of Persia, the Prince of Greece) opposed by Michael.'),
 ('ENT_ISR_SON_OF_MAN','Son of Man','Israelite/Second Temple','Eschatological figure','Heavenly deliverer','dominion; judgment; the heavenly kingdom','Jewish','A','candidate_verified_name','Danielic/Enochic heavenly figure',0,false,false,'The "one like a son of man" given everlasting dominion; the Elect One of the Parables of Enoch.'),
 ('ENT_ISR_ANCIENT_OF_DAYS','Ancient of Days','Israelite/Second Temple','Divine title/form','Theophanic form','the heavenly throne; the books of judgment','Jewish','A','candidate_verified_name','Theophanic form of God',0,false,false,'The white-haired enthroned God of Daniel''s vision, before whom the books are opened.'),
 ('ENT_ISR_RAHAB','Rahab','Israelite/Second Temple','Chaos monster','Sea-dragon','the chaotic sea; primordial rebellion','Jewish','A','candidate_verified_name','Chaos monster',0,true,true,'The sea-dragon of chaos crushed by Yahweh; a doublet of Leviathan.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_ISR_ASMODEUS','SRC_TOBIT','Direct attestation','Tobit 3:8, 17; 8:3: Asmodeus slays Sarah''s seven husbands and is bound by Raphael in Egypt.'),
 ('ENT_ISR_PRINCE_LIGHT','SRC_DSS_COMMUNITY_RULE','Direct attestation','1QS 3:20; CD 5:18: the Prince of Light rules the children of righteousness.'),
 ('ENT_ISR_ANGEL_DARKNESS','SRC_DSS_COMMUNITY_RULE','Direct attestation','1QS 3:20-21: the Angel of Darkness rules the children of deceit and leads them astray.'),
 ('ENT_ISR_SPIRIT_TRUTH','SRC_DSS_COMMUNITY_RULE','Direct attestation','1QS 3:18-19; 4:23-26: the spirit of truth, one of the two spirits set in humankind.'),
 ('ENT_ISR_SPIRIT_DECEIT','SRC_DSS_COMMUNITY_RULE','Direct attestation','1QS 3:18-19; 4:9-11: the spirit of deceit/perversity, the second of the two spirits.'),
 ('ENT_ISR_MELCHIZEDEK','SRC_DSS_MELCHIZEDEK','Direct attestation','11Q13 (11QMelch): Melchizedek as the heavenly elohim who proclaims liberty and executes judgment on Belial.'),
 ('ENT_ISR_KOKABIEL','SRC_1_ENOCH','Direct attestation','1 Enoch 8:3: Kokabiel taught the constellations (one of the chiefs of 1 Enoch 6:7).'),
 ('ENT_ISR_BARAQIEL','SRC_1_ENOCH','Direct attestation','1 Enoch 8:3: Baraqiel taught the signs of the lightnings.'),
 ('ENT_ISR_PENEMUE','SRC_1_ENOCH','Direct attestation','1 Enoch 69:8-11: Penemue taught humankind writing with ink and paper.'),
 ('ENT_ISR_GADREEL','SRC_1_ENOCH','Direct attestation','1 Enoch 69:6: Gadreel led Eve astray and showed the weapons of death.'),
 ('ENT_ISR_OHYAH','SRC_DSS_BOOK_OF_GIANTS','Direct attestation','The Book of Giants (4Q203, 6Q8): Ohyah, son of Shemihazah, a leading giant; also in Mani''s recension.'),
 ('ENT_ISR_HAHYAH','SRC_DSS_BOOK_OF_GIANTS','Direct attestation','The Book of Giants (4Q530): Hahyah, brother of Ohyah, who dreams of the destroying flood.'),
 ('ENT_ISR_MAHAWAY','SRC_DSS_BOOK_OF_GIANTS','Direct attestation','The Book of Giants (4Q530, 4Q203): Mahaway, son of the Watcher Baraqel, sent to Enoch.'),
 ('ENT_ISR_PHANUEL','SRC_1_ENOCH','Direct attestation','1 Enoch 40:9; 54:6: Phanuel, set over repentance, who fends off the satans.'),
 ('ENT_ISR_SARAQAEL','SRC_1_ENOCH','Direct attestation','1 Enoch 20:6: Saraqael, one of the seven holy angels, over the spirits who sin.'),
 ('ENT_ISR_ANGEL_PRESENCE','SRC_JUBILEES','Direct attestation','Jubilees 1:27-29; 2:1: the Angel of the Presence dictates the heavenly tablets to Moses.'),
 ('ENT_ISR_PRINCES_NATIONS','SRC_HEBREW_BIBLE','Direct attestation','Daniel 10:13, 20-21: the Prince of Persia and the Prince of Greece, against whom Michael stands.'),
 ('ENT_ISR_SON_OF_MAN','SRC_HEBREW_BIBLE','Direct attestation','Daniel 7:13-14: "one like a son of man" given everlasting dominion.'),
 ('ENT_ISR_SON_OF_MAN','SRC_1_ENOCH','Direct attestation','1 Enoch 46-48 (the Parables): the Son of Man / Elect One who sits on the throne of glory.'),
 ('ENT_ISR_ANCIENT_OF_DAYS','SRC_HEBREW_BIBLE','Direct attestation','Daniel 7:9-10, 22: the Ancient of Days enthroned, before whom the books are opened.'),
 ('ENT_ISR_RAHAB','SRC_HEBREW_BIBLE','Direct attestation','Job 26:12; Psalm 89:10; Isaiah 51:9: Rahab, the sea-dragon of chaos crushed by Yahweh.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_ISR_ASMODEUS','imprisoned_by','ENT_ISR_RAPHAEL','high','Raphael binds Asmodeus in Egypt (Tobit 8:3).','SRC_TOBIT','reviewed'),
 ('ENT_ISR_PRINCE_LIGHT','identified_with','ENT_ISR_MICHAEL','medium','The Prince of Light is widely identified with Michael in the Scrolls.','SRC_DSS_COMMUNITY_RULE','reviewed'),
 ('ENT_ISR_PRINCE_LIGHT','opposes','ENT_ISR_ANGEL_DARKNESS','high','The two princes rule the lots of light and darkness (1QS 3-4).','SRC_DSS_COMMUNITY_RULE','reviewed'),
 ('ENT_ISR_ANGEL_DARKNESS','identified_with','ENT_ISR_BELIAL','medium','The Angel of Darkness is identified with Belial in the sectarian texts.','SRC_DSS_COMMUNITY_RULE','reviewed'),
 ('ENT_ISR_SPIRIT_TRUTH','opposes','ENT_ISR_SPIRIT_DECEIT','high','The two spirits struggle in the heart of humankind (1QS 4).','SRC_DSS_COMMUNITY_RULE','reviewed'),
 ('ENT_ISR_PRINCE_LIGHT','presides_over','ENT_ISR_SPIRIT_TRUTH','medium','The Prince of Light governs the way of the spirit of truth.','SRC_DSS_COMMUNITY_RULE','reviewed'),
 ('ENT_ISR_ANGEL_DARKNESS','presides_over','ENT_ISR_SPIRIT_DECEIT','medium','The Angel of Darkness governs the way of the spirit of deceit.','SRC_DSS_COMMUNITY_RULE','reviewed'),
 ('ENT_ISR_MELCHIZEDEK','opposes','ENT_ISR_BELIAL','high','Melchizedek executes the judgment of God upon Belial and his spirits (11Q13).','SRC_DSS_MELCHIZEDEK','reviewed'),
 ('ENT_ISR_KOKABIEL','member_of','ENT_ISR_WATCHERS','high','Kokabiel is one of the chiefs of the Watchers (1 Enoch 6-8).','SRC_1_ENOCH','reviewed'),
 ('ENT_ISR_BARAQIEL','member_of','ENT_ISR_WATCHERS','high','Baraqiel is one of the chiefs of the Watchers (1 Enoch 6-8).','SRC_1_ENOCH','reviewed'),
 ('ENT_ISR_PENEMUE','member_of','ENT_ISR_WATCHERS','high','Penemue is among the Watchers who taught forbidden arts (1 Enoch 69).','SRC_1_ENOCH','reviewed'),
 ('ENT_ISR_GADREEL','member_of','ENT_ISR_WATCHERS','high','Gadreel is among the Watchers who taught forbidden arts (1 Enoch 69).','SRC_1_ENOCH','reviewed'),
 ('ENT_ISR_OHYAH','child_of','ENT_ISR_SHEMIHAZAH','high','Ohyah is a son of the Watcher-chief Shemihazah (Book of Giants).','SRC_DSS_BOOK_OF_GIANTS','reviewed'),
 ('ENT_ISR_HAHYAH','child_of','ENT_ISR_SHEMIHAZAH','high','Hahyah is a son of Shemihazah, brother of Ohyah (Book of Giants).','SRC_DSS_BOOK_OF_GIANTS','reviewed'),
 ('ENT_ISR_MAHAWAY','child_of','ENT_ISR_BARAQIEL','medium','Mahaway is the giant son of the Watcher Baraqel/Baraqiel (Book of Giants).','SRC_DSS_BOOK_OF_GIANTS','reviewed'),
 ('ENT_ISR_OHYAH','member_of','ENT_ISR_NEPHILIM','high','The giants of the Book of Giants are the Nephilim.','SRC_DSS_BOOK_OF_GIANTS','reviewed'),
 ('ENT_ISR_HAHYAH','member_of','ENT_ISR_NEPHILIM','high','The giants of the Book of Giants are the Nephilim.','SRC_DSS_BOOK_OF_GIANTS','reviewed'),
 ('ENT_ISR_MAHAWAY','member_of','ENT_ISR_NEPHILIM','high','The giants of the Book of Giants are the Nephilim.','SRC_DSS_BOOK_OF_GIANTS','reviewed'),
 ('ENT_ISR_PHANUEL','aligned_with','ENT_ISR_MICHAEL','medium','Phanuel stands among the four/seven presence-archangels with Michael.','SRC_1_ENOCH','reviewed'),
 ('ENT_ISR_SARAQAEL','aligned_with','ENT_ISR_MICHAEL','medium','Saraqael is one of the seven holy angels alongside Michael (1 Enoch 20).','SRC_1_ENOCH','reviewed'),
 ('ENT_ISR_ANGEL_PRESENCE','aligned_with','ENT_ISR_YAHWEH','high','The Angel of the Presence serves before God and speaks for him (Jubilees).','SRC_JUBILEES','reviewed'),
 ('ENT_ISR_MICHAEL','opposes','ENT_ISR_PRINCES_NATIONS','high','Michael, prince of Israel, stands against the angelic princes of the nations (Daniel 10).','SRC_HEBREW_BIBLE','reviewed'),
 ('ENT_ISR_SON_OF_MAN','aligned_with','ENT_ISR_ANCIENT_OF_DAYS','high','The Son of Man is presented before the Ancient of Days and given dominion (Daniel 7).','SRC_HEBREW_BIBLE','reviewed'),
 ('ENT_ISR_ANCIENT_OF_DAYS','cult_form_of','ENT_ISR_YAHWEH','high','The Ancient of Days is a theophanic form of the God of Israel.','SRC_HEBREW_BIBLE','reviewed'),
 ('ENT_ISR_RAHAB','slain_by','ENT_ISR_YAHWEH','high','Yahweh crushes Rahab, the sea-dragon of chaos (Psalm 89:10; Isaiah 51:9).','SRC_HEBREW_BIBLE','reviewed')
ON CONFLICT DO NOTHING;

-- ── Duplicate-name discipline: Asmodeus now collides with the existing late-antique
--    ritual/Solomonic Asmodeus. Register both as intentionally distinct and wire the
--    reception (the ritual demon descends from the Second Temple demon of Tobit). ──
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Asmodeus','ENT_ISR_ASMODEUS','Reviewed duplicate canonical name; the Second Temple demon of Tobit, distinct from the later late-antique ritual/Solomonic Asmodeus.','intentional_distinct'),
 ('Asmodeus','ENT_LAT_ASMODEUS','Reviewed duplicate canonical name; the late-antique ritual/Solomonic Asmodeus, a reception of the Second Temple demon of Tobit.','intentional_distinct')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_LAT_ASMODEUS','reception_of','ENT_ISR_ASMODEUS','high','The late-antique ritual/Solomonic Asmodeus develops from the Second Temple demon first named in Tobit.','SRC_TOBIT','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Israelite/Second Temple entities' AS label, count(*) FROM entities WHERE tradition='Israelite/Second Temple';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT count(*) AS dup_pairs FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;
SELECT * FROM v_release_metrics;

COMMIT;
