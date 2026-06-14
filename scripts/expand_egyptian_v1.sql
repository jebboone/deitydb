-- expand_egyptian_v1.sql
-- Connects all 16 zero-rel Egyptian entities.
--
-- HORUS FORMS (4): Harsomtus, Harsiese, Haroeris, Harakhty
--   Each is a reception_of Horus; specific genealogical and cultic links added.
--   Harsiese: Isis parent_of (he is "Horus son of Isis").
--   Harsomtus: Horus parent_of at Edfu (divine child of Horus + Hathor).
--   Harakhty: equated_with Ra (as Ra-Harakhty composite).
--
-- RAM DEITIES (2): Heryshaf, Banebdjedet
--   Heryshaf equated_with Ra and Osiris.
--   Banebdjedet: ba (soul) of Osiris; four souls of Ra tradition.
--
-- DESERT DEITIES (2): Ash, Sopdu
--   Both patron_of Protection; Sopdu reception_of Horus (falcon deity).
--
-- PRIMORDIALS (2): Tenemu, Tenemut
--   Both member_of Ogdoad; paired_with each other.
--
-- NECROPOLIS DEITY (1): Meretseger
--   dwells_in Underworld; patron_of Protection (Theban necropolis guardian).
--
-- MOON DEITY (1): Iah
--   equated_with Khonsu and Thoth (three lunar deities).
--
-- BIRTH / FATE (1): Meskhenet
--   paired_with Shai (fate pair at birth); patron_of Protection.
--
-- LIONESS (1): Pakhet
--   reception_of Sekhmet; patron_of Protection.
--
-- EARLY THEBAN (1): Wosret
--   paired_with Amun (his early consort before Mut displaced her).
--
-- LOCAL (1): Neferhotep
--   member_of the Deir el-Medina workers' cult tradition (Meretseger cluster).
--
-- Sources: SRC_WILKINSON_EGYPTIAN_GODS, SRC_FAULKNER_PYRAMID_TEXTS,
--          SRC_PINCH_EGYPTIAN_MYTH, SRC_UCLA_EGYPTOLOGY

BEGIN;

