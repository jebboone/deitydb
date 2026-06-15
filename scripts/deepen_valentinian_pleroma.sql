-- scripts/deepen_valentinian_pleroma.sql
-- Valentinian deepening (v1.32.0): complete the thirty-aeon Pleroma and add Sophia's
-- passions. Grounded in Irenaeus, Adv. Haer. I.1-4 (the Ptolemaic aeon-lists) and
-- Einar Thomassen, The Spiritual Seed (Brill, 2006), the definitive study of the
-- Valentinian tradition.
--
-- The Ogdoad already existed (Bythos, Sige, Nous, Aletheia, Logos, Zoe, Anthropos,
-- Ecclesia); Logos+Zoe parent_of the Decad and Anthropos+Ecclesia parent_of the Dodecad.
-- The existing ENT_GNO_SOPHIA serves as the thirtieth aeon (member_of Dodecad,
-- spouse_of Theletos) and ENT_VAL_MONOGENES as the Decad's Monogenes — both reused, not
-- duplicated. This fills in the remaining 9 Decad + 8 Dodecad member-aeons with their
-- syzygies, and personifies Sophia's passions (Enthymesis and the fourfold passion).
-- Names colliding with existing entities are suffixed "(Valentinian)".

BEGIN;

-- ── Source ───────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_THOMASSEN_SEED','Einar Thomassen, The Spiritual Seed: The Church of the "Valentinians" (Nag Hammadi and Manichaean Studies 60; Brill, 2006)','','secondary scholarship','The definitive study of the Valentinian tradition: its pleroma, protology, Sophia myth, soteriology, and the Eastern/Western schools')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
-- Decad (offspring of Logos + Zoe), 5 syzygies; Monogenes + Macaria complete it
('ENT_VAL_BYTHIOS','Bythios','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Profound (Bythios), male aeon of the Decad, consort of Mixis (Irenaeus AH I.1.2).'),
('ENT_VAL_MIXIS','Mixis','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Mingling (Mixis), female aeon of the Decad, consort of Bythios.'),
('ENT_VAL_AGERATOS','Ageratos','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Never-aging (Ageratos), male aeon of the Decad, consort of Henosis.'),
('ENT_VAL_HENOSIS','Henosis','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Union (Henosis), female aeon of the Decad, consort of Ageratos.'),
('ENT_VAL_AUTOPHYES','Autophyes','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Self-produced (Autophyes), male aeon of the Decad, consort of Hedone.'),
('ENT_VAL_HEDONE','Hedone (Valentinian)','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Pleasure (Hedone), female aeon of the Decad, consort of Autophyes.'),
('ENT_VAL_AKINETOS','Akinetos','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Immovable (Akinetos), male aeon of the Decad, consort of Syncrasis.'),
('ENT_VAL_SYNCRASIS','Syncrasis','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Commixture (Syncrasis), female aeon of the Decad, consort of Akinetos.'),
('ENT_VAL_MACARIA','Macaria (Valentinian)','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Blessedness (Macaria), female aeon of the Decad, consort of Monogenes.'),
-- Dodecad (offspring of Anthropos + Ecclesia), 6 syzygies; Pistis/Agape/Sophia + Theletos already present
('ENT_VAL_PARAKLETOS','Parakletos','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Comforter (Parakletos), male aeon of the Dodecad, consort of Pistis.'),
('ENT_VAL_PATRIKOS','Patrikos','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Paternal (Patrikos), male aeon of the Dodecad, consort of Elpis.'),
('ENT_VAL_ELPIS','Elpis (Valentinian)','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Hope (Elpis), female aeon of the Dodecad, consort of Patrikos.'),
('ENT_VAL_METRIKOS','Metrikos','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Maternal (Metrikos), male aeon of the Dodecad, consort of Agape.'),
('ENT_VAL_AEINOUS','Aeinous','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Ever-mind (Aeinous), male aeon of the Dodecad, consort of Synesis.'),
('ENT_VAL_SYNESIS','Synesis (Valentinian)','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Understanding (Synesis), female aeon of the Dodecad, consort of Aeinous.'),
('ENT_VAL_EKKLESIASTIKOS','Ekklesiastikos','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Ecclesiastical (Ekklesiastikos), male aeon of the Dodecad, consort of Makariotes.'),
('ENT_VAL_MAKARIOTES','Makariotes','Aeon/personification','Valentinian','Aeon','PER_GNO_2ND_4TH','A','reviewed','Felicity (Makariotes), female aeon of the Dodecad, consort of Ekklesiastikos.'),
-- Sophia's passions
('ENT_VAL_ENTHYMESIS','Enthymesis','Aeon/personified passion','Valentinian','Mythic process/category','PER_GNO_2ND_4TH','A','reviewed','The "intention" (Enthymesis) of Sophia: the formless, passion-laden offspring of her presumptuous desire to grasp the Father, separated from her by Horos and cast outside the Pleroma, where it becomes the lower Sophia, Achamoth (Thomassen, Spiritual Seed).'),
('ENT_VAL_LYPE','Lype','Personified passion','Valentinian','Mythic process/category','PER_GNO_2ND_4TH','A','reviewed','Grief (Lype), one of the fourfold passions of Achamoth, from which (with fear and perplexity) the material substance is formed.'),
('ENT_VAL_PHOBOS','Phobos (Valentinian)','Personified passion','Valentinian','Mythic process/category','PER_GNO_2ND_4TH','A','reviewed','Fear (Phobos), one of the fourfold passions of Achamoth.'),
('ENT_VAL_APORIA','Aporia','Personified passion','Valentinian','Mythic process/category','PER_GNO_2ND_4TH','A','reviewed','Perplexity/bewilderment (Aporia), one of the fourfold passions of Achamoth.'),
('ENT_VAL_EPISTROPHE','Epistrophe','Personified passion','Valentinian','Mythic process/category','PER_GNO_2ND_4TH','A','reviewed','Conversion/turning (Epistrophe), the redemptive passion of Achamoth — her turning back toward the light — from which the psychic substance (and the Demiurge) is formed.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources + periods ─────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, s, ev, note FROM (VALUES
 ('ENT_VAL_BYTHIOS'),('ENT_VAL_MIXIS'),('ENT_VAL_AGERATOS'),('ENT_VAL_HENOSIS'),('ENT_VAL_AUTOPHYES'),
 ('ENT_VAL_HEDONE'),('ENT_VAL_AKINETOS'),('ENT_VAL_SYNCRASIS'),('ENT_VAL_MACARIA'),
 ('ENT_VAL_PARAKLETOS'),('ENT_VAL_PATRIKOS'),('ENT_VAL_ELPIS'),('ENT_VAL_METRIKOS'),('ENT_VAL_AEINOUS'),
 ('ENT_VAL_SYNESIS'),('ENT_VAL_EKKLESIASTIKOS'),('ENT_VAL_MAKARIOTES'),
 ('ENT_VAL_ENTHYMESIS'),('ENT_VAL_LYPE'),('ENT_VAL_PHOBOS'),('ENT_VAL_APORIA'),('ENT_VAL_EPISTROPHE')
) AS t(e)
CROSS JOIN (VALUES
 ('SRC_IRENAEUS_AH','Direct attestation','Named in Irenaeus, Adv. Haer. I.1-4.'),
 ('SRC_THOMASSEN_SEED','Secondary analysis','Treated in Thomassen, The Spiritual Seed.')
) AS src(s,ev,note)
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Aeon/passion of the 2nd-c. Valentinian pleroma.', 'SRC_IRENAEUS_AH', 'reviewed'
FROM (VALUES
 ('ENT_VAL_BYTHIOS'),('ENT_VAL_MIXIS'),('ENT_VAL_AGERATOS'),('ENT_VAL_HENOSIS'),('ENT_VAL_AUTOPHYES'),
 ('ENT_VAL_HEDONE'),('ENT_VAL_AKINETOS'),('ENT_VAL_SYNCRASIS'),('ENT_VAL_MACARIA'),
 ('ENT_VAL_PARAKLETOS'),('ENT_VAL_PATRIKOS'),('ENT_VAL_ELPIS'),('ENT_VAL_METRIKOS'),('ENT_VAL_AEINOUS'),
 ('ENT_VAL_SYNESIS'),('ENT_VAL_EKKLESIASTIKOS'),('ENT_VAL_MAKARIOTES'),
 ('ENT_VAL_ENTHYMESIS'),('ENT_VAL_LYPE'),('ENT_VAL_PHOBOS'),('ENT_VAL_APORIA'),('ENT_VAL_EPISTROPHE')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Membership in the Decad / Dodecad ────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
SELECT e, 'member_of', 'ENT_VAL_DECAD', 'high', 'Aeon of the Decad (Irenaeus AH I.1.2).', 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'
FROM (VALUES ('ENT_VAL_BYTHIOS'),('ENT_VAL_MIXIS'),('ENT_VAL_AGERATOS'),('ENT_VAL_HENOSIS'),('ENT_VAL_AUTOPHYES'),('ENT_VAL_HEDONE'),('ENT_VAL_AKINETOS'),('ENT_VAL_SYNCRASIS'),('ENT_VAL_MACARIA')) AS t(e)
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
SELECT e, 'member_of', 'ENT_VAL_DODECAD', 'high', 'Aeon of the Dodecad (Irenaeus AH I.1.2).', 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'
FROM (VALUES ('ENT_VAL_PARAKLETOS'),('ENT_VAL_PATRIKOS'),('ENT_VAL_ELPIS'),('ENT_VAL_METRIKOS'),('ENT_VAL_AEINOUS'),('ENT_VAL_SYNESIS'),('ENT_VAL_EKKLESIASTIKOS'),('ENT_VAL_MAKARIOTES')) AS t(e)
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Syzygies (reciprocal spouse_of) ──────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
SELECT a, 'spouse_of', b, 'high', 'Valentinian syzygy (Irenaeus AH I.1.2).', 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'
FROM (VALUES
 ('ENT_VAL_BYTHIOS','ENT_VAL_MIXIS'),('ENT_VAL_AGERATOS','ENT_VAL_HENOSIS'),
 ('ENT_VAL_AUTOPHYES','ENT_VAL_HEDONE'),('ENT_VAL_AKINETOS','ENT_VAL_SYNCRASIS'),
 ('ENT_VAL_MONOGENES','ENT_VAL_MACARIA'),
 ('ENT_VAL_PARAKLETOS','ENT_VAL_PISTIS'),('ENT_VAL_PATRIKOS','ENT_VAL_ELPIS'),
 ('ENT_VAL_METRIKOS','ENT_VAL_AGAPE'),('ENT_VAL_AEINOUS','ENT_VAL_SYNESIS'),
 ('ENT_VAL_EKKLESIASTIKOS','ENT_VAL_MAKARIOTES')
) AS t(a,b)
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
SELECT b, 'spouse_of', a, 'high', 'Valentinian syzygy (Irenaeus AH I.1.2).', 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'
FROM (VALUES
 ('ENT_VAL_BYTHIOS','ENT_VAL_MIXIS'),('ENT_VAL_AGERATOS','ENT_VAL_HENOSIS'),
 ('ENT_VAL_AUTOPHYES','ENT_VAL_HEDONE'),('ENT_VAL_AKINETOS','ENT_VAL_SYNCRASIS'),
 ('ENT_VAL_MONOGENES','ENT_VAL_MACARIA'),
 ('ENT_VAL_PARAKLETOS','ENT_VAL_PISTIS'),('ENT_VAL_PATRIKOS','ENT_VAL_ELPIS'),
 ('ENT_VAL_METRIKOS','ENT_VAL_AGAPE'),('ENT_VAL_AEINOUS','ENT_VAL_SYNESIS'),
 ('ENT_VAL_EKKLESIASTIKOS','ENT_VAL_MAKARIOTES')
) AS t(a,b)
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Comparative-layer links for select aeons ─────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
('ENT_VAL_HENOSIS','embodies','ENT_UNION','high','The aeon Henosis is Union personified.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_SYNESIS','embodies','ENT_UNDERSTANDING','high','The aeon Synesis is Understanding personified.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_PARAKLETOS','aligned_with','ENT_GNO_HOLY_SPIRIT','medium','Parakletos (the Comforter/Paraclete) corresponds to the Holy Spirit of the wider Christian-Gnostic tradition.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Sophia's passions: the fall ──────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
('ENT_VAL_ENTHYMESIS','emanates_from','ENT_GNO_SOPHIA','high','Enthymesis is the formless passion-offspring of Sophia''s desire to grasp the Father.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_HOROS','guardian_of','ENT_GNO_PLEROMA','high','Horos (the Limit) fences the Pleroma, restoring Sophia and separating her Enthymesis to the outside.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_ACHAMOTH','identified_with','ENT_VAL_ENTHYMESIS','high','The separated Enthymesis becomes the lower Sophia, Achamoth (Thomassen, Spiritual Seed).','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_ACHAMOTH','parent_of','ENT_VAL_LYPE','high','Grief is one of Achamoth''s fourfold passions.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_ACHAMOTH','parent_of','ENT_VAL_PHOBOS','high','Fear is one of Achamoth''s fourfold passions.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_ACHAMOTH','parent_of','ENT_VAL_APORIA','high','Perplexity is one of Achamoth''s fourfold passions.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_ACHAMOTH','parent_of','ENT_VAL_EPISTROPHE','high','Conversion (her turning to the light) is the redemptive passion of Achamoth.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_PHOBOS','embodies','ENT_FEAR','high','The passion Phobos is Fear.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_LYPE','aligned_with','ENT_MISERY','medium','Grief (Lype) belongs to the family of woe/misery.','SRC_IRENAEUS_AH','PER_GNO_2ND_4TH','reviewed'),
('ENT_VAL_EPISTROPHE','aligned_with','ENT_SALVATION','medium','Epistrophe, the turning back toward the light, is the passion oriented to salvation.','SRC_THOMASSEN_SEED','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT count(*) AS unreviewed_dups FROM v_unreviewed_duplicate_entities;
-- the completed pleroma: Decad and Dodecad membership totals
SELECT o.canonical_name AS collective, count(*) AS members
FROM entity_relationships r JOIN entities o ON o.entity_id=r.object_entity_id
WHERE r.relationship_type='member_of' AND o.entity_id IN ('ENT_VAL_DECAD','ENT_VAL_DODECAD')
GROUP BY o.canonical_name ORDER BY o.canonical_name;
SELECT * FROM v_release_metrics;

COMMIT;
