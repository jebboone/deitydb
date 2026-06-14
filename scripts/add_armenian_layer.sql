-- scripts/add_armenian_layer.sql
-- Adds the pre-Christian Armenian pantheon: six deities attested in Khorenatsi
-- and Agathangelos before Armenia's state conversion to Christianity in 301 CE.
-- These deities derive primarily from Iranian/Zoroastrian prototypes but were
-- thoroughly Hellenized in the Artaxiad and Arsacid periods.
--
-- Primary sources:
--   Aramazd / Anahit / Vahagn / Tir / Nane: Agathangelos, History of the
--     Armenians §§14-22; Movses Khorenatsi, History of Armenia II.12-14
--   Vahagn birth hymn: Khorenatsi I.31 (oldest surviving Armenian poem)
--   Astghik: Khorenatsi I.15; Agathangelos §22

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_KHORENATSI_HISTORY',
 'Movses Khorenatsi, History of Armenia (Patmut''iwn Hayots''), 5th c. CE; trans. Robert W. Thomson (Harvard University Press, Cambridge MA, 1978)',
 'primary literary',
 'The fundamental historical and mythological source for pre-Christian Armenian religion. Written in the 5th century CE (though some scholars debate a later 8th-century date for the final composition, the sources used are archaic), it preserves the names and attributes of the principal Armenian deities, the mythology of the Artaxiad royal dynasty, and — crucially — the Vahagn birth hymn (I.31): the oldest surviving Armenian poem, describing Vahagn''s birth from the sea, fire, and sky. Book I covers the mythological period; Book II covers the Armenian kings and their divine patrons. Khorenatsi explicitly names Aramazd as father of the gods, Anahit as his daughter, and Vahagn as dragon-slayer. Thomson''s 1978 Harvard translation is the standard critical English edition.'),
('SRC_AGATHANGELOS_HISTORY',
 'Agathangelos, History of the Armenians (Patmut''iwn Hayots''), 5th c. CE; trans. Robert W. Thomson (State University of New York Press, Albany NY, 1976)',
 'primary literary',
 'Account of the conversion of Armenia to Christianity under King Tiridates III (r. 287-330 CE) and Bishop Gregory the Illuminator. Composed in the 5th century CE but preserving important descriptions of the pre-Christian Armenian cult as it existed immediately before conversion. §§14-22 name the five principal deities (Aramazd, Anahit, Vahagn, Nane, Tir) and their temples, describe their Greek equivalents (Aramazd = Zeus, Anahit = Artemis, Nane = Athena, Tir = Hermes), and record the destruction of the cult statues by Gregory. The most detailed ancient description of the Armenian pantheon from a near-contemporary perspective. Thomson''s 1976 SUNY translation is the standard English edition.'),
