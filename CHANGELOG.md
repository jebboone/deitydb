# Changelog

## v1.1.0 (in progress)

### New tradition layers: Hittite/Hurrian, Phoenician Iron Age, Pre-Islamic Arabian, South Arabian/Sabaean
### Systematic reception chains: Mesopotamian → Greek (with Hittite intermediary)
### Foundational expansion: Canaanite, Hittite, South Arabian, Mesopotamian entities

#### Hittite/Hurrian tradition seed (add_hittite_hurrian_layer.sql)
- Added period PER_HTT_EMPIRE (Hittite Empire, c. 1650–1180 BCE)
- Added 2 sources: SRC_HOFFNER_HITTITE_MYTHS (Hoffner 1998, primary translation),
  SRC_WEST_EAST_HELICON (West 1997, key Mesopotamian→Greek transmission scholar)
- Added 9 Hittite/Hurrian entities:
  ENT_HTT_ALALU (primordial first king), ENT_HTT_KUMARBI (succession deity; Kronos parallel),
  ENT_HTT_TESHUB (Hurrian storm god; Zeus parallel), ENT_HTT_HEPAT (queen of heaven; Hera parallel),
  ENT_HTT_SHAUSHKA (Hurrian Ishtar), ENT_HTT_ULLIKUMMI (chaos monster; Typhon parallel),
  ENT_HTT_ILLUYANKA (chaos serpent; Python parallel), ENT_HTT_TARHUNNA (Hittite storm god),
  ENT_HTT_ARINNA (Hittite sun goddess, chief state deity)
- Added 2 new Greek entities as chain targets: ENT_KRONOS (Titan; Hesiod Theogony 137),
  ENT_TYPHON (chaos monster; Hesiod Theogony 820-880)
- Added 7 reception chain pairs (14 rows):
  - ENT_HTT_KUMARBI → ENT_KRONOS (high): the sky-god castration parallel; West (1997) centerpiece
  - ENT_HTT_TESHUB → ENT_ZEUS (high): storm deity champion who defeats predecessor
  - ENT_HTT_ULLIKUMMI → ENT_TYPHON (medium): monster created by defeated deity to fight champion
  - ENT_HTT_HEPAT → ENT_HERA (medium): queen of heaven parallel
  - ENT_HTT_ILLUYANKA → ENT_PYTHON (low): serpent combat at sacred site
  - ENT_MES_INANNA_ISHTAR ↔ ENT_HTT_SHAUSHKA (identified_with, high): Hittite texts call her "Ishtar of Nineveh"
  - ENT_HTT_TESHUB ↔ ENT_HTT_TARHUNNA (identified_with, high): Hurrian and Hittite storm deities merged

#### Mesopotamian → Greek structural parallels (add_mesopotamian_greek_parallels.sql)
- Added source SRC_BURKERT_ORIENT_REV (Burkert, The Orientalizing Revolution, Harvard 1992)
- Added 1 new Greek entity: ENT_OURANOS (primordial sky; Hesiod Theogony 126-210)
- Added 9 reception chain pairs (18 rows):
  - ENT_MES_ANU → ENT_OURANOS (medium): sky primordial in the succession myth
  - ENT_MES_MARDUK → ENT_ZEUS (medium): combat champion, chief of divine assembly (Enuma Elish)
  - ENT_MES_ENLIL → ENT_ZEUS (low): older storm-kingship parallel; secondary to Marduk chain
  - ENT_MES_TIAMAT → ENT_TYPHON (medium): primordial chaos monster combated by storm champion
  - ENT_MES_ERESHKIGAL → ENT_PERSEPHONE (medium): underworld queen; Descent of Inanna template
  - ENT_MES_APSU → ENT_OCEANUS (medium): primordial cosmic water preceding creation
  - ENT_MES_NABU → ENT_HERMES (medium): writing/wisdom deity + divine messenger
  - ENT_MES_DUMUZI_TAMMUZ → ENT_ADONIS (low): dying vegetation deity via Phoenician mediation
  - ENT_MES_NINHURSAG → ENT_DEMETER (low): earth mother / grain goddess parallel
- Note: ENT_HTT_TESHUB → ENT_ZEUS (already in Hittite script) documents the succession
  narrative; Marduk → Zeus documents the combat-warrior pathway; both coexist as distinct chains

#### Phoenician Iron Age layer (add_phoenician_iron_age_layer.sql)
- Added period PER_PHO_IRON_AGE (Phoenician Iron Age, c. 1200–332 BCE)
- Added 2 sources: SRC_MARKOE_PHOENICIANS (Markoe 2000),
  SRC_HERODOTUS_HISTORIES (Herodotus, Histories, c. 430 BCE; primary)
