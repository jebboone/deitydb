# Changelog

## v1.1.0 (in progress)

### Systematic reception history — Egyptian → Hellenistic/Christian layer
- Added SRC_PLUTARCH_ISIS_OSIRIS (Plutarch, *De Iside et Osiride*, c. 100–120 CE; primary text;
  fullest surviving Greco-Roman account of Egyptian religion, Serapis creation, interpretatio graeca)
- Added 9 reception chain pairs (18 relationship rows):
  - ENT_EGY_OSIRIS → ENT_SYN_SERAPIS (high, PER_GRK_HELLENISTIC): Ptolemaic syncretic creation
    (Plutarch De Is. 28; Tacitus Histories 4.83); highest-confidence Egyptian→syncretic chain
  - ENT_EGY_HORUS → ENT_SYN_HARPOCRATES (high, PER_GRK_HELLENISTIC): Horus-the-child finger-gesture
    misread as silence deity; Horus-child-with-Isis visual model for Christ-child-with-Virgin
  - ENT_EGY_ANUBIS → ENT_SYN_HERMANUBIS (high, PER_GRK_HELLENISTIC): psychopomp function fusion
  - ENT_HERMES → ENT_SYN_HERMANUBIS (high, PER_GRK_HELLENISTIC): the Greek side of the Hermanubis fusion
  - ENT_EGY_AMUN → ENT_SYN_ZEUS_AMMON (high, PER_GRK_CLASSICAL): Herodotus 2.42 attests identification
  - ENT_ZEUS → ENT_SYN_ZEUS_AMMON (high, PER_GRK_CLASSICAL): the Greek side of the Zeus-Ammon fusion
  - ENT_EGY_HATHOR → ENT_APHRODITE (medium, PER_GRK_CLASSICAL): Herodotus 2.41; shared love/beauty
    domains and sacred cow; second source of Aphrodite alongside Canaanite Astarte chain
  - ENT_EGY_SETH → ENT_CHR_DEVIL (medium, PER_PATRISTIC): Plutarch's Seth/Typhon as cosmic evil;
    Late Antique Coptic Satan identification; iconographic contribution to demonic imagery
  - ENT_EGY_ISIS → ENT_SAINT_MARY (medium, PER_PATRISTIC): Isis lactans → Virgo lactans iconography;
    Queen of Heaven title; star-crown; mourning at divine son's death; R.E. Witt (1971) documents
- Syncretic targets (ENT_SYN_SERAPIS, ENT_SYN_HARPOCRATES, ENT_SYN_HERMANUBIS, ENT_SYN_ZEUS_AMMON)
  now have full reception ancestry chains
- ENT_EGY_THOTH → ENT_HER_TRISMEGISTUS already in DB from seed data; not repeated
- Result: 1175 relationships, 82 sources, 0 unresolved

