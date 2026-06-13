-- scripts/add_mesopotamian_expansion.sql
-- Mesopotamian foundational expansion: Anzu, Ninsun, Gilgamesh, Enkidu, Utnapishtim
--
-- Five entities central to Mesopotamian literature that were absent from the DB:
--
--   Anzu: the divine storm bird who steals the Tablet of Destinies from Enlil;
--   defeated by Ninurta (already in DB); appears in the Old Babylonian Anzu myth
--   and the Epic of Gilgamesh; part of the Mesopotamian chaos-combat tradition.
--
--   Ninsun: "Lady Wild Cow"; divine mother of Gilgamesh; daughter of Anu and Uras;
--   priestesses at Ur; her divine lineage makes Gilgamesh "two-thirds divine."
--
--   Gilgamesh: paradigm Mesopotamian hero; king of Uruk; the oldest surviving
--   literary epic; his quest for immortality following Enkidu''s death is the
--   foundational exploration of human mortality in world literature; appears in
--   Sumerian king lists as a historical king (c. 2700 BCE); the flood narrative
--   he learns from Utnapishtim is the direct precursor to the biblical Noah story.
--
--   Enkidu: the wild man created from clay by Aruru at Anu''s command to be
--   Gilgamesh''s equal and companion; civilized through contact with Shamhat
--   (a temple priestess); his death from the Bull of Heaven''s aftermath is the
--   pivotal event that sends Gilgamesh on his quest for immortality.
--
--   Utnapishtim: the mortal who survived the flood and was granted immortality;
--   lives "at the mouth of the rivers" (the Mesopotamian paradise); tells
--   Gilgamesh the flood narrative (Tablet XI of the Epic); the direct precursor
--   to the biblical Noah; also called Ziusudra (Sumerian) or Atrahasis.
--
-- Sources: SRC_ETCSL, SRC_BLACK_GREEN_MESO (already in DB)
-- New source: SRC_GEORGE_GILGAMESH (Andrew George''s critical edition, 2003)

BEGIN;

