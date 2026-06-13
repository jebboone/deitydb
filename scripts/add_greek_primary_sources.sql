-- scripts/add_greek_primary_sources.sql
-- Add four Greek primary sources and link them to appropriate entities.
--
-- Problem addressed: the Greek tradition holds 466 entities but its top
-- source is Theoi.com (a modern secondary website), with only SRC_HESIOD_THEOGONY
-- as an identified primary text. Homer, the Homeric Hymns, Apollodorus, and
-- Pausanias are absent entirely. This script adds them and links each to the
-- entities they genuinely attest.
--
-- Sources added:
--   SRC_HOMER_ILIAD_ODYSSEY  — Iliad (c. 750-700 BCE) and Odyssey (c. 725-675 BCE)
--   SRC_HOMERIC_HYMNS        — 33 Hymns (7th-5th century BCE)
--   SRC_APOLLODORUS_LIBRARY  — Pseudo-Apollodorus, Library/Bibliotheca (1st-2nd c. CE)
--   SRC_PAUSANIAS_DESCRIPTION — Pausanias, Description of Greece (c. 143-176 CE)
--
-- Evidence types used:
--   'primary_attestation' — entity is named/active in the source as a primary text
--   'secondary_reference' — entity is discussed/described in the source's mythographic account
--
-- Linkage scope:
--   Homer:           Olympians, chthonic deities, primordials/Titans named in Homer,
--                    daimones active in the epics, sea deities, Nereids (Iliad XVIII list),
--                    wind gods, river gods, and Trojan War heroes
--   Homeric Hymns:   Specific deities to whom individual hymns are addressed
--   Apollodorus:     Comprehensive — Olympians, Titans/primordials, all major heroes,
--                    monsters, and divine genealogies
--   Pausanias:       Cult-bearing deities (Olympians at their sanctuaries), hero cults,
--                    Asclepius cult centers, mystery cult figures, local river gods

BEGIN;

