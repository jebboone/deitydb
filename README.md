# DeityDB

DeityDB is an open comparative database of spiritual entities across Western religious traditions.

It includes gods, angels, demons, spirits, saints, heroes, aeons, archons, jinn, holy figures, cosmological realms, ritual categories, and symbolic abstractions.

The goal is to make religious entities queryable across traditions instead of leaving them isolated inside separate mythological silos.

## Live Explorer

**https://deitydb-explorer.fly.dev/**

A public read-only web interface with pre-built queries and a full SQL explorer — no installation required.

- [Tradition Overview](https://deitydb-explorer.fly.dev/deitydb/tradition-overview) — all 78 traditions by entity count
- [Cross-Traditional Parallels](https://deitydb-explorer.fly.dev/deitydb/cross-traditional-parallels) — entities linked across tradition boundaries
- [Reception Chains](https://deitydb-explorer.fly.dev/deitydb/reception-chain) — trace how a figure was renamed across traditions
- [Angelic Beings](https://deitydb-explorer.fly.dev/deitydb/angelic-beings), [Adversarial Beings](https://deitydb-explorer.fly.dev/deitydb/adversarial-beings), [Underworld Entities](https://deitydb-explorer.fly.dev/deitydb/underworld-entities), [Revealer Figures](https://deitydb-explorer.fly.dev/deitydb/revealer-figures)
- [About the project](https://deitydb-explorer.fly.dev/about) · [How to contribute](https://deitydb-explorer.fly.dev/contribute)

## Current Release — v1.35.0

- 1,371 entities
- 2,416 relationships
- 162 sources
- 78 tradition labels
- 0 unresolved relationship references; 0 unsourced entities or relationships
- duplicate-name review complete
- diachronic reception chains across traditions
- public query views, including a comparative-domains pivot (compare a function like
  Sovereignty or Healing across every tradition)
- 100% Greek entity period coverage (462/462)
- all Roman entities have primary-source coverage (Virgil, Livy, Cicero, Varro)

## Included Traditions

Seventy-eight tradition labels in all, including:

- Greek (462 entities; 100% period coverage)
- Egyptian, Mesopotamian, Canaanite / Ugaritic, Israelite / Second Temple
- Roman, Etruscan, Italic / Sabine
- Celtic (Irish, Welsh, Gaulish), Germanic / Norse, Baltic, Slavic, Finnish, Thracian, Dacian
- Phrygian, Hittite / Hurrian, Urartian, Elamite, Armenian, Mycenaean / Linear B
- Phoenician Iron Age, Aramean, Nabataean, Pre-Islamic / South Arabian, Transjordanian
  (Moabite, Ammonite, Edomite), Scythian, Iberian / Lusitanian, Meroitic
- Christian, Zoroastrian, Islamic (including Sufi and Shi'a), Jewish mystical (Merkavah and
  Kabbalah), Hermetic, late-antique ritual traditions
- Gnostic currents: Sethian, Valentinian, Ophite / Archontic, Simonian, Basilidean,
  Marcionite, Saturnilian, Carpocratian, Mandaean, Manichaean

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

-- Comparative-domain views: compare a divine function across every tradition
SELECT * FROM v_public_domain_overview;
SELECT * FROM v_public_comparative_domains WHERE domain = 'Sovereignty';
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

High-value areas: Christian mystical currents, Byzantine and patristic angelology, the
remaining Naassene/Peratae and minor Gnostic groups, Works and Days personifications
(Pandora, Five Ages), Greek tragedy source registration (Aeschylus, Sophocles, Euripides),
data visualization, and API or web-interface work. (The earlier targets — heresiology,
Sufism, and Kabbalah — are now substantially covered.)

## License

MIT. Copyright (c) Jeb Boone.
