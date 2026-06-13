-- scripts/audit_mesopotamian_remediation.sql
-- Mesopotamian tradition audit remediation
--
-- Six categories of gaps addressed:
--
-- 1. MISSING PERIOD: PER_MES_UR_III (-2112 to -2004)
--    The bulk of the surviving Sumerian literary corpus (Inanna hymns, Nanna hymns,
--    laments, Gilgamesh poems) was composed in the Ur III / early Old Babylonian
--    periods. Without this period the ETCSL corpus cannot be properly anchored.
--
-- 2. PERIOD SKEW: 29/33 entities assigned only to PER_MES_NEO_ASS (-900 to -539).
--    The major Sumerian deities — Anu, Enlil, Enki/Ea, Inanna, Nanna/Sin, Utu/Shamash,
--    Ninhursag, Ereshkigal, Dumuzi, Geshtinanna, Nisaba, Adad/Ishkur, Ninurta,
--    Nergal, Tiamat, Apsu, Kingu, Marduk, Nabu — are attested from the Early Dynastic
--    period (Fara tablets, c. 2600 BCE) or earlier; they need PER_MES_EARLY.
--
-- 3. MISSING ENTITIES (3 significant gaps):
--    ENT_MES_NINLIL: Enlil's consort; mother of Nanna/Sin; "Lady of the Grain";
--      Enlil currently has no spouse relationship at all.
--    ENT_MES_NINGAL: Nanna/Sin's consort; explicitly named as mother of Inanna
--      and Utu in Sumerian hymns; major cult at Ur; the parentage Nanna → Inanna/Utu
--      exists in DB but records no mother.
--    ENT_MES_NAMMU: Primordial sea goddess; Eridu theology; mother of Enki;
--      in Enki and the World Order she is the first deity named; listed before
--      Anu in some Sumerian traditions; among the oldest attested Mesopotamian deities.
--
-- 4. MISSING INTERNAL RELATIONSHIPS:
--    Anu, Enlil, Enki as member_of → Anunnaki (none of the three chief gods
--      are linked to the collective that is already in DB)
--    Enki ↔ Ninhursag (paired_with): major Sumerian myth; zero relationship
--    Ereshkigal ↔ Inanna (sibling_of): Descent of Inanna explicitly calls
--      Ereshkigal "her sister"
--    Enlil ↔ Ninlil (spouse_of); Nanna ↔ Ningal (spouse_of)
--    Ningal → parent_of → Inanna and Utu (currently no named mother)
--
-- 5. MISSING RECEPTION CHAINS:
--    Inanna/Ishtar → Aphrodite (medium): direct Cypriot path alongside the
--      existing Inanna→Astarte→Aphrodite chain
--    Nanna/Sin → Selene (low): Hellenistic lunar deity equation
--    Enki/Ea → Prometheus (low): divine benefactor against divine assembly;
--      West (1997) notes the structural parallel
--
-- 6. SOURCE GAP:
--    SRC_FOSTER_BEFORE_MUSES: the comprehensive Akkadian literary anthology;
--    ETCSL covers Sumerian; Foster covers Akkadian-period texts.
--
-- Sources used: SRC_ETCSL, SRC_BLACK_GREEN_MESO, SRC_FOSTER_BEFORE_MUSES (new),
--   SRC_BURKERT_ORIENT_REV, SRC_WEST_EAST_HELICON, SRC_HERODOTUS_HISTORIES

BEGIN;

-- ── 1. New period ─────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, period_name, tradition, start_year, end_year)
VALUES ('PER_MES_UR_III', 'Ur III / Sumerian Renaissance', 'Mesopotamian', -2112, -2004)
ON CONFLICT (period_id) DO NOTHING;

-- ── 2. New source ─────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_FOSTER_BEFORE_MUSES',
   'Benjamin R. Foster, Before the Muses: An Anthology of Akkadian Literature, 3rd ed. (CDL Press, 2005)',
   NULL,
   'primary text translation',
   'The standard comprehensive anthology of Akkadian literary texts; covers the major mythological compositions in Akkadian (Enuma Elish / Epic of Creation, Atrahasis Epic, Descent of Ishtar, Erra and Ishum, Nergal and Ereshkigal, Adapa, Etana) and poetic/hymnic texts across the Old Babylonian, Middle Babylonian, and Standard Babylonian periods; essential for Akkadian-period deity attestations (Marduk, Ishtar, Ea/Enki, Nergal, Ereshkigal, Nabu, Adad) where ETCSL covers the Sumerian side')
