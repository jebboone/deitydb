-- scripts/add_egyptian_period_completion.sql
-- Assigns periods to the 21 remaining Egyptian entities that lack period coverage.
-- These are the last unperiodized Egyptian entities after audit_egyptian_remediation.sql
-- covered the 66 main deities. The remaining 21 fall into five clusters:
--
--  A. Four Sons of Horus (collective + 4 individual entities)
--     → all attested in Old Kingdom Pyramid Texts; canopic jar assignment stabilizes in NK
--
--  B. Horus forms (Haroeris, Harsiese, Harakhty, Harsomtus)
--     → each form has a distinct attestation horizon
--
--  C. Elephantine/cataract deities (Satet, Anuket)
--     → Satet: Early Dynastic; Anuket: Old Kingdom
--
--  D. Primordial/cosmological collective (Ogdoad)
--     → Hermopolitan theology: Old Kingdom nucleation; Middle Kingdom systematic form
--
--  E. Remaining entities: Ihy, Ash, Shai, Reret, Shesmetet, Heryshaf,
--     Banebdjedet, Neferhotep, Ptah-Seker-Osiris
--
-- Sources used for dating:
--   SRC_FAULKNER_PYRAMID_TEXTS : Old Kingdom primary attestation (c. 2375-2181 BCE)
--   SRC_WILKINSON_EGYPTIAN_GODS: covers Early Dynastic through Ptolemaic
--   SRC_HORNUNG_DUAT            : funerary/underworld traditions
--   SRC_PINCH_EGYPTIAN_MYTH     : general reference

BEGIN;

