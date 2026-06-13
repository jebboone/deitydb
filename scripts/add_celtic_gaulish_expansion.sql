-- scripts/add_celtic_gaulish_expansion.sql
-- Adds 3 scholarly sources, 1 primary Latin source, and 4 new Gaulish entities.
-- Links all 11 Gaulish entities to the new sources with passage notes.
-- Sources: Delamarre (2003), Duval (1976), Olmsted (1994), Lucan Bellum Civile.

BEGIN;

-- ── 1. Sources ────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES
('SRC_LUCAN_BELLUM_CIVILE',
 'Lucan, Bellum Civile (Pharsalia) (c. 60–65 CE)',
 'primary literary',
 'Latin epic by Marcus Annaeus Lucanus on the Roman civil war. Book 1.444-446 is the primary source naming the three principal Gaulish gods: Esus, Teutates, and Taranis, described with their ritual practices (human sacrifice in water, tree, fire respectively). Scholia on the passage add interpretatio romana identifications. Standard edition: A.E. Housman (1926); trans. S.H. Braund (Oxford World''s Classics).'),
('SRC_DELAMARRE_GAULISH',
 'Delamarre, Xavier. Dictionnaire de la langue gauloise (Éditions Errance, 2003; 2nd ed.)',
 'secondary scholarly',
 'Standard scholarly dictionary of the Gaulish language. Covers all attested Gaulish inscriptions, deity names, personal names, and place names with etymological analysis. The essential reference for reconstructing Gaulish deity name meanings and Proto-Celtic roots. Used for all name-etymology claims in Gaulish tradition entries.'),
('SRC_DUVAL_DIEUX_GAULE',
 'Duval, Paul-Marie. Les dieux de la Gaule (Presses Universitaires de France, 1957; rev. ed. Payot, 1976)',
 'secondary scholarly',
 'Classic French-language study of Gaulish gods based on epigraphy, iconography, and Roman-period dedications. Systematic review of attested Gaulish deity names by region and function. Standard secondary reference for Gaulish polytheism alongside Green (1992) and Mac Cana (1970).'),
('SRC_OLMSTED_GODS_CELTS',
 'Olmsted, Garrett. The Gods of the Celts and the Indo-Europeans (Archaeolingua, 1994)',
 'secondary scholarly',
 'Comparative Indo-European analysis of Celtic deity names and functions, reconstructing Proto-Celtic divine typology from Irish, Welsh, Gaulish, and Celtiberian evidence. Useful for cross-tradition reception chains and etymology of deity names.')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New Gaulish entities ───────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, short_note)
VALUES
('ENT_CEL_LUGUS',
 'Lugus',
 'god',
 'Celtic/Gaulish',
 'Pan-Celtic many-skilled deity; attested in ~50 inscriptions primarily as a theophoric element in personal names and place names (Lugdunum = "fort of Lugus" = Lyon, Laon, Leiden, Léon). His triplism (Lucan Genii Cucullati; three-headed icons at Soissons) and identification with Mercury by Caesar (Gallic War 6.17) indicate a deity of skill, commerce, craft, and sovereignty. Cognate with Irish Lugh and Welsh Lleu. Delamarre (2003) p. 208: *lugus from PIE *leug- "black / oath-sworn / to swear."'),
('ENT_CEL_ROSMERTA',
 'Rosmerta',
 'goddess',
 'Celtic/Gaulish',
 'Gaulish goddess of fertility, abundance, and sovereignty; name means "the Good Provider" (Delamarre 2003, p. 268: *ro-smerta, from smerta "providential"). Attested in about 20 Roman-period dedications from Gaul, Rhineland, and the Moselle region; frequently paired with Mercury (Trier, Metz, Wiesbaden), suggesting a Roman interpretatio of a local sovereignty couple. Depicted with a wooden tub (bucket of abundance) and sometimes a patera; she is the pre-Roman sovereignty figure onto whom Roman Mercury was mapped.'),
('ENT_CEL_MAPONOS',
 'Maponos',
 'god',
 'Celtic/Gaulish',
 'Divine youth deity of the Celts; name means "the Great Son / the Divine Boy" (Delamarre 2003, p. 218: *mapono- < mapo- "son"). Attested in inscriptions from northern Gaul (Chamalieres water-spring defixio) and northern Britain (Ribchester, Corbridge, Hexham) equated with Apollo. Cognate with Welsh Mabon ap Modron (imprisoned divine youth of Arthurian tradition). A deity of youth, music, and hunting. Olmsted (1994) pp. 341-344.'),