ON CONFLICT (source_id) DO NOTHING;

-- ── 3. New entities ───────────────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_MES_NINLIL',
   'Ninlil',
   'Mesopotamian',
   'Mother goddess / Divine consort',
   'A',
   '"Lady of the Grain" or "Lady Air" (Sumerian: nin = lady, lil = grain/air); consort of Enlil and the most important divine mother in the Sumerian pantheon; her primary cult center is Nippur alongside Enlil; the Enlil and Ninlil myth (ETCSL 1.2.1) narrates how Enlil, exiled to the underworld for raping the young Ninlil by the banks of the canal, is followed there by Ninlil; their underground union produces the moon god Nanna/Sin and two other underworld deities (Nergal and Ninazu in some traditions); she is also called Sud in an older tradition before her marriage to Enlil; in the Old Babylonian period she is identified with Ninhursag and with the "Lady of the Earth" tradition; she is the divine mother whose children include the moon (Nanna/Sin), the warrior (Ninurta), and the underworld power (Nergal)'),

  ('ENT_MES_NINGAL',
   'Ningal',
   'Mesopotamian',
   'Moon goddess / Divine consort',
   'A',
   '"Great Lady" (Sumerian: nin = lady, gal = great); divine consort of Nanna/Sin the moon god; her primary cult centers are Ur (the Nanna/Sin temple city) and Harran; she is explicitly named in Sumerian hymns and laments as the mother of Inanna/Ishtar (the evening/morning star) and Utu/Shamash (the sun); the Lamentation over the Destruction of Ur (ETCSL 2.2.2) gives her a major role as the goddess who pleads before the divine assembly not to destroy Ur but is ultimately unable to prevent it — one of the most powerful divine lament figures in Sumerian literature; she is also the mother of Ereshkigal in some traditions, making her the mother of both the love goddess (Inanna) and the queen of death (Ereshkigal); her cult at Harran survived into the Islamic period among the Sabians'),

  ('ENT_MES_NAMMU',
   'Nammu',
   'Mesopotamian',
   'Primordial sea goddess',
   'A',
   'The primordial sea goddess of Eridu theology; the oldest deity in the Eridu cosmogonic tradition; her name appears to mean "the sea" (the primordial body of water, not the salt sea); in Enki and the World Order (ETCSL 1.1.3) Nammu is listed as the first deity, before Anu; in the Debate between Sheep and Grain (ETCSL 5.3.2) Nammu is the mother of Anu and Enlil; in the Eridu Genesis (a Sumerian flood narrative) she is the primordial creator; in Enki and Ninmah (ETCSL 1.1.2) Nammu wakes Enki to help her create humanity — she is Enki''s mother, and her request launches the creation-of-humanity myth; among the oldest attested deities in the Sumerian tradition, associated with the Abzu (the subterranean fresh water) and with the primordial creative principle; later largely superseded by Tiamat (saltwater) and Apsu (fresh water) in the Babylonian theological tradition')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Source links for new entities ─────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_MES_NINLIL', 'SRC_ETCSL',            'primary_attestation',
   'ETCSL 1.2.1 (Enlil and Ninlil): the foundational myth of their union; Ninlil as the young woman who follows Enlil to the underworld; mother of Nanna/Sin and underworld deities'),
  ('ENT_MES_NINLIL', 'SRC_BLACK_GREEN_MESO', 'secondary_reference',
   'Black and Green (1992) pp. 138-139: Ninlil at Nippur; her identification with Sud; role as Enlil''s consort and divine mother'),
  ('ENT_MES_NINGAL', 'SRC_ETCSL',            'primary_attestation',
   'ETCSL 2.2.2 (Lamentation over the Destruction of Ur): Ningal pleads before An and Enlil; her maternal role as protector of Ur; mother of Inanna and Utu named in Nanna hymns'),
  ('ENT_MES_NINGAL', 'SRC_BLACK_GREEN_MESO', 'secondary_reference',
   'Black and Green (1992) p. 138: Ningal as Nanna''s consort; cult at Ur; Harran survival into the Sabian period'),
  ('ENT_MES_NAMMU',  'SRC_ETCSL',            'primary_attestation',
   'ETCSL 1.1.2 (Enki and Ninmah): Nammu wakes Enki to create humanity; she is described as his mother; ETCSL 1.1.3 (Enki and the World Order): Nammu listed as primordial deity; ETCSL 5.3.2 (Debate between Sheep and Grain): Nammu as mother of Anu and Enlil'),
  ('ENT_MES_NAMMU',  'SRC_BLACK_GREEN_MESO', 'secondary_reference',
   'Black and Green (1992) p. 133: Nammu as the primordial sea of Eridu theology; her relationship to Enki and to the Abzu; her supersession by Tiamat and Apsu in the Babylonian tradition')
