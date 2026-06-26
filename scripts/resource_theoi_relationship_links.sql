-- scripts/resource_theoi_relationship_links.sql
-- Upgrade weak relationship sourcing: re-point Greek-myth links from the generic
-- 'Theoi ... category index' to the specific Theoi deity page for the subject.
-- Adds one reference source per distinct deity page; relationships whose subject
-- lacks a standalone Theoi page keep the category index (reported).

BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_THEOI_ACHLYS','Theoi Project: Achlys','https://www.theoi.com/Daimon/Akhlys.html','reference work','Theoi.com encyclopedia page for Achlys (Greek mythology, primary-source referenced)'),
('SRC_THEOI_AEACUS','Theoi Project: Aeacus','https://www.theoi.com/Khthonios/Rhadamanthys.html','reference work','Theoi.com encyclopedia page for Aeacus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ALALA','Theoi Project: Alala','https://www.theoi.com/Daimon/Alala.html','reference work','Theoi.com encyclopedia page for Alala (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ALASTOR','Theoi Project: Alastor','https://www.theoi.com/Daimon/Alastor.html','reference work','Theoi.com encyclopedia page for Alastor (Greek mythology, primary-source referenced)'),
('SRC_THEOI_AMECHANIA','Theoi Project: Amechania','https://www.theoi.com/Daimon/Amekhania.html','reference work','Theoi.com encyclopedia page for Amechania (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ANANKE','Theoi Project: Ananke','https://www.theoi.com/Protogenos/Ananke.html','reference work','Theoi.com encyclopedia page for Ananke (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ANEMOI','Theoi Project: Anemoi','https://www.theoi.com/Titan/Anemoi.html','reference work','Theoi.com encyclopedia page for Anemoi (Greek mythology, primary-source referenced)'),
('SRC_THEOI_APHRODITE','Theoi Project: Aphrodite','https://www.theoi.com/Olympios/Aphrodite.html','reference work','Theoi.com encyclopedia page for Aphrodite (Greek mythology, primary-source referenced)'),
('SRC_THEOI_APOLLO','Theoi Project: Apollo','https://www.theoi.com/Olympios/Apollon.html','reference work','Theoi.com encyclopedia page for Apollo (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ARES','Theoi Project: Ares','https://www.theoi.com/Olympios/Ares.html','reference work','Theoi.com encyclopedia page for Ares (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ASCLEPIUS','Theoi Project: Asclepius','https://www.theoi.com/Ouranios/Asklepios.html','reference work','Theoi.com encyclopedia page for Asclepius (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ASTRAEUS','Theoi Project: Astraeus','https://www.theoi.com/Titan/TitanAstraios.html','reference work','Theoi.com encyclopedia page for Astraeus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ATE','Theoi Project: Atë','https://www.theoi.com/Daimon/Ate.html','reference work','Theoi.com encyclopedia page for Atë (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ATHENA','Theoi Project: Athena','https://www.theoi.com/Olympios/Athena.html','reference work','Theoi.com encyclopedia page for Athena (Greek mythology, primary-source referenced)'),
('SRC_THEOI_AURAE','Theoi Project: Aurae','https://www.theoi.com/Nymphe/Aurai.html','reference work','Theoi.com encyclopedia page for Aurae (Greek mythology, primary-source referenced)'),
('SRC_THEOI_BELLEROPHON','Theoi Project: Bellerophon','https://www.theoi.com/Heros/Bellerophontes.html','reference work','Theoi.com encyclopedia page for Bellerophon (Greek mythology, primary-source referenced)'),
('SRC_THEOI_BENDIS','Theoi Project: Bendis','https://www.theoi.com/Thrakios/Bendis.html','reference work','Theoi.com encyclopedia page for Bendis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_BIA','Theoi Project: Bia','https://www.theoi.com/Daimon/Bia.html','reference work','Theoi.com encyclopedia page for Bia (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CABEIRI','Theoi Project: Cabeiri','https://www.theoi.com/Georgikos/Kabeiroi.html','reference work','Theoi.com encyclopedia page for Cabeiri (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CAERUS','Theoi Project: Caerus','https://www.theoi.com/Daimon/Kairos.html','reference work','Theoi.com encyclopedia page for Caerus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CERBERUS','Theoi Project: Cerberus','https://www.theoi.com/Ther/KuonKerberos.html','reference work','Theoi.com encyclopedia page for Cerberus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CHARITES','Theoi Project: Charites','https://www.theoi.com/Ouranios/Kharites.html','reference work','Theoi.com encyclopedia page for Charites (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CHARON','Theoi Project: Charon','https://www.theoi.com/Khthonios/Kharon.html','reference work','Theoi.com encyclopedia page for Charon (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CHRONOS','Theoi Project: Chronos','https://www.theoi.com/Protogenos/Khronos.html','reference work','Theoi.com encyclopedia page for Chronos (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CRONUS','Theoi Project: Cronus','https://www.theoi.com/Titan/TitanKronos.html','reference work','Theoi.com encyclopedia page for Cronus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_CYCLOPES_CRAFTSMEN','Theoi Project: Cyclopes Craftsmen','https://www.theoi.com/Titan/Kyklopes.html','reference work','Theoi.com encyclopedia page for Cyclopes Craftsmen (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DACTYLS','Theoi Project: Dactyls','https://www.theoi.com/Georgikos/Kouretes.html','reference work','Theoi.com encyclopedia page for Dactyls (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DAPHNE','Theoi Project: Daphne','https://www.theoi.com/Nymphe/NympheDaphne.html','reference work','Theoi.com encyclopedia page for Daphne (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DEMETER','Theoi Project: Demeter','https://www.theoi.com/Olympios/Demeter.html','reference work','Theoi.com encyclopedia page for Demeter (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DIKE','Theoi Project: Dike','https://www.theoi.com/Ouranios/HoraDike.html','reference work','Theoi.com encyclopedia page for Dike (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DIONYSUS','Theoi Project: Dionysus','https://www.theoi.com/Olympios/Dionysos.html','reference work','Theoi.com encyclopedia page for Dionysus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DIOSCURI','Theoi Project: Dioscuri','https://www.theoi.com/Ouranios/Dioskouroi.html','reference work','Theoi.com encyclopedia page for Dioscuri (Greek mythology, primary-source referenced)'),
('SRC_THEOI_DRYADS','Theoi Project: Dryads','https://www.theoi.com/Nymphe/Dryades.html','reference work','Theoi.com encyclopedia page for Dryads (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ENYO','Theoi Project: Enyo','https://www.theoi.com/Daimon/Enyo.html','reference work','Theoi.com encyclopedia page for Enyo (Greek mythology, primary-source referenced)'),
('SRC_THEOI_EOS','Theoi Project: Eos','https://www.theoi.com/Titan/Eos.html','reference work','Theoi.com encyclopedia page for Eos (Greek mythology, primary-source referenced)'),
('SRC_THEOI_EPIONE','Theoi Project: Epione','https://www.theoi.com/Ouranios/AsklepiasEpione.html','reference work','Theoi.com encyclopedia page for Epione (Greek mythology, primary-source referenced)'),
('SRC_THEOI_EPIPHRON','Theoi Project: Epiphron','https://www.theoi.com/Daimon/Epiphron.html','reference work','Theoi.com encyclopedia page for Epiphron (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ERINYES','Theoi Project: Erinyes','https://www.theoi.com/Khthonios/Erinyes.html','reference work','Theoi.com encyclopedia page for Erinyes (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ERIS','Theoi Project: Eris','https://www.theoi.com/Daimon/Eris.html','reference work','Theoi.com encyclopedia page for Eris (Greek mythology, primary-source referenced)'),
('SRC_THEOI_EROS','Theoi Project: Eros','https://www.theoi.com/Ouranios/Eros.html','reference work','Theoi.com encyclopedia page for Eros (Greek mythology, primary-source referenced)'),
('SRC_THEOI_EROS_PRIMORDIAL','Theoi Project: Eros Primordial','https://www.theoi.com/Ouranios/Eros.html','reference work','Theoi.com encyclopedia page for Eros Primordial (Greek mythology, primary-source referenced)'),
('SRC_THEOI_EUNOMIA','Theoi Project: Eunomia','https://www.theoi.com/Ouranios/HoraEunomia.html','reference work','Theoi.com encyclopedia page for Eunomia (Greek mythology, primary-source referenced)'),
('SRC_THEOI_GERAS','Theoi Project: Geras','https://www.theoi.com/Daimon/Geras.html','reference work','Theoi.com encyclopedia page for Geras (Greek mythology, primary-source referenced)'),
('SRC_THEOI_GORGYRA','Theoi Project: Gorgyra','https://www.theoi.com/Khthonios/Gorgyra.html','reference work','Theoi.com encyclopedia page for Gorgyra (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HADES','Theoi Project: Hades','https://www.theoi.com/Khthonios/Haides.html','reference work','Theoi.com encyclopedia page for Hades (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HADES_KLYMENOS','Theoi Project: Hades Klymenos','https://www.theoi.com/Khthonios/Haides.html','reference work','Theoi.com encyclopedia page for Hades Klymenos (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HAMADRYADS','Theoi Project: Hamadryads','https://www.theoi.com/Nymphe/Dryades.html','reference work','Theoi.com encyclopedia page for Hamadryads (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HECATE','Theoi Project: Hecate','https://www.theoi.com/Khthonios/Hekate.html','reference work','Theoi.com encyclopedia page for Hecate (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HEDONE','Theoi Project: Hedone','https://www.theoi.com/Daimon/Hedone.html','reference work','Theoi.com encyclopedia page for Hedone (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HEPHAESTUS','Theoi Project: Hephaestus','https://www.theoi.com/Olympios/Hephaistos.html','reference work','Theoi.com encyclopedia page for Hephaestus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HERA','Theoi Project: Hera','https://www.theoi.com/Olympios/Hera.html','reference work','Theoi.com encyclopedia page for Hera (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HERMES','Theoi Project: Hermes','https://www.theoi.com/Olympios/Hermes.html','reference work','Theoi.com encyclopedia page for Hermes (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HERMES_CHTHONIOS','Theoi Project: Hermes Chthonios','https://www.theoi.com/Olympios/Hermes.html','reference work','Theoi.com encyclopedia page for Hermes Chthonios (Greek mythology, primary-source referenced)'),
('SRC_THEOI_HYBRIS','Theoi Project: Hybris','https://www.theoi.com/Daimon/Hybris.html','reference work','Theoi.com encyclopedia page for Hybris (Greek mythology, primary-source referenced)'),
('SRC_THEOI_IOKE','Theoi Project: Ioke','https://www.theoi.com/Daimon/Ioke.html','reference work','Theoi.com encyclopedia page for Ioke (Greek mythology, primary-source referenced)'),
('SRC_THEOI_KERES','Theoi Project: Keres','https://www.theoi.com/Daimon/Keres.html','reference work','Theoi.com encyclopedia page for Keres (Greek mythology, primary-source referenced)'),
('SRC_THEOI_LETHE','Theoi Project: Lethe','https://www.theoi.com/Khthonios/PotamosLethe.html','reference work','Theoi.com encyclopedia page for Lethe (Greek mythology, primary-source referenced)'),
('SRC_THEOI_LEUCE','Theoi Project: Leuce','https://www.theoi.com/Nymphe/NympheLeuke.html','reference work','Theoi.com encyclopedia page for Leuce (Greek mythology, primary-source referenced)'),
('SRC_THEOI_MELINOE','Theoi Project: Melinoe','https://www.theoi.com/Khthonios/Melinoe.html','reference work','Theoi.com encyclopedia page for Melinoe (Greek mythology, primary-source referenced)'),
('SRC_THEOI_MINOS','Theoi Project: Minos','https://www.theoi.com/Khthonios/Rhadamanthys.html','reference work','Theoi.com encyclopedia page for Minos (Greek mythology, primary-source referenced)'),
('SRC_THEOI_MNEMOSYNE','Theoi Project: Mnemosyne','https://www.theoi.com/Titan/TitanisMnemosyne.html','reference work','Theoi.com encyclopedia page for Mnemosyne (Greek mythology, primary-source referenced)'),
('SRC_THEOI_MOMUS','Theoi Project: Momus','https://www.theoi.com/Daimon/Momos.html','reference work','Theoi.com encyclopedia page for Momus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_MUSES','Theoi Project: Muses','https://www.theoi.com/Ouranios/Mousai.html','reference work','Theoi.com encyclopedia page for Muses (Greek mythology, primary-source referenced)'),
('SRC_THEOI_NEMESIS','Theoi Project: Nemesis','https://www.theoi.com/Daimon/Nemesis.html','reference work','Theoi.com encyclopedia page for Nemesis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_NIKE','Theoi Project: Nike','https://www.theoi.com/Daimon/Nike.html','reference work','Theoi.com encyclopedia page for Nike (Greek mythology, primary-source referenced)'),
('SRC_THEOI_NYX','Theoi Project: Nyx','https://www.theoi.com/Protogenos/Nyx.html','reference work','Theoi.com encyclopedia page for Nyx (Greek mythology, primary-source referenced)'),
('SRC_THEOI_OCEANUS','Theoi Project: Oceanus','https://www.theoi.com/Titan/TitanOkeanos.html','reference work','Theoi.com encyclopedia page for Oceanus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_OIZYS','Theoi Project: Oizys','https://www.theoi.com/Daimon/Oizys.html','reference work','Theoi.com encyclopedia page for Oizys (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PALIOXIS','Theoi Project: Palioxis','https://www.theoi.com/Daimon/Palioxis.html','reference work','Theoi.com encyclopedia page for Palioxis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PEGAEAE','Theoi Project: Pegaeae','https://www.theoi.com/Nymphe/Naiades.html','reference work','Theoi.com encyclopedia page for Pegaeae (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PEITHO','Theoi Project: Peitho','https://www.theoi.com/Daimon/Peitho.html','reference work','Theoi.com encyclopedia page for Peitho (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PENIA','Theoi Project: Penia','https://www.theoi.com/Daimon/Penia.html','reference work','Theoi.com encyclopedia page for Penia (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PERSEPHONE','Theoi Project: Persephone','https://www.theoi.com/Khthonios/Persephone.html','reference work','Theoi.com encyclopedia page for Persephone (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PERSEUS','Theoi Project: Perseus','https://www.theoi.com/Heros/Perseus.html','reference work','Theoi.com encyclopedia page for Perseus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PHANES','Theoi Project: Phanes','https://www.theoi.com/Protogenos/Phanes.html','reference work','Theoi.com encyclopedia page for Phanes (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PHEME','Theoi Project: Pheme','https://www.theoi.com/Daimon/Pheme.html','reference work','Theoi.com encyclopedia page for Pheme (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PHILOTES','Theoi Project: Philotes','https://www.theoi.com/Daimon/Philotes.html','reference work','Theoi.com encyclopedia page for Philotes (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PHOBOS','Theoi Project: Phobos','https://www.theoi.com/Daimon/Deimos.html','reference work','Theoi.com encyclopedia page for Phobos (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PLUTUS','Theoi Project: Plutus','https://www.theoi.com/Georgikos/Ploutos.html','reference work','Theoi.com encyclopedia page for Plutus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_POSEIDON','Theoi Project: Poseidon','https://www.theoi.com/Olympios/Poseidon.html','reference work','Theoi.com encyclopedia page for Poseidon (Greek mythology, primary-source referenced)'),
('SRC_THEOI_POTAMEIDES','Theoi Project: Potameides','https://www.theoi.com/Nymphe/Naiades.html','reference work','Theoi.com encyclopedia page for Potameides (Greek mythology, primary-source referenced)'),
('SRC_THEOI_POTHOS','Theoi Project: Pothos','https://www.theoi.com/Ouranios/ErosPothos.html','reference work','Theoi.com encyclopedia page for Pothos (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PRIAPUS','Theoi Project: Priapus','https://www.theoi.com/Georgikos/Priapos.html','reference work','Theoi.com encyclopedia page for Priapus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PROIOXIS','Theoi Project: Proioxis','https://www.theoi.com/Daimon/Proioxis.html','reference work','Theoi.com encyclopedia page for Proioxis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_PROMETHEUS','Theoi Project: Prometheus','https://www.theoi.com/Titan/TitanPrometheus.html','reference work','Theoi.com encyclopedia page for Prometheus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_RHEA','Theoi Project: Rhea','https://www.theoi.com/Titan/TitanisRhea.html','reference work','Theoi.com encyclopedia page for Rhea (Greek mythology, primary-source referenced)'),
('SRC_THEOI_SALMACIS','Theoi Project: Salmacis','https://www.theoi.com/Nymphe/NympheSalmakis.html','reference work','Theoi.com encyclopedia page for Salmacis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_SOPHROSYNE','Theoi Project: Sophrosyne','https://www.theoi.com/Daimon/Sophrosyne.html','reference work','Theoi.com encyclopedia page for Sophrosyne (Greek mythology, primary-source referenced)'),
('SRC_THEOI_SOTERIA','Theoi Project: Soteria','https://www.theoi.com/Daimon/Soteria.html','reference work','Theoi.com encyclopedia page for Soteria (Greek mythology, primary-source referenced)'),
('SRC_THEOI_TECHNE','Theoi Project: Techne','https://www.theoi.com/Daimon/Tekhne.html','reference work','Theoi.com encyclopedia page for Techne (Greek mythology, primary-source referenced)'),
('SRC_THEOI_THEMIS','Theoi Project: Themis','https://www.theoi.com/Titan/TitanisThemis.html','reference work','Theoi.com encyclopedia page for Themis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_THESIS','Theoi Project: Thesis','https://www.theoi.com/Protogenos/Thesis.html','reference work','Theoi.com encyclopedia page for Thesis (Greek mythology, primary-source referenced)'),
('SRC_THEOI_TYCHE','Theoi Project: Tyche','https://www.theoi.com/Daimon/Tykhe.html','reference work','Theoi.com encyclopedia page for Tyche (Greek mythology, primary-source referenced)'),
('SRC_THEOI_TYCHON','Theoi Project: Tychon','https://www.theoi.com/Georgikos/SatyroiOrthanes.html','reference work','Theoi.com encyclopedia page for Tychon (Greek mythology, primary-source referenced)'),
('SRC_THEOI_URANUS','Theoi Project: Uranus','https://www.theoi.com/Protogenos/Ouranos.html','reference work','Theoi.com encyclopedia page for Uranus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ZEUS','Theoi Project: Zeus','https://www.theoi.com/Olympios/Zeus.html','reference work','Theoi.com encyclopedia page for Zeus (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ZEUS_CHTHONIOS','Theoi Project: Zeus Chthonios','https://www.theoi.com/Olympios/Zeus.html','reference work','Theoi.com encyclopedia page for Zeus Chthonios (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ZEUS_KTESIOS','Theoi Project: Zeus Ktesios','https://www.theoi.com/Olympios/Zeus.html','reference work','Theoi.com encyclopedia page for Zeus Ktesios (Greek mythology, primary-source referenced)'),
('SRC_THEOI_ZEUS_MEILICHIOS','Theoi Project: Zeus Meilichios','https://www.theoi.com/Olympios/Zeus.html','reference work','Theoi.com encyclopedia page for Zeus Meilichios (Greek mythology, primary-source referenced)')
ON CONFLICT (source_id) DO NOTHING;

