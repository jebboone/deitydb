-- scripts/add_pistis_sophia_jeuian.sql
-- Gnostic expansion II (v1.30.0): the Pistis Sophia / Jeuian (Askew & Bruce Codex)
-- light-world, 3rd-4th c. Egypt — the user's active research focus (Session 2 notes).
--
-- Sourced from the Pistis Sophia (Askew Codex) and the Books of Jeu (Bruce Codex).
-- Maps the late-Gnostic "Treasury of Light" cosmology: the upper light-world (First
-- Mystery, Treasury, Jeu, the Virgin of the Light, the Receivers, Melchizedek) and the
-- fall-narrative of the penitent Pistis Sophia oppressed by Authades and Adamas the
-- Tyrant in the Thirteenth Aeon. tradition='Gnostic' (syncretic late stratum);
-- precise provenance carried by the text-level sources.

BEGIN;

-- ── Sources ──────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, url, source_type, scope) VALUES
('SRC_PISTIS_SOPHIA','Pistis Sophia (Askew Codex), c. 3rd-4th c. CE, Egypt','','primary text','Late-Gnostic cosmology: the First Mystery, the Treasury of Light, the Virgin of the Light, the penitent Pistis Sophia and the rulers of the aeons'),
('SRC_BOOKS_OF_JEU','The (Two) Books of Jeu (Bruce Codex), c. 3rd-4th c. CE, Egypt','','primary text','Jeuian ritual cosmology: Jeu the overseer of the Light, the emanations, seals and names, the Fire Baptism and the ascent of the soul')
ON CONFLICT (source_id) DO NOTHING;

-- ── Entities ─────────────────────────────────────────────────────────────────
INSERT INTO entities (entity_id, canonical_name, entity_type, tradition, category, primary_period, evidence_confidence, review_status, short_note) VALUES
-- Upper light-world
('ENT_PS_FIRST_MYSTERY','First Mystery','Supreme principle/savior','Gnostic','Revealer/savior','PER_GNO_2ND_4TH','A','reviewed',
 'The First Mystery (the outward-looking face of the Ineffable) in the Pistis Sophia; the supreme savior with whom the risen Jesus is identified, who descends to rescue the fallen Pistis Sophia.'),
('ENT_PS_TREASURY_LIGHT','Treasury of the Light','Cosmic realm/category','Gnostic','Cosmological category','PER_GNO_2ND_4TH','A','reviewed',
 'The Treasury of the Light (Thesauros), the highest light-realm of the Pistis Sophia and Books of Jeu, holding the 24 invisibles and the five Helpers; the destination of souls that have received the mysteries.'),
('ENT_PS_JEU','Jeu','Light-overseer/First Man','Gnostic','Cosmic administrator','PER_GNO_2ND_4TH','A','reviewed',
 'Jeu, the "overseer of the Light" and First Man, who orders the emanations and the places of the aeons; eponym of the Books of Jeu and the great arranger of the light-world.'),
('ENT_PS_VIRGIN_LIGHT','Virgin of the Light','Light judge/savior figure','Gnostic','Judge/psychopomp','PER_GNO_2ND_4TH','A','reviewed',
 'The Virgin of the Light, the celestial judge who examines souls, inspects their seals and mysteries, and either advances them or assigns them (through her receivers) to rebirth; called "the Judge" in the Fire Baptism.'),
('ENT_PS_RECEIVERS','Receivers of the Light','Angelic collective','Gnostic','Angelic collective','PER_GNO_2ND_4TH','B','reviewed',
 'The receivers (paralemptai) of the Light, the angelic functionaries who take souls from the Virgin of the Light and convey them, whether upward to the Light or back to the sphere of rebirth.'),
('ENT_PS_MELCHIZEDEK','Melchizedek (Zorokothora)','Light-purifier/receiver','Gnostic','Light-purifier','PER_GNO_2ND_4TH','A','reviewed',
 'Zorokothora Melchizedek, the great Receiver and Purifier of the Light in the Pistis Sophia and Books of Jeu, who gathers the purified light and carries it up into the Treasury of the Light.'),
('ENT_PS_FIVE_HELPERS','Five Helpers','Aeonic collective','Gnostic','Aeonic collective','PER_GNO_2ND_4TH','B','reviewed',
 'The five Helpers (parastatai), great powers of the Treasury of the Light in the Pistis Sophia.'),
('ENT_PS_24_INVISIBLES','Twenty-four Invisibles','Aeonic collective','Gnostic','Aeonic collective','PER_GNO_2ND_4TH','B','reviewed',
 'The twenty-four invisible emanations associated with the great Invisible One and the Treasury of the Light in the Pistis Sophia.'),
