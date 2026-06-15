-- =====================================================================
-- deepen_celtic_irish.sql  (v1.59.0 batch)
-- Celtic/Irish 12 -> ~46. The Tuatha Dé Danann, the Fomorians, and the
-- sovereignty/war/land goddesses of the medieval Irish corpus (Lebor
-- Gabála Érenn, Cath Maige Tuired, the Metrical Dindshenchas).
-- Human heroes / late-antiquarian / purely-allegorical figures excluded.
-- Additive; ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_LEBOR_GABALA','Lebor Gabála Érenn (The Book of the Taking of Ireland), ed./trans. R. A. S. Macalister (ITS, 1938-56)',NULL,'primary text','Irish mythological pseudo-history'),
 ('SRC_CATH_MAIGE_TUIRED','Cath Maige Tuired (The Second Battle of Mag Tuired), ed. E. A. Gray (ITS, 1982)',NULL,'primary text','Irish mythological cycle'),
 ('SRC_MACKILLOP_CELTIC','James MacKillop, Dictionary of Celtic Mythology (Oxford University Press, 1998)',NULL,'secondary scholarship','Celtic mythology')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_CEL_BADB','Badb','Celtic/Irish','War goddess','The Morrígna','war; the battle-crow; prophecy of slaughter','mythological','A','candidate_verified_name','Cath Maige Tuired',1,false,false,'War-goddess, the "battle-crow," one of the Morrígna; daughter of Ernmas.'),
 ('ENT_CEL_MACHA','Macha','Celtic/Irish','War goddess','The Morrígna','war; sovereignty; horses; the land of Ulster','mythological','A','candidate_verified_name','Cath Maige Tuired; Dindshenchas',2,false,false,'War and sovereignty goddess bound to Ulster kingship; one of the Morrígna, daughter of Ernmas.'),
 ('ENT_CEL_NEMAIN','Nemain','Celtic/Irish','War goddess','The Morrígna','the frenzy and havoc of battle','mythological','A','candidate_verified_name','Cath Maige Tuired',0,false,false,'Goddess personifying the frenzy of war; sometimes consort of Néit; counted among the Morrígna.'),
 ('ENT_CEL_ERNMAS','Ernmas','Celtic/Irish','Mother goddess','Tuatha Dé Danann','ancestral motherhood','mythological','A','candidate_verified_name','Lebor Gabála Érenn',2,false,false,'Mother-goddess of the Tuatha Dé Danann; mother of the Morrígna (Badb, Macha, Morrígan) and of Ériu, Banba, and Fódla.'),
 ('ENT_CEL_ERIU','Ériu','Celtic/Irish','Sovereignty goddess','Tuatha Dé Danann','the sovereignty of Ireland','mythological','A','candidate_verified_name','Lebor Gabála Érenn',3,false,false,'Eponymous sovereignty goddess of Ireland (Éire); daughter of Ernmas, wife of Mac Gréine; mother of Bres by Elatha.'),
 ('ENT_CEL_BANBA','Banba','Celtic/Irish','Sovereignty goddess','Tuatha Dé Danann','the sovereignty of Ireland','mythological','A','candidate_verified_name','Lebor Gabála Érenn',3,false,false,'Sovereignty goddess and poetic name for Ireland; daughter of Ernmas, wife of Mac Cuill.'),
 ('ENT_CEL_FODLA','Fódla','Celtic/Irish','Sovereignty goddess','Tuatha Dé Danann','the sovereignty of Ireland','mythological','A','candidate_verified_name','Lebor Gabála Érenn',3,false,false,'Sovereignty goddess and poetic name for Ireland; daughter of Ernmas, wife of Mac Cecht.'),
 ('ENT_CEL_DANU','Danu','Celtic/Irish','Mother goddess','Tuatha Dé Danann','ancestral motherhood; the divine race','mythological','B','candidate_verified_name','Lebor Gabála Érenn',2,false,false,'The ancestral mother-goddess (Danu/Anu) from whom the Tuatha Dé Danann ("People of the goddess Danu") take their name.'),
 ('ENT_CEL_BOANN','Boann','Celtic/Irish','River goddess','Tuatha Dé Danann','the River Boyne; cattle; inspiration','mythological','A','candidate_verified_name','Metrical Dindshenchas',3,false,false,'Goddess of the River Boyne; consort of the Dagda and mother of Aengus; wife of Elcmar/Nechtan.'),
 ('ENT_CEL_LIR','Lir','Celtic/Irish','Sea god','Tuatha Dé Danann','the sea','mythological','A','candidate_verified_name','Oidheadh Chlainne Lir',2,false,false,'Sea-god and ancestor figure, father of Manannán mac Lir; central to the tale of the Children of Lir.'),
 ('ENT_CEL_BODBDERG','Bodb Derg','Celtic/Irish','God','Tuatha Dé Danann','kingship of the síde','mythological','A','candidate_verified_name','Children of Lir',1,false,false,'Son of the Dagda, elected King of the Tuatha Dé Danann after their defeat; a síd-lord.'),
 ('ENT_CEL_MIDIR','Midir','Celtic/Irish','God','Tuatha Dé Danann','the Otherworld; the síd of Brí Léith','mythological','A','candidate_verified_name','Tochmarc Étaíne',1,true,false,'Son of the Dagda, lord of the síd of Brí Léith; husband of Fúamnach and lover of Étaín.'),
 ('ENT_CEL_ETAIN','Étaín','Celtic/Irish','Goddess','Tuatha Dé Danann','the Otherworld; sovereignty; (a sun-radiance)','mythological','A','candidate_verified_name','Tochmarc Étaíne',1,false,false,'Otherworld woman, possibly a euhemerised sun/sovereignty goddess; heroine of the Wooing of Étaín, wife of Midir.'),
 ('ENT_CEL_ELCMAR','Elcmar','Celtic/Irish','God','Tuatha Dé Danann','the Brú na Bóinne','mythological','B','candidate_verified_name','Tochmarc Étaíne',1,true,false,'Síd-lord of Brú na Bóinne, husband/guardian of Boann, displaced from the Brú by Aengus.'),
 ('ENT_CEL_CERMAIT','Cermait','Celtic/Irish','God','Tuatha Dé Danann','eloquence','mythological','B','candidate_verified_name','Lebor Gabála Érenn',0,false,false,'Son of the Dagda; father of the three last Tuatha Dé kings (Mac Cuill, Mac Cecht, Mac Gréine).'),
 ('ENT_CEL_DONN','Donn','Celtic/Irish','God of the dead','Tuatha Dé Danann (Milesian)','death; the assembly of the dead','mythological','A','candidate_verified_name','Metrical Dindshenchas',2,true,false,'God of the dead, the first Milesian to die, who rules Tech Duinn ("the House of Donn"), the gathering-place of the dead.'),
 ('ENT_CEL_CREDNE','Credne','Celtic/Irish','Craft god','The three craft-gods','metalworking; bronze; fittings','mythological','A','candidate_verified_name','Cath Maige Tuired',2,false,false,'The bronze-worker (cerd) of the Tuatha Dé Danann, one of the three craft-gods with Goibniu and Luchta.'),
 ('ENT_CEL_LUCHTA','Luchta','Celtic/Irish','Craft god','The three craft-gods','carpentry; shields and spear-shafts','mythological','A','candidate_verified_name','Cath Maige Tuired',2,false,false,'The wright/carpenter of the Tuatha Dé Danann, one of the three craft-gods who armed the host at Mag Tuired.'),
 ('ENT_CEL_FLIDAIS','Flidais','Celtic/Irish','Goddess','Tuatha Dé Danann','cattle; abundance; the hunt','mythological','B','candidate_verified_name','Metrical Dindshenchas',3,false,false,'Goddess of cattle, wild abundance, and the hunt; mother of Fand in some texts.'),
 ('ENT_CEL_AINE','Áine','Celtic/Irish','Goddess','Provincial goddess','summer; sovereignty; sun; wealth','mythological','A','candidate_verified_name','Metrical Dindshenchas',3,false,false,'Goddess of summer, sovereignty, and prosperity, of Cnoc Áine in Munster.'),
 ('ENT_CEL_CLIODHNA','Clíodhna','Celtic/Irish','Goddess','Provincial goddess','the Otherworld; sovereignty; the sea-wave','mythological','B','candidate_verified_name','Metrical Dindshenchas',2,false,false,'A Munster Otherworld and sovereignty goddess; the "wave of Clíodhna" at Glandore.'),
 ('ENT_CEL_FAND','Fand','Celtic/Irish','Goddess','Otherworld','the sea; the Otherworld','mythological','B','candidate_verified_name','Serglige Con Culainn',2,false,false,'Otherworld/sea-goddess, wife of Manannán mac Lir, who loves Cú Chulainn in the Wasting Sickness.'),
 ('ENT_CEL_BALOR','Balor','Celtic/Irish','Fomorian','Fomorians','the baleful eye; blight; death','mythological','A','candidate_verified_name','Cath Maige Tuired',1,false,false,'Fomorian champion-king "of the Baleful Eye," whose gaze slays; killed by his grandson Lugh at Mag Tuired.'),
 ('ENT_CEL_BRES','Bres','Celtic/Irish','God-king','Tuatha Dé / Fomorian','sovereignty (unjust); agriculture','mythological','A','candidate_verified_name','Cath Maige Tuired',2,false,false,'Half-Fomorian king of the Tuatha Dé, son of Elatha and Ériu, husband of Brigid; his miserly rule triggers the Second Battle.'),
 ('ENT_CEL_ELATHA','Elatha','Celtic/Irish','Fomorian','Fomorians','kingship','mythological','B','candidate_verified_name','Cath Maige Tuired',0,false,false,'A Fomorian prince/king, father of Bres by the goddess Ériu.'),
 ('ENT_CEL_INDECH','Indech','Celtic/Irish','Fomorian','Fomorians','war','mythological','B','candidate_verified_name','Cath Maige Tuired',0,false,false,'A Fomorian king who, with Balor, leads the host at the Second Battle of Mag Tuired.'),
 ('ENT_CEL_CETHLENN','Cethlenn','Celtic/Irish','Fomorian','Fomorians','prophecy','mythological','B','candidate_verified_name','Cath Maige Tuired',0,false,false,'Fomorian prophetess, wife of Balor and mother of Ethniu; she foretells the Fomorian defeat.'),
 ('ENT_CEL_TETHRA','Tethra','Celtic/Irish','Fomorian','Fomorians','the sea; rule over the dead (Mag Mell)','mythological','B','candidate_verified_name','Lebor Gabála Érenn',2,true,false,'A Fomorian king associated with the sea and rule over the dead in Mag Mell; his sword Orna is taken at Mag Tuired.'),
 ('ENT_CEL_NEIT','Néit','Celtic/Irish','War god','Tuatha Dé / Fomorian','war','mythological','B','candidate_verified_name','Cath Maige Tuired; Cormac''s Glossary',0,false,false,'An ancient war-god straddling the Tuatha Dé and Fomorians; grandfather of Balor, consort of Nemain (or Badb).'),
 ('ENT_CEL_CIAN','Cían','Celtic/Irish','God','Tuatha Dé Danann','(father of Lugh)','mythological','A','candidate_verified_name','Cath Maige Tuired',0,false,false,'Son of Dian Cécht; father of Lugh by Ethniu; slain by the sons of Tuireann.'),
 ('ENT_CEL_ETHNIU','Ethniu','Celtic/Irish','Goddess','Fomorian / Tuatha Dé','(mother of Lugh)','mythological','A','candidate_verified_name','Cath Maige Tuired',0,false,false,'Daughter of Balor and Cethlenn; mother of Lugh by Cían — the union that bridges Fomorians and Tuatha Dé.'),
 ('ENT_CEL_BRIAN','Brian','Celtic/Irish','God','Sons of Tuireann','craft; the heroic quest','mythological','B','candidate_verified_name','Oidheadh Chlainne Tuireann',0,false,false,'Eldest of the three sons of Tuireann who slay Cían and perform the great quest for Lugh''s blood-fine.'),
 ('ENT_CEL_IUCHAR','Iuchar','Celtic/Irish','God','Sons of Tuireann','the heroic quest','mythological','B','candidate_verified_name','Oidheadh Chlainne Tuireann',0,false,false,'One of the three sons of Tuireann, brother of Brian and Iucharba.'),
 ('ENT_CEL_IUCHARBA','Iucharba','Celtic/Irish','God','Sons of Tuireann','the heroic quest','mythological','B','candidate_verified_name','Oidheadh Chlainne Tuireann',0,false,false,'One of the three sons of Tuireann, brother of Brian and Iuchar.')
