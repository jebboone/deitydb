-- scripts/build_manichaean_core.sql
-- Content normalization IV (v1.46.0): Manichaean build-out. The dualist cosmology of
-- the "Three Times" has a precise cast of divine Evocations and dark powers; the DB had
-- only the 15-entity skeleton. This fills in the canonical figures of the three creations
-- (the Five Sons of the Living Spirit, the Third Messenger and the Maiden of Light, the
-- Call and Answer), the anthropogonic archons (Ashqalun, Nebroel, Az), Mani and his
-- heavenly Twin, Jesus patibilis, and the eschatological Last Statue. Manichaean 15 -> 32.
-- Each entity to a primary Manichaean source (Kephalaia, Psalm-Book, the Cologne Codex).

BEGIN;

-- ── New source: the Cologne Mani Codex (Kephalaia, Psalm-Book already registered) ─
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_CMC','The Cologne Mani Codex (CMC), Greek, on the life and revelations of Mani, c. 5th c. CE','','primary text','The miniature Greek codex recounting Mani''s youth and the revelations of his heavenly Twin')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities
 (entity_id, canonical_name, tradition, entity_type, category, primary_domains, cult_scope,
  evidence_confidence, review_status, inclusion_basis, earth_association_score, chthonic_flag, serpent_flag, short_note)