-- The fall narrative
('ENT_PS_PISTIS_SOPHIA','Pistis Sophia','Fallen aeon/penitent','Gnostic','Fallen aeon','PER_GNO_2ND_4TH','A','reviewed',
 'Pistis Sophia ("Faith-Wisdom"), the aeon of the Thirteenth Aeon who, deceived by a false light, descends and is afflicted in the Chaos; her thirteen repentances and rescue by the First Mystery are the heart of the Askew Codex.'),
('ENT_PS_THIRTEENTH_AEON','Thirteenth Aeon','Cosmic realm/category','Gnostic','Cosmological category','PER_GNO_2ND_4TH','A','reviewed',
 'The Thirteenth Aeon, the realm above the twelve aeons where Pistis Sophia and the rulers of her region (Authades, Adamas the Tyrant) dwell in the Pistis Sophia.'),
('ENT_PS_AUTHADES','Authades','Adversarial archon','Gnostic','Adversarial being','PER_GNO_2ND_4TH','A','reviewed',
 'Authades ("the Arrogant" / Self-willed), the proud power of the Thirteenth Aeon who, envying Pistis Sophia, lures her down with a false light and torments her in the Chaos through his lion-faced emanation.'),
('ENT_PS_ADAMAS_TYRANT','Adamas the Tyrant','Adversarial ruler','Gnostic','Adversarial being','PER_GNO_2ND_4TH','A','reviewed',
 'Adamas the Tyrant, a chief archon who with his rulers oppresses Pistis Sophia in the Chaos in the Askew Codex. Distinct from the Sethian heavenly Adamas (ENT_SET_ADAMAS), with whom he shares only a name.'),
('ENT_PS_LION_FACED','Lion-faced Power','Adversarial emanation','Gnostic','Adversarial being','PER_GNO_2ND_4TH','A','reviewed',
 'The lion-faced power, the emanation of Authades disguised as light, by which Pistis Sophia is deceived and afflicted in the Chaos.')
ON CONFLICT (entity_id) DO NOTHING;

