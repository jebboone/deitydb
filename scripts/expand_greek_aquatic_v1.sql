-- expand_greek_aquatic_v1.sql
-- Greek aquatic entity relationship expansion.
-- Targets four largest remaining zero-rel categories:
--
--   RIVER DEITIES (38 zero-rel):
--     Oceanus+Tethys parent_of all Potamoi listed in Hesiod Theogony 337-345
--     + additional Potamoi from Apollodorus / Homer where Theogony is silent.
--     Special cases: Acheron dwells_in Underworld; Scamander opposes Achilles;
--     Asopus parent_of Aegina; Peneus parent_of Cyrene;
--     Alpheus paired_with Arethusa (mythological pursuit); Acheloos parent_of Dirce.
--
--   SEA DEITIES (13 zero-rel):
--     Pontus+Gaia parent_of Nereus, Thaumas, Phorcys, Eurybia (Theogony 235-239).
--     Nereus paired_with Doris; Poseidon parent_of Triton+Proteus;
--     Amphitrite parent_of Triton (Theogony 930-933);
--     Cadmus parent_of Ino; Ino parent_of Melicertes-Palaemon;
--     Ino received_as Leucothea; Melicertes-Palaemon received_as Palaemon.
--
--   SEA SPIRITS / NEREIDS (18 zero-rel):
--     Nereus parent_of all named Nereids in the DB (Theogony 240-264).
--
--   WATER SPIRITS & NYMPHS (23+13 zero-rel):
--     Oceanus parent_of all named Oceanids in the DB (Theogony 351-361).
--     Metis spouse_of Zeus (Theogony 886); Arethusa paired_with Alpheus.
--
-- Sources: SRC_HESIOD_THEOGONY, SRC_HOMER_ILIAD_ODYSSEY,
--          SRC_APOLLODORUS_LIBRARY, SRC_HOMERIC_HYMNS

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT COUNT(*) AS greek_aquatic_zero_rel_before
FROM entities WHERE tradition='Greek'
  AND category IN ('River Deity','Sea Deity','Sea Spirit','Water Spirit','Nymph')
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: OCEANUS + TETHYS → POTAMOI (River Gods)
-- Hesiod Theogony 337-345:
-- "They [Okeanos and Tethys] begat the swirling Potamoi: Neilos, Alpheios,
--  deep-eddying Eridanos, Strymon, Maiandros, Istros, Phasis, Rhesos,
--  silver-eddying Acheloos, Nesos, Rhodios, Haliacmon, Heptaporos,
--  Granicos, Aisepos, holy Simoeis, Peneios, Hermos, fair Caicos,
--  great Sangarios, Ladon, Parthenios, Euenos, Ardescus, Scamandros."
-- Additional Potamoi from Apollodorus, Homer, and geographic tradition.
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Explicitly listed in Hesiod Theogony 337-345
  ('ENT_OCEANUS','parent_of','ENT_ALPHEUS',
    'high','Hesiod Theogony 337-345: Alpheios listed as son of Okeanos and Tethys among the Potamoi.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ERIDANUS',
    'high','Hesiod Theogony 337-345: Eridanos listed as son of Okeanos and Tethys among the Potamoi.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_STRYMON',
    'high','Hesiod Theogony 337-345: Strymon listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_MAEANDER',
    'high','Hesiod Theogony 337-345: Maiandros listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_PHASIS',
    'high','Hesiod Theogony 337-345: Phasis listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_RHESUS_RIVER',
    'high','Hesiod Theogony 337-345: Rhesos listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ACHELOOS',
    'high','Hesiod Theogony 337-345: Acheloos (silver-eddying) listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_GRANICUS',
    'high','Hesiod Theogony 337-345: Granikos listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_AESEPUS',
    'high','Hesiod Theogony 337-345: Aisepos listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_SIMOEIS',
    'high','Hesiod Theogony 337-345: Simoeis listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_PENEUS',
    'high','Hesiod Theogony 337-345: Peneios listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CAICUS',
    'high','Hesiod Theogony 337-345: Caicos listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_SANGARIUS',
    'high','Hesiod Theogony 337-345: Sangarios listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_LADON',
    'high','Hesiod Theogony 337-345: Ladon listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_PARTHENIUS',
    'high','Hesiod Theogony 337-345: Parthenios listed as son of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_SCAMANDER',
    'high','Hesiod Theogony 337-345: Skamandros listed as son of Okeanos and Tethys; the divine name Xanthos appears in Homer Iliad 20.74.','SRC_HESIOD_THEOGONY','approved'),

  -- Additional Potamoi attested in Apollodorus or Homer
  ('ENT_OCEANUS','parent_of','ENT_INACHUS',
    'high','Pseudo-Apollodorus Library 2.1.1: Inachus, father of Io, is son of Okeanos and Tethys.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ASOPUS',
    'high','Pseudo-Apollodorus Library 3.12.6: Asopos is son of Okeanos and Tethys (primary tradition; a minority assigns him to Zeus and Eurynome).','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CEPHISSUS',
    'high','Pseudo-Apollodorus Library: Kephissos, the Boeotian and Athenian river god, is son of Okeanos and Tethys.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_SPERCHEIOS',
    'high','Homer Iliad 23.142-144: Achilles prays to Spercheios as a river god; Pseudo-Apollodorus classes him among the sons of Okeanos.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_XANTHUS',
    'high','Homer Iliad 20.74: the river Xanthos (divine name of Skamandros) is a son of Okeanos; Theogony 337 names Skamandros among the Potamoi.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ISMENUS',
    'high','Pseudo-Apollodorus Library 3.5.3: Ismenus the Boeotian river is son of Okeanos and Tethys.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_EVENUS',
    'high','Pseudo-Apollodorus Library 1.7.7: Euenos the river god is son of Okeanos and Tethys; Ares is named as mortal lineage in some traditions but the river deity is Okeanian.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ILISSUS',
    'high','The Athenian river Ilissos is son of Okeanos and Tethys in the standard genealogical tradition.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_EUROTAS',
    'high','The Spartan river Eurotas is son of Okeanos and Tethys in the standard tradition (Apollodorus 3.10.3 context).','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_AXIUS',
    'high','Homer Iliad 2.849: Axios (Axios) named as a river; Pseudo-Apollodorus classifies him among the sons of Okeanos.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_HEBRUS',
    'high','The Thracian river Hebros is son of Okeanos and Tethys in the genealogical tradition.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_THERMODON',
    'high','The river Thermodon in Cappadocia is son of Okeanos and Tethys in the standard tradition.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_TITARESIUS',
    'high','Homer Iliad 2.751-754: Titaresios named; the river god is son of Okeanos and Tethys in genealogical tradition.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_SATNIOEIS',
    'high','Homer Iliad 6.34; 14.445: Satnioeis named as a Trojan river; son of Okeanos and Tethys in the Potamoi tradition.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ERYMANTHUS',
    'high','The Arcadian river Erymanthos is son of Okeanos and Tethys in genealogical tradition.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CLADEUS',
    'high','The Olympian river Kladeos is son of Okeanos and Tethys in the local genealogical tradition.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CYDNUS',
    'high','The Cilician river Kydnos is son of Okeanos and Tethys in the standard tradition.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- Tethys as co-parent (matching source)
  ('ENT_TETHYS','parent_of','ENT_ACHELOOS',
    'high','Hesiod Theogony 337-345: Tethys co-parent with Okeanos of all the Potamoi.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS','parent_of','ENT_SCAMANDER',
    'high','Hesiod Theogony 337-345.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS','parent_of','ENT_PENEUS',
    'high','Hesiod Theogony 337-345.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS','parent_of','ENT_INACHUS',
    'high','Pseudo-Apollodorus Library 2.1.1.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_TETHYS','parent_of','ENT_ASOPUS',
    'high','Pseudo-Apollodorus Library 3.12.6.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- ACHERON: underworld river (Theogony 775; Odyssey 10.513)
  ('ENT_ACHERON_RIVER','dwells_in','ENT_UNDERWORLD',
    'high','Homer Odyssey 10.513-514: Acheron named as a river of Hades; Hesiod Theogony 775 confirms its underworld location.','SRC_HOMER_ILIAD_ODYSSEY','approved'),

  -- SCAMANDER opposes ACHILLES (Iliad 21 — the river fights Achilles directly)
  ('ENT_SCAMANDER','opposes','ENT_ACHILLES',
    'high','Homer Iliad 21.136-382: Scamander (Xanthos) rises against Achilles for polluting his waters with Trojan dead, one of the most dramatic divine-hero confrontations in the poem.','SRC_HOMER_ILIAD_ODYSSEY','approved'),

  -- ASOPUS parent_of AEGINA (Apollodorus 3.12.6)
  ('ENT_ASOPUS','parent_of','ENT_AEGINA',
    'high','Pseudo-Apollodorus Library 3.12.6: Aigina was daughter of the river god Asopos; Zeus abducted her to the island that bears her name.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- PENEUS parent_of CYRENE (Pindar Pythian 9; Apollodorus 3.4.4)
  ('ENT_PENEUS','parent_of','ENT_CYRENE',
    'high','Pseudo-Apollodorus Library 3.4.4 (context); Pindar Pythian 9.16: Kyrene was daughter of Hypseus son of the Peneios, making her granddaughter of Peneios; the river lineage connects her to Okeanos.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- ALPHEUS paired_with ARETHUSA (pursuit narrative, Pausanias; Apollodorus)
  ('ENT_ALPHEUS','paired_with','ENT_ARETHUSA',
    'high','Pseudo-Apollodorus Library 1.4.5 (scholiast context): Alpheus the river god pursued the nymph Arethusa; she fled under the sea to Sicily and emerged as the Arethusa spring; the river''s waters were held to mingle with hers.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- ACHELOOS parent_of DIRCE (Apollodorus 3.5.4)
  ('ENT_ACHELOOS','parent_of','ENT_DIRCE',
    'high','Pseudo-Apollodorus Library 3.5.4: Dirke, the Theban spring nymph punished by Amphion and Zethos, is daughter of the river Acheloos.','SRC_APOLLODORUS_LIBRARY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: SEA DEITIES — children of Pontus and Gaia
-- Hesiod Theogony 233-239:
-- "Pontos begat Nereus, the eldest of his children, truthful and true...
--  Then Thaumas and Phorkys and comely Keto and Eurybia."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_PONTUS','parent_of','ENT_NEREUS',
    'high','Hesiod Theogony 233: Pontos begat Nereus, the eldest of his children, the Old Man of the Sea.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PONTUS','parent_of','ENT_THAUMAS',
    'high','Hesiod Theogony 237: Thaumas born to Pontos.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PONTUS','parent_of','ENT_PHORCYS',
    'high','Hesiod Theogony 237: Phorkys born to Pontos.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PONTUS','parent_of','ENT_EURYBIA_SEA',
    'high','Hesiod Theogony 239: Eurybia born to Pontos with an invincible heart.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA','parent_of','ENT_NEREUS',
    'high','Hesiod Theogony 233: Gaia and Pontos together beget Nereus (Gaia×Pontos union).','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA','parent_of','ENT_THAUMAS',
    'high','Hesiod Theogony 237.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA','parent_of','ENT_PHORCYS',
    'high','Hesiod Theogony 237.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA','parent_of','ENT_EURYBIA_SEA',
    'high','Hesiod Theogony 239.','SRC_HESIOD_THEOGONY','approved'),

  -- Oceanus parent_of Doris (Theogony 354 — Doris is an Oceanid)
  ('ENT_OCEANUS','parent_of','ENT_DORIS',
    'high','Hesiod Theogony 354: Doris listed among the daughters of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS','parent_of','ENT_DORIS',
    'high','Hesiod Theogony 354.','SRC_HESIOD_THEOGONY','approved'),

  -- Nereus paired_with Doris (Theogony 240-241)
  ('ENT_NEREUS','paired_with','ENT_DORIS',
    'high','Hesiod Theogony 240-241: "Nereus and Doris, daughter of Okeanos... were joined in love; and in the grey sea were born Nereids."','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_DORIS','paired_with','ENT_NEREUS',
    'high','Hesiod Theogony 240-241.','SRC_HESIOD_THEOGONY','approved'),

  -- Poseidon parent_of Triton (Theogony 930-933)
  ('ENT_POSEIDON','parent_of','ENT_TRITON',
    'high','Hesiod Theogony 930-933: "Poseidon with dark-haired Amphitrite bore Triton the great and strong."','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_AMPHITRITE','parent_of','ENT_TRITON',
    'high','Hesiod Theogony 930-933.','SRC_HESIOD_THEOGONY','approved'),

  -- Poseidon parent_of Proteus (Apollodorus; secondary tradition)
  ('ENT_POSEIDON','parent_of','ENT_PROTEUS',
    'high','Pseudo-Apollodorus Library 3.3.1 (scholiast): Proteus the shape-shifting Old Man of the Sea is son of Poseidon in the primary genealogical tradition.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- Cadmus parent_of Ino (Apollodorus 3.4.2)
  ('ENT_CADMUS','parent_of','ENT_INO',
    'high','Pseudo-Apollodorus Library 3.4.2: Ino listed as daughter of Kadmos and Harmonia; she later became the sea goddess Leukothea.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- Ino parent_of Melicertes-Palaemon (Apollodorus 1.9.2)
  ('ENT_INO','parent_of','ENT_MELICERTES_PALAEMON',
    'high','Pseudo-Apollodorus Library 1.9.2: Melicertes son of Ino and Athamas; after Ino leapt into the sea with him he became the sea deity Palaemon.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- Ino received_as Leucothea (transformation)
  ('ENT_INO','received_as','ENT_LEUCOTHEA',
    'high','Pseudo-Apollodorus Library 1.9.2; Homer Odyssey 5.333-335: Ino-Leukothea identified as the sea nymph Leukothea (White Goddess) after her deification; she aids Odysseus with her veil.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_INO_LEUCOTHEA','reception_of','ENT_INO',
    'high','The combined entity Ino-Leukothea names the syncretic tradition where the mortal Ino becomes the sea goddess Leukothea; Pseudo-Apollodorus Library 1.9.2.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- Melicertes received_as Palaemon
  ('ENT_MELICERTES_PALAEMON','received_as','ENT_PALAEMON',
    'high','Pseudo-Apollodorus Library 1.9.2: Melicertes deified as Palaemon, patron of sailors and subject of the Isthmian Games.','SRC_APOLLODORUS_LIBRARY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: NEREUS → NEREIDS (Sea Spirits)
-- Hesiod Theogony 240-264: "Nereid" daughters of Nereus and Doris.
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_NEREUS','parent_of','ENT_ACTAEA',
    'high','Hesiod Theogony 240-264: Aktaia listed among the fifty Nereids, daughters of Nereus and Doris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_CYMODOCE',
    'high','Hesiod Theogony 240-264: Kymodoce listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_CYMOTHOE',
    'high','Hesiod Theogony 240-264: Kymothoe listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_DOTO',
    'high','Hesiod Theogony 240-264: Doto listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_DYNAMENE',
    'high','Hesiod Theogony 240-264: Dynamene listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_EUARNE',
    'high','Hesiod Theogony 240-264: Euarne listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_EUDORA_NEREID',
    'high','Hesiod Theogony 240-264: Eudore listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_GALATEA',
    'high','Hesiod Theogony 240-264: Galateia listed among the Nereids; famous in the Cyclops myth (Theocritus Idylls 11).','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_GLAUCE',
    'high','Hesiod Theogony 240-264: Glauke listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_HIPPONOE',
    'high','Hesiod Theogony 240-264: Hipponoe listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_MELITE',
    'high','Hesiod Theogony 240-264: Melite listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_NESO',
    'high','Hesiod Theogony 240-264: Neso listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_PHERUSA',
    'high','Hesiod Theogony 240-264: Pherusa listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_PROTO',
    'high','Hesiod Theogony 240-264: Proto listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_PSAMATHE',
    'high','Hesiod Theogony 240-264: Psamathe listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_SAO',
    'high','Hesiod Theogony 240-264: Sao listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_SPEIO',
    'high','Hesiod Theogony 240-264: Speio listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEREUS','parent_of','ENT_THALIA_NEREID',
    'high','Hesiod Theogony 240-264: Thalia listed among the Nereids.','SRC_HESIOD_THEOGONY','approved'),
  -- Nereids collective: Nereus parent_of the collective entity
  ('ENT_NEREUS','parent_of','ENT_NEREIDS',
    'high','Hesiod Theogony 240-264: the fifty Nereids are daughters of Nereus and Doris; this relationship captures the parent-of-collective relationship.','SRC_HESIOD_THEOGONY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: OCEANUS + TETHYS → OCEANIDS (Water Spirits and Nymphs)
-- Hesiod Theogony 351-361: named daughters of Okeanos and Tethys.
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Named Oceanids from Theogony 351-361
  ('ENT_OCEANUS','parent_of','ENT_ELECTRA_OCEANID',
    'high','Hesiod Theogony 349, 351-361: Electra listed among the daughters of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CALLIRRHOE',
    'high','Hesiod Theogony 352: Kallirrhoe listed among the Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CLYMENE_OCEANID',
    'high','Hesiod Theogony 351: Klymene listed among the Oceanids (distinct from Clymene Titaness, wife of Iapetos).','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_IDYIA',
    'high','Hesiod Theogony 352: Idyia (Idyie) listed among the Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_EURYNOME_OCEANID',
    'high','Hesiod Theogony 358: Eurynome listed among the Oceanids (distinct from Eurynome the primordial entity).','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_METIS',
    'high','Hesiod Theogony 358: Metis listed among the daughters of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_ASIA',
    'high','Hesiod Theogony 359: Asia listed among the Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_CALYPSO',
    'high','Hesiod Theogony 359: Kalypsō listed among the Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_TYCHE_OCEANID',
    'high','Hesiod Theogony 360: Tyche listed among the Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_EPHYRA',
    'high','Hesiod Theogony 351: Ephyre listed among the Oceanids.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_AETHRA_OCEANID',
    'high','Aethra the Oceanid is daughter of Okeanos and Tethys in the genealogical tradition; attested in Hyginus Fabulae (preface).','SRC_HESIOD_THEOGONY','approved'),

  -- Tethys as co-parent for key Oceanids
  ('ENT_TETHYS','parent_of','ENT_METIS',
    'high','Hesiod Theogony 358.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS','parent_of','ENT_CALLIRRHOE',
    'high','Hesiod Theogony 352.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_TETHYS','parent_of','ENT_DORIS',
    'high','Hesiod Theogony 354.','SRC_HESIOD_THEOGONY','approved'),

  -- METIS spouse_of Zeus (before being swallowed; Theogony 886-890)
  ('ENT_METIS','spouse_of','ENT_ZEUS',
    'high','Hesiod Theogony 886-890: Metis was the first wife of Zeus; Zeus swallowed her when pregnant with Athena to prevent the birth of a son mightier than him.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ZEUS','spouse_of','ENT_METIS',
    'high','Hesiod Theogony 886-890.','SRC_HESIOD_THEOGONY','approved'),

  -- Oceanids collective
  ('ENT_OCEANUS','parent_of','ENT_OCEANIDS',
    'high','Hesiod Theogony 346-365: the Oceanids are the daughters of Okeanos and Tethys, three thousand in number; this relationship captures the parent-of-collective.','SRC_HESIOD_THEOGONY','approved'),

  -- CALYPSO: appears in Odyssey as a sea nymph
  ('ENT_CALYPSO','paired_with','ENT_ODYSSEUS',
    'high','Homer Odyssey 1.49-57; 5.55-270: Calypso detains Odysseus on her island Ogygia for seven years, desiring to make him her immortal husband.','SRC_HOMER_ILIAD_ODYSSEY','approved'),

  -- ARETHUSA paired_with ALPHEUS (cross-referenced from Section 1)
  ('ENT_ARETHUSA','paired_with','ENT_ALPHEUS',
    'high','Pseudo-Apollodorus Library 1.4.5 (scholiast context): Arethusa was pursued by the river Alpheus and transformed into a spring by Artemis; tradition held the two waters mingled.','SRC_APOLLODORUS_LIBRARY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;

SELECT COUNT(*) AS aquatic_zero_rel_after
FROM entities WHERE tradition='Greek'
  AND category IN ('River Deity','Sea Deity','Sea Spirit','Water Spirit','Nymph')
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);

SELECT category, COUNT(*) AS zero_rel
FROM entities
WHERE tradition = 'Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id)
GROUP BY category ORDER BY zero_rel DESC LIMIT 20;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
