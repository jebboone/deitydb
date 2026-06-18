# DeityDB citation remediation pipeline

Replaces AI-paraphrase `short_note` prose with sourced citations in `entity_citations`.
Every verbatim quote is gated as a **substring of the real public-domain text** (no hallucination).

## Run order (after a fresh PG restore)
1. `build_pilot_citations.sql`        — creates `entity_citations` + `v_public_entity_citations`; 9 hand-verified flagships.
2. Track-1 verbatim builds (each: `python3 extract_<x>.py` → `build_<x>_citations.sql`):
   - `extract_theogony.py`        Hesiod Theogony           (Gutenberg #348, `(ll. n-n)`)
   - `extract_homeric_hymns.py`   Homeric Hymns             (Gutenberg #348)
   - `extract_herodotus.py`       Herodotus                 (Gutenberg #2707/#2456, book.chapter)
   - `extract_pausanias.py`       Pausanias                 (Gutenberg #68946/#68680)
   - `extract_anchor_works.py`    Homer / Ovid Met / Virgil (Gutenberg; flagged, original-text linked)
   - `extract_bible.py`           KJV OT+NT                 (Gutenberg #10, chapter:verse)
   - `extract_iren.py`            Irenaeus Against Heresies (ANF; heresiological)
   - `extract_goetia.py`          Ars Goetia                (Gutenberg #72679)
   - `extract_budge.py`           Budge Papyrus of Ani      (Wikisource)
3. `build_track2_secondary_citations.sql` — formalizes every remaining entity's existing source
   as a graded, flagged pointer (primary-uncited / secondary / reference). Run LAST.

The extract_*.py scripts download their public-domain source text via curl/Gutenberg at run time
(see each script header). Generated build_*.sql are committed for auditability.

## Grades (`entity_citations.evidence_grade`)
- `primary-verbatim` / `heresiological-verbatim` — a real quote, substring-gated.
- `primary-uncited` — primary source identified, verbatim quote still pending (Track-1 upgrade target).
- `secondary` / `reference` — attestation rests on scholarship; not primary-quotable.

`needs_review=true` + `review_reason` flags every row that a human should verify (translation/anchor/OCR/section/secondary).
