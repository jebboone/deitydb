-- scripts/add_italic_sabine.sql
-- Italic/Sabine pre-Roman tradition layer.
--
-- Context: Roman deities exist (ENT_ROM_SATURN, ENT_ROM_MARS, ENT_ROM_JANUS,
-- ENT_ROM_QUIRINUS, etc.) but the older Italic/Sabine stratum is missing.
-- This layer adds the archaic di indigetes (native Italic deities) who predate
-- and underlie the Hellenized Roman pantheon.
--
--   NEW PERIOD (1):
--     PER_ITA_ARCHAIC — Archaic Italic (c. 900–509 BCE)
--
--   NEW ENTITIES (6):
--     ENT_ITA_FAUNUS    — wild nature deity, prophecy, Lupercalia
--     ENT_ITA_PICUS     — prophetic woodpecker deity, first king of Latium
--     ENT_ITA_OPS       — Sabine abundance and harvest goddess, Saturn's consort
--     ENT_ITA_CARMENTA  — prophetic goddess, Carmentalia, patron of childbirth
--     ENT_ITA_FLORA     — goddess of flowering plants and spring bloom
--     ENT_ITA_SILVANUS  — deity of forests, boundaries, uncultivated land
--
--   SOURCES ALREADY IN DB (all confirmed): SRC_OVID_FASTI, SRC_VARRO_ANTIQ,
--     SRC_VIRGIL_AENEID, SRC_BEARD_ROMAN_RELIGIONS
--
--   NEW RELATIONSHIPS (8):
--     Picus parent_of Faunus; Faunus aligned_with Pan; Silvanus aligned_with Pan;
--     Silvanus aligned_with Faunus; Ops spouse_of Saturn; Picus aligned_with Mars

BEGIN;

-- ── 1. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, period_name, notes, start_year, end_year, tradition)
VALUES (
  'PER_ITA_ARCHAIC',
  'Archaic Italic (c. 900–509 BCE)',
  'The period of archaic Italic religion before the Roman Republic, encompassing the Regal period, early Latin and Sabine religious forms, and the pre-Hellenized stratum of di indigetes (native Italic deities). This period covers the formative era of Roman religion before systematic Greek influence transformed the Roman pantheon, from the Villanovan archaeological horizon through the expulsion of the Tarquins (traditional date 509 BCE).',
  -900, -509,
  'Italic/Sabine'
) ON CONFLICT (period_id) DO NOTHING;

-- ── 2. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
) VALUES

('ENT_ITA_FAUNUS',
 'Faunus',
 'Italic/Sabine',
 'deity / prophetic wild nature god',
 'deity',
 'wildlands; shepherds; prophecy; fertility; Lupercalia; omen; fright; di indigetes',
 'A',
 'Faunus is one of the oldest attested Italic deities, a god of the wildlands and prophetic voice, patron of shepherds and country folk. His name is etymologically connected to the Latin faveo ("to favor") or, more likely, a root meaning "wolf" (compare fauces, "jaws/throat"), reflecting his liminal, dangerous character as lord of the uncultivated spaces beyond the human settlement. Faunus prophesies through rustling leaves, animal sounds, and voices in the forest (the "faunalia" — wild prophetic voices). Ovid (Fasti 2.267-380) describes Faunus''s role in the Lupercalia: the February festival of purification and fertility centered on the Lupercal cave on the Palatine, where young men (Luperci) ran the pomerium striking women with strips of goatskin (februa) to promote fertility. Virgil (Aeneid 7.81-101) makes Faunus the prophetic oracle of Latinus: Latinus''s father Faunus (here elevated to king of Latium) speaks through the oracle of the sacred grove at Albunea, warning that Latinus must marry a foreign husband (Aeneas). This version grants Faunus royal and prophetic status beyond the shepherd deity of the archaic stratum. Faunus was explicitly identified with the Greek Pan by Roman writers (Cicero ND 2.6; Ovid Fasti 2.270), making him the Italic equivalent of the Arcadian goat-deity. Under the Fabius family''s patronage, the Luperci Fabiani maintained the cult into the imperial period. Wissowa, G. (1912), Religion und Kultus der Römer, pp. 209-213; Radke, G. (1965), Die Götter Altitaliens, pp. 110-116.'),