UPDATE entity_relationships SET source_id='SRC_THEOI_HERMES_CHTHONIOS', review_status='reviewed' WHERE relationship_id=12;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS_CHTHONIOS', review_status='reviewed' WHERE relationship_id=25;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIONYSUS', review_status='reviewed' WHERE relationship_id=17;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=181;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=183;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=185;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHARON', review_status='reviewed' WHERE relationship_id=13;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHARON', review_status='reviewed' WHERE relationship_id=89;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=1;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=2;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=3;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=4;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=100;
UPDATE entity_relationships SET source_id='SRC_THEOI_CABEIRI', review_status='reviewed' WHERE relationship_id=99;
UPDATE entity_relationships SET source_id='SRC_THEOI_CERBERUS', review_status='reviewed' WHERE relationship_id=91;
UPDATE entity_relationships SET source_id='SRC_THEOI_CERBERUS', review_status='reviewed' WHERE relationship_id=92;
UPDATE entity_relationships SET source_id='SRC_THEOI_DEMETER', review_status='reviewed' WHERE relationship_id=96;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=124;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=125;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=131;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASTRAEUS', review_status='reviewed' WHERE relationship_id=166;
UPDATE entity_relationships SET source_id='SRC_THEOI_EOS', review_status='reviewed' WHERE relationship_id=167;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=168;
UPDATE entity_relationships SET source_id='SRC_THEOI_KERES', review_status='reviewed' WHERE relationship_id=149;
UPDATE entity_relationships SET source_id='SRC_THEOI_EOS', review_status='reviewed' WHERE relationship_id=170;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASTRAEUS', review_status='reviewed' WHERE relationship_id=171;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=172;
UPDATE entity_relationships SET source_id='SRC_THEOI_THEMIS', review_status='reviewed' WHERE relationship_id=174;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=175;
UPDATE entity_relationships SET source_id='SRC_THEOI_THEMIS', review_status='reviewed' WHERE relationship_id=180;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHRONOS', review_status='reviewed' WHERE relationship_id=152;
UPDATE entity_relationships SET source_id='SRC_THEOI_ERINYES', review_status='reviewed' WHERE relationship_id=144;
UPDATE entity_relationships SET source_id='SRC_THEOI_LETHE', review_status='reviewed' WHERE relationship_id=146;
UPDATE entity_relationships SET source_id='SRC_THEOI_PERSEUS', review_status='reviewed' WHERE relationship_id=128;
UPDATE entity_relationships SET source_id='SRC_THEOI_BELLEROPHON', review_status='reviewed' WHERE relationship_id=159;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=5;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=6;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=7;
UPDATE entity_relationships SET source_id='SRC_THEOI_DEMETER', review_status='reviewed' WHERE relationship_id=8;
UPDATE entity_relationships SET source_id='SRC_THEOI_HADES', review_status='reviewed' WHERE relationship_id=9;
UPDATE entity_relationships SET source_id='SRC_THEOI_APOLLO', review_status='reviewed' WHERE relationship_id=10;
UPDATE entity_relationships SET source_id='SRC_THEOI_APOLLO', review_status='reviewed' WHERE relationship_id=11;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIOSCURI', review_status='reviewed' WHERE relationship_id=14;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIOSCURI', review_status='reviewed' WHERE relationship_id=15;
UPDATE entity_relationships SET source_id='SRC_THEOI_HADES', review_status='reviewed' WHERE relationship_id=310;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=322;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERMES_CHTHONIOS', review_status='reviewed' WHERE relationship_id=323;
UPDATE entity_relationships SET source_id='SRC_THEOI_HADES', review_status='reviewed' WHERE relationship_id=321;
UPDATE entity_relationships SET source_id='SRC_THEOI_PERSEPHONE', review_status='reviewed' WHERE relationship_id=326;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=329;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS_MEILICHIOS', review_status='reviewed' WHERE relationship_id=23;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS_KTESIOS', review_status='reviewed' WHERE relationship_id=24;
UPDATE entity_relationships SET source_id='SRC_THEOI_AEACUS', review_status='reviewed' WHERE relationship_id=306;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHARON', review_status='reviewed' WHERE relationship_id=309;
UPDATE entity_relationships SET source_id='SRC_THEOI_TYCHON', review_status='reviewed' WHERE relationship_id=344;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIKE', review_status='reviewed' WHERE relationship_id=379;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=373;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERMES', review_status='reviewed' WHERE relationship_id=362;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERMES_CHTHONIOS', review_status='reviewed' WHERE relationship_id=26;
UPDATE entity_relationships SET source_id='SRC_THEOI_URANUS', review_status='reviewed' WHERE relationship_id=57;
UPDATE entity_relationships SET source_id='SRC_THEOI_CRONUS', review_status='reviewed' WHERE relationship_id=58;
UPDATE entity_relationships SET source_id='SRC_THEOI_CRONUS', review_status='reviewed' WHERE relationship_id=59;
UPDATE entity_relationships SET source_id='SRC_THEOI_RHEA', review_status='reviewed' WHERE relationship_id=60;
UPDATE entity_relationships SET source_id='SRC_THEOI_CRONUS', review_status='reviewed' WHERE relationship_id=61;
UPDATE entity_relationships SET source_id='SRC_THEOI_RHEA', review_status='reviewed' WHERE relationship_id=62;
UPDATE entity_relationships SET source_id='SRC_THEOI_CRONUS', review_status='reviewed' WHERE relationship_id=63;
UPDATE entity_relationships SET source_id='SRC_THEOI_RHEA', review_status='reviewed' WHERE relationship_id=64;
UPDATE entity_relationships SET source_id='SRC_THEOI_CRONUS', review_status='reviewed' WHERE relationship_id=65;
UPDATE entity_relationships SET source_id='SRC_THEOI_RHEA', review_status='reviewed' WHERE relationship_id=66;
UPDATE entity_relationships SET source_id='SRC_THEOI_TYCHE', review_status='reviewed' WHERE relationship_id=343;
UPDATE entity_relationships SET source_id='SRC_THEOI_PLUTUS', review_status='reviewed' WHERE relationship_id=348;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERA', review_status='reviewed' WHERE relationship_id=372;
UPDATE entity_relationships SET source_id='SRC_THEOI_THEMIS', review_status='reviewed' WHERE relationship_id=377;
UPDATE entity_relationships SET source_id='SRC_THEOI_EUNOMIA', review_status='reviewed' WHERE relationship_id=380;
UPDATE entity_relationships SET source_id='SRC_THEOI_HEPHAESTUS', review_status='reviewed' WHERE relationship_id=349;
UPDATE entity_relationships SET source_id='SRC_THEOI_ATHENA', review_status='reviewed' WHERE relationship_id=352;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=361;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS_KTESIOS', review_status='reviewed' WHERE relationship_id=347;
UPDATE entity_relationships SET source_id='SRC_THEOI_CYCLOPES_CRAFTSMEN', review_status='reviewed' WHERE relationship_id=351;
UPDATE entity_relationships SET source_id='SRC_THEOI_PROMETHEUS', review_status='reviewed' WHERE relationship_id=355;
UPDATE entity_relationships SET source_id='SRC_THEOI_ENYO', review_status='reviewed' WHERE relationship_id=410;
UPDATE entity_relationships SET source_id='SRC_THEOI_KERES', review_status='reviewed' WHERE relationship_id=420;
UPDATE entity_relationships SET source_id='SRC_THEOI_ACHLYS', review_status='reviewed' WHERE relationship_id=423;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHARITES', review_status='reviewed' WHERE relationship_id=70;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHARITES', review_status='reviewed' WHERE relationship_id=71;
UPDATE entity_relationships SET source_id='SRC_THEOI_CHARITES', review_status='reviewed' WHERE relationship_id=72;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=73;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=74;
UPDATE entity_relationships SET source_id='SRC_THEOI_APOLLO', review_status='reviewed' WHERE relationship_id=429;
UPDATE entity_relationships SET source_id='SRC_THEOI_PRIAPUS', review_status='reviewed' WHERE relationship_id=394;
UPDATE entity_relationships SET source_id='SRC_THEOI_APHRODITE', review_status='reviewed' WHERE relationship_id=399;
UPDATE entity_relationships SET source_id='SRC_THEOI_ATHENA', review_status='reviewed' WHERE relationship_id=407;
UPDATE entity_relationships SET source_id='SRC_THEOI_ARES', review_status='reviewed' WHERE relationship_id=409;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=430;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=75;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=76;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=77;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=78;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=79;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=80;
UPDATE entity_relationships SET source_id='SRC_THEOI_MUSES', review_status='reviewed' WHERE relationship_id=81;
UPDATE entity_relationships SET source_id='SRC_THEOI_ANEMOI', review_status='reviewed' WHERE relationship_id=82;
UPDATE entity_relationships SET source_id='SRC_THEOI_ANEMOI', review_status='reviewed' WHERE relationship_id=83;
UPDATE entity_relationships SET source_id='SRC_THEOI_ANEMOI', review_status='reviewed' WHERE relationship_id=84;
UPDATE entity_relationships SET source_id='SRC_THEOI_ANEMOI', review_status='reviewed' WHERE relationship_id=85;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERA', review_status='reviewed' WHERE relationship_id=105;
UPDATE entity_relationships SET source_id='SRC_THEOI_ARES', review_status='reviewed' WHERE relationship_id=169;
UPDATE entity_relationships SET source_id='SRC_THEOI_MNEMOSYNE', review_status='reviewed' WHERE relationship_id=182;
UPDATE entity_relationships SET source_id='SRC_THEOI_ARES', review_status='reviewed' WHERE relationship_id=184;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERMES_CHTHONIOS', review_status='reviewed' WHERE relationship_id=311;
UPDATE entity_relationships SET source_id='SRC_THEOI_MINOS', review_status='reviewed' WHERE relationship_id=312;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS_KTESIOS', review_status='reviewed' WHERE relationship_id=366;
UPDATE entity_relationships SET source_id='SRC_THEOI_ANANKE', review_status='reviewed' WHERE relationship_id=390;
UPDATE entity_relationships SET source_id='SRC_THEOI_POTHOS', review_status='reviewed' WHERE relationship_id=397;
UPDATE entity_relationships SET source_id='SRC_THEOI_EROS', review_status='reviewed' WHERE relationship_id=398;
UPDATE entity_relationships SET source_id='SRC_THEOI_PEITHO', review_status='reviewed' WHERE relationship_id=401;
UPDATE entity_relationships SET source_id='SRC_THEOI_ERIS', review_status='reviewed' WHERE relationship_id=403;
UPDATE entity_relationships SET source_id='SRC_THEOI_PHOBOS', review_status='reviewed' WHERE relationship_id=404;
UPDATE entity_relationships SET source_id='SRC_THEOI_BIA', review_status='reviewed' WHERE relationship_id=405;
UPDATE entity_relationships SET source_id='SRC_THEOI_OIZYS', review_status='reviewed' WHERE relationship_id=422;
UPDATE entity_relationships SET source_id='SRC_THEOI_GERAS', review_status='reviewed' WHERE relationship_id=424;
UPDATE entity_relationships SET source_id='SRC_THEOI_MNEMOSYNE', review_status='reviewed' WHERE relationship_id=431;
UPDATE entity_relationships SET source_id='SRC_THEOI_PHANES', review_status='reviewed' WHERE relationship_id=16;
UPDATE entity_relationships SET source_id='SRC_THEOI_IOKE', review_status='reviewed' WHERE relationship_id=1833;
UPDATE entity_relationships SET source_id='SRC_THEOI_PROIOXIS', review_status='reviewed' WHERE relationship_id=1835;
UPDATE entity_relationships SET source_id='SRC_THEOI_PALIOXIS', review_status='reviewed' WHERE relationship_id=1836;
UPDATE entity_relationships SET source_id='SRC_THEOI_PHEME', review_status='reviewed' WHERE relationship_id=1837;
UPDATE entity_relationships SET source_id='SRC_THEOI_TECHNE', review_status='reviewed' WHERE relationship_id=1838;
UPDATE entity_relationships SET source_id='SRC_THEOI_SOTERIA', review_status='reviewed' WHERE relationship_id=1839;
UPDATE entity_relationships SET source_id='SRC_THEOI_PHILOTES', review_status='reviewed' WHERE relationship_id=1840;
UPDATE entity_relationships SET source_id='SRC_THEOI_NIKE', review_status='reviewed' WHERE relationship_id=2001;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=2003;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=2004;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=2005;
UPDATE entity_relationships SET source_id='SRC_THEOI_HADES_KLYMENOS', review_status='reviewed' WHERE relationship_id=2035;
UPDATE entity_relationships SET source_id='SRC_THEOI_HADES_KLYMENOS', review_status='reviewed' WHERE relationship_id=2036;
UPDATE entity_relationships SET source_id='SRC_THEOI_POSEIDON', review_status='reviewed' WHERE relationship_id=2039;
UPDATE entity_relationships SET source_id='SRC_THEOI_DEMETER', review_status='reviewed' WHERE relationship_id=2040;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIONYSUS', review_status='reviewed' WHERE relationship_id=2045;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIONYSUS', review_status='reviewed' WHERE relationship_id=2047;
UPDATE entity_relationships SET source_id='SRC_THEOI_RHEA', review_status='reviewed' WHERE relationship_id=2049;
UPDATE entity_relationships SET source_id='SRC_THEOI_DAPHNE', review_status='reviewed' WHERE relationship_id=2058;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERA', review_status='reviewed' WHERE relationship_id=2060;
UPDATE entity_relationships SET source_id='SRC_THEOI_DEMETER', review_status='reviewed' WHERE relationship_id=2064;
UPDATE entity_relationships SET source_id='SRC_THEOI_APOLLO', review_status='reviewed' WHERE relationship_id=2066;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=2068;
UPDATE entity_relationships SET source_id='SRC_THEOI_EPIONE', review_status='reviewed' WHERE relationship_id=2069;
UPDATE entity_relationships SET source_id='SRC_THEOI_ATE', review_status='reviewed' WHERE relationship_id=2130;
UPDATE entity_relationships SET source_id='SRC_THEOI_MOMUS', review_status='reviewed' WHERE relationship_id=2131;
UPDATE entity_relationships SET source_id='SRC_THEOI_HYBRIS', review_status='reviewed' WHERE relationship_id=2134;
UPDATE entity_relationships SET source_id='SRC_THEOI_SOPHROSYNE', review_status='reviewed' WHERE relationship_id=2135;
UPDATE entity_relationships SET source_id='SRC_THEOI_NEMESIS', review_status='reviewed' WHERE relationship_id=2136;
UPDATE entity_relationships SET source_id='SRC_THEOI_PENIA', review_status='reviewed' WHERE relationship_id=2141;
UPDATE entity_relationships SET source_id='SRC_THEOI_PENIA', review_status='reviewed' WHERE relationship_id=2142;
UPDATE entity_relationships SET source_id='SRC_THEOI_HEDONE', review_status='reviewed' WHERE relationship_id=2144;
UPDATE entity_relationships SET source_id='SRC_THEOI_CAERUS', review_status='reviewed' WHERE relationship_id=2146;
UPDATE entity_relationships SET source_id='SRC_THEOI_NYX', review_status='reviewed' WHERE relationship_id=2152;
UPDATE entity_relationships SET source_id='SRC_THEOI_NYX', review_status='reviewed' WHERE relationship_id=2153;
UPDATE entity_relationships SET source_id='SRC_THEOI_DIONYSUS', review_status='reviewed' WHERE relationship_id=2154;
UPDATE entity_relationships SET source_id='SRC_THEOI_ALASTOR', review_status='reviewed' WHERE relationship_id=2156;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2161;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2162;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2163;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2164;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2165;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2166;
UPDATE entity_relationships SET source_id='SRC_THEOI_BENDIS', review_status='reviewed' WHERE relationship_id=2173;
UPDATE entity_relationships SET source_id='SRC_THEOI_BENDIS', review_status='reviewed' WHERE relationship_id=2174;
UPDATE entity_relationships SET source_id='SRC_THEOI_APHRODITE', review_status='reviewed' WHERE relationship_id=2183;
UPDATE entity_relationships SET source_id='SRC_THEOI_HERMES', review_status='reviewed' WHERE relationship_id=2184;
UPDATE entity_relationships SET source_id='SRC_THEOI_EROS_PRIMORDIAL', review_status='reviewed' WHERE relationship_id=2189;
UPDATE entity_relationships SET source_id='SRC_THEOI_OCEANUS', review_status='reviewed' WHERE relationship_id=2190;
UPDATE entity_relationships SET source_id='SRC_THEOI_OCEANUS', review_status='reviewed' WHERE relationship_id=2194;
UPDATE entity_relationships SET source_id='SRC_THEOI_OCEANUS', review_status='reviewed' WHERE relationship_id=2195;
UPDATE entity_relationships SET source_id='SRC_THEOI_HAMADRYADS', review_status='reviewed' WHERE relationship_id=2201;
UPDATE entity_relationships SET source_id='SRC_THEOI_DRYADS', review_status='reviewed' WHERE relationship_id=2202;
UPDATE entity_relationships SET source_id='SRC_THEOI_HECATE', review_status='reviewed' WHERE relationship_id=2206;
UPDATE entity_relationships SET source_id='SRC_THEOI_PERSEPHONE', review_status='reviewed' WHERE relationship_id=2207;
UPDATE entity_relationships SET source_id='SRC_THEOI_MELINOE', review_status='reviewed' WHERE relationship_id=2208;
UPDATE entity_relationships SET source_id='SRC_THEOI_HADES', review_status='reviewed' WHERE relationship_id=2209;
UPDATE entity_relationships SET source_id='SRC_THEOI_PERSEPHONE', review_status='reviewed' WHERE relationship_id=2210;
UPDATE entity_relationships SET source_id='SRC_THEOI_GORGYRA', review_status='reviewed' WHERE relationship_id=2212;
UPDATE entity_relationships SET source_id='SRC_THEOI_LEUCE', review_status='reviewed' WHERE relationship_id=2213;
UPDATE entity_relationships SET source_id='SRC_THEOI_ALALA', review_status='reviewed' WHERE relationship_id=2215;
UPDATE entity_relationships SET source_id='SRC_THEOI_AURAE', review_status='reviewed' WHERE relationship_id=2221;
UPDATE entity_relationships SET source_id='SRC_THEOI_ZEUS', review_status='reviewed' WHERE relationship_id=2222;
UPDATE entity_relationships SET source_id='SRC_THEOI_SALMACIS', review_status='reviewed' WHERE relationship_id=2231;
UPDATE entity_relationships SET source_id='SRC_THEOI_OCEANUS', review_status='reviewed' WHERE relationship_id=2232;
UPDATE entity_relationships SET source_id='SRC_THEOI_PEGAEAE', review_status='reviewed' WHERE relationship_id=2236;
UPDATE entity_relationships SET source_id='SRC_THEOI_POTAMEIDES', review_status='reviewed' WHERE relationship_id=2237;
UPDATE entity_relationships SET source_id='SRC_THEOI_AMECHANIA', review_status='reviewed' WHERE relationship_id=2238;
UPDATE entity_relationships SET source_id='SRC_THEOI_AMECHANIA', review_status='reviewed' WHERE relationship_id=2239;
UPDATE entity_relationships SET source_id='SRC_THEOI_EPIPHRON', review_status='reviewed' WHERE relationship_id=2240;
UPDATE entity_relationships SET source_id='SRC_THEOI_THESIS', review_status='reviewed' WHERE relationship_id=2248;
UPDATE entity_relationships SET source_id='SRC_THEOI_RHEA', review_status='reviewed' WHERE relationship_id=2253;
UPDATE entity_relationships SET source_id='SRC_THEOI_DACTYLS', review_status='reviewed' WHERE relationship_id=2254;
UPDATE entity_relationships SET source_id='SRC_THEOI_POSEIDON', review_status='reviewed' WHERE relationship_id=2255;
UPDATE entity_relationships SET source_id='SRC_THEOI_ASCLEPIUS', review_status='reviewed' WHERE relationship_id=2258;
UPDATE entity_relationships SET source_id='SRC_THEOI_ANANKE', review_status='reviewed' WHERE relationship_id=1294;
UPDATE entity_relationships SET source_id='SRC_THEOI_NYX', review_status='reviewed' WHERE relationship_id=1314;

COMMIT;