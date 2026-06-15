-- =====================================================================
-- build_medieval_western_christianity.sql  (v1.61.0)
-- Christian (Western/Latin) roster +43: the major-CULTUS medieval Western
-- saints the Christian set deliberately skipped. Mendicant/monastic founders,
-- mystics-with-cultus, martyr & royal saints, and the great pilgrimage/helper
-- cults. Scholastic Doctors-qua-authors (Aquinas, Bonaventure, Anselm,
-- Albert, Scotus) EXCLUDED per house rule; the four included "Doctors"
-- (Anthony of Padua, Bernard, Catherine of Siena, Hildegard) are in on
-- popular-cultus grounds. Julian of Norwich / Mechtild of Magdeburg excluded.
-- Verified vs Farmer's Oxford Dict. of Saints, Butler's Lives, Golden Legend.
-- Additive; ON CONFLICT DO NOTHING; entity-kind = saint throughout.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_FARMER_SAINTS','David Hugh Farmer, The Oxford Dictionary of Saints (Oxford University Press, 5th ed. 2011)',NULL,'secondary scholarship','Western hagiography'),
 ('SRC_BIBLIOTHECA_SANCTORUM','Bibliotheca Sanctorum (Istituto Giovanni XXIII, Rome, 1961-1970)',NULL,'reference work','hagiography')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
-- A. mendicant & monastic founders
 ('ENT_SAINT_DOMINIC','Dominic','Christian','Founder/saint','Saint','preaching; the Order of Preachers; the Rosary','pan-Western','A','candidate_verified_name','major cultus (Bologna)',0,false,false,'Founder of the Dominicans (Order of Preachers, 1216); shrine at the Basilica of San Domenico, Bologna; canonized 1234.'),
 ('ENT_SAINT_CLARE','Clare of Assisi','Christian','Founder/saint','Saint','Franciscan poverty; the Poor Clares; (patron of television)','pan-Western','A','candidate_verified_name','major cultus (Assisi)',0,false,false,'Founder of the Poor Clares and follower of Francis; shrine at the Basilica of Santa Chiara, Assisi; canonized 1255.'),
 ('ENT_SAINT_ANTHONY_PADUA','Anthony of Padua','Christian','Friar/saint','Saint','preaching; the finding of lost things; the poor','pan-Western','A','candidate_verified_name','major cultus (Padua)',0,false,false,'Franciscan wonder-worker and helper-saint, patron of lost things; the Basilica del Santo, Padua, draws millions of pilgrims; canonized 1232 (also a Doctor, 1946).'),
 ('ENT_SAINT_BERNARD','Bernard of Clairvaux','Christian','Founder/saint','Saint','Cistercian reform; Marian devotion; contemplation','pan-Western','A','candidate_verified_name','major cultus',0,false,false,'Abbot of Clairvaux who drove the Cistercian expansion; canonized 1174; a Doctor of the Church (1830) included here for his strong popular Marian cultus.'),
 ('ENT_SAINT_BRUNO','Bruno of Cologne','Christian','Founder/saint','Saint','Carthusian eremitism; silence','regional','B','candidate_verified_name','founder of the Carthusians',0,false,false,'Founder of the Carthusian Order and the Grande Chartreuse; cult confirmed 1514.'),
 ('ENT_SAINT_NORBERT','Norbert of Xanten','Christian','Founder/saint','Saint','the Premonstratensian canons; preaching','regional','B','candidate_verified_name','founder of the Norbertines',0,false,false,'Founder of the Premonstratensians (Norbertines); relics at Strahov, Prague; canonized 1582.'),
 ('ENT_SAINT_ROMUALD','Romuald','Christian','Founder/saint','Saint','Camaldolese eremitism; monastic reform','regional','B','candidate_verified_name','founder of the Camaldolese',0,false,false,'Founder of the Camaldolese reform of the Benedictines; relics at Fabriano; feast established 1595.'),
 ('ENT_SAINT_BRIDGET_SWEDEN','Bridget of Sweden','Christian','Founder/saint','Saint','mystical revelation; the Birgittines; (co-patron of Europe)','pan-Western','A','candidate_verified_name','major cultus (Vadstena)',0,false,false,'Visionary founder of the Birgittines; shrine at Vadstena Abbey; canonized 1391; patron of Sweden and co-patron of Europe.'),
 ('ENT_SAINT_SCHOLASTICA','Scholastica','Christian','Virgin/saint','Saint','Benedictine nuns; contemplative life','pan-Western','B','candidate_verified_name','twin of Benedict',0,false,false,'Twin sister of Benedict of Nursia and traditional foundress of Benedictine nuns; relics shared between Monte Cassino and Le Mans.'),
