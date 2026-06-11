# Religious Entity Seed Data — Greek v0.1

Generated: 2026-06-10

This is an import-ready seed package for a research-grade comparative religious entity database. It is deliberately structured as relational CSVs rather than one flat spreadsheet.

## Files
- `entities.csv`: canonical seed entities with category, entity type, domain summary, review status, and confidence.
- `names.csv`: canonical names. Add Greek spellings, variants, transliterations, and epithets here.
- `sources.csv`: source registry.
- `entity_sources.csv`: many-to-many link between entities and source records.
- `claims.csv`: atomic claims, currently mostly domains/tags. Later add cult, iconographic, textual, ritual, geographic, and relationship claims.
- `places.csv`: coarse seed place links for a few key cult figures; reconcile later against Pleiades IDs.
- `relationships.csv`: starter relationships such as parent/child, divine pair, or collective-member relations.

## Evidence confidence
- A = strong cult and/or widely attested religious figure; still verify details.
- B = secure mythographic/literary or index attestation; cult evidence varies.
- C = collective/type category or uncertain distinct entity.
- D = epithet/cult-title/aspect likely requiring normalization to another entity.

## Research caution
This is a seed corpus, not a final authority. It is designed to prevent hallucinated certainty by preserving review status and source provenance. Before publishing analysis, verify row-level claims against primary texts, inscriptions, cult archaeology, and scholarship.

## Suggested import order
1. sources.csv
2. entities.csv
3. names.csv
4. entity_sources.csv
5. claims.csv
6. places.csv
7. relationships.csv

## Recommended database
PostgreSQL/RDS/Cloud SQL. Add primary keys and foreign keys after initial import or create staging tables first, then transform into canonical tables.
