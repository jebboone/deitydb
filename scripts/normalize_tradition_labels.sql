-- normalize_tradition_labels.sql
-- Consolidates 3 tradition label inconsistencies; 62 labels → 59.
-- No entity IDs, relationship references, or source links change.
--
-- Changes:
--   1. 'Shi'a Islam/Islamic' (3)   → 'Islamic/Shi'a'
--      Standardises on the Islamic/X pattern; same entities, same tradition.
--      Affected: ENT_ISL_ALI, ENT_ISL_HUSAYN, ENT_ISL_MAHDI
--
--   2. 'Sethian/Ophite' (3)        → 'Sethian'
--   3. 'Ophite/Sethian' (1)        → 'Sethian'
--      Both labels refer to the same cluster; primary attestation is
--      Sethian (Apocryphon of John, Gospel of Egyptians).
--      Affected: ENT_GNO_SABAOTH, ENT_GNO_SAKLAS, ENT_GNO_YALDABAOTH,
--                ENT_OPH_EVE_ZOE
--
--   4. 'Gnostic/Platonic' (2)      → 'Gnostic'
--   5. 'Christian/Gnostic' (4)     → 'Gnostic'
--      Both are sub-labels for generic Gnostic concepts (ENT_GNO_ IDs).
--      Affected: ENT_GNO_DEMIURGE, ENT_GNO_NOUS,
--                ENT_CROSS, ENT_GNO_CHRIST, ENT_GNO_HOLY_SPIRIT, ENT_GNO_LOGOS

BEGIN;

-- ── Pre-flight: snapshot rows that will change ────────────────────────
SELECT entity_id, canonical_name, tradition AS old_tradition
FROM entities
WHERE tradition IN (
    'Shi''a Islam/Islamic',
    'Sethian/Ophite', 'Ophite/Sethian',
    'Gnostic/Platonic', 'Christian/Gnostic'
)
ORDER BY tradition, entity_id;

-- ── 1. Islamic naming consistency ─────────────────────────────────────
UPDATE entities
SET tradition = 'Islamic/Shi''a'
WHERE tradition = 'Shi''a Islam/Islamic';

-- ── 2+3. Sethian/Ophite label collision ───────────────────────────────
UPDATE entities
SET tradition = 'Sethian'
WHERE tradition IN ('Sethian/Ophite', 'Ophite/Sethian');

-- ── 4+5. Gnostic sub-label consolidation ─────────────────────────────
UPDATE entities
SET tradition = 'Gnostic'
WHERE tradition IN ('Gnostic/Platonic', 'Christian/Gnostic');

-- ── Post-flight: verify counts ────────────────────────────────────────
-- Old labels should be gone
SELECT tradition, COUNT(*) AS remaining
FROM entities
WHERE tradition IN (
    'Shi''a Islam/Islamic',
    'Sethian/Ophite', 'Ophite/Sethian',
    'Gnostic/Platonic', 'Christian/Gnostic'
)
GROUP BY tradition;

-- Receiving labels should have grown
SELECT tradition, COUNT(*) AS entities
FROM entities
WHERE tradition IN ('Islamic/Shi''a', 'Sethian', 'Gnostic')
GROUP BY tradition
ORDER BY tradition;

-- Total entity count must be unchanged
SELECT COUNT(*) AS total_entities FROM entities;

-- Zero dangling relationship references
SELECT COUNT(*) AS dangling_subject
FROM entity_relationships er
WHERE NOT EXISTS (
    SELECT 1 FROM entities e WHERE e.entity_id = er.subject_entity_id
);

SELECT COUNT(*) AS dangling_object
FROM entity_relationships er
WHERE NOT EXISTS (
    SELECT 1 FROM entities e WHERE e.entity_id = er.object_entity_id
);

COMMIT;
