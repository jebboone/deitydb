-- scripts/complete_kabbalah_tree.sql
-- New layer (v1.27.0): complete the Kabbalistic Tree of Life.
--
-- Second of the two mystical layers, after formative Sufism (v1.26.0). Within the
-- Jewish-mystical tradition the older Hekhalot/Merkavah stratum (c. 200-700 CE) is
-- already present (Merkabah, Metatron, the angelic orders, Sar Torah); this completes
-- the medieval (12th-13th c.) Kabbalah by filling the Sefirot tree, which previously
-- held only its top triad (Keter, Hokhmah, Binah).
--
-- Bottom-up discipline: the Tree as systematised in the Bahir and Zohar is in scope;
-- the later Lurianic apparatus (Tzimtzum, Shevirat ha-Kelim, Tikkun — 16th c. Safed)
-- is deliberately deferred to a later stratum. Reuses existing sources and period.

BEGIN;

-- ── Entities: Ein Sof + the 7 lower Sefirot ──────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
('ENT_JM_EIN_SOF','Ein Sof','Godhead/principle','Jewish Mystical','Divine principle','PER_JM_MEDIEVAL','A','reviewed',
 'The Infinite, the boundless and unknowable Godhead beyond all attributes, from which the Sefirot emanate. Keter is its first self-manifestation; Ein Sof itself remains hidden.'),
