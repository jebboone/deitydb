CREATE VIEW relationship_distribution AS
SELECT relationship_type, COUNT(*) AS count
FROM entity_relationships
GROUP BY relationship_type
ORDER BY count DESC;

CREATE VIEW unresolved_relationships AS
SELECT *
FROM entity_relationships
WHERE review_status != 'reviewed';

CREATE VIEW generic_associations AS
SELECT *
FROM entity_relationships
WHERE relationship_type = 'associated_with';
