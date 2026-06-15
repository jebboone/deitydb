-- =====================================================================
-- deepen_celtic_gaulish_british.sql  (v1.59.0 batch)
-- Celtic/Gaulish 10 -> ~24 + new tag 'Celtic/British' (~9).
-- The Gallo-Roman and Romano-British deities of the inscriptional record
-- and the Roman interpretatio (Belenus, Grannus, Sirona, Sequana, Sulis,
-- Nodens, Brigantia, ...). Each carries its interpretatio link.
-- Epona excluded (already ENT_CEL_EPONA). Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_GREEN_CELTIC_GODS','Miranda Aldhouse-Green, The Gods of the Celts (Sutton, 1986; rev. 2011)',NULL,'secondary scholarship','Celtic/Romano-Celtic religion'),
 ('SRC_RIB','R. G. Collingwood & R. P. Wright, The Roman Inscriptions of Britain (RIB)',NULL,'primary inscription/artifact','Romano-British epigraphy'),
 ('SRC_CIL','Corpus Inscriptionum Latinarum (CIL)',NULL,'primary inscription/artifact','Latin epigraphy')
ON CONFLICT (source_id) DO NOTHING;

-- ---- Gaulish / Continental ----
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_CEL_BELENUS','Belenus','Celtic/Gaulish','God','Healing/solar god','healing; springs; light','regional','A','candidate_verified_name','CIL inscriptions; interpretatio Apollo',2,false,false,'A widely-worshipped healing and light god of Gaul, N. Italy and Noricum, equated with Apollo; ~51 inscriptions.'),
 ('ENT_CEL_GRANNUS','Grannus','Celtic/Gaulish','God','Healing god','healing; thermal springs','regional','A','candidate_verified_name','CIL; Cassius Dio; interpretatio Apollo',2,false,false,'God of healing thermal springs (eponym of Aachen, Aquae Granni), equated with Apollo; consort of Sirona.'),
 ('ENT_CEL_SIRONA','Sirona','Celtic/Gaulish','Goddess','Healing goddess','healing springs; fertility','regional','A','candidate_verified_name','CIL inscriptions',2,false,false,'Healing thermal-spring goddess (snake, eggs, grain), consort of Apollo Grannus.'),
 ('ENT_CEL_BORVO','Borvo','Celtic/Gaulish','God','Healing god','boiling/healing springs','regional','B','candidate_verified_name','CIL; interpretatio Apollo',2,false,false,'God of bubbling healing springs ("the boiling one"; Bourbonne-les-Bains), equated with Apollo; consort of Damona.'),
 ('ENT_CEL_DAMONA','Damona','Celtic/Gaulish','Goddess','Healing goddess','healing; fertility (the "divine cow")','regional','B','candidate_verified_name','CIL inscriptions',3,false,false,'Healing and fertility goddess ("divine cow"), consort of Borvo and of Apollo Moritasgus.'),
 ('ENT_CEL_NEMAUSUS','Nemausus','Celtic/Gaulish','God','Tutelary spring god','the sacred spring of Nîmes','local','B','candidate_verified_name','CIL inscriptions',2,false,false,'Tutelary god of Nîmes and its sacred spring; linked to the Matres Nemausicae.'),
 ('ENT_CEL_SEQUANA','Sequana','Celtic/Gaulish','Goddess','River goddess','the source of the Seine; healing','regional','A','candidate_verified_name','CIL inscriptions',3,false,false,'Goddess of the source of the Seine, to whom over a thousand healing ex-votos were dedicated at Fontes Sequanae.'),
 ('ENT_CEL_RITONA','Ritona','Celtic/Gaulish','Goddess','Goddess of fords','river-fords and crossings','local','B','candidate_verified_name','CIL inscriptions',2,false,false,'Treveran goddess of fords and water-crossings.'),
 ('ENT_CEL_LITAVIS','Litavis','Celtic/Gaulish','Goddess','Earth goddess','the broad earth','regional','B','candidate_verified_name','CIL inscriptions',4,true,false,'An earth-goddess ("the Broad One"; cf. Welsh Llydaw), paired with Mars Cicolluis.'),
 ('ENT_CEL_BELISAMA','Belisama','Celtic/Gaulish','Goddess','Crafts/river goddess','crafts; rivers; light','regional','B','candidate_verified_name','CIL (Minervae Belisamae)',2,false,false,'Goddess of crafts, light and rivers, equated with Minerva (Saint-Lizier inscription).'),
 ('ENT_CEL_OGMIOS','Ogmios','Celtic/Gaulish','God','God of eloquence','eloquence; the binding power of speech','regional','B','candidate_verified_name','Lucian, Heracles',0,false,false,'God of eloquence and the binding force of speech, depicted as an aged Heracles leading men by chains from his tongue (Lucian); compared to Irish Ogma.'),
 ('ENT_CEL_CATHUBODUA','Cathubodua','Celtic/Gaulish','War goddess','Battle-crow goddess','war; the battle-crow','local','C','candidate_verified_name','CIL XII 2571',1,false,false,'A battle-crow goddess of the Allobroges (Haute-Savoie), linguistic cognate of Irish Badb; known from one damaged inscription.'),
 ('ENT_CEL_CAMULOS','Camulos','Celtic/Gaulish','War god','War god','war','regional','A','candidate_verified_name','RIB; CIL; interpretatio Mars',1,false,false,'A war-god of the Belgae and Britons (eponym of Camulodunum/Colchester), equated with Mars.'),
 ('ENT_CEL_ABNOBA','Abnoba','Celtic/Gaulish','Goddess','Forest/hunt goddess','the Black Forest; rivers; the hunt','regional','B','candidate_verified_name','CIL; Tacitus; interpretatio Diana',4,false,false,'Goddess of the Black Forest, its rivers and the hunt, equated with Diana (Diana Abnoba).'),
 ('ENT_CEL_ARDUINNA','Arduinna','Celtic/Gaulish','Goddess','Forest/hunt goddess','the Ardennes forest; the boar-hunt','regional','B','candidate_verified_name','CIL; interpretatio Diana',4,false,false,'Goddess of the Ardennes forest and the boar-hunt, equated with Diana.'),
 ('ENT_CEL_ARTIO','Artio','Celtic/Gaulish','Goddess','Bear goddess','bears; wildlife; abundance','regional','B','candidate_verified_name','CIL (Deae Artioni)',4,false,false,'Bear-goddess of wildlife and abundance (the Muri bronze, near Bern).'),
 ('ENT_CEL_VOSEGUS','Vosegus','Celtic/Gaulish','God','Mountain/hunt god','the Vosges; forest and hunt','local','C','candidate_verified_name','CIL inscriptions',4,false,false,'God personifying the Vosges mountains, the forest and the hunt (the Donon temple).'),
 ('ENT_CEL_SMERTRIOS','Smertrios','Celtic/Gaulish','God','Warrior god','war; provision; the serpent-slayer','regional','B','candidate_verified_name','CIL XIII 3026 (Pillar of the Boatmen)',1,true,false,'A warrior and serpent-slaying god ("the provider"; cf. Rosmerta), on the Paris Pillar of the Boatmen; consort of Ancamna.'),
 ('ENT_CEL_UCUETIS','Ucuetis','Celtic/Gaulish','God','Smith god','smithcraft; metalwork','local','B','candidate_verified_name','CIL XIII 2880 (Alesia)',2,false,false,'A smith-god of Alesia, worshipped with the prosperity-goddess Bergusia.'),
 ('ENT_CEL_LENUS','Lenus','Celtic/Gaulish','God','Healing/war god','healing; tribal protection','regional','A','candidate_verified_name','RIB 309; CIL; interpretatio Mars',2,false,false,'A Treveran healing and tribal war-god (Mars Lenus), worshipped at Trier and at Caerwent in Britain; consort of Ancamna.')
