-- scripts/add_phoenician_iron_age_layer.sql
-- Phoenician Iron Age tradition: the western Mediterranean transmission bridge
--
-- Phoenician religion is distinct from the Bronze Age Ugaritic/Canaanite layer
-- (already in DB as ENT_CAN_*). After the Bronze Age collapse (c. 1200 BCE),
-- the Iron Age Phoenician city-states (Tyre, Sidon, Byblos) developed their own
-- theological identities while remaining in continuity with Ugaritic tradition.
-- Through Phoenician colonization (Carthage founded c. 814 BCE traditional date),
-- mercantile networks, and the foundation of Cyprus and Mediterranean colonies,
-- Phoenician religion reached Greece, Rome, and North Africa — making it the
-- primary western Mediterranean transmission vector from the Semitic world.
--
-- Key entities:
--   Melqart (Tyre): "king of the city"; dying and rising deity; Heracles parallel
--   Eshmun (Sidon): healing deity; Asclepius parallel
--   Tanit (Carthage): queen of heaven, "Face of Baal"; Juno Caelestis parallel
--   Baal Hammon (Carthage): "Lord of the Altar of Incense"; Saturn parallel
--
-- New source: SRC_MARKOE_PHOENICIANS (Markoe 2000), SRC_HERODOTUS_HISTORIES
-- New period: PER_PHO_IRON_AGE (-1200 to -332, Levantine Phoenician)

BEGIN;

-- ── 1. New period ────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, period_name, tradition, start_year, end_year)
VALUES ('PER_PHO_IRON_AGE', 'Phoenician Iron Age', 'Phoenician', -1200, -332)
ON CONFLICT (period_id) DO NOTHING;

-- ── 2. New sources ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_MARKOE_PHOENICIANS',
   'Glenn Markoe, Phoenicians (London: British Museum Press / University of California Press, 2000)',
   NULL,
   'secondary scholarly',
   'Comprehensive survey of Phoenician civilization, religion, and culture; covers the major Phoenician deities (Melqart, Eshmun, Tanit, Baal Hammon, Astarte) and their westward transmission to Carthage and the Mediterranean world; documents inscriptional and archaeological evidence for Phoenician religion from c. 1200-332 BCE'),

  ('SRC_HERODOTUS_HISTORIES',
   'Herodotus, Histories (c. 430 BCE)',
   NULL,
   'primary text',
   'Primary Greek source for comparative religion and cultural anthropology of the Near East and Egypt; documents identifications of Arabian, Egyptian, and Phoenician deities with Greek counterparts; Herodotus 2.41-44 on Egyptian and Phoenician religion; 3.8 on Arabian deities; 2.44 explicitly describes the Phoenician Heracles/Melqart sanctuary at Tyre')
ON CONFLICT (source_id) DO NOTHING;

-- ── 3. New Phoenician entities ───────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_PHO_MELQART',
   'Melqart',
   'Phoenician',
   'State god / dying deity',
   'A',
   'Chief deity of Tyre; "Melqart" = Phoenician mlk qrt, "king of the city"; dying and rising deity with an annual awakening rite (egersis); identified with Heracles throughout the Greek and Roman world; patron of Phoenician navigation and colonization; his cult was carried to Carthage, Cyprus, Sardinia, and Cadiz; Herodotus 2.44 describes his temple at Tyre; 1 Kings 18 alludes to his prophets under the name "Baal of Tyre"'),

  ('ENT_PHO_ESHMUN',
   'Eshmun',
   'Phoenician',
   'Healing god',
   'A',
   'Chief deity of Sidon; god of healing and medicine; identified with Asclepius throughout the Greco-Roman world; his great temple complex at Sidon (the Eshmunazar II sarcophagus inscriptions attest it) was later described by Greek authors as an Asclepion; attested in Phoenician inscriptions from Sidon, Carthage, and across the western Mediterranean'),

  ('ENT_PHO_TANIT',
   'Tanit',
   'Phoenician',
   'Goddess / Queen of Heaven',
   'A',
   'Chief goddess of Carthage; "Tanit Face of Baal" (tnt pn b''l) is her standard formula in Carthaginian inscriptions; closely associated with Baal Hammon at Carthage; her distinctive "sign of Tanit" (triangle, horizontal bar, circle/head) is the most common religious symbol in the Carthaginian world; identified by Romans as Juno Caelestis (the celestial Juno) in the imperial period; related to but distinct from the Phoenician Astarte tradition'),

  ('ENT_PHO_BAAL_HAMMON',
   'Baal Hammon',
   'Phoenician',
   'Chief deity',
   'A',
   'Chief god of Carthage; "Lord of the Altar of Incense" or "Lord of Hammon"; invoked alongside Tanit as the supreme divine pair of Carthage; associated in classical sources with child sacrifice (molk ritual); identified with Kronos/Saturn by Greek and Roman writers; Diodorus Siculus 20.14 calls him "Kronos" and describes the molk rite; Tertullian attests his identification with Saturnus in North Africa')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_PHO_MELQART',    'SRC_MARKOE_PHOENICIANS',  'secondary_reference',
   'Markoe (2000) pp. 114-120 on Melqart: iconography, egersis rite, and Heracles identification'),
  ('ENT_PHO_MELQART',    'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Herodotus 2.44: description of the Tyrian Heracles (Melqart) sanctuary and two pillars'),
  ('ENT_PHO_ESHMUN',     'SRC_MARKOE_PHOENICIANS',  'secondary_reference',
   'Markoe (2000) pp. 120-122 on Eshmun and Asclepius identification; Eshmunazar sarcophagus'),
  ('ENT_PHO_TANIT',      'SRC_MARKOE_PHOENICIANS',  'secondary_reference',
   'Markoe (2000) pp. 127-132 on Tanit: sign of Tanit, Carthaginian inscriptions, Juno Caelestis'),
  ('ENT_PHO_BAAL_HAMMON','SRC_MARKOE_PHOENICIANS',  'secondary_reference',
   'Markoe (2000) pp. 122-127 on Baal Hammon: molk rite, Kronos identification, Diodorus 20.14')
