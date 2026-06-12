# Contributor SQL Guide

This guide explains how to contribute new material to DeityDB using SQL.

DeityDB is a PostgreSQL database. Contributors should add material in small, reviewable batches with clear source support.

## Basic Contribution Workflow

1. Add or verify sources.
2. Add entities.
3. Add aliases.
4. Stage relationships.
5. Check unresolved relationships.
6. Add missing target entities if needed.
7. Import resolved relationships.
8. Run verification queries.
9. Submit a pull request.

Do not submit large unsourced dumps.

A good contribution is small, sourced, and easy to review.

---

# 1. Enter PostgreSQL

From the project directory:

```bash
docker exec -it deitydb psql -U postgres -d deitydb
```

Exit PostgreSQL with:

```sql
\q
```

---

# 2. Add Sources First

Every entity and relationship should point to a source.

Example:

```sql
INSERT INTO sources
(source_id, title, source_type, scope)
VALUES
('SRC_EXAMPLE_BOOK','Author, Title of Source','secondary source','Scope of what this source supports')
ON CONFLICT DO NOTHING;
```

## Source ID Rules

Use clear source IDs:

```text
SRC_IRENAEUS_AH
SRC_HESIOD_THEOGONY
SRC_QURAN
SRC_ZOHAR
SRC_AVESTA
```

Avoid vague IDs like:

```text
SRC_BOOK1
SRC_MISC
SRC_WEBSITE
```

---

# 3. Add Entities

Entities are the main nodes in the graph.

They may include:

* gods
* angels
* demons
* jinn
* saints
* prophets
* imams
* heroes
* aeons
* archons
* daimones
* spirits
* monsters
* cosmological realms
* ritual categories
* personified abstractions

Example:

```sql
INSERT INTO entities
(entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
('ENT_EXAMPLE_NAME','Example Name','Example Tradition','Entity type','Category','domain one; domain two; domain three','Cult or textual scope','A','candidate_verified_name','Brief inclusion reason',0,false,false,'Short explanatory note.')
ON CONFLICT DO NOTHING;
```

## Entity ID Rules

Entity IDs should be stable and readable.

Examples:

```text
ENT_GNO_SOPHIA
ENT_ISL_JIBRIL
ENT_JM_METATRON
ENT_ZOR_AHURA_MAZDA
```

Suggested prefixes:

```text
ENT_GRC_     Greek
ENT_ROM_     Roman
ENT_EGY_     Egyptian
ENT_MES_     Mesopotamian
ENT_CAN_     Canaanite / Ugaritic
ENT_ISR_     Israelite / Second Temple
ENT_CHR_     Christian
ENT_GNO_     General Gnostic
ENT_SET_     Sethian
ENT_VAL_     Valentinian
ENT_MAN_     Mandaean
ENT_MANICH_  Manichaean
ENT_ZOR_     Zoroastrian
ENT_ISL_     Islamic
ENT_JM_      Jewish Mystical
ENT_HER_     Hermetic
ENT_CEL_     Celtic
ENT_NOR_     Germanic / Norse
ENT_         Cross-traditional abstraction
```

## Evidence Confidence

Use:

```text
A = well-attested entity in primary or strong scholarly sources
B = solidly attested but needs more source precision
C = plausible but needs review
D = uncertain, use rarely
```

## Review Status

Use:

```text
candidate_verified_name
needs_review
```

Use `candidate_verified_name` when the entity name itself is stable and recognizable.

Use `needs_review` when the entity, classification, or source interpretation needs more attention.

## Earth Association Score

Use a 0–5 scale:

```text
0 = no earth/material/chthonic association
1 = very weak association
2 = mild association
3 = moderate association
4 = strong material, earth, craft, fertility, or chthonic association
5 = central earth, underworld, land, craft, fertility, or material-world association
```

## Boolean Flags

Use:

```sql
chthonic_flag = true
```

for underworld, death, grave, abyss, or lower-world beings.

Use:

```sql
serpent_flag = true
```

for serpents, dragons, snake beings, or serpent-associated figures.

---

# 4. Add Entity Scores

New entities should receive default score rows.

```sql
INSERT INTO entity_scores
(entity_id, system, score_name, score, confidence, rationale, source_id, review_status)
SELECT e.entity_id, s.system, s.score_name, 0, 'low',
       'Default seed score; revise during review.',
       'SRC_EXAMPLE_BOOK',
       'needs_review'
FROM entities e
CROSS JOIN (
    VALUES
    ('classical_element','earth'),
    ('classical_element','air'),
    ('classical_element','fire'),
    ('classical_element','water'),
    ('classical_planet','moon'),
    ('classical_planet','mercury'),
    ('classical_planet','venus'),
    ('classical_planet','sun'),
    ('classical_planet','mars'),
    ('classical_planet','jupiter'),
    ('classical_planet','saturn')
) AS s(system, score_name)
WHERE e.entity_id ILIKE 'ENT_EXAMPLE_%'
ON CONFLICT DO NOTHING;
```

---

# 5. Add Aliases

Aliases include variant spellings, original-language names, translations, transliterations, and titles.

Example:

