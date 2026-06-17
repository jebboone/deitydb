-- build_qa3_fixes.sql — refinements from the v1.67.3 audit of the 42 Assessors (BD Spell 125)
-- and the Roman indigitamenta. No fabrications/removals were found; these are canonical-wording
-- and citation-accuracy corrections only.
BEGIN;

-- ===== 42 Assessors of Maat: restore canonical sin-wording / hedge an uncertain city gloss =====
UPDATE entities SET short_note='Assessor 6 of Maat (BD 125), "Double Lion," from the sky; the deceased denies stealing/purloining the offerings of the gods (Budge: "purloined offerings" — theft, not destruction).'
 WHERE entity_id='ENT_EGY_ASSESSOR_06';
UPDATE entities SET short_note='Assessor 13 of Maat (BD 125), "Eater of entrails," from Bubastis (Bast); the deceased denies "eating the heart" (the Egyptian idiom for rapacity / hot-temperedness), not generic "foul deeds." (Distinct from the goddess Bastet.)'
 WHERE entity_id='ENT_EGY_ASSESSOR_13';
UPDATE entities SET short_note='Assessor 26 of Maat (BD 125), "Hooded one," from the secret place (Heqat); the deceased denies shutting his ears to the words of truth.'
 WHERE entity_id='ENT_EGY_ASSESSOR_26';
UPDATE entities SET short_note='Assessor 22 of Maat (BD 125), "He who sees what he brings," comes forth from Per-Menu ("House of Min"; the equation with Xois is uncertain — Per-Menu is variously placed at Panopolis/Akhmim); the deceased denies self-pollution.'
 WHERE entity_id='ENT_EGY_ASSESSOR_22';

-- ===== Roman indigitamenta: fix the Cardea/Carna citation conflation + a few citations =====
UPDATE entities SET inclusion_basis='Augustine CD 4.8, 6.7 (Varro)',
 short_note='Goddess of the door-hinge (cardo), one of the doorway triad (with Forculus and Limentinus); protects thresholds against night-spirits. The name is attested in Varro via Augustine (CD 4.8, 6.7); Ovid Fasti 6.101ff actually concerns Carna/Cranae, whom Ovid and Macrobius conflate with Cardea. Distinct from Carna.'
 WHERE entity_id='ENT_ROM_CARDEA';
UPDATE entities SET short_note='Goddess guarding the heart and inward (vital) organs; her festival (June 1, Kalendae Fabariae) ate beans and bacon (Macrobius 1.12; Ovid Fasti 6.101-168). Ovid/Macrobius conflate her with Cardea, the door-hinge goddess. Distinct from Cardea.'
 WHERE entity_id='ENT_ROM_CARNA';
UPDATE entities SET inclusion_basis='Festus 154L; Augustine CD 6.9',
 short_note='A phallic marriage and fertility god on whose image brides were seated; an old Roman counterpart of Priapus. Attested at the sacellum Mutini Titini (Festus 154L) and among Varro''s nuptial deities (Augustine CD 6.9); Lactantius Div. Inst. 1.20.'
 WHERE entity_id='ENT_ROM_MUTUNUS';
UPDATE entities SET short_note='An obscure Sabine goddess with a grove at Reate; her nature was already uncertain in antiquity — ancient identifications variously make her a goddess of rest from farm labour (the vacare etymology, Ovid Fasti 6.307) or of victory (Varro). Horace Epist. 1.10.49.'
 WHERE entity_id='ENT_ROM_VACUNA';
UPDATE entities SET inclusion_basis='Ovid Fasti 6.213-218; Livy 8.20; Varro LL 5.66',
 short_note='A Sabine-Roman god of oaths, faith, and treaties, identified with Dius Fidius (Varro LL 5.66), with a temple on the Quirinal.'
 WHERE entity_id='ENT_ROM_SEMO_SANCUS';
UPDATE entities SET inclusion_basis='Servius ad Aen. 9.4; Augustine CD 6.9',
 short_note='An Italic god who, with his brother Picumnus, wards the newborn child from the woodland spirit Silvanus (the three-men-at-the-threshold rite, Augustine CD 6.9 via Varro; Servius ad Aen. 9.4).'
 WHERE entity_id='ENT_ROM_PILUMNUS';
UPDATE entities SET short_note='God who opens the newborn''s mouth for its first wailing cry (vagitus); attested as "Vaticanus" in Augustine CD 4.8 and Gellius 16.17, with "Vagitanus" the variant form.'
 WHERE entity_id='ENT_ROM_VAGITANUS';
UPDATE entities SET inclusion_basis='Augustine CD 4.8; Pliny NH 18.8',
 short_note='Goddess who protects the standing crop above ground (seges); attested in Varro via Augustine (CD 4.8) and as Segesta with a statue in the Circus (Pliny NH 18.8).'
 WHERE entity_id='ENT_ROM_SEGETIA';

COMMIT;