- Added 4 Phoenician entities:
  ENT_PHO_MELQART (Tyrian chief deity; dying/rising; Heracles parallel),
  ENT_PHO_ESHMUN (Sidonian healing deity; Asclepius parallel),
  ENT_PHO_TANIT (Carthaginian queen of heaven; Juno Caelestis),
  ENT_PHO_BAAL_HAMMON (Carthaginian chief deity; Saturnus Africanus)
- Added 6 reception chain pairs (12 rows):
  - ENT_CAN_BAAL → ENT_PHO_MELQART (medium): Iron Age Baal of Tyre; 1 Kings 18 context
  - ENT_MES_DUMUZI_TAMMUZ → ENT_PHO_MELQART (low): dying-rising deity egersis rite parallel
  - ENT_PHO_MELQART → ENT_HERACLES (high): Herodotus 2.44 explicit; lion-skin, colonial foundation
  - ENT_PHO_ESHMUN → ENT_ASCLEPIUS (high): Eshmunazar sarcophagus; Philo of Byblos; Sidonian Asklepion
  - ENT_PHO_TANIT → ENT_ROM_JUNO (medium): Juno Caelestis in Roman North Africa
  - ENT_PHO_BAAL_HAMMON → ENT_ROM_SATURN (medium): Saturnus Africanus; Diodorus Siculus 20.14

#### Pre-Islamic Arabian layer (add_pre_islamic_arabian_layer.sql)
- Added period PER_ARA_PRE_ISLAMIC (Pre-Islamic Arabia/Jahiliyyah, c. 600 BCE–622 CE)
- Added source SRC_HEALEY_NABATAEAN_RELIGION (Healey, Brill 2001)
- Added 5 Pre-Islamic Arabian entities:
  ENT_ARA_ALLAT (north Arabian goddess; Quran 53:19; Herodotus 3.8 "Alilat"),
  ENT_ARA_AL_UZZA (Venus goddess; Quran 53:19-20; Nabataean inscriptions),
  ENT_ARA_MANAT (fate/death goddess; Quran 53:20; al-Mushallal sanctuary),
  ENT_ARA_HUBAL (chief deity of the Kaaba; Mecca; Quraysh tribe),
  ENT_ARA_DUSHARA (Nabataean chief deity; Petra; "Lord of the Mountain")
- Added 6 reception chain pairs (12 rows):
  - ENT_CAN_ASTARTE → ENT_ARA_AL_UZZA (medium): Semitic Venus-goddess tradition
  - ENT_ARA_ALLAT → ENT_ATHENA (medium): Palmyrene inscriptions equate them explicitly
  - ENT_ARA_AL_UZZA → ENT_APHRODITE (medium): Venus/morning star identification
  - ENT_ARA_MANAT → ENT_NEMESIS (low): fate/death-apportionment parallel
  - ENT_ARA_DUSHARA → ENT_DIONYSUS (medium): Epiphanius Panarion 51.22 explicit
  - ENT_MES_NANNA_SIN → ENT_ARA_HUBAL (low): lunar/divination parallel; scholarly hypothesis
- Pre-Islamic Arabian deities provide the immediate substrate for the Islamic reception layer
  already in DB; the Quran names Al-Lat, Al-Uzza, and Manat explicitly (53:19-20)
- Result: 1100 entities, 1231 relationships, 88 sources, 0 unresolved, 4 new traditions

