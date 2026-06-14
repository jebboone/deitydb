-- scripts/add_baltic_layer.sql
-- Adds the Baltic religious tradition (Lithuanian and Latvian/Old Prussian).
-- The Baltic pantheon is documented primarily through:
--   (a) chronicle accounts from the 13th-17th centuries (Lasicki, Stryjkowski, Grunau)
--   (b) folk song (dainos / dainas) traditions collected in the 18th-20th centuries
--   (c) comparative Baltic-Slavic-Indo-European linguistics
-- Core tradition label: "Baltic"

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_GIMBUTAS_BALTS',
 'Marija Gimbutas, The Balts (Thames and Hudson, London, 1963)',
 'secondary scholarly',
 'The foundational English-language survey of Baltic culture and religion, covering Lithuanian, Latvian, and Old Prussian traditions from the Bronze Age through the medieval Christianisation period. Chapter 9 (The Religion of the Balts) is the standard academic overview of the Baltic pantheon in English: Dievas (sky god), Perkūnas (thunder), Velnias/Vels (chthonic), Laima (fate), Saulė (sun), Meness (moon), Žemyna (earth), and associated folk deities. Gimbutas draws on chronicle sources (Lasicki 1615, Stryjkowski 1582, Grunau 1517-21) and comparative Indo-European evidence. Standard citation for Baltic deity attestation in the secondary literature.'),
('SRC_GREIMAS_LITHUANIAN',
 'Algirdas Julien Greimas, Of Gods and Men: Studies in Lithuanian Mythology (Indiana University Press, Bloomington, 1992; trans. Milda Newman and Joseph Fitzgerald)',
 'secondary scholarly',
 'Structuralist analysis of Lithuanian mythology by a leading semiotician and linguist. Covers the Dievas–Velnias–Perkūnas triad, the celestial family myth cycle (Saulė, Meness, Ašvieniai), Laima as the fate-spinner, and the deep structure of Baltic cosmic myth. Greimas distinguishes the Lithuanian mythological tradition from Slavic parallels and traces Indo-European cognates. The most analytically rigorous secondary source for Lithuanian mythology; supplements Gimbutas on theological structure. Reference for the celestial myth cycle and the Perkūnas vs. Velnias cosmic battle.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_BALT_PAGAN',
 'Baltic',
 'Baltic Pre-Christian Period',
 -2000, 1400,
 'The pre-Christian religious tradition of the Baltic peoples (Lithuanians, Latvians, Old Prussians), from the Bronze Age through the late conversion period. Lithuania was the last European nation formally Christianised (1387 for the ruling class; folk paganism persisted through the 17th century). Deity names attested in chronicles from the 13th century onward; reconstructed earlier from comparative IE linguistics and folk song traditions. Gimbutas (1963) is the standard secondary source for this period.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_BALT_DIEVAS',
 'Dievas',
 'Baltic',
 'sky god',
 'Creator Deity',
 'sky; sovereignty; cosmic order; divine society',
 'A',
 'Supreme sky god of the Baltic tradition; Lithuanian Dievas, Latvian Dievs. The name is cognate with Proto-Indo-European *Dyēus (Greek Zeus, Latin Deus), preserving the ancient sky-father typology. Dievas is portrayed in Lithuanian folk songs (dainos) as a farmer-king who works the sky-fields, wears a silver coat and golden belt, and descends to earth on a grey horse; he embodies cosmic and social order. In the mythological narrative cycle, Dievas and Velnias are complementary opposites: Dievas governs the upper sky-world while Velnias rules the chthonic realm; Perkūnas mediates by enforcing sky-world order. Gimbutas (1963) pp. 197-198; Greimas (1992) pp. 57-75.'),
('ENT_BALT_PERKUNAS',
 'Perkūnas',
 'Baltic',
 'god',
 'Thunder Deity',
 'thunder; lightning; storm; order; battle against chaos',
 'A',
 'Thunder deity; Lithuanian Perkūnas, Latvian Pērkons, Old Prussian Percunis. Name from Baltic *Perkūnas, cognate with Sanskrit Parjanya, Old Norse Fjörgyn (earth, mother of Thor), and ultimately PIE *perkʷ- (oak, thunder). Perkūnas is the great storm deity who drives away Velnias (the chthonic serpentine deity), often depicted as Velnias hiding under trees, in cattle, in humans — and Perkūnas shattering the hiding place with lightning. This Perkūnas-vs.-Velnias myth is one of the best-attested Baltic mythological narratives, preserved in folk songs and converging with Vedic Indra-vs.-Vrtra and Slavic Perun-vs.-Veles. First attested as "Percunis" in the Livonian Rhymed Chronicle (c. 1290 CE). Gimbutas (1963) pp. 199-200; Greimas (1992) pp. 77-120.'),