-- ── A. Four Sons of Horus ────────────────────────────────────────────────────
-- The Four Sons of Horus (Imsety, Hapy, Duamutef, Qebehsenuef) protect the four
-- canopic jars containing the deceased's organs. They appear by name in the
-- Pyramid Texts of Unas (c. 2375 BCE) and throughout the Old Kingdom corpus.
-- In the New Kingdom their canonical pairing with specific canopic jars is
-- standardized (linen/stomach/jackal, linen/lungs/baboon, etc.), but the Old Kingdom
-- attestation is the primary period of first significance.

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  -- Collective entity
  ('ENT_EGY_FOUR_SONS_OF_HORUS', 'PER_EGY_OLD_KINGDOM', 'high',
   'The Four Sons of Horus are named as a divine group in the Pyramid Texts (e.g. PT Utterance 552, § 1360); each guards one of the four cardinal directions; their role as guardians of the deceased king''s viscera is established here in its earliest surviving form',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),
  ('ENT_EGY_FOUR_SONS_OF_HORUS', 'PER_EGY_NEW_KINGDOM', 'high',
   'New Kingdom standardizes the canonical pairing of each Son with a specific canopic jar, specific internal organ, and specific protective goddess (Isis/Imsety; Nephthys/Hapy; Neith/Duamutef; Selket/Qebehsenuef); Book of the Dead spells (esp. BD 151) are the primary New Kingdom texts',
   'SRC_HORNUNG_DUAT', 'reviewed'),

  -- Imsety — human-headed; guards the liver; protected by Isis
  ('ENT_EGY_IMSETY', 'PER_EGY_OLD_KINGDOM', 'high',
   'Imsety (the human-headed Son of Horus) is named in the Pyramid Texts; PT Utterance 552; the liver-guarding role is established from the Old Kingdom funerary tradition; the canopic jar for the liver is among the earliest attested',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Hapy Son of Horus — baboon-headed; guards the lungs; protected by Nephthys
  ('ENT_EGY_HAPY_SON_OF_HORUS', 'PER_EGY_OLD_KINGDOM', 'high',
   'Hapy Son of Horus (baboon-headed; distinct from Hapy the Nile god) is named in the Pyramid Texts; guards the lungs; PT Utterance 552 and the canopic jar system establish the Old Kingdom attestation',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Duamutef — jackal-headed; guards the stomach; protected by Neith
  ('ENT_EGY_DUAMUTEF', 'PER_EGY_OLD_KINGDOM', 'high',
   'Duamutef (the jackal-headed Son of Horus; "he who worships his mother") guards the stomach; named in the Pyramid Texts alongside his three brothers; the canopic jar system has Old Kingdom roots even if full standardization comes in the New Kingdom',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Qebehsenuef — falcon-headed; guards the intestines; protected by Selket
  ('ENT_EGY_QEBEHSENUEF', 'PER_EGY_OLD_KINGDOM', 'high',
   'Qebehsenuef (the falcon-headed Son of Horus; "he who refreshes his brothers") guards the intestines; named in the Pyramid Texts; Old Kingdom funerary tradition is the primary attestation period',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed')
ON CONFLICT DO NOTHING;

-- Also link the four individual Sons to SRC_FAULKNER_PYRAMID_TEXTS
-- (they currently only have Pinch and Wilkinson)
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_FOUR_SONS_OF_HORUS', 'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 552 (§ 1360) names the Four Sons of Horus as divine guardians; the Pyramid Texts establish their collective function as protectors of the four viscera of the deceased king; their association with the four cardinal directions is also established in the PT'),
  ('ENT_EGY_IMSETY',             'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 552: Imsety (the human-headed Son of Horus) is named among the four guardians; he guards the liver and is protected by Isis; primary attestation in the Old Kingdom funerary corpus'),
  ('ENT_EGY_HAPY_SON_OF_HORUS',  'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 552: Hapy Son of Horus (baboon-headed; distinct from Hapy the Nile god) guards the lungs; protected by Nephthys; primary attestation in the Old Kingdom funerary corpus'),
  ('ENT_EGY_DUAMUTEF',           'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 552: Duamutef (jackal-headed Son of Horus; "he who worships his mother") guards the stomach; protected by Neith; primary attestation in the Old Kingdom funerary corpus'),
  ('ENT_EGY_QEBEHSENUEF',        'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 552: Qebehsenuef (falcon-headed Son of Horus; "he who refreshes his brothers") guards the intestines; protected by Selket; primary attestation in the Old Kingdom funerary corpus')
ON CONFLICT DO NOTHING;

-- ── B. Horus forms ────────────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  -- Haroeris (Horus the Elder; Hor-wer) — the oldest Horus form
  ('ENT_EGY_HAROERIS', 'PER_EGY_EARLY_DYNASTIC', 'high',
   'Haroeris (Horus the Elder, Hor-wer = "Great Horus") is one of the earliest attested Egyptian deities; his hawk iconography appears on Narmer Palette (c. 3100 BCE); as the sky-falcon who fights Seth, he is the divine prototype of the pharaoh; a predynastic and early dynastic Horus form distinct from the younger Horus who avenges Osiris',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_HAROERIS', 'PER_EGY_OLD_KINGDOM', 'high',
   'Haroeris is attested in the Pyramid Texts and Old Kingdom texts; his cult at Letopolis (Kom Ausim) is one of the oldest Horus cult centers; the two-eyed (solar + lunar) aspect of Haroeris is established in Old Kingdom theology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Harsiese (Horus Son of Isis; Hor-sa-Iset) — the avenging child
  ('ENT_EGY_HARSIESE', 'PER_EGY_OLD_KINGDOM', 'high',
   'Harsiese (Horus son of Isis; Hor-sa-Iset) is attested in the Pyramid Texts where the deceased king is identified with this specific Horus form as the posthumous child who avenges his father Osiris; PT Utterances repeatedly identify the king as "Horus, son of Osiris and Isis"',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),
  ('ENT_EGY_HARSIESE', 'PER_EGY_NEW_KINGDOM', 'high',
   'New Kingdom texts and images extensively develop Harsiese as the divine child raised secretly in the papyrus marshes of Chemmis; the Contendings of Horus and Seth (Papyrus Chester Beatty I, Ramesside period) is his primary New Kingdom narrative text',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- Harakhty (Horus of the Horizon; Ra-Harakhty in its solar composite form)
  ('ENT_EGY_HARAKHTY', 'PER_EGY_OLD_KINGDOM', 'high',
   'Harakhty ("Horus of the two horizons") is attested in the Pyramid Texts; PT Utterance 266 names Ra-Harakhty as the solar falcon at the horizon; Old Kingdom solar theology identifies the rising and setting sun as Horus at the horizon; his name appears in the nomen of Khafra and in pyramid texts',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),
  ('ENT_EGY_HARAKHTY', 'PER_EGY_NEW_KINGDOM', 'high',
   'New Kingdom solar theology makes Ra-Harakhty a dominant theological figure: the Amarna period (Akhenaten) explicitly identifies the Aten as "the living Ra-Harakhty who rejoices in the horizon"; the Book of the Dead and the Amduat consistently feature Ra-Harakhty as the solar deity who traverses the underworld at night',
   'SRC_HORNUNG_DUAT', 'reviewed'),

  -- Harsomtus (Horus who unites the Two Lands; Hor-sema-tawy)
  ('ENT_EGY_HARSOMTUS', 'PER_EGY_NEW_KINGDOM', 'medium',
   'Harsomtus (Hor-sema-tawy, "Horus who unites the two lands") is attested from the New Kingdom as a divine child deity associated with the theme of royal unification; the sema-tawy (union of the two lands) motif is Ancient but this specific Horus form as a named deity develops most clearly in the New Kingdom',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_HARSOMTUS', 'PER_EGY_PTOLEMAIC', 'high',
   'Harsomtus is especially prominent as the divine child of the sacred triad at Ptolemaic temples: at Edfu (child of Horus of Edfu and Hathor); at Dendera (child of Ra and Hathor); at Kom Ombo (child of Sobek-Ra and Hathor); the Ptolemaic temple texts provide the fullest ancient treatment of Harsomtus as a distinct named deity',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed')
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_HAROERIS',  'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'Haroeris (Horus the Elder) is named in the Pyramid Texts as a sky-falcon deity; Old Kingdom theological tradition distinguishes him from the posthumous Horus son of Osiris; PT attestation places his cult among the oldest documented in the corpus'),
  ('ENT_EGY_HARSIESE',  'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'Harsiese (Horus son of Isis) is attested in the Pyramid Texts as the divine form the deceased king assumes — the avenger of his father Osiris; PT utterances repeatedly invoke "Horus son of Isis" as the paradigm for royal resurrection and vengeance'),
  ('ENT_EGY_HARAKHTY',  'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'Ra-Harakhty (Horus of the horizon) is named in the Pyramid Texts; PT Utterance 266 and throughout: the solar falcon at the moment of rising and setting; the Old Kingdom solar theology of which Harakhty is the key figure is established in the PT')
ON CONFLICT DO NOTHING;

-- ── C. Elephantine / cataract deities ────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  -- Satet (Satis) — Elephantine; Nile inundation and the first cataract
  ('ENT_EGY_SATET', 'PER_EGY_EARLY_DYNASTIC', 'high',
   'Satis/Satet is attested from Early Dynastic inscriptions; the Khasekhemwy vase (Dynasty 2, c. 2670 BCE) at Hierakonpolis depicts her; she was a state deity at Elephantine from the earliest pharaonic period; her white-crown-with-antelope-horns iconography appears on Dynasty 1 objects',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_SATET', 'PER_EGY_OLD_KINGDOM', 'high',
   'Satet appears in the Pyramid Texts (PT Utterance 508: "Satis purifies you with water from Elephantine"); her role as the goddess who pours the purifying Nile flood waters over the deceased king is established in the Old Kingdom funerary corpus',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Anuket (Anukis) — cataract goddess; daughter of Satet
  ('ENT_EGY_ANUKET', 'PER_EGY_OLD_KINGDOM', 'high',
   'Anuket (Anukis; "the embracer") is attested from the Old Kingdom at Elephantine and the Nile cataracts; she is identified as the daughter of Khnum and Satet in the Elephantine triad; her earliest significant attestation is in Old Kingdom dedicatory inscriptions from the Elephantine region',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_ANUKET', 'PER_EGY_NEW_KINGDOM', 'high',
   'Anuket becomes more prominent in the New Kingdom under Thutmose III and later pharaohs who recorded donations to her temple at Seheil (just south of Elephantine); the Seheil inscriptions are her primary New Kingdom attestation; she is often depicted wearing a plumed crown of reeds',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed')
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_SATET', 'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 508: Satis/Satet purifies the deceased king with water from Elephantine; her role as the guardian of the first Nile cataract who pours the purifying flood water is established in the Pyramid Texts; among the oldest attested state deities in the corpus')
ON CONFLICT DO NOTHING;

-- ── D. Ogdoad (Hermopolitan primordial collective) ────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_EGY_OGDOAD', 'PER_EGY_OLD_KINGDOM', 'medium',
   'The Ogdoad (eight primordial deities of Hermopolis Magna: Nun/Naunet, Amun/Amaunet, Heh/Hauhet, Kuk/Kauket — representing primordial water, hiddenness, infinity, and darkness) has roots in Old Kingdom theology; the individual members Nun and Amun appear in the Pyramid Texts; the full systematization as an "eight" (Hmnyw, the Ogdoad) is attested from this period',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),
  ('ENT_EGY_OGDOAD', 'PER_EGY_MIDDLE_KINGDOM', 'high',
   'The Ogdoad as a systematized collective of eight primordial pairs is fully attested in the Coffin Texts (Middle Kingdom; c. 2055-1650 BCE); the Coffin Texts develop the Hermopolitan cosmogony where the Ogdoad creates itself in the primordial waters (Nun) and produces the sun on the primordial mound; the Middle Kingdom is the period of the Ogdoad''s theological consolidation',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_OGDOAD', 'PER_EGY_NEW_KINGDOM', 'high',
   'The New Kingdom Book of the Dead (spell 175) and the Amduat develop the Ogdoad''s role in the cosmological narrative; the Hermopolitan creation myth is integrated into New Kingdom royal theology; the Ogdoad''s connection to Thoth''s city (Khmun = Hermopolis) remains theologically significant throughout the New Kingdom',
   'SRC_HORNUNG_DUAT', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── E. Remaining entities ─────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  -- Ihy — child deity of music; son of Hathor and Horus at Dendera
  ('ENT_EGY_IHY', 'PER_EGY_OLD_KINGDOM', 'high',
   'Ihy (the sistrum-player; child god of music and joy) is named in the Pyramid Texts (PT Utterance 334: "Ihy, son of Hathor, golden one"); he represents the ecstatic joy produced by Hathor''s sistrum; the Dendera cult of Ihy as divine child is the New Kingdom/Ptolemaic elaboration of an Old Kingdom foundation',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Ash — desert and oasis god of the Western Desert
  ('ENT_EGY_ASH', 'PER_EGY_EARLY_DYNASTIC', 'high',
   'Ash is attested from Dynasty 1 wine-jar labels from Abydos where his name appears in association with Libyan oasis regions; he is one of the oldest attested Egyptian deities associated with the Western Desert and Libya; Wilkinson (2003) p. 193: Ash "is attested from the very beginning of Egyptian history"',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_ASH', 'PER_EGY_OLD_KINGDOM', 'high',
   'Ash appears in the Pyramid Texts as a protective deity of the Western Desert regions; his role as a seth-animal deity who guards the western lands connects him to the cosmic geography of the Old Kingdom funerary tradition',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Shai — personification of fate/destiny; weighing of the heart
  ('ENT_EGY_SHAI', 'PER_EGY_MIDDLE_KINGDOM', 'high',
   'Shai (fate/fortune personified; literally "that which has been ordained") is first clearly attested in Middle Kingdom Coffin Texts where the individual''s destiny at birth is established by Shai; the Coffin Texts are the primary Middle Kingdom source establishing Shai as a named divine entity',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_SHAI', 'PER_EGY_NEW_KINGDOM', 'high',
   'New Kingdom Book of the Dead (BD 25, BD 30) regularly includes Shai at the weighing of the heart alongside Thoth and Anubis; Shai represents the deceased''s allotted fate that is weighed against the feather of Maat; the New Kingdom funerary papyri are his primary extensive attestation',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- Reret — protective hippopotamus goddess
  ('ENT_EGY_RERET', 'PER_EGY_OLD_KINGDOM', 'high',
   'Reret ("the Sow") is an Old Kingdom hippopotamus goddess; she is associated with the constellation the Egyptians called "the Hippopotamus" (corresponding to Draco in modern astronomy); attested in Old Kingdom astronomical ceiling texts and protective amulet traditions; the hippopotamus as a protective deity figure is among the oldest Egyptian theological forms',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- Shesmetet — lioness goddess; fierce protective deity
  ('ENT_EGY_SHESMETET', 'PER_EGY_OLD_KINGDOM', 'high',
   'Shesmetet is attested in the Pyramid Texts (PT Utterance 317, § 508: Shesmetet protects the king); a fierce lioness-goddess connected to the protective sekhmet-type tradition; the Pyramid Texts are her earliest textual attestation; her role as the necklace (shesmet) deity connects her to protective amulet theology',
   'SRC_FAULKNER_PYRAMID_TEXTS', 'reviewed'),

  -- Heryshaf — ram god of Herakleopolis (Ihnasya el-Medina)
  ('ENT_EGY_HERYSHAF', 'PER_EGY_OLD_KINGDOM', 'high',
   'Heryshaf ("He who is upon his lake") is the principal deity of Herakleopolis Magna (ancient Henen-nesut / Ihnasya el-Medina); attested from Old Kingdom inscriptions; he is a ram-headed creator and fertility deity associated with the primordial lake; Old Kingdom temples at Herakleopolis document his early cult',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_HERYSHAF', 'PER_EGY_FIRST_INTERMEDIATE', 'high',
   'Heryshaf becomes politically significant when Herakleopolis becomes the royal capital of the 9th and 10th Dynasties (First Intermediate Period, c. 2160-2055 BCE); the Herakleopolitan kings held him as their dynastic deity; his cult and theology are actively promoted during this period of Herakleopolitan supremacy',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- Banebdjedet — ram deity of Mendes (Pe-ba-neb-djed = "he is the ba-soul, lord of Djedet")
  ('ENT_EGY_BANEBDJEDET', 'PER_EGY_EARLY_DYNASTIC', 'high',
   'Banebdjedet (the ram of Mendes; "Ba-soul, lord of Djedet") is attested from Early Dynastic texts at Mendes in the Nile Delta; he is one of the most ancient ram deities; his ram-headed solar theology connects him to the primordial ba-soul of the sun; among the earliest attested Delta deities',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),
  ('ENT_EGY_BANEBDJEDET', 'PER_EGY_NEW_KINGDOM', 'high',
   'New Kingdom texts include Banebdjedet as a divine counselor in the Contendings of Horus and Seth (Papyrus Chester Beatty I, Ramesside period): he suggests writing to Neith for advice on who should inherit the rulership; this Ramesside text provides his most detailed surviving characterization',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- Neferhotep — local deity; "perfect in peace/satisfaction"
  ('ENT_EGY_NEFERHOTEP', 'PER_EGY_MIDDLE_KINGDOM', 'low',
   'Neferhotep as a distinct local deity (rather than a pharaonic name or divine epithet) is most clearly documented from the Middle Kingdom; he appears as a deity at Abydos associated with Osiris''s domain; confidence is low because "Neferhotep" functions as an epithet for multiple deities (Osiris, Ptah) and a given name for the 13th Dynasty king Neferhotep I; the entity''s specific cult context requires further verification (per original short note)',
   'SRC_WILKINSON_EGYPTIAN_GODS', 'reviewed'),

  -- Ptah-Seker-Osiris — syncretic funerary composite
  ('ENT_EGY_PTAH_SEKER_OSIRIS', 'PER_EGY_NEW_KINGDOM', 'high',
   'The composite Ptah-Seker-Osiris unifies three funerary aspects: Ptah (creation/craftsman; Memphis), Seker (necropolis deity of the Memphis plateau), and Osiris (lord of the dead); this composite emerges in the New Kingdom as an expression of the unification of creation, death, and resurrection theology under one divine figure; New Kingdom funerary texts are the earliest systematic attestation',
   'SRC_HORNUNG_DUAT', 'reviewed'),
  ('ENT_EGY_PTAH_SEKER_OSIRIS', 'PER_EGY_PTOLEMAIC', 'high',
   'Ptah-Seker-Osiris becomes a major figure in Ptolemaic funerary religion; the Ptolemaic wooden coffin traditions and funerary statuettes of Ptah-Seker-Osiris (a characteristic Ptolemaic-period artifact type) are among the most common surviving religious objects from this period; the composite represents the totality of the funerary divine process',
   'SRC_HORNUNG_DUAT', 'reviewed')
ON CONFLICT DO NOTHING;

-- Also add Pyramid Texts source links for entities attested there but currently only
-- having Pinch/Wilkinson:
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_EGY_IHY',       'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 334: "Ihy, son of Hathor, golden one" — Ihy is named in the Pyramid Texts as the divine child of Hathor who personifies the ecstatic joy of her music; his Old Kingdom attestation in the PT is his earliest surviving textual reference'),
  ('ENT_EGY_SHESMETET', 'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 317 and elsewhere: Shesmetet (the lioness goddess associated with the shesmet necklace) is invoked as a protective deity in the Pyramid Texts; her earliest textual attestation is in the Old Kingdom funerary corpus'),
  ('ENT_EGY_ASH',       'SRC_FAULKNER_PYRAMID_TEXTS', 'secondary_reference',
   'PT references to the Western Desert protective deity traditions include Ash; he guards the western lands that correspond to the underworld entrance in Old Kingdom cosmological geography'),
  ('ENT_EGY_SATET',     'SRC_FAULKNER_PYRAMID_TEXTS', 'primary_attestation',
   'PT Utterance 508: Satis/Satet of Elephantine purifies the deceased king with Nile cataract water; established as a purification deity in the Old Kingdom funerary tradition'),
  ('ENT_EGY_OGDOAD',    'SRC_FAULKNER_PYRAMID_TEXTS', 'secondary_reference',
   'Individual Ogdoad members (especially Nun the primordial water and Amun the hidden one) appear in the Pyramid Texts; the full Ogdoad as an eight-fold collective is referenced; the Hermopolitan cosmogony is the background for the PT''s primordial water theology')
ON CONFLICT DO NOTHING;

-- ── Verification ─────────────────────────────────────────────────────────────

-- Confirm 0 remaining unperiodized Egyptian entities
SELECT COUNT(*) AS remaining_unperiodized_egyptian
FROM entities e
WHERE e.tradition = 'Egyptian'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id = e.entity_id);

-- Period distribution for Egyptian tradition
SELECT p.period_id, p.period_name, COUNT(DISTINCT ep.entity_id) AS entities
FROM periods p
JOIN entity_periods ep ON ep.period_id = p.period_id
JOIN entities e ON e.entity_id = ep.entity_id AND e.tradition = 'Egyptian'
WHERE p.period_id LIKE 'PER_EGY%'
GROUP BY p.period_id, p.period_name ORDER BY p.start_year;

SELECT * FROM v_release_metrics;

COMMIT;
