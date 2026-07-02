-- buildout_cross_tradition_v2_1_60.sql — Phase 1 of the cross-tradition link
-- buildout: Tier-1 interpretatio/reception edges (Greek<->Egyptian, Greek<->Roman,
-- Mesopotamian<->Canaanite, Canaanite<->Israelite incl. the Helel->Lucifer chain),
-- Tier-2 secondary-sourced edges (Anglo-Saxon/Sami, Slavic Christianization,
-- Arthurian<->Welsh), and directionality/type/confidence FIXES to existing edges
-- flagged by the cross-tradition audit.
--
-- Encoding policy applied throughout:
--   * ancient author equates two gods            -> equated_with (cite the ancient text)
--   * modern scholarship asserts derivation      -> received_as / reception_of
--       (received_as subject = EARLIER form; reception_of subject = LATER form)
--   * typological parallel only                  -> aligned_with (low confidence)
-- Every NEW edge and entity is review_status='needs_review' (edges) or
-- 'candidate_verified_name' (entities) — nothing lands as human-verified.
-- Fixes to existing rows are corrected in place and re-flagged needs_review.
--
-- Texts used and how they were verified (all fetched and substring-gated 2026-07-01):
--   * Herodotus, Histories                — Project Gutenberg #2707 (trans. G. C.
--     Macaulay, vol. 1). NOTE: the roadmap named Rawlinson; Rawlinson's translation
--     is NOT on Project Gutenberg, so the (equally public-domain) Macaulay text was
--     gated instead. Loci identical.
--   * Plutarch, De Iside et Osiride       — LacusCurtius (penelope.uchicago.edu)
--     transcription of Babbitt, Moralia V (Loeb 1936; US copyright not renewed;
--     the site marks the text public domain).
--   * Cicero, De Natura Deorum            — Project Gutenberg #14988 (trans. C. D. Yonge).
--   * Livy, Ab Urbe Condita 10.47         — Project Gutenberg #10907 (trans. D. Spillan
--     & Cyrus R. Edmonds, Books 9-26).
--   * KJV (1 Kgs, 1 Sam, Isa, Hab)        — Project Gutenberg #10.
-- Secondary works cited as POINTERS ONLY (entry named, needs_review=true; no quote
-- fabricated): DDD (van der Toorn/Becking/van der Horst), Simek 1993, Bromwich TYP
-- 4th ed., Ivanits 1989, Rydving 1993, Wildung 1977, Black & Green, OCD.
--
-- Idempotent: every INSERT is ON CONFLICT DO NOTHING / WHERE NOT EXISTS; every
-- UPDATE/DELETE is guarded on the exact prior state. Re-run touches 0 rows.
-- Apply: podman exec -i deitydb psql -U postgres -d deitydb -v ON_ERROR_STOP=1 < scripts/buildout_cross_tradition_v2_1_60.sql

BEGIN;

-- ---------------------------------------------------------------------------
-- (0) New source rows
-- ---------------------------------------------------------------------------
INSERT INTO sources (source_id, title, url, source_type, scope)
SELECT 'SRC_WILDUNG_IMHOTEP',
       'Dietrich Wildung, Egyptian Saints: Deification in Pharaonic Egypt (New York University Press, 1977)',
       NULL, 'secondary scholarship',
       'The deification of Imhotep and Amenhotep son of Hapu; the Ptolemaic identification of Imhotep (Imouthes) with Asklepios'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='SRC_WILDUNG_IMHOTEP');

INSERT INTO sources (source_id, title, url, source_type, scope)
SELECT 'SRC_IVANITS_RUSSIAN_FOLK',
       'Linda J. Ivanits, Russian Folk Belief (M. E. Sharpe, 1989)',
       NULL, 'secondary scholarship',
       'Russian folk religion and dvoeverie: the folk cults of Elijah the Prophet, St Blasius and Paraskeva Pyatnitsa and their pagan substrata (Perun, Volos/Veles, Mokosh)'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='SRC_IVANITS_RUSSIAN_FOLK');

INSERT INTO sources (source_id, title, url, source_type, scope)
SELECT 'SRC_RYDVING_DRUM_TIME',
       'Håkan Rydving, The End of Drum-Time: Religious Change among the Lule Saami, 1670s-1740s (Acta Universitatis Upsaliensis, 1993)',
       NULL, 'secondary scholarship',
       'Sami indigenous religion under missionary pressure; the thunder-god Horagalles (Thora galles) and the drum figures'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE source_id='SRC_RYDVING_DRUM_TIME');

-- ---------------------------------------------------------------------------
-- (1) New entities (each with entity_sources + entity_periods + a citation)
-- ---------------------------------------------------------------------------
INSERT INTO entities (entity_id,canonical_name,tradition,entity_type,category,primary_domains,cult_scope,evidence_confidence,review_status,inclusion_basis,earth_association_score,chthonic_flag,serpent_flag,short_note,entity_class) VALUES
 ('ENT_ROM_AESCULAPIUS','Aesculapius','Roman','Healing god','Healing Figure','medicine; healing; the sacred serpent; the Tiber Island temple','Roman','A','candidate_verified_name','Livy 10.47; Livy Per. 11',0,false,true,
  'Roman reception of Greek Asclepius, fetched from Epidaurus by Senate decree after the plague of 293 BCE (Livy 10.47); his serpent chose the Tiber Island, where his temple stood from 291 BCE.','deity'),
 ('ENT_ROM_LUNA','Luna','Roman','Goddess','Astral Deity','the moon; the months; light','Roman','A','candidate_verified_name','Cicero, De Natura Deorum 2.68',0,false,false,
  'Roman moon-goddess (temple on the Aventine), the Latin counterpart of Greek Selene; Cicero derives her name a lucendo, "from shining."','deity'),
 ('ENT_ROM_LATONA','Latona','Roman','Goddess','Mother of gods','motherhood of Apollo and Diana','Roman','A','candidate_verified_name','Cicero, De Natura Deorum 3.46',0,false,false,
  'The Latin form of Greek Leto (the name entered Latin early, via Etruscan Letun); mother of Apollo and Diana in Roman cult and letters.','deity'),
 ('ENT_ISR_ASHTORETH','Ashtoreth','Israelite/Second Temple','Goddess (polemical reception)','Foreign deity (biblical polemic)','the goddess of the Zidonians in Deuteronomistic polemic','Biblical/Second Temple','A','candidate_verified_name','1 Kings 11:5, 33; 2 Kings 23:13',0,false,false,
  'The Hebrew Bible''s name for Sidonian Astarte (the vowels of boshet, "shame", deforming the theonym); worshipped by Solomon per 1 Kings 11:5 and condemned in Deuteronomistic polemic.','deity'),
 ('ENT_ISR_BAAL','Baal (Hebrew Bible)','Israelite/Second Temple','God (polemical reception)','Foreign deity (biblical polemic)','storm; rain; the rival cult opposed by Elijah and Hosea','Biblical/Second Temple','A','candidate_verified_name','1 Kings 18; Hosea 2',0,false,false,
  'The Baal of Kings and Hosea — the Canaanite storm-god Baal Hadad as received and opposed within Israelite religion; the Carmel contest (1 Kings 18) and Hosea''s polemic frame him as YHWH''s chief rival.','deity'),
 ('ENT_ISR_HELEL','Helel ben Shahar','Israelite/Second Temple','Astral being (fallen)','Astral Deity','the morning star; the fall from heaven (Isaiah 14)','Biblical/Second Temple','A','candidate_verified_name','Isaiah 14:12',0,false,false,
  'The "shining one, son of dawn" of Isaiah 14:12 — the fallen morning-star figure in the taunt against the king of Babylon, drawing on a Canaanite astral myth (DDD s.v. Helel); rendered lucifer in the Vulgate and "Lucifer" in the KJV, the fountainhead of the later Lucifer tradition.','deity'),
 ('ENT_ISR_ANAT_YAHU','Anat-Yahu','Israelite/Second Temple','Goddess (syncretic)','Syncretic Deity','oath deity beside Yahu at Elephantine','Elephantine Jewish colony','B','candidate_verified_name','Elephantine oath text (Cowley 44 = TAD B7.3); DDD s.v. Anat-Yahu',0,false,false,
  'The "Anat of Yahu" invoked in an oath by a Jewish colonist at Elephantine (5th c. BCE) — the name of Canaanite Anat carried into a Yahwistic cult context (DDD s.v. Anat-Yahu).','deity'),
 ('ENT_WEL_MYRDDIN','Myrddin (Wyllt)','Celtic/Welsh','Prophet-poet','Prophet-mage','prophecy; madness in the Caledonian forest; poetry','literary','B','candidate_verified_name','Bromwich, Trioedd Ynys Prydein, s.n. Myrddin',0,false,false,
  'The Welsh wild prophet-poet of the Caledonian forest (Yr Afallennau, Yr Oianau; the Myrddin poems of the Black Book of Carmarthen), driven mad at the battle of Arfderydd; Geoffrey of Monmouth latinized him as Merlinus, the seed of the Arthurian Merlin.','prophet'),
 ('ENT_WEL_GWENHWYFAR','Gwenhwyfar','Celtic/Welsh','Queen','Legendary queen','queenship; the abduction motif','literary','B','candidate_verified_name','Bromwich, Trioedd Ynys Prydein, Triad 56; s.n. Gwenhwyfar',0,false,false,
  'Arthur''s queen in the Welsh tradition (Trioedd Ynys Prydein; Culhwch ac Olwen); her name ("white phantom/enchantress") passed through French Guenievre into English Guinevere.','ruler'),
 ('ENT_ORTH_PARASKEVA','Paraskeva Pyatnitsa','Christian/Orthodox','Saint (folk veneration)','Saint','Friday; spinning and weaving; women''s work; wells','East Slavic folk Orthodoxy','B','candidate_verified_name','Ivanits, Russian Folk Belief, s.v. Paraskeva Piatnitsa',0,false,false,
  'St Paraskeva ("Friday"), the East Slavic folk saint of spinning, women''s work and wells; in Russian folk belief she absorbed functions of the pagan goddess Mokosh (Ivanits 1989).','saint')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note) VALUES
 ('ENT_ROM_AESCULAPIUS','SRC_LIVY_AUC','primary text attestation','Livy 10.47: Aesculapius ordered brought from Epidaurus to Rome (plague of 293 BCE); Per. 11: the serpent and the Tiber Island temple.'),
 ('ENT_ROM_LUNA','SRC_CICERO_DE_NATURA','primary text attestation','Cicero, De Natura Deorum 2.68 (Luna a lucendo; Lucina).'),
 ('ENT_ROM_LATONA','SRC_CICERO_DE_NATURA','primary text attestation','Cicero, De Natura Deorum 3.46.'),
 ('ENT_ISR_ASHTORETH','SRC_HEBREW_BIBLE','primary text attestation','1 Kings 11:5, 33; 2 Kings 23:13.'),
 ('ENT_ISR_ASHTORETH','SRC_DDD_BIBLE','scholarly attestation','DDD s.v. Astarte.'),
 ('ENT_ISR_BAAL','SRC_HEBREW_BIBLE','primary text attestation','1 Kings 18; Hosea 2.'),
 ('ENT_ISR_BAAL','SRC_DDD_BIBLE','scholarly attestation','DDD s.v. Baal.'),
 ('ENT_ISR_HELEL','SRC_HEBREW_BIBLE','primary text attestation','Isaiah 14:12.'),
 ('ENT_ISR_HELEL','SRC_DDD_BIBLE','scholarly attestation','DDD s.v. Helel.'),
 ('ENT_ISR_ANAT_YAHU','SRC_DDD_BIBLE','scholarly attestation','DDD s.v. Anat-Yahu (K. van der Toorn); Elephantine, Cowley 44 = TAD B7.3.'),
 ('ENT_WEL_MYRDDIN','SRC_TRIADS_BROMWICH','scholarly attestation','Bromwich, TYP 4th ed., s.n. Myrddin (Wyllt).'),
 ('ENT_WEL_GWENHWYFAR','SRC_TRIADS_BROMWICH','scholarly attestation','Bromwich, TYP 4th ed., Triad 56; s.n. Gwenhwyfar.'),
 ('ENT_ORTH_PARASKEVA','SRC_IVANITS_RUSSIAN_FOLK','scholarly attestation','Ivanits, Russian Folk Belief (1989), s.v. Paraskeva Piatnitsa.')
