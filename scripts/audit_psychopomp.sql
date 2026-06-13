-- Psychopomp categorization audit
-- Identifies entities with confirmed soul-escort roles missing psychopomp
-- classification in primary_domains or the guides ENT_DEAD relationship.

-- 1. Currently tagged psychopomps
SELECT e.entity_id, e.canonical_name, e.tradition, e.primary_domains, e.tags,
       COUNT(er.relationship_id) FILTER (
           WHERE er.relationship_type = 'guides' AND er.object_entity_id = 'ENT_DEAD'
       ) AS has_guides_dead
FROM entities e
LEFT JOIN entity_relationships er ON er.subject_entity_id = e.entity_id
WHERE lower(e.primary_domains) LIKE '%psychopomp%'
   OR lower(e.tags) LIKE '%psychopomp%'
GROUP BY e.entity_id, e.canonical_name, e.tradition, e.primary_domains, e.tags
ORDER BY e.tradition, e.canonical_name;

-- 2. Entities with guides ENT_DEAD but no psychopomp tag
SELECT e.entity_id, e.canonical_name, e.tradition, e.primary_domains
FROM entity_relationships er
JOIN entities e ON e.entity_id = er.subject_entity_id
WHERE er.relationship_type = 'guides'
  AND er.object_entity_id = 'ENT_DEAD'
  AND lower(COALESCE(e.primary_domains, '')) NOT LIKE '%psychopomp%'
  AND lower(COALESCE(e.tags, '')) NOT LIKE '%psychopomp%'
ORDER BY e.tradition, e.canonical_name;

-- 3. Tier 1 candidates assessed in this audit
SELECT e.entity_id, e.canonical_name, e.tradition, e.primary_domains,
       EXISTS (
           SELECT 1 FROM entity_relationships er
           WHERE er.subject_entity_id = e.entity_id
             AND er.relationship_type = 'guides'
             AND er.object_entity_id = 'ENT_DEAD'
       ) AS has_guides_dead
FROM entities e
WHERE e.entity_id IN (
    'ENT_NOR_VALKYRIES', 'ENT_THANATOS', 'ENT_ROM_MERCURY',
    'ENT_ISR_ANGEL_OF_DEATH', 'ENT_ZOR_SRAOSHA'
)
ORDER BY e.tradition, e.canonical_name;