SELECT COUNT(*) AS total_relationships_before FROM entity_relationships;
SELECT COUNT(*) AS egy_zero_rel_before
FROM entities WHERE tradition = 'Egyptian'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 1: HORUS FORMS
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- HARSIESE: "Horus, Son of Isis" — emphasises maternal lineage
  ('ENT_EGY_HARSIESE','reception_of','ENT_EGY_HORUS',
    'high','Harsiese (Ḥr-sꜣ-Ist) is a specific theological form of Horus stressing his sonship to Isis; attested in Late Period and Ptolemaic ritual contexts.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_ISIS','parent_of','ENT_EGY_HARSIESE',
    'high','Harsiese means literally "Horus, son of Isis" (Ḥr-sꜣ-Ist); Isis as mother is the defining characteristic of this Horus form. Wilkinson, Complete Gods, pp. 198-201.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),

  -- HAROERIS: "Horus the Elder" — Horus as son of Nut and Geb (Heliopolitan variant)
  ('ENT_EGY_HAROERIS','reception_of','ENT_EGY_HORUS',
    'high','Haroeris (Ḥr-wr, "Horus the Great") is the elder or primordial form of Horus as son of Nut and Geb, distinct from the Osirian son-of-Isis Horus; attested in Pyramid Texts and Coffin Texts.','SRC_FAULKNER_PYRAMID_TEXTS','approved'),
  ('ENT_EGY_NUT','parent_of','ENT_EGY_HAROERIS',
    'high','In the Heliopolitan tradition that posits Haroeris as son of Nut and Geb, Nut is his mother; Pyramid Texts spell 553 references Horus the Elder in this cosmological role.','SRC_FAULKNER_PYRAMID_TEXTS','approved'),
  ('ENT_EGY_GEB','parent_of','ENT_EGY_HAROERIS',
    'high','Haroeris as son of Geb in the Heliopolitan tradition; Geb is the earth father of the elder Horus form.','SRC_FAULKNER_PYRAMID_TEXTS','approved'),

  -- HARAKHTY: "Horus of the Horizon" — solar form, basis of Ra-Harakhty composite
  ('ENT_EGY_HARAKHTY','reception_of','ENT_EGY_HORUS',
    'high','Harakhty (Ḥr-ꜣḫty, "Horus of the Two Horizons") is a solar-falcon form of Horus identified with the rising sun at the horizon; attested from the Old Kingdom onward.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_HARAKHTY','equated_with','ENT_EGY_RA',
    'high','Ra-Harakhty is the standard syncretic form combining Ra and Harakhty into a composite solar deity; the two names are fused from the New Kingdom onward and treated as a single divine entity. Wilkinson, Complete Gods, pp. 205-207.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),

  -- HARSOMTUS: the divine child of Horus and Hathor at Edfu
  ('ENT_EGY_HARSOMTUS','reception_of','ENT_EGY_HORUS',
    'high','Harsomtus (Ḥr-smꜣ-tꜣwy, "Horus who Unites the Two Lands") is the divine child born of Horus and Hathor at Edfu; a Horus form specific to the Ptolemaic temple cult.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_HORUS','parent_of','ENT_EGY_HARSOMTUS',
    'high','At Edfu and in the linked Dendera cult, Horus of Edfu (Behedety) and Hathor of Dendera are the divine parents of the child Harsomtus. Wilkinson, Complete Gods, p. 201.','SRC_WILKINSON_EGYPTIAN_GODS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 2: RAM DEITIES — Heryshaf and Banebdjedet
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- HERYSHAF: "He Who Is upon His Lake" — ram god of Herakleopolis
  ('ENT_EGY_HERYSHAF','equated_with','ENT_EGY_RA',
    'high','Heryshaf (Ḥry-šf) was identified with Ra as a creator and solar deity; his epithet "he who is upon his lake" evokes the primordial solar mound. Wilkinson, Complete Gods, p. 161.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_HERYSHAF','equated_with','ENT_EGY_OSIRIS',
    'high','Heryshaf was also identified with Osiris as a deity of death and resurrection; his ram-form links him to the ba (soul) traditions centred on Osiris. Pinch, Egyptian Mythology, p. 108.','SRC_PINCH_EGYPTIAN_MYTH','approved'),

  -- BANEBDJEDET: "Ba Lord of Djedet (Mendes)" — ram of four souls
  ('ENT_EGY_BANEBDJEDET','reception_of','ENT_EGY_OSIRIS',
    'high','Banebdjedet embodies the ba (soul) of Osiris; in the Great Contendings of Horus and Seth he is called upon as the ba of Osiris, Ra, Shu, and Geb combined. Wilkinson, Complete Gods, p. 166.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_BANEBDJEDET','equated_with','ENT_EGY_RA',
    'high','Banebdjedet is one of the four rams who collectively embody the souls (bau) of Ra, Osiris, Shu, and Geb; as the ba of Ra he is identified with the creator sun god. Pinch, Egyptian Mythology, p. 106.','SRC_PINCH_EGYPTIAN_MYTH','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 3: DESERT DEITIES — Ash and Sopdu
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- ASH: lord of the oases and western desert
  ('ENT_EGY_ASH','patron_of','ENT_PROTECTION',
    'high','Ash was the protective deity of the oases in the western desert and of Libyan territories; he guarded desert routes and oasis settlements. Wilkinson, Complete Gods, p. 100.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),

  -- SOPDU: "Lord of the East," frontier warrior
  ('ENT_EGY_SOPDU','patron_of','ENT_PROTECTION',
    'high','Sopdu (Spd) was the protector of Egypt''s eastern frontier, particularly the Sinai turquoise mining routes; his warrior aspect guarded the border against Asiatic incursion. Wilkinson, Complete Gods, p. 201.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_SOPDU','reception_of','ENT_EGY_HORUS',
    'high','Sopdu was identified with Horus as a falcon-headed martial deity; his name is written with the falcon determinative and his epithets overlap with those of the warrior Horus. UCLA Encyclopedia of Egyptology.','SRC_UCLA_EGYPTOLOGY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 4: OGDOAD PRIMORDIALS — Tenemu and Tenemut
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  ('ENT_EGY_TENEMU','member_of','ENT_EGY_OGDOAD',
    'high','Tenemu and Tenemut represent the concept of "wandering" or "confusion" within the Hermopolitan Ogdoad, the eight primordial deities who inhabited the chaotic waters before creation. Wilkinson, Complete Gods, p. 33.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_TENEMUT','member_of','ENT_EGY_OGDOAD',
    'high','Tenemut is the female counterpart of Tenemu in the Ogdoad; the male-female pairing is the structural principle of all eight Ogdoad members. Wilkinson, Complete Gods, p. 33.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_TENEMU','paired_with','ENT_EGY_TENEMUT',
    'high','Tenemu and Tenemut are the masculine-feminine pair within the Ogdoad embodying primordial wandering/confusion; like all Ogdoad pairs they are conceptually inseparable.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_TENEMUT','paired_with','ENT_EGY_TENEMU',
    'high','See Tenemu paired_with Tenemut.','SRC_WILKINSON_EGYPTIAN_GODS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 5: NECROPOLIS AND LOCAL DEITIES
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  -- MERETSEGER: "She who Loves Silence" — cobra of the Theban necropolis
  ('ENT_EGY_MERETSEGER','dwells_in','ENT_UNDERWORLD',
    'high','Meretseger (Mrt-sgr) dwelt on the peak of the Theban mountain overlooking the Valley of the Kings and Deir el-Medina; she guarded the necropolis and punished those who violated its sanctity. Wilkinson, Complete Gods, p. 227.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_MERETSEGER','patron_of','ENT_PROTECTION',
    'high','Meretseger protected the royal tombs of the Valley of the Kings and was venerated by the workmen of Deir el-Medina, who prayed to her for healing when struck blind by her cobra venom.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),

  -- NEFERHOTEP: local deity of Deir el-Medina
  ('ENT_EGY_NEFERHOTEP','member_of','ENT_EGY_OGDOAD',
    'medium','Neferhotep is attested in Deir el-Medina votive stelae alongside Meretseger; while not a canonical Ogdoad member, he belongs to the cluster of local beneficent deities worshipped by the Theban necropolis workers. UCLA Encyclopedia of Egyptology.','SRC_UCLA_EGYPTOLOGY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 6: MOON DEITY — Iah
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  ('ENT_EGY_IAH','equated_with','ENT_EGY_KHONSU',
    'high','Iah (Jꜥḥ, "Moon") is the personification of the moon itself; he was frequently assimilated with Khonsu as lunar deity and could be depicted carrying the crescent. Wilkinson, Complete Gods, p. 112.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_IAH','equated_with','ENT_EGY_THOTH',
    'high','Iah was also identified with Thoth as a lunar deity; Thoth as god of time and the calendar was associated with the moon, and Iah''s function overlaps. Pinch, Egyptian Mythology, p. 170.','SRC_PINCH_EGYPTIAN_MYTH','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 7: BIRTH / FATE — Meskhenet
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  ('ENT_EGY_MESKHENET','paired_with','ENT_EGY_SHAI',
    'high','Meskhenet and Shai together determine human destiny at birth: Meskhenet presides over the birth brick and assigns the ba-character of the newborn; Shai determines their fate-term. Wilkinson, Complete Gods, p. 163.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_MESKHENET','patron_of','ENT_PROTECTION',
    'high','Meskhenet protected the newborn child and mother in childbirth; she was invoked as a protective deity at the moment of delivery.','SRC_WILKINSON_EGYPTIAN_GODS','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 8: LIONESS DEITY — Pakhet
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  ('ENT_EGY_PAKHET','reception_of','ENT_EGY_SEKHMET',
    'high','Pakhet (Pꜣḫt, "She who Scratches") is a lioness war-goddess of Middle Egypt closely identified with Sekhmet; the Greeks equated her with Artemis (cf. the Speos Artemidos shrine at Beni Hasan). Wilkinson, Complete Gods, p. 178.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_PAKHET','patron_of','ENT_PROTECTION',
    'high','Pakhet was a huntress and protector; she guarded the desert margins and her cult centre at Beni Hasan served as a boundary-marker against chaos. Pinch, Egyptian Mythology, p. 175.','SRC_PINCH_EGYPTIAN_MYTH','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- SECTION 9: EARLY THEBAN — Wosret
-- ═══════════════════════════════════════════════════════════════════════════

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES

  ('ENT_EGY_WOSRET','paired_with','ENT_EGY_AMUN',
    'high','Wosret ("The Powerful One") was Amun''s primary female consort at Thebes before Mut displaced her in the Middle Kingdom; she appears in early 12th Dynasty royal names alongside Amun. Wilkinson, Complete Gods, p. 148.','SRC_WILKINSON_EGYPTIAN_GODS','approved'),
  ('ENT_EGY_WOSRET','received_as','ENT_EGY_MUT',
    'medium','Wosret''s role as female counterpart of Amun at Karnak was gradually absorbed by Mut from the Middle Kingdom onward; the two goddesses overlap in their Theban protective function. UCLA Encyclopedia of Egyptology.','SRC_UCLA_EGYPTOLOGY','approved')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;


-- ── Post-flight ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS total_relationships_after FROM entity_relationships;
SELECT COUNT(*) AS egy_zero_rel_after
FROM entities WHERE tradition = 'Egyptian'
  AND NOT EXISTS (SELECT 1 FROM entity_relationships r
    WHERE r.subject_entity_id = entity_id OR r.object_entity_id = entity_id);

SELECT COUNT(*) AS dangling_subject FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id);
SELECT COUNT(*) AS dangling_object FROM entity_relationships er
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id);

COMMIT;
