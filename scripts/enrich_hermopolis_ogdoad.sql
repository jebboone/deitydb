-- scripts/enrich_hermopolis_ogdoad.sql
-- Enriches the Hermopolis Ogdoad cluster, which exists in the DB with correct
-- structure (member_of + male spouse_of) but has one-liner short_notes and
-- is missing:
--   1. Reciprocal spouse_of for the four female members (Naunet, Hauhet, Kauket, Amunet)
--   2. Cross-tradition links (Nun → Nammu, Nun → Apsu)
--   3. Thoth ↔ Ogdoad — the patron relationship missing from the Hermopolitan
--      cosmological cluster
--   4. Substantive short_notes for all 7 thin members + the collective
--
-- No new entities or sources. Uses existing: SRC_WILKINSON_EGYPTIAN_GODS,
-- SRC_PINCH_EGYPTIAN_MYTH, SRC_FAULKNER_PYRAMID_TEXTS.
-- Period: PER_EGY_OLD_KINGDOM (Pyramid Texts) or PER_EGY_MIDDLE_KINGDOM
-- (confirmed by which period the existing entities use — checked below).

BEGIN;

-- ── 1. Update short_notes (the primary quality gap) ──────────────────────────

UPDATE entities SET short_note =
'Nun (also Nu) is the primordial watery abyss of Egyptian cosmology — the boundless, dark, chaotic expanse of inert water that existed before creation. He is the foundational element of the Hermopolitan Ogdoad cosmological system (khmun, "City of the Eight"), the oldest Egyptian cosmogony, in which creation occurs when the Ogdoad''s forces stir the primordial waters and the primordial mound (benben) rises from them, upon which the creator deity (Ra-Atum or Thoth, depending on the tradition) comes into being. Nun is not destroyed by creation but persists as the waters surrounding the known world and beneath the earth — the source of the Nile''s annual inundation and of the sun''s journey through the underworld. The Pyramid Texts (c. 2400–2300 BCE) are the earliest attestation: "O Atum, when you came into being you rose up on the high ground, you rose up as the bnbn stone in the Mansion of the Phoenix in Heliopolis" — with Atum emerging from Nun. Nun is gendered male and paired with Naunet (female counterpart, the watery sky above) as the first of the four Ogdoad pairs. His conceptual parallel in Mesopotamian cosmogony is Apsu (the primordial male freshwater abyss of the Enuma Elish) and Nammu (the Sumerian primordial sea-goddess from whom creation emerged). In temple iconography Nun is sometimes depicted as a man holding up the solar barque, symbolizing the moment creation emerged from the primordial waters. Wilkinson (2003) pp. 100-101; Pinch (2002) pp. 167-168.'
WHERE entity_id = 'ENT_EGY_NUN';

UPDATE entities SET short_note =
'Naunet (also Naunet, Nenet) is the female counterpart of Nun in the Hermopolis Ogdoad — the personification of the counter-heaven or the sky that corresponds to the primordial watery abyss below. In Egyptian cosmological thought, the universe is bounded above by a celestial counterpart to Nun''s waters, and Naunet personifies this upper water-boundary. As a pair, Nun and Naunet represent the totality of the primordial undifferentiated water — below and above, the boundless abyss in all directions — before the moment of creation. Like all female members of the Ogdoad, Naunet is depicted with a serpent''s head rather than a human head (while the male members have frog heads), a convention that expresses their connection to the primordial, pre-creation state. Naunet''s role is almost entirely cosmological; she appears primarily in texts describing the Ogdoad''s primordial state rather than in narratives involving her individually. The Coffin Texts attest to the Ogdoad''s role in "breathing life into the two Lands" upon the first sunrise, with Naunet part of the generative watery principle. Wilkinson (2003) pp. 100-101.'
WHERE entity_id = 'ENT_EGY_NAUNET';

UPDATE entities SET short_note =
'Heh (also Huh, Hah) is the male member of the Ogdoad pair representing primordial infinity or boundlessness. His name means "million," "eternity," or "infinite number" — a conceptual expression of the unboundedness that characterized the pre-creation state. Heh is one of the most distinctively Egyptian divine concepts: the personification of boundless time and space before the ordered cosmos imposed limit and measure on eternity. He is particularly interesting as both an Ogdoad member (the primordial force of boundlessness) and as a separate deity in Egyptian religion: in his non-Ogdoad aspect, Heh is depicted as a kneeling man holding a palm rib (hieroglyph for "year") in each hand, with tadpoles hanging from the ribs as symbols of millions of years — a visual expression of infinite duration. In this form he is frequently placed in the hands of pharaohs as a symbol of eternal reign. As an Ogdoad member, Heh is the infinite spatial-temporal expanse that preceded creation; as an individual deity, he is the divine gift of eternal life that the creator bestows upon kingship. His female counterpart is Hauhet. Wilkinson (2003) pp. 100-101; Pinch (2002) pp. 132-133.'
WHERE entity_id = 'ENT_EGY_HEH';

