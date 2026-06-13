-- scripts/add_south_arabian_sabaean.sql
-- South Arabian / Sabaean tradition: the oldest Arabian religious layer
--
-- The Sabaean kingdom (capital Marib, modern Yemen) is attested from c. 1000 BCE
-- and controlled the incense trade routes through the Arabian peninsula, making it
-- a major religious and cultural power. South Arabian religion is the older stratum
-- beneath the Pre-Islamic Arabian tradition already in DB (add_pre_islamic_arabian.sql).
--
-- Distinctive features of South Arabian religion:
--   - The lunar deity (not solar) is the CHIEF deity of each kingdom; the sun is
--     female (Shams). This is the inverse of most Near Eastern traditions.
--   - Athtar (Venus) is MASCULINE — the opposite gender from Mesopotamian Ishtar
--     and Canaanite Astarte. This masculine Venus deity tradition is unique to
--     South Arabia and parts of the Levant (Ugaritic ʿAttar).
--   - Each major kingdom had its own patron lunar deity:
--     Saba: Almaqah; Qataban: ʿAmm; Hadhramaut: Sin; Himyar: later absorbed all.
--
-- Entities: ENT_SAB_ALMAQAH, ENT_SAB_ATHTAR, ENT_SAB_SHAMS, ENT_SAB_AMM
-- New period: PER_SABAEAN (-1200 to 275 CE; Sabaean and other South Arabian kingdoms)
-- New source: SRC_HOYLAND_ARABIA (Hoyland, Routledge 2001)

BEGIN;

-- ── 1. New period ────────────────────────────────────────────────────────────

INSERT INTO periods (period_id, period_name, tradition, start_year, end_year)
VALUES ('PER_SABAEAN', 'Sabaean and South Arabian Period', 'South Arabian', -1200, 275)
ON CONFLICT (period_id) DO NOTHING;

-- ── 2. New source ────────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_HOYLAND_ARABIA',
   'Robert G. Hoyland, Arabia and the Arabs: From the Bronze Age to the Coming of Islam (Routledge, 2001)',
   NULL,
   'secondary scholarly',
   'Comprehensive scholarly survey of ancient Arabian civilization including South Arabian kingdoms (Saba, Qataban, Hadhramaut, Himyar) and their religion; covers the South Arabian inscriptional evidence for the major deities (Almaqah, Athtar, Shams, ʿAmm, Sin) and their relationship to pre-Islamic north Arabian religion; documents the lunar-deity-as-chief-deity pattern unique to South Arabia and the masculine Venus (Athtar) tradition')
ON CONFLICT (source_id) DO NOTHING;