ON CONFLICT (entity_id) DO NOTHING;

-- ---- Romano-British (new tradition tag 'Celtic/British') ----
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_BRI_NODENS','Nodens','Celtic/British','God','Healing/hunt god','healing; hunting; the sea; dogs','regional','A','candidate_verified_name','RIB 305-307 (Lydney)',2,false,false,'A Romano-British healing, hunting and sea god (the Lydney Park temple, with its dogs), equated with Mars/Silvanus; ancestor of Irish Nuada and Welsh Nudd/Lludd.'),
 ('ENT_BRI_SULIS','Sulis','Celtic/British','Goddess','Healing/spring goddess','the hot springs of Bath; healing; cursing and justice','regional','A','candidate_verified_name','RIB curse tablets (Bath)',3,false,false,'Goddess of the hot springs of Bath (Aquae Sulis), equated with Minerva; her sacred spring received ~130 curse-tablets seeking justice.'),
 ('ENT_BRI_COVENTINA','Coventina','Celtic/British','Goddess','Goddess of wells','sacred wells and springs','local','A','candidate_verified_name','RIB 1522-1535 (Carrawburgh)',3,false,false,'Goddess of the sacred well at Carrawburgh on Hadrian''s Wall, honoured with thousands of votive offerings.'),
 ('ENT_BRI_BRIGANTIA','Brigantia','Celtic/British','Goddess','Tutelary/sovereignty goddess','the Brigantes; sovereignty; victory','regional','A','candidate_verified_name','RIB 627, 628, 1131',2,false,false,'Tutelary sovereignty goddess of the Brigantes of northern Britain (Victoria/Caelestis Brigantia), cognate with (but distinct from) Irish Brigid.'),
 ('ENT_BRI_ANDRASTE','Andraste','Celtic/British','Goddess','War/victory goddess','war; victory; sovereignty','regional','B','candidate_verified_name','Cassius Dio 62.6-7',1,false,false,'A war and victory goddess invoked by Boudica of the Iceni (per Cassius Dio); equated with Victoria.'),
 ('ENT_BRI_COCIDIUS','Cocidius','Celtic/British','God','War/hunt god','war; hunting; the forest','regional','A','candidate_verified_name','RIB 2015; ~25 inscriptions',3,false,false,'A war and hunting god of the north-western frontier (Fanum Cocidi, Bewcastle), equated with Mars and Silvanus; paired with Belatucadros.'),
 ('ENT_BRI_BELATUCADROS','Belatucadros','Celtic/British','God','War god','war','regional','B','candidate_verified_name','RIB; ~28 inscriptions',1,false,false,'A war-god of the western Hadrian''s Wall zone ("Fair Shining One"), favoured by lower-ranking soldiers, equated with Mars.'),
 ('ENT_BRI_ANTENOCITICUS','Antenociticus','Celtic/British','God','Tutelary god','military advancement; local patronage','local','B','candidate_verified_name','RIB 1327-1329 (Benwell)',1,false,false,'A local tutelary god of Benwell (Condercum) on Hadrian''s Wall, invoked for military advancement.'),
 ('ENT_BRI_VINOTONUS','Vinotonus','Celtic/British','God','Woodland god','the moor and woodland','local','C','candidate_verified_name','RIB 732, 733 (Scargill Moor)',4,false,false,'A local woodland/moorland god of Scargill Moor near Bowes, equated with Silvanus.')
