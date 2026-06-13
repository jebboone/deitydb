-- scripts/add_mycenaean_linear_b_layer.sql
-- Mycenaean / Linear B religion: the Bronze Age Greek substrate
--
-- The Linear B tablets (c. 1400-1200 BCE) from Knossos, Pylos, Mycenae, Thebes,
-- and Tiryns are the earliest written evidence for Greek religion — predating the
-- Homeric epics and the Olympian canon by centuries. They establish which Greek
-- deities already existed in the Mycenaean Bronze Age, which were later additions,
-- and what the religion looked like before the Dark Age (c. 1100-800 BCE) reshaped it.
--
-- Key results of Linear B decipherment for religion:
--
--   1. The "Potnia" problem: the most prominent deity in the tablets is "po-ti-ni-ja"
--   (Potnia = "the Mistress"), a generic title that appears with various qualifiers
--   (Potnia Iqeja, Potnia Aswia, Potnia of the Labyrinth, Athana Potnia) and also
--   without any qualifier, suggesting a great goddess figure who later differentiates
--   into distinct Classical goddesses. She is the most important Mycenaean deity NOT
--   already in the DB.
--
--   2. Dionysus was MYCENAEAN: di-wo-nu-so at Pylos (PY Xa 102) overturned the
--   previous scholarly consensus that Dionysus was a late import into Greece.
--   ENT_DIONYSUS is already in DB; it needs a Mycenaean period assignment.
--
--   3. Apollo is ABSENT: the single most important negative finding. Apollo, one of
--   the most prominent Olympians in Classical religion, has NO secure Linear B
--   attestation. This suggests he either did not exist in Mycenaean religion or
--   entered the Greek pantheon after the Bronze Age collapse — possibly from Anatolia
--   in the early Iron Age.
--
--   4. Poseidon was more prominent than Zeus: at Pylos, Poseidon receives more
--   offerings and is named more frequently than Zeus (di-we), suggesting a different
--   divine hierarchy than the Classical Olympian order.
--
--   5. Enyalius appears SEPARATELY from Ares: Pylos tablet PY Tn 316 lists both
--   A-re (Ares) and E-nu-wa-ri-jo (Enyalius) as separate recipients of offerings,
--   suggesting they were distinct deities in Mycenaean religion. Later, Enyalius
--   collapses into an epithet of Ares.
--
--   6. Diwia (di-u-ja): the feminine form of Zeus attested at Pylos; her name is
--   the transparent feminine of Di-we (Zeus); corresponds to later Dione (Zeus's
--   consort at Dodona; Homer Iliad 5.370-417).
--
-- Olympians with SECURE Linear B attestation (will get period assignments below):
--   Zeus (di-we / di-wo), Poseidon (po-se-da-o), Athena (a-ta-na po-ti-ni-ja),
--   Hermes (e-ma-a), Hera (e-ra), Dionysus (di-wo-nu-so), Ares (a-re at Knossos)
--
-- Olympians with ABSENT or INSECURE Linear B attestation (NOT given this period):
--   Apollo (ABSENT — the most significant negative finding), Aphrodite (absent),
--   Artemis (a-te-mi-to at Pylos is debated; excluded here on caution)
--
-- New entities: ENT_MYC_POTNIA (the unqualified Mistress), ENT_MYC_DIWIA (feminine
--   Zeus / proto-Dione), ENT_MYC_ENYALIOS (independent Mycenaean war deity, later
--   absorbed into Ares as an epithet)
--
-- Sources: SRC_VENTRIS_CHADWICK (primary), SRC_BURKERT_GREEK_RELIGION (secondary)

BEGIN;

-- ── 1. New sources ───────────────────────────────────────────────────────────