-- B. mystics & visionaries with cultus
 ('ENT_SAINT_CATHERINE_SIENA','Catherine of Siena','Christian','Mystic/saint','Saint','mysticism; the stigmata; the papacy; (co-patron of Europe)','pan-Western','A','candidate_verified_name','major cultus (Rome/Siena)',0,false,false,'Dominican tertiary mystic who recalled the papacy to Rome; tomb in Santa Maria sopra Minerva; canonized 1461; co-patroness of Europe; a Doctor (1970), included for popular cultus.'),
 ('ENT_SAINT_HILDEGARD','Hildegard of Bingen','Christian','Mystic/saint','Saint','visionary theology; music; healing','regional','A','candidate_verified_name','equivalent canonization 2012',0,false,false,'Benedictine abbess, visionary, and composer; relics at Eibingen; named a Doctor of the Church in 2012; long-standing popular cultus.'),
 ('ENT_SAINT_GERTRUDE','Gertrude the Great','Christian','Mystic/saint','Saint','mysticism; the Sacred Heart; souls in Purgatory','regional','B','candidate_verified_name','equipollent canonization 1677',0,false,false,'Benedictine mystic of Helfta, patron of souls in Purgatory; equipollent canonization 1677.'),
 ('ENT_SAINT_MECHTILD','Mechtild of Hackeborn','Christian','Mystic/saint','Saint','mysticism; liturgical devotion','regional','C','candidate_verified_name','Helfta circle',0,false,false,'Benedictine mystic of Helfta and mentor of Gertrude the Great. (Distinct from the Beguine author Mechtild of Magdeburg.)'),
 ('ENT_SAINT_CATHERINE_GENOA','Catherine of Genoa','Christian','Mystic/saint','Saint','mysticism; Purgatory; care of the sick','regional','B','candidate_verified_name','canonized 1737',0,false,false,'Mystic and "Apostle of Purgatory," hospital reformer of Genoa; canonized 1737.'),
