-- scripts/add_aramean_layer.sql
-- Adds the Aramean/Iron Age Syrian pantheon: three deities of the Aramean
-- states (c. 1100–732 BCE) and their continuations into the Palmyrene and
-- Syrian Hellenistic periods (through 3rd c. CE).
--
-- The Aramean tradition bridges the Canaanite/Ugaritic Bronze Age religious
-- world and the later Semitic Hellenistic traditions. Atargatis (the "Syrian
-- Goddess") is the most influential Aramean export, carried across the
-- Hellenistic world to Delos, Athens, and Rome. Baalshamin ("Lord of Heaven")
-- is the most persistently attested pan-Semitic sky deity. Hadad of Damascus
-- is the storm deity of the principal Aramean kingdom.
--
-- Primary sources: Lucian De Dea Syria (c. 150 CE), Palmyrene inscriptions,
-- Zakkur stele, Tel Dan stele.
-- Secondary: Lipiński (2000), Kaizer (2002).

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_LUCIAN_DEA_SYRIA',
 'Lucian of Samosata, De Dea Syria (On the Syrian Goddess), c. 150 CE; ed. and trans. Harold W. Attridge and Robert A. Oden Jr. (SBL Texts and Translations 9, Graeco-Roman Religion 1; Scholars Press / Society of Biblical Literature, Missoula, 1976)',
 'primary text',
 'The most detailed ancient description of the cult of Atargatis at Hierapolis-Bambyce (modern Manbij, northern Syria). Written c. 150 CE by Lucian of Samosata (himself from nearby Samosata on the Euphrates) in mock-Herodotean style, De Dea Syria describes the great temple complex, its sacred fish-pools and sacred animals, the castrated galli priests and their self-mutilation in honor of the goddess, the annual pilgrimage festival, the sacred prostitution traditions, the mythological narratives (including traditions linking the cult foundation to Semiramis, Deucalion, and Dionysus), and the iconographic program of the temple. Lucian explicitly opens by noting that the Syrians call her "Hera" (i.e. equate her with the Greek Hera as queen of heaven) but that she also encompasses Athena, Aphrodite, Selene, Rhea, Artemis, Nemesis, and the Fates — a panthea (all-goddess) reading of the Syrian Goddess. De Dea Syria is the primary literary source for Atargatis and provides crucial evidence for the nature of Syrian religion in the Roman period. Cited for ENT_ARA_ATARGATIS.'),
('SRC_LIPINSKI_ARAMEANS',
 'Edward Lipiński, The Aramaeans: Their Ancient History, Culture, Religion (Orientalia Lovaniensia Analecta 100; Peeters, Leuven, 2000)',
 'secondary scholarly',
 'The comprehensive scholarly reference on Aramean history, culture, and religion covering the period from the emergence of the Arameans in the late Bronze Age collapse (c. 1200 BCE) through the Hellenistic and Roman periods. Chapter 22 ("The Religion of the Aramaeans") surveys the Aramean pantheon systematically: Hadad as the chief storm deity of Damascus (attested in the Zakkur stele, c. 800 BCE; the Tel Dan stele of Hazael, c. 840 BCE; the Ben-Hadad stele; and Assyrian records of the Damascene kingdom); Baalshamin ("Lord of Heaven") as the pan-Semitic sky deity attested across Syria, Phoenicia, and Arabia in Iron Age and Hellenistic inscriptions; Atargatis as the Aramean form of the great goddess tradition. Lipiński provides the epigraphic corpus for Aramean divine names, analyses the inscriptions from Zinjirli (Sam''al), Hamath, and Arpad, and covers the Palmyrene continuation of Aramean religious traditions. Primary scholarly citation for all three Aramean entities.'),