ON CONFLICT DO NOTHING;

-- ── 5. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_PHO_MELQART',    'PER_PHO_IRON_AGE', 'high',
   'Melqart is the pre-eminent Iron Age Tyrian deity; Herodotus dates the Tyrian temple to c. 2750 BCE (traditional), but inscriptional attestation begins in the Iron Age',
   'SRC_MARKOE_PHOENICIANS', 'reviewed'),
  ('ENT_PHO_MELQART',    'PER_GRK_ARCHAIC',  'high',
   'Melqart-Heracles identification documented from the Archaic period onward; Greek colonies in Cyprus and Sardinia spread the cult',
   'SRC_HERODOTUS_HISTORIES', 'reviewed'),
  ('ENT_PHO_ESHMUN',     'PER_PHO_IRON_AGE', 'high',
   'Eshmun attested in Phoenician inscriptions from the Iron Age; Eshmunazar II sarcophagus (c. 450 BCE) is a primary attestation',
   'SRC_MARKOE_PHOENICIANS', 'reviewed'),
  ('ENT_PHO_TANIT',      'PER_PHO_IRON_AGE', 'high',
   'Tanit''s earliest attestations are in Carthaginian inscriptions from the 7th-6th c. BCE onward; primarily a Carthaginian figure',
   'SRC_MARKOE_PHOENICIANS', 'reviewed'),
  ('ENT_PHO_TANIT',      'PER_ROM_IMPERIAL', 'medium',
   'Identified as Juno Caelestis in Roman North Africa; worship continued well into the imperial period',
   'SRC_MARKOE_PHOENICIANS', 'reviewed'),
  ('ENT_PHO_BAAL_HAMMON','PER_PHO_IRON_AGE', 'high',
   'Baal Hammon is well-attested in Carthaginian inscriptions from the 7th c. BCE onward',
   'SRC_MARKOE_PHOENICIANS', 'reviewed'),
  ('ENT_PHO_BAAL_HAMMON','PER_ROM_IMPERIAL', 'medium',
   'Saturnus Africanus cult, the Roman form of Baal Hammon, continued through the imperial period; Tertullian attests it',
   'SRC_MARKOE_PHOENICIANS', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ──────────────────────────────────────────────────────

-- 6a. Canaanite Baal → Melqart: Iron Age Phoenician development of the Baal tradition
-- Melqart is the Iron Age Phoenician successor to the Bronze Age Baal/Hadad tradition;
-- "Baal of Tyre" = Melqart is the implication of 1 Kings 18 (Elijah vs. Baal''s prophets).
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_CAN_BAAL', 'received_as', 'ENT_PHO_MELQART',
   'medium',
   'Melqart ("king of the city") is the Iron Age Phoenician development of the Bronze Age Baal/Hadad storm-and-kingship deity tradition from Ugarit. The "Baal of Tyre" condemned in 1 Kings 16:31 (the god of Ahab''s Sidonian wife Jezebel) is identified with Melqart by scholars (Markoe 2000, Cross 1973). The dying-and-rising element of Melqart — his annual egersis (awakening) rite documented in Menander of Ephesus (via Josephus, Against Apion 1.118-119) — continues the Dumuzi/Tammuz dying-deity pattern that entered Phoenicia from Mesopotamia. The continuity between Baal (Ugaritic Bronze Age) and Melqart (Tyrian Iron Age) is strong but the Iron Age deity has a distinct city identity, making this a received_as relationship rather than a simple continuation.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_PHO_IRON_AGE'),
  ('ENT_PHO_MELQART', 'reception_of', 'ENT_CAN_BAAL',
   'medium',
   'Melqart as the Iron Age Phoenician city-specific reception of the Bronze Age Baal/Hadad storm and kingship deity; the "Baal of Tyre" in Iron Age Israelite texts.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_PHO_IRON_AGE')
