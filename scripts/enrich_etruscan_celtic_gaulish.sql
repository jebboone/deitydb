-- scripts/enrich_etruscan_celtic_gaulish.sql
-- Enrichment (v1.25.0): the remaining thin traditions — Etruscan (1.33 edges/entity)
-- and Celtic/Gaulish (1.40). Source-backed domain links + cognate/interpretatio
-- cross-links. Enrichment is matched to attestation: the well-documented Etruscan
-- Capitoline-triad gods and Turan get more edges; sparsely-attested Gaulish gods
-- (e.g. Taranis, known mainly from one line of Lucan) get only high-confidence links.
-- No new entities or sources.
--
-- Sources: SRC_DEGRUMMOND_ETRUSCAN (De Grummond, Etruscan Myth, Sacred History and
-- Legend), SRC_PYRGI_TABLETS (bilingual Etruscan-Phoenician gold tablets, c. 500 BCE),
-- SRC_GREEN_CELTIC_GODS (Green, Dictionary of Celtic Myth and Legend),
-- SRC_DUVAL_DIEUX_GAULE (Duval, Les dieux de la Gaule).

BEGIN;

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
VALUES
-- ── Etruscan ─────────────────────────────────────────────────────────────────
('ENT_ETR_TINIA','embodies','ENT_STORM','high',
 'Tinia is the Etruscan sky and thunder god who hurls the lightning bolts; the Piacenza Liver maps his celestial domain and he heads the council that casts the three kinds of thunderbolt.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TINIA','patron_of','ENT_SOVEREIGNTY','high',
 'Tinia is the supreme god of the Etruscan pantheon (the Etruscan Jupiter), head of the divine council and of the Capitoline-style triad with Uni and Menrva.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_UNI','patron_of','ENT_SOVEREIGNTY','high',
 'Uni is the supreme Etruscan goddess, consort of Tinia and member of the chief triad (the Etruscan Juno), patroness of sovereignty and the state.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_UNI','aligned_with','ENT_CAN_ASTARTE','high',
 'The Pyrgi Gold Tablets (c. 500 BCE), a bilingual Etruscan-Phoenician dedication, explicitly identify Uni with the Phoenician goddess Astarte — a directly attested ancient equation.','SRC_PYRGI_TABLETS','reviewed'),
('ENT_ETR_MENRVA','patron_of','ENT_CRAFT','high',
 'Menrva is the Etruscan goddess of crafts, skill, and wisdom (the Etruscan Minerva), the third member of the chief triad.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_MENRVA','patron_of','ENT_WISDOM','high',
 'Menrva governs wisdom and intelligence as well as war and crafts, paralleling Greek Athena.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_MENRVA','reception_of','ENT_ATHENA','high',
 'Menrva absorbs the iconography and martial-wisdom domain of Greek Athena, depicted armed with helmet and aegis on Etruscan mirrors.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TURAN','patron_of','ENT_LOVE','high',
 'Turan is the Etruscan goddess of love, desire, and beauty (the Etruscan Venus/Aphrodite), attended by the Lasas.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TURAN','embodies','ENT_BEAUTY','high',
 'Turan personifies beauty and erotic attraction; her name is linked to desire, and she presides over love and adornment on Etruscan mirrors.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),
('ENT_ETR_TURAN','reception_of','ENT_APHRODITE','high',
 'Turan takes on the imagery and love-goddess domain of Greek Aphrodite in Etruscan art, while retaining her native name and Lasa attendants.','SRC_DEGRUMMOND_ETRUSCAN','reviewed'),

-- ── Celtic/Gaulish ───────────────────────────────────────────────────────────
('ENT_CEL_TARANIS','aligned_with','ENT_ROM_JUPITER','high',
 'Taranis (Gaulish "Thunderer", taran = thunder), named in Lucan''s triad, is equated with Jupiter in the Roman interpretatio; the Gaulish "wheel-god" Jupiter dedications represent this fusion.','SRC_GREEN_CELTIC_GODS','reviewed'),
('ENT_CEL_SUCELLUS','paired_with','ENT_CEL_NANTOSUELTA','high',
 'Sucellus ("the good striker", hammer god) and Nantosuelta form a well-attested Gaulish divine couple, depicted together on reliefs from eastern Gaul and the Rhineland.','SRC_DUVAL_DIEUX_GAULE','reviewed'),
('ENT_CEL_NANTOSUELTA','paired_with','ENT_CEL_SUCELLUS','high',
 'Nantosuelta, goddess of domestic prosperity (often with a house-on-a-pole emblem and raven), is the consort of the hammer god Sucellus in paired Gaulish iconography.','SRC_DUVAL_DIEUX_GAULE','reviewed'),
('ENT_CEL_LUGUS','equated_with','ENT_ROM_MERCURY','high',
 'Lugus is the Gaulish god Caesar describes as "Mercury, the most honoured god of Gaul", inventor of all arts and patron of trade; the toponym Lugdunum (Lyon) marks his cult.','SRC_GREEN_CELTIC_GODS','reviewed'),
('ENT_CEL_LUGUS','patron_of','ENT_CRAFT','high',
 'Lugus is the "many-skilled" god, master of all arts and crafts (reflected in his Irish reflex Lug Samildánach, "skilled in all arts").','SRC_GREEN_CELTIC_GODS','reviewed'),
('ENT_CEL_MATRES','patron_of','ENT_MOTHERHOOD','high',
 'The Matres / Matronae are the triple mother-goddesses of Gaul and the Rhineland, patronesses of motherhood, fertility, and domestic protection, shown with infants and fruit.','SRC_GREEN_CELTIC_GODS','reviewed'),
('ENT_CEL_CERNUNNOS','patron_of','ENT_FERTILITY','medium',
 'Cernunnos, the antlered lord of animals, is associated with fertility and natural abundance (the Gundestrup cauldron and Pillar of the Boatmen depict him with torcs, serpents, and beasts).','SRC_GREEN_CELTIC_GODS','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT e.tradition,
       count(DISTINCT e.entity_id) AS entities,
       count(r.*) AS subj_edges,
       round(count(r.*)::numeric / count(DISTINCT e.entity_id), 2) AS edges_per_entity
FROM entities e
LEFT JOIN entity_relationships r ON r.subject_entity_id = e.entity_id
WHERE e.tradition IN ('Etruscan','Celtic/Gaulish')
GROUP BY e.tradition ORDER BY e.tradition;

SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT * FROM v_release_metrics;

COMMIT;
