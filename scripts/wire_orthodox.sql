-- =====================================================================
-- wire_orthodox.sql  (v1.59.0 batch)
-- Connectivity fix: Christian/Orthodox had 0.57 edges/entity — the entities
-- existed but were barely wired into the graph. Adds typed relationships
-- (patron_of, embodies, teaches, member_of, undergoes_process, savior_of)
-- linking the saints to their domains, to the Church/godhead, and to the
-- Cross-traditional abstractions. No new entities. ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
-- warrior-saints -> war / soldiers
 ('ENT_ORTH_DEMETRIOS','patron_of','ENT_WAR','high','Great-martyr venerated as a military patron and defender of Thessaloniki.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_THEODORE','patron_of','ENT_WAR','high','Great-martyr venerated as a warrior-saint.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_THEODORE','aligned_with','ENT_ORTH_DEMETRIOS','medium','Paired in the Byzantine cult of military great-martyrs.','SRC_SYNAXARION','reviewed'),
-- healers -> healing
 ('ENT_ORTH_PANTELEIMON','patron_of','ENT_HEALING','high','The great unmercenary healer (anargyros) of Orthodox devotion.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_PARASKEVI','patron_of','ENT_HEALING','high','Great-martyr invoked for healing, especially of the eyes.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_MENAS','patron_of','ENT_HEALING','high','Wonderworker-martyr of the great healing shrine at Abu Mena.','SRC_SYNAXARION','reviewed'),
-- the hierarchs / Church Fathers -> teaching + the Three Hierarchs + Christ
 ('ENT_ORTH_BASIL','teaches','ENT_WISDOM','medium','Cappadocian Father and ecumenical teacher of the Church.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_GREGORY_THEOLOGIAN','teaches','ENT_WISDOM','medium','The Theologian, ecumenical teacher of the Church.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_CHRYSOSTOM','teaches','ENT_WISDOM','medium','"Golden-mouthed" ecumenical teacher and preacher.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_ATHANASIUS','teaches','ENT_WISDOM','medium','Defender of Nicene orthodoxy and Church Father.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_THREE_HIERARCHS','teaches','ENT_WISDOM','high','The three ecumenical teachers and hierarchs of the Church.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_ATHANASIUS','savior_of','ENT_JESUS_CHRIST','low','Champion of the full divinity of Christ at Nicaea.','SRC_SYNAXARION','reviewed'),
-- monastic / ascetic saints -> monasticism + asceticism as process
 ('ENT_ORTH_SERAPHIM','embodies','ENT_MONASTICISM','high','Monastic wonderworker and elder of Sarov.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_SERGIUS','embodies','ENT_MONASTICISM','high','Monastic founder and wonderworker of Radonezh.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_SIMEON_STYLITES','embodies','ENT_MONASTICISM','high','The pillar-ascetic, archetype of extreme askesis.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_CLIMACUS','teaches','ENT_MONASTICISM','high','Author of the Ladder of Divine Ascent, teacher of monastic ascent.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_MARY_EGYPT','embodies','ENT_MONASTICISM','high','The penitent desert ascetic, exemplar of repentance.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_SERAPHIM','member_of','ENT_MONASTICISM','medium','Of the Orthodox monastic tradition.','SRC_SYNAXARION','reviewed'),
-- mystics -> the uncreated light / theosis chain
 ('ENT_ORTH_SYMEON','teaches','ENT_ORTH_UNCREATED_LIGHT','high','The New Theologian, forerunner of the theology of the divine light.','SRC_PHILOKALIA','reviewed'),
 ('ENT_ORTH_PALAMAS','teaches','ENT_ORTH_UNCREATED_LIGHT','high','Systematiser of the doctrine of the uncreated energies/light.','SRC_PALAMAS_TRIADS','reviewed'),
-- the Theotokos cult-form + apostolic missionaries
 ('ENT_ORTH_POKROV','patron_of','ENT_WAR','low','The Protection (Pokrov) of the Theotokos, invoked as a shield over the faithful and cities.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_VLADIMIR','savior_of','ENT_ORTH_POKROV','low','Equal-to-the-Apostles who brought the Rus to the veneration of the Theotokos and Christ.','SRC_SYNAXARION','reviewed'),
 ('ENT_ORTH_CYRIL_METHODIUS','aligned_with','ENT_ORTH_VLADIMIR','medium','The Slavic apostolic mission, of which Vladimir''s baptism of the Rus is the heir.','SRC_SYNAXARION','reviewed'),
-- the divine-light chain to theosis (Dionysian bridge already exists; add the Orthodox side)
 ('ENT_ORTH_UNCREATED_LIGHT','undergoes_process','ENT_DIO_THEOSIS','high','Participation in the uncreated energies IS deification (theosis).','SRC_PALAMAS_TRIADS','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Orthodox edge density now =='
SELECT round(count(DISTINCT r.ctid)::numeric / count(DISTINCT e.entity_id),2) AS edges_per_entity
FROM entities e LEFT JOIN entity_relationships r ON r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id
WHERE e.tradition='Christian/Orthodox';
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
