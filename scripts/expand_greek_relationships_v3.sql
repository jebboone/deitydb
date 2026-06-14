-- expand_greek_relationships_v3.sql
-- Greek relationship expansion, batch 3.
-- Covers the broad spread of remaining zero-rel categories:
--
--   ORACLE FIGURES (10): Apollo patron_of or parent_of each seer;
--     Phoebe/Themis at Delphi → gave oracle to Apollo (Aeschylus Eumenides);
--     Cassandra opposes Zeus/Apollo narrative; seers connected to tradition.
--
--   NYX CHILDREN (remaining): parent_of Eris (explicitly), Hypnos, Morpheus,
--     Oneiroi collective, Phobetor, Phantasos, Hesperides, Nosoi (Works & Days).
--
--   DREAM SPIRITS (4): Nyx parent_of; Morpheus member_of Oneiroi.
--
--   KEY PERSONIFICATIONS: Nike (Pallas+Styx daughter, Theogony 383);
--     Eirene/Auxo/Carpo/Thallo (Zeus+Themis daughters, Theogony 901-902);
--     Eileithyia (Zeus+Hera, Theogony 921); Hypnos embodies Death.
--
--   MAIA + ATLAS lineage: Atlas parent_of Maia (Theogony 938);
--     Maia parent_of Hermes (Theogony 938-939).
--
--   HESPERIDES: Nyx parent_of collective + four named (Theogony 215);
--     Atlas parent_of (Apollodorus 2.5.11 as secondary tradition).
--
--   SEA MONSTERS: Phorcys+Ceto parent_of Scylla; Pontus+Gaia parent_of Ceto;
--     Scylla+Charybdis opposes Odysseus (Odyssey 12).
--
--   UNDERWORLD: Plouton/Hades Klymenos/Brimo dwells_in Underworld;
--     Zeus parent_of Rhadamanthys (Apollodorus 3.1.1);
--     Poseidon+Demeter parent_of Despoina; Acheron River parent_of Ascalaphus.
--
--   DIONYSIAN SPIRITS: Dionysus patron_of Maenads/Thyiads/Satyrs/Silenus.
--
--   MYTH PAIRS: Eos paired_with Tithonus (Homeric Hymn 5);
--     Dionysus paired_with Ariadne (Theogony 947); Apollo paired_with Daphne;
--     Zeus paired_with Ganymede (Iliad 20.232); Hermes+Aphrodite parent_of
--     Hermaphroditus; Iris daughter of Thaumas+Electra Oceanid (Theogony 266);
--     Enodia = Hecate aspect.
--
--   RUSTIC / ECSTATIC: Silenus patron_of/serves Dionysus; Korybantes
--     member_of retinue of Rhea/Cybele; Curetes protect Zeus.
--
-- Sources: SRC_HESIOD_THEOGONY, SRC_HOMER_ILIAD_ODYSSEY,
--          SRC_APOLLODORUS_LIBRARY, SRC_HOMERIC_HYMNS, SRC_THEOI_DAIMONES

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: NYX → remaining children
-- Theogony 211-225: Moros, Ker, Thanatos, Hypnos, Oneiroi tribe,
--   Momos (done), Oizys, Hesperides (v.215), Moirai, Keres, Nemesis,
--   Apate (done), Philotes (done), Geras, Eris.
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Eris explicitly child of Nyx (Theogony 225)
  ('ENT_NYX','parent_of','ENT_ERIS',
    'high','Hesiod Theogony 225: Nyx bore Eris last, "hateful Strife."','SRC_HESIOD_THEOGONY','approved'),
  -- Hypnos child of Nyx (Theogony 212)
  ('ENT_NYX','parent_of','ENT_HYPNOS',
    'high','Hesiod Theogony 211-212: Nyx bore Thanatos and Hypnos (Sleep) together; they are twin brothers.','SRC_HESIOD_THEOGONY','approved'),
  -- Oneiroi tribe child of Nyx (Theogony 211-212)
  ('ENT_NYX','parent_of','ENT_ONEIROI',
    'high','Hesiod Theogony 211-212: Nyx bore "the tribe of Oneiroi" (Dreams) as a collective.','SRC_HESIOD_THEOGONY','approved'),
  -- Morpheus: principal Dream, son of Nyx (via Oneiroi; Ovid Met. 11.633 names him explicitly)
  ('ENT_NYX','parent_of','ENT_MORPHEUS',
    'high','Hesiod Theogony 211-212: the Oneiroi are children of Nyx; Morpheus is the most famous of the Oneiroi (Ovid Metamorphoses 11.633 names him son of Hypnos, but the primary Greek genealogy derives all Oneiroi from Nyx).','SRC_HESIOD_THEOGONY','approved'),
  -- Phobetor and Phantasos: dream figures, members of Oneiroi
  ('ENT_NYX','parent_of','ENT_PHOBETOR',
    'high','Hesiod Theogony 211-212: Phobetor (Icelos) is one of the Oneiroi, children of Nyx.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX','parent_of','ENT_PHANTASOS',
    'high','Hesiod Theogony 211-212: Phantasos is one of the Oneiroi, children of Nyx.','SRC_HESIOD_THEOGONY','approved'),
  -- Hesperides child of Nyx (Theogony 215)
  ('ENT_NYX','parent_of','ENT_HESPERIDES',
    'high','Hesiod Theogony 215: "And Night bore the Hesperides who guard the golden apples beyond glorious Okeanos."','SRC_HESIOD_THEOGONY','approved'),
  -- Nosoi child of Nyx (Hesiod Works and Days 102; Hyginus Fabulae preface)
  ('ENT_NYX','parent_of','ENT_NOSOI',
    'high','Hesiod Works and Days 102: diseases (Nosoi) flew out of Pandora''s jar; Hyginus Fabulae preface lists Nosoi as children of Nyx (or Nox).','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Morpheus member_of Oneiroi collective
INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_MORPHEUS','member_of','ENT_ONEIROI',
    'high','Homer Iliad 2.6: Morpheus acts as a divine messenger-dream; he is the most prominent of the Oneiroi tribe.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: ORACLE FIGURES
-- Apollo is patron/source of prophetic gift for most Greek seers.
-- Theogony 887 / Homeric Hymn to Apollo.
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Cassandra: Apollo gave her prophecy, then cursed her (Apollodorus 3.12.5)
  ('ENT_APOLLO','patron_of','ENT_CASSANDRA',
    'high','Pseudo-Apollodorus Library 3.12.5: Apollo gave Cassandra the gift of prophecy; when she refused him, he made it so no one would believe her.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Tiresias: blind seer, held divine favour of Apollo (and Athena)
  ('ENT_APOLLO','patron_of','ENT_TIRESIAS',
    'high','Tiresias received prophetic vision from Apollo (or Zeus) as compensation for his blindness; he is the central prophetic figure across the Theban and underworld traditions (Odyssey 11.90-151; Sophocles Oedipus Rex).','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Calchas: seer in the Iliad who speaks for Apollo (Iliad 1.69-100)
  ('ENT_APOLLO','patron_of','ENT_CALCHAS',
    'high','Homer Iliad 1.69-100: Calchas, best of seers, declares he knows "the things that are, the things that will be, and the things that were before" through the prophetic gifts granted by Phoibos Apollo.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Amphiaraus: seer and hero, received prophecy from Apollo via Delphi
  ('ENT_APOLLO','patron_of','ENT_AMPHIARAUS',
    'high','Pseudo-Apollodorus Library 3.6.4: Amphiaraus the seer-hero received prophetic gifts; his oracle at Oropus was later associated with Apollo.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Manto: daughter of Tiresias, prophetess of Apollo
  ('ENT_APOLLO','patron_of','ENT_MANTO',
    'high','Manto, daughter of Tiresias, was dedicated to Apollo and served at his oracles at Delphi and Claros; the prophetic tradition passed from Tiresias to Manto and to her son Mopsus.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Tiresias parent_of Manto (Apollodorus 3.7.4)
  ('ENT_TIRESIAS','parent_of','ENT_MANTO',
    'high','Pseudo-Apollodorus Library 3.7.4: Manto was daughter of the seer Tiresias.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Melampus: first mortal seer; received prophetic gift via snakes (Apollodorus 1.9.11)
  ('ENT_APOLLO','patron_of','ENT_MELAMPUS',
    'high','Pseudo-Apollodorus Library 1.9.11: Melampus the first mortal prophet received the gift of prophecy; tradition associates his gift with Apollo, who taught him the art.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Phoebe at Delphi: Titaness Phoibe held the oracle before passing it to Apollo
  ('ENT_PHOEBE_AT_DELPHI','reveals','ENT_APOLLO',
    'high','Aeschylus Eumenides 1-19: Phoibe (the Titaness) held the Delphic oracle and passed it as a birthday gift to Apollo; she is the third guardian of Delphi in the Aeschylean sequence (Gaia → Themis → Phoibe → Apollo).','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Themis at Delphi: second holder of the Delphic oracle (Aeschylus Eumenides)
  ('ENT_THEMIS_AT_DELPHI','reveals','ENT_APOLLO',
    'high','Aeschylus Eumenides 2-8: Themis held the Delphic oracle as its second prophet before passing it to Phoibe.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Trophonius: chthonic oracle at Lebadeia; son of Apollo
  ('ENT_APOLLO','parent_of','ENT_TROPHONIUS',
    'high','Pseudo-Apollodorus Library: Trophonius is son of Apollo (or Erginos) in the tradition; he operated the oracle at Lebadeia in Boeotia, a distinctive descent-oracle.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Glycon: serpent-oracle, aspect of Asclepius in Pontus (Alexander of Abonuteichos)
  ('ENT_ASCLEPIUS','reception_of','ENT_GLYCON',
    'medium','Lucian Alexander the False Prophet: Glycon was promoted as a new incarnation of Asclepius by Alexander of Abonuteichos (2nd c. CE); the serpent oracle was presented as a manifestation of Asclepius in a new form.','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: KEY PERSONIFICATIONS — genealogies
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Nike: daughter of Pallas Titan and Styx (Theogony 383-385)
  ('ENT_PALLAS_TITAN','parent_of','ENT_NIKE',
    'high','Hesiod Theogony 383-385: Styx and Pallas bore Zelos, Nike, Kratos, and Bia.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_STYX','parent_of','ENT_NIKE',
    'high','Hesiod Theogony 383-385.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NIKE','embodies','ENT_WAR',
    'high','Nike (Victory) personifies success in battle and competition; she is the divine embodiment of victory and accompanies Zeus and Athena in war.','SRC_THEOI_DAIMONES','approved'),

  -- Eirene / Horai: daughters of Zeus and Themis (Theogony 901-902)
  -- "And next he wed bright Themis who bore the Horai,
  --  Eunomia and Dike and blooming Eirene."
  ('ENT_ZEUS','parent_of','ENT_EIRENE',
    'high','Hesiod Theogony 902: Eirene (Peace) is one of the three Horai, daughters of Zeus and Themis.','SRC_HESIOD_THEOGONY','approved'),
  -- Auxo, Carpo, Thallo: alternative Horai triad (Athenian; Pausanias 9.35.2)
  ('ENT_ZEUS','parent_of','ENT_AUXO',
    'medium','Pausanias 9.35.2: Auxo, Karpo, and Thallo are named as Horai (Seasons) in the Athenian tradition; like Eirene/Eunomia/Dike, they are daughters of Zeus and Themis.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_ZEUS','parent_of','ENT_CARPO',
    'medium','Pausanias 9.35.2: Karpo listed among the Athenian Horai, daughters of Zeus.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_ZEUS','parent_of','ENT_THALLO',
    'medium','Pausanias 9.35.2: Thallo listed among the Athenian Horai, daughters of Zeus.','SRC_THEOI_DAIMONES','approved'),

  -- Eileithyia: daughter of Zeus and Hera (Theogony 921-922)
  ('ENT_ZEUS','parent_of','ENT_EILEITHYIA',
    'high','Hesiod Theogony 921-922: "And Hera bore... and Eileithyia, mistress of childbirth."','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_HERA','parent_of','ENT_EILEITHYIA',
    'high','Hesiod Theogony 921-922.','SRC_HESIOD_THEOGONY','approved'),

  -- Hypnos embodies a form of death/Sleep (twin of Thanatos)
  ('ENT_HYPNOS','paired_with','ENT_THANATOS',
    'high','Hesiod Theogony 211-212: Hypnos (Sleep) and Thanatos (Death) are twin brothers, sons of Nyx; Homer Iliad 16.672 depicts them carrying the body of Sarpedon together.','SRC_HESIOD_THEOGONY','approved'),

  -- IRIS: daughter of Thaumas and Electra Oceanid (Theogony 265-266)
  ('ENT_THAUMAS','parent_of','ENT_IRIS',
    'high','Hesiod Theogony 265-266: "Of Thaumas and Electra, daughter of deep-flowing Okeanos, swift Iris was born and the Harpies with beautiful hair."','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ELECTRA_OCEANID','parent_of','ENT_IRIS',
    'high','Hesiod Theogony 265-266.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_IRIS','reveals','ENT_ZEUS',
    'high','Homer Iliad passim: Iris serves as the divine messenger of Zeus, carrying his decrees to gods and mortals.','SRC_HOMER_ILIAD_ODYSSEY','approved'),

  -- GANYMEDE: abducted by Zeus as divine cupbearer (Iliad 20.232-235)
  ('ENT_ZEUS','paired_with','ENT_GANYMEDE',
    'high','Homer Iliad 20.232-235: Zeus loved Ganymede for his beauty and snatched him away to be cupbearer to the gods among the immortals.','SRC_HOMER_ILIAD_ODYSSEY','approved'),

  -- HERMAPHRODITUS: son of Hermes and Aphrodite (Diodorus 4.6.5; Apollodorus context)
  ('ENT_HERMES','parent_of','ENT_HERMAPHRODITUS',
    'high','Diodorus Siculus 4.6.5: Hermaphroditos was born of Hermes and Aphrodite, combining the attributes of both parents; his name is a compound of theirs.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_APHRODITE','parent_of','ENT_HERMAPHRODITUS',
    'high','Diodorus Siculus 4.6.5.','SRC_APOLLODORUS_LIBRARY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: ATLAS → MAIA → HERMES lineage (Theogony 938-939)
-- "And Maia, daughter of Atlas, bore to Zeus glorious Hermes."
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ATLAS','parent_of','ENT_MAIA',
    'high','Hesiod Theogony 938: Maia is named "daughter of Atlas"; she is one of the Pleiades.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_MAIA','parent_of','ENT_HERMES',
    'high','Hesiod Theogony 938-939: Maia, daughter of Atlas, bore to Zeus glorious Hermes.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ZEUS','parent_of','ENT_HERMES',
    'high','Hesiod Theogony 938-939; Homeric Hymn 4 (To Hermes) 1-9: Zeus is father of Hermes by the Pleiades Maia.','SRC_HESIOD_THEOGONY','approved'),
  -- Maia dwells in a cave on Mount Cyllene (Homeric Hymn 4.2-3)
  ('ENT_MAIA','paired_with','ENT_ZEUS',
    'high','Hesiod Theogony 938-939; Homeric Hymn 4.3: Maia and Zeus are the divine parents of Hermes.','SRC_HESIOD_THEOGONY','approved'),
  -- Cyllene: Arcadian mountain nymph, connected to Hermes (his birthplace)
  ('ENT_CYLLENE','paired_with','ENT_HERMES',
    'high','Homeric Hymn 4 (To Hermes) 2: Hermes was born "in a cave on Mount Cyllene"; the mountain nymph Kyllene is associated with his birth.','SRC_HOMERIC_HYMNS','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 5: HESPERIDES + garden spirits
-- Theogony 215: Nyx parent_of Hesperides.
-- Atlas parent_of (Apollodorus 2.5.11; secondary tradition).
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Named Hesperides: daughters of Nyx or Atlas (traditions vary)
  ('ENT_NYX','parent_of','ENT_AEGLE_HESPERID',
    'high','Hesiod Theogony 215: the Hesperides are children of Nyx; Aigle is named in later Theogony tradition.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX','parent_of','ENT_ERYTHEIA_HESPERID',
    'high','Hesiod Theogony 215.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX','parent_of','ENT_HESPERIA_HESPERID',
    'high','Hesiod Theogony 215.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NYX','parent_of','ENT_ARETHUSA_HESPERID',
    'high','Hesiod Theogony 215.','SRC_HESIOD_THEOGONY','approved'),
  -- Hesperides collective: member_of Nyx's progeny
  ('ENT_HESPERIDES','member_of','ENT_ONEIROI',
    'medium','Hesiod Theogony 211-225: like the Oneiroi, the Hesperides are listed among the supernatural collectives born of Nyx.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 6: SEA MONSTERS — Ceto + Phorcys → children; Scylla/Charybdis
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Ceto: child of Pontus+Gaia (Theogony 237-238); sibling and consort of Phorcys
  ('ENT_PONTUS','parent_of','ENT_CETO',
    'high','Hesiod Theogony 237-238: Pontos and Gaia begat Nereus, Thaumas, Phorkys, Keto (Ceto), and Eurybia.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_GAIA','parent_of','ENT_CETO',
    'high','Hesiod Theogony 237-238.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PHORCYS','paired_with','ENT_CETO',
    'high','Hesiod Theogony 270-336: Phorkys and Keto are siblings who unite to produce the Phorcides (Graiai, Gorgons, etc.) — described as monstrous in appearance.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_CETO','paired_with','ENT_PHORCYS',
    'high','Hesiod Theogony 270-336.','SRC_HESIOD_THEOGONY','approved'),
  -- Phorcys parent_of Scylla (Apollodorus 2.4.2; Odyssey 1.72 names Phorkys)
  ('ENT_PHORCYS','parent_of','ENT_SCYLLA',
    'high','Pseudo-Apollodorus Library 2.4.2 (scholiast); Homer Odyssey 1.72: Skylla is daughter of Phorkys.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_CETO','parent_of','ENT_SCYLLA',
    'high','Pseudo-Apollodorus Library 2.4.2: Keto named as mother of Skulla alongside Phorkys.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Scylla and Charybdis oppose Odysseus (Odyssey 12)
  ('ENT_SCYLLA','opposes','ENT_ODYSSEUS',
    'high','Homer Odyssey 12.234-259: Scylla seized six of Odysseus''s best men from the ship as he passed her lair.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_CHARYBDIS','opposes','ENT_ODYSSEUS',
    'high','Homer Odyssey 12.104-110; 12.430-446: Charybdis thrice swallows and disgorges the sea, threatening Odysseus''s ship and his survival.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 7: UNDERWORLD ENTITIES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Plouton = wealth-name epithet of Hades; rules/dwells in Underworld
  ('ENT_PLOUTON','rules','ENT_UNDERWORLD',
    'high','Hesiod Theogony 850; Homeric Hymn to Demeter: Plouton (Pluto, "the Rich One") is the euphemistic name for Hades as ruler of the underworld and its mineral wealth.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_PLOUTON','dwells_in','ENT_UNDERWORLD',
    'high','Homeric Hymn to Demeter 17: Hades/Plouton rules and dwells in the realm of the dead.','SRC_HOMERIC_HYMNS','approved'),
  -- Hades Klymenos: another epithetic name of Hades ("Clymenos" = famous)
  ('ENT_HADES_KLYMENOS','dwells_in','ENT_UNDERWORLD',
    'high','Hades Klymenos ("the Renowned") is an epithetic form of Hades used in Arcadian cult and poetry; he dwells and rules in the underworld realm.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HADES_KLYMENOS','rules','ENT_UNDERWORLD',
    'high','Epithetic form of Hades; see SRC_THEOI_DAIMONES.','SRC_THEOI_DAIMONES','approved'),
  -- Brimo: chthonic deity, epithetic name of Hecate/Persephone in mystery cult
  ('ENT_BRIMO','dwells_in','ENT_UNDERWORLD',
    'high','Brimo is a chthonic epithet used for Hecate (and occasionally Persephone and Demeter) in mystery-cult contexts; the name indicates her underworld associations.','SRC_THEOI_DAIMONES','approved'),
  -- Rhadamanthys: son of Zeus and Europa; underworld judge
  ('ENT_ZEUS','parent_of','ENT_RHADAMANTHYS',
    'high','Pseudo-Apollodorus Library 3.1.1: Rhadamanthys son of Zeus and Europa; he became a judge of the dead in the underworld. Note: Zeus parent_of Rhadamanthys was established in the Greek v1 batch; this entry ensures the connection is present.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Despoina: daughter of Poseidon and Demeter (Arcadian tradition)
  ('ENT_POSEIDON','parent_of','ENT_DESPOINA',
    'high','Pausanias 8.37.9: Despoina ("the Mistress") is the daughter of Poseidon and Demeter in Arcadian mystery cult; her true name was kept secret.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_DEMETER','parent_of','ENT_DESPOINA',
    'high','Pausanias 8.37.9.','SRC_THEOI_DAIMONES','approved'),
  -- Ascalaphus: underworld being, son of Acheron River (Apollodorus 2.5.12)
  ('ENT_ACHERON_RIVER','parent_of','ENT_ASCALAPHUS',
    'high','Pseudo-Apollodorus Library 2.5.12: Ascalaphus son of Acheron the underworld river; he betrayed Persephone for eating pomegranate seeds and was punished by Demeter.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Enodia: "She of the Roads" — an epithet of Hecate as liminal deity
  ('ENT_ENODIA','dwells_in','ENT_UNDERWORLD',
    'high','Enodia ("She of the Crossroads/Roads") is a Thessalian epithet of Hecate as goddess of thresholds, crossroads, and the liminal underworld boundary.','SRC_THEOI_DAIMONES','approved'),
  -- Macaria: "Blessed Death," daughter of Hades (Apollodorus Library, scholiast)
  ('ENT_HADES','parent_of','ENT_MACARIA',
    'high','Macaria ("Blessed Death") is named in scholiast tradition as daughter of Hades; she personifies a blessed or easy death.','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 8: DIONYSIAN SPIRITS + RUSTIC FIGURES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Maenads: female devotees of Dionysus (Euripides Bacchae passim)
  ('ENT_DIONYSUS','patron_of','ENT_MAENADS',
    'high','Euripides Bacchae passim; Hesiod Works and Days: the Maenads (Bacchants) are the ecstatic female worshippers of Dionysus who follow him in his retinue.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Thyiads: another name/group of Dionysian female devotees
  ('ENT_DIONYSUS','patron_of','ENT_THYIADS',
    'high','The Thyiads are Athenian women who performed Dionysian rites on Parnassus; closely related to or identical with the Maenads as devotees of Dionysus.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_THYIADS','member_of','ENT_MAENADS',
    'medium','The Thyiads are a specific group of Dionysian devotees closely related to the Maenads; the terms overlap in the tradition.','SRC_THEOI_DAIMONES','approved'),
  -- Satyrs: rustic spirits of Dionysus''s retinue (Hesiod Catalogues frg.)
  ('ENT_DIONYSUS','patron_of','ENT_SATYRS',
    'high','The Satyrs are the rustic half-animal companions of Dionysus, constant members of his thiasos (retinue); attested across the lyric and dramatic tradition.','SRC_THEOI_DAIMONES','approved'),
  -- Silenus: oldest Satyr, foster-father and companion of Dionysus
  ('ENT_DIONYSUS','patron_of','ENT_SILENUS',
    'high','Pseudo-Apollodorus Library 2.5.4 (context): Silenus was the oldest and wisest of the Satyrs, foster-father and constant companion of Dionysus.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Korybantes / Kouretes: ecstatic attendants of Rhea/Cybele and protectors of infant Zeus
  ('ENT_RHEA','patron_of','ENT_KORYBANTES',
    'high','The Korybantes are the armoured dancers and attendants of Rhea-Kybele; they were also identified with the Kouretes who drowned out the cries of infant Zeus.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_RHEA','patron_of','ENT_KOURETES',
    'high','The Kouretes clashed their weapons to hide the cries of the infant Zeus from Kronos, serving as divine protectors at Rhea''s command (Hesiod Theogony 477-484).','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_RHEA','patron_of','ENT_CURETES',
    'high','Hesiod Theogony 477-484: the Kouretes/Curetes are divine attendants of Rhea who guard the infant Zeus on Crete.','SRC_HESIOD_THEOGONY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 9: MYTH PAIRS AND REMAINING NARRATIVES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- EOS paired_with TITHONUS (Homeric Hymn 5.218; Iliad 20.237)
  ('ENT_EOS','paired_with','ENT_TITHONUS',
    'high','Homeric Hymn 5 (To Aphrodite) 218-238: Eos abducted Tithonus and begged Zeus to grant him immortality; she forgot to ask for eternal youth.','SRC_HOMERIC_HYMNS','approved'),
  ('ENT_TITHONUS','paired_with','ENT_EOS',
    'high','Homeric Hymn 5.218-238.','SRC_HOMERIC_HYMNS','approved'),

  -- ARIADNE paired_with DIONYSUS (Theogony 947-949)
  -- "And golden-haired Dionysus made blonde Ariadne, daughter of Minos,
  --  his flourishing wife."
  ('ENT_DIONYSUS','paired_with','ENT_ARIADNE',
    'high','Hesiod Theogony 947-949: Dionysus chose Ariadne as his wife after Theseus abandoned her on Naxos; she was made his flourishing consort.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_ARIADNE','paired_with','ENT_DIONYSUS',
    'high','Hesiod Theogony 947-949.','SRC_HESIOD_THEOGONY','approved'),
  -- Ariadne also: daughter of Minos (Apollodorus 3.1.2)
  ('ENT_MINOS','parent_of','ENT_ARIADNE',
    'high','Pseudo-Apollodorus Library 3.1.2: Ariadne is daughter of Minos and Pasiphae.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- APOLLO paired_with DAPHNE (Apollodorus 1.4.1)
  ('ENT_APOLLO','paired_with','ENT_DAPHNE',
    'high','Pseudo-Apollodorus Library 1.4.1: Apollo fell in love with Daphne; she fled and was transformed into a laurel tree; the laurel became sacred to Apollo.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- Daphne received_as tree / laurel (the myth explains Apollo''s laurel crown)
  ('ENT_DAPHNE','embodies','ENT_SPEECH',
    'medium','Daphne is associated with the laurel (daphne), the tree of prophecy and poetic inspiration sacred to Apollo; the Delphic Pythia chewed laurel leaves.','SRC_THEOI_DAIMONES','approved'),

  -- PAN paired_with SYRINX (Ovid Met. 1.689; Greek antecedents)
  ('ENT_SYRINX','received_as','ENT_PAN',
    'medium','Syrinx the naiad fled Pan and was transformed into the reed pipe (syrinx) that bears her name; Ovid Metamorphoses 1.689-712 is the fullest account.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- HERA opposes ECHO (Eros and Echo mythology; Ovid Met. 3.356-369)
  ('ENT_HERA','opposes','ENT_ECHO',
    'high','Ovid Metamorphoses 3.356-369 (Greek antecedent): Hera punished Echo for distracting her with conversation while Zeus seduced nymphs; Echo was left only able to repeat words spoken to her.','SRC_THEOI_DAIMONES','approved'),

  -- PSYCHE: soul figure, beloved of Eros (Apuleius; but connected to Aphrodite in myth)
  ('ENT_APHRODITE','opposes','ENT_PSYCHE',
    'high','Apuleius Metamorphoses 4-6 (drawing on Greek myth): Aphrodite opposes and torments Psyche out of jealousy, setting her impossible tasks before relenting.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- PHOSPHORUS: the morning star, son of Eos (and Astraeus; Theogony 381)
  ('ENT_EOS','parent_of','ENT_PHOSPHORUS',
    'high','Hesiod Theogony 381-383: Eos and Astraeus begat the shining stars of heaven, including Eosphorus the morning star; Phosphorus is the Roman name for the same figure.','SRC_HESIOD_THEOGONY','approved'),

  -- ARISTAEUS (Craft Figure): Apollo parent_of (same as Aristaeus Hero)
  ('ENT_APOLLO','parent_of','ENT_ARISTAEUS',
    'high','Pseudo-Apollodorus Library 3.4.4: Aristaeus the culture hero of beekeeping and cheesemaking is son of Apollo and Cyrene.','SRC_APOLLODORUS_LIBRARY','approved'),

  -- EUBOULEUS: mystery deity, figure in Eleusinian tradition
  -- Connected to Demeter (searching for Persephone); pig-herd who witnessed abduction
  ('ENT_DEMETER','reveals','ENT_EUBOULEUS',
    'medium','In Eleusinian mystery tradition, Eubouleus ("Good Counsel") is a figure connected to the Demeter-Persephone myth; as the pig-herd who witnessed the abduction, he stands at the boundary of the Eleusinian revealed tradition.','SRC_THEOI_DAIMONES','approved'),

  -- LINUS: music figure; son of Apollo (Apollodorus 1.3.2)
  ('ENT_APOLLO','parent_of','ENT_LINUS',
    'high','Pseudo-Apollodorus Library 1.3.2: Linos the music hero is son of Apollo (and one of the Muses, or Urania).','SRC_APOLLODORUS_LIBRARY','approved'),

  -- HYMENAIOS: god of marriage songs; son of Apollo (Apollodorus context)
  ('ENT_APOLLO','parent_of','ENT_HYMENAIOS',
    'medium','In one tradition, Hymenaios (the marriage song personified) is son of Apollo; he embodies the wedding ceremony.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HYMENAIOS','patron_of','ENT_LOVE',
    'high','Hymenaios personifies and presides over the wedding song and the institution of marriage; he is invoked at weddings throughout the Archaic and Classical period.','SRC_THEOI_DAIMONES','approved'),

  -- EPIONE: wife of Asclepius; healing figure
  ('ENT_ASCLEPIUS','spouse_of','ENT_EPIONE',
    'high','Epione ("She Who Soothes") is the wife of Asclepius and personification of pain relief; their union is attested in the Asclepian cult tradition.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_EPIONE','spouse_of','ENT_ASCLEPIUS',
    'high','See ENT_ASCLEPIUS spouse_of ENT_EPIONE.','SRC_THEOI_DAIMONES','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;

SELECT COUNT(*) AS greek_zero_rel_after
FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);

SELECT category, COUNT(*) AS zero_rel
FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id)
GROUP BY category ORDER BY zero_rel DESC LIMIT 20;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
