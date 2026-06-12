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
## Core Relationship Types

### patron_of
Primary domain, phenomenon, office, constituency, or social function governed by an entity.

### embodies
Ontological personification or direct embodiment of an abstraction, force, or principle.

### member_of
Entity belongs to a collective, class, host, or structured divine grouping.

### has_member
Inverse of member_of.

### identified_with
Strong identity equivalence, later reception equation, or direct theological identification.

### aligned_with
Structural, symbolic, functional, or comparative analog without identity.

### paired_with
Stable theological, mythic, ritual, or cultic pairing.

### parent_of
Genealogical or emanational parenthood.

### child_of
Inverse of parent_of.

### emanates_from
Ontological derivation through emanation rather than biological generation.

### belongs_to_realm
Entity belongs to, originates from, or operates within a cosmological realm.

### dwells_in
Locative habitation.

### opposes
Active mythic, theological, or cosmological opposition.

### judges
Performs evaluative, juridical, or eschatological judgment.

### guides
Guides souls, beings, or initiates.

### reveals
Reveals divine knowledge, gnosis, or sacred teaching.

### teaches
Instructional transmission.

### deceives_or_tempts
Temptation, testing, corruption, or deceptive instruction.

### protects
Protective role.

### slays
Violent defeat.

### associated_ritual
Associated ritual or liturgical function.

## Residual Relationship

### associated_with
Reserved for unresolved, contextual, ambiguous, or weak associations not yet formalized.

Policy:
This should remain minimal and ideally under 10 records.
