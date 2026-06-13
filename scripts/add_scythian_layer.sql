-- scripts/add_scythian_layer.sql
-- Adds the Scythian religious tradition based on Herodotus Histories Book 4.
-- Herodotus 4.59 is the only sustained ancient account of Scythian divine names.
-- Six named deities (Tabiti, Papaeus, Api, Oetosyrus, Artimpasa, Thagimasadas)
-- plus the sword-Ares cult (4.62) which had no indigenous name recorded.

BEGIN;

-- ── 1. Secondary source ───────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_CUNLIFFE_SCYTHIANS',
 'Cunliffe, Barry. The Scythians: Nomad Warriors of the Steppe (Oxford University Press, 2019)',
 'secondary scholarly',
 'Comprehensive recent survey of Scythian culture, archaeology, and religion by a leading authority on Iron Age steppe peoples. Chapter 9 covers Scythian religion and the Herodotean divine names in the context of comparative Iranian/Indo-European religious evidence. Standard English-language secondary source for Scythian divine typology.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Period ─────────────────────────────────────────────────────────────────
INSERT INTO periods (period_id, tradition, period_name, start_year, end_year, notes)
VALUES
('PER_SCYTH_ARCHAIC',
 'Scythian',
 'Archaic Scythian',
 -700, -300,
 'The classical period of Scythian nomadic culture on the Pontic steppe, from initial emergence in the archaeological record through the height of royal Scythian power (Herodotean period, c. 450 BCE) and their displacement by the Sarmatians c. 300 BCE. Herodotus Book 4 (c. 430 BCE) is the primary textual witness to Scythian religion during this period.')
ON CONFLICT (period_id) DO NOTHING;

-- ── 3. Entities ───────────────────────────────────────────────────────────────
-- Herodotus 4.59.2: the six named Scythian deities
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, short_note)
VALUES
('ENT_SCYTH_TABITI',
 'Tabiti',
 'goddess',
 'Scythian',
 'Supreme deity of the Scythians; equated by Herodotus with Greek Hestia (Histories 4.59.2). Goddess of the sacred fire and the domestic hearth. Her primacy over all other Scythian gods — ahead of Papaeus (Zeus-equivalent) — is unusual by the standards of Indo-European parallels and has been explained as a reflection of the fire-altar''s central role in steppe nomadic life. Name possibly from Iranian *tápati (she who warms); Cunliffe (2019) p. 203.'),
('ENT_SCYTH_PAPAEUS',
 'Papaeus',
 'god',
 'Scythian',
 'Sky and father god; equated by Herodotus with Zeus (Histories 4.59.2). Herodotus notes the equation is "very rightly in my judgment," confirming the Scythian sky-father typology. Name from Iranian *pap (father); cognate with Ossetic Uacilla. Cunliffe (2019) p. 203; Herodotus describes him as the husband of Api (Earth).'),
('ENT_SCYTH_API',
 'Api',
 'goddess',
 'Scythian',
 'Earth goddess; equated by Herodotus with Gaia/Ge (Histories 4.59.2). Described as wife of Papaeus (Zeus-equivalent). Name from Iranian *api (water, later earth); related to Avestan āp- (water). Represents the divine earth-mother of the Scythian cosmological pair sky-earth. Cunliffe (2019) p. 203.'),
('ENT_SCYTH_OETOSYRUS',
 'Oetosyrus / Goitosyrus',
 'god',
 'Scythian',
 'Sun deity; equated by Herodotus with Apollo (Histories 4.59.2). Also spelled Goitosyrus in some manuscripts. Iranian name: possibly *Vāyu-asura or related to Avestan xvaētahe xvarənah (solar glory). The Scythian-Apollo identification reflects the solar aspect prominent in both. Cunliffe (2019) p. 203.'),
