-- add_jesus_christ_entities.sql
-- Adds the two primary Jesus entities missing from DeityDB:
--
--   1. ENT_JESUS_CHRIST (tradition: Christian)
--      Jesus of Nazareth as Messiah and incarnate Logos; canonical Christian figure
--      around whom the entire Christian entity cluster (Mary, apostles, Antichrist,
--      angels, saints) is already organised.
--
--   2. ENT_ISL_ISA (tradition: Islamic)
--      ʿĪsā ibn Maryam; Quranic prophet and messenger, not divine.
--      Distinct from ENT_JESUS_CHRIST in theology and emphasis; modelled
--      as reception_of rather than identified_with.
--
-- Also adds the missing primary source:
--   SRC_NEW_TESTAMENT — exact mirror of SRC_HEBREW_BIBLE in structure.
--
-- Reception chain wired:
--   ENT_GNO_CHRIST         → reception_of → ENT_JESUS_CHRIST  (Nag Hammadi)
--   ENT_MANICH_JESUS_SPLENDOUR → reception_of → ENT_JESUS_CHRIST  (Manichaean)
--   ENT_THO_LIVING_JESUS   → reception_of → ENT_JESUS_CHRIST  (Gospel of Thomas)
--   ENT_ISL_ISA            → reception_of → ENT_JESUS_CHRIST  (Quran)
--
-- Zero new dangling references; zero entity_id collisions expected.

BEGIN;