### Systematic reception history — Jewish Mystical reception layer
- Added SRC_ALPHABET_BEN_SIRA (9th–11th c. CE; primary source for Lilith as Adam's first wife)
- Added ENT_JM_LILITH (Isaiah 34:14 lilit → Talmud → Alphabet of Ben Sira → Kabbalistic demoness)
- Added 8 reception chain pairs (16 relationship rows):
  - ENT_ENOCH → ENT_JM_METATRON (high): 3 Enoch narrates the patriarch's angelic transformation
  - ENT_ISR_SOPHIA → ENT_JM_SHEKHINAH (medium): Wisdom hypostasis → divine feminine presence
  - ENT_ISR_SOPHIA → ENT_JM_HOKHMAH (medium): Proverbs 8 Wisdom → second sefirah
  - ENT_GNO_SOPHIA → ENT_JM_SHEKHINAH (medium): exiled aeon → exiled divine presence
  - ENT_CAN_ASHERAH → ENT_JM_SHEKHINAH (low): Patai's goddess-beside-God continuity thesis
  - ENT_ISR_AZAZEL → ENT_GNO_SAMAEL (medium): expelled being → adversarial angel of death
  - ENT_ISR_SATAN → ENT_GNO_SAMAEL (medium): accuser → Kabbalistic prince of the sitra achra
  - ENT_MES_LAMASHTU → ENT_JM_LILITH (low): Mesopotamian child-harming demoness → lilit

### Systematic reception history — Islamic reception layer + Mithra→Mithras
- Added SRC_VAN_BLADEL_ARABIC_HERMES (Van Bladel, OUP 2009 — definitive Idris=Hermes study)
- Added ENT_ISL_IDRIS (Quranic prophet; identified with Enoch in Islamic commentary
  and with Hermes Trismegistus in Islamic-Hermetic philosophy; nodal convergence figure)
- Added 11 reception chain pairs (22 relationship rows):
  - ENT_ISR_GABRIEL → ENT_ISL_JIBRIL (high): direct Quranic naming (2:97-98)
  - ENT_ISR_MICHAEL → ENT_ISL_MIKAIL (high): direct Quranic naming (2:98)
  - ENT_ISR_SATAN → ENT_ISL_IBLIS (high): cosmic adversary; Shaytan cognate with satan
  - ENT_ISR_AZAZEL → ENT_ISL_IBLIS (medium): Iblis's pre-fall name Azazil in tafsir
  - ENT_ISR_WATCHERS → ENT_ISL_HARUT (medium): angels teaching forbidden arts in Babylon
  - ENT_ISR_WATCHERS → ENT_ISL_MARUT (medium): paired with Harut in Quran 2:102
  - ENT_CHR_ANTICHRIST → ENT_ISL_DAJJAL (medium): false messiah via Jewish-Christian apocalyptic
  - ENT_ISR_ANGEL_OF_DEATH → ENT_ISL_AZRAIL (medium): named Angel of Death tradition
  - ENT_ENOCH → ENT_ISL_IDRIS (high): universally identified in Islamic commentary
  - ENT_HER_TRISMEGISTUS → ENT_ISL_IDRIS (medium): Idris=Hermes in 9th–12th c. philosophy
  - ENT_ZOR_MITHRA → ENT_SYN_MITHRAS (medium): Iranian Mithra → Roman mystery cult deity

### Systematic reception history — Greek Olympians → Patristic demonization
- Added SRC_JUSTIN_MARTYR_APOLOGIES (1st/2nd Apologies, c. 150–165 CE) and SRC_AUGUSTINE_CITY_OF_GOD (413–426 CE)
- Added 13 reception chain pairs (26 relationship rows) covering all major Olympians:
  - Apollo → ENT_CHR_APOLLYON (high): Revelation 9:11 wordplay; Justin Martyr 1 Apol. 24
  - Zeus → ENT_CHR_DEVIL (medium): chief Olympian structurally mapped to prince of demons
  - Pan → ENT_CHR_DEVIL (medium): iconographic origin of the Devil's physical form
  - Hera, Poseidon, Athena, Ares, Hephaestus, Artemis, Aphrodite, Demeter,
    Dionysus → ENT_CHR_DEMONS (medium): Justin Martyr 1 Apol. 9, 24–25; Augustine II–VIII
  - Hestia → ENT_CHR_DEMONS (low): Augustine City of God IV.23 general condemnation
- Note: ENT_HECATE already handled (ENT_REC_HECATE_PATRISTIC); ENT_HERMES omitted
  (Justin Martyr uses Hermes as a positive Logos parallel; Hermetic chain already in DB)

### Systematic reception history — Zoroastrian → Israelite/Second Temple layer
- Added SRC_TOBIT (Book of Tobit, primary text, c. 3rd–2nd c. BCE)
- Added ENT_ZOR_AESHMA_DAEVA (Zoroastrian demon of wrath; Yasna 29.2, Vidēvdād 10; previously missing)
- Fixed ENT_LAT_ASMODEUS stub: added entity_type, evidence_confidence, sourcing, period
- Added 3 reception chain pairs (6 relationship rows):
  - ENT_ZOR_AESHMA_DAEVA → ENT_LAT_ASMODEUS (high): philologically secure name derivation
  - ENT_ZOR_ANGRA_MAINYU → ENT_ISR_SATAN (medium): cosmic adversary structural influence during exile
  - ENT_ZOR_AMESHA_SPENTAS → ENT_ISR_MICHAEL (low): named divine council structural parallel
- All chains period-anchored (PER_ZOR_ACHAEMENID, PER_ISR_EXILIC, PER_ISR_SECOND_TEMPLE)

### Systematic reception history — Canaanite/Mesopotamian/Israelite layer
- Added SRC_CROSS_CANAANITE_MYTH (Frank Moore Cross, 1973) and SRC_DAY_GODS_CONFLICT (John Day, 1985)
- Added 10 reception chain pairs (20 relationship rows) covering:
  - Mesopotamian→Canaanite: ENT_MES_TIAMAT→ENT_CAN_LOTAN, ENT_MES_INANNA_ISHTAR→ENT_CAN_ASTARTE
  - Canaanite→Israelite: ENT_CAN_LOTAN→ENT_ISR_LEVIATHAN (high), ENT_CAN_MOT→ENT_ISR_SHEOL (high),
    ENT_CAN_YAM→ENT_ISR_LEVIATHAN (medium), ENT_CAN_EL→ENT_ISR_YAHWEH (medium),
    ENT_CAN_ASHERAH→ENT_ISR_SOPHIA (low, contested)
  - Mesopotamian→Israelite direct (exilic contact): ENT_MES_TIAMAT→ENT_ISR_LEVIATHAN,
    ENT_MES_APKALLU→ENT_ISR_WATCHERS
  - Canaanite→Greek: ENT_CAN_ASTARTE→ENT_APHRODITE (via Phoenician Cyprus)
- All chains period-anchored (PER_CAN_BRONZE_AGE, PER_ISR_EXILIC, PER_ISR_SECOND_TEMPLE, PER_GRK_ARCHAIC)
- 0 unresolved relationships maintained

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
