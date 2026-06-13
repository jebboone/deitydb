# DeityDB

DeityDB is an open comparative database of spiritual entities across Western religious traditions.

It includes gods, angels, demons, spirits, saints, heroes, aeons, archons, jinn, holy figures, cosmological realms, ritual categories, and symbolic abstractions.

The goal is to make religious entities queryable across traditions instead of leaving them isolated inside separate mythological silos.

## Current Release — v1.1.0

- 1,168 entities
- 1,349 relationships
- 114 sources
- 60+ tradition labels
- 0 unresolved relationship references
- duplicate-name review complete
- diachronic reception chains across traditions
- public query views included
- 100% Greek entity period coverage (466/466)
- all Roman entities have primary-source coverage (Virgil, Livy, Cicero, Varro)

## Included Traditions

- Greek (466 entities; 100% period coverage)
- Egyptian
- Mesopotamian
- Canaanite / Ugaritic
- Israelite / Second Temple
- Roman
- Celtic (Irish, Welsh, and Gaulish)
- Germanic / Norse
- Christian
- Gnostic
- Mandaean
- Manichaean
- Zoroastrian
- Islamic (including Sufi and Shi'a)
- Jewish mystical
- Hermetic
- Late antique ritual traditions
- Etruscan (Pyrgi tablets; Piacenza liver)
- Scythian (Herodotus Histories 4.59–62)
- Phrygian (Matar Kubileya; Agdistis; Roller 1999)
- Pre-Islamic Arabian
- South Arabian / Sabaean
- Phoenician Iron Age
- Hittite / Hurrian
- Mycenaean / Linear B

## What Can DeityDB Do?

Example questions:

- Which traditions have serpent or dragon beings?
- Which entities reveal hidden knowledge?
- Which beings are associated with the underworld?
- How do angels, jinn, daimones, archons, and aeons compare?
- Which figures function as holy human intermediaries rather than gods?
- How do concepts like wisdom, justice, death, protection, and revelation move across traditions?
- How did Greek gods get reinterpreted as demons in early Christian sources?
- Which Mesopotamian figures have reception chains into Greek mythology?

## Public Views

```sql
SELECT * FROM v_release_metrics;
SELECT * FROM v_public_tradition_overview;
SELECT * FROM v_public_relationship_overview;
SELECT * FROM v_public_revealer_figures;
SELECT * FROM v_public_underworld_entities;
SELECT * FROM v_public_angelic_beings;
SELECT * FROM v_public_adversarial_beings;
SELECT * FROM v_public_serpent_dragon_beings;
SELECT * FROM v_public_wisdom_knowledge_beings;
SELECT * FROM v_public_relationship_triples LIMIT 50;
```

See `examples/sample_queries.sql` for more.

## Quick Start

Requires Docker.

```bash
git clone https://github.com/jebboone/deitydb.git
cd deitydb
docker run --name deitydb -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:15
docker exec -i deitydb psql -U postgres -c "CREATE DATABASE deitydb;"
docker exec -i deitydb psql -U postgres -d deitydb < schema_postgres.sql
```

See `docs/install.md` for the full setup guide including seed data and views.

## Design Principle

DeityDB does not treat all religious entities as gods.

It distinguishes between:

- gods
- angels
- demons
- jinn
- saints
- prophets
- imams
- heroes
- aeons
- archons
- daimones
- spirits
- monsters
- cosmological realms
- ritual categories
- personified abstractions

This allows comparison without collapsing every tradition into the same theological category.

## Contributing

See `CONTRIBUTING.md` and `GOOD_FIRST_ISSUES.md`.

High-value areas: heresiology (Irenaeus, Epiphanius), Islamic tafsir / sira / Sufi expansion, Jewish Kabbalistic expansion, Moses → Musa / Elijah → Ilyas reception chains, Works and Days personifications (Pandora, Five Ages), Greek tragedy source registration (Aeschylus, Sophocles, Euripides), data visualization, API or web interface.

## License

MIT. Copyright (c) Jeb Boone.