('SRC_KAIZER_PALMYRA',
 'Ted Kaizer, The Religious Life of Palmyra: A Study of the Social Patterns of Worship in the Roman Period (Oriens et Occidens 4; Franz Steiner Verlag, Stuttgart, 2002)',
 'secondary scholarly',
 'Comprehensive study of religious practice in Palmyra (ancient Tadmor, modern Syria) during the Roman period (1st–3rd centuries CE), based on the rich Palmyrene inscriptional corpus (200+ religious texts in Aramaic and Greek), the sculptural and numismatic evidence, and the temple programs. Chapter 3 covers Baalshamin, who had one of Palmyra''s major temple complexes (the Baalshamin temple, built 131 CE, well-preserved until its destruction by ISIL in 2015); Chapter 4 covers Bel and the triadic grouping; Chapter 9 covers the full range of divine beings in the Palmyrene tradition. Kaizer analyzes Baalshamin''s relationship with Zeus in the Greek-Palmyrene bilingual inscriptions (many of which render Baalshamin simply as "Zeus"), the festival calendar, and the social organization of the priestly colleges. Cited primarily for ENT_ARA_BAALSHAMIN and secondarily for the Aramean/Palmyrene context of all three entities.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_ARA_IRON_AGE',
 'Aramean',
 'Aramean and Syrian Hellenistic Religion',
 -1100, 650,
 'The period spanning the emergence of the Aramean states in the Iron Age (c. 1100 BCE) through their Hellenistic and Roman-period continuations, ending with the Islamic conquest of Syria (636–638 CE). The Aramean states of the Iron Age — most importantly Damascus (Aram-Damascus), Arpad, Hamath, Sam''al/Zinjirli, and Carchemish — were the major political powers of northern Syria from the 10th to 8th centuries BCE, in constant competition with the Neo-Assyrian Empire (which eventually absorbed them: Damascus fell to Tiglath-Pileser III in 732 BCE). Their religion preserved continuities with the Canaanite/Ugaritic Bronze Age tradition (Hadad as storm deity = Canaanite Baal, Astarte → Atargatis) while developing distinctive Aramean forms and new cult centers. The Aramean language (a Semitic language closely related to Hebrew and Phoenician) became the lingua franca of the Near East under the Neo-Assyrian and Achaemenid empires, spreading Aramean religious forms widely. The Hellenistic period (after Alexander''s conquest, 332 BCE) saw the major Aramean cults — especially Atargatis at Hierapolis-Bambyce — acquire international prestige across the Mediterranean world. Palmyra (a major Aramaic-speaking city on the Syrian desert caravan route) continued Aramean religious traditions through the 3rd century CE. The Islamic conquest of Syria ends the period; some cult traditions (veneration of Baalshamin as "Lord of Heaven" under various names) had already been absorbed into local Christian practice. Lipiński (2000) and Kaizer (2002) are the principal references.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_ARA_ATARGATIS',
 'Atargatis',
 'Aramean',
 'great Syrian goddess / fish goddess',
 'Love Deity',
 'love; fertility; sovereignty; sea and fish; divine queenship; war; prophecy',
 'A',
 'Atargatis ("the Syrian Goddess," Greek Dea Syria; Aramaic Atar-ata or ʿAtar-ʿAte) is the most influential Aramean deity in the broader Mediterranean world and the principal goddess of the Syrian religious tradition. Her main cult center was the great temple complex at Hierapolis-Bambyce (modern Manbij, northern Syria), which Lucian of Samosata describes in detail in De Dea Syria (c. 150 CE): a monumental temple with sacred fish-pools where fish were never caught but fed by hand, sacred doves, a golden statue of Atargatis enthroned between lions (her cult animal), surrounded by divine effigies of other deities, and served by hundreds of priests including the castrated galli who performed ecstatic self-mutilation at festivals. Her theonym is a compressed form of two divine names: Atar (= Aramaic form of Astarte, the Semitic love/war goddess) + Ata/Ate (= possibly "Anat," the Ugaritic war goddess, making Atargatis a fusion of both female divine powers). She is a "panthea" — a many-in-one all-goddess who encompasses love, fertility, sovereignty, war, and prophecy in a single figure. Her cult spread dramatically across the Hellenistic world through Syrian merchant communities: major temples on Delos (the Atargateion, 2nd c. BCE), in Athens, and in Rome (the Galli priests''s festivals were observed in Rome). She is typically depicted enthroned, wearing a turreted crown and holding a scepter, with lions flanking her throne and fish at her feet. Lucian De Dea Syria (§§1-60) is the fullest primary source; Lipiński (2000) pp. 589-610.'),
