-- scripts/source_greek_aspis_xenophon.sql
-- Greek rigor pass IV (v1.39.0): the war-daimones of the Hesiodic Aspis and Athena's
-- aegis, and the personifications of the Choice of Heracles. Additive, source-matched.
-- These entities were ref-only (no primary source), so no dedupe risk.

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_HESIOD_ASPIS','Hesiod (attrib.), The Shield of Heracles (Aspis / Scutum), c. 6th c. BCE, trans. Evelyn-White','','primary text','The ekphrasis of the shield of Heracles and its war-daimones (Pursuit, Rout, Tumult, Achlys)'),
('SRC_MASON_ASPIS','H. C. Mason, The Hesiodic Aspis: Introduction and Commentary on vv. 139-237 (DPhil thesis, Oxford, 2015)','','secondary scholarship','Critical commentary on the shield-ekphrasis and its personifications'),
('SRC_XENOPHON_MEMORABILIA','Xenophon, Memorabilia, c. 371 BCE (incl. Prodicus''s Choice of Heracles, 2.1.21-34)','','primary text','The allegory of Virtue (Arete) and Vice (Kakia) at the crossroads')
ON CONFLICT (source_id) DO NOTHING;

-- ── Aspis war-daimones → Hesiod, Shield of Heracles 154-160, 264-270 ─────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HESIOD_ASPIS', 'Direct attestation', src_note FROM (VALUES
 ('Proioxis','Hesiod, Shield 154 (Proioxis/Onrush, on the shield of Heracles).'),
 ('Palioxis','Hesiod, Shield 154 (Palioxis/Rout, on the shield of Heracles).'),
 ('Homados','Hesiod, Shield 155 (Homados/Tumult, on the shield of Heracles).'),
 ('Achlys','Hesiod, Shield 264-270 (Achlys, the Mist of death, wretched and wan, depicted on the shield).')
) AS t(name, src_note)
JOIN entities e ON e.tradition='Greek' AND e.canonical_name=t.name
ON CONFLICT DO NOTHING;
-- secondary commentary for the shield personifications
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_MASON_ASPIS', 'Secondary analysis', 'Mason (2015), commentary on the Aspis personifications (vv. 139-237).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Proioxis','Palioxis','Homados')
ON CONFLICT DO NOTHING;

-- ── Ioke and Alke → Homer, Iliad 5.738-742 (figures on Athena's aegis) ───────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_HOMER_ILIAD_ODYSSEY', 'Direct attestation', 'Homer, Iliad 5.738-742 (Alke/Prowess and Ioke/Onrush worked upon Athena''s aegis, with Phobos, Eris, and the Gorgon).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Ioke','Alke')
ON CONFLICT DO NOTHING;

-- ── Kakia and Arete → Xenophon, Memorabilia 2.1.21-34 (the Choice of Heracles) ──
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id, 'SRC_XENOPHON_MEMORABILIA', 'Direct attestation', 'Xenophon, Memorabilia 2.1.21-34 (Prodicus''s allegory: Vice/Kakia and Virtue/Arete appear to the young Heracles at the crossroads).'
FROM entities WHERE tradition='Greek' AND canonical_name IN ('Kakia','Arete')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS greek, round(100.0*count(*) FILTER (WHERE hp)/count(*),0) AS pct_w_primary,
  count(*) FILTER (WHERE NOT hp AND NOT hs) AS ref_only
FROM (SELECT e.entity_id,
  bool_or(s.source_type IN ('primary text','primary inscription/artifact','heresiological source')) hp,
  bool_or(s.source_type='secondary scholarship') hs
  FROM entities e JOIN entity_sources es ON es.entity_id=e.entity_id JOIN sources s ON s.source_id=es.source_id
  WHERE e.tradition='Greek' GROUP BY e.entity_id) g;
SELECT count(*) AS dup_pairs FROM (SELECT entity_id, source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d;
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT * FROM v_release_metrics;

COMMIT;
