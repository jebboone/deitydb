-- scripts/add_sethian_apocryphon_john.sql
-- Gnostic expansion (v1.29.0): the Sethian system of the Apocryphon of John.
--
-- Builds out the interior of the existing Sethian skeleton: Barbelo's pentad, the
-- twelve aeons of the Four Luminaries, the placement of the heavenly humans in the
-- luminaries, the Sophia->Yaldabaoth fall genealogy, and the demiurgic apparatus
-- (the twelve authorities = seven heavenly kings + five over the chaos, Heimarmene,
-- the seventy-two body-angels, the four demons of the passions).
--
-- Granularity: the long recension (NHC II/IV) lists 72 limb-angels, 30 powers, etc.,
-- from the "Book of Zoroaster". Named structural powers are mapped as individuals;
-- the undifferentiated swarms are mapped as sourced collectives (per Piwowarczyk's
-- Lexicon, which catalogues them). Text-level sources per the user's source framework.

BEGIN;

-- ── Sources (text-level) ─────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_APOCRYPHON_JOHN','Apocryphon of John (The Secret Book of John), NHC II,1 / III,1 / IV,1 and BG 8502,2; c. 2nd c. CE, Egypt','','primary text','Sethian cosmogony: the Invisible Spirit, Barbelo, the Four Luminaries, Sophia, Yaldabaoth and the archons'),
('SRC_HYPOSTASIS_ARCHONS','Hypostasis of the Archons (The Reality of the Rulers), NHC II,4','','primary text','Sethian Genesis exegesis: the archons, Norea, Eleleth, Sabaoth'),
('SRC_GOSPEL_EGYPTIANS','Gospel of the Egyptians (Holy Book of the Great Invisible Spirit), NHC III,2 / IV,2','','primary text','Sethian liturgy: the Invisible Spirit, Barbelo, the luminaries, Seth and his seed'),
('SRC_PIWOWARCZYK_LEXICON','Przemyslaw Piwowarczyk, A Lexicon of Spiritual Powers in the Nag Hammadi "Library" in the Light of the Texts of Ritual Power','','reference work','Onomastic catalogue of the spiritual powers (aeons, archons, angels, demons) of the Nag Hammadi corpus')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
-- Barbelo's pentad (her first aeons / co-emanations)
('ENT_SET_PROGNOSIS','Prognosis','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed',
 'Foreknowledge (Prognosis), the second of Barbelo''s aeons in the Apocryphon of John; granted at her request as the Invisible Spirit gazes into her.'),
('ENT_SET_APHTHARSIA','Aphtharsia','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed',
 'Incorruptibility (Aphtharsia), one of Barbelo''s aeons in the Apocryphon of John, expressing the imperishability of the divine realm.'),
('ENT_SET_AIONIA_ZOE','Aionia Zoe','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed',
 'Eternal Life (Aionia Zoe), one of Barbelo''s aeons in the Apocryphon of John, the life of the Pleroma.'),