('ENT_ARA_BAALSHAMIN',
 'Baalshamin',
 'Aramean',
 'Lord of Heaven / sky and storm deity',
 'High Deity',
 'sky; storm; rain; cosmic sovereignty; divine protection; weather',
 'A',
 'Baalshamin ("Lord of Heaven," Aramaic Baʿal-šamayim; Greek Zeus Baalshamin) is one of the most widely attested deities of the ancient Semitic world and the dominant sky deity of the Aramean and Palmyrene traditions. As "Lord of Heaven" he presides over the cosmic sky, rain, and storm functions, and his name became nearly a theological title for the supreme divine sovereign of the heavens across Aramaic-speaking communities from Phoenicia to Arabia. His earliest significant attestation is the Aramaic inscription of Zakkur, King of Hamath (c. 800 BCE), in which Baalshamin promises victory to Zakkur over the coalition of kings besieging him — structurally parallel to Khaldi''s role in Urartian royal ideology. He had a major sanctuary at Si'' (in the Hauran region of southern Syria, extensive Nabataean inscriptions) and one of the two principal temples at Palmyra (the Baalshamin temple, dedicated 131 CE, well-preserved until its destruction by ISIL in August 2015). Greek-Palmyrene bilingual inscriptions consistently render "Baalshamin" as "Zeus," confirming the ancient interpretatio graeca. In the Book of Daniel (2nd c. BCE), "Baal Shamayim" ("Lord of the Heavens") is used as an ironic term for the Seleucid deity Olympian Zeus installed in the Jerusalem Temple — the "abomination of desolation" (Daniel 9:27, 11:31), preserving the Aramaic theonym in a polemical Jewish source. Lipiński (2000) pp. 577-588; Kaizer (2002) pp. 60-85.'),
('ENT_ARA_HADAD_DAMASCUS',
 'Hadad of Damascus',
 'Aramean',
 'storm deity / national god of Aram-Damascus',
 'Thunder Deity',
 'storm; thunder; rain; royal victory; national sovereignty; war',
 'A',
 'Hadad of Damascus (Aramaic Hadad, "thunderer"; theonym related to Ugaritic Haddu/Hadad, the proper name of Canaanite Baal) is the chief deity of Aram-Damascus, the most powerful of the Iron Age Aramean kingdoms (capital at Damascus, modern Syrian capital; the kingdom dominated Syria from c. 900 to 732 BCE). He is the Aramean national storm deity, directly continuous with the Canaanite Baal Hadad tradition but now serving as the divine patron of the Aramean state rather than the Canaanite city-states of the Bronze Age. His attestations include: the Aramaic Zakkur stele (c. 800 BCE, which invokes Baalshamin alongside Hadad''s successors), the Melqart stele from Aleppo (c. 870 BCE, dedicated by Ben-Hadad of Damascus, naming Hadad and Melqart), the Tel Dan stele (c. 840 BCE, recording a victory of Hazael of Damascus citing divine favor), and repeated Old Testament references to the kings of Damascus bearing the divine name: Ben-Hadad I, II, III ("son of Hadad"), Hazael (whose name may invoke Hadad), and Hadadezer ("Hadad is my helper," 2 Samuel 8:3). The name "Hadad-Rimmon" in Zechariah 12:11 and the Assyrian practice of deporting the cult statue of "Hadad of Damascus" after the conquest of 732 BCE (Tiglath-Pileser III''s annals) both confirm his central status. Lipiński (2000) pp. 567-577.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_ARA_ATARGATIS', 'SRC_LUCIAN_DEA_SYRIA', 'Primary literary text',
 'Lucian, De Dea Syria §§1-60: complete description of the Hierapolis sanctuary — architecture, sacred fish-pools, galli priests, festival calendar, divine iconography, mythological traditions of the cult foundation. Primary literary source for Atargatis''s functions, iconography, and cult practice.'),
('ENT_ARA_ATARGATIS', 'SRC_LIPINSKI_ARAMEANS', 'Secondary scholarly',
 'Lipiński (2000) pp. 589-610: Atargatis in the Aramean epigraphic corpus; theonym analysis (Atar + Ata/Anat etymology); Aramaic inscriptions from Hierapolis and Dura-Europos; Hellenistic spread through Syrian merchant communities; Delos Atargateion (2nd c. BCE).'),
('ENT_ARA_BAALSHAMIN', 'SRC_LIPINSKI_ARAMEANS', 'Primary epigraphic / secondary scholarly',
 'Lipiński (2000) pp. 577-588: Baalshamin in the Aramean inscriptional corpus — Zakkur stele (c. 800 BCE), Si'' sanctuary inscriptions, distribution across Syria-Palestine and Arabia; "Lord of Heaven" as theological title; theonym etymology.'),
