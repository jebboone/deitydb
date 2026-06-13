-- scripts/add_roman_primary_sources.sql
-- Adds four Roman primary sources and links them to the 22 Roman entities
-- with passage-level notes. Sources: Virgil Aeneid, Livy Ab Urbe Condita,
-- Cicero De Natura Deorum, Varro Antiquitates Rerum Divinarum.

BEGIN;

-- ── 1. Register primary sources ───────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_VIRGIL_AENEID',
 'Virgil, Aeneid (19 BCE)',
 'primary literary',
 'Latin epic poem in 12 books composed by Publius Vergilius Maro; foundational text for Roman religious mythology. Attests Roman deity personalities, cult epithets, and divine interventions in the Trojan/Italic founding narrative. Standard edition: R.D. Williams, Virgil: Aeneid (Bristol Classical Press); trans. David West (Penguin).'),
('SRC_LIVY_AUC',
 'Livy, Ab Urbe Condita (Books 1–10, 21–45; c. 27 BCE – 9 CE)',
 'primary historical',
 'Latin historical narrative by Titus Livius covering Rome from its founding to 9 BCE. Key source for Roman state religion, prodigies, vow-fulfillment, and temple foundation; attests Jupiter Optimus Maximus, Quirinus, Mars, Janus, Vesta, and the role of the Lares and Penates in Roman civic religion. Standard edition: B.O. Foster et al. (Loeb Classical Library).'),
('SRC_CICERO_DE_NATURA',
 'Cicero, De Natura Deorum (45 BCE)',
 'primary philosophical',
 'Philosophical dialogue by Marcus Tullius Cicero presenting Stoic, Epicurean, and Academic views on the nature of the Roman gods. Books I–III. Most systematic ancient Roman treatment of the divine council and theology. Standard edition: A.S. Pease (Cambridge, 1955); trans. P.G. Walsh (Oxford World''s Classics).'),
('SRC_VARRO_ANTIQ',
 'Varro, Antiquitates Rerum Divinarum (c. 47 BCE, surviving via Augustine City of God)',
 'primary scholarly',
 'Marcus Terentius Varro''s systematic taxonomy of Roman religion in 16 books; largely lost but extensively quoted by Augustine (City of God Books VI–VII). Distinguishes mythical, physical, and civic theology; the most comprehensive ancient Roman account of deity functions. Reconstructed via Augustine and other secondary citations.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Virgil Aeneid — passage-level entity_sources ──────────────────────────
-- Juno: most prominent deity in the Aeneid, directly opposing Aeneas
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_ROM_JUNO','SRC_VIRGIL_AENEID','Direct attestation',
 'Juno is the primary divine antagonist of the Aeneid; opposes Aeneas throughout. Key passages: 1.4-7 (her hatred); 1.65-80 (commands Aeolus to raise storm); 7.286-340 (summons Allecto); 12.791-842 (Zeus compels her withdrawal). Aeneid grounds Roman understanding of Juno as implacable queen of heaven.'),
('ENT_ROM_JUPITER','SRC_VIRGIL_AENEID','Direct attestation',
 'Jupiter guarantees Rome''s destiny to Juno (1.257-296: the "fates'' will" speech); sends Mercury to Carthage (4.222-278); adjudicates the final battle (12.791-842). The Aeneid''s Jupiter is the normative image of Jupiter as universal sovereign for the Roman literary tradition.'),
('ENT_ROM_VENUS','SRC_VIRGIL_AENEID','Direct attestation',
 'Venus is Aeneas''s divine mother and protector; appears in Aeneid 1.314-409 (disguised as huntress); 2.589-623 (reveals the gods destroying Troy); 8.370-416 (commissions Vulcan to forge Aeneas''s armor). Central to the Aeneid''s Julii family theology.'),
('ENT_ROM_NEPTUNE','SRC_VIRGIL_AENEID','Direct attestation',
 'Neptune calms the storm raised by Aeolus (1.124-156); provides passage for Aeneas (5.779-826). Aeneid 1.142-156 contains the famous simile of Neptune as statesman calming a mob.'),
('ENT_ROM_MARS','SRC_VIRGIL_AENEID','Direct attestation',
 'Mars is father of Romulus (implied throughout the Aeneid''s Trojan-to-Roman arc); patron of war; 1.274-277 (Romulus destined to found Rome); 9.717 (invoked in battle). The Aeneid reinforces Mars''s role as divine ancestor of the Roman people.'),
