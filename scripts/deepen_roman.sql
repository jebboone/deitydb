-- =====================================================================
-- deepen_roman.sql  (v1.59.0 batch)
-- Roman 43 -> ~77.  The indigitamenta (the minor functional deities of
-- Varro, preserved by Augustine/Servius/Tertullian) + minor cult gods.
-- All cited; epithets-of-major-gods and the one dubious name (Tibellus)
-- excluded per research. Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_AUGUSTINE_CITY_OF_GOD','Augustine of Hippo, De Civitate Dei (The City of God), c. 413-426 CE',NULL,'primary text','preserves Varro''s Roman theology'),
 ('SRC_WISSOWA_RKR','Georg Wissowa, Religion und Kultus der Römer (2nd ed., Munich, 1912)',NULL,'secondary scholarship','Roman religion')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_ROM_INDIGITAMENTA','The Indigitamenta','Roman','Divine collective','Minor functional deities',
  'the lists of specialized minor gods invoked for single acts/moments','priestly','A','candidate_verified_name','Varro via Augustine',2,false,false,
  'The pontifical lists of minor "naming" gods, each presiding over one precise act, moment, or stage of life or agriculture; recorded by Varro and preserved (mockingly) by the Church Fathers.'),
-- the twelve agricultural gods of Fabius Pictor (Servius, ad Georgica 1.21)
 ('ENT_ROM_VERVACTOR','Vervactor','Roman','Functional deity','Agricultural indigitamentum','the first ploughing of fallow land','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve farming gods invoked by the flamen of Ceres (Fabius Pictor via Servius): god of breaking the fallow.'),
 ('ENT_ROM_REPARATOR','Reparator','Roman','Functional deity','Agricultural indigitamentum','the second ploughing','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of the re-ploughing.'),
 ('ENT_ROM_IMPORCITOR','Imporcitor','Roman','Functional deity','Agricultural indigitamentum','ploughing into ridges','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of ploughing in broad furrows (porcae).'),
 ('ENT_ROM_INSITOR','Insitor','Roman','Functional deity','Agricultural indigitamentum','sowing','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of sowing/setting in the seed.'),
 ('ENT_ROM_OBARATOR','Obarator','Roman','Functional deity','Agricultural indigitamentum','ploughing over the sown seed','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of ploughing over the sown seed.'),
 ('ENT_ROM_OCCATOR','Occator','Roman','Functional deity','Agricultural indigitamentum','harrowing','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of harrowing.'),
 ('ENT_ROM_SARRITOR','Sarritor','Roman','Functional deity','Agricultural indigitamentum','hoeing and raking','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of hoeing/weeding the soil.'),
 ('ENT_ROM_SUBRUNCINATOR','Subruncinator','Roman','Functional deity','Agricultural indigitamentum','weeding','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of weeding out.'),
 ('ENT_ROM_MESSOR','Messor','Roman','Functional deity','Agricultural indigitamentum','reaping','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of the harvest/reaping.'),
 ('ENT_ROM_CONVECTOR','Convector','Roman','Functional deity','Agricultural indigitamentum','carting in the crop','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of carrying in the harvest.'),
 ('ENT_ROM_CONDITOR','Conditor','Roman','Functional deity','Agricultural indigitamentum','storing the grain','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of storing the grain (condere), not a "founder".'),
 ('ENT_ROM_PROMITOR','Promitor','Roman','Functional deity','Agricultural indigitamentum','bringing out stored grain','priestly','A','candidate_verified_name','Servius ad Georg. 1.21',3,false,false,'One of the twelve Fabius Pictor farming gods: god of bringing out and distributing stored grain.'),
-- grain-growth & field indigitamenta
 ('ENT_ROM_SEIA','Seia','Roman','Functional deity','Agricultural indigitamentum','the seed-corn underground','priestly','A','candidate_verified_name','Augustine CD 4.8; Pliny NH 18.8',3,false,false,'Goddess who protects the sown seed while it lies underground (sata); statue in the Circus Maximus.'),
 ('ENT_ROM_SEGETIA','Segetia','Roman','Functional deity','Agricultural indigitamentum','the standing crop','priestly','A','candidate_verified_name','Augustine CD 4.8; Macrobius 1.16.8',3,false,false,'Goddess who protects the standing crop above ground (seges) (= Segesta).'),
 ('ENT_ROM_TUTILINA','Tutilina','Roman','Functional deity','Agricultural indigitamentum','stored grain','priestly','A','candidate_verified_name','Augustine CD 4.8; Tertullian Spect. 8',3,false,false,'Goddess who guards the harvested grain in store.'),
 ('ENT_ROM_ROBIGUS','Robigus','Roman','Functional deity','Agricultural deity','averting wheat-rust/mildew','public','A','candidate_verified_name','Ovid Fasti 4.901-942; Varro RR 1.1.6',3,false,false,'God (also Robigo, goddess) who averts wheat-rust; the Robigalia (Apr 25) sacrificed a red dog to him.'),
 ('ENT_ROM_STERCULIUS','Sterculius','Roman','Functional deity','Agricultural deity','manuring of the fields','priestly','B','candidate_verified_name','Augustine CD 18.15; Macrobius 1.7.25',3,false,false,'God of the manuring of fields (stercus); also Stercutus/Sterquilinus, linked as a byname of Saturn.'),
