-- REDB v0.3 taxonomy upgrade
-- Adds structured tables for animals, plants, metals, functions, and regions.
-- Import vocabulary CSVs first, then entity link CSVs.

CREATE TABLE IF NOT EXISTS animals (
    animal text PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS plants (
    plant text PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS metals (
    metal text PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS functions (
    function_name text PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS regions (
    region text PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS entity_animals (
    entity_id text REFERENCES entities(entity_id),
    animal text REFERENCES animals(animal),
    confidence text,
    rationale text,
    source_id text,
    review_status text,
    PRIMARY KEY (entity_id, animal)
);

CREATE TABLE IF NOT EXISTS entity_plants (
    entity_id text REFERENCES entities(entity_id),
    plant text REFERENCES plants(plant),
    confidence text,
    rationale text,
    source_id text,
    review_status text,
    PRIMARY KEY (entity_id, plant)
);

CREATE TABLE IF NOT EXISTS entity_metals (
    entity_id text REFERENCES entities(entity_id),
    metal text REFERENCES metals(metal),
    confidence text,
    rationale text,
    source_id text,
    review_status text,
    PRIMARY KEY (entity_id, metal)
);

CREATE TABLE IF NOT EXISTS entity_functions (
    entity_id text REFERENCES entities(entity_id),
    function_name text REFERENCES functions(function_name),
    confidence text,
    rationale text,
    source_id text,
    review_status text,
    PRIMARY KEY (entity_id, function_name)
);

CREATE TABLE IF NOT EXISTS entity_regions (
    entity_id text REFERENCES entities(entity_id),
    region text REFERENCES regions(region),
    confidence text,
    rationale text,
    source_id text,
    review_status text,
    PRIMARY KEY (entity_id, region)
);

CREATE INDEX IF NOT EXISTS idx_entity_animals_animal ON entity_animals(animal);
CREATE INDEX IF NOT EXISTS idx_entity_plants_plant ON entity_plants(plant);
CREATE INDEX IF NOT EXISTS idx_entity_metals_metal ON entity_metals(metal);
CREATE INDEX IF NOT EXISTS idx_entity_functions_function ON entity_functions(function_name);
CREATE INDEX IF NOT EXISTS idx_entity_regions_region ON entity_regions(region);

DROP VIEW IF EXISTS v_entity_taxonomy_summary;
CREATE VIEW v_entity_taxonomy_summary AS
SELECT
    e.entity_id,
    e.canonical_name,
    e.entity_type,
    e.category,
    e.primary_domains,
    COALESCE(string_agg(DISTINCT ea.animal, '; '), '') AS animals,
    COALESCE(string_agg(DISTINCT ep.plant, '; '), '') AS plants,
    COALESCE(string_agg(DISTINCT em.metal, '; '), '') AS metals,
    COALESCE(string_agg(DISTINCT ef.function_name, '; '), '') AS functions,
    COALESCE(string_agg(DISTINCT er.region, '; '), '') AS regions
FROM entities e
LEFT JOIN entity_animals ea ON e.entity_id = ea.entity_id
LEFT JOIN entity_plants ep ON e.entity_id = ep.entity_id
LEFT JOIN entity_metals em ON e.entity_id = em.entity_id
LEFT JOIN entity_functions ef ON e.entity_id = ef.entity_id
LEFT JOIN entity_regions er ON e.entity_id = er.entity_id
GROUP BY
    e.entity_id,
    e.canonical_name,
    e.entity_type,
    e.category,
    e.primary_domains;
