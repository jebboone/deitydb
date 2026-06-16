-- build_fringe_audit_fixes.sql — corrections from the v1.67.0 adversarial scholarly audit. v1.67.1
-- Fixes: 1 merge (duplicate), 2 removals, fabricated Meroitic attestation, Napir/Napirisha
-- conflation, contradicted/over-specified domains, mistagged Kubaba, Julian misattribution,
-- Qurʾan over-attribution (source transparency), several confidence recalibrations.
BEGIN;

-- ========== A. MERGE: Sin(Hawl) == Sayin (one Hadramite national god; 'Sin' is a superseded reading) ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_SAB_SIN_HAWL' OR object_entity_id='ENT_SAB_SIN_HAWL';
DELETE FROM entity_periods WHERE entity_id='ENT_SAB_SIN_HAWL';
DELETE FROM entity_sources WHERE entity_id='ENT_SAB_SIN_HAWL';
DELETE FROM entity_duplicate_review WHERE entity_id='ENT_SAB_SIN_HAWL';
DELETE FROM entities WHERE entity_id='ENT_SAB_SIN_HAWL';
UPDATE entities SET short_note='National god of the kingdom of Hadramawt (Ancient South Arabian s1yn), worshipped at the great temple in the capital Shabwa; patron of Hadramite kingship. The older transcription "Sin" (with epithet Hawl) wrongly assimilated him to the Mesopotamian moon-god Sin; the modern consensus reads "Sayin". His astral character (solar, favoured by the eagle/radiate coin iconography, vs lunar) is debated.'
WHERE entity_id='ENT_SAB_SAYIN';

-- ========== B. REMOVE: Sardi (bare god-list star-name; domain wrongly = Sun, duplicating Shivini; no astral anchor exists) ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_URA_SARDI' OR object_entity_id='ENT_URA_SARDI';
DELETE FROM entity_periods WHERE entity_id='ENT_URA_SARDI';
DELETE FROM entity_sources WHERE entity_id='ENT_URA_SARDI';
DELETE FROM entities WHERE entity_id='ENT_URA_SARDI';

