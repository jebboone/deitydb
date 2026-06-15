-- =====================================================================
-- link_germanic_interpretatio.sql  (v1.62.0)
-- Cross-tradition gap-fill: the Germanic/Norse pantheon was nearly an island
-- (96 entities, ~4 cross-tradition links). Adds the well-attested ancient
-- interpretatio romana of the Germanic gods (Tacitus, Germania; the weekday
-- calques) + the modern scholarly cognate/functional comparisons, kept
-- strictly distinct by relationship_type:
--   * equated_with  = an ANCIENT identification (Tacitus / interpretatio
--                     germanica weekday calque) — high confidence.
--   * aligned_with  = a MODERN cognate (etymological / Dumezilian functional)
--                     comparison, NOT an ancient identification.
-- Also adds 2 Tacitus-attested entities not yet in the DB (Nerthus, the Alcis)
-- and the Welsh<->Irish cognate Don<->Danu.
-- All verified against Tacitus (Perseus) + Simek; nothing fabricated;
-- contested items (Freyja/Venus, Suebian "Isis") deliberately excluded.
-- ON CONFLICT DO NOTHING.
-- =====================================================================
BEGIN;

INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
 ('SRC_TACITUS_GERMANIA','Tacitus, Germania (De origine et situ Germanorum), c. 98 CE',
  'https://www.perseus.tufts.edu/hopper/text?doc=Perseus:text:1999.02.0083','primary text','Germanic religion / interpretatio romana')
ON CONFLICT (source_id) DO NOTHING;

-- 2 new Tacitus-attested Germanic entities
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 ('ENT_NOR_NERTHUS','Nerthus','Germanic/Norse','Goddess','Continental Germanic','the earth; fertility; peace; the wagon-procession','regional','A','candidate_verified_name','Tacitus, Germania 40',5,false,false,
  'A continental Germanic earth-goddess worshipped by seven Suebian tribes with a wagon-procession rite on an ocean island; Tacitus glosses her explicitly as "Terra Mater." Etymological precursor of the later (masculine) Njord.'),
 ('ENT_NOR_ALCIS','The Alcis','Germanic/Norse','God','Continental Germanic','divine twins; young brother-gods','regional','B','candidate_verified_name','Tacitus, Germania 43',0,false,false,
  'A pair of young brother-gods worshipped by the Nahanarvali (a Lugian tribe), whom Tacitus equates by Roman interpretation with Castor and Pollux; the Germanic reflex of the Indo-European Divine Twins.')
ON CONFLICT (entity_id) DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_NOR_NERTHUS','SRC_TACITUS_GERMANIA','direct attestation','Germania 40 ("Nerthum, id est Terram matrem").'),
 ('ENT_NOR_NERTHUS','SRC_SIMEK_NORTHERN','scholarly attestation','Simek, s.v. Nerthus.'),
 ('ENT_NOR_ALCIS','SRC_TACITUS_GERMANIA','direct attestation','Germania 43 (the Nahanarvali twins = Castor and Pollux).'),
 ('ENT_NOR_ALCIS','SRC_SIMEK_NORTHERN','scholarly attestation','Simek, s.v. Alcis.')
ON CONFLICT (entity_id, source_id, evidence_type) DO NOTHING;

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_NOR_NERTHUS','PER_NOR_VIKING','B','Continental Germanic; attested 1st c. CE (Tacitus), grouped with the Norse corpus.','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_ALCIS','PER_NOR_VIKING','B','Continental Germanic; attested 1st c. CE (Tacitus), grouped with the Norse corpus.','SRC_TACITUS_GERMANIA','reviewed')
ON CONFLICT (entity_id, period_id) DO NOTHING;