INSERT INTO sources (source_id, title, url, source_type, scope)
VALUES
  ('SRC_VENTRIS_CHADWICK',
   'Michael Ventris and John Chadwick, Documents in Mycenaean Greek, 2nd ed. (Cambridge University Press, 1973)',
   NULL,
   'primary text translation',
   'The foundational publication of the Linear B decipherment (Ventris deciphered Linear B in 1952); provides transliterations, translations, and commentary for the major Linear B tablets from Knossos, Pylos, Mycenae, and Tiryns; primary source for all Mycenaean deity attestations (di-we, po-se-da-o, po-ti-ni-ja, e-ma-a, di-wo-nu-so, e-ra, a-re, e-nu-wa-ri-jo, di-u-ja); essential for establishing which Greek deities pre-date the Dark Age and which do not (notably Apollo''s absence); standard reference for all Linear B religious evidence'),

  ('SRC_BURKERT_GREEK_RELIGION',
   'Walter Burkert, Greek Religion: Archaic and Classical, trans. John Raffan (Harvard University Press, 1985; original German: Griechische Religion der archaischen und klassischen Epoche, 1977)',
   NULL,
   'secondary scholarly',
   'The standard comprehensive scholarly account of ancient Greek religion; covers Mycenaean religious continuity and discontinuity (chapter 2), the major deity cults, mystery religions, and the structure of the Greek pantheon; documents the implications of Linear B for understanding which deities are Mycenaean survivals vs. post-Dark-Age additions; essential for contextualizing the Linear B attestations and their relationship to the Classical Olympian pantheon')
ON CONFLICT (source_id) DO NOTHING;

-- ── 2. New Mycenaean entities ─────────────────────────────────────────────────

INSERT INTO entities (entity_id, canonical_name, tradition, entity_type, evidence_confidence, short_note)
VALUES
  ('ENT_MYC_POTNIA',
   'Potnia',
   'Mycenaean',
   'Great goddess / Divine mistress',
   'A',
   '"The Mistress" (Greek po-ti-ni-ja, Linear B); the most prominent and frequently named deity in the Linear B tablets; appears both as a qualified title (Athana Potnia = Lady Athena at Knossos KN V 52; Potnia Iqeja; Potnia Aswia; Potnia of the Labyrinth; Potnia of the Horse) and as an unqualified absolute ("the Mistress" without further specification, most common form); the various Potnia qualifications suggest a single great goddess figure whose cult was differentiated by location and domain in different Mycenaean palatial centers; the unqualified Potnia may be the Mycenaean equivalent of the Minoan palace goddess, and is the probable substrate for multiple Classical goddesses; "Athana Potnia" at Knossos is the earliest certain attestation of Athena; the palatial economy suggests Potnia received the largest or most frequent offerings at several sites; the breakdown of the unified Potnia into distinct Classical goddesses (Athena, possibly Hera, the Eleusinian Demeter) is one of the key transformations of the Dark Age'),

  ('ENT_MYC_DIWIA',
   'Diwia',
   'Mycenaean',
   'Goddess / Feminine form of Zeus',
   'A',
   'Mycenaean goddess attested at Pylos as di-u-ja (Linear B); her name is the transparent feminine form of di-we (Zeus / Di-wos), meaning literally "the female Zeus" or "she who is of Zeus"; she appears in Linear B offering lists alongside other deities and receives cult; her name directly corresponds to the later Classical Greek "Dione" (the same feminine derivation: Dios + -ōnē suffix = Dione), the goddess who is Zeus''s consort at the oracle sanctuary of Dodona (Homer Iliad 5.370-417; Dione there consoles Aphrodite after she is wounded in battle); the Linear B Diwia represents the Mycenaean form of this Zeus-consort tradition before the Dark Age reshaped the divine hierarchy and demoted this figure from an independently worshipped goddess to a secondary consort'),

  ('ENT_MYC_ENYALIOS',
   'Enyalios',
   'Mycenaean',
   'War deity',
   'A',
   'Mycenaean war deity attested as e-nu-wa-ri-jo in Linear B; critically, at Pylos tablet PY Tn 316 — the most important Mycenaean religious text, listing major deity recipients of offerings at a crisis-moment before the palace''s destruction (c. 1180 BCE) — Enyalius and Ares (a-re) appear as SEPARATE recipients receiving their own offerings, establishing that in Mycenaean religion they were distinct deities, not a single deity with a title; in the Classical period Enyalios (Enyalios) survives as an epithet of Ares and as a battle-cry, but some Classical sources still distinguish the two; Pindar (Olympian 13.102) treats Enyalius as an independent deity; his identity in Mycenaean religion as a distinct war god who was later absorbed into or collapsed with Ares is one of the clearest cases of Mycenaean-to-Classical deity merger')