('ENT_BALT_VELNIAS',
 'Velnias',
 'Baltic',
 'chthonic deity',
 'Underworld Deity',
 'underworld; cattle; magic; wealth; the dead; shapeshifting',
 'A',
 'Chthonic deity of the Baltic tradition; Lithuanian Velnias (later folk form: Vėlinas), Latvian Vels. Lord of the realm of the dead (vėlės), protector of cattle and earthly wealth, master of magic and the arts. The name is cognate with Slavic Veles and ultimately with PIE *wel- (the dead, the realm of the dead). Velnias is the serpentine antagonist of Perkūnas in the great Baltic cosmic myth: he steals cattle, gold, or a solar being and hides below the earth, in trees, in water; Perkūnas pursues him with lightning. Despite his adversarial role, Velnias is not simply evil — he governs essential underworld functions including agricultural fertility and the wealth of the earth. Attested in chronicle sources and folk song. Gimbutas (1963) pp. 200-201; Greimas (1992) pp. 121-150.'),
('ENT_BALT_LAIMA',
 'Laima',
 'Baltic',
 'fate goddess',
 'Fate Deity',
 'fate; luck; birth; death; weaving; cuckoo omens',
 'A',
 'Fate goddess of the Baltic tradition; Lithuanian Laima, Latvian Laima (from Latvian laime, luck). Laima determines the fate of each person at birth and death; she appears as a cuckoo whose calls predict the years of life remaining. Laima is sometimes paired with Dievas in the cosmic dispensing of fate, and sometimes with Dievas and Perkūnas as part of a fate-determining triad. She weaves or spins the thread of fate and is associated with the cuckoo, the linden tree, and the morning star. Gimbutas (1963) pp. 202-203; Greimas (1992) pp. 153-185.'),
('ENT_BALT_SAULE',
 'Saulė',
 'Baltic',
 'sun goddess',
 'Solar Deity',
 'sun; light; justice; weaving; amber; spinning; fate',
 'A',
 'Sun goddess; Lithuanian Saulė, Latvian Saule. One of the most prominent deities in Baltic folk song (daina / dainas): she is a spinning, weaving, dancing maiden who drives a copper chariot across the sky, rests at night in an amber island in the sea, and dispenses justice (especially for orphans and the poor). The solar deity is feminine in Baltic (unlike Germanic/Norse Sol, she is central rather than peripheral). In the celestial myth cycle, Saulė is betrothed to or formerly married to Meness (moon); their relationship is often described as troubled (divorce, a quarrel judged by Perkūnas). Associated with amber — tears of Saulė — which is uniquely prominent in Baltic religion given the Baltic amber trade. Gimbutas (1963) pp. 203-204; Greimas (1992) pp. 188-220.'),
('ENT_BALT_MENESS',
 'Meness',
 'Baltic',
 'moon deity',
 'Moon Deity',
 'moon; time; marriage; stars; celestial cycle',
 'A',
 'Moon deity; Lithuanian Meness, Latvian Meness (cognate with Latin mensis, PIE *meh₁n̥s-). Notably masculine in Baltic tradition, in contrast to the feminine moon-deity common elsewhere. Meness is paired with or opposed to Saulė (sun goddess); in the mythological narrative they were married but Meness was unfaithful (had an affair with the Morning Star / Auseklis), for which Perkūnas split him with his sword — which is why the moon waxes and wanes. The Saulė–Meness–Auseklis myth cycle is one of the most elaborate surviving Baltic mythological narratives. Gimbutas (1963) pp. 204; Greimas (1992) pp. 221-250.'),