-- ── 3. New South Arabian entities ───────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_SAB_ALMAQAH',
   'Almaqah',
   'South Arabian',
   'Moon deity / State god',
   'A',
   'Chief deity of the Sabaean kingdom; lunar deity (the moon is the supreme deity in South Arabian religion, not the sun); patron of the capital Marib and the great Awam temple; depicted with the crescent moon and the bull''s head (the bull is sacred to the moon); attested in hundreds of dedicatory inscriptions from c. 800 BCE onward; associated with irrigation, fertility, military victory, and the protection of the tribe; the most prominent South Arabian deity in the epigraphic record; also spelled Ilmuqah, Almaqah, Almaqa'),

  ('ENT_SAB_ATHTAR',
   'Athtar',
   'South Arabian',
   'Venus deity / War deity',
   'A',
   'Pan-South-Arabian Venus deity, uniquely masculine in the South Arabian tradition; associated with the planet Venus (morning/evening star) and with war and irrigation; worshipped across all South Arabian kingdoms as part of the standard divine triad (Athtar, the tribal moon deity, and Shams the sun goddess); his name is cognate with Canaanite Astarte/Attar and Akkadian Ishtar but South Arabian tradition preserved or developed the masculine form; the Ugaritic ʿAttar (who temporarily occupies Baal''s throne after Baal dies) is likely the same deity; his masculine Venus role is unique in the ancient world'),

  ('ENT_SAB_SHAMS',
   'Shams',
   'South Arabian',
   'Sun goddess',
   'A',
   'South Arabian sun goddess; in South Arabian religion the sun is female (unlike most Near Eastern traditions where the sun deity is male); part of the standard South Arabian divine triad with Athtar and the tribal lunar deity; the name Shams is the common Semitic word for sun (Hebrew shemesh, Arabic shams); her cult was widespread across South Arabia, though less prominent than the lunar deities; depicted with solar disc; the distinctively feminine South Arabian sun is one of the most culturally specific features of this tradition'),

  ('ENT_SAB_AMM',
   'ʿAmm',
   'South Arabian',
   'Lunar deity / Tribal deity',
   'A',
   'Chief deity of the Qatabanian kingdom (neighboring Saba to the south); lunar deity like the Sabaean Almaqah; the name ʿAmm means "paternal uncle" in Arabic — the tribal patron conceived in kinship terms as the divine "uncle" of the tribe; worshipped at Timna (Qatabanian capital); the Qatabanian equivalent of Sabaean Almaqah; attested in Qatabanian inscriptions from c. 400 BCE onward; illustrates the pattern of each South Arabian kingdom having its own patron lunar deity')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Source links ──────────────────────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_SAB_ALMAQAH','SRC_HOYLAND_ARABIA',   'primary_attestation',
   'Hoyland (2001) ch. 7 on South Arabian religion: Almaqah as the pre-eminent Sabaean lunar deity; hundreds of inscriptions'),
  ('ENT_SAB_ALMAQAH','SRC_HEALEY_NABATAEAN_RELIGION','secondary_reference',
   'Healey (2001) provides comparative context for South Arabian and North Arabian lunar deity traditions'),
  ('ENT_SAB_ATHTAR', 'SRC_HOYLAND_ARABIA',   'primary_attestation',
   'Hoyland (2001) ch. 7: Athtar as the pan-South-Arabian Venus deity; masculine gender and war associations'),
  ('ENT_SAB_ATHTAR', 'SRC_CROSS_CANAANITE_MYTH','secondary_reference',
   'Cross (1973) pp. 26-28 on ʿAttar/Athtar cognate across Canaanite and South Arabian traditions'),
  ('ENT_SAB_SHAMS',  'SRC_HOYLAND_ARABIA',   'primary_attestation',
   'Hoyland (2001) ch. 7: Shams as the feminine South Arabian sun goddess; standard member of the divine triad'),
  ('ENT_SAB_AMM',    'SRC_HOYLAND_ARABIA',   'primary_attestation',
   'Hoyland (2001): ʿAmm as the Qatabanian chief deity; kinship-metaphor patron deity pattern')
ON CONFLICT DO NOTHING;

-- ── 5. Period assignments ────────────────────────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_SAB_ALMAQAH','PER_SABAEAN','high',
   'Almaqah attested in South Arabian inscriptions from c. 800 BCE onward; peak attestation in Sabaean kingdom period',
   'SRC_HOYLAND_ARABIA','reviewed'),
  ('ENT_SAB_ATHTAR', 'PER_SABAEAN','high',
   'Athtar attested across all South Arabian kingdoms throughout the Sabaean period; pan-South-Arabian deity',
   'SRC_HOYLAND_ARABIA','reviewed'),
  ('ENT_SAB_SHAMS',  'PER_SABAEAN','high',
   'Shams attested as part of the standard South Arabian divine triad throughout the Sabaean period',
   'SRC_HOYLAND_ARABIA','reviewed'),
  ('ENT_SAB_AMM',    'PER_SABAEAN','high',
   'ʿAmm attested in Qatabanian inscriptions from c. 400 BCE; Qatabanians are part of the broader South Arabian cultural zone',
   'SRC_HOYLAND_ARABIA','reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ──────────────────────────────────────────────────────

-- Semitic Venus tradition → Athtar: the Ishtar/Astarte complex received in
-- masculine form in South Arabia. The name cognate is certain (Ishtar/Astarte/
-- Attar/Athtar); the gender shift is specific to the South Arabian tradition.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_CAN_ASTARTE', 'received_as', 'ENT_SAB_ATHTAR',
   'low',
   'The South Arabian Athtar and the Canaanite Astarte/Ugaritic ʿAttar share the same etymological root (the proto-Semitic *ʿAttar- base) and the planet Venus as their primary celestial association. The Ugaritic ʿAttar (masculine) who temporarily sits on Baal''s throne and is deemed too small for it (KTU 1.6 I 53-65) represents the masculine form of the Venus deity that South Arabian Athtar preserves. The gender divergence — Astarte is female, Athtar is male — reflects either an early Semitic tradition that was later feminized in the Levantine context, or independent masculine and feminine developments from a common ancestral deity. Cross (1973) treats them as related variants of the same root deity. Confidence low: the name cognate is certain; the precise transmission direction and mechanism are debated.',
   'SRC_CROSS_CANAANITE_MYTH', 'reviewed', 'PER_SABAEAN'),
  ('ENT_SAB_ATHTAR', 'reception_of', 'ENT_CAN_ASTARTE',
   'low',
   'South Arabian Athtar as a related form of the Semitic Venus deity complex cognate with Canaanite Astarte/Ugaritic ʿAttar; the masculine gender is the South Arabian distinguishing feature.',
   'SRC_CROSS_CANAANITE_MYTH', 'reviewed', 'PER_SABAEAN')