-- life-stage indigitamenta (birth/childhood/marriage)
 ('ENT_ROM_VAGITANUS','Vagitanus','Roman','Functional deity','Life-stage indigitamentum','the newborn''s first cry','priestly','A','candidate_verified_name','Augustine CD 4.8; Gellius 16.17',0,false,false,'God who opens the newborn''s mouth for its first wailing cry (vagitus); also Vaticanus.'),
 ('ENT_ROM_CUNINA','Cunina','Roman','Functional deity','Life-stage indigitamentum','the infant in the cradle','priestly','A','candidate_verified_name','Augustine CD 4.8, 4.11',0,false,false,'Goddess who protects the infant in its cradle (cunae).'),
 ('ENT_ROM_RUMINA','Rumina','Roman','Functional deity','Life-stage indigitamentum','the breastfeeding of infants','priestly','A','candidate_verified_name','Augustine CD 4.11, 7.11',0,false,false,'Goddess who presides over the suckling of infants (ruma = breast); her shrine stood by the Ficus Ruminalis.'),
 ('ENT_ROM_EDUSA','Edusa','Roman','Functional deity','Life-stage indigitamentum','the child learning to eat','priestly','B','candidate_verified_name','Augustine CD 4.11; Varro via Donatus',0,false,false,'Goddess who enables the weaned child to eat (edere); also Educa/Edulia. Paired with Potina.'),
 ('ENT_ROM_POTINA','Potina','Roman','Functional deity','Life-stage indigitamentum','the child learning to drink','priestly','B','candidate_verified_name','Augustine CD 4.11; Tertullian',0,false,false,'Goddess who enables the child to drink (potare). Paired with Edusa.'),
 ('ENT_ROM_LEVANA','Levana','Roman','Functional deity','Life-stage indigitamentum','the acknowledgement of the newborn','priestly','A','candidate_verified_name','Augustine CD 4.11',0,false,false,'Goddess who presides over the father lifting the newborn from the ground (levare) to acknowledge it.'),
 ('ENT_ROM_CARNA','Carna','Roman','Functional deity','Tutelary deity','the vital organs; bodily health','public','A','candidate_verified_name','Macrobius 1.12.31-33; Tertullian',0,false,false,'Goddess guarding the heart and inward organs; her festival (June 1, Kalendae Fabariae) ate beans and bacon. Distinct from Cardea.'),
 ('ENT_ROM_NUNDINA','Nundina','Roman','Functional deity','Life-stage indigitamentum','the naming-day of a child','priestly','B','candidate_verified_name','Macrobius 1.16.36',0,false,false,'Goddess of the dies lustricus, the purification-and-naming day of the newborn (the ninth/eighth day).'),
 ('ENT_ROM_MUTUNUS','Mutunus Tutunus','Roman','Fertility deity','Phallic marriage god','marriage; fertility; sexual potency','public','A','candidate_verified_name','Augustine CD 4.11, 6.9; Festus',0,false,false,'A phallic marriage and fertility god on whose image brides were seated; an old Roman counterpart of Priapus.'),
-- door / threshold gods (Janus-cluster)
 ('ENT_ROM_FORCULUS','Forculus','Roman','Functional deity','Threshold deity','the door-leaves','domestic','A','candidate_verified_name','Augustine CD 4.8, 6.7; Tertullian',0,false,false,'God of the leaves of the door (fores), one of the doorway triad with Cardea and Limentinus.'),
 ('ENT_ROM_LIMENTINUS','Limentinus','Roman','Functional deity','Threshold deity','the threshold','domestic','A','candidate_verified_name','Augustine CD 4.8, 6.7; Tertullian',0,false,false,'God of the threshold (limen), one of the doorway triad.'),
 ('ENT_ROM_CARDEA','Cardea','Roman','Functional deity','Threshold deity','the door-hinge','domestic','A','candidate_verified_name','Augustine CD 4.8, 6.7; Ovid Fasti 6.101',0,false,false,'Goddess of the door-hinge (cardo), one of the doorway triad; protects thresholds against night-spirits. Distinct from Carna.'),