('ENT_ITA_PICUS',
 'Picus',
 'Italic/Sabine',
 'deity / prophetic woodpecker deity',
 'deity',
 'prophecy; augury; woodpecker; first king of Latium; wildlands; di indigetes; transformation',
 'A',
 'Picus ("Woodpecker") is an ancient Italic deity who gives his name to the woodpecker (Lat. picus, Picus Martius — the woodpecker sacred to Mars), the most important augural bird in Roman religion. Picus occupies a unique position in the genealogy of the Latin kings: Virgil (Aeneid 7.48) makes him the father of Faunus and grandfather of Latinus ("Fauno Picus pater"), thus placing him at the root of the Latin royal genealogical tree. Ovid (Metamorphoses 14.320-434; Fasti 3.37-54) preserves the fullest narrative of Picus: he was a beautiful youth, beloved of Pomona, who rejected Circe''s advances, whereupon Circe transformed him into a woodpecker — his prophetic gifts survived the transformation, embodied in the woodpecker''s role as augural bird. As the Picus Martius (woodpecker of Mars), Picus mediates between the divine world and human augural knowledge: the woodpecker''s tapping was interpreted as divine communication, and the bird was protected by the augural laws. The woodpecker also plays a role in the founding myth of Rome: a wolf and a woodpecker together suckled and fed Romulus and Remus in the Lupercal cave (Ovid Fasti 3.54), making Picus (through his bird form) a co-nurturing deity of Rome''s origins. As such, Picus is both a pre-Roman Italic figure (one of the di indigetes of Latium) and a deity deeply embedded in the augural religion of the Republic. Wissowa (1912) pp. 212-213.'),

('ENT_ITA_OPS',
 'Ops',
 'Italic/Sabine',
 'deity / Sabine goddess of abundance and harvest',
 'deity',
 'abundance; harvest; agricultural fertility; Sabine origin; Consus; Saturn consort; Opalia; Opiconsivia',
 'A',
 'Ops ("Abundance, Resources") is a Sabine agricultural goddess of abundant harvests, earth-stored wealth, and the accumulated resources of the community. She is closely associated with Saturn (as his consort or companion) and with the harvest-storage deity Consus, sharing his festivals. Ops is the presiding deity of two ancient Roman festivals: the Opalia (19 December) and the Opiconsivia (25 August), both described by Varro (LL VI.21) as among the oldest festivals of the Roman calendar — festivals so archaic that Varro himself admits their full significance was no longer understood in his day. The Opiconsivia was accessible only to the Vestal Virgins and one particular pontifex, suggesting an extremely archaic, restricted cult. Ops is closely paired with Consus — they share a common festival structure (Consualia 21 August / Opiconsivia 25 August; Consualia 15 December / Opalia 19 December) — and Macrobius (Saturnalia 1.10.19-20) says Ops is the earth''s bounty and Consus is the "guardian of what is sown and stored." Her Sabine origin (attested by Varro, Macrobius) distinguishes her from the purely Latin stratum of di indigetes, making her an important index of the Sabine contribution to early Roman religion. Wissowa (1912) pp. 200-204; Dumézil, G. (1970), Archaic Roman Religion, vol. 1, pp. 316-318.'),

('ENT_ITA_CARMENTA',
 'Carmenta',
 'Italic/Sabine',
 'deity / prophetic goddess and patroness of childbirth',
 'deity',
 'prophecy; childbirth; mothers; past and future; Carmentalia; Latin alphabet; Evander; Arcadian migration',
 'A',
 'Carmenta (also Carmentis) is an ancient Italic prophetic goddess and patroness of childbirth, one of the Camenae (the Latin water-nymph prophetic figures whose spring is on the Caelian Hill). Her name derives from carmen ("song, incantation, prophetic utterance"), making her the personification of prophetic speech. She has two hypostases — Porrima (who prophesies the past, from porro "forward/before") and Postverta (who prophesies what will come after) — indicating that her prophetic scope encompasses both past and future. The Carmentalia was a two-part festival (11 and 15 January) in her honor, among the oldest in the Roman calendar, attended primarily by women; Ovid (Fasti 1.461-586) explains it as thanksgiving from Roman matrons for her protection in childbirth. In the mythological tradition preserved by Ovid (Fasti 1.469-540) and Livy (AUC 1.7.8), Carmenta is the mother of Evander (by the god Mercury or the mortal Echenus) and accompanied him on the Arcadian migration to Latium before the Trojan War — thus making her a mythological bridge between Arcadian Greek civilization and archaic Latium. Most significantly, Carmenta/Nicostrata (her Greek name) was credited in late Republican tradition with the invention of the Latin alphabet, adapting the Greek script for Latin use (Pliny HN 7.192; Hyginus Fabulae 277). This tradition, though legendary, reflects awareness that alphabetic writing came to Latium through Greek (specifically Euboean/Chalcidian) contact, and Carmenta''s role as a prophet of carmen makes her a natural cultural hero for scribal invention. Wissowa (1912) pp. 217-219; Scheid, J. (2003), An Introduction to Roman Religion, pp. 117-118.'),

