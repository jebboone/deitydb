# DeityDB Ontology

## Overview

DeityDB is a comparative knowledge graph of spiritual entities.

The database includes:

* gods
* goddesses
* angels
* demons
* jinn
* saints
* prophets
* heroes
* aeons
* archons
* daimones
* spirits
* monsters
* cosmological realms
* ritual categories
* personified abstractions

The goal is to preserve tradition-specific distinctions while enabling comparative analysis.

---

## Core Tables

### entities

Stores the primary nodes of the graph.

Examples:

* Zeus
* Michael
* Sophia
* Jibril
* Abathur
* Metatron
* Underworld
* Pleroma

---

### entity_relationships

Stores relationships between entities.

Examples:

* parent_of
* spouse_of
* protects
* opposes
* reveals
* teaches
* embodies
* dwells_in

---

### sources

Stores primary texts and scholarly references.

Examples:

* Nag Hammadi Corpus
* Qur'an
* Avesta
* Wilkinson
* Scholem

---

### entity_aliases

Stores alternate names.

Examples:

* Gabriel / Jibril
* Hermes / Mercurius
* Inanna / Ishtar

---

### entity_tradition_tags

Allows entities to belong to multiple traditions without collapsing distinctions.

---

## Design Principles

### Preserve Difference

DeityDB does not assume that entities from different traditions are equivalent.

### Prefer Specific Relationships

Use specific relationship types whenever evidence permits.

### Source Every Claim

Entities and relationships should be traceable to primary texts or scholarly sources.

### Comparative, Not Reductionist

The database supports comparison without asserting that traditions are identical.
