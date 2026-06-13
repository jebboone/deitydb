-- Fix: unresolved staging relationships and unreviewed duplicates
-- Addresses the 12 unresolved_relationships and 2 unreviewed_duplicates
-- reported by v_release_metrics, restoring both counts to 0.
--
-- Run inside a transaction so the whole thing is atomic.

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- Part 1: staging_relationships cleanup
--
-- All 9 rows use `associated_with`, which is not in relationship_types.
-- 8 rows are superseded shadows: typed replacements already exist in
-- entity_relationships. 1 row (Leviathan → Serpent) has no live counterpart
-- and also targets the wrong entity (ENT_OPH_SERPENT, the Gnostic revealer,
-- not the serpent-monster category). All 9 are deleted here.
-- ─────────────────────────────────────────────────────────────────────────────

DELETE FROM staging_relationships
WHERE relationship_type = 'associated_with'
  AND source_id = 'SRC_DDD_CHRISTIAN'
  AND (subject_name, object_name) IN (
      ('Abaddon',              'Abyss'),
      ('Abaddon',              'Destruction'),
      ('Apollyon',             'Abaddon'),
      ('Apollyon',             'Destruction'),
      ('Behemoth',             'Chaos'),
      ('Dragon of Revelation', 'Dragon'),
      ('Dragon of Revelation', 'Satan'),
      ('Leviathan',            'Chaos'),
      ('Leviathan',            'Serpent')
  );

-- ─────────────────────────────────────────────────────────────────────────────
-- Part 2: Leviathan → Serpent gap
--
-- Replace the stale staging row with typed `member_of ENT_DRAGON` relationships
-- for both tradition variants. ENT_DRAGON is the cross-traditional
-- dragon/serpent-monster category. DDD (SRC_DDD_CHRISTIAN) is the source
-- for the CHR variant; the ISR Leviathan's other relationships cite
-- SRC_DDD_BIBLE, used here for consistency.
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_relationships
    (subject_entity_id, relationship_type, object_entity_id,
     confidence, rationale, source_id, review_status)
VALUES
    ('ENT_ISR_LEVIATHAN', 'member_of', 'ENT_DRAGON',
     'high',
     'Leviathan is a sea serpent/chaos dragon and belongs to the cross-traditional serpent-dragon monster category.',
     'SRC_DDD_BIBLE', 'reviewed'),
    ('ENT_CHR_LEVIATHAN', 'member_of', 'ENT_DRAGON',
     'high',
     'Leviathan is received in Christian tradition as a sea serpent/chaos dragon belonging to the cross-traditional serpent-dragon monster category.',
     'SRC_DDD_CHRISTIAN', 'reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Part 3: Seraphim duplicate review entries
--
-- ENT_CHR_SERAPHIM (Christian / Pseudo-Dionysius) and ENT_JM_SERAPHIM
-- (Jewish Mystical / Hekhalot) are intentionally distinct tradition-specific
-- entities, matching the pattern of all other reviewed duplicate pairs.
-- ─────────────────────────────────────────────────────────────────────────────

INSERT INTO entity_duplicate_review
    (canonical_name, entity_id, decision, duplicate_group_note)
VALUES
    ('Seraphim', 'ENT_CHR_SERAPHIM', 'intentional_distinct',
     'Reviewed duplicate canonical name; intentionally distinct tradition-specific entity.'),
    ('Seraphim', 'ENT_JM_SERAPHIM',  'intentional_distinct',
     'Reviewed duplicate canonical name; intentionally distinct tradition-specific entity.')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;

-- ─────────────────────────────────────────────────────────────────────────────
-- Part 4: Patch ENT_JM_SERAPHIM entity record
--
-- entity_type and review_status are missing; inclusion_basis and short_note
-- are blank. Filled to match ENT_CHR_SERAPHIM's level of completeness.
-- ─────────────────────────────────────────────────────────────────────────────

UPDATE entities SET
    entity_type      = 'Angelic order',
    review_status    = 'candidate_verified_name',
    inclusion_basis  = 'Jewish Mystical angelic order',
    short_note       = 'Fiery throne beings in Hekhalot / Jewish Mystical tradition; central to Merkabah liturgy.'
WHERE entity_id = 'ENT_JM_SERAPHIM'
  AND entity_type IS NULL;  -- guard: only apply if not already set

-- ─────────────────────────────────────────────────────────────────────────────
-- Verify: both metrics should now be 0
-- ─────────────────────────────────────────────────────────────────────────────

SELECT unresolved_relationships, unreviewed_duplicates FROM v_release_metrics;

COMMIT;
