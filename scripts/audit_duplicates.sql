-- Possible duplicate entity names
SELECT canonical_name, COUNT(*) AS count
FROM entities
GROUP BY canonical_name
HAVING COUNT(*) > 1
ORDER BY count DESC, canonical_name;

-- Duplicate relationship edges
SELECT subject_entity_id, relationship_type, object_entity_id, COUNT(*) AS count
FROM entity_relationships
GROUP BY subject_entity_id, relationship_type, object_entity_id
HAVING COUNT(*) > 1
ORDER BY count DESC;
