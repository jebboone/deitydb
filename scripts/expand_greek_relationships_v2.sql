-- expand_greek_relationships_v2.sql
-- Greek relationship expansion, batch 2.
-- Targets the three largest remaining zero-rel clusters:
--
--   ABSTRACTIONS (52 zero-rel):
--     - Parent chains: Eris→10 children (Theogony 226-232);
--       Nyx→3 children (Theogony 211-225); Ares+Aphrodite→Harmonia (Theogony 933);
--       Pallas Titan+Styx→Zelos (Theogony 383); Zeus→Litae (Iliad 9.502)
--     - embodies for 14 personifications with matching cross-trad entities
--
--   PRIMORDIAL POWERS (15 zero-rel):
--     - Chaos→Erebus+Nyx (Theogony 116-120)
--     - Erebus+Nyx→Aether+Hemera (Theogony 124-125)
--     - Gaia→Ourea+Pontus (Theogony 129-132); Gaia→Styx (Theogony 361, Oceanid lineage)
--     - Astraeus+Eos→Eosphorus (Theogony 381)
--     - Pontus paired_with Thalassa; Tartarus dwells_in Underworld
--     - Aether+Hemera embodies Light
--
--   HEROES (19 zero-rel):
--     - Apollo parent_of / paired_with: Aristaeus, Asclepius Hero, Mopsus, Hyacinthus
--     - Aphrodite parent_of Aeneas; paired_with Adonis
--     - Diomedes opposes Ares (Iliad 5 aristeia)
--     - Cadmus/Harmonia spousal pair; Orestes/Pylades; Atalanta/Meleager
--     - Athena protects Odysseus, Cecrops, Erechtheus
--     - Poseidon paired_with Pelops; Pelops opposes Oenomaus
--     - Hector slays Protesilaus; Artemis protects Iphigenia
--
-- Sources: SRC_HESIOD_THEOGONY, SRC_HOMER_ILIAD_ODYSSEY,
--          SRC_APOLLODORUS_LIBRARY, SRC_THEOI_DAIMONES

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT COUNT(*) AS greek_zero_rel_before
FROM entities e WHERE tradition = 'Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id);


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1A: ERIS → children (Hesiod Theogony 226-232)
-- "And hateful Eris bore Ponos and Lethe and Limos and the Algea,
--  the Hysminai and the Machai and the Phonoi and the Androktasiai,
--  the Neikea and the Pseudologoi and Amphilogiai,
--  Dysnomia and Ate and Horkos."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ERIS','parent_of','ENT_PONOS',       'high','Hesiod Theogony 226: Ponos (Toil) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_LIMOS',       'high','Hesiod Theogony 227: Limos (Hunger) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_ALGEA',       'high','Hesiod Theogony 227: Algea (Pains) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_HYSMINAI',    'high','Hesiod Theogony 228: Hysminai (Battles) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_MACHAI',      'high','Hesiod Theogony 228: Machai (Wars) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_NEIKEA',      'high','Hesiod Theogony 229: Neikea (Quarrels) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_PSEUDOLOGOI', 'high','Hesiod Theogony 229: Pseudologoi (Lies) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_AMPHILOGIAI', 'high','Hesiod Theogony 229: Amphilogiai (Disputes) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_DYSNOMIA',    'high','Hesiod Theogony 230: Dysnomia (Lawlessness) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ERIS','parent_of','ENT_ATE',         'high','Hesiod Theogony 230: Ate (Ruin/Delusion) listed as child of Eris.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1B: NYX → children (Hesiod Theogony 211-225)
-- "And Nyx bore hateful Moros and black Ker and Thanatos,
--  and Hypnos, and the tribe of Oneiroi...
--  and Momos and painful Oizys, and the Hesperides...
--  and the Moirai and the Keres... and Nemesis...
--  and Apate and Philotes and hateful Geras, and hard-hearted Eris."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_NYX','parent_of','ENT_APATE',    'high','Hesiod Theogony 224: Apate (Deceit) listed as child of Nyx.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX','parent_of','ENT_PHILOTES', 'high','Hesiod Theogony 224: Philotes (Friendship/Love) listed as child of Nyx.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX','parent_of','ENT_MOMOS',    'high','Hesiod Theogony 214: Momos (Blame) listed as child of Nyx.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1C: ARES + APHRODITE → HARMONIA (Theogony 933-937)
-- "Ares of the brazen helm lay with Kytherea and she bore Phobos and Deimos
--  ... and Harmonia."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ARES',     'parent_of','ENT_HARMONIA','high','Hesiod Theogony 933-937: Ares and Aphrodite (Kytherea) parents of Harmonia.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_APHRODITE','parent_of','ENT_HARMONIA','high','Hesiod Theogony 933-937.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1D: PALLAS TITAN + STYX → ZELOS (Theogony 383-385)
-- "Styx, daughter of Okeanos, united with Pallas and bore Zelos
--  and fair-ankled Nike, and Kratos and Bie."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_PALLAS_TITAN','parent_of','ENT_ZELOS','high','Hesiod Theogony 383-385: Pallas (Titan) and Styx parents of Zelos (Emulation), Nike, Kratos, and Bie.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_STYX',        'parent_of','ENT_ZELOS','high','Hesiod Theogony 383-385.','SRC_HESIOD_THEOGONY','approved'),
  -- Oceanus parent_of Styx: Theogony 361 lists Styx among the Oceanids
  ('ENT_OCEANUS','parent_of','ENT_STYX','high','Hesiod Theogony 361: Styx named among the daughters of Okeanos (Oceanids).','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1E: ZEUS → LITAE (Homer Iliad 9.502-512)
-- "For the Litai are the daughters of great Zeus, lame and wrinkled
--  and with eyes cast down..."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ZEUS','parent_of','ENT_LITAE','high','Homer Iliad 9.502-512: the Litai (Prayers) are the daughters of Zeus.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1F: ABSTRACTION embodies (Theoi Daimones index; personifications)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_BASILEIA',   'embodies','ENT_SOVEREIGNTY','high','Basileia personifies kingship and royal power; the name means "sovereignty/queenship."','SRC_THEOI_DAIMONES','approved'),
  ('ENT_DIKAIOSYNE', 'embodies','ENT_JUSTICE',    'high','Dikaiosyne personifies justice and righteousness (dikaiosynē = "justice").','SRC_THEOI_DAIMONES','approved'),
  ('ENT_NOMOS',      'embodies','ENT_JUSTICE',    'high','Nomos personifies law (nomos) as the embodiment of divinely-ordained justice.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HYSMINAI',   'embodies','ENT_WAR',        'high','Hysminai (Battles) personify the combats of war; children of Eris (Theogony 228).','SRC_THEOI_DAIMONES','approved'),
  ('ENT_MACHAI',     'embodies','ENT_WAR',        'high','Machai (Wars) personify warfare; children of Eris (Theogony 228).','SRC_THEOI_DAIMONES','approved'),
  ('ENT_IOKE',       'embodies','ENT_WAR',        'high','Ioke (Battle Pursuit) personifies the pursuit of enemies in battle; a companion of Eris and Ares in Homeric battle descriptions.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_KYDOIMOS',   'embodies','ENT_WAR',        'high','Kydoimos (Din of Battle) personifies the confusion and tumult of warfare; attested in Iliad 4.440-445 alongside Eris.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_PROIOXIS',   'embodies','ENT_WAR',        'high','Proioxis (Onslaught) personifies the charge and forward rush in battle.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_PALIOXIS',   'embodies','ENT_WAR',        'high','Palioxis (Backrush) personifies the retreat and flight in battle; counterpart to Proioxis.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_PHEME',      'embodies','ENT_SPEECH',     'high','Pheme (Rumour/Fame) personifies spoken reputation and fame; equivalent to Roman Fama.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_TECHNE',     'embodies','ENT_CRAFT',      'high','Techne personifies skill and craftsmanship (technē = "art, craft, skill").','SRC_THEOI_DAIMONES','approved'),
  ('ENT_SOTERIA',    'embodies','ENT_SALVATION',  'high','Soteria (Safety/Salvation) personifies deliverance from harm; her name shares the root with sōtēr (saviour).','SRC_THEOI_DAIMONES','approved'),
  ('ENT_PHILOTES',   'embodies','ENT_LOVE',       'high','Philotes (Friendship/Affection) personifies the bond of love and friendship (philia); child of Nyx (Theogony 224).','SRC_THEOI_DAIMONES','approved'),
  ('ENT_POROS',      'embodies','ENT_WEALTH',     'high','Poros (Resource/Plenty) personifies the abundance of means and resourcefulness; in Plato''s Symposium (203b) he is son of Metis and father of Eros by Penia.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: PRIMORDIAL POWERS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- Chaos → Erebus, Nyx (Theogony 116-120)
  ('ENT_CHAOS','parent_of','ENT_EREBUS','high','Hesiod Theogony 116-120: "Out of Chaos came Erebus and black Nyx."','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CHAOS','parent_of','ENT_NYX',   'high','Hesiod Theogony 116-120: Nyx (Night) emerged from Chaos alongside Erebus.','SRC_HESIOD_THEOGONY','approved'),

  -- Erebus × Nyx → Aether, Hemera (Theogony 124-125)
  -- "And Erebus and black Nyx mingled in love; and Nyx bore Aether and Hemera."
  ('ENT_EREBUS','parent_of','ENT_AETHER','high','Hesiod Theogony 124-125: Aether born from Erebus and Nyx.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EREBUS','parent_of','ENT_HEMERA','high','Hesiod Theogony 124-125: Hemera (Day) born from Erebus and Nyx.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX',   'parent_of','ENT_AETHER','high','Hesiod Theogony 124-125.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX',   'parent_of','ENT_HEMERA','high','Hesiod Theogony 124-125.','SRC_HESIOD_THEOGONY','approved'),

  -- Gaia → Ourea (Theogony 129), Pontus (Theogony 132) — parthenogenic
  ('ENT_GAIA','parent_of','ENT_OUREA', 'high','Hesiod Theogony 129: Gaia bore Ourea (Mountains) alone, without union.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA','parent_of','ENT_PONTUS','high','Hesiod Theogony 132: Gaia bore Pontus (Sea) alone, without love.','SRC_HESIOD_THEOGONY','approved'),

  -- Astraeus + Eos → Eosphorus (Theogony 381-383)
  ('ENT_ASTRAEUS','parent_of','ENT_EOSPHORUS','high','Hesiod Theogony 381-383: Eos bore to Astraeus the morning star Eosphorus.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EOS',     'parent_of','ENT_EOSPHORUS','high','Hesiod Theogony 381-383.','SRC_HESIOD_THEOGONY','approved'),

  -- Pontus paired_with Thalassa (primordial sea pair; Orphic/Hesiodic)
  ('ENT_PONTUS',   'paired_with','ENT_THALASSA','high','Pontus (Sea) and Thalassa (Sea) are the paired primordial sea entities in Hesiodic and later cosmological tradition.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_THALASSA', 'paired_with','ENT_PONTUS',  'high','Hesiodic cosmological tradition.','SRC_HESIOD_THEOGONY','approved'),

  -- Tartarus dwells in the deepest underworld (Theogony 119, 720-726)
  ('ENT_TARTARUS','dwells_in','ENT_UNDERWORLD','high','Hesiod Theogony 119, 720-726: Tartarus is the primordial deep pit beneath the earth and Hades, the lowest region of the cosmos.','SRC_HESIOD_THEOGONY','approved'),

  -- Aether embodies Light; Hemera embodies Light
  ('ENT_AETHER','embodies','ENT_LIGHT','high','Hesiod Theogony 124: Aether is the bright upper air and primordial light of heaven, born from Erebus and Nyx.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_HEMERA','embodies','ENT_LIGHT','high','Hesiod Theogony 124-125: Hemera (Day) personifies the light of daytime, born from Erebus and Nyx.','SRC_HESIOD_THEOGONY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: HEROES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- APOLLO parent_of / paired_with
  -- Aristaeus: son of Apollo and Cyrene (Apollodorus 3.4.4)
  ('ENT_APOLLO','parent_of','ENT_ARISTAEUS_HERO',
    'high','Pseudo-Apollodorus Library 3.4.4: Apollo and Cyrene parents of Aristaeus, hero of beekeeping, cheesemaking, and olive-growing.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Asclepius Hero: Apollo parent_of (Apollodorus 3.10.3; separate entity from ENT_ASCLEPIUS)
  ('ENT_APOLLO','parent_of','ENT_ASCLEPIUS_HERO',
    'high','Pseudo-Apollodorus Library 3.10.3: Apollo and Coronis parents of Asclepius; this entity records the hero/mortal aspect of Asclepius before deification.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Mopsus: son of Apollo and Manto (Apollodorus 3.4.4 variant; Strabo)
  ('ENT_APOLLO','parent_of','ENT_MOPSUS',
    'high','Apollodorus and later tradition: Mopsus the seer was son of Apollo (and Manto of Thebes in one account), inheriting prophetic gifts from his divine father.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Hyacinthus: Apollo''s beloved (Apollodorus 3.10.3)
  ('ENT_APOLLO','paired_with','ENT_HYACINTHUS',
    'high','Pseudo-Apollodorus Library 3.10.3: Apollo loved Hyacinthus; the youth died when Zephyrus (or a discus) struck him, and the hyacinth flower sprang from his blood.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- APHRODITE parent_of / paired_with
  -- Aeneas: son of Aphrodite and Anchises (Iliad 5.312; Homeric Hymn 5)
  ('ENT_APHRODITE','parent_of','ENT_AENEAS_GREEK_RECEPTION',
    'high','Homer Iliad 5.312: Aphrodite explicitly named as mother of Aeneas; confirmed in Homeric Hymn 5 (To Aphrodite).','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Adonis: Aphrodite''s beloved (Apollodorus 3.14.4)
  ('ENT_APHRODITE','paired_with','ENT_ADONIS_HERO',
    'high','Pseudo-Apollodorus Library 3.14.4: Aphrodite loved Adonis and kept him hidden; after his death by a boar she mourned him and secured his return for part of each year.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- CADMUS × HARMONIA spousal pair (Theogony 937; Apollodorus 3.4.2)
  ('ENT_CADMUS', 'spouse_of','ENT_HARMONIA','high','Hesiod Theogony 937; Apollodorus 3.4.2: Cadmus married Harmonia, daughter of Ares and Aphrodite, at a divine wedding attended by the Olympians.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_HARMONIA','spouse_of','ENT_CADMUS',  'high','Hesiod Theogony 937; Apollodorus 3.4.2.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- DIOMEDES opposes ARES (Iliad 5 aristeia — Diomedes wounds Ares, Iliad 5.855-863)
  ('ENT_DIOMEDES','opposes','ENT_ARES',
    'high','Homer Iliad 5.855-863: Diomedes, aided by Athena, wounds Ares in battle — one of the most dramatic aristeia in the poem.','SRC_HOMER_ILIAD_ODYSSEY','approved'),

  -- ATALANTA / MELEAGER — companions in the Calydonian Boar Hunt (Apollodorus 1.8.2)
  ('ENT_ATALANTA','paired_with','ENT_MELEAGER',
    'high','Pseudo-Apollodorus Library 1.8.2: Atalanta and Meleager hunted the Calydonian Boar together; Atalanta drew first blood and Meleager awarded her the hide.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_MELEAGER','paired_with','ENT_ATALANTA',
    'high','Pseudo-Apollodorus Library 1.8.2.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- ATHENA protects heroes
  -- Odysseus: Athena is Odysseus''s divine patron throughout the Odyssey
  ('ENT_ATHENA','protects','ENT_ODYSSEUS',
    'high','Homer Odyssey passim (esp. 1.48-62, 13.287-310): Athena is the divine protector and guide of Odysseus throughout his ten-year homeward voyage.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Cecrops: first king of Athens; sacred to Athena (Apollodorus 3.14.1)
  ('ENT_ATHENA','protects','ENT_CECROPS',
    'high','Pseudo-Apollodorus Library 3.14.1: Cecrops was the first king of Attica and judge of the contest between Athena and Poseidon; Athena''s patronage of Athens begins with his reign.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Erechtheus: raised by Athena; worshipped jointly with her (Apollodorus 3.14.6)
  ('ENT_ATHENA','protects','ENT_ERECHTHEUS',
    'high','Pseudo-Apollodorus Library 3.14.6: Erechtheus was raised by Athena, established her cult on the Acropolis, and was eventually worshipped alongside her in the Erechtheion.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- ORESTES / PYLADES — inseparable companions (Apollodorus Epitome 6.25)
  ('ENT_ORESTES','paired_with','ENT_PYLADES',
    'high','Pseudo-Apollodorus Epitome 6.25; Aeschylus Libation Bearers: Orestes and Pylades are the archetypal heroic friendship pair; Pylades accompanies Orestes through the matricide and its aftermath.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_PYLADES','paired_with','ENT_ORESTES',
    'high','Pseudo-Apollodorus Epitome 6.25.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- POSEIDON paired_with PELOPS; PELOPS opposes OENOMAUS (Apollodorus Epitome 2.3-8)
  ('ENT_POSEIDON','paired_with','ENT_PELOPS',
    'high','Pseudo-Apollodorus Epitome 2.3: Poseidon loved Pelops and took him to Olympus; later restored him and aided him with winged horses for the race against Oenomaus.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_PELOPS',  'opposes',    'ENT_OENOMAUS',
    'high','Pseudo-Apollodorus Epitome 2.4-8: Pelops competed against Oenomaus in the chariot race for Hippodameia''s hand; Oenomaus was killed when his chariot collapsed.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- HECTOR slays PROTESILAUS (Apollodorus Epitome 3.30)
  ('ENT_HECTOR','slays','ENT_PROTESILAUS',
    'high','Pseudo-Apollodorus Epitome 3.30: Protesilaus was the first Greek to land at Troy and was immediately slain; later tradition names Hector as his killer.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- ARTEMIS protects IPHIGENIA (Apollodorus Epitome 2.10; Euripides Iphigenia in Tauris)
  ('ENT_ARTEMIS','protects','ENT_IPHIGENIA',
    'high','Pseudo-Apollodorus Epitome 2.10: Artemis rescued Iphigenia from sacrifice at Aulis, replacing her with a deer and transporting her to Tauris as her priestess.','SRC_APOLLODORUS_LIBRARY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;
SELECT COUNT(*) AS greek_zero_rel_after
FROM entities e WHERE tradition = 'Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = e.entity_id OR r.object_entity_id = e.entity_id);

-- Breakdown by category
SELECT category, COUNT(*) AS zero_rel
FROM entities
WHERE tradition = 'Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id)
GROUP BY category ORDER BY zero_rel DESC LIMIT 15;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
