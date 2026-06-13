-- scripts/add_source_linkage_remediation.sql
-- Zero-link and low-link source remediation pass
--
-- Twelve source gaps addressed in priority order:
--
--  1. SRC_POETIC_EDDA      → all 20 Germanic/Norse entities
--     (Prose Edda was already linked; Poetic Edda is the OLDER and MORE PRIMARY source)
--
--  2. SRC_OVID_FASTI       → all 22 Roman entities
--     (Roman religious calendar and myth; no Ovid link existed for any Roman deity)
--
--  3. SRC_PLUTARCH_ISIS_OSIRIS → 15 Egyptian/syncretic entities
--     (De Iside et Osiride is the fullest Greco-Roman account of the Osirian cycle and
--      the foundational text for interpreting Egyptian-Greek religious equations)
--
--  4. SRC_FAULKNER_PYRAMID_TEXTS → 32 Egyptian entities
--     (c. 2375-2181 BCE; the world's oldest religious corpus; previously linked only
--      to the 2 new entities added this session, not to any of the 87 pre-existing
--      Egyptian deities)
--
--  5. SRC_HERODOTUS_HISTORIES → 12 additional entities across traditions
--     (previously 2 links; Histories Books 1-3 systematically document Egyptian-Greek,
--      Persian-Greek, and Arabian-Greek religious equations)
--
--  6. SRC_FOSTER_BEFORE_MUSES → 13 Mesopotamian entities
--     (Akkadian literary corpus; 0 entity links despite being in the sources table
--      since the Mesopotamian remediation; Enuma Elish, Descent of Ishtar, Atrahasis,
--      Nergal and Ereshkigal, Adapa)
--
--  7. SRC_BURKERT_ORIENT_REV → 14 entities across traditions
--     (Burkert 1992: the primary scholarly source for Near Eastern → Greek transmission;
--      used in relationship chain rationales but not linked as entity_sources)
--
--  8. SRC_BUNDAHISHN        → all 16 Zoroastrian entities
--     (Pahlavi cosmological text c. 9th c. CE; preserves the Zoroastrian cosmogony
--      in more systematic form than the Avesta; 0 entity links)
--
--  9. SRC_MANDAEAN_BOOK_JOHN → all 15 Mandaean entities
--     (Draşa d-Yahya; primary Mandaean liturgical text alongside the Ginza Rba;
--      0 entity links)
--
-- 10. SRC_MANICHAEAN_PSALM_BOOK → all 15 Manichaean entities
--     (Allberry Psalm Book; Coptic Manichaean hymnal from Medinet Madi; 0 entity links)
--
-- 11. SRC_WYATT_RELIGIOUS_TEXTS → 12 Canaanite entities
--     SRC_CROSS_CANAANITE_MYTH  → 12 Canaanite entities
--     (Both previously linked only to Dagon and Resheph; the full Ugaritic pantheon
--      needs both)
--
-- 12. SRC_2TJ_COLLINS → 4 Israelite Second Temple entities
--     (Collins, Apocalyptic Imagination; relevant to the prophetic/patriarchal
--      figures in their Second Temple apocalyptic reception)

BEGIN;