('ENT_ROM_MERCURY','SRC_VIRGIL_AENEID','Direct attestation',
 'Mercury delivers Jupiter''s command to Aeneas to leave Carthage (4.222-278, 4.554-570). Depicted with caduceus, winged sandals, and hat; the most vivid Hermes/Mercury description in Latin literature.'),
('ENT_ROM_JANUS','SRC_VIRGIL_AENEID','Direct attestation',
 'Janus appears at 7.179-182 (palace of Latinus has statue of Janus) and 7.607-615 (the gates of Janus opened to declare war). Virgil is our primary literary source for the ritual function of the Janus gates.'),
('ENT_ROM_MINERVA','SRC_VIRGIL_AENEID','Direct attestation',
 'Minerva''s wrath for the desecration of her temple during the sack of Troy pervades the Aeneid (2.615; 11.483); she favors the Greeks and opposes Aeneas. Aeneid 2.615 confirms her role as destroyer of Troy.'),
('ENT_ROM_DIANA','SRC_VIRGIL_AENEID','Direct attestation',
 'Diana appears as model of beauty (Aeneid 1.498-502, simile for Dido); Camilla is her dedicated huntress and warrior (11.532-596, 11.836-867). The Aeneid is a major source for Diana''s warrior-huntress aspect.'),
('ENT_ROM_CERES','SRC_VIRGIL_AENEID','Direct attestation',
 'Ceres invoked at Aeneid 4.58-59 (Dido''s wedding rites); 6.479 (underworld context). Grain goddess role attested in ritual contexts throughout.'),
('ENT_ROM_SATURN','SRC_VIRGIL_AENEID','Direct attestation',
 'Saturn ruled Latium in the Golden Age (Aeneid 8.319-327: Evander''s account); Saturn''s Hill = the Capitol; his name gives Saturnia to Juno''s cult title. Aeneid 8 is the key text for the Roman Golden Age of Saturn.'),
('ENT_ROM_VULCAN','SRC_VIRGIL_AENEID','Direct attestation',
 'Vulcan forges the Shield of Aeneas (Aeneid 8.370-625, the ekphrasis of Roman history on the shield). One of the most elaborate descriptions of Vulcan/Hephaestus as divine smith in any ancient text.'),
('ENT_ROM_PLUTO','SRC_VIRGIL_AENEID','Direct attestation',
 'Pluto/Dis Pater rules the underworld visited by Aeneas in Book 6; 6.127-131 (golden bough required to enter); 6.269-272 (gate of Dis). Aeneid Book 6 is a foundational text for Roman underworld topography.'),
('ENT_ROM_PROSERPINA','SRC_VIRGIL_AENEID','Direct attestation',
 'Proserpina receives the golden bough (Aeneid 6.141-142); consort of Pluto in the Roman underworld. 6.397-401 (Charon''s realm). Central to Aeneid Book 6 as queen of the dead.'),
('ENT_ROM_APOLLO','SRC_VIRGIL_AENEID','Direct attestation',
 'Apollo appears at Aeneid 3.73-98 (oracle at Delos); 6.9-12 (Cumae/Sibyl); 9.638-663 (Apollo commends Ascanius in battle). The Aeneid reflects Augustus''s special patronage of Apollo.'),
('ENT_ROM_BACCHUS','SRC_VIRGIL_AENEID','Direct attestation',
 'Bacchus/Liber appears in Aeneid 6.805 (among Rome''s divine founders); 7.385-391 (Amata''s Bacchic frenzy). The Aeneid attests Bacchus as civic deity as well as god of ecstatic rites.'),
('ENT_ROM_VESTA','SRC_VIRGIL_AENEID','Direct attestation',
 'Vesta appears in Aeneid 2.296-297 (Aeneas rescues her sacred fire from Troy); 2.567-569; 5.744. The Aeneid grounds the Trojan origin of the Roman Vestal fire.'),
('ENT_ROM_PENATES','SRC_VIRGIL_AENEID','Direct attestation',
 'The Penates appear in Aeneid 2.293-295 (Hector''s ghost tells Aeneas to take the Penates); 2.717 (Aeneas carries them from Troy); 3.148-171 (the Penates appear to Aeneas in a dream to direct him to Italy). The Aeneid is the primary source for the Trojan origin of the Roman Penates.'),
('ENT_ROM_LARES','SRC_VIRGIL_AENEID','Direct attestation',
 'Lares appear throughout; Aeneid 5.744 (household Lares invoked); the Lares/Penates distinction is foundational to the Aeneid''s theology of Roman household religion.'),