#### Canaanite foundational expansion (add_canaanite_expansion.sql)
- Added source SRC_WYATT_RELIGIOUS_TEXTS (N. Wyatt, Religious Texts from Ugarit, 2002)
- Added 2 entities:
  ENT_CAN_DAGON (grain/sky deity; father of Baal; KTU 1.5 VI 24; attested from Ebla c. 2400 BCE),
  ENT_CAN_RESHEPH (plague/war deity; gatekeeper at El's court; Cypriot bilingual inscriptions)
- Added 3 relationship chains (6 rows):
  - ENT_CAN_DAGON → parent_of → ENT_CAN_BAAL (medium): KTU 1.5 VI 24 "Baal son of Dagon"
  - ENT_CAN_BAAL → child_of → ENT_CAN_DAGON (medium): inverse
  - ENT_CAN_RESHEPH → received_as → ENT_APOLLO (medium): Cypriot bilingual inscriptions
    equate them explicitly; plague-deity bow-and-arrow complex; West (1997)

#### Hittite foundational expansion (add_hittite_expansion.sql)
- Added 3 entities:
  ENT_HTT_TELIPINU (vanishing deity; CTH 324-325; paradigm seasonal disappearance myth),
  ENT_HTT_INARAS (protective goddess; devises Illuyanka's defeat by feasting trap),
  ENT_HTT_HANNAHANNA (divine grandmother; sends the bee that finds Telipinu)
- Added 5 relationships:
  - ENT_HTT_TELIPINU → received_as → ENT_DEMETER (low): vanishing-deity narrative structure;
    vegetation fails during deity's absence; West (1997) on transmission through Anatolian contact
  - ENT_MES_DUMUZI_TAMMUZ → received_as → ENT_HTT_TELIPINU (low): older Mesopotamian
    dying-vegetation tradition as probable substrate for the Hittite myth
  - ENT_HTT_INARAS → guides → ENT_HTT_TARHUNNA (high): Inaras devises the trap by which
    Tarhunna defeats Illuyanka (CTH 321 §§1-8); links new entity to existing Illuyanka chain

#### South Arabian / Sabaean layer (add_south_arabian_sabaean.sql)
- Added period PER_SABAEAN (Sabaean and South Arabian Period, c. 1200 BCE–275 CE)
- Added source SRC_HOYLAND_ARABIA (Robert G. Hoyland, Arabia and the Arabs, Routledge 2001)
- Added 4 entities:
  ENT_SAB_ALMAQAH (Sabaean chief lunar deity; patron of Marib; hundreds of dedicatory inscriptions),
  ENT_SAB_ATHTAR (pan-South-Arabian Venus deity, uniquely masculine; cognate with Ishtar/Astarte),
  ENT_SAB_SHAMS (South Arabian sun goddess, uniquely feminine; standard triad member),
  ENT_SAB_AMM (Qatabanian chief lunar deity; "divine uncle" kinship-patron pattern)
- Added 3 reception chain pairs (6 rows):
  - ENT_CAN_ASTARTE → received_as → ENT_SAB_ATHTAR (low): Semitic Venus name-cognate
    (*ʿAttar-); South Arabia preserves the masculine form; Cross (1973)
  - ENT_SAB_ALMAQAH → received_as → ENT_ARA_HUBAL (low): South Arabian lunar-deity-as-patron
    pattern as older substrate for North Arabian pre-Islamic lunar deity tradition
  - ENT_SAB_ATHTAR → received_as → ENT_ARA_AL_UZZA (low): Venus deity tradition transmitted
    north through incense trade routes; feminized in North Arabian reception

#### Mesopotamian foundational expansion (add_mesopotamian_expansion.sql)
- Added source SRC_GEORGE_GILGAMESH (Andrew R. George, The Babylonian Gilgamesh Epic, OUP 2003)
- Added 5 entities:
  ENT_MES_ANZU (divine storm bird/chaos monster; steals Tablet of Destinies; defeated by Ninurta),
  ENT_MES_NINSUN ("Lady Wild Cow"; divine mother of Gilgamesh; dream interpreter; cult at Ur),
  ENT_MES_GILGAMESH (hero/semi-divine king of Uruk; protagonist of oldest literary epic),
  ENT_MES_ENKIDU (wild man created by Aruru; Gilgamesh's companion; first treatment of friendship and loss),
  ENT_MES_UTNAPISHTIM (flood survivor granted immortality; Gilgamesh Tablet XI; precursor to biblical Noah)
- Added 5 internal relationships:
  - ENT_MES_NINSUN → parent_of → ENT_MES_GILGAMESH (high): explicit in Epic Tablets I-III
  - ENT_MES_GILGAMESH → child_of → ENT_MES_NINSUN (high): inverse
  - ENT_MES_GILGAMESH → paired_with → ENT_MES_ENKIDU (high): paradigm hero-companion pair
  - ENT_MES_ENKIDU → paired_with → ENT_MES_GILGAMESH (high): inverse
  - ENT_MES_NINURTA → slays → ENT_MES_ANZU (high): Anzu myth; Ninurta recaptures Tablet of Destinies
- Reception chain deferred: ENT_MES_UTNAPISHTIM → received_as → ENT_ISR_NOAH (high confidence;
  highest-documented Mesopotamian→Israelite narrative transmission) — deferred until ENT_ISR_NOAH
  is added in the Israelite expansion
- Result after all four expansion scripts: 1114 entities, 1251 relationships, 91 sources, 0 unresolved

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
