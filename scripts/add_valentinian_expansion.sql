-- scripts/add_valentinian_expansion.sql
-- Expands the Valentinian Gnostic cluster:
--
--   NEW SOURCE (1):
--     SRC_IRENAEUS_AH — Irenaeus, Adversus Haereses I.1-9 (c. 180 CE)
--     The fullest ancient account of Valentinian cosmological theology.
--
--   NEW ENTITIES (6):
--     ENT_VAL_DECAD      — the ten sub-aeons from Logos + Zoe (Irenaeus AH I.2)
--     ENT_VAL_DODECAD    — the twelve sub-aeons from Anthropos + Ecclesia (AH I.2)
--     ENT_VAL_MONOGENES  — Only-begotten (Decad; in some Valentinian systems = Nous)
--     ENT_VAL_PISTIS     — Pistis / Faith (Dodecad)
--     ENT_VAL_AGAPE      — Agape / Love (Dodecad)
--     ENT_VAL_THELETOS   — Theletos / Will (Dodecad; paired with Sophia, the 30th aeon)
--
--   CRITICAL FIX: Yaldabaoth (ENT_GNO_YALDABAOTH) had only 1 relationship.
--   Major Gnostic figure — child of Achamoth and chief of the Archons. Added:
--     Achamoth parent_of Yaldabaoth; Yaldabaoth member_of Archons;
--     Yaldabaoth identified_with Saklas and aligned_with Samael.
--
--   STRUCTURAL ADDITIONS:
--     Logos/Zoe parent_of Decad; Anthropos/Ecclesia parent_of Dodecad;
--     Sophia member_of Dodecad; Sophia spouse_of Theletos;
--     Nous/Aletheia emanates_from Bythos/Sige (Ogdoad production chain).

BEGIN;

-- ── 1. Source ─────────────────────────────────────────────────────────────────
INSERT INTO sources (source_id, title, source_type, scope)
VALUES (
  'SRC_IRENAEUS_AH',
  'Irenaeus of Lyons, Adversus Haereses (Against Heresies), c. 180 CE; ed. Rousseau & Doutreleau, SC 263-264, 293-294, 210-211 (Cerf, 1979-2002)',
  'primary text',
  'The five-book polemic by Irenaeus, bishop of Lyon (c. 130–202 CE), is the single most comprehensive ancient source for Gnostic cosmological systems, particularly Valentinian theology. Books I.1-9 provide the fullest surviving account of the Valentinian Pleroma: the thirty aeons in their fifteen syzygies, the names of all Decad and Dodecad members, the emanation sequence from Bythos/Sige through Nous/Aletheia, Logos/Zoe, Anthropos/Ecclesia, the fall of Sophia (the 30th aeon), the production of Achamoth, and the creation of the material world by the Demiurge/Yaldabaoth. Irenaeus is writing polemically against these systems and may not always represent Valentinian theology accurately, but his account preserves details found in no other ancient source and is confirmed on many points by the Nag Hammadi texts discovered in 1945. Essential for all ENT_VAL_* entities and for the Valentinian reception of older Gnostic cosmological concepts. Cited for ENT_VAL_DECAD, ENT_VAL_DODECAD, ENT_VAL_MONOGENES, ENT_VAL_PISTIS, ENT_VAL_AGAPE, ENT_VAL_THELETOS, and the structural Yaldabaoth relationships.'
) ON CONFLICT (source_id) DO NOTHING;

-- ── 2. Entities ───────────────────────────────────────────────────────────────
INSERT INTO entities (
  entity_id, canonical_name, tradition, entity_type, category,
  primary_domains, evidence_confidence, short_note
) VALUES

