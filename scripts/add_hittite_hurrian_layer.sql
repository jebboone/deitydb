-- scripts/add_hittite_hurrian_layer.sql
-- Hittite/Hurrian tradition: the load-bearing bridge between Mesopotamian and Greek
--
-- The Kumarbi cycle (Hurrian, preserved in Hittite cuneiform at Hattusa, c. 1400-1200 BCE)
-- is the most directly documented transmission pathway from Mesopotamian cosmology to
-- Hesiod's Theogony. M.L. West (The East Face of Helicon, 1997) argues exhaustively
-- that the Greek Succession Myth (Ouranos castrated by Kronos, Zeus defeating Kronos/Titans)
-- derives from this Hurrian tradition, not from Mesopotamia directly.
--
-- Two traditions housed together:
--   (a) Hurrian: Kumarbi cycle, Shaushka = Ishtar (attested in Hittite empire texts)
--   (b) Hittite (native): Illuyanka serpent myth, Tarhunna storm god, Sun Goddess of Arinna
--
-- New Greek entities created here as targets for Hittite→Greek chains:
--   ENT_KRONOS, ENT_TYPHON (ENT_OURANOS is created in add_mesopotamian_greek_parallels.sql)
--
-- Sources: SRC_HOFFNER_HITTITE_MYTHS, SRC_WEST_EAST_HELICON

BEGIN;

-- ── 1. New period ───────────────────────────────────────────────────────────

INSERT INTO periods (period_id, period_name, tradition, start_year, end_year)
VALUES ('PER_HTT_EMPIRE', 'Hittite Empire Period', 'Hittite', -1650, -1180)
ON CONFLICT (period_id) DO NOTHING;

-- ── 2. New sources ──────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_HOFFNER_HITTITE_MYTHS',
   'Harry A. Hoffner Jr., Hittite Myths, 2nd ed. (Society of Biblical Literature, 1998)',
   NULL,
   'primary text translation',
   'Standard English translation of the Hittite mythological corpus including the Song of Kumarbi (succession myth), Song of Ullikummi, Illuyanka myth, and other Hittite/Hurrian religious texts from Hattusa; essential source for Hurrian pantheon transmitted via Hittite cuneiform'),

  ('SRC_WEST_EAST_HELICON',
   'Martin L. West, The East Face of Helicon: West Asiatic Elements in Greek Poetry and Myth (Oxford: Clarendon Press, 1997)',
   NULL,
   'secondary scholarly',
   'Comprehensive argument that early Greek poetry (Homer, Hesiod) directly draws on West Asian literary and mythological traditions; documents Kumarbi=Kronos, Teshub=Zeus, Ullikummi=Typhon parallels exhaustively; essential for Hittite→Greek and Mesopotamian→Greek transmission chains')
ON CONFLICT (source_id) DO NOTHING;

-- ── 3. New Hittite/Hurrian entities ────────────────────────────────────────

-- 3a. Hurrian entities (attested in Hittite empire cuneiform texts at Hattusa)

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_HTT_ALALU',
   'Alalu',
   'Hittite/Hurrian',
   'Primordial high god',
   'A',
   'First king of heaven in the Hurrian succession myth (Song of Kumarbi); dethroned by Anu; no direct Greek parallel but anchors the succession chain Alalu→Anu→Kumarbi→Teshub'),

  ('ENT_HTT_KUMARBI',
   'Kumarbi',
   'Hittite/Hurrian',
   'Succession deity',
   'A',
   'Hurrian grain deity and father of the gods; in the Song of Kumarbi bites off Anu''s genitals and becomes pregnant with Teshub; paradigm parallel for Kronos castrating Ouranos in Hesiod''s Theogony; eventually defeated by his son Teshub'),

  ('ENT_HTT_TESHUB',
   'Teshub',
   'Hittite/Hurrian',
   'Storm god',
   'A',
   'Chief Hurrian storm deity; son/successor to Kumarbi; wields thunder and lightning; defeats Kumarbi and rules heaven; the paradigm parallel for Zeus defeating the Titans; identified with the Hittite Tarhunna'),

  ('ENT_HTT_HEPAT',
   'Hepat',
   'Hittite/Hurrian',
   'Queen of Heaven',
   'A',
   'Hurrian queen of heaven; wife of Teshub; mother of Sharruma; chief goddess of the Hurrian/Hittite divine assembly; identified with the Hittite Sun Goddess of Arinna in later syncretism; structural parallel to Hera as queen of heaven and wife of the chief deity'),

  ('ENT_HTT_SHAUSHKA',
   'Shaushka',
   'Hittite/Hurrian',
   'Love/war goddess',
   'A',
   'Hurrian love and war goddess; the Hurrian name of Ishtar; Hittite texts explicitly identify her as "Ishtar of Nineveh" and "Ishtar of Samuha"; transmits the Mesopotamian Inanna/Ishtar complex into Anatolian and later Mediterranean religion'),

  ('ENT_HTT_ULLIKUMMI',
   'Ullikummi',
   'Hittite/Hurrian',
   'Chaos monster',
   'A',
   'Stone/diorite monster created by Kumarbi from the shoulder of Ubelluri to fight his son Teshub after losing power; grows to threaten heaven; eventually defeated when the gods cut its feet with an ancient tool; the paradigm parallel for Typhon as a monster created by the defeated predecessor to challenge the storm god champion')