ON CONFLICT (entity_id) DO NOTHING;

-- sources
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_MACKILLOP_CELTIC','scholarly attestation','MacKillop, Dictionary of Celtic Mythology.'
FROM entities WHERE tradition='Celtic/Irish' AND review_status='candidate_verified_name' AND entity_id LIKE 'ENT_CEL_%'
  AND entity_id NOT IN ('ENT_CEL_AENGUS','ENT_CEL_BRIGID','ENT_CEL_DAGDA','ENT_CEL_DIANCECHT','ENT_CEL_FOMORIANS','ENT_CEL_GOIBNIU','ENT_CEL_LUGH','ENT_CEL_MANANNAN','ENT_CEL_MORRIGAN','ENT_CEL_NUADA','ENT_CEL_OGMA','ENT_CEL_TUATHA')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_CATH_MAIGE_TUIRED','direct attestation','Named in Cath Maige Tuired.'
FROM entities WHERE entity_id IN ('ENT_CEL_BADB','ENT_CEL_MACHA','ENT_CEL_NEMAIN','ENT_CEL_CREDNE','ENT_CEL_LUCHTA','ENT_CEL_BALOR','ENT_CEL_BRES','ENT_CEL_ELATHA','ENT_CEL_INDECH','ENT_CEL_CETHLENN','ENT_CEL_NEIT','ENT_CEL_CIAN','ENT_CEL_ETHNIU')
ON CONFLICT DO NOTHING;
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT entity_id,'SRC_LEBOR_GABALA','direct attestation','Named in Lebor Gabála Érenn.'
FROM entities WHERE entity_id IN ('ENT_CEL_ERNMAS','ENT_CEL_ERIU','ENT_CEL_BANBA','ENT_CEL_FODLA','ENT_CEL_DANU','ENT_CEL_CERMAIT','ENT_CEL_TETHRA','ENT_CEL_LIR')
ON CONFLICT DO NOTHING;