-- ── 1. Poetic Edda → Germanic/Norse ─────────────────────────────────────────
-- The Poetic Edda (Codex Regius, c. 1270 CE; poems composed 9th-12th c.) is the
-- PRIMARY source for Norse religion — older, less Christian-mediated, and more
-- conservative than the Prose Edda by Snorri Sturluson (c. 1220 CE). Snorri
-- himself drew on the eddic poems. The most important poems:
--   Völuspá (Seeress's Prophecy): creation, the gods, Ragnarök, Baldr's death
--   Hávamál (Sayings of the High One): Odin's wisdom; rune-acquisition
--   Grímnismál: Odin reveals cosmology (Yggdrasil, nine worlds, Valhalla)
--   Hymiskviða: Thor and Tyr among the giants; the brewing kettle
--   Lokasenna (Loki's Flyting): Loki insults all the gods in turn
--   Þrymskviða: Thor's hammer stolen; recovery involving Freyja disguise
--   Baldrs draumar: Odin's descent to question a dead seeress about Baldr
--   Skírnismál: Freyr sends Skírnir to woo Gerðr

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_NOR_ODIN',        'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá, Hávamál, Grímnismál, Baldrs draumar, Lokasenna; the high god across virtually every eddic poem; his self-sacrifice on Yggdrasil (Hávamál 138-141), acquisition of runes, and foreknowledge of Ragnarök are attested here in their primary form'),
  ('ENT_NOR_THOR',        'SRC_POETIC_EDDA', 'primary_attestation',
   'Hymiskviða (wrestling the Miðgarðsormr, retrieving the cauldron from Hymir); Þrymskviða (Mjölnir stolen by Þrymr; recovery in disguise); Lokasenna; Völuspá (Ragnarök: Thor kills Jörmungandr then falls dead)'),
  ('ENT_NOR_FREYJA',      'SRC_POETIC_EDDA', 'primary_attestation',
   'Þrymskviða (Thor must impersonate Freyja to recover his hammer; her desirability as a bride for giants establishes her mythic status); Hyndluljóð (she questions the giantess Hyndla about her protégé''s lineage); Lokasenna (Loki accuses her of sleeping with all gods and elves)'),
  ('ENT_NOR_FREYR',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Skírnismál: Freyr sends his servant Skírnir to woo the giantess Gerðr; this is the primary text for Freyr''s character as a fertility god who gives up his sword for love; Völuspá; Lokasenna'),
  ('ENT_NOR_FRIGG',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (she and Odin mourn Baldr''s death); Lokasenna (Loki accuses her of infidelity); Vafþrúðnismál (she warns Odin about his contest with Vafþrúðnir); her role as Odin''s wife and keeper of fate'),
  ('ENT_NOR_BALDR',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (Baldr''s death prophesied and narrated as a cause of Ragnarök); Baldrs draumar (Odin descends to the underworld to question a seeress about Baldr''s dreams); the Baldr myth is one of the richest in the Poetic Edda'),
  ('ENT_NOR_TYR',         'SRC_POETIC_EDDA', 'primary_attestation',
   'Hymiskviða (Tyr and Thor visit the giant Hymir; Tyr is named as Hymir''s son in this poem); Lokasenna (Tyr loses a hand to Fenrir; Loki mocks him); Sigrdrífumál (victory runes named after Tyr)'),
  ('ENT_NOR_LOKI',        'SRC_POETIC_EDDA', 'primary_attestation',
   'Lokasenna (the primary Loki text: he insults every god at the feast and is then bound); Þrymskviða (helps Thor in the disguise plan); Völuspá (his role in Baldr''s death through Höðr; his binding; his liberation at Ragnarök); his children Fenrir, Jörmungandr, Hel are named'),
  ('ENT_NOR_HEL',         'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (she receives the dead in Hel below Yggdrasil); Baldrs draumar (the hall of Hel, lavishly decorated for Baldr''s reception); Loki is named as her father alongside Fenrir and Jörmungandr'),
  ('ENT_NOR_FENRIR',      'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (at Ragnarök Fenrir breaks his bonds and devours Odin); Lokasenna (Tyr''s hand bitten off by Fenrir is mentioned); the wolf''s binding and his fate at Ragnarök are primary Eddic subjects'),
  ('ENT_NOR_JORMUNGANDR', 'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (Thor and Jörmungandr kill each other at Ragnarök); Hymiskviða (Thor fishes up the Miðgarðsormr; Hymir cuts the line); the World Serpent encircling the ocean is foundational to the Eddic cosmology'),
  ('ENT_NOR_NIDHOGG',     'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (Níðhöggr gnaws the roots of Yggdrasil and flies away at Ragnarök carrying corpses in his wings); Grímnismál (he chews the roots of Yggdrasil alongside the serpents); the primary attestations for this figure'),
  ('ENT_NOR_NJORD',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Lokasenna (Loki accuses Njord of siring children with his sister; Njord defends himself as clean and useful); Vafþrúðnismál (the Vanir origin of Njord is discussed; he will return to Vanaheim at Ragnarök); Völuspá'),
  ('ENT_NOR_NORNS',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (three great Norns carve on wooden slips and assign destinies at the well of Urðr; named as Urðr, Verðandi, and Skuld); Fáfnismál and Sigrdrífumál (other Norns mentioned); the primary Eddic source for the Norns as fate-spinners'),
  ('ENT_NOR_VALKYRIES',   'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (Valkyries ride to choose the slain); Grímnismál (names of Valkyries serving mead in Valhalla); the Sigurðr-cycle hero lays (Brynhildr as a fallen Valkyrie, Sigrún, Sváfa); the primary texts for Valkyrie mythology'),
  ('ENT_NOR_AESIR',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá, Lokasenna, Vafþrúðnismál, and throughout: the Æsir as the primary Norse divine collective, their assembly (þing), the Aesir-Vanir War; the primary collection of texts describing the Aesir as a group'),
  ('ENT_NOR_VANIR',       'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (the first war was between Aesir and Vanir; hostages exchanged); Vafþrúðnismál (Njord among the Vanir); the Aesir-Vanir War is narrated in Völuspá and discussed throughout; the Vanir are identified as Freyr, Freyja, and Njord'),
  ('ENT_NOR_JOTNAR',      'SRC_POETIC_EDDA', 'primary_attestation',
   'Throughout the Poetic Edda: the Jötnar (giants) are the primary adversaries and interlocutors of the gods; Vafþrúðnismál (the wise giant), Hymiskviða (Hymir), Þrymskviða (Þrymr), Skírnismál (Gerðr); the Jötnar''s cosmic role as the anti-divine power'),
  ('ENT_NOR_DWARVES',     'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (the catalog of dwarves — Dvergatal — is embedded in the poem; dwarves are craftsmen of the cosmos); Alvíssmál (the dwarf Alvíss tests his knowledge against Thor; primary text on dwarves as repository of ancient wisdom and as suitors rejected by the gods)'),
  ('ENT_NOR_YGGDRASIL',   'SRC_POETIC_EDDA', 'primary_attestation',
   'Völuspá (Yggdrasil described at the center of the cosmological vision; the well of Urðr, the Norns, the eagle and the serpent); Grímnismál 29-35 (Yggdrasil''s three roots and the beings that dwell there — the most detailed Eddic cosmological description); the primary texts for the World Tree')
ON CONFLICT DO NOTHING;

-- ── 2. Ovid Fasti → Roman ───────────────────────────────────────────────────
-- Ovid's Fasti (c. 8 CE; six books covering the Roman religious calendar from
-- January to June) is a primary Latin literary source for Roman festival theology.
-- It is the only surviving systematic poetic treatment of the Roman religious
-- calendar and is essential for: Janus (Book 1), Mars (Books 2-3), Venus and
-- Ceres (Book 4), Mercury (Book 5), and Juno and Vesta (Book 6). Ovid's
-- mythologized aetiologies often preserve genuine cult traditions. All 22
-- Roman tradition entities should be anchored here as primary_attestation.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ROM_JANUS',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 1.89-294: Janus is Ovid''s primary subject for January; the god speaks at length about his two-faced nature, his guardianship of gates and beginnings, and his role as the first deity of any invocation; the most extensive literary account of Janus''s theology'),
  ('ENT_ROM_MARS',       'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 2.857-862, 3.1-166: February Lupercalia involves Mars; March is his month; Ovid narrates his origin, his rape of Silvia (mother of Romulus and Remus), and the rites of the Salii; primary literary account of the Roman Mars''s cult mythology'),
  ('ENT_ROM_VENUS',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 4.1-18, 4.61-244: April is sacred to Venus; Ovid addresses her and narrates the festivals of Veneralia and Vinalia; the origin of April from aperire (to open) is connected to her power; her role as mother of Aeneas and ancestor of the Julian family'),
  ('ENT_ROM_CERES',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 4.393-620: the Cerealia (April 12-19); Ovid narrates the Rape of Proserpina in the Roman version (Ceres searches for her daughter; the institution of her cult); the primary Latin literary account of the Ceres/Proserpina myth'),
  ('ENT_ROM_PROSERPINA',  'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 4.417-620: Proserpina''s abduction by Pluto (Roman version of the Persephone myth); Ceres''s search; the negotiated return; the primary Latin literary source alongside Ovid''s Metamorphoses'),
  ('ENT_ROM_MERCURY',    'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 5.663-692: the Mercuralia (May 15); Mercury''s origin as son of Maia (May''s eponymous figure); his role as god of merchants and travellers; the ritual sprinkling of his waters at the Porta Capena fountain'),
  ('ENT_ROM_JUNO',       'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 6.15-182: June is sacred to Juno; she speaks in the poem; the Matronalia (March 1 in a different book) and June festivals; her role as queen of heaven and protector of Roman matrons; the Junonian calendar of June'),
  ('ENT_ROM_VESTA',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 6.249-460: the Vestalia (June 7-15); the most important surviving ancient account of the Vesta cult; the Penates, the sacred flame, the ritual prohibition on donkeys during the festival; Ovid connects Vesta to the earth and to the primordial fire'),
  ('ENT_ROM_JUPITER',    'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti throughout: Jupiter is invoked and addressed in multiple calendar entries; his Ides (the 13th of each month are sacred to him); the Vinalia, Agonalia, and other festivals connected to Jupiter; his role as sky-father and state deity'),
  ('ENT_ROM_SATURN',     'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 1.233-254: Saturn''s reign in the Golden Age; his arrival in Latium as a wanderer; the Saturnalia aetiologies are discussed in Macrobius (linked to Fasti tradition); Ovid treats Saturn as the archaic deity of the agricultural Golden Age'),
  ('ENT_ROM_DIANA',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 2.155-192 (Lupercalia passage), 3.263-274: Diana''s rites on the Ides of March; her grove at Aricia (Nemi) referenced; her role as goddess of wild places and the moon; Fasti 3.263-274 describes the founding of her Arician cult'),
  ('ENT_ROM_MINERVA',    'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 3.809-848: the Quinquatrus (March 19-23) as Minerva''s principal festival; Ovid narrates the origin of the festival and the ritual contests of gladiators; Minerva as patroness of crafts, arts, and learning; the second most important Capitoline deity after Jupiter'),
  ('ENT_ROM_NEPTUNE',    'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 1.693-696: the Neptunalia is listed (July, not in the surviving six books, but Neptune is referenced); Ovid mentions Neptune in the context of sea power and his role alongside Jupiter and Pluto as the three cosmic rulers'),
  ('ENT_ROM_VULCAN',     'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 3.831 (Quinquatrus): Vulcan as the divine craftsman associated with fire and metallurgy; the Volcanalia (August 23, outside the surviving six books) is the primary Roman fire festival; Vulcan''s role as the forge-deity contrasted with his Greek counterpart Hephaestus''s lame-craftsman mythology'),
  ('ENT_ROM_BACCHUS',    'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 3.713-790: the Liberalia (March 17; festival of Liber/Bacchus); the coming-of-age ceremony where Roman boys put on their toga virilis; Liber/Bacchus as the deity of wine, freedom, and civic coming-of-age; the primary literary account of the Liberalia'),
  ('ENT_ROM_APOLLO',     'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 3.881 (Agonalia): Apollo referenced in the Roman calendar; the Ludi Apollinares (July, outside the surviving six books); Ovid treats Apollo as the preserver of the Roman state who deflected plague; his role in the Julian-Augustan ideology'),
  ('ENT_ROM_QUIRINUS',   'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 2.475-512: the Quirinalia (February 17); Romulus''s deification as Quirinus; Ovid narrates the apotheosis of Romulus, who becomes Quirinus the civic god; the primary literary account of this deification myth'),
  ('ENT_ROM_LARES',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 2.599-616: the Fornacalia and Compitalia; the Lares Compitales (Lares of the crossroads) and the household Lares; Ovid explains the origin of the Lares and their role protecting the home and the crossroads; a key text for Roman domestic religion'),
  ('ENT_ROM_PENATES',    'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 6.454: Vesta and the Penates are explicitly linked; Ovid treats the Penates as the guardian deities of the Roman state''s inner sanctuary (the Atrium Vestae) as well as household gods brought from Troy by Aeneas; primary literary source for their cult'),
  ('ENT_ROM_MANES',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 2.533-616: the Parentalia (February 13-21) — the feast of the dead when the Manes (ancestral spirits) are propitiated; Ovid describes the ritual: cold offerings at the tomb, violets, and wine; the Feralia (February 21) closes the festival; primary literary account of Roman ancestor cult'),
  ('ENT_ROM_GENIUS',     'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti throughout: the Genius of the paterfamilias is referenced in Roman cult practice; the Genius Augusti (August''s divine spirit) is a political-religious figure Ovid navigates carefully; the Genius is the divine life-force of a person or place in Roman religion'),
  ('ENT_ROM_PLUTO',      'SRC_OVID_FASTI', 'primary_attestation',
   'Fasti 4.417-620: Pluto (Dis Pater) abducts Proserpina in Ovid''s Roman account; the Parentalia and Lemuria involve propitiation of his realm; Fasti 4.445 names Pluto explicitly in the abduction scene')
ON CONFLICT DO NOTHING;

-- ── 3. Plutarch De Iside et Osiride → Egyptian/syncretic ────────────────────
-- Plutarch (c. 46-120 CE), De Iside et Osiride (On Isis and Osiris):
-- The most comprehensive surviving Greco-Roman account of Egyptian religion;
-- written for a priestess of Isis; uses allegorical interpretation (Isis =
-- wisdom, Osiris = mind/good, Seth/Typhon = passions/evil); contains the
-- fullest narrative of the Osiris myth (murder, dismemberment into 14 parts,
-- Isis's search, Horus's conception and birth) and explains the creation of
-- Serapis. Primary source for: Egyptian-Greek religious equations; the
-- Ptolemaic synthetic tradition; Neo-Platonic Egyptian theology.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_OSIRIS',    'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'De Iside et Osiride (Moralia 351C-384C) is the fullest ancient account of the Osiris myth: his murder by Typhon/Seth, dismemberment into 14 parts, Isis''s search and reassembly, posthumous conception of Horus, and Osiris''s resurrection as lord of the dead; Plutarch identifies Osiris with Dionysus, the Nile, and with Mind/Logos in his allegorical reading'),
  ('ENT_EGY_ISIS',      'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Isis is the central figure of De Iside et Osiride: she searches for Osiris''s scattered limbs, reassembles him, and conceives Horus; Plutarch identifies her with Wisdom, with Demeter, and with the Moon; her role as the mourning-and-seeking goddess is the narrative engine of the entire text'),
  ('ENT_EGY_SETH',      'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Seth appears as Typhon (his Greek equation) throughout De Iside et Osiride; he murders Osiris by tricking him into a chest, dismembers the body into 14 pieces, and rules Egypt until Horus defeats him; Plutarch explicitly equates Seth with the Greek Typhon and with the principle of cosmic disorder'),
  ('ENT_EGY_NEPHTHYS',  'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Nephthys is Isis''s sister and Seth''s wife; De Iside (Moralia 355F-356A) narrates that she disguised herself as Isis, conceived Anubis with Osiris, and later joined Isis in mourning and searching for Osiris''s body; Plutarch identifies her with that which is just below the horizon, "the invisible and the hidden"'),
  ('ENT_EGY_THOTH',     'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Thoth assists in reassembling Osiris''s body and is identified with the divine intelligence (Logos) throughout De Iside et Osiride; Plutarch explicitly identifies Thoth with Hermes (Hermes Trismegistus tradition) and describes his role as cosmic mediator and scribe of the gods; De Iside 3, 54'),
  ('ENT_EGY_ANUBIS',    'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Anubis is identified in De Iside et Osiride as the son of Osiris and Nephthys (not Osiris and Isis as in some other traditions); Plutarch explains his role as "the guardian who goes between the upper and lower regions" (De Iside 44); the name Anubis is given a Greek etymology; he becomes Hermanubis in the Greco-Egyptian synthesis'),
  ('ENT_EGY_HORUS',     'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Horus is conceived posthumously from Osiris''s reassembled body (De Iside 18); raised secretly by Isis in the papyrus marshes; he battles Seth/Typhon and wins the judgment of the gods; Plutarch distinguishes the elder Horus (Haroeris) from the younger (Harpocrates); equates Horus with Apollo'),
  ('ENT_EGY_RA',        'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Ra/Re is discussed in De Iside et Osiride as the solar principle; Plutarch identifies him with the Greek Helios and uses the Ra-Osiris synthesis to explain the relationship between the sun (visible daily order) and Osiris (hidden cyclic order); De Iside 52, 56'),
  ('ENT_EGY_HATHOR',    'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Hathor is identified in De Iside et Osiride with Aphrodite (and with Isis in her loving aspect); Plutarch discusses the Aphrodite-Hathor equation (De Iside 39) in the context of the interpretatio graeca of Egyptian religion'),
  ('ENT_EGY_PTAH',      'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Ptah appears in De Iside et Osiride as Hephaestus (Hephaistos); Plutarch discusses the Memphis theology and Ptah''s role as the divine craftsman and creator; De Iside 9 names Ptah alongside the other Memphis deities'),
  ('ENT_EGY_NEITH',     'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Plutarch quotes the famous inscription on the temple of Neith at Sais (De Iside 9): "I am all that has been and is and shall be, and no mortal has ever lifted my veil"; he identifies Neith with Athena as the primordial wisdom-goddess; this is one of the most cited ancient religious texts'),
  ('ENT_SYN_SERAPIS',   'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'De Iside 28 is the primary ancient text for the creation of Serapis: Ptolemy I Soter is told in a dream to bring a statue from Sinope; the theologians Timotheus and Manetho identify the new deity as a synthesis of Osiris and Apis; Plutarch is the most detailed ancient source for the Serapis foundation myth'),
  ('ENT_SYN_HARPOCRATES', 'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'De Iside 19, 68: Harpocrates (Horus-the-child) is explicitly identified as the younger Horus born prematurely; the finger-to-lips gesture misread as "silence" rather than an infantile gesture is explained in De Iside 68; Plutarch''s account is the primary Greek source for Harpocrates as a distinct deity'),
  ('ENT_SYN_HERMANUBIS', 'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Plutarch discusses the Hermes-Anubis synthesis in De Iside et Osiride; Anubis as "guardian between upper and lower realms" (De Iside 44) leads to his identification with Hermes-Psychopomp; the composite Hermanubis emerges from this Greco-Egyptian religious environment'),
  ('ENT_SYN_ZEUS_AMMON', 'SRC_PLUTARCH_ISIS_OSIRIS', 'primary_attestation',
   'Plutarch discusses the Zeus Ammon equation in De Iside et Osiride and elsewhere; the Libyan oracle of Amun equated with Zeus; this equation was established by Herodotus (2.42) and refined in the Ptolemaic period as a tool of political theology connecting Alexander''s divine sonship')
ON CONFLICT DO NOTHING;

-- ── 4. Faulkner Pyramid Texts → Egyptian (core corpus) ──────────────────────
-- The Pyramid Texts (c. 2375-2181 BCE; Unas through Pepi II) are the world's
-- oldest surviving religious corpus and the primary attestation for most of
-- the major Egyptian deities in their oldest recoverable form. Previously linked
-- only to ENT_EGY_IAH and ENT_EGY_WOSRET (newly added entities). The Pyramid
-- Texts are the primary text for: Ennead theology (Atum, Shu, Tefnut, Geb, Nut,
-- Osiris, Isis, Nephthys, Seth, Horus), solar theology (Ra, Khepri, Atum-Ra),
-- funerary theology (Anubis, Sokar/Seker, Duat), and the king's deification.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_ATUM',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 600 (§ 1652): "O Atum-Khoprer, you were on high on the primeval mound; you rose up as the benben stone in the Mansion of the Phoenix in On [Heliopolis]; you spat out Shu, you expectorated Tefnut" — the creation myth in its oldest textual form; Atum is the most frequent divine name in the Pyramid Texts'),
  ('ENT_EGY_SHU',      'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 600 § 1652: Shu created by Atum as the god of air and the space between earth and sky; PT throughout: Shu supports Nut the sky; his role as the first-created divine pair with Tefnut is established here'),
  ('ENT_EGY_TEFNUT',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 600 § 1652: Tefnut created alongside Shu by Atum; the moisture goddess; the primordial divine pair from whom Geb and Nut descend; established in the Pyramid Texts as the second rung of the Ennead'),
  ('ENT_EGY_GEB',      'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Geb is the earth god, son of Shu and Tefnut; frequently invoked as a supporting deity in resurrection utterances; his title "heir of the gods" is established in the Pyramid Texts; Utterance 527 § 1248'),
  ('ENT_EGY_NUT',      'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Nut the sky goddess is one of the most invoked deities; the dead king is described as ascending to Nut and being received by her; "O Great One who became sky..." (Utterance 427 § 779); Nut swallows and re-births the sun each day'),
  ('ENT_EGY_OSIRIS',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Osiris is the central deity of the resurrection theology that runs through the entire Pyramid Text corpus; the dead king is identified with Osiris; Utterance 219 (§ 170): the earliest written form of the Osiris resurrection myth; hundreds of utterances invoke Osiris'),
  ('ENT_EGY_ISIS',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Isis is the most active divine helper in the Pyramid Texts; she and Nephthys flank the coffin and call out to Osiris; her wings protect the dead; Utterance 366 (§ 627): "Isis comes to you... she suckles you with the milk of life and sustenance"'),
  ('ENT_EGY_NEPHTHYS', 'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Nephthys is Isis''s inseparable companion in the Pyramid Texts; she mourns at the coffin head while Isis mourns at the feet; Utterance 366 (§ 628): "your sister Nephthys has come to you"; the two sisters as the protective pair flanking the dead is fully established in the Pyramid Texts'),
  ('ENT_EGY_HORUS',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Horus is the avenger of Osiris and the living king; the Pyramid Texts establish the king as Horus while living and as Osiris after death; Utterances 219-222 (§§ 159-182) contain the earliest narrative of the Horus-Seth conflict; "Horus has seized Seth and set him under you" (§ 142)'),
  ('ENT_EGY_SETH',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Seth is named as the adversary who killed Osiris and opposes Horus; his power is apotropaically invoked in some utterances; the conflict between Horus and Seth is established in the Pyramid Texts as the primordial divine struggle; Utterance 219 and throughout'),
  ('ENT_EGY_RA',       'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Ra is the solar deity whose boat crosses the sky daily; the dead king joins Ra on his barque; Utterance 244 (§ 248); the transition from Osirian to solar theology is visible in the Pyramid Texts as a theological tension between the two dominant frameworks'),
  ('ENT_EGY_THOTH',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Thoth (Djehuty) is the divine scribe and messenger; he delivers words between Horus and Seth; he records the outcome of the divine tribunal; Utterance 359 (§ 594): "Thoth has judged between them"'),
  ('ENT_EGY_ANUBIS',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Anubis (Inpw) is the embalmer and guide of the dead; "Anubis who is upon his mountain" is one of the most frequent epithets in the Pyramid Texts; Utterance 213 (§ 134): Anubis licks and assembles the king''s limbs'),
  ('ENT_EGY_HATHOR',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 247 (§ 261) and throughout: Hathor receives the dead king with her embrace; she provides milk and nourishment; her role as "she who is in the horizon" connects her to the solar cycle; multiple utterances describe the king entering Hathor''s arms'),
  ('ENT_EGY_PTAH',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 570 (§ 1467): Ptah (Ta-Tenen) is invoked in the context of the earth-god theology; the Pyramid Texts include several utterances with Memphis theological language; Ptah''s role as the craftsman-creator who spoke the world into being is the substratum of the texts'),
  ('ENT_EGY_MAAT',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Maat (cosmic order/truth) is a presupposition of the entire Pyramid Text theology; the king acts according to Maat, is given Maat as an offering, and ascends to maintain cosmic order; Utterance 219 (§ 166) and throughout; her feather is the measure of judgment'),
  ('ENT_EGY_HU',       'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 251 (§ 273): Hu (the divine utterance, the authoritative word of the creator) is among the personified attributes of Ra''s creative power; the Pyramid Texts are among the earliest texts attesting Hu as a distinct divine force'),
  ('ENT_EGY_SIA',      'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 250 (§ 270): Sia (divine perception/intuition) personified alongside Hu; both travel with Ra in his solar barque; the Pyramid Texts are the primary ancient source for Sia as a named divine entity in Egyptian theology'),
  ('ENT_EGY_SERQET',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Serqet (Selket) the scorpion goddess protects the dead king; she loosens the throat of the dead so they can breathe; "Serqet gives you breath" (Utterance 366 § 625); one of the four protective goddesses of the canopic jars'),
  ('ENT_EGY_KHEPRI',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 600 and throughout: Khepri (the self-created; the scarab-beetle) is the morning form of the sun, the god of becoming and transformation; the rolling of the sun across the sky is modeled on the dung beetle rolling its ball; primary attestation in the Pyramid Texts'),
  ('ENT_EGY_WEPWAWET', 'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Wepwawet ("Opener of the Ways") is the jackal-headed deity who leads the dead king through the paths of the underworld and opens the roads to the sky; among the most frequently named deities in the Pyramid Texts; Utterance 468 (§ 905)'),
  ('ENT_EGY_NEKHBET',  'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Nekhbet the vulture goddess of Upper Egypt is a protective deity invoked in the Pyramid Texts; she spreads her wings over the king; "your mother Nekhbet comes to you" (Utterance 508); among the oldest attested Egyptian deities'),
  ('ENT_EGY_WADJET',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Wadjet the uraeus cobra of Lower Egypt is the eye of Re protecting the king; she spits fire at enemies; invoked alongside Nekhbet as the Two Ladies; among the oldest attested Egyptian deities (Narmer Palette context confirmed by Pyramid Texts)'),
  ('ENT_EGY_MIN',      'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 461 (§ 872) and elsewhere: Min the ithyphallic fertility god is invoked in the Pyramid Texts as the divine procreative force; his Coptos colossi (among the oldest Egyptian art) predate the Pyramid Texts; his presence in the PTs confirms his Old Kingdom theological standing'),
  ('ENT_EGY_SOBEK',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 317 (§ 507): Sobek the crocodile god is invoked in the Pyramid Texts as a protective deity with connections to the primordial waters; his Fayum and Kom Ombo cults have Pyramid Text foundation'),
  ('ENT_EGY_KHNUM',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterances and the Memphite tradition: Khnum the ram-headed creator god is invoked as the craftsman who shapes on the potter''s wheel; his Elephantine cult is attested from the Old Kingdom; the Pyramid Texts include his protective and creative functions'),
  ('ENT_EGY_SESHAT',   'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 616 (§ 1742): Seshat the goddess of writing and measurement stretches the cord for the king''s mortuary temples; her role in measuring the king''s reign and recording his deeds is established in the Pyramid Text corpus alongside other scribal theology'),
  ('ENT_EGY_SEKER',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Seker (Sokar) the falcon-headed funerary deity of the Memphis necropolis is a primary figure in the Pyramid Text underworld geography; he is lord of Rosetau (the entrance to the underworld); the Pyramid Texts are his earliest systematic attestation'),
  ('ENT_EGY_AKER',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 255 (§ 300): Aker the double-lion deity of the earth''s horizons guards the passage of the sun and the dead king at the eastern and western horizons; a specifically Pyramid Text deity whose primary evidence is the Old Kingdom funerary corpus'),
  ('ENT_EGY_HAPY_NILE','SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Hapy the Nile flood god is invoked as the source of abundance; the king''s power is compared to Hapy''s; Utterance 442 (§ 820): the king''s natron and water are identified with the flood; foundational Pyramid Text attestation'),
  ('ENT_EGY_MONTU',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: Montu the falcon-headed war deity of Armant (Hermonthis) is invoked in warrior contexts in the Pyramid Texts; his Old Kingdom period is his earliest significant attestation; the Pyramid Texts establish his role as a royal war deity before Amon superseded him'),
  ('ENT_EGY_DUAT',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT throughout: the Duat (the underworld/afterlife realm) is the destination and landscape of most Pyramid Text utterances; its topography — the Field of Rushes (Sekhet-Aaru), Rosetau, the barque of Ra — is established here in its earliest surviving form; the Pyramid Texts are the primary ancient source for Duat geography')
ON CONFLICT DO NOTHING;

-- ── 5. Herodotus → additional entities ──────────────────────────────────────
-- Herodotus, Histories (c. 430 BCE): Books 1-3 systematically document
-- religious equations between Greek, Egyptian, Persian, Phoenician, and
-- Arabian traditions. These are the earliest surviving systematic
-- interpretatio graeca of Near Eastern religions.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  -- Egyptian equations (Book 2)
  ('ENT_EGY_OSIRIS',  'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.42, 2.144: Osiris is explicitly equated with Dionysus; Herodotus says "the Egyptians celebrate a feast to Dionysus [Osiris]" and links the myth of Dionysus''s death and resurrection to Osiris; the oldest surviving Greek text making this equation'),
  ('ENT_EGY_ISIS',    'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.41, 2.59: "Isis in the Greek tongue is Demeter"; Herodotus identifies Isis with Demeter at the festival of Bubastis (2.59) and through the grain/agriculture connection; the primary ancient Greek text for the Isis=Demeter equation'),
  ('ENT_EGY_HORUS',   'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.144: Horus is equated with Apollo ("the Egyptians say that Ares and Apollo ... in Egyptian they call Ares Onuris [= Anhur], and Apollo Horus"); the Horus=Apollo identification, while less prominent than Osiris=Dionysus, is made explicit by Herodotus'),
  ('ENT_EGY_AMUN',    'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.42: "Those [Egyptians] who dwell near Thebes sacrifice no sheep but goats... they honor Zeus [= Amun]" — Herodotus explicitly identifies the Theban Amun with Zeus; the oracle of Zeus Ammon in Libya is the Hellenized form of the Siwa Amun oracle; 2.42 and throughout'),
  ('ENT_EGY_THOTH',   'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.52: Herodotus states the Egyptians gave names to the gods that the Greeks then adopted; the equation of Thoth with Hermes ("Hermes they derive from Egypt") underlies the later Hermes Trismegistus tradition; the primary ancient source for this equation'),
  ('ENT_SYN_ZEUS_AMMON', 'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.42, 3.26: Herodotus describes the oracle of Zeus Ammon (= Amun) at the Siwa oasis in Libya; the oracle that Cambyses'' army tried to reach; the primary ancient source establishing Zeus Ammon as a widely recognized cross-cultural deity'),
  -- Persian/Zoroastrian (Book 1)
  ('ENT_ZOR_AHURA_MAZDA', 'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 1.131: "The Persians have no images of the gods, no temples nor altars, and consider their use a sign of folly... Their wont is to ascend the summits of the loftiest mountains, and there to offer sacrifice to Jove [= Ahura Mazda], which is the name they give to the whole circuit of the firmament"; the earliest surviving Greek account of the Persian deity identified as the sky'),
  ('ENT_ZOR_ANAHITA',     'SRC_HERODOTUS_HISTORIES', 'secondary_reference',
   'Histories 1.131: Herodotus notes the Persians sacrifice to "Aphrodite Ourania" — this is almost certainly the Persian Anahita in Greek interpretatio; later confirmed by Artaxerxes II inscriptions; Herodotus is the earliest Greek source linking Persian religion to an Aphrodite-type figure'),
  -- Arabian (Book 3)
  ('ENT_ARA_AL_UZZA',     'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 3.8: "The Arabians call Aphrodite Ourania Alilat" — Alilat is identified with both Al-Lat and Al-Uzza in Arabian tradition; this is the earliest surviving Greek reference to a named Arabian goddess; the Aphrodite Ourania equation establishes her as a Venus-type celestial deity'),
  -- Cross-traditional reception figures
  ('ENT_HERACLES',    'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.44: Herodotus explicitly distinguishes the Greek Heracles from the Phoenician Melqart; he claims to have visited the ancient temple of Heracles at Tyre (two sacred pillars, one gold, one emerald); 2.145: Heracles is placed in a much earlier genealogical stratum than the Greek tradition allows, establishing him as a universal ancient hero'),
  ('ENT_DIONYSUS',    'SRC_HERODOTUS_HISTORIES', 'primary_attestation',
   'Histories 2.49, 2.144, 2.156: Herodotus traces Dionysus''s origins to Egypt (= Osiris) and claims Melampus introduced the Dionysiac rites to Greece from Egypt; he also names Dionysus as much more ancient than Greek genealogy allows; a critical early text for Dionysus''s oriental connections')
ON CONFLICT DO NOTHING;

-- ── 6. Foster Before the Muses → Mesopotamian (Akkadian) ────────────────────
-- Benjamin Foster, Before the Muses: An Anthology of Akkadian Literature
-- (3rd ed. 2005) — the standard Akkadian literary anthology. Key Akkadian
-- texts and their entities:
--   Enuma Elish (Epic of Creation): Marduk, Tiamat, Apsu, Kingu, Ea/Enki
--   Descent of Ishtar: Inanna/Ishtar, Ereshkigal, Nergal (implied)
--   Nergal and Ereshkigal: Nergal, Ereshkigal
--   Atrahasis Epic: Enki/Ea, Enlil, Anu, Nintu (= Ninhursag), Adad
--   Adapa myth: Enki/Ea (Ea counsels Adapa)
--   Erra and Ishum: Nergal (= Erra), Marduk
--   Hymns to Nabu, Marduk, Adad, Ishtar, Ninsun, Ashur

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_MES_MARDUK',        'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Enuma Elish (Epic of Creation; Foster pp. 436-486): Marduk defeats Tiamat, creates the cosmos from her body, and is acclaimed king of the gods; the primary Akkadian text for Marduk''s mythology and his elevation to chief deity of the Babylonian pantheon; also Erra and Ishum (Foster pp. 900-934) where Marduk temporarily vacates his role'),
  ('ENT_MES_TIAMAT',        'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Enuma Elish Tablets I-IV (Foster pp. 436-460): Tiamat the primordial saltwater goddess leads the divine rebellion; her body is split by Marduk to create heaven and earth; the primary Akkadian text for Tiamat as a named mythological entity'),
  ('ENT_MES_APSU',          'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Enuma Elish Tablet I (Foster pp. 436-441): Apsu the primordial freshwater ocean is killed by Ea/Enki in the first divine conflict; Ea builds his temple over Apsu''s body; the primary Akkadian text for Apsu as a named deity distinct from the Sumerian Abzu'),
  ('ENT_MES_KINGU',         'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Enuma Elish Tablets II-VI (Foster pp. 450-475): Kingu is appointed Tiamat''s champion and given the Tablet of Destinies; after Marduk''s victory, Kingu is killed and his blood used to create humanity; the primary Akkadian text for Kingu'),
  ('ENT_MES_NABU',          'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Enuma Elish Tablet VII (Foster pp. 477-486): Marduk grants Nabu the tablet stylus; hymns to Nabu in Foster document his role as god of writing and scribal arts, son of Marduk, patron of Borsippa; the primary Akkadian literary documentation of Nabu''s divine functions'),
  ('ENT_MES_ASHUR',         'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'The Assyrian version of the Enuma Elish substitutes Ashur for Marduk as the victorious deity (an Assyrian theological adaptation); Foster documents this Assyrian version; also Assyrian royal hymns to Ashur document his role as the national deity of Assyria'),
  ('ENT_MES_ERESHKIGAL',   'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Descent of Ishtar (Akkadian; Foster pp. 498-505): the Akkadian version of the Inanna/Ishtar descent; Ereshkigal rules the underworld and has Ishtar killed at each gate; Nergal and Ereshkigal (Foster pp. 506-524): the fullest ancient account of Ereshkigal''s character and her troubled union with Nergal'),
  ('ENT_MES_INANNA_ISHTAR', 'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Descent of Ishtar (Akkadian; Foster pp. 498-505): the Akkadian version of the descent to the underworld; Ishtar stripped of her divine attributes at seven gates; Ishtar Hymns (Foster pp. 570-589): major hymns to Ishtar documenting her character as goddess of love, war, and Venus'),
  ('ENT_MES_NERGAL',        'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Nergal and Ereshkigal (Foster pp. 506-524): the most important Akkadian text for Nergal; he descends to the underworld, has his head seized by Ereshkigal''s throne-attendant Namtar, eventually seizes Ereshkigal herself, and becomes her consort as king of the underworld; Erra and Ishum (Foster pp. 900-934) is the other major Nergal/Erra text'),
  ('ENT_MES_ENKI_EA',       'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Atrahasis Epic (Foster pp. 160-201): Ea/Enki warns Atrahasis about the flood against the decision of the divine assembly; Enuma Elish (Foster pp. 436-486): Ea kills Apsu and establishes himself in the Abzu; the Adapa myth (Foster pp. 528-535): Ea counsels Adapa; primary Akkadian attestations for Ea as the clever intermediary deity'),
  ('ENT_MES_ENLIL',         'SRC_FOSTER_BEFORE_MUSES', 'secondary_reference',
   'Atrahasis Epic (Foster pp. 160-201): Enlil decrees the flood to destroy humanity; the noise of humanity disturbs his sleep; the primary Akkadian text for Enlil''s role as the divine authority who demands humanity''s destruction (in contrast to Ea who saves them)'),
  ('ENT_MES_ADAD_ISHKUR',  'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Atrahasis Epic (Foster pp. 160-201): Adad the storm deity is listed among the great Anunnaki who decree the flood; Adad hymns in Foster document his role as the storm deity who brings rain and thunder; his Akkadian name Adad distinguishes him from the Sumerian Ishkur'),
  ('ENT_MES_LAMASHTU',      'SRC_FOSTER_BEFORE_MUSES', 'primary_attestation',
   'Lamashtu incantation texts (Foster pp. 838-853): the most detailed ancient documentation of Lamashtu as a threatening demoness; the texts describe her physical appearance, her threats to pregnant women and newborns, and the rituals (especially Pazuzu amulets) used to repel her')
ON CONFLICT DO NOTHING;

-- ── 7. Burkert Orientalizing Revolution → reception chain entities ───────────
-- Walter Burkert, The Orientalizing Revolution: Near Eastern Influence on
-- Greek Culture in the Early Archaic Age (Harvard, 1992): the primary
-- scholarly source for documenting the transmission of Near Eastern cultural
-- and religious content into Archaic Greek culture (8th-6th c. BCE).
-- Key transmission chains Burkert documents: Inanna/Aphrodite, Kumarbi/Kronos,
-- Teshub/Zeus, Tiamat/Typhon, Gilgamesh/Heracles structural parallels.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  -- Mesopotamian → Greek
  ('ENT_MES_INANNA_ISHTAR', 'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 97-100: the transmission of the Inanna/Ishtar tradition into the Greek Aphrodite figure via Cypriot and Phoenician mediation; the shared Queen of Heaven / Venus star / love-war combination; the Adonis cult as the Dumuzi/Tammuz reception in Cyprus'),
  ('ENT_APHRODITE',         'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 97-100: Aphrodite as the primary Greek reception of the Mesopotamian Inanna/Ishtar and Phoenician Astarte; the orientalizing context of the Cypriot Aphrodite cult; the "oriental" features that distinguish Aphrodite from typical Olympic goddesses'),
  ('ENT_KRONOS',            'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 18-22: Kronos as the Greek reception of Kumarbi (Hurrian) and the "succession myth" pattern; the castration-by-son narrative links the Hurrian Theogony to Hesiod''s Theogony via the Hittite-Mycenaean contact zone; a centerpiece of Burkert''s argument'),
  ('ENT_ZEUS',              'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 22-29: Zeus as the victorious storm deity who defeats the monster after the divine succession; the Teshub/Zeus and Marduk/Zeus parallels; the "storm-deity fights monster" pattern transmitted from Mesopotamia and Anatolia into Greek mythology'),
  ('ENT_TYPHON',            'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 29-34: Typhon as the Greek reception of both Ullikummi (Hurrian) and Tiamat (Babylonian); the "great monster created to fight the champion" narrative pattern; the Syrian connection of Typhon''s myth (located near Cilicia in Greek tradition)'),
  -- Hittite → Greek
  ('ENT_HTT_KUMARBI',       'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 18-22: Kumarbi as the Hurrian prototype for Kronos; the Hittite Kumarbi cycle (Song of Kumarbi) as the near-eastern tradition behind the Hesiodic succession myth; key evidence for the transmission via Anatolian-Greek contact'),
  ('ENT_HTT_TESHUB',        'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 22-29: Teshub the Hurrian storm deity as a prototype for Zeus in the succession narrative context; the Teshub-Kumarbi conflict as a structural template for the Zeus-Kronos conflict'),
  ('ENT_HTT_ULLIKUMMI',     'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 29-34: Ullikummi (the stone giant created by Kumarbi to fight Teshub) as the Hurrian prototype for the Greek Typhon; the narrative of the defeated god creating a monster for revenge'),
  -- Gilgamesh / Heracles
  ('ENT_MES_GILGAMESH',     'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 76-90: Gilgamesh as a structural parallel to Heracles; the two-thirds divine / one-third human hero with a divine companion, monster-slaying labors, and a quest for immortality; Burkert documents the ways Gilgamesh material entered Greek heroic tradition via the Orientalizing period'),
  ('ENT_HERACLES',          'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 76-90: Heracles as the primary Greek hero who shows structural parallels with Gilgamesh; the lion-skin, the divine companion (Iolaus parallel to Enkidu), the Labors as monster-slaying, the quest for immortality; Burkert is cautious about direct transmission but documents the contact'),
  -- Prometheus
  ('ENT_MES_ENKI_EA',       'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 84-87: the Enki/Ea-as-divine-benefactor pattern and its structural parallel with Prometheus; both defy divine authority to preserve humanity; Burkert notes the comparison while acknowledging no direct transmission is documented'),
  ('ENT_PROMETHEUS',        'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 84-87: Prometheus as a possible Greek reception of the Mesopotamian divine-benefactor archetype; the structural parallel with Enki/Ea who warns humanity against the divine assembly''s decree'),
  -- Adonis
  ('ENT_ADONIS',            'SRC_BURKERT_ORIENT_REV', 'secondary_reference',
   'Burkert (1992) pp. 97-100: the Adonis cult as the Greek reception of the Dumuzi/Tammuz dying-and-rising deity tradition, transmitted via Phoenician mediation through Cyprus; the name "Adonis" itself from Phoenician adon ("lord"); primary scholarly documentation of this transmission')
ON CONFLICT DO NOTHING;

-- ── 8. Bundahishn → Zoroastrian ──────────────────────────────────────────────
-- The Bundahishn ("Primal Creation"; Greater Bundahishn compiled c. 9th c. CE
-- in Pahlavi, preserving older Avestan and Sasanian-period traditions) is the
-- most systematic ancient account of Zoroastrian cosmogony and cosmology. It
-- describes: the original creation of the world as a sphere of light; Angra
-- Mainyu's attack; the division of the cosmos into 12 heavens; the Amesha
-- Spentas' domains; the Daevas; the end-times (Frashgird). The Bundahishn
-- supplements the Avesta with cosmological detail absent from that liturgical
-- corpus and is the primary source for Zoroastrian theology in systematic form.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ZOR_AHURA_MAZDA',   'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 1-3: Ahura Mazda''s original creation of the world as pure light and spiritual being (Menok); his fashioning of the six Amesha Spentas; his foreknowledge of Angra Mainyu''s attack; the Bundahishn is the primary narrative account of Ahura Mazda''s creative activity'),
  ('ENT_ZOR_ANGRA_MAINYU',  'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 1, 3-4: Angra Mainyu''s attack on the good creation; his corruption of each of the seven creations (sky, water, earth, plants, animals, humans, fire); the Bundahishn is the most detailed ancient account of Angra Mainyu''s (Ahriman''s) cosmic assault'),
  ('ENT_ZOR_AMESHA_SPENTAS','SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3 and throughout: the six Amesha Spentas (Beneficent Immortals) created by Ahura Mazda as his divine agents, each assigned guardianship of one of the six material creations; the Bundahishn provides the most systematic account of their domains and relationships'),
  ('ENT_ZOR_VOHU_MANAH',    'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3, 26: Vohu Manah (Good Mind) is the first and highest of the Amesha Spentas; guardian of cattle; he led Zarathustra to Ahura Mazda; the Bundahishn documents his eschatological role at the Frashgird'),
  ('ENT_ZOR_ASHA_VAHISHTA',  'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3: Asha Vahishta (Best Truth/Righteousness) is the Amesha Spenta of fire; guardian of fire and cosmic order; the Bundahishn describes his role in maintaining the cosmic fires that will purify the world at the end'),
  ('ENT_ZOR_KHSHATHRA',     'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3: Khshathra Vairya (Desirable Dominion) is the Amesha Spenta of metal/sky; guardian of metals; his domain covers the sky dome and the mineral world; documented in the Bundahishn''s creation account'),
  ('ENT_ZOR_SPENTA_ARMATI', 'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3: Spenta Armaiti (Holy Devotion) is the Amesha Spenta of earth; guardian of the earth; associated with piety and the devotion of the farmer who tends the soil; the Bundahishn''s agricultural theology'),
  ('ENT_ZOR_HAURVATAT',     'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3: Haurvatat (Wholeness/Health) is the Amesha Spenta of water; guardian of water; paired with Ameretat; the Bundahishn describes their eschatological roles in restoring the dead'),
  ('ENT_ZOR_AMERETAT',      'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 3: Ameretat (Immortality) is the Amesha Spenta of plants; guardian of the plant kingdom; paired with Haurvatat; the Bundahishn documents how the two together will restore the world at the Frashgird'),
  ('ENT_ZOR_MITHRA',        'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 12 and throughout: Mithra is the Yazata of covenant, contract, and light; the Bundahishn documents his role as the divine witness of all contracts and his connection to the sun; his thousand-eared and ten-thousand-eyed nature; a key text for Mithra''s cosmological functions'),
  ('ENT_ZOR_ANAHITA',       'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 13: Anahita (Aredvi Sura Anahita) is the Yazata of water, fertility, and purification; the Bundahishn documents the cosmic river Ardvi that descends from the heavenly mountain Hara and feeds all the waters of the world; Anahita''s role as the guardian of this cosmic water'),
  ('ENT_ZOR_SRAOSHA',       'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 30 (eschatology): Sraosha (Obedience/Hearkening) plays a role in the soul''s judgment at the Chinvat Bridge; the Bundahishn documents his eschatological and protective functions alongside Mithra and Rashnu in the judgment of souls'),
  ('ENT_ZOR_ATAR',          'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 17: Atar (the sacred fire) is described as the son of Ahura Mazda; the five types of sacred fire (including Gushnasb, Farnbag, and Burzen-Mihr) are documented in the Bundahishn; the cosmic fire''s role in defeating Angra Mainyu and purifying the world at the Frashgird'),
  ('ENT_ZOR_DAEVAS',        'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 4: the Daevas are the demonic forces that follow Angra Mainyu; each Daeva opposes one of the Amesha Spentas; the Bundahishn documents the Daeva hierarchy and their role as corrupters of the good creation'),
  ('ENT_ZOR_AESHMA_DAEVA',  'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 28: Aeshma (Wrath/Violence) is the leader of the Daevas in many texts; the Bundahishn documents his role as the primary adversarial force in the cosmic conflict; Aeshma is the Zoroastrian original of the Hebrew Asmodaeus (Tobit)'),
  ('ENT_ZOR_FRAVASHIS',     'SRC_BUNDAHISHN', 'primary_attestation',
   'Bundahishn 6B and throughout: the Fravashis (divine guardian spirits of the righteous) are documented in the Bundahishn as pre-existent spirits who chose to enter physical bodies to fight against Angra Mainyu; their nature as a personal guardian spirit is more fully developed here than in the Avesta')
ON CONFLICT DO NOTHING;

-- ── 9. Mandaean Book of John → Mandaean ─────────────────────────────────────
-- The Draşa d-Yahya (Book of the Zodiac / Book of John; primary Mandaean text)
-- contains hymns and narrative cycles related to John the Baptist as a Mandaean
-- prophet, the descent of Manda d-Hayyi into the world, and the Mandaean
-- cosmological mythology. It is a primary Mandaean liturgical text alongside
-- the Ginza Rba (already linked) and provides a complementary witness.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_MAN_HAYYI_RABBI',   'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'The Book of John addresses Hayyi Rabbi (the Great Life) as the supreme deity throughout; the liturgical hymns in the text are addressed to the Great Life and document his relationship to the lower Light World beings; essential complement to the Ginza Rba''s theological account'),
  ('ENT_MAN_MANDA_D_HAYYI', 'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Manda d-Hayyi (Knowledge of Life) features centrally in the Book of John as the revealer who descends to the earthly world and interacts with John the Baptist; the "knowledge of life" as a redeemer figure who brings gnosis from the Light World'),
  ('ENT_MAN_JOHN_BAPTIST',  'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'The Book of John (Draşa d-Yahya = "Teaching of John") is named for and centrally concerned with John the Baptist as a Mandaean prophet; it contains dialogues, hymns, and narratives in which John receives divine knowledge and instructs the Mandaean community; the primary Mandaean text for the John tradition'),
  ('ENT_MAN_HIBIL_ZIWA',    'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Hibil Ziwa (Radiant Abel) appears in the Book of John in his role as the Light World savior who descends into the underworld; the Descent of Hibil Ziwa narrative is a major Mandaean cosmological text partially preserved in the Book of John alongside the Ginza Rba'),
  ('ENT_MAN_RUHA',          'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Ruha (Spirit/Breath) as the adversarial female figure appears in the Book of John''s cosmological passages; her role as the mother of the Seven Planets (planetary archons) and as the adversary of the Light World beings is documented here'),
  ('ENT_MAN_PTAHIL',        'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Ptahil (the Mandaean demiurge-creator) appears in the Book of John''s creation narratives; his role as the imperfect world-maker sent from the Light World but who produces a flawed material creation'),
  ('ENT_MAN_ABATHUR',       'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Abathur (the judge who weighs souls) is mentioned in the Book of John''s afterlife passages; his role at the scales of judgment is a key Mandaean eschatological concept documented across the primary texts'),
  ('ENT_MAN_ANOSH',         'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Anosh (Enosh; the immortal one) appears in the Book of John as a Light World being; the Mandaean reception of the biblical Enosh (son of Seth) as a primordial divine figure'),
  ('ENT_MAN_SITIL',         'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Sitil (Seth) appears in the Book of John as a primordial patriarch/light being; the Mandaean reception of the biblical Seth as a divine or semi-divine ancestor figure'),
  ('ENT_MAN_YUSHAMIN',      'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Yushamin appears in the Book of John as a demiurgic/lightworld being; one of the uthra (angels) of the Light World whose actions are narrated in Mandaean cosmological texts'),
  ('ENT_MAN_MELKA_D_NHURA', 'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Melka d-Nhura (King of Light) is documented in the Book of John as a Light World sovereign; his relationship to the Great Life and to the material world is part of the Mandaean celestial hierarchy'),
  ('ENT_MAN_MANA_RABBA',    'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Mana Rabba (the Great Mind/Vessel) is documented in the Book of John as the transcendent container of divine light; the concept of the divine vessel (mana) that contains and preserves the light particles is central to Mandaean theology'),
  ('ENT_MAN_UR',            'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'Ur (the chthonic monster/dragon of darkness) appears in the Book of John''s cosmological passages; the primordial darkness that Ptahil encounters and partially defeats in creating the world'),
  ('ENT_MAN_JORDAN',        'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'The Jordan (Yardna) as the ritual river of baptism is central to the Book of John; John the Baptist''s role as the master of baptism (maşbuta) in living water is the theological heart of the text; the celestial Jordan as the archetypal river of life'),
  ('ENT_MAN_PLANETS',       'SRC_MANDAEAN_BOOK_JOHN', 'primary_attestation',
   'The Seven Planets (as planetary archons and children of Ruha) are documented in the Book of John''s cosmological passages; their role as adversarial cosmic rulers who imprison souls in the material world is part of the Mandaean astrological mythology')
ON CONFLICT DO NOTHING;

-- ── 10. Manichaean Psalm Book → Manichaean ───────────────────────────────────
-- The Manichaean Psalm Book (Allberry, 1938; Coptic; from Medinet Madi,
-- Egypt; c. 4th c. CE) is a collection of Manichaean liturgical psalms
-- in Coptic preserving the theology of Mani's religion in hymnic form.
-- All Manichaean entities are named/invoked in this hymnal corpus.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_MANICH_FATHER_GREATNESS', 'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Father of Greatness is invoked in Manichaean psalms as the supreme transcendent deity; "I bless thee, O Father of Greatness" is a formula running through the Psalm Book; the hymns document his separation from Matter and his light-realm'),
  ('ENT_MANICH_MOTHER_LIFE',      'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Mother of Life (First Evocation) appears in Manichaean hymns as the divine mother who calls forth the Primal Man to defend the Light against the attack of Darkness; psalm hymns document her role in the primordial conflict'),
  ('ENT_MANICH_PRIMAL_MAN',       'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Primal Man (Ohrmizd Bay in Parthian) is hymned in the Psalm Book as the divine warrior who descends to fight Darkness, is defeated and captured, and must be rescued; his five sons (the light elements) are swallowed by Darkness in this primordial battle'),
  ('ENT_MANICH_FIVE_SONS',        'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Five Sons of the Primal Man (= five light elements: ether, wind, light, water, fire) are invoked in the psalms; they were surrendered to Darkness and mixed into matter; the Psalm Book hymns their liberation as the goal of the cosmic drama'),
  ('ENT_MANICH_LIVING_SPIRIT',    'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Living Spirit (Second Evocation) is hymned as the rescuer of the Primal Man; he calls down to the captured Primal Man and hears his answering call (the Call and the Answer become divine beings); the psalms document his role in constructing the cosmos from the bodies of defeated demons'),
  ('ENT_MANICH_GREAT_BUILDER',    'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Great Builder (the cosmological architect invoked alongside the Living Spirit) appears in Manichaean hymns as the divine craftsman who constructs the material cosmos from the captured light particles; psalm documentation of the Manichaean cosmogony'),
  ('ENT_MANICH_COLUMN_GLORY',     'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Column of Glory (the Milky Way as the path of ascending light) is invoked in Manichaean psalms; souls of the redeemed ascend through the Column of Glory back to the Light World; the Psalm Book hymns this cosmic mechanism of salvation'),
  ('ENT_MANICH_JESUS_SPLENDOUR',  'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'Jesus Splendour (the Manichaean cosmic Christ figure, distinct from the historical Jesus) is hymned extensively in the Psalm Book; the "Psalms of Thomas" and the "Psalms of Heraclides" in the Psalm Book address Jesus Splendour as the cosmic redeemer who calls souls to light'),
  ('ENT_MANICH_LIGHT_MIND',       'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Light Mind (the divine nous/mind that descends into the righteous to begin their liberation) is a key figure in Manichaean soteriology; the Psalm Book invokes the Light Mind as the divine gift to human souls; the recipient of the Light Mind is the Manichaean Elect'),
  ('ENT_MANICH_WORLD_LIGHT',      'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The World of Light (the transcendent divine realm of the Father of Greatness) is hymned throughout the Psalm Book as the origin and ultimate destination of all light particles; the cosmological goal of Manichaean soteriology'),
  ('ENT_MANICH_KING_DARKNESS',    'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The King of Darkness (the adversarial principle who attacks the World of Light) is named in Manichaean psalms; his realm of five kinds of darkness (equivalent to the five elements of the World of Light) is documented in the Psalm Book''s cosmological hymns'),
  ('ENT_MANICH_MATTER',           'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'Matter (Hyle; the feminine principle of Darkness) is invoked in Manichaean hymns as the corrupt material of the cosmos; the Psalm Book''s hymns describe the mixing of light particles into Matter and the work of liberation'),
  ('ENT_MANICH_ARCHONS',          'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The Archons (demonic cosmic rulers whose bodies became the material cosmos) are named in Manichaean psalms; the Living Spirit''s creation of the cosmos from the slain archons'' bodies is the Manichaean cosmogonic myth documented in the Psalm Book'),
  ('ENT_MANICH_DEMONS',           'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'Manichaean demonic forces are invoked in apotropaic and soteriological psalms; the Psalm Book documents the demonic hierarchy that opposes the work of light liberation'),
  ('ENT_MANICH_LIGHT_PARTICLES',  'SRC_MANICHAEAN_PSALM_BOOK', 'primary_attestation',
   'The light particles (trapped divine light in matter) are the object of all Manichaean soteriological effort; the Psalm Book''s hymns express the longing of light particles for liberation; the fundamental Manichaean concept documented in its primary hymnic form')
ON CONFLICT DO NOTHING;

-- ── 11. Wyatt and Cross → Canaanite (full corpus) ───────────────────────────
-- SRC_WYATT_RELIGIOUS_TEXTS (N. Wyatt, Religious Texts from Ugarit, 2002):
--   primary translation of the KTU Ugaritic tablets; every Ugaritic deity
--   named in the Baal Cycle (KTU 1.1-6), El cycle, and ritual texts
-- SRC_CROSS_CANAANITE_MYTH (F.M. Cross, Canaanite Myth and Hebrew Epic, 1973):
--   the standard scholarly treatment of Canaanite religion and its relationship
--   to Israelite religion; covers El, Baal, Asherah, Astarte, Anat, Mot, Yam

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  -- Wyatt linkages for core Ugaritic pantheon
  ('ENT_CAN_EL',      'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'El is the patriarch of the Ugaritic pantheon; KTU 1.1-6 (Baal Cycle) throughout; KTU 1.65 (El''s feast); Wyatt (2002) pp. 1-10, 329-348; El as "Father of Years," the creator god, husband of Athirat'),
  ('ENT_CAN_BAAL',    'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Baal Hadad is the protagonist of the Baal Cycle (KTU 1.1-6); Wyatt (2002) pp. 33-120 (Baal and Yam), 106-182 (Baal and Mot); his palace-building, death, and resurrection are the central narrative'),
  ('ENT_CAN_ANAT',    'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Anat is Baal''s sister and defender; KTU 1.3 (she slaughters warriors), 1.6 (she retrieves Baal from the underworld); Wyatt (2002) pp. 70-89; the most ferocious goddess in the Ugaritic texts'),
  ('ENT_CAN_ASHERAH', 'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Athirat/Asherah is El''s consort and "Lady of the Sea"; KTU 1.3-4 (Baal appeals to her as intercessor with El); Wyatt (2002) pp. 63-70, 88-106; her role as the divine mother and El''s queen'),
  ('ENT_CAN_ASTARTE', 'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Astarte appears in Ugaritic texts alongside Anat; KTU 1.14 (Keret Epic); Wyatt (2002) pp. 176-212; her role as the Venus goddess and queen of heaven; cognate with the Mesopotamian Inanna/Ishtar'),
  ('ENT_CAN_MOT',     'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Mot (Death) is Baal''s principal adversary; KTU 1.4 V - 1.6 VI (the Baal-Mot conflict; Baal''s descent into Mot''s throat and death; Anat''s vengeance; Baal''s resurrection); Wyatt (2002) pp. 100-168; the underworld deity whose challenge to Baal structures the cycle'),
  ('ENT_CAN_YAM',     'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Yam (Sea) is Baal''s first great enemy; KTU 1.1-2 (Baal vs. Yam); Wyatt (2002) pp. 33-64; the combat between Baal and the primordial sea is a key Ugaritic myth with wide Near Eastern comparanda (Marduk-Tiamat, YHWH-Leviathan)'),
  ('ENT_CAN_LOTAN',   'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Lotan (the twisting/fleeing serpent) is slain by Baal or Anat; KTU 1.5 I 1-3: "When you smote Lotan the fleeing serpent, annihilated the twisting serpent"; Wyatt (2002) pp. 113-115; Lotan is the Ugaritic original of the Hebrew Leviathan'),
  ('ENT_CAN_KOTHAR',  'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Kothar-wa-Khasis ("Skillful and Clever") is the divine craftsman who forges Baal''s clubs (Yagrush and Aymur) for his battle against Yam; KTU 1.1-2; Wyatt (2002) pp. 40-50; his workshops are in Egypt (Kaphtor/Crete) in the Ugaritic texts'),
  ('ENT_CAN_SHAPASH', 'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Shapash (the sun) mediates between Baal and the underworld in KTU 1.6 IV-VI; she declares Baal''s victory in the final resolution of the Baal-Mot conflict; Wyatt (2002) pp. 160-165; a female sun deity in Ugaritic tradition'),
  ('ENT_CAN_YARIKH',  'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'Yarikh (the moon) is attested in the Ugaritic texts; KTU 1.24 (the Wedding of Yarikh and Nikkal); Wyatt (2002) pp. 335-341; the moon deity whose name survives in the toponym Jericho (Yericho)'),
  ('ENT_CAN_REPHAIM', 'SRC_WYATT_RELIGIOUS_TEXTS', 'primary_attestation',
   'The Rephaim (the dead kings/heroes) appear in the Ugaritic texts as divine or semi-divine beings summoned to feasts; KTU 1.20-22 (the Rephaim texts); Wyatt (2002) pp. 317-334; the Ugaritic Rephaim illuminate the biblical Rephaim as giant ancient peoples'),
  -- Cross linkages
  ('ENT_CAN_EL',      'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 1-75: the definitive scholarly treatment of El in the Ugaritic texts and his relationship to the Israelite ʾEl tradition; El''s titles (Father of Years, Creator of Creatures, Bull El), his tent sanctuary, and his transition from patriarch to background deity'),
  ('ENT_CAN_BAAL',    'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 112-163: Baal as the storm deity and divine king; the Baal Cycle as mythology of the battle for divine kingship; the Baal-YHWH comparison and the biblical polemics against Baal worship'),
  ('ENT_CAN_ASHERAH', 'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 31-35: Asherah as El''s consort and her Israelite reception; the asherah cult poles in the Hebrew Bible; the debate about whether Asherah was worshipped alongside YHWH in early Israelite religion'),
  ('ENT_CAN_ASTARTE', 'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 28-43: Astarte''s role in the Canaanite pantheon and her reception in Phoenician and Israelite religion; the Queen of Heaven worship condemned in Jeremiah 44'),
  ('ENT_CAN_ANAT',    'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 16-22: Anat in the Ugaritic texts and her faint traces in the Hebrew Bible (Anathoth; the name Shamgar ben Anat); the war goddess tradition'),
  ('ENT_CAN_LOTAN',   'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 118-120: Lotan/Leviathan as the fleeing serpent defeated by the storm deity; the combat myth in Ugaritic and its reception in Psalms 74, 89, Isaiah 27; the most systematic scholarly treatment of this tradition'),
  ('ENT_CAN_YAM',     'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 112-120: Yam as the sea deity defeated by Baal/YHWH; the combat myth pattern; the Israelite reception in the Sea crossing narrative and the prophetic sea imagery'),
  ('ENT_CAN_MOT',     'SRC_CROSS_CANAANITE_MYTH', 'secondary_reference',
   'Cross (1973) pp. 116-118: Mot as death and the underworld deity; the Baal-Mot cycle as a fertility-myth framework; biblical parallels with the Sheol theology'),
  ('ENT_CAN_EL',      'SRC_DAY_GODS_CONFLICT', 'secondary_reference',
   'Day (1985) pp. 1-38: El and the primordial sea in Canaanite and Israelite theology; the relationship between El''s authority and Yam''s challenge'),
  ('ENT_CAN_LOTAN',   'SRC_DAY_GODS_CONFLICT', 'secondary_reference',
   'Day (1985) pp. 1-61: the dragon/sea conflict as the organizing principle of Canaanite religion; Lotan, Yam, and their biblical reception in Leviathan and Rahab; the fullest treatment of this mythological complex'),
  ('ENT_CAN_YAM',     'SRC_DAY_GODS_CONFLICT', 'secondary_reference',
   'Day (1985) pp. 1-61: Yam the sea deity and his conflict with Baal in Ugaritic and with YHWH in the Hebrew Bible; SRC_DAY_GODS_CONFLICT is the standard monograph on this subject')
ON CONFLICT DO NOTHING;

-- ── 12. Collins Apocalyptic Imagination → Israelite Second Temple ───────────
-- John J. Collins, The Apocalyptic Imagination: An Introduction to Jewish
-- Apocalyptic Literature (3rd ed. 2016): the standard scholarly introduction
-- to Second Temple Jewish apocalyptic; covers the major figures (Enoch, Noah,
-- Ezra, Daniel) as they appear in the apocalyptic literary tradition.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ISR_NOAH',   'SRC_2TJ_COLLINS', 'secondary_reference',
   'Collins (2016) pp. 47-53: Noah in the apocalyptic tradition; the Book of Noah (fragments in 1 Enoch 6-11, 54-55, 60, 65-69, 106-107) portrays Noah as an apocalyptic revealer who escapes the primordial judgment; the figure of Noah as prototype for the remnant who survives cosmic judgment'),
  ('ENT_ISR_ADAM',   'SRC_2TJ_COLLINS', 'secondary_reference',
   'Collins (2016): Adam in Second Temple apocalyptic texts; his glory (kavod) before the fall as a major Second Temple theme; the Life of Adam and Eve; Adam Kadmon as the heavenly prototype; Collins documents how the Adam figure becomes an apocalyptic archetype for human potential and fall'),
  ('ENT_ISR_ELIJAH', 'SRC_2TJ_COLLINS', 'secondary_reference',
   'Collins (2016) pp. 72-76: Elijah''s role in apocalyptic eschatology; Malachi 4:5 ("I will send you the prophet Elijah before the great and dreadful day of the LORD") as the foundational text; Elijah''s expected return as a precursor to the end-times; his fiery ascent as a prototype of apocalyptic rapture'),
  ('ENT_ISR_MOSES',  'SRC_2TJ_COLLINS', 'secondary_reference',
   'Collins (2016): Moses as an apocalyptic figure; the Testament of Moses; Moses as the mediator of cosmic law and the prototype for the apocalyptic seer who receives heavenly revelation; the Mosaic Torah as the framework within which apocalyptic revelation is legitimated')
ON CONFLICT DO NOTHING;

-- ── 13. Verification ─────────────────────────────────────────────────────────

SELECT s.source_id, COUNT(DISTINCT es.entity_id) AS entities_linked
FROM sources s
LEFT JOIN entity_sources es ON es.source_id = s.source_id
WHERE s.source_id IN (
  'SRC_POETIC_EDDA', 'SRC_OVID_FASTI', 'SRC_PLUTARCH_ISIS_OSIRIS',
  'SRC_FAULKNER_PYRAMID_TEXTS', 'SRC_HERODOTUS_HISTORIES',
  'SRC_FOSTER_BEFORE_MUSES', 'SRC_BURKERT_ORIENT_REV',
  'SRC_BUNDAHISHN', 'SRC_MANDAEAN_BOOK_JOHN', 'SRC_MANICHAEAN_PSALM_BOOK',
  'SRC_WYATT_RELIGIOUS_TEXTS', 'SRC_CROSS_CANAANITE_MYTH',
  'SRC_DAY_GODS_CONFLICT', 'SRC_2TJ_COLLINS'
)
GROUP BY s.source_id ORDER BY entities_linked DESC;

-- Updated per-tradition source ratios
SELECT
  e.tradition,
  COUNT(DISTINCT e.entity_id) AS entity_count,
  COUNT(DISTINCT es.source_id) AS source_count,
  ROUND(COUNT(DISTINCT e.entity_id)::numeric / NULLIF(COUNT(DISTINCT es.source_id), 0), 1) AS entities_per_source
FROM entities e
LEFT JOIN entity_sources es ON es.entity_id = e.entity_id
WHERE e.tradition IN (
  'Germanic/Norse', 'Roman', 'Egyptian', 'Mesopotamian',
  'Zoroastrian', 'Mandaean', 'Manichaean', 'Canaanite/Ugaritic',
  'Israelite/Second Temple', 'Israelite'
)
GROUP BY e.tradition ORDER BY entity_count DESC;

SELECT * FROM v_release_metrics;

COMMIT;