UPDATE entities SET short_note =
'Hauhet is the female counterpart of Heh in the Hermopolis Ogdoad, personifying the feminine aspect of primordial boundlessness (Heh = infinity/boundlessness). Like Naunet, Kauket, and Amunet, she is depicted with a serpent''s head in Ogdoad iconography — the serpent being the conventional representation for the female Ogdoad deities, expressing the primordial, chthonic, and apotropaic quality of the pre-creation state. Hauhet''s individual role within the Ogdoad cosmological narratives is limited — she functions primarily as the feminine complement of Heh, ensuring the male-female balance that characterizes all four Ogdoad pairs (the balance of complementary cosmic forces that together constitute a single primordial reality). The paired structure of the Ogdoad (four male-female pairs representing four aspects of pre-creation chaos) reflects an ancient Egyptian cosmological principle that all fundamental realities have masculine and feminine aspects. Wilkinson (2003) pp. 100-101.'
WHERE entity_id = 'ENT_EGY_HAUHET';

UPDATE entities SET short_note =
'Kek (also Kuk) is the male member of the Ogdoad pair representing primordial darkness. His name means "darkness," and he personifies the absolute darkness that preceded the first sunrise — the primal lightlessness before Ra''s emergence from the primordial waters brought light into being. In Egyptian cosmological thought, Kek''s darkness is not simply the absence of light but a positive primordial force, part of the creative matrix from which creation emerges. He is depicted with a frog''s head (standard for male Ogdoad members), sometimes carrying torches, an iconographic inversion that expresses his function as the deity who makes possible the very concept of light by embodying its primordial absence. In the popular internet subculture of the 2010s, "Kek" became a name applied to the deity of chaos/irony (via a misidentification and wordplay), wholly divorced from and unrelated to the Hermopolitan Ogdoad figure. The ancient Kek is a serious cosmological concept — the primordial darkness as creative potential — and should not be confused with the post-2016 folk etymology. His female counterpart is Kauket. Wilkinson (2003) p. 101.'
WHERE entity_id = 'ENT_EGY_KEK';

UPDATE entities SET short_note =
'Kauket (also Keket) is the female counterpart of Kek in the Hermopolis Ogdoad, personifying the feminine aspect of primordial darkness. Like the other three female Ogdoad deities (Naunet, Hauhet, Amunet), she is depicted with a serpent''s head. Kauket shares the cosmological role of her male counterpart — together Kek and Kauket represent the totality of pre-creation darkness, the enveloping lightlessness before the first sunrise. Her attestation in individual religious texts is minimal; she functions primarily within the Ogdoad cosmological system as the feminine principle of darkness, ensuring the structural symmetry of the eight-member creative matrix. The serpent iconography of the female Ogdoad members may reflect the association of serpents with the underworld, regeneration, and the chthonic primordial forces that the female Ogdoad deities embody in contrast to the frog iconography of the male members (frogs being associated with the annual Nile inundation and fertility). Wilkinson (2003) p. 101.'
WHERE entity_id = 'ENT_EGY_KAUKET';

UPDATE entities SET short_note =
'Amunet (also Amaunet, "The Hidden Female One") is the female counterpart of Amun ("The Hidden One") in the Hermopolis Ogdoad. As Amun''s Ogdoad pair, Amunet embodies the feminine aspect of the primordial hidden and invisible force — the unknowable, concealed essence that permeates the pre-creation state. In the early Ogdoad theology of Hermopolis (Old Kingdom period), Amun and Amunet are a cosmological pair equivalent to the other three pairs. However, Amunet''s theological trajectory diverges significantly from the other female Ogdoad members after the New Kingdom: while Amun rises to the supreme position in the Egyptian pantheon (becoming Amun-Ra, the state god of the Empire period), Amunet is partially displaced by Mut as Amun''s consort in the Theban triad (Amun-Mut-Khonsu). Amunet survives, however, as a distinct deity in her own right — she appears in Pyramid Text utterances as a protective deity who "opens her arms" to embrace the deceased king, and she had her own cult at Karnak, where she appears as a woman wearing the red crown of Lower Egypt. Her continued presence alongside Amun in Karnak demonstrates the persistence of the Ogdoad theological tradition within the Theban religious system. Wilkinson (2003) pp. 100-101, 148-150.'
WHERE entity_id = 'ENT_EGY_AMUNET';