('ENT_BALT_GABIJA',
 'Gabija',
 'Baltic',
 'fire deity',
 'Hearth Deity',
 'fire; hearth; home; protection; purity',
 'A',
 'Sacred fire deity / personification of the hearth fire; Lithuanian Gabija (from gabti, to cover, protect). The household fire was kept perpetually burning as the dwelling of Gabija; extinguishing it was inauspicious. Gabija was offered libations of bread, salt, and beer and was considered the protector of the household and family. The sacred fire at the temple of Romuva (Old Prussian; also Romowe) was an eternal flame served by vestal priestesses, described in the chronicle of Peter of Dusburg (1326 CE). Gabija represents the domestic hearth tradition widespread in Indo-European religion (cf. Hestia, Vesta, Vedic Agni in the domestic role). Gimbutas (1963) pp. 204-205.'),
('ENT_BALT_ZEMYNA',
 'Žemyna',
 'Baltic',
 'earth goddess',
 'Earth Deity',
 'earth; agriculture; fertility; ancestors; libations',
 'A',
 'Earth goddess; Lithuanian Žemyna (from žemė, earth; cognate with Latvian Zemes māte, Mother Earth). Žemyna receives the first and last libation at every meal, poured on the earth. She is the mother of the living and the receiving earth for the dead; prayers address her as Žemyna rūpintojėlė (caring Žemyna). Latvian tradition elaborates her as Zemes māte (Mother Earth) and multiplies her into a family of specialized earth-mothers governing fields, forests, water, and graves. Gimbutas (1963) pp. 205; Greimas (1992) pp. 253-260.'),
('ENT_BALT_MEDEINA',
 'Medeina',
 'Baltic',
 'forest deity',
 'Nature Deity',
 'forests; hunting; wild animals; trees',
 'A',
 'Forest deity; Lithuanian Medeina (from medis, tree, forest), Latvian Meža māte (Forest Mother). Patron of forests and hunting; depicted as a woman accompanied by a wolf, or as a deity who must be appeased before entering the forest or cutting trees. Medeina is attested in the chronicle of Jan Lasicki (De diis Samagitarum, 1615 CE), which lists Lithuanian forest and grove deities. The Romowe sanctuary (Romuva) was a sacred oak grove; the veneration of sacred groves (alka) is widely attested in Baltic tradition. Gimbutas (1963) pp. 200, 206.'),
('ENT_BALT_RAGANA',
 'Ragana',
 'Baltic',
 'spirit / witch figure',
 'Spirit',
 'witchcraft; shape-shifting; disease; night; owls',
 'B',
 'Witch-spirit of Baltic folk tradition; Lithuanian ragana (from ragana, witch, seer; related to regėti, to see / perceive). Ragana is a shapeshifting being who can transform into an animal (typically a hare, toad, or owl), fly at night, cause disease in livestock, and steal the milk of cattle. In folk songs she is sometimes associated with the moon and darkness, and sometimes identified with the souls of dead women who did not die a natural death. She occupies an ambivalent position between deity and spirit; Gimbutas treats her as a demonized survival of an older chthonic goddess tradition. Evidence is primarily from 17th-18th century folk accounts and ethnographic collection; classified confidence B (folk tradition, not direct chronicle attestation). Gimbutas (1963) pp. 207-208.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_BALT_DIEVAS',   'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 197-198: Dievas as sky-farmer deity; PIE *Dyēus cognate; folk song iconography.'),