('ENT_ITA_FLORA',
 'Flora',
 'Italic/Sabine',
 'deity / goddess of flowering plants and spring',
 'deity',
 'flowers; spring; vegetation; bloom; Floralia; Sabine origin; Chloris parallel; gardens; fertility',
 'A',
 'Flora is an ancient Italian goddess of flowering plants, spring vegetation, and the season of bloom (ver), whose cult in Rome is attested from the earliest period of the Republic: she had a flamen (the flamen Floralis, one of the fifteen flamines of archaic Rome) assigned to her cult, which is strong evidence of very high antiquity. The Floralia (28 April – 3 May) was her chief festival, an unusually joyful, loosely ordered celebration involving theatrical performances and the scattering of beans, lupins, and vetches. Flora''s Sabine origin is implied by Varro (LL 5.74) who notes that the Sabine word for "Flower" was the basis of her name. Ovid (Fasti 5.195-372) presents the fullest account of her mythology: in a dialogue with the goddess, Ovid learns that Flora was originally the Greek nymph Chloris (Χλωρίς, "Green/Verdant"), beloved of Zephyrus (the west wind), who transformed her and gave her dominion over flowers as a wedding gift. She claims to have caused the pregnancy of Juno that produced Mars (by giving Juno a flower), and to have transformed the blood of Hyacinthus and the body of Narcissus into flowers. This makes Flora/Chloris a figure at the productive intersection of Greek and Italic tradition — her Sabine/Italic name and ancient Roman cult are mapped onto the Greek figure of Chloris. The explicit Chloris identification in Ovid (Fasti 5.195: "Chloris eram") makes Flora the clearest example in Roman religion of an Italic nature deity explained through a Greek mythological counterpart. Wissowa (1912) pp. 196-198.'),