('ENT_ARA_BAALSHAMIN', 'SRC_KAIZER_PALMYRA', 'Primary epigraphic (Palmyrene) / secondary scholarly',
 'Kaizer (2002) pp. 60-85: Baalshamin at Palmyra — the Baalshamin temple (dedicated 131 CE); Palmyrene Aramaic and Greek bilingual inscriptions equating Baalshamin with Zeus; festival calendar; priestly organization; Daniel 11:31 (the "abomination of desolation" = Zeus/Baalshamin equation).'),
('ENT_ARA_HADAD_DAMASCUS', 'SRC_LIPINSKI_ARAMEANS', 'Primary epigraphic (Aramaic) / secondary scholarly',
 'Lipiński (2000) pp. 567-577: Hadad of Damascus — Melqart stele from Aleppo (c. 870 BCE), Zakkur stele (c. 800 BCE), Tel Dan stele (c. 840 BCE); Old Testament Ben-Hadad / Hadadezer / Hadad-Rimmon references; Tiglath-Pileser III''s annals on the deportation of the Damascus Hadad cult statue (732 BCE).')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ARA_ATARGATIS',      'PER_ARA_IRON_AGE', 'high',
 'Atargatis is attested in Aramaic inscriptions from the Hellenistic period onward and described in detail by Lucian c. 150 CE; cult at Hierapolis persisted through late antiquity.',
 'SRC_LUCIAN_DEA_SYRIA', 'reviewed'),
('ENT_ARA_BAALSHAMIN',     'PER_ARA_IRON_AGE', 'high',
 'Attested from the Zakkur stele (c. 800 BCE) through the Palmyrene temple (131 CE) and into late antiquity; one of the longest-attested Semitic theonyms.',
 'SRC_LIPINSKI_ARAMEANS', 'reviewed'),