('ENT_VAL_DECAD',
 'Decad',
 'Valentinian',
 'Aeonic collective / second tier of Pleroma',
 'Aeonic Collective',
 'divine emanation; second Pleroma tier; ten aeons; cosmic fullness; Logos offspring',
 'A',
 'The Decad is the collective name for the ten aeons emanated by the syzygy of Logos and Zoe, constituting the second tier of the Valentinian Pleroma after the primary Ogdoad. Irenaeus (AH I.2.5) names them as five male-female pairs: Bythios and Mixis, Ageratos and Henosis, Autophyes and Hedone, Acinetos and Syncrasis, Monogenes and Macaria (or Theletos and Macaria in some variants). These ten aeons collectively embody aspects of divine creativity, stability, and productive will. The Decad''s significance in the Valentinian system is structural: together with the Ogdoad (first eight aeons) and the Dodecad (twelve aeons), it completes the thirty-aeon Pleroma whose fullness (plēroma) constitutes the divine realm. The crisis in the Pleroma is triggered not within the Decad but in the Dodecad (by Sophia, the 30th aeon), but the Decad''s existence is the precondition for that crisis. Layton (1987) pp. 276-302.'),

('ENT_VAL_DODECAD',
 'Dodecad',
 'Valentinian',
 'Aeonic collective / third tier of Pleroma',
 'Aeonic Collective',
 'divine emanation; third Pleroma tier; twelve aeons; cosmic fullness; Sophia origin; fall',
 'A',
 'The Dodecad is the collective name for the twelve aeons emanated by the syzygy of Anthropos and Ecclesia, constituting the third and final tier of the Valentinian Pleroma. Irenaeus (AH I.2.5-6) names them as six male-female pairs: Paracletos and Pistis, Patricos and Elpis, Metricos and Agape, Ainos and Synesis, Ecclesiasticos and Makariotes, Theletos and Sophia. The theological significance of the Dodecad exceeds the Decad: it is within the Dodecad that the cosmological crisis originates, since Sophia — the 30th and last aeon of the entire Pleroma, paired with Theletos in the Dodecad — is seized by a "passion" to comprehend the Father (Bythos) without her consort, generating an unbounded desire (enthymesis) that, when separated from her by Horos (the boundary), becomes the lower Sophia or Achamoth. This fall of Sophia triggers the creation of the material world by the Demiurge (Yaldabaoth), whom Achamoth produces without a divine partner. The Dodecad thus functions as the point of transition from divine fullness to material creation in the Valentinian cosmological drama. Layton (1987) pp. 276-302.'),

('ENT_VAL_MONOGENES',
 'Monogenes',
 'Valentinian',
 'Aeon / Only-begotten',
 'Aeon',
 'divine sonship; unique knowledge of the Father; only-begotten principle; Nous variant; Decad',
 'A',
 'Monogenes ("Only-begotten") is one of the ten Decad aeons in the Valentinian Pleroma, paired with Macaria ("Blessedness"), and produced by the syzygy of Logos and Zoe (Irenaeus AH I.2.5). He occupies a special position in some Valentinian traditions because the title "Monogenes" is also applied to Nous (the second aeon, paired with Aletheia), who alone has knowledge of the Father (Bythos): "Nous alone, which is also called Only-begotten and Father and Beginning of all things, was able to know the size of the Father" (Irenaeus AH I.2.1). This creates a theological ambiguity in Valentinianism: there is a Decad-level Monogenes (paired with Macaria in the Decad sequence) and a title Monogenes applied to the second Ogdoad aeon Nous. The term "Monogenes" is also the Greek theological term used for Christ''s divine Sonship in the Gospel of John (1:14, 18; 3:16), making this concept a bridge point between Valentinian aeon theology and orthodox Christology. Layton (1987) pp. 276-302; Irenaeus AH I.2.5.'),

('ENT_VAL_PISTIS',
 'Pistis',
 'Valentinian',
 'Aeon / personified Faith',
 'Aeon',
 'faith; divine trust; Dodecad; Paracletos pair; Pistis Sophia tradition; salvific trust',
 'A',
 'Pistis ("Faith") is one of the twelve Dodecad aeons in the Valentinian Pleroma, paired with Paracletos ("Comforter" — the Valentinian appropriation of the Johannine Paraclete concept). Produced by the syzygy of Anthropos and Ecclesia, Pistis personifies the theological virtue of faith as a cosmic, divine quality rather than a human disposition — in Valentinian theology, Pistis is the archetypal pattern of which human faith is a shadow. The figure of Pistis acquires much greater theological development in the text known as Pistis Sophia (possibly 3rd–4th c. CE), a Coptic Gnostic dialogue in which Sophia/Pistis is a fallen aeon who descends through thirteen emanations seeking rescue from the material realm — an extended narrative elaboration of the Valentinian cosmological drama. In the Pistis Sophia text, the figure named "Pistis Sophia" conflates the Dodecad aeon Pistis with the fallen Sophia, creating a hybrid narrative figure distinct from the Valentinian Decad/Dodecad structure. Layton (1987) pp. 299-300; Irenaeus AH I.2.5.'),