('SRC_RUSSELL_ZOR_ARMENIA',
 'James R. Russell, Zoroastrianism in Armenia (Harvard Iranian Series 5; Harvard University Department of Near Eastern Languages and Civilizations, Cambridge MA, 1987)',
 'secondary scholarly',
 'The standard scholarly monograph on the Iranian / Zoroastrian substratum of Armenian religion. Demonstrates that Aramazd derives from Ahura Mazda, Anahit from Anahita, Nane from Nana, and Vahagn from Verethragna via systematic linguistic and theological analysis. Covers the Artaxiad period (189 BCE – 1 CE) when Zoroastrian influence was strongest, the Arsacid dynasty''s Iranian connections, and the survival of Iranian divine names in Armenian personal names and place names. Also covers Mihr (Mithra), Tir (Tishtrya?), Spandaramet (Spenta Armaiti), and the transformation of the Iranian yazata system into the Armenian divine court. Primary secondary citation for all Iranian-derived relationships in this layer.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_ARM_PAGAN',
 'Armenian',
 'Pre-Christian Armenian',
 -500, 301,
 'Period of documented pre-Christian Armenian religious practice, from the earliest traces of the Zoroastrian-derived divine court (c. 500 BCE, corresponding to the Orontid dynasty''s Iranian connections) through Armenia''s formal conversion to Christianity as the state religion in 301 CE under King Tiridates III and Gregory the Illuminator — making Armenia the first nation to adopt Christianity officially. The canonical Armenian pantheon (Aramazd, Anahit, Vahagn, Nane, Tir, Astghik) is primarily attested in two 5th-century CE texts that look back on the pre-Christian period: Agathangelos''s History of the Armenians and Movses Khorenatsi''s History of Armenia. The Artaxiad dynasty (189 BCE – 1 CE) represents the peak of organized cult practice; the Arsacid dynasty (52–428 CE) continued the Iranian religious inheritance until conversion. Russell (1987) is the standard scholarly reference for the Iranian substratum.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
)
VALUES
('ENT_ARM_ARAMAZD',
 'Aramazd',
 'Armenian',
 'supreme deity / sky father',
 'High Deity',
 'sky; creator; father of gods; fertility; rain; thunder',
 'A',
 'Supreme deity of the pre-Christian Armenian pantheon; father of the gods. Name derived directly from Ahura Mazda (Avestan: Ahura Mazdā → Armenian: Aramazd) via regular sound change, establishing the direct Zoroastrian origin. Agathangelos (§22) equates Aramazd with Zeus: "Aramazd, who is called Zeus among the Greeks." Khorenatsi (II.12-14) describes his cult at Ani and Bagaran, where the Artaxiad kings renewed their oaths to him at the new year. His principal temple was at Ashtishat on the Euphrates. Aramazd is the creator of heaven and earth, father of Anahit, Vahagn, and Nane. He is associated with fertility and agricultural abundance — Agathangelos §22 says his cult included prayers for the fertility of the land. Unlike Ahura Mazda, who is primarily a deity of cosmic order (asha), Aramazd in Armenian sources is more prominently a sky-father and genealogical head of the divine family, reflecting Hellenistic influence. Russell (1987) pp. 78-120; Agathangelos §22; Khorenatsi II.12.'),
('ENT_ARM_ANAHIT',
 'Anahit',
 'Armenian',
 'goddess of fertility, love, and war',
 'Fertility Deity',
 'fertility; love; purity; war; water; national sovereignty; the Armenian people',
 'A',
 'The most beloved deity of the Armenian pantheon and the most widely attested. Daughter of Aramazd. Name derived from Zoroastrian Anahita (Avestan: Arədvī Sūrā Anāhitā) via regular sound change. Strabo (Geography XI.14.16) describes her magnificent gold cult statue at the temple at Erez (Ashtishat) — so rich that Roman soldiers melted it for gold after Antony''s campaign in 36 BCE. Agathangelos (§22) equates her with Artemis: "Anahit, who is called Artemis among the Greeks; she is the glory of our nation and vivifier... mother of all chastity, benefactress of the whole human race." Kings of the Artaxiad and Arsacid dynasties used the epithet "Anahit the Golden" (ոսկի Անահիտ). She combines domains that in Zoroastrian theology belong to Anahita (water, fertility, war-victory) with Hellenistic characteristics of Artemis (virginity, hunting) and Aphrodite (love, beauty) — the widest functional range of any Armenian deity. Russell (1987) pp. 121-250; Agathangelos §22; Khorenatsi I.14.'),
