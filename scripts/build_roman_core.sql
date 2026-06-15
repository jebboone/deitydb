-- scripts/build_roman_core.sql
-- Content normalization VI (v1.48.0): Roman build-out. The DB had the Dii Consentes core
-- but was thin on the distinctively Roman strata: the deified state-virtues (Fortuna,
-- Victoria, Pax...), the rustic gods (Faunus, Silvanus, Flora), the late-antique solar
-- and Magna Mater cults, and the deified emperors (the imperial cult — humans raised to
-- godhood, squarely within the methodology). Roman 23 -> 43; each to a primary Latin
-- source (Ovid, Livy, Cicero, Varro, Catullus, Suetonius, the inscriptions).

BEGIN;

-- ── New Latin sources (Ovid/Livy/Varro/Cicero/Virgil/Apuleius already registered) ─
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_CIL','Corpus Inscriptionum Latinarum (Latin votive and dedicatory inscriptions)','','primary inscription/artifact','The epigraphic record of Roman cult: dedications to Silvanus, Sol Invictus, the Magna Mater, Dea Roma'),
('SRC_SUETONIUS','Suetonius, De Vita Caesarum (Lives of the Caesars), c. 121 CE','','primary text','The imperial biographies; the deification of the Caesars'),
('SRC_CATULLUS','Catullus, Carmina, c. 54 BCE','','primary text','The Neoteric poems; Carmen 63 on Attis and the Magna Mater')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- the deified state-virtues
 ('ENT_ROM_FORTUNA','Fortuna','Roman','Goddess','Personified virtue','fortune; chance; the destiny of persons and the state','Roman','A','candidate_verified_name','Major Roman cult',0,false,false,'The goddess of fortune and chance, with many cults (Fors Fortuna, Fortuna Primigenia).'),
 ('ENT_ROM_VICTORIA','Victoria','Roman','Goddess','Personified virtue','victory; military triumph; the fortune of the state','Roman','A','candidate_verified_name','Major Roman cult',0,false,false,'The goddess of victory, whose altar stood in the Senate house.'),
 ('ENT_ROM_FIDES','Fides','Roman','Goddess','Personified virtue','good faith; oaths; sworn fidelity','Roman','A','candidate_verified_name','Ancient Roman cult',0,false,false,'The goddess of good faith and the sanctity of oaths, one of the oldest Roman cults.'),
 ('ENT_ROM_CONCORDIA','Concordia','Roman','Goddess','Personified virtue','civic harmony; agreement','Roman','A','candidate_verified_name','Roman state cult',0,false,false,'The goddess of concord and civic harmony, with a temple in the Forum.'),
 ('ENT_ROM_SALUS','Salus','Roman','Goddess','Personified virtue','health; welfare; the safety of the state','Roman','A','candidate_verified_name','Roman state cult',0,false,false,'The goddess of health and the welfare of the Roman state.'),
 ('ENT_ROM_SPES','Spes','Roman','Goddess','Personified virtue','hope','Roman','A','candidate_verified_name','Roman cult',0,false,false,'The goddess of hope, especially hope for the harvest and for posterity.'),
 ('ENT_ROM_PAX','Pax','Roman','Goddess','Personified virtue','peace; the peace of the empire','Roman','A','candidate_verified_name','Augustan state cult',0,false,false,'The goddess of peace, honoured at the Ara Pacis Augustae.'),
 ('ENT_ROM_LIBERTAS','Libertas','Roman','Goddess','Personified virtue','liberty; civic freedom','Roman','A','candidate_verified_name','Roman cult',0,false,false,'The goddess of liberty and civic freedom, with a temple on the Aventine.'),
 ('ENT_ROM_PIETAS','Pietas','Roman','Goddess','Personified virtue','dutiful devotion to gods, family and state','Roman','A','candidate_verified_name','Roman cult',0,false,false,'The goddess of pietas, dutiful devotion to the gods, the family and the fatherland.'),
 ('ENT_ROM_VIRTUS','Virtus','Roman','Deity','Personified virtue','valour; martial courage','Roman','A','candidate_verified_name','Roman cult',0,false,false,'The deity of valour and martial courage, twinned with Honos.'),
 ('ENT_ROM_ROMA','Roma','Roman','Goddess','Deified city','the city and empire of Rome personified','Roman','A','candidate_verified_name','Imperial state cult',0,false,false,'Dea Roma, the personified and deified city of Rome, central to the imperial cult.'),
 -- the rustic gods (NB: Faunus, Silvanus, Flora and Ops already exist under the
 -- Italic/Sabine tradition, their proper archaic home — they are enriched below with
 -- this pass's primary sourcing rather than duplicated here.)
 ('ENT_ROM_POMONA','Pomona','Roman','Goddess','Orchard deity','fruit trees; orchards; the harvest of fruit','Roman','A','candidate_verified_name','Old Italic cult',2,false,false,'The goddess of fruit trees and orchards, wooed by Vertumnus.'),
 ('ENT_ROM_VERTUMNUS','Vertumnus','Roman','God','Deity of change','the seasons; ripening; transformation','Roman','A','candidate_verified_name','Etrusco-Roman cult',1,false,false,'The god of seasons, change and ripening, who wins Pomona by shapeshifting.'),
 ('ENT_ROM_TELLUS','Tellus','Roman','Goddess','Earth deity','the earth; fertility; the dead','Roman','A','candidate_verified_name','Old Italic cult',5,true,false,'Tellus Mater, the Earth goddess of fertility and the receiving ground of the dead.'),
 -- war
 ('ENT_ROM_BELLONA','Bellona','Roman','Goddess','War deity','war; martial frenzy','Roman','A','candidate_verified_name','Roman war cult',0,false,false,'The goddess of war, before whose temple foreign envoys and war-declarations were received.'),
 -- the late-antique solar and Magna Mater cults
 ('ENT_ROM_SOL_INVICTUS','Sol Invictus','Roman','Solar deity','Imperial sun god','the unconquered sun; imperial victory','Roman','A','candidate_verified_name','Late imperial state cult',0,false,false,'The Unconquered Sun, made a chief god of the state by Aurelian in 274 CE.'),
 ('ENT_ROM_MAGNA_MATER','Magna Mater','Roman','Mother goddess','Great Mother','the mountains; wild nature; the protection of Rome','Roman','A','candidate_verified_name','State cult (from 204 BCE)',1,false,false,'The Great Mother (Cybele), brought to Rome in 204 BCE and served by the galli.'),
 ('ENT_ROM_ATTIS','Attis','Roman','God','Consort of the Great Mother','death and rebirth; vegetation; the galli','Roman','A','candidate_verified_name','Cult of the Magna Mater',1,false,false,'The youthful consort of the Magna Mater, whose self-castration and death the galli reenact.'),
 ('ENT_ROM_DIVUS_JULIUS','Divus Julius','Roman','Deified emperor','Imperial cult','the deified Caesar; the comet-soul; state divinity','Roman','A','candidate_verified_name','Imperial cult (deified human)',0,false,false,'The deified Julius Caesar, whose soul was seen as the sidus Iulium (the comet).'),
 ('ENT_ROM_DIVUS_AUGUSTUS','Divus Augustus','Roman','Deified emperor','Imperial cult','the deified Augustus; the genius of the princeps','Roman','A','candidate_verified_name','Imperial cult (deified human)',0,false,false,'The deified Augustus, founder of the imperial cult observed across the empire.'),
 -- love
 ('ENT_ROM_CUPID','Cupid','Roman','God','Love deity','desire; love; the arrows of passion','Roman','A','candidate_verified_name','Roman love-god',0,false,false,'Cupid (Amor), the boy-god of desire, son of Venus and lover of Psyche.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_ROM_FORTUNA','SRC_OVID_FASTI','Direct attestation','Ovid, Fasti 6.569-636: the temple and rites of Fortuna (Fors Fortuna).'),
 ('ENT_ROM_VICTORIA','SRC_LIVY_AUC','Direct attestation','Livy 10.33; 29.14: the temple and cult of Victoria on the Palatine.'),
 ('ENT_ROM_FIDES','SRC_CICERO_DE_NATURA','Direct attestation','Cicero, De Natura Deorum 2.61: Fides among the deified virtues with a public cult.'),
 ('ENT_ROM_CONCORDIA','SRC_OVID_FASTI','Direct attestation','Ovid, Fasti 1.637-650; 3.881-882: the temple of Concordia in the Forum.'),
 ('ENT_ROM_SALUS','SRC_LIVY_AUC','Direct attestation','Livy 9.43; 10.1: the temple of Salus on the Quirinal.'),
 ('ENT_ROM_SPES','SRC_CICERO_DE_NATURA','Direct attestation','Cicero, De Natura Deorum 2.61: Spes (Hope) among the deified virtues; her temple in the Forum Holitorium.'),
 ('ENT_ROM_PAX','SRC_OVID_FASTI','Direct attestation','Ovid, Fasti 1.709-722: Pax and the Ara Pacis Augustae.'),
 ('ENT_ROM_LIBERTAS','SRC_LIVY_AUC','Direct attestation','Livy 24.16; 25.7: the temple of Libertas on the Aventine.'),
 ('ENT_ROM_PIETAS','SRC_LIVY_AUC','Direct attestation','Livy 40.34: the temple of Pietas in the Forum Holitorium.'),
 ('ENT_ROM_VIRTUS','SRC_LIVY_AUC','Direct attestation','Livy 25.40; 27.25: the temple of Honos and Virtus dedicated by Marcellus.'),
 ('ENT_ROM_ROMA','SRC_CIL','Direct attestation','CIL: dedications to Dea Roma; the temple of Venus and Roma; the cult of Roma et Augustus.'),
 ('ENT_ROM_POMONA','SRC_OVID_METAMORPHOSES','Direct attestation','Ovid, Metamorphoses 14.623-771: Pomona and the wooing of Vertumnus.'),
 ('ENT_ROM_VERTUMNUS','SRC_OVID_METAMORPHOSES','Direct attestation','Ovid, Metamorphoses 14.623-771: Vertumnus, the shapeshifting god who wins Pomona.'),
 ('ENT_ROM_TELLUS','SRC_OVID_FASTI','Direct attestation','Ovid, Fasti 1.671-674; 4.629-672: Tellus Mater and the Fordicidia.'),
 ('ENT_ROM_BELLONA','SRC_LIVY_AUC','Direct attestation','Livy 10.19: the vowing of the temple of Bellona by Appius Claudius.'),
 ('ENT_ROM_SOL_INVICTUS','SRC_CIL','Direct attestation','CIL: the dedications to Sol Invictus; the Aurelianic state cult instituted 274 CE.'),
 ('ENT_ROM_MAGNA_MATER','SRC_LIVY_AUC','Direct attestation','Livy 29.10-14: the bringing of the Mater Magna Idaea to Rome in 204 BCE.'),
 ('ENT_ROM_ATTIS','SRC_CATULLUS','Direct attestation','Catullus 63: the Attis poem; the self-castration and ecstatic frenzy of the galli.'),
 ('ENT_ROM_DIVUS_JULIUS','SRC_OVID_METAMORPHOSES','Direct attestation','Ovid, Metamorphoses 15.745-870: the apotheosis of Julius Caesar as a star.'),
 ('ENT_ROM_DIVUS_AUGUSTUS','SRC_SUETONIUS','Direct attestation','Suetonius, Augustus 100: the deification of Augustus by decree of the Senate.'),
 ('ENT_ROM_CUPID','SRC_APULEIUS_GOLDEN_ASS','Direct attestation','Apuleius, Metamorphoses (Golden Ass) 4.28-6.24: Cupid, son of Venus, and his love of Psyche.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_ROM_FORTUNA','embodies','ENT_FORTUNE','high','Fortuna is the deified Fortune.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_TELLUS','embodies','ENT_EARTH','high','Tellus Mater is the deified Earth.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_SOL_INVICTUS','embodies','ENT_SUN','high','Sol Invictus is the deified, unconquered Sun.','SRC_CIL','reviewed'),
 ('ENT_ROM_SOL_INVICTUS','syncretized_with','ENT_SYN_MITHRAS','medium','In late antiquity Sol Invictus and Mithras are closely identified (Sol Invictus Mithras).','SRC_CIL','reviewed'),
 ('ENT_ROM_CUPID','embodies','ENT_LOVE','high','Cupid is the deified desire/love.','SRC_APULEIUS_GOLDEN_ASS','reviewed'),
 ('ENT_ROM_CUPID','child_of','ENT_ROM_VENUS','high','Cupid is the son of Venus.','SRC_APULEIUS_GOLDEN_ASS','reviewed'),
 ('ENT_ROM_BELLONA','embodies','ENT_WAR','high','Bellona is the deified War.','SRC_LIVY_AUC','reviewed'),
 ('ENT_ROM_BELLONA','aligned_with','ENT_ROM_MARS','high','Bellona is the war-goddess companion of Mars.','SRC_LIVY_AUC','reviewed'),
 ('ENT_ROM_VICTORIA','aligned_with','ENT_ROM_JUPITER','medium','Victoria, who crowns the victor, attends Jupiter and the triumph.','SRC_LIVY_AUC','reviewed'),
 ('ENT_ROM_FIDES','aligned_with','ENT_ROM_JUPITER','medium','Fides is closely linked to Jupiter as guarantor of oaths (Dius Fidius).','SRC_CICERO_DE_NATURA','reviewed'),
 ('ENT_ROM_VIRTUS','aligned_with','ENT_ROM_MARS','medium','Virtus, martial valour, is associated with Mars.','SRC_LIVY_AUC','reviewed'),
 ('ENT_ROM_POMONA','consort_of','ENT_ROM_VERTUMNUS','high','Pomona is won and wedded by Vertumnus.','SRC_OVID_METAMORPHOSES','reviewed'),
 ('ENT_ROM_ATTIS','consort_of','ENT_ROM_MAGNA_MATER','high','Attis is the youthful consort of the Magna Mater.','SRC_CATULLUS','reviewed'),
 ('ENT_ROM_PAX','aligned_with','ENT_ROM_DIVUS_AUGUSTUS','medium','Pax is the Augustan peace, consecrated at the Ara Pacis Augustae.','SRC_OVID_FASTI','reviewed'),
 ('ENT_ROM_ROMA','aligned_with','ENT_ROM_DIVUS_AUGUSTUS','high','The provincial imperial cult joins Dea Roma with the deified Augustus (Roma et Augustus).','SRC_CIL','reviewed'),
 ('ENT_ROM_DIVUS_AUGUSTUS','child_of','ENT_ROM_DIVUS_JULIUS','high','Augustus was the adopted son and heir of the deified Julius Caesar.','SRC_SUETONIUS','reviewed')
ON CONFLICT DO NOTHING;

-- ── Enrich the existing Italic/Sabine gods (rather than duplicate them as Roman) ──
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_ITA_OPS','SRC_VARRO_ANTIQ','Direct attestation','Varro, De Lingua Latina 5.57, 64: Ops, goddess of plenty, consort of Saturn.'),
 ('ENT_ITA_FAUNUS','SRC_OVID_FASTI','Direct attestation','Ovid, Fasti 2.193-242, 267-452: Faunus, the Lupercalia and the Faunalia.'),
 ('ENT_ITA_FLORA','SRC_OVID_FASTI','Direct attestation','Ovid, Fasti 5.183-378: Flora gives her own account of the Floralia.'),
 ('ENT_ITA_SILVANUS','SRC_CIL','Direct attestation','CIL: Silvanus is among the most frequently dedicated-to gods of the Latin inscriptions.')
ON CONFLICT DO NOTHING;
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_ITA_OPS','embodies','ENT_ABUNDANCE','high','Ops is the deified abundance of the harvest.','SRC_VARRO_ANTIQ','reviewed'),
 ('ENT_ITA_OPS','consort_of','ENT_ROM_SATURN','high','Ops is the consort of Saturn.','SRC_VARRO_ANTIQ','reviewed'),
 ('ENT_ITA_FAUNUS','aligned_with','ENT_ITA_SILVANUS','medium','Faunus and Silvanus are kindred woodland gods of the Italian countryside.','SRC_CIL','reviewed')
ON CONFLICT DO NOTHING;

-- ── Attis (Phrygian) vs the Roman cult-Attis, and the Magna Mater = Cybele reception ─
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Attis','ENT_ATTIS','Reviewed duplicate canonical name; the Phrygian Attis, distinct from the Roman cult of the Magna Mater.','intentional_distinct'),
 ('Attis','ENT_ROM_ATTIS','Reviewed duplicate canonical name; the Roman cult-Attis of the Magna Mater, a reception of the Phrygian Attis.','intentional_distinct')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_ROM_ATTIS','reception_of','ENT_ATTIS','high','The Roman cult-Attis develops from the Phrygian god Attis.','SRC_CATULLUS','reviewed'),
 ('ENT_ROM_MAGNA_MATER','reception_of','ENT_CYBELE','high','The Roman Magna Mater is the state reception of the Anatolian/Greek Cybele.','SRC_LIVY_AUC','reviewed')
ON CONFLICT DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Roman entities' AS label, count(*) FROM entities WHERE tradition='Roman';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
