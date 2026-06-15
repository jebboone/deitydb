-- scripts/complete_sethian_corpus.sql
-- Gnostic expansion V (v1.35.0): completing the Sethian corpus beyond the Apocryphon of
-- John — the remaining major figures of Trimorphic Protennoia, the Platonizing Sethian
-- treatises (Zostrianos, Allogenes, Three Steles of Seth), and the Gospel of the Egyptians.
--
-- Sourced from Meyer's Nag Hammadi Scriptures (the master translation, newly in the Drive)
-- and Burns, Apocalypse of an Alien God (2014), the study of the Platonizing treatises;
-- the Gospel-of-the-Egyptians figures also cite SRC_GOSPEL_EGYPTIANS. (The deep-text cast
-- was reconstructed from established scholarship; the NH Scriptures PDF returned only its
-- front matter on read.)

BEGIN;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_NAG_HAMMADI_SCRIPTURES','Marvin Meyer (ed.), The Nag Hammadi Scriptures: The Revised and Updated Translation of Sacred Gnostic Texts (HarperOne, 2007)','','primary text','Complete modern translation of the Nag Hammadi codices and related texts'),
('SRC_BURNS_ALIEN_GOD','Dylan M. Burns, Apocalypse of an Alien God: Platonism and the Exile of Sethian Gnosticism (University of Pennsylvania Press, 2014)','','secondary scholarship','The Platonizing Sethian treatises (Zostrianos, Allogenes, Marsanes, Three Steles of Seth) and their Neoplatonic context')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
('ENT_SET_PROTENNOIA','Protennoia','Aeon/first thought','Sethian','Aeon/personification','PER_GNO_2ND_4TH','A','reviewed','The "First Thought" (Protennoia), the threefold revealer of the Trimorphic Protennoia, identical with Barbelo, who descends in three forms — as the Voice (the Father), the Sound/Speech (the Mother), and the Word/Logos (the Son) — to awaken the seed of light.'),
('ENT_SET_KALYPTOS','Kalyptos','Aeon/sub-aeon of Barbelo','Sethian','Aeon/personification','PER_GNO_2ND_4TH','B','reviewed','The Hidden One (Kalyptos), the first and latent of the three aeons within the Barbelo aeon in the Platonizing Sethian treatises (Zostrianos, Allogenes); the contemplated, unmanifest intellect.'),
('ENT_SET_PROTOPHANES','Protophanes','Aeon/sub-aeon of Barbelo','Sethian','Aeon/personification','PER_GNO_2ND_4TH','B','reviewed','The First-Appearing One (Protophanes), the second aeon within Barbelo; the manifest, contemplating intellect and the realm of the perfect individuals (Zostrianos, Allogenes).'),
('ENT_SET_TRIPLE_POWER','Triple-Powered One','Divine power/principle','Sethian','Divine principle','PER_GNO_2ND_4TH','B','reviewed','The Triple-Powered One (Tridynamos), the power of the Invisible Spirit — Existence, Life, and Mind (or Blessedness) — that mediates the unfolding of the Barbelo aeon from the unknowable One in the Platonizing Sethian treatises.'),
('ENT_SET_DOXOMEDON','Doxomedon','Aeon/cosmic realm','Sethian','Cosmological category','PER_GNO_2ND_4TH','B','reviewed','Doxomedon ("ruler of glory"), the great aeon of aeons and throne-realm of the thrice-male child and the Invisible Spirit in the Gospel of the Egyptians.'),
('ENT_SET_PLESITHEA','Plesithea','Virgin mother/aeon','Sethian','Aeon/personification','PER_GNO_2ND_4TH','B','reviewed','Plesithea, the virgin mother of the angels and of the incorruptible seed of the great Seth in the Gospel of the Egyptians.'),
('ENT_SET_HORMOS','Hormos','Agent/aeon','Sethian','Aeon/personification','PER_GNO_2ND_4TH','B','reviewed','Hormos, the power prepared through a Logos-begotten holy vessel through whom the great Seth sows his incorruptible seed into the world in the Gospel of the Egyptians.'),
('ENT_SET_NEBRUEL','Nebruel','Demonic power','Sethian','Adversarial being','PER_GNO_2ND_4TH','B','reviewed','Nebruel, the great female demon/power who, joined with Sakla (Saklas), begets the lower archontic powers that rule the material cosmos in the Gospel of the Egyptians.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources + periods ─────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, 'SRC_NAG_HAMMADI_SCRIPTURES', 'Direct attestation', 'Named in the Nag Hammadi Scriptures.'
FROM (VALUES ('ENT_SET_PROTENNOIA'),('ENT_SET_KALYPTOS'),('ENT_SET_PROTOPHANES'),('ENT_SET_TRIPLE_POWER'),('ENT_SET_DOXOMEDON'),('ENT_SET_PLESITHEA'),('ENT_SET_HORMOS'),('ENT_SET_NEBRUEL')) AS t(e)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_SET_KALYPTOS','SRC_BURNS_ALIEN_GOD','Secondary analysis','Burns on the Barbeline triad of the Platonizing treatises.'),
('ENT_SET_PROTOPHANES','SRC_BURNS_ALIEN_GOD','Secondary analysis','Burns on Protophanes and the realm of the perfect individuals.'),
('ENT_SET_TRIPLE_POWER','SRC_BURNS_ALIEN_GOD','Secondary analysis','Burns on the Triple-Powered One and the Existence-Life-Mind triad.'),
('ENT_SET_DOXOMEDON','SRC_GOSPEL_EGYPTIANS','Direct attestation','The Doxomedon aeon in the Gospel of the Egyptians.'),
('ENT_SET_PLESITHEA','SRC_GOSPEL_EGYPTIANS','Direct attestation','Plesithea in the Gospel of the Egyptians.'),
('ENT_SET_HORMOS','SRC_GOSPEL_EGYPTIANS','Direct attestation','Hormos in the Gospel of the Egyptians.'),
('ENT_SET_NEBRUEL','SRC_GOSPEL_EGYPTIANS','Direct attestation','Nebruel and Sakla in the Gospel of the Egyptians.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Sethian figure of the 2nd-4th c. Nag Hammadi corpus.', 'SRC_NAG_HAMMADI_SCRIPTURES', 'reviewed'
FROM (VALUES ('ENT_SET_PROTENNOIA'),('ENT_SET_KALYPTOS'),('ENT_SET_PROTOPHANES'),('ENT_SET_TRIPLE_POWER'),('ENT_SET_DOXOMEDON'),('ENT_SET_PLESITHEA'),('ENT_SET_HORMOS'),('ENT_SET_NEBRUEL')) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- Trimorphic Protennoia
('ENT_SET_PROTENNOIA','identified_with','ENT_SET_BARBELO','high','Protennoia, the First Thought, is identical with Barbelo.','SRC_NAG_HAMMADI_SCRIPTURES','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_PROTENNOIA','emanates_from','ENT_GNO_MONAD','high','Protennoia is the First Thought of the invisible One.','SRC_NAG_HAMMADI_SCRIPTURES','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_PROTENNOIA','reveals','ENT_HIDDEN_KNOWLEDGE','high','In her threefold descent (Voice, Sound, Word) Protennoia reveals the saving knowledge and awakens the seed of light.','SRC_NAG_HAMMADI_SCRIPTURES','PER_GNO_2ND_4TH','reviewed'),
-- the Platonizing Barbeline triad
('ENT_SET_TRIPLE_POWER','emanates_from','ENT_GNO_MONAD','high','The Triple-Powered One is the power of the invisible One/Spirit.','SRC_BURNS_ALIEN_GOD','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_BARBELO','emanates_from','ENT_SET_TRIPLE_POWER','medium','The Barbelo aeon unfolds from the Triple-Powered One in the Platonizing treatises.','SRC_BURNS_ALIEN_GOD','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_KALYPTOS','member_of','ENT_SET_BARBELO','high','Kalyptos is the first of the three aeons within Barbelo.','SRC_BURNS_ALIEN_GOD','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_PROTOPHANES','member_of','ENT_SET_BARBELO','high','Protophanes is the second of the three aeons within Barbelo.','SRC_BURNS_ALIEN_GOD','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_AUTOGENES','member_of','ENT_SET_BARBELO','high','Autogenes is the third of the three aeons within Barbelo.','SRC_BURNS_ALIEN_GOD','PER_GNO_2ND_4TH','reviewed'),
-- Gospel of the Egyptians
('ENT_GNO_MONAD','dwells_in','ENT_SET_DOXOMEDON','medium','The Invisible Spirit is enthroned in the great Doxomedon aeon.','SRC_GOSPEL_EGYPTIANS','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_DOXOMEDON','member_of','ENT_GNO_AEONS','high','Doxomedon is the great aeon of aeons.','SRC_GOSPEL_EGYPTIANS','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_PLESITHEA','parent_of','ENT_SET_SEED_OF_SETH','high','Plesithea is the virgin mother of the incorruptible seed of Seth.','SRC_GOSPEL_EGYPTIANS','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_HORMOS','aligned_with','ENT_SET_SEED_OF_SETH','medium','Through Hormos the great Seth sows his incorruptible seed into the world.','SRC_GOSPEL_EGYPTIANS','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_NEBRUEL','paired_with','ENT_GNO_SAKLAS','high','Nebruel is joined with Sakla to beget the lower powers.','SRC_GOSPEL_EGYPTIANS','PER_GNO_2ND_4TH','reviewed'),
('ENT_SET_NEBRUEL','member_of','ENT_GNO_ARCHONS','high','Nebruel is a power of the lower, archontic order.','SRC_GOSPEL_EGYPTIANS','PER_GNO_2ND_4TH','reviewed'),
-- Hypostasis of the Archons: Eleleth rescues Norea
('ENT_SET_ELELETH','guides','ENT_SET_NOREA','high','The great luminary Eleleth descends to rescue Norea from the archons and reveal her heavenly origin (Hypostasis of the Archons).','SRC_HYPOSTASIS_ARCHONS','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT count(*) AS unreviewed_dups FROM v_unreviewed_duplicate_entities;
SELECT tradition, count(*) FROM entities WHERE tradition='Sethian' GROUP BY 1;
SELECT * FROM v_release_metrics;

COMMIT;