```sql
INSERT INTO entity_aliases
(entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
VALUES
('ENT_EXAMPLE_NAME','Example Alias','variant spelling','English','SRC_EXAMPLE_BOOK','high','candidate_verified_name','Brief note.')
ON CONFLICT DO NOTHING;
```

Useful alias types:

```text
translation/common name
variant spelling
variant transliteration
original script
title/form
cult title
descriptive title
```

---

# 6. Stage Relationships

Do not directly insert relationships first.

Use the staging table:

```sql
TRUNCATE staging_relationships;
```

Then:

```sql
INSERT INTO staging_relationships
(subject_name, relationship_type, object_name, source_id, confidence, rationale, review_status)
VALUES
('Example Name','associated_with','Example Concept','SRC_EXAMPLE_BOOK','high','Explanation of why this relationship exists.','candidate_verified_name');
```

## Relationship Types

Preferred relationship types include:

```text
associated_with
parent_of
child_of
spouse_of
sibling_of
member_of
has_member
protects
opposes
slays
judges
guides
reveals
teaches
transmits
embodies
dwells_in
rules
rescues
mediates
associated_ritual
syncretized_with
equated_with
cult_form_of
```

Use specific relationships when evidence supports them.

Use:

```text
associated_with
```

only when the relationship is real but too broad or ambiguous for a more precise type.

---

# 7. Check Unresolved Relationships

After staging relationships, always run:

```sql
SELECT *
FROM v_staging_relationship_unresolved;
```

If this returns rows, the object or subject entity does not yet exist.

Either:

1. Add the missing entity, or
2. Correct the spelling/name in staging.

Do not import relationships until unresolved rows are fixed.

---

# 8. Import Resolved Relationships

Once unresolved rows are clear:

```sql
INSERT INTO entity_relationships
(subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
SELECT subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status
FROM v_staging_relationships_resolved
ON CONFLICT DO NOTHING;
```

Then verify:

```sql
SELECT COUNT(*) FROM entity_relationships;
```

---

# 9. Verification Queries

After a contribution, run:

```sql
SELECT COUNT(*) FROM v_staging_relationship_unresolved;
```

Expected:

```text
0
```

Check new entities:

```sql
SELECT canonical_name, tradition, category
FROM entities
WHERE entity_id ILIKE 'ENT_EXAMPLE_%'
ORDER BY canonical_name;
```

Check new relationships:

```sql
SELECT
  s.canonical_name AS subject,
  r.relationship_type,
  o.canonical_name AS object,
  r.source_id
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE s.entity_id ILIKE 'ENT_EXAMPLE_%'
ORDER BY subject, relationship_type, object;
```

---

# 10. Duplicate Names

Duplicate canonical names are allowed when they represent tradition-specific entities.

Examples:

```text
Apollo, Greek
Apollo, Roman
```

Do not merge entities only because they share a name.

If a duplicate is intentional, it should be reviewed in `entity_duplicate_review`.

---

# 11. What Makes a Good Pull Request?

A good pull request should:

* Add a small or medium-sized batch of material.
* Include sources.
* Use stable entity IDs.
* Avoid unsourced claims.
* Include relationship rationales.
* Leave no unresolved staging rows.
* Include verification output in the PR description.

Good PR title examples:

```text
Add Irenaeus source layer for Valentinian entities
Add Greek primary-source relationships from Hesiod
Expand Islamic jinn traditions from tafsir sources
Review Egyptian underworld entity relationships
```

Poor PR title examples:

```text
Add stuff
More gods
Update database
```

---

# 12. Example Mini-Contribution

```sql
INSERT INTO sources
(source_id, title, source_type, scope)
VALUES
('SRC_EXAMPLE_SOURCE','Example Author, Example Title','secondary source','Example tradition scope')
ON CONFLICT DO NOTHING;

INSERT INTO entities
(entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope, evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
('ENT_EXAMPLE_DEITY','Example Deity','Example Tradition','God','Example category','wisdom; craft; protection','Example scope','B','needs_review','Example contribution',2,false,false,'Short note about the entity.')
ON CONFLICT DO NOTHING;

INSERT INTO entity_aliases
(entity_id, alias_name, alias_type, language, source_id, confidence, review_status, notes)
VALUES
('ENT_EXAMPLE_DEITY','Example Alias','variant spelling','English','SRC_EXAMPLE_SOURCE','medium','needs_review','Example alias.')
ON CONFLICT DO NOTHING;

TRUNCATE staging_relationships;

INSERT INTO staging_relationships
(subject_name, relationship_type, object_name, source_id, confidence, rationale, review_status)
VALUES
('Example Deity','associated_with','Wisdom','SRC_EXAMPLE_SOURCE','medium','The source associates this figure with wisdom.','needs_review');

SELECT *
FROM v_staging_relationship_unresolved;

INSERT INTO entity_relationships
(subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
SELECT subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status
FROM v_staging_relationships_resolved
ON CONFLICT DO NOTHING;
```

---

# 13. Final Reminder

DeityDB is a comparative historical database.

It is not a devotional authority, a theological adjudicator, or a claim that all traditions are the same.

Preserve difference. Cite sources. Prefer precision.
