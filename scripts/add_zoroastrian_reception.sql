-- scripts/add_zoroastrian_reception.sql
-- Systematic reception chains: Zoroastrian → Israelite/Second Temple Jewish
--
-- Key transmissions: Aeshma Daeva→Asmodeus (high, name derivation secure),
-- Angra Mainyu→Satan (medium, scholarly consensus on structural influence),
-- Amesha Spentas→archangel emergence (low, structural parallel).
--
-- New entity: ENT_ZOR_AESHMA_DAEVA (demon of wrath; previously missing, needed to
-- close the Asmodeus chain). Also fixes ENT_LAT_ASMODEUS stub (no type/confidence).
-- New source: SRC_TOBIT (primary attestation of Asmodeus in Tobit 3:8).
--
-- Requires: upgrade_v1_1_temporal.sql, add_canaanite_israelite_reception.sql
-- (periods table and received_as/reception_of types must be present)

BEGIN;

-- ── 1. New source ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_TOBIT',
   'Book of Tobit',
   NULL,
   'primary text',
   'Deuterocanonical/apocryphal Second Temple text (c. 3rd–2nd century BCE); primary attestation of Asmodeus (Tobit 3:8, 8:3) as demon who kills Sarah''s husbands and is bound by Raphael using fish gall; key evidence for Zoroastrian demonological influence on Second Temple Judaism')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New Zoroastrian entity: Aeshma Daeva ────────────────────────────────
-- Previously absent; required to close the Aeshma Daeva→Asmodeus chain.
-- Primary attestation: Yasna 29.2; Vidēvdād (Vendidad) 10.9, 18.15.

INSERT INTO entities
  (entity_id, canonical_name, tradition, entity_type, evidence_confidence,
   primary_period, inclusion_basis, short_note)
VALUES
  ('ENT_ZOR_AESHMA_DAEVA',
   'Aeshma Daeva',
   'Zoroastrian',
   'Demon',
   'A',
   'PER_ZOR_ACHAEMENID',
   'Named in Avestan primary texts (Yasna, Vidēvdād) as demon of wrath; etymological source of Hebrew Asmodeus',
   'Avestan demon of wrath (aēšma, "wrath/violence"); one of the six archdemons opposing the Amesha Spentas; Vidēvdād 10.9 names him as Aeshma of the bloody mace. Name is the direct etymological source of Hebrew Ashmedai / Asmodeus (Tobit 3:8).')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_ZOR_AESHMA_DAEVA', 'SRC_AVESTA', 'primary_attestation',
   'Yasna 29.2; Vidēvdād (Vendidad) 10.9 and 18.15 — Aeshma Daeva as demon of wrath and violence, opponent of Sraosha')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, source_id, review_status)
VALUES
  ('ENT_ZOR_AESHMA_DAEVA', 'PER_ZOR_ACHAEMENID', 'high', 'SRC_AVESTA', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 3. Fix ENT_LAT_ASMODEUS stub ───────────────────────────────────────────
-- Entity exists but lacks type, confidence, and sourcing.

UPDATE entities
SET entity_type        = 'Demon',
    evidence_confidence = 'A',
    inclusion_basis    = 'Primary attestation in Book of Tobit 3:8; Second Temple demonology',
    short_note         = 'Demonic figure who kills the seven husbands of Sarah (Tobit 3:8); bound in Egypt by the angel Raphael using fish-liver smoke (Tobit 8:3). Name derives from Avestan Aeshma Daeva. Key evidence for Zoroastrian demonological influence on Jewish Second Temple literature.'
WHERE entity_id = 'ENT_LAT_ASMODEUS';

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_LAT_ASMODEUS', 'SRC_TOBIT',   'primary_attestation',
   'Tobit 3:8 (Asmodeus kills Sarah''s husbands); 8:3 (Raphael binds him in Upper Egypt)'),
  ('ENT_LAT_ASMODEUS', 'SRC_DDD_BIBLE', 'secondary_reference',
   'DDD_BIBLE s.v. "Asmodeus" — traces name derivation from Avestan Aeshma Daeva and Second Temple reception')
