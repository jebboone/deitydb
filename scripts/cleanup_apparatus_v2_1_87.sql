-- cleanup_apparatus_v2_1_87.sql — apparatus-bleed cleanup, round 2
--
-- Round 1 (v2.1.24, cleanup_apparatus_citations.sql) caught 48 rows but its signal
-- set missed dot-leaders, "Digitized by", forewords/title pages, translator notes,
-- ETCSL incipit concordances and bare SGML entities. This pass covers those.
--
-- Every row below was read in full by hand. Automated classification over-flags
-- badly here (legitimate primary name-catalogues look like indexes), so the
-- regex was used only to nominate candidates, never to decide.
--
-- Idempotent: all statements are guarded on current state.

BEGIN;

-- 1. Pure apparatus: TOC, index, title page, foreword, translator footnote,
--    editorial commentary, incipit concordance, bibliography. No source text
--    present, or source text too OCR-damaged to salvage. Blank to an honest
--    pointer; work_title/locus keep the attribution for a later re-anchor pass.
UPDATE entity_citations SET
    quote = NULL,
    evidence_grade = 'primary-uncited',
    verify_method = 'apparatus-cleanup v2 re-point (2026-09-18)',
    needs_review = true,
    review_reason = 'Quote was translator/editor apparatus or scan furniture, not source text; needs re-anchor to a clean edition.'
WHERE citation_id IN (
    -- Malory tables of contents (dot leaders + page numbers)
    'CIT_ART_ELAINE_ASTOLAT_MALORY','CIT_ART_EXCALIBUR_MALORY',
    'CIT_ART_MORDRED_MALORY','CIT_ART_PELLINORE_MALORY',
    -- Picatrix: Warburg Institute foreword and a plate caption
    'CIT_AST_DECANS_PICATR','CIT_AST_PLANETARY_SPIRITS_PICATR',
    -- Frazer's footnotes / introduction to Apollodorus
    'CIT_ERECHTHEUS_APOLLO','CIT_MELAMPUS_APOLLO',
    -- Athanassakis & Wolkow notes to the Orphic Hymns
    'CIT_EUBOULEUS_ORPHIC','CIT_MELINOE_ORPHIC','CIT_PHYSIS_ORPHIC',
    -- Darmesteter footnotes
    'CIT_GOOD_MIND_AVESTA','CIT_ZOR_RASHNU_AVESTA',
    -- A study guide's index, not Guillaume's translation of Ibn Ishaq
    'CIT_ISL_ABU_TALIB_IBNISH','CIT_ISL_JAFAR_IBNISH',
    -- R. H. Charles's notes to 1 Enoch
    'CIT_ISR_GABRIEL_ENOCH1','CIT_ISR_NEPHILIM_ENOCH1',
    'CIT_ISR_RAGUEL_ENOCH1','CIT_ISR_RAPHAEL_ENOCH1',
    -- Odeberg's notes to 3 Enoch
    'CIT_JM_RADUERIEL_ENOCH3','CIT_JM_ZIQIEL_ENOCH3',
    -- Morgan's TOC + introduction to Sepher ha-Razim
    'CIT_JM_SEVEN_FIRMAMENTS_HARAZI',
    -- Gardner & Lieu editorial commentary
    'CIT_MANICH_JESUS_PATIBILIS_MANICH','CIT_MANICH_LIGHT_PARTICLES_MANICH',
    'CIT_MANICH_WORLD_LIGHT_MANICH',
    -- Ginza table of contents
    'CIT_MAN_WORLD_LIGHT_GINZA',
    -- Ventris & Chadwick title page, and a smiths/bronze table
    'CIT_MYC_PANTHEON_VENTRI','CIT_MYC_TN316_VENTRI',
    -- Golden Legend tables of contents
    'CIT_SAINT_BECKET_GOLDEN','CIT_SAINT_COSMAS_DAMIAN_GOLDEN',
    'CIT_SAINT_DOMINIC_GOLDEN','CIT_SAINT_FRANCIS_GOLDEN',
    -- Golden Legend bodies: real Caxton, but the Google scan interleaves running
    -- heads and marginal glosses mid-sentence and the OCR is badly damaged
    -- ("Jitst of his name", "jJ S. die came", "Mid mother"). A clean Caxton text
    -- is needed; polishing this scan would not produce a faithful quote.
    'CIT_CHR_CHRISTOPHER_GOLDEN','CIT_CHR_MARGARET_GOLDEN','CIT_CHR_SEBASTIAN_GOLDEN',
    'CIT_SAINT_DENIS_GOLDEN','CIT_SAINT_GEORGE_GOLDEN','CIT_SAINT_GILES_GOLDEN',
    -- ETCSL incipit concordances (name + dotted catalogue number runs)
    'CIT_MES_NISABA_ETCSL','CIT_MES_DUMUZI_TAMMUZ_ETCSL','CIT_MES_LUGALBANDA_ETCSL',
    'CIT_MES_NANNA_SIN_ETCSL','CIT_MES_NINURTA_ETCSL',
    -- Modern secondary bibliography, not a Nag Hammadi tractate
    'CIT_VAL_SOTER_NHC_ME'
)
AND quote IS NOT NULL;