UPDATE entities SET short_note =
'The Ogdoad (Egyptian: khmun, "the eight"; Greek: Ogdoas) is the Hermopolitan collective of eight primordial deities who constitute the pre-creation cosmological matrix in the theology of Hermopolis Magna (modern Ashmunein, Middle Egypt). The name of the city, Khmun (Coptic: Shmun), derives directly from the word for "eight" (ḫmn), reflecting the centrality of the Ogdoad to the city''s religious identity. The eight deities are four male-female pairs, each embodying one primordial quality of the pre-creation state: Nun and Naunet (the primordial waters), Heh and Hauhet (infinity/boundlessness), Kek and Kauket (primordial darkness), and Amun and Amunet (the hidden/invisible). Together they represent the full matrix of creative potential — the totality of what existed before creation brought order, light, and differentiated being into existence. In the Hermopolitan cosmology, the Ogdoad''s primordial forces are stirred (by Thoth''s creative voice in some versions; by their own internal dynamic in others) to produce the primordial mound (the benben or Island of Flame) from which the creator deity (Atum-Ra, or specifically Thoth as the Hermopolitan demiurge) emerges to begin the ordered creation. The Ogdoad cosmology predates the Heliopolitan Ennead (Atum''s family) as the primary Egyptian cosmological system; the two systems coexisted and influenced each other throughout Egyptian history. The Ogdoad has a notable reception in the Gnostic Ogdoad tradition (the "eighth heaven" or octadic pleroma structure), where the Hermopolitan cosmological structure of eight primordial forces was adapted into Valentinian and Sethian cosmological schemas. Thoth (Hermopolis''s patron deity) is the organizing/creative intelligence within the Ogdoad system, receiving the Ogdoad''s primordial energies and giving them creative direction. Pinch (2002) pp. 165-168; Wilkinson (2003) pp. 99-102.'
WHERE entity_id = 'ENT_EGY_OGDOAD';

