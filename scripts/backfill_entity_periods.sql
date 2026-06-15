-- scripts/backfill_entity_periods.sql
-- Chronology repair (v1.51.0). Two fixes surfaced by the pre-Christ coverage audit:
--   (1) The Zoroastrian core was tagged ONLY to the Sasanian period (224 CE), wrongly
--       placing Ahura Mazda, the Amesha Spentas, Mithra etc. on the post-Christ side. They
--       are Avestan/Achaemenid in origin (the Gathas predate the Achaemenids). Fix: add a
--       PER_ZOR_ACHAEMENID link to every Zoroastrian entity (Sasanian links kept as the
--       continuation), so their earliest period is correctly pre-Christ.
--   (2) The ~150 entities added in the content-normalization program (v1.43-1.50) were
--       never linked to entity_periods. This wires each tradition's additions to its period.
-- The Cross-traditional abstraction layer (Truth, Death, Fate, ...) is intentionally left
-- undated: those concepts are timeless and not tied to one period.

BEGIN;

-- (1) Zoroastrian: every entity gets the Achaemenid/Avestan origin period (pre-Christ).
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT entity_id, 'PER_ZOR_ACHAEMENID', 'A',
       'Avestan/Achaemenid-origin Zoroastrian figure; the religion and its divine cast predate the Christ event.', 'reviewed'
FROM entities WHERE tradition='Zoroastrian'
ON CONFLICT DO NOTHING;

-- (2) Pre-Christ additions ------------------------------------------------------
-- Jewish Second Temple build-out (1 Enoch, Jubilees, Tobit, the Dead Sea Scrolls, Daniel).
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_ISR_SECOND_TEMPLE', 'A',
       'Second Temple Jewish figure (apocalyptic angelology/demonology, the Scrolls, Daniel).', 'reviewed'
FROM entities e WHERE e.tradition='Israelite/Second Temple'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Roman: the imperial-era / CE additions ...
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_ROM_IMPERIAL', 'A',
       'Roman imperial-era cult (the deified Augustus; Aurelian''s Sol Invictus).', 'reviewed'
FROM entities e WHERE e.tradition='Roman' AND e.canonical_name IN ('Sol Invictus','Divus Augustus')
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;
-- ... and the rest of the Roman additions, which are Republican-era cults (pre-Christ).
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_ROM_REPUBLIC', 'A',
       'Republican-era Roman cult (state-virtue, rustic or Magna Mater cult; pre-Christ).', 'reviewed'
FROM entities e WHERE e.tradition='Roman'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Greek hybrid sub-traditions (Telchines, Trivia, Aion, the Korybantic/Anatolian figures).
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_GRK_HELLENISTIC', 'B',
       'Greek hybrid/syncretic figure of the Hellenistic-Roman Greek world.', 'reviewed'
FROM entities e WHERE e.tradition LIKE 'Greek/%'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- (2) Post-Christ additions -----------------------------------------------------
-- Hermetic/Theurgic (Corpus Hermeticum + the Chaldean-Neoplatonic theurgic orders).
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_HER_HELLENISTIC', 'A',
       'Hermetic/theurgic figure (Corpus Hermeticum, Chaldean Oracles, the Neoplatonists).', 'reviewed'
FROM entities e WHERE e.tradition='Hermetic/Theurgic'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Manichaean.
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_MAN_3RD_7TH', 'A',
       'Manichaean figure (Mani''s revelation and its flourishing, 3rd-7th c.).', 'reviewed'
FROM entities e WHERE e.tradition='Manichaean'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Mandaean.
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_LATE_ANTIQUE', 'A',
       'Mandaean figure (the late-antique lightworld/underworld of the Ginza and Qolasta).', 'reviewed'
FROM entities e WHERE e.tradition='Mandaean'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Christian / Christian-Biblical patristic build-out.
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_PATRISTIC', 'A',
       'Patristic-era Christian figure (the divine persons, the Revelation cast, the early martyrs).', 'reviewed'
FROM entities e WHERE e.tradition IN ('Christian','Christian/Biblical')
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Jewish Mystical rabbinic/Hekhalot additions (late antique: the Talmud, the Hekhalot).
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_LATE_ANTIQUE', 'A',
       'Late-antique rabbinic/Hekhalot figure (the Babylonian Talmud, the Merkavah literature).', 'reviewed'
FROM entities e WHERE e.tradition='Jewish Mystical'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- Islamic straggler.
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, review_status)
SELECT e.entity_id, 'PER_ISL_CLASSICAL', 'B',
       'Islamic-tradition figure of the classical period.', 'reviewed'
FROM entities e WHERE e.tradition='Islamic'
  AND NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
-- Era buckets after the fix (the only remaining undated should be Cross-traditional).
WITH e_era AS (
  SELECT e.entity_id, e.tradition, MIN(p.start_year) AS earliest
  FROM entities e
  LEFT JOIN entity_periods ep ON ep.entity_id=e.entity_id
  LEFT JOIN periods p ON p.period_id=ep.period_id
  GROUP BY e.entity_id, e.tradition)
SELECT CASE
   WHEN earliest IS NULL THEN '3. undated'
   WHEN earliest < 1 THEN '1. pre-Christ roots'
   ELSE '2. CE-origin' END AS era, count(*)
FROM e_era GROUP BY 1 ORDER BY 1;
SELECT 'remaining undated traditions' AS label, e.tradition, count(*) FROM entities e
WHERE NOT EXISTS (SELECT 1 FROM entity_periods ep WHERE ep.entity_id=e.entity_id)
GROUP BY e.tradition ORDER BY 3 DESC;
-- Zoroastrian sanity: every Zoroastrian entity now has a pre-Christ period.
SELECT 'Zoroastrian pre-Christ' AS label, count(*) FROM (
  SELECT e.entity_id FROM entities e JOIN entity_periods ep ON ep.entity_id=e.entity_id
  JOIN periods p ON p.period_id=ep.period_id WHERE e.tradition='Zoroastrian' AND p.start_year < 1
  GROUP BY e.entity_id) z;

COMMIT;