('ENT_VAL_AGAPE',
 'Agape',
 'Valentinian',
 'Aeon / personified Love',
 'Aeon',
 'love; divine charity; Dodecad; Metricos pair; cosmic love principle; Pleroma binding force',
 'A',
 'Agape ("Love") is one of the twelve Dodecad aeons in the Valentinian Pleroma, paired with Metricos ("Measurer"). Like Pistis, Agape personifies a theological virtue as a cosmic divine reality. In Valentinian theology, the agape that binds the Pleroma is the divine love through which all aeons are oriented toward the Father — it is the binding force of the divine fullness. The prominence of Agape in the Dodecad reflects Valentinianism''s deep engagement with the Johannine tradition (1 John 4:8: "God is Agape") and Paul''s hymn to love in 1 Corinthians 13. For Valentinian theologians, Paul''s statement that "love never fails" (1 Cor 13:8) while knowledge and prophecy pass away supports the aeon Agape''s permanent role in the Pleroma even after the Fall of Sophia and its aftermath. Irenaeus AH I.2.5; Layton (1987) pp. 299-300.'),

('ENT_VAL_THELETOS',
 'Theletos',
 'Valentinian',
 'Aeon / Divine Will',
 'Aeon',
 'divine will; Dodecad; Sophia pair; cosmological crisis; fall of Sophia; Pleroma limit',
 'A',
 'Theletos ("Will" or "Desired One") is the second-to-last of the thirty Valentinian aeons, paired with Sophia as the final male-female syzygy of the Dodecad (Irenaeus AH I.1.1-3; I.2.5). He is theologically pivotal: Sophia''s fall occurs specifically because she desires to comprehend the Father without her consort Theletos — her passion/desire (enthymesis) erupts as a desire to "know" the Father directly, bypassing the proper mediation of her syzygy partner. Without Theletos, Sophia''s unbounded desire cannot be contained, and it overflows the Pleroma boundary, generating the crisis that eventually produces Achamoth (Lower Sophia) and the material world. Theletos thus represents the principle of divine Will as the proper partner of Wisdom — the absence of Theletos from Sophia''s creative act is precisely what makes her creation defective and material rather than spiritual. In later Valentinian theology (as preserved in the Gospel of Philip, NHC II,3), the relationship of Theletos and Sophia informs the discussion of proper spiritual pairing (the "bridal chamber" motif). Irenaeus AH I.1.1-3; Layton (1987) pp. 289-302.')

ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Entity sources ─────────────────────────────────────────────────────────
INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
('ENT_VAL_DECAD',    'SRC_IRENAEUS_AH',  'Primary text', 'AH I.2.5: names of the ten Decad aeons in five pairs from Logos+Zoe.'),
('ENT_VAL_DECAD',    'SRC_LAYTON_GNOSTIC','Secondary scholarly', 'Layton (1987) pp. 276-302: analysis of Valentinian Pleroma structure.'),
('ENT_VAL_DODECAD',  'SRC_IRENAEUS_AH',  'Primary text', 'AH I.2.5-6: names of the twelve Dodecad aeons; Sophia as the 30th and final aeon.'),
('ENT_VAL_DODECAD',  'SRC_LAYTON_GNOSTIC','Secondary scholarly', 'Layton (1987) pp. 276-302.'),
('ENT_VAL_MONOGENES','SRC_IRENAEUS_AH',  'Primary text', 'AH I.2.1 (Nous as Monogenes); I.2.5 (Monogenes as Decad aeon paired with Macaria).'),
('ENT_VAL_PISTIS',   'SRC_IRENAEUS_AH',  'Primary text', 'AH I.2.5: Pistis as Dodecad aeon paired with Paracletos.'),
('ENT_VAL_PISTIS',   'SRC_NHC',          'Primary text', 'Pistis Sophia (Askew Codex, not NHC but related tradition); also NHC for Valentinian framing.'),
('ENT_VAL_AGAPE',    'SRC_IRENAEUS_AH',  'Primary text', 'AH I.2.5: Agape as Dodecad aeon paired with Metricos.'),
('ENT_VAL_THELETOS', 'SRC_IRENAEUS_AH',  'Primary text', 'AH I.1.1-3; I.2.5: Theletos as Sophia''s consort whose absence enables the Fall.')
ON CONFLICT DO NOTHING;