ON CONFLICT (entity_id) DO NOTHING;

-- 3a-cont. Hittite-native entities (distinct tradition from Hurrian)
INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_HTT_ILLUYANKA',
   'Illuyanka',
   'Hittite',
   'Chaos serpent',
   'A',
   'Serpent/dragon defeated by the Hittite storm god Tarhunna in the Illuyanka myth; Tarhunna initially loses but ultimately defeats the serpent with the help of the mortal Hupasiya and the goddess Inaras; structural parallel to Zeus/Typhon and Apollo/Python in the "storm god defeats chaos serpent" combat myth tradition'),

  ('ENT_HTT_TARHUNNA',
   'Tarhunna',
   'Hittite',
   'Storm god',
   'A',
   'Native Hittite storm deity (also Tarhun or Tarhunz); wields the thunderbolt; defeats Illuyanka; closely identified with the Hurrian Teshub in Hittite-Hurrian syncretic pantheon; the Hittite counterpart of the Zeus/Jupiter/Baal storm-god archetype'),

  ('ENT_HTT_ARINNA',
   'Sun Goddess of Arinna',
   'Hittite',
   'Sun goddess',
   'A',
   'Chief state deity of the Hittite kingdom; the Great Sun Goddess worshipped at Arinna; distinctive in being a sun goddess (not god) at the head of the pantheon; identified with the Hurrian Hepat in syncretic texts; her prominence reflects a distinctly Hittite religious priority separate from the Hurrian Teshub-centered tradition')
ON CONFLICT (entity_id) DO NOTHING;

-- 3b. New Greek entities needed as targets for Hittite→Greek chains
-- (ENT_OURANOS is created in add_mesopotamian_greek_parallels.sql)

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_KRONOS',
   'Kronos',
   'Greek',
   'Titan',
   'A',
   'King of the Titans; son of Ouranos and Gaia; castrates his father Ouranos to seize power; swallows his divine children to prevent being overthrown; ultimately defeated by Zeus; Hesiod Theogony 137-138, 453-506; the Greek parallel for the Hurrian Kumarbi'),

  ('ENT_TYPHON',
   'Typhon',
   'Greek',
   'Chaos monster',
   'A',
   'Last great monster of the pre-Olympian age; son of Gaia (and Tartaros); created to challenge Zeus after the defeat of the Titans; defeated by Zeus''s thunderbolts and buried under Etna; Hesiod Theogony 820-880; parallel to the Hurrian Ullikummi and Hittite Illuyanka as a chaos monster challenging the storm god champion')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Source links ─────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_HTT_ALALU',     'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Song of Kumarbi (Song of Going Forth), Hoffner (1998) pp. 40-65; Alalu as first king'),
  ('ENT_HTT_KUMARBI',   'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Song of Kumarbi (CTH 344); Song of Ullikummi (CTH 345); Hoffner (1998) pp. 40-80'),
  ('ENT_HTT_TESHUB',    'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Song of Kumarbi, Song of Ullikummi, and throughout Hittite/Hurrian religious texts'),
  ('ENT_HTT_HEPAT',     'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Hittite prayer texts, Yazilikaya rock sanctuary iconography; Hepat enthroned with Teshub'),
  ('ENT_HTT_SHAUSHKA',  'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Myth of Shaushka and Hedammu; "Ishtar of Nineveh" treaty texts; Hoffner (1998) pp. 97-100'),
  ('ENT_HTT_ULLIKUMMI', 'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Song of Ullikummi (CTH 345A-C); Hoffner (1998) pp. 55-65'),
  ('ENT_HTT_ILLUYANKA', 'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Illuyanka myth (CTH 321); two versions; Hoffner (1998) pp. 10-14'),
  ('ENT_HTT_TARHUNNA',  'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Illuyanka myth and throughout Hittite state religion texts; Hoffner (1998) passim'),
  ('ENT_HTT_ARINNA',    'SRC_HOFFNER_HITTITE_MYTHS', 'primary_attestation',
   'Hittite prayers, annals, and treaty texts; Sun Goddess of Arinna as chief Hittite deity'),
  ('ENT_KRONOS',        'SRC_HESIOD_THEOGONY',        'primary_attestation',
   'Hesiod, Theogony 137-138 (birth), 453-506 (swallowing children), 720 (defeat by Zeus)'),
  ('ENT_TYPHON',        'SRC_HESIOD_THEOGONY',        'primary_attestation',
   'Hesiod, Theogony 820-880; also Pindar Pythian 1.15-28; Aeschylus Prometheus Bound 351-372')
