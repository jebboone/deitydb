# Changelog

## v1.92.0 — 2026-06-17

### Deeper graph & API features (no data change)

Four new graph/API capabilities on top of the completed dataset (3,836 entities), all
served from the same source-traced graph.

- **Public JSON API** (`plugins/deitydb_api.py`) — clean, stable, CORS-enabled, documented
  at **/api** with a machine-readable **/api/openapi.json**:
  `/api/entity/{id}`, `/api/neighbors/{id}` (filterable by type/tradition/direction),
  `/api/path?from=&to=`, `/api/search?q=`, `/api/tradition/{name}`, `/api/graph.json`,
  `/api/meta`. Makes DeityDB programmatically reusable.
- **/path — Find a Path** — the shortest source-traced relationship chain between *any two*
  figures (bidirectional BFS over the graph), rendered as a tradition-coloured flow with the
  cited rationale on every hop. (e.g. Zeus → … → 999; Isis → … → Erzulie Freda.)
- **/constellation** — the whole dataset as one zoomable, canvas-rendered force map: every
  figure a star, every relationship a thread, clustered and coloured by tradition, with a
  per-tradition filter and click-through to entities.
- **/graph filters** — the relationship graph now has relationship-type checkboxes and a
  tradition spotlight, plus a link into the path-finder.

Added to the nav (Path, Map, API) and the homepage's Browse & Visualize cards. Template/plugin
only — the data (3,836 entities / 7,098 relationships / 458 sources / 135 traditions) is
unchanged.


## v1.91.1 — 2026-06-17

### Post-roadmap audit cleanup

Full audit of the completed roadmap deployment (`scripts/qa_orphans_selfloops_v1_91.sql`).
All integrity invariants verified clean; two pieces of pre-existing debt (predating the
build-out) were surfaced and fixed:
- **4 degenerate `identified_with`-self self-loops** removed (the real cross-links, e.g.
  Mandaean↔Christian John the Baptist, already existed separately).
- **17 orphan entities** (0 edges) wired into real edges: the 13 orphan saints into a new
  **Communion of Saints** hub (+ the martyrs `embodies` Martyrdom); Renpet↔Anna Perenna
  (year-goddess cognates), Nemty↔Charon (divine ferrymen), Vacuna `equated_with` Victoria;
  and the "Heroes" class `aligned_with` the Daimones.

Final state: 0 unsourced / orphan / rationale-less / dangling / orphan-source / self-loop /
profile-gap; 97.3% primary-or-scholarly source coverage.


## v1.91.0 — 2026-06-17

### Completeness build-out, Phase 7 (FINAL) — the boundary domains of the Atlantic world

Final phase of the completeness program (`docs/COMPLETENESS_ROADMAP.md`), orchestrated
research→adversarial-verify workflow under a mandatory cultural-sensitivity rule. **+51
entities, +95 relationships, +10 sources, 5 new traditions** + a new `afro-diasporic`
tradition_profile class. Scorecard now 3,836 entities / 7,078 relationships / 458 sources /
135 traditions.

- **Vodou** — the Lwa (Bondye, Papa Legba, Erzulie Freda & Dantor, Damballa & Ayida-Wedo,
  Baron Samedi & the Gede, Maman Brigitte), organized in the Rada and Petwo nanchon, with the
  saint-syncretisms (Legba≈St Peter/St Lazarus, Damballa≈St Patrick, Erzulie≈Our Lady of
  Sorrows/Częstochowa) wired onto the existing Catholic saints.
- **Yoruba-Orisha** (Santería/Candomblé + the Yoruba root) — Olodumare, Eshu/Elegguá, Obatalá,
  Ogun, Shango, Oshun, Yemoja, Oya, Babalú-Ayé, Orunmila, the Seven African Powers — with the
  classic saint-mappings (Shango≈St Barbara, Babalú-Ayé≈St Lazarus, Oshun≈Our Lady of Charity).
- **Rastafari** — Jah (← YHWH), Haile Selassie I (modeled neutrally as held belief), Marcus
  Garvey, Babylon (← the Whore of Babylon), Zion — wired to the Ethiopian Solomonic line.
- **Folk-Catholic saints** — Santa Muerte, San La Muerte, Maximón, Jesús Malverde, Niño
  Fidencio, Difunta Correa (labeled unofficial, modeled neutrally).
- **Pre-Columbian syncretism seam** — Tonantzin → the existing Our Lady of Guadalupe (only the
  documented seam, not the full pantheon).

The deity↔saint syncretism reception network is the payoff — these living Atlantic-world
traditions are wired into the Catholic saints already in the DB. Integrity-gated to 0 rejected /
orphan / unsourced / unperiodized / rationale-less / orphan-source / unreviewed-duplicate.

**This completes the systematic completeness build-out (Phases 1–7).** Across the program the
dataset grew from 3,173 → 3,836 entities and 96 → 135 traditions, all source-traced.


## v1.90.0 — 2026-06-17

### Completeness build-out, Phase 6 — cross-cutting structure (realms, monsters, angel-sets)

Sixth phase of the completeness program (`docs/COMPLETENESS_ROADMAP.md`), orchestrated
research→adversarial-verify workflow. Almost entirely WITHIN existing traditions (no new
traditions), heavily dedup-wired onto existing figures. **+85 entities, +156 relationships,
+8 sources.** Scorecard now 3,785 entities / 6,983 relationships / 448 sources / 130 traditions.

- **Cosmological realms** (the biggest structural gap) — **Islamic** (Jannah & its gardens,
  Jahannam & its seven gates, Barzakh, As-Sirat, al-Aʿraf, Sidrat al-Muntaha); **Norse** (the
  Nine Worlds + Valhalla, Folkvangr, Bifröst, Ginnungagap); **Greek** (Elysium, the Asphodel
  Meadows, the Isles of the Blest, onto the existing underworld rivers); **Christian/Dante**
  (Purgatory, Limbo, the Empyrean, the Bosom of Abraham, the Nine Circles); **Iranian /
  Mesopotamian / Jewish** (the Chinvat Bridge & the House of Song/Lies; Irkalla & Dilmun; the
  Seven Heavens & the Hekhalot palaces).
- **The Echidna/Typhon monster brood** — Echidna (the genealogical hub, `parent_of` her
  already-present children Cerberus/Hydra/Chimera/…), Orthrus, the Sphinx, the Harpies, the
  Sirens, the Graeae.
- **Finite angel-sets** — the Seven Planetary Angels completed and the Twelve Zodiacal Angels
  (Agrippa) added, cross-linked to the existing planetary angels and decans.

Process: the verifier rewrote 18 `part_of` edges to the existing verb `belongs_to_realm`; a
duplicate Níðhöggr was merged into the canonical `ENT_NOR_NIDHOGG`. Integrity-gated to 0
rejected / orphan / unsourced / unperiodized / rationale-less / orphan-source.


## v1.89.0 — 2026-06-17

### Completeness build-out, Phase 5 — Western esoteric & modern new-religious movements