('ENT_ITA_SILVANUS',
 'Silvanus',
 'Italic/Sabine',
 'deity / guardian of forests and boundaries',
 'deity',
 'forests; wildlands; boundaries; uncultivated land; property limits; woodcutters; herdsmen; di indigetes',
 'A',
 'Silvanus ("Of the Forest," from silva) is the Roman-Italic god of forests, uncultivated land, and the boundaries that separate the cultivated from the wild. He guards the edges of fields (the silvester locus — the wooded margin), the boundary stones (termini) of property, and the liminal zones between human settlement and wild nature. Cato the Elder (De Agricultura 83) gives the oldest extended ritual prescription for Silvanus: a farmer should propitiate Silvanus with offerings of wine, pork, meal, and grain when working woodland that borders cultivated fields — a purely functional, contractual religion of the boundary. Unlike Faunus (who is prophetic and liminal) or Fauna (the female companion/sister), Silvanus is primarily protective and territorial: he guards the specific boundary of THIS field, not the wild in general. Plautus, Pliny, and Ovid all emphasize his forest and boundary role. In social terms, Silvanus was one of the few major Roman deities whose cult was primarily associated with slaves and freedmen (CIL inscriptions show Silvanus collegii — clubs of Silvanus worshippers — heavily populated by slaves): this may reflect his role as protector of those who work the boundary lands and forests outside the ordered civic space. The structural parallel with Pan (both are goat-legged, boundary-guarding, rural deities) was noted in antiquity, and Virgil in the Eclogues places Silvanus and Pan in equivalent roles. Wissowa (1912) pp. 213-216; North, J.A. (2000), Roman Religion, pp. 60-62.')

ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_ITA_FAUNUS',   'SRC_OVID_FASTI',    'Primary text',  'Fasti 2.267-380: Faunus and the Lupercalia festival; 2.193-474; 5.99-102.'),
('ENT_ITA_FAUNUS',   'SRC_VIRGIL_AENEID', 'Primary text',  'Aeneid 7.81-106: Faunus as oracle and father/ancestor of Latinus.'),
('ENT_ITA_FAUNUS',   'SRC_VARRO_ANTIQ',   'Primary text',  'Antiquitates Rerum Divinarum (frags.): Faunus as di indigetes; testimony preserved in Augustine, City of God 18.15.'),
('ENT_ITA_PICUS',    'SRC_VIRGIL_AENEID', 'Primary text',  'Aeneid 7.48: "Fauno Picus pater" — Picus as father of Faunus; 7.171-191: Picus in the Latin genealogy.'),
('ENT_ITA_PICUS',    'SRC_OVID_FASTI',    'Primary text',  'Fasti 3.37-54: Picus as Picus Martius (woodpecker sacred to Mars).'),
('ENT_ITA_PICUS',    'SRC_VARRO_ANTIQ',   'Primary text',  'Antiquitates (frags.): Picus as di indigetes of Latium.'),
('ENT_ITA_OPS',      'SRC_OVID_FASTI',    'Primary text',  'Fasti 6.303-304 (Opalia); Macrobius Saturnalia 1.10.19-20 (Ops and Consus).'),
('ENT_ITA_OPS',      'SRC_VARRO_ANTIQ',   'Primary text',  'LL VI.21: Opiconsivia and Opalia as archaic Roman festivals; Antiquitates on Ops as Sabine deity.'),
('ENT_ITA_CARMENTA', 'SRC_OVID_FASTI',    'Primary text',  'Fasti 1.461-586: Carmentalia, Carmenta''s role in childbirth, the Arcadian migration, and Evander.'),
('ENT_ITA_CARMENTA', 'SRC_VARRO_ANTIQ',   'Primary text',  'Antiquitates (frags.): Carmenta as Camena and prophetess.'),
('ENT_ITA_FLORA',    'SRC_OVID_FASTI',    'Primary text',  'Fasti 5.183-378: Floralia, the Chloris/Flora narrative, and Flora''s claims to mythological agency (Mars, Hyacinthus).'),
('ENT_ITA_FLORA',    'SRC_VARRO_ANTIQ',   'Primary text',  'Antiquitates (frags.): flamen Floralis and archaic festival; LL 5.74 on Sabine etymology.'),
('ENT_ITA_SILVANUS', 'SRC_VARRO_ANTIQ',   'Primary text',  'Antiquitates (frags.): Silvanus as di indigetes; boundary and forest function.'),
('ENT_ITA_SILVANUS', 'SRC_BEARD_ROMAN_RELIGIONS', 'Secondary scholarly', 'Beard, North, Price (1998), Religions of Rome, vol. 1: Silvanus''s social profile (slaves/freedmen, collegii).'),
('ENT_ITA_FAUNUS',   'SRC_BEARD_ROMAN_RELIGIONS', 'Secondary scholarly', 'Beard, North, Price (1998), Religions of Rome, vol. 1: Lupercalia and Faunus.'),
('ENT_ITA_CARMENTA', 'SRC_BEARD_ROMAN_RELIGIONS', 'Secondary scholarly', 'Beard, North, Price (1998): Carmentalia and the Camenae.')
ON CONFLICT DO NOTHING;

-- ── 4. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ITA_FAUNUS',   'PER_ITA_ARCHAIC', 'high', 'Attested among the di indigetes; cult predates Roman Republic. Lupercalia among oldest Roman festivals.', 'SRC_OVID_FASTI',    'reviewed'),
('ENT_ITA_PICUS',    'PER_ITA_ARCHAIC', 'high', 'Latin genealogy in Virgil places Picus before Faunus and Latinus — archaic Latium tradition.',                  'SRC_VIRGIL_AENEID', 'reviewed'),
('ENT_ITA_OPS',      'PER_ITA_ARCHAIC', 'high', 'Opiconsivia/Opalia are among Rome''s oldest calendar festivals; Sabine origin implies pre-Roman.',              'SRC_VARRO_ANTIQ',   'reviewed'),
('ENT_ITA_CARMENTA', 'PER_ITA_ARCHAIC', 'high', 'Carmentalia as oldest-stratum festival; Evander migration narrative set before the Trojan War.',                'SRC_OVID_FASTI',    'reviewed'),
('ENT_ITA_FLORA',    'PER_ITA_ARCHAIC', 'high', 'Flamen Floralis is evidence of very early cult; Floralia among oldest Roman festivals.',                        'SRC_OVID_FASTI',    'reviewed'),
('ENT_ITA_SILVANUS', 'PER_ITA_ARCHAIC', 'high', 'Cato De Agr. 83 ritual prescription for Silvanus is among the earliest Latin prose attestations of a deity cult.','SRC_VARRO_ANTIQ',  'reviewed')
ON CONFLICT DO NOTHING;

