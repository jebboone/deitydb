-- v2.1.81  Cross-traditional / thematic pointers - The Brill Dictionary of Religion (2006)
-- POINTERS ONLY: quote is NULL, no text reproduced (in-copyright, essay-format).
-- Existing citations PRESERVED; these are added as separate secondary citations.
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES (
  'SRC_BRILL_DICT_RELIGION',
  'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion, 4 vols. (Leiden/Boston: Brill, 2006); English translation of Metzler Lexikon Religion',
  '', 'secondary scholarship',
  'NEW - major thematic dictionary of religious studies; signed scholarly articles on cross-traditional concepts'
) ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ANGELS_BRILL', 'ENT_ANGELS', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Angel", p. 64',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ANGELS_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_CHRR_HEAVEN_BRILL', 'ENT_CHRR_HEAVEN', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Heaven / Sky", p. 838',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_CHRR_HEAVEN_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_CHRR_HELL_BRILL', 'ENT_CHRR_HELL', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Hell", p. 842',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_CHRR_HELL_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_CREATION_BRILL', 'ENT_CREATION', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Creation", p. 464',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_CREATION_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_IMMORTALITY_BRILL', 'ENT_IMMORTALITY', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Immortality", p. 913',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_IMMORTALITY_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_MONASTICISM_BRILL', 'ENT_MONASTICISM', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Monasticism", p. 1242',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_MONASTICISM_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_MON_SPHINX_BRILL', 'ENT_MON_SPHINX', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Sphinx", p. 1803',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_MON_SPHINX_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_POSSESSION_BRILL', 'ENT_POSSESSION', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Possession", p. 1477',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_POSSESSION_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_POVERTY_BRILL', 'ENT_POVERTY', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Poverty", p. 1482',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_POVERTY_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_PROPHECY_BRILL', 'ENT_PROPHECY', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Prophecy / Divination", p. 1520',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_PROPHECY_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_REVELATION_BRILL', 'ENT_REVELATION', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Revelation", p. 1628',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_REVELATION_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SAINT_HILDEGARD_BRILL', 'ENT_SAINT_HILDEGARD', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Hildegard of Bingen", p. 857',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SAINT_HILDEGARD_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SALVATION_BRILL', 'ENT_SALVATION', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Salvation / Redemption", p. 1672',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SALVATION_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_WHOLENESS_BRILL', 'ENT_WHOLENESS', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Wholeness / Holism", p. 1973',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_WHOLENESS_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_WRITING_BRILL', 'ENT_WRITING', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Writing", p. 1992',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_WRITING_BRILL');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ZOR_ZARATHUSTRA_BRILL', 'ENT_ZOR_ZARATHUSTRA', 'SRC_BRILL_DICT_RELIGION', 'Kocku von Stuckrad (ed.), The Brill Dictionary of Religion (Leiden: Brill, 2006)', 's.v. "Zarathustra", p. 1999',
  NULL,
  'secondary', 'Pointer to a signed scholarly article; no text reproduced (in-copyright).', DATE '2026-08-20',
  'entry located in pdftotext extraction and confirmed to be a substantive signed article on this subject (title + body verified); NO text reproduced - pointer only', 4, TRUE, 'secondary pointer - confirm the article treats this entity'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ZOR_ZARATHUSTRA_BRILL');

COMMIT;