ON CONFLICT (entity_id,source_id,evidence_type) DO NOTHING;

INSERT INTO entity_periods (entity_id,period_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_ROM_AESCULAPIUS','PER_ROM_REPUBLIC','high','Cult brought to Rome 293-291 BCE (Livy 10.47; Per. 11).','SRC_LIVY_AUC','needs_review'),
 ('ENT_ROM_LUNA','PER_ROM_REPUBLIC','high','Aventine temple attributed to the regal/early republican period; discussed by Cicero (DND 2.68).','SRC_CICERO_DE_NATURA','needs_review'),
 ('ENT_ROM_LATONA','PER_ROM_REPUBLIC','high','Latona in republican-era Latin letters (Cicero, DND 3.46).','SRC_CICERO_DE_NATURA','needs_review'),
 ('ENT_ISR_ASHTORETH','PER_ISR_IRON_AGE','high','Solomonic/Deuteronomistic polemic context (1 Kgs 11).','SRC_HEBREW_BIBLE','needs_review'),
 ('ENT_ISR_BAAL','PER_ISR_IRON_AGE','high','Omride-era Baal cult and the Carmel contest (1 Kgs 18); Hosea (8th c.).','SRC_HEBREW_BIBLE','needs_review'),
 ('ENT_ISR_HELEL','PER_ISR_EXILIC','high','Isaiah 14 taunt against the king of Babylon.','SRC_HEBREW_BIBLE','needs_review'),
 ('ENT_ISR_ANAT_YAHU','PER_ISR_SECOND_TEMPLE','high','Elephantine papyri, 5th c. BCE.','SRC_DDD_BIBLE','needs_review'),
 ('ENT_WEL_MYRDDIN','PER_CEL_MEDIEVAL_WELSH','high','Black Book of Carmarthen Myrddin poems; TYP.','SRC_TRIADS_BROMWICH','needs_review'),
 ('ENT_WEL_GWENHWYFAR','PER_CEL_MEDIEVAL_WELSH','high','TYP Triads 53, 54, 56; Culhwch ac Olwen.','SRC_TRIADS_BROMWICH','needs_review'),
 ('ENT_ORTH_PARASKEVA','PER_EAST_ORTHODOX','high','East Slavic folk-Orthodox veneration (Ivanits 1989).','SRC_IVANITS_RUSSIAN_FOLK','needs_review')
ON CONFLICT (entity_id,period_id) DO NOTHING;

-- Citations for the new entities (primary-verbatim where a public-domain text
-- could be substring-gated; secondary pointer + needs_review otherwise).
INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ROM_AESCULAPIUS_LIVY','ENT_ROM_AESCULAPIUS','SRC_LIVY_AUC','Livy, Ab Urbe Condita','Ab Urbe Condita 10.47',
 'the books were consulted: in the books it was found that Aesculapius must be brought to Rome from Epidaurus. Nor were any steps taken that year in that matter, because the consuls were fully occupied in the war, except that a supplication was performed to Aesculapius for one day.',
 'D. Spillan and Cyrus R. Edmonds',1850,'https://www.gutenberg.org/ebooks/10907','primary-verbatim',
 'The Sibylline consultation of 293 BCE that brought the Epidaurian Asclepius to Rome as Aesculapius; the arrival and Tiber Island temple are in the epitome of the lost Book 11.',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized) against Project Gutenberg #10907 (Livy, History of Rome Books 9-26, trans. Spillan & Edmonds), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ROM_AESCULAPIUS_LIVY');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ROM_LUNA_CICERO','ENT_ROM_LUNA','SRC_CICERO_DE_NATURA','Cicero, De Natura Deorum','De Natura Deorum 2.68',
 'Luna, the moon, is so called a lucendo (from shining); she bears the name also of Lucina: and as in Greece the women in labor invoke Diana Lucifera, so here they invoke Juno Lucina.',
 'Charles Duke Yonge',1877,'https://www.gutenberg.org/ebooks/14988','primary-verbatim',
 'Balbus''s Stoic etymology of the Roman moon-goddess; the same passage gives "Apollo, a Greek name, is called Sol, the sun; and Diana, Luna, the moon."',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized; Gutenberg italics underscores stripped) against Project Gutenberg #14988 (Yonge), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ROM_LUNA_CICERO');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ROM_LATONA_CICERO','ENT_ROM_LATONA','SRC_CICERO_DE_NATURA','Cicero, De Natura Deorum','De Natura Deorum 3.46',
 'But if you think Latona a Goddess, how can you avoid admitting Hecate to be one also, who was the daughter of Asteria, Latona''s sister?',
 'Charles Duke Yonge',1877,'https://www.gutenberg.org/ebooks/14988','primary-verbatim',
 'Cotta''s argument presumes Latona''s established place among the Roman gods.',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized; Gutenberg italics underscores stripped) against Project Gutenberg #14988 (Yonge), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ROM_LATONA_CICERO');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ISR_ASHTORETH_KJV','ENT_ISR_ASHTORETH','SRC_HEBREW_BIBLE','Hebrew Bible (KJV)','1 Kings 11:5',
 'For Solomon went after Ashtoreth the goddess of the Zidonians, and after Milcom the abomination of the Ammonites.',
 'King James Version',1611,'https://www.gutenberg.org/ebooks/10','primary-verbatim',
 'The text itself identifies Ashtoreth as "the goddess of the Zidonians", i.e. Phoenician/Canaanite Astarte (DDD s.v. Astarte).',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized) against Project Gutenberg #10 (KJV), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ISR_ASHTORETH_KJV');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ISR_BAAL_KJV','ENT_ISR_BAAL','SRC_HEBREW_BIBLE','Hebrew Bible (KJV)','1 Kings 18:21',
 'And Elijah came unto all the people, and said, How long halt ye between two opinions? if the LORD be God, follow him: but if Baal, then follow him. And the people answered him not a word.',
 'King James Version',1611,'https://www.gutenberg.org/ebooks/10','primary-verbatim',
 'The Carmel contest: Baal as the rival cult within Israelite religion; the Baal of Ahab''s Israel is the Phoenician/Canaanite storm-god (DDD s.v. Baal).',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized) against Project Gutenberg #10 (KJV), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ISR_BAAL_KJV');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ISR_HELEL_KJV','ENT_ISR_HELEL','SRC_HEBREW_BIBLE','Hebrew Bible (KJV)','Isaiah 14:12',
 'How art thou fallen from heaven, O Lucifer, son of the morning! how art thou cut down to the ground, which didst weaken the nations!',
 'King James Version',1611,'https://www.gutenberg.org/ebooks/10','primary-verbatim',
 'KJV "Lucifer" renders Hebrew helel ben shahar ("shining one, son of dawn") via Vulgate lucifer; on the Canaanite astral-myth background see DDD s.v. Helel.',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized) against Project Gutenberg #10 (KJV), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ISR_HELEL_KJV');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ISR_ANAT_YAHU_DDD','ENT_ISR_ANAT_YAHU','SRC_DDD_BIBLE','Dictionary of Deities and Demons in the Bible (2nd ed., Brill 1999)','s.v. "Anat-Yahu" (K. van der Toorn); cf. s.v. "Anat"',
 NULL,NULL,NULL,NULL,'secondary',
 'Pointer citation: Anat-Yahu is attested in the Elephantine oath text Cowley 44 = TAD B7.3 (5th c. BCE); the DDD entry surveys the evidence and the debate (goddess vs. hypostasis of Yahu).',
 NULL,'buildout v2.1.60: pointer to a named DDD entry; no quote reproduced (in-copyright reference work; owner copy not on hand for gating)',true,
 'POINTER CITATION — secondary reference entry named but not quote-gated; verify against the owner''s DDD copy.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ISR_ANAT_YAHU_DDD');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_WEL_MYRDDIN_BROMWICH','ENT_WEL_MYRDDIN','SRC_TRIADS_BROMWICH','Rachel Bromwich, Trioedd Ynys Prydein (4th ed., 2014)','Notes to personal names, s.n. Myrddin (Wyllt); cf. Triad 87',
 NULL,NULL,NULL,NULL,'secondary',
 'Pointer citation: Bromwich''s onomastic note on Myrddin — the wild prophet of the Old North (Arfderydd legend; the Myrddin poems of the Black Book of Carmarthen) and Geoffrey of Monmouth''s latinization Merlinus.',
 NULL,'buildout v2.1.60: pointer to a named entry in Bromwich TYP; no quote reproduced (in-copyright)',true,
 'POINTER CITATION — secondary reference entry named but not quote-gated; verify against the owner''s Bromwich copy.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_WEL_MYRDDIN_BROMWICH');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_WEL_GWENHWYFAR_BROMWICH','ENT_WEL_GWENHWYFAR','SRC_TRIADS_BROMWICH','Rachel Bromwich, Trioedd Ynys Prydein (4th ed., 2014)','Triad 56 (Arthur''s Three Great Queens); notes to personal names, s.n. Gwenhwyfar',
 NULL,NULL,NULL,NULL,'secondary',
 'Pointer citation: Triad 56 names three Gwenhwyfars as Arthur''s great queens; Bromwich''s onomastic note traces the name and its passage into continental romance.',
 NULL,'buildout v2.1.60: pointer to a named triad and entry in Bromwich TYP; no quote reproduced (in-copyright)',true,
 'POINTER CITATION — secondary reference entry named but not quote-gated; verify against the owner''s Bromwich copy.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_WEL_GWENHWYFAR_BROMWICH');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_ORTH_PARASKEVA_IVANITS','ENT_ORTH_PARASKEVA','SRC_IVANITS_RUSSIAN_FOLK','Linda J. Ivanits, Russian Folk Belief (M. E. Sharpe, 1989)','ch. 1 (on the folk pantheon''s Christian veneer) and index s.v. Paraskeva Piatnitsa',
 NULL,NULL,NULL,NULL,'secondary',
 'Pointer citation: Ivanits documents the folk cult of Paraskeva Pyatnitsa (Friday saint of spinning, women''s work and wells) and its widely accepted continuity with Mokosh.',
 NULL,'buildout v2.1.60: pointer to a named discussion in Ivanits 1989; no quote reproduced (in-copyright)',true,
 'POINTER CITATION — secondary reference named but not quote-gated; verify against a copy of Ivanits and add page numbers.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_ORTH_PARASKEVA_IVANITS');

