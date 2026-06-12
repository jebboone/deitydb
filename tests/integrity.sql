-- No duplicate edges
SELECT subject_entity_id, relationship_type, object_entity_id, COUNT(*)
FROM entity_relationships
GROUP BY 1,2,3
HAVING COUNT(*) > 1;

-- No orphan relationships
SELECT *
FROM entity_relationships er
LEFT JOIN entities s ON s.entity_id = er.subject_entity_id
LEFT JOIN entities o ON o.entity_id = er.object_entity_id
WHERE s.entity_id IS NULL
   OR o.entity_id IS NULL;

-- No null rationales
SELECT *
FROM entity_relationships
WHERE rationale IS NULL;
