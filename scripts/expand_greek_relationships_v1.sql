-- expand_greek_relationships_v1.sql
-- Batch 1 of Greek relationship graph expansion.
-- Adds ~90 typed relationships covering:
--   1. Titan genealogies (Hesiod Theogony 132-520)
--      - Uranus/Gaia parent_of all 11 non-Cronus Titans
--      - Hyperion×Theia, Crius×Eurybia, Coeus×Phoebe, Iapetus×Clymene,
--        Perses×Asteria spousal + parent_of chains
--      - Oceanus×Tethys spousal pair
--   2. Olympian genealogical gaps (Hesiod Theogony 453-930)
--      - Cronus/Rhea parent_of Hestia, Demeter
--      - Zeus parent_of Persephone
--      - Leto parent_of Apollo, Artemis
--      - Hera parent_of Hephaestus (parthenogenic version, Theogony 927-929)
--      - Poseidon×Amphitrite spousal pair
--      - Eos parent_of Memnon (Theogony 984-985)
--   3. Domain patron_of for thin Olympians (Homeric Hymns)
--      - Helios patron_of Sun; Selene patron_of Moon
--      - Demeter patron_of Agriculture; Hestia patron_of Fire
--      - Hades rules Underworld
--   4. Hero genealogies (Apollodorus Library + Homer Iliad)
--      - Zeus parent_of: Heracles, Perseus, Helen, Minos, Rhadamanthys, Aeacus
--      - Poseidon parent_of Theseus; Theseus parent_of Hippolytus
--      - Thetis parent_of Achilles; Apollo parent_of Ion
--      - Oceanus parent_of Clymene Titaness (Theogony 508 "daughter of Okeanos")
--   5. Hero narrative relationships (Homer Iliad)
--      - Achilles opposes/slays Hector; Ajax opposes Hector
--      - Jason spouse_of Medea; Menelaus spouse_of Helen (and inverses)
--
-- Sources used:
--   SRC_HESIOD_THEOGONY     — canonical Titan/Olympian genealogy
--   SRC_HOMERIC_HYMNS       — patron domains
--   SRC_HOMER_ILIAD_ODYSSEY — hero narrative, Thetis/Achilles
--   SRC_APOLLODORUS_LIBRARY — hero genealogies
--
-- All INSERTs use ON CONFLICT DO NOTHING against the
-- unique constraint (subject_entity_id, relationship_type, object_entity_id).
-- Zero new entity_id values are created; zero dangling refs will result.

BEGIN;

-- ── Pre-flight metrics ─────────────────────────────────────────────────────
SELECT COUNT(*) AS total_relationships_before      FROM entity_relationships;
SELECT COUNT(*) AS greek_relationships_before
  FROM entity_relationships r
  JOIN entities s ON s.entity_id = r.subject_entity_id
  WHERE s.tradition = 'Greek';
