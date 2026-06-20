-- reclassify_associated_with.sql
-- Reclassify the small subset of vague `associated_with` edges where the
-- rationale unambiguously gives both a precise relationship_type AND the correct
-- direction (verified by object entity_class + symmetric-type guards). The other
-- ~90 flagged edges need a per-edge domain call — see docs/associated_with_triage.md.
-- The 14 associated_ritual->ritual edges are correctly typed and left as-is.

BEGIN;
UPDATE entity_relationships SET relationship_type='member_of'  WHERE relationship_id=7385;  -- Kadmilos -> Cabeiri (their member)
UPDATE entity_relationships SET relationship_type='paired_with' WHERE relationship_id=7376;  -- Eumolpus <-> Triptolemus (paired Eleusinian founders)
UPDATE entity_relationships SET relationship_type='taught_by'  WHERE relationship_id=6974;  -- Quddús (disciple) -> the Báb
UPDATE entity_relationships SET relationship_type='taught_by'  WHERE relationship_id=6975;  -- Táhirih (disciple) -> the Báb
COMMIT;

-- Second pass (17 edges; agent-proposed, human-reviewed + direction-checked 2026-06-20):
BEGIN;
UPDATE entity_relationships SET relationship_type='guardian_of' WHERE relationship_id=1221;  -- Chayyot -> Throne
UPDATE entity_relationships SET relationship_type='guardian_of' WHERE relationship_id=1223;  -- Hashmallim -> Throne
UPDATE entity_relationships SET relationship_type='guardian_of' WHERE relationship_id=1222;  -- Ophanim -> Throne
UPDATE entity_relationships SET relationship_type='symbolized_by' WHERE relationship_id=7653;  -- Satan (LaVeyan / symbolic adversary) -> Baphomet (Lévi)
UPDATE entity_relationships SET relationship_type='guardian_of' WHERE relationship_id=1224;  -- Seraphim -> Throne
UPDATE entity_relationships SET relationship_type='dwelling_of' WHERE relationship_id=7861;  -- The Seven Heavens (Vilon, Raqia, Shehaqim, Zebul, Maon, Makhon, Araboth) -> Throne
UPDATE entity_relationships SET relationship_type='presided_over_by' WHERE relationship_id=7860;  -- The Seven Hekhalot (Heavenly Palaces) -> Metatron
UPDATE entity_relationships SET relationship_type='dwelling_of' WHERE relationship_id=6661;  -- The Planetary Temples of Harran (Buyut al-Kawakib) -> The Seven Planetary Deities of Harran (al-Aṣnām al-Sabʿa)
UPDATE entity_relationships SET relationship_type='dwelling_of' WHERE relationship_id=7797;  -- Well of Urd (Urðarbrunnr) -> Norns
UPDATE entity_relationships SET relationship_type='creator_of' WHERE relationship_id=7251;  -- Petra Genetrix -> Mithras
UPDATE entity_relationships SET relationship_type='dwelling_of' WHERE relationship_id=7800;  -- Niflheim (Niflheimr) -> Níðhöggr
UPDATE entity_relationships SET relationship_type='identified_with' WHERE relationship_id=7818;  -- The Isles of the Blest (Fortunate Isles) -> Elysium (Elysian Fields)
UPDATE entity_relationships SET relationship_type='dwelling_of' WHERE relationship_id=7857;  -- The Seven Heavens (Vilon, Raqia, Shehaqim, Zebul, Maon, Makhon, Araboth) -> The Seven Hekhalot (Heavenly Palaces)
UPDATE entity_relationships SET relationship_type='guided_by' WHERE relationship_id=6827;  -- Hands of the Cause of God -> Shoghi Effendi (Shoghi Rabbání)
UPDATE entity_relationships SET relationship_type='aligned_with' WHERE relationship_id=7023;  -- Gregory of Nyssa -> Gregory the Theologian
UPDATE entity_relationships SET relationship_type='aligned_with' WHERE relationship_id=7024;  -- Hilary of Poitiers -> Athanasius of Alexandria
UPDATE entity_relationships SET relationship_type='guarded_by' WHERE relationship_id=7799;  -- Well of Mimir (Mímisbrunnr) -> Mimir
COMMIT;
