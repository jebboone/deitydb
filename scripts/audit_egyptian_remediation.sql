-- scripts/audit_egyptian_remediation.sql
-- Egyptian tradition audit remediation
--
-- Addresses five categories of gaps identified in the Egyptian audit:
--
-- 1. CRITICAL STRUCTURAL GAP: Atum at the Ennead apex
--    Atum has 0 parent_of relationships. He is the Heliopolitan creator who
--    produced Shu and Tefnut — without this the entire Ennead genealogy
--    (Shu+Tefnut → Geb+Nut → Osiris+Isis+Seth+Nephthys) is unrooted.
--    Source: Pyramid Texts, the oldest religious corpus in the world.
--
-- 2. MISSING DIVINE TRIAD LINKS
--    Amun has no relationship with Mut (Theban Triad: Amun–Mut–Khonsu).
--    Ptah has no relationship with Sekhmet (Memphis Triad: Ptah–Sekhmet–Nefertem).
--
-- 3. MISSING ENTITIES (4 significant gaps in older strata)
--    Wosret (Old Kingdom; "the Powerful One"; Pyramid Texts; early Theban patron)
--    Iah (Old Kingdom; moon deity; Pyramid Texts; predates Khonsu's prominence)
--    Meskhenet (Middle Kingdom; birth brick goddess; Papyrus Westcar; fate/destiny)
--    Pakhet (Middle Kingdom; lioness goddess; Speos Artemidos; "She Who Scratches")
--
-- 4. BULK PERIOD ASSIGNMENTS for existing entities
--    61 Egyptian entities have no period assignments; this remediation covers the
--    most important: predynastic/Early Dynastic deities (Horus, Seth, Neith,
--    Wadjet, Nekhbet, Min, Wepwawet) and Old Kingdom Pyramid Texts deities
--    (Atum, Ptah, Shu, Tefnut, Geb, Nut, Isis, Nephthys, Hathor, Thoth, Bastet,
--    Sekhmet, Sobek, Khnum, Khepri, Seshat, Montu, Khonsu, and others).
--
-- 5. MISSING RECEPTION CHAINS (three are Herodotus-explicit)
--    Neith → Athena (Herodotus Histories 2.28, 2.59)
--    Ptah → Hephaestus (Herodotus Histories 3.37)
--    Min → Pan (Herodotus Histories 2.46)
--
-- New source: SRC_FAULKNER_PYRAMID_TEXTS
-- Existing sources used: SRC_WILKINSON_EGYPTIAN_GODS, SRC_HERODOTUS_HISTORIES,
--   SRC_PINCH_EGYPTIAN_MYTH, SRC_HORNUNG_DUAT

BEGIN;

-- ── 1. New source ─────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_FAULKNER_PYRAMID_TEXTS',
   'R. O. Faulkner, The Ancient Egyptian Pyramid Texts (Oxford University Press, 1969; repr. Aris & Phillips, 1998)',
   NULL,
   'primary text translation',
   'The standard English translation of the Pyramid Texts (PT), the oldest religious corpus in the world (c. 2375-2181 BCE; first attested in the pyramid of Unas, 5th Dynasty); 759 "Utterances" covering the solar theology of Ra and Atum, the Osiris myth, the Ennead genealogy, the underworld geography, and virtually every major Old Kingdom deity; primary source for establishing Old Kingdom period attestations of Egyptian deities including Atum, Shu, Tefnut, Geb, Nut, Osiris, Isis, Seth, Nephthys, Hathor, Thoth, Ptah, Anubis, Khepri, Horus, Sekhmet, Sobek, Khnum, Seshat, Wepwawet, and dozens of others')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Critical gap: Atum as Ennead apex ─────────────────────────────────────