('ENT_ARM_VAHAGN',
 'Vahagn',
 'Armenian',
 'war deity / dragon-slayer',
 'War Deity',
 'war; fire; lightning; dragon-slaying; victory; courage; vitality',
 'A',
 'War deity and dragon-slayer of the Armenian pantheon; son of Aramazd. Name derived from Zoroastrian Verethragna (god of victory, smiter of evil, dragon-slayer) via Parthian Wahrāgn. Khorenatsi (I.31) preserves the famous Vahagn birth hymn, the oldest surviving Armenian poem: "In travail were heaven and earth, / In travail, too, the purple sea! / The travail held in the sea the small red reed. / Through the hollow of the reed came forth smoke, / Through the hollow of the reed came forth flame, / And out of the flame ran a youth. / He had hair of fire, he had a beard of flame, / And his eyes were as suns." Agathangelos (§22) equates Vahagn with Heracles at his temple in Ashtishat and credits him with destroying a monster. He is associated with fire, the sun, and the primal vitality of the warrior. In the Artaxiad period his cult was primary at the same Ashtishat complex as Aramazd and Anahit. Russell (1987) pp. 443-500; Khorenatsi I.31; Agathangelos §22.'),
('ENT_ARM_ASTGHIK',
 'Astghik',
 'Armenian',
 'goddess of love and water',
 'Love Deity',
 'love; beauty; water; stars; fertility; night; roses',
 'A',
 'Goddess of love, beauty, and water; companion of Vahagn. The name Astghik means "little star" in Armenian (astgh = star). Khorenatsi (I.15) describes her cult at Ashtishat (literally "city of Ashtart" — the place name derives from Astghik/Ashtart, revealing the Semitic Astarte layer beneath the Iranian-Armenian tradition). Agathangelos (§22) equates her with Aphrodite. Armenian folk tradition preserves the Vardavar festival (originally a water-pouring celebration of Astghik, later Christianized as the Feast of the Transfiguration) in which celebrants pour water on each other and release doves — the dove and rose being Astghik''s symbols. She is the Armenian reception of the widespread Near Eastern love goddess (Ishtar/Inanna → Astarte → Astghik), shaped by the Iranian environment of the Armenian highlands. Russell (1987) pp. 340-380; Khorenatsi I.15; Agathangelos §22.'),
('ENT_ARM_TIR',
 'Tir',
 'Armenian',
 'god of writing, wisdom, and dreams',
 'Wisdom Deity',
 'writing; wisdom; arts; dreams; scribal craft; knowledge; records',
 'A',
 'Deity of writing, wisdom, and the arts; scribe of Aramazd and reader of souls. Agathangelos (§22) explicitly equates Tir with Hermes: "Tir, whom they call the scribe of Aramazd, who is called Hermes by the Greeks and Apollo by others; he who is the interpreter of dreams and the teacher of the arts of writing, who records human deeds." His temple was at Artashat, the Artaxiad capital. Tir''s function as recorder of human deeds and interpreter of dreams reflects Iranian Tishtrya (the star Sirius, deity of rain and fate) and Mesopotamian scribal deities; his identification with Hermes-Mercury reflects the Hellenistic layer. The name Tir may derive from Avestan Tishtrya or from a Parthian intermediary. His dual identification with Hermes and Apollo in Agathangelos reflects the breadth of his scribal-artistic-prophetic domain. Russell (1987) pp. 380-440; Agathangelos §22.'),
