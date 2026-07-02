-- resource_flagged_v2_1_59.sql — re-source the citations flagged/voided by
-- scripts/fix_citation_qa_v2_1_58.sql, replacing each wrong-referent / apparatus /
-- HTML-grab quote with a REAL passage verified as a verbatim substring of a
-- retrievable text (substring gate; whitespace-normalized; OCR page furniture such
-- as running heads stripped where noted in verify_method). No quote below was
-- composed or paraphrased by the editor of this script.
--
-- Texts used and how they were obtained (all opened and grepped, 2026-07-01):
--   * Wikisource KJV Apocrypha (Judith, Tobit)      — en.wikisource.org raw wikitext
--   * Rodwell Qur'an                                 — Project Gutenberg #2800
--   * Darmesteter, SBE 23 Yasht 6                    — archive.org zendavesta02darm scan
--                                                      + avesta.org yt6sbe.htm (two copies agree)
--   * Irenaeus, Against Heresies (ANF vol. 1)        — ccel.org anf01.ix.ii.ii.html
--   * Livy 29 (Edmonds)                              — Project Gutenberg #12582
--   * Apollodorus, Library (Frazer 1921)             — theoi.com/Text/Apollodorus1.html
--   * Hoffner, Hittite Myths (1998)                  — owner's PDF (Google Drive "Texts")
--   * Gardner & Lieu, Manichaean Texts (2004)        — owner's PDF (Google Drive "Texts")
--   * Schmidt/MacDermot, Books of Jeu (1978)         — owner's PDF (Google Drive "Texts")
--   * Mead, Pistis Sophia 2nd ed. (1921)             — archive.org pistissophiagnos1921mead scan
--   * Parker, Works of Dionysius (1897)              — archive.org theworksofdionys00dionuoft scan
--   * Crowley, The Equinox I(5) and I(7)             — archive.org crowley-equinox_202110 +
--                                                      oto-equinox-vol-1-no-01-10 (two scans agree)
--   * ETCSL t.1.1.3                                  — etcsl.orinst.ox.ac.uk
--   * Davidson, A Dictionary of Angels (1967)        — owner's PDF (~/texts/Books)
--
-- Idempotent: every UPDATE is guarded on the flagged state (needs_review, or the
-- stale prefix/locus it replaces); every INSERT is ON CONFLICT DO NOTHING / NOT EXISTS.
-- Apply: podman exec -i deitydb psql -U postgres -d deitydb -v ON_ERROR_STOP=1 < scripts/resource_flagged_v2_1_59.sql

BEGIN;

-- ---------------------------------------------------------------------------
-- (0) New source rows needed by the re-anchored citations
-- ---------------------------------------------------------------------------
INSERT INTO sources (source_id, title, url, source_type, scope)
SELECT 'SRC_MANICHAEAN_HOMILIES',
       'Manichaean Homilies (Medinet Madi codex), incl. The Sermon of the Great War, Coptic, 4th c. CE; ed. H. J. Polotsky (1934); trans. Iain Gardner in Gardner & Lieu, Manichaean Texts from the Roman Empire (Cambridge University Press, 2004)',
       NULL, 'primary text',
       'Coptic Manichaean homiletic corpus; the Sermon of the Great War (eschatology: the last judgement, the collapse of the cosmos, the ascent of the five sons of the Living Spirit including the Adamas)'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='SRC_MANICHAEAN_HOMILIES');

INSERT INTO sources (source_id, title, url, source_type, scope)
SELECT 'SRC_CROWLEY_VISION_VOICE',
       'Aleister Crowley, Liber XXX Aerum vel Saeculi sub figura CCCCXVIII (The Vision and the Voice), visions received 1900/1909; first published as the Special Supplement to The Equinox Vol. I No. 5 (London, 1911)',
       'https://archive.org/details/crowley-equinox_202110', 'primary text',
       'The Cries of the Thirty Aethyrs (Aires) of the Enochian system as worked and published by Crowley; the primary modern occult text of the Aethyrs'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='SRC_CROWLEY_VISION_VOICE');