-- ── Pre-flight ─────────────────────────────────────────────────────────────
SELECT COUNT(*) AS entities_before        FROM entities;
SELECT COUNT(*) AS relationships_before   FROM entity_relationships;
SELECT COUNT(*) AS sources_before         FROM sources;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: SOURCE — New Testament primary text
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO sources (source_id, title, source_type)
VALUES (
    'SRC_NEW_TESTAMENT',
    'New Testament (primary text; Greek: Nestle-Aland 28th ed.; citations by book, chapter, and verse)',
    'primary text'
)
ON CONFLICT (source_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: ENTITY — Jesus Christ (Christian)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entities (
    entity_id, canonical_name, tradition, entity_type, category,
    primary_domains, cult_scope,
    evidence_confidence, review_status, inclusion_basis, short_note
) VALUES (
    'ENT_JESUS_CHRIST',
    'Jesus Christ',
    'Christian',
    'Messiah/incarnate Logos',
    'Revealer Figure',
    'salvation; healing; revelation; incarnation; resurrection',
    'Christian',
    'A',
    'candidate_verified_name',
    'Christian core figure',
    'Jesus of Nazareth; venerated in Christian theology as the Messiah (Hebrew māšîaḥ, Greek Christos), Son of God, and incarnate Logos (John 1:14). Attested in the four canonical Gospels, the Pauline epistles, Acts, and Revelation. Born to Mary in Bethlehem; baptised by John the Baptist; conducted a healing and teaching ministry in Galilee and Judaea; crucified under Pontius Pilate (c. 30 CE); proclaimed resurrected on the third day. Central referent for the entire Christian tradition in the DB: Mary Theotokos, the apostles, the angelic hierarchy, the Antichrist, and the hagiographic saints all cluster around this figure. Received variously as the Gnostic pneumatic Christ (ENT_GNO_CHRIST), the Manichaean Jesus Splendour (ENT_MANICH_JESUS_SPLENDOUR), the Living Jesus of Thomas (ENT_THO_LIVING_JESUS), and the Quranic prophet ʿĪsā ibn Maryam (ENT_ISL_ISA).'
)
ON CONFLICT (entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: ENTITY — ʿĪsā ibn Maryam (Islamic)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entities (
    entity_id, canonical_name, tradition, entity_type, category,
    primary_domains, cult_scope,
    evidence_confidence, review_status, inclusion_basis, short_note
) VALUES (
    'ENT_ISL_ISA',
    'ʿĪsā ibn Maryam',
    'Islamic',
    'Prophet/messenger',
    'Holy Figure',
    'prophecy; healing; revelation; eschatology',
    'Islamic',
    'A',
    'candidate_verified_name',
    'Primary Quranic attestation: Suras 3:45-49, 4:157-159, 5:110-117, 19:16-33',
    'ʿĪsā ibn Maryam (Jesus son of Mary); Quranic prophet and messenger of God. Born of a virgin birth (Quran 19:20-22), confirmed by miracles including healing the blind and lepers and raising the dead (Quran 3:49), and given the Injīl (Gospel). Explicitly not divine in Islamic theology: "He was only a messenger of Allah" (Quran 4:171). One of the five Ulu al-Azm (Prophets of Firm Resolve) along with Noah, Abraham, Moses, and Muhammad. Islamic eschatology holds that ʿĪsā will return before the Day of Judgment to defeat the Dajjal (Quran 43:61; Hadith tradition). The Quranic ʿĪsā is the Islamic reception of the Jesus tradition (ENT_JESUS_CHRIST); the two figures share the virgin birth and healing miracles but diverge sharply on christology.'
)
ON CONFLICT (entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: ENTITY SOURCES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_JESUS_CHRIST','SRC_NEW_TESTAMENT','primary_attestation',
    'Named and described throughout the four canonical Gospels, Pauline epistles, Acts, and Revelation.'),
  ('ENT_JESUS_CHRIST','SRC_DDD_CHRISTIAN','secondary_reference',
    'Attested in Dictionary of Deities and Demons in the Bible, Christian entries.'),
  ('ENT_JESUS_CHRIST','SRC_DDD_BIBLE','secondary_reference',
    'Attested in Dictionary of Deities and Demons in the Bible.'),
  ('ENT_ISL_ISA','SRC_QURAN','primary_attestation',
    'Named as ʿĪsā ibn Maryam in Suras 3:45-49, 4:157-159, 5:110-117, 19:16-33 and elsewhere.'),
  ('ENT_ISL_ISA','SRC_ISLAM_EI2','secondary_reference',
    'Attested in Encyclopaedia of Islam (EI2), article "ʿĪsā".')
ON CONFLICT DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 5: RELATIONSHIPS — ENT_JESUS_CHRIST (Christian tradition)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- Mary is mother of Jesus (Matt 1:18; Luke 1:31-35)
  ('ENT_SAINT_MARY','parent_of','ENT_JESUS_CHRIST',
    'high',
    'New Testament (Matthew 1:18; Luke 1:31-35): Mary conceives Jesus by the Holy Spirit and gives birth.',
    'SRC_NEW_TESTAMENT','approved'),

  -- John the Baptist reveals/announces Jesus (John 1:29-34; Mark 1:7-8)
  ('ENT_SAINT_JOHN_BAPTIST','reveals','ENT_JESUS_CHRIST',
    'high',
    'New Testament (John 1:29-34; Mark 1:7-8): John the Baptist announces and baptises Jesus, declaring him the Lamb of God.',
    'SRC_NEW_TESTAMENT','approved'),

  -- Jesus heals — core Gospel witness (Matthew 8-9; Mark 1:29-34; Luke 7:21-22)
  ('ENT_JESUS_CHRIST','patron_of','ENT_HEALING',
    'high',
    'New Testament (Matthew 8-9; Mark 1:29-34; Luke 7:21-22): Jesus heals the sick, blind, lepers, and raises the dead throughout the Synoptic and Johannine traditions.',
    'SRC_NEW_TESTAMENT','approved'),

  -- Jesus as savior/redeemer (John 3:16-17; Matthew 1:21; Luke 2:11)
  ('ENT_JESUS_CHRIST','savior_of','ENT_SALVATION',
    'high',
    'New Testament (John 3:16-17; Matthew 1:21; Luke 2:11): Jesus named explicitly as savior and his mission defined as saving his people from sin.',
    'SRC_NEW_TESTAMENT','approved'),

  -- Jesus reveals God — Johannine prologue (John 1:14-18)
  ('ENT_JESUS_CHRIST','reveals','ENT_REVELATION',
    'high',
    'New Testament (John 1:18; John 14:9): Jesus as the incarnate Logos who makes the Father known; "he who has seen me has seen the Father."',
    'SRC_NEW_TESTAMENT','approved'),

  -- Devil opposes Jesus — temptation in the wilderness (Matt 4:1-11; Luke 4:1-13)
  ('ENT_CHR_DEVIL','opposes','ENT_JESUS_CHRIST',
    'high',
    'New Testament (Matthew 4:1-11; Luke 4:1-13): the Devil tempts Jesus three times in the wilderness.',
    'SRC_NEW_TESTAMENT','approved'),

  -- Antichrist opposes Jesus — NT and patristic (1 John 2:22; 2 Thess 2:4)
  ('ENT_CHR_ANTICHRIST','opposes','ENT_JESUS_CHRIST',
    'high',
    'New Testament (1 John 2:22; 2 Thessalonians 2:4): the Antichrist figure is defined by opposition to Christ.',
    'SRC_NEW_TESTAMENT','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 6: RELATIONSHIPS — ENT_ISL_ISA (Islamic tradition)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- Mary (Maryam) is mother of ʿĪsā (Quran 19:22-27)
  ('ENT_SAINT_MARY','parent_of','ENT_ISL_ISA',
    'high',
    'Quran 19:22-27 (Sura Maryam): Maryam conceives ʿĪsā by divine command and gives birth.',
    'SRC_QURAN','approved'),

  -- ʿĪsā heals the sick (Quran 3:49)
  ('ENT_ISL_ISA','patron_of','ENT_HEALING',
    'high',
    'Quran 3:49: "I will heal the blind and the leper, and bring the dead to life, by God''s permission."',
    'SRC_QURAN','approved'),

  -- ʿĪsā reveals Gospel (Injīl) — Quran 57:27
  ('ENT_ISL_ISA','reveals','ENT_REVELATION',
    'high',
    'Quran 57:27: God gave ʿĪsā the Injīl (Gospel) as revealed scripture; 5:46 confirms him as bearer of the Injīl.',
    'SRC_QURAN','approved'),

  -- ʿĪsā is Islamic reception of the Jesus tradition
  ('ENT_ISL_ISA','reception_of','ENT_JESUS_CHRIST',
    'high',
    'Quran 3:45-49; 19:16-33: the Quranic ʿĪsā ibn Maryam draws on and reinterprets the Jesus tradition while rejecting divinity; the figure shares virgin birth, miracles, and the Injīl but reframes them within Islamic monotheism.',
    'SRC_QURAN','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 7: RECEPTION CHAIN — wire existing Christ-figures to ENT_JESUS_CHRIST
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- Gnostic pneumatic Christ is a reception of the historical Jesus tradition
  ('ENT_GNO_CHRIST','reception_of','ENT_JESUS_CHRIST',
    'high',
    'Nag Hammadi Library passim: Gnostic texts draw on and radically reinterpret the Jesus tradition, positing a docetic/pneumatic Christ who merely appeared to suffer.',
    'SRC_NHC','approved'),

  -- Manichaean Jesus Splendour is a reception of Jesus
  ('ENT_MANICH_JESUS_SPLENDOUR','reception_of','ENT_JESUS_CHRIST',
    'high',
    'Manichaean Psalm Book; Kephalaia: Mani drew on the Jesus tradition and recast Jesus as the cosmic lightworld figure Jesus Splendour.',
    'SRC_MANICHAEAN_PSALM_BOOK','approved'),

  -- Thomasine Living Jesus is a reception of Jesus
  ('ENT_THO_LIVING_JESUS','reception_of','ENT_JESUS_CHRIST',
    'high',
    'Gospel of Thomas incipit (NHC II,2): "These are the hidden words which the living Jesus spoke." The Living Jesus is the Thomasine reception of the Jesus tradition.',
    'SRC_NHC','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight verification ───────────────────────────────────────────────

SELECT COUNT(*) AS entities_after       FROM entities;
SELECT COUNT(*) AS relationships_after  FROM entity_relationships;
SELECT COUNT(*) AS sources_after        FROM sources;

-- Verify both new entities present with correct tradition
SELECT entity_id, canonical_name, tradition, entity_type, category
FROM entities
WHERE entity_id IN ('ENT_JESUS_CHRIST','ENT_ISL_ISA')
ORDER BY entity_id;

-- Verify new source
SELECT source_id, title FROM sources WHERE source_id = 'SRC_NEW_TESTAMENT';

-- Verify all relationships for the two new entities
SELECT s.canonical_name, r.relationship_type, o.canonical_name AS object, r.source_id
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE r.subject_entity_id IN ('ENT_JESUS_CHRIST','ENT_ISL_ISA','ENT_SAINT_MARY',
    'ENT_SAINT_JOHN_BAPTIST','ENT_GNO_CHRIST','ENT_MANICH_JESUS_SPLENDOUR',
    'ENT_THO_LIVING_JESUS','ENT_CHR_DEVIL','ENT_CHR_ANTICHRIST')
  AND (r.object_entity_id = 'ENT_JESUS_CHRIST'
    OR r.subject_entity_id IN ('ENT_JESUS_CHRIST','ENT_ISL_ISA'))
ORDER BY s.canonical_name, r.relationship_type;

-- Zero dangling references
SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