ON CONFLICT DO NOTHING;

-- ── 5. Period assignments for new entities ────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_MES_NINLIL', 'PER_MES_EARLY',   'high',
   'Ninlil attested at Nippur from the Early Dynastic period; the Enlil and Ninlil myth preserved in Ur III copies but composed earlier; her presence in the Nippur theological tradition goes back to the earliest literate period',
   'SRC_ETCSL', 'reviewed'),
  ('ENT_MES_NINLIL', 'PER_MES_UR_III',  'high',
   'The Enlil and Ninlil myth (ETCSL 1.2.1) is preserved primarily in Ur III and Old Babylonian manuscripts; she is a central figure in Ur III Nippur liturgy',
   'SRC_ETCSL', 'reviewed'),
  ('ENT_MES_NINGAL', 'PER_MES_UR_III',  'high',
   'Ningal''s major attestation is in the Ur III lament literature; the Lamentation over the Destruction of Ur is a Ur III-era composition; her temple at Ur (e-kiš-nu-gál) was a major Ur III cult center',
   'SRC_ETCSL', 'reviewed'),
  ('ENT_MES_NINGAL', 'PER_MES_OLD_BAB', 'high',
   'Ningal''s role continues in Old Babylonian liturgy; Nanna/Sin hymns of the Old Babylonian period consistently name Ningal as his consort and mother of Inanna and Utu',
   'SRC_ETCSL', 'reviewed'),
  ('ENT_MES_NAMMU',  'PER_MES_EARLY',   'high',
   'Nammu is attested in the earliest Sumerian theological compositions; her Eridu theology predates the systematic Nippur tradition; she represents the oldest stratum of Sumerian cosmogony at Eridu (Enki''s city)',
   'SRC_ETCSL', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Bulk period assignments: add PER_MES_EARLY to Sumerian deities ─────────
-- All of the following are attested in Fara-period texts (c. 2600 BCE) or
-- the earliest Sumerian literary corpus. The Fara tablets (from ancient Šuruppak)
-- preserve god-lists that already include: Enlil, Inanna, Enki, Nanna, Utu,
-- Ninhursag, Adad/Ishkur, Ninurta, Nergal, Ereshkigal, and most other major deities.
-- The Uruk IV/III proto-cuneiform (c. 3200-3000 BCE) attests Inanna's sign
-- among the earliest written symbols. All assignments HIGH confidence.

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_MES_ANU',          'PER_MES_EARLY', 'high',
   'Anu (An) is attested in the earliest Sumerian god-lists (Fara period, c. 2600 BCE) as the supreme sky deity; the sign AN is among the earliest proto-cuneiform symbols from Uruk IV (c. 3200 BCE)',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_ENLIL',        'PER_MES_EARLY', 'high',
   'Enlil is attested in the Fara god-lists (c. 2600 BCE) and in the earliest royal inscriptions as the chief deity of Nippur and the divine authority over kingship; one of the most frequently attested Early Dynastic deities',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_ENKI_EA',      'PER_MES_EARLY', 'high',
   'Enki (En-ki = "Lord Earth"; Ea in Akkadian) is attested at Eridu from the earliest literate period; his city Eridu is among the oldest Sumerian cities; the Eridu theology is the oldest recoverable Mesopotamian cosmogonic tradition',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_INANNA_ISHTAR', 'PER_MES_EARLY', 'high',
   'Inanna is attested in the Fara god-lists and in proto-cuneiform from Uruk; the cuneiform sign for Inanna (the gate-post or reed bundle) is among the oldest written symbols; she is the primary deity of Uruk, the first city',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_NANNA_SIN',    'PER_MES_EARLY', 'high',
   'Nanna (the moon god) is attested in the Fara god-lists and in Early Dynastic royal inscriptions from Ur; his temple e-kiš-nu-gál at Ur is one of the earliest documented temples',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_UTU_SHAMASH',  'PER_MES_EARLY', 'high',
   'Utu (the sun god) is attested in the Fara god-lists and in the earliest Sumerian royal inscriptions; the sun-disc symbol appears in proto-cuneiform; Larsa and Sippar are his cult cities from the Early Dynastic period',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_NINHURSAG',    'PER_MES_EARLY', 'high',
   'Ninhursag (also Ninmah, Nintu, Ki; "Lady of the Sacred Mountain") is attested in the Fara god-lists as the mother goddess; she is one of the four principal Sumerian deities (Anu, Enlil, Enki, Ninhursag) of the Early Dynastic canon',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_ERESHKIGAL',   'PER_MES_EARLY', 'high',
   'Ereshkigal is attested in the Fara god-lists and in Early Dynastic texts as the queen of the underworld; the Descent of Inanna tradition (attested in Ur III copies) preserves Early Dynastic cosmological thinking',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_DUMUZI_TAMMUZ','PER_MES_EARLY', 'high',
   'Dumuzi appears in the Sumerian king list as a historical king of Uruk (ante-diluvian section); he is attested in the Fara god-lists; the Inanna-Dumuzi love poetry is among the earliest Sumerian literary compositions',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_GESHTINANNA',  'PER_MES_EARLY', 'high',
   'Geshtinanna (divine sister of Dumuzi; scribe of the underworld) appears in Early Dynastic Sumerian texts; her role in the Inanna-Dumuzi myth cycle is established in the earliest Sumerian literary tradition',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_NERGAL',       'PER_MES_EARLY', 'high',
   'Nergal (the underworld and war deity) is attested in the Fara god-lists; his city Cutha (Kutha) was one of the major Early Dynastic cult centers',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_NINURTA',      'PER_MES_EARLY', 'high',
   'Ninurta (warrior deity; son of Enlil; later also an agriculture deity) is attested in the Fara god-lists and in Early Dynastic hymns; Lugale, one of the most important Sumerian mythological texts, is attested in Ur III copies but reflects earlier tradition',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_NISABA',       'PER_MES_EARLY', 'high',
   'Nisaba (goddess of grain, writing, and scribal arts) is attested from the Early Dynastic period in school texts and god-lists; she is the patron of the scribal tradition from its earliest documented phase',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_ADAD_ISHKUR',  'PER_MES_EARLY', 'high',
   'Adad/Ishkur (the storm deity) is attested in the Fara god-lists as Ishkur; his Akkadian name Adad develops later but the Sumerian Ishkur cult is Early Dynastic; he is the son of Anu in some traditions',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_TIAMAT',       'PER_MES_OLD_BAB', 'high',
   'Tiamat as a named mythological figure is primarily an Old Babylonian and later concept, reaching canonical form in the Enuma Elish (Standard Babylonian period); she may have antecedents in earlier primordial-sea traditions but the named entity is Old Babylonian',
   'SRC_FOSTER_BEFORE_MUSES', 'reviewed'),

  ('ENT_MES_APSU',         'PER_MES_OLD_BAB', 'high',
   'Apsu as a named mythological entity alongside Tiamat appears in the Old Babylonian tradition leading to the Enuma Elish; the concept of the Abzu (subterranean fresh water) is older but the Apsu-as-named-deity-alongside-Tiamat is Old Babylonian',
   'SRC_FOSTER_BEFORE_MUSES', 'reviewed'),

  ('ENT_MES_KINGU',        'PER_MES_OLD_BAB', 'high',
   'Kingu appears as Tiamat''s champion in the Enuma Elish tradition, which reaches its canonical form in the Old Babylonian period; his blood is used to create humanity after Marduk''s victory',
   'SRC_FOSTER_BEFORE_MUSES', 'reviewed'),

  ('ENT_MES_MARDUK',       'PER_MES_OLD_BAB', 'high',
   'Marduk''s rise as the chief deity of the Babylonian pantheon begins in the Old Babylonian period with the rise of the First Babylonian Dynasty; the Enuma Elish narrative of his victory over Tiamat is an Old Babylonian theological development',
   'SRC_FOSTER_BEFORE_MUSES', 'reviewed'),

  ('ENT_MES_NABU',         'PER_MES_OLD_BAB', 'high',
   'Nabu (son of Marduk; deity of writing and scribal arts) becomes prominent in the Old Babylonian period alongside Marduk''s rise; his city Borsippa is attested as a major cult center from the Old Babylonian period',
   'SRC_FOSTER_BEFORE_MUSES', 'reviewed'),

  ('ENT_MES_ASHUR',        'PER_MES_OLD_BAB', 'high',
   'Ashur (the Assyrian state deity) is attested from the Old Assyrian period (contemporaneous with Old Babylonian); his national cult at Assur develops in parallel with Marduk''s at Babylon',
   'SRC_FOSTER_BEFORE_MUSES', 'reviewed'),

  ('ENT_MES_LAMASHTU',     'PER_MES_OLD_BAB', 'high',
   'Lamashtu as a named demoness threatening mothers and infants is attested in Old Babylonian incantation texts; the detailed iconography and ritual against her is Old Babylonian',
   'SRC_BLACK_GREEN_MESO', 'reviewed'),

  ('ENT_MES_PAZUZU',       'PER_MES_OLD_BAB', 'high',
   'Pazuzu (the demon who opposes Lamashtu) is attested in Old Babylonian incantation texts and amulets; his use as a protective counter-demon against Lamashtu is established in the Old Babylonian period',
   'SRC_BLACK_GREEN_MESO', 'reviewed'),

  -- Ur III period assignments for the core literary deities
  ('ENT_MES_INANNA_ISHTAR', 'PER_MES_UR_III', 'high',
   'The major Inanna hymn corpus (Hymns to Inanna by Enheduanna, daughter of Sargon; the Descent of Inanna) is preserved in Ur III manuscripts; Enheduanna''s hymns (c. 2285-2250 BCE) are the oldest attributed literary compositions in history',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_NANNA_SIN',    'PER_MES_UR_III', 'high',
   'The Ur III period is the peak of Nanna/Sin worship; Ur-Namma and Shulgi (Ur III kings) dedicated major hymns to Nanna; the e-kiš-nu-gál temple at Ur was reconstructed by Ur-Namma; Nanna is the patron deity of the Ur III dynasty',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_ENLIL',        'PER_MES_UR_III', 'high',
   'Enlil''s role as the supreme authority who grants kingship is central to the Ur III political theology; Ur III royal hymns consistently invoke Enlil; Nippur (his cult city) was the religious capital of the Ur III empire',
   'SRC_ETCSL', 'reviewed'),

  ('ENT_MES_DUMUZI_TAMMUZ','PER_MES_UR_III', 'high',
   'The Inanna-Dumuzi love poetry corpus is preserved in Ur III and early Old Babylonian manuscripts; the Descent of Inanna (ETCSL 1.4.1) with its Dumuzi substitution narrative is a Ur III-era composition',
   'SRC_ETCSL', 'reviewed')