ON CONFLICT DO NOTHING;

-- 6b. Dumuzi/Tammuz → Melqart: dying vegetation deity parallel in Phoenician form
-- The annual egersis (awakening) rite of Melqart parallels the Tammuz mourning ritual;
-- both involve the annual mourning and then rejoicing at the deity''s revival.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_DUMUZI_TAMMUZ', 'received_as', 'ENT_PHO_MELQART',
   'low',
   'Melqart''s annual egersis rite — in which the city of Tyre mourned the death of its divine king and then celebrated his awakening/resurrection — parallels the Mesopotamian Tammuz mourning ritual (attested at Babylon and in Ezekiel 8:14 at Jerusalem). Both rites involve (1) annual lamentation for a dying deity; (2) the deity''s descent and return from the underworld; (3) celebration of the revival. The Phoenician transmission of the dying-deity pattern from Mesopotamian Tammuz tradition is probable but not textually documented. Confidence low; structural parallel only.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_PHO_IRON_AGE'),
  ('ENT_PHO_MELQART', 'reception_of', 'ENT_MES_DUMUZI_TAMMUZ',
   'low',
   'Melqart as a possible Phoenician reception of the Mesopotamian Dumuzi/Tammuz dying-deity tradition via the annual egersis/awakening rite.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_PHO_IRON_AGE')
ON CONFLICT DO NOTHING;

-- 6c. Melqart → Heracles: the best-documented Phoenician→Greek deity transmission
-- Herodotus 2.44 explicitly describes visiting the Tyrian Heracles sanctuary and
-- concludes there are "two Heracleses" — a Phoenician original and a Greek reception.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_PHO_MELQART', 'received_as', 'ENT_HERACLES',
   'high',
   'The Melqart→Heracles identification is one of the best-documented Phoenician→Greek religious transmissions. Herodotus 2.44 explicitly states that he visited the Tyrian temple of Heracles, notes that it was far older than the Greek Heracles tradition, and concludes that there were "two Heracleses" — clearly distinguishing the Phoenician Melqart from the Greek hero. Melqart''s attributes transmitted to Heracles include: (1) the lion-skin (Melqart depicted in lion garb in Phoenician iconography); (2) the club; (3) navigation and founding of colonies (Cadiz/Gadir was a Phoenician colony with a famous Melqart-Heracles sanctuary); (4) the dying-and-apotheosis narrative (Melqart''s egersis → Heracles''s immolation and apotheosis on Oeta). The identification was standard in the Greek world by the Archaic period.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_HERACLES', 'reception_of', 'ENT_PHO_MELQART',
   'high',
   'Heracles as the Greek reception of Tyrian Melqart; Herodotus 2.44 documents the Phoenician original explicitly; lion-skin, club, colonial foundation, and dying-apotheosis narrative all transmit from Melqart to the Greek hero complex.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 6d. Eshmun → Asclepius: the healing deity identification
