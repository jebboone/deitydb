-- PostgreSQL seed schema for Religious Entity Database v0.1
-- Import order: sources, entities, names, entity_sources, claims, places, relationships.

CREATE TABLE IF NOT EXISTS sources (
  source_id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  url TEXT,
  source_type TEXT,
  scope TEXT
);

CREATE TABLE IF NOT EXISTS entities (
  entity_id TEXT PRIMARY KEY,
  canonical_name TEXT NOT NULL,
  greek_name TEXT,
  tradition TEXT,
  entity_type TEXT,
  category TEXT,
  primary_domains TEXT,
  tags TEXT,
  cult_scope TEXT,
  primary_period TEXT,
  evidence_confidence TEXT CHECK (evidence_confidence IN ('A','B','C','D')),
  review_status TEXT,
  inclusion_basis TEXT,
  earth_association_score INTEGER CHECK (earth_association_score BETWEEN 0 AND 5),
  chthonic_flag BOOLEAN,
  serpent_flag BOOLEAN,
  short_note TEXT
);

CREATE TABLE IF NOT EXISTS names (
  entity_id TEXT REFERENCES entities(entity_id),
  name TEXT NOT NULL,
  name_type TEXT,
  language TEXT,
  source_id TEXT REFERENCES sources(source_id)
);

CREATE TABLE IF NOT EXISTS entity_sources (
  entity_id TEXT REFERENCES entities(entity_id),
  source_id TEXT REFERENCES sources(source_id),
  evidence_type TEXT,
  source_note TEXT,
  PRIMARY KEY(entity_id, source_id, evidence_type)
);

CREATE TABLE IF NOT EXISTS claims (
  claim_id TEXT PRIMARY KEY,
  entity_id TEXT REFERENCES entities(entity_id),
  claim_type TEXT NOT NULL,
  claim_value TEXT NOT NULL,
  confidence TEXT CHECK (confidence IN ('A','B','C','D')),
  source_id TEXT REFERENCES sources(source_id),
  review_status TEXT
);

CREATE TABLE IF NOT EXISTS places (
  entity_id TEXT REFERENCES entities(entity_id),
  place_name TEXT NOT NULL,
  place_type TEXT,
  place_authority_id TEXT,
  source_id TEXT REFERENCES sources(source_id),
  confidence TEXT CHECK (confidence IN ('A','B','C','D')),
  review_status TEXT
);

CREATE TABLE IF NOT EXISTS relationships (
  subject_entity_id TEXT REFERENCES entities(entity_id),
  object_entity_id TEXT REFERENCES entities(entity_id),
  relationship_type TEXT NOT NULL,
  confidence TEXT CHECK (confidence IN ('A','B','C','D')),
  source_id TEXT REFERENCES sources(source_id),
  review_status TEXT
);

CREATE INDEX IF NOT EXISTS idx_entities_name ON entities(canonical_name);
CREATE INDEX IF NOT EXISTS idx_entities_type ON entities(entity_type);
CREATE INDEX IF NOT EXISTS idx_entities_category ON entities(category);
CREATE INDEX IF NOT EXISTS idx_entities_confidence ON entities(evidence_confidence);
CREATE INDEX IF NOT EXISTS idx_claims_entity ON claims(entity_id);
CREATE INDEX IF NOT EXISTS idx_claims_type_value ON claims(claim_type, claim_value);