ON CONFLICT DO NOTHING;

-- ── 7. Missing internal relationships ─────────────────────────────────────────

-- 7a. Chief gods as members of the Anunnaki collective
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ANU',      'member_of', 'ENT_MES_ANUNNAKI',
   'high',
   'Anu is the chief of the Anunnaki; in Sumerian theology the Anunnaki are the gods of the earth and underworld, with Anu as their divine patriarch; the term "great Anunnaki" in the Atrahasis Epic and Enuma Elish refers to the high council of gods with Anu at the apex.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_ENLIL',    'member_of', 'ENT_MES_ANUNNAKI',
   'high',
   'Enlil is one of the three chief Anunnaki (Anu, Enlil, Enki) who divide the cosmos between them; in the Atrahasis Epic the Anunnaki cast lots and Enlil receives command of the earth; as the lord of the divine assembly (Ubshu-ukkinna) at Nippur, he presides over the Anunnaki.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_ENKI_EA',  'member_of', 'ENT_MES_ANUNNAKI',
   'high',
   'Enki/Ea is the third of the three chief Anunnaki; he receives dominion over the Abzu (the subterranean sweet water) when the cosmos is divided; he is the cleverest of the Anunnaki ("Enki surpasses all gods in wisdom" — Hymn to Enki) and frequently acts as the intermediary between the divine assembly and humanity.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY')