-- periods
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT entity_id,'PER_CEL_MEDIEVAL_IRISH','A','Attested in the medieval Irish mythological corpus (pre-Christian deities preserved in Christian-era texts).','SRC_MACKILLOP_CELTIC','reviewed'
FROM entities WHERE tradition='Celtic/Irish' AND review_status='candidate_verified_name' AND entity_id LIKE 'ENT_CEL_%'
  AND entity_id NOT IN ('ENT_CEL_AENGUS','ENT_CEL_BRIGID','ENT_CEL_DAGDA','ENT_CEL_DIANCECHT','ENT_CEL_FOMORIANS','ENT_CEL_GOIBNIU','ENT_CEL_LUGH','ENT_CEL_MANANNAN','ENT_CEL_MORRIGAN','ENT_CEL_NUADA','ENT_CEL_OGMA','ENT_CEL_TUATHA')
ON CONFLICT DO NOTHING;

-- relationships: the family/myth graph
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_CEL_BADB','member_of','ENT_CEL_MORRIGAN','medium','One of the Morrígna, the triad headed by the Morrígan.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_MACHA','member_of','ENT_CEL_MORRIGAN','medium','One of the Morrígna.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_NEMAIN','member_of','ENT_CEL_MORRIGAN','medium','One of the Morrígna.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_BADB','child_of','ENT_CEL_ERNMAS','high','Daughter of Ernmas.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_MACHA','child_of','ENT_CEL_ERNMAS','high','Daughter of Ernmas.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_MORRIGAN','child_of','ENT_CEL_ERNMAS','high','Daughter of Ernmas.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_ERIU','child_of','ENT_CEL_ERNMAS','high','Daughter of Ernmas.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_BANBA','child_of','ENT_CEL_ERNMAS','high','Daughter of Ernmas.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_FODLA','child_of','ENT_CEL_ERNMAS','high','Daughter of Ernmas.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_ERIU','member_of','ENT_CEL_TUATHA','high','Of the Tuatha Dé Danann.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_BANBA','member_of','ENT_CEL_TUATHA','high','Of the Tuatha Dé Danann.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_FODLA','member_of','ENT_CEL_TUATHA','high','Of the Tuatha Dé Danann.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_BOANN','consort_of','ENT_CEL_DAGDA','high','Boann bore Aengus to the Dagda.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_AENGUS','child_of','ENT_CEL_BOANN','high','Son of Boann and the Dagda.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_BOANN','consort_of','ENT_CEL_ELCMAR','medium','Wife of Elcmar of the Brú.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_BODBDERG','child_of','ENT_CEL_DAGDA','high','Son of the Dagda.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_MIDIR','child_of','ENT_CEL_DAGDA','high','Son of the Dagda.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_CERMAIT','child_of','ENT_CEL_DAGDA','high','Son of the Dagda.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_MIDIR','consort_of','ENT_CEL_ETAIN','high','Husband of Étaín.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_MANANNAN','child_of','ENT_CEL_LIR','high','Manannán mac Lir, son of Lir.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_FAND','consort_of','ENT_CEL_MANANNAN','high','Wife of Manannán mac Lir.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_CREDNE','member_of','ENT_CEL_TUATHA','high','One of the three craft-gods.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_LUCHTA','member_of','ENT_CEL_TUATHA','high','One of the three craft-gods.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_BALOR','member_of','ENT_CEL_FOMORIANS','high','Fomorian champion.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_ELATHA','member_of','ENT_CEL_FOMORIANS','high','Fomorian prince.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_INDECH','member_of','ENT_CEL_FOMORIANS','high','Fomorian king.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_CETHLENN','member_of','ENT_CEL_FOMORIANS','high','Fomorian prophetess.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_TETHRA','member_of','ENT_CEL_FOMORIANS','high','Fomorian king of the dead.','SRC_LEBOR_GABALA','reviewed'),
 ('ENT_CEL_BALOR','consort_of','ENT_CEL_CETHLENN','high','Husband of Cethlenn.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_ETHNIU','child_of','ENT_CEL_BALOR','high','Daughter of Balor and Cethlenn.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_CIAN','child_of','ENT_CEL_DIANCECHT','high','Son of Dian Cécht.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_LUGH','child_of','ENT_CEL_CIAN','high','Lugh, son of Cían and Ethniu.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_LUGH','child_of','ENT_CEL_ETHNIU','high','Lugh, son of Ethniu (and grandson of Balor).','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_LUGH','slays','ENT_CEL_BALOR','high','Lugh slays his grandfather Balor at the Second Battle of Mag Tuired.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_BRES','child_of','ENT_CEL_ELATHA','high','Son of Elatha.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_BRES','child_of','ENT_CEL_ERIU','high','Son of Ériu.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_BRES','consort_of','ENT_CEL_BRIGID','high','Husband of Brigid.','SRC_CATH_MAIGE_TUIRED','reviewed'),
 ('ENT_CEL_BALOR','child_of','ENT_CEL_NEIT','medium','Balor of the line of Néit.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_BRIAN','sibling_of','ENT_CEL_IUCHAR','high','One of the three sons of Tuireann.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_IUCHAR','sibling_of','ENT_CEL_IUCHARBA','high','One of the three sons of Tuireann.','SRC_MACKILLOP_CELTIC','reviewed'),
 ('ENT_CEL_BRIAN','slays','ENT_CEL_CIAN','high','The sons of Tuireann kill Cían.','SRC_MACKILLOP_CELTIC','reviewed')
ON CONFLICT DO NOTHING;

COMMIT;
\echo '== Celtic/Irish count (expect ~46) =='
SELECT count(*) FROM entities WHERE tradition='Celtic/Irish';
SELECT unreviewed_duplicates, unresolved_relationships FROM v_release_metrics;