INSERT INTO sources (source_id, title, url, source_type, scope)
SELECT 'SRC_CROWLEY_LIBER_CHANOKH',
       'Aleister Crowley, Liber LXXXIV vel Chanokh: A Brief Abstract of the Symbolic Representation of the Universe Derived by Doctor John Dee Through the Skrying of Sir Edward Kelly; The Equinox Vol. I Nos. 7-8 (London, 1912)',
       'https://archive.org/details/crowley-equinox_202110', 'secondary source',
       'Systematic abstract of the Dee/Kelley Enochian corpus: the Sigillum Dei Aemeth, shew-stone, elemental watchtowers, the Angelic (Enochian) alphabet and Calls, and the Thirty Aethyrs or Aires'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='SRC_CROWLEY_LIBER_CHANOKH');

-- ---------------------------------------------------------------------------
-- (1) Wrong-referent rows → re-sourced to the correct passage
-- ---------------------------------------------------------------------------

-- CIT_STJ_JUDITH_APOCRY: was Genesis 26:34 (Judith daughter of Beeri); now Book of Judith 8:1.
UPDATE entity_citations SET
  quote='Now at that time Judith heard thereof, which was the daughter of Merari, the son of Ox, the son of Joseph, the son of Oziel, the son of Elcia, the son of Ananias, the son of Gedeon, the son of Raphaim, the son of Acitho, the son of Eliu, the son of Eliab, the son of Nathanael, the son of Samael, the son of Salasadi, the son of Israel.',
  locus='Judith 8:1',
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/Judith',
  evidence_grade='primary-verbatim',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against Wikisource KJV Apocrypha, Bible (King James)/Judith, fetched 2026-07-01'
WHERE citation_id='CIT_STJ_JUDITH_APOCRY' AND needs_review;

-- CIT_ISL_ISHAQ_QURAN: was Rodwell's editorial note on Ibn Ishaq; now Rodwell Q 37:112-113
-- (annunciation of Isaac — distinct from the existing CIT_ISL_ISHAQ_QUR, Q 14:39 Pickthall).
UPDATE entity_citations SET
  quote='And we announced Isaac to him-a righteous Prophet- And on him and on Isaac we bestowed our blessing.',
  locus='Surah 37:112-113',
  evidence_grade='primary-verbatim',
  evidence_note='Rodwell prints "Isaac" for Arabic Ishaq. Distinct verse from CIT_ISL_ISHAQ_QUR (Q 14:39, Pickthall): this is the annunciation of Isaac to Abraham after the sacrifice narrative.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against Project Gutenberg #2800 (Rodwell, The Koran), fetched 2026-07-01'
WHERE citation_id='CIT_ISL_ISHAQ_QURAN' AND needs_review;

-- CIT_ZOR_HVAR_AVESTA: was Yima Khshaeta (Yasht 5); now Khorshed Yasht (Yasht 6) verse 1.
UPDATE entity_citations SET
  quote='We sacrifice unto the undying, shining, swift-horsed Sun.',
  locus='Khorshed Yasht (Yasht 6), 1',
  translator='James Darmesteter (Sacred Books of the East, vol. 23)',
  translation_year=1883,
  evidence_grade='primary-verbatim',
  evidence_note='Darmesteter renders Avestan hvare-khshaeta ("radiant Sun") as "the undying, shining, swift-horsed Sun" throughout Yasht 6, the hymn dedicated to Hvar Khshaeta; the transliterated name appears only in his headings, never in the translated verse text.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate against two copies of Darmesteter SBE 23 Yasht 6.1 — archive.org zendavesta02darm scan (p. 85; line-break hyphenation joined) and avesta.org/ka/yt6sbe.htm — fetched 2026-07-01'
WHERE citation_id='CIT_ZOR_HVAR_AVESTA' AND needs_review;

-- CIT_VAL_ECCLESIA_NHC: was the NHL volume's modern introduction; now Irenaeus, AH 1.1.1.
UPDATE entity_citations SET
  source_id='SRC_IRENAEUS_AH',
  work_title='Irenaeus, Against Heresies',
  locus='Against Heresies 1.1.1',
  quote='By the conjunction of Logos and Zoe were brought forth Anthropos and Ecclesia; and thus was formed the first-begotten Ogdoad, the root and substance of all things, called among them by four names, viz., Bythus, and Nous, and Logos, and Anthropos.',
  translator='Alexander Roberts & W. H. Rambaut (Ante-Nicene Fathers, vol. 1)',
  translation_year=1885,
  source_url='https://www.ccel.org/ccel/schaff/anf01.ix.ii.ii.html',
  evidence_grade='heresiological-verbatim',
  evidence_note='Irenaeus reporting the Valentinian aeonology: Ecclesia is the eighth aeon, completing the first-begotten Ogdoad. Valentinian doctrine survives chiefly through this heresiological report.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against CCEL ANF vol. 1, Against Heresies I.1.1, fetched 2026-07-01'