-- ========== C. MEROITIC: fix fabricated attestation + inverted confidence (Aritene contested, Mash is the real sun god) ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MER_ARITENE' AND relationship_type='member_of' AND object_entity_id='ENT_MER_APEDEMAK';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MER_ARITENE' AND relationship_type='aligned_with' AND object_entity_id='ENT_MER_MANDULIS';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MER_ARITENE' AND relationship_type='embodies' AND object_entity_id='ENT_SUN';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MER_MASH' AND relationship_type='member_of' AND object_entity_id='ENT_MER_APEDEMAK';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MER_MASH' AND relationship_type='paired_with' AND object_entity_id='ENT_MER_ARITENE';
UPDATE entities SET evidence_confidence='C', short_note='A possible indigenous Meroitic solar deity, read as "Ariten/Aritene" on a fragmentary faience medallion from Meroe by Priese (1984) — a solar identification that is contested and largely superseded in favour of Mash. Divine status of the name is itself uncertain. (Earlier note text conflating REM 0277 / "Haramadeye" was a fabricated joint attestation and has been removed.)'
WHERE entity_id='ENT_MER_ARITENE';
UPDATE entities SET evidence_confidence='B', short_note='The indigenous Meroitic sun god (ate Ms-o, "priest of Masha, god of the Sun", attested on a Sedeinga funerary stela; cult localized to the Karanog/Aniba area), who fuses with Amun as Mash-Amani (= Amun-Ra). The better-attested of the candidate Meroitic solar deities (cf. the contested Aritene).'
WHERE entity_id='ENT_MER_MASH';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_MER_MASH','embodies','ENT_SUN','high','Mash is the indigenous Meroitic sun god (Sedeinga "priest of Masha, god of the Sun").','SRC_TÖRÖK_MEROE','reviewed'),
 ('ENT_MER_MASH','syncretized_with','ENT_EGY_AMUN','medium','Mash fuses with Amun as Mash-Amani (= Amun-Ra) in the Meroitic record (Rilly).','SRC_TÖRÖK_MEROE','reviewed'),
 ('ENT_MER_ARITENE','aligned_with','ENT_MER_MASH','low','Aritene and Mash are competing scholarly identifications of the Meroitic solar deity, not a documented pairing.','SRC_TÖRÖK_MEROE','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ========== D. ELAMITE: undo Napir/Napirisha conflation; fix inverted/contradicted links ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ELAM_NAPIR' AND relationship_type='guardian_of' AND object_entity_id='ENT_ELAM_HUMBAN';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ELAM_TIRUTUR' AND relationship_type='member_of' AND object_entity_id='ENT_ELAM_HUMBAN';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ELAM_SUHSIPA' AND relationship_type='belongs_to_realm' AND object_entity_id='ENT_UNDERWORLD';
UPDATE entities SET evidence_confidence='B', short_note='A minor Elamite deity attested in the Neo-Elamite inscription of Hanni of Ayapir (EKI 75, epithet "the favorite") and among the clergy under Tepti-Huban-Inshushinak. The name element nap means simply "god"; a lunar identification (German handbook tradition, Haas/Koch) is one reading but NOT consensus (Vallat, Henkelman). NOTE: distinct from the supreme Anshanite god Napirisha — the king Untash-Napirisha and the Tchoga Zanbil high temple belong to Napirisha, not Napir.'
WHERE entity_id='ENT_ELAM_NAPIR';
UPDATE entities SET short_note='An independent local Elamite god of Ayapir, regularly invoked as a pair with Tepti ("lord") in Neo-Elamite royal inscriptions (Hanni of Ayapir, EKI 75); like Humban and Inshushinak he could grant kitin (god-given royal legitimacy). The Ayapir sanctuary was most likely his, not Humban''s (Henkelman).'
WHERE entity_id='ENT_ELAM_TIRUTUR';
UPDATE entities SET short_note='An Elamite deity with a grove-temple (siyan husame, "temple in the sacred grove" — husa = grove, NOT netherworld) on the middle terrace at Dur-Untash (Tchoga Zanbil), grouped with Lagamar and Napirisha. Per Henkelman, Suhsipa is among the grove-temple gods who LACK an underworld connection (with Manzat and Simut), not an underworld deity.'
WHERE entity_id='ENT_ELAM_SUHSIPA';

-- ========== E. RETAG: Kubaba is Luwian/Neo-Hittite (Carchemish), not Aramean; Kybele descent is debated ==========
UPDATE entities SET tradition='Luwian', short_note='Tutelary goddess of Carchemish, a leading deity of the Syro-Hittite/Luwian (Neo-Hittite) world, attested in Luwian hieroglyphic and Aramaic inscriptions (and earlier as a Syrian goddess at 3rd-millennium Kish/Mari). Sometimes argued to underlie Anatolian Kybele, though the derivation is debated and phonologically contested.'
WHERE entity_id='ENT_ARA_KUBABA';
UPDATE entity_periods SET period_id='PER_LUW_NEO_HITTITE' WHERE entity_id='ENT_ARA_KUBABA' AND period_id='PER_ARA_IRON_AGE';

-- ========== F. AZIZOS/MONIMOS: correct the Julian attribution (Azizos=Ares, Monimos=Hermes), add those equations ==========
UPDATE entities SET short_note='The morning-star deity of Edessa, paired with Monimos as the two paredroi (attendants) of the Sun (Helios). Julian (Hymn to King Helios 150c-d) equates Azizos with Ares; the morning/evening-star (Venus) reading is a modern interpretation (Drijvers).'
WHERE entity_id='ENT_ARA_AZIZOS';
UPDATE entities SET short_note='The evening-star deity of Edessa (Aramaic mnʿm, "the favourable one"), twin attendant of the Sun alongside Azizos. Julian (Hymn to King Helios 150c-d) equates Monimos with Hermes; the Venus/star reading is a modern interpretation (Drijvers).'
WHERE entity_id='ENT_ARA_MONIMOS';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_ARA_AZIZOS','aligned_with','ENT_ARES','high','Julian (Hymn to King Helios) equates Azizos of Edessa with Ares.','SRC_LIPINSKI_ARAMEANS','reviewed'),
 ('ENT_ARA_MONIMOS','aligned_with','ENT_HERMES','high','Julian (Hymn to King Helios) equates Monimos of Edessa with Hermes.','SRC_LIPINSKI_ARAMEANS','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ========== G. MYCENAEAN: strip over-specified domains; add a Tn 316 collective so cult-recipients stay connected ==========
INSERT INTO entities (entity_id,canonical_name,tradition,entity_type,category,primary_domains,cult_scope,evidence_confidence,review_status,inclusion_basis,earth_association_score,chthonic_flag,serpent_flag,short_note)
VALUES ('ENT_MYC_TN316','Deities of the Pylos Tn 316 Tablet','Mycenaean','Collective','Cult collective','Mycenaean state cult; offering recipients','regional','A','candidate_verified_name','Early-antiquity fringe completion (v1.67.0)',0,false,false,'The group of deities receiving offerings on the Pylos Linear B tablet PY Tn 316, the most important single document of Mycenaean religion, recording gold vessels and human offerings to a set of gods.')
ON CONFLICT (entity_id) DO NOTHING;
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note) VALUES ('ENT_MYC_TN316','SRC_VENTRIS_CHADWICK','direct attestation','PY Tn 316; Ventris & Chadwick, Documents in Mycenaean Greek') ON CONFLICT DO NOTHING;
INSERT INTO entity_periods (entity_id,period_id,confidence,rationale,source_id,review_status) VALUES ('ENT_MYC_TN316','PER_GRK_MYCENAEAN','high','PY Tn 316 dates to the Late Bronze Age Pylian archive.','SRC_VENTRIS_CHADWICK','reviewed') ON CONFLICT DO NOTHING;
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MYC_POTNIA_LABYRINTH' AND relationship_type='presides_over' AND object_entity_id='ENT_EARTH';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MYC_IPHIMEDEIA' AND relationship_type='presides_over' AND object_entity_id='ENT_FERTILITY';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MYC_TRISHEROS' AND relationship_type='presides_over' AND object_entity_id='ENT_DEATH';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_MYC_QERASIJA' AND relationship_type='presides_over' AND object_entity_id='ENT_ANIMALS';
UPDATE entities SET evidence_confidence='B', short_note='di-ri-mi-jo on Linear B tablet PY Tn 316, read as di-wo i-je-we ("son of Zeus") on a single line; both the theonym and the "son of Zeus" reading rest on that one attestation and are plausible but not beyond dispute.'
WHERE entity_id='ENT_MYC_DRIMIOS';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_MYC_DRIMIOS','member_of','ENT_MYC_TN316','high','di-ri-mi-jo receives offerings on PY Tn 316.','SRC_VENTRIS_CHADWICK','reviewed'),
 ('ENT_MYC_IPHIMEDEIA','member_of','ENT_MYC_TN316','high','i-pi-me-de-ja receives offerings on PY Tn 316 (a divine cult-recipient; the later "fertility" association is post-Mycenaean myth).','SRC_VENTRIS_CHADWICK','reviewed'),
 ('ENT_MYC_TRISHEROS','member_of','ENT_MYC_TN316','high','ti-ri-se-ro-e ("Thrice-Hero") receives offerings on PY Tn 316 as a hero/ancestor cult-recipient (not a death-deity).','SRC_VENTRIS_CHADWICK','reviewed'),
 ('ENT_MYC_QERASIJA','aligned_with','ENT_MYC_POTNIA','low','qe-ra-si-ja is a Knossian offering-goddess grouped typologically with the Cretan Potnia; the "beast/Animals" reading is only one of several and is not asserted as a domain.','SRC_VENTRIS_CHADWICK','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ========== H. URARTIAN: recalibrate the divinized weapon; normalize a verb ==========
UPDATE entities SET evidence_confidence='C' WHERE entity_id='ENT_URA_SPEAR_KHALDI';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_URA_SELARDI' AND relationship_type='presides_over' AND object_entity_id='ENT_MOON';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_URA_SELARDI','embodies','ENT_MOON','medium','Selardi is the Urartian lunar deity of the Meher Kapisi list (verb normalized to embodies, matching other lunar gods).','SRC_PIOTROVSKY_URARTU','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ========== I. NABATAEAN / ARABIAN: domain-vs-interpretatio fixes + note corrections ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_ARA_DUSHARA' AND relationship_type='presides_over' AND object_entity_id='ENT_SUN';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_NAB_AL_KUTBA' AND relationship_type='presides_over' AND object_entity_id='ENT_WEALTH';
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_NAB_AL_UZZA_PETRA' AND relationship_type='presides_over' AND object_entity_id='ENT_VENUS';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_NAB_AL_KUTBA','presides_over','ENT_WRITING','high','al-Kutbaʾ (root k-t-b "to write") is the Nabataean god of writing and scribes/records.','SRC_HEALEY_NABATAEAN_RELIGION','reviewed'),
 ('ENT_NAB_AL_UZZA_PETRA','embodies','ENT_VENUS','high','al-ʿUzza is the Venus/morning-star goddess of the Nabataeans, identified with Aphrodite.','SRC_HEALEY_NABATAEAN_RELIGION','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;
UPDATE entities SET short_note='Caravan-protector and warrior god "who drinks no wine", named in a bilingual Nabataean-Palmyrene altar from Palmyra (2nd c. CE).' WHERE entity_id='ENT_NAB_SHAI_AL_QAUM';
UPDATE entities SET short_note='Petraean cult-form of al-ʿUzza, chief Nabataean goddess identified with Aphrodite; tentatively associated with Petra''s Temple of the Winged Lions (the temple''s principal goddess is debated).' WHERE entity_id='ENT_NAB_AL_UZZA_PETRA';
UPDATE entities SET canonical_name='The Idols of Pre-Islamic Arabia', short_note='Collective of the betyls and idols of pre-Islamic Arabia catalogued in Ibn al-Kalbi''s Kitab al-Asnam (Book of Idols). NB: the Kaʿba idols proper (Hubal, Isaf, Naʾila…) and the five antediluvian idols of Qurʾan 71:23 (Wadd, Suwaʿ, Yaghuth, Yaʿuq, Nasr, framed there as the idols of Noah''s people) are distinct sets grouped here under one umbrella.' WHERE entity_id='ENT_ARAB_KAABA_IDOLS';
UPDATE entities SET short_note='White quartz betyl and oracular sanctuary (famed for divination by arrows) at Tabala in the Tihama/Asir region of southwest Arabia — the "Yemeni/Southern Kaʿba" by epithet, not located in Yemen proper; venerated by Daws, Khathʿam and Bajila per Ibn al-Kalbi.' WHERE entity_id='ENT_ARAB_DHUL_KHALASA';
UPDATE entities SET evidence_confidence='C', short_note='A tall rock-betyl of the Banu Milkan (Kinana) anointed with sacrificial blood, per Ibn al-Kalbi (whose anecdote has camels bolting from the blood-smeared stone); a tribal cult-stone rather than a developed deity. The "Fortune" association rests on the name saʿd ("good luck"), an etymology, not attested cult function.' WHERE entity_id='ENT_ARAB_SAD';
UPDATE entities SET short_note='National god of the Minaean (Maʿin) kingdom and a pan-South-Arabian moon-deity; overwhelmingly an epigraphic deity (the "Wd ʾb" / "Wadd is father" formula on amulets, the temple at as-Sawda/Baraqish). Also named, with the other four antediluvian idols, in Qurʾan 71:23.' WHERE entity_id='ENT_SAB_WADD';

-- ========== J. AKSUMITE: tighten interpretatio verbs to the bilingual evidence ==========
DELETE FROM entity_relationships WHERE subject_entity_id='ENT_AKS_BEHER' AND relationship_type='aligned_with' AND object_entity_id='ENT_POSEIDON';
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_AKS_BEHER','equated_with','ENT_POSEIDON','high','Ezana''s bilingual inscription renders the sea-god Beher as Poseidon — an ancient interpretatio in the source itself.','SRC_MUNRO_HAY_AKSUM','reviewed'),
 ('ENT_AKS_ASTAR','aligned_with','ENT_ZEUS','medium','Ezana''s Greek text renders Astar (the head of the pagan triad) as Zeus, even though the ʿAthtar lineage is the Venus-star deity.','SRC_MUNRO_HAY_AKSUM','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ========== K. CONNECTIVITY: add attested interpretatio for war/sun leaf-nodes (also reduces abstraction-only leaves) ==========
INSERT INTO entity_relationships(subject_entity_id,relationship_type,object_entity_id,confidence,rationale,source_id,review_status) VALUES
 ('ENT_IB_COSUS','aligned_with','ENT_ARES','medium','Cosus is interpreted via interpretatio romana as a Mars-type war god of the Callaeci.','SRC_OLIVARES_IBERIAN','reviewed'),
 ('ENT_ARA_ELAGABAL','aligned_with','ENT_HELIOS','medium','Elagabal of Emesa was assimilated to the sun (Sol Invictus Elagabal) in the Roman period.','SRC_LIPINSKI_ARAMEANS','reviewed'),
 ('ENT_THRA_PLEISTOROS','aligned_with','ENT_ARES','medium','Pleistoros is a Thracian war-god of Ares-type, the recipient of martial human sacrifice (Herodotus 9.119).','SRC_HODDINOTT_THRACIANS','reviewed'),
 ('ENT_THRA_KANDAON','aligned_with','ENT_ARES','low','Late Greek sources (Lycophron, scholia) gloss the Thracian/Macedonian Kandaon as Ares.','SRC_HODDINOTT_THRACIANS','reviewed')
ON CONFLICT (subject_entity_id,relationship_type,object_entity_id) DO NOTHING;

-- ========== L. SOURCE TRANSPARENCY: re-anchor Qurʾan-only entities to epigraphic scholarship; keep Qurʾan as secondary name-attestation ==========
UPDATE entity_sources SET source_id='SRC_HOYLAND_ARABIA'
WHERE source_id='SRC_QURAN' AND entity_id IN ('ENT_SAB_WADD','ENT_SAB_NASR','ENT_SAB_YAGHUTH','ENT_ARAB_SUWA','ENT_ARAB_YAUQ','ENT_ARAB_KAABA_IDOLS');
INSERT INTO entity_sources (entity_id,source_id,evidence_type,source_note)
SELECT v.eid,'SRC_QURAN','direct attestation','Named in Qurʾan 71:23 (the five antediluvian idols of Noah''s people)'
FROM (VALUES ('ENT_SAB_WADD'),('ENT_SAB_NASR'),('ENT_SAB_YAGHUTH'),('ENT_ARAB_SUWA'),('ENT_ARAB_YAUQ')) AS v(eid)
ON CONFLICT DO NOTHING;

\echo '--- post-fix: any fringe orphan / unsourced / unperiodized (must be 0)? ---'
WITH n AS (SELECT entity_id FROM entities WHERE inclusion_basis='Early-antiquity fringe completion (v1.67.0)')
SELECT
 (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=n.entity_id OR r.object_entity_id=n.entity_id)) AS orphans,
 (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_sources s WHERE s.entity_id=n.entity_id)) AS unsourced,
 (SELECT count(*) FROM n WHERE NOT EXISTS(SELECT 1 FROM entity_periods p WHERE p.entity_id=n.entity_id)) AS unperiodized;

COMMIT;