('ENT_ARM_NANE',
 'Nane',
 'Armenian',
 'goddess of war and motherhood',
 'War Deity',
 'war; motherhood; wisdom; protection; weaving; divine justice',
 'A',
 'Goddess of war and motherhood; daughter of Aramazd. Agathangelos (§22) explicitly equates Nane with Athena: "Nane, the daughter of Aramazd, who is called Athena among the Greeks; she is the mother of virtues, the teacher of virtue, who bestows wisdom and valor." Her temple was at Tiliē. The name Nane connects with the Mesopotamian mother goddess Nana (Sumerian Nanna; also the name of a minor Zoroastrian deity) and may represent a survival of the pre-Iranian Anatolian divine mother tradition in Armenia. In Agathangelos she is the only female deity besides Anahit, taking the martial-wisdom domain while Anahit holds fertility-love-war. The pairing Aramazd-Anahit-Nane as father and two daughters is a defining feature of the Armenian divine family. Russell (1987) pp. 322-340; Agathangelos §22; Khorenatsi II.12.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
-- Aramazd
('ENT_ARM_ARAMAZD', 'SRC_AGATHANGELOS_HISTORY', 'Primary literary',
 '§22: "They called Aramazd, who is called Zeus among the Greeks, the father of all the gods." Also describes his cult at Ashtishat and the Artaxiad royal oath-renewal ritual at new year.'),
('ENT_ARM_ARAMAZD', 'SRC_KHORENATSI_HISTORY', 'Primary literary',
 'II.12-14: Aramazd''s cult at Ani and Bagaran; the royal dynasty''s patronage of Aramazd; his role as father of Anahit and Vahagn.'),
('ENT_ARM_ARAMAZD', 'SRC_RUSSELL_ZOR_ARMENIA', 'Secondary scholarly',
 'Russell (1987) pp. 78-120: etymology (Ahura Mazda → Aramazd via regular Armenian sound change); the Iranian theological substratum; Aramazd''s transformation from cosmic-order deity to sky-father under Hellenistic influence.'),
-- Anahit
('ENT_ARM_ANAHIT', 'SRC_AGATHANGELOS_HISTORY', 'Primary literary',
 '§22: "Anahit, who is called Artemis among the Greeks; she is the glory of our nation and vivifier... mother of all chastity, benefactress of the whole human race." Describes cult statue and its destruction by Gregory the Illuminator.'),
('ENT_ARM_ANAHIT', 'SRC_KHORENATSI_HISTORY', 'Primary literary',
 'I.14 and II.12: Anahit as daughter of Aramazd; her golden statue at Erez/Ashtishat; the Armenian royal cult; the epithet "Anahit the Golden."'),
('ENT_ARM_ANAHIT', 'SRC_RUSSELL_ZOR_ARMENIA', 'Secondary scholarly',
 'Russell (1987) pp. 121-250: the most extensive treatment; Anahit as Armenian transformation of Zoroastrian Anahita; the shift from water-purity deity to the broadest functional deity in the Armenian pantheon; Strabo Geography XI.14.16 on the Erez temple and statue.'),
-- Vahagn
('ENT_ARM_VAHAGN', 'SRC_KHORENATSI_HISTORY', 'Primary literary',
 'I.31: the Vahagn birth hymn, the oldest surviving Armenian poem — preserving archaic oral material about his birth from the primal elements (sea, fire, sky). II.12: his temple at Ashtishat alongside Aramazd and Anahit.'),
('ENT_ARM_VAHAGN', 'SRC_AGATHANGELOS_HISTORY', 'Primary literary',
 '§22: "Vahagn, who is called Heracles among the Greeks" — explicitly equates Vahagn with Heracles at the Ashtishat temple; notes his role as destroyer of monsters.'),
('ENT_ARM_VAHAGN', 'SRC_RUSSELL_ZOR_ARMENIA', 'Secondary scholarly',
 'Russell (1987) pp. 443-500: Vahagn as Armenian reception of Zoroastrian Verethragna (god of victory, dragon-slayer) via Parthian Wahrāgn; the fire imagery of the birth hymn; the Heracles equation in the Hellenistic period.'),
-- Astghik
('ENT_ARM_ASTGHIK', 'SRC_AGATHANGELOS_HISTORY', 'Primary literary',
 '§22: Astghik explicitly equated with Aphrodite; the goddess of love at the Ashtishat cult complex.'),
('ENT_ARM_ASTGHIK', 'SRC_KHORENATSI_HISTORY', 'Primary literary',
 'I.15: the Vardavar festival of Astghik; the meaning of the place name Ashtishat ("city of Ashtart") revealing the Semitic layer.'),
('ENT_ARM_ASTGHIK', 'SRC_RUSSELL_ZOR_ARMENIA', 'Secondary scholarly',
 'Russell (1987) pp. 340-380: Astghik as convergence of Semitic Astarte and Iranian traditions in Armenian highlands; the Vardavar festival as survival; the star symbolism.'),
-- Tir
('ENT_ARM_TIR', 'SRC_AGATHANGELOS_HISTORY', 'Primary literary',
 '§22: "Tir, whom they call the scribe of Aramazd, who is called Hermes by the Greeks and Apollo by others; he who is the interpreter of dreams and the teacher of the arts of writing, who records human deeds." Temple at Artashat. Most detailed ancient description of Tir.'),
('ENT_ARM_TIR', 'SRC_KHORENATSI_HISTORY', 'Primary literary',
 'II.12: Tir at Artashat; his role as recorder and interpreter.'),
('ENT_ARM_TIR', 'SRC_RUSSELL_ZOR_ARMENIA', 'Secondary scholarly',
 'Russell (1987) pp. 380-440: Tir''s etymology and function; the possible connection to Avestan Tishtrya (star Sirius); the Hermes and Apollo equations; scribal deity traditions.'),
-- Nane
('ENT_ARM_NANE', 'SRC_AGATHANGELOS_HISTORY', 'Primary literary',
 '§22: "Nane, the daughter of Aramazd, who is called Athena among the Greeks; she is the mother of virtues, the teacher of virtue." Temple at Tiliē.'),
('ENT_ARM_NANE', 'SRC_KHORENATSI_HISTORY', 'Primary literary',
 'II.12: Nane as daughter of Aramazd; her place in the Armenian divine family alongside Anahit.'),
('ENT_ARM_NANE', 'SRC_RUSSELL_ZOR_ARMENIA', 'Secondary scholarly',
 'Russell (1987) pp. 322-340: Nane and the Mesopotamian Nana tradition; the Iranian connection; her war-wisdom domain as complement to Anahit''s fertility-love domain.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_ARM_ARAMAZD',  'PER_ARM_PAGAN', 'high',
 'Attested in Agathangelos and Khorenatsi as the supreme deity of the Armenian pantheon through the Artaxiad and Arsacid periods until conversion in 301 CE; cult at Ani, Bagaran, and Ashtishat.',
 'SRC_AGATHANGELOS_HISTORY', 'reviewed'),
('ENT_ARM_ANAHIT',   'PER_ARM_PAGAN', 'high',
 'The most widely attested Armenian deity; cult at Erez/Ashtishat described by Strabo and Agathangelos; golden statue melted by Roman soldiers in 36 BCE; royal epithet "Anahit the Golden" used by Artaxiad kings.',
 'SRC_AGATHANGELOS_HISTORY', 'reviewed'),
('ENT_ARM_VAHAGN',   'PER_ARM_PAGAN', 'high',
 'Vahagn birth hymn (Khorenatsi I.31) preserves archaic oral tradition; cult at Ashtishat attested by Khorenatsi and Agathangelos; present throughout the pre-Christian period.',
 'SRC_KHORENATSI_HISTORY', 'reviewed'),
('ENT_ARM_ASTGHIK',  'PER_ARM_PAGAN', 'high',
 'Cult at Ashtishat attested in Khorenatsi I.15; the Vardavar festival survived into the Christian period, confirming deep pre-Christian roots. Agathangelos §22 on the Aphrodite equation.',
 'SRC_AGATHANGELOS_HISTORY', 'reviewed'),
('ENT_ARM_TIR',      'PER_ARM_PAGAN', 'high',
 'Temple at Artashat; Agathangelos §22 provides the most detailed description. Present throughout the Artaxiad-Arsacid cult period.',
 'SRC_AGATHANGELOS_HISTORY', 'reviewed'),
('ENT_ARM_NANE',     'PER_ARM_PAGAN', 'high',
 'Temple at Tiliē; Agathangelos §22 explicitly names her as daughter of Aramazd and equates with Athena. Present throughout the Artaxiad-Arsacid cult period.',
 'SRC_AGATHANGELOS_HISTORY', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
-- Aramazd
('ENT_ARM_ARAMAZD', 'reception_of', 'ENT_ZOR_AHURA_MAZDA',
 'high',
 'Aramazd is the direct Armenian reception of Ahura Mazda; the name derives by regular Armenian sound change (Avestan Ahura Mazdā → Middle Iranian Ohrmazd → Armenian Aramazd). Both are supreme deities, creators of heaven and earth, and heads of the divine order. Russell (1987) pp. 78-120 establishes this derivation as the most linguistically and theologically secure connection in Armenian religious history.',
 'SRC_RUSSELL_ZOR_ARMENIA', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ARAMAZD', 'syncretized_with', 'ENT_ZEUS',
 'high',
 'Agathangelos §22 explicitly equates Aramazd with Zeus: "Aramazd, who is called Zeus among the Greeks, the father of all the gods." The equation reflects both functional similarity (supreme sky-father) and Hellenistic-period interpretatio Graeca applied to the Armenian court during the Artaxiad dynasty (189 BCE – 1 CE). Agathangelos History §22.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ARAMAZD', 'parent_of', 'ENT_ARM_ANAHIT',
 'high',
 'Agathangelos §22 and Khorenatsi II.12 both identify Anahit as the daughter of Aramazd. This is one of the defining structural features of the Armenian divine family.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ARAMAZD', 'parent_of', 'ENT_ARM_VAHAGN',
 'high',
 'Khorenatsi II.12 identifies Vahagn as the son of Aramazd, placing him in the divine family alongside Anahit and Nane.',
 'SRC_KHORENATSI_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ARAMAZD', 'parent_of', 'ENT_ARM_NANE',
 'high',
 'Agathangelos §22 explicitly identifies Nane as "the daughter of Aramazd." The pairing of Aramazd as father with Anahit and Nane as his daughters is a defining feature of the Armenian pantheon.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
-- Anahit
('ENT_ARM_ANAHIT', 'reception_of', 'ENT_ZOR_ANAHITA',
 'high',
 'Anahit is the Armenian reception of Zoroastrian Anahita (Avestan: Arədvī Sūrā Anāhitā — "the Moist, Strong, Immaculate"). Name derivation is regular and secure. Both are water, fertility, and war-victory deities; both receive royal patronage. Russell (1987) pp. 121-250 provides the definitive analysis. The transformation from Anahita to Anahit involved absorption of Hellenistic Artemis characteristics (virginity, hunting) and greater prominence as national deity.',
 'SRC_RUSSELL_ZOR_ARMENIA', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ANAHIT', 'syncretized_with', 'ENT_ARTEMIS',
 'high',
 'Agathangelos §22 explicitly equates Anahit with Artemis. Strabo (Geography XI.14.16) describes her temple at Erez and cult statue in terms consistent with an Artemis-type deity. The equation is ancient, consistent across multiple sources, and reflects functional overlap in hunting, virginity, and divine protection. The most securely attested Greek equation for any Armenian deity.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ANAHIT', 'syncretized_with', 'ENT_APHRODITE',
 'medium',
 'Some ancient sources (and Khorenatsi''s description of her fertility and love domains) support a secondary equation with Aphrodite alongside the primary Artemis equation. Anahit''s fertility and love domains overlap with Aphrodite''s function; Agathangelos''s description of her as "mother of all chastity" and "benefactress of the human race" spans both divine profiles. Russell (1987) pp. 180-200 notes the dual Greek reception. Confidence medium: Artemis equation is primary.',
 'SRC_RUSSELL_ZOR_ARMENIA', 'PER_ARM_PAGAN', 'reviewed'),
-- Vahagn
('ENT_ARM_VAHAGN', 'syncretized_with', 'ENT_HERACLES',
 'high',
 'Agathangelos §22 explicitly equates Vahagn with Heracles at his Ashtishat temple: "Vahagn, who is called Heracles among the Greeks." The equation reflects shared dragon-slaying/monster-fighting function, exceptional strength, and the paradigmatic warrior role. Khorenatsi I.31 (the birth hymn) presents Vahagn''s primal fire-birth as a hero of cosmic scope, consistent with the Heracles equation.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_VAHAGN', 'aligned_with', 'ENT_ARES',
 'medium',
 'In addition to the Heracles equation, Vahagn''s war deity function aligns him with Ares as the deity who gives victory in battle. Some Armenian scholars note that Vahagn''s role as son of Aramazd/Zeus parallels Ares as son of Zeus. The primary Greek equation is Heracles; Ares represents the war-deity aspect. Russell (1987) pp. 470-500.',
 'SRC_RUSSELL_ZOR_ARMENIA', 'PER_ARM_PAGAN', 'reviewed'),
-- Astghik
('ENT_ARM_ASTGHIK', 'syncretized_with', 'ENT_APHRODITE',
 'high',
 'Agathangelos §22 explicitly equates Astghik with Aphrodite. Khorenatsi I.15 describes her Vardavar festival — a water-pouring and dove-releasing celebration — features directly parallel to Aphrodite''s cult symbols (dove, water, love). The Ashtishat place name ("city of Ashtart") reveals the deeper Semitic Astarte layer that underlies the Armenian Aphrodite equation.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_ASTGHIK', 'paired_with', 'ENT_ARM_VAHAGN',
 'medium',
 'Armenian tradition pairs Astghik with Vahagn as the goddess of love with the warrior deity, parallel to Aphrodite-Ares pairings in Greek mythology. Khorenatsi I.15 situates Astghik''s cult at the same Ashtishat complex as Vahagn. The pairing is consistently attested in Armenian folk tradition and the festival calendar. Russell (1987) pp. 355-360. Confidence medium: the pairing is traditional but less explicitly stated than the Aphrodite equation.',
 'SRC_KHORENATSI_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
-- Tir
('ENT_ARM_TIR', 'syncretized_with', 'ENT_HERMES',
 'high',
 'Agathangelos §22 explicitly equates Tir with Hermes: "Tir, who is called Hermes by the Greeks... the scribe of Aramazd, interpreter of dreams and teacher of the arts of writing." The equation reflects shared domains: writing, commerce, messenger/scribe function, psychopomp role (recording souls'' deeds), and divine interpreter. The most explicit deity-to-deity equation in Agathangelos after Aramazd=Zeus.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
('ENT_ARM_TIR', 'syncretized_with', 'ENT_APOLLO',
 'medium',
 'Agathangelos §22 names Apollo alongside Hermes as a Greek equivalent of Tir: "who is called Hermes by the Greeks and Apollo by others." The Apollo equation reflects Tir''s arts, divination, and prophecy domains. Confidence medium: Hermes is the primary equation; Apollo is secondary and reflects the prophetic-artistic aspect only.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed'),
-- Nane
('ENT_ARM_NANE', 'syncretized_with', 'ENT_ATHENA',
 'high',
 'Agathangelos §22 explicitly equates Nane with Athena: "Nane, the daughter of Aramazd, who is called Athena among the Greeks; she is the mother of virtues, the teacher of virtue, who bestows wisdom and valor." The equation is explicit, ancient, and reflects functional overlap in war, wisdom, and protection. The most unambiguous Athena equation in any Near Eastern tradition.',
 'SRC_AGATHANGELOS_HISTORY', 'PER_ARM_PAGAN', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT tradition, COUNT(*) AS entities
FROM entities
WHERE tradition = 'Armenian'
GROUP BY tradition;

SELECT e.canonical_name, COUNT(er.relationship_id) AS rels
FROM entities e
LEFT JOIN entity_relationships er
  ON (er.subject_entity_id = e.entity_id OR er.object_entity_id = e.entity_id)
WHERE e.entity_id IN (
  'ENT_ARM_ARAMAZD','ENT_ARM_ANAHIT','ENT_ARM_VAHAGN',
  'ENT_ARM_ASTGHIK','ENT_ARM_TIR','ENT_ARM_NANE'
)
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.canonical_name;

SELECT * FROM v_release_metrics;

COMMIT;