SELECT COUNT(*) AS greek_zero_rel_entities_before
  FROM entities e
  WHERE e.tradition = 'Greek'
    AND NOT EXISTS (
      SELECT 1 FROM entity_relationships r
      WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id
    );


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: URANUS + GAIA → TWELVE TITANS (Theogony 132-138)
-- "...deep-swirling Okeanos, Koios, Kreios, Hyperion, Iapetos,
--  Theia, Rheia, Themis, Mnemosyne, gold-crowned Phoibe, and lovely Tethys."
-- (Cronus already linked; adding the other eleven.)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_URANUS','parent_of','ENT_OCEANUS',  'high','Hesiod Theogony 132-138: Ouranos and Gaia beget the twelve Titans.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_COEUS',    'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_CRIUS',    'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_HYPERION', 'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_IAPETUS',  'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_THEIA',    'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_RHEA',     'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_THEMIS',   'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_MNEMOSYNE','high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_PHOEBE',   'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_URANUS','parent_of','ENT_TETHYS',   'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_OCEANUS',  'high','Hesiod Theogony 132-138: Gaia and Ouranos beget the twelve Titans.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_COEUS',    'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_CRIUS',    'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_HYPERION', 'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_IAPETUS',  'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_THEIA',    'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_RHEA',     'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_THEMIS',   'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_MNEMOSYNE','high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_PHOEBE',   'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA',  'parent_of','ENT_TETHYS',   'high','Hesiod Theogony 132-138.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: OCEANUS × TETHYS (Theogony 337-338)
-- "From Okeanos and Tethys were born the river-gods..."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_OCEANUS','spouse_of','ENT_TETHYS','high','Hesiod Theogony 337-338: Okeanos and Tethys as parents of rivers and Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS', 'spouse_of','ENT_OCEANUS','high','Hesiod Theogony 337-338.','SRC_HESIOD_THEOGONY','approved'),
  -- Clymene is an Oceanid, daughter of Oceanus (Theogony 507-508: "daughter of Okeanos")
  ('ENT_OCEANUS','parent_of','ENT_CLYMENE_TITANESS','high','Hesiod Theogony 507-508: Klymene identified as daughter of Okeanos.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: HYPERION × THEIA lineage (Theogony 371-374)
-- "Hyperion and Theia, mingling in love, bore great Helios and bright Selene
--  and Eos who shines on all upon the earth."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_HYPERION','spouse_of', 'ENT_THEIA',  'high','Hesiod Theogony 371-374: Hyperion and Theia parents of Helios, Selene, Eos.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_THEIA',   'spouse_of', 'ENT_HYPERION','high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_HYPERION','parent_of', 'ENT_HELIOS', 'high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_HYPERION','parent_of', 'ENT_SELENE', 'high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_HYPERION','parent_of', 'ENT_EOS',    'high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_THEIA',   'parent_of', 'ENT_HELIOS', 'high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_THEIA',   'parent_of', 'ENT_SELENE', 'high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_THEIA',   'parent_of', 'ENT_EOS',    'high','Hesiod Theogony 371-374.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: CRIUS × EURYBIA lineage (Theogony 375-382)
-- "Eurybia, shining among goddesses, joined in love with Kreios and bore
--  great Astraios, and Pallas, and Perses who excelled in wisdom."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_CRIUS',   'spouse_of', 'ENT_EURYBIA',     'high','Hesiod Theogony 375-377: Kreios and Eurybia parents of Astraeos, Pallas, Perses.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EURYBIA', 'spouse_of', 'ENT_CRIUS',       'high','Hesiod Theogony 375-377.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CRIUS',   'parent_of', 'ENT_ASTRAEUS',    'high','Hesiod Theogony 375-376.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CRIUS',   'parent_of', 'ENT_PALLAS_TITAN','high','Hesiod Theogony 375-377.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CRIUS',   'parent_of', 'ENT_PERSES_TITAN','high','Hesiod Theogony 375-377.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EURYBIA', 'parent_of', 'ENT_ASTRAEUS',    'high','Hesiod Theogony 375-376.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EURYBIA', 'parent_of', 'ENT_PALLAS_TITAN','high','Hesiod Theogony 375-377.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EURYBIA', 'parent_of', 'ENT_PERSES_TITAN','high','Hesiod Theogony 375-377.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 5: COEUS × PHOEBE lineage (Theogony 404-412)
-- "Koios and Phoibe joined in love desirable and she bore dark-robed Leto
--  ... and Asterie of the blessed name, whom Perses once led home as his wife."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_COEUS', 'spouse_of', 'ENT_PHOEBE',  'high','Hesiod Theogony 404-410: Koios and Phoibe parents of Leto and Asteria.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PHOEBE','spouse_of', 'ENT_COEUS',   'high','Hesiod Theogony 404-410.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_COEUS', 'parent_of', 'ENT_LETO',    'high','Hesiod Theogony 404-406.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_COEUS', 'parent_of', 'ENT_ASTERIA', 'high','Hesiod Theogony 409-410.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PHOEBE','parent_of', 'ENT_LETO',    'high','Hesiod Theogony 404-406.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PHOEBE','parent_of', 'ENT_ASTERIA', 'high','Hesiod Theogony 409-410.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 6: PERSES TITAN × ASTERIA → HECATE (Theogony 409-412)
-- "Asterie of the blessed name, whom Perses once led home as his wife...
--  and she [Asterie] bore Hekate."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_PERSES_TITAN','spouse_of', 'ENT_ASTERIA',    'high','Hesiod Theogony 409: Perses married Asteria.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ASTERIA',     'spouse_of', 'ENT_PERSES_TITAN','high','Hesiod Theogony 409.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PERSES_TITAN','parent_of', 'ENT_HECATE',     'high','Hesiod Theogony 411-412: Asteria bore Hecate to Perses.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ASTERIA',     'parent_of', 'ENT_HECATE',     'high','Hesiod Theogony 411-412.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 7: IAPETUS × CLYMENE lineage (Theogony 507-520)
-- "Iapetos took the neat-ankled daughter of Okeanos, Klymene, and went up
--  with her into one bed; and she bore him Atlas of the mighty spirit,
--  also Menoitios of exceeding pride, and Prometheus of the subtle mind,
--  and blameless Epimetheus." (Theogony 507-511)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_IAPETUS',         'spouse_of', 'ENT_CLYMENE_TITANESS','high','Hesiod Theogony 507-508: Iapetos married Klymene, daughter of Okeanos.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CLYMENE_TITANESS','spouse_of', 'ENT_IAPETUS',         'high','Hesiod Theogony 507-508.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_IAPETUS',         'parent_of', 'ENT_ATLAS',           'high','Hesiod Theogony 507-509.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_IAPETUS',         'parent_of', 'ENT_MENOETIUS',       'high','Hesiod Theogony 507-510.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_IAPETUS',         'parent_of', 'ENT_PROMETHEUS',      'high','Hesiod Theogony 507-511.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_IAPETUS',         'parent_of', 'ENT_EPIMETHEUS',      'high','Hesiod Theogony 511.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CLYMENE_TITANESS','parent_of', 'ENT_ATLAS',           'high','Hesiod Theogony 507-509.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CLYMENE_TITANESS','parent_of', 'ENT_MENOETIUS',       'high','Hesiod Theogony 507-510.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CLYMENE_TITANESS','parent_of', 'ENT_PROMETHEUS',      'high','Hesiod Theogony 507-511.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CLYMENE_TITANESS','parent_of', 'ENT_EPIMETHEUS',      'high','Hesiod Theogony 511.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 8: OLYMPIAN GENEALOGICAL GAPS (Theogony 453-930)
-- ═══════════════════════════════════════════════════════════════════════════

-- Cronus + Rhea → Hestia, Demeter (Theogony 453-454, not yet in DB)
-- "She bore them all: Hestia, Demeter, gold-sandalled Hera,
--  strong Hades...Poseidon...and Zeus." (Hestia and Demeter missing)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_CRONUS','parent_of','ENT_HESTIA', 'high','Hesiod Theogony 453-454: Rheia bore Hestia to Kronos.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CRONUS','parent_of','ENT_DEMETER','high','Hesiod Theogony 453-454.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_RHEA',  'parent_of','ENT_HESTIA', 'high','Hesiod Theogony 453-454.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_RHEA',  'parent_of','ENT_DEMETER','high','Hesiod Theogony 453-454.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Zeus parent_of Persephone (Theogony 912-914)
-- "Demeter ... bore Persephone of the white arms, whom Aidoneus
--  carried off by force from her mother, with the consent of Zeus." (Hom. Hymn 2.3)
-- Theogony 912: Zeus lay with Demeter and she bore Persephone.
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ZEUS','parent_of','ENT_PERSEPHONE','high','Hesiod Theogony 912-914: Zeus and Demeter parents of Persephone.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Persephone spouse_of Hades (inverse of existing Hades spouse_of Persephone)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_PERSEPHONE','spouse_of','ENT_HADES','high','Homeric Hymn to Demeter 2.3: Hades (Aidoneus) carried off Persephone as wife.','SRC_HOMERIC_HYMNS','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Leto parent_of Apollo + Artemis (Theogony 918-920)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_LETO','parent_of','ENT_APOLLO', 'high','Hesiod Theogony 918-920: Leto bore Apollo and Artemis to Zeus.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_LETO','parent_of','ENT_ARTEMIS','high','Hesiod Theogony 918-920.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Hera parent_of Hephaestus (Theogony 927-929 — parthenogenic)
-- "Hera without the embraces of her husband bore famed Hephaestus."
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_HERA','parent_of','ENT_HEPHAESTUS','high','Hesiod Theogony 927-929: Hera bore Hephaestus alone, without Zeus (Hesiodic tradition).','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Poseidon × Amphitrite (Theogony 930-932)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_POSEIDON',  'spouse_of','ENT_AMPHITRITE','high','Hesiod Theogony 930-932: Poseidon and Amphitrite.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_AMPHITRITE','spouse_of','ENT_POSEIDON',  'high','Hesiod Theogony 930-932.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Eos parent_of Memnon (Theogony 984-985)
-- "Eos bore...bronze-weaponed Memnon, king of the Ethiopians"
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_EOS','parent_of','ENT_MEMNON','high','Hesiod Theogony 984-985: Eos bore Memnon to Tithonus.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 9: DOMAIN patron_of / rules FOR THIN OLYMPIANS (Homeric Hymns)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Hymn 31 To Helios: "Begin to sing of Helios, the son of Heaven... who shines on mortals"
  ('ENT_HELIOS','patron_of','ENT_SUN',         'high','Homeric Hymn 31 To Helios: Helios as solar deity who lights the world.','SRC_HOMERIC_HYMNS','approved'),
  -- Hymn 32 To Selene: "Sing of the long-winged Moon... Selene..."
  ('ENT_SELENE','patron_of','ENT_MOON',        'high','Homeric Hymn 32 To Selene: Selene as lunar deity.','SRC_HOMERIC_HYMNS','approved'),
  -- Hymn 2 To Demeter: Demeter as goddess of grain and agriculture
  ('ENT_DEMETER','patron_of','ENT_AGRICULTURE','high','Homeric Hymn 2 To Demeter: Demeter as giver of grain and presider over agriculture.','SRC_HOMERIC_HYMNS','approved'),
  -- Hymn 24+29 To Hestia: Hestia as goddess of the sacred hearth/fire
  ('ENT_HESTIA','patron_of','ENT_FIRE',        'high','Homeric Hymns 24 and 29 To Hestia: Hestia as goddess of the sacred hearth and fire.','SRC_HOMERIC_HYMNS','approved'),
  -- Homer Iliad 15.187-193: Zeus/Poseidon/Hades divide realms; Hades rules the underworld
  ('ENT_HADES','rules','ENT_UNDERWORLD',        'high','Homer Iliad 15.187-193: the three sons of Kronos divided the world by lot; Hades received the underworld.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 10: HERO GENEALOGIES
-- ═══════════════════════════════════════════════════════════════════════════

-- Zeus parent_of heroes (Apollodorus Library)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Apollodorus 2.4.8: Zeus and Alcmene beget Heracles
  ('ENT_ZEUS','parent_of','ENT_HERACLES',        'high','Pseudo-Apollodorus Library 2.4.8: Zeus and Alcmene parents of Heracles.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Apollodorus 2.4.1: Zeus as golden shower impregnates Danae; Perseus born
  ('ENT_ZEUS','parent_of','ENT_PERSEUS',          'high','Pseudo-Apollodorus Library 2.4.1: Zeus and Danae parents of Perseus.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Apollodorus 3.10.7: Zeus as swan and Leda; Helen born
  ('ENT_ZEUS','parent_of','ENT_HELEN',            'high','Pseudo-Apollodorus Library 3.10.7: Zeus (as swan) and Leda parents of Helen.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Apollodorus 3.1.1: Zeus and Europa bear Minos and Rhadamanthys
  ('ENT_ZEUS','parent_of','ENT_MINOS_HERO',       'high','Pseudo-Apollodorus Library 3.1.1: Zeus and Europa parents of Minos.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_ZEUS','parent_of','ENT_RHADAMANTHYS_HERO','high','Pseudo-Apollodorus Library 3.1.1: Zeus and Europa parents of Rhadamanthys.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Apollodorus 3.12.6: Zeus and Aegina beget Aeacus
  ('ENT_ZEUS','parent_of','ENT_AEACUS_HERO',      'high','Pseudo-Apollodorus Library 3.12.6: Zeus and Aegina parents of Aeacus.','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Poseidon parent_of Theseus; Theseus parent_of Hippolytus (Apollodorus 3.15.7)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_POSEIDON','parent_of','ENT_THESEUS',   'high','Pseudo-Apollodorus Library 3.15.7: Poseidon and Aethra co-parents of Theseus (divine paternity tradition).','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_THESEUS', 'parent_of','ENT_HIPPOLYTUS','high','Pseudo-Apollodorus Library 3.15.7-9: Theseus and Hippolyte/Antiope parents of Hippolytus.','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Thetis parent_of Achilles (Homer Iliad 1.280-281, 18.82-93)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_THETIS','parent_of','ENT_ACHILLES','high','Homer Iliad 1.280-281, 18.82-93: Thetis as divine mother of Achilles.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Apollo parent_of Ion (Apollodorus 1.7.3: Apollo and Creusa parents of Ion)
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_APOLLO','parent_of','ENT_ION','high','Pseudo-Apollodorus Library 1.7.3: Apollo and Creusa parents of Ion.','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 11: HERO NARRATIVE RELATIONSHIPS (Homer Iliad)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Iliad 22.325-363: Achilles kills Hector
  ('ENT_ACHILLES','opposes', 'ENT_HECTOR','high','Homer Iliad passim: Achilles and Hector as primary antagonists throughout the Iliad.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_ACHILLES','slays',   'ENT_HECTOR','high','Homer Iliad 22.325-363: Achilles slays Hector beneath the walls of Troy.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Iliad 7.181-312: Ajax and Hector duel; Ajax opposes Hector
  ('ENT_AJAX',   'opposes',  'ENT_HECTOR','high','Homer Iliad 7.181-312: Ajax (Telamonian) duels Hector at Troy.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 12: HERO SPOUSAL RELATIONSHIPS (Homer + Apollodorus)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Helen and Menelaus (Homer Iliad, passim; Apollodorus 3.10.9)
  ('ENT_MENELAUS','spouse_of','ENT_HELEN',   'high','Homer Iliad passim: Menelaus as husband of Helen, whose abduction precipitates the Trojan War.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_HELEN',   'spouse_of','ENT_MENELAUS','high','Homer Iliad passim.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Jason and Medea (Apollodorus 1.9.27: "Medea became the wife of Jason")
  ('ENT_JASON','spouse_of','ENT_MEDEA','high','Pseudo-Apollodorus Library 1.9.27: Jason and Medea married after the Argonautic expedition.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_MEDEA','spouse_of','ENT_JASON', 'high','Pseudo-Apollodorus Library 1.9.27.','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight verification ───────────────────────────────────────────────

-- New totals
SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;
SELECT COUNT(*) AS greek_relationships_after
  FROM entity_relationships r
  JOIN entities s ON s.entity_id = r.subject_entity_id
  WHERE s.tradition = 'Greek';
SELECT COUNT(*) AS greek_zero_rel_entities_after
  FROM entities e
  WHERE e.tradition = 'Greek'
    AND NOT EXISTS (
      SELECT 1 FROM entity_relationships r
      WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id
    );

-- Zero dangling references
SELECT COUNT(*) AS dangling_subject
  FROM entity_relationships er
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object
  FROM entity_relationships er
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

-- Sample: Titan entities that now have relationships
SELECT e.entity_id, e.canonical_name,
       COUNT(r.relationship_id) AS rel_count
  FROM entities e
  LEFT JOIN entity_relationships r
    ON r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id
  WHERE e.tradition = 'Greek' AND e.category = 'Titan'
  GROUP BY e.entity_id, e.canonical_name
  ORDER BY rel_count DESC, e.canonical_name;

COMMIT;