ON CONFLICT DO NOTHING;

-- 7b. Enki ↔ Ninhursag: the central relationship of the Enki and Ninhursag myth
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ENKI_EA', 'paired_with', 'ENT_MES_NINHURSAG',
   'high',
   'Enki and Ninhursag (ETCSL 1.1.1) is one of the most important Sumerian mythological compositions; Enki and Ninhursag are the divine couple in Dilmun (the sacred land); their sexual encounters and the resulting chain of offspring goddesses drives the narrative; their complex relationship (creative partnership that turns to conflict when Enki eats the plants Ninhursag grew, then reconciliation when Ninhursag heals Enki''s ailments) establishes them as a divine creative pair whose interaction generates life and the divine order of nature.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_NINHURSAG', 'paired_with', 'ENT_MES_ENKI_EA',
   'high',
   'Ninhursag as Enki''s divine partner in the Enki and Ninhursag myth (ETCSL 1.1.1); their relationship alternates between creative union and conflict; Ninhursag ultimately heals the ailing Enki and is celebrated as the mother of all living things.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY')
ON CONFLICT DO NOTHING;

-- 7c. Ereshkigal ↔ Inanna: sisters in the Descent of Inanna
-- Descent of Inanna (ETCSL 1.4.1): "Inanna set her heart toward the Great Below ...
-- toward her sister Ereshkigal, queen of the Great Below"
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_INANNA_ISHTAR', 'sibling_of', 'ENT_MES_ERESHKIGAL',
   'high',
   'In the Descent of Inanna (ETCSL 1.4.1), Inanna explicitly travels "toward her sister Ereshkigal, queen of the Great Below." The sibling relationship between the love goddess and the queen of death is the foundational tension of the narrative: Ereshkigal has power over the underworld that Inanna desires; Inanna is stripped of her divine attributes at each of the seven gates as she descends to face her sister. Their sisterhood makes the confrontation mythologically significant — it is the love of life vs. the finality of death embodied in divine sisters.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_ERESHKIGAL', 'sibling_of', 'ENT_MES_INANNA_ISHTAR',
   'high',
   'Ereshkigal as the sister of Inanna; the Descent of Inanna establishes that the queen of the Great Below and the queen of heaven and earth are divine sisters whose domains define the cosmic poles of life/love and death.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY')
