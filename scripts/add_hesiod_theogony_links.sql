-- scripts/add_hesiod_theogony_links.sql
-- Hesiod Theogony (and Works and Days) linkage pass
--
-- SRC_HESIOD_THEOGONY was previously linked only to 39 entities, all of them
-- either cross-traditional personified abstractions or just two named Greek entities
-- (ENT_KRONOS and ENT_OURANOS, which were linked when created as chain targets in
-- earlier scripts). The Theogony is the foundational genealogical text for the entire
-- Greek pantheon — it gives the creation narrative, the Titanomachy, the births of all
-- the Olympians, and the catalog of Nyx's and Eris's offspring. All 89 named Greek
-- entities below get primary_attestation here.
--
-- SRC_HESIOD_THEOGONY covers both texts: the title in the sources table is
-- "Hesiod, Theogony and Works and Days" — so Works and Days entities (Elpis,
-- Aidos) are also linked here with their Works and Days passage noted.
--
-- Theogony structure used for source_notes:
--   116-232   First Principles and their offspring
--   233-264   Sea deities (children of Pontus)
--   337-406   Oceanids and Titans' offspring
--   411-452   Hecate
--   453-1018  Divine births: Olympians and later generations
-- Works and Days:
--   47-105    Prometheus / Pandora
--   106-201   Five Ages of Man; departure of Aidos and Nemesis

BEGIN;

