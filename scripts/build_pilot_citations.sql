-- ============================================================================
-- DeityDB — Citation Remediation PILOT  (scripts/build_pilot_citations.sql)
-- ----------------------------------------------------------------------------
-- Demonstrates the target standard: replace AI-paraphrase short_note prose with
-- VERBATIM excerpts from public-domain primary texts, each carrying a precise
-- locus, named translator+year, retrievable URL, and an evidence grade.
--
-- Every quote below was retrieved verbatim on 2026-06-17 from the public-domain
-- edition at the recorded URL (Wikisource). NOTHING is quoted from memory.
-- Idempotent: safe to re-run.
-- ============================================================================

CREATE TABLE IF NOT EXISTS entity_citations (
    citation_id      text PRIMARY KEY,
    entity_id        text NOT NULL REFERENCES entities(entity_id),
    source_id        text REFERENCES sources(source_id),
    work_title       text NOT NULL,         -- e.g. 'Homeric Hymn 23 (To Zeus)'
    locus            text NOT NULL,         -- e.g. 'lines 1-4'
    quote            text,                  -- verbatim excerpt (NULL for Track-2 source pointers)
    translator       text,
    translation_year integer,
    source_url       text,                  -- retrievable edition (NULL where the source has no URL)
    evidence_grade   text NOT NULL,         -- primary-verbatim | heresiological-verbatim
    evidence_note    text,                  -- scholarly caveat (e.g. hostile witness)
    verified_on      date,
    verify_method    text,
    display_order    integer DEFAULT 1,
    needs_review     boolean DEFAULT false,  -- flagged for human verification
    review_reason    text,                   -- why flagged (e.g. OCR source; non-line-keyed translation)
    original_text_url text                   -- link to the original-language text (Latin/Greek) where the English is a translation
);

CREATE INDEX IF NOT EXISTS idx_entity_citations_entity ON entity_citations(entity_id);

INSERT INTO entity_citations
 (citation_id, entity_id, source_id, work_title, locus, quote, translator, translation_year,
  source_url, evidence_grade, evidence_note, verified_on, verify_method, display_order)
VALUES