WHERE citation_id='CIT_VAL_ECCLESIA_NHC' AND needs_review;

-- CIT_VAL_LOGOS_PISTIS: was Mead's introduction on the Books of Ieou; now Irenaeus, AH 1.1.1.
UPDATE entity_citations SET
  source_id='SRC_IRENAEUS_AH',
  work_title='Irenaeus, Against Heresies',
  locus='Against Heresies 1.1.1',
  quote='And Monogenes, perceiving for what purpose he had been produced, also himself sent forth Logos and Zoe, being the father of all those who were to come after him, and the beginning and fashioning of the entire Pleroma.',
  translator='Alexander Roberts & W. H. Rambaut (Ante-Nicene Fathers, vol. 1)',
  translation_year=1885,
  source_url='https://www.ccel.org/ccel/schaff/anf01.ix.ii.ii.html',
  evidence_grade='heresiological-verbatim',
  evidence_note='Irenaeus reporting the Valentinian aeonology: Logos, emitted with Zoe by Monogenes (Nous), is the fifth aeon of the primal Ogdoad.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against CCEL ANF vol. 1, Against Heresies I.1.1, fetched 2026-07-01'
WHERE citation_id='CIT_VAL_LOGOS_PISTIS' AND needs_review;

-- CIT_ROM_MAGNA_MATER_LIVY: was an unrelated enfranchisement speech; now Livy 29.10
-- (the Sibylline prophecy that brought the Idaean Mother to Rome, 204 BCE).
UPDATE entity_citations SET
  quote='Whensoever a foreign enemy should bring war into the land of Italy, he may be driven out of Italy and conquered, if the Idaean Mother should be brought from Pessinus to Rome.',
  locus='Ab Urbe Condita 29.10',
  translator='Cyrus R. Edmonds',
  translation_year=1850,
  source_url='https://www.gutenberg.org/ebooks/12582',
  evidence_grade='primary-verbatim',
  evidence_note='Livy''s cult title for the goddess is Mater Idaea, "the Idaean Mother" — the Roman name of the Magna Mater (Cybele) fetched from Pessinus in 204 BCE (Livy 29.10-14). The previously credited Canon Roberts translation of Book 29 is not on Project Gutenberg; the quoted text is Edmonds (Gutenberg #12582).',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against Project Gutenberg #12582 (Livy, History of Rome, Books 27-36, trans. Edmonds), fetched 2026-07-01'
WHERE citation_id='CIT_ROM_MAGNA_MATER_LIVY' AND needs_review;

-- ---------------------------------------------------------------------------
-- (2) Apparatus-as-text rows → re-anchored to the translated source text itself
-- ---------------------------------------------------------------------------

-- CIT_MARSYAS_APOLLO: was Frazer's footnote + running head; now Apollodorus' own narrative, 1.4.2.
UPDATE entity_citations SET
  quote='Apollo also slew Marsyas, the son of Olympus. For Marsyas, having found the pipes which Athena had thrown away because they disfigured her face, engaged in a musical contest with Apollo. They agreed that the victor should work his will on the vanquished, and when the trial took place Apollo turned his lyre upside down in the competition and bade Marsyas do the same. But Marsyas could not, so Apollo was judged the victor and despatched Marsyas by hanging him on a tall pine tree and stripping off his skin.',
  locus='Library 1.4.2',
  evidence_grade='primary-verbatim',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized; Frazer''s superscript footnote numbers omitted) against theoi.com/Text/Apollodorus1.html transcription of Frazer 1921, fetched 2026-07-01'
WHERE citation_id='CIT_MARSYAS_APOLLO' AND needs_review;

