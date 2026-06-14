-- expand_syncretic_zero_rel_v1.sql
-- Clears all 10 remaining zero-rel entities across syncretic/minor traditions:
--   Greek/Anatolian: ENT_CORYBANTES
--   Greek/Phrygian: ENT_MARSYAS
--   Greek/Phrygian/Cretan: ENT_DACTYLS
--   Greek/Rhodian: ENT_TELCHINES
--   Greek/Roman: ENT_SIBYL, ENT_TELESPHORUS, ENT_TRIVIA
--   South Arabian: ENT_SAB_AMM, ENT_SAB_SHAMS
--   Thelemic: ENT_THL_HADIT
--
-- Sources: SRC_APOLLODORUS_LIBRARY, SRC_HOMERIC_HYMNS, SRC_OVID_FASTI,
--          SRC_THEOI_DAIMONES

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT COUNT(*) AS total_zero_rel_before FROM entities e
WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id);


-- ── Greek/Anatolian ───────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- CORYBANTES: Anatolian ecstatic attendants of the Great Mother (Cybele/Rhea)
  ('ENT_RHEA','patron_of','ENT_CORYBANTES',
    'high','The Corybantes are the Anatolian/Phrygian armed, ecstatic attendants of the Great Mother (Cybele/Rhea); they perform ecstatic dances to protect the goddess and drown the cries of the infant Zeus. Strabo Geography 10.3.19; Homeric Hymn to Cybele context.','SRC_HOMERIC_HYMNS','approved'),
  ('ENT_CORYBANTES','paired_with','ENT_KORYBANTES',
    'high','Corybantes (Greek/Anatolian tradition label) and Korybantes are two romanisation variants of the same tradition of armed ecstatic attendants of the Great Mother; the paired_with marks their identity.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Greek/Phrygian ────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- MARSYAS: satyr who challenged Apollo and was flayed (Apollodorus 1.4.2)
  ('ENT_APOLLO','opposes','ENT_MARSYAS',
    'high','Pseudo-Apollodorus Library 1.4.2: Marsyas, a Phrygian satyr, found Athena''s discarded aulos and learned to play it; he challenged Apollo to a music contest. Apollo won, and flayed Marsyas alive, hanging his skin on a pine tree.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_MARSYAS','opposes','ENT_APOLLO',
    'high','Pseudo-Apollodorus Library 1.4.2: see ENT_APOLLO opposes ENT_MARSYAS — Marsyas issued the music contest challenge against Apollo.','SRC_APOLLODORUS_LIBRARY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Greek/Phrygian/Cretan ─────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- DACTYLS: divine craftsmen of Mount Ida (Crete and/or Phrygia)
  ('ENT_RHEA','patron_of','ENT_DACTYLS',
    'high','The Dactyls (Idaean Fingers) are divine craftsmen associated with Mount Ida in Crete; they are attendants of Rhea/Cybele, credited with the discovery of iron-working and magic. Diodorus Siculus 5.64; Theoi Daimones.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_DACTYLS','paired_with','ENT_CURETES',
    'high','The Dactyls and Curetes are parallel groups of Cretan/Anatolian divine craftsmen and ritual attendants of the Great Mother; they frequently overlap in myth and are sometimes treated as the same group.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Greek/Rhodian ─────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- TELCHINES: divine craftsmen of Rhodes who forged Poseidon's trident
  ('ENT_POSEIDON','patron_of','ENT_TELCHINES',
    'high','The Telchines were the original divine craftsmen of Rhodes; they forged the sickle of Cronus, the trident of Poseidon, and were the first to work metal. Poseidon is their primary patron deity. Diodorus Siculus 5.55; Theoi Daimones.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Greek/Roman ───────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- SIBYL: prophetess patron'd by Apollo (Homeric Hymn to Apollo; Ovid)
  ('ENT_APOLLO','patron_of','ENT_SIBYL',
    'high','The Sibyls (notably the Cumaean Sibyl) prophesy through the gift of Apollo; Ovid Metamorphoses 14.130-155 tells how Apollo offered the Sibyl anything she wished and she chose long life. Apollo is the source and patron of sibylline prophecy.','SRC_OVID_FASTI','approved'),
  ('ENT_SIBYL','reveals','ENT_APOLLO',
    'high','The Sibyl reveals and transmits Apollo''s prophecies; she is his earthly mouthpiece, uttering oracles in a state of divine possession by the god.','SRC_OVID_FASTI','approved'),
  -- TELESPHORUS: healing daimon, companion of Asclepius
  ('ENT_ASCLEPIUS','patron_of','ENT_TELESPHORUS',
    'high','Telesphorus ("he who brings completion/recovery") is a Graeco-Roman healing daimon who accompanies Asclepius; he is the personification of convalescence, depicted as a hooded dwarf standing beside the healer god. Theoi Daimones.','SRC_THEOI_DAIMONES','approved'),
  -- TRIVIA: Latin name for Hecate at the crossroads (Ovid Fasti 1.141; Virgil Aeneid)
  ('ENT_TRIVIA','reception_of','ENT_HECATE',
    'high','Trivia ("Three Roads") is the Latin epithet and functional reception of the Greek Hecate as goddess of crossroads; Ovid Metamorphoses 7.177 calls Hecate "Trivia," and the Aeneid 6.13 treats them as the same deity under different names.','SRC_OVID_FASTI','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── South Arabian ─────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- ʿAMM: South Arabian moon deity; equated with the Semitic moon god Sin
  ('ENT_SAB_AMM','equated_with','ENT_SIN',
    'medium','ʿAmm is a South Arabian (Qatabanian) moon deity; his name means "Paternal Uncle" and he is the chief deity of the Qatabanian kingdom. He is identified with the broader Semitic moon-god tradition represented by Sin/Nanna in Mesopotamia.','SRC_THEOI_DAIMONES','approved'),
  -- SHAMS: South Arabian sun deity (feminine); equated with solar deities broadly
  ('ENT_SAB_SHAMS','equated_with','ENT_MES_UTU_SHAMASH',
    'medium','Shams is the South Arabian sun deity (the name cognate with Semitic šmš, "sun"); she is identified with the Semitic solar deity tradition represented by Utu/Shamash in Mesopotamia and with the South Arabian solar goddess tradition.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_SAB_AMM','paired_with','ENT_SAB_SHAMS',
    'medium','In the South Arabian pantheon, ʿAmm (Moon) and Shams (Sun) are the complementary celestial deity pair; their pairing reflects the widespread ancient Near Eastern dyad of moon and sun deity.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_SAB_SHAMS','paired_with','ENT_SAB_AMM',
    'medium','See ENT_SAB_AMM paired_with ENT_SAB_SHAMS.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Thelemic ─────────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- HADIT: the winged serpent/point of view, paired with Nuit (Liber AL vel Legis 2)
  ('ENT_THL_HADIT','paired_with','ENT_THL_NUIT',
    'high','Aleister Crowley, Liber AL vel Legis (Book of the Law) Chapter 2: Hadit is the second speaker of the Book of the Law, the winged serpent and point of infinite contraction, who forms the divine dyad with Nuit (infinite expansion/stars). "Every man and every woman is a star" — Hadit is the inner point, Nuit the outer circle.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_THL_HADIT','paired_with','ENT_THL_RA_HOOR_KHUIT',
    'high','Liber AL vel Legis Chapter 3: Ra-Hoor-Khuit (Horus as ruler) is the third member of the Thelemic divine triad; Hadit is his inner "secret flame," and the two are identified in Chapter 3 as dual aspects of the same solar-war current.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;
SELECT COUNT(*) AS total_zero_rel_after FROM entities e
WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id);

-- Any remaining?
SELECT tradition, entity_id, canonical_name FROM entities e
WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id)
ORDER BY tradition, entity_id;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
