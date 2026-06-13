-- scripts/add_mesopotamian_greek_parallels.sql
-- Mesopotamian → Greek structural parallels and reception chains
--
-- These chains document direct Mesopotamian→Greek transmission pathways
-- that do NOT route through the Hittite/Hurrian intermediary (those were
-- added in add_hittite_hurrian_layer.sql). The pathways here are either:
--   (a) Direct structural parallels whose transmission mechanism was Ionian
--       Greek contact with Babylonian/Assyrian cultural zones (Burkert 1992)
--   (b) Chains that post-date the Hittite Empire collapse (after c. 1180 BCE)
--       and route through Neo-Assyrian/Neo-Babylonian cultural influence
--
-- Burkert's Orientalizing Revolution (1992) documents the 8th-7th c. BCE
-- period when Ionian Greek cities absorbed Near Eastern literary, artistic,
-- and mythological material. West's East Face of Helicon (1997) supplements
-- with specific textual parallels.
--
-- New Greek entity created here: ENT_OURANOS (sky/heaven primordial)
-- All other targets already exist.
-- Sources: SRC_BURKERT_ORIENT_REV (new); SRC_WEST_EAST_HELICON (already in DB)

BEGIN;

-- ── 1. New source ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_BURKERT_ORIENT_REV',
   'Walter Burkert, The Orientalizing Revolution: Near Eastern Influence on Greek Culture in the Early Archaic Age (Harvard University Press, 1992)',
   NULL,
   'secondary scholarly',
   'Documents the 8th-7th c. BCE transmission of Near Eastern — primarily Mesopotamian and Levantine — mythology, literature, and iconography into Greek culture; argues for craftsmen, mercenaries, and merchants as the transmission vectors; documents specific parallels between Mesopotamian and Greek deities, myths, and ritual practices')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New Greek entity: Ouranos ─────────────────────────────────────────────

-- Ouranos is the Greek sky primordial, parallel to the Mesopotamian Anu in the
-- succession myth. He is attested in Hesiod Theogony 126-210 (birth from Gaia,
-- castration by Kronos) and widely across Greek poetry.
INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_OURANOS',
   'Ouranos',
   'Greek',
   'Protogenos/Primordial',
   'A',
   'Greek primordial sky deity; first ruler of the cosmos; son and husband of Gaia; castrated by Kronos with an adamantine sickle; his severed genitals falling into the sea produce Aphrodite and the Erinyes; Hesiod Theogony 126-210; parallel to the Mesopotamian Anu as the primordial sky god who is overthrown by the next generation')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_OURANOS', 'SRC_HESIOD_THEOGONY', 'primary_attestation',
   'Hesiod, Theogony 126-210: Ouranos born from Gaia, castration by Kronos; also 176-200')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_OURANOS', 'PER_GRK_ARCHAIC', 'high',
   'Hesiod (c. 700 BCE) is the primary source; Archaic period attestation',
   'SRC_HESIOD_THEOGONY', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 3. Transmission chains ───────────────────────────────────────────────────