-- named minor cult gods (festivals/temples)
 ('ENT_ROM_FERONIA','Feronia','Roman','Goddess','Italic nature goddess','wild nature; fertility; manumission of slaves','public','A','candidate_verified_name','Livy 1.30, 26.11; Varro LL 5.74',2,false,false,'An Italic goddess of wild places, fertility, and the freeing of slaves, with famous groves at Capena and Terracina.'),
 ('ENT_ROM_SEMO_SANCUS','Semo Sancus','Roman','God','God of oaths','oaths; good faith; treaties','public','A','candidate_verified_name','Ovid Fasti 6.213-218; Livy 8.20',1,false,false,'A Sabine-Roman god of oaths, faith, and treaties (Dius Fidius), with a temple on the Quirinal.'),
 ('ENT_ROM_SUMMANUS','Summanus','Roman','God','God of nocturnal thunder','thunder by night','public','A','candidate_verified_name','Pliny NH 2.138; Ovid Fasti 6.731',0,false,false,'God of nocturnal thunder, the night counterpart of Jupiter, with a temple by the Circus Maximus.'),
 ('ENT_ROM_VEIOVIS','Veiovis','Roman','God','Chthonic god','the underworld; a "young" or "anti-" Jupiter','public','A','candidate_verified_name','Ovid Fasti 3.429-448; Gellius 5.12',0,true,false,'A chthonic god, an "anti-Jupiter" or Jupiter of the underworld, with a temple between the two groves on the Capitoline.'),
 ('ENT_ROM_CONSUS','Consus','Roman','God','God of stored grain','the storehouse; counsel','public','A','candidate_verified_name','Varro LL 6.20-21; Livy 1.9',3,true,false,'God of the grain-store and of counsel, with a subterranean altar in the Circus Maximus; the Consualia (Aug 21, Dec 15).'),
 ('ENT_ROM_PALES','Pales','Roman','Deity','Pastoral deity','shepherds and flocks','public','A','candidate_verified_name','Ovid Fasti 4.721-806',3,false,false,'The pastoral deity of shepherds and flocks; the Parilia (Apr 21), Rome''s birthday festival, was sacred to Pales.'),
 ('ENT_ROM_ANGERONA','Angerona','Roman','Goddess','Goddess of the solstice','the winter solstice; relief from anguish','public','A','candidate_verified_name','Macrobius 1.10.7-8; Pliny NH 3.65',0,false,false,'Goddess of the winter solstice and of release from anguish (angor); her statue had a bound and sealed mouth. Divalia/Angeronalia (Dec 21).'),
 ('ENT_ROM_LAVERNA','Laverna','Roman','Deity','Goddess of thieves','thieves; fraud; the underworld','public','B','candidate_verified_name','Horace Epist. 1.16.60; Varro LL 5.163',0,true,false,'The goddess of thieves and the dishonest, with an altar at the Porta Lavernalis.'),
 ('ENT_ROM_VICA_POTA','Vica Pota','Roman','Goddess','Victory goddess','victory and mastery','public','B','candidate_verified_name','Cicero De Leg. 2.28; Livy 2.7.12',0,false,false,'An archaic goddess of victory and mastery, a precursor of Victoria, with a shrine on the Velia.'),
 ('ENT_ROM_ANNA_PERENNA','Anna Perenna','Roman','Goddess','Goddess of the year-cycle','the year and its renewal','public','A','candidate_verified_name','Ovid Fasti 3.523-696',2,false,false,'Goddess of the circuit and renewal of the year, feasted (Mar 15) at her grove by the Tiber.'),
 ('ENT_ROM_MEFITIS','Mefitis','Roman','Goddess','Goddess of noxious vapours','sulphurous and swamp gases','public','B','candidate_verified_name','Pliny NH 2.208; Servius ad Aen. 7.563',2,false,false,'Goddess of the noxious sulphurous exhalations of the earth, worshipped at Ampsanctus and on the Esquiline.'),
 ('ENT_ROM_FURRINA','Furrina','Roman','Goddess','Spring goddess','springs (her function later obscure)','public','B','candidate_verified_name','Varro LL 6.19; Cicero ND 3.46',2,false,false,'An archaic goddess (probably of springs) with her own flamen and a grove on the Janiculum; the Furrinalia (Jul 25).'),
 ('ENT_ROM_FONS','Fons','Roman','God','God of springs','springs and fountains','public','A','candidate_verified_name','Varro LL 6.22; Cicero ND 3.52',3,false,false,'God of springs and flowing water, son of Janus; the Fontinalia (Oct 13).'),
 ('ENT_ROM_PORTUNUS','Portunus','Roman','God','God of harbours','harbours, doors, and keys','public','A','candidate_verified_name','Varro LL 6.19; Festus',1,false,false,'God of harbours, gates, and keys, with his own flamen; the Portunalia (Aug 17).'),
 ('ENT_ROM_VOLTURNUS','Volturnus','Roman','God','River god','rivers and water','public','B','candidate_verified_name','Varro LL 6.21; Arnobius 3.29',3,false,false,'An old river/water god with his own flamen; the Volturnalia (Aug 27).'),
 ('ENT_ROM_FEBRIS','Febris','Roman','Goddess','Goddess of fever','fever, propitiated to avert it','public','A','candidate_verified_name','Cicero ND 3.63; Pliny NH 2.16',0,false,false,'The goddess of fever, propitiated to ward off malaria; she had three shrines in Rome.'),
 ('ENT_ROM_ORBONA','Orbona','Roman','Goddess','Goddess of bereavement','parents bereft of children','public','B','candidate_verified_name','Cicero ND 3.63; Arnobius 4.7',0,false,false,'Goddess invoked by parents who had lost their children (orbus), with an altar by the temple of the Lares.'),
 ('ENT_ROM_DEA_DIA','Dea Dia','Roman','Goddess','Agrarian goddess','the growth of crops','priestly','A','candidate_verified_name','Acta Fratrum Arvalium',3,false,false,'The agrarian goddess of the Arval Brethren, honoured each May with the archaic Carmen Arvale.'),
 ('ENT_ROM_VACUNA','Vacuna','Roman','Goddess','Sabine goddess','rest from labour; victory','public','B','candidate_verified_name','Horace Epist. 1.10.49; Ovid Fasti 6.307',2,false,false,'A Sabine goddess (of rest from farm labour, or of victory per Varro) with a grove at Reate.'),
 ('ENT_ROM_PICUMNUS','Picumnus','Roman','God','God of infants and fields','marriage, infancy, manuring','public','B','candidate_verified_name','Servius ad Aen. 9.4; Augustine CD 6.9',3,false,false,'An Italic god of marriage, infants, and the fertilising of fields, paired with his brother Pilumnus.'),
 ('ENT_ROM_PILUMNUS','Pilumnus','Roman','God','God of infants','the protection of newborns','public','B','candidate_verified_name','Servius ad Aen. 9.4; Augustine CD 6.9',2,false,false,'An Italic god who, with Picumnus, wards the newborn child from the woodland spirit Silvanus.')
