-- Relationship distribution
SELECT relationship_type, COUNT(*) AS count
FROM entity_relationships
GROUP BY relationship_type
ORDER BY count DESC;

-- Remaining generic relationships
SELECT
    er.relationship_id,
    s.canonical_name AS subject,
    o.canonical_name AS object,
    er.rationale,
    er.review_status
FROM entity_relationships er
JOIN entities s ON s.entity_id = er.subject_entity_id
JOIN entities o ON o.entity_id = er.object_entity_id
WHERE er.relationship_type = 'associated_with'
ORDER BY s.canonical_name;

-- Unreviewed relationships
SELECT relationship_type, review_status, COUNT(*) AS count
FROM entity_relationships
GROUP BY relationship_type, review_status
ORDER BY count DESC;
