# Changelog

## v1.1.0 (in progress)

### Temporal / Diachronic layer
- Added `period_id` column to `entity_relationships` (upgrade_v1_1_temporal.sql)
- Added 26 period records (total: 44) covering all major traditions + reception eras
- Bulk-assigned 454 entity_period records
- Added `received_as` and `reception_of` relationship types for transmission chains
- Added Hermes Trismegistus (ENT_HER_TRISMEGISTUS) with Hellenistic/Renaissance period assignments
- Added Hecate Patristic reception entity (ENT_REC_HECATE_PATRISTIC)
- Added 8 seed transmission chains: Thoth→Trismegistus, Hermes→Trismegistus, Satan→Devil, Daimones→Devil, Devil→Lucifer, Hecate→Hecate Patristic, Agathos Daimon→Hermetic Agathos Daimon

### Sourcing
- Sourced all 118 Cross-traditional abstraction entities (batch 10, final)
  - Added SRC_HESIOD_THEOGONY (primary for 36 named Greek personifications)
  - Added SRC_ELIADE_ER (secondary reference for all 118)
- Sourcing campaign complete: 577 previously unsourced entities → 0

### Relationship cleanup
- Replaced all 51 `aligned_with` edges with typed relations
- Re-added `associated_with` to relationship_types (3 defensible uses remain)

### 20th-century Thelemic reception layer
- Added period PER_20C_OCCULT (1900-2000) for Thelema, Wicca, and later occultism
- Added SRC_CROWLEY_BOOK_OF_LAW (Liber AL vel Legis, 1904/1909; primary text)
- Added 4 Thelemic entities (all evidence_confidence A, sourced to The Book of the Law):
  ENT_THL_NUIT, ENT_THL_HADIT, ENT_THL_RA_HOOR_KHUIT, ENT_THL_AIWASS
- Added 11 transmission chains anchored to PER_20C_OCCULT:
  Nut→Nuit, Horus→Ra-Hoor-Khuit, Ra→Ra-Hoor-Khuit, Ra-Horakhty→Ra-Hoor-Khuit,
  Harpocrates→Ra-Hoor-Khuit, Mahatmas→Aiwass (plus reception_of inverses)
- All entities explicitly labeled as 20th-century Thelemic reception; none
  presented as continuations of ancient Egyptian religion

### 19th-century occultism reception layer
- Added 4 source records: SRC_LEVI_DOGME_RITUEL, SRC_BLAVATSKY_SECRET_DOCTRINE,
  SRC_HUTTON_TRIUMPH, SRC_HANEGRAAFF_DGW
- Added 3 reception entities: ENT_REC_BAPHOMET_LEVI, ENT_REC_MAHATMAS,
  ENT_REC_PAN_ROMANTIC — all explicitly labeled as documented modern reception,
  all sourced to Hutton (1999), Lévi (1854-1856), or Blavatsky (1888)
- Added 8 transmission chains anchored to PER_19C_OCCULT

## v1.0.0-rc1

- Ontology frozen
- Relationship governance added
- Audit scripts added
- Bootstrap installer added
- Integrity tests added
- Reduced associated_with from 235 to 5
- Increased semantic precision across graph