-- CIT_MANICH_ADAMAS_MANICH: was the edition's glossary; now the Sermon of the Great War
-- (Manichaean Homilies), the ascent of the five sons of the Living Spirit.
UPDATE entity_citations SET
  source_id='SRC_MANICHAEAN_HOMILIES',
  work_title='The Sermon of the Great War (Manichaean Homilies)',
  locus='Homilies 40-41 (Sermon of the Great War; Gardner & Lieu, Manichaean Texts from the Roman Empire, no. 71, p. 226)',
  quote='They will make a sign . . . all of you arise! The Adamas . . . who watches over his brethren, will proceed to the heights.',
  translator='Iain Gardner',
  translation_year=2004,
  evidence_grade='primary-verbatim',
  evidence_note='Ellipses are lacunae in the Coptic codex as printed by the translator. The Adamas here — ascending with the Keeper of Splendour, King of Honour, King of Glory and the Porter at the end of the world — is the Adamas of Light, one of the five sons of the Living Spirit. No public-domain English translation of the Coptic Manichaica exists; quoted from the owner''s copy of Gardner & Lieu 2004.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against pdftotext of the owner''s Gardner & Lieu 2004 PDF (Google Drive "Texts"), 2026-07-01'
WHERE citation_id='CIT_MANICH_ADAMAS_MANICH' AND needs_review;

-- CIT_SAINT_RAPHAEL_CHR_DIONYS: the Celestial Hierarchy never names Raphael;
-- re-sourced to Tobit 12:15, the primary scriptural attestation.
UPDATE entity_citations SET
  source_id='SRC_TOBIT',
  work_title='Book of Tobit (KJV Apocrypha)',
  locus='Tobit 12:15',
  quote='I am Raphael, one of the seven holy angels, which present the prayers of the saints, and which go in and out before the glory of the Holy One.',
  translator='King James Version',
  translation_year=1611,
  source_url='https://en.wikisource.org/wiki/Bible_(King_James)/Tobit',
  evidence_grade='primary-verbatim',
  evidence_note='Pseudo-Dionysius'' Celestial Hierarchy nowhere names Raphael (checked against the full Parker 1897 translation); the angel''s self-naming in Tobit is the primary attestation behind his place in the Christian angelic taxonomy.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against Wikisource KJV Apocrypha, Bible (King James)/Tobit, fetched 2026-07-01; absence of "Raphael" in Pseudo-Dionysius confirmed by grep over the archive.org Parker 1897 scan (theworksofdionys00dionuoft)'
WHERE citation_id='CIT_SAINT_RAPHAEL_CHR_DIONYS' AND needs_review;

-- CIT_SAINT_MICHAEL_CHR_DIONYS: was a chapter heading + marginal refs; now the one passage
-- of the Celestial Hierarchy that actually names Michael (IX.2).
UPDATE entity_citations SET
  locus='The Celestial Hierarchy IX.2',
  quote='Hence, the Word of God has assigned our Hierarchy to Angels, by naming Michael as Ruler of the Jewish people, and others over other nations.',
  evidence_grade='primary-verbatim',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized; OCR double-spacing collapsed) against the archive.org scan of Parker 1897, The Works of Dionysius the Areopagite (theworksofdionys00dionuoft), pp. 37-38, fetched 2026-07-01'
WHERE citation_id='CIT_SAINT_MICHAEL_CHR_DIONYS' AND needs_review;

-- CIT_HTT_ILLUYANKA_HITTIT: was Hoffner's editorial commentary; now the myth text itself.
UPDATE entity_citations SET
  locus='CTH 321 (The Illuyanka Tales), Version 1 par. 3 (A i 9-11)',
  quote='When the Storm God and the serpent fought each other in Kiskilussa, the serpent defeated the Storm God.',
  evidence_grade='primary-verbatim',
  evidence_note='Hoffner renders the Hittite common noun illuyanka- ("serpent") as "the serpent" throughout his translation of CTH 321, the Illuyanka Tales; the name appears as such only in his headings. No public-domain English translation of CTH 321 exists; quoted from the owner''s copy of Hoffner 1998.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized) against the owner''s Hoffner, Hittite Myths 2nd ed. PDF (Google Drive "Texts"), 2026-07-01'
WHERE citation_id='CIT_HTT_ILLUYANKA_HITTIT' AND needs_review;

-- ---------------------------------------------------------------------------
-- (3) Relabels — quote was genuine, metadata wrong
-- ---------------------------------------------------------------------------