ON CONFLICT DO NOTHING;

-- West (1997) as secondary reference for comparative context
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_HTT_KUMARBI',   'SRC_WEST_EAST_HELICON', 'secondary_reference',
   'West (1997) chs. 5-6 document the Kumarbi=Kronos parallel exhaustively'),
  ('ENT_HTT_TESHUB',    'SRC_WEST_EAST_HELICON', 'secondary_reference',
   'West (1997) documents Teshub=Zeus transmission via Archaic Greek contact with Anatolian tradition'),
  ('ENT_HTT_ULLIKUMMI', 'SRC_WEST_EAST_HELICON', 'secondary_reference',
   'West (1997) pp. 300-302 explicitly links Ullikummi and Typhon'),
  ('ENT_KRONOS',        'SRC_WEST_EAST_HELICON', 'secondary_reference',
   'West (1997) makes the Kumarbi→Kronos identification the centerpiece of his transmission argument'),
  ('ENT_TYPHON',        'SRC_WEST_EAST_HELICON', 'secondary_reference',
   'West (1997) documents Ullikummi→Typhon as the best-attested cross-cultural monster parallel')
ON CONFLICT DO NOTHING;

-- ── 5. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_HTT_ALALU',     'PER_HTT_EMPIRE', 'high',
   'Attested in Hittite empire cuneiform texts at Hattusa, c. 1400-1200 BCE',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_KUMARBI',   'PER_HTT_EMPIRE', 'high',
   'Song of Kumarbi and associated texts dated to the Hittite New Kingdom/Empire period',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_TESHUB',    'PER_HTT_EMPIRE', 'high',
   'Throughout Hittite empire religious and literary texts; major deity at Yazilikaya sanctuary',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_HEPAT',     'PER_HTT_EMPIRE', 'high',
   'Prominent at Yazilikaya (c. 1250 BCE) and throughout Hittite empire prayer texts',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_SHAUSHKA',  'PER_HTT_EMPIRE', 'high',
   'Ishtar of Nineveh/Samuha identified as Shaushka throughout the Hittite empire period',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_ULLIKUMMI', 'PER_HTT_EMPIRE', 'high',
   'Song of Ullikummi dated to Hittite New Kingdom period at Hattusa',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_ILLUYANKA', 'PER_HTT_EMPIRE', 'high',
   'Illuyanka myth (CTH 321) attested in Old Hittite and New Kingdom period versions',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_TARHUNNA',  'PER_HTT_EMPIRE', 'high',
   'Chief storm deity of Hittite state religion throughout the empire period',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_HTT_ARINNA',    'PER_HTT_EMPIRE', 'high',
   'Sun Goddess of Arinna as supreme Hittite state deity throughout the empire period',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed'),
  ('ENT_KRONOS',        'PER_GRK_ARCHAIC', 'high',
   'Hesiod (c. 700 BCE) is the primary source; Archaic period attestation',
   'SRC_HESIOD_THEOGONY', 'reviewed'),
  ('ENT_TYPHON',        'PER_GRK_ARCHAIC', 'high',
   'Hesiod Theogony 820-880 is the fullest early account; Archaic period attestation',
   'SRC_HESIOD_THEOGONY', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ─────────────────────────────────────────────────────

-- 6a. Internal Hittite/Hurrian identifications

-- Teshub ↔ Tarhunna: the Hurrian and Hittite storm gods are closely identified
-- in syncretic Hittite-Hurrian religion; their names are used interchangeably
-- in many texts. Yazilikaya shows them together.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_TESHUB', 'identified_with', 'ENT_HTT_TARHUNNA',
   'high',
   'The Hurrian storm god Teshub and the Hittite storm god Tarhunna are closely identified throughout the syncretized Hittite-Hurrian religious tradition. At the Yazilikaya open-air sanctuary (c. 1250 BCE), the two traditions'' storm deities appear together, effectively as the same divine power under different names. Hittite treaty texts and prayers use the names interchangeably or in paired formulae.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE'),
  ('ENT_HTT_TARHUNNA', 'identified_with', 'ENT_HTT_TESHUB',
   'high',
   'Tarhunna as the Hittite name of the storm deity identified with the Hurrian Teshub; both are the chief storm gods of their respective traditions and merged in Hittite-Hurrian syncretic religion.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE')
