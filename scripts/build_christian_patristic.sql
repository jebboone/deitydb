-- scripts/build_christian_patristic.sql
-- Content normalization VII (v1.49.0): Christian/patristic build-out. The DB had the
-- saints, the nine angelic orders and the Devil, but lacked the divine persons of the
-- Trinity, the apocalyptic cast of Revelation, the Gospel demons, and the great martyrs
-- of the patristic age. This fills those in (Christian family 45 -> 65), each to a primary
-- source (the New Testament, the early martyr-acts, the Golden Legend, the Nicene Creed).

BEGIN;

-- ── New patristic sources (NT, Golden Legend, Augustine already registered) ──
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_NICENE_CREED','The Nicene-Constantinopolitan Creed, 325/381 CE','','primary text','The conciliar creed defining the Father, Son and Holy Spirit'),
('SRC_PASSIO_PERPETUA','The Passion of Perpetua and Felicity (Passio Perpetuae et Felicitatis), c. 203 CE','','primary text','The prison diary and martyrdom of the African martyrs Perpetua and Felicity'),
('SRC_ACTS_PAUL_THECLA','The Acts of Paul and Thecla, c. 2nd c. CE','','primary text','The apocryphal acts of Thecla, disciple of Paul'),
('SRC_SULPICIUS_VITA_MARTINI','Sulpicius Severus, Life of St Martin (Vita Martini), c. 397 CE','','primary text','The founding hagiography of Martin of Tours')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- the divine persons
 ('ENT_CHR_GOD_FATHER','God the Father','Christian','Divine person','The Trinity','creation; fatherhood; the Godhead','Christian','A','candidate_verified_name','First person of the Trinity',0,false,false,'God the Father, the first person of the Trinity, creator of all things.'),
 ('ENT_CHR_HOLY_SPIRIT','Holy Spirit','Christian','Divine person','The Trinity','sanctification; inspiration; the Paraclete','Christian','A','candidate_verified_name','Third person of the Trinity',0,false,false,'The Holy Spirit, the third person of the Trinity, the Paraclete who proceeds from the Father.'),
 -- the apocalyptic cast of Revelation
 ('ENT_CHR_BEAST','Beast of Revelation','Christian/Biblical','Apocalyptic monster','Eschatological adversary','blasphemous empire; the number 666','Christian','A','candidate_verified_name','Apocalyptic figure',0,true,false,'The seven-headed beast from the sea, who bears the number 666 (Revelation 13).'),
 ('ENT_CHR_FALSE_PROPHET','False Prophet','Christian/Biblical','Apocalyptic figure','Eschatological deceiver','false signs; the worship of the Beast','Christian','A','candidate_verified_name','Apocalyptic figure',0,false,false,'The second beast from the earth, who deceives the world into worshipping the first Beast.'),
 ('ENT_CHR_WHORE_BABYLON','Whore of Babylon','Christian/Biblical','Apocalyptic figure','Eschatological symbol','the great city; idolatry; persecution','Christian','A','candidate_verified_name','Apocalyptic figure',0,false,false,'Babylon the Great, the scarlet woman drunk on the blood of the saints (Revelation 17).'),
 ('ENT_CHR_FOUR_HORSEMEN','Four Horsemen','Christian/Biblical','Apocalyptic collective','Eschatological riders','conquest; war; famine; death','Christian','A','candidate_verified_name','Apocalyptic collective',0,false,false,'The four riders of the seals: Conquest, War, Famine and Death (Revelation 6).'),
 -- the Gospel demons
 ('ENT_CHR_BEELZEBUL','Beelzebul','Christian','Demon','Prince of demons','demonic rule; possession','Christian','A','candidate_verified_name','Named demon (Gospels)',0,true,false,'Beelzebul, "the prince of demons," named by Jesus'' opponents and identified with Satan.'),
 ('ENT_CHR_MAMMON','Mammon','Christian','Demon','Personified wealth','riches; avarice; the rival of God','Christian','A','candidate_verified_name','Personified wealth (Gospels)',0,false,false,'Mammon, wealth personified as a master who cannot be served alongside God.'),
 ('ENT_CHR_LEGION','Legion','Christian','Demon collective','Possessing demons','possession; multitude','Christian','A','candidate_verified_name','Named demons (Gospels)',0,true,false,'"My name is Legion, for we are many" — the host of demons cast into the swine (Mark 5).'),
 -- the great martyrs and patristic saints
 ('ENT_CHR_STEPHEN','Stephen','Christian','Saint','Protomartyr','the first martyrdom; the diaconate','Christian','A','candidate_verified_name','Protomartyr',0,false,false,'The protomartyr Stephen, the first Christian martyr, stoned while seeing the Son of Man.'),
 ('ENT_CHR_PERPETUA','Perpetua and Felicity','Christian','Saint','Martyrs','martyrdom; visionary courage','Christian','A','candidate_verified_name','Patristic martyrs',0,false,false,'The African martyrs Perpetua and Felicity, whose prison visions are recorded in their Passio.'),
 ('ENT_CHR_THECLA','Thecla','Christian','Saint','Proto-martyr / apostle','virginity; preaching; the disciple of Paul','Christian','A','candidate_verified_name','Apostolic-age saint',0,false,false,'Thecla, the virgin disciple of Paul, venerated as a proto-martyr and equal-to-the-apostles.'),
 ('ENT_CHR_LAWRENCE','Lawrence','Christian','Saint','Martyr-deacon','the diaconate; charity; the gridiron','Christian','A','candidate_verified_name','Roman martyr',0,false,false,'The deacon Lawrence of Rome, martyred on the gridiron, patron of the poor.'),
 ('ENT_CHR_SEBASTIAN','Sebastian','Christian','Saint','Martyr','protection from plague; the arrows','Christian','A','candidate_verified_name','Plague-saint martyr',0,false,false,'The soldier-martyr Sebastian, shot with arrows, invoked against plague.'),
 ('ENT_CHR_AGNES','Agnes','Christian','Saint','Virgin-martyr','virginity; chastity','Christian','A','candidate_verified_name','Roman virgin-martyr',0,false,false,'The young Roman virgin-martyr Agnes, celebrated by Ambrose and Prudentius.'),
 ('ENT_CHR_CECILIA','Cecilia','Christian','Saint','Virgin-martyr','music; virginity','Christian','A','candidate_verified_name','Roman virgin-martyr',0,false,false,'The Roman virgin-martyr Cecilia, patron of music and musicians.'),
 ('ENT_CHR_CHRISTOPHER','Christopher','Christian','Saint','Helper-saint','travellers; protection from sudden death','Christian','A','candidate_verified_name','Universal helper-saint',0,false,false,'The giant Christopher who bore the Christ-child across the river, patron of travellers.'),
 ('ENT_CHR_BARBARA','Barbara','Christian','Saint','Helper-saint','protection from lightning and sudden death','Christian','A','candidate_verified_name','One of the Fourteen Holy Helpers',0,false,false,'The virgin-martyr Barbara, invoked against lightning and sudden death.'),
 ('ENT_CHR_MARGARET','Margaret of Antioch','Christian','Saint','Helper-saint','childbirth; deliverance from the dragon','Christian','A','candidate_verified_name','One of the Fourteen Holy Helpers',0,false,false,'The virgin-martyr Margaret, who burst from the dragon''s belly, patroness of childbirth.'),
 ('ENT_CHR_MARTIN','Martin of Tours','Christian','Saint','Confessor-bishop','charity; the cloak; Western monasticism','Christian','A','candidate_verified_name','Patristic confessor-bishop',0,false,false,'Martin of Tours, the soldier who shared his cloak, founder of Gaulish monasticism.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_CHR_GOD_FATHER','SRC_NICENE_CREED','Direct attestation','The Nicene Creed: "We believe in one God, the Father Almighty, maker of heaven and earth."'),
 ('ENT_CHR_GOD_FATHER','SRC_NEW_TESTAMENT','Direct attestation','Matthew 6:9; John 17: the Father to whom Jesus prays and whom he reveals.'),
 ('ENT_CHR_HOLY_SPIRIT','SRC_NICENE_CREED','Direct attestation','The Nicene Creed: "the Holy Spirit, the Lord and giver of life, who proceeds from the Father."'),
 ('ENT_CHR_HOLY_SPIRIT','SRC_NEW_TESTAMENT','Direct attestation','John 14:16-26; Acts 2: the Paraclete sent at Pentecost.'),
 ('ENT_CHR_BEAST','SRC_NEW_TESTAMENT','Direct attestation','Revelation 13:1-10: the seven-headed beast from the sea, with the number 666.'),
 ('ENT_CHR_FALSE_PROPHET','SRC_NEW_TESTAMENT','Direct attestation','Revelation 13:11-18; 16:13; 19:20: the second beast / False Prophet.'),
 ('ENT_CHR_WHORE_BABYLON','SRC_NEW_TESTAMENT','Direct attestation','Revelation 17-18: Babylon the Great, the woman on the scarlet beast.'),
 ('ENT_CHR_FOUR_HORSEMEN','SRC_NEW_TESTAMENT','Direct attestation','Revelation 6:1-8: the four riders of the first four seals.'),
 ('ENT_CHR_BEELZEBUL','SRC_NEW_TESTAMENT','Direct attestation','Mark 3:22; Matthew 12:24-27; Luke 11:15-19: Beelzebul, the prince of demons.'),
 ('ENT_CHR_MAMMON','SRC_NEW_TESTAMENT','Direct attestation','Matthew 6:24; Luke 16:9-13: "You cannot serve God and Mammon."'),
 ('ENT_CHR_LEGION','SRC_NEW_TESTAMENT','Direct attestation','Mark 5:1-20; Luke 8:26-39: the Gerasene demoniac and the demons named Legion.'),
 ('ENT_CHR_STEPHEN','SRC_NEW_TESTAMENT','Direct attestation','Acts 6-7: Stephen, the first martyr, stoned after his vision of the Son of Man.'),
 ('ENT_CHR_PERPETUA','SRC_PASSIO_PERPETUA','Direct attestation','The Passion of Perpetua and Felicity (c. 203): their imprisonment, visions and martyrdom at Carthage.'),
 ('ENT_CHR_THECLA','SRC_ACTS_PAUL_THECLA','Direct attestation','The Acts of Paul and Thecla: Thecla, the virgin disciple who follows Paul and survives the beasts.'),
 ('ENT_CHR_LAWRENCE','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend: Lawrence the deacon, martyred on the gridiron.'),
 ('ENT_CHR_SEBASTIAN','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend: Sebastian, shot with arrows and invoked against plague.'),
 ('ENT_CHR_AGNES','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend; Ambrose, De Virginibus: Agnes, the young Roman virgin-martyr.'),
 ('ENT_CHR_CECILIA','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend: Cecilia, virgin-martyr and patron of music.'),
 ('ENT_CHR_CHRISTOPHER','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend: Christopher, the Christ-bearer, patron of travellers.'),
 ('ENT_CHR_BARBARA','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend: Barbara, invoked against lightning and sudden death.'),
 ('ENT_CHR_MARGARET','SRC_GOLDEN_LEGEND','Direct attestation','The Golden Legend: Margaret of Antioch and the dragon, patroness of childbirth.'),
 ('ENT_CHR_MARTIN','SRC_SULPICIUS_VITA_MARTINI','Direct attestation','Sulpicius Severus, Life of St Martin: the cloak, the miracles, and Gaulish monasticism.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_CHR_GOD_FATHER','parent_of','ENT_JESUS_CHRIST','high','God the Father is the Father of the Son, Jesus Christ.','SRC_NICENE_CREED','reviewed'),
 ('ENT_CHR_HOLY_SPIRIT','emanates_from','ENT_CHR_GOD_FATHER','high','The Holy Spirit proceeds from the Father (Nicene Creed).','SRC_NICENE_CREED','reviewed'),
 ('ENT_CHR_HOLY_SPIRIT','aligned_with','ENT_JESUS_CHRIST','medium','The Spirit is sent by the Son and bears witness to him.','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_BEAST','aligned_with','ENT_CHR_DRAGON_REVELATION','high','The dragon gives the Beast its power and throne (Revelation 13:2).','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_BEAST','aligned_with','ENT_CHR_ANTICHRIST','medium','The Beast of Revelation is read as a figure of the Antichrist.','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_FALSE_PROPHET','aligned_with','ENT_CHR_BEAST','high','The False Prophet (second beast) serves and promotes the first Beast.','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_WHORE_BABYLON','aligned_with','ENT_CHR_BEAST','high','Babylon the Great rides upon the scarlet Beast (Revelation 17:3).','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_BEELZEBUL','identified_with','ENT_CHR_DEVIL','high','Jesus identifies Beelzebul, "prince of demons," with Satan (Matthew 12:24-26).','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_BEELZEBUL','rules','ENT_CHR_DEMONS','high','Beelzebul is named "the prince of the demons."','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_MAMMON','opposes','ENT_CHR_GOD_FATHER','medium','"You cannot serve God and Mammon" (Matthew 6:24).','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_LEGION','member_of','ENT_CHR_DEMONS','high','Legion is the host of demons of the Gerasene possession.','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_STEPHEN','aligned_with','ENT_JESUS_CHRIST','medium','Stephen dies seeing the Son of Man standing at God''s right hand (Acts 7:56).','SRC_NEW_TESTAMENT','reviewed'),
 ('ENT_CHR_THECLA','taught_by','ENT_SAINT_PAUL','high','Thecla is the disciple of Paul in the Acts of Paul and Thecla.','SRC_ACTS_PAUL_THECLA','reviewed')
ON CONFLICT DO NOTHING;

-- ── Duplicate-name discipline: "Holy Spirit" now exists in both the Gnostic and the
--    Christian traditions (the Sethian/Barbeloite Holy Spirit vs the Nicene third person) ─
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Holy Spirit','ENT_GNO_HOLY_SPIRIT','Reviewed duplicate canonical name; the Gnostic Holy Spirit (Barbeloite), distinct from the Nicene third person.','intentional_distinct'),
 ('Holy Spirit','ENT_CHR_HOLY_SPIRIT','Reviewed duplicate canonical name; the Christian/Nicene Holy Spirit, distinct from the Gnostic Holy Spirit.','intentional_distinct')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Christian-family entities' AS label, count(*) FROM entities WHERE tradition LIKE 'Christian%';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
