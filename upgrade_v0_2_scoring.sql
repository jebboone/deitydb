-- deitydb v0.2 scoring upgrade
-- Adds an extensible scoring table for classical elements and planets.
-- Scores in entity_scores_seed_v0_2.csv are algorithmic seed scores and must be treated as needs_review.

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES (
  'SRC_INTERNAL_HEURISTIC_V0_2',
  'Internal heuristic scoring pass v0.2',
  NULL,
  'internal_method',
  'Algorithmic seed scores generated from v0.1 entity category, domains, tags, flags, and notes; for review only.'
)
ON CONFLICT (source_id) DO NOTHING;

CREATE TABLE IF NOT EXISTS entity_scores (
    entity_id text NOT NULL REFERENCES entities(entity_id),
    system text NOT NULL,
    score_name text NOT NULL,
    score integer CHECK (score >= 0 AND score <= 5),
    confidence text CHECK (confidence IN ('high', 'medium', 'low')),
    rationale text,
    source_id text REFERENCES sources(source_id),
    review_status text DEFAULT 'needs_review',
    created_at timestamp DEFAULT now(),
    updated_at timestamp DEFAULT now(),
    PRIMARY KEY (entity_id, system, score_name)
);

CREATE INDEX IF NOT EXISTS idx_entity_scores_system_name_score
ON entity_scores (system, score_name, score);

CREATE INDEX IF NOT EXISTS idx_entity_scores_entity
ON entity_scores (entity_id);

CREATE OR REPLACE VIEW v_entity_correspondences AS
SELECT
    e.entity_id,
    e.canonical_name,
    e.entity_type,
    e.category,
    e.primary_domains,
    e.tags,
    e.evidence_confidence,
    MAX(CASE WHEN es.system='classical_element' AND es.score_name='earth' THEN es.score END) AS earth_score,
    MAX(CASE WHEN es.system='classical_element' AND es.score_name='air' THEN es.score END) AS air_score,
    MAX(CASE WHEN es.system='classical_element' AND es.score_name='fire' THEN es.score END) AS fire_score,
    MAX(CASE WHEN es.system='classical_element' AND es.score_name='water' THEN es.score END) AS water_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='moon' THEN es.score END) AS moon_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='mercury' THEN es.score END) AS mercury_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='venus' THEN es.score END) AS venus_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='sun' THEN es.score END) AS sun_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='mars' THEN es.score END) AS mars_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='jupiter' THEN es.score END) AS jupiter_score,
    MAX(CASE WHEN es.system='classical_planet' AND es.score_name='saturn' THEN es.score END) AS saturn_score
FROM entities e
LEFT JOIN entity_scores es ON es.entity_id = e.entity_id
GROUP BY e.entity_id, e.canonical_name, e.entity_type, e.category, e.primary_domains, e.tags, e.evidence_confidence;