Fifth phase of the completeness program (`docs/COMPLETENESS_ROADMAP.md`), orchestrated
research→adversarial-verify workflow (JSON only; applied + QA'd here) under the
"genuinely-practiced" test. **+64 entities, +141 relationships, +17 sources, 8 new
traditions.** Scorecard now 3,700 entities / 6,827 relationships / 440 sources / 130 traditions.

- **Wicca** — the Horned God (`reception_of` Cernunnos & Pan), the Triple Goddess
  (aligned with Hecate/Diana/Selene), the Dryghtyn, the Watchtower guardians, the Wheel of
  the Year.
- **Alchemy personified** — the tria prima (Sulphur/Mercury/Salt), the alchemical King &
  Queen, the Rebis, Azoth, the Green Lion (linked to the World Soul & Hermes Trismegistus).
- **Modern Satanism / Luciferianism / Temple of Set** — LaVeyan Satan, a "Four Crown
  Princes" collective over the *existing* demons, Set & Baphomet & Lucifer by reception.
- **Freemasonry & Rosicrucianism** — the Great Architect, Hiram Abiff, Jachin & Boaz,
  Christian Rosenkreutz, the Invisible College.
- **UFO religions** — the Space Brothers, Ashtar, the Council of Nine, the Raëlian Elohim,
  Sananda, Heaven's Gate's Next Level (linked to the existing Starseeds).
- **Scientology** — thetans, body thetans, Xenu, the Marcab Confederacy (neutrally-modeled
  belief-entities).
- **The "I AM" / Church Universal & Triumphant layer** — the Mighty I AM Presence, the
  Violet Flame, the Great White Brotherhood (mostly reception edges onto the existing
  Ascended Masters; Theosophical tradition, no new profile).
- **Discordianism** — the modern Eris (`reception_of` the Greek Eris), the Sacred Chao, the
  Golden Apple, Greyface, the Law of Fives.
- **Modern Paganism** — Heathenry/Ásatrú & Druidry as reconstructionist movements (linked
  to the Norse/Celtic gods), the Goddess movement, Martinism, New Thought.

Integrity-gated to 0 rejected / orphan / unsourced / unperiodized / rationale-less /
orphan-source / unreviewed-duplicate.


## v1.88.0 — 2026-06-17

### Completeness build-out, Phase 4 — European depth

Fourth phase of the completeness program (`docs/COMPLETENESS_ROADMAP.md`), orchestrated
research→adversarial-verify workflow (JSON only; applied + QA'd here). **+112 entities,
+196 relationships, +12 sources, 6 new traditions.** Scorecard now 3,636 entities /
6,686 relationships / 423 sources / 122 traditions.

- **Anglo-Saxon pantheon** (new tradition) — Woden, Thunor, Tiw, Frige, Ēostre, Hreða,
  Seaxnēat, Ing, Erce — each `aligned_with` its existing Norse cognate (Woden~Odin, …).
- **Continental Germanic & the Matronae** (new tradition) — the named Rhineland
  mother-goddess groups (Aufaniae, Vacallinehae, Gabiae, Suleviae) + Nehalennia, Donar/
  Hercules Magusanus, Baduhenna, Tanfana.
- **The Irish heroic & folklore layer (30)** — the Ulster Cycle (Cú Chulainn, Medb,
  Deirdre, Scáthach), the Fenian Cycle (Fionn, Oisín, Diarmuid), the invasion myths, the
  sovereignty goddesses (the Cailleach, Tailtiu), and the folklore beings (banshee,
  leprechaun, púca, the aos sí) — wired onto the existing Túatha Dé Danann.
- **Illyrian** (new tradition) — the absent western-Balkan pantheon (Medaurus, Redon, En,
  Vidasus & Thana).
- **The Germanic legendary-saga cycle** (new legendary-literary tradition) — Sigurð,
  Brynhild, Fáfnir, the Völsungs, Wayland the Smith, Ragnarr Loðbrók.
- **Norse folklore beings** — the draugr, landvættir, fylgja, huldra, nisse, the mara
  (cross-linked to the sleep-paralysis Old Hag), the nøkk.
- **The Nart sagas** (new tradition) — Batraz, Satana, Uastyrdzhi (≈ St George) — the
  surviving Scythian/Sarmatian-Alanic mythology of the Caucasus.
- **Venetic** (new tradition, Reitia) and **South Slavic** (Dabog, the vila class).

Integrity-gated to 0 rejected / orphan / unsourced / unperiodized / rationale-less /
orphan-source / unreviewed-duplicate.


## v1.87.0 — 2026-06-17

### Completeness build-out, Phase 3 — ancient Mediterranean & Near-East depth

Third phase of the completeness program (`docs/COMPLETENESS_ROADMAP.md`), orchestrated
research→adversarial-verify workflow (JSON only; applied + QA'd here). **+79 entities,
+174 relationships, +8 sources, 5 new traditions.** Scorecard now 3,524 entities /
6,490 relationships / 411 sources / 116 traditions.

- **Roman Mithraism** (new tradition) — the mystery cult fully built out: the seven grades
  (Corax → Pater), the torchbearers Cautes & Cautopates, the Leontocephaline time-god
  (equated with Aion), Petra Genetrix, and the tauroctony — around the existing Mithras
  (the redundant Mithras↔Sol Invictus / Mithras↔Zoroastrian-Mithra edges were dropped by
  the verifier as already present).
- **The absent Anatolian pantheons** (4 new traditions) — **Lydian** (Kuvava/Kybebe→Cybele,
  Santas), **Lycian** (Trqqas, the Twelve Gods, Eni Mahanahi), **Carian** (Zeus Labraundos,
  Hecate of Lagina), **Commagene** (the Antiochus-I syncretism: Zeus-Oromasdes,
  Apollo-Mithras-Helios-Hermes, Artagnes-Heracles-Ares) — wired by interpretatio to the
  existing Greek/Iranian gods.
- **Phoenician cosmogony** (Philo of Byblos/Sanchuniathon) — Elioun, Ouranos & Ge, Sydyk &
  Misor, Chousor (=Kothar), Taautos (=Thoth), the first men Ousoos & Samemroumos.
- **Roman Eastern cults** — Jupiter Dolichenus, the Heliopolitan triad, Dea Syria, Dea
  Caelestis (=Tanit), Elagabalus.
- **Mystery-cult inner casts** — the Samothracian tetrad (Axieros/Axiokersa/Axiokersos/
  Kasmilos), the Eleusinian inner cast (Baubo, Eumolpus, Demophoon), Theos Hypsistos.
- **Levantine biblical-attested minor deities** — Baal-Zebub of Ekron (the deity behind the
  demon Beelzebub), Ashima, Adrammelech & Anammelech, Nibhaz & Tartak.

Integrity-gated to 0 rejected / orphan / unsourced / unperiodized / rationale-less /
orphan-source / unreviewed-duplicate.


## v1.86.0 — 2026-06-17

### Completeness build-out, Phase 2 — the Christian foundational layer + Second Temple Judaism

Second phase of the completeness program (`docs/COMPLETENESS_ROADMAP.md`), orchestrated as a
background research→adversarial-verify workflow (JSON only; applied + QA'd here). **+137
entities, +234 relationships, +13 sources, 6 new traditions.** Scorecard now 3,445 entities /
6,316 relationships / 403 sources / 111 traditions.

- **Patristics (22)** — the four Latin Doctors (Augustine, Jerome, Ambrose, Gregory the Great)
  plus Origen, Irenaeus, Tertullian, Cyprian, Justin Martyr, the Apostolic Fathers (Clement of
  Rome, Ignatius, Polycarp), Gregory of Nyssa, Cyril of Alexandria, Maximus the Confessor, John
  of Damascus, Bede, Isidore — wired to the already-present Athanasius/Basil/Chrysostom.
- **Desert Fathers & Mothers (14)** — Pachomius, Evagrius, John Cassian, Moses the Black, the
  Ammas, around the existing Anthony the Great.
- **The Oriental & Eastern churches** (4 new traditions) — **Syriac** (Ephrem, Isaac of Nineveh,
  Aphrahat), **Armenian** (Gregory the Illuminator, Mesrop, Gregory of Narek), **Ethiopian**
  (Frumentius, Yared + the **Kebra Nagast** cycle: Makeda/Queen of Sheba, Menelik I), **Coptic**
  (Shenoute) — whole branches of Christianity that were entirely absent.
- **Christian heresies & dualists** (new tradition Christian/Heterodox) — Arius, Nestorius,
  Pelagius, the Bogomils, the Cathars/Albigensians, the Paulicians, wired `opposed_by` the
  Fathers who refuted them.
- **Second Temple Judaism (24)** — the sages (Hillel, Akiva, Yohanan ben Zakkai…), Philo and
  Josephus, the Qumran Teacher of Righteousness, and the deuterocanonical figures (Judith, the
  Maccabees, Tobias, Susanna, Ahikar).
- **Christian demonology beyond the Goetia** (new tradition) — the Seven Princes / deadly-sins
  schema (mostly edges onto the existing demons) + the genuinely-missing Loudun possession
  demons (Verrine, Gresil, …) + Titivillus.
- **Marian titles (12)** — older devotional titles (Rosary, Mount Carmel, Sorrows, Perpetual
  Help, Częstochowa, Walsingham, Loreto, Akita, Zeitoun), each `reception_of` the Virgin Mary.

Integrity-gated to 0 rejected / orphan / unsourced / unperiodized / rationale-less /
orphan-source / unreviewed-duplicate.


## v1.85.0 — 2026-06-17

### Completeness build-out, Phase 1 — whole missing religions + connectivity (orchestrated)

First phase of the systematic completeness program (see `docs/COMPLETENESS_ROADMAP.md`),
executed as a background multi-agent workflow (research → adversarial verify, JSON only;
applied + QA'd here). **+135 entities, +321 relationships, +28 sources, 9 new traditions.**
Scorecard now 3,308 entities / 6,082 relationships / 390 sources / 105 traditions.

- **Nine whole missing religions** (Tier 1) — each a new tradition with a `tradition_profile`
  row, periodized, sourced, wired into a hub + cross-tradition reception links:
  **Yazidi** (Tawûsî Melek / the Peacock Angel + the Heptad + Sheikh Adi; the Shaytan
  misidentification explicitly rejected), **Druze** (the five luminaries / al-hudud +
  al-Hakim), **Yarsan / Ahl-e Haqq** (Sultan Sahak + the Haftan + the manifestation chain),
  **Alawite / Nusayri** (the ʿAyn-Mim-Sin trinity, cross-linked to mainstream Ali/Muhammad/
  Salman), **Bahá'í** (the Manifestations chain — Bahá'u'lláh `reception_of` Abraham/Moses/
  Jesus/Muhammad/Zoroaster), **Samaritan** (the Taheb, Marqah, Mt Gerizim), **Latter-day
  Saint** (Heavenly Father & Mother, Kolob, Moroni, the three degrees of glory),
  **Sabian/Harranian** (the planetary star-cult, cross-linked to Sin of Harran & the
  Hermetic corpus), **Alevi-Bektashi** (the Allah-Muhammad-Ali trinity, the Assembly of the
  Forty, cross-linked to the existing Hajji Bektash).
- **Connectivity remediation** (Tier 7) — the two long-disconnected rosters wired into their
  cosmologies: **Mandaean** (Hayyi Rabbi → the uthras/Manda d-Hayyi/Abathur/Ptahil/Ruha; the
  Mandaean John the Baptist cross-linked to the NT John), and **Manichaean** (a Lightworld
  hierarchy hub + new emanation/cross edges; the adversarial verifier dropped 24 proposed
  edges that duplicated or contradicted the cohort's already-existing 54 edges). **Zurvan**'s
  twin-birth myth (parent of both Ohrmazd and Ahriman) + its two time-aspects.
- **Data quality** — normalized 23 case-variant `entity_type` labels (god/God, goddess/
  Goddess, …) to a single casing so type-faceted views stop double-counting.

All applied via committed generators; integrity-gated to 0 rejected / orphan / unsourced /
unperiodized / rationale-less / orphan-source / unreviewed-duplicate.

## v1.84.2 — 2026-06-17

### Traceability backfill — the dataset is now fully clean (`scripts/qa_v1_84_2.sql`)

Cleared the last pre-existing traceability debt surfaced by the v1.84.1 audit:
- **Backfilled all 77 rationale-less relationships** with accurate, source-grounded
  rationales drawn from each edge's own citation — chiefly the Testament of Solomon
  decan-demons (causes_affliction / member_of / opposes / Solomon rules) and the
  3 Enoch & Hekhalot Jewish-mystical edges (Metatron, the throne-bearing angelic
  orders, Enoch's ascent).
- **Resolved all 10 legacy orphan sources:** attached the genuine bibliographic ones
  to the figures they document (2 Enoch → Enoch/Metatron, the DSS War Scroll → Michael,
  Mēnōg-ī Khrad → Zoroastrian beings, Sappho → Aphrodite, Lindow → the Norse gods,
  Digital Egypt → the major Egyptian gods, the Catholic Encyclopedia & Bibliotheca
  Sanctorum → saints), and retired three non-attestational entries (an internal
  placeholder and the Pleiades / ToposText gazetteers).

Every traceability invariant is now **0**: 0 unsourced entities, 0 relationships
without a source, **0 relationships without a rationale**, 0 dangling references,
**0 orphan sources**. (3,173 entities / 5,761 relationships / 362 sources.)

## v1.84.1 — 2026-06-17

### Sourcing / traceability QA pass (`scripts/qa_sourcing_v1_84.sql`)

A full sourcing audit after the v1.77–v1.84 build-out. Core invariants all clean:
**0 unsourced entities, 0 relationships without a source, 0 dangling source references,
0 malformed source records, 0 bad confidence/evidence values.** Two issues found and
fixed:
- **Butler's *Lives of the Saints* (and Bibliotheca Sanctorum) were mis-typed as bare
  'reference work'** — they are scholarly hagiography, so per the project rule (cf.
  Farmer's) they are now **'secondary scholarship'**. Butler alone backed 58 of the
  Catholic-cohort saints, so their primary/scholarly coverage jumped from ~11–21% to
  **100%**. Global primary/scholarly coverage is now **97.2%**.
- **Four newly-added sources had been left orphan** (added but never attached) —
  Hildegard's *Scivias*, Raymond of Capua's *Life of Catherine*, Attar's *Tadhkirat
  al-Awliya*, and Campbell's *Digital Religion* — now attached to the figures they
  document.

Known pre-existing debt (untouched, not from the new data): 77 older relationships
(chiefly the decan/astrological layer) carry no rationale text, and 10 legacy catalog
sources remain unattached. Flagged for a future dedicated backfill.

## v1.84.0 — 2026-06-17

### The angel-numbers lineage, deepened — and a "Lineages" reception-chain visualization

A flagship demonstration of the dataset's reach: a single source-traced thread from
the ancient Zoroastrian angelic hierarchy to Gen-Z "angel numbers" (and a Juice WRLD
tattoo). Two things shipped: the missing links of the chain, and a visualization built
to show it off.

**Data — the number-mysticism thread + the pop endpoint (+6 entities, +16 edges, +3 sources):**
The angelic half of the chain already existed (Amesha Spentas / Fravashis → Second-Temple
archangels → Guardian Angels → New Age angels). This adds the parallel *number-mysticism*
half and wires the full spine:
- New nodes: **Pythagorean Number Mysticism** (Greek, ~530 BCE), **Gematria** (Jewish
  Mystical), **the Scale of Numbers** (Agrippa's *De Occulta Philosophia* — the explicit
  number↔angel table that joins the two threads), **Modern Numerology** (Theosophical),
  **999 (Juice WRLD)** and **11:11** (the contemporary number-devotions).
- The spine, link by link with sourced rationales: Pythagoras + Gematria → Agrippa →
  Modern Numerology → **Angel Numbers** ← New Age Guardian Angels ← (Christian Guardian
  Angels ← Fravashis; archangels ← Amesha Spentas) → **999 / 11:11**. The second-temple
  archangels (Gabriel, Raphael, Uriel) are now also wired `reception_of` the Amesha Spentas
  (Michael already was), and the Christian Guardian Angels `reception_of` the Fravashis.
- Sourced to scholarship (Boyce on Zoroastrian influence, Burkert on Pythagoreanism,
  Scholem on gematria, Dudley on numerology) and primaries (Agrippa; a Juice WRLD profile).

**Visualization — the new `/chain` "Lineages" page:** renders a reception chain as a
left-to-right time-flow (ancient → today): nodes placed by date on a BCE/CE axis, colored
by tradition, arrows pointing from each earlier source to its later reception. Hover an
arrow for its sourced rationale; click any node for its full entry; zoom/pan; search any
figure to trace its lineage. Loads the angel-numbers lineage by default, with featured
chains (Cybele, Aphrodite, Mithras, the Grail). Added to the nav and the homepage's
"Browse & Visualize" cards.

Scorecard now 3,173 entities / 5,761 relationships / 365 sources / 96 traditions.

## v1.83.0 — 2026-06-17

### Contemporary folklore & vernacular religion — the supernatural beings of online and modern lived culture

A new tradition for the emergent supernatural beings people genuinely engage today —
**ritually** (summoning), **devotionally** (petition/veneration), or **apotropaically**
(warding/protection) — the test that separates *lived folklore* (ostension) from mere
fiction. Purely fictional creepypasta and franchises (the Backrooms, SCP, Jeff the
Killer, Momo, etc.) are deliberately EXCLUDED; authentic living Indigenous beliefs
(Skinwalker, Wendigo) and plain cryptozoology (Bigfoot) are out of scope here. New
tradition **"Contemporary Folklore & Vernacular Religion"**, new tradition_profile class
**`vernacular-folklore`**, two new periods (`PER_MODERN_FOLKLORE` 1800–2000,
`PER_DIGITAL_FOLKLORE` 2000–present). **+29 entities, +43 relationships, +20 sources.**
Scorecard now 3,167 entities / 5,745 relationships / 362 sources / 96 traditions.

- **Encountered & apotropaic beings:** the Hat Man, Shadow People & the Old Hag
  (sleep-paralysis entities people ward against — the Old Hag `reception_of` Lilith);
  DMT "machine elves" and the Mantis (entheogenic encounter); Mothman (omen,
  `embodies` the Apocalypse), Chupacabra, the Jersey Devil, La Llorona, El Cucuy, the
  Black-Eyed Children, Krampus; Bloody Mary and Zozo (performed summoning/Ouija
  rites); Slender Man (flagged — born fiction but crossed into ostensive legend with
  real summoning practice); tulpas; Roko's Basilisk (digital eschatology). Several are
  `opposed_by` the existing Guardian Angels / St Nicholas — the apotropaic dimension.
- **Contemporary devotional currents:** **angel numbers** + New Age Guardian Angels —
  the project's own question answered in the data: modeled as a contemporary
  `reception_of` the Christian Guardian Angels AND the Zoroastrian Fravashis & Amesha
  Spentas (the historical taproot of the guardian-angel idea); "the Universe" /
  Manifestation (Law of Attraction); the **Kek** meme-magic egregore (`reception_of`
  the ancient Egyptian frog-god Kek — a real conscious syncretism); the Higher Self,
  Starseeds, the egregore concept; and **WitchTok / online neopagan devotion**, wired
  `reception_of` ten ancient deities it actually revives (Lilith, Loki, Hecate, Hades,
  Persephone, Aphrodite, Hermes, Dionysus, Freyja, Brigid) — edges onto the existing
  entities, not duplicates.
- Sourced to the folkloristics / digital-religion literature (Peck on Slender Man,
  Hufford & Adler on sleep paralysis, Dundes on Bloody Mary, Keel on Mothman, Strassman
  on DMT entities, Burton's *Strange Rites*, Hanegraaff on New Age, Campbell on digital
  religion) plus the primary works (Virtue, Byrne).

## v1.82.0 — 2026-06-17

### Modern mainstream depth (1800–present) — de-occulting the modern era

A scan showed the entire post-1800 era was occult/esoteric (Theosophy, Thelema,
Anthroposophy, Spiritualism) with **zero mainstream modern Christianity or Islam** —
the sharpest expression of the imbalance the standing steer warns against. This adds
the modern mainstream tri-faith devotional layer. **+75 entities, +108 relationships,
+8 sources, 3 new periods**, via `gen_roster.py` from agent JSON (no DB writes by
agents). The **1800+ era went 45 → 120**. Scorecard now 3,138 entities /
5,702 relationships / 342 sources / 95 traditions.

- **Modern Catholic saints & Marian apparitions (`ENT_MOC_`, 34):** the apparitions
  (Lourdes, Fátima, the Miraculous Medal, La Salette, Knock, Beauraing, Banneux —
  each `reception_of` the Virgin Mary) with their seers (Bernadette, the three Fátima
  children), and the modern saints (Thérèse of Lisieux, John Vianney, John Bosco,
  Padre Pio, Faustina, Maximilian Kolbe, Damien of Molokai, Frances Cabrini, Edith
  Stein, Teresa of Calcutta — kept distinct from the 16th-c Teresa of Ávila, John
  Paul II, Óscar Romero, et al.). New period `PER_MODERN_CATHOLIC`; 3 primary sources.
- **Modern Eastern Orthodox saints (`ENT_ORTH_`, 22):** the Russian startsy and
  Athonite elders (John of Kronstadt, Silouan, Paisios, Porphyrios, Sophrony), the
  New Martyrs (the Romanov passion-bearers, Elizabeth Feodorovna, Maria Skobtsova),
  the hesychast theologians (Theophan the Recluse, Nikodemos the Hagiorite, Justin
  Popović) — wired to the existing Seraphim of Sarov and Uncreated-Light/monasticism
  abstractions. New period `PER_MODERN_ORTHODOX`.
- **Modern Sufi reformers & global spread (`ENT_SUF_`, 19):** the neo-Sufi revival
  and worldwide spread — Ahmad ibn Idris, al-Sanusi (Sanusiyya), Ahmad al-Alawi,
  Said Nursi (Risale-i Nur), Ahmadou Bamba (Mouridiyya), Ibrahim Niasse, Inayat Khan
  (Sufism to the West), Bawa Muhaiyaddeen, Nazim al-Haqqani — with their order hubs.
  New period `PER_ISL_MODERN`; 5 primary sources.

## v1.81.0 — 2026-06-17

### Early-modern Abrahamic depth (1500–1800) — filling the era cliff

A fresh era scan showed the early-modern window almost empty (17 entities for
1500–1800, versus hundreds in every adjacent era). This fills it with the
mainstream tri-faith devotional/mystical layer — no occult weighting, per the
standing steer. **+77 entities, +142 relationships, +16 sources, 2 new periods**,
all via the reusable `gen_roster.py` from agent-proposed JSON (agents wrote input
files only, never the DB). The **1500–1800 era went 17 → 94**. Scorecard now
3,063 entities / 5,594 relationships / 334 sources / 95 traditions.

- **Counter-Reformation & Baroque Catholic saints (`ENT_EMC_`, 35):** the Jesuit
  founders (Ignatius, Francis Xavier, Faber, Borgia), the Discalced Carmelite
  mystics (Teresa of Ávila, John of the Cross, Mary Magdalene de' Pazzi), the
  Oratorian/Borromean reformers, the colonial-American saints (Rose of Lima, Martín
  de Porres, Turibius), the charity founders (Vincent de Paul, Louise de Marillac,
  Francis de Sales), the North American Martyrs, and Our Lady of Guadalupe
  (`reception_of` the Virgin Mary). New period `PER_COUNTER_REFORMATION` (1517–1800);
  4 new primary sources (Ignatius' Exercises, Teresa's Interior Castle, John of the
  Cross' Dark Night, de Sales' Devout Life).
- **Early-modern Jewish mystics (`ENT_JM_`, 20):** the human masters of a tradition
  whose *concepts* were already mapped — wired into the existing Lurianic apparatus.
  The Safed/Lurianic circle (Cordovero, Isaac Luria, Hayyim Vital, Karo, Alkabetz,
  Luzzatto — Luria `reveals` the 14 existing Lurianic concepts he taught), the
  Sabbatean messianism (Sabbatai Zevi, Nathan of Gaza), the Hasidic founders (Baal
  Shem Tov → Dov Ber → Schneur Zalman/Levi Yitzhak/Elimelech, plus Nachman of
  Breslov), and the Lithuanian mitnagdim (the Vilna Gaon, who `opposes` Hasidism).
  2 new primary sources (Vital's Etz Chaim, Shivhei ha-Besht).
- **Early-modern Sufi reformers & orders (`ENT_SUF_`, 22):** the reform-and-revival
  era — Ahmad Sirhindi (Naqshbandi-Mujaddidi), al-Nabulsi (Akbari commentator), Shah
  Waliullah, Ahmad al-Tijani (Tijaniyya), the Khalwati/Darqawi lines, and the
  saint-poets (Bulleh Shah, Bhittai, Sultan Bahu, Yunus Emre-tradition). New period
  `PER_ISL_EARLY_MODERN` (1517–1850); the Mujaddidi hub `reception_of` the existing
  Naqshbandi order; al-Nabulsi `reception_of` Ibn Arabi.

## v1.80.0 — 2026-06-17

### High & late-medieval depth (1000–1450) — the mainstream Abrahamic devotional layer

The holistic audit's last open gap: the 1000–1450 window was thin in exactly the
mainstream faiths that actually dominated it. Two cohorts, both venerated-saint
layers (not theologians-as-such), built via the new reusable `gen_roster.py` from
agent-proposed JSON (agents wrote only input files, never the DB). **+52 entities,
+90 edges, +7 sources.** No occult weighting — this is the tri-faith mainstream the
standing steer calls for. Scorecard now 2,986 entities / 5,452 relationships /
318 sources.

- **Latin-West high/late-medieval saints & mystics (`ENT_LMW_`, 21):** the scholastic
  doctors (Anselm, Peter Damian, Albertus Magnus, Thomas Aquinas, Bonaventure), the
  preaching friars (Vincent Ferrer, Bernardino of Siena, Simon Stock), the women
  visionaries (Julian of Norwich, Mechthild of Magdeburg, Angela of Foligno,
  Catherine of Sweden, Frances of Rome), and the remaining Fourteen Holy Helpers
  (Vitus, Erasmus/Elmo, Pantaleon, Eustace, Cyriacus, Acacius). New period
  `PER_HIGH_MEDIEVAL_WEST` (1000–1450); 5 new primary hagiographic sources (Legenda
  Aurea, Hildegard's Scivias, Julian's Revelations, Bonaventure's Legenda Maior,
  Raymond of Capua's Life of Catherine). Wired into the **existing** `ENT_SAINT_`
  layer (Aquinas `taught_by` Albertus; Bonaventure/Bernardino `aligned_with` Francis;
  the new Helpers `member_of` the existing `ENT_SAINT_FOURTEEN_HELPERS`) plus two new
  hubs (Mendicant-Order Saints, Medieval Women Visionaries) and real patronages
  (patron_of healing/protection/wisdom).
- **Post-classical Sufi saints & tariqa founders (`ENT_SUF_`, 31):** filling
  `PER_ISL_MEDIEVAL` (was just 2 entities → now 28). The order eponyms and their
  hubs — Kubrawiyya, Chishtiyya (the full Delhi silsila: Mu'in al-Din Chishti →
  Bakhtiar Kaki → Baba Farid → Nizam al-Din Awliya → Amir Khusrow), Naqshbandiyya
  (Naqshband → Ahrar → Jami), Bektashiyya, Ni'matullahiyya, Badawiyya — plus the
  Ibn-Arabi metaphysical school (Qunawi, Iraqi, Shabistari, al-Jili), saint-poets
  (Yunus Emre, Hafiz), and regional saints (Hamadani, Maneri, Lal Ded, Nund Rishi).
  2 new primary sources (Attar's Tadhkirat al-Awliya, Jami's Nafahat al-Uns).

Process note: the Christian agent emitted its relationships with the type/object
fields transposed (all 52 edges initially REJECTED by the self-validating build);
caught from the REJECTED report and corrected before any bad data landed. New
`gen_roster.py` is a general roster tool (per-entity tradition/period/source).

## v1.79.0 — 2026-06-17

### Connectivity remediation (graph-quality pass, no new roster)

The holistic audit's other standing gap: clusters of near-isolated / degree-1 nodes
that were attested members of well-known systems but had never been wired in. A
relationships-mostly pass adding **+102 attested typed edges** and **5 pantheon
collective hubs** (the only new entities), reusing existing sources/periods. No new
tradition. Scorecard now 2,934 entities / 5,362 relationships / 311 sources.

- **Anatolian (Luwian, Hittite, Hittite/Hurrian):** new `ENT_LUW_PANTHEON` and
  `ENT_HTT_PANTHEON` hubs; the Kumarbi-cycle backbone finally modeled (Teshub
  `child_of` Kumarbi, Kumarbi `parent_of` Ullikummi and `opposes` Teshub, Teshub
  `consort_of` Hepat); Luwian↔Hittite/Hurrian sun/moon/storm cognates (Tiwaz↔Istanu/
  Shimige, Arma↔Kushuh, Tarhunz↔Teshub); the Kubaba→Kybebe→**Cybele** continuity;
  and the missing domain edges. **Luwian, Hittite, Hittite/Hurrian, Etruscan,
  Mycenaean all dropped to 0 degree-≤1 nodes.**
- **Mediterranean (Phoenician, Mycenaean, Etruscan):** new `ENT_PHO_PANTHEON`,
  `ENT_MYC_PANTHEON`, `ENT_ETR_PANTHEON` hubs; the canonical interpretatio that was
  still missing for the single-edge tails — Melqart=Heracles, Tanit=Juno Caelestis,
  Adonis=Dumuzi/Tammuz, Turms=Hermes, Culsans=Janus — plus the genuinely
  Mycenaean-only Linear B recipients (Potnia-forms, Diwia, Enyalios=Enyo) wired to
  their pantheon rather than force-fit to Olympians.
- **Christian/Biblical (NT):** conservative, human-respecting wiring only — the
  apostle brother-pairs (Andrew–Peter, John–James the Greater), the **orphaned Four
  Horsemen** given their war/death domains, Behemoth paired with Leviathan, and the
  four Evangelists as transmitters of revelation. The ~39 remaining one-edge minor
  figures were deliberately left at their single true membership (no invented edges,
  no deifying of humans).

## v1.78.0 — 2026-06-17

### Arthurian legend / Matter of Britain (the Grail mythos)

Built the wholly-absent Arthurian cycle — the audit's runner-up gap, and a high/
late-medieval literary tradition that also helps the 1000-1450 era trough. New
tradition **Arthurian** (`ENT_ART_`), new period PER_ARTHURIAN (1100-1500), 6 new
primary-text sources (Geoffrey of Monmouth, Chrétien de Troyes, Robert de Boron,
the Vulgate Cycle, Wolfram's Parzival, Malory). **+35 entities, +75 relationships**,
0 rejected/orphan/unsourced/unperiodized, 0 unreviewed duplicates. Scorecard now
2,929 entities / 5,260 relationships / 311 sources / 96 traditions.

- **Court & kin:** Arthur, Guinevere, Uther Pendragon, Igraine, Mordred, Morgan le
  Fay, Morgause, King Lot, Merlin, the Lady of the Lake — with the Tintagel
  begetting, the incestuous Mordred, and the Orkney lineage modeled in full.
- **The Round Table:** Lancelot, Galahad, Perceval, Gawain, Bors, Tristan, Kay,
  Bedivere, Gareth, Gaheris, Agravain, Lamorak, Pellinore, and the Green Knight,
  under a Knights-of-the-Round-Table collective.
- **The Grail mythos:** the Holy Grail (`reception_of` Jesus Christ — the cup of the
  Last Supper — and `mediated_by` the existing Joseph of Arimathea, who brought it
  to Britain), the Fisher King, Elaine of Corbenic, Galahad/Perceval/Bors as Grail
  achievers, and the Siege Perilous.
- **Objects & realms:** Excalibur (given by the Lady of the Lake), the Round Table,
  Camelot, Avalon, with Merlin's demonic begetting cross-linked to the Devil.
- Classified in the tradition-profile layer under a new **legendary-literary** class
  (a mythos in story, never a practiced cult).

## v1.77.0 — 2026-06-17

### European regional polytheisms (audit-driven: the largest in-scope gap)

A holistic audit identified the under-built European regional polytheisms — the
mainstream faiths of major European peoples sitting at single digits, far below
attested depth — as the next-largest content gap. **+90 entities, +179
relationships**, 0 rejected/orphan/unsourced/unperiodized, 0 unreviewed
duplicates; 5 new sources, 3 new periods. Scorecard now 2,894 entities /
5,185 relationships / 305 sources / 95 traditions.

- **Slavic 9 → 39:** the entire West-Slavic temple pantheon (Svetovit of Arkona,
  Triglav, Rugievit, Porevit, Porenut, Yarovit, Radegast, Zhiva, Chernobog, and
  the reconstructed Belobog) from Saxo Grammaticus and Helmold; the seasonal/fate
  figures (Svarozhich, the Rozhanitsy, Dola, Marzanna, Jarilo, Kupala, the disputed
  Lada and Devana); and the folk-spirit layer (Domovoi, Rusalka, Leshy, Vodyanoy,
  Kikimora, Bannik, Polevik, Baba Yaga, Koschei, Zmey Gorynych) — under a Slavic
  Pantheon and a Folk-Spirits collective; Perun⟷Veles and Chernobog⟷Belobog wired.
- **Finnish 7 → 25:** the Kalevala roster (Ilmarinen, Lemminkäinen, Vellamo, Tuoni
  & Tuonetar, Kullervo, Pellervo, Nyyrikki, Tellervo, Kalma, Hiisi, Surma, Pekko,
  Rauni) and the realms Tuonela and Pohjola.
- **Baltic 10 → 21:** Aušrinė/Auseklis, Ūsiņš, Bangpūtys, the Prussian Potrimpo and
  Patulas, the Latvian Mātes (with Jūras māte), and the household spirits Aitvaras
  and Kaukas.
- **Three new traditions:** **Basque** (Mari, Sugaar, Basajaun, the Lamiak,
  Tartalo…), **Sámi** (Horagalles, Beaivi, the Máttaráhkká household goddesses,
  Leib-olmai, Stallo…), and **Hungarian/Magyar** (Isten, Ördög, Boldogasszony, the
  Turul, the Világfa world-tree, the táltos) — with cross-links such as
  Boldogasszony→the Virgin Mary and Horagalles→the Norse Thor. All three added to
  the tradition_profile layer (civic-polytheism / regional).
- Disputed/reconstructed figures flagged at confidence C (Belobog, Lada, Devana,
  Urtzi, Hadúr, the Magyar reconstructions).

## v1.76.0 — 2026-06-17

### Tradition-profile layer: mainstream vs. esoteric/marginal, made explicit

Added a tradition-level metadata layer so the database can state — queryably, for
all 91 tradition tags — what KIND of religion each is and how prevalent it was,
rather than leaving raw entity counts to imply that entity-dense esoteric
traditions were mainstream. No entity/relationship changes. New table
`tradition_profile` (tradition, tradition_class, prevalence, status_note) and
public view `v_public_tradition_profile` (added to schema/tables.sql,
schema/views.sql, and the export VIEWS array).

Classes and totals: civic-polytheism (49 traditions / 1,483 entities),
mainstream-scriptural (9 / 468), esoteric-magic (7 / 282), heterodox-sect
(13 / 220), mystical-current (6 / 189), modern-esoteric (6 / 44),
comparative (1 / 118).

The point this captures: the grimoire/occult traditions (Goetic/Solomonic,
Renaissance Esoteric, the magical papyri, etc.) carry many entities because they
catalogue large fixed rosters of named spirits, but they are flagged
`esoteric-magic / learned-subculture` — historically present and influential, yet
textual subcultures of a few specialists framed within and drawing on a host
religion, NOT mainstream faiths. Their influence on the surrounding religions is
already modeled by the existing reception_of links (Bael←Baal, Astaroth←Astarte,
etc.) and by cult_scope='literary'. Note also that the bulk of that occult content
sits in the early-modern period (PER_EARLY_MODERN_OCCULT, 1450-1900), not the
medieval period — the medieval window itself is dominated by mainstream
Christianity, Islam, and Judaism plus the still-living Norse/Celtic polytheisms.

## v1.75.0 — 2026-06-17

### Modern-strand deepening: Alice Bailey, Anthroposophy, Spiritualism

Deepened the modern esoteric strand. **+19 entities, +38 relationships** (34 new
edges), 0 rejected, 0 unsourced/unperiodized/orphan, 0 unreviewed duplicates;
3 new sources. Scorecard now 2,804 entities / 5,006 relationships / 300 sources /
92 traditions. Reuses period PER_MODERN_OCCULT.

- **Alice Bailey's esoteric Theosophy (`ENT_THE_`, extending the Theosophy bloc):**
  Maitreya (the Christ / World Teacher), the Seven Rays, the Solar Angel, Shamballa
  (where Sanat Kumara dwells), the Manu, the Buddhas of Activity, and the ray-Masters
  Jesus, Saint Germain (Rakoczi), Hilarion, and Serapis Bey — wired into the existing
  Spiritual Hierarchy and Mahatmas collectives. Maitreya/Master Jesus aligned_with
  the canonical Jesus Christ (held distinct).
- **Anthroposophy / Rudolf Steiner (`ENT_ANT_`, new tradition):** his polar
  adversaries Ahriman (reception_of Zoroastrian Angra Mainyu) and Lucifer
  (aligned_with the Christian Lucifer; named "Lucifer (Anthroposophical)" to stay
  distinct), the Asuras, Sorat the Sun-Demon (aligned_with the Agrippan Sorath and
  the Antichrist), and the Representative of Humanity (the Christ-balance, opposing
  both Lucifer and Ahriman), under a Threefold Adversaries collective.
- **Spiritualism (`ENT_SPI_`, new tradition):** the Summerland (afterlife realm),
  Spirit Guides, and the Doorkeeper.

## v1.74.0 — 2026-06-17

### Modern occult revival (Thelema, Theosophy, Golden Dawn)

Returned to the esoteric thread with the genuinely-new beings of the c. 1850-1950
revival, **aligned to the database's existing traditions rather than duplicating
them**. New period PER_MODERN_OCCULT; one new source (SRC_GOLDEN_DAWN; the Crowley
and Blavatsky sources already existed). **+19 entities, +38 relationships**,
0 rejected, 0 unsourced/unperiodized/orphan, 0 unreviewed duplicates. Scorecard
now 2,785 entities / 4,972 relationships / 297 sources.

- **Thelema (`ENT_THL_`, extending the existing four deities):** Hoor-paar-kraat,
  Babalon, Therion (the Beast 666), Choronzon, the Holy Guardian Angel, and the
  Aeon of Horus, all gathered with the existing Nuit/Hadit/Ra-Hoor-Khuit/Aiwass
  under a new Thelemic Pantheon collective. Cross-links: Babalon←Whore of Babylon,
  Therion←the Beast, Hoor-paar-kraat←Harpocrates, Choronzon←the Enochian system
  (reception_of); Babalon consort_of Therion; Ra-Hoor-Khuit rules the Aeon of Horus.
- **Theosophy (`ENT_THE_`, reusing the existing Mahatmas collective):** the Masters
  Morya, Koot Hoomi, Djwal Khul, the Maha Chohan (wired into ENT_REC_MAHATMAS),
  and the cosmic hierarchy — Sanat Kumara (Lord of the World), the Solar and
  Planetary Logoi, the Lipika (Lords of Karma), and the Root Races — under a new
  Theosophical Spiritual Hierarchy collective.
- **Golden Dawn (`ENT_MOD_`, 'Modern Occult'):** the Order itself and its Secret
  Chiefs (reception_of the Enochian system; the Secret Chiefs aligned_with the
  Theosophical Masters).
- NOTE: an initial pass mistakenly created a flat 'Modern Occult' tradition that
  duplicated the existing ENT_THL_ Thelemic deities; it was rolled back and rebuilt
  against the existing Thelemic/Theosophical tags.

## v1.73.0 — 2026-06-17

### Mainstream backbone depth: monarchy, Acts, Islamic law & devotion

Completed several mainstream rosters left partial in v1.72. **+64 entities,
+116 relationships**, 0 rejected, 0 unsourced/unperiodized/orphan, 0 unreviewed
duplicates. Scorecard now 2,766 entities / 4,934 relationships / 296 sources.
One new source (SRC_ISLAMIC_TRADITION).

- **Remaining divided-monarchy kings (`ENT_ISR_*`):** the rest of the kings of
  Judah (Abijah, Athaliah, Jehoram, Ahaziah, Joash, Amaziah, Jotham, Amon,
  Jehoahaz, Jehoiakim, Jehoiachin) and Israel (Nadab, Baasha, Elah, Zimri, Tibni,
  Ahaziah, Jehoram, Jehoahaz, Jehoash, Zechariah, Shallum, Menahem, Pekahiah,
  Pekah, Hoshea) — completing both royal lines. Modeled as a single dynastic
  descent chain (child_of) and the northern assassination chain (slays), with
  cross-kingdom and demon homonyms disambiguated by name/id.
- **More Acts/Pauline figures (`ENT_NT_*`):** the remaining Seven Deacons
  (Prochorus, Nicanor, Timon, Parmenas, Nicolaus) and the apostolic-age figures
  Cornelius, Ananias of Damascus, Gamaliel, Agabus, Tabitha, the Ethiopian eunuch,
  Phoebe, Junia, Onesimus, Philemon, Epaphras, Onesiphorus.
- **Islamic law & devotion (`ENT_ISL_*`):** the Four Imams of the Sunni schools
  of law (Abu Hanifa, Malik, al-Shafi'i, Ahmad ibn Hanbal) under a new collective;
  the remaining Ten Promised Paradise (Talha, al-Zubayr, Abd al-Rahman ibn Awf,
  Sa'd ibn Abi Waqqas, Sa'id ibn Zayd, Abu Ubayda); the remaining Mothers of the
  Believers (Sawda, Hafsa, Zaynab bint Jahsh, Umm Salama, Juwayriya, Safiyya,
  Umm Habiba, Maymuna, Zaynab bint Khuzayma); and the Ninety-Nine Names of God
  (al-Asma al-Husna) as a single devotional-set entity (not 99 reified epithets).

## v1.72.0 — 2026-06-17

### Mainstream Abrahamic deepening: canonical figures + folk beings

Continued the mainstream rebalancing — the human canonical figures the backbone
still lacked, plus the popular folk supernatural beings of the three faiths.
**+74 entities, +104 relationships**, 0 rejected, 0 unsourced/unperiodized/orphan,
0 unreviewed duplicates. Scorecard now 2,702 entities / 4,818 relationships /
295 sources. No new periods; 2 new sources for the folklore cohort.

Human canonical figures (+64, all existing scripture/sira sources):
- **Divided-monarchy kings & later Tanakh figures (`ENT_ISR_*`):** the kings of
  Judah (Rehoboam → Zedekiah) and Israel (Jeroboam I, Omri, Ahab, Jehu,
  Jeroboam II) under two new collectives, plus Jezebel, Goliath, Jonathan,
  Absalom, Boaz, Naomi, Naaman, Balaam, Delilah, and the foreign kings
  Nebuchadnezzar II and Cyrus the Great. Wired by dynastic descent and by
  narrative conflict (Elijah opposes Ahab/Jezebel; Goliath slain_by David;
  Naaman healed via Elisha; Nebuchadnezzar vs Zedekiah; Cyrus patron of the
  return).
- **NT apostolic-age figures (`ENT_NT_*`, Christian/Biblical):** the brothers of
  the Lord (James the Just, Jude), the Seven Deacons (Philip the Evangelist +
  existing Stephen), Pauline coworkers (Silas, Apollos, Priscilla, Aquila, Lydia),
  Gospel figures (Joseph of Arimathea, Mary of Bethany, Salome, Zacchaeus, Mary
  of James), and the antagonists Pilate, Herod the Great, Herod Antipas, Caiaphas;
  collectives for the Seven Deacons and the Myrrh-Bearing Women.
- **Early-Islamic foundational figures (`ENT_ISL_*`, sira/hadith-sourced):** the
  Rashidun caliphs (Abu Bakr, Umar, Uthman; Ali wired), major companions (Hamza,
  Bilal, Salman al-Farsi, Khalid ibn al-Walid, Abu Hurayra, Zayd, Ja'far) and the
  Prophet's kin (Abu Talib, Abd al-Muttalib), the Mothers of the Believers
  (Khadijah, Aisha), under the Rashidun / Sahaba / Ummahat al-Mu'minin / Ten
  Promised Paradise collectives.

Folk supernatural beings (+10, 2 new sources):
- **Jewish (`ENT_JM_*`):** Golem, Dybbuk, Ibbur, Estrie.
- **Islamic jinn taxonomy (`ENT_ISL_*`):** Shaytan/Shayatin, Ghul, Si'lat, Div,
  under a new Classes-of-the-Jinn collective (with the existing Ifrit/Marid wired
  in; Iblis rules the shayatin).
- **Christian (`ENT_CHR_*`):** Gog and Magog. (Most major beings — Antichrist,
  Behemoth, Leviathan, the Revelation cast — already existed and were skipped.)

## v1.71.0 — 2026-06-17

### Enochian system of John Dee

Completes the Renaissance-magic arc with the Enochian angelic system of John Dee
and Edward Kelley (1581-1587). Tradition Renaissance Esoteric (`ENT_REN_*`),
reusing period PER_EARLY_MODERN_OCCULT; one new source SRC_DEE_ENOCHIAN (the
Enochian diaries: Heptarchia Mystica, Liber Loagaeth, Liber Scientiae).
**+19 entities, +22 relationships**, 0 rejected, all invariants green.
Scorecard now 2,628 entities / 4,714 relationships / 293 sources.

- **Heptarchia Mystica:** the seven Heptarchic kings (Carmara, Baligon, Bobogel,
  Babalel, Bnaspol, Bynepor, Bnapsen) and seven princes (Hagonel + Bornogo,
  Befafes, Butmono, Blisdon, Bralges, Bagenol), under the system collective
  `ENT_REN_ENOCHIAN`.
- **The Four Watchtowers (Great Table)** and **the Thirty Aethyrs** as collectives,
  with LIL (1st/highest) and TEX (30th/lowest) as named example aethyrs.
- Built conservatively: only firmly-documented structural entities; the hundreds
  of Great-Table square-angels and the full 30 aethyr-governors were deliberately
  NOT enumerated to avoid fabricating precise Enochian names, and manuscript-
  variable day/planet and king-pairing attributions are flagged in-note and given
  confidence C. No sigils (CLAUDE.md boundary).

## v1.70.0 — 2026-06-16

### Mainstream Abrahamic scriptural backbone (Hebrew Bible, New Testament, Qur'an)

A deliberate rebalancing toward the mainstream Judeo-Christian-Islamic canon
after several esoteric/occult releases. An audit found the scriptural backbone
badly underbuilt — Abraham, David, Isaac, Jacob, Aaron, the entire Latter
Prophets, most of the Twelve Apostles, and most of the 25 Qur'anic prophets were
all missing while saints and esoterica were richly developed. **+105 entities,
+209 relationships**, 0 rejected, 0 unsourced/unperiodized/orphan, 0 unreviewed
duplicates. Scorecard now 2,609 entities / 4,692 relationships / 292 sources.
No new sources needed (SRC_HEBREW_BIBLE, SRC_NEW_TESTAMENT, SRC_QURAN all
existed); one new period PER_APOSTOLIC.

- **Hebrew Bible figures (`ENT_ISR_*`, Israelite/Second Temple):** the patriarchs
  and matriarchs (Eve, Abraham, Sarah, Isaac, Rebecca, Jacob, Rachel, Leah,
  Joseph, the tribal eponyms, Lot), Exodus/conquest leaders (Aaron, Miriam,
  Joshua, Caleb), the judges (Deborah, Gideon, Samson), the united monarchy
  (Samuel, Saul, David, Bathsheba), the Writings figures (Ruth, Esther, Mordecai,
  Job, Ezra, Nehemiah), and the prophets — Isaiah, Jeremiah, Ezekiel, Daniel and
  the Twelve Minor Prophets, plus Elisha and Nathan. Precise genealogy modeled
  (parent_of/child_of/spouse_of/sibling_of) and collectives (Patriarchs,
  Matriarchs, Twelve Tribes, Judges, Kings, Latter Prophets, the Twelve).
- **New Testament figures (`ENT_NT_*`, Christian/Biblical):** the Twelve Apostles
  (Andrew, John, Philip, Bartholomew, Thomas, Matthew, James son of Alphaeus,
  Jude, Simon, Judas Iscariot, Matthias — Peter and James the Greater wired from
  their existing saint entities), the Evangelists (Mark, Luke), and the Pauline
  circle and Gospel figures (Barnabas, Timothy, Titus, Lazarus, Martha,
  Nicodemus), under the Twelve Apostles / Four Evangelists / Pauline Circle
  collectives.
- **Qur'anic prophets (`ENT_ISL_*`, Islamic):** the 25 anbiya (Adam, Nuh, Hud,
  Salih, Ibrahim, Lut, Ismail, Ishaq, Yaqub, Yusuf, Ayyub, Shu'ayb, Musa, Harun,
  Dhul-Kifl, Dawud, Sulayman, Ilyas, Al-Yasa, Yunus, Zakariya, Yahya, Isa, plus
  Luqman; Idris/Khidr/Isa/Musa/Ilyas already existed and were wired in), under
  the Prophets of Islam and Ulu al-Azm collectives.
- **Headline cross-tradition feature — 24 `reception_of` links** from the Qur'anic
  prophets to their Hebrew/Christian counterparts (Ibrahim←Abraham, Musa←Moses,
  Dawud←David, Isa←Jesus, Yahya←John the Baptist, …), making the shared Abrahamic
  prophetic lineage explicit and queryable.
- Disambiguated homonyms: Joseph-the-patriarch vs Joseph of Nazareth, Islamic
  Adam vs Israelite Adam (by name), biblical Daniel vs the Shem-angel Daniel (by
  id), and registered duplicate-review rows for Seth (biblical vs Egyptian vs
  Sethian) and Thomas (apostle vs Thomasine).

## v1.69.0 — 2026-06-16

### Renaissance angelic & planetary magic: Shem ha-Mephorash 72 + Agrippa + Olympic Spirits

The angelic-and-planetary half of the Renaissance-magic roadmap, and the
benevolent counterpart to the v1.68.0 Goetia. New tradition **Renaissance
Esoteric** (prefix `ENT_REN_`), reusing period `PER_EARLY_MODERN_OCCULT`; 3 new
sources (Kircher's *Oedipus Aegyptiacus*; the *Arbatel de magia veterum* 1575;
Thomas Rudd's *Treatise on Angel Magic* / "Goetia of Dr Rudd", ed.
Skinner & Rankine). **+96 entities, +266 relationships**, 0 rejected,
0 unsourced/unperiodized/orphan, 0 unreviewed duplicates. Scorecard now
2,504 entities / 4,483 relationships / 292 sources / 88 traditions.

- **The Shem ha-Mephorash 72 angels (`ENT_REN_*`):** all 72, Vehuiah (#1) →
  Mumiah (#72), derived from the three verses Exodus 14:19-21 (each a three-letter
  fragment of the divine Name + suffix -el/-iah), each tied to its 5° zodiacal
  quinance and Chaldean ruling planet, with its traditional office. All
  `member_of` the new collective `ENT_REN_SHEM_72` and `presides_over` 1-2 office
  abstractions (healing, protection, love, justice, wisdom, knowledge, etc.).
- **The 72 angels vs the 72 demons:** `ENT_REN_SHEM_72 opposes ENT_GOE_ARS_GOETIA`
  — Rudd's tradition pairs the benevolent Shem angels against the Ars Goetia
  demons. The opposition is modeled at the **set level**, since the specific
  one-to-one assignments differ between tabulations (the two research passes
  themselves disagreed on the ordinal mapping).
- **Agrippa's planetary Intelligences & Spirits (`ENT_REN_*`):** the 7
  Intelligence/Spirit pairs from the magic squares of *De occulta philosophia*
  II.22 (Agiel/Zazel, Iophiel/Hismael, Graphiel/Bartzabel, Nakhiel/Sorath,
  Hagiel/Kedemel, Tiriel/Taphthartharath, Malkah-be-Tarshishim/Chashmodai),
  under the collective `ENT_REN_AGRIPPA_PLANETARY`.
- **The Olympic Spirits of the Arbatel:** Aratron, Bethor, Phaleg, Och, Hagith,
  Ophiel, Phul (with province counts), under `ENT_REN_OLYMPIC_SPIRITS`.
- **Cross-links:** every planetary entity is `aligned_with` both its Greek
  planetary cognate (Kronos/Zeus/Ares/Helios/Aphrodite/Hermes/Selene) and the
  existing v1.66 Picatrix planetary spirit (`ENT_AST_*_SPIRIT`), building a
  Picatrix↔Agrippa↔Arbatel planetary-magic hub; Intelligence `paired_with` Spirit,
  and Olympic spirit `paired_with` Agrippa Intelligence, per planet.
- Modeled as catalogued entities (name/rank/office/correspondence/cross-links);
  no sigils or seals (CLAUDE.md boundary). Enochian/Dee is the queued follow-up.

## v1.68.0 — 2026-06-16

### Grimoire demonology: the Ars Goetia + the infernal hierarchy

Opened the post-medieval Western esoteric continuum with the first early-modern
grimoire cohort. New tradition tag **Goetic/Solomonic**, new period
**PER_EARLY_MODERN_OCCULT** (1450–1900), 3 new sources (Lemegeton/Ars Goetia ed.
Mathers & Crowley; Weyer's *Pseudomonarchia Daemonum* 1577; Collin de Plancy's
*Dictionnaire Infernal* 1818). **+77 entities, +217 relationships**, 0 rejected,
0 unsourced/unperiodized/orphan, 0 unreviewed duplicates. Scorecard now
2,408 entities / 4,217 relationships / 289 sources.

- **The 72 spirits of the Ars Goetia (ENT_GOE_*):** every spirit Bael (#1) →
  Andromalius (#72) with its canonical rank (King/Duke/Prince/Marquis/President/
  Earl/Knight, double ranks preserved), legion count, and office, cross-checked
  between the Lemegeton and Weyer. Each is `member_of` the new umbrella collective
  **ENT_GOE_ARS_GOETIA** and `presides_over` 1–3 office abstractions (hidden
  knowledge, prophecy, love, war, wealth, disease, death, craft, deception,
  revelation, protection, magic, destruction, forbidden knowledge).
- **Demonological receptions (reception_of):** Bael←Baal (Canaanite),
  Astaroth←Astarte, Asmoday←Asmodeus (←Aeshma Daeva), Belial(Goetia)←Belial —
  the four securely-attested derivations of grimoire demons from older deities.
  Belial(Goetia) is kept distinct from the existing ENT_ISR_BELIAL by name.
- **The infernal hierarchy / princes of Hell:** new collectives
  **ENT_GOE_INFERNAL_HIERARCHY** and **ENT_GOE_SEVEN_DEADLY_DEMONS** (Binsfeld
  1589), the new princes Belphegor (sloth) and Adramelech (chancellor of Hell),
  and the seven-deadly-sin mapping wired to the *existing* canonical entities —
  Lucifer (pride), Mammon (greed), Asmodeus (lust), Leviathan (envy), Beelzebub
  (gluttony), Satan (wrath) — rather than duplicating them.
- Demons modeled strictly as catalogued entities (name/rank/legions/office/
  cross-links); no ritual seals or sigils (CLAUDE.md boundary).

## v1.67.6 — 2026-06-16

### Whole-DB cross-tradition verb sweep

Audited all 474 "strong-verb" cross-tradition comparative links (reception_of /
received_as / equated_with / identified_with / syncretized_with / cult_form_of
between two real traditions). The interpretatio blocks (Roman=Greek, Etruscan,
Scythian/Norse from Herodotus/Tacitus) and the genuine reception chains (Abrahamic
Islamic←Israelite, Welsh←Irish←Gaulish, Ishtar→Astarte→Aphrodite, Dumuzi→Adonis,
Hurrian-Hittite succession Kumarbi→Kronos / Illuyanka→Python, the Testament-of-
Solomon decans, Matar→Cybele) are correct and unchanged. Corrected the systematic
error class:

- **Functional Near-East↔Greek cosmic equations → aligned_with (13):** the reverse/
  parallel edges of the v1.67.5 Mesopotamian fixes were still mislabeled
  reception_of — Oceanus←Apsu, Ouranos←Anu, Zeus←Enlil, Zeus←Marduk,
  Prometheus←Enki, Demeter←Ninhursag, Demeter←Telipinu, Persephone←Ereshkigal,
  Hermes←Nabu, Selene←Sin, and the Chaoskampf set Typhon←Tiamat, Lotan←Tiamat,
  Leviathan←Tiamat (the genuine serpent chain is Lotan→Leviathan, kept). Now
  consistent in both directions.
- **Deduplicated double-verb pairs (6):** removed the redundant weaker verb where a
  link was modeled twice — Astarte=Ishtar (kept reception_of), Leviathan=Tiamat
  (now aligned_with), Leviathan=Lotan (kept reception_of), Dushara=Dionysus / Al-Lat
  =Athena / Al-Uzza=Aphrodite (kept the equated_with interpretatio).
- **Propagated two earlier fixes to their reverse edges:** Lilith's reception
  re-pointed from Lamashtu to Lilitu; the discredited Sin=Hubal link removed on the
  Hubal side too.

Net: 0 entity change (-7 relationships); cross-tradition verbs now consistent
(aligned_with 162, reception_of 184). scripts/build_qa6_fixes.sql.

## v1.67.5 — 2026-06-16

### Fifth audit pass: the Mesopotamian deepening (v1.52 / v1.60)

Adversarial three-agent audit of the 109-entity Mesopotamian cohort (city-gods,
demons, theogony, the Seven Sages, cross-tradition links). NO fabrications — all
109 are genuinely attested, every city-god assignment correct, the Enuma Elish
theogony chain and the Uruk-List Seven-Sages king-pairings verified accurate (one
audit agent's "fix" to the sage-pairings was itself mistaken and was rejected after
cross-check against Lenzi 2008). Corrections were relationship/verb discipline:

- **Cross-tradition verb discipline:** 14 links downgraded received_as → aligned_with
  where they are functional/typological parallels, not attested receptions —
  Anu→Ouranos, Apsu→Oceanus, Enlil→Zeus, Marduk→Zeus, Enki→Prometheus,
  Ninhursag→Demeter, Ereshkigal→Persephone, Nabu→Hermes, Sin→Selene,
  Dumuzi→Melqart, Dumuzi→Telipinu, and the Chaoskampf set Tiamat→Lotan/Leviathan/
  Typhon (the real chains run Lotan→Leviathan and via Hurrian-Hittite intermediaries).
  Kept as genuine receptions: Ishtar→Astarte→Aphrodite, Dumuzi→Adonis, Apkallu→
  Watchers; kept identified_with: Ishtar=Shaushka.
- **Removed:** Sin = Hubal (a discredited Winckler/Morey-era "moon-god" speculation
  with no attestation).
- **Re-rooted:** Lilith descends from the lilitu night-demon, not Lamashtu —
  re-pointed received_as from Lamashtu to Lilitu.
- **Inverted edges flipped:** Kulla and Saltu were modeled as "creator_of Ea" when
  both were *created by* Ea — corrected to Ea creator_of Kulla / Saltu.
- **Relationship fixes:** Humut-tabal "dwells_in Ereshkigal" (a deity) → dwells_in
  Underworld; removed Pabilsag's wrong parentage of Ninazu and his redundant Gula
  consort-link (Gula = Ninisina by syncretism); Damu re-parented from Gula to
  Ninisina; the orphan Etana wired to his patron Shamash (Etana epic).
- **Confidence/notes:** Gugalanna A→B (the Bull-of-Heaven identity is an inferential
  modern synthesis); Gula/Humut-tabal/Damu notes reworded for accuracy.

Net: 0 entity change (-6 / +4 relationships); scorecard clean. scripts/build_qa5_fixes.sql.

## v1.67.4 — 2026-06-16

### Fourth audit pass: Celtic inscriptional gods + Egyptian Duat cast

Adversarial audit of the Gaulish/Romano-British inscriptional gods (40) and the
Egyptian netherworld-book cast (Amduat / Book of Gates / Litany of Re, 38).
Integrity clean. One likely fabrication caught; the rest are real with corrections.

- **Removed (1):** ENT_EGY_AKHEKHI — "guardian of gate 12 paired with Pai" is not
  attested in Hornung/Budge (the 12th gate is Tjeser-baiu, guarded by Isis/Nephthys
  serpents); the name appears conflated with the Set-creature Akhekh.
- **Egyptian fixes:** Ankh-neteru renamed to the correct Ka-en-Ankh-Neteru (the
  12th-hour tow-serpent); Ammit's broken relationships fixed (belongs_to_realm
  Osiris → Duat; removed "judges Maat" — she devours the unjustified, she does not
  judge); Mehet-Weret's "embodies Ra" removed (she is an Eye of Ra who *bears* the
  sun, not Ra himself); Ka-Maat's spurious link to the 75 Forms of Re removed
  (genre conflation); Set-em-maat-f's BD-125 "Hall of Maat" gloss dropped + downgraded.
- **Celtic interpretatio cleanup:** the disputed Lucan-triad equations softened —
  Esus and Teutates retyped equated_with → aligned_with with notes that the Bern
  scholia transmit contradictory Mars/Mercury traditions; Taranis "aligned_with
  Jupiter" upgraded to equated_with (it IS an ancient interpretatio); Belenus's
  "embodies Sun" removed (the solar etymology is now doubted — he is a healing/Apollo
  god); Nodens given a Silvanus association so the epigraphic "Mars" framing does not
  bury his healing/hunting/sea character. Note caveats added for the single-source/
  hapax/inferred cases (Cathubodua, Lugus, Maponos).

Net: -1 entity; scorecard clean. scripts/build_qa4_fixes.sql.

## v1.67.3 — 2026-06-16

### Third audit pass: the 42 Assessors (BD Spell 125) + Roman indigitamenta

Adversarial audit of the two structured "list" cohorts most prone to fabrication —
the 42 Assessors of Maat (each with a name, city, and the sin denied) and the Roman
indigitamenta (Varro's function-gods, each with a classical citation). Both came
back essentially clean — NO fabrications, NO removals; the Assessors are a faithful
reproduction of Budge's Spell 125 (all names/order/sin-pairings verified) and the
Roman set is well-sourced with the canonical twelve Fabius Pictor farming gods
exactly right. Refinements only:

- **Assessors:** restored canonical sin-wording where the notes had paraphrased
  loosely — #6 Ruruti (purloining offerings, not "destroying"), #13 Basti ("eating
  the heart" idiom, not "foul deeds"), #26 Nekhenu (dropped the extraneous
  "hoodwinking"); hedged #22 Maa-antuf's uncertain "Xois" city gloss (the text gives
  Per-Menu).
- **Roman:** fixed the Cardea/Carna citation conflation (Ovid Fasti 6.101 is
  Carna/Cranae, not Cardea — re-sourced Cardea to Augustine CD 4.8/6.7, flagged the
  ancient conflation on both); corrected Mutunus Tutunus's citation (Festus 154L +
  Augustine CD 6.9, not 4.11); softened Vacuna's overstated function; tightened the
  citations for Semo Sancus (Dius Fidius = Varro LL 5.66), Pilumnus (Augustine CD
  6.9 for the Silvanus-warding rite), Vagitanus (Vaticanus variant), and Segetia.

No structural change (note/citation accuracy only); scorecard unchanged.
scripts/build_qa3_fixes.sql.

## v1.67.2 — 2026-06-16

### Second scholarly-audit pass: deep-past (v1.65) + occult (v1.66) cohorts

Applied the same adversarial five-agent scholarly audit (plus deterministic
integrity battery) to the two other large agent-built batches that had never been
audited — 112 entities. Integrity was clean (0 orphans/unsourced/unperiodized,
0 homonym collisions, all verbs typed). Encouragingly, NO fabrications were found
in the high-risk Jewish-magical cluster: all twelve Sefer ha-Razim angel names
verified against the Rebiger & Schaefer and Morgan editions, including embedded
roster details (Michael/Gabriel under Klmial, Nuriel under Dlqial, the E/W sixth-
firmament split). Corrections this release:

- **Removed (4) — entities that should not exist:** ENT_ELAM_TEPTI ("Tepti/Temti"
  is the Elamite word *lord* / a theophoric element, not a deity); ENT_PGM_
  ABLANATHANALBA and ENT_PGM_SESENGENBARPHARANGES (*voces magicae* / magic words,
  not addressable powers — per Brashear, Gager); ENT_SOL_GENON (not an attested
  Ars Notoria angel in Véronèse's edition; garbled).
- **Anachronism re-sourced:** the standardized seven planetary-angel set
  (Cassiel/Sachiel/Anael/Samael…) was attributed to the 13c Liber Razielis but is
  the 16c Agrippa Scale of Seven (De occulta philosophia II.10, 1533). Added
  SRC_AGRIPPA_OCCULTA, re-sourced the standardized attributions, downgraded the
  four affected entities to C, and reworded notes (Sachiel's 13c precursor is
  Satquiel; the Venus/Mars attributions are Agrippa-era).
- **Homonym-as-identity fixed:** ENT_SOL_ANAEL / ENT_LAT_ANAEL and ENT_SOL_
  SAMAEL_MARS / ENT_GNO_SAMAEL retyped identified_with → aligned_with (same name,
  distinct figures); likewise Ninegal "identified_with Inanna" and Narundi
  "equated_with Ishtar" softened to aligned_with (Belet-ekallim is a distinct
  palace goddess; Narundi's Ishtar link is loose).
- **Invented/incorrect relationships:** removed Nirah "child_of Ishtaran" (he is
  Ishtaran's messenger/sukkal, not son); Ninkurra "child_of Enki" → "child_of
  Ninshar" (the Enki-Ninhursag sequence); Nebethetepet "spouse_of Atum" →
  "paired_with" (she personifies Atum's creative hand); removed spurious Bat
  "protected_by Horus" and Sed "patron_of Horus".
- **Over-specified domains stripped:** Af Bri → rain/Water (not Protection);
  Iabet's Sun, Aha's Apep, Pesakir's vacuous "Magic", Boel's "Revelation" (it is
  dream-divination), Sefer-Raziel-Teaching's Healing, and the beatific-vision
  operation's Protection — all removed or corrected. Picatrix-spirit → Olympian
  alignments (Zeus/Ares/Aphrodite/Hermes/Helios/Selene) recalibrated high → medium.
- Note corrections on ~11 entities (Henkhisesui flagged Late-Period, Narundi
  re-dated, etc.).

Net: -4 entities; scorecard clean. scripts/build_qa2_fixes.sql.

## v1.67.1 — 2026-06-16

### Scholarly audit corrections to the early-antiquity fringe (v1.67.0)

An adversarial five-agent scholarly audit (plus a deterministic integrity pass)
of the v1.67.0 fringe section. Integrity was clean (0 orphans/unsourced/unperiodized,
0 homonym collisions, all relationships typed). The scholarly pass found and this
release fixes:

- **Duplicate merged:** ENT_SAB_SIN_HAWL and ENT_SAB_SAYIN are the SAME Hadramite
  national god (s1yn); "Sin/Hawl" is a superseded transcription that wrongly
  assimilated him to the Mesopotamian moon-god. Merged into ENT_SAB_SAYIN (solar
  vs lunar character noted as debated).
- **Fabricated attestation removed:** the Meroitic Aritene/Mash pair carried an
  invented joint citation ("Haramadeye / REM 0277") and invented relationships.
  Corrected: Mash is the genuinely-attested sun god (upgraded B; Sedeinga "priest
  of Masha", Mash-Amani = Amun-Ra); Aritene downgraded to C as a contested
  (Priese 1984) and largely superseded solar reading. Fabricated edges removed.
- **Conflation undone:** ENT_ELAM_NAPIR was loaded with the supreme god
  Napirisha's attributes (Untash-Napirisha, Tchoga Zanbil, "protector of the
  gods"). Reworded (name = "god"; lunar reading flagged non-consensus); the
  Napirisha material and the spurious guardian_of-Humban link removed.
- **Contradicted/inverted links removed:** Tirutur "member_of Humban" (the Ayapir
  sanctuary is Tirutur's own); Suhsipa "belongs_to_realm Underworld" (Henkelman
  explicitly excludes it — husa = sacred grove, not netherworld).
- **Mistag fixed:** Kubaba retagged Aramean → Luwian (Neo-Hittite Carchemish);
  the Kubaba→Kybele descent reworded as debated.
- **Misattribution fixed:** Julian equates Azizos with Ares and Monimos with
  Hermes (not Venus); notes corrected and those equations added.
- **Removed:** ENT_URA_SARDI (a bare god-list star-name whose only domain wrongly
  pointed at the Sun, duplicating Shivini).
- **Over-specified domains stripped:** speculative domains on Linear B cult-
  recipients (Potnia-of-the-Labyrinth→Earth, Iphimedeia→Fertility, Trisheros→
  Death, Qe-ra-si-ja→Animals) removed; a new "Deities of the Pylos Tn 316 Tablet"
  collective keeps them connected. Drimios downgraded A→B (single-line attestation).
- **Domain-vs-interpretatio cleanup:** moved interpretatio targets out of
  presides_over (al-Kutbaʾ→Writing not Wealth; al-ʿUzza-of-Petra embodies Venus;
  Dushara's contested solar domain removed).
- **Source transparency:** re-anchored the five Qurʾan-71:23 idols + the idol
  collective from SRC_QURAN (which only names them) to SRC_HOYLAND_ARABIA
  (epigraphic scholarship), retaining Qurʾan as a secondary name-attestation.
  Note corrections: Dhu'l-Khalasa at Tabala (Tihama/Asir, not Yemen); Shai
  al-Qaum "builds no tomb" embellishment dropped; Saʿd reframed as a tribal betyl.
- **Connectivity:** added attested interpretatio for leaf war/sun gods (Cosus,
  Pleistoros, Kandaon → Ares; Elagabal → Helios; Beher equated_with Poseidon;
  Astar aligned_with Zeus; Selardi verb normalized).

Net: -2 entities (1 merge, 1 removal) +1 collective; scorecard clean.
scripts/build_fringe_audit_fixes.sql.

## v1.67.0 — 2026-06-16

### Early-antiquity fringe completion (Nabataean → Aksum)

Brought the long tail of small/peripheral ancient pantheons up to their attested
depth, completing the early-antique coverage to the limit of the surviving record.
+78 entities, +161 relationships, +3 sources, +2 periods, +2 traditions (six
parallel research passes; primary/scholarly-sourced, period-linked, fully wired,
0 rejected, scorecard clean).

- **Nabataean (NEW tradition, +6):** Shai al-Qaum, Aʿra of Bostra, al-Kutbaʾ,
  Manotu of Hegra, al-ʿUzza of Petra, plus a Nabataean Pantheon collective that
  wires in the existing shared Arabian gods (Dushara, Allat, al-ʿUzza, Manat,
  Hubal) and their interpretatio (Dushara=Dionysus, Allat=Athena, al-ʿUzza=Aphrodite).
- **Pre-Islamic Arabian (5→17):** the Kaʿba/sanctuary idols of Ibn al-Kalbi's
  Book of Idols and Qurʾan 71:23 — Isaf & Naʾila, Manaf, Dhu'l-Khalasa, Ruda,
  Nuhm, al-Fals, Saʿd, Quzaḥ, Suwaʿ, Yaʿuq.
- **South Arabian (4→16):** Wadd, Anbay, Sayin, Sin/Hawl, Taʾlab, Hawbas, the
  solar Ladies (Dhat-Himyam, Dhat-Baʿdan, Dhat-Zahran), Basamum, Nasr, Yaghuth.
- **Aksumite / Ethiopian (NEW tradition, +5):** Ezana's pre-Christian triad
  Astar–Beher–Medr and the war-god Mahrem (=Ares), with the Dʿmt-period South-
  Arabian gods (Almaqah, ʿAthtar, Hawbas, Dhat-Himyam) wired into the Aksumite
  pantheon. New period PER_DMT_AKSUM.
- **Aramean (3→15):** the Palmyrene set (Bel, Yarhibol, Aglibol, Malakbel,
  Allat-of-Palmyra), Sin of Harran, Rakib-El & Sahar of Samʾal, Kubaba of
  Carchemish, Elagabal of Emesa, the Edessene star-twins Azizos & Monimos.
- **Urartian (4→11):** the Khaldi-Teisheba-Shivini supreme triad collective,
  Bagmashtu, Selardi, Tushpuea, Huba (=Hurrian Hepat), Sardi, the Spear of Khaldi.
- **Iberian/Lusitanian (5→13), Mycenaean (3→10), Thracian (5→9), Meroitic (5→7),
  Elamite (20→23):** Lusitanian votive gods (Cosus, Reue, Bormanicus…); genuinely-
  distinct Linear B deities (Mistress of the Labyrinth, Drimios, Trisheros…); the
  Thracian Horseman, Pleistoros, Zibelthiurdos; the Meroitic Aritene & Mash; the
  Elamite Napir, Tirutur, Suhsipa.

Homonyms kept distinct (Allat-of-Palmyra/Manotu/al-ʿUzza-of-Petra as cult-forms
cross-linked to the pan-Arabian originals; Yaghuth/Nasr deduplicated to their
South-Arabian entries). Bare god-list names with no content deliberately excluded
(e.g. the Urartian "Ua"). The Phoenician pass returned zero rather than pad.
scripts/gen_fringe.py, scripts/build_fringe.sql, scripts/_fringe/.

## v1.66.1 — 2026-06-16

### Surface the occult layer on the public site

- New canned query **magical-papyri-hub** ("The Magical Papyri — gods fused across
  traditions"): the members of the PGM "Invoked Powers" collective with their home
  traditions — a compact demonstration of how late-antique magic drew Greek,
  Egyptian, Jewish, Mesopotamian and Gnostic powers into one operative system.
- New homepage card in the Comparative Core section linking to it.
No data change. templates/index.html, metadata.yaml.

## v1.66.0 — 2026-06-16

### Late-antique & early-medieval occult build

Added four under-represented occult corpora the user requested (entities rarely
surfaced in mainstream-tradition rosters), via four parallel research passes:

- **Greco-Egyptian Magical / PGM (+6, new tradition):** the genuinely-new named
  powers of the Greek Magical Papyri — the Headless One (Akephalos), the
  Kosmokrator, the aerial-and-chthonic daimones, and the protective name-powers
  Ablanathanalba and Sesengenbarpharanges — under a new collective, "The Invoked
  Powers of the Magical Papyri." Crucially, the ~17 PGM-invoked gods that ALREADY
  existed (Iao, Sabaoth, Abrasax, Aion, Seth/Typhon, Helios, Ra, Selene, Hekate,
  Ereshkigal, Bes, Harpocrates, Agathos Daimon, Ananke, Pan, Mithras) were wired
  INTO that collective rather than duplicated — making it a cross-tradition hub of
  9 distinct traditions, modeling how late-antique magic fused Greek, Egyptian,
  Jewish and Mesopotamian powers.
- **Jewish magical angelology (+19, Jewish Mystical):** the angels of the seven
  firmaments of Sefer ha-Razim (encampment-chiefs Aurpnial/Boel-of-dreams/Pesakir
  and the third- and sixth-firmament princes), the sword-angels of the Sword of
  Moses (Margioiel, Vehadrziolo, Totrisi — Soqedhozi already present), Af Bri the
  rain-angel, and the Teaching of Raziel.
- **Astral Magic / Picatrix (+11, new tradition):** the seven planetary spirits
  (each cross-linked to its classical cognate), the Perfect Nature (the sage's
  celestial guardian), the 28 lunar mansions and the 36 decans.
- **Solomonic Magic (+11, new tradition):** the seven planetary angels of the
  grimoire tradition (Cassiel, Sachiel, Anael, Samael-of-Mars new; Michael/
  Raphael/Gabriel wired from the existing canonical archangels), the angels and
  notae of the Ars Notoria, the angelic kings of the air and beatific-vision
  operation of the Liber Juratus, and the Semiforas of the Liber Razielis.

+47 entities, +133 relationships, +7 sources (Sefer ha-Razim, Sword of Moses,
Sefer Raziel, Picatrix, Liber Juratus, Ars Notoria, Liber Razielis), +3 traditions.
All primary-sourced, period-linked, fully wired (0 orphans), homonyms kept distinct
(grimoire Anael/Samael vs Testament-of-Solomon/Gnostic), 0 rejected, scorecard
clean. scripts/gen_occult.py, scripts/build_occult.sql, scripts/_occult/.

## v1.65.0 — 2026-06-16

### Deep-past enrichment (archaic Sumerian, predynastic Egyptian, Elamite)

Thickened the oldest strata of the dataset and used the build as an empirical test
of the Egypt<->Mesopotamia independence finding.

- **Archaic Sumerian / Early Dynastic (+31):** deities from the earliest god-lists
  (Fara, Abu Salabikh, the Zame Hymns) most rosters skip — Lagash-pantheon figures
  (Hendursaga, Nin-MAR.KI, Gatumdug, Nindara, Igalima, Shulshaga, Shul-utula, the
  sons of Ningirsu), the Isin healing circle (Ninisina, Gunura), the Adab/Kesh sons
  of Ninhursag (Ashgi, Panigingarra), the craft/birth circle (Ninmug, Ninildu,
  Ninkurra, Ninshar, Ninimma), Gibil the fire god, Ningirima of the earliest
  incantations, the Uruk Kullaba tutelaries (Mes-sanga-Unug, Ninirigal), Nungal of
  prisons, and others. (Pabilsag was already present; the build enriched it.)
- **Predynastic / Old Kingdom Egyptian (+18):** Bat (the Narmer-Palette cow-goddess),
  Mehit, the Souls of Pe and Souls of Nekhen, the directional pair Iabet/Imentet,
  Nebethetepet (the creative hand of Atum), the archaic feline/serpent/scorpion
  tutelaries (Seret, Sepa, Hededet), the Letopolis/Athribis falcon gods, Aha (the
  Middle Kingdom antecedent of Bes), and Sefkhet-Abwy of the foundation rite.
- **Elamite (+16, from 4 to 20):** the genuine eastern bridge — Pinikir (=Ishtar/
  Ninsianna), Simut (=Nergal), Nahhunte (=Shamash), Manzat, Ruhurater, the Susian
  afterlife judges Lagamal and Ishmekarab, Narundi, and the Tchoga Zanbil cult
  deities. New source SRC_HENKELMAN_ELAM (Henkelman, The Other Gods Who Are).

+65 entities, +141 relationships, +1 source, all primary/scholarly-sourced,
period-linked, fully wired (no orphans), 0 rejected, scorecard clean.

**Empirical result:** adding these 65 archaic entities raised the pre-2000 BCE
stratum from 152 to 217 entities but left direct Egypt<->Mesopotamia comparative
links unchanged at 2, while Elam<->Mesopotamia links rose to 11. Deepening
attestation in the era most vulnerable to sampling bias did NOT manufacture
Egypt<->Mesopotamia connections — evidence that their independence is real, not an
artifact of thin sourcing, and that east-west contact ran through Elam.
scripts/gen_deep_past.py, scripts/build_deep_past.sql, scripts/_deeppast/.

## v1.64.0 — 2026-06-16

### Jewish angelology expansion

Roughly doubled the Jewish angel roster (~36 -> 73). Added the 3 Enoch / Hekhalot
angelic princes — the cosmic-phenomenon princes of 3 Enoch 14 (hail, wind, thunder,
rain, snow, the spheres of the sun and moon, the constellations, day and night) and
the throne-princes of Metatron's retinue (Kerubiel, Seraphiel, Hayliel, Rikbiel,
the two Soperiel scribes of the living and the dead, Soqedhozi the weigher of merits,
Hadraniel, Anpiel, Radueriel) — the missing classic angelic ranks (Cherubim, Erelim,
Malachim, Elohim, Ishim) gathered under a new Heavenly Host collective, and
medieval/Kabbalistic archangels (Kemuel, Zadkiel, Haniel, Zaphkiel). All
primary/scholarly-sourced (3 Enoch, the Hekhalot Synopse, Maimonides Mishneh Torah,
the Zohar), period-linked to a new Merkavah/Hekhalot period (200-700 CE), and fully
wired (no orphans created). +37 entities, +47 relationships, +1 source, +1 period.
Homonyms kept distinct (Baraqiel/Kokabiel remain the 1 Enoch Watchers; the Jewish
Cherubim registered intentional_distinct from the Christian). scripts/build_jewish_angelology.sql.

## v1.63.2 — 2026-06-16

### Connectivity batch 3 — enriched under-wired Egyptian & Mesopotamian entities

**+66 typed, source-backed edges** adding family, pantheon, syncretism, and domain
links to degree-1 entities (researched per cluster by four agents, schema-validated,
0 rejected). Egyptian single-edge entities 83 -> 65; Mesopotamian 57 -> 20.
Examples: Nefertem child_of Sekhmet & Ptah; Mehen opposes Apep; Neper
syncretized_with Osiris; Bau -> Healing, Ishtaran -> Justice, Tishpak/Zababa -> War,
Ishara/Nanaya -> Love; Kishar parent_of Anu; Humbaba slain_by Enkidu;
Belet-seri / Geshtinanna / Neti -> the Underworld. (Boilerplate per-Assessor
"presides_over Truth" spokes were dropped as noise.) Relationships 3,485 -> 3,551;
0 unsourced, 0 unresolved, 0 unreviewed dups. `scripts/wire_singleedge_v1.sql`.

## v1.63.1 — 2026-06-16

### Audit follow-through: completeness fixes + more orphan wiring

- Filled the **85 missing `evidence_confidence`** values by a transparent,
  source-tied rule (Cross-traditional abstraction -> A; any primary source -> B;
  reference/secondary-only -> C). `scripts/audit_fixes_v1.sql`.
- Retyped the **15 `associated_with`** code-smell edges to precise relations
  (bull-cults -> cult_form_of; doorway/grain minor gods -> presided_over_by;
  counterparts and shared-cult pairs -> paired_with). Same script.
- Wired **17 more orphans (39 -> 22)** via `scripts/wire_orphans_v2.sql`: non-saint
  isolates to existing domain abstractions (Halki->Agriculture, Maliya->Water,
  Runtiya->Animals, Tayet->Craft, Ugallu->Thresholds, the Four Races protected_by
  Ra, Keresaspa slays the Dragon); saints to existing domains (Cecilia->Music,
  Martin->Monasticism, Sebastian opposes Disease); and a new **Royal Saints**
  collective for the orphaned canonized monarchs (Louis IX, Olaf, Wenceslaus,
  Stephen I, Edmund, Canute, Casimir).

The 22 remaining orphans are deliberately left — saints whose only patronages are
places/nations/conditions not modeled as entities, plus a few genuine isolates —
rather than wired with off-ontology entities or forced edges. Entities 2,109 ->
2,110; relationships 3,468 -> 3,485; 0 unsourced, 0 unresolved, 0 unreviewed dups.

## v1.63.0 — 2026-06-16

### Connectivity audit — wired 49 orphan entities into the graph

A sweeping dataset audit found the integrity excellent (0 unsourced, 0 unresolved,
0 unreviewed duplicates, all non-abstraction entities period-linked) but surfaced
**88 entities with zero relationships** — fully sourced yet invisible to the graph,
Connections, and every relationship view. Batch 1 of the remediation wires **49 of
them (+56 typed, source-backed edges)**, researched per tradition against
primary/scholarly sources:

- **Egyptian (14)** — nome/local gods, Duat realms (Fields of Reeds/Offerings),
  deified humans (Heqaib, Isi of Edfu), barque crew, Werethekau → Magic.
- **Mesopotamian/Anatolian (11)** — civic gods → the Anunnaki; sun-gate monsters
  (Girtablullu, Kusarikku) → Shamash; disease demons (Sulak, Edimmu) → Disease;
  syncretisms (Zababa→Ninurta, Nanaya→Inanna, Lelwani→Ereshkigal).
- **Roman/Celtic (12)** — deified virtues → Greek interpretatio (Libertas→Eleutheria,
  Pietas→Eusebeia); fever/exhalation goddesses → Disease; river/spring gods → Water.
- **Zoroastrian (7)** — yazatas emanate from Ahura Mazda; Vizaresh → the daevas.
- **Christian (4)** — Barbara, Christopher, Margaret, Denis → the Fourteen Holy Helpers.

Saints were kept strictly as **venerated humans** (no divine framing). The remaining
~39 orphans — mostly saints whose patronages (nations, crafts, places) are not yet
entities — were deliberately left rather than wired with forced or fabricated edges.
Relationships 3,412 → 3,468. Idempotent script: `scripts/wire_orphans_v1.sql`.

## v1.62.6 — 2026-06-16

### Rich entity pages + global search

- **Entity profile pages** (`/entity?id=ENT_ID`): a readable, no-SQL profile for any
  figure — name, tradition/type chips, description, domains, the periods it belongs to,
  aliases, its relationships grouped by type (each linking to the related figure's own
  page), and its sources. An "Open in relationship graph" button hands off to the graph.
- **Global search**: a search box on the homepage hero (and on every entity page)
  autocompletes across all figures and jumps straight to the profile.

Frontend-only.

## v1.62.5 — 2026-06-16

### Timeline view

A new `/timeline` page renders the period-linked data as a chronological lane
chart: each tradition is a bar spanning when its figures are attested, from the
Early Dynastic Nile (~3150 BCE) to the modern occult revival, coloured by family
and sorted oldest-first. Hover for the span and figure count; click a bar (or
label) to list that tradition's entities. Added to the nav and homepage. Built
on entity_periods → periods (start_year/end_year). Frontend-only.

## v1.62.4 — 2026-06-16

### Onboarding aids for first-time visitors

- **First-visit welcome.** A dismissible welcome dialog on the homepage orients
  newcomers to the three no-SQL ways in — Browse, Graph, Connections — each a
  one-line plain-language description and a direct link. Shown once
  (localStorage), closable by button, backdrop click, or Esc.
- **Connections surfaced on the homepage.** The "Browse & Visualize" call-to-action
  now includes the Connections map alongside Browse and the Graph.

Frontend-only.

## v1.62.3 — 2026-06-16

### Connections: a "constellation" view

The `/connections` page gains a second view, toggled alongside the heatmap: a
force-directed **constellation of traditions** — every tradition is a node sized
by how many cross-tradition links it carries, every edge weighted by how many
links bridge that pair, coloured by tradition family. Hover for counts, drag and
zoom, click a tradition to focus on its neighbours, and click any line to read
the underlying sourced links (the same drill-down as the heatmap, each name
deep-linking into the entity graph). Frontend-only.

## v1.62.2 — 2026-06-16

### Non-technical discovery: graph starting points + a clickable connections map

Two additions for visitors who don't write SQL (all canned queries and public
views already carry plain-language descriptions; this targets *discovery*).

**Graph starting points.** The `/graph` empty state now offers curated, grouped
entry points — *Famous figures* (Zeus, Apollo, Ra, Isis, Odin…), *Cross-tradition
bridges* (Hermes, Hecate, Mithras, Sol Invictus, Sophia, Thoth), and *Whole worlds*
(the Aesir, the Archons, the 42 Assessors of Maat, the Decans, the Indigitamenta) —
so users land on a rich network instead of a blank search box. Added a
`/graph?start=ENT_ID` deep link.

**Connections (`/connections`).** A new page turns `v_public_cross_tradition_matrix`
from a table into an interactive heatmap: the most cross-connected traditions on
both axes, each square shaded by how many comparative links bridge that pair.
Click a square to read the actual sourced links (received_as / syncretized_with /
equated_with / …), each name linking straight into the graph. Added to the nav.

Frontend-only (`templates/pages/{graph,connections}.html`, `_site_nav.html`);
no schema or data change.

## v1.62.1 — 2026-06-16

### Relationship graph: expand AND collapse

Acting on user feedback — *"Is there a way to collapse the nodes on the
relationship graph? Sometimes I want to de-overwhelm myself…"* — the `/graph`
explorer now supports collapsing, not just expanding. The visible graph is
recomputed from a reachability rule: a node is shown only while it is reachable
from the focal entity *through expanded nodes*. So:

- click a node to **expand** its connections; click it again to **collapse**
  them (hiding everything reachable only through it),
- `+` / `−` glyphs inside each node show whether a click will expand or collapse,
- a **Collapse all** button returns to the focal entity's immediate network,
- the focal node is ringed in gold; hover shows how many more connections a node
  will reveal.

Frontend-only (`templates/pages/graph.html`); no schema or data change.

## v1.62.0 — 2026-06-15

### Feature the cross-tradition links — the comparative core

An audit of the relationship graph found the database's best feature buried:
**577 genuine religion-to-religion comparative links** (reception, syncretism,
equation, cognate) were scattered, while the canned "parallels" query showed
only a third of them and nothing surfaced the tradition-to-tradition web. This
release surfaces them and fills the biggest gap.

**New public views** (`schema/views.sql`):
- `v_public_cross_tradition_links` — every comparative link between two
  *different real traditions* (the 8 comparative verbs), excluding the
  abstraction layer; entity, tradition, link type, linked entity, linked
  tradition, confidence, rationale, source.
- `v_public_cross_tradition_matrix` — the tradition-to-tradition web:
  per tradition-pair, how many links bridge them and of what kinds.

**Surfaced prominently:** a gold-accented "Comparative Core" feature block now
leads the homepage; three new canned queries (★ all links, ★ the web, ★ links
for one tradition); the `cross-traditional-parallels` query rebuilt on the new
view; the stale homepage card referencing a nonexistent `parallel_to` fixed.

**Gap filled — Germanic/Norse was nearly an island** (4 cross-links → 14):
added the well-attested *interpretatio romana* from Tacitus's *Germania* and
the weekday calques, with ancient identifications (`equated_with`) kept strictly
distinct from modern cognate/functional comparisons (`aligned_with`): Odin=
Mercury, Tyr=Mars, Thor=Hercules (strength) and Thor=Jupiter (thunder, the
Thursday calque), Frigg=Venus, Nerthus="Terra Mater" (Tellus), the Alcis=the
Dioscuri; plus cognate edges Odin~Hermes, Tyr~Zeus (etymological, *dyew-, with
a caveat note), Alcis~the Divine Twins. Two new Tacitus-attested entities
(Nerthus, the Alcis) + Njord `reception_of` Nerthus; and the Welsh↔Irish
cognate Dôn~Danu. Contested equations (Freyja↔Venus, the Suebian "Isis")
deliberately excluded. The sqlite export now materialises the two new views.

Integrity preserved (0 unsourced / 0 unresolved / 0 dup-pairs / 0 unreviewed
duplicates). Now **2,109 entities**, 3,412 relationships, 273 sources, 81
traditions, **577 cross-tradition comparative links**.

## v1.61.0 — 2026-06-15

### Content deepening: medieval Western Christianity

Adds the major-*cultus* medieval Western (Latin) saints the Christian roster
deliberately skipped (`build_medieval_western_christianity.sql`). Christian
(Western) 54 → **97**, +43, verified against Farmer's *Oxford Dictionary of
Saints*, Butler's *Lives*, and the *Golden Legend*; each entered for genuine
major cultus (shrine, pilgrimage, patronage), not as an author.

- **Mendicant & monastic founders:** Dominic, Clare of Assisi, Anthony of
  Padua, Bernard of Clairvaux, Bruno (Carthusians), Norbert (Norbertines),
  Romuald (Camaldolese), Bridget of Sweden (Birgittines), Scholastica.
- **Mystics with cultus:** Catherine of Siena, Hildegard of Bingen, Gertrude
  the Great, Mechtild of Hackeborn, Catherine of Genoa.
- **Martyr / political saints:** Thomas Becket, Stanislaus of Kraków, John of
  Nepomuk, Wenceslaus, Boniface (Apostle of Germany), Adalbert of Prague,
  Olaf of Norway, Canute of Denmark.
- **Royal / dynastic saints:** Louis IX of France, Edward the Confessor,
  Stephen I of Hungary, Elizabeth of Hungary, Margaret of Scotland, Henry II
  and Cunigunde, Casimir of Poland.
- **Pilgrimage / helper cults:** James the Greater (Santiago de Compostela),
  the Three Kings (Cologne), Faith of Conques, Leonard of Noblac, Giles, the
  Fourteen Holy Helpers, Denis of Paris, Genevieve of Paris, Cuthbert,
  Swithun, Edmund the Martyr, Walburga, Brigid of Kildare.

Wired the order-founder, family, and devotional edges (Clare→Francis,
Catherine of Siena→Dominic, Scholastica↔Benedict, Henry II↔Cunigunde…), and a
cross-tradition cross-link: **Brigid of Kildare `reception_of` the Irish
goddess Brigid**. Per house rule, the scholastic Doctors-qua-authors (Aquinas,
Bonaventure, Anselm, Albert, Scotus) are excluded; the four included "Doctors"
(Anthony of Padua, Bernard, Catherine of Siena, Hildegard) are in for popular
cultus. Julian of Norwich and Mechtild of Magdeburg excluded (no Latin cultus).

Also reclassified `SRC_FARMER_SAINTS` from "reference work" to "secondary
scholarship" (a single-author critical scholarly dictionary). Integrity
preserved (0 unsourced / 0 unresolved / 0 dup-pairs / 0 unreviewed duplicates);
ref-only stays at the by-design 88. Coverage 95.7% → **95.8%**. Now
**2,107 entities**, 3,400 relationships, 272 sources, 81 traditions.

## v1.60.0 — 2026-06-15

### Connectivity enrichment + deeper Mesopotamian & Norse

A fresh multi-dimensional audit (density, chronology, source-rigor) found the
top gap was **connectivity, not roster**: the traditions expanded in v1.59.0
(and some pre-existing nodes) were under-wired, leaving many near-isolated
entities invisible to the comparative-relationship views. Two phases:

**Phase 1 — enrichment** (`enrich_underwired_traditions.sql`): added meaningful
typed edges (interpretatio/`embodies`/family/triad/domain/healing patronage) —
no new entities — lifting edge-density to the healthy range: Roman 1.27→1.90,
Etruscan 1.26→1.94, Celtic/Irish 1.72→2.04, Canaanite/Ugaritic →3.39, Celtic/
British 1.11→2.00, Gaulish/Welsh/Phoenician →1.72–1.75. Wired the obvious
missing interpretatio of the major Roman gods (Vulcan→Hephaestus, Neptune→
Poseidon, Pluto→Hades, Bacchus→Dionysus, Vesta→Hestia, Tellus→Gaia) and the
deified virtues (Fortuna→Tyche, Pax→Eirene, Spes→Elpis, Salus→Hygieia,
Concordia→Homonoia). Also fixed the 2 stray ref-only entities (Ogmios→Lucian's
*Heracles*, Andraste→Cassius Dio) — ref-only outside the by-design set is now 0.

**Phase 2 — roster** deepened the two traditions still under their attested
depth:
- **Mesopotamian 76 → 117** (`deepen_mesopotamian_v2.sql`): civic/functional
  gods (Ninshubur, Isimud, Ishara, Pabilsag, Dagan, Tishpak, Enbilulu, the
  grain/flocks/building gods), the Seven Sages by name (the apkallu), underworld
  officials & demons (Humut-tabal, Hushbishag, Sulak, the Lamassu/Shedu
  guardian pair), and the primordial theogony (Lahamu, Enmesharra, Alala &
  Belili). From Black & Green, Lambert's *Babylonian Creation Myths*, and the
  Uruk List of Sages.
- **Germanic/Norse 46 → 96** (`deepen_norse.sql`): the myth-families wired as a
  graph — Loki's kin (Fárbauti, Laufey, Angrboða, Sigyn), Thor's sons (Móði,
  Magni), the sun/moon/day/night genealogy (Sól, Máni, Nótt, Dagr, Mundilfari,
  Dellingr), Odin's ancestry (Borr, Bestla), the Mead of Poetry cycle
  (Suttungr, Gunnlöð, Fjalar, Galar), the dwarf-smiths (Brokkr, Sindri), and
  the named giants, dwarves, and mythological animals (Sleipnir, Huginn &
  Muninn, Geri & Freki, the Ragnarök wolves). From the Poetic & Prose Eddas,
  Simek, and Lindow. Entity-kinds kept strictly distinct (god/giant/dwarf/
  animal/collective); disguises (Þökk=Loki) and pure name-list filler excluded.

Homonyms registered intentional_distinct: Alala (Mesopotamian primordial ↔
Greek war-cry). Integrity preserved (0 unsourced / 0 unresolved / 0 dup-pairs /
0 unreviewed duplicates). Primary/scholarly coverage 95.4% → **95.7%**. Now
**2,064 entities**, 3,380 relationships, 270 sources, 81 traditions.

## v1.59.0 — 2026-06-15

### Cross-tradition gap audit: deepen six under-mined traditions + wire Orthodoxy

A whole-dataset distribution + relationship-density audit (the same lens as
the v1.58.0 Egyptian pass) found several traditions thin *relative to their
attested record*, plus one connectivity defect. All additions verified to
primary/scholarly sources by four parallel research passes; uncertain
readings, human heroes, and epithets-of-major-gods deliberately excluded.

- **Roman 43 → 94** (`deepen_roman.sql`): the *indigitamenta* — the minor
  functional deities recorded by Varro and preserved by Augustine/Servius/
  Tertullian. Fabius Pictor's twelve farming gods (Vervactor…Promitor), the
  grain-growth and life-stage indigitamenta (Seia, Vagitanus, Cunina,
  Cardea…), and named minor cult gods (Feronia, Semo Sancus, Summanus,
  Veiovis, Consus, Pales, Angerona, Anna Perenna, Portunus, Febris…).
- **Celtic/Irish 12 → 46** (`deepen_celtic_irish.sql`): the Morrígna (Badb,
  Macha, Nemain), the sovereignty trio (Ériu/Banba/Fódla), the Tuatha Dé
  family (Boann, Midir, Étaín, Bodb Derg…), the craft-gods, and the Fomorians
  (Balor, Bres, Elatha, Cethlenn, Ethniu…); the Mag Tuired myth wired as a graph.
- **Celtic/Welsh 15 → 39** (`deepen_celtic_welsh.sql`): the Houses of Llŷr,
  Dôn, and Beli (Llŷr, Penarddun, Gofannon, Amaethon, Dylan, Mabon, Modron,
  Lludd, Creiddylad, Efnysien…) and the Taliesin/Culhwch cast (Ceridwen,
  Olwen, Ysbaddaden…).
- **Celtic/Gaulish 10 → 30 + new tag `Celtic/British` (9)**
  (`deepen_celtic_gaulish_british.sql`): the Gallo-Roman and Romano-British
  inscriptional gods (Belenus, Grannus, Sirona, Sequana, Lenus, Camulos;
  Nodens, Sulis, Coventina, Brigantia, Cocidius…), each with its Roman
  interpretatio wired.
- **Etruscan 12 → 31; Canaanite/Ugaritic 14 → 23; Phoenician 4 → 12**
  (`deepen_etruscan_semitic.sql`): the Liver of Piacenza + mirror pantheon
  (Aplu, Turms, Sethlans, Aita, Phersipnai, Vanth…); the Baal Cycle daughters
  and dawn/dusk twins (Pidray, Tallay, Arsay, Shahar, Shalim, Nikkal, Horon…);
  the distinct Phoenician/Punic cult gods (Baal-Shamem, Baalat Gebal, Adonis,
  Shadrapa…). Homonyms registered intentional_distinct: Adonis (Phoenician↔
  Greek, reception wired), Athtar (Ugaritic↔South Arabian), Brigantia (British
  ↔Irish Brigid).
- **Christian/Orthodox wiring** (`wire_orthodox.sql`): the 21 Orthodox saints
  had only 0.57 edges/entity (they existed but floated). Added typed edges —
  warrior-saints→War, healers→Healing, hierarchs→Wisdom, monastics→Monasticism,
  the hesychast mystics→the Uncreated Light→theosis — raising density to 1.71.

**Audit conclusion recorded:** Greek (462) being the largest tradition is
*correct* — its literary record simply names more discrete beings. The fix is
always to mine an under-represented tradition's *attested* roster up to depth,
never to shrink Greek. Genuinely attestation-limited traditions (Baltic,
Slavic, Thracian, Scythian, Aramean, Elamite…) were left as-is.

Integrity preserved (0 unsourced / 0 unresolved / 0 dup-pairs / 0 unreviewed
duplicates). Primary/scholarly coverage 95.1% → **95.4%**. Now 1,973 entities,
3,119 relationships, 264 sources, 81 traditions.

## v1.58.0 — 2026-06-15

### Content deepening: the Egyptian roster (91 → 188)

A distribution audit showed Greek (462) dwarfing Egyptian (91) by ~5×. Greek's
size is legitimate (the Greek literary record individually names far more
figures than any other tradition), but the *gap* was a cataloguing artifact:
Egypt's textual corpus names a comparably vast cast that had not been mined to
the same depth. This build closes that gap (`deepen_egyptian.sql`), +97
entities, all verified to a primary text / scholarly edition by four parallel
research passes (uncertain readings deliberately excluded — nothing fabricated).

- **The 42 Assessors of Maat** (Book of the Dead, Spell 125) — the full
  tribunal of the Negative Confession, each judge with its city and the sin it
  hears denied, wired to a new collective (`presided_over_by` Osiris,
  `embodies` Maat, in the Duat). Was entirely absent.
- **The Duat cast** (Amduat / Book of Gates / Litany of Re, +22) — Af-Ra (the
  night sun), the great cat Mau-aa who slays Apophis, Heka, the named barque
  crew, the world-encircling serpent and the gate-guardian serpents, the four
  races of mankind, the damned, and the regions (Field of Reeds, Field of
  Offerings, Rosetau, Imhet, Wernes, the Lake of Fire), the Twelve Hours, and
  the 75 Forms of Re.
- **The astronomical decans** (+3) — Sopdet (Sirius), Sah (Orion), and the
  decanal system as a collective; the existing Testament-of-Solomon
  decan-demons (`ENT_LAT_DECAN_*`) are wired as its Hellenistic `reception_of`.
  (The 36 individual decan names are NOT reconstructed — readings are contested
  and inventing them would be fabrication.)
- **Deified humans** (+4) — Imhotep, Amenhotep son of Hapu, Heqaib, Isi of Edfu.
- **Nome / local gods + pan-Egyptian omissions** (+25) — Andjety, Wenut, Nemty,
  Hemen, Khentekhtai, Ipy/Opet, Dedwen, Igai, Ha, Weneg, Kherty, Wadj-wer,
  Khentamentiu; the sacred bulls Apis/Mnevis/Buchis; Hesat, Mehet-Weret,
  Iusaaset, Neper, Werethekau, Tayet, Renpet, Nehmetawy, Tutu/Tithoes — with
  syncretism edges (Andjety/Khentamentiu→Osiris, Apis→Serapis, etc.).

Mandulis was *not* added (already present as Meroitic). Sources: Faulkner's
Book of the Dead, Budge's Papyrus of Ani, Piankoff's Litany of Re,
Neugebauer–Parker's Egyptian Astronomical Texts, Habachi's Sanctuary of
Heqaib, plus the existing Hornung/Wilkinson/Pinch/Faulkner-Pyramid set.
Integrity preserved (0 unsourced / 0 unresolved / 0 dup-pairs / 0 unreviewed
duplicates). Primary/scholarly coverage 94.8% → **95.1%**.

## v1.57.0 — 2026-06-15

### Content deepening: the Pseudo-Dionysian / Christian-theurgic layer

Adds the Corpus Dionysiacum (c. 500 CE) as the bridge between the
Hermetic/Theurgic (Iamblichus/Proclus) bloc and the Christian bloc
(`build_christian_theurgy.sql`). New tradition tag **`Christian/Theurgic`**
(+20 entities); id prefix `ENT_DIO_`.

**The Celestial Hierarchy.** The nine angelic orders are organised into
Dionysius's three triads — First (Seraphim, Cherubim, Thrones), Second
(Dominions, Virtues, Powers), Third (Principalities, Archangels, Angels). The
existing `ENT_CHR_*` orders are **wired into** the triads, not duplicated;
divine light is `transmits`-chained down the triads, and the whole hierarchy
`emanates_from` the Thearchy.

**The Ecclesiastical Hierarchy.** The earthly mirror: the clergy triad
(Hierarchs/Bishops → Priests → Deacons), the initiate triad (Monks → Holy
People → the Purified catechumens/penitents/energumens), and the three
sacraments-as-*theourgiai* (Illumination/Baptism, the Synaxis/Eucharist, the
consecration of the Myron/Chrism). The church `symbolizes` the celestial
hierarchy, which `transmits` light down to it.

**The theology.** The superessential **Thearchy** (Godhead); the **Divine
Names** (cataphatic — wired `embodies` to the existing Beauty/Light/Life/
Love/Wisdom/Truth abstractions, with **the Good** as chief name); the
**Divine Darkness** (apophatic, the Mystical Theology); **deification
(theosis)**; and **procession & return** (proodos/epistrophe).

**The cross-tradition bridge** (realising the user's Theurgy Study Group
thesis): the Celestial Hierarchy is `reception_of` the Iamblichan
**Hypercosmic/Encosmic gods**; the Thearchy and the Divine Darkness are
`reception_of` the Neoplatonic **One**; procession/return is received from
**Proclus**; and **theosis** is aligned with theurgic *henosis* and with the
**Orthodox Uncreated Light** (its Palamite systematisation). Sources: the
Parker translation of the corpus (1897, public domain) + Rorem's commentary
+ Shaw, *Theurgy and the Soul*.

Whole-DB integrity preserved (0 unsourced / 0 unresolved / 0 duplicate
source-pairs / 0 unreviewed duplicates). Primary/scholarly coverage 94.3% →
**94.8%**.

## v1.56.0 — 2026-06-15

### Content deepening: the Norse and Anatolian pantheons

Closes the last two thin pre-Christ pantheons flagged in the coverage audit
(`build_norse_core.sql`, `build_anatolian_core.sql`).

**Germanic/Norse 20 → 46:** the missing Aesir (Heimdall, Bragi, Idun, Sif, Hodr, Vidar,
Vali, Forseti, Ullr, Nanna), the sea-powers Aegir and Ran, the wisdom-beings Mimir,
Kvasir and Gullveig, the giantess-goddess Skadi, the primordial cosmogony (Ymir,
Audhumla, Buri, Surtr) and the great jötnar (Thrym, Hrungnir), the hound Garm, and the
three named Norns (Urd, Verdandi, Skuld). The myth-cycle is wired — Hodr slays Baldr,
Vali avenges him, Vidar slays Fenrir, Surtr slays Freyr, Odin slays Ymir, Thor slays
Hrungnir. All to the Poetic and Prose Eddas.

**Anatolian (Hittite / Hurrian / Luwian) ~13 → 34:** the Hurrian Kumarbi-cycle gods
(Sharruma, Kushuh, Shimige, Aranzah, Tashmishu, Seri & Hurri, Hazzi, Hutena & Hutellura),
the Hittite cult pantheon (Kamrusepa, Istanu, Mezzulla, Wurunkatte, Lelwani, Halki), and
the Luwian Iron Age gods (Tarhunz, Tiwaz, Arma, Runtiya, Santa, Iyarri, Maliya). The
theogony and the household of Teshub are wired. To Hoffner's *Hittite Myths* and Taracha's
*Religions of Second Millennium Anatolia*.

No new sources needed (the Eddas and the Anatolian references were already registered).
Every figure period-linked. 0 unsourced; 0 unresolved; duplicate discipline clean.

**This closes the pre-Christ content roadmap from the audit** (Mesopotamian, Norse,
Anatolian all now at canonical depth).

---

## v1.55.0 — 2026-06-15

### Content deepening: Lurianic / theosophical Kabbalah

Adds the theosophical superstructure on top of the existing Sefirot, Ein Sof and Adam
Kadmon (`build_lurianic_kabbalah.sql`). Jewish Mystical **39 → 59**:

- **The five partzufim** (divine configurations) wired to their sefirot: Arikh Anpin
  (Keter) and the concealed Atika Kadisha, Abba (Hokhmah), Imma (Binah), Zeir Anpin (the
  six emotive sefirot) and Nukva (Malkhut / the Shekhinah) — with Zeir Anpin born of Abba
  and Imma, and Nukva his consort.
- **The four worlds (ABYA)** as a descent: Atziluth → Beriah → Yetzirah → Assiah.
- **The Lurianic cosmogony**, wired as a chain: the **Tzimtzum** (the self-contraction of
  Ein Sof), the Reshimu and the Kav (from which Adam Kadmon emanates), Olam ha-Tohu and the
  **Shevirat ha-Kelim** (the breaking of the vessels), the scattered **Netzotzot** (holy
  sparks), and the **Tikkun** that gathers them and overcomes the shells.
- **The realm of evil:** the **Qliphoth** (the shells from the broken vessels) and the
  **Sitra Achra**, ruled by Samael with Lilith — plus **Da'at**, the hidden sefirah.

+1 primary source (244 total: Hayyim Vital's *Etz Hayyim*, alongside the Zohar) and a new
Lurianic/Safed Kabbalah period. 0 unsourced; 0 unresolved; duplicate discipline clean.

---

## v1.54.0 — 2026-06-15

### Content deepening: Eastern Orthodox Christianity

Balances the Western-leaning Christian set with the Byzantine and Slavic Orthodox
dimension (`build_eastern_orthodox.sql`), under a distinct `Christian/Orthodox` tag.
Christian-family **65 → 86** (a new Orthodox bloc of 21):

- **Great-martyrs & unmercenary healers:** Demetrios of Thessaloniki, Theodore the
  Soldier, Panteleimon (chief of the Anargyroi), Paraskevi, Menas, and Mary of Egypt.
- **The Three Holy Hierarchs** (Basil the Great, Gregory the Theologian, John Chrysostom,
  wired to their joint feast) plus Athanasius, and the hesychast mystics **Gregory Palamas**
  and **Symeon the New Theologian**.
- **Monastic wonderworkers:** Simeon Stylites, John Climacus, the Slavic Cyril and
  Methodius, Sergius of Radonezh, Seraphim of Sarov, and Vladimir (baptiser of the Rus').
- **Distinctively Orthodox:** the **Protection of the Theotokos (Pokrov)** as a Marian
  veneration-form, and the **Uncreated Light** — the Taboric/Palamite divine energies,
  wired as proceeding from the Father and shining from Christ at the Transfiguration.

Cross-linked to the existing Western set (Athanasius → Antony, Panteleimon → Cosmas &
Damian, Demetrios → George). +3 primary sources (243 total: the Synaxarion, Palamas'
Triads, the Philokalia) and a new Byzantine/Slavic Orthodox period. 0 unsourced;
0 unresolved; duplicate discipline clean.

---

## v1.53.0 — 2026-06-15

### Content deepening: Islam — the Shi'a Imamate and the angels

Begins the forward (CE) build-out. The Islamic core was strong but Shi'a had only 4
entities and **the Prophet Muhammad was missing entirely**. This deepens it
(`deepen_islamic_shia.sql`); Islamic-family **54 → 73**, Shi'a **4 → 17**:

- **The Prophet Muhammad** (the Seal of the Prophets — a notable prior omission) and
  **Fatima al-Zahra**.
- **The nine missing Twelve Imams** (the 2nd and 4th–11th): Hasan, Zayn al-Abidin,
  al-Baqir, al-Sadiq, al-Kazim, al-Rida, al-Jawad, al-Hadi, al-Askari — wired as the full
  father-to-son Imamate lineage (Ali → … → al-Askari → the Mahdi).
- **The holy collectives:** the Ahl al-Bayt (the Five of the Cloak / Panjtan) and the
  Fourteen Infallibles (Ma'sumin), with each member wired in; plus the doctrine of Imamah.
- **The angels of paradise and hell:** Malik (keeper of Hell) and the Zabaniya he
  commands, Ridwan (keeper of Paradise), the Bearers of the Throne, and the Hur (houris).

+3 primary sources (240 total): al-Mufid's *Kitab al-Irshad* (the canonical Twelver
biography of the Imams), Ibn Ishaq's *Sira*, and Sahih al-Bukhari. All period-linked
(Early/Classical Islamic). 0 unsourced; 0 unresolved; duplicate discipline clean.

---

## v1.52.0 — 2026-06-15

### Content deepening: the Mesopotamian pantheon

Doubles the Mesopotamian pantheon — the biggest pre-Christ content gap by importance —
from 36 to **76** (`deepen_mesopotamian.sql`), each entity to a primary source (ETCSL,
Enuma Elish, Atrahasis, Gilgamesh, Foster's *Before the Muses*) or Black & Green:

- **City-patron & functional gods:** Gula (the great physician), Nanshe, Ningirsu, Bau,
  Ninazu, Ningishzida, Shara, Ishtaran, Zababa, Damu, Ninkasi, Nanaya, Nuska.
- **The Enuma Elish theogony:** Lahmu, Anshar, Kishar, Mummu — wired as the full descent
  Apsu → Lahmu → Anshar → Anu — plus the Marduk circle (Damkina, Sarpanit) and Belet-ili
  (Mami), the creatrix of Atrahasis.
- **The underworld court:** Namtar, Neti, Belet-seri, and Gugalanna (the Bull of Heaven).
- **The monster & demon register:** Asag (slain by Ninurta), Humbaba, the Mushhushshu
  dragon, the Sebitti (the Seven / Pleiades), Bashmu, Girtablullu, Kusarikku, Ugallu,
  Lilitu (a forerunner of Lilith), and the edimmu ghost.
- **The Erra Epic:** Erra, his herald Ishum, and the Sebitti; plus the sages Adapa and
  Etana and the deified hero-king Lugalbanda (father of Gilgamesh).

+3 primary sources (237 total). Every figure period-linked (Early Dynastic/Ur III, Old
Babylonian, or Neo-Assyrian). 0 unsourced; 0 unresolved; duplicate discipline clean.

---

## v1.51.0 — 2026-06-15

### Chronology repair: re-date Zoroastrianism and backfill the period layer

A pre-Christ coverage audit surfaced two problems in the chronology layer, both fixed
here (`backfill_entity_periods.sql`):

- **Zoroastrianism was mis-dated to the wrong side of the Christ event.** 15 of the 16
  original Zoroastrian entities were tagged only to the Sasanian period (224 CE), wrongly
  placing Ahura Mazda, the Amesha Spentas and Mithra — Avestan figures whose Gathas predate
  the Achaemenids — in the post-Christ era. Every Zoroastrian entity now carries a
  `PER_ZOR_ACHAEMENID` origin link (Sasanian kept as the continuation). Zoroastrian
  pre-Christ entities: **1 → 53**.
- **The content-normalization program (v1.43–1.50) had added ~150 entities without any
  `entity_periods` link.** Each tradition's additions are now wired to its period: the
  Jewish Second Temple build → Second Temple; the Roman additions → Republic/Imperial by
  date; the Greek hybrids → Hellenistic; and the Manichaean, Mandaean, Christian/patristic,
  Hermetic/theurgic and rabbinic-Hekhalot additions to their respective late-antique periods.

Whole-dataset chronology: **undated entities 293 → 118** — and the remaining 118 are exactly
the Cross-traditional abstraction layer (Truth, Death, Fate…), which is intentionally
timeless. Pre-Christ-origin entities now total **926**.

---

## v1.50.1 — 2026-06-15

### Vocabulary hygiene: normalize evidence_type

Normalizes `entity_sources.evidence_type` from 25 ad-hoc values to a controlled
vocabulary of 5 (`normalize_evidence_type.sql`), mirroring the earlier `source_type`
normalization:

- **direct attestation** (1,717) — the entity is directly named/described in a primary text
- **scholarly attestation** (1,134) — established or discussed via secondary scholarship
- **index attestation** (1,026) — listed in a reference index/aggregator (the Theoi indices, DDD, …)
- **inscriptional attestation** (20) — attested in a primary inscription or material artifact
- **probable attestation** (1) — uncertain / probable identification

Inconsistent evidence_type strings (e.g. `primary_attestation` vs `Direct attestation`)
were the root cause of the recurring duplicate `(entity_id, source_id)` pairs flagged in
the v1.50.0 health audit: because evidence_type is part of the primary key, the same
citation could slip in twice under two spellings. Folding them to a single controlled term
makes future `ON CONFLICT` inserts dedupe correctly. 0 duplicate pairs; 0 unsourced.

---

## v1.50.0 — 2026-06-14

### Content normalization VIII: Hermetic/Theurgic build-out

Fills in the Hermetic cosmic drama and the Chaldean–Neoplatonic theurgic hierarchy
(`build_hermetic_theurgic.sql`), beyond the bare metaphysical core the DB had. Hermetic/
Theurgic **5 → 22**, grounded in the user's theurgy library (Christian Bull's *Tradition
of Hermes Trismegistus*; Proclus's *On the Hieratic Art*) plus the core primaries:

- **The Hermetic drama (Corpus Hermeticum):** Poimandres (the revealing Mind), the
  Demiurge and the seven Governors, Heimarmene (Fate), and the Ogdoad and Ennead — the
  eighth and ninth spheres of ascent (Discourse on the Eighth and Ninth, NHC VI.6).
- **The Chaldean orders (Chaldean Oracles):** the Paternal Intellect (the Father), the
  cosmic Hecate (the World-Soul, wired as a reception of the Greek goddess), and the
  mediating Iynges, Synocheis and Teletarchs.
- **The Neoplatonic hierarchy (Plotinus, Proclus, Iamblichus):** the henads, the World
  Soul, the personal daimon, the material daimones, and the encosmic and hypercosmic gods.

The Gnostic Demiurge is now wired as a polemical inversion (`reception_of`) of the good
Hermetic/Platonic craftsman. +6 sources (234 total: the Chaldean Oracles, Plotinus'
Enneads, Proclus' Elements and Hieratic Art, the Discourse on the Eighth and Ninth, Bull).
The cross-tradition homonyms (Demiurge, Heimarmene, Hecate, Ogdoad) are registered as
intentionally distinct. Whole-dataset rigor **94.3%**. 0 unsourced; 0 unresolved.

---

## v1.49.0 — 2026-06-14

### Content normalization VII: Christian/patristic build-out

Fills in the parts of the Christian cosmos the DB had skipped (`build_christian_patristic.sql`):
the divine persons, the apocalyptic cast, the Gospel demons, and the great martyrs of
the patristic age. Christian family **45 → 65**, each entity to a primary source:

- **The divine persons:** God the Father and the Holy Spirit (with Jesus Christ, already
  present, completing the Trinity), to the New Testament and the Nicene Creed.
- **The apocalyptic cast of Revelation:** the Beast (666), the False Prophet, the Whore
  of Babylon, and the Four Horsemen.
- **The Gospel demons:** Beelzebul (the prince of demons, identified with Satan), Mammon,
  and Legion.
- **The martyrs and patristic saints:** the protomartyr Stephen, Perpetua and Felicity,
  Thecla, Lawrence, Sebastian, Agnes, Cecilia, Christopher, Barbara, Margaret of Antioch,
  and Martin of Tours — figures of major intercessory cultus, joining the saints already
  in the set.

+4 sources (228 total: the Nicene Creed, the Passion of Perpetua, the Acts of Paul and
Thecla, Sulpicius' Life of Martin). The "Holy Spirit" homonym (Gnostic/Christian) is
registered as intentionally distinct. Whole-dataset rigor rose to **94.2%**. 0 unsourced;
0 unresolved; duplicate discipline clean.

**Rebalancing scorecard (v1.42 → v1.49):** Zoroastrian 16→53, Jewish 56→92, Manichaean
15→32, Mandaean 15→31, Roman 23→43, Christian 45→65 — the late-antique religious world
is now represented in proportion, with sourcing rigor higher than when the program began.

---

## v1.48.0 — 2026-06-14

### Content normalization VI: Roman build-out

Extends beyond the Dii Consentes core into the distinctively Roman strata
(`build_roman_core.sql`). Roman **23 → 43**, each entity to a primary Latin source
(Ovid, Livy, Cicero, Varro, Catullus, Suetonius, the inscriptions):

- **The deified state-virtues:** Fortuna, Victoria, Fides, Concordia, Salus, Spes, Pax,
  Libertas, Pietas, Virtus, and Dea Roma — the cults of the personified Roman order.
- **The rustic gods:** Pomona and Vertumnus (the Ovidian pair), and Tellus Mater. (The
  archaic Faunus, Silvanus, Flora and Ops already live under Italic/Sabine and were
  enriched there with this pass's sourcing rather than duplicated.)
- **War:** Bellona.
- **The late-antique and imperial cults:** Sol Invictus (Aurelian's unconquered Sun,
  identified with Mithras), the Magna Mater (received from Phrygian Cybele) and her
  consort Attis, and the deified emperors **Divus Julius** and **Divus Augustus** —
  humans raised to godhood, squarely within the methodology.
- Cupid, son of Venus.

+3 sources (224 total: the Latin inscriptions/CIL, Suetonius, Catullus). The cross-
tradition homonyms (Attis Phrygian/Roman) are registered as intentionally distinct,
with reception edges (Roman Attis ← Phrygian Attis; Magna Mater ← Cybele). 0 unsourced;
0 unresolved; duplicate discipline clean.

---

## v1.47.0 — 2026-06-14

### Content normalization V: Mandaean build-out

Fills in the Mandaean lightworld and underworld, previously a 15-entity skeleton
(`build_mandaean_core.sql`). Mandaean **15 → 31**, each entity to a primary Mandaean
source (the Ginza Rabba, the Qolasta):

- **The lightworld and its uthras:** the Uthras themselves, Simat Hayyi (the Treasure
  of Life, consort of the Great Life), the great uthra Yawar Ziwa, and the celestial
  prototypes Adam Kasia and Hawwa Kasia.
- **The living water:** the Jordan's guardian uthras Shilmai and Nidbai, the baptism-
  uthra Bihram, and Kushta (Truth, the sacred handclasp).
- **The cosmic realms:** the World of Light (Alma d-Nhura), the World of Darkness, the
  material earth Tibil (made by Ptahil), and the matartas (the soul's purgatory
  watch-stations, over which Abathur presides).
- **The dark powers:** Krun (the "mountain of flesh," chief king of the darkness), the
  Twelve zodiacal rulers (children of Ruha, with the Seven Planets), and Sauriel, the
  angel of death.

+1 source (221 total: the Qolasta). The "World of Light" homonym (now Mandaean and
Manichaean) is registered as intentionally distinct. 0 unsourced; 0 unresolved.

**Rebalancing complete (v1.43 → v1.47):** the four late-antique traditions that fed
the Gnostic material are now at solid canonical depth — Zoroastrian 16→53, Jewish
56→92, Manichaean 15→32, Mandaean 15→31 — without diluting the sourcing rigor
(still ~94%).

---

## v1.46.0 — 2026-06-14

### Content normalization IV: Manichaean build-out

Fills in the canonical cast of the Manichaean dualist cosmology, previously only a
15-entity skeleton (`build_manichaean_core.sql`). Manichaean **15 → 32**, each entity
to a primary Manichaean source (the Kephalaia, the Coptic Psalm-Book, the Cologne
Mani Codex):

- **The evocations of the three creations:** the Friend of the Lights, the Third
  Messenger and the Maiden of Light (whose epiphany frees the swallowed light), and
  the **five sons of the Living Spirit** — the Keeper of Splendour (Splenditenens),
  Adamas of Light, the King of Glory, the King of Honour, and the Porter (Omophoros).
- **The awakening and the suffering light:** the Call and Answer (Xroshtag and
  Padvaxtag) that rouse the Primal Man, and Jesus patibilis — the world-soul crucified
  throughout matter.
- **The dark anthropogony:** the demoness Az (wired as a reception of the Zoroastrian
  Az from v1.43.0), and the archons Ashqalun and Nebroel who fashion the first human
  pair; plus the Five Worlds of Darkness.
- **The apostle:** Mani, the incarnate Paraclete, and his heavenly Twin (the Syzygos).
- The eschatological Last Statue.

+1 source (220 total: the Cologne Mani Codex). The cross-tradition Az homonym is
registered as intentionally distinct. 0 unsourced; 0 unresolved; duplicates clean.

---

## v1.45.0 — 2026-06-14

### Content normalization III: Jewish rabbinic + Hekhalot/Merkavah

Completes the Jewish-tradition rebalancing (`build_jewish_rabbinic_hekhalot.sql`)
with the late-antique rabbinic and Merkavah-mystical strata. Jewish Mystical
**24 → 39**; the whole Jewish bloc now **92** (from 56):

- **Rabbinic demonology:** Dumah (prince of Gehenna), Ketev Meriri (the noonday
  demon), the demon-queens Agrat bat Mahlat and Naamah, the shedim and mazzikin,
  the lilin (Lilith's brood), and the destroying angels Af and Hemah. Lilith is now
  wired as the consort of Samael.
- **Hekhalot / Merkavah throne-princes:** Anafiel (set above Metatron in 3 Enoch),
  Akatriel (the enthroned Name seen in Berakhot 7a), Yahoel (the Name-bearing guide
  of the *Apocalypse of Abraham*, wired as Metatron's precursor), Zagzagel, and the
  offices of the Sar ha-Panim and Sar ha-Olam (both identified with Metatron).
- **Cosmology:** Gehenna (developed from Sheol) and the Ziz, completing the
  primordial triad with Behemoth and Leviathan.

+3 sources (219 total: the Babylonian Talmud, the Apocalypse of Abraham, the classical
Midrash). Whole-dataset rigor holds at **93.9%**. 0 unsourced; 0 unresolved; duplicate
discipline clean.

**Rebalancing scorecard (v1.42 → v1.45):** the Gnostic : Jewish : Zoroastrian ratio
moved from **186 : 56 : 16** to **177 : 92 : 53** — the late-antique Iranian and
Jewish substrates that fed the Gnostic material are now proportionate to it.

---

## v1.44.0 — 2026-06-14

### Content normalization II: Jewish Second Temple build-out

Deepens the Second Temple apocalyptic angelology and demonology
(`build_jewish_second_temple.sql`), continuing the rebalancing away from the
Gnostic over-weighting. Israelite/Second Temple **26 → 46**, every entity to a
primary locus:

- **Asmodeus** (Tobit) — previously missing entirely; bound by Raphael, and wired
  as the ancestor of the existing late-antique ritual/Solomonic Asmodeus.
- **The 1QS "Two Spirits" dualism** — the Prince of Light (≈ Michael) and the Angel
  of Darkness (≈ Belial), the Spirit of Truth and the Spirit of Deceit — a direct
  structural parallel to the Zoroastrian Spenta/Angra Mainyu axis added in v1.43.0.
- **The heavenly Melchizedek** (11Q13), who judges Belial.
- **Named Watcher-chiefs** (Kokabiel, Baraqiel, Penemue, Gadreel) and **giants**
  (Ohyah, Hahyah, Mahaway) — the last three cross-linking the Manichaean *Book of
  Giants* already in the DB.
- **Danielic / Enochic heavenly figures** — Phanuel, Saraqael, the Angel of the
  Presence (Jubilees), the Princes of the Nations (opposed by Michael), the Son of
  Man, and the Ancient of Days (as a theophanic form of Yahweh); plus the chaos-
  dragon Rahab.

+5 Dead Sea Scrolls / 2 Enoch sources (216 total: 1QS, 11Q13, 1QM, the Book of
Giants, 2 Enoch). Duplicate-name discipline preserved (the Asmodeus homonym
registered as intentionally distinct). 0 unsourced; 0 unresolved relationships.

---

## v1.43.0 — 2026-06-14

### Content normalization I: Zoroastrian build-out

A shift from sourcing rigor to **balancing the dataset**, which was heavily weighted
toward the Gnostic bloc (186) and thin on the late-antique traditions that fed it.
Zoroastrianism — the Iranian dualist substrate upstream of the Second Temple Jewish,
Gnostic, and Manichaean material — was the thinnest of the majors at 16 entities.
This pass brings it to a solid canonical core of **53** (`build_zoroastrian_core.sql`),
every figure attested to its Avestan or Pahlavi locus:

- **Yazatas & divine beings (+17):** Spenta Mainyu (the Bounteous Spirit, Yasna 30),
  Verethragna, Tishtrya, Rashnu, Vayu, Haoma, Apam Napat, Ashi, Daena, Chista, Hvar
  Khshaeta (Sun), Mah (Moon), Asman, Khvarenah (the divine Glory), Geush Urvan,
  Nairyosangha, Drvaspa — each to its dedicated Yasht.
- **Primordial / eschatological / heroic (+7):** Zurvan (Time, the Zurvanite father
  of the twin spirits), Gayomard (the first man), the Saoshyant (the future savior),
  Yima, Thraetaona, Keresaspa, and the prophet Zarathustra.
- **The daeva counter-pantheon (+13):** Aka Manah, Indra, Saurva and Nanghaithya
  (the arch-daevas mirroring the Amesha Spentas), plus Az, Jeh, Astovidatu, Vizaresh,
  Nasu, Apaosha, Bushyasta, the dragon Azhi Dahaka, and the Druj (the Lie itself).

The classic Avestan antagonisms are wired as typed edges (Spenta vs Angra Mainyu,
Aka Manah vs Vohu Manah, Saurva vs Khshathra, Tishtrya vs Apaosha, Sraosha vs Aeshma,
Thraetaona slays Azhi Dahaka, the Saoshyant defeats Ahriman). +3 sources (211 total:
Denkard, Menog-i Khrad, Zaehner's *Zurvan*). 0 unsourced; 0 unresolved relationships.

---

## v1.42.0 — 2026-06-14

### Sourcing rigor VII: the Greek long tail

The last large rigor gap closed (`source_greek_long_tail.sql`). The ~154 Greek
entities still sourced only to the Theoi index are now matched to verified
**primary-text loci**, each cited to its exact ancient passage. +32 public-domain
sources (208 total): Ovid (*Metamorphoses*, *Heroides*), Nonnus' *Dionysiaca*,
Lucian's *Alexander* (Glycon), Strabo, Diodorus Siculus, Callimachus, Theocritus,
Apuleius (*Golden Ass* — Psyche), Virgil's *Georgics* (Aristaeus), Apollonius'
*Argonautica*, Damascius (the Orphic Rhapsodic theogony), Aeschylus (*Oresteia*,
*Suppliants*), Euripides (*Bacchae*, *Heracles*, *Heracleidae*), Pindar, four
Aristophanes comedies, Sappho, Alcaeus, Theognis, Posidippus, Hyginus, Mnaseas,
Philostratus, Zenobius (preserving Sappho fr. 178), Servius, and the *Suda*.

Coverage of the cluster: the cosmogonic/Hesiodic catalogues (Charites, Horae,
Muses, Nereids, Oceanids, Erinyes, Cyclopes) → *Theogony*; the metamorphosis
nymphs (Daphne, Echo, Syrinx, Salmacis, Arethusa) → Ovid; the underworld rivers
→ *Odyssey* 10 / Plato; the Asklepian and Eleusinian figures, cult-forms, and
local heroes (Trophonius, Amphiaraus, Despoina) → Pausanias; the monsters (Hydra,
Geryon, Scylla, Minotaur) → Apollodorus / Homer; the dream-daimones
(Morpheus, Phantasos, Phobetor) → Ovid *Met.* 11; the Orphic primordials (Ophion,
Eurynome, Hydros, Thesis) → Apollonius / Damascius; the mystery collectives
(Kabeiroi, Korybantes, Kouretes, Telchines) → Strabo / Diodorus.

Whole-dataset primary/scholarly coverage **82.8% → 93.6%**; ref-only 236 → 88.
The remaining 88 are the **Cross-traditional abstractions (81**, appropriately
referenced to Eliade's *Encyclopedia of Religion* — cross-cultural concepts not
tied to a single primary text) and **7 Greek figures** that survive only through
scholia, lexica, or cult-epithets with no clean primary locus (Lampades,
Mormolykeia, Eleutheria, Soter, Soteria, Kakodaimon, Aceso). 0 duplicate pairs;
0 unsourced.

---

## v1.41.0 — 2026-06-14

### Sourcing rigor VI: the scattered singles

Mop-up of the ref-only entities outside the big Greek and Cross-traditional sets
(`source_scattered_singles.sql`). +6 public-domain primary sources (176 total): the three
regional saints' Vitae (Eligius, Dunstan, Roch — **Christian now 100% primary**), and
three Shi'a primaries (Nahj al-Balagha, al-Tabari's *History*, al-Kulayni's *al-Kafi*).
- **Christian/Biblical** (Abaddon, Apollyon, Behemoth, the Dragon of Revelation, Leviathan)
  → Revelation / Job.
- **Christian reception** (the patristic Hecate → Augustine's *City of God*; Lucifer →
  Isaiah 14:12 + Luke 10:18).
- **Shi'a** — Ali → Nahj al-Balagha + al-Tabari + Quran 5:55; Husayn → al-Tabari (Karbala)
  + Quran 33:33; the Mahdi & the Occultation → al-Kafi; Walaya → Quran 5:55.
- **Jewish** Torah → the Pentateuch; **Pre-Islamic Arabian** Hubal → Hoyland.
- **Greek hybrid sub-traditions** → Greek primary texts (Adrasteia/Marsyas → Apollodorus;
  Protogonos/Corybantes → Orphic Hymns; Dactyls/Telesphorus/Sibyl → Pausanias; Trivia →
  Virgil; Aion → the Greek Magical Papyri).

Whole-dataset primary/scholarly coverage **80.9% → 82.8%**; ref-only 262 → 236. The
remainder is the Greek long tail (~154, needs Nonnus/Pindar/the tragedians), the
Cross-traditional abstractions (~81, appropriately referenced to Eliade), and the Telchines
(needs Strabo/Diodorus). 0 duplicate pairs; 0 unsourced.

---

## v1.40.0 — 2026-06-14

### Sourcing rigor V: Christian and Israelite/Second Temple → primary texts

The rigor program moves off Greek to the next gaps (`source_christian_israelite.sql`).
Both traditions were sourced only to reference works (DDD, Butler's Lives, the Catholic
Encyclopedia); this adds the actual primary attestation, additively:
- **Israelite/Second Temple** → Hebrew Bible (Yahweh, Satan, Behemoth, Leviathan, Sheol,
  Ruach, Bene Elohim, Scapegoat, Sophia/Wisdom, the Angel of Death, Belial — each with
  chapter-and-verse); Tobit → Book of Tobit; Belial also → Jubilees.
- **Christian** → New Testament (John the Baptist, Joseph, Mary Magdalene, Mary Theotokos,
  Paul, Peter, the Devil, Demons, Antichrist, Baptism, Mission — each with references);
  saints → the Golden Legend (Blaise, Catherine, Cosmas & Damian, Francis, George, Lucy,
  Nicholas), Anthony & Monasticism → Athanasius's *Life of Antony*, Benedict → Gregory's
  *Dialogues* II.

New sources: SRC_ATHANASIUS_LIFE_ANTONY, SRC_GREGORY_DIALOGUES (170 total).

Result: **Israelite/Second Temple 54% → 100%** primary (0 ref-only); **Christian 37% →
92%** (3 regional saints — Eligius, Dunstan, Roch — remain on hagiographic reference works,
their primary Vitae not yet registered). 0 duplicate pairs; 0 unsourced entities.

---

## v1.39.0 — 2026-06-14

### Sourcing rigor IV: the Aspis daimones and the Choice of Heracles

Fourth Greek pass (`source_greek_aspis_xenophon.sql`), after locating the Hesiodic *Aspis*
(in the Evelyn-White Loeb volume, with H. C. Mason's 2015 commentary) and adding Xenophon:
- **Aspis war-daimones** → Hesiod, *Shield of Heracles*: Proioxis (154), Palioxis (154),
  Homados (155), Achlys (264–270); with Mason (2015) as secondary commentary.
- **Ioke and Alke** → Homer, *Iliad* 5.738–742 (figures worked on Athena's aegis).
- **Kakia and Arete** → Xenophon, *Memorabilia* 2.1.21–34 (Prodicus's Choice of Heracles).

New sources: SRC_HESIOD_ASPIS, SRC_MASON_ASPIS, SRC_XENOPHON_MEMORABILIA (168 total).
Greek primary coverage **65% → 66%**; ref-only **161 → 154**; 0 duplicate (entity_id,
source_id) pairs.

---

## v1.38.1 — 2026-06-14

### Cleanup: de-duplicate entity_sources

The Greek rigor passes' bulk-by-type inserts added `evidence_type='Direct attestation'`
rows for sources some entities already carried under a different `evidence_type` — and
since the entity_sources PK is `(entity_id, source_id, evidence_type)`, these did not
conflict, leaving 78 redundant rows (plus 2 pre-existing original-data duplicates).
`dedupe_entity_sources.sql` removes them, keeping the more specific citation. No coverage
change (the metrics key on source *type*, not these rows); Greek primary coverage holds at
65%, 0 duplicate (entity_id, source_id) pairs remain.

Noted TODO: the `evidence_type` vocabulary is itself inconsistent across the dataset
(snake_case `primary_attestation` vs `Primary text` vs `Direct attestation`) and would
benefit from the same controlled-vocabulary normalisation already applied to `source_type`.

---

## v1.38.0 — 2026-06-14

### Sourcing rigor III: Greek nymphs, heroes, and daimon stragglers

Third Greek pass (`source_greek_nymphs_heroes.sql`), using the newly-added Plato
*Symposium* (SRC_PLATO_SYMPOSIUM) and Hesiod *Works & Days* (SRC_HESIOD_WORKS_DAYS):
- **Heroes / deified mortals** (39) → **Apollodorus, *Library*** (the mythographic
  handbook); the Trojan/Odyssean heroes also → Homer.
- **Nymphs** → Homeric Hymns (the nymph-classes); Meliae → Hesiod *Theog.* 187; Calypso →
  *Odyssey* 5; genealogical nymphs (Aegina, Cyrene, Adrasteia, Idaia) → Apollodorus;
  local-cult nymphs (Corycia, Neda, Dirce) → Pausanias.
- **Daimon stragglers** → Penia/Poros → Plato *Symposium* 203b; Aidos/Elpis/Pheme/Arete
  and the two Strifes → Hesiod *Works & Days*.

Result: Greek entities with a primary source **56% → 65%**; ref-only **202 → 161** (290 →
161 over three passes; 37% → 65% coverage). +2 sources (165 total); 0 unsourced.

The remaining ~161 Greek ref-only are the long tail — later/obscure personifications and
collectives (e.g. the Shield daimones, tragedian and Xenophon personifications, Nonnan
nymphs) that need primary texts not yet in the registry.

---

## v1.37.0 — 2026-06-14

### Sourcing rigor II: Greek Orphic primordials, rivers, and Hesiodic daimones

Second Greek pass (`source_greek_hesiodic_v2.sql`), using the newly-added **Orphic Hymns**
(SRC_ORPHIC_HYMNS), all additive to the Theoi index:
- **Orphic primordials** → Orphic Hymns: Phanes (H.6), Physis (H.10), Chronos and Ananke
  (the Orphic cosmogony); plus Orphic-hymn attestation for Nyx/Ouranos/Aether.
- **River-gods (Potamoi)** → Hesiod, *Theogony* 337–345 (sons of Oceanus and Tethys); the
  rivers that act in the Iliad (Scamander, Xanthus, Simoeis, Aesepus, Granicus, Satnioeis,
  Titaresius, Spercheios, Axius, Caicus…) also → Homer.
- **Hesiodic daimon-personifications**, matched by genealogy → Hesiod, *Theogony*:
  children of Night (211–225: Apate, Geras, Momos, Oizys, Philotes, Eris), children of
  Strife (226–232: Ponos, Limos, Algea, Neikea, Dysnomia, Ate, Horkos…), children of Styx
  (383–385: Zelos, Kratos, Bia), Deimos/Phobos/Harmonia (933–937), Eros/Himeros (201);
  Enyo and Kydoimos → Homer.

Result: Greek entities with a primary source **45% → 56%**; ref-only **253 → 202** (290 →
202 over both passes). +1 source (163 total); no entity/relationship change; 0 unsourced.

Still deferred (need sources not yet in the registry): the philosophical personifications
(Penia/Poros — Plato *Symposium*), *Works & Days* and Shield daimones, and the obscure
Orphic-theogony figures (Ophion, Hydros, Thesis…).

---

## v1.36.0 — 2026-06-14

### Sourcing rigor I: Greek catalogue clusters → primary texts

Start of a program to bring the rest of the database to the sourcing standard set by the
Gnostic material. An audit found Greek the largest gap: 462 entities (37% of the DB), of
which **290 were sourced only to the Theoi.com index** — no primary text — even though
Hesiod, Homer, Apollodorus, and Pausanias were already in the registry.

This pass (`source_greek_hesiodic_v1.sql`) attaches the actual primary attestation,
**additively** (the Theoi reference is kept as a convenient index), to the clean
catalogue clusters, each matched to its correct source with a cited locus — not
blanket-assigned by type:
- Muses, Moirai, Charites, Nereids, Oceanids, the cosmogonic primordials, the astral
  deities, and Ker/Moros → **Hesiod, Theogony** (specific passages); Nereids also →
  **Homer, Iliad 18**.
- The Athenian Horai (Auxo/Carpo/Thallo) → **Pausanias 9.35** (not Hesiod's Eunomia/
  Dike/Eirene); the individually-named Hesperides → **Apollodorus 2.5.11** (Hesiod names
  them only as a group).
- The Orphic primordials (Phanes, Chronos, Ophion, Ananke…) were deliberately **deferred**
  — they need an Orphic source, not Hesiod.

Result: Greek entities with a primary source **37% → 45%**; ref-only **290 → 253**. No
entity/relationship/source counts changed (this adds source *links*); 0 unsourced
entities. (Remaining Greek clusters — rivers, nymphs, daimon-personifications, heroes —
follow in subsequent passes.)

---

## v1.35.0 — 2026-06-14

### Gnostic expansion V: completing the Sethian corpus

The remaining major Sethian figures beyond the Apocryphon of John, sourced from Meyer's
*Nag Hammadi Scriptures* (newly in the Drive) and Burns, *Apocalypse of an Alien God*
(2014). (`complete_sethian_corpus.sql`)

**New sources (2):** SRC_NAG_HAMMADI_SCRIPTURES (Meyer 2007); SRC_BURNS_ALIEN_GOD (2014).

**New entities (8):**
- *Trimorphic Protennoia:* Protennoia (the threefold First Thought, identical with Barbelo,
  descending as Voice/Father, Sound/Mother, Word/Son).
- *Platonizing treatises (Zostrianos, Allogenes):* the Barbeline triad — Kalyptos (the
  Hidden), Protophanes (the First-Appearing), and Autogenes (placed as the third) — plus
  the Triple-Powered One (Existence–Life–Mind) that mediates Barbelo from the One.
- *Gospel of the Egyptians:* Doxomedon (the great aeon/throne-realm), Plesithea (virgin
  mother of Seth's seed), Hormos (the vessel who sows the seed), and Nebruel (the demon
  joined with Sakla to beget the lower powers).

**Relationships (15):** Protennoia identified with Barbelo and revealing the gnosis; the
Barbeline triad (Kalyptos/Protophanes/Autogenes member_of Barbelo; Barbelo from the
Triple-Powered One); the Invisible Spirit enthroned in Doxomedon; Plesithea parent_of the
seed of Seth; Nebruel paired with Sakla; and **Eleleth descending to rescue Norea**
(Hypostasis of the Archons).

Counts: **1,371** entities (+8) / **2,416** relationships (+15) / **162** sources (+2);
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.34.0 — 2026-06-14

### Gnostic expansion IV: the Jeuian ascent-archons (Bruce Codex)

The soul's ascent through the first three aeons in the (Second) Book of Jeu, with the
ritual mechanism of passage. (`add_jeuian_ascent_archons.sql`)

**New entities (10):**
- *Gate-archons:* Proteth, Persomphon, Chous (first aeon); Chouncheoch (second);
  Choucho (third).
- *Ascent realms:* the First, Second, and Third Aeons of the Ascent.
- *Ritual mechanism:* the Baptism of Fire and the Seals of the Light.

**Relationships (21):** each archon rules its aeon; **the third aeon is guarded by
Yaldabaoth together with Choucho** — a direct bridge between the Jeuian ascent and the
Sethian demiurge; the archons are members of the archontic order; and the ritual
apparatus (Jesus administers the Baptism of Fire, which purifies, mediates salvation, is
kept by the Virgin of the Light, and opens onto the Treasury of the Light; the Seals
mediate the soul's passage past the archons).

Sourced to the Books of Jeu (Bruce Codex) and the Pistis Sophia. Builds on the Pistis
Sophia / Jeuian layer (v1.30.0).

Counts: **1,363** entities (+10) / **2,401** relationships (+21) / 160 sources;
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.33.0 — 2026-06-14

### Valentinian deepening II: the Eastern/Western split + soteriology

The Oriental/Italic division (Thomassen's central thesis), represented through entities
rather than teachers (Ptolemy, Heracleon, Theodotus, Axionicus are authors, excluded).
Sourced to Thomassen, Irenaeus AH, Clement's *Excerpta ex Theodoto* (the Eastern witness),
Hippolytus *Haer.* VI 35, and Tertullian *Adv. Valent.* (the "two schools").
(`add_valentinian_east_west.sql`)

**New entities (8):**
- *Threefold anthropology:* Pneumatic, Psychic, Hylic (the three natures/classes).
- *Spiritual Seed* — the pneumatic elect sown by Achamoth (Thomassen's title concept).
- *Psychic Christ* — the clearest marker of the split: the **Western** school gave the
  Saviour a psychic body from the Demiurge and made the psychics the target of salvation;
  the **Eastern** school held the Saviour's body to be wholly spiritual.
- *Angels of the Savior* — the seed's syzygy-partners in the bridal-chamber reunion.
- *Apolytrosis* — the redemption/release sacrament.
- *The Middle (Mesotes)* — the intermediate realm: Achamoth in the Ogdoad, the Demiurge
  ruling the Hebdomad below.

**Relationships (17):** the anthropology's origin in Achamoth's states (spiritual seed
from her vision; psychic from her conversion/Epistrophe; hylic from her passions/Lype);
Achamoth parent_of the Demiurge, who embodies the Psychic and rules the Middle; the psychic
Christ from the Demiurge, aligned with the Soter; and the reunion soteriology (spiritual
seed paired_with the angels of the Saviour, undergoes Salvation; apolytrosis bound to the
bridal chamber).

Counts: **1,353** entities (+8) / **2,380** relationships (+17) / 160 sources;
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.32.0 — 2026-06-14

### Valentinian deepening: the complete 30-aeon Pleroma + Sophia's passions

Grounded in Irenaeus *Adv. Haer.* I.1–4 and Einar Thomassen's *The Spiritual Seed*
(Brill, 2006), the definitive study of Valentinianism. (`deepen_valentinian_pleroma.sql`)

The Ogdoad already existed; the existing `ENT_GNO_SOPHIA` (30th aeon, spouse of Theletos)
and `ENT_VAL_MONOGENES` (Decad) were reused, not duplicated.

**New source:** SRC_THOMASSEN_SEED.

**New entities (22):**
- *Decad member-aeons (9):* Bythios, Mixis, Ageratos, Henosis, Autophyes, Hedone,
  Akinetos, Syncrasis, Macaria (completing the Decad to 10 with Monogenes).
- *Dodecad member-aeons (8):* Parakletos, Patrikos, Elpis, Metrikos, Aeinous, Synesis,
  Ekklesiastikos, Makariotes (completing the Dodecad to 12 with Pistis, Agape, Sophia,
  Theletos).
- *Sophia's passions (5):* Enthymesis (her cast-out intention = the lower Sophia/Achamoth)
  and the fourfold passion — Lype (grief), Phobos (fear), Aporia (perplexity), Epistrophe
  (conversion, the redemptive turning).

**Relationships (50):** the 17 member-aeons placed in their Decad/Dodecad; the ten
syzygies as reciprocal `spouse_of` pairs; the fall (Enthymesis emanates from Sophia,
Horos guards the Pleroma and separates it, Achamoth = Enthymesis, Achamoth parent_of the
four passions); and comparative links (Henosis→Union, Synesis→Understanding,
Parakletos→Holy Spirit, Phobos→Fear, Epistrophe→Salvation).

The full Pleroma now resolves: **Ogdoad (8) + Decad (10) + Dodecad (12) = 30 aeons.**
Homonyms suffixed "(Valentinian)" (Hedone, Macaria, Elpis, Synesis, Phobos).

Counts: **1,345** entities (+22) / **2,363** relationships (+50) / **160** sources (+1);
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.31.2 — 2026-06-14

### Hygiene: normalize the source_type vocabulary

Collapsed `sources.source_type` from ~39 ad-hoc near-duplicate values to a controlled
vocabulary of 6 (`normalize_source_types.sql`):

| source_type | count |
|---|---|
| primary text | 75 |
| secondary scholarship | 48 |
| reference work | 27 |
| primary inscription/artifact | 4 |
| heresiological source | 4 |
| internal | 1 |

Translation-anthologies and critical editions of primary scripture (Layton, Meyer, the
OTP translations, the Schäfer Hekhalot synopse, etc.) fold into *primary text*; the Theoi
indices, gazetteers, dictionaries and encyclopedias into *reference work*. Also corrected
one misclassification: Irenaeus's *Adversus Haereses* moved from *primary text* to
*heresiological source*, joining Hippolytus/Clement/Tertullian. No entity/relationship
changes (1,323 / 2,313 / 159).

---

## v1.31.1 — 2026-06-14

### Source audit + remediation

Added `scripts/audit_sources.sql` (re-runnable source-integrity audit) and fixed its
findings:
- **0 unsourced entities, 0 unsourced relationships, 0 dangling source FKs** — clean.
- Linked two primary-text sources that had been added in v1.29.0 but cited to nothing:
  `SRC_GOSPEL_EGYPTIANS` (→ Seth, Seed of Seth, Four Luminaries, Barbelo, Adamas) and
  `SRC_HYPOSTASIS_ARCHONS` (→ Norea, Sabaoth, Eleleth) — proper multi-text attestation.
- Filled the missing `scope` on `SRC_NEW_TESTAMENT`.

Reported, not changed: 4 pre-existing orphan sources (the Pleiades / ToposText /
Digital Egypt gazetteers and an internal heuristic marker), and the `source_type` field's
~39 near-duplicate values — flagged for a future normalisation pass to a controlled
vocabulary. No entity/relationship counts changed (1,323 / 2,313 / 159).

---

## v1.31.0 — 2026-06-14

### Gnostic expansion III: breadth beyond Sethian — the other currents

Adds the divine/spiritual entities of the Simonian, Basilidean, Marcionite, Saturnilian,
and Carpocratian currents, which survive mainly through the heresiologists.
(`add_gnostic_schools_entities.sql`)

**Methodology note:** DeityDB holds spiritual entities, not authors — so the school
*founders* (Basilides, Marcion, Valentinus, Carpocrates, Ptolemy, Heracleon, Marcus,
Cerinthus, Bardaisan) are excluded as historical theologians. Two humans are included
because their sects raised them to functional godhood: **Simon Magus** (worshipped as the
supreme Great Power) and **Epiphanes** (deified with a temple-cult per Clement).

**New sources (3):** Hippolytus, *Refutatio*; Clement of Alexandria, *Stromata* /
*Excerpta ex Theodoto*; Tertullian, *Adversus Marcionem* (joining the existing Irenaeus).

**New entities (9):** Basilidean — Unbegotten Father, **Abrasax** (lord of the 365
heavens), the Great Archon; Simonian — the Great Power, **Helena/Ennoia** (the earliest
fallen-Wisdom figure), Simon Magus; Marcionite — the **Stranger God**; Saturnilian — the
Seven World-Creating Angels; Carpocratian — Epiphanes.

**Relationships (15):** Basilidean emanation (Great Archon from the Unbegotten; Abrasax
rules the archons and aligns with Heimarmene/the 365); Simonian myth (Simon identified
with the Great Power, paired with Helena; **Helena aligned_with Sophia** as the prototype
of the fallen-Wisdom myth); Marcion's Stranger God opposes the Demiurge; the Seven Angels
align with the Hebdomad; supreme principles aligned with the Monad.

Counts: **1,323** entities (+9) / **2,313** relationships (+15) / **159** sources (+3);
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.30.0 — 2026-06-14

### Gnostic expansion II: the Pistis Sophia / Jeuian light-world

The late-Gnostic (3rd–4th c.) Treasury-of-Light cosmology of the Askew and Bruce
codices, sourced from the primary texts. (`add_pistis_sophia_jeuian.sql`)

**New sources (2):** Pistis Sophia (Askew Codex); the Books of Jeu (Bruce Codex).

**New entities (13):**
- *Upper light-world:* First Mystery (the manifest face of the Ineffable; identified with
  the risen Christ), the Treasury of the Light (with the Twenty-four Invisibles and the
  Five Helpers), Jeu (overseer of the Light / First Man), the Virgin of the Light (judge
  of souls) and her Receivers, and Zorokothora Melchizedek (the great Receiver/Purifier
  of the Light).
- *The fall narrative:* Pistis Sophia (the penitent fallen aeon, identified with the
  Gnostic Sophia), the Thirteenth Aeon, Authades ("the Arrogant"), Adamas the Tyrant, and
  the Lion-faced Power.

**Relationships (25):** light-world structure (First Mystery emanates from the Monad and
is identified with Christ; the Invisibles and Helpers in the Treasury; Jeu orders the
Treasury and aeons); soul-judgment (the Virgin of the Light judges the Dead and directs
her Receivers; Melchizedek mediates Salvation); and the fall (Pistis Sophia opposed by
Authades and Adamas the Tyrant, afflicted by the Lion-faced Power, undergoes Salvation,
and is carried out of the Chaos by the archangels Michael and Gabriel).

Note: "Adamas the Tyrant" (evil archon) is kept distinct from the Sethian heavenly Adamas.

Counts: **1,314** entities (+13) / **2,298** relationships (+25) / **156** sources (+2);
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.29.0 — 2026-06-14

### Gnostic expansion I: the Sethian system of the Apocryphon of John

Builds out the interior of the existing Sethian skeleton, sourced at the text level.
(`add_sethian_apocryphon_john.sql`)

**New sources (4):** Apocryphon of John (NHC II/III/IV + BG 8502); Hypostasis of the
Archons (NHC II,4); Gospel of the Egyptians (NHC III/IV); and Piwowarczyk's *Lexicon of
Spiritual Powers in the Nag Hammadi Library* (the scholarly onomastic reference).

**New entities (20):**
- *Barbelo's pentad:* Prognosis (Foreknowledge), Aphtharsia (Incorruptibility),
  Aionia Zoe (Eternal Life).
- *The twelve aeons of the Four Luminaries* (three each): Harmozel — Charis, Aletheia,
  Morphe; Oroiael — Aisthesis, Mneme (+ Epinoia); Daveithe — Synesis, Agape, Idea;
  Eleleth — Teleios, Eirene (+ Sophia).
- *Demiurgic apparatus:* Heimarmene (Fate), the Twelve Authorities (= Seven Kings of the
  Heavens + Five over the Chaos), the Seventy-two Angels (body-craftsmen, from the Book
  of Zoroaster interpolation), the Four Demons of the Passions, and the Souls of the
  Repentant. (Undifferentiated swarms mapped as sourced collectives, not 72 individual
  hapax names.)

**Relationships (34):** Barbelo's aeons emanate from her; the 12 aeons member_of their
luminaries; the heavenly humans placed in the luminaries (Adamas→Harmozel, Seth→Oroiael,
Seed of Seth→Daveithe, repentant souls→Eleleth); Autogenes identified_with Christ and
rules the luminaries; the fall genealogy **Yaldabaoth emanates_from Sophia**; the archon
hierarchy (Yaldabaoth parent_of the Twelve Authorities = 7 Kings + 5 over the Chaos);
Heimarmene embodies Fate; the Four Demons causes_affliction Humans; plus comparative
links (Aletheia→Truth, Mneme→Memory, Synesis→Understanding, Agape→Love).

Note: the Sethian aeons Aletheia, Agape, and Eirene are suffixed "(Sethian)" to
distinguish them from the existing Valentinian/Greek homonyms.

Counts: **1,301** entities (+20) / **2,273** relationships (+34) / **154** sources (+4);
0 unsourced, 0 orphans, 0 unresolved, 0 unreviewed duplicates.

---

## v1.28.0 — 2026-06-14

### Layer: later Sufism — the systematizers and metaphysicians (11th–13th c.)

Builds on the formative Sufi layer (v1.26.0), oldest-first: al-Qushayri (d. 1074) →
al-Ghazali (d. 1111) → ʿAbd al-Qadir al-Jilani (d. 1166) → Suhrawardi (d. 1191) →
Ibn al-ʿArabi (d. 1240) → Rumi (d. 1273). (`add_sufi_classical_systematizers.sql`)

**New period:** PER_ISL_MEDIEVAL (1258–1517, post-Abbasid) for Rumi.

**New sources (3):** al-Ghazali, *Ihya Ulum al-Din*; Ibn al-ʿArabi, *Fusus al-Hikam*;
Rumi, *Masnavi*.

**New entities (10):** 6 figures (above) + 4 doctrines — Wahdat al-Wujud (unity of
being), Insan al-Kamil (the Perfect Man), Ishraq (Illumination), Samaʿ (spiritual
audition / whirling).

**Relationships (17):** doctrine attributions (Ibn al-ʿArabi teaches wahdat al-wujud +
the Perfect Man; Suhrawardi teaches ishraq; Rumi embodies mahabba + associated_ritual
samaʿ); path codification (Qushayri/Ghazali/Jilani teach Tariqa); silsila reception
(Ghazali reception_of Junayd; Ibn al-ʿArabi reception_of Hallaj); sainthood (Ibn
al-ʿArabi, Jilani embodies Walaya). Comparative integration: wahdat al-wujud → Union,
ishraq → Light, samaʿ → Dhikr, and **Insan al-Kamil aligned_with Adam Kadmon (Jewish)
and Anthropos (Gnostic)** — uniting the Perfect Man / cosmic Anthropos motif across the
Sufi, Kabbalistic, and Gnostic traditions.

Counts: **1,281** entities (+10) / **2,239** relationships (+17) / **150** sources (+3);
0 unsourced entities, 0 unsourced relationships, 0 orphans, 0 unresolved references.

---

## v1.27.0 — 2026-06-14

### New layer: complete the Kabbalistic Tree of Life

Second of the two mystical layers (after formative Sufism, v1.26.0). The Jewish-mystical
tradition already held its older Hekhalot/Merkavah stratum (Merkabah, Metatron, angelic
orders, Sar Torah) and the Sefirot top triad (Keter, Hokhmah, Binah); this completes the
medieval (12th–13th c.) Tree of Life. The later Lurianic apparatus (Tzimtzum, Shevirat
ha-Kelim, Tikkun — 16th c. Safed) is deliberately deferred. (`complete_kabbalah_tree.sql`)

**New entities (8):** Ein Sof (the Infinite) and the seven lower Sefirot — Chesed,
Gevurah (Din), Tiferet, Netzach, Hod, Yesod, Malkhut. Sources: Zohar, Scholem (*Kabbalah*).

**Relationships (22):**
- *Emanation chain* (seder hishtalshelut): Keter emanates_from Ein Sof, then the full
  cascade Keter→Hokhmah→Binah→Chesed→Gevurah→Tiferet→Netzach→Hod→Yesod→Malkhut.
- *Tree membership:* Sefirot has_member each of the 7 new Sefirot (now 10 of 10).
- *Attribute / comparative links:* Chesed embodies Love, Gevurah embodies Judgment,
  Tiferet embodies Beauty, Malkhut embodies Sovereignty.
- *Identity:* Malkhut identified_with Shekhinah (the indwelling presence).

Counts: **1,271** entities (+8) / **2,222** relationships (+22) / 147 sources; 0 unsourced
entities, 0 unsourced relationships, 0 orphans, 0 unresolved references.

---

## v1.26.0 — 2026-06-14

### New layer: formative Sufism (8th–10th c.)

First of two planned mystical layers, built oldest-first per the bottom-up priority:
early Sufism (Hasan al-Basri d. 728 → al-Hallaj d. 922) predates Kabbalah proper
(12th–13th c.) by ~300–400 years, so it lands before the Jewish-mystical/Kabbalistic
layer. The great systematizers (al-Ghazali d. 1111, Ibn al-ʿArabi d. 1240, Rumi d. 1273)
are deliberately deferred to a later stratum. (`add_sufi_formative_layer.sql`)

**New sources (2):** SRC_SCHIMMEL_SUFISM (Schimmel, *Mystical Dimensions of Islam*, 1975);
SRC_HUJWIRI_KASHF (al-Hujwiri, *Kashf al-Mahjub*, c. 1075 — earliest Persian Sufi treatise).

**New entities (12):**
- *6 mystics:* Hasan al-Basri (asceticism/zuhd), Rabiʿa al-ʿAdawiyya (divine love),
  Dhuʾl-Nun al-Misri (maʿrifa), Abu Yazid al-Bistami (intoxicated fanaʾ), al-Junayd
  al-Baghdadi (sober school, fanaʾ→baqaʾ), al-Hallaj (the "Anaʾl-Haqq" martyr).
- *6 doctrines:* Fanaʾ, Baqaʾ, Maʿrifa, Mahabba, Dhikr, Tariqa.

**Relationships (21):** figures embody/teach their signature doctrines; silsila links
(Junayd teaches Hallaj; Junayd reception_of Hasan al-Basri); doctrine structure
(Fanaʾ ⇄ Baqaʾ; Fanaʾ/Baqaʾ/Maʿrifa/Dhikr member_of Tariqa); comparative-layer
integration (Mahabba→Love, Maʿrifa→Hidden Knowledge, Fanaʾ→Union); and sainthood
(Junayd/Bistami embodies Walaya, tying into the existing Qutb/Abdal hierarchy).

Counts: **1,263** entities (+12) / **2,200** relationships (+21) / **147** sources (+2);
0 unsourced entities, 0 unsourced relationships, 0 orphans, 0 unresolved references.

---

## v1.25.0 — 2026-06-14

### Enrichment: Etruscan and Celtic/Gaulish (completes the thin-tradition pass)

The last two thin traditions — Etruscan (1.33 edges/entity) and Celtic/Gaulish (1.40) —
enriched with 17 source-backed relationships (`enrich_etruscan_celtic_gaulish.sql`).
Enrichment matched to attestation: well-documented gods get more edges, sparsely-attested
ones (e.g. Taranis, known mainly from one line of Lucan) only a single high-confidence
link. No new entities or sources.

**Etruscan (10 edges):** Tinia embodies Storm + patron_of Sovereignty; Uni patron_of
Sovereignty + aligned_with Astarte (explicit in the bilingual Pyrgi Gold Tablets);
Menrva patron_of Craft + Wisdom + reception_of Athena; Turan patron_of Love + embodies
Beauty + reception_of Aphrodite. Source: De Grummond, *Etruscan Myth*; Pyrgi Tablets.

**Celtic/Gaulish (7 edges):** Taranis aligned_with Jupiter (wheel-god interpretatio);
Sucellus ⇄ Nantosuelta (paired divine couple); Lugus equated_with Mercury (Caesar's
"most honoured god of Gaul") + patron_of Craft; Matres patron_of Motherhood; Cernunnos
patron_of Fertility. Sources: Green, *Dictionary of Celtic Myth*; Duval, *Les dieux de
la Gaule*.

Result: edge density Etruscan 1.33 → 2.17, Celtic/Gaulish 1.40 → 2.10. With v1.24.0,
all four originally-thin traditions (Baltic, Slavic, Etruscan, Celtic/Gaulish) now sit
above 2.0 edges/entity. Counts: 1,251 entities / **2,179** relationships (+17) / 145
sources; 0 unsourced, 0 unresolved.

---

## v1.24.0 — 2026-06-14

### Enrichment: Baltic and Slavic traditions (thinnest layers)

The two thinnest covered traditions — Baltic (1.30 edges/entity) and Slavic (1.44) —
enriched with 23 source-backed relationships (`enrich_baltic_slavic.sql`). Most are
domain links into the abstraction layer, so these cognate Indo-European gods now also
surface in `v_public_comparative_domains`. No new entities or sources.

**Baltic (11 edges):** Saulė embodies Sun; Mēness embodies Moon; Perkūnas embodies Storm
+ patron_of Justice; Laima embodies Fate; Žemyna patron_of Fertility; Velnias dwells_in
Underworld + patron_of Magic; Dievas patron_of Sovereignty; Medeina patron_of Animals;
Saulė aligned_with Helios (PIE *seh2ul- solar reflex). Sources: Gimbutas (The Balts),
Greimas (Of Gods and Men).

**Slavic (12 edges):** Perun patron_of Sovereignty (head of the 980 Kiev pantheon);
Veles dwells_in Underworld + patron_of Magic; Dažbog embodies Sun + patron_of Wealth;
Khors embodies Sun; Stribog embodies Wind; Mokosh embodies Fate + patron_of Fertility;
Svarog patron_of Craft + aligned_with Hephaestus (explicit in the Slavic Malalas gloss);
Rod patron_of Fate. Sources: Brückner (Mitologia Słowiańska), Primary Chronicle.

Result: edge density Baltic 1.30 → 2.40, Slavic 1.44 → 2.78 (above the Egyptian baseline).
Counts: 1,251 entities / **2,162** relationships (+23) / 145 sources; 0 unsourced, 0
unresolved.

---

## v1.23.0 — 2026-06-14

### Disambiguation: sharpen the Dead / Death / Underworld abstraction cluster

An audit of the 118-node "Cross-traditional" abstraction layer (CLAUDE.md rule 3)
found it remarkably well-curated — apparent synonyms mostly encode real theological
distinctions (Binah vs Hokhmah, the individual Muses, Phobos/Deimos = Fear/Terror, the
Celtic Otherworld vs the chthonic Underworld). No node merges were warranted; merging
would have flattened genuine theology.

The one real conflation was the **Dead (the deceased) / Death (the force) /
Underworld (the realm)** cluster, where six edges blurred the force/people/place
boundary (`disambiguate_death_cluster.sql`):
- **Deleted** `Thanatos embodies Dead` (exact duplicate of the correct
  `Thanatos embodies Death`).
- **Deleted** `Sheol belongs_to_realm Death` (redundant; Sheol already correctly
  `belongs_to_realm Underworld`).
- **Retyped** `Osiris patron_of Death` → `rules Underworld` (Osiris rules the Duat but
  had **no** Underworld edge — gap filled; rationale updated).
- **Retyped** `Nergal patron_of Death` → `rules Underworld` (Mesopotamian underworld
  sovereign; same gap; rationale updated).
- **Deleted** `Ereshkigal patron_of Death` (redundant — already `rules Dead` +
  `dwells_in Underworld`; a realm-queen, not the death-force).
- **Deleted** `Anubis patron_of Death` (redundant — already `guides`/`guardian_of Dead`;
  funerary patron, not the death-force).

The Death-force node now holds only genuine personifications (Thanatos, Mot, Keres,
Moros, Azrail, Angel of Death…) plus the battlefield-death patrons Morrígan and Odin.

Counts: 1,251 entities / **2,139** relationships (−4) / 145 sources; source_id preserved
on retypes; 0 unsourced relationships, 0 orphans, 0 unresolved references.

---

## v1.22.3 — 2026-06-14

### Reproducibility: total view fidelity — schema rebuilds the live DB exactly

Back-filled the last 16 internal views into `schema/views.sql` (dumped from the live
instance, dependency-ordered as emitted by pg_dump, normalised to `CREATE OR REPLACE`):
`entity_relationships_expanded` (inverse-expanded edges), `v_entity_relationships_full`,
`v_entity_correspondences`, `v_entity_taxonomy_summary`, `v_entity_traditions`,
`v_category_distribution`, `v_entity_epithet_relationships`, `v_entity_epithet_summary`,
`v_associated_with_conversion_candidates`, `v_possible_duplicate_entities`,
`v_relationships_needing_review`, `v_priority_relationship_review`, `v_review_by_tradition`,
`v_review_dashboard`, `v_staging_entity_duplicates`, `v_staging_relationships_resolved`.

`schema/views.sql` now defines all 30 views (14 curated public/metrics + 16 internal).

**Verified:** a throwaway database built through `tables.sql → constraints.sql →
views.sql` (`ON_ERROR_STOP=1`) is now an exact structural replica of the live instance —
**36 tables, 30 views, 77 constraints, 47 indexes**, with zero live views missing. The
schema layer is fully reproducible. No data change.

---

## v1.22.2 — 2026-06-14

### Reproducibility: commit table + constraint DDL — bootstrap now works end-to-end

`schema/bootstrap.sql` loads `tables.sql` → `constraints.sql` → `views.sql`, but
`schema/tables.sql` did not exist and `constraints.sql` held only three hand-written
constraints — so a from-scratch rebuild failed immediately. The full table and
constraint DDL lived only in the running Postgres instance.

- **`schema/tables.sql`** (new): all 36 tables, 5 sequences, and column defaults,
  dumped from the live instance via `pg_dump --section=pre-data` (views stripped —
  they belong to `views.sql`; `search_path`/`\restrict` meta removed so the shared
  bootstrap session keeps the default `public` search path).
- **`schema/constraints.sql`** (regenerated): all 71 `ADD CONSTRAINT` (31 PK, 38 FK,
  2 UNIQUE) plus 14 indexes, via `pg_dump --section=post-data`. Supersedes the earlier
  three-constraint hand-written stub (which it reproduces).

**Verified end-to-end:** building a throwaway database through
`tables.sql → constraints.sql → views.sql` with `ON_ERROR_STOP=1` exits clean and
reproduces the live schema exactly — **36 tables, 77 constraints, 47 indexes** (parity
with live) — and the real data (1,251 entities + sources) loads into it with every FK
and constraint satisfied.

Known remaining gap (non-blocking): the live instance also has ~14 internal diagnostic
views (review dashboards, taxonomy summaries, staging helpers) not yet in `views.sql`;
the bootstrap produces all 11 public views + metrics. No data change.

---

## v1.22.1 — 2026-06-14

### Reproducibility: commit the full public-view DDL to schema/views.sql

`schema/bootstrap.sql` loads `schema/views.sql`, but that file defined only three
early placeholder views (`relationship_distribution`, `unresolved_relationships`,
`generic_associations`) that no longer exist in the database — while the views
actually in use (the eleven `v_public_*` plus `v_release_metrics` and its two staging
dependencies) lived only in the running Postgres instance. The public API could not
be rebuilt from source.

`schema/views.sql` now contains the canonical DDL for **all live views**, dumped from
the instance (`pg_get_viewdef`) and ordered so dependencies precede dependents:
- staging diagnostics `v_unreviewed_duplicate_entities`, `v_staging_relationship_unresolved`
- `v_release_metrics`
- the eleven `v_public_*` views (overview, thematic rosters, and the v1.22.0
  comparative-domain pair)

All use `CREATE OR REPLACE` (idempotent) and were verified to apply against the live DB
with no diff. The three obsolete placeholders were removed (unreferenced; superseded by
`v_public_relationship_overview` and the staging diagnostics). No data or view-output
change — website surfaces unaffected.

---

## v1.22.0 — 2026-06-14

### Feature: comparative-domain public views

DeityDB's purpose is comparing divine functions *across* traditions and kinds, but
none of the existing public views pivoted on that axis — they were all theme rosters
(underworld beings, serpents, angels…). The "Cross-traditional" tradition turns out
to be the comparative substrate: 118 abstraction/domain nodes (War, Healing,
Sovereignty, Disease, Underworld, Wisdom…) that 658 typed edges from 45 traditions
point at.

**New views** (`add_comparative_domains_views.sql`):
- **`v_public_comparative_domains`** (detail): every (domain, entity) pairing — which
  deities/beings across every tradition `embodies` / `patron_of` / `rules` /
  `causes_affliction` / `dwells_in` / `reveals` each shared domain, with confidence
  and source. 658 rows.
- **`v_public_domain_overview`** (index): per domain, entity count + tradition count +
  the relationship kinds involved. Widest-reaching: Protection (30 entities / 14
  traditions), War (29 / 14), Dead (42 / 13), Sovereignty (28 / 13), Fertility (17 / 13).

**Wiring:**
- `metadata.yaml`: both views documented; new Datasette queries `comparative-domains-index`
  and a parameterized `browse-domain` (`WHERE domain = :domain`). Fixed stale source
  count (143 → 145).
- `scripts/export_sqlite.sh`: both views materialised into the SQLite/Datasette export.
- `examples/sample_queries.sql`: index + single-domain comparison examples.

These are the **first public views with committed DDL** — the existing nine
`v_public_*` views live only in the running Postgres instance. **Follow-up:** back-fill
`schema/views.sql` with the other nine so the public API is fully reproducible.

No data changes: 1,251 entities / 2,143 relationships / 145 sources.

---

## v1.21.0 — 2026-06-14

### Quality: full relationship sourcing — 0 unsourced relationships

**Source backfill** (`fix_sourcing_batch11_unsourced_relationships.sql`):
An audit (`audit_quality_snapshot.sql`) found 99 relationships with no `source_id` —
the last gap against CLAUDE.md rule 2 (every relationship traces to a source record).
All 99 are real, defensible edges that simply never had the FK populated. Each was
assigned a source already linked to one of its endpoints (no new sources introduced),
using the source that documents the actual claim:
- **reception_of / embodies / rules / equated_with / etc.** → the SUBJECT's attesting
  source (the tradition making the claim).
- **received_as** → the OBJECT's source (the later/receiving tradition documenting the
  reception).

Largest clusters: Solomonic demonology (20 → SRC_TESTAMENT_SOLOMON: afflictions,
binding, decans); Thelemic receptions (11 → SRC_CROWLEY_BOOK_OF_LAW); Hermetic
Hermes/Thoth→Trismegistus (11 → SRC_CORPUS_HERMETICUM); Nag Hammadi Gnostic (5 →
SRC_NHC); Behemoth/Leviathan chaos monsters (5 → SRC_DDD_BIBLE); Christian
Devil/Lucifer (6 → SRC_CHRISTIAN_DEMONOLOGY_GENERAL); plus Manichaean, Kabbalistic,
Mesopotamian, Canaanite, Zoroastrian, Norse, and Greek single edges.

Also committed `audit_quality_snapshot.sql` (re-runnable health snapshot) and
`pre_release_cleanup.sql` (previously applied, now tracked).

Counts unchanged: 1,251 entities / 2,143 relationships / 145 sources;
**0 unsourced relationships**, 0 orphans, 0 unsourced entities, 0 unresolved references.

---

## v1.20.0 — 2026-06-14

### Expansion: Valentinian pleroma, Dacian tradition, Italic/Sabine tradition

**Valentinian pleroma expansion** (`add_valentinian_expansion.sql`):
- **NEW SOURCE**: SRC_IRENAEUS_AH (Irenaeus, Adversus Haereses I.1-9, c. 180 CE — the fullest
  ancient account of Valentinian theology; Rousseau & Doutreleau SC 263-264 edition)
- **NEW ENTITIES (6)**: ENT_VAL_DECAD (ten-aeon collective from Logos+Zoe), ENT_VAL_DODECAD
  (twelve-aeon collective from Anthropos+Ecclesia), ENT_VAL_MONOGENES (Only-begotten, Decad),
  ENT_VAL_PISTIS (Faith, Dodecad), ENT_VAL_AGAPE (Love, Dodecad), ENT_VAL_THELETOS (Will,
  Dodecad — paired with Sophia, the 30th aeon; his absence triggers the Fall).
- **CRITICAL FIX — Yaldabaoth**: ENT_GNO_YALDABAOTH had only 1 relationship (cult_form_of
  Demiurge). Added 5 relationships: parent_of from Achamoth, member_of Archons,
  identified_with Saklas, aligned_with Samael, opposes Sophia.
- **STRUCTURAL CHAIN**: Nous emanates_from Bythos; Aletheia emanates_from Sige; Logos+Zoe
  parent_of Decad; Anthropos+Ecclesia parent_of Dodecad; individual aeons member_of their
  collectives; Sophia member_of Dodecad; Sophia spouse_of Theletos.

**Dacian tradition** (`add_dacian_layer.sql`):
- **NEW ENTITY (1)**: ENT_DAC_DERZELAS — Dacian chthonic deity of vigor and abundance,
  attested on coins at Odessos (mod. Varna, Bulgaria), 3rd–2nd c. BCE. Tradition: "Dacian".
- **NEW RELATIONSHIPS (3)**: Zalmoxis aligned_with Dionysus (mystery cult structural parallel;
  Herodotus, Plato); Derzelas aligned_with Zalmoxis (shared chthonic-vitalistic domain);
  Derzelas aligned_with Gebeleizis (regional Dacian storm/chthonic divine pair).

**Italic/Sabine tradition** (`add_italic_sabine.sql`):
- **NEW PERIOD**: PER_ITA_ARCHAIC (Archaic Italic, c. 900–509 BCE)
- **NEW ENTITIES (6)**: ENT_ITA_FAUNUS (wildlands, prophecy, Lupercalia), ENT_ITA_PICUS
  (prophetic woodpecker, first king of Latium, father of Faunus per Virgil Aen. 7.48),
  ENT_ITA_OPS (Sabine abundance goddess, Saturn's consort), ENT_ITA_CARMENTA (prophetic
  goddess, Carmentalia, patron of childbirth, co-credited with Latin alphabet), ENT_ITA_FLORA
  (goddess of flowering plants, Floralia, identified with Greek Chloris in Ovid Fasti 5.195),
  ENT_ITA_SILVANUS (forest boundary guardian, primarily worshipped by slaves/freedmen).
- **RELATIONSHIPS (10)**: Picus parent_of Faunus (high); Faunus aligned_with Pan (high — explicit
  ancient identification); Picus aligned_with Mars (medium — Picus Martius, woodpecker of Mars);
  Ops spouse_of Saturn (high); Silvanus aligned_with Pan (medium); Silvanus aligned_with Faunus
  (medium); Carmenta aligned_with Hermes (medium — mother of Evander with Mercury per Ovid/Livy);
  Carmenta reception_of Mnemosyne (low — Camenae identified with Muses by Livius Andronicus);
  Flora aligned_with Demeter (low); Flora aligned_with Ceres (medium — consecutive festival calendar).

Counts: +13 entities (1,251 total), +30 relationships (2,143 total),
+1 source (145 total), 0 unresolved references.

---

## v1.19.0 — 2026-06-14

### Enrichment: Hermopolis Ogdoad cluster

**Hermopolis Ogdoad enrichment** (`enrich_hermopolis_ogdoad.sql`):
All 8 Ogdoad entities existed in the DB with correct structural relationships
(member_of + male spouse_of), but 7 had one-liner short_notes and none had
cross-tradition links or reciprocal female spouse_of relationships.

**Short_notes enriched (8):** Nun (primordial watery abyss, Pyramid Texts attestation,
benben emergence), Naunet (counter-heaven water, serpent iconography), Heh (primordial
infinity, dual role as Ogdoad force and individual eternity deity, palm-rib iconography),
Hauhet (female boundlessness, serpent head, structural symmetry), Kek (primordial
darkness as creative potential, corrects internet folk etymology confusion),
Kauket (female darkness, serpent iconography), Amunet (female hidden, Karnak cult
persistence, Mut displacement in Theban triad), Ogdoad collective (Hermopolitan
cosmology full account, khmun etymology, Ennead comparison, Gnostic Ogdoad reception,
Thoth as organizing agent).

**Reciprocal spouse_of relationships (4):** Naunet↔Nun, Hauhet↔Heh, Kauket↔Kek
(all high), Amunet↔Amun (medium — complicated by Mut's New Kingdom displacement).

**Cross-tradition links (2):**
- `ENT_EGY_NUN aligned_with ENT_MES_APSU` (medium — both primordial male water-abyss
  pre-creation; most direct Egyptian-Mesopotamian cosmogony parallel)
- `ENT_EGY_NUN aligned_with ENT_MES_NAMMU` (medium — Sumerian primordial sea parallel;
  gender-inverted but same creative-matrix function)

**Thoth ↔ Ogdoad (1):**
- `ENT_EGY_THOTH patron_of ENT_EGY_OGDOAD` (medium — Hermopolis patron deity;
  in some traditions the creative Logos who gives voice to the Ogdoad's primordial forces;
  lays the primordial cosmic egg)

Counts: +0 entities (1,238 total), +7 relationships (2,113 total),
0 unresolved references.

---

## v1.18.0 — 2026-06-14

### Expansion: Enochian / Second Temple Apocalyptic cluster

**Enochian expansion** (`add_enochian_expansion.sql`): The core Enochian layer
(Enoch, Azazel, Shemihazah, Watchers, Mastema) already existed and was well-connected.
This expansion targets the specific gaps: the three absent archangels completing the
1 Enoch 20 seven-archangel council, the Nephilim (the foundational product of the
Watcher transgression and progenitors of Second Temple demonology), enrichment of
thin entities (Behemoth/Leviathan pairing, Mastema/Satan alignment), and a
substantive short_note for Shemihazah.

**New entities (4):**
- **Raguel** (`ENT_ISR_RAGUEL`, conf A): Archangel who "takes vengeance on the world
  of the luminaries" (1 Enoch 20:4); oversees cosmic-astronomical order; venerated
  in Ethiopian Orthodox tradition; completes the 7-archangel council alongside
  Michael, Gabriel, Raphael, Uriel (all already in DB), Remiel, and Sariel.
- **Remiel** (`ENT_ISR_REMIEL`, conf A): Archangel "whom God set over those who rise"
  (1 Enoch 20:8); resurrection/souls of the dead; appears as "Jeremiel" in 4 Ezra
  4:36; confirmed in 2 Baruch 55:3; cross-linked to ENT_ZOR_AMERETAT (low —
  Zoroastrian immortality/resurrection parallel).
- **Sariel** (`ENT_ISR_SARIEL`, conf A): Archangel "set over the spirits, who sin in
  the spirit" (1 Enoch 20:6); named on War Scroll battle tower (1QM 9:15-16)
  alongside Michael, Gabriel, Raphael — replacing Uriel in the DSS four-archangel
  schema; one of the best-attested archangels in Dead Sea Scrolls literature.
- **Nephilim** (`ENT_ISR_NEPHILIM`, conf A): Giant hybrid offspring of Watchers and
  human women (Gen 6:1-4; 1 Enoch 6-7); their violence precipitates the Flood
  judgment; their disembodied spirits become the post-Flood demons of Second Temple
  demonology (1 Enoch 15:8-12); child_of both ENT_ISR_WATCHERS and
  ENT_ISR_BENE_ELOHIM; parent entity Shemihazah; opposes ENT_ISR_YAHWEH.

**Entity update:**
- **Shemihazah** (`ENT_ISR_SHEMIHAZAH`): Replaced one-line stub with full short_note
  (Mount Hermon oath, Watcher list, specific teaching domain, Michael's binding
  command 1 Enoch 10:11-12, DSS Book of Giants attestation, contrast with Mastema).

**New relationships (14):**
- `ENT_ISR_BEHEMOTH paired_with ENT_ISR_LEVIATHAN` (high — 1 Enoch 60:7-9; Job 40-41;
  4 Ezra 6:49-52; rabbinic eschatological feast tradition; the canonical pair)
- `ENT_ISR_MASTEMA aligned_with ENT_ISR_SATAN` (high — same adversarial/accuser
  function; Mastema in Jubilees = Satan in Job/DSS; Jubilees 17:16 binding of Isaac test)
- `ENT_ISR_BENE_ELOHIM member_of ENT_ISR_WATCHERS` (high — Gen 6 Bene Elohim = 1 Enoch
  Watchers; the two tradition-names for the same divine beings)
- `ENT_ISR_WATCHERS parent_of ENT_ISR_NEPHILIM` + `ENT_ISR_SHEMIHAZAH parent_of
  ENT_ISR_NEPHILIM` + `ENT_ISR_NEPHILIM child_of ENT_ISR_BENE_ELOHIM` (genealogy chain)
- `ENT_ISR_NEPHILIM opposes ENT_ISR_YAHWEH` (high — their corruption precipitates Flood)
- Raguel, Remiel, Sariel each: `aligned_with` existing archangels; Remiel `aligned_with`
  ENT_ZOR_AMERETAT (low — resurrection/immortality parallel); Sariel, Raguel each
  `opposes ENT_ISR_WATCHERS` (domain overlap)
- New source: `SRC_JUBILEES` (VanderKam, CSCO 510-511, 1989 — anchors Mastema material)

Counts: +4 entities (1,238 total), +14 relationships (2,106 total),
+1 source (144 total), 0 unresolved references.

---

## v1.17.0 — 2026-06-14

### Structural quality: category audit, orphan fix, Zoroastrian cross-links

Three structural improvement scripts applied — no new entities or sources,
only improvements to data completeness and graph connectivity.

**Category audit** (`audit_category_fill.sql`):
90 entities across 20 traditions were missing `category` and/or `primary_domains`,
making them invisible to all category-filtered public views. All 90 are now
fully classified:
- Celtic/Welsh (15): Arawn, Gwyn ap Nudd, Rhiannon, Math, Gwydion, Don, Lleu,
  Manawydan, Pryderi, Pwyll, Blodeuwedd, Bran, Branwen, Aranrhod, Annwn
- Etruscan (12): Tinia, Uni, Menrva, Turan, Usil, Fufluns, Nethuns, Thesan,
  Voltumna, Lasa, Charun, Tuchulcha
- Scythian (7): Tabiti, Papaeus, Artimpasa, Api, Sword Ares, Oetosyrus, Thagimasadas
- Hittite + Hittite/Hurrian (12): Arinna, Tarhunna, Hannahanna, Telipinu, Inaras,
  Illuyanka, Teshub, Hepat, Kumarbi, Shaushka, Alalu, Ullikummi
- And all remaining gaps in Canaanite, Celtic/Gaulish, Egyptian, Greek (Titans),
  Islamic, Israelite, Jewish Mystical, Mesopotamian, Mycenaean, Phoenician,
  Phrygian, Pre-Islamic Arabian, South Arabian, Zoroastrian
- Zero entities missing category after this script.

**Orphan fix** (`fix_orphan_entities.sql`):
6 entities had zero relationships and were fully disconnected from the graph.
Each now has 1–2 sourced relationships:
- **ENT_SLAV_ROD** → `aligned_with ENT_ZEUS` (medium — supreme creator deity parallel;
  Brückner/Primary Chronicle)
- **ENT_BALT_RAGANA** → `opposes ENT_BALT_LAIMA` (medium — dark/light fate contrast;
  Greimas) + `aligned_with ENT_HECATE` (medium — nocturnal sorceress/crossroads parallel)
- **ENT_SLAV_STRIBOG** → `aligned_with ENT_SLAV_DAZBOG` (medium — paired in Primary
  Chronicle as complementary sky-force deities)
- **ENT_SLAV_SIMARGL** → `aligned_with ENT_SLAV_PERUN` (low — co-listed in 980 CE
  Kiev pantheon; guardian within Perun's divine assembly)
- **ENT_SLAV_KHORS** → `aligned_with ENT_SLAV_DAZBOG` (high — consistently paired in
  Primary Chronicle and Igor Tale as complementary solar deities)
- **ENT_FINN_AHTI** → `aligned_with ENT_POSEIDON` (low — structural parallel as
  supreme sea deity; Kalevala Runo 5)
- Global orphan count: 0. All 1,234 entities are now graph-connected.

**Zoroastrian cross-links** (`add_zoroastrian_crosslinks.sql`):
The 6 Amesha Spentas previously had only inward relationships (member_of, embodies).
They are now linked to their closest Jewish archangel and Gnostic aeon counterparts,
completing the most important missing cluster in comparative theology:
- **Vohu Manah** (Good Mind) → `aligned_with ENT_GNO_NOUS` (medium — semantic parallel:
  divine Mind/Intelligence as first emanation)
- **Asha Vahishta** (Best Truth/Fire) → `aligned_with ENT_ISR_URIEL` (medium — domain:
  truth/fire/divine light; Uriel as angel of fire in 1 Enoch 20:2)
- **Khshathra Vairya** (Dominion) → `aligned_with ENT_ISR_MICHAEL` (medium — domain:
  divine sovereignty/kingdom; Daniel 10:13 Michael as heavenly warrior-king)
- **Spenta Armaiti** (Holy Devotion) → `aligned_with ENT_GNO_SOPHIA` (medium — domain:
  divine feminine wisdom/devotion; both feminine emanations of supreme divinity)
- **Haurvatat** (Wholeness) → `aligned_with ENT_ISR_RAPHAEL` (medium — domain:
  healing/wholeness/water; "God has healed"; Tobit 12:14–15)
- **Ameretat** (Immortality) → `aligned_with ENT_GNO_ZOE` (medium — semantic: both
  embody the life/deathlessness principle)

Counts: +0 entities (1,234 total), +13 relationships (2,092 total),
0 unresolved references.

---

## v1.16.0 — 2026-06-14

### Enrichment: Pre-Islamic Arabian / Nabataean deities

**Pre-Islamic Arabian enrichment** (`enrich_pre_islamic_arabian.sql`):
Dushara, Al-Uzza, Manat, and Al-Lat already existed as well-noted entities
(backed by SRC_HEALEY_NABATAEAN_RELIGION, SRC_HERODOTUS_HISTORIES, SRC_QURAN)
but lacked `category`, `primary_domains`, and two key relationships:

- **category / primary_domains added** to all four: Dushara (High Deity;
  divine supremacy, mountain, sky, aniconic baetyl cult), Al-Uzza (Love Deity;
  Venus/morning star, love, war), Manat (Underworld Deity; fate, death, moon,
  tribal oaths), Al-Lat (High Deity; sun, fertility, motherhood, war).
- **Al-Lat received_as Aphrodite (high)**: Herodotus 3.8 (c. 430 BCE) is the
  earliest explicit ancient Arabian-Greek deity equation — he names "Alilat" and
  states "Alilat is the same as Aphrodite [Ourania]." This primary-text equation
  was unrepresented in the graph despite SRC_HERODOTUS_HISTORIES already being
  linked to Al-Lat. Al-Lat now has two Greek equations: Aphrodite (high, Herodotus)
  and Athena (medium, Palmyrene-period identification).
- **Dushara aligned_with Zeus (medium)**: Greek and Roman sources (incl. Epiphanius,
  *Panarion* 51.22) identified Dushara with both Dionysus (his existing relationship)
  and Zeus/Jupiter as the supreme deity of the Arabs. The Zeus equation reflects his
  sky-sovereignty function alongside the vegetation/wine Dionysus aspect.

Counts: +0 entities (1,234 total), +3 relationships (2,079 total), 0 unresolved references.

---

## v1.15.0 — 2026-06-14

### Dataset expansion: Elamite tradition

**Elamite layer** (`add_elamite_layer.sql`) — new tradition, 4 entities:
- Sources: `SRC_POTTS_ELAM` (Potts, *The Archaeology of Elam*, Cambridge UP 1999 — standard
  comprehensive reference), `SRC_CARTER_STOLPER_ELAM` (Carter & Stolper, *Elam: Surveys of
  Political History and Archaeology*, UC Press 1984 — classic historical survey).
- Period: `PER_ELAM_CLASSICAL` (Kingdom of Elam, −2200 to −539 BCE).
- **Inshushinak** (`ENT_ELAM_INSHUSHINAK`, conf A): "Lord of Susa"; principal deity of Susa
  and lord of the dead / divine judge; attested from Old Elamite through Neo-Elamite periods;
  Chogha Zanbil dedicated jointly to him and Napirisha; patron_of Dead;
  aligned_with ENT_MES_UTU_SHAMASH (medium — parallel judicial deity of neighboring tradition).
- **Kiririsha** (`ENT_ELAM_KIRIRISHA`, conf A): "the Great Goddess"; principal Elamite mother
  goddess; cult at Liyan (Bushehr) and Chogha Zanbil; Middle Elamite divine triad member;
  patron_of Fertility; aligned_with ENT_MES_INANNA_ISHTAR (medium);
  aligned_with ENT_ZOR_ANAHITA (low — later Iranian great goddess succession);
  spouse_of ENT_ELAM_NAPIRISHA (high — Chogha Zanbil paired temples).
- **Napirisha** (`ENT_ELAM_NAPIRISHA`, conf A): "the Great God"; supreme deity of the Middle
  Elamite / Untash-Napirisha period; Chogha Zanbil ziggurat built for him c. 1250 BCE;
  famous bronze statue c. 1340 BCE (Louvre Sb 2731); water/healing domains;
  patron_of Healing; aligned_with ENT_MES_ENKI_EA (medium — water deity parallel).
- **Humban** (`ENT_ELAM_HUMBAN`, conf A): chief deity of Old and Neo-Elamite periods;
  dominant theophoric element in Neo-Elamite royal names (Humban-Haltash, Humban-Numena,
  Humban-Undasha); cult objects deported to Nineveh by Assurbanipal after 647 BCE sacking
  of Susa; aligned_with ENT_MES_ENLIL (medium — parallel chief divine authorities of
  neighboring civilizations).

Counts: +4 entities (1,234 total), +9 relationships (2,076 total), +2 sources (143 total),
+1 tradition (76 total), 0 unresolved references.

---

## v1.14.0 — 2026-06-14

### Dataset expansion: Phrygian expansion + Luwian tradition

**Phrygian expansion** (`add_phrygian_expansion.sql`):
- **Attis** (`ENT_ATTIS`): reclassified from Greek seed stub to full Phrygian entity.
  Vegetation deity and dying-and-rising consort of Matar Kubileya; myth of self-castration
  under a pine tree (Pausanias 7.17.9-12; Arnobius *Adversus Nationes* 5.5-7; Catullus 63;
  Ovid *Fasti* 4.179-246); annual Roman festival cycle (Canna Intrat → Arbor Intrat →
  Sanguem → Hilaria); Galli priests. New relationships:
  paired_with ENT_PHRYG_MATAR (high); aligned_with ENT_DIONYSUS (medium — dying-and-rising
  parallel noted by Firmicus Maternus, *De Errore* 3.1).
- Sources: `SRC_VERMASEREN_CYBELE_ATTIS` (Vermaseren, *Cybele and Attis*, Thames & Hudson 1977),
  `SRC_TARACHA_ANATOLIA` (Taracha, *Religions of Second Millennium Anatolia*, Harrassowitz 2009).
- New period: `PER_LUW_NEO_HITTITE` (Neo-Hittite / Luwian Iron Age, −1200 to −700).

**Luwian tradition** — 1 new entity:
- **Kubaba** (`ENT_LUW_KUBABA`, conf A): city goddess of Carchemish (principal Neo-Hittite
  state, c. 1000–717 BCE); enthroned on a lion, holding pomegranate and mirror; name
  "Kubaba" → Phrygian "Kubileya" is one of the most etymologically secure deity receptions
  in Anatolian history. Completes the reception chain:
  **Kubaba → Matar Kubileya → Cybele** (ENT_CYBELE reception_of ENT_PHRYG_MATAR already
  existed; ENT_PHRYG_MATAR reception_of ENT_LUW_KUBABA is the new link).

Counts: +1 entity (1,230 total), +3 relationships (2,067 total), +2 sources (141 total),
+1 tradition (75 total, Luwian added), 0 unresolved references.

---

## v1.13.0 — 2026-06-14

### Dataset expansion: Meroitic, Iberian/Lusitanian, and Aramean traditions

**Meroitic layer** (`add_meroitic_layer.sql`) — new tradition, 5 entities:
- Sources: `SRC_TÖRÖK_MEROE` (Török, *Kingdom of Kush*, Brill 1997 — standard handbook),
  `SRC_ZABKAR_APEDEMAK` (Žabkar, *Apedemak*, Aris & Phillips 1975 — dedicated monograph).
- Period: `PER_MER_NAPATAN_MEROITIC` (Napatan–Meroitic Kingdom of Kush, −750 to 350 CE).
- **Apedemak** (`ENT_MER_APEDEMAK`, conf A): indigenous lion war god with no Egyptian counterpart;
  temples at Musawwarat es-Sufra (c. 270 BCE) and Naga (c. 1–20 CE); three iconographic forms
  including unique multi-headed variant; patron_of War; aligned_with Sekhmet and Horus.
- **Arensnuphis** (`ENT_MER_ARENSNUPHIS`, conf A): "Good Companion"; explicitly syncretized with
  Anhur/Onuris in Greek dedications at Philae ("Arensnuphis Onuphris"); syncretized_with ENT_EGY_ANHUR.
- **Mandulis** (`ENT_MER_MANDULIS`, conf A): solar deity of Lower Nubia at Kalabsha (Talmis);
  ~30 Greek votive inscriptions including the Isidoros Hymn; aligned_with Ra and Horus.
- **Sebiumeker** (`ENT_MER_SEBIUMEKER`, conf B): indigenous creator deity at Musawwarat es-Sufra;
  human-form (no Egyptian equivalent); patron_of Fertility.
- **Amesemi** (`ENT_MER_AMESEMI`, conf B): Meroitic goddess, Apedemak's consort; hawk-crown
  iconography; spouse_of Apedemak; aligned_with Isis.

**Iberian/Lusitanian layer** (`add_iberian_layer.sql`) — new tradition, 5 entities:
- Sources: `SRC_BLÁZQUEZ_RELIGIONES` (Blázquez, *Religiones primitivas de Hispania*, CSIC 1962 —
  foundational epigraphic catalogue), `SRC_OLIVARES_IBERIAN` (Olivares Pedreño, *Los dioses de
  la Hispania céltica*, Real Academia de la Historia 2002).
- Period: `PER_IB_IRON_AGE` (Pre-Roman and Roman-period Hispanian Indigenous Religion, −600 to 400 CE).
- **Endovelicus** (`ENT_IB_ENDOVELICUS`, conf A): healing/oracular deity; ~80 Latin inscriptions
  from sanctuary at São Miguel da Mota, Alandroal; incubation cult; patron_of Healing;
  aligned_with Asclepius.
- **Ataegina** (`ENT_IB_ATAEGINA`, conf A): chthonic regeneration goddess of Lusitania and
  Baetica; explicitly inscribed "Dea sancta Ataegina Turibrigensis Proserpina" at Turobriga;
  patron_of Underworld; syncretized_with ENT_ROM_PROSERPINA (high — ancient inscription).
- **Trebaruna** (`ENT_IB_TREBARUNA`, conf B): attested in Lusitanian language on Bronze Plaque of
  Arronches (c. 1st c. CE); treb- = "settlement"; territorial/oath deity; patron_of War (low).
- **Bandua** (`ENT_IB_BANDUA`, conf A): most widely distributed NW Iberian deity (~25+ inscriptions);
  PIE *bondho- "bond/obligation"; war/oath; aligned_with ENT_ROM_MARS.
- **Nabia** (`ENT_IB_NABIA`, conf A): river/mountain goddess; attested across Lusitania and
  NW Hispania; name cognate with river Navia; patron_of Fertility.

**Aramean layer** (`add_aramean_layer.sql`) — new tradition, 3 entities:
- Sources: `SRC_LUCIAN_DEA_SYRIA` (Lucian, *De Dea Syria*, c. 150 CE; trans. Attridge & Oden,
  SBL 1976 — primary text for Hierapolis cult), `SRC_LIPINSKI_ARAMEANS` (Lipiński, *The Aramaeans*,
  Peeters 2000 — comprehensive reference), `SRC_KAIZER_PALMYRA` (Kaizer, *Religious Life of
  Palmyra*, Steiner 2002 — Palmyrene inscriptional corpus).
- Period: `PER_ARA_IRON_AGE` (Aramean and Syrian Hellenistic Religion, −1100 to 650 CE).
- **Atargatis** (`ENT_ARA_ATARGATIS`, conf A): "the Syrian Goddess" of Hierapolis-Bambyce; name
  = Atar (Astarte) + Ata/Anat; sacred fish-pools, lion throne, galli priests; spread to Delos,
  Athens, Rome; reception_of ENT_CAN_ASTARTE (high); syncretized_with ENT_APHRODITE (high);
  aligned_with ENT_MES_INANNA_ISHTAR.
- **Baalshamin** (`ENT_ARA_BAALSHAMIN`, conf A): "Lord of Heaven"; Palmyrene temple (131 CE,
  destroyed by ISIL 2015); consistently rendered as Zeus in Greek-Palmyrene bilinguals;
  Dan 11:31 "abomination of desolation" = Zeus/Baalshamin; patron_of Storm;
  aligned_with ENT_ZEUS (high); aligned_with ENT_CAN_BAAL (medium).
- **Hadad of Damascus** (`ENT_ARA_HADAD_DAMASCUS`, conf A): Aramean storm deity of Aram-Damascus;
  Hadad = "thunderer" (Aramaic); Ben-Hadad / Hadadezer royal names; Tiglath-Pileser III deported
  his cult statue 732 BCE; reception_of ENT_CAN_BAAL (high); patron_of Storm.

Counts: +13 entities (1,229 total), +26 relationships (2,064 total), +7 sources (139 total),
+3 traditions (74 total), 0 unresolved references maintained throughout all three layers.

---

## v1.10.0 — 2026-06-14

### Dataset expansion: Urartian tradition

**Urartian layer** (`add_urartian_layer.sql`) — new tradition, 4 entities:
- Sources: `SRC_ZIMANSKY_URARTU` (Zimansky, *Ecology and Empire*, Oriental Institute 1985 —
  standard English-language monograph on Urartian structure and religion),
  `SRC_PIOTROVSKY_URARTU` (Piotrovsky, *Ancient Civilization of Urartu*, 1969 — based on
  excavations at Karmir Blur/Teishebaini).
- Period: `PER_URA_IRON_AGE` (Kingdom of Urartu, −860 to −590 BCE).
- **Khaldi** (`ENT_URA_KHALDI`, conf A): supreme deity and national war god; formula "By the
  greatness of Khaldi" heads every royal campaign annals inscription; cult center at Musasir
  (sacked by Sargon II 714 BCE, documented in Sargon's 8th campaign letter);
  patron_of War; aligned_with Assyrian Ashur (parallel national war deities of rival Iron Age kingdoms).
- **Teisheba** (`ENT_URA_TEISHEBA`, conf A): storm/thunder deity; linguistically cognate with
  Hurrian Teshub by regular sound change (Hurrian Teš(u)b → Urartian Teišeba — the most
  secure deity-to-deity etymology in Anatolian religion); bull iconography; city Teishebaini
  (Karmir Blur, "city of Teisheba") named for him;
  reception_of ENT_HTT_TESHUB (high); patron_of Storm; aligned_with Tarhunna.
- **Shivini** (`ENT_URA_SHIVINI`, conf A): sun deity; winged sun disk iconography shared
  with Shamash and Aten; oath-witness and divine order function; third in the triad
  Khaldi-Teisheba-Shivini mirroring Hurrian Teshub-Shaushka-Shimegi;
  aligned_with Utu/Shamash; aligned_with Hittite Sun Goddess of Arinna.
- **Arubani** (`ENT_URA_ARUBANI`, conf B): "the deity of Khaldi" in dedicatory inscriptions;
  likely Khaldi's divine consort; arts/beauty/fertility domains; probable Urartian reception
  of the Hurrian Shaushka tradition (Shaushka = Teshub's consort → Arubani = Khaldi's consort);
  spouse_of Khaldi; aligned_with ENT_HTT_SHAUSHKA.

Counts: +4 entities (1,216 total), +9 relationships (2,038 total), +2 sources (132 total),
+1 tradition (71 total), 0 unresolved references maintained.

---

## v1.9.0 — 2026-06-14

### Dataset expansion: Finnish tradition

**Finnish layer** (`add_finnish_layer.sql`) — new tradition, 7 entities:
- Sources: `SRC_KALEVALA` (Lönnrot 1849; Bosley trans. OUP 1989 — primary),
  `SRC_AGRICOLA_PRIMER` (Agricola 1551 Finnish Psalter — earliest written attestation),
  `SRC_PENTIKÄINEN_KALEVALA` (Pentikäinen, *Kalevala Mythology*, Indiana UP 1999).
- Period: `PER_FINN_TRADITIONAL` (Pre-Christian Finnish, −500 to 1300 CE).
- **Ukko** (`ENT_FINN_UKKO`, conf A): supreme thunder/sky deity; name = "old man";
  Agricola 1551 names him first among Finnish deities; Kalevala invokes him as
  "thou of gods the highest"; patron_of Storm; aligned_with Thor, Perkūnas, Perun.
- **Väinämöinen** (`ENT_FINN_VAINAMOINEN`, conf A): shaman-bard and culture hero;
  son of Ilmatar; spends 700 years in womb; greatest singer (kantele); descends to
  Tuonela (realm of the dead); departs at Kalevala's end (Runo 50);
  aligned_with Orpheus (shaman-bard parallel).
- **Ilmatar** (`ENT_FINN_ILMATAR`, conf A): air spirit and water mother; Kalevala Runo 1
  cosmogony — her floating on the primordial sea leads to the duck's egg breaking into
  the world; parent_of Väinämöinen.
- **Tapio** (`ENT_FINN_TAPIO`, conf A): lord of the forest realm Tapiola; Agricola 1551;
  hunters invoked him before entering the forest; spouse_of Mielikki.
- **Mielikki** (`ENT_FINN_MIELIKKI`, conf A): goddess of the forest and bears;
  Tapio's wife; "mistress of the woodland" (Kalevala Runo 14); patroness of the bear
  hunt; aligned_with Baltic Medeina.
- **Ahti** (`ENT_FINN_AHTI`, conf A): sea/water deity; lord of the underwater realm
  Ahtola; Agricola 1551; wife Vellamo governs water's surface; fishermen's patron.
- **Louhi** (`ENT_FINN_LOUHI`, conf A): shamanistic mistress of Pohjola (the Far North);
  primary antagonist of the Kalevala; demands the Sampo as bride-price; steals the sun
  and moon (Runo 47-49); shape-shifts into an eagle-hawk; opposes Väinämöinen.

**Totals**: 1,205 → **1,212 entities** (+7); 2,019 → **2,029 relationships** (+10);
127 → **130 sources** (+3); 69 → **70 traditions** (+Finnish); 0 unresolved references maintained.

## v1.8.0 — 2026-06-14

### Dataset expansion: Armenian tradition

**Armenian layer** (`add_armenian_layer.sql`) — new tradition, 6 entities:
- Sources: `SRC_KHORENATSI_HISTORY` (Movses Khorenatsi, *History of Armenia*, 5th c. CE;
  Thomson trans. Harvard 1978), `SRC_AGATHANGELOS_HISTORY` (Agathangelos, *History of the
  Armenians*, 5th c. CE; Thomson trans. SUNY 1976), `SRC_RUSSELL_ZOR_ARMENIA` (Russell,
  *Zoroastrianism in Armenia*, Harvard Iranian Series 5, 1987).
- Period: `PER_ARM_PAGAN` (Pre-Christian Armenian, −500 to 301 CE — Armenia adopted
  Christianity as state religion in 301 CE under Tiridates III).
- **Aramazd** (`ENT_ARM_ARAMAZD`, conf A): supreme sky-father deity; name derives from Ahura
  Mazda by regular sound change; Agathangelos §22 explicitly equates with Zeus; cult at Ani,
  Bagaran, and Ashtishat; father of Anahit, Vahagn, and Nane.
- **Anahit** (`ENT_ARM_ANAHIT`, conf A): most beloved Armenian deity; "glory of our nation and
  vivifier" (Agathangelos §22); gold statue at Erez described by Strabo; reception of Zoroastrian
  Anahita; syncretized with Artemis (primary, Agathangelos) and Aphrodite (secondary).
- **Vahagn** (`ENT_ARM_VAHAGN`, conf A): war deity and dragon-slayer; son of Aramazd; the Vahagn
  birth hymn (Khorenatsi I.31) is the oldest surviving Armenian poem, describing his birth from
  sea, fire, and sky; syncretized with Heracles (Agathangelos §22).
- **Astghik** (`ENT_ARM_ASTGHIK`, conf A): goddess of love, beauty, and water; name means "little
  star"; Vardavar water festival survives into the Christian period; syncretized with Aphrodite;
  paired with Vahagn; the place name Ashtishat ("city of Ashtart") reveals a Semitic substratum.
- **Tir** (`ENT_ARM_TIR`, conf A): scribe of Aramazd, god of writing, dreams, and wisdom; temple
  at Artashat; Agathangelos §22 equates him with both Hermes (primary) and Apollo (secondary).
- **Nane** (`ENT_ARM_NANE`, conf A): daughter of Aramazd; war and wisdom goddess; Agathangelos §22
  equates with Athena ("mother of virtues, teacher of virtue"); temple at Tiliē.

**Totals**: 1,199 → **1,205 entities** (+6); 2,004 → **2,019 relationships** (+15);
124 → **127 sources** (+3); 68 → **69 traditions** (+Armenian); 0 unresolved references maintained.

## v1.7.0 — 2026-06-14

### Dataset expansion: Thracian tradition

**Thracian layer** (`add_thracian_layer.sql`) — new tradition, 5 entities (3 reclassified + 2 new):
- Sources: `SRC_ARCHIBALD_ODRYSIAN` (Archibald, *The Odrysian Kingdom of Thrace*, 1998),
  `SRC_PLATO_REPUBLIC` (Plato, *Republic*, c. 375 BCE).
- Period: `PER_THRA_IRON_AGE` (Thracian Iron Age and Classical Period, −700 to 150 CE).
- **Sabazios** (`ENT_SABAZIOS`, reclassified Greek → Thracian, conf A): Thracian sky-thunder god
  received into Athenian mystery religion by the 5th c. BCE (Aristophanes *Wasps* 422 BCE);
  syncretized with Dionysus (Herodotus 5.7) and Zeus (Roman-period "Zeus Sabazios" votive tablets).
  Removed stale seed relationship (`member_of ENT_PHRYG_MATAR`).
- **Bendis** (`ENT_BENDIS`, reclassified Greek → Thracian, conf A): Thracian moon/hunting goddess;
  official Athenian state cult established by decree by 429 BCE; Plato opens the *Republic* (327a)
  at her Piraeus festival. Equated with Artemis (high), Selene (medium), Hecate (medium).
- **Cotys** (`ENT_COTYS`, reclassified Greek → Thracian, conf B): goddess of orgiastic mystery rites;
  the Cotytia attested in Attic comedy (Eupolis fr. 85), Aeschylus *Edoni* fr. 57, and Theopompus;
  equated with Rhea/Cybele in Greek interpretation.
- **Zalmoxis** (`ENT_THRA_ZALMOXIS`, new, conf A): deity/deified revealer figure of the Getae;
  Herodotus 4.94-96 (longest ancient account); Plato *Charmides* 156d-157c (soul-doctrine);
  patron of the dead and revealer of immortality to the Getae. Aligned with Orpheus (structural
  Thracian mystery parallel; Burkert 1987).
- **Gebeleizis** (`ENT_THRA_GEBELEIZIS`, new, conf B): Getae sky/thunder deity; Herodotus 4.94
  (sole attestation — Getae shoot arrows at sky to threaten him during storms); patron of Storm;
  possibly the same deity as Zalmoxis in a different aspect (Eliade 1970, vs. Archibald 1998 caution).

**Totals**: 1,197 → **1,199 entities** (+2 new); 1,997 → **2,004 relationships** (+7);
122 → **124 sources** (+2); 67 → **68 traditions** (+Thracian); 0 unresolved references maintained.

## v1.6.0 — 2026-06-14

### Dataset expansion: Moabite, Ammonite, and Edomite traditions

**Transjordanian Iron Age layer** (`add_transjordanian_layer.sql`) — 3 new traditions, 4 entities:
- Sources: `SRC_MESHA_STELE` (Mesha Stele c. 840 BCE / Dearman 1989 edition),
  `SRC_BARTLETT_EDOM` (Bartlett 1989).
- Period: `PER_TRANSJORDAN_IRON_AGE` (Iron Age Transjordanian, −1200 to −500 BCE).
- **Kemosh** (`ENT_MOA_KEMOSH`, Moabite, conf A): national deity of Moab; named 9 times
  in the Mesha Stele (c. 840 BCE); attested across 4 independent biblical books spanning
  9th–6th c. BCE. War and storm deity; goes into exile at national defeat (Jer 48).
- **Ashtar-Kemosh** (`ENT_MOA_ASHTAR_KEMOSH`, Moabite, conf B): compound warrior form
  of Kemosh attested once in the Mesha Stele ḥērem formula (line 17); conflates Kemosh
  with the warrior-Venus Ashtar tradition.
- **Milkom** (`ENT_AMM_MILKOM`, Ammonite, conf A): national deity of Ammon; "the King"
  (*mlk); attested in 1 Kgs 11, 2 Kgs 23, Jer 49, Zeph 1 and Ammonite personal names.
- **Qos** (`ENT_EDO_QOS`, Edomite, conf B): national deity of Edom; not named as deity
  in the Hebrew Bible but securely attested through Edomite onomastic inscriptions
  (7th–5th c. BCE) including the Qos-gabr theophoric name in Assyrian annals.
- Relationships: Kemosh and Milkom opposed_by Yahweh (theological polemic structure
  in Judges 11, Jeremiah); Kemosh and Milkom aligned_with each other (parallel national
  deity theology); Kemosh reception_of Baal Hadad (typological inheritance);
  Ashtar-Kemosh cult_form_of Kemosh, aligned_with Astarte.

**Totals**: 1,193 → **1,197 entities** (+4); 1,986 → **1,997 relationships** (+11);
120 → **122 sources** (+2); 0 unresolved relationship references maintained.

## v1.5.0 — 2026-06-14

### Dataset expansion: Baltic and Slavic traditions; Egyptian gap fill

**Egyptian additions** (`add_aten_amarna.sql`):
- **Aten** (`ENT_EGY_ATEN`): Amarna-period solar disk deity; one of the
  most historically significant Egyptian figures — the Akhenaten monotheistic
  revolution (c. 1353-1336 BCE). Source: new `SRC_MURNANE_AMARNA` (Murnane 1995
  critical edition of the Great Hymn to the Aten and Amarna boundary stelae).
  Relationships: cult_form_of Ra, identified_with Ra-Horakhty, opposes Amun.
- **Anhur** (`ENT_EGY_ANHUR`): hunting and war deity of Thinis; attested from
  the Pyramid Texts; identified with Shu in the New Kingdom; received as
  Onuris/Ares by the Greeks. Relationships: identified_with Shu, reception_of Ra.
- Total Egyptian tradition: 89 → **91 entities**.

**Baltic tradition** (`add_baltic_layer.sql`) — new tradition, 0 → **10 entities**:
- Sources: `SRC_GIMBUTAS_BALTS` (Gimbutas 1963), `SRC_GREIMAS_LITHUANIAN` (Greimas 1992).
- Period: `PER_BALT_PAGAN` (Baltic Pre-Christian Period, −2000 to 1400 CE).
- Entities: Dievas (sky god, PIE *Dyēus), Perkūnas (thunder, cognate with Thor/Parjanya),
  Velnias (chthonic/cattle/dead), Laima (fate), Saulė (sun goddess, feminine),
  Meness (moon deity, masculine), Gabija (hearth fire), Žemyna (earth),
  Medeina (forest), Ragana (witch-spirit, conf B).
- Key relationships: Perkūnas opposes Velnias (the core Baltic cosmic myth),
  Saulė paired_with Meness, Perkūnas judges Meness, Dievas aligned_with Zeus,
  Perkūnas aligned_with Thor, Gabija embodies Fire, Žemyna embodies Earth.

**Slavic tradition** (`add_slavic_layer.sql`) — new tradition, 0 → **9 entities**:
- Sources: `SRC_PRIMARY_CHRONICLE_PVL` (Nestor's Primary Chronicle, c. 1113 CE),
  `SRC_BRUCKNER_SLAVIC_MYTH` (Brückner 1918).
- Period: `PER_SLAV_PAGAN` (Slavic Pre-Christian Period, −500 to 1100 CE).
- Kiev Pantheon (AD 980 PVL entry, conf A): Perun (thunder), Mokosh (earth/fate),
  Dažbog (solar), Stribog (wind), Simargl (guardian, conf B), Khors (solar/Iranian, conf B).
- Additional attested: Veles (chthonic/cattle; oath treaties AD 945, 971),
  Svarog (fire/sky; Hypatian Chronicle Malalas gloss), Rod (ancestral fate; conf B).
- Key relationships: Perun opposes Veles (core Slavic cosmic myth), Svarog parent_of
  Dažbog, Perun aligned_with Perkūnas, Perun aligned_with Thor, Veles aligned_with
  Velnias, Mokosh aligned_with Laima, Perun embodies Storm.

**Totals**: 1,172 → **1,193 entities** (+21); 1,961 → **1,986 relationships** (+25);
115 → **120 sources** (+5); 0 unresolved relationship references maintained.

## v1.4.0 — 2026-06-13

### Visualizations

- **Entity browser** (`/explore`): client-side searchable grid of all 1,172 entities.
  Filter by tradition (62 options), search by name/type/domain, sort by relationship
  count or alphabetically. Clicking any card opens a slide-in detail panel with
  metadata and all relationships grouped by type.

- **Relationship graph** (`/graph`): D3 v7 force-directed graph. Autocomplete search
  launches any entity as the root node; clicking any node expands its 1-hop
  neighbourhood; nodes coloured by tradition. Supports pan/zoom and Fit-to-screen.
  Graph state is additive — each click extends without resetting the layout.

### Bug fixes

- **CSS `[hidden]` / `display` cascade** (three separate sites): our global
  `[hidden] { display: none !important }` rule prevented `element.hidden = false`
  from un-hiding elements whose CSS carried an explicit `display` value
  (`display: block` on `#gp-svg`, `display: grid` on `.explore-grid`,
  `display: flex` on `.ex-overlay`). Fixed by switching those show/hide calls to
  `element.style.display` which takes precedence over the cascade.

- **Autocomplete filter**: `canonical_name__icontains` is silently ignored in
  Datasette 0.65.2 (returns all rows); changed to `canonical_name__contains`.

## v1.3.0 — 2026-06-13

### Relationship graph completion — 0 zero-rel entities

Systematic expansion connecting every entity in the database to the relationship
graph. Result: **0 zero-rel entities** across all 1,172 entities; **1,961 total
relationships** (+609 from v1.2.0 baseline of 1,352).

- **expand_greek_relationships_v2.sql** (+68 rels): Greek abstraction parent chains
  (Eris→10 Strife children, Theogony 226-232; Nyx→Apate/Philotes/Momos, Theogony
  211-225); 14 embodies edges (Dikaiosyne/Nomos→Justice, Hysminai/Machai→War, etc.);
  primordials (Chaos→Erebus/Nyx, Theogony 116-120; Gaia→Ourea/Pontus, Theogony
  129-132); hero relationships (Aphrodite→Aeneas; Athena protects Odysseus/Cecrops;
  Hector slays Protesilaus, Epitome 3.30). Greek zero-rel: 294→240.

- **expand_greek_aquatic_v1.sql** (+101 rels): All river deities (Potamoi)
  with Oceanus parent chains from Theogony 337-345; 18 named Nereids; 12 named
  Oceanids; sea deities (Nereus, Thaumas, Phorcys, Eurybia from Theogony 233-239);
  Ino→Leucothea and Melicertes→Palaemon reception chains; Scamander opposes Achilles
  (Iliad 21). Greek zero-rel: 240→24 (aquatic cluster cleared).

- **expand_greek_relationships_v3.sql** (+90 rels): Oracle figures (Apollo
  patron_of Cassandra/Tiresias/Calchas/Amphiaraus; Phoebe reveals to Apollo at
  Delphi, Aeschylus Eumenides 1-19); Nyx additional children (Morpheus, Phobetor,
  Phantasos, Hesperides, Nosoi); Dionysian cluster (Dionysus patron_of Maenads/
  Thyiads/Satyrs/Silenus; Rhea patron_of Korybantes/Kouretes, Theogony 477-484);
  underworld batch (Plouton/Hades rules+dwells_in; Brimo; Melinoe; Ascalaphus);
  myth pairs (Eos/Tithonus, Dionysus/Ariadne Theogony 947-949, Pan/Syrinx,
  Aphrodite/Psyche). Greek zero-rel: 240→97.

- **expand_egyptian_v1.sql** (+31 rels): Horus forms (Harsiese, Haroeris, Harakhty,
  Harsomtus as reception_of Horus); ram deities (Heryshaf, Banebdjedet); Ogdoad
  primordials (Tenemu/Tenemut member_of Ogdoad); necropolis/birth cluster
  (Meretseger, Neferhotep, Meskhenet, Shai); Pakhet reception_of Sekhmet; Wosret
  received_as Mut. Egyptian zero-rel: 16→0.

- **expand_hittite_scythian_v1.sql** (+17 rels): Hittite: Arinna paired_with
  Tarhunna (Hoffner, Hittite Myths), equated_with Hepat, patron_of Sovereignty;
  Hannahanna guides Telipinu. Hittite/Hurrian: Alalu in Kumarbi Cycle (Song of
  Kumarbi). Scythian: all four Herodotus 4.59-62 equations (Artimpasa=Aphrodite,
  Oetosyrus=Apollo, Sword Ares=Ares, Thagimasadas=Poseidon). Both traditions: 0.

- **expand_misc_zero_rel_v1.sql** (+12 rels): Cross-traditional virtue pair
  (Generosity/Poverty); Francis patron_of Poverty; Nicholas patron_of Generosity;
  Quirinus patron_of Sovereignty, paired_with Mars, reception_of Mars (Ovid Fasti
  2.475-512); Valentinian Ennoia paired_with Bythos+Sige, emanates_from Bythos.

- **expand_greek_relationships_v4.sql** (+108 rels): Full sweep of 97 remaining
  Greek zero-rel entities across 15 thematic sections: abstraction pairs/oppositions
  (Aidos/Nemesis Works & Days 197-200; Hybris/Sophrosyne; Arete/Kakia Xenophon Mem.
  2.1; Poine/Penia/Poros Plato Symp. 203b; Dolos from Nyx via Hyginus Fab. pref.;
  Lyssa from Nyx via Eur. Heracles 822-873); Erinyes cluster (Alastor, Poinai);
  Corycian nymphs (Paus. 10.32.2); Hecate retinue (Lamia, Gello, Mormo, Empusa,
  Empousa, Mormolykeia); Eros Primordial (Chaos parent, Theogony 120; equated_with
  Phanes); Gaia→Meliae (Theogony 187); all underworld spirits (Cocytus/Phlegethon,
  Lampades, Melinoe, Minthe, Orphne, Gorgyra, Leuce, Eurynomos); war daimons
  (Alala, Homados, Pallas); all remaining Oceanids (Peitho, Perseis, Pleione, Neda);
  Naiad sub-collectives (Crenaiae, Heleionomai, Limnades, Pegaeae, Potameides);
  Bendis, Cotys, Dactyls cluster; nymphs (Adrasteia, Amaltheia, Beroe, Chelone).

- **expand_greek_relationships_v4b.sql** (+11 rels): Final 7 Greek zero-rel:
  Amechania/Penia, Epiphron/Sophrosyne, Praxis/Techne, Thrasos/Hybris+Aidos;
  Eurynome Primordial+Ophion (Apollonius Argonautica 1.503-511, Pelasgian rulers);
  Thesis/Phanes (Orphic). Greek zero-rel: 0.

- **expand_syncretic_zero_rel_v1.sql** (+17 rels): Clears all remaining 10 entities
  across syncretic traditions — Greek/Anatolian (Corybantes/Rhea), Greek/Phrygian
  (Marsyas vs Apollo, Apollodorus 1.4.2), Greek/Phrygian/Cretan (Dactyls/Rhea),
  Greek/Rhodian (Telchines/Poseidon), Greek/Roman (Sibyl/Apollo Ovid Met. 14.130;
  Telesphorus/Asclepius; Trivia reception_of Hecate Ovid Met. 7.177), South Arabian
  (ʿAmm equated_with Sin; Shams equated_with Utu/Shamash), Thelemic (Hadit paired_with
  Nuit + Ra-Hoor-Khuit, Liber AL vel Legis). Total zero-rel: 0.

---

## Public Web Explorer — 2026-06-13

Launched a public read-only Datasette explorer at https://deitydb-explorer.fly.dev/

### Infrastructure
- `scripts/export_sqlite.sh` — exports PostgreSQL → SQLite via db-to-sqlite; materializes 10 public views as tables for Datasette compatibility
- `Dockerfile` — Python 3.12-slim, Datasette pinned to 0.65.2 (1.0+ removed the `/database/query-name` URL route); non-root `datasette` user
- `fly.toml` — Fly.io deployment, scale-to-zero, 256 MB, `iad` region
- `metadata.yaml` — 16 canned queries under the `queries:` key (Datasette 0.65.2 uses `queries:`, not `canned_queries:`)
- `.github/workflows/fly-deploy.yml` — manual dispatch workflow (SQLite is not committed; deploys require a local export first)

### Security hardening
- `plugins/security_headers.py` — ASGI wrapper injecting `x-content-type-options`, `x-frame-options`, `referrer-policy`, `permissions-policy` on every response
- SQL execution limits: `sql_time_limit_ms=2000`, `max_returned_rows=1000`

### Custom UI
- `templates/base.html` — custom Datasette base template with site-wide sticky nav (replaces default breadcrumb nav on all pages including built-in query/table result pages)
- `templates/_site_nav.html` — DeityDB brand, Explore / About / Contribute / GitHub links, active-state highlighting, mobile hamburger menu
- `templates/index.html` — homepage: Blake's *Ancient of Days* art hero, stat strip, 12 query cards in two grids, JS-loaded tradition grid, about strip
- `templates/database.html` — query explorer: 5 organized sections (Browse, Entity Explorer, Cross-Tradition, Browse by Type, Reference), collapsible raw tables, custom SQL editor
- `templates/about.html` — project About page: description, design-principle cards, tradition coverage, citation format, tech stack; Flammarion engraving + Raphael *School of Athens* art
- `templates/contribute.html` — Contribute page: 6 pathway cards, data standards, 4-step getting-started guide; Paradise Lost frontispiece art
- `plugins/custom_pages.py` — `register_routes` hook serving `/about` and `/contribute`
- `static/deitydb.css` — navy/gold/cream design system, art hero with dark overlay, responsive at 700px and 860px

### Canned queries (all at `/deitydb/<name>`)
tradition-overview, browse-tradition, browse-category, entity-relationships, reception-chain, divine-genealogies, cross-traditional-parallels, most-connected, underworld-entities, adversarial-beings, angelic-beings, revealer-figures, wisdom-knowledge, serpent-dragon, source-bibliography, relationship-vocabulary

---

## v1.2.0

### New tradition layers: Etruscan (12 entities; Pyrgi tablets, Piacenza liver), Scythian (7 entities; Herodotus 4.59–62), Phrygian (Matar Kubileya; Agdistis)
### Celtic/Gaulish expansion: Lugus, Rosmerta, Maponos, Matres (11 total Gaulish entities; Lucan as primary Latin attestation for Esus/Teutates/Taranis)
### Welsh internal relationships: 26 typed relationships from the Four Branches of the Mabinogi (was 2)
### Greek periodization: 466/466 entities (3% → 100%); bulk Archaic + targeted Classical/Hellenistic/Roman
### Roman primary sourcing: Virgil Aeneid, Livy AUC, Cicero De Natura Deorum, Varro Antiquitates
### Pre-release cleanup: ENT_ISL_MUSA + ENT_ISL_ILYAS added; 0 associated_with remaining; Tinia→Voltumna removed

#### Greek periodization completion (add_greek_period_assignments.sql)
- **Problem addressed**: 466 Greek entities at 3% period coverage (15/466 assigned)
- Bulk assignment strategy: PER_GRK_ARCHAIC baseline (Homer/Hesiod); PER_GRK_CLASSICAL for tragedy/philosophical figures; PER_GRK_HELLENISTIC for genuinely later entities; PER_GRK_ROMAN for Glycon (Lucian 2nd c. CE)
- Coverage by cluster: protogenoi (29), titans (24), daimones/personifications (71), heroes (39), river gods (39), nymph collectives (19), nereids (19), individual nymphs (11), oceanids (10), muses (9), and ~177 in smaller clusters
- Classical additions: Erinyes (Aeschylus Oresteia), Eros (Plato Symposium), Medea/Ajax/Orestes (Euripides/Sophocles), Pan (Herodotus post-Marathon), Bendis (Plato Republic), Sabazios (Aristophanes)
- Hellenistic additions: Tyche as city-fortune goddess, Agathos Daimon (Ptolemaic), Melinoe (Orphic Hymns), Great Gods of Samothrace, Hermaphroditus, Priapus
- Result: 466/466 Greek entities periodized (100%); 0 unresolved relationships

#### Welsh internal relationships (add_welsh_internal_relationships.sql)
- **Problem addressed**: 15 Welsh entities had only 2 relationships (the two reception chains added in the original Mabinogion layer)
- Added 26 typed relationships explicitly attested in the Four Branches of the Mabinogi (SRC_MABINOGION):
  - Arawn and Gwyn ap Nudd: rules/dwells_in ENT_WEL_ANNWN
  - Pwyll ↔ Rhiannon: spouse_of (Branch 1); Manawydan ↔ Rhiannon: spouse_of (Branch 3)
  - Pwyll and Rhiannon → parent_of → Pryderi
  - Bran ↔ Branwen, Bran ↔ Manawydan, Branwen ↔ Manawydan: sibling_of (Branch 2)
  - Dôn → parent_of → Gwydion and Aranrhod; Gwydion ↔ Aranrhod: sibling_of (Branch 4)
  - Aranrhod → parent_of → Lleu Llaw Gyffes (the three tyngedau narrative)
  - Math and Gwydion: creator_of Blodeuwedd; Lleu ↔ Blodeuwedd: spouse_of
  - Math → teaches → Gwydion
- Welsh entities now have 28 total relationships (was 2)

#### Etruscan tradition layer (add_etruscan_layer.sql)
- New tradition: Etruscan (0 entities previously)
- Added 3 sources: SRC_PYRGI_TABLETS (c. -500, bilingual Etruscan/Phoenician; equates Uni with Astarte), SRC_PIACENZA_LIVER (c. -100, bronze haruspicy model), SRC_DEGRUMMOND_ETRUSCAN (De Grummond 2006)
- Added 3 periods: PER_ETR_ARCHAIC (-700 to -480), PER_ETR_CLASSICAL (-480 to -300), PER_ETR_LATE (-300 to -89)
- Added 12 entities: Tinia (Jupiter), Uni (Juno; Pyrgi tablets), Menrva (Minerva), Charun (underworld coercive escort), Tuchulcha (Tomba dell'Orco demon), Voltumna (Etruscan League deity), Lasa (winged attendant spirits), Thesan (dawn), Turan (love), Nethuns (sea), Fufluns (Dionysus), Usil (sun)
- 7 relationships: Tinia-Uni spouse_of; syncretized_with: Jupiter↔Tinia, Juno↔Uni, Minerva↔Menrva (Capitoline triad as Etruscan import); Lasa member_of Turan

#### Roman primary sources (add_roman_primary_sources.sql)
- **Problem addressed**: All 22 Roman entities had only secondary sources (OCD, Beard, Ovid Fasti)
- Added 4 primary sources: SRC_VIRGIL_AENEID, SRC_LIVY_AUC, SRC_CICERO_DE_NATURA, SRC_VARRO_ANTIQ
- 60 entity_source rows with passage-level notes:
  - Virgil Aeneid: Juno as primary antagonist (1.4-7), Penates Trojan origin (2.293-295), Shield of Aeneas/Vulcan (8.370-625), Gates of Janus (7.607-615), Saturn's golden age Latium (8.319-327)
  - Livy AUC: Quirinus apotheosis (1.16.3), Janus gates (1.19.2), Vestal institution (1.20.3), Mars as Romulus's father (1.4.1), Ceres temple 493 BCE (2.41.8)
  - Cicero DND: philosophical treatment of all 22 deities; Stoic allegorizations; etymology Ceres < gero, Mercury < reason/speech, Janus = uniquely Roman doorway deity without Greek parallel
  - Varro Antiquitates (via Augustine): Lares as souls of dead (7.6), Genius taxonomy (7.13), Vesta-as-earth (7.16), Penates vs. di selecti (7.5)
- All 22 Roman entities now have 5-7 sources (up from 3)

#### Celtic/Gaulish expansion (add_celtic_gaulish_expansion.sql)
- Added 4 sources: SRC_LUCAN_BELLUM_CIVILE (1.444-446 naming Esus/Teutates/Taranis), SRC_DELAMARRE_GAULISH (linguistic dictionary), SRC_DUVAL_DIEUX_GAULE (Duval 1976), SRC_OLMSTED_GODS_CELTS (comparative Indo-European)
- Added 4 Gaulish entities:
  ENT_CEL_LUGUS (~50 inscription attestations; pan-Celtic many-skilled deity; Lugdunum place names; Caesar's Mercurius equation; source of Irish Lugh, Welsh Lleu)
  ENT_CEL_ROSMERTA (~20 Roman-period dedications; "Good Provider" sovereignty goddess; paired with Mercury)
  ENT_CEL_MAPONOS ("Divine Son"; Chamalieres defixio + British Apollo inscriptions; Welsh Mabon cognate)
  ENT_CEL_MATRES (1000+ votive inscriptions; triple seated mothers; most epigraphically attested Celtic deity category)
- 34 entity_source rows; Esus/Teutates/Taranis now linked to Lucan as primary Latin attestation
- Gaulish entities now have 3-5 sources (up from 1); 11 total Gaulish entities (up from 7)
- Reception chains: Lugh reception_of Lugus (high); Lleu reception_of Lugus (medium)

#### Scythian religion layer (add_scythian_layer.sql)
- New tradition: Scythian (0 entities previously)
- Source: SRC_HERODOTUS_HISTORIES already registered; added SRC_CUNLIFFE_SCYTHIANS (OUP 2019)
- Period: PER_SCYTH_ARCHAIC (-700 to -300)
- Added 7 entities from Herodotus Histories 4.59-62 (the only sustained ancient account of Scythian divine names):
  ENT_SCYTH_TABITI (= Hestia; supreme deity; fire-cult), ENT_SCYTH_PAPAEUS (= Zeus; sky-father),
  ENT_SCYTH_API (= Gaia; earth-mother; wife of Papaeus), ENT_SCYTH_OETOSYRUS (= Apollo; sun deity),
  ENT_SCYTH_ARTIMPASA (= Aphrodite Urania; moon/love; Enarees transvestite priests, Hdt. 4.67),
  ENT_SCYTH_THAGIMASADAS (= Poseidon; sea; Royal Scythians only),
  ENT_SCYTH_SWORD_ARES (war cult of the iron sword/akinakes; only Scythian deity with built altar; Hdt. 4.62)
- Relationships: equated_with (Tabiti↔Hestia, Papaeus↔Zeus, Api↔Gaia); spouse_of Papaeus↔Api

#### Phrygian tradition layer (add_phrygian_layer.sql)
- New tradition: Phrygian (ENT_CYBELE and ENT_ATTIS previously in DB as tradition='Greek')
- Added 2 sources: SRC_ROLLER_CYBELE (Roller 1999, U. California Press — standard monograph), SRC_PHRYGIAN_INSCRIPTIONS (Brixhe/Lejeune corpus)
- Period: PER_PHRYG_IRON_AGE (-1200 to -300)
- Added 2 entities:
  ENT_PHRYG_MATAR ("Matar Kubileya" — pre-Hellenic Mountain Mother; rock-cut shrine dedications at Midas City 8th c. BCE; the Anatolian original of Greek/Roman Cybele)
  ENT_PHRYG_AGDISTIS (hermaphroditic primordial deity; Pessinuntine myth; Pausanias 7.17.10-12; origin point of the Cybele-Attis complex)
- Reception chains: ENT_CYBELE reception_of ENT_PHRYG_MATAR (high); ENT_CYBELE and ENT_ATTIS emanates_from ENT_PHRYG_AGDISTIS
- Also linked SRC_ROLLER_CYBELE to ENT_CYBELE, ENT_ATTIS, ENT_SABAZIOS (Greek-tradition entities now cross-linked to Phrygian scholarship)

#### Pre-release cleanup (pre_release_cleanup.sql)
- Removed speculative ENT_ETR_TINIA → rules → ENT_ETR_VOLTUMNA (not directly attested; Voltumna was an independent Etruscan League deity)
- Retyped 3 remaining associated_with edges → paired_with:
  - ENT_EGY_OSIRIS ↔ ENT_EGY_HAPY_NILE: Nile fertility pair; Pyramid Texts Utterance 442
  - ENT_EGY_SIA ↔ ENT_EGY_THOTH: paired cognitive deities on the solar barque; Book of the Dead ch. 17
  - ENT_THEURGY ↔ ENT_MAGIC: overlapping late-antique ritual categories; Iamblichus De Mysteriis I.1-2
- Added ENT_ISL_MUSA (Musa/Moses; Quran 2:51-61, 7:103-162, 20:9-98, 28:3-43; 136 Quranic mentions across 36 suras)
- Added ENT_ISL_ILYAS (Ilyas/Elijah; Quran 6:85, 37:123-132; Baal-worship confrontation parallel to 1 Kings 18)
- Reception chains: ENT_ISL_MUSA reception_of ENT_ISR_MOSES (high); ENT_ISL_ILYAS reception_of ENT_ISR_ELIJAH (high)
- 0 associated_with remaining | 0 unresolved relationships

#### Release metrics — v1.2.0
- 1170 entities | 1352 relationships | 114 sources | 0 associated_with | 0 unresolved
- New traditions added this release: Etruscan, Scythian, Phrygian
- Greek tradition: 466/466 entities periodized (100%); was 15/466 (3%) at start of release
- Welsh tradition: 28 relationships (was 2); all Four Branches of the Mabinogi mapped
- Roman tradition: all 22 entities have primary-source coverage (Virgil, Livy, Cicero, Varro)
- Gaulish tradition: 11 entities, 4 new sources; Esus/Teutates/Taranis have Lucan as primary attestation
- Islamic tradition: ENT_ISL_MUSA and ENT_ISL_ILYAS complete the Islamic prophet corpus

## v1.1.0

### New tradition layers: Hittite/Hurrian, Phoenician Iron Age, Pre-Islamic Arabian, South Arabian/Sabaean, Welsh (Mabinogion)
### Systematic reception chains: Mesopotamian → Greek; Egyptian → Hellenistic/Christian; Islamic; Patristic demonization; Zoroastrian → Israelite; Jewish Mystical
### Foundational expansion: Canaanite, Hittite, South Arabian, Mesopotamian; Greek primary sources (Homer, Apollodorus, Pausanias, Homeric Hymns, Hesiod)
### Egyptian tradition audit and remediation (0 unperiodized Egyptian entities; Pyramid Texts sourcing for 34 entities)
### Mycenaean / Linear B religion layer (Bronze Age Greek substrate)
### Temporal/diachronic layer: period_id column on entity_relationships; 26 periods; received_as / reception_of relationship types
### Sourcing campaign complete: 577 previously unsourced entities → 0; aligned_with eliminated (51 edges retyped)

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

#### Egyptian audit remediation (audit_egyptian_remediation.sql)
- Added source SRC_FAULKNER_PYRAMID_TEXTS (R.O. Faulkner, OUP 1969; c. 2375-2181 BCE;
  oldest religious corpus in the world; primary attestation for all Old Kingdom period assignments)
- **Critical structural fix**: Atum → parent_of → Shu and Atum → parent_of → Tefnut (both high;
  PT Utterance 600); the Ennead genealogy was fully mapped but its apex was unrooted
- **Divine triad links**:
  Theban Triad: Amun ↔ Mut (spouse_of); Amun → parent_of → Khonsu; Mut → parent_of → Khonsu
  Memphis Triad: Ptah ↔ Sekhmet (spouse_of); both were absent despite Sekhmet being member_of Ptah
- **4 new entities** (older strata gaps):
  ENT_EGY_WOSRET (Old Kingdom; "the Powerful One"; Pyramid Texts; Senusret name etymology; Mut precursor),
  ENT_EGY_IAH (Old Kingdom; primary lunar deity in Pyramid Texts; predates Khonsu's prominence),
  ENT_EGY_MESKHENET (Middle Kingdom; birth brick goddess; Papyrus Westcar; fate at birth and judgment),
  ENT_EGY_PAKHET (Middle Kingdom; "She Who Scratches"; Speos Artemidos; later equated with Artemis)
- **Bulk period assignments** (43 rows):
  Predynastic/Early Dynastic: Horus (Narmer Palette c. 3100 BCE), Seth, Neith, Wadjet, Nekhbet,
  Min (Coptos colossi; among oldest Egyptian art), Wepwawet, Seshat
  Old Kingdom (Pyramid Texts c. 2375 BCE): Atum, Shu, Tefnut, Geb, Nut, Isis, Nephthys,
  Hathor, Ptah, Thoth (corrected from Middle Kingdom only), Bastet, Sekhmet, Sobek, Khnum,
  Khepri, Khonsu, Montu, Heket, Serqet, Sopdu, Seker, Aker, Duat, Sia, Hu, Hapy, Nefertem, Tatenen
  Middle Kingdom: Mut, Renenutet; New Kingdom: Bes, Taweret, Meretseger, Amun-Ra, Ra-Horakhty
  Period coverage: 12 → 75 Egyptian entities assigned (21 remaining: Horus-forms, canopic jar
  gods, Ogdoad collective, minor deities)
- **3 reception chains** (6 rows; all Herodotus-explicit):
  ENT_EGY_NEITH → received_as → ENT_ATHENA (high): Histories 2.28, 2.59 explicit; Sais = Athena's city
  ENT_EGY_PTAH → received_as → ENT_HEPHAESTUS (high): Histories 3.37 explicit; Memphis = "Hephaestia"
  ENT_EGY_MIN → received_as → ENT_PAN (high): Histories 2.46 explicit; Akhmim → Panopolis
- Result: 1125 entities, 1281 relationships, 95 sources, 0 unresolved

#### Mycenaean / Linear B religion (add_mycenaean_linear_b_layer.sql)
- Added 2 sources: SRC_VENTRIS_CHADWICK (Documents in Mycenaean Greek, CUP 1973; primary Linear B reference),
  SRC_BURKERT_GREEK_RELIGION (Burkert, Greek Religion, Harvard 1985; standard secondary)
- Added 3 Mycenaean entities:
  ENT_MYC_POTNIA (po-ti-ni-ja; "the Mistress"; most-attested Mycenaean deity; unqualified great goddess
  who appears also as Athana Potnia, Potnia of the Labyrinth, etc.; substrate for multiple Classical goddesses),
  ENT_MYC_DIWIA (di-u-ja at Pylos; feminine form of Zeus; corresponds to Classical Dione at Dodona),
  ENT_MYC_ENYALIOS (e-nu-wa-ri-jo; independent war deity; appears SEPARATELY from Ares on PY Tn 316;
  later absorbed into Ares as an epithet in the Classical period)
- Assigned PER_GRK_MYCENAEAN to 7 Olympians with secure Linear B attestation:
  Zeus (di-we), Poseidon (po-se-da-o; more prominent than Zeus at Pylos), Hermes (e-ma-a),
  Dionysus (di-wo-nu-so; overturns "late import" theory), Hera (e-ra), Athena (a-ta-na po-ti-ni-ja), Ares (a-re)
- Apollo explicitly excluded: ABSENT from all Linear B tablets — most significant negative finding
- Added 3 reception chains (6 rows):
  - ENT_MYC_POTNIA → received_as → ENT_ATHENA (high): KN V 52 "Athana Potnia" is Athena's earliest attestation;
    she originates within the Mycenaean Potnia tradition
  - ENT_MYC_DIWIA → received_as → ENT_DIONE (medium): identical name derivation (feminine of Zeus);
    Dodona cult preserves her older independent goddess status
  - ENT_MYC_ENYALIOS → received_as → ENT_ARES (medium): PY Tn 316 proves they were distinct Mycenaean
    deities; post-Dark-Age consolidation merged them
- Result: 1121 entities, 1265 relationships, 94 sources, 0 unresolved

#### Israelite patriarchs and prophets (add_israelite_patriarchs_prophets.sql)
- Added source SRC_HEBREW_BIBLE (Masoretic Text / BHS-BHQ; first explicit Israelite primary text source)
- Patched ENT_ISR_SOLOMON stub: added entity_type ("King / Wisdom figure"), evidence_confidence A,
  short_note, and SRC_HEBREW_BIBLE source link
- Added 4 entities:
  ENT_ISR_NOAH (flood patriarch; Genesis 6-9; Ezekiel 14:14; 1 Enoch 106-107),
  ENT_ISR_ADAM (first human; tselem elohim Genesis 1:26-27; J source Genesis 2-3),
  ENT_ISR_ELIJAH (9th c. BCE; 1 Kings 17-19; 2 Kings 2:11 fiery ascent; Malachi 4:5 eschatological return),
  ENT_ISR_MOSES (Exodus 2–Deuteronomy 34; face-to-face with Yahweh; paradigm lawgiver)
- Added 5 reception chain pairs (10 rows):
  - ENT_MES_UTNAPISHTIM → received_as → ENT_ISR_NOAH (high, PER_ISR_EXILIC):
    highest-confidence cross-traditional narrative transmission; deferred since
    add_mesopotamian_expansion.sql; now activated; George (2003) documents the parallels
  - ENT_ISR_ELIJAH → received_as → ENT_SAINT_JOHN_BAPTIST (high, PER_ISR_SECOND_TEMPLE):
    Matthew 11:14, 17:12 explicit; Malachi 4:5 prophetic basis; best-documented
    Hebrew Bible prophet → NT reception chain in the dataset
  - ENT_ISR_ADAM → received_as → ENT_JM_ADAM_KADMON (medium): tselem elohim →
    Lurianic primordial divine human; Scholem (1974)
  - ENT_ISR_ADAM → received_as → ENT_SET_ADAMAS (medium): critical Gnostic reception
    of Genesis 1-6 via Apocryphon of John (Nag Hammadi II,1); Meyer (2003)
- Deferred: Moses→Musa (ENT_ISL_MUSA not yet in DB) and Elijah→Ilyas (ENT_ISL_ILYAS not yet in DB)
- Result: 1118 entities, 1259 relationships, 92 sources, 0 unresolved

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

#### Greek primary source layer (add_greek_primary_sources.sql)
- **Problem addressed**: Greek tradition held 466 entities with 12 sources (38.8 entities/source);
  the top 10 sources were all Theoi.com secondary reference indexes; Homer was entirely absent
- Added 4 new primary sources (reaching 100 sources total):
  SRC_HOMER_ILIAD_ODYSSEY (Iliad c. 750 BCE + Odyssey c. 725 BCE; Lattimore/Wilson translations)
  SRC_HOMERIC_HYMNS (33 hymns, 7th-5th c. BCE; M.L. West, Loeb 2003)
  SRC_APOLLODORUS_LIBRARY (Pseudo-Apollodorus, Library/Bibliotheca, 1st-2nd c. CE; Robin Hard, OUP 2008)
  SRC_PAUSANIAS_DESCRIPTION (Pausanias, Description of Greece, c. 143-176 CE; Loeb 1918-1935)
- Homer linkages (113 entities): all 12 Olympians, Hades, Persephone, Dionysus, Hestia;
  primordials and Titans named in Homer (Gaia, Ouranos, Tartarus, Nyx, Erebus, Oceanus, Aether,
  Cronus/Kronos, Rhea, Tethys, Hyperion, Leto, Atlas, Themis, Dione, Iapetus);
  daimones active in the epics (Iris, Eris, Deimos, Phobos, Enyo, Hypnos, Thanatos, Ate, Litae,
  Moirai, Ker, Nemesis, Horkos); sea deities (Nereus, Thetis, Amphitrite, Proteus, Ino-Leucothea);
  15 Nereids from the Iliad XVIII catalog; wind gods (Boreas, Zephyrus, Notus, Eurus, Aeolus, Anemoi);
  river gods (Scamander, Acheloos); Trojan War heroes (Achilles, Odysseus, Ajax, Hector, Diomedes,
  Menelaus, Helen, Bellerophon, Heracles, Theseus, Perseus, Orestes, Protesilaus, Meleager, Machaon,
  Podalirius, Asclepius, Castor, Polydeuces, Pelops, Cadmus, Ganymede, Tiresias, Calypso)
- Homeric Hymns linkages (23 entities): specific deities addressed in individual hymns:
  Demeter (HH 2; Eleusinian Mysteries foundation myth), Apollo (HH 3; Delos + Delphi), Hermes (HH 4;
  theft of cattle + lyre invention), Aphrodite (HH 5, 6, 10), Ares (HH 8), Artemis (HH 9, 27),
  Athena (HH 11, 28; birth from Zeus's head), Hera (HH 12), Rhea/Mother of Gods (HH 14),
  Heracles (HH 15), Asclepius (HH 16), Poseidon (HH 22), Zeus (HH 23), Hestia (HH 24, 29),
  Gaia (HH 30), Helios (HH 31), Selene (HH 32), Pan (HH 19), Hephaestus (HH 20),
  Dionysus (HH 7; pirates myth), Persephone (HH 2), Python (HH 3)
- Apollodorus linkages (93 entities): comprehensive coverage of Olympians, chthonic deities,
  primordials, Titans, major heroes (Heracles full career, Perseus, Theseus, Jason/Medea,
  Achilles, Odysseus, Bellerophon, Cadmus, Orestes, Tiresias, Atalanta), monsters (Typhon, Chimera,
  Nemean Lion, Medusa, Cerberus), and underworld figures
- Pausanias linkages (29 entities): Olympians at their principal sanctuaries (Zeus at Olympia,
  Hera at Argos, Athena on the Acropolis, Apollo at Delphi, Demeter at Eleusis); hero cults
  (Heracles, Achilles, Ajax, Theseus, Protesilaus, Pelops, Orpheus, Iphigenia, Hippolytus);
  healing cult (Asclepius at Epidaurus — fullest ancient description); mystery cults
  (Demeter/Kore at Eleusis); special sanctuaries (Nemesis at Rhamnous, Hades at Elis — the
  only ancient Panhellenic temple to Hades; Pan in Arcadia and at Athens)
- Result: 16 sources for Greek tradition (up from 12); ratio 29.1 entities/source (down from 38.8);
  Homer now #3 source by entity count (113); Apollodorus #5 (93); 100 total sources milestone
- No change to entity or relationship counts: 1128 entities, 1303 relationships, 100 sources

#### Hesiod Theogony linkage pass (add_hesiod_theogony_links.sql)
- **Problem addressed**: SRC_HESIOD_THEOGONY ("Hesiod, Theogony and Works and Days") was linked
  to only 39 entities, all of them cross-traditional personified abstractions or two Greek entities
  (ENT_KRONOS and ENT_OURANOS, linked incidentally when created as chain targets in earlier scripts);
  the Olympians, all Titans, all primordials, sea deities, and Hecate had no Hesiod links
- **89 new entity_sources rows → 128 total links (was 39)**
- Organized by Theogony structure:
  - **Protogenoi / First Principles** (Theogony 116-132 + Nyx's offspring):
    Chaos, Gaia, Tartarus, Eros Primordial, Erebus, Nyx, Aether, Hemera, Pontus, Ourea, Thalassa,
    Uranus, Moros, Ker, Moirai, Selene, Helios, Eos (18 entities)
  - **Named children of Nyx** (Theogony 211-225):
    Thanatos, Hypnos, Nemesis, Eris, Dolos, Oizys, Keres (7 entities; Moirai already above)
  - **Catalog of Eris's offspring** (Theogony 226-232):
    Ponos, Limos, Algea, Hysminai, Makhai, Neikea, Amphilogiai, Pseudologoi, Dysnomia,
    Ate, Atë, Horkos (12 entities; many with no other source links)
  - **Twelve Titans** (Theogony 133-138):
    Oceanus, Coeus, Crius, Hyperion, Iapetus, Themis, Rhea, Mnemosyne, Phoebe, Tethys,
    Cronus (stub distinct from ENT_KRONOS), Theia (12 entities)
  - **Second-generation Titans and Oceanids** (Theogony 337-406, 507-616):
    Atlas, Prometheus, Epimetheus, Menoetius, Leto, Asteria, Astraeus, Perses Titan, Pallas Titan,
    Dione, Metis, Eurybia, Clymene Titaness, Styx (14 entities)
  - **Hecate** (Theogony 411-452): the most extensive individual praise passage in the entire Theogony
    (40+ lines); Hesiod is the primary ancient text for Hecate's theology (1 entity)
  - **Olympians** (Theogony 453-506, 886-1020): births and genealogies for all 15:
    Zeus, Hera, Poseidon, Demeter, Hestia, Hades, Athena (born from Zeus's head after Metis swallowed),
    Apollo, Artemis, Ares, Hephaestus (born of Hera alone — Hesiodic variant), Hermes, Aphrodite
    (sea-foam birth — Hesiodic variant vs. Homer's daughter of Zeus/Dione), Persephone, Dionysus
  - **Sea deities / children of Pontus** (Theogony 233-264):
    Nereus (with 50 Nereids named by Hesiod), Thaumas, Phorcys, Ceto, Eurybia Sea, Triton (6 entities)
  - **Works and Days**: Elpis (hope in the jar; Works and Days 94-98 is the ONLY ancient source
    naming her in this role), Aidos (leaves earth with Nemesis at the end of the Iron Age; WD 197-201)
  - **Other**: Iris (daughter of Thaumas; Theogony 265-266), Phoebe at Delphi (secondary reference
    to the Titaness Phoebe as grandmother of Apollo and holder of the Delphic oracle before him)
- Note: ENT_APHRODITE and ENT_HEPHAESTUS now have BOTH Homer and Hesiod as primary sources,
  with the two texts attesting incompatible traditions (Aphrodite: sea-born vs. daughter of Zeus/Dione;
  Hephaestus: parthenogenic/Hera alone vs. son of Zeus and Hera)
- Result: 1128 entities, 1303 relationships, 100 sources, 0 unresolved

#### Zero-link and low-link source remediation (add_source_linkage_remediation.sql)
- **Problem addressed**: Source audit found 14 registered sources with 0 or near-0 entity links;
  most traditions had primary sources in the sources table but not linked to their own entities;
  e.g. all 20 Norse entities had only Prose Edda + Simek; the older Poetic Edda was unlinked;
  all 22 Roman entities had no Ovid link; no Egyptian entity had a Pyramid Texts link except
  the 2 new entities added in the Egyptian remediation this session
- **Total new links: ~199 entity_sources rows across 14 sources and 168 distinct entities**
- **SRC_POETIC_EDDA** → 20 Germanic/Norse entities
  (Odin, Thor, Freyja, Freyr, Frigg, Baldr, Tyr, Loki, Hel, Fenrir, Jörmungandr, Níðhöggr,
  Njord, Norns, Valkyries, Aesir, Vanir, Jötnar, Dwarves, Yggdrasil);
  primary for Völuspá, Hávamál, Grímnismál, Hymiskviða, Lokasenna, Þrymskviða, Baldrs draumar,
  Skírnismál; the Poetic Edda pre-dates Snorri's Prose Edda and is more directly attested
- **SRC_OVID_FASTI** → 22 Roman entities
  (Jupiter, Juno, Mars, Venus, Saturn, Janus, Vesta, Ceres, Diana, Minerva, Neptune, Mercury,
  Pluto, Proserpina, Bacchus, Apollo, Quirinus, Vulcan, Genius, Lares, Manes, Penates);
  primary Latin source for the Roman religious calendar; especially critical for Janus (Book 1),
  Mars (Books 2-3), Venus and Ceres (Book 4), Mercury (Book 5), Juno and Vesta (Book 6)
- **SRC_PLUTARCH_ISIS_OSIRIS** → 15 Egyptian/syncretic entities
  (Osiris, Isis, Seth, Nephthys, Thoth, Anubis, Horus, Ra, Hathor, Ptah, Neith,
  Serapis, Harpocrates, Hermanubis, Zeus Ammon);
  fullest surviving Greco-Roman account of the Osirian cycle and Egyptian-Greek equations;
  primary source for the Serapis foundation myth (De Iside 28) and Harpocrates' gesture;
  Neith's famous inscription ("I am all that has been and is and shall be") is quoted here
- **SRC_FAULKNER_PYRAMID_TEXTS** → 32 additional Egyptian entities (34 total; was 2)
  (Atum, Shu, Tefnut, Geb, Nut, Osiris, Isis, Seth, Nephthys, Horus, Ra, Thoth, Anubis,
  Hathor, Ptah, Maat, Hu, Sia, Serqet, Khepri, Wepwawet, Nekhbet, Wadjet, Min, Sobek,
  Khnum, Seshat, Seker, Aker, Hapy, Montu, Duat + the 2 already linked);
  oldest surviving religious corpus (c. 2375-2181 BCE); these are the primary attestations
  for all these deities; Atum (PT 600), Osiris resurrection theology (PT 219-222), Anubis
  ("upon his mountain"), Hu and Sia in Ra's barque, Aker at the horizons
- **SRC_HERODOTUS_HISTORIES** → 11 additional entities (13 total; was 2)
  Egyptian: Osiris (= Dionysus, 2.42, 2.144), Isis (= Demeter, 2.41, 2.59),
  Horus (= Apollo, 2.144), Amun / Zeus Ammon (2.42; Siwa oracle), Thoth (= Hermes, 2.52);
  Zoroastrian: Ahura Mazda (1.131; first Greek account of Persian religion),
  Anahita (1.131; as Aphrodite Ourania);
  Arabian: Al-Uzza (3.8; "Alilat" = Aphrodite Ourania);
  Cross-traditional: Heracles (2.44; distinguished from Phoenician Melqart),
  Dionysus (2.49; traced to Egypt / Osiris), Zeus Ammon already counted
- **SRC_FOSTER_BEFORE_MUSES** → 13 Mesopotamian entities
  (Marduk, Tiamat, Apsu, Kingu, Nabu, Ashur, Ereshkigal, Inanna/Ishtar, Nergal, Enki/Ea,
  Enlil, Adad/Ishkur, Lamashtu);
  Akkadian literary corpus: Enuma Elish (tablets I-VII), Descent of Ishtar, Nergal and
  Ereshkigal, Atrahasis Epic, Adapa, Erra and Ishum, Lamashtu incantation texts;
  fills the gap created by adding SRC_FOSTER_BEFORE_MUSES in the Mesopotamian remediation
  without linking any entities to it at that time
- **SRC_BURKERT_ORIENT_REV** → 13 entities across traditions
  (Inanna/Ishtar, Aphrodite, Kronos, Zeus, Typhon, Kumarbi, Teshub, Ullikummi,
  Gilgamesh, Heracles, Enki/Ea, Prometheus, Adonis);
  primary scholarly source for Near Eastern → Greek transmission in the Orientalizing period
  (8th-6th c. BCE); documents the Inanna→Aphrodite, Kumarbi→Kronos, and Gilgamesh→Heracles
  parallels; used in relationship-chain rationales throughout but not previously linked as entity_sources
- **SRC_BUNDAHISHN** → 16 Zoroastrian entities (complete tradition coverage)
  (Ahura Mazda, Angra Mainyu, all 6 Amesha Spentas, Mithra, Anahita, Sraosha, Atar,
  Daevas, Aeshma Daeva, Fravashis);
  Pahlavi cosmological text (c. 9th c. CE) that is the most systematic ancient account
  of Zoroastrian cosmogony; supplements the Avesta with cosmological detail absent from
  the liturgical corpus
- **SRC_MANDAEAN_BOOK_JOHN** → 15 Mandaean entities (complete tradition coverage)
  (Hayyi Rabbi, Manda d-Hayyi, John the Baptist, Hibil Ziwa, Ruha, Ptahil, Abathur,
  Anosh, Sitil, Yushamin, Melka d-Nhura, Mana Rabba, Ur, Jordan, Planets);
  Draşa d-Yahya; primary Mandaean liturgical text alongside the Ginza Rba (already linked);
  central text for the Mandaean John the Baptist tradition
- **SRC_MANICHAEAN_PSALM_BOOK** → 15 Manichaean entities (complete tradition coverage)
  (Father of Greatness, Mother of Life, Primal Man, Five Sons, Living Spirit, Great Builder,
  Column of Glory, Jesus Splendour, Light Mind, World of Light, King of Darkness, Matter,
  Archons, Demons, Light Particles);
  Allberry Psalm Book; Coptic Manichaean hymnal from Medinet Madi (c. 4th c. CE);
  preserves Manichaean cosmological theology in its primary liturgical form
- **SRC_WYATT_RELIGIOUS_TEXTS** → 12 Canaanite entities (was 2: Dagon, Resheph)
  SRC_CROSS_CANAANITE_MYTH → 10 Canaanite entities (was 2)
  SRC_DAY_GODS_CONFLICT → 3 Canaanite entities
  Entities: El, Baal, Anat, Asherah, Astarte, Mot, Yam, Lotan, Kothar, Shapash, Yarikh, Rephaim;
  the full Ugaritic pantheon now covered by both the primary KTU translation (Wyatt) and the
  standard Canaanite theology monograph (Cross); Cross and Day provide the academic framework
  for interpreting the mythological texts and their Israelite reception
- **SRC_2TJ_COLLINS** → 4 Israelite Second Temple entities
  (Noah, Adam, Elijah, Moses); Collins, The Apocalyptic Imagination (3rd ed. 2016);
  documents the Second Temple apocalyptic reception of these prophetic/patriarchal figures
  (Noah in 1 Enoch's Book of Noah; Elijah's eschatological return; Moses in the Testament
  of Moses; Adam as apocalyptic archetype)
- Result: 1128 entities, 1303 relationships, 100 sources, 0 unresolved
- Tradition source ratios after remediation: Egyptian 14.8 (was ~44), Canaanite 2.3,
  Zoroastrian 4.0, Israelite (prophets) 1.0, Mesopotamian 6.0, Roman 7.3, Norse 6.7

#### Egyptian period completion (add_egyptian_period_completion.sql)
- **Problem addressed**: 21 Egyptian entities still had no period assignments after the bulk
  Egyptian audit pass; these were the remaining specialist clusters: Horus forms, Four Sons
  of Horus (collective + 4 individual), Ogdoad, Elephantine deities, and minor deities
- **0 unperiodized Egyptian entities remain** (was 21)
- **Four Sons of Horus** (5 entities):
  ENT_EGY_FOUR_SONS_OF_HORUS, ENT_EGY_IMSETY, ENT_EGY_HAPY_SON_OF_HORUS,
  ENT_EGY_DUAMUTEF, ENT_EGY_QEBEHSENUEF → PER_EGY_OLD_KINGDOM (high; PT Utterance 552);
  the collective also assigned PER_EGY_NEW_KINGDOM (BD 151 standardization of their canopic jar roles)
- **Horus forms** (4 entities):
  ENT_EGY_HAROERIS (Great Horus) → PER_EGY_EARLY_DYNASTIC (high; Narmer Palette) + PER_EGY_OLD_KINGDOM;
  ENT_EGY_HARSIESE → PER_EGY_OLD_KINGDOM + PER_EGY_NEW_KINGDOM;
  ENT_EGY_HARAKHTY → PER_EGY_OLD_KINGDOM (PT 266) + PER_EGY_NEW_KINGDOM (Amduat);
  ENT_EGY_HARSOMTUS → PER_EGY_NEW_KINGDOM (medium) + PER_EGY_PTOLEMAIC (high; Edfu/Dendera)
- **Elephantine deities** (2 entities):
  ENT_EGY_SATET → PER_EGY_EARLY_DYNASTIC (high; Khasekhemwy vase, Dynasty 2) + PER_EGY_OLD_KINGDOM;
  ENT_EGY_ANUKET → PER_EGY_OLD_KINGDOM + PER_EGY_NEW_KINGDOM (Seheil inscriptions)
- **Other deities** (10 entities):
  ENT_EGY_OGDOAD → PER_EGY_OLD_KINGDOM (medium) + PER_EGY_MIDDLE_KINGDOM (high; Coffin Texts)
    + PER_EGY_NEW_KINGDOM (high; Amduat/BD);
  ENT_EGY_IHY → PER_EGY_OLD_KINGDOM (PT 334 "Ihy, son of Hathor, golden one");
  ENT_EGY_ASH → PER_EGY_EARLY_DYNASTIC (Dynasty 1 wine jars) + PER_EGY_OLD_KINGDOM;
  ENT_EGY_SHAI → PER_EGY_MIDDLE_KINGDOM (Coffin Texts) + PER_EGY_NEW_KINGDOM (BD 25, 30);
  ENT_EGY_RERET → PER_EGY_OLD_KINGDOM (hippopotamus constellation);
  ENT_EGY_SHESMETET → PER_EGY_OLD_KINGDOM (PT 317);
  ENT_EGY_HERYSHAF → PER_EGY_OLD_KINGDOM + PER_EGY_FIRST_INTERMEDIATE (Herakleopolis royal capital);
  ENT_EGY_BANEBDJEDET → PER_EGY_EARLY_DYNASTIC + PER_EGY_NEW_KINGDOM (Contendings of Horus and Seth);
  ENT_EGY_NEFERHOTEP → PER_EGY_MIDDLE_KINGDOM (low; cult context to verify);
  ENT_EGY_PTAH_SEKER_OSIRIS → PER_EGY_NEW_KINGDOM + PER_EGY_PTOLEMAIC (high; syncretic funerary triad)
- Additional SRC_FAULKNER_PYRAMID_TEXTS entity_sources links added for 12 entities not previously linked
- Period coverage after completion: Old Kingdom 56, New Kingdom 30, Early Dynastic 12, Middle Kingdom 11
- Result: 1128 entities, 1303 relationships, 100 sources, 0 unresolved

#### Welsh tradition layer — Mabinogion (add_welsh_mabinogion_layer.sql)
- **Problem addressed**: SRC_MABINOGION was registered in the sources table with 0 entity links
  because no Welsh entities existed in the database; the Celtic tradition was entirely Irish and Gaulish
- **New period**: PER_CEL_MEDIEVAL_WELSH (Celtic/Welsh, 1050-1400 CE): composition of the Four
  Branches of the Mabinogi (c. 1050-1120 CE); preserved in the White Book of Rhydderch (c. 1350)
  and Red Book of Hergest (c. 1382)
- **15 new entities** (tradition: 'Celtic/Welsh'), all linked to SRC_MABINOGION as primary_attestation:
  - *First Branch* (Pwyll Pendefig Dyfed):
    ENT_WEL_RHIANNON (sovereignty goddess; *Rigantona; magical white horse; Epona cognate),
    ENT_WEL_PWYLL (prince of Dyfed; exchanges kingdoms with Arawn; earns title Pen Annwn),
    ENT_WEL_ARAWN (lord of Annwn; hunts with the Cŵn Annwn, the white red-tipped Otherworld hounds),
    ENT_WEL_PRYDERI (the only character in all four branches; tragic hero figure)
  - *Second Branch* (Branwen ferch Llŷr):
    ENT_WEL_BRAN (Bendigeidfran; divine giant king; possessor of the Cauldron of Rebirth; speaking head),
    ENT_WEL_BRANWEN (tragic queen; trains a starling to carry a message to Bran),
    ENT_WEL_MANAWYDAN (patient craftsman; Second and Third Branch)
  - *Fourth Branch* (Math fab Mathonwy):
    ENT_WEL_MATH (magician-king of Gwynedd; the foot-holder taboo),
    ENT_WEL_GWYDION (trickster magician; the Fourth Branch's primary agent),
    ENT_WEL_LLEU_LLAW_GYFFES (solar hero; "skillful hand"; three tyngedau; eagle transformation),
    ENT_WEL_BLODEUWEDD (flower-woman created from oak, broom, and meadowsweet; transformed to owl),
    ENT_WEL_ARANRHOD (star goddess; "Silver Wheel"; places three magical taboos on her own son Lleu),
    ENT_WEL_DON (ancestral mother; "Children of Dôn" = Welsh divine family)
  - *Otherworld geography and Culhwch ac Olwen*:
    ENT_WEL_ANNWN (the Welsh Otherworld; First Branch + Preiddeu Annwfn; cosmological realm),
    ENT_WEL_GWYN_AP_NUDD (Otherworld king; controls the demons of Annwn; the May Day eternal combat)
- **Secondary source links** (6 rows): SRC_GREEN_CELTIC_GODS for Rhiannon/Epona, Brân head-cult,
  Gwyn ap Nudd, Lleu/Lugus; SRC_MACCANA_CELTIC_MYTH for Lleu/Lugh, Manawydan/Manannán
- **Iron Age period links** (low confidence): Rhiannon, Lleu, Dôn, Bran — pan-Celtic prototype roots
- **2 reception chains** (name-cognate / structural parallels to existing Irish entities):
  ENT_WEL_LLEU_LLAW_GYFFES → reception_of → ENT_CEL_LUGH (medium): *Lugus prototype; many-skilled;
    Green (1992); Mac Cana (1970)
  ENT_WEL_MANAWYDAN → reception_of → ENT_CEL_MANANNAN (low): *Manawydanō name-cognate;
    divergent development (Welsh: craftsman; Irish: sea-god); Mac Cana (1970)
- SRC_MABINOGION: 0 → 15 entity links
- Result: 1143 entities, 1305 relationships, 100 sources, 0 unresolved

#### Mesopotamian tradition audit and remediation (audit_mesopotamian_remediation.sql)
- Added period PER_MES_UR_III (Ur III / Sumerian Renaissance, -2112 to -2004): the core period
  for the surviving Sumerian literary corpus (Inanna hymns, Nanna hymns, laments, Gilgamesh poems);
  fills the gap between PER_MES_EARLY and PER_MES_OLD_BAB
- Added source SRC_FOSTER_BEFORE_MUSES (Benjamin Foster, Before the Muses, 3rd ed., CDL Press 2005):
  the comprehensive Akkadian literary anthology; ETCSL covers Sumerian, Foster covers Akkadian;
  now sourcing Tiamat, Apsu, Kingu, Marduk, Nabu, Ashur, Lamashtu, Pazuzu
- Added 3 missing entities with full source links:
  ENT_MES_NINLIL ("Lady of the Grain"; Enlil's consort; mother of Nanna/Sin; Enlil and Ninlil ETCSL 1.2.1;
    cult at Nippur from Early Dynastic; Enlil had no spouse in the dataset before this fix)
  ENT_MES_NINGAL ("Great Lady"; Nanna's consort; mother of Inanna and Utu; Lamentation over
    Destruction of Ur ETCSL 2.2.2; major cult at Ur; Harran cult survives into the Sabian period)
  ENT_MES_NAMMU (primordial sea goddess of Eridu theology; listed before Anu in Enki and the World
    Order; mother of Enki per Enki and Ninmah ETCSL 1.1.2; among oldest attested Mesopotamian deities)
- Bulk PER_MES_EARLY period assignments (14 deities): Anu, Enlil, Enki/Ea, Inanna/Ishtar, Nanna/Sin,
  Utu/Shamash, Ninhursag, Ereshkigal, Dumuzi/Tammuz, Geshtinanna, Nergal, Ninurta, Nisaba,
  Adad/Ishkur — all attested in Fara-period tablets (c. 2600 BCE); previously 29/33 entities
  were assigned only to PER_MES_NEO_ASS (-900 to -539 BCE)
- PER_MES_OLD_BAB assignments: Tiamat, Apsu, Kingu, Marduk, Nabu, Ashur, Lamashtu, Pazuzu
  (the Babylonian theological tradition that gives these entities their canonical form)
- Additional PER_MES_UR_III assignments: Inanna (Enheduanna hymns c. 2285-2250 BCE; oldest
  attributed literary works), Nanna (Ur III dynastic patron deity), Enlil (Nippur theological
  capital), Dumuzi (Inanna-Dumuzi love poetry in Ur III manuscripts)
- Missing internal relationships (9 relationship pairs, 18 rows total):
  Anu, Enlil, Enki → member_of → Anunnaki (the three chief gods were not linked to their collective)
  Enki ↔ Ninhursag (paired_with): Enki and Ninhursag myth (ETCSL 1.1.1) is foundational
  Ereshkigal ↔ Inanna (sibling_of): Descent of Inanna explicitly calls Ereshkigal "her sister"
  Enlil ↔ Ninlil (spouse_of) + Enlil → parent_of → Nanna/Sin
  Ninlil → parent_of → Nanna/Sin
  Nanna ↔ Ningal (spouse_of) + Ningal → parent_of → Inanna and Utu
  Nammu → parent_of → Enki
- Reception chains (3 pairs, 6 rows):
  ENT_MES_INANNA_ISHTAR → received_as → ENT_APHRODITE (medium): direct Cypriot path alongside
    existing Inanna→Astarte→Aphrodite chain; Queen of Heaven / Venus star / love-war combination;
    Burkert (1992)
  ENT_MES_NANNA_SIN → received_as → ENT_SELENE (low): Hellenistic lunar deity equation;
    Sin of Harran identified with Selene in the Sabian / interpretatio graeca tradition
  ENT_MES_ENKI_EA → received_as → ENT_PROMETHEUS (low): divine benefactor against divine assembly;
    structural parallel noted by West (1997); direct transmission unconfirmed
- Result: 1128 entities, 1303 relationships, 96 sources, 0 unresolved

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
