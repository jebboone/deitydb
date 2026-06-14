-- scripts/add_transjordanian_layer.sql
-- Adds the Iron Age Transjordanian national deities: Moabite, Ammonite, and Edomite.
-- These are the three peoples immediately east of the Jordan and Dead Sea whose
-- national deities are attested epigraphically and in the Hebrew Bible.
--
-- Primary sources:
--   Kemosh (Moab): Mesha Stele (c. 840 BCE), Hebrew Bible
--   Milkom (Ammon): Hebrew Bible (1 Kgs 11, 2 Kgs 23, Jer 49, Zeph 1)
--   Qos (Edom): Edomite onomastic inscriptions (7th–5th c. BCE)

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_MESHA_STELE',
 'The Mesha Stele (Moabite Stone), c. 840 BCE; ed. John A. Dearman, Studies in the Mesha Inscription and Moab (Scholars Press / ASOR, Atlanta, 1989)',
 'primary epigraphic',
 'The Mesha Stele (also: Moabite Stone; KAI 181) is a basalt monument erected by King Mesha of Moab c. 840 BCE, now in the Louvre. At 34 lines it is the longest Iron Age inscription from the southern Levant and the most detailed pre-biblical account of Kemosh as national deity. The text names Kemosh nine times, attributes Moab''s subjugation under Omri of Israel to Kemosh''s anger, and records Kemosh''s command to retake Israelite-held territory ("Go, take Nebo against Israel"). It explicitly mirrors the Deuteronomistic theology of Yahweh applied to Kemosh: divine anger, military defeat, divine favour, restoration. Dearman (1989) provides the standard critical edition and commentary; the KAI (Kanaanäische und aramäische Inschriften) number is 181. Primary source for all Kemosh claims in this layer.'),