-- Biblical attestations added to two EXISTING Canaanite entities (Tier-1 items
-- "Dagon (1 Sam 5)" and "Resheph (Hab 3:5)": same deity inside the Hebrew Bible,
-- so no new entity or edge is warranted — the reception is documented by citation).
INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_CAN_DAGON_KJV','ENT_CAN_DAGON','SRC_HEBREW_BIBLE','Hebrew Bible (KJV)','1 Samuel 5:2',
 'When the Philistines took the ark of God, they brought it into the house of Dagon, and set it by Dagon.',
 'King James Version',1611,'https://www.gutenberg.org/ebooks/10','primary-verbatim',
 'The Philistine Dagon of Ashdod in the ark narrative — the same West Semitic grain-god attested at Ugarit and on the Middle Euphrates (DDD s.v. Dagon); the Hebrew Bible is his best-known attestation.',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized) against Project Gutenberg #10 (KJV), fetched 2026-07-01',false,NULL
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_CAN_DAGON_KJV');

INSERT INTO entity_citations (citation_id,entity_id,source_id,work_title,locus,quote,translator,translation_year,source_url,evidence_grade,evidence_note,verified_on,verify_method,needs_review,review_reason)
SELECT 'CIT_CAN_RESHEPH_KJV','ENT_CAN_RESHEPH','SRC_HEBREW_BIBLE','Hebrew Bible (KJV)','Habakkuk 3:5',
 'Before him went the pestilence, and burning coals went forth at his feet.',
 'King James Version',1611,'https://www.gutenberg.org/ebooks/10','primary-verbatim',
 'KJV "burning coals" renders Hebrew resheph: in Yahweh''s theophany the old plague-god Resheph marches, demoted, in the divine retinue alongside Deber ("the pestilence") — DDD s.v. Resheph (P. Xella).',
 CURRENT_DATE,'buildout v2.1.60: verbatim substring gate (whitespace-normalized) against Project Gutenberg #10 (KJV), fetched 2026-07-01',true,
 'Referent identification (KJV "burning coals" = resheph) rests on DDD s.v. Resheph; quote itself gated verbatim. Confirm against the owner''s DDD copy.'
WHERE NOT EXISTS (SELECT 1 FROM entity_citations WHERE citation_id='CIT_CAN_RESHEPH_KJV');