ON CONFLICT DO NOTHING;

-- Almaqah → Hubal: South Arabian lunar deity tradition feeding into pre-Islamic
-- North Arabian lunar deity worship. Hubal''s lunar associations (already noted
-- in add_pre_islamic_arabian_layer.sql) connect to this older tradition.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_SAB_ALMAQAH', 'received_as', 'ENT_ARA_HUBAL',
   'low',
   'The South Arabian lunar-deity-as-chief-deity pattern (exemplified by Almaqah as the patron of the Sabaean kingdom) is the older religious substrate for the pre-Islamic north Arabian lunar deity worship that Hubal represents at Mecca. The transmission pathway from South Arabian to North Arabian religion operated through incense trade routes and population movements; the same general religious grammar (lunar deity as patron of the tribe/city, with Venus and sun as secondary deities) characterizes both South and pre-Islamic North Arabian religion. Confidence low: this is a broad cultural transmission rather than a specific documented lineage from Almaqah to Hubal.',
   'SRC_HOYLAND_ARABIA', 'reviewed', 'PER_ARA_PRE_ISLAMIC'),
  ('ENT_ARA_HUBAL', 'reception_of', 'ENT_SAB_ALMAQAH',
   'low',
   'Hubal as a possible North Arabian reception of the South Arabian lunar-patron-deity pattern; the general grammar of lunar deity supremacy transmitted through incense trade routes.',
   'SRC_HOYLAND_ARABIA', 'reviewed', 'PER_ARA_PRE_ISLAMIC')
ON CONFLICT DO NOTHING;

-- Athtar → Al-Uzza: South Arabian Venus deity feeding into North Arabian
-- Venus goddess tradition. Both are Venus deities; the South → North direction
-- of the Venus deity complex is plausible via trade routes.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_SAB_ATHTAR', 'received_as', 'ENT_ARA_AL_UZZA',
   'low',
   'The South Arabian masculine Venus deity (Athtar) and the North Arabian feminine Venus deity (Al-Uzza, "the most mighty") are both Venus deities within the Arabian religious world. The incense trade routes connecting South Arabia to the Hijaz and the Levant provided the vector for religious exchange; the feminization of the Venus deity in the North Arabian tradition (mirroring the general Levantine pattern of a feminine Venus) likely reflects the stronger influence of Phoenician/Canaanite religion on North Arabia. Confidence low: both are Venus deities in the same broad Semitic religious tradition, but the gender difference makes a direct transmission chain less certain than a parallel development from the common Semitic ʿAttar- root.',
   'SRC_HOYLAND_ARABIA', 'reviewed', 'PER_ARA_PRE_ISLAMIC'),
  ('ENT_ARA_AL_UZZA', 'reception_of', 'ENT_SAB_ATHTAR',
   'low',
   'Al-Uzza as the North Arabian reception of the Venus deity tradition from the broader Semitic world including South Arabian Athtar; feminized form of the masculine South Arabian Venus deity.',
   'SRC_HOYLAND_ARABIA', 'reviewed', 'PER_ARA_PRE_ISLAMIC')
ON CONFLICT DO NOTHING;

-- ── 7. Verification ──────────────────────────────────────────────────────────

SELECT 'south_arabian_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'South Arabian';

SELECT * FROM v_release_metrics;

COMMIT;