ON CONFLICT (entity_id) DO NOTHING;

-- ── 3. Source links for new entities ─────────────────────────────────────────

INSERT INTO entity_sources (entity_id, source_id, evidence_type, source_note)
VALUES
  ('ENT_MYC_POTNIA',    'SRC_VENTRIS_CHADWICK',    'primary_attestation',
   'Linear B tablets: KN V 52 (Athana Potnia at Knossos); PY An 1281 (Potnia unqualified at Pylos); multiple offering tablets at Knossos, Pylos, and Mycenae; Ventris & Chadwick (1973) ch. 7 on Mycenaean religion and the Potnia problem'),
  ('ENT_MYC_POTNIA',    'SRC_BURKERT_GREEK_RELIGION','secondary_reference',
   'Burkert (1985) pp. 42-46 on Mycenaean religion; the Potnia goddess and her relationship to Classical goddess figures'),
  ('ENT_MYC_DIWIA',     'SRC_VENTRIS_CHADWICK',    'primary_attestation',
   'Linear B di-u-ja attested at Pylos; Ventris & Chadwick (1973): di-u-ja as feminine form of di-we; goddess in the Pylos offering lists'),
  ('ENT_MYC_DIWIA',     'SRC_BURKERT_GREEK_RELIGION','secondary_reference',
   'Burkert (1985) on Dione/Diwia: the Zeus-consort figure at Dodona and her Mycenaean antecedent'),
  ('ENT_MYC_ENYALIOS',  'SRC_VENTRIS_CHADWICK',    'primary_attestation',
   'Linear B e-nu-wa-ri-jo; PY Tn 316: the crucial tablet where Enyalius and A-re (Ares) appear as SEPARATE offering recipients, establishing they were distinct Mycenaean deities; Ventris & Chadwick (1973) p. 289 and notes'),
  ('ENT_MYC_ENYALIOS',  'SRC_BURKERT_GREEK_RELIGION','secondary_reference',
   'Burkert (1985) pp. 169-170 on Ares and Enyalius: the distinction in Mycenaean evidence and the Classical period convergence')
ON CONFLICT DO NOTHING;