ON CONFLICT (entity_id) DO NOTHING;

-- sources
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_GREEN_CELTIC_GODS','scholarly attestation','Aldhouse-Green, The Gods of the Celts.'
FROM entities WHERE tradition IN ('Celtic/Gaulish','Celtic/British') AND review_status='candidate_verified_name'
  AND (entity_id LIKE 'ENT_BRI_%' OR entity_id IN ('ENT_CEL_BELENUS','ENT_CEL_GRANNUS','ENT_CEL_SIRONA','ENT_CEL_BORVO','ENT_CEL_DAMONA','ENT_CEL_NEMAUSUS','ENT_CEL_SEQUANA','ENT_CEL_RITONA','ENT_CEL_LITAVIS','ENT_CEL_BELISAMA','ENT_CEL_OGMIOS','ENT_CEL_CATHUBODUA','ENT_CEL_CAMULOS','ENT_CEL_ABNOBA','ENT_CEL_ARDUINNA','ENT_CEL_ARTIO','ENT_CEL_VOSEGUS','ENT_CEL_SMERTRIOS','ENT_CEL_UCUETIS','ENT_CEL_LENUS'))
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_RIB','inscriptional attestation','Attested in the Roman Inscriptions of Britain.'
FROM entities WHERE entity_id IN ('ENT_BRI_NODENS','ENT_BRI_SULIS','ENT_BRI_COVENTINA','ENT_BRI_BRIGANTIA','ENT_BRI_COCIDIUS','ENT_BRI_BELATUCADROS','ENT_BRI_ANTENOCITICUS','ENT_BRI_VINOTONUS','ENT_CEL_CAMULOS','ENT_CEL_LENUS')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_CIL','inscriptional attestation','Attested in the Corpus Inscriptionum Latinarum.'
FROM entities WHERE entity_id IN ('ENT_CEL_BELENUS','ENT_CEL_GRANNUS','ENT_CEL_SIRONA','ENT_CEL_BORVO','ENT_CEL_DAMONA','ENT_CEL_NEMAUSUS','ENT_CEL_SEQUANA','ENT_CEL_RITONA','ENT_CEL_LITAVIS','ENT_CEL_BELISAMA','ENT_CEL_CATHUBODUA','ENT_CEL_ABNOBA','ENT_CEL_ARDUINNA','ENT_CEL_ARTIO','ENT_CEL_VOSEGUS','ENT_CEL_SMERTRIOS','ENT_CEL_UCUETIS')
ON CONFLICT DO NOTHING;