-- C. martyrs / political saints
 ('ENT_SAINT_BECKET','Thomas Becket','Christian','Martyr/saint','Saint','ecclesiastical liberty; martyrdom','pan-Western','A','candidate_verified_name','major cultus (Canterbury)',0,false,false,'Archbishop of Canterbury murdered in his cathedral in 1170; his Canterbury shrine became one of medieval Europe''s greatest pilgrimages; canonized 1173.'),
 ('ENT_SAINT_STANISLAUS','Stanislaus of Kraków','Christian','Martyr/saint','Saint','episcopal martyrdom; Polish nationhood','regional','B','candidate_verified_name','patron of Poland',0,false,false,'Bishop of Kraków martyred by King Bolesław II; shrine at Wawel Cathedral; canonized 1253; principal patron of Poland.'),
 ('ENT_SAINT_NEPOMUK','John of Nepomuk','Christian','Martyr/saint','Saint','the seal of confession; bridges and waterways','regional','B','candidate_verified_name','patron of confessors',0,true,false,'Martyr of the confessional seal, drowned in the Vltava; tomb in St Vitus, Prague; canonized 1729; patron of bridges and against floods.'),
 ('ENT_SAINT_WENCESLAUS','Wenceslaus','Christian','Royal martyr/saint','Saint','Bohemian nationhood; just rule','regional','A','candidate_verified_name','patron of Bohemia',0,false,false,'Duke of Bohemia martyred by his brother in 935; shrine at St Vitus Cathedral; patron of the Czech lands ("Good King Wenceslas").'),
 ('ENT_SAINT_BONIFACE','Boniface','Christian','Martyr/saint','Saint','the evangelization of Germany; martyrdom','pan-Western','A','candidate_verified_name','Apostle of Germany',0,false,false,'Anglo-Saxon "Apostle of Germany," martyred in Frisia in 754; national shrine of Catholic Germany at Fulda.'),
 ('ENT_SAINT_ADALBERT','Adalbert of Prague','Christian','Martyr/saint','Saint','mission to the Prussians; martyrdom','regional','B','candidate_verified_name','patron of Poland/Bohemia',0,false,false,'Bishop of Prague martyred evangelizing the Prussians in 997; shrines at Gniezno and Prague; canonized 999.'),
 ('ENT_SAINT_OLAF','Olaf of Norway','Christian','Royal martyr/saint','Saint','Norwegian nationhood; the Christianization of Norway','regional','A','candidate_verified_name','Rex Perpetuus Norvegiae',0,false,false,'King Olaf Haraldsson, fallen at Stiklestad in 1030; his shrine at Nidaros (Trondheim) was northern Europe''s foremost pilgrimage; eternal king and patron of Norway.'),
 ('ENT_SAINT_CANUTE','Canute of Denmark','Christian','Royal martyr/saint','Saint','Danish nationhood; just rule','regional','B','candidate_verified_name','patron of Denmark',0,false,false,'King Knud IV of Denmark, killed in church in 1086; shrine at Odense; canonized 1101; patron of Denmark.'),
-- D. royal / dynastic saints
 ('ENT_SAINT_LOUIS','Louis IX of France','Christian','Royal saint','Saint','just kingship; crusade; the Passion relics','pan-Western','A','candidate_verified_name','only canonized King of France',0,false,false,'King of France and crusader who built the Sainte-Chapelle for the Passion relics; buried at Saint-Denis; canonized 1297; the only canonized King of France.'),
 ('ENT_SAINT_EDWARD_CONFESSOR','Edward the Confessor','Christian','Royal saint','Saint','English kingship; Westminster','regional','A','candidate_verified_name','shrine at Westminster',0,false,false,'King of England and founder of Westminster Abbey, where his shrine survives intact; canonized 1161; a patron of England.'),
 ('ENT_SAINT_STEPHEN_HUNGARY','Stephen I of Hungary','Christian','Royal saint','Saint','Hungarian nationhood; Christian kingship','regional','A','candidate_verified_name','founder/patron of Hungary',0,false,false,'First Christian king of Hungary; the "Holy Right Hand" relic is venerated in Budapest; canonized 1083; founder and patron of Hungary.'),
 ('ENT_SAINT_ELIZABETH_HUNGARY','Elizabeth of Hungary','Christian','Royal saint','Saint','charity; care of the poor and sick; Franciscan tertiaries','pan-Western','A','candidate_verified_name','major cultus (Marburg)',0,false,false,'Hungarian princess and Franciscan tertiary renowned for charity; her Marburg shrine rivalled Compostela; canonized 1235; patroness of the Secular Franciscans.'),
 ('ENT_SAINT_MARGARET_SCOTLAND','Margaret of Scotland','Christian','Royal saint','Saint','Scottish nationhood; charity; church reform','regional','B','candidate_verified_name','patron of Scotland',0,false,false,'Queen of Scotland and church reformer; shrine at Dunfermline; canonized 1250; patron of Scotland; great-niece of Edward the Confessor.'),
 ('ENT_SAINT_HENRY_II','Henry II','Christian','Royal saint','Saint','the Holy Roman Empire; the see of Bamberg','regional','B','candidate_verified_name','patron of Bamberg',0,false,false,'The last Ottonian Holy Roman Emperor, founder of the see of Bamberg; canonized 1146; enshrined at Bamberg Cathedral with his wife Cunigunde.'),
 ('ENT_SAINT_CUNIGUNDE','Cunigunde','Christian','Royal saint','Saint','the Holy Roman Empire; chastity; charity','regional','B','candidate_verified_name','patron of Bamberg',0,false,false,'Holy Roman Empress, wife of Henry II, foundress with him of Bamberg; canonized 1200; enshrined at Bamberg Cathedral.'),
 ('ENT_SAINT_CASIMIR','Casimir of Poland','Christian','Royal saint','Saint','Poland and Lithuania; chastity','regional','B','candidate_verified_name','patron of Poland/Lithuania',0,false,false,'Jagiellonian prince of Poland; shrine at Vilnius Cathedral; canonized 1521; patron of Poland and Lithuania.'),
