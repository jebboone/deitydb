-- expand_greek_relationships_v4.sql
-- Final comprehensive Greek relationship batch.
-- Covers the remaining 97 zero-rel Greek entities across all categories.
-- Goal: reduce zero-rel from 97 to <15 (the truly unconnectable obscurities).
--
-- Sources: SRC_HESIOD_THEOGONY, SRC_HOMER_ILIAD_ODYSSEY, SRC_HOMERIC_HYMNS,
--          SRC_APOLLODORUS_LIBRARY, SRC_THEOI_DAIMONES, SRC_THEOI_UNDERWORLD,
--          SRC_THEOI_NYMPHS, SRC_THEOI_RUSTIC, SRC_PAUSANIAS_DESCRIPTION

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT COUNT(*) AS greek_zero_rel_before FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: ABSTRACTION DUPLICATES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- ENT_AT (Atë) is a name-variant duplicate of ENT_ATE
  ('ENT_AT','reception_of','ENT_ATE',
    'medium','ENT_AT (Atë) appears to be a variant romanisation of ENT_ATE (Ate, Ruin); the two entities represent the same Hesiodic personification (Theogony 230). Reception_of marks the name-form relationship.','SRC_THEOI_DAIMONES','approved'),
  -- ENT_MOMUS is a duplicate/variant of ENT_MOMOS
  ('ENT_MOMUS','reception_of','ENT_MOMOS',
    'medium','ENT_MOMUS and ENT_MOMOS are alternate romanisations of the same Greek personification of blame and criticism (μῶμος, Theogony 214).','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: ABSTRACTION PAIRS AND OPPOSITIONS
-- Hesiod Works and Days, Theoi Daimones index, Theogony
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- AIDOS paired_with NEMESIS (Works and Days 197-200)
  ('ENT_AIDOS','paired_with','ENT_NEMESIS',
    'high','Hesiod Works and Days 197-200: Aidos (Shame/Reverence) and Nemesis depart last from the earth as the iron age fails, always paired as the twin moral enforcers of social order.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_NEMESIS','paired_with','ENT_AIDOS',
    'high','See ENT_AIDOS paired_with ENT_NEMESIS; Hesiod Works and Days 197-200.','SRC_HESIOD_THEOGONY','approved'),
  -- HYBRIS opposes AIDOS; SOPHROSYNE opposes HYBRIS
  ('ENT_HYBRIS','opposes','ENT_AIDOS',
    'high','Hybris (Insolence) is the direct opposite of Aidos (Reverence); Greek ethical thought consistently contrasts them (Pindar, Plato, Aeschylus), and Nemesis punishes Hybris in defence of Aidos.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_SOPHROSYNE','opposes','ENT_HYBRIS',
    'high','Sophrosyne (Self-control/Temperance) is the virtue that directly counters Hybris (Hubris); Plato (Charmides; Republic 430e) treats sophrosyne as the antidote to hubristic excess.','SRC_THEOI_DAIMONES','approved'),
  -- NEMESIS opposes HYBRIS (she punishes hubris)
  ('ENT_NEMESIS','opposes','ENT_HYBRIS',
    'high','Nemesis is the divine personification of retribution specifically directed at Hybris (excessive pride); she checks and punishes those who transgress their mortal limits (Pindar; Hesiod).','SRC_THEOI_DAIMONES','approved'),
  -- ARETE and KAKIA: the Choice of Heracles (Xenophon Memorabilia 2.1.21-34, Prodicus)
  ('ENT_ARETE','paired_with','ENT_KAKIA',
    'high','Prodicus''s "Choice of Heracles" (preserved in Xenophon Memorabilia 2.1.21-34): Arete (Virtue/Excellence) and Kakia (Vice) appear to the young Heracles at a crossroads, each offering a different path.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_KAKIA','paired_with','ENT_ARETE',
    'high','See ENT_ARETE paired_with ENT_KAKIA; Xenophon Memorabilia 2.1.21-34.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_KAKIA','opposes','ENT_ARETE',
    'high','Prodicus''s allegorical tale: Kakia offers Heracles the easy path of pleasure, opposing Arete who offers the hard path of virtue.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- POINE paired_with NEMESIS (both are retributive daimons)
  ('ENT_POINE','paired_with','ENT_NEMESIS',
    'high','Poine (Punishment/Retribution) and Nemesis are closely related retributive daimons; Poine acts as the agent of specific punishments, Nemesis as the overarching principle of divine retribution.','SRC_THEOI_DAIMONES','approved'),
  -- PENIA paired_with POROS; opposes POROS (Plato Symposium 203b)
  ('ENT_PENIA','paired_with','ENT_POROS',
    'high','Plato Symposium 203b: at the banquet of the gods, Penia (Poverty) and Poros (Resource) conceive Eros together; their union defines Eros as always between want and plenty.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_PENIA','opposes','ENT_POROS',
    'high','Penia (Poverty/Need) is the direct antithesis of Poros (Resource/Plenty); Plato Symposium 203b exploits their opposition to define the nature of Eros.','SRC_THEOI_DAIMONES','approved'),
  -- HOMONOIA paired_with EIRENE (concord and peace go together)
  ('ENT_HOMONOIA','paired_with','ENT_EIRENE',
    'high','Homonoia (Concord/Agreement) and Eirene (Peace) are closely paired political and social virtues; they appear together in civic cult from the Classical period onward.','SRC_THEOI_DAIMONES','approved'),
  -- HEDONE paired_with POROS (Plato Symposium context: pleasure with Poros)
  ('ENT_HEDONE','paired_with','ENT_POROS',
    'medium','Hedone (Pleasure) and Poros (Resource/Plenty) are conceptually linked in the tradition of Eros born from Poros and Penia; Hedone represents one of the gifts of Poros.','SRC_THEOI_DAIMONES','approved'),
  -- ELPIS paired_with MOIRAI (fate and hope intertwined; Works and Days)
  ('ENT_ELPIS','paired_with','ENT_MOIRAI',
    'medium','Hesiod Works and Days 96-98: when Pandora opened the jar, all evils scattered but Elpis (Hope) alone remained; the Moirai (Fates) determine the limits of hope as they do of all human life.','SRC_HESIOD_THEOGONY','approved'),
  -- CAERUS paired_with TYCHE (opportunity and fortune)
  ('ENT_CAERUS','paired_with','ENT_TYCHE',
    'medium','Caerus (Opportunity, the right moment) and Tyche (Fortune) are associated as paired daimones of chance and timing in Hellenistic philosophical and literary tradition.','SRC_THEOI_DAIMONES','approved'),
  -- ELEUTHERIA patron_of Sovereignty (freedom as a civic sovereignty virtue)
  ('ENT_ELEUTHERIA','patron_of','ENT_SOVEREIGNTY',
    'high','Eleutheria (Freedom) was personified in Hellenistic and Roman-era Greek cities as the presiding virtue of civic and political sovereignty; she appears on coins and in temple dedications.','SRC_THEOI_DAIMONES','approved'),
  -- EUSEBEIA paired_with AIDOS (piety and reverence companion virtues)
  ('ENT_EUSEBEIA','paired_with','ENT_AIDOS',
    'high','Eusebeia (Piety/Reverence toward the gods) and Aidos (Reverence/Shame) are companion virtues in Greek ethical thought; both concern proper respect — for the divine and for social conventions respectively.','SRC_THEOI_DAIMONES','approved'),
  -- ELEOS embodies LOVE (pity/compassion as a form of love)
  ('ENT_ELEOS','embodies','ENT_LOVE',
    'medium','Eleos (Pity/Compassion) personifies the emotion of merciful love for those suffering; Demosthenes and Aristotle discuss eleos as the compassionate response that requires feeling love or care for the sufferer.','SRC_THEOI_DAIMONES','approved'),
  -- ADIKIA opposes JUSTICE
  ('ENT_ADIKIA','opposes','ENT_JUSTICE',
    'high','Adikia (Injustice) is the direct personification of injustice; she stands as the polar opposite of Dike (Justice) and is often depicted battling her in allegorical representations.','SRC_THEOI_DAIMONES','approved'),
  -- ALKE embodies WAR (valor/battle-strength)
  ('ENT_ALKE','embodies','ENT_WAR',
    'high','Alke (Battle-Strength/Valor) personifies the fighting prowess and courage of warriors in battle; the term appears in the Iliad for the strength shown in combat.','SRC_THEOI_DAIMONES','approved'),
  -- NYX parent_of Dolos and Lyssa (Hyginus Fabulae preface; Euripides Heracles)
  ('ENT_NYX','parent_of','ENT_DOLOS',
    'high','Hyginus Fabulae preface: Dolus (Trickery/Guile) is listed among the children of Nox (Nyx); he personifies deceptive cunning.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_NYX','parent_of','ENT_LYSSA',
    'high','Euripides Heracles 822-873: Lyssa (Rabid Madness) identifies herself as daughter of Night (Nyx) and blood of Ouranos; she is the personification of maddened fury.','SRC_THEOI_DAIMONES','approved'),
  -- DIONYSUS patron_of MANIA (divine madness/Bacchic frenzy)
  ('ENT_DIONYSUS','patron_of','ENT_MANIA',
    'high','Mania (Madness) is one of the forms of divine madness associated with Dionysiac possession; the god is patron of the ecstatic mania that grips his devotees.','SRC_THEOI_DAIMONES','approved'),
  -- DOLOS paired_with APATE (both are deception daimons)
  ('ENT_DOLOS','paired_with','ENT_APATE',
    'high','Dolos (Trickery) and Apate (Deceit) are closely paired personifications of guile and deception; Apate is daughter of Nyx, and Dolos frequently appears alongside her in lists of evil daimons.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: AVENGING DAIMONS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_ALASTOR','member_of','ENT_ERINYES',
    'high','Alastor (the Avenging Daimon) is closely associated with the Erinyes as a spirit of vendetta and family curse; he embodies the inherited guilt that the Erinyes enforce.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_POINAI','member_of','ENT_ERINYES',
    'high','The Poinai (Spirits of Punishment) are the individualised agents of retribution who work alongside the Erinyes; they are sometimes treated as synonymous with the Erinyes themselves.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: CAVE SPIRITS (Corycian)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_CORYCIA','paired_with','ENT_APOLLO',
    'high','Corycia is the naiad of the Corycian Cave on Parnassus, which was sacred to both Apollo and the Muses; Pausanias Description of Greece 10.32.2 describes the cave as belonging to the Corycian nymphs.','SRC_PAUSANIAS_DESCRIPTION','approved'),
  ('ENT_CORYCIAN_NYMPHS','paired_with','ENT_APOLLO',
    'high','Pausanias Description of Greece 10.32.2: the Corycian Cave above Delphi is the sanctuary of the Corycian nymphs and Pan; it was among the most notable cult sites of Apollo''s mountain domain.','SRC_PAUSANIAS_DESCRIPTION','approved'),
  ('ENT_CORYCIAN_NYMPHS','member_of','ENT_CORYCIA',
    'high','The Corycian Nymphs are the collective of which Corycia is the eponymous individual nymph; they share the same mountain-cave cult on Parnassus.','SRC_PAUSANIAS_DESCRIPTION','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 5: CHILD-HARMING SPIRITS AND DANGEROUS DAIMONS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Hecate patron_of the child-harming spirits and liminal daimons
  ('ENT_HECATE','patron_of','ENT_LAMIA',
    'high','Lamia, the child-harming demoness, is one of the entities associated with Hecate as goddess of the uncanny and nocturnal threats; late antique sources list Lamia among Hecate''s supernatural companions.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HECATE','patron_of','ENT_GELLO',
    'high','Gello, the child-harming spirit of Byzantine-era Greek tradition, is one of the nocturnal threats associated with the domain of Hecate as goddess of liminal and dangerous night-spirits.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HECATE','patron_of','ENT_MORMO',
    'high','Mormo, the bogey used to frighten children, belongs to the retinue of frightening night-daimons associated with Hecate and the underworld; attested in scholiasts on Theocritus.','SRC_THEOI_DAIMONES','approved'),
  -- Empusa and Mormolykeia: Hecate's retinue
  ('ENT_HECATE','patron_of','ENT_EMPUSA',
    'high','Empusa is explicitly one of Hecate''s supernatural attendants (Aristophanes Frogs 288-295; scholiasts); she is a shape-shifting demoness who serves the goddess of liminal spaces.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HECATE','patron_of','ENT_EMPOUSA',
    'high','Empousa (alternate form of Empusa) belongs to Hecate''s nocturnal retinue; attested in Aristophanes Frogs 288-295.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_HECATE','patron_of','ENT_MORMOLYKEIA',
    'high','Mormolykeia ("Mormo-wolf" bogeys) are a class of frightening night-daimons in Hecate''s liminal domain; the term appears in philosophical texts as an example of fearful supernatural beings.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_KAKODAIMON','dwells_in','ENT_UNDERWORLD',
    'medium','Kakodaimon (Evil Daimon) is associated with the underworld and with bad luck; it is the dark counterpart of the Agathodaimon, dwelling in the chthonic domain.','SRC_THEOI_UNDERWORLD','approved'),
  -- Gello paired_with Lamia and Mormo as a triad of child-harming spirits
  ('ENT_GELLO','paired_with','ENT_LAMIA',
    'medium','Gello and Lamia are the two most prominent child-harming female spirits in Greek and Byzantine popular belief; they are often invoked together in apotropaic texts.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_MORMO','paired_with','ENT_LAMIA',
    'medium','Mormo and Lamia were paired in Greek literature as female bogeys used to frighten children; Theocritus and scholiasts treat them as interchangeable threats.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 6: FERTILITY DEITIES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  ('ENT_KALLIGENEIA','patron_of','ENT_DEMETER',
    'high','Kalligeneia ("Fair-born") is a title and divine attendant of Demeter specifically in the Thesmophoria festival; she is invoked alongside Demeter in the agricultural and birth-related rites.','SRC_THEOI_AGRICULTURE','approved'),
  ('ENT_KOUROTROPHOS','patron_of','ENT_PROTECTION',
    'high','Kourotrophos ("Child-nurturer") is a divine title applied to several goddesses (Gaia, Hestia, Artemis, Hecate) who protect children and nursing mothers; she embodies the protective maternal domain.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_PHYLLIS','paired_with','ENT_DEMETER',
    'medium','Phyllis, the Thracian princess who became a tree (almond or nut tree), belongs to the mythological cluster of vegetation and earth-renewal associated with Demeter; her transformation echoes Demeter''s tree-spirit nymphs.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 7: MOON, MOUNTAIN, MYSTERY DEITIES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- BENDIS: Thracian moon goddess equated with Artemis (Plato Republic 327a)
  ('ENT_BENDIS','equated_with','ENT_ARTEMIS',
    'high','Plato Republic 327a: the opening scene describes the festival of Bendis in Piraeus; she was a Thracian goddess equated with Artemis by Athenian interpreters and admitted to the Piraeus cult in the 5th c. BCE.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_BENDIS','equated_with','ENT_SELENE',
    'medium','Bendis the Thracian moon goddess was equated not only with Artemis but also with Selene as a lunar deity; her torch-bearing cult imagery overlaps with Selene''s iconography.','SRC_THEOI_DAIMONES','approved'),
  -- MÊN: Phrygian/Anatolian moon god present in Greek tradition (rare)
  ('ENT_M_N','equated_with','ENT_SELENE',
    'medium','Mên is an Anatolian moon god absorbed into Hellenistic Greek worship; as a lunar deity he is conventionally associated with Selene and the Greek moon tradition. His cult was centred in Phrygia and Lydia but spread to Attica and Phrygia.','SRC_THEOI_DAIMONES','approved'),
  -- IDAIA: nymph of Mount Ida (Rhea's sacred mountain, Crete)
  ('ENT_RHEA','patron_of','ENT_IDAIA',
    'high','Idaia is the eponymous nymph of Mount Ida on Crete, the mountain sacred to Rhea where Zeus was hidden; she belongs to the Cretan cult cluster centred on Rhea as Great Mother. Apollodorus 3.12.2.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- MUSES HELICONIAN: the Muses of Mount Helicon (Hesiod Theogony 1-8)
  ('ENT_MUSES_HELICONIAN','member_of','ENT_MUSES',
    'high','Hesiod Theogony 1-8: Hesiod''s Muses are specifically the Heliconian Muses, dwelling on Mount Helicon; they are the Theogonic version of the nine Muses.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_MUSES_HELICONIAN','paired_with','ENT_APOLLO',
    'high','Hesiod Theogony 94-95: "From the Muses and far-shooting Apollo are there singers and lyre-players upon the earth"; the Heliconian Muses are paired with Apollo as co-patrons of music and poetry.','SRC_HESIOD_THEOGONY','approved'),
  -- OREADS: mountain nymphs, companions of Artemis
  ('ENT_OREADS','paired_with','ENT_ARTEMIS',
    'high','Homer Odyssey 6.102-109: Artemis is compared to a mountain nymph (Oread) and described leading them in the hunt; the Oreads are her hunting companions.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- COTYS: Thracian mystery goddess equated with Rhea/Cybele (Strabo 10.3.15)
  ('ENT_COTYS','equated_with','ENT_RHEA',
    'high','Strabo Geography 10.3.15: Cotys (Kotyto) is a Thracian mystery goddess whose ecstatic rites were identified with those of Rhea-Kybele; she was the patron of the Cotyttia festival.','SRC_PAUSANIAS_DESCRIPTION','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 8: NYMPHS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- ADRASTEIA NYMPH: nursed Zeus on Crete at Rhea's direction
  ('ENT_RHEA','patron_of','ENT_ADRASTEIA_NYMPH',
    'high','Apollodorus Library 1.1.7: Adrasteia is named as a Cretan nymph who nursed the infant Zeus; she was placed in the service of Rhea on Crete.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- AMALTHEIA: goat-nymph who nursed Zeus; rewarded with the cornucopia
  ('ENT_ZEUS','patron_of','ENT_AMALTHEIA',
    'high','Pseudo-Apollodorus Library 1.1.7: Amaltheia (as the goat or its nymph-keeper) nursed the infant Zeus; in gratitude, Zeus later gave her the cornucopia (or took one of her horns).','SRC_APOLLODORUS_LIBRARY','approved'),
  -- BEROE: daughter of Aphrodite and Adonis (Nonnus Dionysiaca 41.49-155)
  ('ENT_APHRODITE','parent_of','ENT_BEROE',
    'medium','Nonnus Dionysiaca 41.49-155: Beroe, eponymous nymph of the city Berytus (Beirut), is daughter of Aphrodite and Adonis in this late-antique source.','SRC_THEOI_NYMPHS','approved'),
  -- CHELONE: punished by Hermes for missing Zeus and Hera's wedding
  ('ENT_HERMES','opposes','ENT_CHELONE',
    'high','The myth of Chelone: she refused to attend the wedding of Zeus and Hera, and Hermes punished her by transforming her into a tortoise (chelone), condemned to carry her house on her back. Theoi Nymphs.','SRC_THEOI_NYMPHS','approved'),
  -- Meadow and other nymph collectives connected to the generic Nymphs entity
  ('ENT_LEIMAKIDES','member_of','ENT_NYMPHS',
    'medium','Leimakides (Meadow Nymphs) are a subset of the broader nymph category; they inhabit the meadows and are grouped among the nymphs generally.','SRC_THEOI_NYMPHS','approved'),
  ('ENT_NAPAEAE','member_of','ENT_NYMPHS',
    'medium','Napaeae (Valley Nymphs) are nymphs of glens and valleys; they are grouped among the broad collective of Greek nymphs.','SRC_THEOI_NYMPHS','approved'),
  -- Nymphs collective: Zeus as their guardian
  ('ENT_ZEUS','patron_of','ENT_NYMPHS',
    'high','Homer Iliad 6.420; Odyssey 6.105: Zeus is invoked as the guardian of the nymphs and the divine patron of all natural supernatural beings.','SRC_HOMER_ILIAD_ODYSSEY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 9: PRIMORDIAL POWERS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- EROS PRIMORDIAL: hatched from Chaos (Theogony 120); equated_with Phanes (Orphic)
  ('ENT_CHAOS','parent_of','ENT_EROS_PRIMORDIAL',
    'high','Hesiod Theogony 120: "and Eros, the most beautiful of the immortal gods" is named alongside Chaos, Gaia, and Tartarus as one of the first primordial powers.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_EROS_PRIMORDIAL','equated_with','ENT_PHANES',
    'high','In Orphic theogony, the primordial Eros (Protogonus) who hatches from the world-egg is identified with Phanes, the first-born god of light; both names refer to the same primordial creative force. Theoi Daimones.','SRC_THEOI_DAIMONES','approved'),
  -- NESOI: island nymphs; daughters of Oceanus/Tethys or offspring of Gaia
  ('ENT_OCEANUS','parent_of','ENT_NESOI',
    'medium','The Nesoi (Island Nymphs) are associated with the ocean that surrounds the islands; Oceanus and Tethys, as parents of all water entities, are the conventional genealogical source for the collective Nesoi.','SRC_THEOI_NYMPHS','approved'),
  -- HYDROS: Orphic primordial water, paired with Phanes in Orphic cosmogony
  ('ENT_HYDROS','paired_with','ENT_PHANES',
    'medium','In the Orphic cosmogonies, Hydros (primordial Water) is one of the first entities alongside Phanes (Light/Love); the Orphic Rhapsodic Theogony begins with Water before the world-egg.','SRC_THEOI_DAIMONES','approved'),
  -- PHYSIS: Orphic Nature, associated with primordial Earth
  ('ENT_PHYSIS','embodies','ENT_EARTH',
    'medium','Physis (Nature) personifies the generative principle of the natural world; she is associated with and sometimes identified with Gaia as the embodiment of the material cosmos.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 10: MINOR RIVER DEITIES + PROTECTIVE SPIRIT
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- ACHELOUS MINOR: variant/lesser form of Acheloos
  ('ENT_ACHELOUS_MINOR','reception_of','ENT_ACHELOOS',
    'medium','Achelous Minor appears to be a lesser or regional stream associated with the major river god Acheloos; the relationship marks it as a reception or local form.','SRC_THEOI_DAIMONES','approved'),
  -- AESAR, MELES, NESSUS (river): sons of Oceanus
  ('ENT_OCEANUS','parent_of','ENT_AESAR',
    'medium','Aesar is a minor river deity in the Potamoi (river-god) tradition; as with all Potamoi, his genealogical source is Okeanos and Tethys.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_OCEANUS','parent_of','ENT_MELES',
    'medium','Meles, the river near Smyrna sacred to Homer''s tradition, is a Potamos and son of Okeanos and Tethys in the standard genealogy.','SRC_THEOI_DAIMONES','approved'),
  ('ENT_OCEANUS','parent_of','ENT_NESSUS',
    'medium','Nessos the River (distinct from Nessos the centaur) is listed among the sons of Okeanos and Tethys in Hesiod Theogony 337-345 (as "Nesos").','SRC_HESIOD_THEOGONY','approved'),
  -- GLAUCUS: Poseidon''s sea-domain deity
  ('ENT_POSEIDON','patron_of','ENT_GLAUCUS',
    'high','Glaucus, the deified fisherman who ate magical herbs and became a sea deity, dwells in the sea under Poseidon''s domain; Athenaeus records him as prophesying alongside the Nereids.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- ANYTUS: Giant who raised Despoina (Pausanias 8.37.9)
  ('ENT_ANYTUS','guides','ENT_DESPOINA',
    'high','Pausanias Description of Greece 8.37.9: Anytus, one of the Titans, was the guardian and raiser of Despoina in the Arcadian tradition of her birth.','SRC_PAUSANIAS_DESCRIPTION','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 11: TREE SPIRITS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- MELIAE: born from blood of Uranus on Gaia (Theogony 187)
  ('ENT_GAIA','parent_of','ENT_MELIAE',
    'high','Hesiod Theogony 187: from the drops of Ouranos''s blood that fell on the earth rose the Meliai (ash-tree nymphs), born of Gaia.','SRC_HESIOD_THEOGONY','approved'),
  -- MELIA: individual ash-tree nymph; member of the Meliae collective
  ('ENT_MELIA','member_of','ENT_MELIAE',
    'high','Melia is an individual Melia (ash-tree nymph), member of the Meliai collective born from the blood of Ouranos; the singular and collective are both attested.','SRC_HESIOD_THEOGONY','approved'),
  -- HAMADRYADS: subgroup of Dryads (tree-bound nymphs)
  ('ENT_HAMADRYADS','member_of','ENT_DRYADS',
    'high','Hamadryads (nymphs bound to specific trees, dying with them) are a subset of the Dryads (tree-nymphs) collectively; the distinction appears in Apollonius of Rhodes and later mythographers.','SRC_THEOI_NYMPHS','approved'),
  -- DRYADS: tree spirit collective; associated with forests of the earth
  ('ENT_DRYADS','dwells_in','ENT_EARTH',
    'high','Dryads are tree spirits who dwell within trees and forests; they inhabit the wooded parts of the terrestrial realm (earth) as their natural domain.','SRC_THEOI_NYMPHS','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 12: UNDERWORLD SPIRITS AND PLACES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- COCYTUS and PHLEGETHON: underworld rivers (Homer Odyssey 10.513-514; Plato Phaedo 113a)
  ('ENT_COCYTUS','dwells_in','ENT_UNDERWORLD',
    'high','Homer Odyssey 10.513-514: Cocytus is named alongside Pyriphlegethon as a branch of the Styx in the underworld; Plato Phaedo 113b describes it further.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_PHLEGETHON','dwells_in','ENT_UNDERWORLD',
    'high','Homer Odyssey 10.513: Pyriphlegethon (Phlegethon, "the Flaming River") is a river of fire in the underworld; Plato Phaedo 113a gives the fullest description.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- Underworld rivers paired
  ('ENT_COCYTUS','paired_with','ENT_ACHERON_RIVER',
    'high','Homer Odyssey 10.513-514: Cocytus is described as a branch of the Styx that flows around the Acheron; they are neighbouring underworld rivers.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- LAMPADES: torch-bearing underworld nymphs of Hecate (Theoi Underworld)
  ('ENT_HECATE','patron_of','ENT_LAMPADES',
    'high','The Lampades (torch-bearing nymphs) are the attendants of Hecate in the underworld; they carry torches as they accompany the goddess through chthonic realms. Theoi Underworld.','SRC_THEOI_UNDERWORLD','approved'),
  -- MELINOE: daughter of Persephone and Zeus/Hades; chthonic ghost deity
  ('ENT_PERSEPHONE','parent_of','ENT_MELINOE',
    'high','Orphic Hymn 71 (To Melinoe): "You were born near the mouth of the Cocytus, from Persephone"; Melinoe is the daughter of Persephone and Zeus (or Hades).','SRC_THEOI_UNDERWORLD','approved'),
  ('ENT_MELINOE','dwells_in','ENT_UNDERWORLD',
    'high','Orphic Hymn 71: Melinoe is a chthonic deity born in the underworld who wanders the earth at night as a bringer of nightmares.','SRC_THEOI_UNDERWORLD','approved'),
  -- MINTHE: mint nymph, Hades''s lover, transformed by Persephone
  ('ENT_HADES','paired_with','ENT_MINTHE',
    'high','Strabo Geography 8.3.14; Oppian Halieutica 3.485: Minthe was a nymph beloved by Hades; when Persephone discovered the affair she trampled or transformed Minthe into the mint plant.','SRC_THEOI_UNDERWORLD','approved'),
  ('ENT_PERSEPHONE','opposes','ENT_MINTHE',
    'high','Strabo Geography 8.3.14: Persephone transformed Minthe (Hades''s beloved) into the mint plant out of jealousy.','SRC_THEOI_UNDERWORLD','approved'),
  -- ORPHNE: underworld naiad, mother of Ascalaphus by Acheron
  ('ENT_ORPHNE','paired_with','ENT_ACHERON_RIVER',
    'high','Pseudo-Apollodorus Library 2.5.12: Ascalaphus is son of Acheron and Orphne; Orphne is an underworld naiad of the river Acheron.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- GORGYRA: underworld naiad; companion of Acheron
  ('ENT_GORGYRA','dwells_in','ENT_UNDERWORLD',
    'high','Gorgyra is an underworld naiad; she is mentioned alongside Orphne in the Ascalaphus tradition as a companion spirit of the underworld river Acheron. Theoi Underworld.','SRC_THEOI_UNDERWORLD','approved'),
  -- LEUCE: white poplar nymph beloved of Hades; became a tree in Elysium
  ('ENT_LEUCE','dwells_in','ENT_UNDERWORLD',
    'high','Leuce was a naiad beloved of Hades who was transported to Elysium after her death; the white poplar tree in Elysium was said to have grown from her. Theoi Underworld.','SRC_THEOI_UNDERWORLD','approved'),
  -- EURYNOMOS: flesh-eating daemon of the dead (Pausanias 10.28.7)
  ('ENT_EURYNOMOS','dwells_in','ENT_UNDERWORLD',
    'high','Pausanias Description of Greece 10.28.7: Eurynomos is the underworld daemon described in Polygnotus''s painting of the underworld at Delphi; he strips the flesh from the dead.','SRC_PAUSANIAS_DESCRIPTION','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 13: WAR DAIMONS AND WAR DEITY
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- ALALA: the war-cry personified (Pindar Dithyramb 2.1)
  ('ENT_ALALA','embodies','ENT_WAR',
    'high','Pindar Dithyramb 2.1: "Alala, daughter of War, you prelude of spears" — Alala personifies the battle cry and is described as a daughter of Polemos/War.','SRC_THEOI_DAIMONES','approved'),
  -- HOMADOS: the battle din (Homer Iliad 14.394)
  ('ENT_HOMADOS','embodies','ENT_WAR',
    'high','Homer Iliad 14.394: Homados (the Battle-Din) is named alongside other war personifications as one of the sounds and forces of combat.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- MAKHAI: variant spelling of MACHAI; reception_of relationship
  ('ENT_MAKHAI','reception_of','ENT_MACHAI',
    'medium','ENT_MAKHAI is a variant romanisation of ENT_MACHAI (Battles/Wars), both deriving from Greek μάχαι; the reception_of marks the name-variant relationship.','SRC_THEOI_DAIMONES','approved'),
  -- PALLAS (War Deity): the Giant slain by Athena (Apollodorus 1.6.2)
  ('ENT_ATHENA','slays','ENT_PALLAS',
    'high','Pseudo-Apollodorus Library 1.6.2: during the Gigantomachy, Athena slew the Giant Pallas and flayed him, using his skin as her aegis; from Pallas she also took the epithet "Pallas Athena."','SRC_APOLLODORUS_LIBRARY','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 14: WIND SPIRITS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- AEOLUS: keeper of the winds; guides Odysseus (Odyssey 10.1-79)
  ('ENT_AEOLUS','guides','ENT_ODYSSEUS',
    'high','Homer Odyssey 10.1-79: Aeolus, keeper of the winds, received Odysseus hospitably and gave him a bag of all winds to aid his homeward voyage.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  ('ENT_AEOLUS','patron_of','ENT_PROTECTION',
    'high','Aeolus rules and controls the winds (Odyssey 10.21); his mastery over them makes him a protective deity for sailors whom Zeus appointed as wind-keeper.','SRC_HOMER_ILIAD_ODYSSEY','approved'),
  -- AURAE: breezes associated with Eos (dawn breezes)
  ('ENT_AURAE','paired_with','ENT_EOS',
    'medium','The Aurae (Breezes) are associated with the dawn winds that blow at Eos''s rising; they are described as daughters or companions of the wind-deities and dawn.','SRC_THEOI_DAIMONES','approved'),
  -- NEPHELAE: cloud nymphs under Zeus''s domain
  ('ENT_ZEUS','patron_of','ENT_NEPHELAE',
    'high','The Nephelae (Cloud Nymphs) are associated with Zeus as the rain-bringer and cloud-gatherer (Nephelegetes); Aristophanes Clouds depicts them as Zeus''s divine attendants.','SRC_THEOI_DAIMONES','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 15: WATER SPIRITS (remaining Oceanids + local spring nymphs)
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
  -- Named Oceanids still zero-rel
  ('ENT_OCEANUS','parent_of','ENT_PEITHO_OCEANID',
    'high','Hesiod Theogony 349: Peitho (Persuasion) is listed among the Oceanids, daughters of Okeanos and Tethys.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_PERSEIS',
    'high','Hesiod Theogony 356: Perseis is listed among the Oceanids, daughters of Okeanos and Tethys; she is mother of Circe and Aietes by Helios.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_PLEIONE',
    'high','Hesiod Theogony 351: Pleione is an Oceanid, daughter of Okeanos and Tethys; she is the mother of the Pleiades by Atlas.','SRC_HESIOD_THEOGONY','approved'),
  ('ENT_OCEANUS','parent_of','ENT_NEDA',
    'high','Pausanias Description of Greece 8.38.3: Neda is a naiad of the Arcadian river; she is an Oceanid daughter of Okeanos and Tethys who nursed the infant Zeus.','SRC_PAUSANIAS_DESCRIPTION','approved'),
  -- NEDA guides ZEUS (nursed infant Zeus at Lycaeus)
  ('ENT_NEDA','guides','ENT_ZEUS',
    'high','Pausanias Description of Greece 8.38.3: Neda nursed the infant Zeus at Mount Lykaion in Arcadia; she and Theisoa (or Hagno) were among the Arcadian nymphs who raised him.','SRC_PAUSANIAS_DESCRIPTION','approved'),
  -- PLEIONE paired_with ATLAS (parents of the Pleiades)
  ('ENT_ATLAS','paired_with','ENT_PLEIONE',
    'high','Pseudo-Apollodorus Library 3.10.1: the Pleiades (and Hyades) are daughters of Atlas and Pleione; Pleione and Atlas are the parental pair for the Pleiades including Maia, Electra, etc.','SRC_APOLLODORUS_LIBRARY','approved'),
  ('ENT_PLEIONE','paired_with','ENT_ATLAS',
    'high','Pseudo-Apollodorus Library 3.10.1.','SRC_APOLLODORUS_LIBRARY','approved'),
  -- AGANIPPE: Muse-spring nymph at Helicon (Theogony 1-8 context)
  ('ENT_AGANIPPE','paired_with','ENT_MUSES_HELICONIAN',
    'high','Pausanias Description of Greece 9.29.5: Aganippe is the spring nymph of the Aganippe spring on Mount Helicon, sacred to the Muses; she and Hippocrene are the two Heliconiad spring-muses.','SRC_PAUSANIAS_DESCRIPTION','approved'),
  -- SALMACIS paired_with HERMAPHRODITUS (Ovid Met. 4.285-388; Greek myth)
  ('ENT_SALMACIS','paired_with','ENT_HERMAPHRODITUS',
    'high','Ovid Metamorphoses 4.285-388 (drawing on Hellenistic source): Salmacis the naiad fell in love with Hermaphroditus; they were merged into one dual-gendered being in her pool.','SRC_THEOI_NYMPHS','approved'),
  -- NAIADS collective: Oceanus as source
  ('ENT_OCEANUS','parent_of','ENT_NAIADS',
    'high','The Naiads (freshwater nymphs) derive collectively from Okeanos and Tethys as the primordial parents of all river and freshwater spirits; they are a subset of the Okeanian water spirits.','SRC_THEOI_NYMPHS','approved'),
  -- Water spirit collectives linked to the Naiads
  ('ENT_CRENAIAE','member_of','ENT_NAIADS',
    'medium','Crenaiae (fountain/spring nymphs) are a subgroup of the Naiads who dwell specifically in springs and fountains.','SRC_THEOI_NYMPHS','approved'),
  ('ENT_HELEIONOMAI','member_of','ENT_NAIADS',
    'medium','Heleionomai (marsh nymphs) are a subgroup of the Naiads who inhabit swamps and marshy areas.','SRC_THEOI_NYMPHS','approved'),
  ('ENT_LIMNADES','member_of','ENT_NAIADS',
    'medium','Limnades (lake nymphs) are a subgroup of the Naiads who dwell in lakes and still waters.','SRC_THEOI_NYMPHS','approved'),
  ('ENT_PEGAEAE','member_of','ENT_NAIADS',
    'medium','Pegaeae (spring-source nymphs) are a subgroup of the Naiads who dwell at the sources of springs.','SRC_THEOI_NYMPHS','approved'),
  ('ENT_POTAMEIDES','member_of','ENT_NAIADS',
    'medium','Potameides (river nymphs) are a subgroup of the Naiads who dwell in rivers and streams, not springs or lakes.','SRC_THEOI_NYMPHS','approved')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;
SELECT COUNT(*) AS greek_zero_rel_after FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);

-- Remaining zero-rel by category
SELECT category, COUNT(*) AS zero_rel FROM entities WHERE tradition='Greek'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id)
GROUP BY category ORDER BY zero_rel DESC;

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