-- 1. ZEUS — Homeric Hymn 23 (complete) ---------------------------------------
('CIT_ZEUS_HH23', 'ENT_ZEUS', 'SRC_HOMERIC_HYMNS',
 'Homeric Hymn 23 (To Zeus)', 'lines 1-4',
 'I will sing of Zeus, chiefest among the gods and greatest, all-seeing, the lord of all, the fulfiller who whispers words of wisdom to Themis as she sits leaning towards him. Be gracious, all-seeing Son of Cronos, most excellent and great!',
 'Hugh G. Evelyn-White', 1914,
 'https://en.wikisource.org/wiki/Hesiod,_the_Homeric_Hymns_and_Homerica/Hymn_XXIII_(To_Zeus)',
 'primary-verbatim', NULL, DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Loeb edition (Wikisource)', 1),

-- 2. HECATE — Hesiod, Theogony 411 ff. ---------------------------------------
('CIT_HECATE_THEOG', 'ENT_HECATE', 'SRC_HESIOD_THEOGONY',
 'Hesiod, Theogony (the praise of Hecate)', 'lines 411-415 (within 411-452)',
 'whom Zeus the son of Cronos honoured above all. He gave her splendid gifts, to have a share of the earth and the unfruitful sea. She received honour also in starry heaven, and is honoured exceedingly by the deathless gods.',
 'Hugh G. Evelyn-White', 1914,
 'https://en.wikisource.org/wiki/Hesiod,_the_Homeric_Hymns_and_Homerica/The_Theogony',
 'primary-verbatim',
 'Hesiod gives Hecate exceptional honours across earth, sea, and heaven — the fullest early cult notice of the goddess.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Loeb edition (Wikisource)', 1),

-- 3. DEMETER — Homeric Hymn 2, opening -------------------------------------
('CIT_DEMETER_HH2', 'ENT_DEMETER', 'SRC_HOMERIC_HYMNS',
 'Homeric Hymn 2 (To Demeter)', 'lines 1-3',
 'I begin to sing of rich-haired Demeter, awful goddess--of her and her trim-ankled daughter whom Aidoneus rapt away, given to him by all-seeing Zeus the loud-thunderer.',
 'Hugh G. Evelyn-White', 1914,
 'https://en.wikisource.org/wiki/Hesiod,_the_Homeric_Hymns_and_Homerica/Hymn_II_(To_Demeter)',
 'primary-verbatim',
 'The hymn is the foundational narrative of the Eleusinian Mysteries; this opening states the rape of Persephone.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Loeb edition (Wikisource)', 1),

-- 4. APOLLO — Homeric Hymn 3, opening --------------------------------------
('CIT_APOLLO_HH3', 'ENT_APOLLO', 'SRC_HOMERIC_HYMNS',
 'Homeric Hymn 3 (To Apollo)', 'lines 1-4',
 'I will remember and not be unmindful of Apollo who shoots afar. As he goes through the house of Zeus, the gods tremble before him and all spring up from their seats when he draws near, as he bends his bright bow.',
 'Hugh G. Evelyn-White', 1914,
 'https://en.wikisource.org/wiki/Hesiod,_the_Homeric_Hymns_and_Homerica/Hymn_III_(To_Apollo)',
 'primary-verbatim', NULL, DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Loeb edition (Wikisource)', 1),

-- 5. DIONYSUS — Homeric Hymn 7, opening ------------------------------------
('CIT_DIONYSUS_HH7', 'ENT_DIONYSUS', 'SRC_HOMERIC_HYMNS',
 'Homeric Hymn 7 (To Dionysus)', 'lines 1-6',
 'I will tell of Dionysus, the son of glorious Semele, how he appeared on a jutting headland by the shore of the fruitless sea, seeming like a stripling in the first flush of manhood: his rich, dark hair was waving about him, and on his strong shoulders he wore a purple robe.',
 'Hugh G. Evelyn-White', 1914,
 'https://en.wikisource.org/wiki/Hesiod,_the_Homeric_Hymns_and_Homerica/Hymn_VII_(To_Dionysus)',
 'primary-verbatim',
 'The hymn relates Dionysus'' capture by Tyrsenian pirates and his epiphany — an early witness to his power over mortals at sea.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Loeb edition (Wikisource)', 1),

-- 6. ODIN — Poetic Edda, Havamal 139 (Runatal) ----------------------------
('CIT_ODIN_HAVAMAL139', 'ENT_NOR_ODIN', 'SRC_POETIC_EDDA',
 'Poetic Edda, Havamal (Runatal)', 'stanza 139',
 'I ween that I hung on the windy tree, / Hung there for nights full nine; / With the spear I was wounded, and offered I was / To Othin, myself to myself, / On the tree that none may ever know / What root beneath it runs.',
 'Henry Adams Bellows', 1923,
 'https://en.wikisource.org/wiki/The_Poetic_Edda_(tr._Bellows)/Hovamol',
 'primary-verbatim',
 'Odin''s self-sacrifice on the windy tree (Yggdrasil) to win the runes — the central myth of his wisdom-acquisition.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain edition (Wikisource)', 1),

-- 7. SOPHIA — Irenaeus, Against Heresies I.2.2 (hostile witness) -----------
('CIT_SOPHIA_AH122', 'ENT_GNO_SOPHIA', 'SRC_IRENAEUS_AH',
 'Irenaeus, Against Heresies', 'Book I, ch. 2, sec. 2 (I.2.2)',
 'But there rushed forth in advance of the rest that AEon who was much the latest of them, and was the youngest of the Duodecad which sprang from Anthropos and Ecclesia, namely Sophia, and suffered passion apart from the embrace of her consort Theletos.',
 'Roberts & Rambaut (Ante-Nicene Fathers, Vol. I)', 1885,
 'https://en.wikisource.org/wiki/Ante-Nicene_Fathers/Volume_I/IRENAEUS/Against_Heresies:_Book_I',
 'heresiological-verbatim',
 'HOSTILE WITNESS: Irenaeus is a heresiologist reporting the Valentinian system in order to refute it; this describes the fall (passion) of the youngest Aeon, Sophia, not a self-description by Valentinians.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Ante-Nicene Fathers edition (Wikisource)', 1),

-- 8. OSIRIS — Papyrus of Ani, Hymn to Osiris ------------------------------
('CIT_OSIRIS_ANI', 'ENT_EGY_OSIRIS', 'SRC_BUDGE_PAPYRUS_ANI',
 'The Papyrus of Ani, Hymn to Osiris', 'Hymn to Osiris Un-Nefer (opening)',
 'Homage to thee, Osiris, Lord of eternity, King of the Gods, whose names are manifold, whose forms are holy, thou being of hidden form in the temples, whose Ka is holy.',
 'E. A. Wallis Budge', 1913,
 'https://en.wikisource.org/wiki/The_Papyrus_of_Ani_(1913)',
 'primary-verbatim',
 'Funerary hymn opening the Papyrus of Ani; "Un-Nefer" (Wennefer) is Osiris as the resurrected, beneficent king of the dead.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Budge edition (Wikisource)', 1),

-- 9. RA — Papyrus of Ani, Hymn of Praise to Ra ----------------------------
('CIT_RA_ANI', 'ENT_EGY_RA', 'SRC_BUDGE_PAPYRUS_ANI',
 'The Papyrus of Ani, Hymn of Praise to Ra', 'Hymn to Ra (opening address)',
 'Homage to thee, O thou who hast come as Khepera, Khepera the creator of the gods.',
 'E. A. Wallis Budge', 1913,
 'https://en.wikisource.org/wiki/The_Papyrus_of_Ani_(1913)',
 'primary-verbatim',
 'Solar hymn identifying Ra with Khepera, the self-creating morning aspect of the sun-god.',
 DATE '2026-06-17',
 'verbatim web-retrieval from public-domain Budge edition (Wikisource)', 1)

ON CONFLICT (citation_id) DO UPDATE SET
   entity_id=EXCLUDED.entity_id, source_id=EXCLUDED.source_id, work_title=EXCLUDED.work_title,
   locus=EXCLUDED.locus, quote=EXCLUDED.quote, translator=EXCLUDED.translator,
   translation_year=EXCLUDED.translation_year, source_url=EXCLUDED.source_url,
   evidence_grade=EXCLUDED.evidence_grade, evidence_note=EXCLUDED.evidence_note,
   verified_on=EXCLUDED.verified_on, verify_method=EXCLUDED.verify_method,
   display_order=EXCLUDED.display_order;

-- Public view (house style: v_public_*) --------------------------------------
DROP VIEW IF EXISTS v_public_entity_citations;
CREATE VIEW v_public_entity_citations AS
SELECT c.entity_id, e.canonical_name, e.tradition,
       c.work_title, c.locus, c.quote, c.translator, c.translation_year,
       c.source_url, c.original_text_url, c.evidence_grade, c.evidence_note,
       c.needs_review, c.review_reason, c.display_order
FROM entity_citations c
JOIN entities e ON e.entity_id = c.entity_id
ORDER BY e.canonical_name, c.display_order;

-- Verification report ---------------------------------------------------------
\echo '--- pilot citations applied ---'
SELECT count(*) AS citations, count(DISTINCT entity_id) AS entities,
       count(*) FILTER (WHERE evidence_grade LIKE '%verbatim%') AS verbatim
FROM entity_citations;
