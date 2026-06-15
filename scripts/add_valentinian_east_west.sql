-- scripts/add_valentinian_east_west.sql
-- Valentinian deepening II (v1.33.0): the Eastern/Western (Oriental/Italic) split and
-- the soteriological apparatus it divides over. Grounded in Thomassen, The Spiritual
-- Seed (2006), with Irenaeus AH, Clement's Excerpta ex Theodoto (the key Eastern witness),
-- Hippolytus Haer. VI 35, and Tertullian Adv. Valent. (the "two schools / two chairs").
--
-- The split is represented through ENTITIES, not the teachers (Ptolemy, Heracleon,
-- Theodotus, Axionicus are authors and excluded): the threefold anthropology, the
-- spiritual seed, and especially the psychic Christ — the Western school gave the Saviour
-- a psychic body from the Demiurge and made the psychics the target of salvation, while
-- the Eastern school held the Saviour's body to be purely spiritual.

BEGIN;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
('ENT_VAL_PNEUMATIC','Pneumatic','Anthropological category','Valentinian','Theological category','PER_GNO_2ND_4TH','A','reviewed','The spiritual (pneumatic) nature — the highest of the three Valentinian classes of humanity, kin to the Pleroma. Both schools agreed the pneumatic is saved; they differed on whether it is saved by nature (Eastern) or must be formed by knowledge.'),
('ENT_VAL_PSYCHIC','Psychic','Anthropological category','Valentinian','Theological category','PER_GNO_2ND_4TH','A','reviewed','The psychic (soul) nature — the middle class, possessing free will. The Western (Italic) school made the psychics the central target of salvation, saved by faith and works; the Eastern school subordinated them to the spiritual.'),
('ENT_VAL_HYLIC','Hylic','Anthropological category','Valentinian','Theological category','PER_GNO_2ND_4TH','A','reviewed','The material (hylic/choic) nature — the lowest class, formed from Achamoth''s passions and destined to dissolution.'),
('ENT_VAL_SPIRITUAL_SEED','Spiritual Seed','Elect collective/category','Valentinian','Elect collective','PER_GNO_2ND_4TH','A','reviewed','The spiritual seed (sperma pneumatikon): the pneumatic element that Achamoth, beholding the Saviour and his angels, conceived and sowed into the Demiurge''s creation — the elect "Church" destined to re-enter the Pleroma. The title concept of Thomassen''s study.'),
('ENT_VAL_PSYCHIC_CHRIST','Psychic Christ','Savior aspect','Valentinian','Revealer/savior','PER_GNO_2ND_4TH','A','reviewed','The psychic Christ: in the Western (Italic) school (Ptolemy, Heracleon) the Saviour assumed a psychic body furnished by the Demiurge, in addition to his spiritual nature; the Eastern (Oriental) school (Theodotus, Axionicus) held the Saviour''s body to be wholly spiritual. The clearest marker of the two-school division.'),
('ENT_VAL_ANGELS_SAVIOR','Angels of the Savior','Aeonic collective','Valentinian','Aeonic collective','PER_GNO_2ND_4TH','A','reviewed','The (male) angels of the Saviour: the spiritual counterparts who accompany the Saviour out of the Pleroma; the spiritual seed is reunited with them in the bridal chamber, mending the broken syzygy.'),
('ENT_VAL_APOLYTROSIS','Apolytrosis','Ritual/devotional category','Valentinian','Ritual category','PER_GNO_2ND_4TH','A','reviewed','Apolytrosis ("redemption"/release): the Valentinian sacrament of liberation that seals the pneumatic for ascent through the powers, closely bound to the bridal chamber (Irenaeus AH I.21).'),
('ENT_VAL_MIDDLE','The Middle','Cosmic realm/category','Valentinian','Cosmological category','PER_GNO_2ND_4TH','A','reviewed','The Middle (Mesotes): the intermediate region between the Pleroma and the cosmos. Achamoth dwells in the Ogdoad/Middle, while the psychic Demiurge rules the Hebdomad below her.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources + periods ─────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, s, ev, note FROM (VALUES
 ('ENT_VAL_PNEUMATIC'),('ENT_VAL_PSYCHIC'),('ENT_VAL_HYLIC'),('ENT_VAL_SPIRITUAL_SEED'),
 ('ENT_VAL_PSYCHIC_CHRIST'),('ENT_VAL_ANGELS_SAVIOR'),('ENT_VAL_APOLYTROSIS'),('ENT_VAL_MIDDLE')
) AS t(e)
CROSS JOIN (VALUES
 ('SRC_THOMASSEN_SEED','Secondary analysis','Thomassen, The Spiritual Seed, on the Eastern/Western division and Valentinian soteriology.'),
 ('SRC_IRENAEUS_AH','Direct attestation','Irenaeus, Adv. Haer. I.1-8, 21, on the anthropology, the Saviour, and apolytrosis.')
) AS src(s,ev,note)
ON CONFLICT DO NOTHING;