-- ── 4. Entity periods ─────────────────────────────────────────────────────────
INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
('ENT_VAL_DECAD',    'PER_GNO_2ND_4TH','high','Valentinian system attested from Valentinus (c. 100-180 CE) through 4th c. CE.','SRC_IRENAEUS_AH','reviewed'),
('ENT_VAL_DODECAD',  'PER_GNO_2ND_4TH','high','Valentinian Pleroma structure; Irenaeus AH c. 180 CE is primary documentation.','SRC_IRENAEUS_AH','reviewed'),
('ENT_VAL_MONOGENES','PER_GNO_2ND_4TH','high','Valentinian Decad aeon; Irenaeus AH I.2.5.','SRC_IRENAEUS_AH','reviewed'),
('ENT_VAL_PISTIS',   'PER_GNO_2ND_4TH','high','Valentinian Dodecad aeon; AH I.2.5.','SRC_IRENAEUS_AH','reviewed'),
('ENT_VAL_AGAPE',    'PER_GNO_2ND_4TH','high','Valentinian Dodecad aeon; AH I.2.5.','SRC_IRENAEUS_AH','reviewed'),
('ENT_VAL_THELETOS', 'PER_GNO_2ND_4TH','high','Valentinian Dodecad aeon; AH I.1.1-3; I.2.5.','SRC_IRENAEUS_AH','reviewed')
ON CONFLICT DO NOTHING;

-- ── 5. Relationships ──────────────────────────────────────────────────────────
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES

-- ── Critical fix: Yaldabaoth ──────────────────────────────────────────────────
('ENT_VAL_ACHAMOTH', 'parent_of', 'ENT_GNO_YALDABAOTH',
 'high',
 'Achamoth (Lower Sophia) produces Yaldabaoth as her imperfect creation — she creates him without a divine partner, which is why he is material and ignorant rather than spiritual. This is the central act of material creation in Valentinian cosmology: Irenaeus AH I.4.1-2 describes Achamoth forming the Demiurge from the "material" component of her own passions. Yaldabaoth, knowing only his mother Achamoth and not the higher Pleroma, arrogantly declares "I am a jealous God and there is no God but me" (Exodus 20:5 in Valentinian exegesis), demonstrating his ignorance of the divine world above him.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_GNO_YALDABAOTH', 'member_of', 'ENT_GNO_ARCHONS',
 'high',
 'Yaldabaoth is not merely a member of the Archons but their head and creator: he produces the seven planetary Archons from his own substance and breath (Irenaeus AH I.5.2-3; Apocryphon of John NHC II,1). He then sits enthroned above his creation, ignorant of the divine Pleroma above him. As the chief Archon he rules the material world and enforces the imprisonment of the divine spark (pneuma) within human bodies. The seven Archons correspond to the seven planets in Valentinian and Sethian cosmological schemas.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_GNO_YALDABAOTH', 'identified_with', 'ENT_GNO_SAKLAS',
 'high',
 '"Saklas" (Aramaic: "fool") is one of three names given to Yaldabaoth in Sethian texts: Yaldabaoth ("Child of chaos"), Saklas ("Fool"), and Samael ("Blind god"). Apocryphon of John (NHC II,1:11): "He is imperfect compared to the immortal father, for he is not perfect... He said to his fellows, ''I am God and no other god exists except me.'' But by saying this, he showed the angels who were with him that there is another god; for if there were no other one, of whom would he be jealous?" The name Saklas most directly expresses his defining characteristic — ignorance/foolishness — in contrast to the Gnostic divine Nous (Mind). NHC II,1.',
 'SRC_NHC', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_GNO_YALDABAOTH', 'aligned_with', 'ENT_GNO_SAMAEL',
 'high',
 '"Samael" ("Blind god") is the third name given to Yaldabaoth in Apocryphon of John (NHC II,1): his names are Yaldabaoth, Saklas, and Samael. In Sethian cosmology, Samael refers to his blindness to the divine world above him (he sees only the material realm and his own creation); in Jewish tradition Samael is the chief adversarial angel. The identification equates the Gnostic chief Archon with the Jewish demonic adversary, positioning Yaldabaoth as both the material creator and the divine opponent. This identification is one of the sharpest theological provocations in Sethian Gnostic theology — equating the creator God of the Hebrew Bible with the adversary. NHC II,1.',
 'SRC_NHC', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_GNO_YALDABAOTH', 'opposes', 'ENT_GNO_SOPHIA',
 'medium',
 'Yaldabaoth, as the product of Sophia''s/Achamoth''s imperfect creation, is structurally opposed to Sophia throughout the Gnostic cosmological drama: Sophia''s divine spark (pneuma) is trapped within the material creation that Yaldabaoth rules, and the task of the Gnostic savior is to release this pneuma from Yaldabaoth''s material prison. In Sethian texts (Apocryphon of John, NHC II,1; Hypostasis of the Archons, NHC II,4), Yaldabaoth''s rule is the antagonist to Sophia''s redemptive movement. Confidence medium: the relationship is structural/thematic throughout Gnostic cosmology; the specific narrative interactions vary by text.',
 'SRC_NHC', 'PER_GNO_2ND_4TH', 'reviewed'),

