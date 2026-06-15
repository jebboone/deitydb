-- scripts/add_jeuian_ascent_archons.sql
-- Gnostic expansion IV (v1.34.0): the Jeuian ascent — the gate-guarding archons of the
-- first three aeons and the ritual mechanism of passage (the Fire Baptism and the Seals),
-- from the (Second) Book of Jeu (Bruce Codex), 3rd-4th c. Egypt.
--
-- In the ascent rite the soul passes each aeon by sealing itself, holding the numbered
-- token, and pronouncing the names of power, whereupon the archons withdraw. The third
-- aeon is guarded by Yaldabaoth (the Sethian demiurge) together with Choucho — a direct
-- bridge between the Jeuian ascent and the Sethian cosmos. Builds on the Pistis
-- Sophia / Jeuian layer (v1.30.0).

BEGIN;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
('ENT_JEU_PROTETH','Proteth','Archon/gate-guardian','Gnostic','Archon/ruler','PER_GNO_2ND_4TH','B','reviewed','One of the three archons guarding the first aeon of the ascent in the Second Book of Jeu; the initiate makes them retreat westward with the seal Zozeze, the token 1119, and the names of power.'),
('ENT_JEU_PERSOMPHON','Persomphon','Archon/gate-guardian','Gnostic','Archon/ruler','PER_GNO_2ND_4TH','B','reviewed','One of the three archons of the first aeon of the ascent in the Second Book of Jeu, named alongside Proteth and Chous.'),
('ENT_JEU_CHOUS','Chous','Archon/gate-guardian','Gnostic','Archon/ruler','PER_GNO_2ND_4TH','B','reviewed','One of the three archons of the first aeon of the ascent in the Second Book of Jeu.'),
('ENT_JEU_CHOUNCHEOCH','Chouncheoch','Archon/gate-guardian','Gnostic','Archon/ruler','PER_GNO_2ND_4TH','B','reviewed','The archon guarding the second aeon of the ascent in the Second Book of Jeu; passed by the seal Thozoaz, the token 2219, and the names of power.'),
('ENT_JEU_CHOUCHO','Choucho','Archon/gate-guardian','Gnostic','Archon/ruler','PER_GNO_2ND_4TH','B','reviewed','An archon of the third aeon of the ascent in the Second Book of Jeu, guarding it together with Yaldabaoth; passed by the seal Zozeaz and the token 3349.'),
('ENT_JEU_FIRST_AEON','First Aeon of the Ascent','Cosmic realm/category','Gnostic','Cosmological category','PER_GNO_2ND_4TH','B','reviewed','The first of the hostile aeons through which the soul ascends in the Second Book of Jeu, guarded by Proteth, Persomphon, and Chous.'),
('ENT_JEU_SECOND_AEON','Second Aeon of the Ascent','Cosmic realm/category','Gnostic','Cosmological category','PER_GNO_2ND_4TH','B','reviewed','The second aeon of the ascent, guarded by Chouncheoch.'),
('ENT_JEU_THIRD_AEON','Third Aeon of the Ascent','Cosmic realm/category','Gnostic','Cosmological category','PER_GNO_2ND_4TH','B','reviewed','The third aeon of the ascent, guarded by Yaldabaoth and Choucho.'),
('ENT_JEU_FIRE_BAPTISM','Baptism of Fire','Ritual/devotional category','Gnostic','Ritual category','PER_GNO_2ND_4TH','A','reviewed','The baptism of fire of the Books of Jeu: a purificatory rite, administered by Jesus and sealed by the Virgin of the Light, that forgives sins and prepares the soul for ascent and admission into the Kingdom (Treasury) of the Light.'),
('ENT_JEU_SEALS','Seals of the Light','Ritual mechanism/category','Gnostic','Ritual category','PER_GNO_2ND_4TH','A','reviewed','The seals (sphragides) of the Jeuian rites: sacred sigils, with numbered tokens and names of power, by which the initiate authorises passage so that the archons of each aeon withdraw.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources + periods ─────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, 'SRC_BOOKS_OF_JEU', 'Direct attestation', 'Named in the (Second) Book of Jeu (Bruce Codex).'
FROM (VALUES
 ('ENT_JEU_PROTETH'),('ENT_JEU_PERSOMPHON'),('ENT_JEU_CHOUS'),('ENT_JEU_CHOUNCHEOCH'),('ENT_JEU_CHOUCHO'),
 ('ENT_JEU_FIRST_AEON'),('ENT_JEU_SECOND_AEON'),('ENT_JEU_THIRD_AEON'),('ENT_JEU_FIRE_BAPTISM'),('ENT_JEU_SEALS')
) AS t(e)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_JEU_FIRE_BAPTISM','SRC_PISTIS_SOPHIA','Secondary analysis','The Virgin of the Light as keeper of the seal and judge parallels the Pistis Sophia.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Figure/structure of the Jeuian ascent rite (3rd-4th c.).', 'SRC_BOOKS_OF_JEU', 'reviewed'
FROM (VALUES
 ('ENT_JEU_PROTETH'),('ENT_JEU_PERSOMPHON'),('ENT_JEU_CHOUS'),('ENT_JEU_CHOUNCHEOCH'),('ENT_JEU_CHOUCHO'),
 ('ENT_JEU_FIRST_AEON'),('ENT_JEU_SECOND_AEON'),('ENT_JEU_THIRD_AEON'),('ENT_JEU_FIRE_BAPTISM'),('ENT_JEU_SEALS')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- archons guard their aeons
('ENT_JEU_PROTETH','rules','ENT_JEU_FIRST_AEON','high','Proteth guards the first aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_PERSOMPHON','rules','ENT_JEU_FIRST_AEON','high','Persomphon guards the first aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_CHOUS','rules','ENT_JEU_FIRST_AEON','high','Chous guards the first aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_CHOUNCHEOCH','rules','ENT_JEU_SECOND_AEON','high','Chouncheoch guards the second aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_CHOUCHO','rules','ENT_JEU_THIRD_AEON','high','Choucho guards the third aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_GNO_YALDABAOTH','rules','ENT_JEU_THIRD_AEON','high','Yaldabaoth guards the third aeon of the ascent together with Choucho — bridging the Jeuian ascent and the Sethian demiurge.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
-- archons are of the archontic order
('ENT_JEU_PROTETH','member_of','ENT_GNO_ARCHONS','high','A gate-guarding archon.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_PERSOMPHON','member_of','ENT_GNO_ARCHONS','high','A gate-guarding archon.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_CHOUS','member_of','ENT_GNO_ARCHONS','high','A gate-guarding archon.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_CHOUNCHEOCH','member_of','ENT_GNO_ARCHONS','high','A gate-guarding archon.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_CHOUCHO','member_of','ENT_GNO_ARCHONS','high','A gate-guarding archon.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
-- the ascent-aeons in the aeonic structure
('ENT_JEU_FIRST_AEON','member_of','ENT_GNO_AEONS','medium','An aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_SECOND_AEON','member_of','ENT_GNO_AEONS','medium','An aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_THIRD_AEON','member_of','ENT_GNO_AEONS','medium','An aeon of the ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
-- the ritual mechanism
('ENT_GNO_CHRIST','associated_ritual','ENT_JEU_FIRE_BAPTISM','high','Jesus administers and seals the baptism of fire in the Books of Jeu.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_FIRE_BAPTISM','aligned_with','ENT_PURIFICATION','high','The baptism of fire purifies the soul of its sins.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_FIRE_BAPTISM','mediates','ENT_SALVATION','high','The baptism of fire admits the soul to the Kingdom of the Light.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_FIRE_BAPTISM','aligned_with','ENT_PS_VIRGIN_LIGHT','high','The Virgin of the Light is keeper of the seal of the baptism of fire.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_FIRE_BAPTISM','aligned_with','ENT_PS_TREASURY_LIGHT','medium','The baptism of fire prepares the soul for the Treasury of the Light.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_SEALS','aligned_with','ENT_JEU_FIRE_BAPTISM','high','The seals are integral to the baptism and ascent rites.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_JEU_SEALS','mediates','ENT_SALVATION','high','By the seals and names the soul passes the archons and secures its ascent.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT count(*) AS unreviewed_dups FROM v_unreviewed_duplicate_entities;
-- the third aeon's two guardians (the Sethian bridge):
SELECT s.canonical_name AS guardian FROM entity_relationships r JOIN entities s ON s.entity_id=r.subject_entity_id
WHERE r.object_entity_id='ENT_JEU_THIRD_AEON' AND r.relationship_type='rules' ORDER BY s.canonical_name;
SELECT * FROM v_release_metrics;

COMMIT;