('ENT_SCYTH_ARTIMPASA',
 'Artimpasa',
 'goddess',
 'Scythian',
 'Love and moon goddess; equated by Herodotus with Aphrodite Urania (Histories 4.59.2). Also spelled Argimpasa. Herodotus 4.67 describes Enárees (male priests serving her who adopted female dress), suggesting a shamanic transvestite priesthood comparable to Iranian traditions. Name possibly from Iranian *Arti-pāsa (guardian of truth/order). The choice of Aphrodite Urania (the heavenly, celestial aspect) rather than the common Aphrodite is significant. Cunliffe (2019) p. 203.'),
('ENT_SCYTH_THAGIMASADAS',
 'Thagimasadas',
 'god',
 'Scythian',
 'Sea and water god; equated by Herodotus with Poseidon (Histories 4.59.2). Worshipped only by the Royal Scythians, a distinction Herodotus notes explicitly. The name has no universally agreed etymology; possibly from Iranian *thagi-masada (lord of depths). The association with the sea among a steppe people suggests an inherited Indo-Iranian water-deity tradition rather than direct maritime experience. Cunliffe (2019) p. 203.'),
('ENT_SCYTH_SWORD_ARES',
 'Sword Ares (Akinakes cult)',
 'god',
 'Scythian',
 'Scythian war deity worshipped in the form of an iron sword (akinakes) set atop a platform of fagot-wood; equated by Herodotus with Ares (Histories 4.62). No indigenous Scythian name is recorded; the worship is described in detail: annual festivals, rounding up of prisoners, pouring of wine over their heads, cutting their throats, collecting blood, and pouring it over the sword. The only Scythian deity for whom Herodotus describes a built cult structure. Herodotus 4.62 is the primary textual attestation. Cunliffe (2019) pp. 204-205.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 4. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_SCYTH_TABITI','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.2: "Hestia they call Tabiti; the Scythians worship Hestia above all gods." Primary and only ancient source naming Tabiti.'),
('ENT_SCYTH_TABITI','SRC_CUNLIFFE_SCYTHIANS','Secondary analysis',
 'Cunliffe (2019) p. 203: analysis of Tabiti''s primacy in the Scythian pantheon; Iranian etymology and fire-cult parallels.'),
('ENT_SCYTH_PAPAEUS','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.2: "Zeus (very rightly in my judgment) Papaeus; Earth Api" — Herodotus notes the cosmological pair explicitly.'),
('ENT_SCYTH_PAPAEUS','SRC_CUNLIFFE_SCYTHIANS','Secondary analysis',
 'Cunliffe (2019) p. 203: Papaeus in the context of Iranian sky-father traditions.'),
('ENT_SCYTH_API','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.2: "Earth Api" — paired with Papaeus as sky-earth divine couple.'),
('ENT_SCYTH_API','SRC_CUNLIFFE_SCYTHIANS','Secondary analysis',
 'Cunliffe (2019) p. 203: Api as earth-water goddess; Iranian āp- etymology.'),
('ENT_SCYTH_OETOSYRUS','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.2: "Apollo Oetosyrus" — Scythian sun god identified with Apollo.'),
('ENT_SCYTH_OETOSYRUS','SRC_CUNLIFFE_SCYTHIANS','Secondary analysis',
 'Cunliffe (2019) p. 203: Oetosyrus / Goitosyros as sun deity.'),
('ENT_SCYTH_ARTIMPASA','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.2 (named Artimpasa = Aphrodite Urania); 4.67 (Enarees — transvestite priests serving her). Two separate attestation contexts.'),
('ENT_SCYTH_ARTIMPASA','SRC_CUNLIFFE_SCYTHIANS','Secondary analysis',
 'Cunliffe (2019) p. 203-204: Artimpasa and the Enarees priesthood; Iranian parallels.'),
('ENT_SCYTH_THAGIMASADAS','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.2: "Poseidon Thagimasadas" — worshipped only by Royal Scythians; Herodotus''s explicit note about this restriction is significant.'),
('ENT_SCYTH_THAGIMASADAS','SRC_CUNLIFFE_SCYTHIANS','Secondary analysis',
 'Cunliffe (2019) p. 203: Thagimasadas as inherited Iranian water-deity.'),