-- ── Ogdoad production chain ────────────────────────────────────────────────────
('ENT_VAL_NOUS', 'emanates_from', 'ENT_VAL_BYTHOS',
 'high',
 'Irenaeus AH I.1.1: Bythos, after an immense period of silence with Sige, resolves to emit the beginning of all things. He projects Nous (also called Monogenes, Only-begotten, Father, and Beginning of all things) as his first emission. Nous alone among the aeons is able to comprehend the Father''s immeasurable greatness. Nous is the first and highest visible expression of Bythos''s inner being, paired with Aletheia (Truth). The emanation of Nous from Bythos is the first act of the divine self-disclosure within the Valentinian Pleroma.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_ALETHEIA', 'emanates_from', 'ENT_VAL_SIGE',
 'high',
 'Irenaeus AH I.1.1-2: Sige (Silence), the feminine principle paired with Bythos, is the "womb" of the first divine emission — Nous+Aletheia. Aletheia (Truth) is the feminine counterpart of Nous in the first Ogdoad syzygy. She is the divine Truth that is immediately disclosed when the Father''s Mind is revealed: Nous and Aletheia together constitute the first self-manifestation of the divine pair Bythos+Sige.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

-- ── Decad / Dodecad genealogy ─────────────────────────────────────────────────
('ENT_VAL_LOGOS', 'parent_of', 'ENT_VAL_DECAD',
 'high',
 'Irenaeus AH I.2.5: Logos and Zoe (the second Ogdoad syzygy) produce the ten Decad aeons. The Decad is the second tier of the Valentinian Pleroma, generated by the creative activity of the divine Word (Logos) and Life (Zoe) — the principles of creative utterance and living generativity.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_ZOE', 'parent_of', 'ENT_VAL_DECAD',
 'high',
 'Irenaeus AH I.2.5: Zoe and Logos together produce the ten Decad aeons. The pairing of Logos (Word) and Zoe (Life) as the generative principle of the second Pleroma tier reflects the Johannine theological matrix (John 1:4: "In him was life [zoe], and the life was the light of all people") that underpins Valentinian cosmological speculation.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_ANTHROPOS', 'parent_of', 'ENT_VAL_DODECAD',
 'high',
 'Irenaeus AH I.2.5-6: Anthropos (Primordial Human) and Ecclesia (Assembly/Church) produce the twelve Dodecad aeons. Anthropos as the generative principle of the Dodecad reflects the Valentinian insight that the divine human form is itself cosmogonically productive — the image of the divine Human generates the structures of community (Ecclesia) and the virtues (Pistis, Elpis, Agape, etc.) that constitute the Dodecad.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_ECCLESIA', 'parent_of', 'ENT_VAL_DODECAD',
 'high',
 'Irenaeus AH I.2.5-6: Ecclesia (Assembly/Church) and Anthropos together produce the twelve Dodecad aeons. Ecclesia as the co-generative principle of the Dodecad reflects the Valentinian ecclesiology: the divine Assembly generates the virtues (faith, hope, love, etc.) that bind the pneumatic community.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

-- ── New Dodecad aeon memberships ──────────────────────────────────────────────
('ENT_VAL_MONOGENES', 'member_of', 'ENT_VAL_DECAD',
 'high',
 'Irenaeus AH I.2.5: Monogenes and Macaria are the fifth (final) pair of the Decad. Monogenes is the Decad''s "only-begotten" figure, echoing the title applied to Nous at the Ogdoad level.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_PISTIS', 'member_of', 'ENT_VAL_DODECAD',
 'high',
 'Irenaeus AH I.2.5: Pistis and Paracletos are the first pair of the Dodecad.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_AGAPE', 'member_of', 'ENT_VAL_DODECAD',
 'high',
 'Irenaeus AH I.2.5: Agape and Metricos are the third pair of the Dodecad.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_VAL_THELETOS', 'member_of', 'ENT_VAL_DODECAD',
 'high',
 'Irenaeus AH I.2.5: Theletos and Sophia are the sixth (final) pair of the Dodecad — Sophia is the 30th and last aeon of the entire Pleroma.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_GNO_SOPHIA', 'member_of', 'ENT_VAL_DODECAD',
 'high',
 'Sophia (the 30th and final aeon of the entire Pleroma) is paired with Theletos as the sixth (last) pair of the Dodecad. Her position as the outermost aeon — closest to the Pleroma boundary (Horos) and furthest from Bythos — is a structural precondition for her fall: she is the most distant from the Father and therefore most susceptible to the desire to comprehend him directly. Irenaeus AH I.2.2-3.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed'),

('ENT_GNO_SOPHIA', 'spouse_of', 'ENT_VAL_THELETOS',
 'high',
 'Irenaeus AH I.2.2: Sophia is paired with Theletos as the final syzygy of the Dodecad. The separation of Sophia from Theletos — her desire to comprehend the Father without her proper consort — is the cosmological disaster that generates Achamoth and ultimately the material world. The Sophia-Theletos pairing is the most theologically loaded syzygy in the Valentinian Pleroma, since it is the integrity of this pairing (Wisdom operating within the bounds of divine Will) that separates the ordered Pleroma from the chaotic material creation.',
 'SRC_IRENAEUS_AH', 'PER_GNO_2ND_4TH', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── 6. Verify ─────────────────────────────────────────────────────────────────
SELECT e.entity_id, e.canonical_name,
       COUNT(r.subject_entity_id) + COUNT(r2.object_entity_id) AS total_rels
FROM entities e
LEFT JOIN entity_relationships r  ON r.subject_entity_id = e.entity_id
LEFT JOIN entity_relationships r2 ON r2.object_entity_id = e.entity_id
WHERE e.entity_id IN (
  'ENT_VAL_DECAD','ENT_VAL_DODECAD','ENT_VAL_MONOGENES','ENT_VAL_PISTIS',
  'ENT_VAL_AGAPE','ENT_VAL_THELETOS','ENT_GNO_YALDABAOTH','ENT_VAL_ACHAMOTH',
  'ENT_GNO_SOPHIA','ENT_VAL_THELETOS','ENT_VAL_NOUS','ENT_VAL_ALETHEIA'
)
GROUP BY e.entity_id, e.canonical_name ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;
COMMIT;