ON CONFLICT DO NOTHING;

-- 7d. Enlil ↔ Ninlil: the divine couple of Nippur
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ENLIL', 'spouse_of', 'ENT_MES_NINLIL',
   'high',
   'Enlil and Ninlil are the divine couple of Nippur; the Enlil and Ninlil myth (ETCSL 1.2.1) narrates the circumstances of their union and subsequent journey to the underworld; in Sumerian hymns and god-lists they are consistently paired as the lord and lady of Nippur.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_NINLIL', 'spouse_of', 'ENT_MES_ENLIL',
   'high',
   'Ninlil as Enlil''s consort; the divine lady of Nippur alongside Enlil; their pairing is foundational to the Nippur theological tradition and to the legitimation of Sumerian kingship.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_ENLIL', 'parent_of', 'ENT_MES_NANNA_SIN',
   'high',
   'In the Enlil and Ninlil myth (ETCSL 1.2.1), Enlil''s union with Ninlil in the underworld produces Nanna/Sin (the moon god); this paternity is the standard Sumerian tradition for Nanna''s divine parentage and is attested in hymns across the corpus.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY'),
  ('ENT_MES_NINLIL', 'parent_of', 'ENT_MES_NANNA_SIN',
   'high',
   'Ninlil as the mother of Nanna/Sin per the Enlil and Ninlil myth (ETCSL 1.2.1); her journey to the underworld following Enlil results in Nanna''s birth as a child of the underworld who ascends to rule the night sky.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY')