('SRC_BARTLETT_EDOM',
 'John R. Bartlett, Edom and the Edomites (JSOT Supplement Series 77; Sheffield Academic Press, Sheffield, 1989)',
 'secondary scholarly',
 'The standard scholarly monograph on Edomite history and religion. Chapter 6 covers the Edomite deity Qos (Qaus): the name does not appear in the canonical Hebrew Bible as a divine name, but is attested as a theophoric element in Edomite personal names recovered from inscriptions at Umm el-Biyara, Buseirah (biblical Bozrah), Horvat Qitmit, and En Hazeva (7th–5th c. BCE). Bartlett surveys the onomastic evidence and concludes Qos was the national deity of Edom, a thunderstorm deity comparable in function to Kemosh for Moab and Milkom for Ammon. Also covers Edomite culture, the Edom–Israel relationship in biblical texts, and the archaeology of the Edomite heartland. Standard citation for all Qos claims.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_TRANSJORDAN_IRON_AGE',
 'Transjordanian',
 'Iron Age Transjordanian',
 -1200, -500,
 'The period of the independent Iron Age kingdoms of Moab, Ammon, and Edom, from the emergence of these polities in the Late Bronze–Iron Age transition (c. 1200 BCE) through their conquest by Babylonia under Nebuchadnezzar II (Moab and Ammon c. 582 BCE; Edom came under Babylonian and then Nabataean pressure from c. 550 BCE). The national deities — Kemosh (Moab), Milkom (Ammon), and Qos (Edom) — are attested primarily within this period. The Mesha Stele (c. 840 BCE) is the key primary epigraphic source; biblical attestations span the 9th–6th c. BCE. Bartlett (1989) is the standard secondary reference for the Edomite side; Dearman (1989) for Moabite.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
-- MOABITE ─────────────────────────────────────────────────────────────────────
('ENT_MOA_KEMOSH',
 'Kemosh',
 'Moabite',
 'national deity',
 'War Deity',
 'war; national sovereignty; destruction; divine anger; restoration',
 'A',
 'National deity of Moab; also spelled Chemosh, Kamosh. Primary attestation: the Mesha Stele (c. 840 BCE; KAI 181), which names Kemosh nine times and presents him as the supreme deity of Moab — the one whose anger caused Moab''s subjugation under Israel, and whose favour enabled its restoration. The theological structure of the Mesha Stele exactly mirrors Deuteronomistic theology: "Omri, king of Israel, humiliated Moab many years, for Kemosh was angry with his land." Kemosh commands military campaigns directly: "Go, take Nebo against Israel" (line 14). Kemosh receives the spoils of battle as ḥērem (sacred destruction/devotion). Hebrew Bible: Numbers 21:29 calls the Moabites "the people of Kemosh"; Judges 11:24 records Jephthah''s argument that each people holds the land its deity grants; 1 Kings 11:7,33 reports Solomon building a high place for Kemosh on the Mount of Olives; Jeremiah 48:7,13,46 announces Kemosh''s exile in judgment. Kemosh is a war and storm deity; later Hellenistic sources equated him with Ares. Dearman (1989) pp. 95-160; Cross (1973) pp. 228-229.'),
('ENT_MOA_ASHTAR_KEMOSH',
 'Ashtar-Kemosh',
 'Moabite',
 'syncretic deity / warrior form',
 'War Deity',
 'war; sacred destruction; Venus-warrior; ḥērem',
 'B',
 'A compound divine name appearing once in the Mesha Stele (line 17): "And I devoted [the city of Nebo] to destruction (ḥrm) for Ashtar-Kemosh." The name conflates Ashtar (the warrior aspect of the Venus deity, attested in Ugaritic as a fertility-warrior figure who briefly occupies Baal''s throne) with Kemosh. The exact theological relationship is debated: Ashtar-Kemosh may be a compound epithet of Kemosh in his warrior/destructive aspect, a distinct deity subordinate to Kemosh, or Kemosh himself conflated with the Ashtar cult in Moabite territory. Cross (1973) p. 229 interprets the name as "Ashtar of Kemosh" — Kemosh''s consort or feminine cult partner. The single attestation limits certainty. Dearman (1989) pp. 118-120; KAI 181 line 17.'),
-- AMMONITE ────────────────────────────────────────────────────────────────────
('ENT_AMM_MILKOM',
 'Milkom',
 'Ammonite',
 'national deity',
 'War Deity',
 'national sovereignty; war; kingship; Ammon',
 'A',
 'National deity of the Ammonites; also spelled Milcom, Malcam. Name from Proto-Semitic *mlk (king); the deity''s name literally means "the King." Primary attestation in the Hebrew Bible: 1 Kings 11:5,33 record Solomon building a high place for Milkom "the abomination of the Ammonites"; 2 Kings 23:13 records Josiah''s destruction of that high place; Jeremiah 49:1,3 asks "Why has Milkom dispossessed Gad?" and announces Milkom''s exile; Zephaniah 1:5 condemns those who swear by Milkom. The Tell Siran bottle inscription (c. 600 BCE; from Amman) and Ammonite personal names with theophoric Milkom elements (*mlkm, *mlky) confirm the deity''s prominence in the Ammonite royal cult. The identification of Milkom with Molech (the deity associated with child sacrifice in Leviticus 18:21 etc.) is debated; most contemporary scholars treat them as distinct, though both derive from *mlk. Cross (1973) p. 228; DDD Bible, "Milcom" entry.'),
-- EDOMITE ─────────────────────────────────────────────────────────────────────
('ENT_EDO_QOS',
 'Qos',
 'Edomite',
 'national deity',
 'Thunder Deity',
 'thunderstorm; national sovereignty; war; divine bow; Edom',
 'B',
 'National deity of Edom; also spelled Qaus, Qoze, Qôs. The name does not appear as a divine name in the canonical Hebrew Bible — its divine status is inferred from Edomite personal names recovered from Iron Age II and Persian-period inscriptions: Qos-gabr ("Qos is mighty," Edomite king named in Assyrian annals of Esarhaddon and Assurbanipal, 7th c. BCE), Qos-malk, Qos-yada, and dozens of others found at Buseirah (biblical Bozrah), Umm el-Biyara, Horvat Qitmit, and En Hazeva. The onomastic pattern is the same as Milkom-theophoric names for Ammon and Kemosh-theophoric for Moab: the national deity name embedded in royal and elite personal names signals the deity''s supreme status. Qos is generally classified as a thunderstorm deity — the name may connect to the Semitic root *qws (to shoot a bow), suggesting a warrior-archer aspect; alternatively related to Quzah, the pre-Islamic Arabian storm deity. The Horvat Qitmit Edomite sanctuary (7th–6th c. BCE; Beit Arieh 1995) provides archaeological evidence of Edomite cult practice without naming Qos directly. Bartlett (1989) pp. 199-205; DDD Bible, "Qaus" entry.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
-- Kemosh
('ENT_MOA_KEMOSH', 'SRC_MESHA_STELE', 'Primary epigraphic',
 'Mesha Stele (KAI 181) names Kemosh nine times as the supreme deity of Moab. Lines 3-4: "Kemosh was angry with his land." Line 9: "And Kemosh returned [the land] in my days." Line 14: "And Kemosh said to me: Go, take Nebo against Israel." Line 17: "And I devoted it to destruction (ḥrm) for Ashtar-Kemosh." Primary and most detailed epigraphic source.'),
('ENT_MOA_KEMOSH', 'SRC_HEBREW_BIBLE', 'Primary text',
 'Numbers 21:29: "Woe to you, Moab! You are destroyed, O people of Kemosh." Judges 11:24: Jephthah''s theological argument that Kemosh gives Ammon its land as Yahweh gives Israel its land — the clearest biblical recognition of Kemosh as a legitimate national deity. 1 Kings 11:7,33: Solomon''s high place for Kemosh on the Mount of Olives. Jeremiah 48:7,13,46: prophecy of Kemosh''s exile; "Kemosh will go into exile, his priests and officials together." Multiple independent books confirming Kemosh across a 4-century span.'),
('ENT_MOA_KEMOSH', 'SRC_DDD_BIBLE', 'Secondary analysis',
 'DDD Bible, "Chemosh" entry: full survey of the biblical and epigraphic evidence; theological analysis of the Kemosh cult; relationship to Ashtar-Kemosh; Hellenistic equation with Ares.'),
('ENT_MOA_KEMOSH', 'SRC_CROSS_CANAANITE_MYTH', 'Secondary analysis',
 'Cross (1973) pp. 228-229: Kemosh in the context of West Semitic national deity theology; the Mesha Stele as parallel to Deuteronomistic historical writing.'),
-- Ashtar-Kemosh
('ENT_MOA_ASHTAR_KEMOSH', 'SRC_MESHA_STELE', 'Primary epigraphic',
 'KAI 181 line 17: sole attestation of the compound name Ashtar-Kemosh in the ḥērem dedication formula for the city of Nebo. The only ancient source naming this entity.'),
('ENT_MOA_ASHTAR_KEMOSH', 'SRC_DDD_BIBLE', 'Secondary analysis',
 'DDD Bible, "Chemosh" entry: discussion of Ashtar-Kemosh as compound epithet or subordinate deity; survey of interpretive options.'),
-- Milkom
('ENT_AMM_MILKOM', 'SRC_HEBREW_BIBLE', 'Primary text',
 '1 Kings 11:5,33: "Milkom the abomination of the Ammonites" — Solomon''s cultic concession. 2 Kings 23:13: Josiah''s abolition. Jeremiah 49:1,3: "Milkom will go into exile, his priests and officials together." Zephaniah 1:5: condemnation of those who swear oaths by Milkom. Attested across Deuteronomistic History, Jeremiah, and Zephaniah independently.'),
('ENT_AMM_MILKOM', 'SRC_DDD_BIBLE', 'Secondary analysis',
 'DDD Bible, "Milcom" entry: full analysis of biblical evidence, theophoric Ammonite personal names, distinction from Molech, and the divine name etymology (*mlk, King).'),
('ENT_AMM_MILKOM', 'SRC_CROSS_CANAANITE_MYTH', 'Secondary analysis',
 'Cross (1973) p. 228: Milkom in the context of West Semitic national deity theology; the *mlk epithet structure.'),
-- Qos
('ENT_EDO_QOS', 'SRC_BARTLETT_EDOM', 'Secondary analysis',
 'Bartlett (1989) pp. 199-205: full survey of the Qos onomastic evidence; the Qos-gabr attestation in Assyrian annals; archaeological context of the Edomite cult (Horvat Qitmit); thunderstorm / archer etymology.'),
('ENT_EDO_QOS', 'SRC_DDD_BIBLE', 'Secondary analysis',
 'DDD Bible, "Qaus" entry: onomastic evidence, etymology, comparison with Quzah (pre-Islamic Arabian storm deity), and the scholarly debate over Qos''s divine status and function.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_MOA_KEMOSH',        'PER_TRANSJORDAN_IRON_AGE', 'high',
 'Mesha Stele c. 840 BCE; Hebrew Bible attestations from the 9th through 6th c. BCE. Kemosh spans the full Iron Age Moabite kingdom before Babylonian conquest.',
 'SRC_MESHA_STELE', 'reviewed'),
('ENT_MOA_ASHTAR_KEMOSH', 'PER_TRANSJORDAN_IRON_AGE', 'high',
 'Mesha Stele c. 840 BCE; single attestation places the compound name firmly in the Iron Age IIB period.',
 'SRC_MESHA_STELE', 'reviewed'),
('ENT_AMM_MILKOM',        'PER_TRANSJORDAN_IRON_AGE', 'high',
 'Hebrew Bible attestations across Deuteronomistic History (9th c. BCE context), Jeremiah (7th–6th c. BCE), and Zephaniah (late 7th c. BCE); theophoric names in Ammonite inscriptions 7th–6th c. BCE.',
 'SRC_HEBREW_BIBLE', 'reviewed'),
('ENT_EDO_QOS',           'PER_TRANSJORDAN_IRON_AGE', 'high',
 'Qos-gabr named in Assyrian annals of Esarhaddon (680s BCE) and Assurbanipal (660s BCE); onomastic evidence concentrated in the 7th–5th c. BCE Edomite inscriptions.',
 'SRC_BARTLETT_EDOM', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Kemosh domain / function
('ENT_MOA_KEMOSH', 'patron_of', 'ENT_STORM',
 'medium',
 'Kemosh''s warrior function and Hellenistic equation with Ares suggest a storm/war deity typology; not directly described as a storm deity in surviving Moabite sources but inferred from the divine anger / lightning metaphor pattern in the Mesha Stele. DDD Bible "Chemosh" entry.',
 'SRC_DDD_BIBLE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
('ENT_MOA_KEMOSH', 'patron_of', 'ENT_WAR',
 'high',
 'Mesha Stele: Kemosh commands military campaigns ("Go, take Nebo"), receives the ḥērem spoils of battle, and is credited with both Moab''s defeat (divine anger) and its victory (divine favour). The closest ancient parallel to a divine war commander in a national-deity context.',
 'SRC_MESHA_STELE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Ashtar-Kemosh is a cult form / warrior aspect of Kemosh
('ENT_MOA_ASHTAR_KEMOSH', 'cult_form_of', 'ENT_MOA_KEMOSH',
 'medium',
 'The compound name Ashtar-Kemosh (Mesha Stele line 17) most plausibly represents Kemosh in a specific warrior/destructive cult manifestation — the same deity in his ḥērem (sacred destruction) aspect. The Ashtar element (Ugaritic Athtar, the warrior Venus) qualifies Kemosh''s function in the context of sacred battle. Dearman (1989) pp. 118-120.',
 'SRC_MESHA_STELE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Ashtar-Kemosh is aligned with / related to Canaanite Astarte
('ENT_MOA_ASHTAR_KEMOSH', 'aligned_with', 'ENT_CAN_ASTARTE',
 'medium',
 'The Ashtar element of Ashtar-Kemosh shares its divine name with Ugaritic Athtar and the broader Astarte/Ishtar tradition. The warrior aspect of the Astarte-cycle deity is the element relevant here. Cross (1973) p. 229.',
 'SRC_CROSS_CANAANITE_MYTH', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Milkom
('ENT_AMM_MILKOM', 'patron_of', 'ENT_WAR',
 'medium',
 'Milkom is presented as the divine patron of Ammon''s territorial claims in Jeremiah 49:1 ("Has Israel no sons? Has he no heir? Why then has Milkom dispossessed Gad?") — the same structure as Kemosh''s patronage of Moabite territory. DDD Bible "Milcom" entry.',
 'SRC_DDD_BIBLE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Cross-tradition: Kemosh and Milkom as parallel national deities aligned with each other
('ENT_MOA_KEMOSH', 'aligned_with', 'ENT_AMM_MILKOM',
 'high',
 'Kemosh and Milkom share the same structural role as national "divine patron" deities in adjacent Iron Age kingdoms — both are credited with granting territory, demanding exclusive loyalty, and going into exile at national defeat. Judges 11:24 explicitly treats them as parallel: Jephthah argues "Whatever Kemosh your god gives you to possess... that we will possess." Cross (1973) p. 228.',
 'SRC_HEBREW_BIBLE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
('ENT_AMM_MILKOM', 'aligned_with', 'ENT_MOA_KEMOSH',
 'high',
 'Milkom and Kemosh are structurally parallel national deities of adjacent kingdoms; Judges 11:24 treats them as exact parallels in divine territorial patronage. Cross (1973) p. 228.',
 'SRC_HEBREW_BIBLE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Qos aligned with Kemosh and Milkom
('ENT_EDO_QOS', 'aligned_with', 'ENT_MOA_KEMOSH',
 'medium',
 'Qos is the Edomite national deity fulfilling the same structural role as Kemosh for Moab — supreme deity, divine patron of national sovereignty, theophoric element in royal personal names. Bartlett (1989) pp. 199-205.',
 'SRC_BARTLETT_EDOM', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Kemosh and Milkom in reception / polemical context in Israelite tradition
('ENT_MOA_KEMOSH', 'opposed_by', 'ENT_ISR_YAHWEH',
 'high',
 'The Hebrew Bible consistently frames Kemosh as the principal divine opponent of Yahweh in the Transjordanian context. Judges 11:24 (Jephthah) presents the theological schema explicitly. Jeremiah 48 announces Kemosh''s defeat and exile as Yahweh''s judgment on Moab. The opposition is not ontological (Kemosh is not a chaos monster) but geopolitical-theological: competing national divine claims. Mesha Stele is the Moabite mirror image of the same claim structure. Cross (1973) pp. 228-229.',
 'SRC_HEBREW_BIBLE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
('ENT_AMM_MILKOM', 'opposed_by', 'ENT_ISR_YAHWEH',
 'high',
 'Milkom is framed in prophetic literature (Jeremiah 49, Zephaniah 1) as a divine patron whose claims over Ammonite territory oppose Yahweh''s claims for Israel. The Deuteronomistic condemnation of Solomon''s Milkom cult (1 Kings 11:5,33; 2 Kings 23:13) reflects the same theological polemic. DDD Bible "Milcom."',
 'SRC_HEBREW_BIBLE', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed'),
-- Canaanite alignment: all three are West Semitic national deities descending from the El/Baal typology
('ENT_MOA_KEMOSH', 'reception_of', 'ENT_CAN_BAAL',
 'medium',
 'Kemosh shares significant traits with Baal Hadad — war deity, storm associations, divine anger, conflict theology — and likely inherits his divine typology from the broader West Semitic Baal tradition. The Mesha Stele''s rhetorical structure (divine anger → defeat → divine favour → victory) mirrors Baal-cycle theological grammar. Cross (1973) p. 229 notes Kemosh''s Baal-type features. Classified medium: the dependence is typological, not directly attested.',
 'SRC_CROSS_CANAANITE_MYTH', 'PER_TRANSJORDAN_IRON_AGE', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities
WHERE tradition IN ('Moabite','Ammonite','Edomite')
GROUP BY tradition ORDER BY tradition;

SELECT e.canonical_name, COUNT(er.relationship_id) AS rels
FROM entities e
LEFT JOIN entity_relationships er ON (er.subject_entity_id=e.entity_id OR er.object_entity_id=e.entity_id)
WHERE e.entity_id IN ('ENT_MOA_KEMOSH','ENT_MOA_ASHTAR_KEMOSH','ENT_AMM_MILKOM','ENT_EDO_QOS')
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.canonical_name;

SELECT * FROM v_release_metrics;

COMMIT;