-- E. great pilgrimage / helper cults
 ('ENT_SAINT_JAMES_GREATER','James the Greater','Christian','Apostle/saint','Saint','the Camino; Spain; pilgrimage','pan-Western','A','candidate_verified_name','Santiago de Compostela',0,false,false,'The apostle James, whose shrine at Santiago de Compostela became one of the three great medieval pilgrimages (the Camino); patron of Spain. (NT apostle; the Compostela cult is the medieval Western phenomenon recorded here.)'),
 ('ENT_SAINT_THREE_KINGS','The Three Kings','Christian','Saint collective','Saint','the Epiphany; the Cologne relic cult','pan-Western','A','candidate_verified_name','Cologne shrine',0,false,false,'The Magi, whose relics were translated to Cologne in 1164; the Shrine of the Three Kings is the largest reliquary in the West and Cologne Cathedral was built to house it.'),
 ('ENT_SAINT_FAITH_CONQUES','Faith of Conques','Christian','Virgin-martyr/saint','Saint','the Camino; healing of blindness; the captive','regional','B','candidate_verified_name','Conques shrine',0,false,false,'A child virgin-martyr of Agen (Sainte-Foy) whose gold reliquary-statue at Conques was a major Camino shrine famed for curing blindness.'),
 ('ENT_SAINT_LEONARD','Leonard of Noblac','Christian','Helper-saint','Saint','prisoners and captives; women in childbirth','pan-Western','B','candidate_verified_name','helper cult',0,false,false,'A Frankish hermit, patron of prisoners and captives (votive chains) and of women in labour; his tomb at Saint-Léonard-de-Noblat was a Camino stop with ~177 English dedications.'),
 ('ENT_SAINT_GILES','Giles','Christian','Helper-saint','Saint','cripples, lepers and beggars; the wilderness','pan-Western','A','candidate_verified_name','one of the Fourteen Holy Helpers',0,false,false,'A hermit-abbot, patron of the disabled and the outcast; his shrine at Saint-Gilles-du-Gard was a major Camino hub; the only non-martyr among the Fourteen Holy Helpers.'),
 ('ENT_SAINT_FOURTEEN_HELPERS','The Fourteen Holy Helpers','Christian','Saint collective','Saint','intercession against plague and sudden death','pan-Western','A','candidate_verified_name','collective helper cult',0,false,false,'A collective of fourteen intercessory saints invoked together against plague and afflictions; centred on the Vierzehnheiligen basilica in Bavaria; arose in the 14th-century plague era.'),
 ('ENT_SAINT_DENIS','Denis of Paris','Christian','Martyr/saint','Saint','Paris and France; martyrdom','pan-Western','A','candidate_verified_name','patron of France',0,true,false,'The cephalophore first bishop of Paris, martyred in the 3rd century; the royal abbey-basilica of Saint-Denis (cradle of Gothic and royal necropolis) bears his cult; patron of France.'),
 ('ENT_SAINT_GENEVIEVE','Genevieve of Paris','Christian','Virgin/saint','Saint','the protection of Paris','regional','B','candidate_verified_name','patroness of Paris',0,false,false,'Virgin patroness of Paris, said to have turned aside Attila by prayer; her relics were processed against civic threats.'),
 ('ENT_SAINT_CUTHBERT','Cuthbert','Christian','Bishop/saint','Saint','Northumbria; wonder-working','regional','A','candidate_verified_name','shrine at Durham',0,false,false,'Bishop of Lindisfarne, the "Wonder-worker of England"; his incorrupt body and shrine at Durham Cathedral made one of medieval England''s greatest cults.'),
 ('ENT_SAINT_SWITHUN','Swithun','Christian','Bishop/saint','Saint','Winchester; weather-lore','regional','B','candidate_verified_name','shrine at Winchester',0,false,false,'Bishop of Winchester whose shrine drew major English pilgrimage; popularly the patron of weather ("St Swithun''s day").'),
 ('ENT_SAINT_EDMUND_MARTYR','Edmund the Martyr','Christian','Royal martyr/saint','Saint','East Anglia; martyrdom','regional','B','candidate_verified_name','shrine at Bury St Edmunds',0,false,false,'King of East Anglia killed by the Danes in 869; his shrine at Bury St Edmunds was one of England''s wealthiest pilgrimage abbeys; a former patron of England.'),
 ('ENT_SAINT_WALBURGA','Walburga','Christian','Virgin/saint','Saint','the mission to Germany; healing oil','regional','B','candidate_verified_name','shrine at Eichstätt',0,false,false,'Anglo-Saxon Benedictine missionary abbess; her shrine at Eichstätt is famed for a miraculous oil; her feast eve gives "Walpurgisnacht."'),
 ('ENT_SAINT_BRIGID_KILDARE','Brigid of Kildare','Christian','Abbess/saint','Saint','Ireland; the hearth; healing and abundance','regional','A','candidate_verified_name','secondary patron of Ireland',2,false,false,'Abbess of Kildare, "Mary of the Gael," secondary patron of Ireland; her cult absorbed much of the older Irish goddess Brigid (St Brigid''s crosses, the perpetual fire).')