('ENT_JM_CHESED','Chesed','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The fourth Sefirah, divine loving-kindness and mercy (also Gedulah, greatness); the expansive, giving force at the head of the right pillar.'),
('ENT_JM_GEVURAH','Gevurah','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The fifth Sefirah, divine severity, power, and judgment (also Din); the contracting, restraining force at the head of the left pillar, counterpoised to Chesed.'),
('ENT_JM_TIFERET','Tiferet','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The sixth Sefirah, beauty and harmony; the balancing centre of the tree that reconciles Chesed and Gevurah, associated with the written Torah and the divine masculine.'),
('ENT_JM_NETZACH','Netzach','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The seventh Sefirah, endurance, eternity, and victory; the lower terminus of the right pillar.'),
('ENT_JM_HOD','Hod','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The eighth Sefirah, splendour and majesty; the lower terminus of the left pillar, paired with Netzach.'),
('ENT_JM_YESOD','Yesod','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The ninth Sefirah, foundation; the channel that gathers the upper Sefirot and transmits the divine flow (shefa) into Malkhut.'),
('ENT_JM_MALKHUT','Malkhut','Sephirah','Jewish Mystical','Sephirah','PER_JM_MEDIEVAL','A','reviewed',
 'The tenth Sefirah, kingdom; the receptive culmination of the tree and the indwelling divine presence in the world. In Kabbalah, Malkhut is identified with the Shekhinah.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources ───────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
('ENT_JM_EIN_SOF','SRC_SCHOLEM_KABBALAH','Secondary analysis','Scholem on Ein Sof and the emanation of the Sefirot.'),
('ENT_JM_CHESED','SRC_ZOHAR','Direct attestation','Sefirah of the Zoharic tree.'),
('ENT_JM_CHESED','SRC_SCHOLEM_KABBALAH','Secondary analysis','Scholem on the structure of the Sefirot.'),
('ENT_JM_GEVURAH','SRC_ZOHAR','Direct attestation','Sefirah of the Zoharic tree (Din).'),
('ENT_JM_GEVURAH','SRC_SCHOLEM_KABBALAH','Secondary analysis','Scholem on Gevurah/Din.'),
('ENT_JM_TIFERET','SRC_ZOHAR','Direct attestation','Central Sefirah of the Zoharic tree.'),
('ENT_JM_TIFERET','SRC_SCHOLEM_KABBALAH','Secondary analysis','Scholem on Tiferet and the divine masculine.'),
('ENT_JM_NETZACH','SRC_ZOHAR','Direct attestation','Sefirah of the Zoharic tree.'),
('ENT_JM_HOD','SRC_ZOHAR','Direct attestation','Sefirah of the Zoharic tree.'),
('ENT_JM_YESOD','SRC_ZOHAR','Direct attestation','Sefirah of the Zoharic tree; channel of shefa.'),
('ENT_JM_YESOD','SRC_SCHOLEM_KABBALAH','Secondary analysis','Scholem on Yesod as the foundation/channel.'),
('ENT_JM_MALKHUT','SRC_ZOHAR','Direct attestation','Sefirah of the Zoharic tree, identified with the Shekhinah.'),
('ENT_JM_MALKHUT','SRC_SCHOLEM_KABBALAH','Secondary analysis','Scholem on Malkhut/Shekhinah.')
ON CONFLICT DO NOTHING;

-- ── Entity periods ───────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status) VALUES
('ENT_JM_EIN_SOF','PER_JM_MEDIEVAL','high','Ein Sof as a technical term emerges with medieval Kabbalah.','SRC_SCHOLEM_KABBALAH','reviewed'),
('ENT_JM_CHESED','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed'),
('ENT_JM_GEVURAH','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed'),
('ENT_JM_TIFERET','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed'),
('ENT_JM_NETZACH','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed'),
('ENT_JM_HOD','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed'),
('ENT_JM_YESOD','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed'),
('ENT_JM_MALKHUT','PER_JM_MEDIEVAL','high','Sefirot tree systematised in medieval Kabbalah.','SRC_ZOHAR','reviewed')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- Emanation chain (seder hishtalshelut): each Sefirah emanates from the prior; Keter from Ein Sof
('ENT_JM_KETER','emanates_from','ENT_JM_EIN_SOF','high','Keter is the first emanation of the hidden Ein Sof.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_HOKHMAH','emanates_from','ENT_JM_KETER','high','Hokhmah proceeds from Keter as the first active potency.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_BINAH','emanates_from','ENT_JM_HOKHMAH','high','Binah receives and gives form to the flash of Hokhmah.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_CHESED','emanates_from','ENT_JM_BINAH','high','Chesed proceeds from the supernal triad into the emotive Sefirot.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_GEVURAH','emanates_from','ENT_JM_CHESED','high','Gevurah arises as the restraining counterpoise to Chesed.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_TIFERET','emanates_from','ENT_JM_GEVURAH','high','Tiferet harmonises Chesed and Gevurah at the centre of the tree.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_NETZACH','emanates_from','ENT_JM_TIFERET','high','Netzach flows from Tiferet down the right pillar.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_HOD','emanates_from','ENT_JM_NETZACH','high','Hod is paired with Netzach in the lower triad.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_YESOD','emanates_from','ENT_JM_HOD','high','Yesod gathers the flow of the upper Sefirot.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_MALKHUT','emanates_from','ENT_JM_YESOD','high','Malkhut receives the divine flow (shefa) through Yesod.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
-- Tree membership
('ENT_JM_SEFIROT','has_member','ENT_JM_CHESED','high','Chesed is the fourth of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_SEFIROT','has_member','ENT_JM_GEVURAH','high','Gevurah is the fifth of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_SEFIROT','has_member','ENT_JM_TIFERET','high','Tiferet is the sixth of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_SEFIROT','has_member','ENT_JM_NETZACH','high','Netzach is the seventh of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_SEFIROT','has_member','ENT_JM_HOD','high','Hod is the eighth of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_SEFIROT','has_member','ENT_JM_YESOD','high','Yesod is the ninth of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_SEFIROT','has_member','ENT_JM_MALKHUT','high','Malkhut is the tenth of the ten Sefirot.','SRC_ZOHAR','PER_JM_MEDIEVAL','reviewed'),
-- Attribute / comparative-layer links
('ENT_JM_CHESED','embodies','ENT_LOVE','high','Chesed is divine loving-kindness.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_GEVURAH','embodies','ENT_JUDGMENT','high','Gevurah (Din) is the Sefirah of divine judgment.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_TIFERET','embodies','ENT_BEAUTY','high','Tiferet is the Sefirah of beauty and harmony.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
('ENT_JM_MALKHUT','embodies','ENT_SOVEREIGNTY','high','Malkhut is the Sefirah of kingship and divine sovereignty.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed'),
-- Malkhut = Shekhinah
('ENT_JM_MALKHUT','identified_with','ENT_JM_SHEKHINAH','high','In Kabbalah, the tenth Sefirah Malkhut is identified with the Shekhinah, the indwelling presence.','SRC_SCHOLEM_KABBALAH','PER_JM_MEDIEVAL','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS sefirot_members
FROM entity_relationships WHERE subject_entity_id='ENT_JM_SEFIROT' AND relationship_type='has_member';
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
