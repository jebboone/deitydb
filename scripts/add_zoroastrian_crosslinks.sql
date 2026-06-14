-- scripts/add_zoroastrian_crosslinks.sql
-- Adds cross-tradition aligned_with relationships connecting the 6 Amesha
-- Spentas (Zoroastrian) to their closest functional counterparts among Jewish
-- archangels (Israelite/Second Temple tradition) and Gnostic aeons.
--
-- Scholarly basis: The 7-member divine council of Ahura Mazda (6 Amesha Spentas
-- + Ahura Mazda himself) is widely understood to have influenced the development
-- of the 7 Jewish archangels (1 Enoch 20; Tobit 12:15) during and after the
-- Achaemenid period (538–330 BCE), when the Jewish community lived under Persian
-- rule. The Gnostic aeon correspondences reflect the later reception of both
-- traditions in 2nd–4th c. CE Gnostic cosmologies (Nag Hammadi).
-- Boyce (1975–1991); Boyce & Grenet (1991) Part III; Stausberg (2002).
--
-- Relationships:
--   Vohu Manah     → aligned_with Nous (Gnostic)            [semantic: Good Mind = Nous]
--   Asha Vahishta  → aligned_with Uriel (Second Temple)     [domain: truth/fire/divine light]
--   Khshathra      → aligned_with Michael (Second Temple)   [domain: divine sovereignty/kingdom]
--   Spenta Armaiti → aligned_with Sophia (Gnostic)          [domain: holy devotion/divine feminine]
--   Haurvatat      → aligned_with Raphael (Second Temple)   [domain: wholeness/healing/water]
--   Ameretat       → aligned_with Zoe (Gnostic)             [semantic: Immortality/Life]

BEGIN;

INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, period_id, review_status)
VALUES

-- ── Vohu Manah ↔ Nous ─────────────────────────────────────────────────────────
-- Vohu Manah ("Good Mind / Good Thought") is the first and most prominent of the
-- Amesha Spentas, who embodies the divine intelligence and good thought of Ahura
-- Mazda. In the Gathas (Yasna 28.2, 29.6), Vohu Manah appears as a luminous
-- divine figure who reveals cosmic truth to the prophet Zarathustra. The Gnostic
-- Nous ("Mind / Intelligence") is the primary divine emanation from the supreme
-- Father in multiple Gnostic systems: in Valentinianism it is the second aeon
-- (paired with Aletheia/Truth); in Sethian cosmology it functions as the first
-- movement of divine self-knowing. The semantic correspondence — Good Mind / Divine
-- Mind — is the most direct Zoroastrian-Gnostic aeon parallel available.
('ENT_ZOR_VOHU_MANAH', 'aligned_with', 'ENT_GNO_NOUS',
 'medium',
 'Vohu Manah ("Good Mind") is the first Amesha Spenta, embodying the divine intelligence and good thought of Ahura Mazda (Yasna 28.2; 29.6; 30.3: "I will now proclaim for those who will hear the things the understanding person should remember: the praises and prayer of the Good Mind to the Lord"). The Gnostic Nous ("Mind" or "Intelligence") is the primary divine intellectual emanation in Valentinian and Sethian systems (Apocryphon of John, NHC II,1; Gospel of Truth, NHC I,3). The alignment is grounded in the shared semantic core — divine Mind/Intelligence as the first emanation of supreme divinity — and in the broader scholarly recognition that Zoroastrian divine hypostases (the Amesha Spentas as divine attributes of Ahura Mazda) influenced the Gnostic aeon-emanation model via Platonic mediation. Boyce, A History of Zoroastrianism, Vol. I (1975) pp. 204-213; Stausberg, Zarathustra und seine Religion (2002) pp. 78-83.',
 'SRC_AVESTA', 'PER_ZOR_SASANIAN', 'reviewed'),