ON CONFLICT (entity_id) DO NOTHING;

-- sources: all -> Farmer (Oxford Dict. of Saints); the legendary/older ones also Golden Legend
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_FARMER_SAINTS','scholarly attestation','Farmer, The Oxford Dictionary of Saints.'
FROM entities WHERE tradition='Christian' AND entity_id LIKE 'ENT_SAINT_%' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_SAINT_DOMINIC','ENT_SAINT_CLARE','ENT_SAINT_ANTHONY_PADUA','ENT_SAINT_BERNARD','ENT_SAINT_BRUNO','ENT_SAINT_NORBERT','ENT_SAINT_ROMUALD','ENT_SAINT_BRIDGET_SWEDEN','ENT_SAINT_SCHOLASTICA','ENT_SAINT_CATHERINE_SIENA','ENT_SAINT_HILDEGARD','ENT_SAINT_GERTRUDE','ENT_SAINT_MECHTILD','ENT_SAINT_CATHERINE_GENOA','ENT_SAINT_BECKET','ENT_SAINT_STANISLAUS','ENT_SAINT_NEPOMUK','ENT_SAINT_WENCESLAUS','ENT_SAINT_BONIFACE','ENT_SAINT_ADALBERT','ENT_SAINT_OLAF','ENT_SAINT_CANUTE','ENT_SAINT_LOUIS','ENT_SAINT_EDWARD_CONFESSOR','ENT_SAINT_STEPHEN_HUNGARY','ENT_SAINT_ELIZABETH_HUNGARY','ENT_SAINT_MARGARET_SCOTLAND','ENT_SAINT_HENRY_II','ENT_SAINT_CUNIGUNDE','ENT_SAINT_CASIMIR','ENT_SAINT_JAMES_GREATER','ENT_SAINT_THREE_KINGS','ENT_SAINT_FAITH_CONQUES','ENT_SAINT_LEONARD','ENT_SAINT_GILES','ENT_SAINT_FOURTEEN_HELPERS','ENT_SAINT_DENIS','ENT_SAINT_GENEVIEVE','ENT_SAINT_CUTHBERT','ENT_SAINT_SWITHUN','ENT_SAINT_EDMUND_MARTYR','ENT_SAINT_WALBURGA','ENT_SAINT_BRIGID_KILDARE')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_GOLDEN_LEGEND','direct attestation','Life recorded in the Golden Legend (Jacobus de Voragine).'
FROM entities WHERE entity_id IN ('ENT_SAINT_DOMINIC','ENT_SAINT_BERNARD','ENT_SAINT_BECKET','ENT_SAINT_JAMES_GREATER','ENT_SAINT_GILES','ENT_SAINT_DENIS','ENT_SAINT_FAITH_CONQUES')
ON CONFLICT DO NOTHING;