ON CONFLICT (entity_id) DO NOTHING;

-- sources: agricultural twelve -> Servius; the rest -> Augustine; + Wissowa on the collective
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_SERVIUS_COMMENTARY','direct attestation','Servius, ad Georgica 1.21 (Fabius Pictor''s twelve farming gods).'
FROM entities WHERE category='Agricultural indigitamentum'
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_AUGUSTINE_CITY_OF_GOD','direct attestation','Named in Augustine''s catalogue of Varro''s minor Roman gods.'
FROM entities WHERE entity_id IN
 ('ENT_ROM_INDIGITAMENTA','ENT_ROM_SEIA','ENT_ROM_SEGETIA','ENT_ROM_TUTILINA','ENT_ROM_STERCULIUS','ENT_ROM_VAGITANUS',
  'ENT_ROM_CUNINA','ENT_ROM_RUMINA','ENT_ROM_EDUSA','ENT_ROM_POTINA','ENT_ROM_LEVANA','ENT_ROM_NUNDINA','ENT_ROM_MUTUNUS',
  'ENT_ROM_FORCULUS','ENT_ROM_LIMENTINUS','ENT_ROM_CARDEA','ENT_ROM_ORBONA','ENT_ROM_PICUMNUS','ENT_ROM_PILUMNUS')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_OVID_FASTI','direct attestation','Attested in Ovid''s Fasti (festival calendar).'