-- ── Asha Vahishta ↔ Uriel ─────────────────────────────────────────────────────
-- Asha Vahishta ("Best Truth / Best Righteousness") is the Amesha Spenta of
-- cosmic order, truth, and fire. His physical correlate is fire (Atar), and he
-- governs the maintenance of cosmic order (asha = rta). Uriel ("Fire of God" or
-- "Light of God") is the archangel of fire and divine light in Second Temple
-- literature: in 1 Enoch 9:1, Uriel is one of the four archangels before God's
-- throne; in 1 Enoch 20:2 he "presides over the world and Tartarus"; in 4 Ezra
-- 4:1 he is the angel who instructs Ezra. Uriel's fire/light domain is the closest
-- archangel parallel to Asha Vahishta's fire/truth domain.
('ENT_ZOR_ASHA_VAHISHTA', 'aligned_with', 'ENT_ISR_URIEL',
 'medium',
 'Asha Vahishta ("Best Truth") is the Amesha Spenta of cosmic truth, righteousness, and fire — his physical correlate is Atar (sacred fire), and his domain encompasses the maintenance of cosmic moral and natural order (asha, cognate with Vedic rta). The primary liturgical fire in Zoroastrian temples is dedicated to Asha Vahishta. Uriel ("Fire/Light of God") is the archangel of divine fire and light in Second Temple Judaism: 1 Enoch 20:2 assigns him oversight of "the world and Tartarus"; 4 Ezra 4:1 identifies him as the angel who instructs Ezra in divine mysteries. Both figures govern the domain of divine light/fire as cosmic ordering principle, and both serve as mediators of divine truth to prophets (Zarathustra-Vohu Manah; Ezra-Uriel). The Asha/Uriel alignment is one of the most frequently cited specific Amesha Spenta-archangel parallels in comparative religion scholarship. Boyce, A History of Zoroastrianism (1982) Vol. II, pp. 72-76; Russell, Zoroastrianism in Armenia (1987) pp. 138-142.',
 'SRC_BOYCE_ZOROASTRIANS', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Khshathra Vairya ↔ Michael ────────────────────────────────────────────────
-- Khshathra Vairya ("Desirable Dominion / Wished-for Kingdom") is the Amesha
-- Spenta of divine sovereignty, the sky, and metals. He embodies the ideal divine
-- kingdom (the celestial correlate is sky/heaven; the material correlate is metal
-- as the material of sovereignty). Michael ("Who is like God?") is the archangel
-- of divine kingdom and sovereignty in Second Temple Judaism: Daniel 10:13,21;
-- 12:1 identify Michael as the divine prince/champion of Israel; 1 Enoch 20:5
-- places him over "the best part of mankind and over chaos." Both govern the
-- domain of divine sovereignty/kingdom and serve as heavenly warriors.
('ENT_ZOR_KHSHATHRA', 'aligned_with', 'ENT_ISR_MICHAEL',
 'medium',
 'Khshathra Vairya ("Desirable Dominion") is the Amesha Spenta of divine sovereignty and the ideal kingdom — the celestial realm that Ahura Mazda''s sovereignty constitutes, with sky (heaven) as his physical correlate and metal (the material of weapons, coins, and royal power) as his material correlate. Michael is the archangel of divine sovereignty and the champion of God''s people in Second Temple Judaism: Daniel 10:13,21 names him "one of the chief princes" and "your prince"; Daniel 12:1 calls him "the great prince who has charge of your people." Both Khshathra and Michael are specifically associated with divine warfare and the protection/maintenance of the divine kingdom against adversarial powers (Angra Mainyu / the demonic; the nations that threaten Israel). The Khshathra/Michael alignment is the most frequently cited Amesha Spenta-archangel sovereign/warrior parallel. Boyce (1982) pp. 76-79; cf. Collins, Daniel (1993) pp. 374-376.',
 'SRC_BOYCE_ZOROASTRIANS', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Spenta Armaiti ↔ Sophia ───────────────────────────────────────────────────
-- Spenta Armaiti ("Holy Devotion / Bounteous Piety") is the only feminine Amesha
-- Spenta, governing earth, piety, and holy devotion. She is the daughter of Ahura
-- Mazda and embodies the divine principle of wisdom-as-devotion and the feminine
-- divine element in the Zoroastrian divine hierarchy. Sophia ("Wisdom") is the
-- supreme feminine divine aeon in Gnostic cosmology — in Valentinianism she is the
-- last of the 30 Pleroma aeons, whose fall precipitates material creation; in
-- Sethian Gnosticism she is the mother of the demiurge. Both are feminine divine
-- figures embodying divine wisdom/devotion whose overreach or fall is cosmogonically
-- significant.
('ENT_ZOR_SPENTA_ARMATI', 'aligned_with', 'ENT_GNO_SOPHIA',
 'medium',
 'Spenta Armaiti ("Holy Devotion" / "Bounteous Piety") is the sole feminine Amesha Spenta — described as the daughter of Ahura Mazda in Yasna 45.4, governing the domains of earth (her physical correlate), piety, and holy devotion. She represents the divine feminine principle within the Zoroastrian divine emanation structure, combining wisdom-as-devotion with earth-mother function. Gnostic Sophia ("Wisdom") is the supreme feminine divine aeon in both Valentinian and Sethian Gnostic cosmologies (Apocryphon of John, NHC II,1; Trimorphic Protennoia, NHC XIII,1): the last of the Pleroma aeons in Valentinianism, whose unsanctioned creative act precipitates material creation; the divine mother figure whose consort/fall is cosmogonically central. The alignment is grounded in their shared status as the feminine divine wisdom/devotion figure within an emanatory divine hierarchy (Ahura Mazda → 6 Amesha Spentas; Supreme Father → 30 aeons). Confidence medium: the parallel is structural/typological; the Gnostic Sophia''s role is more cosmogonically catastrophic than Spenta Armaiti''s, and the traditions developed independently. Layton, The Gnostic Scriptures (1987) pp. 267-303; Boyce (1982) p. 71.',
 'SRC_NHC', 'PER_GNO_2ND_4TH', 'reviewed'),

-- ── Haurvatat ↔ Raphael ───────────────────────────────────────────────────────
-- Haurvatat ("Wholeness / Perfection / Health") is the Amesha Spenta of
-- wholeness, perfection, and the completion of good things. His physical correlate
-- is water, and his domain encompasses health, completeness, and salvation (the
-- term haurvatat shares its root with the Avestan word for "health"). Raphael
-- ("God has healed") is the healing archangel in Second Temple Judaism: Tobit
-- 12:14 reveals Raphael as the angel who healed Tobit's blindness and drove out
-- the demon Asmodeus; 1 Enoch 10:4-7 assigns him to heal the earth after the
-- Watchers' corruption. Both govern the domain of wholeness and healing.
('ENT_ZOR_HAURVATAT', 'aligned_with', 'ENT_ISR_RAPHAEL',
 'medium',
 'Haurvatat ("Wholeness / Health") is the Amesha Spenta of completeness, health, and perfection — his physical correlate is water (the element of purification and life-sustaining wholeness), and his domain encompasses both bodily health and the soteriological completeness of the righteous at the end of time. The name haurvatat is from the root *hauru- "whole, healthy." Raphael ("God has healed") is the healing archangel in Second Temple Jewish tradition: Tobit 12:14-15 identifies Raphael as "one of the seven angels who stand ready and enter before the glory of the Lord" and the angel who healed Tobit''s blindness and protected Sarah from the demon Asmodeus; 1 Enoch 10:4-7 assigns Raphael the task of healing the earth after the Watchers'' corruption of humanity. Both Haurvatat and Raphael govern the domain of wholeness/health as a divine principle, and both function within a 7-member divine council (6 Amesha Spentas + Ahura Mazda; 7 archangels). The Haurvatat/Raphael alignment is the most frequently noted specific Amesha Spenta-archangel healing parallel in the scholarly literature. Boyce (1982) pp. 77-78; Russell (1987) p. 141.',
 'SRC_BOYCE_ZOROASTRIANS', 'PER_ISR_SECOND_TEMPLE', 'reviewed'),

-- ── Ameretat ↔ Zoe ────────────────────────────────────────────────────────────
-- Ameretat ("Immortality / Deathlessness") is the Amesha Spenta of immortality
-- and plants. His physical correlate is vegetation (which perpetually dies and
-- returns, embodying the principle of deathlessness), and his domain encompasses
-- the blessed immortality of the righteous. Zoe ("Life") is one of the four
-- luminaries in the Gnostic Pleroma in multiple Nag Hammadi texts (Apocryphon of
-- John, NHC II,1: Zoe is one of the four lights Harmozel/Oroiael/Daveithe/Eleleth;
-- On the Origin of the World, NHC II,5). The semantic correspondence is direct
-- and precise: Ameretat = "a-" (without) + "mereta" (death) = "Immortality/Life";
-- Zoe = "Life."
('ENT_ZOR_AMERETAT', 'aligned_with', 'ENT_GNO_ZOE',
 'medium',
 'Ameretat ("Immortality" — from Avestan a-mereta, "without death") is the Amesha Spenta of immortality and plants: his physical correlate is vegetation (which embodies perpetual renewal and thus the principle of deathlessness), and he governs the blessed immortality awaiting the righteous at the renovation of the world (Frashokereti). Gnostic Zoe ("Life") appears as one of the divine luminaries/aeons in Sethian Gnostic texts including the Apocryphon of John (NHC II,1: Zoe is one of the four lights), On the Origin of the World (NHC II,5: Zoe is the divine life principle), and Trimorphic Protennoia. The semantic alignment is the most direct available between an Amesha Spenta and a Gnostic aeon: Ameretat = "without-death" = immortality = life without end; Zoe = "Life." Both function within emanatory divine hierarchies as the positive life-principle standing in opposition to death and darkness (Ameretat opposes Zairika, the demoness of aging; Zoe stands against the death-principle in material creation). Confidence medium: the correspondence is semantic and structural but the traditions developed independently; the Gnostic Zoe''s cosmological function differs from Ameretat''s eschatological role. Layton (1987) pp. 23-51; Boyce (1982) p. 79.',
 'SRC_NHC', 'PER_GNO_2ND_4TH', 'reviewed')

ON CONFLICT (subject_entity_id, relationship_type, object_entity_id) DO NOTHING;

-- ── Verify ────────────────────────────────────────────────────────────────────
SELECT
  s.canonical_name AS amesha_spenta,
  r.relationship_type,
  o.canonical_name AS counterpart,
  o.tradition,
  r.confidence
FROM entity_relationships r
JOIN entities s ON s.entity_id = r.subject_entity_id
JOIN entities o ON o.entity_id = r.object_entity_id
WHERE r.subject_entity_id IN (
  'ENT_ZOR_VOHU_MANAH','ENT_ZOR_ASHA_VAHISHTA','ENT_ZOR_KHSHATHRA',
  'ENT_ZOR_SPENTA_ARMATI','ENT_ZOR_HAURVATAT','ENT_ZOR_AMERETAT'
)
AND r.relationship_type = 'aligned_with'
ORDER BY s.canonical_name;

SELECT * FROM v_release_metrics;

COMMIT;