('ENT_BALT_DIEVAS',   'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 57-75: structuralist analysis of the Dievas-Velnias-Perkūnas triad.'),
('ENT_BALT_PERKUNAS', 'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 199-200: Perkūnas etymology, iconography, vs. Velnias myth cycle.'),
('ENT_BALT_PERKUNAS', 'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 77-120: the Perkūnas-vs.-Velnias narrative; cosmic battle structure.'),
('ENT_BALT_VELNIAS',  'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 200-201: Velnias as lord of dead, cattle, magic; vs. Perkūnas myth.'),
('ENT_BALT_VELNIAS',  'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 121-150: Velnias in the cosmic myth; chthonic vs. sky-world structure.'),
('ENT_BALT_LAIMA',    'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 202-203: Laima as fate goddess; cuckoo oracle; birth and death fate.'),
('ENT_BALT_LAIMA',    'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 153-185: Laima in the fate-dispensing narrative; linden and cuckoo symbolism.'),
('ENT_BALT_SAULE',    'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 203-204: Saulė as feminine sun deity; copper chariot; amber; spinning.'),
('ENT_BALT_SAULE',    'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 188-220: the celestial myth cycle (Saulė, Meness, Auseklis, Perkūnas).'),
('ENT_BALT_MENESS',   'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) p. 204: Meness as masculine moon deity; divorce from Saulė myth.'),
('ENT_BALT_MENESS',   'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 221-250: Saulė-Meness-Auseklis narrative; Perkūnas judges and splits the moon.'),
('ENT_BALT_GABIJA',   'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 204-205: Gabija hearth fire; Romowe eternal flame; vestal priestesses.'),
('ENT_BALT_ZEMYNA',   'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) p. 205: Žemyna libation; earth-mother of living and dead.'),
('ENT_BALT_ZEMYNA',   'SRC_GREIMAS_LITHUANIAN',  'Secondary analysis', 'Greimas (1992) pp. 253-260: Žemyna in the Baltic cosmological structure.'),
('ENT_BALT_MEDEINA',  'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 200, 206: Medeina; sacred grove (alka) tradition; Jan Lasicki 1615 attestation.'),
('ENT_BALT_RAGANA',   'SRC_GIMBUTAS_BALTS',     'Secondary analysis', 'Gimbutas (1963) pp. 207-208: Ragana as shapeshifting witch-spirit; ethnographic collection 17th-18th c.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_BALT_DIEVAS',   'PER_BALT_PAGAN', 'high',   'Sky god named in chronicle sources from 13th c. onward; folk song tradition continuous through 20th c.; reconstructed from PIE comparanda.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_PERKUNAS', 'PER_BALT_PAGAN', 'high',   '"Percunis" attested in Livonian Rhymed Chronicle c. 1290 CE; thunder cult continuous through the pre-Christianisation period of Lithuania (to 1387+).', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_VELNIAS',  'PER_BALT_PAGAN', 'high',   'Attested in chronicle sources and folk song tradition; the Perkūnas-Velnias myth cycle is one of the best-attested Baltic narratives.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_LAIMA',    'PER_BALT_PAGAN', 'high',   'Fate goddess widely attested in Lithuanian and Latvian folk song tradition; chronicle mention from 15th c.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_SAULE',    'PER_BALT_PAGAN', 'high',   'Sun goddess central in Baltic folk song tradition; amber association reflects Baltic prehistoric religion.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_MENESS',   'PER_BALT_PAGAN', 'high',   'Moon deity in the celestial myth cycle; attested in folk song tradition.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_GABIJA',   'PER_BALT_PAGAN', 'high',   'Hearth fire tradition attested; Romowe eternal flame described by Peter of Dusburg (1326 CE).', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_ZEMYNA',   'PER_BALT_PAGAN', 'high',   'Earth goddess libation tradition widely attested in ethnographic and chronicle sources.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_MEDEINA',  'PER_BALT_PAGAN', 'high',   'Forest deity attested in Jan Lasicki (1615); alka sacred grove tradition continuous.', 'SRC_GIMBUTAS_BALTS', 'reviewed'),
('ENT_BALT_RAGANA',   'PER_BALT_PAGAN', 'medium', 'Witch-spirit from 17th-18th c. folk sources; represents demonised survival of older tradition.', 'SRC_GIMBUTAS_BALTS', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- The core Perkūnas–Velnias cosmic battle
('ENT_BALT_PERKUNAS', 'opposes', 'ENT_BALT_VELNIAS',
 'high',
 'The central Baltic mythological narrative: Perkūnas (thunder) pursues Velnias (chthonic) who steals cattle or a solar being and hides below the earth or in trees. Perkūnas shatters hiding places with lightning. Attested in dozens of Lithuanian folk songs and reconstructed comparatively. Greimas (1992) pp. 77-120; Gimbutas (1963) p. 200.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
('ENT_BALT_VELNIAS', 'opposed_by', 'ENT_BALT_PERKUNAS',
 'high',
 'Velnias is the chthonic antagonist of Perkūnas in the cosmic battle myth; he flees into the earth, trees, and water to escape Perkūnas''s lightning. Greimas (1992) pp. 121-150.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
-- Dievas and the divine triad
('ENT_BALT_DIEVAS', 'paired_with', 'ENT_BALT_LAIMA',
 'medium',
 'Dievas and Laima together dispense fate in the Lithuanian folk narrative; they are sometimes depicted as partners who decide human destiny. Greimas (1992) pp. 57-75; Gimbutas (1963) p. 202.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
-- Saule and Meness
('ENT_BALT_SAULE', 'paired_with', 'ENT_BALT_MENESS',
 'high',
 'Sun and moon are divine partners in the Baltic celestial myth; their marriage and subsequent troubled relationship (Meness''s infidelity with the morning star) judged by Perkūnas, who splits Meness with his sword — explaining the moon''s phases. Greimas (1992) pp. 188-250.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
('ENT_BALT_MENESS', 'paired_with', 'ENT_BALT_SAULE',
 'high',
 'Moon is paired with the sun goddess Saulė in the celestial myth cycle; their separation is adjudicated by Perkūnas. Greimas (1992) pp. 221-250.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
-- Perkūnas judges the Saule-Meness divorce
('ENT_BALT_PERKUNAS', 'judges', 'ENT_BALT_MENESS',
 'high',
 'In the celestial myth, Perkūnas judges the moon guilty of unfaithfulness to Saulė and splits him with a sword, explaining the waning moon. This is one of the most widely attested narrative elements in Baltic folk song. Greimas (1992) pp. 221-250.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
-- Gabija embodies the sacred fire
('ENT_BALT_GABIJA', 'embodies', 'ENT_FIRE',
 'high',
 'Gabija is the personification of the sacred hearth fire; the fire IS Gabija, not merely her symbol. Gimbutas (1963) pp. 204-205.',
 'SRC_GIMBUTAS_BALTS', 'PER_BALT_PAGAN', 'reviewed'),
-- Žemyna embodies earth
('ENT_BALT_ZEMYNA', 'embodies', 'ENT_EARTH',
 'high',
 'Žemyna is the personification of the earth itself; libations poured on the ground go directly to her. Gimbutas (1963) p. 205.',
 'SRC_GIMBUTAS_BALTS', 'PER_BALT_PAGAN', 'reviewed'),
-- Cross-traditional parallels
('ENT_BALT_PERKUNAS', 'aligned_with', 'ENT_NOR_THOR',
 'high',
 'Perkūnas and Thor are cognate thunder deities: both wield the thunder weapon against a serpentine or giant antagonist, both protect the ordered world from chthonic chaos. The PIE *perkʷ- (oak/thunder) root and the structural myth parallel are well established. Gimbutas (1963) p. 199; Greimas (1992) pp. 77-84.',
 'SRC_GREIMAS_LITHUANIAN', 'PER_BALT_PAGAN', 'reviewed'),
('ENT_BALT_DIEVAS', 'aligned_with', 'ENT_ZEUS',
 'high',
 'Dievas and Zeus are cognate sky-father deities from PIE *Dyēus; both govern cosmic order and are the supreme divine rulers in their respective traditions. Gimbutas (1963) p. 197; comparative IE evidence.',
 'SRC_GIMBUTAS_BALTS', 'PER_BALT_PAGAN', 'reviewed'),
('ENT_BALT_VELNIAS', 'aligned_with', 'ENT_NOR_HEL',
 'medium',
 'Velnias governs the Baltic realm of the dead (vėlės) as a chthonic divine being, functionally parallel to Hel''s underworld rule; the parallel is structural (lord of the dead) rather than etymological. Gimbutas (1963) p. 200.',
 'SRC_GIMBUTAS_BALTS', 'PER_BALT_PAGAN', 'reviewed'),
-- Medeina domain
('ENT_BALT_MEDEINA', 'patron_of', 'ENT_STORM',
 'low',
 'Placeholder — use patron_of forests instead; see note.',
 'SRC_GIMBUTAS_BALTS', 'PER_BALT_PAGAN', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- Remove the placeholder Medeina relationship (forests entity may not exist)
DELETE FROM entity_relationships
WHERE subject_entity_id = 'ENT_BALT_MEDEINA'
  AND relationship_type = 'patron_of'
  AND object_entity_id = 'ENT_STORM';

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS baltic_entities FROM entities WHERE tradition = 'Baltic';
SELECT * FROM v_release_metrics;

COMMIT;
