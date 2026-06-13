-- scripts/add_etruscan_layer.sql
-- Adds the Etruscan tradition layer: sources, periods, 12 entities,
-- entity_sources, entity_periods, and key relationships.
-- Primary sources: Pyrgi gold tablets (c. -500) and Piacenza liver (c. -100).
-- Secondary: de Grummond (2006), Pallottino (1975).
-- All entity IDs follow ENT_ETR_ prefix convention.

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_PYRGI_TABLETS',
 'Pyrgi Gold Tablets (c. 500 BCE)',
 'primary epigraphic',
 'Three gold lamellae found at Pyrgi (port of Caere/Cerveteri), c. 500 BCE. Two in Etruscan, one in Phoenician. The Phoenician text equates Etruscan Uni with Phoenician Astarte. Primary evidence for Etruscan-Phoenician religious contact and Uni''s supreme status.'),
('SRC_PIACENZA_LIVER',
 'Piacenza Liver (c. 100 BCE)',
 'primary artifact',
 'Bronze model of a sheep''s liver found near Piacenza, c. 100 BCE. Surface divided into regions inscribed with Etruscan deity names used in haruspicy. Primary evidence for the Etruscan divine council. Key deities inscribed: Tinia, Uni, Menrva, Nethuns, Fufluns, Usil, Thesan, Turan, Lasa, Voltumna.'),
('SRC_DEGRUMMOND_ETRUSCAN',
 'De Grummond, Nancy Thomson. Etruscan Myth, Sacred History, and Legend (University of Pennsylvania Museum, 2006)',
 'secondary scholarly',
 'Comprehensive treatment of Etruscan deity iconography, myth, and religious narratives drawn from mirrors, sarcophagi, and painted tombs. Standard English-language secondary source for Etruscan religion.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Periods ────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_ETR_ARCHAIC',
 'Etruscan',
 'Archaic Etruscan',
 -700, -480,
 'Formative and Archaic Etruscan culture; Orientalizing phase through early contact with Greek and Phoenician traders; major urban centers established. Pyrgi tablets (c. -500) fall in this period.'),
('PER_ETR_CLASSICAL',
 'Etruscan',
 'Classical Etruscan',
 -480, -300,
 'Height of Etruscan political power and artistic production; the twelve-city Etruscan League with its pan-Etruscan sanctuary at the Fanum Voltumnae; rich tomb painting traditions at Tarquinia and Vulci.'),
