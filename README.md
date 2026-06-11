# DeityDB

DeityDB is an open comparative database of spiritual entities across Western religious traditions.

It includes gods, angels, demons, spirits, saints, heroes, aeons, archons, jinn, holy figures, cosmological realms, ritual categories, and symbolic abstractions.

The goal is to make religious entities queryable across traditions instead of leaving them isolated inside separate mythological silos.

## Current Release Candidate

- 1,000+ entities
- 900+ relationships
- 60+ sources
- 40+ tradition labels
- 0 unresolved relationship references
- duplicate-name review complete
- public query views included

## Included Traditions

Current coverage includes:

- Greek
- Egyptian
- Mesopotamian
- Canaanite / Ugaritic
- Israelite / Second Temple
- Roman
- Celtic
- Germanic / Norse
- Christian
- Gnostic
- Mandaean
- Manichaean
- Zoroastrian
- Islamic
- Sufi and Shi'a Islamic
- Jewish mystical
- Hermetic
- Late antique ritual traditions

## What Can DeityDB Do?

Example questions:

- Which traditions have serpent or dragon beings?
- Which entities reveal hidden knowledge?
- Which beings are associated with the underworld?
- How do angels, jinn, daimones, archons, and aeons compare?
- Which figures function as holy human intermediaries rather than gods?
- How do concepts like wisdom, justice, death, protection, and revelation move across traditions?

## Public Views

Useful views include:

- `v_release_metrics`
- `v_public_tradition_overview`
- `v_public_relationship_overview`
- `v_public_revealer_figures`
- `v_public_underworld_entities`
- `v_public_angelic_beings`
- `v_public_adversarial_beings`
- `v_public_serpent_dragon_beings`
- `v_public_wisdom_knowledge_beings`
- `v_public_relationship_triples`

## Sample Queries

See:

```text
examples/sample_queries.sql
## Sample Queries

See:

`examples/sample_queries.sql`

## Design Principle

DeityDB does not treat all religious entities as gods.

It distinguishes between:

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

This allows comparison without collapsing every tradition into the same theological category.

## Contributing

Contributors are welcome.

High-value contribution areas:

* primary-source upgrades
* Greek and Egyptian source refinement
* Irenaeus and early Christian heresiology
* Islamic tafsir, sira, and Sufi traditions
* Jewish mystical and Kabbalistic expansion
* data visualization
* API or web interface development
* scholarly review of existing relationship types

## License

MIT License.

Copyright (c) 2026 Apostolic Johannite Church.
