-- v2.1.80  Islamic/Sufi secondary sourcing - Renard, Historical Dictionary of Sufism (2005)
-- Existing primary-source pointers are PRESERVED; Renard is ADDED as a separate secondary citation
-- (display_order 3, id suffix _2NDRY) per the v2.1.53 rule.
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES (
  'SRC_RENARD_SUFISM',
  'John Renard, Historical Dictionary of Sufism (Historical Dictionaries of Religions, Philosophies, and Movements 58; Lanham, MD: Scarecrow Press, 2005)',
  '', 'secondary scholarship',
  'NEW - scholarly dictionary of Sufism; headword definitions for Sufi figures, orders and technical terms'
) ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ISL_HUSAYN_2NDRY', 'ENT_ISL_HUSAYN', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "HUSAYN IBN ''ALI"',
  'Son of ''Ali and the Prophet''s daughter Fatima, acclaimed by Shi''is as the "proto-martyr." When he led a small force against Yazid, Umayyad family heir to the caliphate, he and his family band and supporters were slaughtered at Karbala'' in Iraq on the 10th of Muharram (the first Islamic lunar month).',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ISL_HUSAYN_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ISL_SADIQ_2NDRY', 'ENT_ISL_SADIQ', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "JA''FAR AS-SADIQ"',
  'Medinan-born traditionist, exegete, and religious scholar and leader of the early Shi''i community who counseled against open revolt against the Sunni majority.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ISL_SADIQ_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_ISL_ABDAL_2NDRY', 'ENT_ISL_ABDAL', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "SUBSTITUTES"',
  'A group of living persons called abdal (sg. badal), variously numbered at four, seven, 40, or 70, who form an essential part of the Sufi cosmological hierarchy.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_ISL_ABDAL_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_JAMI_2NDRY', 'ENT_SUF_JAMI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "JAMI, MAWLANA ''ABD AR-RAHMAN"',
  'Persian mystical poet and hagiographer from Herat (present-day Afghanistan), member of the Naqshbandiya. He is most celebrated for his collection of didactic poems in the couplet structure, The Seven Thrones (Haft awrang), and for his major hagiographical work, Warm Breezes of Intimacy (Nafahat al-uns).',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_JAMI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_TIJANI_2NDRY', 'ENT_SUF_TIJANI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "TIJANI, AHMAD IBN MUHAMMAD AT-"',
  'Algerian-born shaykh and religious scholar, founder of the Tijaniya who claimed that none other than the Prophet had disclosed his new spiritual path to him in a vision.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_TIJANI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_SIRHINDI_2NDRY', 'ENT_SUF_SIRHINDI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "SIRHINDI, AHMAD"',
  'Major Indian religious scholar and mystical author from the Panjab, pir of the Naqshbandiya under the Mughal dynasty. As a Sufi leader he was politically active, offering advice to rulers concerning needed religious reforms.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_SIRHINDI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_GHAZALI_2NDRY', 'ENT_SUF_GHAZALI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "GHAZALI, ABU HAMID AL-"',
  'Major religious scholar and theorist, mystical and pastoral theologian, author. He was born and raised in Khurasan, where he studied Shafi''i Law and Ash''ari theology.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_GHAZALI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_HALLAJ_2NDRY', 'ENT_SUF_HALLAJ', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "HALLAJ, HUSAYN IBN MANSUR AL-"',
  'Persian-born mystical author and poet who spent much of his life traveling throughout the central Middle East as well as central and parts of South Asia, and was brutally executed in Baghdad as a heretic.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_HALLAJ_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_JUNAYD_2NDRY', 'ENT_SUF_JUNAYD', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "JUNAYD, ABU ''L-QASIM MUHAMMAD AL-"',
  'Central figure among the mystics of Baghdad, of Persian origin; author, and Shafi''i legal scholar; nephew of Sari and critic of Hallaj. Known especially as chief proponent of "sober" mysticism, he advocated a reserved approach to claims about, and expression of, spiritual experience.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_JUNAYD_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_QUSHAYRI_2NDRY', 'ENT_SUF_QUSHAYRI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "QUSHAYRI, ABU ''L-QASIM ''ABD AL-KARIM AL-"',
  'Major Central Asian religious scholar, Sufi manualist and hagiographer, disciple of Abu ''Ali ad-Daqqaq and Sulami. He spent many years studying Shafi''i Law and Ash''ari theology before traveling to Baghdad, where he took a post as religious scholar for the sultan.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_QUSHAYRI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_NAQSHBAND_2NDRY', 'ENT_SUF_NAQSHBAND', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "BAHA'' AD-DIN NAQSHBAND"',
  'Central Asian dervish after whom the Naqshbandiya order takes its name. According to tradition, he was an Uwaysi by virtue of a "spirit initiation" that he experienced in a vision.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_NAQSHBAND_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_CHISHTI_2NDRY', 'ENT_SUF_CHISHTI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "CHISHTIYA"',
  'Major Sufi order, founded by Mu''in ad-Din Chishti in Ajmir, particularly influential in India. Chishti shaykhs founded numerous khanqahs throughout northern India during the seventh/13th and eighth/14th centuries, and members generally remained aloof from political affairs.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_CHISHTI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_DARQAWIYYA_2NDRY', 'ENT_SUF_DARQAWIYYA', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "DARQAWIYA"',
  'Sufi order founded in Morocco during the late 13th/18th century and established predominantly in Morocco and Algeria. With the exception of some participation in the early 14th/19th century Berber rebellion and French takeover of Algeria, members of this order have generally eschewed political activism in favor of a relatively reclusive life.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_DARQAWIYYA_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_IRAQI_2NDRY', 'ENT_SUF_IRAQI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "FAKHR AD-DIN ''IRAQI"',
  'Persian mystical poet and author, onetime qalandar and associate of the Suhrawardiya.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_IRAQI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_HASAN_BASRI_2NDRY', 'ENT_SUF_HASAN_BASRI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "HASAN AL-BASRI"',
  'Medinan-born religious scholar and preacher who moved to Basra and is most famous as an ascetic and was claimed by later Sufis as one of the earliest Sufis.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_HASAN_BASRI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_KHWAJA_AHRAR_2NDRY', 'ENT_SUF_KHWAJA_AHRAR', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "AHRAR, KHWAJA ''UBAYD ALLAH"',
  'Central Asian Naqshbandi shaykh who spent most of his adult life in Tashkent and Samarkand, in present-day Uzbekistan. His public authority, probably not as broad as his hagiographers would have us believe, was enhanced by his own family''s considerable mercantile wealth and extensive property holdings.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_KHWAJA_AHRAR_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_NAQSHBANDI_2NDRY', 'ENT_SUF_NAQSHBANDI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "NAQSHBANDIYA"',
  'Order of Central Asian origin that eventually came to be active across a broader expanse of territory than any but the Qadiriya. It was particularly important also in the Balkans, Turkey, Persia, Afghanistan, and India, and there is evidence of its spread as far eastward as parts of present-day Indonesia.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_NAQSHBANDI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_RABIA_2NDRY', 'ENT_SUF_RABIA', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "RABI''A AL-''ADAWIYA"',
  'Early woman poet, ascetic, and mystic of Basra around whom numerous elements of legend and lore have gathered.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_RABIA_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_RUMI_2NDRY', 'ENT_SUF_RUMI', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "RUMI, MAWLANA JALAL AD-DIN BALKHI"',
  'Major Persian mystical poet widely popular through translation into many languages, perhaps best known as the original "Whirling Dervish." He was born in Balkh (in northern Afghanistan) where his father, Baha'' ad-Din Walad, was a major religious scholar.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_RUMI_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_SAMA_2NDRY', 'ENT_SUF_SAMA', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "AUDITION"',
  'A category of Sufi ritual much contested because it involves the use of music, which mainstream Muslim tradition has generally condemned because of its emotional power and soul-altering properties.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_SAMA_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_TIJANIYYA_2NDRY', 'ENT_SUF_TIJANIYYA', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "TIJANIYA"',
  'Founded in Tlemcen in Algeria in 1195/1781 by Ahmad ibn Muhammad at-Tijani, the order was a dominant influence in large portions of North and West Africa, including Algeria, Morocco, Senegal, Guinea, Western Sahara, Nigeria, Ghana, and Togo, as well as, but much later and to a lesser extent, in Egypt, Sudan, and Ethiopia.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_TIJANIYYA_2NDRY');