ON CONFLICT DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, source_id, review_status)
VALUES
  ('ENT_LAT_ASMODEUS', 'PER_ISR_SECOND_TEMPLE', 'high', 'SRC_TOBIT', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 4. Transmission chains ─────────────────────────────────────────────────

-- 4a. Aeshma Daeva → Asmodeus: name derivation, highest confidence in this batch
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ZOR_AESHMA_DAEVA', 'received_as', 'ENT_LAT_ASMODEUS',
   'high',
   'Aeshma Daeva (Avestan: aēšma daēuua, "demon of wrath") is the direct etymological source of Hebrew Ashmedai / Greek Asmodeus. Tobit 3:8 introduces Asmodeus as the demon who has killed each of Sarah''s seven husbands; Raphael binds him in Egypt (8:3). The name derivation (aēšma → Ashm-dai) is philologically secure. DDD_BIBLE s.v. "Asmodeus" and Boyce document the transmission. This is one of the clearest cross-traditional demonic transmissions in Second Temple literature.',
   'SRC_TOBIT', 'reviewed', 'PER_ISR_SECOND_TEMPLE'),
  ('ENT_LAT_ASMODEUS', 'reception_of', 'ENT_ZOR_AESHMA_DAEVA',
   'high',
   'Asmodeus as Israelite/Jewish reception of Avestan Aeshma Daeva; name derivation philologically secure; role (demon of wrath/lust causing harm to humans) cognate.',
   'SRC_TOBIT', 'reviewed', 'PER_ISR_SECOND_TEMPLE')
ON CONFLICT DO NOTHING;

-- 4b. Angra Mainyu → Satan: cosmic adversary structural influence
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ZOR_ANGRA_MAINYU', 'received_as', 'ENT_ISR_SATAN',
   'medium',
   'In early Hebrew texts, "the satan" (the accuser) is a member of Yahweh''s heavenly court (Job 1–2; Zechariah 3:1–2) — not an independent cosmic evil. The development of Satan as an independent adversarial power opposing God (1 Enoch 6–11; Jubilees 10; later Revelation) parallels the Zoroastrian Angra Mainyu (cosmic adversary of Ahura Mazda, independent evil principle). Jews under Persian/Achaemenid rule (6th–4th c. BCE) had direct access to Zoroastrian theology; Boyce and DDD_BIBLE s.v. "Satan" both discuss the probable structural influence. Confidence medium: the development could be endogenous; the influence is probable but not textually demonstrable.',
   'SRC_BOYCE_ZOROASTRIANS', 'reviewed', 'PER_ISR_EXILIC'),
  ('ENT_ISR_SATAN', 'reception_of', 'ENT_ZOR_ANGRA_MAINYU',
   'medium',
   'Satan''s development from court accuser to independent cosmic adversary shows probable structural influence from Zoroastrian Angra Mainyu during the Babylonian exile and Persian period.',
   'SRC_BOYCE_ZOROASTRIANS', 'reviewed', 'PER_ISR_EXILIC')
ON CONFLICT DO NOTHING;

-- 4c. Amesha Spentas → archangel emergence: structural parallel (low)
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_ZOR_AMESHA_SPENTAS', 'received_as', 'ENT_ISR_MICHAEL',
   'low',
   'The six Amesha Spentas (divine beings surrounding Ahura Mazda, each embodying a virtue) parallel the emergence of named archangels surrounding Yahweh in Second Temple angelology (1 Enoch 20 names seven: Michael, Gabriel, Raphael, Uriel, Saraqael, Raguel, Remiel). Both systems feature a high god surrounded by a council of named divine beings, each with a specific cosmic domain, in traditions that were in direct contact during the Persian period. Michael is cited as the most prominent archangel. Confidence low: the structural parallel is suggestive but the transmission is not textually demonstrable; parallel development is possible.',
   'SRC_BOYCE_ZOROASTRIANS', 'reviewed', 'PER_ISR_SECOND_TEMPLE'),
  ('ENT_ISR_MICHAEL', 'reception_of', 'ENT_ZOR_AMESHA_SPENTAS',
   'low',
   'Emergence of named archangels (here: Michael as representative) as structural parallel to Amesha Spentas; both systems place named divine councillors around the high god with specific cosmic domains. Low confidence: structural parallel, not proven transmission.',
   'SRC_BOYCE_ZOROASTRIANS', 'reviewed', 'PER_ISR_SECOND_TEMPLE')
ON CONFLICT DO NOTHING;

-- ── 5. Verification ────────────────────────────────────────────────────────

SELECT 'zoroastrian_reception_chains' AS metric,
       COUNT(*) AS count
FROM entity_relationships
WHERE relationship_type IN ('received_as','reception_of')
AND (subject_entity_id LIKE 'ENT_ZOR_%' OR object_entity_id LIKE 'ENT_ZOR_%');

SELECT 'asmodeus_fix' AS check,
       entity_type, evidence_confidence
FROM entities WHERE entity_id = 'ENT_LAT_ASMODEUS';

SELECT * FROM v_release_metrics;

COMMIT;