-- ── 4. Period assignments for new entities ───────────────────────────────────

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  ('ENT_MYC_POTNIA',   'PER_GRK_MYCENAEAN', 'high',
   'Potnia is the most frequently attested deity in the Linear B tablets (c. 1400-1200 BCE) across Knossos, Pylos, and other Mycenaean centers',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),
  ('ENT_MYC_DIWIA',    'PER_GRK_MYCENAEAN', 'high',
   'di-u-ja attested at Pylos in the Linear B tablets (c. 1200 BCE horizon of the PY tablets)',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),
  ('ENT_MYC_ENYALIOS', 'PER_GRK_MYCENAEAN', 'high',
   'e-nu-wa-ri-jo attested on PY Tn 316 (c. 1180 BCE; the last major Pylos tablet before the palace destruction)',
   'SRC_VENTRIS_CHADWICK', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 5. Mycenaean period assignments for attested Olympians ───────────────────
-- Only deities with SECURE Linear B attestation receive this period.
-- Apollo is explicitly excluded (absent from Linear B — a significant finding).

INSERT INTO entity_periods (entity_id, period_id, confidence, rationale, source_id, review_status)
VALUES
  -- Zeus (di-we / di-wo): certain
  ('ENT_ZEUS',     'PER_GRK_MYCENAEAN', 'high',
   'di-we and di-wo appear in multiple Linear B tablets at Knossos and Pylos; Zeus is securely attested in Mycenaean religion',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),

  -- Poseidon (po-se-da-o): certain; more prominent than Zeus at Pylos
  ('ENT_POSEIDON', 'PER_GRK_MYCENAEAN', 'high',
   'po-se-da-o is one of the most prominently attested deities at Pylos, receiving more offerings than Zeus (di-we) in the Pylos tablets; his high status in Mycenaean Pylos suggests a different divine hierarchy than the Classical Olympian order',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),

  -- Hermes (e-ma-a): certain at Pylos
  ('ENT_HERMES',   'PER_GRK_MYCENAEAN', 'high',
   'e-ma-a (Hermes) attested at Pylos in the Linear B offering lists; establishes Hermes as a Mycenaean deity',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),

  -- Dionysus (di-wo-nu-so): certain; overturns the "late import" theory
  ('ENT_DIONYSUS', 'PER_GRK_MYCENAEAN', 'high',
   'di-wo-nu-so at Pylos (PY Xa 102) is one of the most significant Linear B finds: it demonstrates that Dionysus was a Mycenaean deity, overturning the long-held scholarly view (Nietzsche, Rohde, Wilamowitz) that Dionysus was a late foreign import into Greece',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),

  -- Hera (e-ra): fairly certain at Pylos
  ('ENT_HERA',     'PER_GRK_MYCENAEAN', 'high',
   'e-ra (Hera) attested at Pylos in offering lists; establishes Hera as a Mycenaean deity whose cult predates the Dark Age',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),

  -- Athena (a-ta-na po-ti-ni-ja at Knossos): certain, though as "Athana Potnia"
  ('ENT_ATHENA',   'PER_GRK_MYCENAEAN', 'high',
   '"A-ta-na po-ti-ni-ja" (Athana Potnia, Lady Athena) at Knossos KN V 52 is the earliest attestation of Athena; she appears as a Potnia-title deity, indicating her origin within the broader Mycenaean Potnia tradition',
   'SRC_VENTRIS_CHADWICK', 'reviewed'),

  -- Ares (a-re at Knossos): fairly certain
  ('ENT_ARES',     'PER_GRK_MYCENAEAN', 'high',
   'a-re (Ares) attested at Knossos and appears on PY Tn 316 separately from Enyalius; establishes Ares as a Mycenaean deity distinct from Enyalius in the Bronze Age',
   'SRC_VENTRIS_CHADWICK', 'reviewed')
ON CONFLICT DO NOTHING;

-- ── 6. Reception chains ───────────────────────────────────────────────────────

-- Potnia → Athena: the "Athana Potnia" identification at Knossos is the most
-- direct Mycenaean→Classical chain in the dataset; it is the earliest attestation
-- of Athena and shows she derives from the Potnia tradition.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MYC_POTNIA', 'received_as', 'ENT_ATHENA',
   'high',
   'The Linear B tablet KN V 52 from Knossos reads "a-ta-na po-ti-ni-ja" — Athana Potnia, "Lady Athena" — making this the earliest certain attestation of the Greek goddess Athena, and establishing her origin within the Mycenaean Potnia tradition. The unqualified Potnia ("the Mistress") is the generic form; "Athana Potnia" is the Knossos localization. This means Athena began as a Potnia-type great goddess and later differentiated from the Potnia collective into a distinct deity with her own name and iconographic identity in the post-Dark-Age period. Burkert (1985) treats this as one of the clearest cases of Mycenaean-to-Classical religious continuity.',
   'SRC_VENTRIS_CHADWICK', 'reviewed', 'PER_GRK_MYCENAEAN'),
  ('ENT_ATHENA', 'reception_of', 'ENT_MYC_POTNIA',
   'high',
   'Athena as the Classical Greek differentiation of the Mycenaean Potnia tradition; "Athana Potnia" at Knossos KN V 52 is the earliest attestation; the goddess named and cult-defined independently in the post-Dark-Age period.',
   'SRC_VENTRIS_CHADWICK', 'reviewed', 'PER_GRK_MYCENAEAN')
ON CONFLICT DO NOTHING;