('ENT_ROM_GENIUS','SRC_VIRGIL_AENEID','Direct attestation',
 'Genius of the place (genius loci); Aeneid 7.136 (genius of the River Tiber); 8.62-65 (Tiber appears as the genius of the river). Roman genius theology implicit throughout.');

-- ── 3. Livy — key Roman civic religion attestations ──────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_ROM_JUPITER','SRC_LIVY_AUC','Direct attestation',
 'Jupiter Optimus Maximus is the presiding deity of the Roman state throughout Livy. AUC 1.10 (first triumphal offering to Jupiter Feretrius by Romulus); 1.38 (Capitoline temple vow); 5.51-54 (Jupiter''s will that Rome remain at the Tiber). Livy is the essential source for Jupiter''s role as guarantor of Roman victory.'),
('ENT_ROM_JANUS','SRC_LIVY_AUC','Direct attestation',
 'AUC 1.19.2-4 (Numa Pompilius institutes opening/closing of Janus''s gates to signify peace or war); this is the primary prose source for the ritual of the Janus gates.'),
('ENT_ROM_QUIRINUS','SRC_LIVY_AUC','Direct attestation',
 'AUC 1.16.3 (Romulus deified as Quirinus after his disappearance; Proculus Julius''s testimony). Livy is the primary narrative source for Romulus''s apotheosis as Quirinus.'),
('ENT_ROM_MARS','SRC_LIVY_AUC','Direct attestation',
 'Mars as divine father of Romulus; AUC 1.4.1-2 (Rhea Silvia claims Mars fathered Romulus and Remus); Salii priests of Mars; AUC 1.20.4 (Numa establishes Salii). Key civic religion attestations throughout Books 1-10.'),
('ENT_ROM_VESTA','SRC_LIVY_AUC','Direct attestation',
 'AUC 1.20.3 (Numa institutes the Vestal Virgins and the eternal fire of Vesta); primary prose source for the Vestal institution. AUC 5.40.7 (Vestals carry sacred objects during the Gallic sack).'),
('ENT_ROM_LARES','SRC_LIVY_AUC','Direct attestation',
 'Lares Compitales appear in Livy in the context of prodigies and festivals; AUC 34.44.8 (compitalia festival). Attests civic role of Lares in the Roman neighborhood system.'),
('ENT_ROM_PENATES','SRC_LIVY_AUC','Direct attestation',
 'Penates of Lavinium appear as the Trojan sacred objects brought to Italy; AUC 1.14.2; 5.52.8-10 (Camillus speech: Rome cannot abandon its Penates). State Penates at Lavinium as objects of annual Latin League ceremony.'),
('ENT_ROM_SATURN','SRC_LIVY_AUC','Direct attestation',
 'Saturn''s treasury (Aerarium Saturni) at the foot of the Capitol; AUC 2.21.2 (treasury established). Saturnalia festival implicit throughout. Attests Saturn''s role as presider over state finance.'),
('ENT_ROM_CERES','SRC_LIVY_AUC','Direct attestation',
 'Temple of Ceres (Aventine triad Ceres-Liber-Libera) dedicated 493 BCE; AUC 2.41.8. Key source for the Aventine plebeian triad and Ceres''s role in grain supply.');