-- ---------------------------------------------------------------------------
-- (2) TIER 1 — new edges (all review_status='needs_review')
-- ---------------------------------------------------------------------------
-- 2a. Greek <-> Egyptian interpretatio graeca (ancient equations -> equated_with)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_EGY_OSIRIS','equated_with','ENT_DIONYSUS','high',
  'Ancient interpretatio, in Herodotus''s own voice: "except only Isis and Osiris (who they say is Dionysos)" (Hdt 2.42) and "Now Osiris in the tongue of Hellas is Dionysos" (Hdt 2.144; trans. Macaulay, PG #2707, both verified verbatim 2026-07-01). Also Plutarch, De Iside 35 (trans. Babbitt, Loeb 1936, PD): "That Osiris is identical with Dionysus who could more fittingly know than yourself, Clea?" (verified against LacusCurtius 2026-07-01); cf. De Iside 13. Encoded equated_with per policy — an ancient author equates; no derivation asserted. [v2.1.60]',
  'SRC_HERODOTUS_HISTORIES','needs_review','PER_GRK_CLASSICAL'),
 ('ENT_EGY_ISIS','equated_with','ENT_DEMETER','high',
  'Ancient interpretatio: "now Isis is in the tongue of the Hellenes Demeter" (Hdt 2.59; trans. Macaulay, PG #2707, verified verbatim 2026-07-01); cf. Hdt 2.156 "Demeter is Isis". Encoded equated_with per policy. [v2.1.60]',
  'SRC_HERODOTUS_HISTORIES','needs_review','PER_GRK_CLASSICAL'),
 ('ENT_EGY_HORUS','equated_with','ENT_APOLLO','high',
  'Ancient interpretatio: "Oros the son of Osiris, whom the Hellenes call Apollo" (Hdt 2.144) and "in the Egyptian tongue Apollo is Oros" (Hdt 2.156; trans. Macaulay, PG #2707, both verified verbatim 2026-07-01). Encoded equated_with per policy. [v2.1.60]',
  'SRC_HERODOTUS_HISTORIES','needs_review','PER_GRK_CLASSICAL'),
 ('ENT_EGY_BASTET','equated_with','ENT_ARTEMIS','high',
  'Ancient interpretatio: "Now Bubastis in the Hellenic tongue is Artemis" (Hdt 2.137) and "Artemis is Bubastis" (Hdt 2.156; trans. Macaulay, PG #2707, both verified verbatim 2026-07-01). Boubastis is Bastet, mistress of Bubastis. Encoded equated_with per policy. [v2.1.60]',
  'SRC_HERODOTUS_HISTORIES','needs_review','PER_GRK_CLASSICAL'),
 ('ENT_EGY_WADJET','equated_with','ENT_LETO','medium',
  'Ancient interpretatio at Buto: "This Oracle which is in Egypt is sacred to Leto, and it is established in a great city near that mouth of the Nile which is called Sebennytic" (Hdt 2.155) and Leto as nurse of Apollo/Horus on the floating island (Hdt 2.156; trans. Macaulay, PG #2707, verified verbatim 2026-07-01). Herodotus never names the Egyptian goddess; her identification as Wadjet, mistress of Buto (Per-Wadjet), is modern Egyptology (Wilkinson, Complete Gods and Goddesses, s.v. Wadjet) — hence MEDIUM. [v2.1.60]',
  'SRC_HERODOTUS_HISTORIES','needs_review','PER_GRK_CLASSICAL'),
 ('ENT_EGY_THOTH','equated_with','ENT_HERMES','high',
  'Ancient equation, in Cicero''s enumeration of the several Mercurii (= Greek Hermes): "A fifth, whom we call, in their language, Thoth, as with them the first month of the year is called, is he whom the people of Pheneum worship, and who is said to have killed Argus, to have fled for it into Egypt, and to have given laws and learning to the Egyptians." (De Natura Deorum 3.56; trans. Yonge, PG #14988, verified verbatim 2026-07-01, bracketed footnote number stripped). Cf. the Thoth->Hermes Trismegistus chain already in the DB. Encoded equated_with per policy. [v2.1.60]',
  'SRC_CICERO_DE_NATURA','needs_review','PER_GRK_HELLENISTIC'),
 ('ENT_EGY_IMHOTEP','equated_with','ENT_ASCLEPIUS','medium',
  'The deified vizier Imhotep (Greek Imouthes) was identified with Asklepios in Ptolemaic Egypt; his Memphite sanctuary was the Asklepieion (pointer: Wildung, Egyptian Saints: Deification in Pharaonic Egypt, NYU Press 1977, the Imhotep chapters; cf. the Imouthes-Asclepius aretalogy P.Oxy. XI 1381). Secondary pointer — needs review. [v2.1.60]',
  'SRC_WILDUNG_IMHOTEP','needs_review','PER_EGY_PTOLEMAIC')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- 2b. Greek <-> Roman
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_ROM_CUPID','identified_with','ENT_EROS','high',
  'Cupid (Amor) is the Roman counterpart of Greek Eros (OCD s.v. Cupid; cf. Apuleius, Cupid and Psyche). Follows the existing OCD identified_with pattern (Venus/Aphrodite, Jupiter/Zeus). Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_ROM_VICTORIA','identified_with','ENT_NIKE','high',
  'Victoria is the Roman counterpart of Greek Nike (OCD s.v. Victoria); her cult (temple on the Palatine, 294 BCE) absorbed the iconography of Nike. Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_ROM_SOL_INVICTUS','identified_with','ENT_HELIOS','medium',
  'Roman Sol (Indiges, later Invictus) is the Latin sun-god identified with Greek Helios (OCD s.v. Sol); cf. Cicero, DND 2.68 for the solar interpretatio field ("Apollo, a Greek name, is called Sol, the sun"). MEDIUM because this entity is specifically the imperial-cult form. Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_IMPERIAL'),
 ('ENT_ROM_APOLLO','reception_of','ENT_APOLLO','high',
  'Roman Apollo is a direct import of the Greek god — the one major god whose Greek name Rome kept, received via Cumae/Delphi (first temple vowed 433 BCE for plague relief, Livy 4.25; OCD s.v. Apollo). Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_APOLLO','received_as','ENT_ROM_APOLLO','high',
  'Mirror of the Roman Apollo reception edge: the Greek Apollo was received at Rome under his own name (Livy 4.25; OCD s.v. Apollo). Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_ROM_AESCULAPIUS','reception_of','ENT_ASCLEPIUS','high',
  'Documented cult transfer: "the books were consulted: in the books it was found that Aesculapius must be brought to Rome from Epidaurus" (Livy 10.47; trans. Spillan & Edmonds, PG #10907, verified verbatim 2026-07-01); the god was fetched from Greek Epidaurus in 291 BCE and installed on the Tiber Island (Livy Per. 11). [v2.1.60]',
  'SRC_LIVY_AUC','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_ASCLEPIUS','received_as','ENT_ROM_AESCULAPIUS','high',
  'Mirror of the Aesculapius reception edge: Asclepius of Epidaurus was received at Rome as Aesculapius, 293-291 BCE (Livy 10.47, quote on the mirror row; Per. 11). [v2.1.60]',
  'SRC_LIVY_AUC','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_ROM_LUNA','identified_with','ENT_SELENE','high',
  'Luna is the Roman counterpart of Greek Selene (OCD s.v. Luna); Cicero treats her among the di caelestes (DND 2.68 — quote on the entity citation). Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_ROM_LATONA','reception_of','ENT_LETO','high',
  'Latona is the Latin form of Greek Leto, the name borrowed early (via Etruscan Letun); mother of Apollo and Diana in Roman cult and letters (OCD s.v. Latona; Cicero DND 3.46 — quote on the entity citation). Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC'),
 ('ENT_LETO','received_as','ENT_ROM_LATONA','high',
  'Mirror of the Latona reception edge: Greek Leto received in Latium as Latona (OCD s.v. Latona). Pointer cite — needs review. [v2.1.60]',
  'SRC_ROMAN_OCD','needs_review','PER_ROM_REPUBLIC')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- 2c. Mesopotamian <-> Canaanite (secondary pointers; ancient god-list equations
--     encoded equated_with, actual westward transmissions as reception chains)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_MES_DAGAN','received_as','ENT_CAN_DAGON','high',
  'Dagon of the coastal Levant (Ugarit; later Philistine Ashdod and Gaza) is the West Semitic continuation of Middle-Euphrates Dagan (Mari, Ebla, Emar, Terqa) — the same deity carried west (pointer: DDD s.v. Dagon, J. F. Healey). Secondary pointer — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_CAN_DAGON','reception_of','ENT_MES_DAGAN','high',
  'Mirror of the Dagan->Dagon transmission edge (DDD s.v. Dagon). Secondary pointer — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_MES_NINGAL','received_as','ENT_CAN_NIKKAL','high',
  'Ugaritic Nikkal (nkl, in the hymn of Nikkal-and-Ib and the Kotharat), bride of the moon-god Yarikh, is the borrowed Sumerian Ningal ("Great Lady"), wife of Nanna — transmitted west via Hurrian Nikkal (pointer: Black & Green, Gods, Demons and Symbols of Ancient Mesopotamia, s.v. Ningal). Secondary pointer — needs review. [v2.1.60]',
  'SRC_BLACK_GREEN_MESO','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_CAN_NIKKAL','reception_of','ENT_MES_NINGAL','high',
  'Mirror of the Ningal->Nikkal transmission edge (Black & Green s.v. Ningal; name is a direct loan). Secondary pointer — needs review. [v2.1.60]',
  'SRC_BLACK_GREEN_MESO','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_CAN_RESHEPH','equated_with','ENT_MES_NERGAL','medium',
  'Resheph is equated with Nergal in the ancient god-lists (Ebla; the Ugaritic polyglot lists) as the plague-and-underworld god (pointer: DDD s.v. Resheph, P. Xella). Ancient list-equation known through a modern reference — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_CAN_KOTHAR','equated_with','ENT_MES_ENKI_EA','medium',
  'Kothar-wa-Khasis, the Ugaritic craftsman/wisdom god, is equated with Ea in the Ugaritic god-lists, sharing the craft-and-cunning portfolio (pointer: DDD s.v. Koshar, M. S. Smith). Ancient list-equation known through a modern reference — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_CAN_SHAPASH','equated_with','ENT_MES_UTU_SHAMASH','high',
  'Ugaritic Shapshu and Akkadian Shamash are the common Semitic sun-deity under cognate names (feminine at Ugarit, masculine in Mesopotamia), equated in the polyglot god-lists (pointer: DDD s.v. Shemesh, respectively Shapash). Secondary pointer — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_CAN_BRONZE_AGE'),
 ('ENT_CAN_BAAL','equated_with','ENT_MES_ADAD_ISHKUR','high',
  'Baal-Hadad of Ugarit and Mesopotamian Adad/Ishkur are the same Semitic storm-god Haddu/Adda under regional names, equated in the god-lists (pointer: DDD s.v. Hadad, J. C. Greenfield). Secondary pointer — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_CAN_BRONZE_AGE')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- 2d. Canaanite <-> Israelite (KJV-verbatim primary anchors + DDD pointers)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_CAN_ASTARTE','received_as','ENT_ISR_ASHTORETH','high',
  'The Hebrew Bible itself marks the reception: "For Solomon went after Ashtoreth the goddess of the Zidonians" (1 Kgs 11:5, KJV, PG #10, verified verbatim 2026-07-01). Ashtoreth is Sidonian Astarte, the theonym deformed with the vowels of boshet, "shame" (DDD s.v. Astarte). [v2.1.60]',
  'SRC_HEBREW_BIBLE','needs_review','PER_ISR_IRON_AGE'),
 ('ENT_ISR_ASHTORETH','reception_of','ENT_CAN_ASTARTE','high',
  'Mirror of the Astarte->Ashtoreth reception edge (1 Kgs 11:5 KJV, quote on the mirror row; DDD s.v. Astarte). [v2.1.60]',
  'SRC_HEBREW_BIBLE','needs_review','PER_ISR_IRON_AGE'),
 ('ENT_CAN_BAAL','received_as','ENT_ISR_BAAL','high',
  'The Baal opposed in Kings and Hosea is the Canaanite/Phoenician storm-god Baal Hadad received into Israelite religion as YHWH''s rival: "if the LORD be God, follow him: but if Baal, then follow him" (1 Kgs 18:21, KJV, PG #10, verified verbatim 2026-07-01; DDD s.v. Baal). [v2.1.60]',
  'SRC_HEBREW_BIBLE','needs_review','PER_ISR_IRON_AGE'),
 ('ENT_ISR_BAAL','reception_of','ENT_CAN_BAAL','high',
  'Mirror of the Baal Hadad->biblical Baal reception edge (1 Kgs 18:21 KJV, quote on the mirror row; DDD s.v. Baal). [v2.1.60]',
  'SRC_HEBREW_BIBLE','needs_review','PER_ISR_IRON_AGE'),
 ('ENT_CAN_ANAT','received_as','ENT_ISR_ANAT_YAHU','medium',
  'Anat-Yahu ("Anat of Yahu"), invoked in the Jewish colony at Elephantine (oath text Cowley 44 = TAD B7.3, 5th c. BCE), carries the name of Canaanite Anat into a Yahwistic cult context (pointer: DDD s.v. Anat-Yahu, K. van der Toorn). MEDIUM: whether a full goddess or a hypostasis of Yahu is debated. Secondary pointer — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_ISR_SECOND_TEMPLE'),
 ('ENT_ISR_ANAT_YAHU','reception_of','ENT_CAN_ANAT','medium',
  'Mirror of the Anat->Anat-Yahu reception edge (DDD s.v. Anat-Yahu). Secondary pointer — needs review. [v2.1.60]',
  'SRC_DDD_BIBLE','needs_review','PER_ISR_SECOND_TEMPLE'),
 ('ENT_ISR_HELEL','received_as','ENT_CHR_LUCIFER','high',
  '"How art thou fallen from heaven, O Lucifer, son of the morning!" (Isa 14:12, KJV, PG #10, verified verbatim 2026-07-01). KJV "Lucifer" follows Vulgate lucifer for Hebrew helel ben shahar; patristic exegesis (Origen, Tertullian) read the fallen morning star as the fall of Satan, making Helel the fountainhead of the Christian Lucifer (DDD s.v. Helel). Completes the chain Helel -> Lucifer -> Devil (Lucifer<->Devil edges already in DB). [v2.1.60]',
  'SRC_HEBREW_BIBLE','needs_review','PER_PATRISTIC'),
 ('ENT_CHR_LUCIFER','reception_of','ENT_ISR_HELEL','high',
  'Mirror of the Helel->Lucifer reception edge (Isa 14:12 KJV, quote on the mirror row; DDD s.v. Helel). [v2.1.60]',
  'SRC_HEBREW_BIBLE','needs_review','PER_PATRISTIC')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- (3) TIER 2 — new edges (secondary pointers, calibrated confidence)