ON CONFLICT DO NOTHING;

-- 7e. Nanna ↔ Ningal: the divine couple of Ur; Ningal as mother of Inanna and Utu
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_NANNA_SIN', 'spouse_of', 'ENT_MES_NINGAL',
   'high',
   'Nanna/Sin and Ningal are the divine couple of Ur; their pairing is consistently attested in Ur III hymns to Nanna; Ningal has her own temple (the e-kiš-nu-gál) within Nanna''s temple complex at Ur; she is named as his consort in the Lamentation over the Destruction of Ur (ETCSL 2.2.2) and in multiple Nanna hymns.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_UR_III'),
  ('ENT_MES_NINGAL', 'spouse_of', 'ENT_MES_NANNA_SIN',
   'high',
   'Ningal as the divine consort of Nanna/Sin at Ur; she intercedes with the divine assembly on Ur''s behalf in the Lamentation over the Destruction of Ur, acting as the protective mother of the city and its people.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_UR_III'),
  ('ENT_MES_NINGAL', 'parent_of', 'ENT_MES_INANNA_ISHTAR',
   'high',
   'Ningal is explicitly named as the mother of Inanna in Sumerian hymns; the parentage Nanna + Ningal → Inanna is the standard Sumerian tradition. Ningal''s maternal role provides Inanna with both a lunar/celestial father (Nanna) and a divine mother who intercedes before the gods.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_UR_III'),
  ('ENT_MES_NINGAL', 'parent_of', 'ENT_MES_UTU_SHAMASH',
   'high',
   'Ningal is named as the mother of Utu/Shamash (the sun god) alongside Inanna in Sumerian hymns; Nanna and Ningal are the divine parents of both the moon''s primary associated celestial bodies (sun and Venus/morning star).',
   'SRC_ETCSL', 'reviewed', 'PER_MES_UR_III')
ON CONFLICT DO NOTHING;

-- 7f. Nammu as mother of Enki
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_NAMMU', 'parent_of', 'ENT_MES_ENKI_EA',
   'high',
   'In Enki and Ninmah (ETCSL 1.1.2), Nammu is explicitly described as Enki''s mother: she wakes Enki to help solve the problem of the gods having to do their own labor, and calls him "my son." The Eridu cosmogonic tradition places Nammu as the primordial sea from which Enki/the Abzu emerges; this makes Nammu the generative source of Enki''s fresh-water wisdom domain.',
   'SRC_ETCSL', 'reviewed', 'PER_MES_EARLY')
ON CONFLICT DO NOTHING;

-- ── 8. Reception chains ───────────────────────────────────────────────────────

