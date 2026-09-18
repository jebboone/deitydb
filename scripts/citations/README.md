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

## Quoting policy

Two rules decide whether a citation carries a quote. They are independent — a source
must satisfy both to be quoted.

**1. The substring gate (absolute).** A stored `quote` must be a contiguous verbatim
substring of the source text, verified programmatically over the *entire* quote, never
a fragment of it. Never hand-write, assemble, splice or paraphrase quote text. If no
clean genuine substring can be found, leave the row as a pointer (`quote IS NULL`).
Trimming a verified span at its *ends* preserves contiguity; excising from the middle
and rejoining does not, and is fabrication.

**2. Source format decides quote vs pointer.** Dictionary and encyclopedia entries —
headword definitions of the form "X was a god of…" — quote cleanly and are the
preferred target. Essay-format references and monographs stay **pointers**, because
lifting a characterizing sentence out of qualified scholarly prose produces a
decontextualized-but-accurate quote that misleads. The canonical example: DDD's "El is
a poorly known deity" describes one limited attestation, not El's standing in the
pantheon. This is a subtler integrity risk than fabrication and is unrelated to
copyright — Brill's *Dictionary of Religion*, DDD, Glassé and the *Catholic
Encyclopedia* stay pointers on these grounds alone.

**Copyright is not a third rule.** Brief attributed excerpts from in-copyright works
are permitted for identification, and are used throughout the database (Robinson's
*Nag Hammadi Library*, Pickthall, Gardner & Lieu, Guillaume, Renard, Davidson,
Dixon-Kennedy, Netton, Grimal). Keep them brief — roughly 250–450 characters — give
full attribution in `work_title`, and set
`review_reason = 'In-copyright modern translation — brief excerpt for identification'`.
An in-copyright *dictionary* is therefore quotable; an in-copyright *monograph* is not,
by rule 2.

**Always eyeball every candidate.** Never bulk-apply either pipeline. Disambiguation,
not extraction, is the binding constraint: measured precision runs ~28% for single
common nouns and ~69% for distinctive multi-word proper nouns. Read the surrounding
context and confirm the referent before accepting a match.

**Apparatus is not source text.** Tables of contents, indexes, forewords, title pages,
running heads, translator footnotes, editorial commentary, bibliographies and incipit
concordances have all been mis-anchored as `primary-verbatim` in the past (cleaned in
v2.1.24 and again in v2.1.87). Bound extraction to the body of the text and reject
candidates carrying dot leaders, page-number runs, scan furniture ("Digitized by"),
or catalogue numbers. Note that naive "looks like a name list" heuristics over-flag
badly — legitimate primary catalogues such as the Völuspá Dvergatal, the Egyptian
Ennead and the Apocryphon of John's archon lists all trip them. Use the regex to
nominate candidates; decide by reading.
