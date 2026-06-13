-- Item 2: Add received_as / reception_of relationship types
-- These directed types encode historical transmission: subject (earlier entity)
-- was received/reinterpreted as object (later entity) in a subsequent tradition.

BEGIN;

INSERT INTO relationship_types (relationship_type, description)
VALUES
    ('received_as',
     'Directed transmission: the subject (entity in an earlier tradition) was received, reinterpreted, or transmitted as the object (entity in a later tradition or reception context). Captures historical transformation across traditions and periods. Use with period_id on the relationship to anchor the moment of reception.'),
    ('reception_of',
     'Inverse of received_as: the subject (later tradition entity) is a reception, reinterpretation, or derivative of the object (earlier entity). Use to query backward from a reception form to its source.')
ON CONFLICT DO NOTHING;

SELECT relationship_type, description FROM relationship_types
WHERE relationship_type IN ('received_as','reception_of');

COMMIT;