-- Diwia → Dione: the transparent name derivation makes this the most secure
-- Mycenaean→Classical goddess chain after Potnia→Athena.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MYC_DIWIA', 'received_as', 'ENT_DIONE',
   'medium',
   'The Linear B di-u-ja (Diwia) and the Classical Dione share the same derivation: both are the transparent feminine form of the Zeus-name (Proto-Greek *Diw-os → Diwia in Linear B; Dios → Dione in Classical Greek, using the -ōnē suffix). Dione appears in Homer (Iliad 5.370-417) as Zeus''s consort on Olympus, where she comforts Aphrodite after her wounding — a role that suggests she is a survival of an older tradition rather than a narrative creation. Her cult at Dodona (one of the oldest Greek oracular sanctuaries) as Zeus''s consort preserves what the Linear B Diwia represents: a major independent goddess who was progressively subordinated as Zeus''s divine sovereignty was consolidated in the post-Dark-Age period. Confidence medium rather than high because the continuous cult identity between Mycenaean Diwia and Classical Dione cannot be directly documented through texts.',
   'SRC_VENTRIS_CHADWICK', 'reviewed', 'PER_GRK_MYCENAEAN'),
  ('ENT_DIONE', 'reception_of', 'ENT_MYC_DIWIA',
   'medium',
   'Classical Dione as the Iron Age / Archaic survival of the Mycenaean Diwia (feminine Zeus); her role as Zeus''s consort at Dodona preserves the older independent goddess status of the Linear B deity.',
   'SRC_VENTRIS_CHADWICK', 'reviewed', 'PER_GRK_MYCENAEAN')
ON CONFLICT DO NOTHING;

-- Enyalius → Ares: the Mycenaean independent war deity absorbed into Ares
-- as an epithet in the Classical period; PY Tn 316 is the key evidence.
INSERT INTO entity_relationships
  (subject_entity_id, relationship_type, object_entity_id,
   confidence, rationale, source_id, review_status, period_id)
VALUES
  ('ENT_MYC_ENYALIOS', 'received_as', 'ENT_ARES',
   'medium',
   'Pylos tablet PY Tn 316 — the most important Mycenaean religious text, listing offering recipients at a crisis moment before the palace''s destruction c. 1180 BCE — lists both E-nu-wa-ri-jo (Enyalius) and A-re (Ares) as separate recipients, establishing they were distinct war deities in Mycenaean religion. In the Classical period, Enyalius (Enyalios) persists primarily as an epithet of Ares and as a battle-cry formula; however, some Classical sources still treat Enyalius as distinct (Pindar Olympian 13.102; the separate cult title at some sanctuaries). The transition from independent deity to epithet is the Mycenaean-to-Classical merger: Enyalius''s identity and cult were absorbed into the dominant Ares figure in the post-Dark-Age consolidation of the Greek war-deity tradition.',
   'SRC_VENTRIS_CHADWICK', 'reviewed', 'PER_GRK_DARK_AGE'),
  ('ENT_ARES', 'reception_of', 'ENT_MYC_ENYALIOS',
   'medium',
   'Classical Ares as the post-Dark-Age consolidation that absorbed the Mycenaean Enyalius; the distinct war deity of Mycenaean religion survived only as an Ares epithet and battle-cry in the Classical period.',
   'SRC_VENTRIS_CHADWICK', 'reviewed', 'PER_GRK_DARK_AGE')
ON CONFLICT DO NOTHING;

-- ── 7. Verification ──────────────────────────────────────────────────────────

SELECT 'mycenaean_entities' AS metric, COUNT(*) AS count
FROM entities WHERE tradition = 'Mycenaean';

SELECT 'olympians_with_mycenaean_period' AS metric, COUNT(*) AS count
FROM entity_periods
WHERE period_id = 'PER_GRK_MYCENAEAN';

SELECT 'potnia_athena_chain' AS metric,
  CASE WHEN EXISTS (
    SELECT 1 FROM entity_relationships
    WHERE subject_entity_id = 'ENT_MYC_POTNIA'
      AND object_entity_id   = 'ENT_ATHENA'
  ) THEN 'linked' ELSE 'missing' END AS status;

SELECT * FROM v_release_metrics;

COMMIT;
