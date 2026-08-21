-- v2.1.83  Recovered pointers (Neoplatonic theurgy, Simonian, Samaritan, Armenian Christian)
-- Same method as v2.1.82; these were recovered after widening the tradition/collection fit test.
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_ASCETICISM_AND_CHRISTOLOGICAL_CONTROVERSY_IN', 'Asceticism and Christological Controversy in 5th-Century Palestinem The Career of Peter the Iberian (Oxford University Press, 2006)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_BASIL_OF_CAESAREA_CHRISTIAN_HUMANIST', 'Basil of Caesarea Christian Humanist Ascetic, A Sixteen-Hundredth Anniversary Symposium (PIMS, 1981)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_DAMASCIUS_PROBLEMS_AND_SOLUTIONS_CONCERNING', 'Damascius'' Problems and Solutions Concerning First Principles (Oxford University Press, 2010)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_HANDBOOK_OF_PATRISTIC_EXEGESIS_THE', 'Handbook of Patristic Exegesis, The Bible in Ancient Christianity (2 Vols) (Brill Publishing, 2004)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_HOW_PHILISOPHY_BECAME_SOCRATIC_A', 'How Philisophy Became Socratic, A Study of Plato’s Protagoras Charmides and Republic (University of Chicago Press, 2010)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_IRENAEUS_OF_LYONS', 'Irenaeus of Lyons (Routledge Press, 1997)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_ORIGEN_AND_THE_JEWS_STUDIES', 'Origen and the Jews, Studies in Jewish-Christian Relations in 3rd-Century Palestine (Cambridge University Press, 1976)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_SOCRATES_DISSATISFIED_AN_ANALYSIS_OF', 'Socrates Dissatisfied, An Analysis of Plato''s Crito (Oxford University Press, 1998)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_THEURGY_AND_THE_SOUL_THE', 'Theurgy and the Soul, The Neoplatonism of Iamblichus (Pennsylvania State University Press, 1995)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES ('SRC_LIB_THE_TEACHINGS_OF_SYRIANUS_ON', 'The Teachings of Syrianus on Plato''s Timaeus and Parmenides (Brill Publishing, 2011)', '', 'secondary scholarship', 'NEW - scholarly monograph from the 2026-08 library acquisition') ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_HER_HENADS_LIB', 'ENT_HER_HENADS', 'SRC_LIB_DAMASCIUS_PROBLEMS_AND_SOLUTIONS_CONCERNING', 'Damascius'' Problems and Solutions Concerning First Principles (Oxford University Press, 2010)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (190 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_HER_HENADS_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_HER_ENCOSMIC_GODS_LIB', 'ENT_HER_ENCOSMIC_GODS', 'SRC_LIB_THE_TEACHINGS_OF_SYRIANUS_ON', 'The Teachings of Syrianus on Plato''s Timaeus and Parmenides (Brill Publishing, 2011)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (27 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_HER_ENCOSMIC_GODS_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_HER_HYPERCOSMIC_GODS_LIB', 'ENT_HER_HYPERCOSMIC_GODS', 'SRC_LIB_THEURGY_AND_THE_SOUL_THE', 'Theurgy and the Soul, The Neoplatonism of Iamblichus (Pennsylvania State University Press, 1995)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (18 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_HER_HYPERCOSMIC_GODS_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ADRASTEIA_LIB', 'ENT_ADRASTEIA', 'SRC_LIB_HOW_PHILISOPHY_BECAME_SOCRATIC_A', 'How Philisophy Became Socratic, A Study of Plato’s Protagoras Charmides and Republic (University of Chicago Press, 2010)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (18 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ADRASTEIA_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SIM_SIMON_LIB', 'ENT_SIM_SIMON', 'SRC_LIB_IRENAEUS_OF_LYONS', 'Irenaeus of Lyons (Routledge Press, 1997)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (16 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SIM_SIMON_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_CORYBANTES_LIB', 'ENT_CORYBANTES', 'SRC_LIB_SOCRATES_DISSATISFIED_AN_ANALYSIS_OF', 'Socrates Dissatisfied, An Analysis of Plato''s Crito (Oxford University Press, 1998)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (13 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_CORYBANTES_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SYN_AION_LIB', 'ENT_SYN_AION', 'SRC_LIB_THE_TEACHINGS_OF_SYRIANUS_ON', 'The Teachings of Syrianus on Plato''s Timaeus and Parmenides (Brill Publishing, 2011)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (8 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SYN_AION_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SAM_MARQAH_LIB', 'ENT_SAM_MARQAH', 'SRC_LIB_ORIGEN_AND_THE_JEWS_STUDIES', 'Origen and the Jews, Studies in Jewish-Christian Relations in 3rd-Century Palestine (Cambridge University Press, 1976)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (7 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SAM_MARQAH_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ARMC_GREGORY_ILLUMINATOR_LIB', 'ENT_ARMC_GREGORY_ILLUMINATOR', 'SRC_LIB_BASIL_OF_CAESAREA_CHRISTIAN_HUMANIST', 'Basil of Caesarea Christian Humanist Ascetic, A Sixteen-Hundredth Anniversary Symposium (PIMS, 1981)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (6 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ARMC_GREGORY_ILLUMINATOR_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ARMC_MESROP_LIB', 'ENT_ARMC_MESROP', 'SRC_LIB_ASCETICISM_AND_CHRISTOLOGICAL_CONTROVERSY_IN', 'Asceticism and Christological Controversy in 5th-Century Palestinem The Career of Peter the Iberian (Oxford University Press, 2006)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (5 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ARMC_MESROP_LIB');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ARMC_NAREK_LIB', 'ENT_ARMC_NAREK', 'SRC_LIB_HANDBOOK_OF_PATRISTIC_EXEGESIS_THE', 'Handbook of Patristic Exegesis, The Bible in Ancient Christianity (2 Vols) (Brill Publishing, 2004)', 'passim',
  NULL, 'secondary', 'Entity discussed in this work (3 word-boundary occurrences); context verified.', DATE '2026-08-20', 'full-text extraction (pdftotext); entity located by word-boundary search and surrounding context read to confirm the referent; NO text reproduced - pointer only', 5, TRUE,
  'secondary pointer - confirm the work treats this figure substantively'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ARMC_NAREK_LIB');

COMMIT;