-- 3a. Succession myth: sky primordial parallel
-- Anu (Mesopotamian sky god, dethroned in the Kumarbi cycle) parallels Ouranos
-- (Greek sky primordial, castrated by Kronos). Both are the "primordial sky deity
-- who is overthrown by the usurper" in the succession myth pattern.
-- The Hittite intermediary (ENT_HTT_KUMARBI bites off Anu's genitals) completes
-- the chain: Anu → Ouranos is the sky-god layer; Kumarbi → Kronos (already in DB)
-- is the usurper layer.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ANU', 'received_as', 'ENT_OURANOS',
   'medium',
   'Anu (Sumero-Akkadian sky god) and Ouranos (Greek primordial sky) share the role of the sky/heaven primordial who is overthrown by the next generation in the divine succession myth. In the Kumarbi cycle (Hittite/Hurrian text), it is explicitly Anu who is castrated by Kumarbi — the same narrative that in Greek becomes Ouranos castrated by Kronos. West (1997) treats the Anu→Ouranos parallel as part of the succession myth transmission chain. Confidence medium because Anu appears in the Hittite texts by name (not transformed into a new deity), while the Greek Ouranos is a distinctly Greek reconception of the sky-primordial role.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_OURANOS', 'reception_of', 'ENT_MES_ANU',
   'medium',
   'Ouranos as the Greek reception of the Mesopotamian Anu in the succession myth framework — the sky/heaven primordial who is overthrown and castrated by the usurper deity.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3b. Marduk → Zeus: divine combat champion becomes chief of the assembly
-- The Enuma Elish (Old Babylonian, c. 1200 BCE) establishes Marduk as the
-- deity who defeats Tiamat in combat and creates the cosmos, then rules the
-- divine assembly. Zeus defeats the Titans and Typhon to rule the Olympians.
-- Burkert (1992) documents this as the primary Mesopotamian→Greek combat-
-- deity parallel, separate from the Teshub→Zeus chain via Hittite.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_MARDUK', 'received_as', 'ENT_ZEUS',
   'medium',
   'Marduk''s role in the Enuma Elish (Babylonian creation epic) as the deity who defeats the chaos monster (Tiamat) in combat, creates the cosmos from her body, and is acclaimed chief of the divine assembly is structurally identical to Zeus''s role in Hesiod''s Theogony. Both deities: (1) are selected by the divine assembly to fight a chaos threat; (2) use the thunderbolt/storm as their primary weapon; (3) create order after defeating chaos; (4) rule the divine assembly by acclamation. Burkert (1992) treats this as one of the primary Mesopotamian→Greek transmission parallels. This chain documents the direct Babylonian contribution to Zeus''s character, separate from the Teshub→Zeus Hittite chain (already in DB), which documents the succession narrative. Both chains coexist because they transmit different aspects of Zeus.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_ZEUS', 'reception_of', 'ENT_MES_MARDUK',
   'medium',
   'Zeus as the Greek reception of the Babylonian Marduk tradition — the combat champion who defeats chaos and is acclaimed chief of the divine assembly; separate pathway from the Teshub→Zeus Hittite succession chain.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3c. Enlil → Zeus: the older storm-kingship parallel
-- Enlil (Sumerian wind/storm deity, lord of the divine assembly) predates Marduk
-- as the paradigm chief deity of the Mesopotamian pantheon. His storm weapon
-- (the wind/tempest) and his role as lord of the assembly are the older template
-- for the Zeus complex. West (1997) notes Enlil as a secondary Zeus parallel.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ENLIL', 'received_as', 'ENT_ZEUS',
   'low',
   'Enlil (Sumerian storm and kingship deity, lord of the divine assembly) is the older template for the Zeus-type divine king. Like Zeus, Enlil: (1) wields the storm as his primary attribute; (2) presides over the divine assembly; (3) is the guardian of cosmic order (ME in Sumerian); (4) punishes divine and human transgressors. Enlil''s role as the active lord of the Anzu myth (defending cosmic order against Anzu who steals the tablet of destinies) parallels Zeus''s active defense of cosmic order. Confidence low because Enlil was largely eclipsed by Marduk in the Neo-Babylonian period (when Greek-Mesopotamian contact was most intense), making the transmission pathway indirect; Marduk is the more proximate Babylonian Zeus parallel (already in DB).',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_ZEUS', 'reception_of', 'ENT_MES_ENLIL',
   'low',
   'Zeus as a possible Greek reception of the older Enlil storm-kingship tradition; secondary parallel to the more direct Marduk→Zeus and Teshub→Zeus chains.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3d. Tiamat → Typhon: primordial chaos monster combated by divine champion
-- The Enuma Elish combat (Marduk defeats Tiamat) and Hesiod''s Typhon narrative
-- (Zeus defeats Typhon) share the pattern of the divine storm champion defeating
-- a primordial chaos monster. This chain is distinct from the Ullikummi→Typhon
-- chain (already in DB) because Tiamat is the Babylonian chaos tradition directly
-- and its influence on Greece may have operated through multiple channels.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_TIAMAT', 'received_as', 'ENT_TYPHON',
   'medium',
   'The Tiamat→Typhon parallel is part of the broader Near Eastern "chaos combat" tradition documented by Burkert (1992). Tiamat (Babylonian primordial sea dragon, defeated by Marduk in the Enuma Elish) and Typhon (Greek chaos monster, defeated by Zeus in Hesiod Theogony 820-880) share: (1) identification with primordial chaos preceding the current divine order; (2) defeat by the storm deity champion via the thunderbolt/storm weapon; (3) multi-headed or serpentine form. The Canaanite Lotan→Leviathan chain (already in DB) and the Hittite Ullikummi→Typhon chain (already in DB) are related but distinct transmission pathways. The Tiamat→Typhon chain represents the direct Babylonian contribution to the Greek chaos-monster complex. Confidence medium because the Ullikummi route (via Hittite) is better documented than a direct Babylonian route.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_TYPHON', 'reception_of', 'ENT_MES_TIAMAT',
   'medium',
   'Typhon as a Greek reception of the Babylonian Tiamat chaos tradition — the primordial chaos monster defeated by the divine storm champion; parallel to but distinct from the Hittite Ullikummi→Typhon chain.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3e. Ereshkigal → Persephone: underworld queen parallel
-- Both rule the underworld; both are associated with a narrative of descent/abduction
-- and seasonal return. West (1997) documents this as one of the clearest
-- Mesopotamian→Greek functional parallels.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_ERESHKIGAL', 'received_as', 'ENT_PERSEPHONE',
   'medium',
   'Ereshkigal (Sumerian/Akkadian queen of the underworld) and Persephone (Greek queen of the underworld) share the role of female sovereign of the realm of the dead. Key parallels: (1) both are described as unwilling rulers of the underworld who came to power through abduction or compulsion (Ereshkigal''s own mythology includes her abduction by Kur/Nergal; Persephone is abducted by Hades); (2) the Descent of Inanna narrative — Inanna''s journey to confront her sister Ereshkigal, death, and resurrection — provides the narrative template for the Persephone/Demeter/Kore complex; (3) both are associated with the seasonal cycle of vegetation and death. West (1997) documents the Inanna/Ishtar Descent as a source text for the Eleusinian Persephone mythology. Confidence medium because functional parallels are strong but direct textual transmission to the Persephone myth cannot be pinpointed to a single text.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_PERSEPHONE', 'reception_of', 'ENT_MES_ERESHKIGAL',
   'medium',
   'Persephone as Greek reception of the Mesopotamian underworld queen Ereshkigal; the Descent of Inanna narrative template contributes to the Persephone/Demeter/Kore mythological complex.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3f. Apsu → Oceanus: primordial cosmic water before creation
-- Apsu (Babylonian primordial freshwater ocean beneath the earth, killed by Ea/Enki
-- in the Enuma Elish) and Oceanus (Greek great river-ocean surrounding the world,
-- parent of rivers and streams in Hesiod) share the role of primordial cosmic water
-- from which the world emerged.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_APSU', 'received_as', 'ENT_OCEANUS',
   'medium',
   'Apsu (Babylonian primordial freshwater, the deep beneath the earth, commingled with Tiamat as the primordial salt waters before creation) and Oceanus (Greek primordial river-ocean surrounding the world) share the role of the primordial cosmic water from which the current world order emerged. Hesiod (Theogony 133, 265-269) treats Oceanus as a primordial Titan who precedes the Olympian order; the Iliad (14.201) calls Oceanus "the origin of all things," paralleling Apsu and Tiamat as the primordial pair in the Enuma Elish prologue. West (1997) notes the cosmogonic role of oceanic waters as a shared element. The Apsu/Oceanus correspondence is a structural parallel rather than a name cognate; confidence medium.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_OCEANUS', 'reception_of', 'ENT_MES_APSU',
   'medium',
   'Oceanus as the Greek reception of the Mesopotamian primordial water tradition — the cosmic water that preceded creation and surrounds/underlies the current world.',
   'SRC_WEST_EAST_HELICON', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3g. Nabu → Hermes: writing/wisdom deity + divine messenger
-- Nabu (Babylonian scribe deity, son of Marduk, patron of writing and wisdom)
-- and Hermes (Greek divine messenger, patron of eloquence, writing, and the arts)
-- share the roles of divine scribe/communicator and messenger between realms.
-- Burkert (1992) includes this in his catalog of Mesopotamian→Greek deity parallels.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_NABU', 'received_as', 'ENT_HERMES',
   'medium',
   'Nabu (Babylonian god of scribal arts, wisdom, and writing; son of Marduk) and Hermes (Greek divine messenger, patron of eloquence and writing, psychopomp) share the roles of (1) divine communicator/messenger; (2) deity associated with writing and wisdom; (3) intermediary between divine and human realms. Nabu''s symbol is the writing stylus; he records destinies on the Tablet of Destinies. Hermes is the divine herald and the Greek deity most closely associated with logos (speech, writing, reason). The transmission is plausible via Neo-Assyrian cultural influence on Ionian Greeks (Burkert 1992), though no specific text documents the Nabu→Hermes identification. Confidence medium: functional parallel is strong; transmission mechanism is indirect.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_HERMES', 'reception_of', 'ENT_MES_NABU',
   'medium',
   'Hermes as a possible Greek reception of the Babylonian Nabu tradition — the divine scribe and messenger; the Hermes Trismegistus tradition later makes this connection explicit in Hellenistic synthesis.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3h. Dumuzi/Tammuz → Adonis: dying vegetation deity via Phoenician mediation
-- Dumuzi (Sumerian) / Tammuz (Akkadian) is the paradigm "dying and rising" vegetation
-- deity. The name "Adonis" is the Greek reception of Semitic "Adon" (lord) — the
-- Phoenician/Syrian "lord" whose annual death and mourning rites at Byblos are
-- described by Lucian (De Syria Dea). This chain transmits via Phoenician mediation.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_DUMUZI_TAMMUZ', 'received_as', 'ENT_ADONIS',
   'low',
   'The Greek Adonis is the reception of the Semitic "Adon" (lord), the Phoenician/Syrian dying vegetation deity whose annual mourning rites were celebrated at Byblos on the Adonis River. This deity is the Phoenician Iron Age reception of the Mesopotamian Dumuzi/Tammuz tradition: Tammuz (= Dumuzi) was mourned annually in Mesopotamian ritual (Ezekiel 8:14 attests this in Jerusalem), and the rite transmitted to Phoenicia and then to Greece as the Adonis cult. The Greek Adonis myth — the beautiful youth loved by Aphrodite, killed by a boar, mourned annually, descending to and returning from the underworld — reproduces the Dumuzi/Inanna narrative structure. Lucian (De Syria Dea 6-9) describes the Byblos rites as a transmission from "Osiris" via Phoenicia. Confidence low because the transmission route goes through Phoenician intermediaries (not direct Mesopotamian→Greek contact) and the add_phoenician_iron_age_layer.sql script adds the Phoenician intermediate entities.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_ADONIS', 'reception_of', 'ENT_MES_DUMUZI_TAMMUZ',
   'low',
   'Adonis as the Greek reception of the Mesopotamian Dumuzi/Tammuz dying vegetation deity tradition, via Phoenician Adon intermediary.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- 3i. Ninhursag → Demeter: earth mother / grain goddess parallel
-- Ninhursag (Sumerian "Lady of the Sacred Mountain," mother of the gods, fertility
-- and earth goddess) and Demeter (Greek grain and earth goddess, mother of Persephone)
-- share the role of divine earth mother and patroness of agriculture.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MES_NINHURSAG', 'received_as', 'ENT_DEMETER',
   'low',
   'Ninhursag ("Lady of the Sacred Mountain," also Ninmah and Ki) is the Sumerian earth mother and mother of the gods — the female earth principle who nurtures and sustains living things and presides over agricultural fertility. Demeter is the Greek grain goddess who presides over the fertility of the earth and the agricultural cycle. Both are: (1) earth/grain goddesses; (2) divine mothers with a strong nurturing function; (3) associated with ritual cycles of agricultural fertility. The parallel is a structural one; no specific textual transmission is documented. Confidence low because the earth-mother/grain-goddess archetype is so widespread that parallel development is as plausible as transmission.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC'),
  ('ENT_DEMETER', 'reception_of', 'ENT_MES_NINHURSAG',
   'low',
   'Demeter as a possible Greek reception of the Mesopotamian earth-mother/grain-goddess tradition (Ninhursag/Ki); structural parallel; direct transmission not documented.',
   'SRC_BURKERT_ORIENT_REV', 'reviewed', 'PER_GRK_ARCHAIC')
ON CONFLICT DO NOTHING;

-- ── 4. Verification ──────────────────────────────────────────────────────────

SELECT 'mes_greek_chains' AS metric, COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('received_as','reception_of')
AND (subject_entity_id LIKE 'ENT_MES_%' OR object_entity_id LIKE 'ENT_MES_%')
AND (subject_entity_id LIKE 'ENT_%' AND subject_entity_id NOT LIKE 'ENT_MES_%'
  OR object_entity_id LIKE 'ENT_%' AND object_entity_id NOT LIKE 'ENT_MES_%')
AND (subject_entity_id NOT LIKE 'ENT_ISR_%' AND object_entity_id NOT LIKE 'ENT_ISR_%')
AND (subject_entity_id NOT LIKE 'ENT_CAN_%' AND object_entity_id NOT LIKE 'ENT_CAN_%');

SELECT * FROM v_release_metrics;

COMMIT;