-- periods: all medieval West
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_MEDIEVAL_WEST','A','Medieval Western (Latin) saint with major cultus.','SRC_FARMER_SAINTS','reviewed'
FROM entities WHERE tradition='Christian' AND entity_id LIKE 'ENT_SAINT_%' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_SAINT_DOMINIC','ENT_SAINT_CLARE','ENT_SAINT_ANTHONY_PADUA','ENT_SAINT_BERNARD','ENT_SAINT_BRUNO','ENT_SAINT_NORBERT','ENT_SAINT_ROMUALD','ENT_SAINT_BRIDGET_SWEDEN','ENT_SAINT_SCHOLASTICA','ENT_SAINT_CATHERINE_SIENA','ENT_SAINT_HILDEGARD','ENT_SAINT_GERTRUDE','ENT_SAINT_MECHTILD','ENT_SAINT_CATHERINE_GENOA','ENT_SAINT_BECKET','ENT_SAINT_STANISLAUS','ENT_SAINT_NEPOMUK','ENT_SAINT_WENCESLAUS','ENT_SAINT_BONIFACE','ENT_SAINT_ADALBERT','ENT_SAINT_OLAF','ENT_SAINT_CANUTE','ENT_SAINT_LOUIS','ENT_SAINT_EDWARD_CONFESSOR','ENT_SAINT_STEPHEN_HUNGARY','ENT_SAINT_ELIZABETH_HUNGARY','ENT_SAINT_MARGARET_SCOTLAND','ENT_SAINT_HENRY_II','ENT_SAINT_CUNIGUNDE','ENT_SAINT_CASIMIR','ENT_SAINT_JAMES_GREATER','ENT_SAINT_THREE_KINGS','ENT_SAINT_FAITH_CONQUES','ENT_SAINT_LEONARD','ENT_SAINT_GILES','ENT_SAINT_FOURTEEN_HELPERS','ENT_SAINT_DENIS','ENT_SAINT_GENEVIEVE','ENT_SAINT_CUTHBERT','ENT_SAINT_SWITHUN','ENT_SAINT_EDMUND_MARTYR','ENT_SAINT_WALBURGA','ENT_SAINT_BRIGID_KILDARE')
ON CONFLICT DO NOTHING;