-- ---------------------------------------------------------------------------
-- 3a. Anglo-Saxon weekday interpretatio (ancient calque -> equated_with)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_ASX_WODEN','equated_with','ENT_ROM_MERCURY','high',
  'Interpretatio germanica weekday calque: dies Mercurii -> OE wodnesdaeg (Wednesday) equates Woden with Mercury (pointer: Simek, Dictionary of Northern Mythology, s.v. Wodan and the days-of-the-week discussion; parallel to the existing Tacitus edge for Norse Odin). Secondary pointer — needs review. [v2.1.60]',
  'SRC_SIMEK_NORTHERN','needs_review','PER_ANGLO_SAXON'),
 ('ENT_ASX_THUNOR','equated_with','ENT_ROM_JUPITER','high',
  'Interpretatio germanica weekday calque: dies Iovis -> OE thunresdaeg (Thursday) equates the thunderer Thunor with Jupiter Tonans (pointer: Simek s.v. Donar). Secondary pointer — needs review. [v2.1.60]',
  'SRC_SIMEK_NORTHERN','needs_review','PER_ANGLO_SAXON'),
 ('ENT_ASX_TIW','equated_with','ENT_ROM_MARS','high',
  'Interpretatio germanica weekday calque: dies Martis -> OE tiwesdaeg (Tuesday) equates Tiw with Mars (pointer: Simek s.v. *Tiwaz/Tyr). Secondary pointer — needs review. [v2.1.60]',
  'SRC_SIMEK_NORTHERN','needs_review','PER_ANGLO_SAXON'),
 ('ENT_ASX_FRIGE','equated_with','ENT_ROM_VENUS','high',
  'Interpretatio germanica weekday calque: dies Veneris -> OE frigedaeg (Friday) renders Venus with Frige/Frija (pointer: Simek s.v. Frigg). Secondary pointer — needs review. [v2.1.60]',
  'SRC_SIMEK_NORTHERN','needs_review','PER_ANGLO_SAXON')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- 3b. Sami Horagalles <- Norse Thor (documented borrowing, name and hammer)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_SAMI_HORAGALLES','reception_of','ENT_NOR_THOR','high',
  'The Sami thunder-god Horagalles bears a borrowed Scandinavian name (Thora galles < Old Norse Thorr karl, "old man Thor") and the hammer attribute on the drum figures — a documented Norse->Sami reception (pointer: Rydving, The End of Drum-Time, on the drum-figure Horagalles; cf. DuBois, Nordic Religions in the Viking Age). The existing aligned_with edge (SRC_SAMI_RELIGION) records the functional parallel; this edge records the borrowing. Secondary pointer — needs review. [v2.1.60]',
  'SRC_RYDVING_DRUM_TIME','needs_review','PER_SAMI_TRADITIONAL'),
 ('ENT_NOR_THOR','received_as','ENT_SAMI_HORAGALLES','high',
  'Mirror of the Horagalles reception edge (Rydving; DuBois). Secondary pointer — needs review. [v2.1.60]',
  'SRC_RYDVING_DRUM_TIME','needs_review','PER_SAMI_TRADITIONAL')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- 3c. Slavic Christianization substitutions (folk-religious function transfer,
--     MEDIUM confidence by design)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_SLAV_PERUN','received_as','ENT_ISR_ELIJAH','medium',
  'Folk-religious substitution after the conversion of Rus (988 CE): Perun''s thunder functions passed to the prophet Elijah — "Ilya the Prophet", whose chariot rumbles as thunder in Russian folk belief (pointer: Ivanits, Russian Folk Belief, ch. 1 and s.v. Il''ia). MEDIUM: a documented functional substitution, not an identity claim. Secondary pointer — needs review. [v2.1.60]',
  'SRC_IVANITS_RUSSIAN_FOLK','needs_review','PER_EAST_ORTHODOX'),
 ('ENT_ISR_ELIJAH','reception_of','ENT_SLAV_PERUN','medium',
  'Mirror of the Perun->Elijah substitution edge, scoped to the East Slavic folk cult of Ilya (Ivanits). Secondary pointer — needs review. [v2.1.60]',
  'SRC_IVANITS_RUSSIAN_FOLK','needs_review','PER_EAST_ORTHODOX'),
 ('ENT_SLAV_VELES','received_as','ENT_SAINT_BLAISE','medium',
  'Folk-religious substitution: Veles/Volos, the "cattle god" (skotii bog) of the Primary Chronicle, was succeeded by St Blasius (Vlasii) as cattle patron in Russian folk Christianity; the name similarity Volos/Vlasii aided the merger (pointer: Ivanits, Russian Folk Belief). MEDIUM: functional substitution. Secondary pointer — needs review. [v2.1.60]',
  'SRC_IVANITS_RUSSIAN_FOLK','needs_review','PER_EAST_ORTHODOX'),
 ('ENT_SAINT_BLAISE','reception_of','ENT_SLAV_VELES','medium',
  'Mirror of the Veles->St Blasius substitution edge, scoped to the East Slavic folk cult of Vlasii (Ivanits). Secondary pointer — needs review. [v2.1.60]',
  'SRC_IVANITS_RUSSIAN_FOLK','needs_review','PER_EAST_ORTHODOX'),
 ('ENT_SLAV_MOKOSH','received_as','ENT_ORTH_PARASKEVA','medium',
  'Folk-religious substitution: Mokosh''s spinning/women''s-work functions were absorbed by St Paraskeva Pyatnitsa in Russian folk belief (pointer: Ivanits, Russian Folk Belief, s.v. Paraskeva Piatnitsa). MEDIUM: functional substitution. Secondary pointer — needs review. [v2.1.60]',
  'SRC_IVANITS_RUSSIAN_FOLK','needs_review','PER_EAST_ORTHODOX'),
 ('ENT_ORTH_PARASKEVA','reception_of','ENT_SLAV_MOKOSH','medium',
  'Mirror of the Mokosh->Paraskeva substitution edge (Ivanits). Secondary pointer — needs review. [v2.1.60]',
  'SRC_IVANITS_RUSSIAN_FOLK','needs_review','PER_EAST_ORTHODOX')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- 3d. Arthurian <-> Welsh (Mabon<-Maponos already in DB, edge 3440; not repeated)
INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status,period_id) VALUES
 ('ENT_ART_MERLIN','reception_of','ENT_WEL_MYRDDIN','high',
  'Geoffrey of Monmouth latinized Welsh Myrddin as Merlinus (Vita Merlini; Historia Regum Britanniae), fusing the wild prophet of the Old North with Ambrosius — the direct source of the Arthurian Merlin (pointer: Bromwich, TYP 4th ed., s.n. Myrddin). Secondary pointer — needs review. [v2.1.60]',
  'SRC_TRIADS_BROMWICH','needs_review','PER_ARTHURIAN'),
 ('ENT_WEL_MYRDDIN','received_as','ENT_ART_MERLIN','high',
  'Mirror of the Merlin reception edge (Bromwich s.n. Myrddin). Secondary pointer — needs review. [v2.1.60]',
  'SRC_TRIADS_BROMWICH','needs_review','PER_ARTHURIAN'),
 ('ENT_ART_GUINEVERE','reception_of','ENT_WEL_GWENHWYFAR','high',
  'Guinevere continues Welsh Gwenhwyfar (TYP Triads 53, 54, 56; Culhwch ac Olwen), the name passing through French Guenievre into English (pointer: Bromwich, TYP 4th ed., s.n. Gwenhwyfar). Secondary pointer — needs review. [v2.1.60]',
  'SRC_TRIADS_BROMWICH','needs_review','PER_ARTHURIAN'),
 ('ENT_WEL_GWENHWYFAR','received_as','ENT_ART_GUINEVERE','high',
  'Mirror of the Guinevere reception edge (Bromwich s.n. Gwenhwyfar). Secondary pointer — needs review. [v2.1.60]',
  'SRC_TRIADS_BROMWICH','needs_review','PER_ARTHURIAN')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- (4) FIXES to existing edges (in place; all re-flagged needs_review)
-- ---------------------------------------------------------------------------

-- F1. Adonis: edge 3493 said Phoenician Adonis is a reception of GREEK Adonis — inverted.
UPDATE entity_relationships SET
  subject_entity_id='ENT_ADONIS', object_entity_id='ENT_PHO_ADONIS',
  review_status='needs_review',
  rationale='[REVERSED v2.1.60: reception_of subject must be the LATER/receiving form. Greek Adonis (the name is Semitic adon, "lord") is the Greek reception of the Phoenician dying consort of Astarte at Byblos (Philo of Byblos apud Eusebius, PE 1.10), not vice versa.] ' || coalesce(rationale,'')
WHERE relationship_id=3493 AND subject_entity_id='ENT_PHO_ADONIS'
  AND relationship_type='reception_of' AND object_entity_id='ENT_ADONIS';

-- F2. Greek gods asserted as "reception_of" Arabian deities -> retype to the
--     equation the sources actually attest (mirrors of existing equated_with
--     rows 4291/4293/4294).
UPDATE entity_relationships SET relationship_type='equated_with', confidence='high', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with, medium->high: the evidence (Greek-era identifications of Allat with Athena, e.g. the Palmyrene/Nabataean iconography Healey surveys) is interpretatio, not a derivation of the Greek goddess. Mirror of edge 4293.] ' || coalesce(rationale,'')
WHERE relationship_id=1521 AND subject_entity_id='ENT_ATHENA' AND relationship_type='reception_of' AND object_entity_id='ENT_ARA_ALLAT';

UPDATE entity_relationships SET relationship_type='equated_with', confidence='high', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with, medium->high: the Venus-star identification of al-Uzza with Aphrodite (Healey) is interpretatio, not a derivation of the Greek goddess. Mirror of edge 4294.] ' || coalesce(rationale,'')
WHERE relationship_id=1523 AND subject_entity_id='ENT_APHRODITE' AND relationship_type='reception_of' AND object_entity_id='ENT_ARA_AL_UZZA';

UPDATE entity_relationships SET relationship_type='equated_with', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->equated_with: Manat was identified with Nemesis in Nabataean-era inscriptions (Healey); an equation, not a transmission of Manat into the Greek goddess.] ' || coalesce(rationale,'')
WHERE relationship_id=1524 AND subject_entity_id='ENT_ARA_MANAT' AND relationship_type='received_as' AND object_entity_id='ENT_NEMESIS';

UPDATE entity_relationships SET relationship_type='equated_with', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with: mirror of the Manat-Nemesis equation (Healey); Greek Nemesis does not derive from Manat.] ' || coalesce(rationale,'')
WHERE relationship_id=1525 AND subject_entity_id='ENT_NEMESIS' AND relationship_type='reception_of' AND object_entity_id='ENT_ARA_MANAT';

UPDATE entity_relationships SET relationship_type='equated_with', confidence='high', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with, medium->high: Dushara was identified with Dionysus in the Hellenistic-Roman Nabataean sphere (Healey); an equation, not a derivation of the Greek god. Mirror of edge 4291.] ' || coalesce(rationale,'')
WHERE relationship_id=1527 AND subject_entity_id='ENT_DIONYSUS' AND relationship_type='reception_of' AND object_entity_id='ENT_ARA_DUSHARA';

UPDATE entity_relationships SET relationship_type='equated_with', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->equated_with: Herodotus is an ancient author making an equation — "Of gods they believe in Dionysos and Urania alone ... and Urania they call Alilat" (Hdt 3.8, trans. Macaulay, PG #2707, verified verbatim 2026-07-01; Macaulay''s "Urania" = Aphrodite Ourania). No derivation of the Arabian goddess into Aphrodite is asserted by the source.] ' || coalesce(rationale,'')
WHERE relationship_id=2396 AND subject_entity_id='ENT_ARA_ALLAT' AND relationship_type='received_as' AND object_entity_id='ENT_APHRODITE';

UPDATE entity_relationships SET relationship_type='equated_with', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with: mirror of the Hdt 3.8 Alilat = Aphrodite Urania equation ("and Urania they call Alilat", Macaulay, PG #2707, verified verbatim 2026-07-01); Greek Aphrodite does not derive from Allat.] ' || coalesce(rationale,'')
WHERE relationship_id=2397 AND subject_entity_id='ENT_APHRODITE' AND relationship_type='reception_of' AND object_entity_id='ENT_ARA_ALLAT';

-- F3-F5. Inverted received_as rows (subject must be the EARLIER deity) -> reception_of,
--        with correct-direction mirrors added.
UPDATE entity_relationships SET relationship_type='reception_of', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->reception_of: received_as subject must be the EARLIER form; Dea Syria is the later Roman cult-form of Atargatis of Hierapolis, so this row (Roman form as subject) is reception_of.] ' || coalesce(rationale,'')
WHERE relationship_id=7359 AND subject_entity_id='ENT_ROM_DEA_SYRIA' AND relationship_type='received_as' AND object_entity_id='ENT_ARA_ATARGATIS';

UPDATE entity_relationships SET relationship_type='reception_of', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->reception_of: received_as subject must be the EARLIER form; Dea Caelestis is the later Roman cult-form of Punic Tanit, so this row (Roman form as subject) is reception_of.] ' || coalesce(rationale,'')
WHERE relationship_id=7361 AND subject_entity_id='ENT_ROM_DEA_CAELESTIS' AND relationship_type='received_as' AND object_entity_id='ENT_PHO_TANIT';