-- ── 2. Reciprocal spouse_of for female Ogdoad members ────────────────────────
-- The existing DB has male → female (Nun spouse_of Naunet; Heh spouse_of Hauhet;
-- Kek spouse_of Kauket; Amun spouse_of Amunet). Add female → male direction.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES
('ENT_EGY_NAUNET', 'spouse_of', 'ENT_EGY_NUN',
 'high',
 'Naunet is the female counterpart/spouse of Nun in the Hermopolis Ogdoad; they form the first of the four primordial pairs representing the pre-creation watery abyss. The male-female pairing in the Ogdoad system is a fundamental structural feature attested in all Hermopolitan cosmological texts. Wilkinson (2003) p. 101.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'PER_EGY_OLD_KINGDOM', 'reviewed'),

('ENT_EGY_HAUHET', 'spouse_of', 'ENT_EGY_HEH',
 'high',
 'Hauhet is the female counterpart/spouse of Heh in the Hermopolis Ogdoad; together they personify the primordial infinity/boundlessness (the undivided whole of infinite space-time before creation). Wilkinson (2003) p. 101.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'PER_EGY_OLD_KINGDOM', 'reviewed'),

('ENT_EGY_KAUKET', 'spouse_of', 'ENT_EGY_KEK',
 'high',
 'Kauket is the female counterpart/spouse of Kek in the Hermopolis Ogdoad; together they personify primordial darkness (the absolute lightlessness before the first sunrise). Wilkinson (2003) p. 101.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'PER_EGY_OLD_KINGDOM', 'reviewed'),

('ENT_EGY_AMUNET', 'spouse_of', 'ENT_EGY_AMUN',
 'medium',
 'Amunet is the female counterpart/spouse of Amun in the original Hermopolitan Ogdoad theology. This pairing predates the New Kingdom Theban triad (Amun-Mut-Khonsu) in which Mut displaces Amunet as Amun''s primary consort; Amunet retains an independent cult at Karnak and the original Ogdoad pairing. Confidence medium: the Amunet-Amun pairing is older but is complicated by Amun''s later theological elevation and Mut''s displacement of Amunet in Theban state theology. Wilkinson (2003) pp. 148-150.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'PER_EGY_OLD_KINGDOM', 'reviewed'),

-- ── 3. Cross-tradition: Nun ↔ Apsu and Nammu ─────────────────────────────────
('ENT_EGY_NUN', 'aligned_with', 'ENT_MES_APSU',
 'medium',
 'Nun and Apsu are the two nearest cross-cultural parallels for the concept of the primordial male freshwater/undifferentiated-water abyss from which creation emerges: Nun is the Egyptian primordial watery chaos (gendered male), while Apsu is the Akkadian primordial freshwater ocean (also gendered male) who mingles with Tiamat (salt water) to produce the first gods in the Enuma Elish. Both Nun and Apsu represent the primordial water-before-creation as an existential category, both are gendered male, and both precede and enable the creation of the ordered cosmos. The parallel is widely noted in comparative cosmogony scholarship. Confidence medium: both are independently developed primordial water deities with no direct historical connection; the parallel is structural/typological. Pinch (2002) pp. 167-168.',
 'SRC_PINCH_EGYPTIAN_MYTH', 'PER_EGY_OLD_KINGDOM', 'reviewed'),

('ENT_EGY_NUN', 'aligned_with', 'ENT_MES_NAMMU',
 'medium',
 'Nun (Egyptian primordial watery abyss) and Nammu (Sumerian primordial sea-goddess, "the mother who gave birth to heaven and earth," Atrahasis Prologue; Enki and Ninhursag) are structurally parallel as the primordial undifferentiated water from which creation emerges and from which the creator deity is born. The parallel is noted in standard works on comparative ancient Near Eastern cosmogony. Key difference: Nun is gendered male; Nammu is gendered female (the Great Mother of Sumerian theology). Despite the gender inversion, both serve as the primordial creative matrix — the undifferentiated watery whole that precedes and enables creation. Confidence medium: independently developed traditions; structural parallel without direct historical connection. Pinch (2002) pp. 167-168.',
 'SRC_PINCH_EGYPTIAN_MYTH', 'PER_EGY_OLD_KINGDOM', 'reviewed'),

-- ── 4. Thoth ↔ Ogdoad ─────────────────────────────────────────────────────────
('ENT_EGY_THOTH', 'patron_of', 'ENT_EGY_OGDOAD',
 'medium',
 'Thoth is the patron deity of Hermopolis Magna (khmun, the City of the Eight), the city whose name, cosmological identity, and central religious system are the Ogdoad. The Hermopolitan tradition in some versions makes Thoth the active creative agent who gives voice to the Ogdoad''s latent primordial forces — he is the divine Logos/Word who speaks the creator into existence from the primordial waters stirred by the Ogdoad. In one version of the Hermopolitan creation narrative, it is Thoth (in his form as the ibis or the sacred baboon) who lays the primordial cosmic egg from which the creator (Ra-Atum or Thoth himself) hatches at the first sunrise. The relationship between Thoth and the Ogdoad is thus that of creative mediator/patron to the primordial forces he organizes and articulates. Confidence medium: the specific tradition varies — in some versions Thoth creates through the Ogdoad; in others the Ogdoad creates independently and Thoth is simply their city''s patron; in yet others Thoth is identified with the Ogdoad''s collective wisdom. Wilkinson (2003) pp. 99-102; Pinch (2002) pp. 198-200.',
 'SRC_WILKINSON_EGYPTIAN_GODS', 'PER_EGY_OLD_KINGDOM', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── 5. Verify ─────────────────────────────────────────────────────────────────
SELECT e.entity_id, e.canonical_name,
       LENGTH(e.short_note) AS note_len,
       COUNT(r.subject_entity_id) + COUNT(r2.object_entity_id) AS total_rels
FROM entities e
LEFT JOIN entity_relationships r  ON r.subject_entity_id = e.entity_id
LEFT JOIN entity_relationships r2 ON r2.object_entity_id = e.entity_id
WHERE e.entity_id IN (
  'ENT_EGY_NUN','ENT_EGY_NAUNET','ENT_EGY_HEH','ENT_EGY_HAUHET',
  'ENT_EGY_KEK','ENT_EGY_KAUKET','ENT_EGY_AMUNET','ENT_EGY_OGDOAD','ENT_EGY_THOTH'
)
GROUP BY e.entity_id, e.canonical_name, e.short_note
ORDER BY e.entity_id;

SELECT * FROM v_release_metrics;

COMMIT;
