-- scripts/add_gnostic_schools_entities.sql
-- Gnostic expansion III (v1.31.0): breadth beyond Sethian — the divine/spiritual
-- entities of the other Gnostic and heterodox-Christian currents (Simonian, Basilidean,
-- Marcionite, Saturnilian, Carpocratian), surviving mainly through the heresiologists.
--
-- METHODOLOGY: DeityDB holds SPIRITUAL ENTITIES, not authors. The school founders
-- (Basilides, Marcion, Valentinus, Carpocrates, Ptolemy, Heracleon, Marcus, Cerinthus,
-- Bardaisan) are theologians and are deliberately EXCLUDED. Two humans are included
-- because their sects raised them to functional godhood: Simon Magus (worshipped as the
-- supreme Great Power, Irenaeus AH I.23) and Epiphanes (deified with a temple-cult,
-- Clement Strom. III). Helena is the divine First Thought (Ennoia) her cult venerated.

BEGIN;

-- ── Heresiological sources ───────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_HIPPOLYTUS_REF','Hippolytus of Rome, Refutatio Omnium Haeresium (Philosophumena), c. 225-235 CE','','heresiological source','Accounts of the Naassenes, Peratae, Sethians, Basilideans, Valentinians and others; preserves hymns and diagrams'),
('SRC_CLEMENT_STROM','Clement of Alexandria, Stromata and Excerpta ex Theodoto, c. 195-205 CE','','heresiological source','Basilidean and Valentinian fragments, sometimes verbatim; the Carpocratian Epiphanes'),
('SRC_TERTULLIAN_MARC','Tertullian, Adversus Marcionem (and Adversus Valentinianos), c. 207-212 CE','','heresiological source','The fullest patristic account of Marcion''s two gods and edited canon')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
-- Basilidean
('ENT_BAS_UNBEGOTTEN','Unbegotten Father','Supreme principle','Basilidean','Supreme principle','PER_GNO_2ND_4TH','B','reviewed',
 'The unbegotten, ineffable Father of the Basilidean system — in Hippolytus''s account the "non-existent God" (ouk on theos) beyond being, from whom the cosmic seed and the archons unfold.'),
('ENT_BAS_ABRASAX','Abrasax','Cosmic ruler/archon','Basilidean','Archon/ruler','PER_GNO_2ND_4TH','A','reviewed',
 'Abrasax (Abraxas), the ruler whose name numbers 365 — the lord of the 365 heavens in the Basilidean cosmos. Widely attested on magical gems as a power over the cosmic cycle.'),
('ENT_BAS_GREAT_ARCHON','Great Archon','Demiurgic archon','Basilidean','Creator/ruler figure','PER_GNO_2ND_4TH','B','reviewed',
 'The Great Archon of the Ogdoad in Hippolytus''s Basilides, the chief world-ruler who, believing himself supreme, fashions and governs the cosmos beneath the ineffable Father.'),
-- Simonian
('ENT_SIM_GREAT_POWER','Great Power','Supreme principle','Simonian','Supreme principle','PER_GNO_2ND_4TH','B','reviewed',
 'The Great Power (Megale Dynamis), "the Power of God that is called Great" (Acts 8:10), the supreme principle of the Simonian system, manifest (its adherents held) in Simon himself.'),
('ENT_SIM_HELENA','Helena (Ennoia)','Divine feminine/aeon','Simonian','Aeon/personification','PER_GNO_2ND_4TH','B','reviewed',
 'Helena, identified by the Simonians as the Ennoia (First Thought) of the Great Power — the divine feminine who descended, was imprisoned in matter and successive female bodies, and was sought and redeemed by Simon. The earliest form of the fallen-Wisdom myth.'),
('ENT_SIM_SIMON','Simon Magus','Deified figure/divine claimant','Simonian','Deified human','PER_GNO_2ND_4TH','A','reviewed',
 'Simon Magus, whom his followers venerated not as a teacher but as the supreme God incarnate — the Great Power appearing as Father, Son and Spirit (Irenaeus AH I.23). Included as a human raised by his cult to functional godhood.'),