-- ---- interpretatio (ancient identification) -> equated_with, high confidence ----
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_NOR_ODIN','equated_with','ENT_ROM_MERCURY','high','Interpretatio romana: Tacitus (Germania 9; Annals 13.57) names the chief Germanic god "Mercury"; confirmed by the weekday calque dies Mercurii -> Wodnesdaeg (Wednesday).','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_TYR','equated_with','ENT_ROM_MARS','high','Interpretatio romana: Tacitus (Germania 9) gives "Mars" for the war-god Tiwaz/Tyr; weekday calque dies Martis -> Tiwesdaeg (Tuesday).','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_THOR','equated_with','ENT_HERACLES','high','Interpretatio romana: Tacitus (Germania 9) names "Hercules" among the Germanic gods, read by scholars as Thor/Donar on the basis of strength and the club/hammer champion-motif.','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_THOR','equated_with','ENT_ROM_JUPITER','high','Interpretatio germanica: the weekday calque dies Iovis -> Thunresdaeg (Thursday) equates the thunderer Donar/Thor with Jupiter Tonans. (A distinct basis from the Tacitean Hercules link.)','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_FRIGG','equated_with','ENT_ROM_VENUS','high','Interpretatio germanica: the weekday calque dies Veneris -> Frigedaeg (Friday) renders Venus with the chief goddess Frija/Frigg.','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_NERTHUS','equated_with','ENT_ROM_TELLUS','high','Tacitus (Germania 40) explicitly: "Nerthum, id est Terram matrem" — Nerthus is Mother Earth (Roman Terra Mater / Tellus).','SRC_TACITUS_GERMANIA','reviewed'),
 ('ENT_NOR_ALCIS','equated_with','ENT_DIOSCURI','high','Tacitus (Germania 43): the Nahanarvali twins are, "by Roman interpretation," Castor and Pollux (the Dioscuri).','SRC_TACITUS_GERMANIA','reviewed'),
-- ---- modern cognate / functional comparisons -> aligned_with ----
 ('ENT_NOR_ODIN','aligned_with','ENT_HERMES','medium','Modern functional parallel: Odin and Hermes as wandering psychopomps, gods of eloquence and hidden knowledge (Davidson; Simek). Layered on the firmer Mercury interpretatio.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_TYR','aligned_with','ENT_ZEUS','medium','Etymological cognate within the PIE *dyew- family (Tyr/*Tiwaz, Zeus, Jupiter, Dyaus) — but INDIRECT, via the common noun *deywos, NOT a direct reflex of *Dyeus; and the ancient interpretatio equates Tyr with Mars, not Zeus. Recorded as a cognate, not an identification.','SRC_SIMEK_NORTHERN','reviewed'),
 ('ENT_NOR_ALCIS','aligned_with','ENT_DIOSCURI','medium','The Indo-European "Divine Twins" comparison (Alcis, Dioskouroi, Vedic Asvins) — Dumezilian/scholarly, distinct from the ancient Tacitean equation already recorded as equated_with.','SRC_SIMEK_NORTHERN','reviewed'),
-- ---- Celtic Welsh<->Irish cognate still missing ----
 ('ENT_WEL_DON','aligned_with','ENT_CEL_DANU','high','The Welsh mother-goddess Don is the cognate/counterpart of the Irish Danu (the divine matriarchs of the two Celtic mythologies).','SRC_MACKILLOP_CELTIC','reviewed'),
-- intra-Norse: keep Nerthus connected (Njord is her later continuation)
 ('ENT_NOR_NJORD','reception_of','ENT_NOR_NERTHUS','high','The Vanir sea-god Njord is the later (masculinised) continuation of the continental earth-goddess Nerthus; the names are the same (*Nerthuz).','SRC_SIMEK_NORTHERN','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

COMMIT;
\echo '== Germanic/Norse cross-tradition links now =='
SELECT count(*) FROM v_public_cross_tradition_links WHERE tradition='Germanic/Norse' OR linked_tradition='Germanic/Norse';
\echo '== total cross-tradition links =='
SELECT count(*) FROM v_public_cross_tradition_links;
\echo '== integrity (expect 0/0/0/0) =='
SELECT (SELECT unreviewed_duplicates FROM v_release_metrics) ud, (SELECT unresolved_relationships FROM v_release_metrics) ur,
       (SELECT count(*) FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id)) unsourced,
       (SELECT count(*) FROM (SELECT entity_id,source_id FROM entity_sources GROUP BY 1,2 HAVING count(*)>1) d) dup_pairs;