('PER_ETR_LATE',
 'Etruscan',
 'Late Etruscan',
 -300, -89,
 'Gradual Roman absorption of Etruscan cities; Piacenza liver falls in this period; Etruscan haruspicy persists into the Roman period as a formal discipline. Enfranchisement of Etruscans under Roman law 89 BCE marks the cultural endpoint.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, short_note)
VALUES
('ENT_ETR_TINIA','Tinia','god','Etruscan',
 'Supreme deity of the Etruscan pantheon; god of sky, lightning, and thunderbolts. Presides over the council of twelve (Dii Consentes Etrusci). Commands three types of lightning bolt. Attested on the Piacenza liver and numerous votive inscriptions. Cognate with Roman Jupiter and Greek Zeus.'),
('ENT_ETR_UNI','Uni','goddess','Etruscan',
 'Queen of the Etruscan gods; supreme goddess. Equated with Phoenician Astarte in the Pyrgi gold tablets (c. 500 BCE) and with Roman Juno / Greek Hera. Major cult sites: Pyrgi, Veii, Perugia. Her cult statue at Veii was taken to Rome at the city''s conquest (396 BCE).'),
('ENT_ETR_MENRVA','Menrva','goddess','Etruscan',
 'Goddess of wisdom, craft, and warfare; member of the Etruscan Capitoline triad (Tinia-Uni-Menrva), the model for Rome''s Jupiter-Juno-Minerva. Attested on the Piacenza liver; frequently depicted in full armor on bronze mirrors. Her name is borrowed into Latin as Minerva.'),
('ENT_ETR_CHARUN','Charun','daimon','Etruscan',
 'Underworld daemon and active escort of the dead; appears in Tarquinian tomb paintings (Tomba degli Auguri; Tomba dell''Orco) wielding a hammer with serpents. Distinct from Greek Charon (ferryman only): Charun coerces souls into the underworld. Depicted with blue-green skin and animal features in later tradition.'),
('ENT_ETR_TUCHULCHA','Tuchulcha','daimon','Etruscan',
 'Underworld daimon with vulture beak, donkey ears, and serpents; attested in the Tomba dell''Orco at Tarquinia (4th c. BCE) alongside Charun. Uniquely Etruscan with no Greek counterpart. A terror figure whose presence in tomb frescoes reflects the Etruscan conception of death as a violent, coerced journey.'),
('ENT_ETR_VOLTUMNA','Voltumna','god','Etruscan',
 'Chief deity of the Etruscan League; the Fanum Voltumnae near Volsinii/Orvieto was the pan-Etruscan federal sanctuary. Named by Livy (4.23; 5.17) as patron of the league''s annual assembly. His name is the source of Roman Vertumnus. The Fanum was destroyed after Rome conquered Volsinii in 264 BCE.'),
('ENT_ETR_LASA','Lasa','spirit','Etruscan',
 'Winged female spirits; attendants and personifications of fate and beauty associated with Turan. Frequently depicted on Etruscan bronze mirrors (4th–3rd c. BCE), sometimes named individually (Lasa Vecuvia, Lasa Sitmica, Lasa Thimrae). Serve both funerary and erotic functions.'),
('ENT_ETR_THESAN','Thesan','goddess','Etruscan',
 'Dawn goddess; Etruscan equivalent of Greek Eos / Roman Aurora. Depicted on mirrors abducting youths. Attested on the Piacenza liver. Name of Etruscan formation with no clear Indo-European etymology.'),
('ENT_ETR_TURAN','Turan','goddess','Etruscan',
 'Goddess of love and beauty; Etruscan equivalent of Aphrodite/Venus. Frequently depicted on bronze mirrors with her Lasa retinue. Attested on the Piacenza liver. Name possibly from Etruscan *tur- (to give). Major cult centers at Caere and Vulci.'),
('ENT_ETR_NETHUNS','Nethuns','god','Etruscan',
 'God of wells, springs, and sea; Etruscan equivalent of Poseidon/Neptune. The Latin Neptune is widely held to be borrowed from Etruscan Nethuns. Attested on the Piacenza liver.'),
('ENT_ETR_FUFLUNS','Fufluns','god','Etruscan',
 'God of wine, vegetation, and vitality; Etruscan equivalent of Dionysus/Bacchus. Attested on the Piacenza liver and Etruscan mirrors. His myths track Greek Dionysiac tradition closely, attesting direct reception by the 6th c. BCE.'),
('ENT_ETR_USIL','Usil','god','Etruscan',
 'Sun deity; Etruscan equivalent of Helios/Sol. Attested on the Piacenza liver and mirrors (depicted with solar rays and in chariot procession). Distinguished from Thesan (dawn) in the Etruscan cosmological scheme.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
-- Piacenza liver attestations
('ENT_ETR_TINIA','SRC_PIACENZA_LIVER','Direct attestation','Named in Tinia region of liver; innermost position reflecting supreme status'),
('ENT_ETR_UNI','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver; attests her position in the divine council'),
('ENT_ETR_MENRVA','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver; confirms triad membership with Tinia and Uni'),
('ENT_ETR_NETHUNS','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver; primary evidence for his divine council position'),
('ENT_ETR_FUFLUNS','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver'),
('ENT_ETR_USIL','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver; solar deity in the divine scheme'),
('ENT_ETR_THESAN','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver; dawn goddess in council scheme'),
('ENT_ETR_TURAN','SRC_PIACENZA_LIVER','Direct attestation','Named on Piacenza liver'),
('ENT_ETR_VOLTUMNA','SRC_PIACENZA_LIVER','Probable attestation','Some scholars identify Veltune/Veltune inscriptions on the liver with Voltumna'),
-- Pyrgi tablets
('ENT_ETR_UNI','SRC_PYRGI_TABLETS','Direct attestation','Named in Etruscan text of Pyrgi tablets; equated with Phoenician Astarte in the Phoenician text; c. 500 BCE'),
-- De Grummond secondary
('ENT_ETR_TINIA','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 3 on Tinia and the thunderbolt typology'),
('ENT_ETR_UNI','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 4 on Uni/Juno and the Pyrgi tablets'),
('ENT_ETR_MENRVA','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 5 on Menrva/Minerva and the Capitoline triad'),
('ENT_ETR_CHARUN','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 10 on underworld figures; Charun in Tarquinian tomb paintings'),
('ENT_ETR_TUCHULCHA','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 10; Tuchulcha attested in Tomba dell''Orco, Tarquinia'),
('ENT_ETR_VOLTUMNA','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 1 on the Etruscan League and Fanum Voltumnae; also Livy 4.23'),
('ENT_ETR_LASA','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 8 on the Lasa spirits on Etruscan mirrors'),
('ENT_ETR_THESAN','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) on Thesan in mirror iconography'),
('ENT_ETR_TURAN','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 7 on Turan/Aphrodite and the Lasa retinue'),
('ENT_ETR_NETHUNS','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) on Nethuns; connection to Latin Neptune'),
('ENT_ETR_FUFLUNS','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) ch. 6 on Fufluns/Dionysus and Greek reception'),
('ENT_ETR_USIL','SRC_DEGRUMMOND_ETRUSCAN','Secondary analysis','De Grummond (2006) on Usil in mirror iconography and the solar tradition')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
-- Archaic (Pyrgi tablets c. -500; all major deities attested by this point)
('ENT_ETR_TINIA','PER_ETR_ARCHAIC','high','Supreme deity attested from earliest Etruscan sacred art; thunderbolt iconography Archaic period','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_UNI','PER_ETR_ARCHAIC','high','Named in Pyrgi gold tablets (c. -500); major temple at Pyrgi Archaic period','SRC_PYRGI_TABLETS','reviewed'),
('ENT_ETR_MENRVA','PER_ETR_ARCHAIC','high','Menrva attested in Archaic period votive dedications; Capitoline triad Archaic formation','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_THESAN','PER_ETR_ARCHAIC','high','Dawn abduction scenes attested on Archaic Etruscan mirrors','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TURAN','PER_ETR_ARCHAIC','high','Turan attested in Archaic mirror engravings and votive deposits','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_FUFLUNS','PER_ETR_ARCHAIC','high','Dionysiac reception in Etruria documented from 6th c. BCE (Archaic)','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_USIL','PER_ETR_ARCHAIC','high','Solar deity in Archaic Etruscan cosmology; chariot procession imagery Archaic','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_NETHUNS','PER_ETR_ARCHAIC','high','Neptune/Nethuns borrowing into Latin attests an Archaic Etruscan water deity','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_CHARUN','PER_ETR_ARCHAIC','high','Earliest Charun depictions in Archaic tomb paintings (Tomba degli Auguri, Tarquinia c. -530)','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_LASA','PER_ETR_ARCHAIC','medium','Lasa spirits attested primarily Classical/late period; Archaic basis probable','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_VOLTUMNA','PER_ETR_ARCHAIC','medium','Fanum Voltumnae existed from early Etruscan League formation; Archaic origin probable','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TUCHULCHA','PER_ETR_ARCHAIC','low','Tuchulcha first clearly attested in 4th c. BCE Tomba dell''Orco; Archaic antecedent assumed','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
-- Classical (primary attestations of the Piacenza liver-type deities)
('ENT_ETR_TINIA','PER_ETR_CLASSICAL','high','Tinia dominates Classical Etruscan sacred imagery and votive practice','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_UNI','PER_ETR_CLASSICAL','high','Uni as supreme goddess most fully elaborated in Classical period (Veii cult statue)','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_MENRVA','PER_ETR_CLASSICAL','high','Menrva on Classical bronze mirrors and votive bronzes','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_CHARUN','PER_ETR_CLASSICAL','high','Charun at height of tomb painting tradition, Tarquinia; Tomba dell''Orco (4th c. BCE)','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TUCHULCHA','PER_ETR_CLASSICAL','high','Primary attestation: Tomba dell''Orco, Tarquinia, 4th c. BCE','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_VOLTUMNA','PER_ETR_CLASSICAL','high','Fanum Voltumnae at height Classical Etruscan League meetings (Livy 4.23; 5.17)','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_LASA','PER_ETR_CLASSICAL','high','Lasa spirits peak attestation on Classical bronze mirrors (4th–3rd c. BCE)','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TURAN','PER_ETR_CLASSICAL','high','Turan in Classical mirror iconography; Lasa retinue developed Classical period','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
-- Late Etruscan (Piacenza liver c. -100)
('ENT_ETR_TINIA','PER_ETR_LATE','high','Named on Piacenza liver (c. -100); persistence into late haruspical tradition','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_UNI','PER_ETR_LATE','high','Named on Piacenza liver; haruspicy tradition persists into Roman period','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_MENRVA','PER_ETR_LATE','high','Named on Piacenza liver','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_NETHUNS','PER_ETR_LATE','high','Named on Piacenza liver (c. -100)','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_FUFLUNS','PER_ETR_LATE','high','Named on Piacenza liver','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_USIL','PER_ETR_LATE','high','Named on Piacenza liver','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_THESAN','PER_ETR_LATE','high','Named on Piacenza liver','SRC_PIACENZA_LIVER','reviewed'),
('ENT_ETR_TURAN','PER_ETR_LATE','high','Named on Piacenza liver','SRC_PIACENZA_LIVER','reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Key Etruscan relationships ─────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Tinia-Uni-Menrva triad (Etruscan Capitoline Triad)
('ENT_ETR_TINIA','spouse_of','ENT_ETR_UNI','high',
 'Tinia and Uni are paired as the supreme couple of the Etruscan pantheon, cognate with Zeus/Hera and Jupiter/Juno; the triad Tinia-Uni-Menrva mirrors the Roman Capitoline Triad, which was an Etruscan import; de Grummond (2006) pp. 51-62','SRC_DEGRUMMOND_ETRUSCAN','PER_ETR_ARCHAIC','reviewed'),

('ENT_ETR_UNI','spouse_of','ENT_ETR_TINIA','high',
 'Uni as consort of Tinia; named in Pyrgi tablets as supreme goddess; de Grummond (2006) pp. 51-62','SRC_PYRGI_TABLETS','PER_ETR_ARCHAIC','reviewed'),

-- Tinia rules the divine council (a member_of relationship isn''t quite right; he presides over it)
('ENT_ETR_TINIA','rules','ENT_ETR_VOLTUMNA','low',
 'Speculative: some scholars identify Voltumna as an aspect or subordinate of Tinia''s cosmological domain; not directly attested; included with low confidence pending further epigraphic evidence','SRC_DEGRUMMOND_ETRUSCAN','PER_ETR_CLASSICAL','reviewed'),

-- Lasa as retinue of Turan
('ENT_ETR_LASA','member_of','ENT_ETR_TURAN','high',
 'Lasa spirits are frequently depicted as attendants of Turan (Etruscan Aphrodite) on bronze mirrors; they serve both erotic and funerary functions in her retinue; de Grummond (2006) pp. 152-167','SRC_DEGRUMMOND_ETRUSCAN','PER_ETR_CLASSICAL','reviewed'),

-- Etruscan → Roman cross-tradition links
('ENT_ROM_JUPITER','syncretized_with','ENT_ETR_TINIA','high',
 'Roman Jupiter was directly identified with Etruscan Tinia; the Capitoline temple (dedicated 509 BCE) housed the Etruscan-derived triad Jupiter-Juno-Minerva; de Grummond (2006) pp. 55-60; Pallottino (1975) p. 141','SRC_DEGRUMMOND_ETRUSCAN','PER_ETR_ARCHAIC','reviewed'),

('ENT_ROM_JUNO','syncretized_with','ENT_ETR_UNI','high',
 'Roman Juno identified with Etruscan Uni; Juno''s name may derive from Uni via Etruscan; the abduction of Uni''s statue from Veii to Rome (396 BCE) demonstrates the identification; Pyrgi tablets link Uni to Astarte; de Grummond (2006) pp. 67-72','SRC_PYRGI_TABLETS','PER_ETR_ARCHAIC','reviewed'),

('ENT_ROM_MINERVA','syncretized_with','ENT_ETR_MENRVA','high',
 'Roman Minerva derives directly from Etruscan Menrva; the name Minerva is a Latin adaptation of Menrva; the Capitoline Triad (Jupiter-Juno-Minerva) was introduced to Rome from Etruria; de Grummond (2006) pp. 79-84','SRC_DEGRUMMOND_ETRUSCAN','PER_ETR_ARCHAIC','reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS etruscan_entities FROM entities WHERE tradition = 'Etruscan';
SELECT COUNT(*) AS etruscan_relationships
FROM entity_relationships er
JOIN entities e ON er.subject_entity_id = e.entity_id
WHERE e.tradition = 'Etruscan';
SELECT * FROM v_release_metrics;

COMMIT;