-- Carpocratian
('ENT_CAR_EPIPHANES','Epiphanes','Deified figure','Carpocratian','Deified human','PER_GNO_2ND_4TH','B','reviewed',
 'Epiphanes, the son of Carpocrates, deified after his early death and honoured with a temple, altars and monthly rites on Same (Cephallenia) according to Clement (Strom. III). Included as a human raised to cultic godhood.'),
-- Marcionite
('ENT_MAR_STRANGER_GOD','Stranger God','Supreme principle','Marcionite','Supreme deity','PER_GNO_2ND_4TH','A','reviewed',
 'The alien or Stranger God of Marcion: the wholly good, previously unknown God of pure love and the Father of Jesus, utterly distinct from and opposed to the just Creator of the Law and the world.'),
-- Saturnilian
('ENT_SAT_SEVEN_ANGELS','Seven World-Creating Angels','Archontic collective','Saturnilian','Archontic collective','PER_GNO_2ND_4TH','B','reviewed',
 'The seven angels who, in the system of Saturninus (Satornilos) of Antioch, fashion the world and humanity below the unknown Father; one of them is the God of the Jews (Irenaeus AH I.24).')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources ───────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_BAS_UNBEGOTTEN','SRC_HIPPOLYTUS_REF','Secondary analysis','Hippolytus, Refut. VII, on the Basilidean non-existent God.'),
('ENT_BAS_UNBEGOTTEN','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.24 on the Basilidean Father.'),
('ENT_BAS_ABRASAX','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.24.7 on Abrasax and the 365 heavens.'),
('ENT_BAS_ABRASAX','SRC_HIPPOLYTUS_REF','Secondary analysis','Hippolytus on the Basilidean heavens.'),
('ENT_BAS_GREAT_ARCHON','SRC_HIPPOLYTUS_REF','Secondary analysis','Hippolytus, Refut. VII, on the Great Archon of the Ogdoad.'),
('ENT_SIM_GREAT_POWER','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.23 on the Simonian Great Power.'),
('ENT_SIM_GREAT_POWER','SRC_HIPPOLYTUS_REF','Secondary analysis','Hippolytus, Refut. VI, on Simon''s Great Power.'),
('ENT_SIM_HELENA','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.23.2 on Helena/Ennoia.'),
('ENT_SIM_SIMON','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.23 on Simon worshipped as a god.'),
('ENT_SIM_SIMON','SRC_HIPPOLYTUS_REF','Secondary analysis','Hippolytus, Refut. VI, on Simon.'),
('ENT_CAR_EPIPHANES','SRC_CLEMENT_STROM','Direct attestation','Clement, Strom. III, on the deified Epiphanes and his cult.'),
('ENT_MAR_STRANGER_GOD','SRC_TERTULLIAN_MARC','Secondary analysis','Tertullian, Adv. Marcionem, on Marcion''s alien God.'),
('ENT_MAR_STRANGER_GOD','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.27 on Marcion''s two gods.'),
('ENT_SAT_SEVEN_ANGELS','SRC_IRENAEUS_AH','Secondary analysis','Irenaeus AH I.24.1-2 on Saturninus and the seven angels.')
ON CONFLICT DO NOTHING;