('ENT_ARA_HADAD_DAMASCUS', 'PER_ARA_IRON_AGE', 'high',
 'Ben-Hadad royal names and the Melqart stele place Hadad of Damascus in the 9th–8th centuries BCE; Tiglath-Pileser III''s deportation of his cult statue in 732 BCE is the terminus ante quem for the main Aramean state cult.',
 'SRC_LIPINSKI_ARAMEANS', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Atargatis
('ENT_ARA_ATARGATIS', 'reception_of', 'ENT_CAN_ASTARTE',
 'high',
 'Atargatis is the Aramean reception of the West Semitic love/war goddess whose canonical Canaanite/Phoenician form is Astarte (Ashtart). The first element of Atargatis''s theonym — Atar — is the Aramaic form of Ashtart/Astarte, making the etymology itself the evidence for the reception. The goddess retains Astarte''s core domains (love, fertility, sovereignty) while incorporating additional aspects (sacred fish, prophetic oracles, the galli cult) that develop distinctively in the Syrian Aramean context. The spread of the Atargatis cult across the Hellenistic world replicates the earlier spread of Astarte through Phoenician trade routes. Lipiński (2000) pp. 589-592.',
 'SRC_LIPINSKI_ARAMEANS', 'PER_ARA_IRON_AGE', 'reviewed'),
('ENT_ARA_ATARGATIS', 'syncretized_with', 'ENT_APHRODITE',
 'high',
 'Atargatis was routinely identified with Aphrodite in the Hellenistic world. Lucian opens De Dea Syria by explicitly listing the Syrians'' identification of "the goddess" with Aphrodite among other Greek identifications. The Delos Atargateion (2nd c. BCE) contains dedications to Atargatis and Aphrodite in both separate and combined forms. Coins from Hierapolis and Palmyra depict Atargatis in iconographic modes borrowed from Aphrodite. This is one of the most extensively documented Greek-Oriental deity syncretisms of the Hellenistic period. Lipiński (2000) p. 598; Lucian §32.',
 'SRC_LUCIAN_DEA_SYRIA', 'PER_ARA_IRON_AGE', 'reviewed'),
('ENT_ARA_ATARGATIS', 'aligned_with', 'ENT_MES_INANNA_ISHTAR',
 'medium',
 'Atargatis and Inanna/Ishtar are parallel expressions of the Semitic great goddess tradition: both encompass love, fertility, war, sovereignty, and prophecy in a single divine figure; both have lion iconography (the lion throne); both have sacred prostitution traditions associated with their cults; and both are the supreme female divine powers of their respective traditions. The alignment is typological and structural — representing different regional expressions of the ancient Near Eastern great goddess — rather than a direct historical reception. Lipiński (2000) p. 600.',
 'SRC_LIPINSKI_ARAMEANS', 'PER_ARA_IRON_AGE', 'reviewed'),
-- Baalshamin
('ENT_ARA_BAALSHAMIN', 'patron_of', 'ENT_STORM',
 'high',
 'Baalshamin is explicitly the deity of the heavens and weather — rain, storm, and cosmic sovereignty over the sky. As "Lord of Heaven" his storm/rain patronage is his primary inscriptional function: the Zakkur stele (c. 800 BCE) shows him intervening in a military crisis through prophetic oracles, but his core domain is the sky and its weather functions. The storm-deity role is consistently attested across Aramean and Palmyrene sources. Lipiński (2000) pp. 577-580; Kaizer (2002) p. 62.',
 'SRC_LIPINSKI_ARAMEANS', 'PER_ARA_IRON_AGE', 'reviewed'),
('ENT_ARA_BAALSHAMIN', 'aligned_with', 'ENT_ZEUS',
 'high',
 'Greek-Palmyrene bilingual inscriptions consistently render "Baalshamin" as "Zeus" — the most thoroughly documented interpretatio graeca in the Aramean/Syrian tradition. The Palmyrene Baalshamin temple dedicatory inscriptions (from the 1st–3rd centuries CE) use "Zeus" as the Greek equivalent in every bilingual text recovered. The author of 2 Maccabees (2nd c. BCE) identifies the deity installed by Antiochus IV in the Jerusalem Temple as "Zeus Olympios" while 1 Maccabees uses "Baal Shamayim" — the two books are describing the same event with Greek and Aramaic divine names respectively. The Zeus-Baalshamin equation is one of the best-attested divine equivalences in the ancient world. Kaizer (2002) pp. 60-65.',
 'SRC_KAIZER_PALMYRA', 'PER_ARA_IRON_AGE', 'reviewed'),
('ENT_ARA_BAALSHAMIN', 'aligned_with', 'ENT_CAN_BAAL',
 'medium',
 'Baalshamin ("Lord of Heaven") and Baal Hadad ("Lord/Storm") are related but distinct deities in the Semitic tradition. Both are Baal-titles applied to sky/storm deities, but Baalshamin emphasizes the heavenly-sovereignty aspect while Baal Hadad emphasizes the storm-violence aspect. The distinction is made in Iron Age inscriptions (e.g., the Panamuwa inscription from Sam''al/Zinjirli invokes both Hadad and Baalshamin as distinct deities in the same text), demonstrating they were not simply identical. Confidence medium: the relationship is theological (two Baal-figures in the same tradition) rather than identity or explicit equation. Lipiński (2000) p. 583.',
 'SRC_LIPINSKI_ARAMEANS', 'PER_ARA_IRON_AGE', 'reviewed'),
-- Hadad of Damascus
('ENT_ARA_HADAD_DAMASCUS', 'reception_of', 'ENT_CAN_BAAL',
 'high',
 'Aramean Hadad of Damascus is the direct continuation of the Canaanite Baal Hadad tradition — the same deity name (Hadad is the proper name of Canaanite Baal) carried forward into the Iron Age Aramean states. The theonym Hadad (Aramaic hdd, "thunderer") directly corresponds to Ugaritic Haddu, the personal name of Baal. The transition from Bronze Age Canaanite cult to Iron Age Aramean state cult represents a reception: the same storm deity, reorganized as the national patron of the Aramean kingdom of Damascus, receiving royal inscriptions and military victory dedications in Aramaic rather than Ugaritic. Lipiński (2000) pp. 567-569.',
 'SRC_LIPINSKI_ARAMEANS', 'PER_ARA_IRON_AGE', 'reviewed'),
('ENT_ARA_HADAD_DAMASCUS', 'patron_of', 'ENT_STORM',
 'high',
 'Hadad of Damascus is explicitly the storm deity of the Aramean kingdom — the Aramaic name "Hadad" means "thunderer," and his function in inscriptions and the OT accounts of the Damascene kings is consistently as the storm god who gives rain and grants military victory. The Melqart stele inscription invokes Hadad''s divine favor; the royal epithets Ben-Hadad ("son of Hadad") and Hadadezer ("Hadad is my help") confirm his storm-patronage as the basis of royal legitimacy. Lipiński (2000) pp. 570-572.',
 'SRC_LIPINSKI_ARAMEANS', 'PER_ARA_IRON_AGE', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities WHERE tradition = 'Aramean'
GROUP BY tradition;

SELECT * FROM v_release_metrics;

COMMIT;
