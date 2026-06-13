-- upgrade_v1_1_temporal.sql
-- Adds period_id column to entity_relationships, enabling temporal anchoring
-- of transmission and reception relationships.
-- Follows the upgrade_v0_2 / upgrade_v0_3 pattern.

BEGIN;

ALTER TABLE entity_relationships
ADD COLUMN IF NOT EXISTS period_id text REFERENCES periods(period_id);

CREATE INDEX IF NOT EXISTS idx_entity_relationships_period_id
ON entity_relationships(period_id)
WHERE period_id IS NOT NULL;

-- Verify
SELECT
    column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'entity_relationships' AND column_name = 'period_id';

COMMIT;