-- The twelve aeons of the Four Luminaries (three each)
('ENT_SET_CHARIS','Charis','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Grace (Charis), one of the three aeons of the first luminary Harmozel in the Apocryphon of John.'),
('ENT_SET_ALETHEIA','Aletheia (Sethian)','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Truth (Aletheia), one of the three aeons of the first luminary Harmozel in the Apocryphon of John.'),
('ENT_SET_MORPHE','Morphe','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Form (Morphe), one of the three aeons of the first luminary Harmozel in the Apocryphon of John.'),
('ENT_SET_AISTHESIS','Aisthesis','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Perception (Aisthesis), one of the three aeons of the second luminary Oroiael in the Apocryphon of John.'),
('ENT_SET_MNEME','Mneme','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Memory (Mneme), one of the three aeons of the second luminary Oroiael in the Apocryphon of John.'),
('ENT_SET_SYNESIS','Synesis','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Understanding (Synesis), one of the three aeons of the third luminary Daveithe in the Apocryphon of John.'),
('ENT_SET_AGAPE','Agape (Sethian)','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Love (Agape), one of the three aeons of the third luminary Daveithe in the Apocryphon of John.'),
('ENT_SET_IDEA','Idea','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Idea (Idea/Perfection of form), one of the three aeons of the third luminary Daveithe in the Apocryphon of John.'),
('ENT_SET_TELEIOS','Teleios','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Perfection (Teleios), one of the three aeons of the fourth luminary Eleleth in the Apocryphon of John.'),
('ENT_SET_EIRENE','Eirene (Sethian)','Aeon/personification','Sethian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Peace (Eirene), one of the three aeons of the fourth luminary Eleleth in the Apocryphon of John.'),
('ENT_SET_REPENTANT_SOULS','Souls of the Repentant','Elect collective','Sethian','Elect collective','PER_GNO_2ND_4TH','B','reviewed','The souls who came to knowledge late but repented, placed in the fourth luminary Eleleth in the Apocryphon of John.'),
-- Demiurgic apparatus
('ENT_SET_HEIMARMENE','Heimarmene','Cosmic mechanism/category','Sethian','Cosmological category','PER_GNO_2ND_4TH','A','reviewed','Fate (Heimarmene), the bond of forgetfulness the archons forge to enslave humanity to the stars and passions in the Apocryphon of John.'),
('ENT_SET_TWELVE_AUTHORITIES','Twelve Authorities','Archontic collective','Sethian','Archontic collective','PER_GNO_2ND_4TH','A','reviewed','The twelve authorities (exousiai) Yaldabaoth begets to rule the cosmos in the Apocryphon of John: seven kings over the heavens and five over the chaos of the underworld.'),
('ENT_SET_SEVEN_KINGS','Seven Kings of the Heavens','Archontic collective','Sethian','Archontic collective','PER_GNO_2ND_4TH','A','reviewed','The seven archontic kings Yaldabaoth sets over the seven heavens (the planetary spheres) in the Apocryphon of John.'),
('ENT_SET_FIVE_CHAOS','Five over the Chaos','Archontic collective','Sethian','Archontic collective','PER_GNO_2ND_4TH','B','reviewed','The five authorities set over the chaos of the underworld, beneath the seven heavenly kings, in the Apocryphon of John (BG 41).'),
('ENT_SET_72_ANGELS','Seventy-two Angels','Angel collective','Sethian','Angel collective','PER_GNO_2ND_4TH','A','reviewed','The seventy-two angels who, with their powers, craft the parts of the psychic body of Adam in the long recension of the Apocryphon of John (drawn from the Book of Zoroaster).'),
('ENT_SET_FOUR_DEMONS','Four Demons of the Passions','Demon collective','Sethian','Demon collective','PER_GNO_2ND_4TH','A','reviewed','The four chief demons who rule the passions in the material body in the long recension of the Apocryphon of John.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources (primary text + Piwowarczyk lexicon) ──────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, 'SRC_APOCRYPHON_JOHN', 'Direct attestation', 'Named in the Apocryphon of John.'
FROM (VALUES
 ('ENT_SET_PROGNOSIS'),('ENT_SET_APHTHARSIA'),('ENT_SET_AIONIA_ZOE'),
 ('ENT_SET_CHARIS'),('ENT_SET_ALETHEIA'),('ENT_SET_MORPHE'),('ENT_SET_AISTHESIS'),('ENT_SET_MNEME'),
 ('ENT_SET_SYNESIS'),('ENT_SET_AGAPE'),('ENT_SET_IDEA'),('ENT_SET_TELEIOS'),('ENT_SET_EIRENE'),
 ('ENT_SET_REPENTANT_SOULS'),('ENT_SET_HEIMARMENE'),('ENT_SET_TWELVE_AUTHORITIES'),
 ('ENT_SET_SEVEN_KINGS'),('ENT_SET_FIVE_CHAOS'),('ENT_SET_72_ANGELS'),('ENT_SET_FOUR_DEMONS')
) AS t(e)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, 'SRC_PIWOWARCZYK_LEXICON', 'Secondary analysis', 'Catalogued in Piwowarczyk, Lexicon of Spiritual Powers.'
FROM (VALUES
 ('ENT_SET_TWELVE_AUTHORITIES'),('ENT_SET_SEVEN_KINGS'),('ENT_SET_FIVE_CHAOS'),
 ('ENT_SET_72_ANGELS'),('ENT_SET_FOUR_DEMONS'),('ENT_SET_HEIMARMENE')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Entity periods ───────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Sethian aeon/power of the Apocryphon of John (2nd c.).', 'SRC_APOCRYPHON_JOHN', 'reviewed'
FROM (VALUES
 ('ENT_SET_PROGNOSIS'),('ENT_SET_APHTHARSIA'),('ENT_SET_AIONIA_ZOE'),
 ('ENT_SET_CHARIS'),('ENT_SET_ALETHEIA'),('ENT_SET_MORPHE'),('ENT_SET_AISTHESIS'),('ENT_SET_MNEME'),
 ('ENT_SET_SYNESIS'),('ENT_SET_AGAPE'),('ENT_SET_IDEA'),('ENT_SET_TELEIOS'),('ENT_SET_EIRENE'),
 ('ENT_SET_REPENTANT_SOULS'),('ENT_SET_HEIMARMENE'),('ENT_SET_TWELVE_AUTHORITIES'),
 ('ENT_SET_SEVEN_KINGS'),('ENT_SET_FIVE_CHAOS'),('ENT_SET_72_ANGELS'),('ENT_SET_FOUR_DEMONS')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- Barbelo's pentad emanate from her
('ENT_SET_PROGNOSIS','emanates_from','ENT_SET_BARBELO','high','Foreknowledge is granted to Barbelo as her aeon.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_APHTHARSIA','emanates_from','ENT_SET_BARBELO','high','Incorruptibility stands forth as one of Barbelo''s aeons.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_AIONIA_ZOE','emanates_from','ENT_SET_BARBELO','high','Eternal Life stands forth as one of Barbelo''s aeons.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
-- Twelve aeons of the luminaries (member_of their luminary)
('ENT_SET_CHARIS','member_of','ENT_SET_HARMOZEL','high','Grace is an aeon of the first luminary Harmozel.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_ALETHEIA','member_of','ENT_SET_HARMOZEL','high','Truth is an aeon of the first luminary Harmozel.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_MORPHE','member_of','ENT_SET_HARMOZEL','high','Form is an aeon of the first luminary Harmozel.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_AISTHESIS','member_of','ENT_SET_OROIAEL','high','Perception is an aeon of the second luminary Oroiael.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_MNEME','member_of','ENT_SET_OROIAEL','high','Memory is an aeon of the second luminary Oroiael.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_EPINNOIA','member_of','ENT_SET_OROIAEL','medium','Afterthought (Epinoia) is reckoned among the aeons of the second luminary Oroiael.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_SYNESIS','member_of','ENT_SET_DAVEITHE','high','Understanding is an aeon of the third luminary Daveithe.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_AGAPE','member_of','ENT_SET_DAVEITHE','high','Love is an aeon of the third luminary Daveithe.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_IDEA','member_of','ENT_SET_DAVEITHE','high','Idea is an aeon of the third luminary Daveithe.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_TELEIOS','member_of','ENT_SET_ELELETH','high','Perfection is an aeon of the fourth luminary Eleleth.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_EIRENE','member_of','ENT_SET_ELELETH','high','Peace is an aeon of the fourth luminary Eleleth.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_GNO_SOPHIA','member_of','ENT_SET_ELELETH','medium','Sophia is associated with the fourth luminary Eleleth before her fall.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
-- aeon -> comparative abstraction
('ENT_SET_ALETHEIA','embodies','ENT_TRUTH','high','The aeon Aletheia is Truth personified.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_MNEME','embodies','ENT_MEMORY','high','The aeon Mneme is Memory personified.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_SYNESIS','embodies','ENT_UNDERSTANDING','high','The aeon Synesis is Understanding personified.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_AGAPE','embodies','ENT_LOVE','high','The aeon Agape is Love personified.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
-- heavenly humans placed in the luminaries
('ENT_SET_ADAMAS','dwells_in','ENT_SET_HARMOZEL','high','The perfect Man Adamas is placed in the first luminary Harmozel.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_SETH','dwells_in','ENT_SET_OROIAEL','high','The heavenly Seth is placed in the second luminary Oroiael.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_SEED_OF_SETH','dwells_in','ENT_SET_DAVEITHE','high','The seed (posterity) of Seth is placed in the third luminary Daveithe.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_REPENTANT_SOULS','dwells_in','ENT_SET_ELELETH','high','The souls who repented late are placed in the fourth luminary Eleleth.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
-- Autogenes-Christ over the luminaries
('ENT_SET_AUTOGENES','identified_with','ENT_GNO_CHRIST','high','The self-generated Autogenes is the divine Christ anointed by the Invisible Spirit.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_AUTOGENES','rules','ENT_SET_FOUR_LUMINARIES','high','The Autogenes is set over the Four Luminaries and their aeons.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
-- The fall and the demiurgic apparatus
('ENT_GNO_YALDABAOTH','emanates_from','ENT_GNO_SOPHIA','high','Sophia brings forth Yaldabaoth alone, without her consort or the Spirit''s consent; he is her malformed offspring.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_GNO_YALDABAOTH','parent_of','ENT_SET_TWELVE_AUTHORITIES','high','Yaldabaoth begets the twelve authorities to rule the cosmos.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_SEVEN_KINGS','member_of','ENT_SET_TWELVE_AUTHORITIES','high','The seven heavenly kings are seven of the twelve authorities.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_FIVE_CHAOS','member_of','ENT_SET_TWELVE_AUTHORITIES','high','The five over the chaos of the underworld complete the twelve authorities.','SRC_PIWOWARCZYK_LEXICON','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_TWELVE_AUTHORITIES','member_of','ENT_GNO_ARCHONS','high','The twelve authorities are the chief archons of Yaldabaoth''s realm.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_HEIMARMENE','embodies','ENT_FATE','high','Heimarmene is Fate, the astral bondage the archons impose on humanity.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_72_ANGELS','member_of','ENT_GNO_ARCHONS','high','The seventy-two angels serve the archons in fashioning the psychic body of Adam.','SRC_PIWOWARCZYK_LEXICON','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_FOUR_DEMONS','member_of','ENT_GNO_ARCHONS','high','The four demons of the passions belong to the archontic ordering of the material body.','SRC_PIWOWARCZYK_LEXICON','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_FOUR_DEMONS','causes_affliction','ENT_HUMANS','high','The four chief demons rule the passions that afflict humanity in the material body.','SRC_APOCRYPHON_JOHN','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS sethian_entities FROM entities WHERE tradition='Sethian';
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
-- the luminary structure:
SELECT lum.canonical_name AS luminary, count(*) FILTER (WHERE r.relationship_type='member_of') AS aeons
FROM entities lum LEFT JOIN entity_relationships r ON r.object_entity_id=lum.entity_id AND r.relationship_type='member_of'
WHERE lum.entity_id IN ('ENT_SET_HARMOZEL','ENT_SET_OROIAEL','ENT_SET_DAVEITHE','ENT_SET_ELELETH')
GROUP BY lum.canonical_name ORDER BY lum.canonical_name;
SELECT * FROM v_release_metrics;

COMMIT;