-- the most Theodotus/Hippolytus-specific entities also cite the Eastern witnesses
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_VAL_PSYCHIC_CHRIST','SRC_HIPPOLYTUS_REF','Direct attestation','Hippolytus, Haer. VI 35:5-7, on the two schools'' divergent Christology.'),
('ENT_VAL_SPIRITUAL_SEED','SRC_CLEMENT_STROM','Direct attestation','Clement, Excerpta ex Theodoto, on the spiritual seed and the angels.'),
('ENT_VAL_ANGELS_SAVIOR','SRC_CLEMENT_STROM','Direct attestation','Clement, Excerpta ex Theodoto, on the angels of the Saviour and the bridal-chamber reunion.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Valentinian soteriological category, 2nd c.', 'SRC_THOMASSEN_SEED', 'reviewed'
FROM (VALUES
 ('ENT_VAL_PNEUMATIC'),('ENT_VAL_PSYCHIC'),('ENT_VAL_HYLIC'),('ENT_VAL_SPIRITUAL_SEED'),
 ('ENT_VAL_PSYCHIC_CHRIST'),('ENT_VAL_ANGELS_SAVIOR'),('ENT_VAL_APOLYTROSIS'),('ENT_VAL_MIDDLE')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- the threefold anthropology and its origin in Achamoth's states
('ENT_VAL_SPIRITUAL_SEED','emanates_from','ENT_VAL_ACHAMOTH','high','Achamoth, beholding the Saviour and his angels, conceives and sows the spiritual seed.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_SPIRITUAL_SEED','embodies','ENT_VAL_PNEUMATIC','high','The spiritual seed is the pneumatic element among humanity.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_PNEUMATIC','aligned_with','ENT_SPIRIT','high','The pneumatic nature is the spiritual element.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_PSYCHIC','emanates_from','ENT_VAL_EPISTROPHE','high','The psychic substance arises from Achamoth''s conversion (epistrophe).','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_HYLIC','emanates_from','ENT_VAL_LYPE','high','The material substance arises from Achamoth''s passions of grief, fear, and perplexity.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
-- the Demiurge and the Middle
('ENT_VAL_ACHAMOTH','parent_of','ENT_GNO_DEMIURGE','high','Achamoth forms the psychic Demiurge from the psychic substance of her conversion.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_GNO_DEMIURGE','embodies','ENT_VAL_PSYCHIC','high','The Demiurge is the psychic god, ruler of the psychic order.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_GNO_DEMIURGE','rules','ENT_VAL_MIDDLE','high','The Demiurge rules the Hebdomad within the Middle, beneath Achamoth.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_ACHAMOTH','dwells_in','ENT_VAL_MIDDLE','high','Achamoth dwells in the Ogdoad of the Middle, above the Demiurge.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
-- the Christology of the two schools
('ENT_VAL_PSYCHIC_CHRIST','emanates_from','ENT_GNO_DEMIURGE','high','In the Western school the Saviour''s psychic body is furnished by the Demiurge.','SRC_HIPPOLYTUS_REF','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_PSYCHIC_CHRIST','aligned_with','ENT_VAL_SOTER','high','The psychic Christ is the psychic component the Western Saviour assumes; the Eastern Saviour''s body is wholly spiritual.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_PSYCHIC_CHRIST','embodies','ENT_VAL_PSYCHIC','high','The psychic Christ belongs to the psychic order.','SRC_HIPPOLYTUS_REF','PER_GNO_2ND_4TH','reviewed'),
-- the soteriology of reunion
('ENT_VAL_ANGELS_SAVIOR','emanates_from','ENT_VAL_SOTER','high','The angels accompany the Saviour out of the Pleroma.','SRC_CLEMENT_STROM','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_SPIRITUAL_SEED','paired_with','ENT_VAL_ANGELS_SAVIOR','high','The spiritual seed is reunited with the angels of the Saviour, restoring the syzygy.','SRC_CLEMENT_STROM','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_SPIRITUAL_SEED','undergoes_process','ENT_SALVATION','high','The spiritual seed is gathered up and saved into the Pleroma.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_APOLYTROSIS','aligned_with','ENT_VAL_BRIDAL_CHAMBER','high','Apolytrosis (redemption) is bound to the bridal-chamber sacrament of reunion.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_APOLYTROSIS','mediates','ENT_SALVATION','high','Apolytrosis seals the pneumatic for ascent and salvation.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT count(*) AS unreviewed_dups FROM v_unreviewed_duplicate_entities;
SELECT * FROM v_release_metrics;

COMMIT;