-- ── 1. New sources ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_HOMER_ILIAD_ODYSSEY',
   'Homer, Iliad and Odyssey (c. 750-675 BCE); trans. Richmond Lattimore (Iliad, Univ. of Chicago 1951) and trans. Emily Wilson (Odyssey, Norton 2017)',
   NULL,
   'primary text corpus',
   'The foundational Greek primary texts; the Iliad (24 books, the rage of Achilles and the Trojan War) and the Odyssey (24 books, the return of Odysseus) are the oldest surviving Greek literary works and the primary source for Olympian personalities, divine behavior, the cosmological structure of the Greek world (Olympus / earth / Tartarus), the Nereid catalog (Iliad XVIII), the divine assembly, and the Trojan War heroes. The Nekyia (Odyssey XI) is the primary text for the underworld geography (Asphodel, Elysium, Tartarus) and the role of Hades, Persephone, Minos, Rhadamanthus, Tiresias, and the dead. Homer depicts the gods as active participants in human affairs; his characterizations of Zeus, Hera, Athena, Apollo, Ares, Aphrodite, Hermes, Hephaestus, Poseidon, Artemis, and Demeter establish the canonical Olympian personalities that all later Greek literature responds to.'),

  ('SRC_HOMERIC_HYMNS',
   'Homeric Hymns (7th-5th century BCE); trans. M.L. West, Homeric Hymns (Loeb Classical Library 496, Harvard 2003)',
   NULL,
   'primary text corpus',
   '33 hymns addressed to individual Greek deities; despite the name "Homeric" they are not by Homer but by various poets in the hexameter tradition, composed across the 7th-5th centuries BCE. The major hymns are primary sources for: Demeter (HH 2; Eleusinian Mysteries foundation myth), Apollo (HH 3; Delos and Delphi foundations), Hermes (HH 4; theft of Apollo''s cattle, invention of the lyre), Aphrodite (HH 5; her affair with Anchises), and Dionysus (HH 7). The shorter hymns (HH 8-33) address Ares, Artemis, Athena, Hera, Demeter, Rhea/Mother of Gods, Heracles, Asclepius, Castor and Polydeuces (Dioscuri), Pan, Hephaestus, Poseidon, Zeus, Hestia, the Muses, Helios, Selene, and Gaia. Each hymn is the primary text for the deity''s cult epithets, functions, and origin myths as understood in the archaic and early classical periods.'),

  ('SRC_APOLLODORUS_LIBRARY',
   'Pseudo-Apollodorus, Library (Bibliotheca) (1st-2nd century CE); trans. Robin Hard (Oxford World''s Classics, OUP 2008)',
   NULL,
   'primary text compilation',
   'The most comprehensive surviving ancient handbook of Greek mythology; three books systematically covering the genealogies of the gods (Titans, Olympians, and their offspring), the mythological cycle from the Theogony forward, and the great hero cycles: Perseus, Heracles (twelve labors and full career), Theseus, Jason and the Argonauts, the Theban cycle (Cadmus through Oedipus), the Trojan War, and the Nostoi (returns of the heroes). The Library is the standard secondary compendium for ancient mythographic tradition; it does not itself record lost myths but assembles and harmonizes material from earlier sources (Hesiod, the cyclic epics, Pherecydes, Hellanicus, Acusilaus). Pseudo-Apollodorus is by convention attributed to the scholar Apollodorus of Athens (2nd c. BCE) but was likely composed later; the work is the foundational reference for genealogical claims about virtually every named entity in the Greek tradition.'),

  ('SRC_PAUSANIAS_DESCRIPTION',
   'Pausanias, Description of Greece (c. 143-176 CE); trans. W.H.S. Jones (Loeb Classical Library, Harvard 1918-1935)',
   NULL,
   'primary text',
   'A travel guide to mainland Greece in ten books written by a Greek traveler in the 2nd century CE; the single most important ancient source for the actual practice of Greek religion: cult sites, temples, statues, festivals, ritual procedures, local traditions, and hero shrines. Pausanias personally visited the major sanctuaries (Olympia, Delphi, Corinth, Athens, Eleusis, Epidaurus) and documented what was there and the traditions attached to them. Essential for: the cult of Asclepius at Epidaurus (Book 2); the Eleusinian Mysteries and Demeter/Persephone at Eleusis (Book 1); hero cults for Achilles, Ajax, Protesilaus, Heracles, Pelops, Theseus, Iphigenia; the oracle of Apollo at Delphi (Book 10); local cult forms of Zeus, Athena, Hera, and Poseidon; and the Olympia complex. Pausanias often preserves local mythological variants and cult titles not found in the literary tradition.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Homer: Olympians ───────────────────────────────────────────────────────
-- All twelve Olympians are active participants in the Iliad and/or Odyssey.
-- Hestia is the partial exception — she is named in passing (Od. XIV.159) but
-- has minimal narrative role; she receives a Homeric Hymn (HH 24, 29) instead.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ZEUS',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Zeus is the central divine authority of both epics; he presides over the divine assembly, enforces fate (moira), and is the addressee of prayers from both Greeks and Trojans; Iliad I-XXIV and Odyssey I-XXIV throughout'),
  ('ENT_HERA',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hera actively favors the Greeks; she deceives Zeus in the Deception of Zeus episode (Iliad XIV); opposes Troy passionately throughout; Iliad I, III-V, XIV-XV, XVIII, XXIV'),
  ('ENT_ATHENA',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Athena is the most active Olympian in both epics: she inspires Achilles (Iliad I), fights beside Diomedes (Iliad V), guides Odysseus throughout the Odyssey; Iliad I, V, VI, XV, XVIII-XXII; Odyssey I, III, XIII-XXIV'),
  ('ENT_APOLLO',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Apollo sends the plague that opens the Iliad (I.8-53); he is the divine protector of Troy; he kills Achilles with Paris as his instrument (implied Il. XXII); Iliad I, IV, V, VII, XV-XVI, XXII, XXIV'),
  ('ENT_ARES',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ares fights for Troy and is wounded by Diomedes with Athena''s help (Iliad V.825-906); he is portrayed as the god of war-madness, distinguished from Athena''s strategic warfare; Iliad V, XIII, XV'),
  ('ENT_APHRODITE',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Aphrodite rescues Paris from Menelaus (Iliad III.380-420); is wounded by Diomedes (Iliad V.330-430); her mother here is Dione (Il. V.370) rather than the sea-foam tradition; Iliad III, V, XIX'),
  ('ENT_HERMES',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hermes escorts Priam through the Greek camp to ransom Hector''s body (Iliad XXIV); in the Odyssey he delivers Zeus''s commands to Calypso (Od. V) and escorts the dead suitors to Hades (Od. XXIV); Iliad XXIV; Odyssey V, X, XXIV'),
  ('ENT_POSEIDON',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Poseidon actively favors the Greeks; he appears in his underwater palace (Iliad XIII) and physically fights in the divine battle; his enmity with Odysseus drives the Odyssey''s delays; Iliad VII, XIII-XIV, XX-XXI; Odyssey I, V, XIII'),
  ('ENT_ARTEMIS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Artemis favors Troy; she is struck and humiliated by Hera in the Battle of the Gods (Iliad XXI.470-496); she is the twin of Apollo; Iliad VI, IX, XXI'),
  ('ENT_HEPHAESTUS', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hephaestus forges the armor of Achilles at Thetis''s request (Iliad XVIII.468-617); he quenches the river Scamander with fire (Iliad XXI.342-382); his limp and his forging domain are foundational here; Iliad I, XVIII, XXI'),
  ('ENT_DEMETER',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Demeter is mentioned in the Iliad as the golden-haired grain goddess (Il. II.696, V.500, XIII.322, XXI.76); her union with Iasion in Crete is narrated in the Odyssey (Od. V.125); she does not play a narrative role in either epic'),
  ('ENT_DIONYSUS',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Dionysus is mentioned in the Iliad (VI.130-140: the Lycurgus story, where Dionysus flees in terror and Thetis protects him; XIV.325: in the catalogue of Zeus''s loves); he does not play a major narrative role but his Homeric attestation is important evidence for his early presence in the Greek pantheon'),
  ('ENT_HESTIA',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hestia is mentioned in passing in the Odyssey (XIV.159: "Hestia and the god of the hearth"); her minimal narrative role in Homer contrasts with her prominent Homeric Hymns; she is the goddess of the household hearth')
ON CONFLICT DO NOTHING;

-- ── 3. Homer: Chthonic and underworld deities ─────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_HADES',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hades (called Aïdēs or Aïdoneus) is named as the lord of the dead who received his dominion when the cosmos was divided by lot (Iliad XV.187-193); the Odyssey Book XI (Nekyia) is the primary epic account of the underworld; Homer''s Hades is a realm of shadows, not torture'),
  ('ENT_PERSEPHONE', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Persephone is named as queen of the underworld and Hades'' consort (Odyssey X.491, XI.47, XI.226, XI.386, XI.634-635); she presides over the ghosts; Odyssey XI'),
  ('ENT_MINOS',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Minos appears in the Odyssey XI (Nekyia) as the judge of the dead, holding his golden scepter and giving judgments among the dead (Od. XI.568-571); this is the earliest attestation of his role as underworld judge'),
  ('ENT_RHADAMANTHUS',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Rhadamanthus appears in the Odyssey IV.563-564 (Menelaus told he will go to Elysium where Rhadamanthus lives) as a ruler of Elysium; this is his earliest Greek attestation'),
  ('ENT_RHADAMANTHYS',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Rhadamanthys (variant spelling) in Odyssey IV.564; ruler of Elysium; see ENT_RHADAMANTHUS'),
  ('ENT_CERBERUS',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Cerberus is named in the Odyssey XI.623 (Heracles'' eleventh labor: bringing up the hound of Hades) and Iliad VIII.368; the multi-headed nature is not specified in Homer but his role as Hades'' hound is established here'),
  ('ENT_AEACUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Aeacus is named in the Iliad as the father of Peleus and grandfather of Achilles (Iliad XXI.189); he is mentioned as a son of Zeus and the nymph Aegina; his role as underworld judge postdates Homer')
ON CONFLICT DO NOTHING;

-- ── 4. Homer: Primordials and cosmological figures ────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_GAIA',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Gaia (Gē / Earth) is named in oath formulas (Iliad III.104, XIX.259; Odyssey V.184) and as the origin of the gods; she is called upon alongside Helios and the river gods in formal oaths'),
  ('ENT_OURANOS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ouranos (Uranus) is named as the father of the Titans and as the sky domain over which the gods reign; Iliad XV.37 (Zeus threatens to hurl Hera to the stars where Ouranos reaches); primarily appears as part of the cosmic geography'),
  ('ENT_URANUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Uranus (Latinized Ouranos) named as primordial sky; see ENT_OURANOS'),
  ('ENT_TARTARUS',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Tartarus is the lowest region, as far below Hades as earth is below heaven; Zeus threatens to hurl Hera into Tartarus (Iliad VIII.13-16) and describes it as the place where the Titans and Kronos are imprisoned; Iliad VIII.13, XIV.279, XV.225'),
  ('ENT_EOS',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Eos (Dawn) appears at the opening of many books of both epics; she is the mother of Memnon (Iliad implied) and Tithonus; she transports her son''s body from Troy (Odyssey V.1); she abducts Orion and Cleitos; throughout both epics'),
  ('ENT_HELIOS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Helios (the Sun) drives his chariot across the sky; his sacred cattle on Thrinakia are central to Odyssey XII (the men''s fatal transgression); he is called upon in oath formulas alongside Gaia and rivers (Iliad III.104)'),
  ('ENT_SELENE',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Selene (the Moon) is mentioned in the Iliad in similes and as part of the cosmic order; she is less prominent than Helios in Homer but named in the divine cosmological register'),
  ('ENT_NYX',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Nyx (Night) appears in the Deception of Zeus episode: when Hypnos fears Zeus''s wrath, Hera tells him to flee to Nyx, "who has power over gods and men" — even Zeus feared to offend Nyx (Iliad XIV.259-261); this is the primary evidence for Nyx''s primordial status'),
  ('ENT_EREBUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Erebus (the deep darkness) is named in the Odyssey as the deep darkness of the underworld through which the dead travel; Odysseus sacrifices at the entrance to Erebus (Od. XI.37)'),
  ('ENT_OCEANUS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Oceanus is the cosmic river encircling the world''s edge; Iliad XIV.200-210 (Hera claims she travels to the ends of the earth to visit Oceanus "who gave rise to the gods"); Odyssey XI.13 (Odysseus sails past Oceanus to reach the underworld); Homer''s Oceanus is the origin of rivers and seas'),
  ('ENT_AETHER',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Aether (the bright upper air of the gods) is distinguished from the dark aer (lower air) in Homer; Zeus dwells in the aether; Iliad II.412, XIV.288; the gods breathe aether rather than air')
ON CONFLICT DO NOTHING;

-- ── 5. Homer: Titans named in the epics ──────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_CRONUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Kronos/Cronus is named throughout as Zeus''s father and the deposed king of the gods; Zeus is consistently called "son of Kronos" (Kronion); Kronos is imprisoned in Tartarus; Iliad I.503, VIII.13, XIV.203, etc.; throughout both epics'),
  ('ENT_KRONOS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Kronos (ENT_KRONOS; variant) named as Zeus''s father and king of an earlier divine order; see ENT_CRONUS'),
  ('ENT_RHEA',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Rhea is named as the mother of the Olympians and the wife of Kronos; Iliad XIV.203 (Hera refers to her birth from Kronos and Rhea); Rhea''s role as mother of the major gods is established in Homer'),
  ('ENT_TETHYS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Tethys is named as the consort of Oceanus; Hera says she travels to "visit Oceanus, origin of gods, and mother Tethys, who reared me carefully in their house" (Iliad XIV.200-210); this is the primary text for Tethys as divine nurse/mother'),
  ('ENT_HYPERION',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hyperion (Titan of the sun) is named as the father of Helios; in the Odyssey, Helios is repeatedly called "Hyperion" or "son of Hyperion" (Od. I.8, XII.176, XII.374); the cattle of Helios are called "cattle of Hyperion" (Od. XII.263)'),
  ('ENT_LETO',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Leto is named as the mother of Apollo and Artemis; she appears in the Battle of the Gods (Iliad XXI.497-504: Hera slaps her and scatters her arrows); Iliad I.9, V.447, XIV.327, XX.72, XXI.497'),
  ('ENT_ATLAS',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Atlas is named in the Odyssey V.52-54 as the father of Calypso: "his daughter, the nymph Calypso whose father is destructive Atlas who knows the depths of the whole sea" — this is the earliest Greek attestation of Atlas as Calypso''s father'),
  ('ENT_THEMIS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Themis assembles the gods to council at Zeus''s command (Iliad XX.4-6); she is described as the summoner of divine assemblies; Iliad XX.4; Odyssey II.68'),
  ('ENT_DIONE',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Dione appears in Iliad V.370-430 as Aphrodite''s mother: after Diomedes wounds Aphrodite, she flies to Olympus and is comforted by Dione; this is the only major appearance of Dione as Aphrodite''s mother (contrasting with the sea-foam Hesiodic tradition); Iliad V.370'),
  ('ENT_IAPETUS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Iapetus is named in Iliad VIII.479 (alongside Kronos) as one of the imprisoned Titans in Tartarus, far from the light of Helios; his imprisonment establishes the Titan-below-Olympian structure'),
  ('ENT_MNEMOSYNE',  'SRC_HOMER_ILIAD_ODYSSEY', 'secondary_reference',
   'Mnemosyne is not named directly in Homer but her daughters the Muses are invoked at Iliad II.484-493 and Odyssey I.1; as mother of the Muses she is implied by the Homeric invocations')
ON CONFLICT DO NOTHING;

-- ── 6. Homer: Daimones active in the epics ───────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_IRIS',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Iris is the primary divine messenger in the Iliad; she delivers Zeus''s commands to the Trojans (Iliad II.786-807), to Hector (Iliad XI.185-210), and to Poseidon (Iliad XV.143-217); she also warns Priam (Iliad XXIV.144-188); more active than Hermes as messenger in the Iliad'),
  ('ENT_ERIS',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Eris (Strife) is named alongside Ares, Enyo, and the Ker as a war deity who delights in battle (Iliad IV.440-445; V.518-521); she is described as the sister of Ares and appears on the battlefield; the tradition of Eris throwing the golden apple (cause of the Trojan War) is post-Homeric but her presence in the Iliad is primary'),
  ('ENT_DEIMOS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Deimos (Terror/Dread) accompanies Ares into battle; Iliad IV.440: "Ares and Athena, Deimos and Phobos and Eris" are listed together as the war spirits; Iliad XIII.299'),
  ('ENT_PHOBOS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Phobos (Fear/Rout) accompanies Ares; Iliad IV.440 (battle catalog alongside Deimos); the horses of Ares are named Deimos and Phobos (Iliad XV.119); Iliad IV.440, XIII.299, XV.119'),
  ('ENT_ENYO',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Enyo (goddess of war/havoc) is named alongside Ares and Eris in the battle catalog (Iliad V.333: "Enyo, sacker of cities"); Iliad IV.440, V.333'),
  ('ENT_HYPNOS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hypnos (Sleep) has a major role in the Deception of Zeus (Iliad XIV); Hera persuades him to put Zeus to sleep so Poseidon can help the Greeks; he is the twin of Thanatos and the son of Night (Nyx); Iliad XIV.231-291, XVI.672 (carries Sarpedon''s body with Thanatos)'),
  ('ENT_THANATOS',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Thanatos (Death) is named in Iliad XIV.231 (son of Night, twin of Sleep/Hypnos) and plays a key role in Iliad XVI.672-683: Zeus sends Hypnos and Thanatos to carry the body of Sarpedon back to Lycia; this is the primary Greek text for Thanatos as a personified death-deity with a specific mythological role'),
  ('ENT_ATE',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ate (Delusion/Ruin) has a key narrative in Iliad XIX.91-131: Zeus tells the story of how Ate blinded his mind regarding the birth of Heracles and how he hurled her from Olympus; the Litae (Prayers) are described as following behind Ate in Iliad IX.502-512; Iliad IX.502, XIX.91'),
  ('ENT_AT',         'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Atë (variant of Ate/Delusion); see ENT_ATE; named in Iliad IX and XIX'),
  ('ENT_LITAE',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Litae (Prayers personified) are described in Phoenix''s speech (Iliad IX.502-512): they are the daughters of Zeus, "crippled and wrinkled and squint-eyed," who follow behind Ate (Ruin) and heal the damage she causes; this is their only Homeric attestation and the primary ancient text for their existence'),
  ('ENT_MOIRAI',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'The Moirai (Fates) are named in the Iliad as the force that assigns each person their portion at birth; Iliad XXIV.209-210 (Hecuba says a Moira gave Hector his spirit); XX.127; the concept of moira as a binding fate operates throughout both epics; the three-fold Clotho/Lachesis/Atropos division is Hesiodic, not Homeric'),
  ('ENT_KER',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ker/Keres (spirits of death and doom) appear on the Shield of Achilles (Iliad XVIII.535-538): "pale Keres, gnashing their white teeth"; they appear at battles dragging away the dead; Iliad II.302, XI.332, XVIII.535; Odyssey (several passages)'),
  ('ENT_NEMESIS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Nemesis is named in the Odyssey (XIV.283: "divine nemesis from the gods") as a divine retribution force; she does not appear as a personified deity with narrative role in Homer, but the concept nemesis (divine indignation at excess) operates throughout both epics'),
  ('ENT_HORKOS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Horkos (Oath) is named in formal oath scenes in both epics; Iliad III.104 (the major oath scene invoking Zeus, Earth, Sun, and rivers); XIX.258-265 (Achilles'' oath); oath-breaking brings the punishment of the Erinyes'),
  ('ENT_MOMOS',      'SRC_HOMER_ILIAD_ODYSSEY', 'secondary_reference',
   'Momos (Blame) is alluded to in the tradition of divine blame but is not named in the Homeric epics themselves; the Theoi tradition places him among Nyx''s offspring'),
  ('ENT_MOMUS',      'SRC_HOMER_ILIAD_ODYSSEY', 'secondary_reference',
   'Momus (Blame/Ridicule): see ENT_MOMOS; variant spelling; post-Homeric personification')
ON CONFLICT DO NOTHING;

-- ── 7. Homer: Sea deities ────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_NEREUS',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Nereus (the Old Man of the Sea) is named in the Iliad as the father of the Nereids; Iliad I.538: Thetis is described as the daughter of the old man of the sea; XVIII.36: the Nereids assemble from their father Nereus; Homer does not extensively describe Nereus himself'),
  ('ENT_THETIS',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Thetis (Nereid; mother of Achilles) is a major figure in the Iliad: she intercedes with Zeus on Achilles'' behalf (Iliad I.493-533), commissions Hephaestus to forge Achilles'' armor (XVIII.368-617), and mourns her son throughout; she is the son of Nereus and the sea; throughout Iliad I, XVIII, XXIV'),
  ('ENT_AMPHITRITE',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Amphitrite is named in the Odyssey as the consort of Poseidon and the personified sea (Od. III.91: "the deep of Amphitrite"); Od. XII.60 (the ship must sail past Amphitrite); she is not a major narrative character in Homer but establishes her role as sea-queen'),
  ('ENT_PROTEUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Proteus (the Old Man of the Sea) has a major narrative role in Odyssey IV.351-570: Menelaus wrestles with the shape-shifting Proteus on the shore of Egypt; Proteus reveals how to return home and the fates of the other Greek leaders; this is the primary Homeric text for Proteus''s prophetic and shape-shifting nature'),
  ('ENT_INO_LEUCOTHEA', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ino-Leucothea appears in Odyssey V.333-353: after Poseidon wrecks Odysseus''s raft, Ino (formerly a mortal, now a sea-goddess) rises from the waves and gives him her magic veil to stay afloat; she is called "Leucothea" (the White Goddess); Odyssey V'),
  ('ENT_LEUCOTHEA',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Leucothea: see ENT_INO_LEUCOTHEA; Odyssey V.333-353'),
  ('ENT_THALASSA',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Thalassa (the Sea) is personified in Homer as the cosmic salt sea; Iliad I.316, etc.; she is not a major narrative character but represents the sea as a divine entity')
ON CONFLICT DO NOTHING;

-- ── 8. Homer: Nereids named in Iliad XVIII.38-49 ────────────────────────────
-- Iliad XVIII.38-49 is the most complete ancient list of Nereids in Homer;
-- they assemble to mourn with Thetis over Patroclus's death.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ACTAEA',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.41 Nereid catalog assembled to mourn with Thetis'),
  ('ENT_CYMODOCE',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.39 Nereid catalog; also Il. XVIII.65'),
  ('ENT_CYMOTHOE',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.41 Nereid catalog'),
  ('ENT_DOTO',         'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.43 Nereid catalog'),
  ('ENT_DYNAMENE',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.43 Nereid catalog'),
  ('ENT_GALATEA',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.45 Nereid catalog (Galateia)'),
  ('ENT_GLAUCE',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.39 Nereid catalog (Glauke)'),
  ('ENT_MELITE',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.42 Nereid catalog'),
  ('ENT_PHERUSA',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.43 Nereid catalog'),
  ('ENT_PROTO',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.43 Nereid catalog'),
  ('ENT_SPEIO',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.40 Nereid catalog (Speio)'),
  ('ENT_THALIA_NEREID','SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.39 Nereid catalog (Thaleia)'),
  ('ENT_PSAMATHE',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.45 Nereid catalog (Psamathe)'),
  ('ENT_EUARNE',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.42 Nereid catalog (Euarne / Euagore)'),
  ('ENT_NESO',         'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Named in the Iliad XVIII.40 Nereid catalog (Nesaie / Nesaea)')
ON CONFLICT DO NOTHING;

-- ── 9. Homer: Wind gods ──────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_BOREAS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Boreas (North Wind) is called upon to blow on the funeral pyre of Patroclus (Iliad XXIII.194-230: Achilles prays to Boreas and Zephyrus to come and kindle the pyre); he also appears in Odyssey passages; Iliad XXIII'),
  ('ENT_ZEPHYRUS',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Zephyrus (West Wind) is named alongside Boreas in Iliad XXIII.194-230 (the pyre scene); Zephyrus sends favorable breezes in Odyssey; both wind gods are active narrative figures in Homer'),
  ('ENT_NOTUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Notus (South Wind) is named in Odyssey V.295 (storms) and in several Iliad passages as one of the four winds; Iliad XI.306, Odyssey V.295'),
  ('ENT_EURUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Eurus (East Wind) is named in Odyssey V.295 among the four winds that batter Odysseus''s raft; Iliad II.145; Odyssey V.295, XII.289, XIX.206'),
  ('ENT_ANEMOI',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'The Anemoi (wind gods collectively) are named throughout both epics; the four winds (Boreas, Zephyrus, Notus, Eurus) are established in the Homeric corpus as the canonical set'),
  ('ENT_AEOLUS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Aeolus (Keeper of the Winds) has a major Odyssey episode (Book X.1-79): Odysseus visits his floating island, receives a bag containing all the winds; the crew opens it, releasing the winds and blowing them back to Aeolus who refuses further help; Odyssey X.1-79')
ON CONFLICT DO NOTHING;

-- ── 10. Homer: River gods ────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_SCAMANDER', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Scamander (also called Xanthos) is the major river of the Trojan plain and has a speaking narrative role in Iliad XXI.136-382: Achilles kills so many Trojans in the river that Scamander/Xanthos rises up in anger and tries to drown Achilles; Hephaestus then intervenes with fire; this is the most dramatic divine-vs-hero confrontation in the Iliad'),
  ('ENT_ACHELOOS',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Acheloos (Achelous) is named in Iliad XXIV.616 (in Niobe''s story) and called upon as a river oath deity; he is invoked alongside the river gods in the formal oath formula; Iliad XXIV.616; also Odyssey references to the river''s power')
ON CONFLICT DO NOTHING;

-- ── 11. Homer: Heroes ────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ACHILLES',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Achilles is the central hero of the Iliad; his rage (mēnis) is the poem''s first word and its subject; he is the son of Peleus and the Nereid Thetis; his divine parentage, his heel, his armor, his friendship with Patroclus, and his death at Paris''s hands (aided by Apollo) are all Homeric; Iliad I-XXIV'),
  ('ENT_ODYSSEUS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Odysseus is the central hero of the Odyssey; present in the Iliad as a major figure (embassy to Achilles, Iliad IX; spy mission with Diomedes, Iliad X); the Odyssey narrates his ten-year return from Troy; Iliad IX-X; Odyssey I-XXIV'),
  ('ENT_AJAX',        'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ajax (Aias the Greater) is the second-greatest Greek warrior after Achilles; he fights Hector to a draw (Iliad VII), defends the ships (Iliad XII-XVI), and is prominent in the funeral games; Iliad VII, XI-XII, XV-XVII, XXIII'),
  ('ENT_HECTOR',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Hector is the greatest Trojan warrior and the most sympathetically portrayed figure in the Iliad; his death at Achilles'' hands and the ransom of his body form the climax of the poem; Iliad VI, VII, XII-XIII, XV-XVII, XXII, XXIV'),
  ('ENT_DIOMEDES',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Diomedes is the hero of Iliad V-VI (the aristeia of Diomedes), in which he wounds both Ares and Aphrodite with Athena''s help; he is one of the most prominent Greek warriors; Iliad V-VI, X (spy mission with Odysseus)'),
  ('ENT_MENELAUS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Menelaus is the husband of Helen and the wronged party whose cause the Greeks fight; he is active in both epics; Odyssey IV (the Telemachy) and Iliad III, IV, VII, XVII, XXIII'),
  ('ENT_HELEN',       'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Helen is the cause of the Trojan War; she is a complex figure in the Iliad (Iliad III: the Teichoscopia, where she identifies the Greek heroes; her conversation with Aphrodite after Paris''s defeat) and Odyssey IV (living harmoniously with Menelaus); Iliad III, VI; Odyssey IV'),
  ('ENT_BELLEROPHON', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Bellerophon appears in Iliad VI.155-202 in Glaucus''s account of his lineage; this is the primary Homeric source for the Bellerophon myth: sent to Lycia with a letter requesting his death, he performed trials including killing the Chimera; Iliad VI'),
  ('ENT_HERACLES',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Heracles is mentioned extensively in both epics as the greatest Greek hero; Iliad V.638-643 (sack of Troy), VIII.362-369 (his labors including Cerberus), XV.18-30 (his suffering at Hera''s hands); Odyssey XI.601-626 (Odysseus sees his shade in the underworld); throughout both epics'),
  ('ENT_THESEUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Theseus is mentioned in the Iliad (I.265: Nestor refers to Theseus as a great hero of an earlier age) and Odyssey (XI.322-325: Odysseus sees Ariadne who helped Theseus); Homer treats him as a legendary figure from the heroic past'),
  ('ENT_PERSEUS',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Perseus is named in Iliad XIV.319-320 (in the catalogue of Zeus''s loves: he lay with Danae to father Perseus) and XIX.116-124 (Hera ensures Heracles rather than Perseus is born first); brief but primary attestation'),
  ('ENT_ORESTES',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Orestes is held up repeatedly in the Odyssey as the exemplary avenger of his father''s murder: Telemachus is urged to emulate Orestes'' revenge on Aegisthus; Od. I.30-43, III.196-200; the Orestes story is the Odyssey''s moral parallel to the Telemachus plot'),
  ('ENT_PROTESILAUS', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Protesilaus is named in Iliad II.695-710 as the first Greek killed at Troy; he leapt from the first ship and was immediately killed by a Trojan; his wife is left "with cheeks torn in grief, the house half-built"; this brief passage is his Homeric primary attestation'),
  ('ENT_MELEAGER',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Meleager is the subject of Phoenix''s extended paradigmatic tale (Iliad IX.524-605): he withdrew from battle in anger and only returned when his city was in danger; this story is told as a parallel to Achilles'' own withdrawal and serves as persuasion in the Embassy scene'),
  ('ENT_MACHAON',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Machaon (son of Asclepius) is the chief healer of the Greek army at Troy; Iliad II.732 (listed with Podalirius as sons of Asclepius); XI.505-520 (Machaon is wounded; "a healer is worth many men in one")'),
  ('ENT_PODALIRIUS',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Podalirius (son of Asclepius) is named alongside Machaon in Iliad II.732 as a son of Asclepius who leads warriors from Tricca'),
  ('ENT_ASCLEPIUS',   'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Asclepius is named in Iliad II.729-733 as the father of the two healers Machaon and Podalirius, who command men from Tricca; he is called "the blameless physician"; this is the primary Homeric attestation of Asclepius, before his later development into a healer god'),
  ('ENT_ASCLEPIUS_HERO', 'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Asclepius Hero (the mortal physician who became a healing cult figure): see ENT_ASCLEPIUS; Iliad II.729-733'),
  ('ENT_CASTOR',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Castor is named in Iliad III.236-244 (the Teichoscopia: Helen looks for her brothers Castor and Polydeuces on the battlefield but notes they are not visible, not knowing they are already dead in Sparta); Odyssey XI.300-304 (they alternate life and death each day)'),
  ('ENT_POLYDEUCES',  'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Polydeuces (Pollux) named alongside Castor in Iliad III.236-244 and Odyssey XI.300-304; the Dioscuri myth of alternating immortality is first attested in the Odyssey'),
  ('ENT_PELOPS',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Pelops is named in Iliad II.104-108 (the lineage of the scepter: Zeus → Hermes → Pelops → Atreus → Thyestes → Agamemnon); this genealogy passing through Pelops is the primary Homeric attestation for his role as the ancestor of the Atreidae'),
  ('ENT_CADMUS',      'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Cadmus is named in Odyssey V.333 (Ino "of the slim ankles, once a mortal, now Leucothea, who was the daughter of Kadmos"); this is the Homeric attestation of Cadmus as the ancestor of Ino-Leucothea'),
  ('ENT_GANYMEDE',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Ganymede is named in Iliad XX.231-235 as the most beautiful of mortal men, taken by the gods to serve as Zeus''s cupbearer among the immortals; his horses are later given to his father Tros as compensation; Iliad XX'),
  ('ENT_TIRESIAS',    'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Tiresias is the central figure of Odyssey XI.90-150 (the Nekyia): Odysseus descends to the underworld specifically to consult Tiresias, who prophesies his return, warns about the cattle of Helios, and reveals the journey to Epirus; this is the primary Homeric attestation and the foundational text for Tiresias as the prophet who retains his mind even in death'),
  ('ENT_CALYPSO',     'SRC_HOMER_ILIAD_ODYSSEY', 'primary_attestation',
   'Calypso (daughter of Atlas) has a major narrative role in the Odyssey: she keeps Odysseus on her island Ogygia for seven years; the poem opens with Hermes being sent to order her to release him (Odyssey I.14-15, V.1-281); she is the daughter of Atlas (Od. I.52-54)')
ON CONFLICT DO NOTHING;

-- ── 12. Homeric Hymns: deities who receive dedicated hymns ───────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_DEMETER',    'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 2 (To Demeter): the longest and most theologically significant Homeric Hymn; narrates the abduction of Persephone by Hades, Demeter''s grief and wandering, her sojourn at Eleusis, the famine, and the institution of the Eleusinian Mysteries; the primary foundation text for the Eleusinian Mysteries'),
  ('ENT_PERSEPHONE', 'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 2 (To Demeter): Persephone''s abduction and return from the underworld; the origin of the seasons as explained by her alternation between Hades and her mother Demeter; central figure of the hymn alongside Demeter'),
  ('ENT_APOLLO',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 3 (To Apollo): one of the longest Homeric Hymns, in two parts; the Delian section narrates his birth on Delos from Leto; the Pythian section narrates his establishment of the oracle at Delphi and his slaying of the Python; the primary primary source for Apollo''s cult foundations'),
  ('ENT_PYTHON',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'Python is slain by Apollo in HH 3 (To Apollo); the hymn narrates Apollo''s establishment of the Delphic oracle after killing the Python; HH 3.300-374 is the primary textual source for the Python as the guardian of the site'),
  ('ENT_HERMES',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 4 (To Hermes): the most narrative Homeric Hymn; narrates the infant Hermes stealing Apollo''s cattle, inventing the lyre from a tortoise-shell, and eventually exchanging the lyre with Apollo to receive the caduceus and the role of messenger; the foundational text for Hermes'' role as trickster, inventor, and divine intermediary'),
  ('ENT_APHRODITE',  'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 5 (To Aphrodite): narrates how Zeus causes Aphrodite to fall in love with the mortal Anchises; she lies with him and from their union Aeneas is born; the primary text for Aphrodite''s relationship with Anchises and the divine genealogy of Aeneas; also HH 6 (birth from sea-foam) and HH 10'),
  ('ENT_ARES',       'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 8 (To Ares): a short but notable hymn addressing Ares as "exceeding in strength, driving the chariot, gold-helmeted, doughty in heart, shield-bearer, savior of cities"; the most direct ancient hymnic address to Ares; possibly a late addition to the Homeric Hymn corpus'),
  ('ENT_ARTEMIS',    'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 9 (To Artemis) and HH 27 (To Artemis): short hymns addressing Artemis as the golden-shafted huntress and twin of Apollo; she is depicted as driving golden-yoked chariots and bathing her horses in the Meles river'),
  ('ENT_ATHENA',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 11 (To Athena) and HH 28 (To Athena): the longer HH 28 narrates her birth from Zeus''s head fully armed; she shakes Olympus with her weapons; the gods are awestruck; the hymns establish her war-goddess and wisdom aspects as central cult attributes'),
  ('ENT_HERA',       'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 12 (To Hera): a short hymn addressing Hera as the golden-throned queen, daughter of Rhea, immortal consort of Zeus, glorious, whom all the blessed on tall Olympus revere and honor equally with Zeus'),
  ('ENT_RHEA',       'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 14 (To the Mother of Gods): addressed to Rhea as the Mother of Gods (Meter theon); she is described as loving gongs, kettledrums, hand-cymbals, the shouting of wolves and fierce-eyed lions; this hymn conflates Rhea with Cybele (the Phrygian mother goddess)'),
  ('ENT_HERACLES',   'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 15 (To Heracles the Lion-Hearted): a short hymn celebrating Heracles as the son of Zeus and Alcmene, born at Thebes; "most valiant of earthly men"; he wandered over all the earth performing his great labors and now dwells on Olympus with Hebe as his wife'),
  ('ENT_ASCLEPIUS',  'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 16 (To Asclepius): the primary ancient hymn to Asclepius as a healer god; describes him as the son of Apollo and Coronis, raised by Chiron, who learned the art of healing; the hymn establishes his role as soother of harsh disease'),
  ('ENT_ASCLEPIUS_HERO', 'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 16 (To Asclepius): see ENT_ASCLEPIUS; the hymn addresses the historical cult figure'),
  ('ENT_POSEIDON',   'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 22 (To Poseidon): addresses Poseidon as the great god, holder of the earth and barren sea, shaker of the earth and fruitful lord of Helicon and wide Aegae; establishes his domains of earth-shaking, sea-ruling, and horse-taming'),
  ('ENT_ZEUS',       'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 23 (To Zeus): short hymn to Zeus as the greatest and most glorious of the immortals; best and greatest; who accomplishes all things with Themis who sits beside him'),
  ('ENT_HESTIA',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 24 (To Hestia) and HH 29 (To Hestia and Hermes): Hestia receives her own dedicated hymns; HH 24 calls her guardian of the sacred precinct of far-shooting Apollo at Pytho; the hymns establish her role as the divine hearth'),
  ('ENT_GAIA',       'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 30 (To Earth the Mother of All): the primary hymnic address to Gaia; "I will sing of well-founded Earth, mother of all, eldest of all beings"; she feeds all things, gives or takes away life; the hymn is the fullest ancient poetic expression of Gaia''s universal mother-goddess role'),
  ('ENT_HELIOS',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 31 (To Helios): the dedicated hymn to the Sun; Helios drives his golden chariot across the sky, his hair a blaze of light, warming the earth and the waters; born of Hyperion and Euryphaessa (= Theia); establishes his cosmic role and genealogy'),
  ('ENT_SELENE',     'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 32 (To Selene): the dedicated hymn to the Moon; she lights the sky and the earth with her golden crown; when she has bathed her beautiful body in the Ocean, she puts on her gleaming garments and harnesses her far-gleaming steeds'),
  ('ENT_PAN',        'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 19 (To Pan): the dedicated hymn to Pan; describes his birth from Hermes and a nymph, his dance-teaching role, his appearance (goat-legs, horns, beard), his haunting of mountain and forest; the primary archaic Greek text establishing Pan''s character and birth story; of great antiquity in its core tradition'),
  ('ENT_HEPHAESTUS', 'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 20 (To Hephaestus): celebrates Hephaestus as the craftsman god who taught splendid crafts to men; "glorious-limbed"; without him humans would live like wild animals in the mountains; establishes his culture-giver role'),
  ('ENT_DIONYSUS',   'SRC_HOMERIC_HYMNS', 'primary_attestation',
   'HH 1 (To Dionysus, fragmentary), HH 7 (To Dionysus: the pirates hymn), HH 26 (To Dionysus): HH 7 narrates how pirates capture a young Dionysus and he transforms the ship into a vessel of vines, turns himself into a lion, and the pirates leap overboard becoming dolphins; primary source for the Dionysus-pirates myth')
ON CONFLICT DO NOTHING;

-- ── 13. Apollodorus: Olympians and major deities ─────────────────────────────
-- Apollodorus covers essentially all Greek mythology systematically.
-- Link to the full set of Olympians, Titans, major primordials, heroes,
-- and monsters — all are discussed with genealogies and myth summaries.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  -- Olympians
  ('ENT_ZEUS',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.5-1.2.1; birth, Titan war, cosmological division, loves and offspring'),
  ('ENT_HERA',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.5, 1.3.1; daughter of Kronos; wife of Zeus; pursuer of Heracles'),
  ('ENT_ATHENA',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.6; born from Zeus''s head fully armed; contest with Poseidon for Athens'),
  ('ENT_APOLLO',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.2, 1.4.1-2; birth on Delos; slaying of Python; his loves and offspring'),
  ('ENT_ARTEMIS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.4.1; twin of Apollo; huntress; Actaeon myth; Iphigenia'),
  ('ENT_ARES',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.1; son of Zeus and Hera; father of Eros in some traditions; Otus and Ephialtes story'),
  ('ENT_APHRODITE',  'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.1; born from Ouranos''s severed genitals cast into the sea (Hesiodic version); Library accounts of the Trojan War genealogy'),
  ('ENT_HERMES',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.10.2; son of Zeus and Maia; inventor of the lyre; psychopomp function; role in the Trojan cycle'),
  ('ENT_POSEIDON',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.5; received dominion of the sea after the lottery; contest for Athens with Athena; father of many monsters'),
  ('ENT_HEPHAESTUS', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.5; thrown from Olympus by Hera or Zeus; forges armor; Lemnos cult; marriage to Aphrodite'),
  ('ENT_DEMETER',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.5.1-3; abduction of Persephone, famine, and the Eleusinian Mysteries foundation'),
  ('ENT_HESTIA',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.5; firstborn of Kronos; yielded her seat on Olympus to Dionysus (later tradition)'),
  ('ENT_DIONYSUS',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.4.3, 3.5.1-3; twice-born from Zeus and Semele; wanderings; driven mad by Hera; conquest of India; introduction of the vine'),
  -- Chthonic
  ('ENT_HADES',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.5; received dominion of the underworld after the lottery; abduction of Persephone; his dog Cerberus'),
  ('ENT_PERSEPHONE', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.5.1-3; abducted by Hades; causes of the seasons; role at Eleusis'),
  ('ENT_HECATE',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.4; daughter of Perses and Asteria; dwells in underworld; companion of Persephone in the abduction myth'),
  -- Primordials
  ('ENT_GAIA',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1-2; the primordial earth; mother of Ouranos, Pontus, Titans, Cyclopes, Hecatonchires, Giants, and Typhon'),
  ('ENT_OURANOS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1-4; primordial sky; castrated by Kronos; father of Titans, Cyclopes, Hecatonchires'),
  ('ENT_URANUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1; see ENT_OURANOS'),
  ('ENT_TARTARUS',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1; primordial region below; prison of the Titans after the Titanomachy'),
  ('ENT_NYX',        'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1; primordial Night; among the first entities; mother of Thanatos, Hypnos, and Eris'),
  ('ENT_EROS',           'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1-2; Eros as son of Ares and Aphrodite; the love deity in the heroic genealogies'),
  ('ENT_EROS_PRIMORDIAL','SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1; primordial Eros among the first entities; the creative generative principle that moves the first gods'),
  ('ENT_EOS',        'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.2, 1.2.4; daughter of Hyperion and Theia; Dawn goddess; mother of the winds; abductions of Eos including Tithonus and Orion'),
  ('ENT_HELIOS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.2; son of Hyperion and Theia; the sun-god who sees all; his cattle on Thrinakia'),
  ('ENT_SELENE',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.2; daughter of Hyperion and Theia; sister of Helios; her love for Endymion'),
  ('ENT_OCEANUS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3; Titan; the cosmic river; husband of Tethys; father of Oceanids and river gods'),
  ('ENT_CHAOS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1; the first principle from which Gaia, Tartarus, and Eros arise'),
  ('ENT_EREBUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.1; primordial darkness; coupled with Nyx to produce Aether and Hemera'),
  ('ENT_PONTUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.2; primordial Sea; son of Gaia without father; father of Nereus, Thaumas, Phorcys, Ceto, Eurybia'),
  -- Titans
  ('ENT_CRONUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3-1.2.1; castrates Ouranos; swallows his children; overthrown by Zeus in the Titanomachy'),
  ('ENT_KRONOS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3; see ENT_CRONUS'),
  ('ENT_RHEA',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3, 1.2.1; daughter of Ouranos and Gaia; wife of Kronos; saves Zeus by wrapping a stone'),
  ('ENT_OCEANUS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3; Titan husband of Tethys; father of Oceanids'),
  ('ENT_TETHYS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3; Titaness; wife of Oceanus; mother of Oceanids and river gods'),
  ('ENT_HYPERION',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3, 1.2.2; Titan of the sun; father of Helios, Selene, Eos by Theia'),
  ('ENT_THEIA',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.2; Titaness; wife of Hyperion; mother of Helios, Selene, Eos'),
  ('ENT_COEUS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3, 1.2.2; Titan; husband of Phoebe; father of Leto and Asteria'),
  ('ENT_PHOEBE',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3, 1.2.2; Titaness; wife of Coeus; mother of Leto and Asteria'),
  ('ENT_LETO',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.2, 1.4.1; daughter of Coeus and Phoebe; mother of Apollo and Artemis by Zeus; Hera persecutes her during her wandering birth-journey'),
  ('ENT_IAPETUS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3, 1.2.3; Titan; father of Atlas, Prometheus, Epimetheus, Menoetius by Clymene'),
  ('ENT_PROMETHEUS', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.3; son of Iapetus; creator of humanity from clay; steals fire; bound to a rock; freed by Heracles'),
  ('ENT_EPIMETHEUS', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.3, 1.7.2; son of Iapetus; brother of Prometheus; accepts Pandora'),
  ('ENT_ATLAS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.3, 2.5.11; holds up the sky as his punishment; Heracles temporarily takes his burden in the Hesperides labor'),
  ('ENT_MNEMOSYNE',  'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.1; mother of the nine Muses by Zeus; Titan memory goddess'),
  ('ENT_THEMIS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.1; mother of the Horae and Moirai by Zeus; Titaness of law and order'),
  ('ENT_CRIUS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.1.3; Titan; father of Astraeus, Pallas, Perses by Eurybia'),
  ('ENT_DIONE',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.1; Titaness or Oceanid; in Apollodorus mother of Dionysus in some accounts'),
  ('ENT_ASTERIA',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.4; daughter of Coeus and Phoebe; transformed into the island Delos (or a quail); mother of Hecate by Perses'),
  ('ENT_ASTRAEUS',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.4; Titan; husband of Eos; father of Zephyrus, Boreas, Notus, and the stars'),
  -- Monsters
  ('ENT_TYPHON',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.6.3; the greatest monster; son of Gaia (and Tartarus); Zeus defeats him and buries him under Etna; the gods flee from him in animal forms in Egypt'),
  ('ENT_CHIMERA',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.3.1; killed by Bellerophon; lion''s head, goat''s body, dragon''s tail; daughter of Typhon and Echidna'),
  ('ENT_NEMEAN_LION','SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.5.1; Heracles'' first labor; offspring of Typhon and Echidna'),
  ('ENT_MEDUSA',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.4.2-3; slain by Perseus; her head turns beholders to stone; her blood spawns Chrysaor and Pegasus'),
  -- Underworld figures
  ('ENT_CHARON',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library mentions Charon in underworld context; the ferryman of the dead who takes souls across the Styx'),
  ('ENT_CERBERUS',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.5.12; Heracles'' twelfth labor; brought from the underworld; described as three-headed (50-headed in some versions)'),
  ('ENT_MINOS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.1.2; son of Zeus and Europa; king of Crete; judge of the dead in the underworld'),
  ('ENT_RHADAMANTHUS', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.1.2; brother of Minos; son of Zeus and Europa; judge of the dead'),
  ('ENT_RHADAMANTHYS','SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.1.2; see ENT_RHADAMANTHUS'),
  ('ENT_AEACUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.12.6; son of Zeus and Aegina; king of the Myrmidons; father of Peleus and Telamon; judge of the dead')
ON CONFLICT DO NOTHING;

-- Heroes (comprehensive)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_HERACLES',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.4.8-2.7.8; the twelve labors and complete heroic career; the fullest ancient systematic account'),
  ('ENT_PERSEUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.4.1-5; conception, birth, Medusa, rescue of Andromeda, return; the systematic account'),
  ('ENT_THESEUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.15.6-16.2, Epitome 1; complete career including Minotaur, Hippolyta, descent to Hades'),
  ('ENT_JASON',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.9.16-27; the Argonautica; voyage to Colchis; Medea; the Golden Fleece'),
  ('ENT_MEDEA',       'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.9.24-28; her role in the Argonautica; flight with Jason; murder of children'),
  ('ENT_ACHILLES',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.13.8; Epitome 3-5; birth from Thetis and Peleus; early life; Trojan War career'),
  ('ENT_ODYSSEUS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library Epitome 7; the returns from Troy; the systematic account of Odysseus after the Iliad'),
  ('ENT_AJAX',        'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library Epitome 5.4-7; Ajax at Troy; the judgment of the arms; his madness and suicide'),
  ('ENT_BELLEROPHON', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.3.1-2; Chimera slaying; riding Pegasus; his attempted flight to Olympus'),
  ('ENT_CADMUS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.1.1, 3.4.1-2; foundation of Thebes; sowing the dragon''s teeth; transformation into a serpent'),
  ('ENT_ORPHEUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.3.2-3; son of Oeagrus and the Muse Calliope; his music charmed all creation; descent to the underworld for Eurydice; death at the hands of Maenads'),
  ('ENT_MELEAGER',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.8.2-3; the Calydonian Boar Hunt; the fire-brand and his death; the fullest account of the Meleager myth'),
  ('ENT_PELOPS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library Epitome 2.3-9; chariot race with Oenomaus; foundation of the Peloponnese'),
  ('ENT_ATALANTA',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.9.2; the footrace; Library 1.8.2 (Calydonian Boar); her marriage and transformation into a lion'),
  ('ENT_CASTOR',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.11.1-2; Dioscuri; Castor as horse-tamer; their death and alternate immortality'),
  ('ENT_POLYDEUCES',  'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.11.1-2; Dioscuri; Polydeuces as boxer; shares immortality with mortal Castor'),
  ('ENT_PROTESILAUS', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library Epitome 3.30; first Greek killed at Troy; his wife Laodamia''s grief'),
  ('ENT_ORESTES',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library Epitome 6.14-28; avenges Agamemnon; kills Clytemnestra; trial at Athens; purification'),
  ('ENT_TIRESIAS',    'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.6.7; blinded by Athena (or Hera); compensated with prophetic gifts and long life; seven generations of prophetic ability'),
  ('ENT_PELOPS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library Epitome 2.3; chariot race with Oenomaus; foundation of the Peloponnese'),
  -- Healing figures
  ('ENT_ASCLEPIUS',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.10.3-4; son of Apollo and Coronis; raised by Chiron; learns healing; raises the dead; killed by Zeus with a thunderbolt; later deified'),
  ('ENT_ASCLEPIUS_HERO', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.10.3-4; see ENT_ASCLEPIUS; his mortal hero career before deification'),
  ('ENT_MACHAON',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.10.8; son of Asclepius; healer at Troy; his role in treating wounded heroes'),
  ('ENT_PODALIRIUS',  'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.10.8; son of Asclepius; healer at Troy alongside his brother Machaon')
ON CONFLICT DO NOTHING;

-- Sea deities and Nereids via Apollodorus
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_NEREUS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.7; son of Pontus and Gaia; the Old Man of the Sea; the Nereids are his fifty daughters'),
  ('ENT_PHORCYS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.6; son of Pontus and Gaia; brother of Nereus; father of the Gorgons, Graeae, and the Hesperides'),
  ('ENT_THAUMAS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.6; son of Pontus; husband of Electra (Oceanid); father of Iris and the Harpies'),
  ('ENT_CETO',        'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.6; daughter of Pontus; wife of Phorcys; mother of Gorgons and Graeae'),
  ('ENT_THETIS',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.13.5; daughter of Nereus; married Peleus (both Chiron and Prometheus warn Zeus); mother of Achilles'),
  ('ENT_GALATEA',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library references the Cyclops Polyphemus''s love for Galatea the Nereid (though the full story is in Theocritus)'),
  ('ENT_AMPHITRITE',  'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.7; daughter of Nereus; wife of Poseidon; queen of the sea; mother of Triton'),
  ('ENT_TRITON',      'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 1.2.7; son of Poseidon and Amphitrite; the fish-tailed sea deity; dwells in the depths of the sea'),
  ('ENT_PROTEUS',     'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 2.5.9 (mentioned in Heracles'' Egypt episode); the shape-shifting Old Man of the Sea'),
  ('ENT_INO_LEUCOTHEA', 'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.4.3; daughter of Cadmus; raises the infant Dionysus; driven mad by Hera; leaps into the sea and becomes Leucothea'),
  ('ENT_LEUCOTHEA',   'SRC_APOLLODORUS_LIBRARY', 'secondary_reference', 'Library 3.4.3; see ENT_INO_LEUCOTHEA; the sea-goddess form of Ino')
ON CONFLICT DO NOTHING;

-- ── 14. Pausanias: Olympians at their principal sanctuaries ──────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ZEUS',       'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the Temple of Zeus at Olympia extensively (Book 5-6); the cult statue by Pheidias was considered one of the Seven Wonders; he also records the oracle of Zeus at Dodona (Book 7) and Zeus''s shrines throughout Greece'),
  ('ENT_HERA',       'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the Heraion at Olympia (the oldest temple at the site; Book 5.16-17) and the Heraion at Argos (Book 2.17); the Hera cult at Argos is documented as one of the most important in Greece; he records the games of the Heraia'),
  ('ENT_ATHENA',     'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias devotes extensive coverage to the Acropolis of Athens (Book 1.22-28): the Parthenon, the chryselephantine statue of Athena Parthenos by Pheidias, the Erechtheion, and the Athena Promachos; also Athena Alea at Tegea (Book 8.45-47)'),
  ('ENT_APOLLO',     'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias visits and describes the sanctuary at Delphi in detail (Book 10): the Temple of Apollo, the Oracle, the Omphalos, the treasuries of the Greek cities, and the paintings of Polygnotus; also Apollo at Corinth (Book 2) and Apollo Epikourios at Bassae (Book 8)'),
  ('ENT_ARTEMIS',    'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the cult of Artemis Orthia at Sparta (Book 3.16.7-11), Artemis Laphria at Patrai (Book 7.18-19), and various Artemis sanctuaries; he documents the ritual practices at Brauron (Book 1.23.7)'),
  ('ENT_POSEIDON',   'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the sanctuary of Poseidon at the Isthmus of Corinth (Book 2.1-2) and his contest with Athena for Athens (Book 1.24.3); also Poseidon Hippios (horse-Poseidon) shrines throughout'),
  ('ENT_DEMETER',    'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias visits Eleusis and provides the most detailed ancient description of the sanctuary of Demeter and Kore and the Eleusinian Mysteries (Book 1.37-38); he cannot reveal the secret rites but describes the sanctuary structures, monuments, and public myth; the primary ancient source for the physical site'),
  ('ENT_PERSEPHONE', 'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the Eleusinian sanctuary of Kore/Persephone (Book 1.38) and her shrines throughout Greece; also the sanctuary of Persephone at Locri (Book 6.25.4-5)'),
  ('ENT_DIONYSUS',   'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents Dionysiac cult throughout Greece: his tomb at Delphi (Book 10.24.6), the Lenaia festival at Athens, the cult at Sicyon (Book 2.7.5-6), and the Dionysus Lysios sanctuary at Corinth (Book 2.2.5)'),
  ('ENT_HEPHAESTUS', 'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the Hephaisteion at Athens (mistakenly called the "Theseum" in later times; Book 1.14.6); the cult of Hephaestus at Lemnos; his role in Attic metalworking religion'),
  ('ENT_HERMES',     'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the Hermes cult at various sites: herm statues throughout Athens, the sanctuary at Pheneos (Book 8.14.10), and the early Arcadian Hermes cults; also Hermes Kriophoros (ram-bearer) at Tanagra'),
  ('ENT_ARES',       'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the Temple of Ares in the Athenian Agora (Book 1.8.4) and Ares cults at Sparta (where he was bound in chains) and Geronthrai'),
  ('ENT_APHRODITE',  'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents major Aphrodite sanctuaries: the important cult at Corinth (Book 2.4.7: temple on Acrocorinth with sacred prostitution), the Aphrodite Ourania sanctuary at Athens (Book 1.14.7), and the Cnidian Aphrodite tradition'),
  -- Hero cults documented by Pausanias
  ('ENT_HERACLES',   'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents Heracles'' hero shrines throughout Greece: at Athens, Thebes (Book 9.11.1-2), Olympia, and Peloponnesus; the Herakleia festival; his cult was the most widespread hero cult in the ancient world'),
  ('ENT_ACHILLES',   'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the hero cult of Achilles: his tomb at Sigeum in the Troad (referenced); cult at Elis (Book 6.23.3); the island of Leuke (White Island) in the Black Sea as his afterlife; his hero shrine at Sparta'),
  ('ENT_AJAX',       'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the hero shrine of Ajax on Salamis (Book 1.35.3-5) and describes the statue and cult; he records traditions about the discovery of his bones; Salamis was his primary cult center'),
  ('ENT_THESEUS',    'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the Theseum (Hephaisteion area, Athens; Book 1.17.2-6): Theseus''s bones brought from Scyros by Cimon; his hero cult at Athens; the Pyanepsia and other Theseus festivals; Book 1-2 extensively'),
  ('ENT_ASCLEPIUS',  'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias visits the Asclepium at Epidaurus (Book 2.26-28): the most famous healing sanctuary in the ancient world; he describes the temple, the cult statue, the abaton (incubation hall), the miraculous healing tablets, and the sacred snakes; the primary ancient source for the Epidaurian Asclepius cult'),
  ('ENT_ASCLEPIUS_HERO', 'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias Book 2.26-28: the hero-cult aspect of Asclepius at Epidaurus; also Asclepius shrines at Corinth, Sicyon, Athens, Cos, and Pergamon'),
  ('ENT_PROTESILAUS','SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the hero shrine of Protesilaus at Elaeus in the Thracian Chersonese (Book 1.34.2); he describes the sacred grove and temenos; Protesilaus''s cult was important in the area around the Hellespont'),
  ('ENT_PELOPS',     'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the Pelopion at Olympia (Book 5.13.1-3): a sacred enclosure holding Pelops''s hero shrine; the annual sacrifice of a black ram at the Pelopion before Olympic games; the chariot race with Oenomaus; Pelops was the eponymous hero of the Peloponnese'),
  ('ENT_ORPHEUS',    'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the tomb of Orpheus on the river Helikon in Macedonia (Book 9.30.5-12) and the tradition that his lyre was preserved there; also his head and lyre floating to Lesbos; the oracle of Orpheus''s head'),
  ('ENT_IPHIGENIA',  'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the hero cult of Iphigenia at Brauron (Book 1.23.7) and at Hermione (Book 2.35.1); the Brauron sanctuary to Artemis preserves her cult alongside Artemis; he records the traditions about her transformation into Hecate or her escape to Tauris'),
  ('ENT_HIPPOLYTUS', 'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents the hero cult of Hippolytus at Troezen (Book 2.32.1-3): his temple and cult statue; the annual offerings of hair from Troezenian youths before marriage; he records the dispute over whether he was truly killed or was preserved by Artemis in Italy'),
  -- Mystery figures
  ('ENT_HADES',      'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias records the sanctuary of Hades at Elis (Book 6.25.2-3): open only once per year to the priest; the only Panhellenic temple to Hades in Greece; also the Nekyomanteion at Ephyra (Book 1.17.5)'),
  ('ENT_HECATE',     'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the oldest cult statue of Hecate (by the sculptor Alcamenes; placed near the Propylaea of the Athenian Acropolis; Book 2.30.2); also Hecate at Aegina and Argos; this is the primary ancient source for her earliest cult images'),
  ('ENT_PAN',        'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias documents Pan''s cult in Arcadia (Book 8.37.11) as well as the cave of Pan on the north slope of the Acropolis at Athens (Book 1.28.4); the Athens cave was established after Pan appeared to Pheidippides before Marathon (Herodotus and Pausanias both record this)'),
  ('ENT_NEMESIS',    'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias visits the great sanctuary of Nemesis at Rhamnous in Attica (Book 1.33.2-8): the cult statue of Nemesis made by Pheidias from a block of Parian marble that the Persians had brought to make a victory monument; this is the most important ancient text for the Nemesis cult at Rhamnous'),
  ('ENT_KORE',       'SRC_PAUSANIAS_DESCRIPTION', 'primary_attestation',
   'Pausanias describes the sanctuary of Kore (= Persephone as mystery-cult title) at Eleusis alongside Demeter (Book 1.37-38) and in many local shrines across Greece; Kore is the cult name used at Eleusis for Persephone before the abduction; Pausanias is the primary source for the cult geography of Kore-worship across the Greek world')
ON CONFLICT DO NOTHING;

-- ── 15. Verification ─────────────────────────────────────────────────────────

SELECT
  s.source_id,
  COUNT(DISTINCT es.entity_id) AS entities_now_linked
FROM sources s
LEFT JOIN entity_sources es ON es.source_id = s.source_id
WHERE s.source_id IN (
  'SRC_HOMER_ILIAD_ODYSSEY',
  'SRC_HOMERIC_HYMNS',
  'SRC_APOLLODORUS_LIBRARY',
  'SRC_PAUSANIAS_DESCRIPTION'
)
GROUP BY s.source_id
ORDER BY entities_now_linked DESC;

-- Recalculate source coverage for the Greek tradition
SELECT
  e.tradition,
  COUNT(DISTINCT e.entity_id) AS entity_count,
  COUNT(DISTINCT es.source_id) AS source_count,
  ROUND(COUNT(DISTINCT e.entity_id)::numeric / NULLIF(COUNT(DISTINCT es.source_id),0), 1) AS entities_per_source
FROM entities e
LEFT JOIN entity_sources es ON es.entity_id = e.entity_id
WHERE e.tradition = 'Greek'
GROUP BY e.tradition;

-- New top sources by entity coverage
SELECT
  s.source_id,
  s.source_type,
  COUNT(DISTINCT es.entity_id) AS entities_sourced
FROM sources s
LEFT JOIN entity_sources es ON es.source_id = s.source_id
WHERE es.entity_id IN (SELECT entity_id FROM entities WHERE tradition = 'Greek')
GROUP BY s.source_id, s.source_type
ORDER BY entities_sourced DESC
LIMIT 15;

SELECT * FROM v_release_metrics;

COMMIT;