-- ── 1. New source ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_GEORGE_GILGAMESH',
   'Andrew R. George, The Babylonian Gilgamesh Epic: Introduction, Critical Edition and Cuneiform Texts, 2 vols. (Oxford University Press, 2003)',
   NULL,
   'primary text translation',
   'The definitive critical edition of the Epic of Gilgamesh in all its versions (Old Babylonian, Middle Babylonian, Standard Babylonian, Sumerian); primary source for Gilgamesh, Enkidu, Utnapishtim, and Ninsun; essential for the flood narrative (Tablet XI), the Cedar Forest episode, the Bull of Heaven, and the quest for immortality; also covers the Sumerian Gilgamesh poems')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New entities ──────────────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_MES_ANZU',
   'Anzu',
   'Mesopotamian',
   'Chaos bird / Storm monster',
   'A',
   'Mesopotamian divine storm bird; also called Zu or Imdugud (Sumerian); the great lion-headed eagle who steals the Tablet of Destinies from Enlil, plunging heaven and earth into disorder; defeated by Ninurta (in the Old Babylonian Anzu myth; also in the Standard Babylonian version) who recaptures the Tablet; appears also in the Epic of Gilgamesh (the Anzud bird); part of the Mesopotamian chaos-combat tradition alongside Tiamat, Kingu, and other chaos beings'),

  ('ENT_MES_NINSUN',
   'Ninsun',
   'Mesopotamian',
   'Divine mother / Cow goddess',
   'A',
   '"Lady Wild Cow" (Sumerian nin = lady, sun4 = wild cow); divine mother of Gilgamesh; daughter of Anu and the earth goddess; her divine nature makes Gilgamesh "two-thirds divine" (Aga of Kish); priestesses of Ninsun are attested at Ur; known for her wisdom and ability to interpret dreams — she interprets Gilgamesh''s dreams in Tablet I of the Epic; adopts Enkidu as her son before the Cedar Forest expedition; a divine mother figure whose wisdom supports the hero'),

  ('ENT_MES_GILGAMESH',
   'Gilgamesh',
   'Mesopotamian',
   'Hero / Semi-divine king',
   'A',
   'King of Uruk (c. 2700 BCE per Sumerian king lists); "two-thirds divine, one-third mortal" (son of Ninsun and the lugal Lugalbanda); protagonist of the oldest surviving literary epic; his exploits include: building Uruk''s walls, journeying to the Cedar Forest with Enkidu to defeat Humbaba, rejecting Ishtar''s proposal, slaying the Bull of Heaven (with Enkidu), and after Enkidu''s death, seeking immortality from Utnapishtim; his failure to retain the plant of immortality and Utanapishtim''s counsel ("when the gods created humanity they allotted death to humanity, but life they retained in their own keeping") is the foundational literary statement on human mortality'),

  ('ENT_MES_ENKIDU',
   'Enkidu',
   'Mesopotamian',
   'Wild man / Hero companion',
   'A',
   'Created from clay by the goddess Aruru at Anu''s command to be the equal of Gilgamesh and check his oppressive rule; born wild among animals; civilized through a seven-day encounter with the temple priestess Shamhat; becomes Gilgamesh''s closest companion and equal in battle; the two defeat Humbaba and the Bull of Heaven together; the gods decree his death as punishment for the latter; his deathbed lament and Gilgamesh''s mourning are the emotional core of the Epic; the first great literary treatment of friendship and loss'),

  ('ENT_MES_UTNAPISHTIM',
   'Utnapishtim',
   'Mesopotamian',
   'Flood survivor / Immortal mortal',
   'A',
   'The Mesopotamian flood hero; warned by Ea/Enki to build a boat and save his family and the seed of all living things before the gods sent the flood; after the flood, granted immortality by the gods and placed "at the mouth of the rivers" (a paradise at the edge of the world); Gilgamesh travels to him seeking the secret of immortality; he reveals the flood narrative (Tablet XI) and directs Gilgamesh to the plant of immortality (which Gilgamesh then loses); also called Ziusudra (Sumerian version of the flood story) and Atrahasis (from the Atrahasis Epic, c. 1700 BCE); the direct precursor to the biblical Noah')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_MES_ANZU',        'SRC_BLACK_GREEN_MESO',   'primary_attestation',
   'Black and Green (1992) pp. 106-107: Anzu/Zu/Imdugud iconography and myth summary'),
  ('ENT_MES_ANZU',        'SRC_ETCSL',              'primary_attestation',
   'ETCSL: Sumerian Anzu myth (Lugalbanda and the Anzud Bird); Ninurta-Anzu myth texts'),
  ('ENT_MES_NINSUN',      'SRC_GEORGE_GILGAMESH',   'primary_attestation',
   'Epic of Gilgamesh Tablet I-III: Ninsun as Gilgamesh''s mother, dream interpreter, adopts Enkidu'),
  ('ENT_MES_NINSUN',      'SRC_BLACK_GREEN_MESO',   'secondary_reference',
   'Black and Green (1992) p. 141: Ninsun entry; cow goddess, divine mother, cult at Ur'),
  ('ENT_MES_GILGAMESH',   'SRC_GEORGE_GILGAMESH',   'primary_attestation',
   'Andrew George (2003): the definitive edition; all tablets of the Standard Babylonian Epic and Sumerian precursor poems'),
  ('ENT_MES_GILGAMESH',   'SRC_ETCSL',              'primary_attestation',
   'ETCSL: five Sumerian Gilgamesh poems (Bilgames and Akka, Bilgames and the Bull of Heaven, etc.)'),
  ('ENT_MES_ENKIDU',      'SRC_GEORGE_GILGAMESH',   'primary_attestation',
   'Epic of Gilgamesh Tablets I-VIII: Enkidu''s creation, civilization, friendship with Gilgamesh, death'),
  ('ENT_MES_UTNAPISHTIM', 'SRC_GEORGE_GILGAMESH',   'primary_attestation',
   'Epic of Gilgamesh Tablet XI: the flood narrative; Utnapishtim''s immortality; the plant of life'),
  ('ENT_MES_UTNAPISHTIM', 'SRC_ETCSL',              'primary_attestation',
   'ETCSL: Atrahasis Epic (the Sumerian flood narrative); Ziusudra version')