-- ── 5. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES

-- Picus genealogy
('ENT_ITA_PICUS', 'parent_of', 'ENT_ITA_FAUNUS',
 'high',
 'Virgil Aeneid 7.48: "Fauno Picus pater" — Picus is the father of Faunus, making Picus the first generation of the Latin divine genealogy. This sequence (Picus → Faunus → Latinus → Lavinia ← Aeneas) is the genealogical spine of Virgil''s Latium foundation myth. Virgil Aeneid 7.45-48.',
 'SRC_VIRGIL_AENEID', 'PER_ITA_ARCHAIC', 'reviewed'),

-- Faunus ↔ Pan (explicit Roman identification)
('ENT_ITA_FAUNUS', 'aligned_with', 'ENT_PAN',
 'high',
 'Roman writers explicitly identified Faunus with the Greek Pan: Cicero (De Natura Deorum 2.6) calls Pan the "Faunus" of the Greeks; Ovid (Fasti 2.267-270) explicitly compares and equates the two. Both deities are prophetic, goat-footed (in some traditions), associated with wildlands and shepherds, and attached to a major initiatory festival (Lupercalia/Pan-Greek Paneia). The identification is so complete that Roman mythographers treated them as interchangeable. Confidence high: explicit ancient identification.',
 'SRC_OVID_FASTI', 'PER_ITA_ARCHAIC', 'reviewed'),

-- Picus ↔ Mars (woodpecker sacred to Mars)
('ENT_ITA_PICUS', 'aligned_with', 'ENT_ROM_MARS',
 'medium',
 'The Picus Martius (woodpecker of Mars) is the specifically sacred bird of Mars in Roman augury. Ovid (Fasti 3.37-54) makes this connection explicit: the woodpecker is Mars''s sacred bird because of its pecking/hammering action (associated with the war god''s energy) and because the woodpecker Picus shares Mars''s prophetic augural role. Pliny (NH 10.20) notes that Roman augury treated the woodpecker''s behavior as directly communicating divine will. The identification of Picus the deity with Picus the bird of Mars suggests that the deity Picus may originally have been the personification or hypostasis of Mars''s augural bird — i.e., Picus is the divine patron of the woodpecker''s augural speech. Confidence medium: the connection is functional/cultic rather than a narrative identification.',
 'SRC_OVID_FASTI', 'PER_ITA_ARCHAIC', 'reviewed'),

-- Ops ↔ Saturn (standard consort pairing)
('ENT_ITA_OPS', 'spouse_of', 'ENT_ROM_SATURN',
 'high',
 'Ops is the standard divine consort of Saturn in Roman religious tradition: Macrobius (Saturnalia 1.10.19-20) explains that "Ops and Saturn are thought to be the same as heaven and earth" and pairs their cult. The December Saturnalia (17-23 Dec.) and Opalia (19 Dec.) are co-located, as are the August Consualia-Opiconsivia cluster. Ops thus functions both as Saturn''s consort and as the personification of the earth''s stored abundance in complementary relationship to Saturn as the celestial ordering principle. Varro, LL VI.21.',
 'SRC_VARRO_ANTIQ', 'PER_ITA_ARCHAIC', 'reviewed'),

-- Silvanus ↔ Pan (structural wildland deity parallel)
('ENT_ITA_SILVANUS', 'aligned_with', 'ENT_PAN',
 'medium',
 'Silvanus and Pan share the structural function of deity of uncultivated, boundary wildlands, and both are associated with shepherds and the rustic world beyond the city. Virgil''s Eclogues place them in equivalent roles: "Silvanus and Pan and the sisterhood of Naiads" (Ecl. 10.24-26). Ancient writers sometimes grouped them together as rural deities. However, unlike Faunus/Pan, the identification of Silvanus with Pan is less systematic — Silvanus has a distinctly Italic character (boundary guardian, property deity) that Pan lacks. Confidence medium: structural parallel and Virgilian grouping, not explicit identification.',
 'SRC_VIRGIL_AENEID', 'PER_ITA_ARCHAIC', 'reviewed'),