UPDATE entity_relationships SET relationship_type='reception_of', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->reception_of: received_as subject must be the EARLIER form; Sol Invictus Elagabal is the later Roman imperial cult-form of Emesene Elagabal, so this row (Roman form as subject) is reception_of.] ' || coalesce(rationale,'')
WHERE relationship_id=7362 AND subject_entity_id='ENT_ROM_SOL_INVICTUS_ELAGABAL' AND relationship_type='received_as' AND object_entity_id='ENT_ARA_ELAGABAL';

INSERT INTO entity_relationships (subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_ARA_ATARGATIS','received_as','ENT_ROM_DEA_SYRIA','high',
  'Correct-direction mirror added v2.1.60 for the retyped edge 7359: Atargatis of Hierapolis was received in the Roman world as Dea Syria (Lucian, De Dea Syria; Beard/North/Price, Religions of Rome). Pointer — needs review.',
  'SRC_BEARD_ROMAN_RELIGIONS','needs_review'),
 ('ENT_PHO_TANIT','received_as','ENT_ROM_DEA_CAELESTIS','high',
  'Correct-direction mirror added v2.1.60 for the retyped edge 7361: Tanit of Carthage was received in Roman Africa as Dea Caelestis (Beard/North/Price, Religions of Rome). Pointer — needs review.',
  'SRC_BEARD_ROMAN_RELIGIONS','needs_review'),
 ('ENT_ARA_ELAGABAL','received_as','ENT_ROM_SOL_INVICTUS_ELAGABAL','high',
  'Correct-direction mirror added v2.1.60 for the retyped edge 7362: the Emesene sun-god Elagabal was received at Rome as Sol Invictus Elagabal under the emperor Elagabalus, 218-222 CE (Beard/North/Price, Religions of Rome). Pointer — needs review.',
  'SRC_BEARD_ROMAN_RELIGIONS','needs_review')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- F6. Khawandagar/Ali: edge 6562 made the 7th-c. imam a "reception of" the Yarsan
--     supreme-being concept (14th c. doctrine) — chronologically inverted.
UPDATE entity_relationships SET
  subject_entity_id='ENT_YRS_KHAWANDAGAR', object_entity_id='ENT_ISL_ALI',
  review_status='needs_review',
  rationale='[REVERSED v2.1.60: reception_of subject must be the LATER/receiving construct. The Yarsan doctrine of Khawandagar manifesting in Ali (Yarsan corpus, 14th c. onward) reinterprets the earlier historical Ali ibn Abi Talib; the previous row followed the mythic (emanationist) chronology instead of the historical one.] ' || coalesce(rationale,'')
WHERE relationship_id=6562 AND subject_entity_id='ENT_ISL_ALI'
  AND relationship_type='reception_of' AND object_entity_id='ENT_YRS_KHAWANDAGAR';

-- F7. Asclepius "reception_of" Eshmun: reversed derivation claim; the correct-direction
--     interpretatio edge (1512: Eshmun received_as Asclepius) already exists. Remove.
DELETE FROM entity_relationships
WHERE relationship_id=1513 AND subject_entity_id='ENT_ASCLEPIUS'
  AND relationship_type='reception_of' AND object_entity_id='ENT_PHO_ESHMUN';

-- F8. Sheol <- Mot: high -> medium (scholarly inference, not attested transmission).
UPDATE entity_relationships SET confidence='medium', review_status='needs_review',
  rationale='[CONFIDENCE v2.1.60 high->medium: Sheol shares the devouring-underworld imagery with Ugaritic Mot, but direct derivation is a scholarly inference (DDD s.v. Mot; Day 1985), not an attested transmission.] ' || coalesce(rationale,'')
WHERE relationship_id=1372 AND subject_entity_id='ENT_CAN_MOT' AND object_entity_id='ENT_ISR_SHEOL' AND confidence='high';

UPDATE entity_relationships SET confidence='medium', review_status='needs_review',
  rationale='[CONFIDENCE v2.1.60 high->medium: mirror of edge 1372; derivation of Sheol from Mot is a scholarly inference (DDD s.v. Mot; Day 1985).] ' || coalesce(rationale,'')
WHERE relationship_id=1373 AND subject_entity_id='ENT_ISR_SHEOL' AND object_entity_id='ENT_CAN_MOT' AND confidence='high';

-- F9. Heracles <- Melqart: high -> medium (the ancient EQUATION is secure and lives
--     on edge 6001; the DERIVATION of the Greek god is contested).
UPDATE entity_relationships SET confidence='medium', review_status='needs_review',
  rationale='[CONFIDENCE v2.1.60 high->medium: the ancient equation Melqart = Heracles is secure — Herodotus "made a voyage also to Tyre of Phenicia, hearing that in that place there was a holy temple of Heracles" (Hdt 2.44, trans. Macaulay, PG #2707, verified verbatim 2026-07-01), recorded as equated_with edge 6001 — but the claim that Greek Heracles historically DERIVES from Melqart is contested scholarship, hence medium.] ' || coalesce(rationale,'')
WHERE relationship_id=1510 AND subject_entity_id='ENT_PHO_MELQART' AND object_entity_id='ENT_HERACLES' AND confidence='high';

UPDATE entity_relationships SET confidence='medium', review_status='needs_review',
  rationale='[CONFIDENCE v2.1.60 high->medium: mirror of edge 1510; the derivation (as opposed to the ancient equation on edge 6001) is contested.] ' || coalesce(rationale,'')
WHERE relationship_id=1511 AND subject_entity_id='ENT_HERACLES' AND object_entity_id='ENT_PHO_MELQART' AND confidence='high';

-- F10. Zeus <- Teshub: motif transmission misfiled as deity reception -> aligned_with, low.
UPDATE entity_relationships SET relationship_type='aligned_with', confidence='low', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->aligned_with, high->low: West (East Face of Helicon) argues literary transmission of the succession/storm-champion NARRATIVE pattern, not that the god Zeus derives from Teshub; Zeus''s name is an independent IE inheritance (*Dyeus). Typological/motif alignment only. The Ullikummi->Typhon motif chain (edges 1482/1483) remains as reception.] ' || coalesce(rationale,'')
WHERE relationship_id=1480 AND subject_entity_id='ENT_HTT_TESHUB' AND relationship_type='received_as' AND object_entity_id='ENT_ZEUS';

UPDATE entity_relationships SET relationship_type='aligned_with', confidence='low', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->aligned_with, high->low: mirror of edge 1480; motif parallel (West), not a derivation of Zeus.] ' || coalesce(rationale,'')
WHERE relationship_id=1481 AND subject_entity_id='ENT_ZEUS' AND relationship_type='reception_of' AND object_entity_id='ENT_HTT_TESHUB';

-- F11. Typhon <- Seth: Plutarch makes an EQUATION -> equated_with (ancient author).
UPDATE entity_relationships SET relationship_type='equated_with', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with: Plutarch is an ancient author equating the two — "For this reason the Egyptians regularly call Typhon "Seth," which, being interpreted, means "overmastering and compelling."" (De Iside 41, trans. Babbitt, Loeb 1936, PD, verified verbatim against LacusCurtius 2026-07-01, footnote number stripped); cf. De Iside 62 "Typhon, as has been said, is named Seth and Bebon and Smu". Greek Typhon (Hesiodic) does not derive from Seth; the Ullikummi motif chain covers derivation.] ' || coalesce(rationale,'')
WHERE relationship_id=8026 AND subject_entity_id='ENT_TYPHON' AND relationship_type='reception_of' AND object_entity_id='ENT_EGY_SETH';

-- F12. Aphrodite <- Hathor: interpretatio -> equated_with, re-sourced to the passage
--      that actually attests it (Hdt 2.41), replacing the Plutarch source label.
UPDATE entity_relationships SET relationship_type='equated_with', source_id='SRC_HERODOTUS_HISTORIES', review_status='needs_review',
  rationale='[RETYPED v2.1.60 received_as->equated_with, re-sourced Plutarch->Herodotus: the ancient testimony is the Aphrodite temple in the cow-goddess city — "the name of the city is Atarbechis, and in it there is set up a holy temple of Aphrodite" (Hdt 2.41, trans. Macaulay, PG #2707, verified verbatim 2026-07-01); Atarbechis = Egyptian Per-Hathor (Wilkinson). Equation via interpretatio; the derivation channel for Aphrodite is already recorded via the Astarte/Ishtar edges.] ' || coalesce(rationale,'')
WHERE relationship_id=1468 AND subject_entity_id='ENT_EGY_HATHOR' AND relationship_type='received_as' AND object_entity_id='ENT_APHRODITE';