INSERT INTO entity_citations (citation_id, entity_id, source_id, work_title, locus, quote,
  evidence_grade, evidence_note, verified_on, verify_method, display_order, needs_review, review_reason)
SELECT 'CIT_SUF_WAHDAT_WUJUD_2NDRY', 'ENT_SUF_WAHDAT_WUJUD', 'SRC_RENARD_SUFISM', 'John Renard, Historical Dictionary of Sufism (Scarecrow Press, 2005)', 's.v. "UNITY, ONTOLOGICAL"',
  'Referred to by the Arabic expression wahdat al-wujud, understood in the sense that the individuality of the mystic is ultimately annihilated in the being of God.',
  'secondary', 'Brief attributed excerpt from a scholarly reference dictionary.', DATE '2026-08-20',
  'pdftotext -enc UTF-8; diacritics and dot-below normalized; entire stored quote programmatically substring-gated against extracted text; headword match eyeballed', 3, TRUE, 'secondary dictionary quote - confirm headword refers to this figure'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id = 'CIT_SUF_WAHDAT_WUJUD_2NDRY');

UPDATE entity_citations
   SET verify_method = verify_method || '; quote continues across a page break in the printed entry (verified contiguous in reading order)'
 WHERE citation_id IN ('CIT_SUF_JUNAYD_2NDRY','CIT_SUF_KHWAJA_AHRAR_2NDRY')
   AND verify_method NOT LIKE '%page break%';

COMMIT;