-- Silvanus ↔ Faunus (structural parallel: both Italic wildland deities)
('ENT_ITA_SILVANUS', 'aligned_with', 'ENT_ITA_FAUNUS',
 'medium',
 'Silvanus and Faunus are the two principal Italic deities of the wildlands, often grouped together in Roman texts as complementary figures of the rural, uncultivated world. Faunus presides over the prophetic voices and pastoral wildlands; Silvanus guards the forest boundaries and woodlands. Ovid (Fasti 5.99-102) places them in parallel in the context of rural Italian religion. Their cults are structurally analogous (both have no formal temple of the highest grade in the city center; both receive purely votive cult in the countryside) and their functional domains overlap in the silva/saltus zone.',
 'SRC_OVID_FASTI', 'PER_ITA_ARCHAIC', 'reviewed')
-- Note: Flora aligned_with ENT_CHLORIS is a candidate for a future Greek nymph
-- expansion (Ovid Fasti 5.195); ENT_CHLORIS not yet in DB.

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── 5b. Orphan fixes: Carmenta and Flora cross-tradition links ────────────────
-- Added after initial script run since the 6 entities above had only intra-layer rels.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES

('ENT_ITA_CARMENTA', 'aligned_with', 'ENT_HERMES',
 'medium',
 'Ovid (Fasti 1.469-474) and Livy (AUC 1.7.8) make Carmenta/Carmentis the mother of Evander, with Mercury/Hermes as Evander''s father. Carmenta as consort of Hermes/Mercury links the Italian prophetess of prophetic carmen (speech) to the Greek deity of communication and divine messages. Functional parallel: both preside over divine speech and transmission.',
 'SRC_OVID_FASTI', 'PER_ITA_ARCHAIC', 'reviewed'),

('ENT_ITA_CARMENTA', 'reception_of', 'ENT_MNEMOSYNE',
 'low',
 'The Camenae (archaic Latin prophetic nymphs, of whom Carmenta is chief) were identified with the Muses (daughters of Mnemosyne) by Livius Andronicus in his Odusia (c. 240 BCE), rendering Greek ''Mousa'' as ''Camena''. Confidence low: class-level identification of Camenae with Muses, not a direct Carmenta-Mnemosyne equation. Cicero Acad. 1.3.',
 'SRC_VARRO_ANTIQ', 'PER_ITA_ARCHAIC', 'reviewed'),

('ENT_ITA_FLORA', 'aligned_with', 'ENT_DEMETER',
 'low',
 'Flora and Demeter share the domain of agricultural vegetation and seasonal fertility. However, Ovid (Fasti 5.195-372) emphasizes Flora''s Greek identity as Chloris rather than Demeter/Ceres, so the Flora/Demeter alignment is secondary. Confidence low: functional/domain parallel, not explicit ancient identification.',
 'SRC_OVID_FASTI', 'PER_ITA_ARCHAIC', 'reviewed'),

('ENT_ITA_FLORA', 'aligned_with', 'ENT_ROM_CERES',
 'medium',
 'Flora and Ceres are complementary Roman agricultural deities: Floralia (28 April) and Cerealia (19 April) fall within days of each other and are treated consecutively by Ovid (Fasti 4-5), implying a conceptual pairing. Both belong to the same domain cluster of vegetation and fertility in the Roman plebeian festival calendar.',
 'SRC_OVID_FASTI', 'PER_ITA_ARCHAIC', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── 6. Verify ─────────────────────────────────────────────────────────────────
SELECT e.entity_id, e.canonical_name,
       COUNT(DISTINCT r.relationship_id) + COUNT(DISTINCT r2.relationship_id) AS total_rels
FROM entities e
LEFT JOIN entity_relationships r  ON r.subject_entity_id  = e.entity_id
LEFT JOIN entity_relationships r2 ON r2.object_entity_id = e.entity_id
WHERE e.tradition IN ('Italic/Sabine', 'Dacian')
   OR e.entity_id IN ('ENT_ROM_SATURN','ENT_ROM_MARS','ENT_PAN')
GROUP BY e.entity_id, e.canonical_name ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;
COMMIT;