-- The Eshmun-Asclepius identification is attested in multiple classical sources.
-- Eshmun''s great sanctuary at Sidon (north of the Ydlal spring) was renamed
-- "the Asklepion" by Greek authors.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_PHO_ESHMUN', 'received_as', 'ENT_ASCLEPIUS',
   'high',
   'The Eshmun→Asclepius identification is extensively documented. The great Eshmun sanctuary north of Sidon — a major healing temple complex with a sacred spring — was described by Greek and Roman writers as an Asclepion, establishing a direct religious identification. The Eshmunazar II sarcophagus inscription (c. 450 BCE) names Eshmun explicitly as Sidon''s chief healing deity. Philo of Byblos (c. 100 CE, citing Sanchuniathon) identifies the Phoenician healing deity with Asclepius. Pausanias notes the "Sidonian" character of Asclepius. Both Eshmun and Asclepius preside over healing sanctuaries with sacred springs, receive offerings from the sick, and are described as divine physicians.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_GRK_CLASSICAL'),
  ('ENT_ASCLEPIUS', 'reception_of', 'ENT_PHO_ESHMUN',
   'high',
   'Asclepius as the Greek reception of the Sidonian Eshmun healing deity; the Eshmun sanctuary at Sidon was renamed Asklepion; Philo of Byblos documents the identification.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_GRK_CLASSICAL')
ON CONFLICT DO NOTHING;

-- 6e. Tanit → Juno Caelestis: North African queen of heaven in Roman guise
-- In Roman North Africa, the Carthaginian Tanit was identified with Juno Caelestis
-- (the Celestial Juno), and her worship continued under that name well into
-- the imperial period. Augustine of Hippo mentions her.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_PHO_TANIT', 'received_as', 'ENT_ROM_JUNO',
   'medium',
   'In Roman North Africa following the conquest of Carthage (146 BCE), Tanit was identified and worshipped as Juno Caelestis (the Celestial Juno). The Roman cult of Juno Caelestis at Carthage continued for centuries; her sanctuary on the Byrsa hill was one of the great temples of Roman Africa. Tertullian (Apology 24) and Augustine of Hippo mention the cult. The identification reflects shared attributes: both Tanit and Juno are queens of heaven, associated with the moon, and consorts of the chief male deity (Baal Hammon/Jupiter). Confidence medium because the identification is well-documented for the Roman period but the theological continuity between Tanit and Juno (as opposed to a superficial nomenclature overlay) is debated.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_ROM_IMPERIAL'),
  ('ENT_ROM_JUNO', 'reception_of', 'ENT_PHO_TANIT',
   'medium',
   'Juno Caelestis as the Roman form of the Carthaginian Tanit; the queen of heaven''s cult continued under a Roman name in North Africa through the imperial period.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_ROM_IMPERIAL')
ON CONFLICT DO NOTHING;

-- 6f. Baal Hammon → Saturn: child-sacrifice deity identified with the Roman Kronos
-- The identification of Baal Hammon with Kronos/Saturn is documented in Diodorus
-- Siculus (20.14) describing the molk rite, and the Saturnus Africanus cult in
-- Roman North Africa perpetuated Baal Hammon under a Roman name.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_PHO_BAAL_HAMMON', 'received_as', 'ENT_ROM_SATURN',
   'medium',
   'Diodorus Siculus 20.14 explicitly calls the god of Carthage to whom children were sacrificed "Kronos," using the Greek name for Saturn. In Roman North Africa, Baal Hammon was worshipped as Saturnus Africanus; thousands of votive stelae to Saturnus from Roman North Africa continue the Baal Hammon tradition. Tertullian (Apology 9) identifies "Saturnus" as the North African deity who receives child sacrifice. The molk rite — child sacrifice to Baal Hammon — persisted in the Saturnus Africanus cult in vestigial forms. The identification reflects shared chthonic and agricultural associations: both Saturn/Kronos and Baal Hammon are associated with time, the cycles of harvest, and the demands of divine sovereignty. Confidence medium because the theological mapping is partially opportunistic (Roman interpretatio) rather than purely functional.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_ROM_IMPERIAL'),
  ('ENT_ROM_SATURN', 'reception_of', 'ENT_PHO_BAAL_HAMMON',
   'medium',
   'Saturnus Africanus as the Roman form of the Carthaginian Baal Hammon; Diodorus Siculus documents the Kronos/Baal Hammon identification; the Saturnus cult in Roman North Africa continues Baal Hammon worship.',
   'SRC_MARKOE_PHOENICIANS', 'reviewed', 'PER_ROM_IMPERIAL')
ON CONFLICT DO NOTHING;

-- ── 7. Verification ──────────────────────────────────────────────────────────

SELECT 'phoenician_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Phoenician';

SELECT 'phoenician_chains' AS metric, COUNT(*) AS count
FROM entity_relationships
WHERE subject_entity_id LIKE 'ENT_PHO_%'
   OR object_entity_id LIKE 'ENT_PHO_%';

SELECT * FROM v_release_metrics;

COMMIT;
