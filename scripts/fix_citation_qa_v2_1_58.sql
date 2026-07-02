-- fix_citation_qa_v2_1_58.sql — citation-quality fixes surfaced by scripts/qa_citations.sql.
-- Idempotent (every UPDATE is guarded on the bad state or exact row). Three sections:
--  (1) VOID the 4 archive.org HTML-grab quotes (scraper captured page chrome, not source
--      text). Quote is NULLed and the row downgraded primary-verbatim→primary-uncited +
--      flagged; NO replacement quote is invented — re-anchoring is a human follow-up.
--  (2) CORRECT two sources-row edition labels to the translation the citations ACTUALLY
--      quote (verified: all 68 quoted Apollodorus rows are Frazer 1921; all 39 quoted
--      Homer rows are Butler 1898/1900 — the Gutenberg #2199/#1727 texts the rows link).
--      The old titles named in-copyright editions (Hard OUP 2008; Lattimore/Wilson) that
--      no quoted text came from.
--  (3) FLAG (never replace) the wrong-referent / apparatus-as-text rows from the audit,
--      each with a precise review_reason so a human can re-source. Quotes left in place
--      as evidence of what was mis-grabbed.
-- Apply: podman exec -i deitydb psql -U postgres -d deitydb -v ON_ERROR_STOP=1 < scripts/fix_citation_qa_v2_1_58.sql
BEGIN;

-- (1) archive.org HTML-grab quotes → void + flag -----------------------------------
UPDATE entity_citations SET
  quote=NULL,
  evidence_grade='primary-uncited',
  needs_review=true,
  review_reason='WRONG QUOTE — scraper grabbed archive.org page HTML (nav chrome), not source text; re-anchor to the primary text needed.',
  verify_method='citation-QA v2.1.58 (qa_citations.sql check A): HTML markers detected mechanically; quote voided, no replacement fabricated',
  verified_on=NULL
WHERE citation_id IN ('CIT_THO_LIVING_JESUS_PISTIS','CIT_GNO_HOLY_SPIRIT_PISTIS',
                      'CIT_REN_ENOCHIAN_DEE','CIT_REN_AETHYRS_DEE')
  AND quote LIKE '%media-subnav%';

-- (2) sources-row edition labels → match the translation actually quoted ------------
UPDATE sources SET
  title='Pseudo-Apollodorus, Library (Bibliotheca) (1st-2nd century CE); trans. J. G. Frazer (Loeb Classical Library, 1921)'
WHERE source_id='SRC_APOLLODORUS_LIBRARY' AND title LIKE '%Robin Hard%';

UPDATE sources SET
  title='Homer, Iliad and Odyssey (c. 750-675 BCE); trans. Samuel Butler (Iliad 1898; Odyssey 1900; Project Gutenberg #2199/#1727)'
WHERE source_id='SRC_HOMER_ILIAD_ODYSSEY' AND title LIKE '%Lattimore%';

-- (3) wrong-referent / apparatus-as-text rows → flag only ---------------------------
UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='WRONG REFERENT — homonym match: quote is Genesis 26:34-27:1 (Judith daughter of Beeri, Esau''s wife), not the Book of Judith heroine; re-source to the Book of Judith.'
WHERE citation_id='CIT_STJ_JUDITH_APOCRY';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='WRONG REFERENT + APPARATUS — quote is Rodwell''s editorial note about Ibn Ishaq (Muhammad''s biographer), not Qur''anic text about the prophet Ishaq/Isaac; re-source.'
WHERE citation_id='CIT_ISL_ISHAQ_QURAN';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='WRONG REFERENT — homonym match on "Khshaeta": passage concerns Yima Khshaeta, not the sun yazata Hvar Khshaeta; re-anchor (e.g. Khorshed Nyayesh/Yasht).'
WHERE citation_id='CIT_ZOR_HVAR_AVESTA';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='WRONG REFERENT + APPARATUS — quote is the volume''s modern introduction (on the contemporary Ecclesia Gnostica organization), not Valentinian source text on the aeon Ecclesia; re-anchor.'
WHERE citation_id='CIT_VAL_ECCLESIA_NHC';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='WRONG REFERENT + APPARATUS — quote is the translator''s introduction describing the Books of Ieou ("Book of the Great Logos"), not Pistis Sophia text on the Valentinian Logos aeon; re-anchor.'
WHERE citation_id='CIT_VAL_LOGOS_PISTIS';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='WRONG REFERENT — homonym match ("Mater…"): quoted passage is a political speech on enfranchising the vanquished, not the Magna Mater/Cybele arrival narrative (Livy 29.10-14); re-anchor.'
WHERE citation_id='CIT_ROM_MAGNA_MATER_LIVY';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='APPARATUS quoted as source text — passage is Frazer''s footnote (with OCR running-head "THE LIBRARY") plus a stray text fragment, not Apollodorus'' own narrative; re-anchor to Library 1.4.2.'
WHERE citation_id='CIT_MARSYAS_APOLLO';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='APPARATUS quoted as source text — passage is the edition''s glossary ("Adamas See: Adamant of light…"), not Kephalaia text; re-anchor.'
WHERE citation_id='CIT_MANICH_ADAMAS_MANICH';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='APPARATUS quoted as source text — chapter heading + marginal scripture refs of the Celestial Hierarchy (OCR) quoted as text; the passage never names Raphael; re-anchor.'
WHERE citation_id='CIT_SAINT_RAPHAEL_CHR_DIONYS';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='APPARATUS quoted as source text — chapter heading + marginal scripture refs of the Celestial Hierarchy (OCR) quoted as text; the passage never names Michael; re-anchor.'
WHERE citation_id='CIT_SAINT_MICHAEL_CHR_DIONYS';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='APPARATUS quoted as source text — passage is Hoffner''s editorial commentary on the Illuyanka stories, not the translated myth text; re-anchor.'
WHERE citation_id='CIT_HTT_ILLUYANKA_HITTIT';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='TITLE/LOCUS MISMATCH — work_title says Iliad but the quote is Odyssey 4 (Butler); quote itself is genuine Homer; correct work_title/locus on re-verification.'
WHERE citation_id='CIT_RHADAMANTHYS_HOMER_';

UPDATE entity_citations SET needs_review=true, verified_on=NULL,
  review_reason='LOCUS MISMATCH — quoted line is from Enki and the World Order (ETCSL 1.1.3, ll. 418-421), not the cited Nanshe A (ETCSL 4.14.1); checked against ETCSL 2026-07-01; fix locus or requote from 4.14.1.'
WHERE citation_id='CIT_MES_NANSHE_SEC';

-- Edge: Azazel received_as Iblis cites SRC_QURAN, but the Azazil identification is
-- tafsir (al-Tabari, Ibn Kathir), not Qur'anic text. Flag the edge and its mirror.
UPDATE entity_relationships SET review_status='needs_review',
  rationale='[SOURCE MISMATCH — tafsir not Qur''an: the Azazil identification is from al-Tabari/Ibn Kathir, not Qur''anic text; re-source away from SRC_QURAN] ' || rationale
WHERE subject_entity_id='ENT_ISR_AZAZEL' AND relationship_type='received_as' AND object_entity_id='ENT_ISL_IBLIS'
  AND source_id='SRC_QURAN' AND rationale NOT LIKE '[SOURCE MISMATCH%';

UPDATE entity_relationships SET review_status='needs_review',
  rationale='[SOURCE MISMATCH — tafsir not Qur''an: the Azazil identification is from al-Tabari/Ibn Kathir, not Qur''anic text; re-source away from SRC_QURAN] ' || rationale
WHERE subject_entity_id='ENT_ISL_IBLIS' AND relationship_type='reception_of' AND object_entity_id='ENT_ISR_AZAZEL'
  AND source_id='SRC_QURAN' AND rationale NOT LIKE '[SOURCE MISMATCH%';

COMMIT;

\echo '--- post-fix: HTML-grab rows (expect 4, quote NULL, primary-uncited, flagged) ---'
SELECT citation_id, quote IS NULL AS quote_voided, evidence_grade, needs_review
FROM entity_citations
WHERE citation_id IN ('CIT_THO_LIVING_JESUS_PISTIS','CIT_GNO_HOLY_SPIRIT_PISTIS',
                      'CIT_REN_ENOCHIAN_DEE','CIT_REN_AETHYRS_DEE');

\echo '--- post-fix: corrected source titles ---'
SELECT source_id, title FROM sources
WHERE source_id IN ('SRC_APOLLODORUS_LIBRARY','SRC_HOMER_ILIAD_ODYSSEY');

\echo '--- post-fix: flagged rows (expect 13 citations needs_review=t + 2 flagged edges) ---'
SELECT count(*) AS flagged_citations FROM entity_citations
WHERE needs_review AND review_reason ~ '^(WRONG REFERENT|WRONG QUOTE|APPARATUS|TITLE/LOCUS|LOCUS)';
SELECT count(*) AS flagged_edges FROM entity_relationships
WHERE review_status='needs_review' AND rationale LIKE '[SOURCE MISMATCH%';