-- CIT_RHADAMANTHYS_HOMER_: quote is genuine Butler, Odyssey 4 (Proteus on Elysium);
-- work_title said Iliad and source_url pointed at the Iliad e-text.
UPDATE entity_citations SET
  work_title='Homer, Odyssey',
  locus='Odyssey 4',
  source_url='https://www.gutenberg.org/ebooks/1727',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='relabel v2.1.59: existing quote re-verified as a verbatim substring (whitespace-normalized) of Project Gutenberg #1727 (Butler, The Odyssey), Book IV, fetched 2026-07-01; work_title/locus/source_url corrected from Iliad to Odyssey'
WHERE citation_id='CIT_RHADAMANTHYS_HOMER_' AND needs_review;

-- CIT_MES_NANSHE_SEC: line is from Enki and the World Order, not Nanshe A; locus corrected
-- and the quote replaced with the exact ETCSL rendering (the old copy had "Nance" for "Nanše").
UPDATE entity_citations SET
  locus='ETCSL 1.1.3 (Enki and the World Order), ll. 418-421',
  quote='Nanše, the august lady, who rests her feet on the holy pelican, is to be the fisheries inspector of the sea. She is to be responsible for accepting delectable fish and delicious birds from there to go to Nibru for her father Enlil.',
  source_url='https://etcsl.orinst.ox.ac.uk/cgi-bin/etcsl.cgi?text=t.1.1.3',
  evidence_grade='primary-verbatim',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-source v2.1.59: verbatim substring gate (whitespace-normalized; inline markup tags removed) against ETCSL t.1.1.3 translation, ll. 418-421, fetched 2026-07-01'
WHERE citation_id='CIT_MES_NANSHE_SEC' AND needs_review;

-- ---------------------------------------------------------------------------
-- (4) The four voided HTML-grab rows → re-anchored
-- ---------------------------------------------------------------------------

-- CIT_THO_LIVING_JESUS_PISTIS: Pistis Sophia (Mead and Schmidt/MacDermot both checked)
-- never uses the title "living Jesus"; re-anchored to the Books of Jeu, which attest it densely.
UPDATE entity_citations SET
  source_id='SRC_BOOKS_OF_JEU',
  work_title='The First Book of Jeu (Bruce Codex)',
  locus='1 Jeu 1 (Schmidt/MacDermot, The Books of Jeu and the Untitled Text in the Bruce Codex, pp. 39-40)',
  quote='in the knowledge of the living Jesus, who has come forth through the Father from the aeon of light at the completion of the pleroma',
  translator='Violet MacDermot',
  translation_year=1978,
  source_url=NULL,
  evidence_grade='primary-verbatim',
  evidence_note='Neither Mead''s nor Schmidt/MacDermot''s Pistis Sophia uses the title "living Jesus" (both checked); the epithet''s primary Coptic-Gnostic attestations are the Books of Jeu (passim, incl. "The living Jesus answered and said to his apostles") and the Gospel of Thomas incipit, whose standard English translations are in copyright. Quoted from the owner''s copy of Schmidt/MacDermot 1978.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-anchor v2.1.59 (was voided HTML grab): verbatim substring gate (whitespace-normalized) against the owner''s Schmidt/MacDermot 1978 PDF (Google Drive "Texts"), 2026-07-01'
WHERE citation_id='CIT_THO_LIVING_JESUS_PISTIS' AND needs_review AND quote IS NULL;

-- CIT_GNO_HOLY_SPIRIT_PISTIS: re-anchored to Mead 1921, ch. 141 (the dove passage).
UPDATE entity_citations SET
  work_title='Pistis Sophia (Mead, 2nd ed. 1921)',
  locus='Pistis Sophia ch. 141 (Mead 1921, p. 308; Coptic p. 373)',
  quote='And after a little while my father sent me the holy spirit in the type of a dove.',
  source_url='https://archive.org/details/pistissophiagnos1921mead',
  evidence_grade='primary-verbatim',
  evidence_note='Chapter number per Schmidt''s standard chapter division (Book IV, ch. 141), cross-checked against Schmidt/MacDermot 1978 ("after a little time my Father sent to me the Holy Spirit in the type of a dove"). Mead prints "holy spirit" in lower case.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-anchor v2.1.59 (was voided HTML grab): verbatim substring gate (whitespace-normalized) against the archive.org scan of Mead, Pistis Sophia 2nd ed. 1921 (pistissophiagnos1921mead), p. 308, fetched 2026-07-01; passage cross-verified in the owner''s Schmidt/MacDermot 1978 PDF'