-- ── Section 1: First Principles (Protogenoi) ─────────────────────────────────
-- Theogony 116-132: the First Entities and Gaia's first offspring
-- Theogony 116: "First of all Chaos came to be"
-- These are the foundational entities for whom the Theogony provides the ONLY or
-- PRIMARY ancient narrative account. Many are also named in Homer but without
-- the cosmological genealogical context Hesiod provides.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_CHAOS',         'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 116: "First of all Chaos came to be (γένετ᾽)" — the formless void that precedes the cosmos; Hesiod is the earliest surviving text that names Chaos as a cosmological entity and makes it the origin of all things; the primary ancient source for Chaos as a named primordial'),
  ('ENT_GAIA',          'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 117-122: "broad-bosomed Earth (Gaia), ever the unshaken foundation of all" emerges after Chaos; Gaia is mother of Ouranos, Pontus, and the mountains (Ourea); she later conspires with Kronos against Ouranos and with Zeus against the Titans; Theogony is her primary ancient narrative framework'),
  ('ENT_TARTARUS',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 119: Tartarus emerges from Chaos as the third primordial entity; Theogony 720-819 provides the most detailed ancient description of Tartarus as a cosmological place — the abyss beneath Hades where the Titans are imprisoned, bounded by bronze gates, where Styx has her hall, and where Typhon was cast after his defeat'),
  ('ENT_EROS_PRIMORDIAL','SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 120-122: Eros emerges as the fourth primordial — "the fairest of the immortal gods, who slackens the limbs and overcomes the mind and wise counsels of all gods and all men within them" — the generative principle enabling cosmic reproduction; Hesiod is the primary ancient text for Eros as a cosmological first-principle distinct from the later Aphrodite-attendant Eros'),
  ('ENT_EREBUS',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 123: from Chaos came Erebus and dark Night (Nyx); from Erebus and Night came Aether and Hemera; Hesiod establishes Erebus as a primordial entity, the primordial darkness preceding light, and the parent of Aether and Day alongside Nyx'),
  ('ENT_NYX',           'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 123-125, 211-225: Nyx (Night) emerges from Chaos alongside Erebus; Hesiod gives Nyx an extensive genealogy (Theogony 211-225): she bore Moros, Ker, Thanatos, Hypnos, the Oneiroi, Momos, Oizys, the Hesperides, the Moirai, Nemesis, Deceit, Love, Old Age, and Eris; the most important ancient account of Nyx''s divine progeny'),
  ('ENT_AETHER',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 124-125: Aether (the upper, bright air) is born of Erebus and Nyx; the bright uppermost layer of the cosmos above the clouds; Hesiod is the primary ancient text establishing Aether as a named cosmological entity distinct from aer (ordinary air)'),
  ('ENT_HEMERA',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 124-125: Hemera (Day) is born of Erebus and Nyx, paired with Aether; she shares a threshold with her mother Nyx — when one leaves, the other returns; Theogony 748-757 elaborates this night/day exchange at the edge of the world; Hesiod is the primary ancient source for Hemera as a personified divine entity'),
  ('ENT_PONTUS',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 132: Gaia bore Pontus (the sea) without union — he is the barren sea; he is then paired with Gaia to produce Nereus, Thaumas, Phorcys, Ceto, and Eurybia (Theogony 233-239); Hesiod is the primary ancient source establishing Pontus as a named primordial sea deity distinct from Oceanus'),
  ('ENT_OUREA',         'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 129-131: Gaia bore the Ourea (Mountains) — "the divine habitation of the Nymphs who dwell in the wooded mountain vales"; Hesiod is the primary ancient source for the Ourea as a collective of divine mountain entities; they are born of Gaia alone, without a partner'),
  ('ENT_THALASSA',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 233: Thalassa (the sea-surface) is named as the mother of Phorcys and Ceto in the Theogony''s genealogical system: "Pontus begat old Nereus... after that Thaumas and proud Phorcys, born of the same mother, Ceto with the fair cheeks and Eurybia" — Thalassa provides the maternal sea-element alongside Pontus''s paternal sea-element; primary source for Thalassa as a named entity'),
  ('ENT_URANUS',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 126-128: Gaia bore Ouranos/Uranus (the starry Sky) to cover her on every side — "so that there should be for the blessed gods a seat for ever secure"; Theogony 154-210: his castration by Kronos at Gaia''s instigation; his severed genitals produce Aphrodite, the Erinyes, and the Giants; the primary and most extensive ancient narrative of Ouranos'),
  -- Nyx's children who are Protogenoi type in the DB
  ('ENT_MOROS',         'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 211: Moros (Doom/Fate) is the first-born child of Nyx — "hateful Night bore Moros and black Ker and Death and Sleep" — the dread inevitability of death that even the gods fear; Hesiod is the primary ancient source for Moros as a named primordial entity distinct from the Moirai'),
  ('ENT_KER',           'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 211-212: Ker (Violent Death, the death-fate-spirit) is born of Nyx alongside Moros; Theogony 217: the Keres ("the grim ones who pursue men") are also daughters of Night; Hesiod provides the primary ancient genealogical placement of Ker as a personified form of violent death as opposed to the peaceful death of Thanatos'),
  ('ENT_MOIRAI',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 217-220: the three Moirai (Clotho, Lachesis, and Atropos — "who give mortal men evil and good to have") are daughters of Night in the first account; Theogony 901-906 gives a second account: born of Zeus and Themis; Hesiod is the foundational text for the Moirai as three named goddesses of destiny; the first account (as daughters of Nyx) places them outside divine authority, the second subordinates them to Zeus'),
  ('ENT_SELENE',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 371-374: Selene (the Moon) is the daughter of the Titan Hyperion and Theia; "Hyperion lay with famous Theia and she conceived and bore great Helios and bright Selene and Eos" — the primary ancient genealogical account of Selene as a Titaness/second-generation primordial'),
  ('ENT_HELIOS',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 371: Helios (the Sun) is the son of Hyperion and Theia — the primary ancient genealogical account establishing Helios as a second-generation Titan/primordial, son of the Titan of radiant light (Hyperion); Hesiod''s genealogy is the foundational framework for understanding Helios''s divine status'),
  ('ENT_EOS',           'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 371-374, 378-382: Eos (Dawn) is daughter of Hyperion and Theia; she bore to Astraeus the winds (Boreas, Zephyros, Notus) and the morning stars; "rosy-fingered Eos" whose genealogy in the Theogony establishes her as a Titaness of the second generation; the primary ancient source for Eos''s cosmic genealogical position')
ON CONFLICT DO NOTHING;

-- ── Section 2: Named offspring of Nyx — daimones ─────────────────────────────
-- Theogony 211-225: the children of Night (Nyx) as named divine entities;
-- many of these also appear in Homer but the Theogony is their primary genealogical placement

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_THANATOS',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 212: Thanatos (Death) is a son of Nyx, brother of Hypnos; "hateful Night bore... Death and Sleep"; Theogony 756-766: Thanatos and Hypnos share a house at the edge of the world; Hesiod is the foundational text for Thanatos as a personified entity with specific genealogical placement'),
  ('ENT_HYPNOS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 212: Hypnos (Sleep) is a son of Nyx, twin of Thanatos; Theogony 756-766: "there the son of Night has his house, Sleep, whom Thanatos his brother knows"; Hesiod establishes the twin Sleep/Death pair as sons of Night with their domain at the world''s edge'),
  ('ENT_ERIS',       'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 224-232: Eris (Strife) is a daughter of Night; she bears the catalog of evils (Ponos, Lethe, Limos, Algea, Hysminai, Makhai, Phonoi, Androktasiai, Neikea, Pseudologoi, Amphilogiai, Dysnomia, Ate, and Horkos); Hesiod gives Eris her most extensive ancient theological treatment as the mother of all strife-related evils'),
  ('ENT_NEMESIS',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 223: Nemesis is a daughter of Night — "baleful Nemesis to afflict mortal men"; Works and Days 197-201: Nemesis and Aidos will leave the earth when the Iron Age reaches its lowest; Hesiod is the primary ancient text for Nemesis as a personified divine retribution born of Nyx'),
  ('ENT_DOLOS',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 224: Dolos (Deceit) is a child of Night alongside Eris; Hesiod is the primary ancient source for Dolos as a named personified divine entity; he becomes a companion of Ate and the other destructive daimones'),
  ('ENT_OIZYS',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 214: Oizys (Misery/Pain) is a daughter of Night; "sorrowful Oizys" in the list of Night''s evil offspring; Hesiod is the primary ancient source for Oizys as a personified divine entity'),
  ('ENT_KERES',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 217: the Keres (the plural death-spirits; spirits of violent death in battle) are daughters of Night; they are the bloodthirsty spirits who snatch the dying; Hesiod establishes them as distinct from the singular Ker; the Aspis (Shield of Heracles, attributed to Hesiod) contains their most detailed description')
ON CONFLICT DO NOTHING;

-- ── Section 3: Children of Eris — the catalog of strife ─────────────────────
-- Theogony 226-232: Eris herself is a daughter of Night (section 2 above),
-- but her offspring constitute a separate theological category

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_PONOS',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 226: Ponos (Toil/Labour) is the first child of Eris; "hateful Eris bore painful Ponos" — the divine personification of grinding labor as a cosmic evil; Hesiod is the primary ancient source'),
  ('ENT_LIMOS',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 227: Limos (Starvation/Hunger) is a child of Eris; personified famine and starvation as a divine affliction of mortals; Hesiod is the primary ancient source for Limos as a named divine entity'),
  ('ENT_ALGEA',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 227: Algea (Pains/Sorrows) is a plural collective — the personified pains and griefs; children of Eris; Hesiod is the primary ancient source'),
  ('ENT_HYSMINAI',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 228: Hysminai (Battles/Combats) is a child of Eris; personified battles as a divine cosmic force; Hesiod is the primary ancient source for this figure'),
  ('ENT_MAKHAI',       'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 228: Makhai (Fights) is a child of Eris; the personified divine force of one-on-one combat and conflict; Hesiod is the primary ancient source'),
  ('ENT_NEIKEA',       'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 229: Neikea (Quarrels/Disputes) is a child of Eris; the personified divine force of disputes and quarrels; Hesiod is the primary ancient source'),
  ('ENT_AMPHILOGIAI',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 229: Amphilogiai (Disputes/Contradictions) is a child of Eris; the personified divine force of ambiguous disputes; Hesiod is the primary ancient source for this obscure personification'),
  ('ENT_PSEUDOLOGOI',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 229: Pseudologoi (False Stories/Lies) is a child of Eris; the personified divine force of false speech and deception in communication; Hesiod is the primary ancient source'),
  ('ENT_DYSNOMIA',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 230: Dysnomia (Lawlessness) is a child of Eris; she is paired with Ate (Ruin); the divine personification of the absence of law and order; Hesiod is the primary ancient source; Dysnomia is notably the opposite of Eunomia (Good Order, born of Zeus and Themis)'),
  ('ENT_ATE',          'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 230: Ate (Ruin/Blindness) is a child of Eris; paired with Dysnomia; the divine personification of the moral blindness that leads to ruin; Hesiod is the primary genealogical source; Iliad 19.91-131 gives the myth of Ate''s expulsion from Olympus by Zeus; Hesiod provides her genealogy as a child of Night/Strife'),
  ('ENT_AT',           'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 230: Atë (variant spelling; same entity as Ate above); Hesiod names Atë as a child of Eris and pairs her with Dysnomia; both ENT_ATE and ENT_AT represent the same deity in the source texts'),
  ('ENT_HORKOS',       'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 231-232: Horkos (Oath) is the last and most important child of Eris — "who most harms men upon earth when anyone wilfully swears a false oath"; the cosmic significance of the oath as the most dangerous of Eris''s offspring is a distinctly Hesiodic theological statement; Theogony is the primary ancient genealogical text for Horkos')
ON CONFLICT DO NOTHING;

-- ── Section 4: The Twelve Titans ─────────────────────────────────────────────
-- Theogony 133-138, 207-210: the original twelve Titans
-- Hesiod is the PRIMARY text for all Titan genealogies and the Titanomachy

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_OCEANUS',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 133: Oceanus is the first-named Titan, eldest child of Ouranos and Gaia; Theogony 337-370: he and Tethys produced three thousand Oceanid daughters and three thousand river gods; Oceanus is the encircling world-river; Hesiod establishes him as the primordial fresh-water Titan, the cosmic river at the world''s edge'),
  ('ENT_COEUS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 134: Coeus (Koios) is a Titan son of Ouranos and Gaia; paired with Phoebe, they produce Leto and Asteria; he is the Titan of questioning and intelligence (the name Koios relates to questioning); Hesiod is the primary ancient source for Coeus as a named Titan'),
  ('ENT_CRIUS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 134: Crius (Kreios) is a Titan son of Ouranos and Gaia; he married Eurybia (daughter of Pontus) and fathered Astraeus, Pallas, and Perses (Theogony 375-377); Hesiod is the primary ancient source for Crius as a named Titan'),
  ('ENT_HYPERION',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 134: Hyperion is the Titan of heavenly light, "going above" (his name); he married his sister Theia and they produced Helios, Selene, and Eos (Theogony 371-374); Hesiod is the primary genealogical text for Hyperion''s family as the source of the sun, moon, and dawn'),
  ('ENT_IAPETUS',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 134: Iapetus is a Titan son of Ouranos and Gaia; he married the Oceanid Clymene and fathered Atlas, Menoetius, Prometheus, and Epimetheus (Theogony 507-511); Hesiod establishes Iapetus as the father of the Promethean line — the most influential Titan genealogy for human civilization'),
  ('ENT_THEMIS',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 135, 901-906: Themis (Divine Law, Custom, Right) is a Titaness daughter of Ouranos and Gaia; she becomes the second wife of Zeus and bears him the Horai (Hours; law-order-peace) and the Moirai; Hesiod is the primary text for Themis as the divine personification of cosmic law and order who bridges the Titanic and Olympian orders'),
  ('ENT_RHEA',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 135, 453-506: Rhea is a Titaness daughter of Ouranos and Gaia; she marries Kronos and bears the six Olympians (Hestia, Demeter, Hera, Hades, Poseidon, Zeus); after Kronos swallows each child, she tricks him by presenting a stone wrapped in swaddling clothes for Zeus; Hesiod is the primary ancient narrative of Rhea as the mother of the Olympians'),
  ('ENT_MNEMOSYNE', 'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 135, 915-917: Mnemosyne (Memory) is a Titaness daughter of Ouranos and Gaia; Zeus lay with her for nine consecutive nights and she bore the nine Muses; Hesiod himself invokes the Muses in the opening of the Theogony and names them all (Theogony 52-79); Mnemosyne as mother of the Muses is a distinctly Hesiodic theological idea'),
  ('ENT_PHOEBE',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 136: Phoebe (Bright One) is a Titaness daughter of Ouranos and Gaia; she married Coeus and bore Leto and Asteria (Theogony 404-408); she held the oracle at Delphi before passing it to Apollo (implied by the name-lineage: Phoebe → Leto → Apollo "Phoebus"); Hesiod is the primary ancient genealogical source for Phoebe''s role in the divine lineage'),
  ('ENT_TETHYS',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 136: Tethys is the Titaness wife of Oceanus; together they produced the 3,000 Oceanids and 3,000 river gods (Theogony 337-370); Hesiod provides the foundational ancient treatment of Tethys as the Titaness mother of all flowing waters'),
  ('ENT_CRONUS',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 137-138, 453-506: Cronus (Kronos; here the stub entity ENT_CRONUS distinct from the developed ENT_KRONOS) is the youngest and most terrible Titan; he castrates his father Ouranos with the adamantine sickle Gaia fashioned; he swallows each of his own children to prevent being overthrown; his defeat by Zeus and imprisonment in Tartarus; Hesiod is the primary ancient narrative source'),
  ('ENT_THEIA',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 135, 371-374: Theia (Divine, Goddess) is a Titaness daughter of Ouranos and Gaia; she married Hyperion and bore Helios, Selene, and Eos; Hesiod is the primary ancient source for Theia as a named Titaness — she is barely mentioned outside of Hesiod and the genealogical tradition he established')
ON CONFLICT DO NOTHING;

-- ── Section 5: Second-generation Titans, Oceanids, key figures ───────────────
-- Theogony 337-406, 507-616

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ATLAS',          'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 507-520: Atlas is a son of Iapetus and Clymene; condemned by Zeus after the Titanomachy to hold up the sky on his shoulders at the western edge of the world "by stern Necessity"; Hesiod provides the primary genealogical account; the punishment narrative is foundational for all subsequent Atlas mythology'),
  ('ENT_PROMETHEUS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 507-616: the most extensive section on any second-generation Titan; Prometheus steals fire for humanity, Zeus chains him and sends the eagle, and Theogony gives the Pandora aition (Works and Days 47-105 provides more detail); Hesiod is the foundational ancient text for the Prometheus myth — theft of fire, divine punishment, and the origin of human toil and woman'),
  ('ENT_EPIMETHEUS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 511-514: Epimetheus (Afterthought) is the brother of Prometheus; "witless Epimetheus who from the first was a mischief to men who eat bread" — he accepts Pandora as a gift despite Prometheus''s warning; Hesiod is the primary ancient text for Epimetheus as a named character in the Promethean story'),
  ('ENT_MENOETIUS',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 514-516: Menoetius is the third brother of Prometheus; "overweening Menoetius" was struck by Zeus with a lightning bolt and driven into Erebus for his pride and excess of daring; Hesiod is the only ancient source that names him and gives him a brief characterization'),
  ('ENT_LETO',           'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 406-408: Leto is a Titaness daughter of Coeus and Phoebe; she bore Apollo and Artemis to Zeus (Theogony 918-920); Hesiod is the primary genealogical text establishing Leto as a second-generation Titaness and the mother of the twin deities; the Homeric Hymn to Apollo (separately attested) gives the birth narrative in more detail'),
  ('ENT_ASTERIA',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 409-411: Asteria (Starry One) is a Titaness daughter of Coeus and Phoebe, sister of Leto; she avoided Zeus by transforming into a quail (ortyx) and leaping into the sea, becoming the island Delos; Hesiod is the primary ancient source for Asteria''s myth and genealogy'),
  ('ENT_ASTRAEUS',       'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 376-382: Astraeus (the Starry Sky) is a son of Titan Crius and Eurybia; he married Eos (Dawn) and they produced the winds (Zephyros, Boreas, Notus) and the morning stars (Eosphoros and the Astra Planeta); Hesiod is the primary ancient genealogical source for Astraeus as the father of the winds'),
  ('ENT_PERSES_TITAN',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 377, 409: Perses is a son of Crius and Eurybia; he married Asteria (daughter of Coeus and Phoebe) and fathered Hecate; Hesiod is the ONLY primary ancient source for Perses as a named Titan — without the Theogony he would be entirely unknown'),
  ('ENT_PALLAS_TITAN',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 376, 383-385: Pallas is a son of Crius and Eurybia; he fathered Zelus (Rivalry), Nike (Victory), Kratos (Strength), and Bia (Force); Hesiod is the only primary ancient source for Pallas Titan as a named figure; the four children of Pallas and the Oceanid Styx are Zeus''s personal honor guard'),
  ('ENT_DIONE',          'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 353: Dione is an Oceanid, daughter of Oceanus and Tethys; Homer makes her an Olympian, the mother of Aphrodite by Zeus (Iliad 5.370) — a rival tradition to Hesiod''s sea-foam Aphrodite birth; Hesiod''s Theogony establishes Dione as an Oceanid; the two traditions coexist'),
  ('ENT_METIS',          'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 358, 886-900: Metis (Counsel/Wisdom) is the first wife of Zeus; Zeus swallowed her when she was pregnant with Athena because of a prophecy that her male child would be mightier than Zeus himself; Athena then sprang fully armed from Zeus''s head; Hesiod is the primary ancient text for this myth'),
  ('ENT_CLYMENE_TITANESS','SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 351, 507-511: Clymene is an Oceanid, daughter of Oceanus and Tethys; she married the Titan Iapetus and bore Atlas, Menoetius, Prometheus, and Epimetheus; Hesiod is the primary ancient source for Clymene''s genealogical role as the Oceanid who links the Titan Iapetus to the Promethean line'),
  ('ENT_EURYBIA',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 239, 375-377: Eurybia (the Titan/sea-daughter) is a daughter of Pontus and Gaia; she married the Titan Crius and bore Astraeus, Pallas, and Perses; Hesiod gives her the epithet "with heart of flint within her"; primary ancient source for this specific Eurybia (note: ENT_EURYBIA_SEA is the same entity in a different DB stub)'),
  ('ENT_STYX',           'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 361, 383-403, 775-806: Styx is an Oceanid, eldest daughter of Oceanus and Tethys; she was the first to aid Zeus against the Titans and in return Zeus made her waters the great oath of the gods; Theogony 775-806 describes her underground domain in great detail; Hesiod provides the most extensive ancient account of Styx as both a goddess and an oath-mechanism')
ON CONFLICT DO NOTHING;

-- ── Section 6: Hecate ─────────────────────────────────────────────────────────
-- Theogony 411-452: Hecate receives the longest individual praise passage in the
-- entire Theogony — 40+ lines listing her powers over earth, sea, and sky; over
-- contests, war, horses, sailors, fishermen, and children; this is the primary
-- ancient text for Hecate's theology

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_HECATE', 'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 411-452: Hecate receives the longest individual praise passage in the Theogony — "Hecate whom Zeus the son of Cronos honoured above all" (412); Zeus gave her a share of the honors of earth, sea, and starry sky; she aids those who pray to her in all domains (war, athletics, fishing, herding, judgment, children); daughter of Titan Perses and the Titaness Asteria; Hesiod is the earliest and most complete ancient theological account of Hecate''s power; the Chthonic/liminal aspects attested in later sources build on this foundation')
ON CONFLICT DO NOTHING;

-- ── Section 7: The Olympians — births from Theogony ──────────────────────────
-- Theogony 453-506 (Rhea''s children by Kronos), 886-1020 (Zeus''s unions)
-- The Theogony is the canonical genealogical source for all the Olympians,
-- even those Homer knew earlier — Homer gives them in action; Hesiod gives
-- them their births, parents, and cosmic roles.

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ZEUS',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 453-506, 820-885: Zeus''s birth (Rhea hides him in Crete; gives Kronos a stone); the Titanomachy (617-720); Zeus defeats Typhon (820-885) and distributes honors among the gods; Theogony is the primary ancient narrative of Zeus''s rise to power and his establishment as king of the gods; his many unions and the offspring born from them (886-1020) form the genealogical basis of the Greek pantheon'),
  ('ENT_HERA',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 454-458, 921-923: Hera is a daughter of Kronos and Rhea; she is the third wife of Zeus (after Metis and Themis); she bore Hebe, Ares, and Eileithyia to Zeus; she bore Hephaestus alone without union (Theogony 927-929; a tradition differing from the Homeric version); Hesiod is the primary genealogical source for Hera''s cosmic position'),
  ('ENT_POSEIDON',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 454-456: Poseidon is a son of Kronos and Rhea; his cosmic role as ruler of the seas is established by Zeus''s distribution of domains after the Titanomachy (Theogony 73); he was swallowed by Kronos with his siblings and released by Zeus; Hesiod is the primary genealogical source for Poseidon as an Olympian'),
  ('ENT_DEMETER',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 454, 912-914: Demeter is a daughter of Kronos and Rhea; she bore Persephone to Zeus; Hesiod provides the genealogical framework; the Homeric Hymn to Demeter (separately attested) gives the full Persephone-abduction narrative; Hesiod''s Theogony establishes Demeter''s divine lineage and her role as mother of Persephone'),
  ('ENT_HESTIA',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 454: Hestia is the first-born daughter of Kronos and Rhea (first swallowed, last released); her role as goddess of the hearth and domestic order is foundational to Greek religion but largely taken for granted in later sources; Hesiod''s genealogy is the primary ancient placement of Hestia within the Olympian family'),
  ('ENT_HADES',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 455: Hades is a son of Kronos and Rhea — "Aidoneus who rules below"; after Zeus overthrows Kronos, the cosmos is divided by lot: Zeus gets the sky, Poseidon the sea, Hades the underworld (implied by Theogony; explicitly stated in Iliad 15.187); Theogony provides the foundational genealogy and his place in the cosmic order'),
  ('ENT_ATHENA',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 886-900, 924-926: the most important birth narrative in the Theogony; Zeus swallowed Metis when she was pregnant; at the right moment Athena sprang fully armed and shouting from Zeus''s head; Hesiod is the primary ancient text for the Athena-born-of-Zeus''s-head myth, which became the standard account; he also names Athena as "the gleaming-eyed goddess, tireless, mighty" (925)'),
  ('ENT_APOLLO',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 918-920: Apollo and Artemis are born of Zeus and the Titaness Leto; "Leto gave birth to Apollo and Artemis who delights in arrows" — Hesiod provides the genealogical basis; the Homeric Hymns to Apollo (separately linked) give the full birth narrative at Delos; Hesiod''s Theogony is the primary genealogical placement'),
  ('ENT_ARTEMIS',   'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 918-920: Artemis is born of Zeus and Leto alongside Apollo; "Artemis who delights in arrows"; Hesiod gives the genealogical foundation; the Homeric Hymn to Artemis (HH 27) gives her character; Hesiod''s Theogony establishes her as twin of Apollo, daughter of a Titaness'),
  ('ENT_ARES',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 921-923: Ares is born of Zeus and Hera; the Theogony names him alongside Hebe and Eileithyia as the children of the king and queen of the gods; his characterization as the god of war develops in Homer and later tradition; Hesiod provides the genealogical foundation'),
  ('ENT_HEPHAESTUS','SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 927-929: Hera bore Hephaestus alone, without union, in anger at Zeus for producing Athena without her — "outstanding in craftsmanship among the blessed gods"; this contrasts with Homer''s version where Hephaestus is son of both Zeus and Hera; Hesiod''s parthenogenic version is a key theological variant making Hephaestus Hera''s mirror of Athena'),
  ('ENT_HERMES',    'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 938-939: Hermes is born of Zeus and the nymph Maia (daughter of Atlas); Hesiod provides the genealogical placement as son of the youngest daughter of Atlas; the Homeric Hymn to Hermes (HH 4) gives the full birth and infant-trickster narrative; Hesiod establishes the lineage'),
  ('ENT_APHRODITE', 'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 188-206: the sea-foam Aphrodite birth — Ouranos''s severed genitals fall into the sea near Cyprus; white foam gathers around them and a girl grows from it; she is called Aphrodite ("foam-born") and Kythereia; Hesiod''s account is the basis for Botticelli''s Venus; it conflicts with Homer''s version (daughter of Zeus and Dione); Hesiod is primary for the sea-birth tradition'),
  ('ENT_PERSEPHONE','SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 912-914: Persephone is born of Zeus and Demeter; Theogony also alludes to her abduction by Hades (Theogony 768-774); Hesiod gives the genealogical foundation; the Homeric Hymn to Demeter (separately linked) narrates the full abduction myth; Hesiod establishes Persephone as daughter of Zeus and the grain goddess'),
  ('ENT_DIONYSUS',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 940-942: Dionysus is born of Zeus and the mortal Semele; Zeus took the premature infant from Semele''s womb after her death and sewed him into his thigh to complete the gestation — "golden-haired Dionysus"; Hesiod is the primary genealogical source for Dionysus as a son of Zeus and a mortal woman, establishing the foundation for his mixed divine-mortal nature')
ON CONFLICT DO NOTHING;

-- ── Section 8: Sea deities — children of Pontus ──────────────────────────────
-- Theogony 233-264: Pontus and Gaia produce the sea-deity lineage

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_NEREUS',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 233-264: Nereus is the first-born of Pontus and Gaia — "the truthful and trusty Old Man of the Sea" who "never forgets the right and knows only kind and just thoughts"; he fathered the 50 Nereids with the Oceanid Doris; Hesiod catalogs all 50 Nereids by name (Theogony 240-264); the most extensive ancient account of Nereus''s character and family'),
  ('ENT_THAUMAS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 237: Thaumas (Wonder) is a son of Pontus and Gaia; he married the Oceanid Electra and fathered Iris and the Harpies; Hesiod is the only significant ancient source for Thaumas as a named sea deity; he appears nowhere else in any detail'),
  ('ENT_PHORCYS',     'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 237-238: Phorcys is a son of Pontus and Gaia; he married his sister Ceto; they are parents of the Graiai, the Gorgons (including Medusa), the Echidna, and the serpent Ladon; Hesiod is the primary ancient genealogical source for Phorcys as the progenitor of the monstrous marine lineage'),
  ('ENT_CETO',        'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 238, 270-336: Ceto (whale-sea) is a daughter of Pontus and Gaia; married her brother Phorcys; their offspring are the great monsters of the Greek mythological tradition: the Graiai (Pemphredo and Enyo), the Gorgons (Stheno, Euryale, and Medusa), and the serpent guarding the Hesperides'' apples; Hesiod is the primary ancient source for Ceto''s genealogical role'),
  ('ENT_EURYBIA_SEA', 'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 239: Eurybia is a daughter of Pontus and Gaia — "with heart of flint within her"; she married the Titan Crius and bore Astraeus, Pallas, and Perses (Theogony 375-377); Hesiod is the only significant ancient source for this Eurybia as a named entity; she provides the link between the primordial sea lineage and the Titan lineage'),
  ('ENT_TRITON',      'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 930-933: Triton is the son of Poseidon and Amphitrite — "who has the great might and who dwells on the floor of the sea"; he is the messenger of the deep; Hesiod is the primary genealogical source for Triton as the son of Poseidon')
ON CONFLICT DO NOTHING;

-- ── Section 9: Works and Days entities ───────────────────────────────────────
-- SRC_HESIOD_THEOGONY covers both texts (the title: "Theogony and Works and Days")

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ELPIS',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Works and Days 94-98: when Pandora opens the storage jar, all the evils fly out into the world; only Elpis (Hope) remains inside under the jar''s lip — "for the lid of the great jar stopped her before she could fly out"; Hesiod is the ONLY ancient source that names Elpis in this role; the ambiguity of whether Hope remaining in the jar is good (hope stays with humanity) or evil (humanity is deceived by vain hope) is a productive ancient interpretive problem'),
  ('ENT_AIDOS',  'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Works and Days 197-201: in Hesiod''s description of the Iron Age''s final degeneration, Aidos (Shame/Reverence) and Nemesis will wrap themselves in white robes and leave the earth for Olympus, abandoning humanity entirely; this will be the definitive sign that the end of the human moral order has come; Hesiod is the primary ancient source for Aidos as a divine entity whose presence on earth is constitutive of moral civilization')
ON CONFLICT DO NOTHING;

-- ── Section 10: Other Theogony figures ───────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_IRIS',          'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Theogony 265-266: Iris (the Rainbow) is a daughter of Thaumas and the Oceanid Electra; Hesiod gives her genealogy alongside the Harpies; Hesiod establishes Iris as a messenger goddess whose cosmic function is the rainbow that bridges heaven and earth; Homer names her frequently but without genealogy'),
  ('ENT_PHOEBE_AT_DELPHI','SRC_HESIOD_THEOGONY', 'secondary_reference',
   'Theogony 136, 404-410: Phoebe (Titaness) held the oracle at Delphi before passing it to Apollo via her daughter Leto (implied by the divine lineage: Phoebe bore Leto, who bore Apollo "Phoebus" = the Bright One); the ENT_PHOEBE_AT_DELPHI cult entity represents the Delphi oracle tradition before Apollo; its theological basis is the Hesiodic genealogy of Phoebe as Leto''s mother and Apollo''s grandmother')
ON CONFLICT DO NOTHING;

-- ── Verification ─────────────────────────────────────────────────────────────

SELECT COUNT(DISTINCT entity_id) AS entities_now_linked_to_hesiod
FROM entity_sources WHERE source_id = 'SRC_HESIOD_THEOGONY';

SELECT entity_type, COUNT(*) AS count
FROM entities e
WHERE e.entity_id IN (
  SELECT entity_id FROM entity_sources WHERE source_id = 'SRC_HESIOD_THEOGONY'
) AND e.tradition = 'Greek'
GROUP BY entity_type ORDER BY count DESC;

SELECT * FROM v_release_metrics;

COMMIT;