-- periods: Celtic Iron Age / Gallo-Roman -> PER_CEL_IRON_AGE (Gaulish) ; British -> PER_ROM_IMPERIAL (Romano-British)
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_CEL_IRON_AGE','B','Gaulish/Gallo-Roman deity of the Celtic Iron Age and Roman-period inscriptions.','SRC_GREEN_CELTIC_GODS','reviewed'
FROM entities WHERE tradition='Celtic/Gaulish' AND review_status='candidate_verified_name'
  AND entity_id IN ('ENT_CEL_BELENUS','ENT_CEL_GRANNUS','ENT_CEL_SIRONA','ENT_CEL_BORVO','ENT_CEL_DAMONA','ENT_CEL_NEMAUSUS','ENT_CEL_SEQUANA','ENT_CEL_RITONA','ENT_CEL_LITAVIS','ENT_CEL_BELISAMA','ENT_CEL_OGMIOS','ENT_CEL_CATHUBODUA','ENT_CEL_CAMULOS','ENT_CEL_ABNOBA','ENT_CEL_ARDUINNA','ENT_CEL_ARTIO','ENT_CEL_VOSEGUS','ENT_CEL_SMERTRIOS','ENT_CEL_UCUETIS','ENT_CEL_LENUS')
ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_ROM_IMPERIAL','B','Romano-British deity of the Roman Imperial period inscriptions.','SRC_RIB','reviewed'
FROM entities WHERE tradition='Celtic/British'
ON CONFLICT DO NOTHING;

