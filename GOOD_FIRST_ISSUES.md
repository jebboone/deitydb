# Good First Issues

These are well-defined, self-contained tasks that don't require deep familiarity with the full database. Each has a clear success condition. Open an issue before starting so work isn't duplicated.

## Source work

**Add primary source links for Roman entities**
Many Roman entities are attested in Livy, Virgil (*Aeneid*), Cicero (*De Natura Deorum*), and Varro (*Antiquitates*), none of which are currently linked. Good scope: pick one source, find the entities it attests, write the `entity_sources` inserts with passage citations. See `scripts/add_source_linkage_remediation.sql` for the pattern.

**Add reception chains: Moses → Musa, Elijah → Ilyas**
`ENT_ISL_MUSA` and `ENT_ISL_ILYAS` are not yet in the database. These are the two most important Hebrew prophet → Quranic prophet reception chains. The Quran names both explicitly; the source `SRC_QURAN` is already registered. Task: add the two Islamic entities and the `received_as` relationship pairs.

**Review period coverage for Roman and Celtic entities**
Run:
```sql
SELECT e.entity_id, e.canonical_name
FROM entities e
LEFT JOIN entity_periods ep ON e.entity_id = ep.entity_id
WHERE e.tradition LIKE 'Roman%' AND ep.entity_id IS NULL;
```
Then assign periods using existing period IDs (see the `periods` table). Same pattern for `Celtic/%`.

## New entities

**Expand Welsh / Arthurian tradition**
The Four Branches of the Mabinogi are now in the DB but several figures from *Culhwch ac Olwen* and the Welsh Triads are still missing: Culhwch, Olwen, Ysbaddaden, Arthur (Welsh tradition), Mabon ap Modron, Cei, Bedwyr. Source: `SRC_MABINOGION` (already registered); secondary: `SRC_GREEN_CELTIC_GODS`.

**Add Works and Days personifications**
*Works and Days* (covered by `SRC_HESIOD_THEOGONY`) introduces Pandora and the Five Ages — figures not yet in the DB. Task: add `ENT_GRK_PANDORA` and the Five Ages cosmological eras as entities with appropriate Hesiod source links and `entity_periods` rows.

**Expand Greek tragedy figures**
Aeschylus, Sophocles, and Euripides attest many figures who are only stubs or absent: Electra, Clytemnestra, Agamemnon, Iphigenia, Medea, Antigone, Oedipus. None of the tragedy authors are registered as sources yet. Task: add one or two tragedy sources and link the entities they attest.

## Data and tooling

**Reception chain traversal query**
Add an example query to `examples/sample_queries.sql` — a recursive CTE over `entity_relationships` filtered to `received_as` / `reception_of` that traces a full transmission chain for a given entity (e.g. Tiamat → Lotan → Leviathan). A useful navigational tool for any contributor exploring the diachronic layer.

**Docker Compose setup**
`docs/install.md` describes manual Docker steps. A `docker-compose.yml` at the root would make setup one command. Task: write `docker-compose.yml` that starts postgres, creates the database, and mounts the schema. No seed data automation required — just the container.

**Tradition coverage report**
Add an example to `examples/sample_queries.sql` showing per-tradition: entity count, source count, average sources per entity, and count of entities with no period assignment. Useful for gap analysis and for orienting new contributors.

## Scholarly review

**Audit `associated_with` edges**
Three `associated_with` relationships remain in the graph. Run:
```sql
SELECT * FROM entity_relationships WHERE relationship_type = 'associated_with';
```
Open an issue proposing a typed replacement for any that can be narrowed (e.g. `patron_of`, `embodies`, `paired_with`). See `CONTRIBUTING.md` for the preferred relationship vocabulary.

**Psychopomp / funerary deity classification**
Several entities typed as 'god' or 'spirit' are primarily funerary or psychopomp figures (Anubis, Hecate, Osiris, Hermes in his chthonic role). Propose a consistent approach — a new `entity_type` value, or a `member_of` relationship to a funerary-function collective — and open an issue for discussion before implementing.