VALUES
 -- second and third creation evocations
 ('ENT_MANICH_FRIEND_LIGHTS','Friend of the Lights','Manichaean','Lightworld being','Evocation','the second creation; the calling of the Great Builder','Manichaean','A','candidate_verified_name','Manichaean evocation',0,false,false,'The evocation of the second creation, who calls forth the Great Builder.'),
 ('ENT_MANICH_THIRD_MESSENGER','Third Messenger','Manichaean','Lightworld savior','Evocation','the third creation; the seduction of the archons; the liberation of light','Manichaean','A','candidate_verified_name','Manichaean evocation',0,false,false,'The Messenger of the third creation, whose display before the archons frees the swallowed light.'),
 ('ENT_MANICH_MAIDEN_LIGHT','Maiden of Light','Manichaean','Lightworld being','Light-virgin','beauty; the provocation of the archons; the gathering of light','Manichaean','A','candidate_verified_name','Manichaean light-being',0,false,false,'The Virgin of Light whose beauty provokes the archons to release the imprisoned light.'),
 ('ENT_MANICH_KEEPER_SPLENDOUR','Keeper of Splendour','Manichaean','Lightworld being','Cosmic upholder','the upholding of the heavens','Manichaean','A','candidate_verified_name','Son of the Living Spirit',0,false,false,'Splenditenens, who holds up the ten heavens by their highest part.'),
 ('ENT_MANICH_ADAMAS','Adamas of Light','Manichaean','Lightworld warrior','Cosmic warrior','war against the dark; the guarding of the cosmos','Manichaean','A','candidate_verified_name','Son of the Living Spirit',0,false,false,'The warrior-son of the Living Spirit who fights the powers of darkness.'),
 ('ENT_MANICH_KING_GLORY','King of Glory','Manichaean','Lightworld being','Cosmic ruler','the turning of the three wheels of wind, water and fire','Manichaean','A','candidate_verified_name','Son of the Living Spirit',0,false,false,'The son of the Living Spirit who turns the three wheels that raise the light.'),
 ('ENT_MANICH_KING_HONOUR','King of Honour','Manichaean','Lightworld being','Cosmic guardian','the watch over the firmaments','Manichaean','A','candidate_verified_name','Son of the Living Spirit',0,false,false,'The son of the Living Spirit who watches over the firmaments from on high.'),
 ('ENT_MANICH_PORTER','Porter','Manichaean','Lightworld being','Cosmic upholder','the bearing of the earths','Manichaean','A','candidate_verified_name','Son of the Living Spirit',1,false,false,'Omophoros (Atlas), who carries the burden of the earths upon his shoulders.'),
 ('ENT_MANICH_CALL_ANSWER','Call and Answer','Manichaean','Lightworld being','Awakening pair','the awakening of the fallen light','Manichaean','A','candidate_verified_name','Manichaean awakening-pair',0,false,false,'Xroshtag and Padvaxtag, the Call and the Answer sent to rouse the fallen Primal Man.'),
 ('ENT_MANICH_JESUS_PATIBILIS','Jesus patibilis','Manichaean','Suffering savior','Cosmic suffering','the light crucified in matter; the suffering of the world-soul','Manichaean','A','candidate_verified_name','Manichaean suffering-Jesus',0,false,false,'The Suffering Jesus, the Cross of Light: the world-soul crucified throughout matter.'),
 ('ENT_MANICH_LAST_STATUE','Last Statue','Manichaean','Eschatological figure','Final gathering','the eschaton; the last gathering and ascent of light','Manichaean','A','candidate_verified_name','Manichaean eschatology',0,false,false,'The Last Statue (Andrias), the final image of redeemed light that ascends at the end.'),
 -- the dark anthropogony
 ('ENT_MANICH_AZ','Az','Manichaean','Demoness','Concupiscence','greed; lust; the fashioning of the human body','Manichaean','A','candidate_verified_name','Manichaean demoness',0,true,false,'Az, the demoness of greed and concupiscence, who shapes the body of Adam to imprison the light.'),
 ('ENT_MANICH_ASHQALUN','Ashqalun','Manichaean','Archon','Anthropogonic archon','the devouring of the abortions; the making of Adam','Manichaean','A','candidate_verified_name','Manichaean archon',0,true,false,'The male archon (Saklas) who, with Nebroel, devours the abortions and fashions Adam.'),
 ('ENT_MANICH_NEBROEL','Nebroel','Manichaean','Archon','Anthropogonic archon','the making of Eve; the binding of light in flesh','Manichaean','A','candidate_verified_name','Manichaean archon',0,true,false,'The female archon who, with Ashqalun, produces the first human pair.'),
 ('ENT_MANICH_FIVE_DARK_WORLDS','Five Worlds of Darkness','Manichaean','Adversarial collective','Dark elements','smoke, fire, wind, water, darkness; the realm of the King of Darkness','Manichaean','A','candidate_verified_name','Manichaean dark realm',0,true,false,'The five dark worlds (smoke, fire, wind, water, darkness) ruled by the King of Darkness.'),
 -- the apostle and his Twin
 ('ENT_MANICH_MANI','Mani','Manichaean','Prophet','Apostle of Light','the Paraclete; the final revelation; the seal of the prophets','Manichaean','A','candidate_verified_name','Founder-apostle (incarnate Paraclete)',0,false,false,'The Apostle of Light, the incarnate Paraclete who proclaimed the final revelation.'),
 ('ENT_MANICH_TWIN','The Twin','Manichaean','Lightworld being','Heavenly counterpart','revelation; the divine self; the guidance of the apostle','Manichaean','A','candidate_verified_name','Mani''s heavenly Twin',0,false,false,'The Syzygos, Mani''s heavenly Twin, who revealed to him the mysteries of light and dark.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note) VALUES
 ('ENT_MANICH_FRIEND_LIGHTS','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia ch. 7 (the cosmogony of the evocations): the Friend of the Lights of the second creation.'),
 ('ENT_MANICH_THIRD_MESSENGER','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia ch. 7: the Third Messenger, whose epiphany before the archons liberates the light.'),
 ('ENT_MANICH_MAIDEN_LIGHT','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia: the Maiden/Virgin of Light who appears to the archons with the Third Messenger.'),
 ('ENT_MANICH_KEEPER_SPLENDOUR','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia ch. 7: Splenditenens, the Keeper of Splendour, first of the five sons of the Living Spirit.'),
 ('ENT_MANICH_ADAMAS','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia: Adamas of Light, the warrior-son of the Living Spirit.'),
 ('ENT_MANICH_KING_GLORY','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia: the King of Glory, who turns the three wheels of wind, water and fire.'),
 ('ENT_MANICH_KING_HONOUR','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia: the King of Honour, who watches over the firmaments.'),
 ('ENT_MANICH_PORTER','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia: Omophoros, the Porter, who bears the earths on his shoulders.'),
 ('ENT_MANICH_CALL_ANSWER','SRC_MANICHAEAN_PSALM_BOOK','Direct attestation','The Coptic Psalm-Book: Xroshtag and Padvaxtag, the Call and the Answer that awaken the Primal Man.'),
 ('ENT_MANICH_JESUS_PATIBILIS','SRC_MANICHAEAN_PSALM_BOOK','Direct attestation','The Psalm-Book (the Bema and Jesus psalms): Jesus patibilis, the light suffering crucified in matter.'),
 ('ENT_MANICH_LAST_STATUE','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia: the Last Statue (Andrias), the final ascent of the gathered light at the end of the world.'),
 ('ENT_MANICH_AZ','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia; the Middle Persian cosmogony: Az, the demoness of concupiscence who fashions the human body.'),
 ('ENT_MANICH_ASHQALUN','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia (the anthropogony); cf. Theodore bar Konai: Ashqalun (Saklas) devours the abortions and makes Adam.'),
 ('ENT_MANICH_NEBROEL','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia; cf. Theodore bar Konai: Nebroel, the female archon who with Ashqalun makes the first pair.'),
 ('ENT_MANICH_FIVE_DARK_WORLDS','SRC_MANICHAEAN_KEPHALAIA','Direct attestation','Kephalaia ch. 6: the five dark worlds of smoke, fire, wind, water and darkness.'),
 ('ENT_MANICH_MANI','SRC_CMC','Direct attestation','The Cologne Mani Codex: Mani, the Apostle of Light and incarnate Paraclete.'),
 ('ENT_MANICH_MANI','SRC_MANICHAEAN_PSALM_BOOK','Direct attestation','The Psalm-Book: Mani hymned as the apostle and seal of the prophets.'),
 ('ENT_MANICH_TWIN','SRC_CMC','Direct attestation','The Cologne Mani Codex: the heavenly Twin (Syzygos) who reveals the truth to Mani.')
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, review_status) VALUES
 ('ENT_MANICH_FRIEND_LIGHTS','emanates_from','ENT_MANICH_FATHER_GREATNESS','high','The Friend of the Lights is evoked by the Father in the second creation.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_GREAT_BUILDER','emanates_from','ENT_MANICH_FRIEND_LIGHTS','high','The Friend of the Lights calls forth the Great Builder.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_KEEPER_SPLENDOUR','child_of','ENT_MANICH_LIVING_SPIRIT','high','The Keeper of Splendour is a son of the Living Spirit.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_ADAMAS','child_of','ENT_MANICH_LIVING_SPIRIT','high','Adamas of Light is a son of the Living Spirit.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_KING_GLORY','child_of','ENT_MANICH_LIVING_SPIRIT','high','The King of Glory is a son of the Living Spirit.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_KING_HONOUR','child_of','ENT_MANICH_LIVING_SPIRIT','high','The King of Honour is a son of the Living Spirit.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_PORTER','child_of','ENT_MANICH_LIVING_SPIRIT','high','The Porter (Omophoros) is a son of the Living Spirit.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_THIRD_MESSENGER','emanates_from','ENT_MANICH_FATHER_GREATNESS','high','The Third Messenger is evoked by the Father in the third creation.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_THIRD_MESSENGER','deceives_or_tempts','ENT_MANICH_ARCHONS','high','The Messenger''s epiphany provokes the archons to release the swallowed light.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_MAIDEN_LIGHT','aligned_with','ENT_MANICH_THIRD_MESSENGER','high','The Maiden of Light appears with the Third Messenger to provoke the archons.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_CALL_ANSWER','emanates_from','ENT_MANICH_LIVING_SPIRIT','high','The Call and Answer are sent by the Living Spirit to the fallen Primal Man.','SRC_MANICHAEAN_PSALM_BOOK','reviewed'),
 ('ENT_MANICH_CALL_ANSWER','rescues','ENT_MANICH_PRIMAL_MAN','high','The Call rouses, and the Answer raises, the fallen Primal Man.','SRC_MANICHAEAN_PSALM_BOOK','reviewed'),
 ('ENT_MANICH_JESUS_PATIBILIS','aligned_with','ENT_MANICH_LIGHT_PARTICLES','high','Jesus patibilis is the suffering light scattered and bound throughout matter.','SRC_MANICHAEAN_PSALM_BOOK','reviewed'),
 ('ENT_MANICH_JESUS_PATIBILIS','imprisoned_by','ENT_MANICH_MATTER','high','The Suffering Jesus is the world-soul crucified within matter.','SRC_MANICHAEAN_PSALM_BOOK','reviewed'),
 ('ENT_MANICH_LAST_STATUE','aligned_with','ENT_MANICH_COLUMN_GLORY','medium','The Last Statue is the final ascent of the light gathered up the Column of Glory.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_AZ','reception_of','ENT_ZOR_AZ','high','The Manichaean Az develops the Zoroastrian demoness of greed (Az).','SRC_LIEU_MANICHAEISM','reviewed'),
 ('ENT_MANICH_AZ','aligned_with','ENT_MANICH_KING_DARKNESS','high','Az is the chief demoness of the realm of the King of Darkness.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_ASHQALUN','consort_of','ENT_MANICH_NEBROEL','high','Ashqalun and Nebroel mate to produce the first human pair.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_ASHQALUN','member_of','ENT_MANICH_ARCHONS','high','Ashqalun is one of the archons of darkness.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_NEBROEL','member_of','ENT_MANICH_ARCHONS','high','Nebroel is one of the archons of darkness.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_FIVE_DARK_WORLDS','ruled_by','ENT_MANICH_KING_DARKNESS','high','The five dark worlds are the domain of the King of Darkness.','SRC_MANICHAEAN_KEPHALAIA','reviewed'),
 ('ENT_MANICH_TWIN','guides','ENT_MANICH_MANI','high','The heavenly Twin reveals the truth to Mani and guides his mission.','SRC_CMC','reviewed'),
 ('ENT_MANICH_TWIN','emanates_from','ENT_MANICH_LIGHT_MIND','medium','The Twin is sent from the Light-Nous (the Paraclete) to Mani.','SRC_CMC','reviewed'),
 ('ENT_MANICH_MANI','aligned_with','ENT_MANICH_LIGHT_MIND','high','Mani is the incarnate Paraclete, the apostle of the Light-Nous.','SRC_CMC','reviewed')
ON CONFLICT DO NOTHING;

-- ── Duplicate-name discipline: the Manichaean Az is a reception of the Zoroastrian
--    demoness Az (the reception edge is wired above). Register both as distinct. ──
INSERT INTO entity_duplicate_review (canonical_name, entity_id, duplicate_group_note, decision) VALUES
 ('Az','ENT_ZOR_AZ','Reviewed duplicate canonical name; the Zoroastrian demoness of greed, distinct from her Manichaean reception.','intentional_distinct'),
 ('Az','ENT_MANICH_AZ','Reviewed duplicate canonical name; the Manichaean demoness of concupiscence, a reception of the Zoroastrian Az.','intentional_distinct')
ON CONFLICT (canonical_name, entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT 'Manichaean entities' AS label, count(*) FROM entities WHERE tradition='Manichaean';
SELECT count(*) AS unsourced FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unresolved_rel FROM entity_relationships r
  WHERE NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.object_entity_id)
     OR NOT EXISTS (SELECT 1 FROM entities e WHERE e.entity_id=r.subject_entity_id);
SELECT (SELECT count(*) FROM v_unreviewed_duplicate_entities) AS unreviewed_duplicates;
SELECT * FROM v_release_metrics;

COMMIT;