('ENT_CEL_MATRES',
 'Matres / Matrones',
 'goddess',
 'Celtic/Gaulish',
 'Triple Mother Goddesses; the most widely attested religious phenomenon in Celtic Gaul and Roman-period Britain and Germany: over 1,000 votive inscriptions. Always depicted as a triad of seated women, usually carrying infants, fruit, baskets of abundance, or loaves. Regional variants named by tribe or locality (Matres Aufaniae, Matres Nemetiales, Matres Domesticae). Represent fertility, protection, and communal well-being. Olmsted (1994) pp. 299-312; Duval (1976) pp. 55-60.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Periods for new entities ───────────────────────────────────────────────
-- Lugus: attested from Iron Age through Roman period
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_CEL_LUGUS','PER_CEL_IRON_AGE','high',
 'Lugus as pan-Celtic deity is pre-Roman; place names (Lugdunum) attested from Iron Age settlement patterns; Delamarre (2003) p. 208',
 'SRC_DELAMARRE_GAULISH','reviewed'),
('ENT_CEL_ROSMERTA','PER_CEL_IRON_AGE','medium',
 'Pre-Roman Gaulish goddess; Roman-period inscriptions preserve an Iron Age sovereignty figure; Duval (1976) p. 77',
 'SRC_DUVAL_DIEUX_GAULE','reviewed'),
('ENT_CEL_MAPONOS','PER_CEL_IRON_AGE','high',
 'Chamalieres defixio (1st c. BCE) attests Maponos in Gaul; British inscriptions Roman period; cognate tradition prehistoric',
 'SRC_DELAMARRE_GAULISH','reviewed'),
('ENT_CEL_MATRES','PER_CEL_IRON_AGE','high',
 'Mother goddess cult attested from Late Bronze Age in Celtic regions; Roman-period inscriptions preserve pre-Roman tradition',
 'SRC_OLMSTED_GODS_CELTS','reviewed')
ON CONFLICT DO NOTHING;

-- ── 4. Entity sources — new entities ─────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_CEL_LUGUS','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 207-209: entry for Lugus with full analysis of ~50 theophoric place names and personal names; reconstructs *lugus from PIE *leug-.'),
('ENT_CEL_LUGUS','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 61-65: analysis of Lugus as the Gaulish Mercury; Caesar''s identification discussed.'),
('ENT_CEL_LUGUS','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 399-410: comparative analysis of Lugus / Lugh / Lleu as the Proto-Celtic many-skilled deity; reconstructs Proto-Celtic *Lugus.'),
('ENT_CEL_LUGUS','SRC_GREEN_CELTIC_GODS','Secondary analysis',
 'Green (1992) pp. 129-133: Lugus in the context of Celtic deity triplism and the "Mercurius" equation.'),
('ENT_CEL_ROSMERTA','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 267-268: entry for Rosmerta with inscription corpus; name etymology *ro-smerta.'),
('ENT_CEL_ROSMERTA','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 76-78: Rosmerta as Gaulish abundance goddess; her pairing with Mercury in Rhenish dedications.'),
('ENT_CEL_ROSMERTA','SRC_GREEN_CELTIC_GODS','Secondary analysis',
 'Green (1992) pp. 182-184: Rosmerta iconography and abundance symbolism.'),
('ENT_CEL_MAPONOS','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 217-218: entry for Maponos; attested in Chamalieres defixio and British inscriptions; *mapono- etymology.'),
('ENT_CEL_MAPONOS','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 341-344: Maponos / Mabon as the Divine Son archetype; comparative Indo-European analysis.'),
('ENT_CEL_MAPONOS','SRC_GREEN_CELTIC_GODS','Secondary analysis',
 'Green (1992) pp. 139-140: Maponos equated with Apollo in British dedications.'),
('ENT_CEL_MATRES','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 299-312: Matres as the most epigraphically attested divine category in Celtic religion; comparative analysis.'),
('ENT_CEL_MATRES','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 55-60: survey of Matres inscriptions by region; iconographic analysis of the seated triad.'),
('ENT_CEL_MATRES','SRC_GREEN_CELTIC_GODS','Secondary analysis',
 'Green (1992) pp. 151-156: Matres/Matrones iconography across Gaul and Britain.'),

-- ── 5. Existing Gaulish entities — add new sources ────────────────────────────
-- Cernunnos
('ENT_CEL_CERNUNNOS','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) p. 109: entry for Cernunnos; name < *carno- (horn); the Paris altar inscription is the only ancient text naming him.'),
('ENT_CEL_CERNUNNOS','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 25-29: Cernunnos iconography from the Gundestrup cauldron, Reims altar, and Paris pillar.'),
('ENT_CEL_CERNUNNOS','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 351-358: Cernunnos as lord of animals and the underworld; comparative Indo-European analysis.'),
-- Esus
('ENT_CEL_ESUS','SRC_LUCAN_BELLUM_CIVILE','Direct attestation',
 'Lucan Bellum Civile 1.444-446: names Esus alongside Teutates and Taranis as the three principal Gaulish gods requiring human sacrifice; scholia identify Esus with Mercury or Mars.'),