FROM entities WHERE entity_id IN ('ENT_ROM_ROBIGUS','ENT_ROM_CARNA','ENT_ROM_VEIOVIS','ENT_ROM_PALES','ENT_ROM_ANNA_PERENNA','ENT_ROM_SEMO_SANCUS','ENT_ROM_SUMMANUS','ENT_ROM_VACUNA')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_WISSOWA_RKR','scholarly attestation','Wissowa, Religion und Kultus der Römer.'
FROM entities WHERE entity_id IN
 ('ENT_ROM_FERONIA','ENT_ROM_CONSUS','ENT_ROM_ANGERONA','ENT_ROM_LAVERNA','ENT_ROM_VICA_POTA','ENT_ROM_MEFITIS',
  'ENT_ROM_FURRINA','ENT_ROM_FONS','ENT_ROM_PORTUNUS','ENT_ROM_VOLTURNUS','ENT_ROM_FEBRIS','ENT_ROM_DEA_DIA',
  'ENT_ROM_SEIA','ENT_ROM_SEGETIA','ENT_ROM_TUTILINA','ENT_ROM_ROBIGUS','ENT_ROM_STERCULIUS')
ON CONFLICT DO NOTHING;

-- periods: all Republican-rooted
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_ROM_REPUBLIC','A','Archaic/Republican Roman cult, recorded in the pontifical and Varronian tradition.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'
FROM entities WHERE tradition='Roman' AND review_status='candidate_verified_name'
  AND (entity_id='ENT_ROM_INDIGITAMENTA' OR category IN ('Agricultural indigitamentum','Life-stage indigitamentum','Threshold deity','Minor functional deities')
       OR entity_id IN ('ENT_ROM_SEIA','ENT_ROM_SEGETIA','ENT_ROM_TUTILINA','ENT_ROM_ROBIGUS','ENT_ROM_STERCULIUS','ENT_ROM_CARNA','ENT_ROM_MUTUNUS',
       'ENT_ROM_FERONIA','ENT_ROM_SEMO_SANCUS','ENT_ROM_SUMMANUS','ENT_ROM_VEIOVIS','ENT_ROM_CONSUS','ENT_ROM_PALES','ENT_ROM_ANGERONA',
       'ENT_ROM_LAVERNA','ENT_ROM_VICA_POTA','ENT_ROM_ANNA_PERENNA','ENT_ROM_MEFITIS','ENT_ROM_FURRINA','ENT_ROM_FONS','ENT_ROM_PORTUNUS',
       'ENT_ROM_VOLTURNUS','ENT_ROM_FEBRIS','ENT_ROM_ORBONA','ENT_ROM_DEA_DIA','ENT_ROM_VACUNA','ENT_ROM_PICUMNUS','ENT_ROM_PILUMNUS'))
ON CONFLICT DO NOTHING;

-- relationships: the indigitamenta collective + thematic links
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'member_of','ENT_ROM_INDIGITAMENTA','high','One of the minor "naming" gods of the pontifical lists.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'
FROM entities WHERE category IN ('Agricultural indigitamentum','Life-stage indigitamentum','Threshold deity')
ON CONFLICT DO NOTHING;
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_ROM_INDIGITAMENTA','presided_over_by','ENT_ROM_CERES','medium','The agricultural indigitamenta were invoked by the flamen of Ceres.','SRC_SERVIUS_COMMENTARY','reviewed'),
 ('ENT_ROM_FORCULUS','associated_with','ENT_ROM_JANUS','high','Doorway god under Janus, lord of doors and gates.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_LIMENTINUS','associated_with','ENT_ROM_JANUS','high','Threshold god under Janus.','SRC_AUGUSTINE_CITY_OF_GOD','reviewed'),
 ('ENT_ROM_CARDEA','associated_with','ENT_ROM_JANUS','high','Hinge goddess under Janus, lord of doors.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_PICUMNUS','sibling_of','ENT_ROM_PILUMNUS','high','The paired brother-gods of marriage and infancy.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_VEIOVIS','opposes','ENT_ROM_JUPITER','low','Conceived as an "anti-Jupiter" of the underworld.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_SUMMANUS','associated_with','ENT_ROM_JUPITER','medium','God of nocturnal thunder, the night counterpart of Jupiter.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_SEIA','associated_with','ENT_ROM_CERES','medium','Grain-protecting goddess in the sphere of Ceres.','SRC_WISSOWA_RKR','reviewed'),
 ('ENT_ROM_ROBIGUS','associated_with','ENT_ROM_CERES','medium','Averts rust from the crop of Ceres.','SRC_OVID_FASTI','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Roman count (expect ~77) =='
SELECT count(*) FROM entities WHERE tradition='Roman';
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
