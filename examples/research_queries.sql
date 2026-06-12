-- All storm gods across traditions
SELECT canonical_name, tradition
FROM entities
WHERE primary_domains ILIKE '%storm%';

-- Cross-tradition death judges
SELECT e.canonical_name, t.name
FROM entity_relationships r
JOIN entities e ON r.subject_entity_id = e.entity_id
WHERE r.relationship_type = 'judges';

-- Entities aligned with Anthropos
SELECT s.canonical_name
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE r.relationship_type = 'aligned_with'
AND o.canonical_name = 'Anthropos';