('ENT_CEL_ESUS','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 168-169: Esus attested on the Paris altar (Nautes Parisiens pillar) and the Trier altar; name etymology uncertain (*esus = "lord"?).'),
('ENT_CEL_ESUS','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 35-38: Esus iconography (woodcutter with bull and cranes) and the Lucan triads.'),
-- Taranis
('ENT_CEL_TARANIS','SRC_LUCAN_BELLUM_CIVILE','Direct attestation',
 'Lucan Bellum Civile 1.444-446: names Taranis alongside Esus and Teutates; scholia say victims were burned in wooden vessels. Name = "the Thunderer" < *taran- (Delamarre 2003 p. 293).'),
('ENT_CEL_TARANIS','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 292-293: entry for Taranis; attested in ~30 inscriptions; *taran- "thunder" cognate with Old Irish torann.'),
('ENT_CEL_TARANIS','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 38-42: Taranis as Gaulish thunder-wheel god; iconographic analysis of the wheel symbol.'),
('ENT_CEL_TARANIS','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 371-378: Taranis in the Proto-Celtic sky-god reconstruction.'),
-- Teutates
('ENT_CEL_TEUTATES','SRC_LUCAN_BELLUM_CIVILE','Direct attestation',
 'Lucan Bellum Civile 1.444-446: names Teutates alongside Esus and Taranis; scholia say victims were drowned. Name = "god of the tribe" < *teutā- (people/tribe); Delamarre (2003) p. 296.'),
('ENT_CEL_TEUTATES','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 295-296: Teutates as tribal patron deity; *teuta-tes < *teutā (tribe); attested in inscriptions as Toutatis.'),
('ENT_CEL_TEUTATES','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 42-45: Teutates as Mars-identified tribal war-god; inscription distribution.'),
('ENT_CEL_TEUTATES','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 379-385: Teutates in the Proto-Celtic divine typology.'),
-- Epona
('ENT_CEL_EPONA','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 160-161: Epona attested in ~350 inscriptions across Gaul, Britain, the Danubian provinces, and Rome itself; name < *epos "horse" + -ona (divine suffix).'),
('ENT_CEL_EPONA','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 68-72: Epona iconography (riding or flanked by horses; carrying grain or fruit); her unique status as a Gaulish deity officially adopted into the Roman army.'),
('ENT_CEL_EPONA','SRC_OLMSTED_GODS_CELTS','Secondary analysis',
 'Olmsted (1994) pp. 395-398: Epona as sovereignty horse goddess; comparison with Irish Macha and Welsh Rhiannon.'),
-- Nantosuelta
('ENT_CEL_NANTOSUELTA','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 230-231: Nantosuelta attested primarily at Sarrebourg; name < *nanto- (valley/river) + *suelta (?)  possibly "winding/meandering river").'),
('ENT_CEL_NANTOSUELTA','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 78-81: Nantosuelta paired with Sucellus; iconography of the house-on-pole and raven.'),
-- Sucellus
('ENT_CEL_SUCELLUS','SRC_DELAMARRE_GAULISH','Direct attestation',
 'Delamarre (2003) pp. 281-282: Sucellus attested in ~60 inscriptions across Gaul and Britain; name = "the Good Striker" < *su- (good) + *cello- (strike).'),
('ENT_CEL_SUCELLUS','SRC_DUVAL_DIEUX_GAULE','Secondary analysis',
 'Duval (1976) pp. 82-86: Sucellus as hammer/mallet god; iconographic analysis; paired with Nantosuelta.')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chain: Lugus → Lugh, Lugus → Lleu ──────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status)
VALUES
('ENT_CEL_LUGH','reception_of','ENT_CEL_LUGUS','high',
 'Lugh (Irish) and Lugus (Gaulish) share the Proto-Celtic *Lugus deity name, the "many-skilled" epithet (samildánach = master of all arts), and the spear as primary weapon. The Irish tradition elaborates the mythology more fully; the Gaulish tradition preserves the name in place names (Lugdunum sites). Olmsted (1994) pp. 399-410; Green (1992) pp. 129-133.',
 'SRC_OLMSTED_GODS_CELTS','PER_CEL_IRON_AGE','reviewed'),

('ENT_WEL_LLEU_LLAW_GYFFES','reception_of','ENT_CEL_LUGUS','medium',
 'Lleu Llaw Gyffes (Welsh) and Lugus share the Proto-Celtic *Lugus name and the "long arm / skilled hand" epithet; however the Welsh narrative diverges significantly from the Irish Lugh version, suggesting parallel but independent reception. The Lugus → Lleu chain is mediated through Common Brittonic, not directly from Gaulish; confidence medium. Olmsted (1994) pp. 399-410; Mac Cana (1970) pp. 53-57.',
 'SRC_OLMSTED_GODS_CELTS','PER_CEL_IRON_AGE','reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT COUNT(*) AS gaulish_entities FROM entities WHERE tradition LIKE 'Celtic/Gaulish%';

SELECT e.entity_id, e.canonical_name, COUNT(es.source_id) AS src_count
FROM entities e
JOIN entity_sources es ON e.entity_id = es.entity_id
WHERE e.tradition LIKE 'Celtic/Gaulish%'
GROUP BY e.entity_id, e.canonical_name
ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;

COMMIT;