-- ── Entity sources ───────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, 'SRC_PISTIS_SOPHIA', 'Direct attestation', 'Named in the Pistis Sophia (Askew Codex).'
FROM (VALUES
 ('ENT_PS_FIRST_MYSTERY'),('ENT_PS_TREASURY_LIGHT'),('ENT_PS_JEU'),('ENT_PS_VIRGIN_LIGHT'),
 ('ENT_PS_RECEIVERS'),('ENT_PS_MELCHIZEDEK'),('ENT_PS_FIVE_HELPERS'),('ENT_PS_24_INVISIBLES'),
 ('ENT_PS_PISTIS_SOPHIA'),('ENT_PS_THIRTEENTH_AEON'),('ENT_PS_AUTHADES'),('ENT_PS_ADAMAS_TYRANT'),
 ('ENT_PS_LION_FACED')
) AS t(e)
ON CONFLICT DO NOTHING;

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
SELECT e, 'SRC_BOOKS_OF_JEU', 'Direct attestation', 'Also attested in the Books of Jeu (Bruce Codex).'
FROM (VALUES
 ('ENT_PS_JEU'),('ENT_PS_TREASURY_LIGHT'),('ENT_PS_VIRGIN_LIGHT'),('ENT_PS_MELCHIZEDEK')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Entity periods ───────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
SELECT e, 'PER_GNO_2ND_4TH', 'high', 'Figure of the Askew/Bruce Codex Gnostic cosmology (3rd-4th c.).', 'SRC_PISTIS_SOPHIA', 'reviewed'
FROM (VALUES
 ('ENT_PS_FIRST_MYSTERY'),('ENT_PS_TREASURY_LIGHT'),('ENT_PS_JEU'),('ENT_PS_VIRGIN_LIGHT'),
 ('ENT_PS_RECEIVERS'),('ENT_PS_MELCHIZEDEK'),('ENT_PS_FIVE_HELPERS'),('ENT_PS_24_INVISIBLES'),
 ('ENT_PS_PISTIS_SOPHIA'),('ENT_PS_THIRTEENTH_AEON'),('ENT_PS_AUTHADES'),('ENT_PS_ADAMAS_TYRANT'),
 ('ENT_PS_LION_FACED')
) AS t(e)
ON CONFLICT DO NOTHING;

-- ── Relationships ────────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id, confidence, rationale, source_id, period_id, review_status) VALUES
-- Upper light-world structure
('ENT_PS_FIRST_MYSTERY','emanates_from','ENT_GNO_MONAD','high','The First Mystery is the manifest face of the Ineffable (the Monad/One).','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_FIRST_MYSTERY','identified_with','ENT_GNO_CHRIST','high','The risen Jesus reveals himself as the First Mystery looking outward.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_24_INVISIBLES','dwells_in','ENT_PS_TREASURY_LIGHT','high','The twenty-four invisibles belong to the Treasury of the Light.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_FIVE_HELPERS','member_of','ENT_PS_TREASURY_LIGHT','high','The five Helpers are great powers of the Treasury of the Light.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_JEU','rules','ENT_PS_TREASURY_LIGHT','medium','Jeu, overseer of the Light, orders the Treasury and its emanations.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_JEU','emanates_from','ENT_PS_FIRST_MYSTERY','medium','Jeu is produced from the First Mystery to arrange the light-world.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_JEU','rules','ENT_GNO_AEONS','medium','Jeu sets in order the places of the aeons and their rulers.','SRC_BOOKS_OF_JEU','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_TREASURY_LIGHT','aligned_with','ENT_SALVATION','medium','The Treasury of the Light is the goal and inheritance of the saved soul.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
-- Judgment of souls
('ENT_PS_VIRGIN_LIGHT','judges','ENT_DEAD','high','The Virgin of the Light examines and judges the souls of the dead.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_VIRGIN_LIGHT','rules','ENT_PS_RECEIVERS','high','The Virgin of the Light directs her receivers, who take charge of the souls.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_RECEIVERS','guides','ENT_DEAD','high','The receivers convey souls upward to the Light or back to the sphere of rebirth.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_MELCHIZEDEK','rules','ENT_PS_RECEIVERS','medium','Zorokothora Melchizedek is the great receiver over the gatherers of the light.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_MELCHIZEDEK','mediates','ENT_SALVATION','medium','Melchizedek purifies and carries the gathered light up into the Treasury, mediating the soul''s salvation.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
-- The fall and rescue of Pistis Sophia
('ENT_PS_PISTIS_SOPHIA','identified_with','ENT_GNO_SOPHIA','high','Pistis Sophia is the Askew Codex form of the Gnostic aeon Sophia.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_PISTIS_SOPHIA','dwells_in','ENT_PS_THIRTEENTH_AEON','high','Pistis Sophia originally dwells in the Thirteenth Aeon before her descent.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_PISTIS_SOPHIA','undergoes_process','ENT_SALVATION','high','Through thirteen repentances Pistis Sophia is purified and restored — the paradigm of the penitent soul.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_AUTHADES','opposes','ENT_PS_PISTIS_SOPHIA','high','Authades envies and persecutes Pistis Sophia, luring her into the Chaos.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_AUTHADES','dwells_in','ENT_PS_THIRTEENTH_AEON','high','Authades is a proud power of the Thirteenth Aeon.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_AUTHADES','parent_of','ENT_PS_LION_FACED','high','The lion-faced power is the emanation of Authades.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_LION_FACED','causes_affliction','ENT_PS_PISTIS_SOPHIA','high','The lion-faced power, disguised as light, deceives and torments Pistis Sophia.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_ADAMAS_TYRANT','opposes','ENT_PS_PISTIS_SOPHIA','high','Adamas the Tyrant and his rulers oppress Pistis Sophia in the Chaos.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_ADAMAS_TYRANT','member_of','ENT_GNO_ARCHONS','medium','Adamas the Tyrant is a chief archon of the lower rulers.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_PS_THIRTEENTH_AEON','member_of','ENT_GNO_AEONS','medium','The Thirteenth Aeon stands at the head of the aeonic structure, above the twelve.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
-- the First Mystery sends the Israelite archangels to carry Sophia out of the Chaos
('ENT_ISR_MICHAEL','guides','ENT_PS_PISTIS_SOPHIA','medium','Michael and Gabriel are sent to bear Pistis Sophia up out of the Chaos on their hands.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed'),
('ENT_ISR_GABRIEL','guides','ENT_PS_PISTIS_SOPHIA','medium','Gabriel, with Michael, carries Pistis Sophia out of the Chaos.','SRC_PISTIS_SOPHIA','PER_GNO_2ND_4TH','reviewed')
ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ───────────────────────────────────────────────────────────────────
SELECT count(*) AS unsourced_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_sources s WHERE s.entity_id=e.entity_id);
SELECT count(*) AS unsourced_rels FROM entity_relationships WHERE source_id IS NULL OR source_id='';
SELECT count(*) AS orphan_entities FROM entities e WHERE NOT EXISTS (SELECT 1 FROM entity_relationships r WHERE r.subject_entity_id=e.entity_id OR r.object_entity_id=e.entity_id);
SELECT count(*) AS unreviewed_dups FROM v_unreviewed_duplicate_entities;
SELECT * FROM v_release_metrics;

COMMIT;