-- relationships: order-founder, family, devotion, cultus, the goddess-reception cross-link
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_SAINT_CLARE','aligned_with','ENT_SAINT_FRANCIS','high','Clare, follower of Francis and co-founder of the Franciscan movement.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_ANTHONY_PADUA','aligned_with','ENT_SAINT_FRANCIS','high','Anthony of Padua, a Franciscan friar.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_ELIZABETH_HUNGARY','aligned_with','ENT_SAINT_FRANCIS','medium','Elizabeth of Hungary, a Franciscan tertiary.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_CATHERINE_SIENA','aligned_with','ENT_SAINT_DOMINIC','high','Catherine of Siena, a Dominican tertiary.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_SCHOLASTICA','sibling_of','ENT_SAINT_BENEDICT','high','Scholastica, twin sister of Benedict of Nursia.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_BERNARD','embodies','ENT_MONASTICISM','medium','Bernard, the great Cistercian monastic reformer.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_BRUNO','embodies','ENT_MONASTICISM','medium','Bruno, founder of the Carthusian eremitical life.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_ROMUALD','embodies','ENT_MONASTICISM','medium','Romuald, founder of the Camaldolese.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_NORBERT','embodies','ENT_MONASTICISM','low','Norbert, founder of the Premonstratensian canons.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_GERTRUDE','aligned_with','ENT_SAINT_MECHTILD','high','Gertrude the Great and Mechtild of Hackeborn, the mystics of Helfta.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_BERNARD','patronized_by','ENT_SAINT_MARY','low','Bernard, renowned for his Marian devotion.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_CATHERINE_SIENA','aligned_with','ENT_SAINT_BRIDGET_SWEDEN','low','The two great 14th-century visionary women, co-patronesses of Europe.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_HENRY_II','consort_of','ENT_SAINT_CUNIGUNDE','high','Henry II and Cunigunde, the imperial couple enshrined at Bamberg.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_MARGARET_SCOTLAND','aligned_with','ENT_SAINT_EDWARD_CONFESSOR','medium','Margaret of Scotland, great-niece of Edward the Confessor.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_BECKET','savior_of','ENT_JESUS_CHRIST','low','Becket, martyred for the liberty of the Church.','SRC_GOLDEN_LEGEND','reviewed'),
 ('ENT_SAINT_GILES','member_of','ENT_SAINT_FOURTEEN_HELPERS','high','Giles, one of the Fourteen Holy Helpers.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_LEONARD','patron_of','ENT_HUMANS','low','Leonard, patron of prisoners and captives.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_HILDEGARD','patron_of','ENT_HEALING','low','Hildegard, renowned for her medical and healing writings.','SRC_FARMER_SAINTS','reviewed'),
 ('ENT_SAINT_THREE_KINGS','aligned_with','ENT_JESUS_CHRIST','medium','The Magi who adored the infant Christ.','SRC_GOLDEN_LEGEND','reviewed'),
 ('ENT_SAINT_BRIGID_KILDARE','reception_of','ENT_CEL_BRIGID','high','The cult of St Brigid of Kildare absorbed much of the older Irish goddess Brigid.','SRC_FARMER_SAINTS','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Christian (Western) count + new saints =='
SELECT count(*) FROM entities WHERE tradition='Christian';
SELECT count(*) AS new_medieval FROM entities WHERE entity_id IN ('ENT_SAINT_DOMINIC','ENT_SAINT_BECKET','ENT_SAINT_LOUIS','ENT_SAINT_BRIGID_KILDARE','ENT_SAINT_THREE_KINGS');
\echo '== integrity (expect 0/0/0/0) =='
SELECT (SELECT unreviewed_duplicates FROM v_release_metrics) ud, (SELECT unresolved_relationships FROM v_release_metrics) ur,
       (SELECT count(*) FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id)) unsourced,
       (SELECT count(*) FROM (SELECT entity_id,source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d) dup_pairs;
\echo '== any new saint missing a period link? (expect 0) =='
SELECT count(*) FROM entities e WHERE e.entity_id LIKE 'ENT_SAINT_%' AND e.tradition='Christian' AND e.review_status='candidate_verified_name'
  AND e.entity_id IN ('ENT_SAINT_DOMINIC','ENT_SAINT_CLARE','ENT_SAINT_BRIGID_KILDARE','ENT_SAINT_LOUIS','ENT_SAINT_FOURTEEN_HELPERS')
  AND NOT EXISTS (SELECT 1 FROM entity_periods p WHERE p.entity_id=e.entity_id);