ON CONFLICT DO NOTHING;

-- ── 4. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_MES_ANZU',        'PER_MES_OLD_BAB', 'high',
   'Old Babylonian Anzu myth (c. 1700 BCE) is the earliest full version; iconographic attestation goes back to the Early Dynastic period',
   'SRC_BLACK_GREEN_MESO', 'reviewed'),
  ('ENT_MES_NINSUN',      'PER_MES_OLD_BAB', 'high',
   'Ninsun attested in Old Babylonian versions of the Gilgamesh Epic (c. 1800-1600 BCE); cult at Ur documented in the Ur III period',
   'SRC_GEORGE_GILGAMESH', 'reviewed'),
  ('ENT_MES_GILGAMESH',   'PER_MES_EARLY',   'medium',
   'Gilgamesh appears in the Sumerian king list as a king of Uruk in the Early Dynastic period (c. 2700 BCE); Sumerian Gilgamesh poems date to c. 2100-2000 BCE (Ur III period)',
   'SRC_ETCSL', 'reviewed'),
  ('ENT_MES_GILGAMESH',   'PER_MES_OLD_BAB', 'high',
   'Old Babylonian Epic of Gilgamesh (c. 1700 BCE) is the most developed early version; the Standard Babylonian version (Sin-leqi-unninni, c. 1200 BCE) is the canonical form',
   'SRC_GEORGE_GILGAMESH', 'reviewed'),
  ('ENT_MES_ENKIDU',      'PER_MES_OLD_BAB', 'high',
   'Enkidu appears in Old Babylonian Gilgamesh texts (c. 1700 BCE) and in Sumerian precursor poems',
   'SRC_GEORGE_GILGAMESH', 'reviewed'),
  ('ENT_MES_UTNAPISHTIM', 'PER_MES_OLD_BAB', 'high',
   'Utnapishtim/Atrahasis flood narrative attested in the Atrahasis Epic (c. 1700 BCE) and the Old Babylonian Gilgamesh texts; Ziusudra version in Sumerian is slightly older',
   'SRC_GEORGE_GILGAMESH', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 5. Internal relationships ────────────────────────────────────────────────

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  -- Ninsun is Gilgamesh''s divine mother
  ('ENT_MES_NINSUN', 'parent_of', 'ENT_MES_GILGAMESH',
   'high',
   'Ninsun is explicitly named as Gilgamesh''s divine mother throughout the Epic; her divine nature is what makes Gilgamesh "two-thirds divine" and gives him his extraordinary strength and beauty. She appears in Tablets I-III as the interpreter of his dreams and the one who adopts Enkidu before their Cedar Forest journey.',
   'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_MES_OLD_BAB'),
  ('ENT_MES_GILGAMESH', 'child_of', 'ENT_MES_NINSUN',
   'high',
   'Gilgamesh as son of the divine Ninsun; his two-thirds divine nature derives from her.',
   'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_MES_OLD_BAB'),

  -- Gilgamesh and Enkidu: the paradigm hero-companion pair
  ('ENT_MES_GILGAMESH', 'paired_with', 'ENT_MES_ENKIDU',
   'high',
   'Gilgamesh and Enkidu are the paradigm hero-companion pair in world literature; created to be Gilgamesh''s equal, Enkidu becomes his closest companion; together they defeat Humbaba in the Cedar Forest and the Bull of Heaven; Enkidu''s death is the pivotal event of the Epic that launches Gilgamesh on his quest for immortality.',
   'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_MES_OLD_BAB'),
  ('ENT_MES_ENKIDU', 'paired_with', 'ENT_MES_GILGAMESH',
   'high',
   'Enkidu as Gilgamesh''s equal companion; their relationship is the emotional core of the Epic.',
   'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_MES_OLD_BAB'),

  -- Ninurta defeats Anzu (already have Ninurta)
  ('ENT_MES_NINURTA', 'slays', 'ENT_MES_ANZU',
   'high',
   'In the Anzu myth, Ninurta is the divine champion chosen by the assembly of gods to fight Anzu and recover the stolen Tablet of Destinies; after several failed attempts using conventional weapons (which Anzu deflects using the Tablet''s power), Ninurta defeats Anzu through a strategy devised by Ea/Enki. This combat establishes Ninurta as the paradigm warrior deity in the Mesopotamian tradition.',
   'SRC_BLACK_GREEN_MESO', 'reviewed', 'PER_MES_OLD_BAB')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ──────────────────────────────────────────────────────

-- Utnapishtim → Noah: the most directly documented Mesopotamian→Israelite narrative
-- transmission; the flood narrative in Genesis 6-9 parallels the Atrahasis Epic
-- and the Gilgamesh Tablet XI in structure, detail (dove/raven), and outcome.
-- Check if ENT_ISR_NOAH exists first (it may not).

-- We add the chain regardless; if ENT_ISR_NOAH doesn''t exist yet, the
-- relationship will document the transmission when the Israelite layer is expanded.
-- Using ON CONFLICT DO NOTHING protects against already-existing chains.
DO $$
BEGIN
  -- Only insert if ENT_ISR_NOAH exists as an entity
  IF EXISTS (SELECT 1 FROM entities WHERE entity_id = 'ENT_ISR_NOAH') THEN
    INSERT INTO entity_relationships
      (subject_entity_id, relationship_type, object_entity_id,
       confidence, rationale, source_id, review_status, period_id)
    VALUES
      ('ENT_MES_UTNAPISHTIM', 'received_as', 'ENT_ISR_NOAH',
       'high',
       'The flood narrative in Genesis 6-9 (the Noah story) is the most directly documented case of Mesopotamian→Israelite literary transmission. The parallels between the Atrahasis Epic (c. 1700 BCE) and the Gilgamesh Tablet XI flood account on one side, and Genesis on the other, are structural (divine decree to destroy humanity, one righteous man warned, boat/ark, animals saved, flood, birds released to find dry land, offering after flood, divine promise not to repeat) and verbal (the dove/raven release). The Israelites'' contact with Babylonian flood traditions occurred during and after the Babylonian exile (586-538 BCE) when they had direct access to the Atrahasis and Gilgamesh traditions. This is one of the highest-confidence cross-traditional narrative transmissions in the dataset.',
       'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_ISR_EXILIC'),
      ('ENT_ISR_NOAH', 'reception_of', 'ENT_MES_UTNAPISHTIM',
       'high',
       'Noah as the Israelite reception of the Mesopotamian flood hero tradition (Utnapishtim/Atrahasis/Ziusudra); the Genesis flood narrative''s detailed parallels with the Atrahasis Epic and Gilgamesh Tablet XI demonstrate direct literary transmission, most plausibly during the Babylonian exile.',
       'SRC_GEORGE_GILGAMESH', 'reviewed', 'PER_ISR_EXILIC')
    ON CONFLICT DO NOTHING;
  END IF;
END $$;

-- ── 7. Verification ──────────────────────────────────────────────────────────

SELECT 'mesopotamian_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Mesopotamian';

SELECT 'utnapishtim_noah_chain' AS metric,
       CASE WHEN EXISTS (
         SELECT 1 FROM entity_relationships
         WHERE subject_entity_id = 'ENT_MES_UTNAPISHTIM'
           AND object_entity_id = 'ENT_ISR_NOAH'
       ) THEN 'linked' ELSE 'ENT_ISR_NOAH not yet in DB — chain deferred' END AS status;

SELECT * FROM v_release_metrics;

COMMIT;