('ENT_SCYTH_SWORD_ARES','SRC_HERODOTUS_HISTORIES','Direct attestation',
 'Herodotus Histories 4.59.3 and 4.62: the sword-Ares cult described in detail — the only Scythian deity with a constructed altar; annual festival; human and equine sacrifice; wine poured over victims'' heads.')
ON CONFLICT DO NOTHING;

-- ── 5. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_SCYTH_TABITI','PER_SCYTH_ARCHAIC','high',
 'Herodotus describes the Scythian religion as he encountered it c. 450 BCE; Tabiti is the supreme deity in this account','SRC_HERODOTUS_HISTORIES','reviewed'),
('ENT_SCYTH_PAPAEUS','PER_SCYTH_ARCHAIC','high',
 'Herodotus Histories 4.59.2; the Archaic Scythian pantheon as encountered c. 450 BCE','SRC_HERODOTUS_HISTORIES','reviewed'),
('ENT_SCYTH_API','PER_SCYTH_ARCHAIC','high',
 'Herodotus Histories 4.59.2; the Archaic Scythian earth goddess','SRC_HERODOTUS_HISTORIES','reviewed'),
('ENT_SCYTH_OETOSYRUS','PER_SCYTH_ARCHAIC','high',
 'Herodotus Histories 4.59.2; the Archaic Scythian sun deity','SRC_HERODOTUS_HISTORIES','reviewed'),
('ENT_SCYTH_ARTIMPASA','PER_SCYTH_ARCHAIC','high',
 'Herodotus Histories 4.59.2 and 4.67; the Archaic Scythian love/moon goddess','SRC_HERODOTUS_HISTORIES','reviewed'),
('ENT_SCYTH_THAGIMASADAS','PER_SCYTH_ARCHAIC','high',
 'Herodotus Histories 4.59.2; Royal Scythian water deity','SRC_HERODOTUS_HISTORIES','reviewed'),
('ENT_SCYTH_SWORD_ARES','PER_SCYTH_ARCHAIC','high',
 'Herodotus Histories 4.62; the sword-Ares cult as witnessed by Herodotus in the Archaic period','SRC_HERODOTUS_HISTORIES','reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Herodotean Greek interpretatio links ───────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
('ENT_SCYTH_TABITI','equated_with','ENT_HESTIA','high',
 'Herodotus Histories 4.59.2: "Hestia they call Tabiti" — explicit equation; Tabiti as fire-goddess is the most natural parallel to Hestia','SRC_HERODOTUS_HISTORIES','PER_SCYTH_ARCHAIC','reviewed'),
('ENT_SCYTH_PAPAEUS','equated_with','ENT_ZEUS','high',
 'Herodotus Histories 4.59.2: "Zeus Papaeus" — Herodotus notes this equation with unusual approbation ("very rightly in my judgment")','SRC_HERODOTUS_HISTORIES','PER_SCYTH_ARCHAIC','reviewed'),
('ENT_SCYTH_API','equated_with','ENT_GAIA','high',
 'Herodotus Histories 4.59.2: "Earth Api" — explicit equation; Api as earth-wife of Papaeus/Zeus','SRC_HERODOTUS_HISTORIES','PER_SCYTH_ARCHAIC','reviewed'),
('ENT_SCYTH_PAPAEUS','spouse_of','ENT_SCYTH_API','high',
 'Herodotus Histories 4.59.2: "Earth they regard as the wife of Zeus [Papaeus]" — the Scythian cosmological pair','SRC_HERODOTUS_HISTORIES','PER_SCYTH_ARCHAIC','reviewed'),
('ENT_SCYTH_API','spouse_of','ENT_SCYTH_PAPAEUS','high',
 'Herodotus Histories 4.59.2: Api is wife of Papaeus (Zeus-equivalent) in the Scythian cosmology','SRC_HERODOTUS_HISTORIES','PER_SCYTH_ARCHAIC','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS scythian_entities FROM entities WHERE tradition = 'Scythian';
SELECT * FROM v_release_metrics;

COMMIT;