WHERE citation_id='CIT_GNO_HOLY_SPIRIT_PISTIS' AND needs_review AND quote IS NULL;

-- CIT_REN_ENOCHIAN_DEE: the 1659 Casaubon folio survives online only as uncorrected
-- black-letter OCR (unusable for a verbatim gate); re-anchored to Crowley's published
-- abstract of Dee's system (public domain, two independent scans agree).
UPDATE entity_citations SET
  source_id='SRC_CROWLEY_LIBER_CHANOKH',
  work_title='Liber LXXXIV vel Chanokh: A Brief Abstract of the Symbolic Representation of the Universe Derived by Doctor John Dee Through the Skrying of Sir Edward Kelly',
  locus='The Equinox I(7) (1912), pp. 232-233 (part I, on the shew-stone and the great tablets)',
  quote='The Shew-stone, a crystal which Dee alleged to have been brought to him by angels, was then placed upon this table, and the principal result of the ceremonial skrying of Sir Edward Kelly is the obtaining of the following diagrams',
  translator=NULL,
  translation_year=NULL,
  source_url='https://archive.org/details/crowley-equinox_202110',
  evidence_grade='secondary',
  evidence_note='Crowley''s abstract is a secondary (reception) source for Dee''s Enochian system; the primary sources — Dee''s spirit diaries (Sloane MSS) and Casaubon, A True and Faithful Relation (1659) — exist online only as uncorrected black-letter scans. Supply a clean transcription of Casaubon or of Peterson''s edition to upgrade this to a primary attestation.',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-anchor v2.1.59 (was voided HTML grab): verbatim substring gate (whitespace-normalized; the "233 / THE EQUINOX" page-break running head between "this" and "table" stripped) against two independent archive.org scans of The Equinox I(7) (crowley-equinox_202110 and oto-equinox-vol-1-no-01-10), 2026-07-01'
WHERE citation_id='CIT_REN_ENOCHIAN_DEE' AND needs_review AND quote IS NULL;

-- CIT_REN_AETHYRS_DEE: re-anchored to The Vision and the Voice (Liber 418), the Cry of
-- the 30th AEthyr, TEX — the received text itself, naming the 30th AEthyr.
UPDATE entity_citations SET
  source_id='SRC_CROWLEY_VISION_VOICE',
  work_title='Liber XXX Aerum vel Saeculi sub figura CCCCXVIII (The Vision and the Voice)',
  locus='The Cry of the Thirtieth or Inmost Aire or Æthyr, which is called TEX; The Equinox I(5), Special Supplement (1911), pp. 13-14',
  quote='Thus hast thou my name who am above these three, but the angels of the 30th Æthyr are indeed four, and they have none above them; wherefore dispersion and disorder.',
  translator=NULL,
  translation_year=NULL,
  source_url='https://archive.org/details/crowley-equinox_202110',
  evidence_grade='primary-verbatim',
  evidence_note='The 1911 Equinox printing uses the ligature "Æthyr" (OCR copies read "Aethyr" / "A''thyr"); "Aire" is Dee''s own term for the Thirty Aethyrs (cf. Liber Scientiae). The Vision and the Voice is the primary modern text of the Thirty Aethyrs, received by Crowley 1900-1909 and published as the Special Supplement to The Equinox I(5).',
  needs_review=false, review_reason=NULL, verified_on=CURRENT_DATE,
  verify_method='re-anchor v2.1.59 (was voided HTML grab): verbatim substring gate (whitespace-normalized; Æ ligature confirmed by two independent archive.org scans of The Equinox I(5) — crowley-equinox_202110 reads "Aethyr", oto-equinox-vol-1-no-01-10 reads the ligature) — 2026-07-01'
WHERE citation_id='CIT_REN_AETHYRS_DEE' AND needs_review AND quote IS NULL;

