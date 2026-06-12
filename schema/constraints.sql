-- Prevent duplicate semantic edges
ALTER TABLE entity_relationships
ADD CONSTRAINT unique_relationship
UNIQUE(subject_entity_id, relationship_type, object_entity_id);

-- Prevent self-parenting
ALTER TABLE entity_relationships
ADD CONSTRAINT no_self_parent
CHECK (
    NOT (
        relationship_type = 'parent_of'
        AND subject_entity_id = object_entity_id
    )
);

-- Prevent self-spouse
ALTER TABLE entity_relationships
ADD CONSTRAINT no_self_spouse
CHECK (
    NOT (
        relationship_type = 'spouse_of'
        AND subject_entity_id = object_entity_id
    )
);
