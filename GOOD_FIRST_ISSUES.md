# Good First Issues

These are well-defined, self-contained tasks that don't require deep familiarity with the full database. Each has a clear success condition. Open an issue before starting so work isn't duplicated.

## Source work

**Register Greek tragedy authors as sources and link their entities**
Aeschylus, Sophocles, and Euripides are not yet registered as sources. Many entities they attest are linked only to Apollodorus or Burkert. Task: register `SRC_AESCHYLUS`, `SRC_SOPHOCLES`, `SRC_EURIPIDES` (following the format in `scripts/add_greek_primary_sources.sql`) and add `entity_sources` rows for the entities they attest with specific play/line citations (e.g. Aeschylus *Oresteia* → Erinyes, Orestes, Clytemnestra; Sophocles *Ajax* → Ajax; Euripides *Medea* → Medea, Jason; *Bacchae* → Dionysus, Pentheus, Cadmus).

**Add reception chains: Moses → Musa, Elijah → Ilyas**
`ENT_ISL_MUSA` and `ENT_ISL_ILYAS` are not yet in the database. These are the two most important Hebrew prophet → Quranic prophet reception chains. The Quran names both explicitly; the source `SRC_QURAN` is already registered. Task: add the two Islamic entities and the `received_as` relationship pairs.

**Review period coverage for Gaulish and Gnostic entities**
Run:
```sql
SELECT e.entity_id, e.canonical_name
FROM entities e
LEFT JOIN entity_periods ep ON e.entity_id = ep.entity_id
WHERE e.tradition LIKE 'Celtic/Gaulish%' AND ep.entity_id IS NULL;
```
Then assign periods. Same pattern for `Gnostic` and `Valentinian` entities.

## New entities

**Add Works and Days personifications**
*Works and Days* (covered by `SRC_HESIOD_THEOGONY`) introduces Pandora and the Five Ages — figures not yet in the DB. Task: add `ENT_GRK_PANDORA`, `ENT_GRK_GOLDEN_AGE`, `ENT_GRK_SILVER_AGE`, `ENT_GRK_BRONZE_AGE`, `ENT_GRK_HEROIC_AGE`, `ENT_GRK_IRON_AGE` as entities with appropriate Hesiod source links and `entity_periods` rows (all `PER_GRK_ARCHAIC`).

**Expand Welsh / Arthurian tradition**
The Four Branches of the Mabinogi are now in the DB with full internal relationships, but several figures from *Culhwch ac Olwen* and the Welsh Triads are still missing: Culhwch, Olwen, Ysbaddaden, Arthur (Welsh tradition), Mabon ap Modron, Cei, Bedwyr. Source: `SRC_MABINOGION` (already registered); secondary: `SRC_GREEN_CELTIC_GODS`.

**Add Greek tragedy figures as standalone entities**
Several figures prominent in Attic tragedy are only stubs or absent from the DB: Electra, Clytemnestra, Agamemnon, Antigone, Oedipus, Creon, Pentheus. These are heroic/legendary figures with their own cult reception and iconographic tradition. Add as `entity_type = 'hero'` or `'legendary mortal'` with links to the tragedy sources once registered (see task above).

**Etruscan expansion**
The current Etruscan layer has 12 entities from the major deity list. Additional attested figures: Vanth (winged underworld psychopomp; tomb paintings), Mania (underworld mother of the Manes), Sethlans (Etruscan Hephaestus), Turms (Etruscan Hermes), Aplu (Etruscan Apollo). Sources: `SRC_PIACENZA_LIVER`, `SRC_DEGRUMMOND_ETRUSCAN`.

**Gaulish deity expansion**
The Gaulish layer has 11 entities. Well-attested deities still missing: Borvo (healing spring god; paired with Damona), Damona (healing spring goddess; "divine cow"), Coventina (British spring goddess, Carrawburgh temple), Arduinna (Ardennes forest goddess; boar iconography), Brigantia (northern British tutelary goddess). Sources: `SRC_DELAMARRE_GAULISH`, `SRC_DUVAL_DIEUX_GAULE` (both already registered).

## Data and tooling

**Reception chain traversal query**
Add an example query to `examples/sample_queries.sql` — a recursive CTE over `entity_relationships` filtered to `received_as` / `reception_of` that traces a full transmission chain for a given entity (e.g. Matar Kubileya → Cybele → Magna Mater, or Lugus → Lugh / Lleu). A useful navigational tool for exploring the diachronic layer.

**Docker Compose setup**
`docs/install.md` describes manual Docker steps. A `docker-compose.yml` at the root would make setup one command. Task: write `docker-compose.yml` that starts postgres, creates the database, and mounts the schema. No seed data automation required — just the container.

**Tradition coverage report**
Add an example to `examples/sample_queries.sql` showing per-tradition: entity count, source count, average sources per entity, and count of entities with no period assignment. Useful for gap analysis and for orienting new contributors.

## Scholarly review

**Audit `associated_with` edges**
Some `associated_with` relationships remain in the graph. Run:
```sql
SELECT * FROM entity_relationships WHERE relationship_type = 'associated_with';
```
Open an issue proposing a typed replacement for any that can be narrowed (e.g. `patron_of`, `embodies`, `paired_with`). See `CONTRIBUTING.md` for the preferred relationship vocabulary.

**Psychopomp / funerary deity classification**
Several entities typed as `'god'` or `'spirit'` are primarily funerary or psychopomp figures (Anubis, Hecate, Osiris, Hermes in his chthonic role, Etruscan Charun and Vanth). Propose a consistent approach — a new `entity_type` value, or a `member_of` relationship to a funerary-function collective — and open an issue for discussion before implementing.

**Phrygian entity tradition labels**
`ENT_CYBELE` and `ENT_ATTIS` are currently `tradition = 'Greek'` because they entered the DB via the Greek reception layer. Now that `ENT_PHRYG_MATAR` and `ENT_PHRYG_AGDISTIS` exist as their Phrygian originals, consider whether to relabel them `'Greek/Phrygian'` (matching the existing convention for `ENT_MARSYAS`) or leave them as-is. Open an issue for discussion — this affects how `v_public_tradition_overview` counts them.