-- ---------------------------------------------------------------------------
-- (5) Edges 1424/1425 (Azazel received_as Iblis): tafsir-not-Qur'an mismatch →
--     re-pointed to a retrievable reference work the owner holds (Davidson 1967),
--     which records the Islamic-legend identification verbatim.
-- ---------------------------------------------------------------------------
UPDATE entity_relationships SET
  source_id='SRC_DAVIDSON_ANGELS',
  review_status='reviewed',
  rationale='[re-sourced v2.1.59 — Davidson, A Dictionary of Angels (1967), s.v. "Azazel": "According to the legend in Islamic lore, when God commanded the angels to worship Adam, Azazel refused … Whereupon God cast Azazel out of Heaven and changed his name to Eblis"; cf. s.v. "Eblis". The identification is tafsir/legend (al-Tabari, Ibn Kathir), not Qur''anic text, so the edge no longer cites SRC_QURAN.] ' || regexp_replace(rationale, '^\[SOURCE MISMATCH[^\]]*\] ', '')
WHERE relationship_id IN (1424,1425)
  AND source_id='SRC_QURAN' AND rationale LIKE '[SOURCE MISMATCH%';

-- ---------------------------------------------------------------------------
-- (6) Documented aliases surfaced by the re-sourcing (helps qa_citations.sql check E)
-- ---------------------------------------------------------------------------
INSERT INTO entity_aliases (entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
SELECT 'ENT_ROM_MAGNA_MATER','Idaean Mother','cult title','English','SRC_LIVY_AUC','high','reviewed',
       'Mater Idaea, the cult title under which Livy narrates the goddess''s arrival from Pessinus (Livy 29.10-14).'
WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ROM_MAGNA_MATER' AND alias_name='Idaean Mother');

INSERT INTO entity_aliases (entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
SELECT 'ENT_ISL_ISHAQ','Isaac','English form','English','SRC_QURAN','high','reviewed',
       'English rendering of Ishaq used by the public-domain Qur''an translations quoted in this database (Rodwell, Pickthall).'
WHERE NOT EXISTS (SELECT 1 FROM entity_aliases WHERE entity_id='ENT_ISL_ISHAQ' AND alias_name='Isaac');

COMMIT;

-- ---------------------------------------------------------------------------
-- Post-fix verification
-- ---------------------------------------------------------------------------
\echo '--- post-fix: the 17 re-sourced/relabeled citations (expect needs_review=f, quote present) ---'
SELECT citation_id, source_id, left(locus,44) AS locus, quote IS NOT NULL AS has_quote,
       evidence_grade, needs_review
FROM entity_citations
WHERE citation_id IN ('CIT_STJ_JUDITH_APOCRY','CIT_ISL_ISHAQ_QURAN','CIT_ZOR_HVAR_AVESTA',
                      'CIT_VAL_ECCLESIA_NHC','CIT_VAL_LOGOS_PISTIS','CIT_ROM_MAGNA_MATER_LIVY',
                      'CIT_MARSYAS_APOLLO','CIT_MANICH_ADAMAS_MANICH','CIT_SAINT_RAPHAEL_CHR_DIONYS',
                      'CIT_SAINT_MICHAEL_CHR_DIONYS','CIT_HTT_ILLUYANKA_HITTIT','CIT_RHADAMANTHYS_HOMER_',
                      'CIT_MES_NANSHE_SEC','CIT_THO_LIVING_JESUS_PISTIS','CIT_GNO_HOLY_SPIRIT_PISTIS',
                      'CIT_REN_ENOCHIAN_DEE','CIT_REN_AETHYRS_DEE')
ORDER BY citation_id;

\echo '--- post-fix: edges 1424/1425 (expect SRC_DAVIDSON_ANGELS, reviewed) ---'
SELECT relationship_id, source_id, review_status, left(rationale,60) AS rationale_head
FROM entity_relationships WHERE relationship_id IN (1424,1425);

\echo '--- post-fix: new sources + aliases ---'
SELECT source_id FROM sources WHERE source_id IN ('SRC_MANICHAEAN_HOMILIES','SRC_CROWLEY_VISION_VOICE','SRC_CROWLEY_LIBER_CHANOKH');
SELECT entity_id, alias_name FROM entity_aliases
WHERE (entity_id,alias_name) IN (('ENT_ROM_MAGNA_MATER','Idaean Mother'),('ENT_ISL_ISHAQ','Isaac'));

\echo '--- post-fix: remaining flagged citations from the v2.1.58 audit (expect 0) ---'
SELECT count(*) AS still_flagged FROM entity_citations
WHERE needs_review AND review_reason ~ '^(WRONG REFERENT|WRONG QUOTE|APPARATUS|TITLE/LOCUS|LOCUS)';
