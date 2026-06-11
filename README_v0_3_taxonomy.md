# REDB v0.3 Taxonomy Upgrade

This package adds structured, reviewable tables for:

- animals
- plants
- metals
- functions
- regions

The seed rows were extracted from the existing v0.1/v0.2 database fields:
entities.primary_domains, entities.tags, entities.short_note, claims.claim_value, and places.

Counts:
- animals vocab: 3
- entity_animals rows: 7
- plants vocab: 9
- entity_plants rows: 21
- metals vocab: 3
- entity_metals rows: 7
- functions vocab: 49
- entity_functions rows: 531
- regions vocab: 9
- entity_regions rows: 397

All generated rows are marked as candidate_extracted or inherited from the prior seed status.
They should be reviewed before publication.