-- 2. Mis-anchor: the quote is the Life of S. Eugenia, a different saint entirely.
UPDATE entity_citations SET
    review_reason = 'Quote was mis-anchored to the Life of S. Eugenia, not Catherine of Alexandria; re-anchor required.'
WHERE citation_id = 'CIT_SAINT_CATHERINE_ALEX_GOLDEN';

-- 3. Ventris & Chadwick, Documents in Mycenaean Greek: these rows carry genuine
--    content, but it is the authors' own commentary and their translations of the
--    tablets, in an in-copyright scholarly edition. 'primary-verbatim' implied
--    Mycenaean tablet text. Re-grade to secondary and keep the quote.
UPDATE entity_citations SET
    evidence_grade = 'secondary',
    verify_method  = 'apparatus-cleanup v2 re-grade (2026-09-18): modern scholarly edition, not tablet text',
    needs_review   = true,
    review_reason  = 'Ventris & Chadwick commentary/translation — secondary scholarship, graded accordingly.'
WHERE citation_id IN (
    'CIT_MYC_DIWIA_VENTRI','CIT_MYC_IPHIMEDEIA_VENTRI','CIT_MYC_POTNIA_VENTRI',
    'CIT_MYC_POTNIA_LABYRINTH_VENTRI','CIT_MYC_DRIMIOS_VENTRI'
)
AND evidence_grade <> 'secondary';

-- 4. Prefix/suffix trims. Each replacement is a CONTIGUOUS span of the stored
--    quote with material removed only from the ends — never excised from the
--    middle and rejoined — so each remains a genuine substring of the source.
UPDATE entity_citations SET
    quote = 'Asman. To the high, powerful Heavens; to the bright, all-happy, blissful abode of the holy ones.',
    verify_method = 'apparatus-cleanup v2 suffix-trim (2026-09-18); contiguous prefix of the prior verified span',
    needs_review = true
WHERE citation_id = 'CIT_ZOR_ASMAN_AVESTA' AND quote LIKE '%See Yt. XVII%';

UPDATE entity_citations SET
    quote = 'to the tall lord Apam Napa^''^ and to the water made by Mazda ; to Haoma ^^, of holy birth ; to the pious and good Blessing ;',
    verify_method = 'apparatus-cleanup v2 trim (2026-09-18); contiguous span, footnote tail removed',
    needs_review = true
WHERE citation_id = 'CIT_ZOR_HAOMA_AVESTA' AND quote LIKE '%See p. II, note 6%';

UPDATE entity_citations SET
    quote = 'Father of All, [Ennoia] 1 of the Light 1 [dwelling in the heights 1 above the (regions) below, 15 Light dwelling [in 1 the] heights, Voice of 1 Truth, upright Nous, 1 untouchable Logos, 1 and [ineffable] Voice, 20 [incomprehensible] Father!',
    verify_method = 'apparatus-cleanup v2 trim (2026-09-18); contiguous span between two running heads',
    needs_review = true
WHERE citation_id = 'CIT_VAL_ENNOIA_NHC' AND quote LIKE '%THE TH O U G H T OF NOREA%';

COMMIT;