UPDATE entity_relationships SET relationship_type='equated_with', source_id='SRC_HERODOTUS_HISTORIES', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->equated_with, re-sourced Plutarch->Herodotus: mirror of edge 1468 (Hdt 2.41 Atarbechis temple of Aphrodite, verified verbatim 2026-07-01); Greek Aphrodite does not derive from Hathor.] ' || coalesce(rationale,'')
WHERE relationship_id=1469 AND subject_entity_id='ENT_APHRODITE' AND relationship_type='reception_of' AND object_entity_id='ENT_EGY_HATHOR';

-- F13. Lilith/Lilitu mirror-confidence reconcile (1455 low vs 4466 high, same source).
UPDATE entity_relationships SET confidence='high', review_status='needs_review',
  rationale='[CONFIDENCE v2.1.60 low->high, reconciled with mirror edge 4466 (high, same source): the lilitu->Lilith derivation (name and night-demon function) is standard (Black & Green s.v. lilitu; DDD s.v. Lilith).] ' || coalesce(rationale,'')
WHERE relationship_id=1455 AND subject_entity_id='ENT_JM_LILITH' AND object_entity_id='ENT_MES_LILITU' AND confidence='low';

-- F14. Cyril "reception_of" Athanasius: intra-Christian doctrinal continuity, not a
--      cross-tradition reception -> aligned_with (parallel to edge 7024).
UPDATE entity_relationships SET relationship_type='aligned_with', review_status='needs_review',
  rationale='[RETYPED v2.1.60 reception_of->aligned_with: intra-Christian doctrinal succession (Cyril continuing Athanasian Christology) is not a cross-tradition/period reception; reception_of is reserved for transmission across traditions. Parallel to edge 7024 (Hilary aligned_with Athanasius).] ' || coalesce(rationale,'')
WHERE relationship_id=7027 AND subject_entity_id='ENT_PAT_CYRIL_ALEX' AND relationship_type='reception_of' AND object_entity_id='ENT_ORTH_ATHANASIUS';

-- F15. Anglo-Saxon/Norse cognate pairs: aligned_with -> identified_with (cognate name
--      pairs, not mere typological parallels), per Simek.
UPDATE entity_relationships SET relationship_type='identified_with', source_id='SRC_SIMEK_NORTHERN', review_status='needs_review',
  rationale='[RETYPED v2.1.60 aligned_with->identified_with: Woden and Odin are the same Common Germanic god (*Wodanaz) under cognate names — an identification, not a typological parallel (Simek s.v. Odin/Wodan; previously sourced to Pollington).] ' || coalesce(rationale,'')
WHERE relationship_id=7421 AND subject_entity_id='ENT_ASX_WODEN' AND relationship_type='aligned_with' AND object_entity_id='ENT_NOR_ODIN';

UPDATE entity_relationships SET relationship_type='identified_with', source_id='SRC_SIMEK_NORTHERN', review_status='needs_review',
  rationale='[RETYPED v2.1.60 aligned_with->identified_with: Thunor and Thor are the same Common Germanic thunder-god (*Thunraz) under cognate names (Simek s.v. Donar/Thor; previously sourced to Pollington).] ' || coalesce(rationale,'')
WHERE relationship_id=7422 AND subject_entity_id='ENT_ASX_THUNOR' AND relationship_type='aligned_with' AND object_entity_id='ENT_NOR_THOR';

UPDATE entity_relationships SET relationship_type='identified_with', source_id='SRC_SIMEK_NORTHERN', review_status='needs_review',
  rationale='[RETYPED v2.1.60 aligned_with->identified_with: Tiw and Tyr are the same Common Germanic god (*Tiwaz) under cognate names (Simek s.v. Tyr; previously sourced to Pollington).] ' || coalesce(rationale,'')
WHERE relationship_id=7423 AND subject_entity_id='ENT_ASX_TIW' AND relationship_type='aligned_with' AND object_entity_id='ENT_NOR_TYR';

UPDATE entity_relationships SET relationship_type='identified_with', source_id='SRC_SIMEK_NORTHERN', review_status='needs_review',
  rationale='[RETYPED v2.1.60 aligned_with->identified_with: Frige and Frigg are the same Common Germanic goddess (*Frijjo) under cognate names (Simek s.v. Frigg; previously sourced to Pollington).] ' || coalesce(rationale,'')
WHERE relationship_id=7424 AND subject_entity_id='ENT_ASX_FRIGE' AND relationship_type='aligned_with' AND object_entity_id='ENT_NOR_FRIGG';

UPDATE entity_relationships SET relationship_type='identified_with', source_id='SRC_SIMEK_NORTHERN', review_status='needs_review',
  rationale='[RETYPED v2.1.60 aligned_with->identified_with: Ing and Freyr (Yngvi-Freyr) reflect the same Common Germanic *Ingwaz figure under cognate names (Simek s.v. Yngvi; confidence stays medium — the equation runs through the Yngvi byname; previously sourced to Pollington).] ' || coalesce(rationale,'')
WHERE relationship_id=7425 AND subject_entity_id='ENT_ASX_ING' AND relationship_type='aligned_with' AND object_entity_id='ENT_NOR_FREYR';

-- F16. Gehenna tradition mislabel: the concept's formative context is Israelite/Second
--      Temple (Valley of Hinnom; 1 Enoch; Synoptics), not medieval Jewish mysticism.
UPDATE entities SET tradition='Israelite/Second Temple'
WHERE entity_id='ENT_JM_GEHENNA' AND tradition='Jewish Mystical';

COMMIT;

-- ---------------------------------------------------------------------------
-- Post-fix verification
-- ---------------------------------------------------------------------------
\echo '--- new sources (expect 3) ---'
SELECT source_id FROM sources WHERE source_id IN ('SRC_WILDUNG_IMHOTEP','SRC_IVANITS_RUSSIAN_FOLK','SRC_RYDVING_DRUM_TIME');

\echo '--- new entities (expect 10, all candidate_verified_name) ---'
SELECT entity_id, canonical_name, tradition, review_status FROM entities
WHERE entity_id IN ('ENT_ROM_AESCULAPIUS','ENT_ROM_LUNA','ENT_ROM_LATONA','ENT_ISR_ASHTORETH','ENT_ISR_BAAL',
                    'ENT_ISR_HELEL','ENT_ISR_ANAT_YAHU','ENT_WEL_MYRDDIN','ENT_WEL_GWENHWYFAR','ENT_ORTH_PARASKEVA')
ORDER BY entity_id;

\echo '--- new citations (expect 12; 8 primary-verbatim with quotes, 4 secondary pointers flagged) ---'
SELECT citation_id, evidence_grade, quote IS NOT NULL AS has_quote, needs_review FROM entity_citations
WHERE citation_id IN ('CIT_ROM_AESCULAPIUS_LIVY','CIT_ROM_LUNA_CICERO','CIT_ROM_LATONA_CICERO','CIT_ISR_ASHTORETH_KJV',
                      'CIT_ISR_BAAL_KJV','CIT_ISR_HELEL_KJV','CIT_ISR_ANAT_YAHU_DDD','CIT_WEL_MYRDDIN_BROMWICH',
                      'CIT_WEL_GWENHWYFAR_BROMWICH','CIT_ORTH_PARASKEVA_IVANITS','CIT_CAN_DAGON_KJV','CIT_CAN_RESHEPH_KJV')
ORDER BY citation_id;

\echo '--- new v2.1.60 edges (expect 52, all needs_review) ---'
SELECT count(*) AS new_edges, count(*) FILTER (WHERE review_status='needs_review') AS flagged
FROM entity_relationships WHERE rationale LIKE '%[v2.1.60]%' OR rationale LIKE 'Correct-direction mirror added v2.1.60%';

\echo '--- fixed edges (expect 28 updates flagged needs_review) ---'
SELECT count(*) AS fixed_edges FROM entity_relationships
WHERE rationale LIKE '[RETYPED v2.1.60%' OR rationale LIKE '[REVERSED v2.1.60%' OR rationale LIKE '[CONFIDENCE v2.1.60%';

\echo '--- removed edge 1513 (expect 0 rows) + Gehenna relabel (expect Israelite/Second Temple) ---'
SELECT count(*) AS eshmun_reversed_remaining FROM entity_relationships WHERE relationship_id=1513;
SELECT entity_id, tradition FROM entities WHERE entity_id='ENT_JM_GEHENNA';

\echo '--- spot-check reversed rows ---'
SELECT relationship_id, subject_entity_id, relationship_type, object_entity_id, confidence, review_status
FROM entity_relationships WHERE relationship_id IN (3493,6562,7359,7361,7362,1480,1481,8026,1468,1469,2396,2397)
ORDER BY relationship_id;

\echo '--- integrity: no orphan endpoints, no unknown types (expect 0/0) ---'
SELECT count(*) AS bad_endpoints FROM entity_relationships r
WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id)
   OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id);
SELECT count(*) AS bad_types FROM entity_relationships r
WHERE NOT EXISTS (SELECT 1 FROM relationship_types t WHERE t.relationship_type=r.relationship_type);