-- relationships: interpretatio + consort + cognate links
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_CEL_BELENUS','syncretized_with','ENT_ROM_APOLLO','high','Worshipped as Apollo Belenus.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_GRANNUS','syncretized_with','ENT_ROM_APOLLO','high','Worshipped as Apollo Grannus.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_BORVO','syncretized_with','ENT_ROM_APOLLO','high','Worshipped as Apollo Borvo.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_GRANNUS','consort_of','ENT_CEL_SIRONA','high','Apollo Grannus and Sirona, a healing-spring divine couple.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_BORVO','consort_of','ENT_CEL_DAMONA','high','Borvo and Damona, a healing-spring divine couple.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_BELISAMA','syncretized_with','ENT_ROM_MINERVA','high','Worshipped as Minerva Belisama.','SRC_CIL','reviewed'),
 ('ENT_CEL_CAMULOS','syncretized_with','ENT_ROM_MARS','high','Worshipped as Mars Camulos.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_LENUS','syncretized_with','ENT_ROM_MARS','high','Worshipped as Mars Lenus.','SRC_RIB','reviewed'),
 ('ENT_CEL_ABNOBA','syncretized_with','ENT_ROM_DIANA','high','Worshipped as Diana Abnoba.','SRC_CIL','reviewed'),
 ('ENT_CEL_ARDUINNA','syncretized_with','ENT_ROM_DIANA','high','Worshipped as Diana Arduinna.','SRC_CIL','reviewed'),
 ('ENT_CEL_OGMIOS','syncretized_with','ENT_HERACLES','high','Depicted by Lucian as a Gaulish Heracles of eloquence.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_OGMIOS','aligned_with','ENT_CEL_OGMA','medium','Often compared (debated) with the Irish god Ogma.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_SMERTRIOS','aligned_with','ENT_CEL_ROSMERTA','low','Name-kin of Rosmerta ("the provider").','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_CEL_NEMAUSUS','associated_with','ENT_CEL_MATRES','medium','Linked to the Matres Nemausicae of the Nîmes spring.','SRC_CIL','reviewed'),
 ('ENT_BRI_SULIS','syncretized_with','ENT_ROM_MINERVA','high','Worshipped as Sulis Minerva at Bath.','SRC_RIB','reviewed'),
 ('ENT_BRI_NODENS','syncretized_with','ENT_ROM_MARS','high','Worshipped as Mars Nodens at Lydney.','SRC_RIB','reviewed'),
 ('ENT_BRI_BRIGANTIA','syncretized_with','ENT_ROM_VICTORIA','high','Worshipped as Victoria Brigantia.','SRC_RIB','reviewed'),
 ('ENT_BRI_BRIGANTIA','aligned_with','ENT_CEL_BRIGID','medium','Brittonic cognate of (but distinct from) Irish Brigid.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_BRI_ANDRASTE','syncretized_with','ENT_ROM_VICTORIA','medium','Equated with Victoria; invoked by Boudica.','SRC_GREEN_CELTIC_GODS','reviewed'),
 ('ENT_BRI_COCIDIUS','syncretized_with','ENT_ROM_MARS','high','Worshipped as Mars Cocidius.','SRC_RIB','reviewed'),
 ('ENT_BRI_BELATUCADROS','syncretized_with','ENT_ROM_MARS','high','Worshipped as Mars Belatucadros.','SRC_RIB','reviewed'),
 ('ENT_BRI_COCIDIUS','paired_with','ENT_BRI_BELATUCADROS','medium','The two north-British war-gods often invoked in the same zone.','SRC_RIB','reviewed'),
 ('ENT_BRI_NODENS','aligned_with','ENT_CEL_NUADA','medium','Nodens is the ancestor-form of Irish Nuada and Welsh Nudd/Lludd.','SRC_GREEN_CELTIC_GODS','reviewed')
ON CONFLICT DO NOTHING;

-- homonym register: Brigantia (British) vs Brigid (Irish) — cognate but distinct
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Brigantia','ENT_BRI_BRIGANTIA','Brigantia (British tutelary goddess) and Brigid (Irish) are cognate reflexes of a common Celtic *Brigantī but are distinct cult figures.','intentional_distinct')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Gaulish + British counts =='
SELECT tradition, count(*) FROM entities WHERE tradition IN ('Celtic/Gaulish','Celtic/British') GROUP BY tradition;
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