ON CONFLICT DO NOTHING;

-- Inanna/Ishtar ↔ Shaushka: explicit cross-tradition identification in Hittite texts
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_INANNA_ISHTAR', 'identified_with', 'ENT_HTT_SHAUSHKA',
   'high',
   'Hittite religious texts explicitly call Shaushka "Ishtar of Nineveh" and "Ishtar of Samuha," demonstrating a direct identification rather than mere structural parallel. The Myth of Shaushka and Hedammu and treaty texts from the Hittite empire routinely use the two names as equivalents. Shaushka is the Hurrian reception of the Mesopotamian love/war goddess complex, transmitting the Inanna/Ishtar tradition into Anatolian religion.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE'),
  ('ENT_HTT_SHAUSHKA', 'identified_with', 'ENT_MES_INANNA_ISHTAR',
   'high',
   'Shaushka as the Hurrian reception of Mesopotamian Inanna/Ishtar; Hittite texts call her "Ishtar of Nineveh" and "Ishtar of Samuha"; the identification is explicit in the primary sources.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_HTT_EMPIRE')
ON CONFLICT DO NOTHING;

-- 6b. Hittite/Hurrian → Greek transmission chains (PER_GRK_ARCHAIC)
-- West (1997) argues for direct literary transmission via Anatolian intermediaries
-- reaching Ionian Greeks in the 8th-7th c. BCE (the "Orientalizing Revolution" period)

-- Kumarbi → Kronos: the castrator-of-the-sky-god parallel
-- The most exact structural parallel in all Near Eastern→Greek transmission:
-- both are the deity who castrates/overthrows the sky god (Anu/Ouranos) and is
-- in turn defeated by the storm deity (Teshub/Zeus).
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_KUMARBI', 'received_as', 'ENT_KRONOS',
   'high',
   'The Kumarbi→Kronos parallel is the centerpiece of West''s (1997) argument for Near Eastern influence on Hesiod''s Theogony. Both deities share an exact structural role: (1) they overthrow the ruling sky deity by biting/castrating the genitals (Kumarbi bites off Anu''s genitals; Kronos castrates Ouranos with a sickle); (2) they absorb divine seed and become pregnant with the deity who will overthrow them; (3) they are themselves defeated by the storm deity son (Teshub/Zeus). This three-stage narrative is unique to the Kumarbi cycle among Near Eastern texts and uniquely explains why Hesiod''s Theogony has the same three-stage structure. Transmission most likely via Anatolian-Greek contact in the 8th-7th c. BCE.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_KRONOS', 'reception_of', 'ENT_HTT_KUMARBI',
   'high',
   'Kronos as the Greek reception of the Hurrian Kumarbi succession deity; the sky-god castration narrative in Hesiod''s Theogony is best explained by the Kumarbi cycle tradition transmitted via Anatolian contact.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- Teshub → Zeus: the storm deity champion who defeats the predecessor
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_TESHUB', 'received_as', 'ENT_ZEUS',
   'high',
   'Teshub and Zeus share the role of the storm deity champion who defeats a monstrous adversary (Ullikummi/Typhon) and the usurper predecessor (Kumarbi/Kronos) to establish the current divine order. West (1997) documents that the narrative structure of Zeus''s ascent in Hesiod''s Theogony follows the Kumarbi cycle more closely than any other Near Eastern text. Both Teshub and Zeus also create an ordered cosmos out of the pre-existing chaos. The transmission pathway runs through Anatolian-Ionian Greek contact in the Archaic period.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_ZEUS', 'reception_of', 'ENT_HTT_TESHUB',
   'high',
   'Zeus as the Greek reception of the Hurrian/Hittite Teshub tradition — the storm deity who defeats both the monstrous chaos figure and the preceding ruler to establish the current divine order.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- Ullikummi → Typhon: monster created by the defeated predecessor to fight the champion
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_ULLIKUMMI', 'received_as', 'ENT_TYPHON',
   'medium',
   'The Song of Ullikummi and Hesiod''s Typhon narrative share the same plot structure: (1) the defeated predecessor deity (Kumarbi/defeated Titans, or Gaia acting on behalf of the old order) creates a monstrous adversary; (2) the monster grows to threaten heaven and challenge the storm god champion; (3) the champion (Teshub/Zeus) must struggle to defeat the monster. West (1997) pp. 300-302 makes this parallel explicit. In both myths, the monster''s defeat marks the final establishment of the current divine order. Confidence medium because the narrative parallels are strong but the transmission mechanism is indirect (probably via Anatolian-Ionian contact rather than direct textual borrowing).',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_TYPHON', 'reception_of', 'ENT_HTT_ULLIKUMMI',
   'medium',
   'Typhon as the Greek reception of the Ullikummi tradition — the chaos monster created by the old order to challenge the new divine champion, whose defeat finally establishes cosmic order.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- Hepat → Hera: queen of heaven parallel