-- ── 4. Cicero De Natura Deorum — philosophical theology ─────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_ROM_JUPITER','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.64-66 (Stoic account: Jupiter as universal providence); 3.53-60 (Epicurean/Academic critiques). Most systematic ancient account of Jupiter''s theological function.'),
('ENT_ROM_JUNO','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.66 (Juno as personification of air in Stoic allegory); 3.62. Cicero documents both mythological and allegorical interpretations of Juno.'),
('ENT_ROM_NEPTUNE','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.66 (Neptune as personification of the sea in Stoic interpretation); systematic philosophical treatment.'),
('ENT_ROM_MARS','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.67 (Mars as war); 3.62. Cicero documents both the cult function and the Stoic allegorical interpretation of Mars.'),
('ENT_ROM_VENUS','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.69 (Venus as desire/generation in Stoic allegory); 3.62 (Academic critique of Venus myths). Systematic philosophical treatment.'),
('ENT_ROM_MINERVA','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.22 (Minerva/Athena''s birth from Jupiter''s head); 3.59 (Academic). Documents the Roman reception of Greek Athena mythology.'),
('ENT_ROM_DIANA','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.68-69 (Diana/Luna as moon goddess); 3.58. Documents moon-goddess identification.'),
('ENT_ROM_CERES','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.67 (Ceres as grain, from gerere); Cicero gives the Stoic etymology Ceres < gero.'),
('ENT_ROM_VULCAN','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.67 (Vulcan = fire/forge in Stoic allegory). Documents allegorical Roman theology.'),
('ENT_ROM_MERCURY','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.62 (Mercury as reason/speech in Stoic allegory). Key for Mercury''s philosophical reception.'),
('ENT_ROM_BACCHUS','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.62; 3.58. Cicero cites multiple versions of Bacchus/Dionysus, noting their theological confusion.'),
('ENT_ROM_SATURN','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.64 (Saturn = time in Stoic allegory, from satus/saturation). Documents Stoic allegorization of Saturn.'),
('ENT_ROM_JANUS','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.67 (Janus = ianus/doorway; Cicero''s systematic analysis of Janus as a uniquely Roman deity without Greek parallel).'),
('ENT_ROM_VESTA','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.67 (Vesta = fire of the hearth; Stoic element allegory). Key for Roman hearth-fire theology.'),
('ENT_ROM_PLUTO','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.66 (Pluto/Dis as ruler of the earth and underworld in Stoic interpretation).'),
('ENT_ROM_PROSERPINA','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.66 (Proserpina as grain seed that descends into the earth — Stoic allegory of agriculture).'),
('ENT_ROM_APOLLO','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.68 (Apollo = sun in Stoic allegory; the "many-named" Apollo); 3.57-59. Extensive philosophical treatment.'),
('ENT_ROM_QUIRINUS','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.62 (Quirinus = Romulus deified; Cicero cites Proculus Julius). Documents the apotheosis tradition.'),
('ENT_ROM_GENIUS','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 2.45 (genius as the divine creative force in every individual; Stoic treatment). Primary philosophical source for the Roman genius concept.'),
('ENT_ROM_LARES','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 3.39-42 (Cotta''s critique of the proliferation of gods including Lares). Attests the philosophical debate about Roman household deities.'),
('ENT_ROM_PENATES','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 3.39 (Penates as a category; Cotta''s critique). Attests theological classification of the Penates.'),
('ENT_ROM_MANES','SRC_CICERO_DE_NATURA','Direct attestation',
 'DND 3.39 (Manes / di Inferi as a theological category debated). Primary philosophical source for Manes theology.');

-- ── 5. Varro Antiquitates (via Augustine) ────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_ROM_JUPITER','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro treats Jupiter as the supreme deity of civic (political) theology; cited in Augustine City of God 7.9-11. Varro distinguishes the philosophical Jupiter (soul of the world) from the civic cult figure.'),
('ENT_ROM_JANUS','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro devotes special analysis to Janus (City of God 7.9); notes that Janus is uniquely Roman with no Greek equivalent and represents beginnings/doorways. Key source for Janus theology.'),
('ENT_ROM_SATURN','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro''s Saturn as seed/sowing deity; City of God 7.13. Varro offers the canonical Roman allegorization of Saturn.'),
('ENT_ROM_GENIUS','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro''s taxonomy places Genius in the category of di selecti (chosen gods); City of God 7.13; the fullest ancient account of the genius system.'),
('ENT_ROM_JUNO','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro''s account of Juno as soul element (air) and queen of the gods; City of God 7.11.'),
('ENT_ROM_LARES','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro traces Lares to the souls of the dead; City of God 7.6; the most systematic ancient treatment of Lares theology.'),
('ENT_ROM_MANES','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro on di Manes as the souls of the departed; City of God 7.6; standard ancient classification.'),
('ENT_ROM_PENATES','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro identifies the Penates with the di selecti (principal gods) rather than the Trojan household gods; City of God 7.5.'),
('ENT_ROM_VESTA','SRC_VARRO_ANTIQ','Direct attestation',
 'Varro''s identification of Vesta with the earth (terra); City of God 7.16; differs from the more common fire identification and is Varro''s distinctive contribution.');

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT
  e.entity_id,
  e.canonical_name,
  COUNT(es.source_id) AS source_count,
  string_agg(es.source_id, ', ' ORDER BY es.source_id) AS sources
FROM entities e
JOIN entity_sources es ON e.entity_id = es.entity_id
WHERE e.tradition = 'Roman'
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;

COMMIT;