-- The Heliopolitan Ennead begins with Atum's self-creation and his production
-- of the first divine pair. PT Utterance 600: "Atum, who formerly was high on the
-- primeval hill ... who spat out Shu, who expectorated Tefnut." The Pyramid Texts
-- also describe Atum creating Shu and Tefnut by masturbation (PT 527, 1248).
-- Both traditions agree on the same genealogical result: Atum → Shu + Tefnut.

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_ATUM', 'parent_of', 'ENT_EGY_SHU',
   'high',
   'Pyramid Texts Utterance 600: Atum spat out Shu ("who spat out Shu, who expectorated Tefnut") from Heliopolis. Also PT 527, 1248 describe Atum creating Shu and Tefnut by masturbation (the "hand of Atum" tradition). Atum as the creator of the first divine pair Shu (air) and Tefnut (moisture) is the foundational act of the Heliopolitan cosmogony and the root of the Ennead genealogy.',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed', 'PER_EGY_OLD_KINGDOM'),

  ('ENT_EGY_ATUM', 'parent_of', 'ENT_EGY_TEFNUT',
   'high',
   'Pyramid Texts Utterance 600: Atum expectorated Tefnut alongside Shu. Tefnut (moisture/cosmic order) is the twin of Shu and the second generation of the Ennead; both are products of Atum''s creative act at the primordial moment on the Benben hill of Heliopolis.',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed', 'PER_EGY_OLD_KINGDOM'),

  -- Shu and Tefnut are children of Atum and parents of Geb/Nut (already in DB);
  -- add the inverse child_of for Atum to complete the chain
  ('ENT_EGY_SHU', 'child_of', 'ENT_EGY_ATUM',
   'high',
   'Shu as the firstborn of Atum; Pyramid Texts establish Shu (air/light) and Tefnut (moisture) as the first created beings, products of Atum''s self-generation on the primordial mound.',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed', 'PER_EGY_OLD_KINGDOM'),

  ('ENT_EGY_TEFNUT', 'child_of', 'ENT_EGY_ATUM',
   'high',
   'Tefnut as the twin of Shu and second offspring of Atum; Pyramid Texts and Coffin Texts consistently pair Shu and Tefnut as the first created divine pair produced by Atum.',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed', 'PER_EGY_OLD_KINGDOM')
ON CONFLICT DO NOTHING;

-- ── 3. Missing divine triad links ────────────────────────────────────────────

-- Theban Triad: Amun – Mut – Khonsu
-- Amun currently has spouse_of → Amunet (the Ogdoad pairing) but NO link to Mut.
-- In the Middle Kingdom and New Kingdom, Amun's primary consort is Mut, not Amunet.
-- The Theban Triad (Amun, Mut, Khonsu) was the dominant theological framework of
-- the New Kingdom and the state religion at Karnak.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_AMUN', 'spouse_of', 'ENT_EGY_MUT',
   'high',
   'Amun and Mut form the divine couple of the Theban Triad (Amun–Mut–Khonsu), with Khonsu as their son. Mut''s Precinct at Karnak (south of the main Amun temple complex) was her primary cult center. The pairing is the dominant theological arrangement of the New Kingdom Egyptian state religion. Wilkinson (2003) p. 151.',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed', 'PER_EGY_NEW_KINGDOM'),
  ('ENT_EGY_MUT', 'spouse_of', 'ENT_EGY_AMUN',
   'high',
   'Mut as the divine consort of Amun and mother of Khonsu in the Theban Triad; her name means "mother"; originally a primordial mother goddess who was later integrated as Amun''s principal wife in the Middle Kingdom Theban theology.',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed', 'PER_EGY_NEW_KINGDOM'),
  ('ENT_EGY_AMUN', 'parent_of', 'ENT_EGY_KHONSU',
   'high',
   'Khonsu is the divine son of Amun and Mut in the Theban Triad; his name means "the traveller" and he is primarily a moon deity; his main temple at Karnak (the Khonsu temple, largely built by Ramesses III) forms the third element of the Theban triad complex.',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed', 'PER_EGY_NEW_KINGDOM'),
  ('ENT_EGY_MUT', 'parent_of', 'ENT_EGY_KHONSU',
   'high',
   'Mut as the divine mother of Khonsu in the Theban Triad; her maternal role is the primary mythological function in the Amun–Mut–Khonsu family theology of Karnak.',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed', 'PER_EGY_NEW_KINGDOM')
ON CONFLICT DO NOTHING;

-- Memphis Triad: Ptah – Sekhmet – Nefertem
-- Ptah and Sekhmet are the divine couple; Nefertem is their son (already linked
-- via Nefertem member_of Ptah). The spousal link between Ptah and Sekhmet is absent.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_PTAH', 'spouse_of', 'ENT_EGY_SEKHMET',
   'high',
   'Ptah and Sekhmet form the divine couple of the Memphis Triad (Ptah–Sekhmet–Nefertem). Sekhmet ("the Powerful One") is Ptah''s fierce consort and the lioness goddess of war and pestilence; their pairing unites the creative/craftsman principle (Ptah) with the destructive/protective force (Sekhmet). Wilkinson (2003) pp. 181, 212.',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed', 'PER_EGY_OLD_KINGDOM'),
  ('ENT_EGY_SEKHMET', 'spouse_of', 'ENT_EGY_PTAH',
   'high',
   'Sekhmet as the divine consort of Ptah and co-parent of Nefertem in the Memphis Triad; her marriage to Ptah joined the creative and destructive aspects of the Memphite divine order.',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed', 'PER_EGY_OLD_KINGDOM')
ON CONFLICT DO NOTHING;

-- ── 4. New entities ───────────────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_EGY_WOSRET',
   'Wosret',
   'Egyptian',
   'Goddess / Early Theban deity',
   'A',
   '"The Powerful One" (Egyptian wsr = powerful); ancient Theban goddess attested in the Pyramid Texts (Old Kingdom); one of the earliest Theban patron deities, predating Amun''s rise to prominence; her name is the same root as Osiris (Wsir) and Waser; she appears in the Pyramid Texts as a protective and powerful female force; some Egyptologists (including Wilkinson) consider her a possible early precursor to Mut in the Theban theological tradition, though direct textual continuity is debated; she is also thought to be connected with the royal cartouche tradition — the name "Wosret" appears in several 12th Dynasty pharaonic names (Senusret, meaning "man of Wosret"), suggesting she retained theological importance into the Middle Kingdom despite being overshadowed by Mut'),

  ('ENT_EGY_IAH',
   'Iah',
   'Egyptian',
   'Moon deity',
   'A',
   'Egyptian moon deity; name simply means "moon" (Egyptian: Jꜥḥ); one of the oldest Egyptian lunar deities, attested in the Pyramid Texts (Old Kingdom); he is associated with the crescent moon and is depicted as a man wearing the crescent and full moon disc on his head; in the Old Kingdom and Middle Kingdom he was the primary lunar deity of the Egyptian pantheon; his importance was gradually eclipsed by Khonsu (the moon deity of the Theban Triad) who absorbed his functions in the New Kingdom; Thoth also absorbed aspects of his lunar role; by the Ptolemaic period Iah had become largely a lunar symbol rather than an actively worshipped deity; his name survives in the element "Jah" (month) in the Coptic calendar'),

  ('ENT_EGY_MESKHENET',
   'Meskhenet',
   'Egyptian',
   'Birth goddess / Fate deity',
   'A',
   'Egyptian goddess of childbirth and fate; presides over the birth brick (the "meskhenet"), a low brick on which Egyptian women squatted to give birth; she is present at every birth and determines the newborn''s fate (shay/shai) at the moment of delivery; attested in the Coffin Texts (Middle Kingdom, c. 2055-1650 BCE) and famously in Papyrus Westcar (Middle Kingdom narrative involving the miraculous births of the first three kings of the 5th Dynasty), where Meskhenet appears alongside Isis, Nephthys, Heket, and Khnum to assist at the royal births; she is also present at the final judgment scene (the weighing of the heart), where she testifies about the deceased; her iconography includes the birth brick headdress or a double-looped uterine symbol'),

  ('ENT_EGY_PAKHET',
   'Pakhet',
   'Egyptian',
   'Lioness goddess / Hunter',
   'A',
   '"She Who Scratches" or "She Who Tears" (Egyptian: Pꜣḫt); Middle Kingdom lioness goddess worshipped primarily at Speos Artemidos ("Cave of Artemis"), a rock-cut shrine east of Beni Hasan in Middle Egypt; her cult is principally attested from the Middle Kingdom through the New Kingdom; she is a fierce huntress who prowls the desert at night, catching prey with her claws — her name refers to this scratching/tearing action; Queen Hatshepsut enlarged the Speos Artemidos shrine and left an important inscription there; the Greeks later identified her with Artemis (hence "Speos Artemidos"), making her one of the Egyptian deities in the Greek interpretatio tradition; her function as a desert huntress and nocturnal lioness parallels Sekhmet but is distinct in character')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 5. Source links for new entities ─────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_WOSRET',    'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'Wosret appears in the Pyramid Texts as a powerful protective female deity in the Theban tradition; Old Kingdom attestation'),
  ('ENT_EGY_WOSRET',    'SRC_WILKINSON_EGYPTIAN_GODS','secondary_reference',
   'Wilkinson (2003) p. 167: Wosret as ancient Theban goddess; possible precursor to Mut; Senusret name etymology'),
  ('ENT_EGY_IAH',       'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'Iah attested in the Pyramid Texts as the primary lunar deity of the Old Kingdom; the moon-name deity predating Khonsu''s prominence'),
  ('ENT_EGY_IAH',       'SRC_WILKINSON_EGYPTIAN_GODS','secondary_reference',
   'Wilkinson (2003) pp. 113-114: Iah as the oldest Egyptian moon deity; his absorption by Khonsu and Thoth in later periods'),
  ('ENT_EGY_MESKHENET', 'SRC_PINCH_EGYPTIAN_MYTH',   'primary_attestation',
   'Pinch (2002) pp. 126-127: Meskhenet in Papyrus Westcar; the birth brick goddess and her role in fate determination; Coffin Text attestation'),
  ('ENT_EGY_MESKHENET', 'SRC_WILKINSON_EGYPTIAN_GODS','secondary_reference',
   'Wilkinson (2003) p. 175: Meskhenet''s iconography (birth brick or double-looped headdress), her role at birth and at the final judgment'),
  ('ENT_EGY_PAKHET',    'SRC_WILKINSON_EGYPTIAN_GODS','primary_attestation',
   'Wilkinson (2003) pp. 176-177: Pakhet at Speos Artemidos; "She Who Scratches"; Hatshepsut''s enlargement of the shrine; Middle Kingdom origin'),
  ('ENT_EGY_PAKHET',    'SRC_PINCH_EGYPTIAN_MYTH',   'secondary_reference',
   'Pinch (2002) on Pakhet: the nocturnal lioness huntress; Greek identification with Artemis at Speos Artemidos')
ON CONFLICT DO NOTHING;

-- ── 6. Period assignments for new entities ───────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_EGY_WOSRET',    'PER_EGY_OLD_KINGDOM',    'medium',
   'Wosret attested in the Pyramid Texts (Old Kingdom); her antiquity is secure but the textual record is sparse; her name survives in 12th Dynasty pharaonic names (Senusret)',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),
  ('ENT_EGY_WOSRET',    'PER_EGY_MIDDLE_KINGDOM',  'high',
   'Wosret''s importance in the Middle Kingdom is demonstrated by the royal name Senusret ("man of Wosret"), borne by three 12th Dynasty pharaohs',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_IAH',       'PER_EGY_OLD_KINGDOM',    'high',
   'Iah attested in the Pyramid Texts as the primary lunar deity of the Old Kingdom period',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),
  ('ENT_EGY_MESKHENET', 'PER_EGY_MIDDLE_KINGDOM',  'high',
   'Meskhenet prominently attested in Papyrus Westcar (Middle Kingdom) and the Coffin Texts (Middle Kingdom)',
   'SRC_PINCH_EGYPTIAN_MYTH', 'reviewed'),
  ('ENT_EGY_PAKHET',    'PER_EGY_MIDDLE_KINGDOM',  'high',
   'Pakhet''s primary cult at Speos Artemidos originates in the Middle Kingdom; confirmed by the rock-cut shrine and Middle Kingdom texts',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_PAKHET',    'PER_EGY_NEW_KINGDOM',     'high',
   'Hatshepsut enlarged the Speos Artemidos shrine in the New Kingdom; major Pakhet inscription from 18th Dynasty',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 7. Bulk period assignments for existing entities ─────────────────────────
-- Covers predynastic/Early Dynastic and Old Kingdom deities.
-- Sources: primary = SRC_FAULKNER_PYRAMID_TEXTS for Old Kingdom attestations;
-- SRC_WILKINSON_EGYPTIAN_GODS for Early Dynastic material not in the Pyramid Texts.

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES

  -- ── Predynastic / Early Dynastic (-3150 to -2686) ──────────────────────────

  ('ENT_EGY_HORUS',    'PER_EGY_EARLY_DYNASTIC', 'high',
   'Horus as the royal falcon god is attested on the Narmer Palette (c. 3100 BCE), the earliest monument of unified Egypt; he is the patron deity of kingship from the first dynasty onward',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_SETH',     'PER_EGY_EARLY_DYNASTIC', 'high',
   'Seth is attested in the Early Dynastic period at Nubt (Ombos/Naqada), his cult center, which predates unification; the Seth animal appears in Predynastic imagery; 2nd Dynasty pharaoh Peribsen took a Seth name',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_NEITH',    'PER_EGY_EARLY_DYNASTIC', 'high',
   'Neith is one of the oldest attested Egyptian deities; the name Neith-hotep (a 1st Dynasty queen) and the Neith-headed standard appear in the earliest dynastic records; her cult at Sais is pre-dynastic in origin',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_WADJET',   'PER_EGY_EARLY_DYNASTIC', 'high',
   'Wadjet (the cobra of Lower Egypt) is attested from the Early Dynastic period as the protector of Lower Egypt and of the pharaoh; she appears on the royal uraeus from the earliest dynasties',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_NEKHBET',  'PER_EGY_EARLY_DYNASTIC', 'high',
   'Nekhbet (the vulture of Upper Egypt) appears on the Narmer Palette alongside Wadjet; she is the protective vulture goddess of Upper Egypt and the pharaoh from the earliest dynastic period',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_MIN',      'PER_EGY_EARLY_DYNASTIC', 'high',
   'Min of Coptos (Qift) is attested by the Min colossi, now in the Ashmolean Museum — some of the oldest surviving large-scale Egyptian sculpture, dated to the Predynastic or Early Dynastic period (c. 3000 BCE); his ithyphallic cult at Coptos is among the oldest documented Egyptian religious traditions',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_WEPWAWET', 'PER_EGY_EARLY_DYNASTIC', 'high',
   'Wepwawet ("Opener of the Ways") appears on the Narmer Palette as a standard carried before the pharaoh; his jackal cult at Asyut (Lycopolis) is among the oldest provincial cults in Egypt',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_SESHAT',   'PER_EGY_EARLY_DYNASTIC', 'medium',
   'Seshat (goddess of writing and measurement) is associated with the "Stretching the Cord" foundation ceremony, attested from the 1st Dynasty; her earliest certain textual attestation is slightly later but her Early Dynastic role in royal ceremony is well-documented',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- ── Old Kingdom: Pyramid Texts deities (-2686 to -2181) ────────────────────

  ('ENT_EGY_ATUM',     'PER_EGY_OLD_KINGDOM',    'high',
   'Atum is massively attested in the Pyramid Texts (c. 2375-2181 BCE) as the Heliopolitan creator deity; PT Utterance 600 describes his creation of Shu and Tefnut; he is the apex of the Ennead genealogy and the primordial self-created deity of Heliopolis',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SHU',      'PER_EGY_OLD_KINGDOM',    'high',
   'Shu (god of air and light) is attested throughout the Pyramid Texts as the first offspring of Atum and the father of Geb and Nut; his cosmological role as the air that separates sky from earth is foundational to Old Kingdom theology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_TEFNUT',   'PER_EGY_OLD_KINGDOM',    'high',
   'Tefnut (goddess of moisture and cosmic order) is attested in the Pyramid Texts as the twin of Shu and the second offspring of Atum; her moisture complements Shu''s air in the Old Kingdom creation cosmology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_GEB',      'PER_EGY_OLD_KINGDOM',    'high',
   'Geb (earth god) is attested throughout the Pyramid Texts as the son of Shu and Tefnut, spouse of Nut, and father of the second generation of the Ennead (Osiris, Isis, Seth, Nephthys)',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_NUT',      'PER_EGY_OLD_KINGDOM',    'high',
   'Nut (sky goddess) is attested throughout the Pyramid Texts as the daughter of Shu and Tefnut and the mother of Osiris, Isis, Seth, and Nephthys; she arches over Geb to form the sky, and the deceased pharaoh is received into her body for rebirth',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_ISIS',     'PER_EGY_OLD_KINGDOM',    'high',
   'Isis is attested in the Pyramid Texts as the daughter of Geb and Nut, wife of Osiris, and mother of Horus; her role as the divine mourner who resurrects Osiris is central to Old Kingdom funerary theology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_NEPHTHYS', 'PER_EGY_OLD_KINGDOM',    'high',
   'Nephthys is attested in the Pyramid Texts as the daughter of Geb and Nut and the twin sister of Isis; she assists Isis in the mourning and resurrection of Osiris; her role as a protective funerary goddess is established in the Old Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_HATHOR',   'PER_EGY_OLD_KINGDOM',    'high',
   'Hathor is extensively attested in the Pyramid Texts; the 4th Dynasty pharaohs adopted the epithet "son of Hathor" at Dendera; her identification as the "Eye of Ra" and her role as the goddess of joy, love, and music are established in the Old Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_PTAH',     'PER_EGY_OLD_KINGDOM',    'high',
   'Ptah is the patron deity of Memphis, the Old Kingdom royal capital; the Memphite Theology (preserved in the Shabaka Stone, a Late Period copy of an Old Kingdom original) establishes him as the creator who creates by thought and word; he appears in the Pyramid Texts',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_THOTH',    'PER_EGY_OLD_KINGDOM',    'high',
   'Thoth is attested in the Pyramid Texts (Old Kingdom) as the divine scribe, measurer of time, and moon deity; this corrects his current period assignment of Middle Kingdom only — his attestation goes back to the Pyramid Texts',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_BASTET',   'PER_EGY_OLD_KINGDOM',    'high',
   'Bastet is attested from the 2nd Dynasty at Bubastis; the Pyramid Texts reference her; her cat goddess identity develops through the Old Kingdom; she is one of the oldest Lower Egyptian deities',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SEKHMET',  'PER_EGY_OLD_KINGDOM',    'high',
   'Sekhmet is attested in the Pyramid Texts as the fierce lioness goddess of war and pestilence; her Memphis connections (as Ptah''s consort) establish her in the Old Kingdom theological landscape',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SOBEK',    'PER_EGY_OLD_KINGDOM',    'high',
   'Sobek is attested in the Pyramid Texts as the crocodile deity; his Fayum cult and his connections to Ra (Sobek-Ra) are established in Old Kingdom texts',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_KHNUM',    'PER_EGY_OLD_KINGDOM',    'high',
   'Khnum of Elephantine is attested in Old Kingdom texts as the ram-headed creator who fashions humans on his potter''s wheel; his Elephantine triad (Khnum, Satet, Anuket) is established in the Old Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_KHEPRI',   'PER_EGY_OLD_KINGDOM',    'high',
   'Khepri (the scarab beetle sun deity, representing the rising morning sun) is attested in the Pyramid Texts as the self-created dawn aspect of the solar cycle, alongside Ra (noon) and Atum (setting sun)',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_KHONSU',   'PER_EGY_OLD_KINGDOM',    'medium',
   'Khonsu appears in the Pyramid Texts in a violent aspect as a deity who consumes the hearts of the dead (PT 580); his role as the benevolent moon deity of the Theban Triad develops in the Middle and New Kingdoms; Old Kingdom attestation is limited',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_MONTU',    'PER_EGY_OLD_KINGDOM',    'high',
   'Montu is attested in the Pyramid Texts as the falcon-headed war deity of Thebes; he was the primary Theban patron deity before Amun rose to prominence; his cult at Medamud, Tod, and Armant is established in the Old Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_HEKET',    'PER_EGY_OLD_KINGDOM',    'high',
   'Heket (frog goddess of fertility and childbirth) is attested in the Pyramid Texts; she assists at the births of gods and kings; her role in the Pyramid Texts as a birth-helper is established in the Old Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SERQET',   'PER_EGY_OLD_KINGDOM',    'high',
   'Serqet (scorpion goddess) is attested in the Pyramid Texts as a protective deity who guards Osiris and assists the dead; she is one of the four canopic jar goddesses',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SOPDU',    'PER_EGY_OLD_KINGDOM',    'high',
   'Sopdu (falcon deity of the eastern frontier, associated with the star Sirius in some traditions) is attested in the Pyramid Texts and in Old Kingdom inscriptions at the Sinai turquoise mines',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SEKER',    'PER_EGY_OLD_KINGDOM',    'high',
   'Seker (Sokar) is an ancient Memphite funerary deity attested from the Old Kingdom; his festival (the Sokar festival) is one of the oldest Egyptian religious celebrations; he is paired with Ptah in the Memphis funerary tradition',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_AKER',     'PER_EGY_OLD_KINGDOM',    'high',
   'Aker (the earth/horizon deity who guards the passage of the solar bark) is attested in the Pyramid Texts as the dual-headed lion deity of the eastern and western horizons',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_DUAT',     'PER_EGY_OLD_KINGDOM',    'high',
   'The Duat (the Egyptian netherworld / afterlife realm) is extensively described in the Pyramid Texts; the concept of the Duat as the region through which Ra travels at night and where the dead are judged is foundational to Old Kingdom funerary theology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_SIA',      'PER_EGY_OLD_KINGDOM',    'medium',
   'Sia (divine perception/understanding) is attested in the Pyramid Texts alongside Hu (divine utterance) as personifications of the divine cognitive faculties of Ra and Ptah; their appearance as companion deities on the solar bark is an Old Kingdom concept',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_HU',       'PER_EGY_OLD_KINGDOM',    'medium',
   'Hu (divine utterance/creative word) is attested in the Pyramid Texts alongside Sia; both personify aspects of the divine creative faculty; Hu is the utterance by which Ra and Ptah create',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- ── Middle Kingdom additions (-2055 to -1650) ──────────────────────────────

  ('ENT_EGY_MUT',       'PER_EGY_MIDDLE_KINGDOM', 'high',
   'Mut''s identification as Amun''s consort and her development as a major independent goddess begins in the Middle Kingdom Theban theological tradition; her Precinct of Mut at Karnak is her principal cult establishment',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_RENENUTET', 'PER_EGY_MIDDLE_KINGDOM', 'high',
   'Renenutet (harvest/fate goddess) is attested in Middle Kingdom agricultural and funerary texts; her role as the goddess who bestows the "ren" (true name) at birth and determines fate is documented in Middle Kingdom sources',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_HAPY_NILE', 'PER_EGY_OLD_KINGDOM',   'high',
   'Hapy (the Nile inundation deity) is attested in the Pyramid Texts; the "Hymn to Hapy" (a Middle Kingdom text preserved in later copies) is the most elaborate expression of his cult but his Old Kingdom attestation is secure',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- ── New Kingdom additions (-1550 to -1069) ─────────────────────────────────

  ('ENT_EGY_BES',        'PER_EGY_NEW_KINGDOM',   'high',
   'Bes is first prominently attested in the New Kingdom as a household protective deity; he appears on headrests, birth chambers, and domestic objects from the 18th Dynasty onward; his origins may be earlier (possibly Middle Kingdom) but the major attestation is New Kingdom',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_TAWERET',    'PER_EGY_NEW_KINGDOM',   'high',
   'Taweret (hippopotamus goddess of childbirth) is attested as a major household deity from the New Kingdom; amulets and figurines proliferate in the New Kingdom; her connection to Bes as a protective birth deity pair is established in the New Kingdom',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_MERETSEGER', 'PER_EGY_NEW_KINGDOM',   'high',
   'Meretseger ("She Who Loves Silence") is the cobra goddess of the Theban necropolis; her cult is specifically attested at Deir el-Medina (the artisan village) in the 19th-20th Dynasties; she is a specifically New Kingdom deity with no earlier significant attestation',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_AMUN_RA',    'PER_EGY_NEW_KINGDOM',   'high',
   'The Amun-Ra syncretism reaches its apex in the New Kingdom 18th Dynasty when Amun-Ra becomes the state deity of the Egyptian Empire; the Karnak temple complex is his primary monument; the Amun-Ra theological tradition is the dominant New Kingdom religious framework',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_RA_HORAKHTY','PER_EGY_NEW_KINGDOM',   'high',
   'Ra-Horakhty ("Ra who is Horus of the Two Horizons") is a New Kingdom syncretism most prominently attested at Abu Simbel (Ramesses II temple) and in New Kingdom solar theology; though Harakhty has Old Kingdom roots, the hyphenated Ra-Horakhty form is New Kingdom',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_SESHAT',     'PER_EGY_OLD_KINGDOM',   'high',
   'Seshat is attested from the Old Kingdom Pyramid Texts and in royal foundation ceremonies; her role as divine record-keeper, measurer, and scribe of the gods is established in the Old Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  ('ENT_EGY_TATENEN',    'PER_EGY_OLD_KINGDOM',   'medium',
   'Tatenen ("the Exalted Earth") is a Memphite earth deity who later merged with Ptah; his most prominent attestation is New Kingdom but he has roots in the Old Kingdom Memphite theology',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  ('ENT_EGY_NEFERTEM',   'PER_EGY_OLD_KINGDOM',   'medium',
   'Nefertem (lotus deity, son of Ptah and Sekhmet in the Memphis Triad) is attested in the Pyramid Texts; his identification with the primordial lotus of creation links him to Old Kingdom cosmology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed')

ON CONFLICT DO NOTHING;

-- ── 8. Reception chains ───────────────────────────────────────────────────────
-- All three are explicitly documented in Herodotus Histories Book 2-3.

-- Neith → Athena: Herodotus 2.28 and 2.59 explicit
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_NEITH', 'received_as', 'ENT_ATHENA',
   'high',
   'Herodotus explicitly equates Neith with Athena in two passages: at 2.28 he identifies the goddess of Sais as Athena, and at 2.59 he names the great festival at Sais as belonging to Athena (= Neith). The equation is supported by shared attributes: both are warrior goddesses associated with weaving, wisdom, and craftsmanship; both have the owl as a sacred animal in some traditions; both are depicted with shield and spear. The famous inscription at Sais — "I am all that has been, and is, and shall be, and none among mortals has yet uncovered my robe" — was transmitted to the Greek world through this Neith-Athena identification. The identification is one of the best-documented Egyptian→Greek deity equations in the ancient sources.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_EGY_LATE_PERIOD'),
  ('ENT_ATHENA', 'reception_of', 'ENT_EGY_NEITH',
   'high',
   'Athena as the Greek reception of the Egyptian Neith of Sais; Herodotus 2.28, 2.59 make the identification explicit; shared warrior-weaver-wisdom attributes.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_EGY_LATE_PERIOD')
ON CONFLICT DO NOTHING;

-- Ptah → Hephaestus: Herodotus 3.37 explicit
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_PTAH', 'received_as', 'ENT_HEPHAESTUS',
   'high',
   'Herodotus explicitly equates Ptah with Hephaestus at 3.37, where he refers to the temple of Ptah at Memphis as the temple of Hephaestus: "the temple of Hephaestus" (= Ptah) at Memphis is where Cambyses committed his sacrilege. Memphis itself was sometimes called "Hephaestia" by Greek writers. The equation rests on shared craftsmanship and creation attributes: Ptah is the divine craftsman and creator-by-word in Egyptian theology; Hephaestus is the divine craftsman and smith of the Greek pantheon. Both are associated with fire, metalwork, and the creative power to fashion divine objects. The identification was widespread in the Ptolemaic and Roman periods.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_EGY_LATE_PERIOD'),
  ('ENT_HEPHAESTUS', 'reception_of', 'ENT_EGY_PTAH',
   'high',
   'Hephaestus as the Greek reception of the Egyptian Ptah; Herodotus 3.37 explicit; shared craftsman-creator attributes; Memphis = "Hephaestia" in Greek usage.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_EGY_LATE_PERIOD')
ON CONFLICT DO NOTHING;

-- Min → Pan: Herodotus 2.46 explicit
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_EGY_MIN', 'received_as', 'ENT_PAN',
   'high',
   'Herodotus makes the Min-Pan identification explicit at 2.46: "in Egypt, Pan is reckoned one of the eight gods who are of the earliest rank" — this refers to Min, the ithyphallic deity of Coptos and Akhmim, who was identified by Greek visitors as Pan. The equation rests on: (1) Min''s conspicuous ithyphallism, which Greek observers associated with Pan''s fertility and sexuality; (2) Min''s association with the desert and with wild spaces parallel to Pan''s domain; (3) the Egyptian goat cult at Mendes that Herodotus also describes in 2.46 may have reinforced the equation via the goat association of Pan. The identification became standard in the Ptolemaic and Roman periods; the Greco-Roman city of Akhmim (ancient Ipu/Khent-Abt, Min''s cult center) was called Panopolis (City of Pan) by the Greeks.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_EGY_LATE_PERIOD'),
  ('ENT_PAN', 'reception_of', 'ENT_EGY_MIN',
   'high',
   'Pan as the Greek reception of the Egyptian Min; Herodotus 2.46 explicit; ithyphallic fertility deity equation; Min''s city Akhmim became Panopolis in the Greco-Roman period.',
   'SRC_HERODOTUS_HISTORIES', 'reviewed', 'PER_EGY_LATE_PERIOD')
ON CONFLICT DO NOTHING;

-- ── 9. Verification ───────────────────────────────────────────────────────────

SELECT 'atum_ennead_links' AS metric, COUNT(*) AS count
FROM entity_relationships
WHERE subject_entity_id = 'ENT_EGY_ATUM' AND relationship_type = 'parent_of';

SELECT 'egyptian_entities_with_period' AS metric, COUNT(DISTINCT ep.entity_id) AS count
FROM entity_periods ep
JOIN entities e ON ep.entity_id = e.entity_id
WHERE e.tradition ILIKE '%egypt%';

SELECT 'egyptian_entities_without_period' AS metric, COUNT(*) AS count
FROM entities e
WHERE e.tradition ILIKE '%egypt%'
  AND e.entity_id NOT LIKE 'ENT_SYN_%'
  AND e.entity_id NOT LIKE 'ENT_HER_%'
  AND e.entity_id NOT LIKE 'ENT_LAT_%'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id = e.entity_id);

SELECT * FROM v_release_metrics;

COMMIT;