-- Hepat is the Hurrian queen of heaven, wife of the chief deity, and chief goddess.
-- Hera is the Greek queen of heaven, wife of Zeus, and chief Olympian goddess.
-- The functional parallel is strong; direct transmission is plausible but less
-- precisely documented than the Kumarbi→Kronos chain.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_HEPAT', 'received_as', 'ENT_HERA',
   'medium',
   'Hepat and Hera share the role of queen of heaven and consort of the chief deity (Teshub/Zeus). At Yazilikaya, Hepat stands opposite Teshub as his divine equal — a role that parallels Hera''s position as Zeus''s queen. Hepat is also called "queen of heaven" (DINGIR.MAH or similar in Hittite texts) before the same title was applied to Hera and later to Isis and Mary. West (1997) includes the Hepat-Hera parallel among the Anatolian-Greek transmission chain, though with less textual specificity than the Kumarbi-Kronos pair.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_HERA', 'reception_of', 'ENT_HTT_HEPAT',
   'medium',
   'Hera as the Greek reception of the Hurrian queen of heaven Hepat; shared role as wife and consort of the chief storm deity, and as queen of the divine assembly.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- Illuyanka → Python: serpent combat at a divine site
-- The Illuyanka myth (Hittite) features the storm god defeating a serpent/dragon
-- at or for a sacred site. This pattern — storm/solar deity defeats serpent to
-- claim a cult site — parallels Apollo defeating Python at Delphi.
-- Lower confidence because the transmission to Apollo (not a storm god) is indirect;
-- the common ancestor is the broader Near Eastern serpent-combat tradition.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_HTT_ILLUYANKA', 'received_as', 'ENT_PYTHON',
   'low',
   'The Illuyanka myth (Hittite) and the Apollo/Python tradition both belong to the broader Near Eastern "storm/solar deity defeats serpent to claim a sacred site" pattern, which appears also in Baal/Lotan (Ugaritic), Marduk/Tiamat (Babylonian), and Zeus/Typhon (Greek). Illuyanka is defeated by Tarhunna (the storm god) with help from the goddess Inaras and a mortal, paralleling the multi-agent defeats in other serpent-combat myths. The transmission to the specifically solar Apollo/Python form is indirect — probably via the same broad transmission pathway as other Near Eastern→Greek myth contacts in the Archaic period. Confidence low because Apollo (not the storm god) is the serpent''s defeater in the Greek version, and no direct textual link between Illuyanka and Python is demonstrable.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_PYTHON', 'reception_of', 'ENT_HTT_ILLUYANKA',
   'low',
   'Python as a possible Greek reception of the Anatolian serpent-combat tradition (Illuyanka); the pattern of a divine champion defeating a serpent to claim a sacred site is shared, but Apollo''s solar rather than storm nature makes the transmission indirect.',
   'SRC_HOFFNER_HITTITE_MYTHS', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- ── 7. Verification ─────────────────────────────────────────────────────────

SELECT 'hittite_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition IN ('Hittite','Hittite/Hurrian');

SELECT 'hittite_chains' AS metric, COUNT(*) AS count
FROM entity_relationships
WHERE subject_entity_id LIKE 'ENT_HTT_%'
   OR object_entity_id LIKE 'ENT_HTT_%';

SELECT * FROM v_release_metrics;

COMMIT;