-- ── Entity periods ───────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Figure/principle of a 1st-2nd c. Gnostic or heterodox current known via the heresiologists.', 'SRC_IRENAEUS_AH', 'reviewed'
FROM (VALUES
 ('ENT_BAS_UNBEGOTTEN'),('ENT_BAS_ABRASAX'),('ENT_BAS_GREAT_ARCHON'),
 ('ENT_SIM_GREAT_POWER'),('ENT_SIM_HELENA'),('ENT_SIM_SIMON'),
 ('ENT_CAR_EPIPHANES'),('ENT_MAR_STRANGER_GOD'),('ENT_SAT_SEVEN_ANGELS')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- Basilidean
('ENT_BAS_GREAT_ARCHON','emanates_from','ENT_BAS_UNBEGOTTEN','medium','The Great Archon arises from the cosmic seed sown by the non-existent Father.','SRC_HIPPOLYTUS_REF','PER_GNO_2ND_4TH','reviewed'),
('ENT_BAS_UNBEGOTTEN','aligned_with','ENT_GNO_MONAD','medium','The Basilidean ineffable Father parallels the Gnostic unknowable Monad/One.','SRC_HIPPOLYTUS_REF','PER_GNO_2ND_4TH','reviewed'),
('ENT_BAS_ABRASAX','rules','ENT_GNO_ARCHONS','high','Abrasax rules the 365 heavens and their archontic powers.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_BAS_ABRASAX','aligned_with','ENT_SET_HEIMARMENE','medium','As lord of the 365 (the cosmic year), Abrasax presides over the astral cycle bound up with Fate.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_BAS_GREAT_ARCHON','aligned_with','ENT_GNO_DEMIURGE','medium','The Great Archon, who believes himself the highest god while a power stands above him, plays the demiurgic role.','SRC_HIPPOLYTUS_REF','PER_GNO_2ND_4TH','reviewed'),
-- Simonian
('ENT_SIM_SIMON','identified_with','ENT_SIM_GREAT_POWER','high','Simon was venerated as the manifestation of the supreme Great Power.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_SIM_SIMON','paired_with','ENT_SIM_HELENA','high','Simon and his Ennoia Helena form the redeemer-and-redeemed pair of the Simonian myth.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_SIM_HELENA','identified_with','ENT_VAL_ENNOIA','medium','Helena is the Ennoia (First Thought) of the Great Power.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_SIM_HELENA','aligned_with','ENT_GNO_SOPHIA','high','The fallen, imprisoned, and redeemed Helena/Ennoia is the earliest form of the fallen-Wisdom (Sophia) myth.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_SIM_GREAT_POWER','aligned_with','ENT_GNO_MONAD','medium','The Simonian Great Power is the supreme principle, parallel to the Gnostic Monad.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
-- Carpocratian
('ENT_CAR_EPIPHANES','aligned_with','ENT_GNO_MONAD','medium','Epiphanes'' teaching (in his On Righteousness) centred on the primal divine Monad and its undivided generosity.','SRC_CLEMENT_STROM','PER_GNO_2ND_4TH','reviewed'),
-- Marcionite
('ENT_MAR_STRANGER_GOD','opposes','ENT_GNO_DEMIURGE','high','Marcion''s good Stranger God stands wholly opposed to the just Creator of the world and the Law.','SRC_TERTULLIAN_MARC','PER_GNO_2ND_4TH','reviewed'),
('ENT_MAR_STRANGER_GOD','aligned_with','ENT_GNO_MONAD','medium','The previously unknown, transcendent good God parallels the Gnostic supreme unknown.','SRC_TERTULLIAN_MARC','PER_GNO_2ND_4TH','reviewed'),
-- Saturnilian
('ENT_SAT_SEVEN_ANGELS','member_of','ENT_GNO_ARCHONS','high','The seven world-creating angels are the archontic rulers of the Saturnilian cosmos.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_SAT_SEVEN_ANGELS','aligned_with','ENT_OPH_HEBDOMAD','medium','The seven creating angels correspond to the planetary Hebdomad of the other Gnostic systems.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT count(*) AS unreviewed_dups FROM v_unreviewed_duplicate_entities;
SELECT tradition, count(*) FROM entities WHERE tradition IN ('Basilidean','Simonian','Carpocratian','Marcionite','Saturnilian') GROUP BY tradition ORDER BY tradition;
SELECT * FROM v_release_metrics;

COMMIT;