-- Inanna/Ishtar → Aphrodite: the direct Cypriot-mediated path
-- (alongside the existing Inanna → Astarte → Aphrodite chain already in DB)
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_INANNA_ISHTAR', 'received_as', 'ENT_APHRODITE',
   'medium',
   'Inanna/Ishtar transmits directly to Aphrodite via the Cypriot channel, alongside the more fully documented Inanna→Astarte→Aphrodite chain already in the dataset. The key shared elements: (1) the "Queen of Heaven" title (Inanna is consistently "Queen of Heaven"; Aphrodite Ourania is "Heavenly Aphrodite"); (2) the planet Venus as the primary celestial identification (both are the morning/evening star deity); (3) the love-war combination (both are goddesses of erotic love and of war and conflict — an unusual combination that marks the Mesopotamian influence); (4) the Cypriot cult of Aphrodite at Paphos showing direct Eastern religious influence; (5) the Adonis/Tammuz link — Adonis is the Greek reception of Dumuzi, Inanna/Ishtar''s divine lover, and the Adonis cult is deeply Cypriot. Burkert (1992) and West (1997) both treat this as a well-grounded direct channel.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_APHRODITE', 'reception_of', 'ENT_MES_INANNA_ISHTAR',
   'medium',
   'Aphrodite as the Greek reception of the Mesopotamian Inanna/Ishtar tradition; the Queen of Heaven / morning-star / love-war combination transmitted via Cypriot Aphrodite cult and Phoenician mediation.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- Nanna/Sin → Selene: Hellenistic lunar deity equation
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_NANNA_SIN', 'received_as', 'ENT_SELENE',
   'low',
   'In the Hellenistic and Roman periods, the moon deity Sin (Nanna) of Harran was equated with the Greek moon deity Selene/Luna. The Sabians of Harran (a surviving late-antique Mesopotamian religious community) were known to Greek and Arab writers as "star worshippers" who identified their deities with the classical planetary gods; Sin of Harran was equated with the Moon (Selene/Luna) in this Hellenistic planetary-deity identification system. The equation is a late Hellenistic/Roman-era interpretatio graeca of the Mesopotamian lunar tradition rather than a documented literary transmission chain. Confidence low: this is structural equation rather than documented narrative transmission.',
   'SRC_BLACK_GREEN_MESO', 'reviewed', 'PER_HER_HELLENISTIC'),
  ('ENT_SELENE', 'reception_of', 'ENT_MES_NANNA_SIN',
   'low',
   'Selene as the Hellenistic Greek reception of the Mesopotamian lunar deity Sin/Nanna in the planetary-deity identification system; mediated through the Sabian tradition at Harran.',
   'SRC_BLACK_GREEN_MESO', 'reviewed', 'PER_HER_HELLENISTIC')
ON CONFLICT DO NOTHING;

-- Enki/Ea → Prometheus: structural parallel; West (1997) notes the comparison
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ENKI_EA', 'received_as', 'ENT_PROMETHEUS',
   'low',
   'West (1997) and Burkert (1992) note the structural parallel between Enki/Ea and Prometheus as divine benefactors who act against the divine assembly''s decisions to preserve or benefit humanity. In the Atrahasis Epic (c. 1700 BCE), Ea warns Atrahasis (the flood hero) about the flood that the divine assembly has decreed to destroy humanity, instructing him to build a boat — acting in secret opposition to the divine council''s decision. In Gilgamesh Tablet XI, Ea again warns Utnapishtim. Prometheus likewise steals fire for humanity against Zeus''s explicit refusal, defying the divine order. Both are trickster-wisdom figures who value humanity''s survival over obedience to the divine hierarchy. However, no direct textual transmission from the Enki/Ea tradition to the Prometheus myth has been documented; this is a structural/comparative parallel rather than a proven reception chain. Confidence low.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_PROMETHEUS', 'reception_of', 'ENT_MES_ENKI_EA',
   'low',
   'Prometheus as a possible Greek reception of the Mesopotamian Enki/Ea divine-benefactor-against-divine-assembly archetype; the structural parallel is noted by West (1997) and Burkert (1992) but direct textual transmission has not been established.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- ── 9. Verification ───────────────────────────────────────────────────────────

SELECT 'mesopotamian_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Mesopotamian';

SELECT 'mes_entities_with_early_period' AS metric, COUNT(DISTINCT ep.entity_id) AS count
FROM entity_periods ep
WHERE ep.period_id = 'PER_MES_EARLY'
  AND ep.entity_id LIKE 'ENT_MES_%';

SELECT 'anunnaki_members_linked' AS metric, COUNT(*) AS count
FROM entity_relationships
WHERE object_entity_id = 'ENT_MES_ANUNNAKI' AND relationship_type = 'member_of';

SELECT 'ninlil_enlil_linked' AS metric,
  CASE WHEN EXISTS (
    SELECT 1 FROM entity_relationships
    WHERE subject_entity_id = 'ENT_MES_ENLIL'
      AND object_entity_id   = 'ENT_MES_NINLIL'
  ) THEN 'yes' ELSE 'no' END AS status;

SELECT * FROM v_release_metrics;

COMMIT;
