# DeityDB — Content-Quality Remediation Triage

**Date:** 2026-06-17 · **Against:** v2.0.0 (3,837 entities / 7,098 relationships / 458 sources / 135 traditions)
**Trigger:** user feedback that entity descriptions are imprecise, read like AI, aren't scholarly, and aren't properly cited. This is a violation of the project's standing *no-AI-generated-copy* rule and of CLAUDE.md's *"reconstruction must be source-grounded."*

This document is the **complete remediation picture** requested before any scrap-or-salvage decision. All numbers are measured from the live Postgres, not estimated.

---

## 1. What is actually wrong (measured)

| Finding | Count | Notes |
|---|---|---|
| Entities total | 3,837 | |
| `short_note` present | 3,780 | 57 empty |
| `short_note` with **any** citation marker (year / p. / § / line) | **367 (9.7%)** | ~90% of public descriptions are uncited |
| `short_note` that is **category-templated boilerplate** (10 templates) | **376** | verbatim-repeated, e.g. "Hero or apotheosed mortal category; cult status must be checked per locality" ×39 |
| Relationships using the discouraged `associated_with`/`associated_ritual` | 106 / 7,098 (1.5%) | CLAUDE.md flags `associated_with` as a "code smell" |

**The public-facing `short_note` field is the core problem**: AI paraphrase, ~90% uncited, with 376 entities sharing 10 generic templates that openly admit they're unverified ("details require row-level review").

## 2. What is *not* wrong (verified, and it matters for cost)

- **Bibliography is genuine.** A cross-phase sample of cited works was web-verified as real publications with correct publisher/year/ISBN (Taracha 2009 Harrassowitz; Lange 2016 Cambridge; Spät 2005 Saqi; Dudley 1997 MAA). The agents cited real scholarship; they did **not** fabricate sources. (Sample = 4; not a proof for all 458, but a strong signal on the axis that worried us most.)
- **Structural invariants hold.** 0 unsourced entities, 0 dangling relationship refs, 0 orphan sources, dup-name discipline clean, every build reproducible from committed scripts.
- **A second, better citation layer already exists but is hidden.** `entity_sources.source_note` (6,414 rows, 99% populated) contains, for many primary-source entities, **real specific text loci** — e.g. "Hesiod, *Theogony* 337-345 (the river-gods, sons of Oceanus and Tethys)", "*Odyssey* 10.513", Apollodorus "*Library* 3.13.8". **The public site shows the bad `short_note`, not these.**
  - The rest of `source_note` is itself boilerplate ("attestation" ×903, "Attested in Theoi Project index" ×473, "Literary attestation…" ×386), so the layer is mixed, not uniformly good.

**Net:** the failure is the **descriptive/citation layer** (AI prose + claims never verified-to-locus), not invented data. That makes this a remediation problem, not a fabrication problem — but a large one.

## 3. Schema gaps that remediation requires

`sources` has only `source_id, title, url, source_type, scope` — **no author, year, page, locus, or quote column.** `claims` is only `domain`/`tag` tuples (464 entities). So today there is **nowhere structured to put a verified excerpt + locus.** Remediation needs a one-time schema addition: a citation/evidence layer (per-entity verified quote, locus, source author+year, evidence grade, verification status). Small, one-time.

## 4. Remediation tiers (mutually exclusive; sum = 3,837)

| Tier | Count | What it needs | Cost driver |
|---|---:|---|---|
| **1 — locus already present** | **1,241** | Verify the existing locus against the (mostly public-domain) text; lift the actual verbatim quote; replace the boilerplate `short_note` with the cited excerpt | Cheapest. Greek/Egyptian/Gnostic classical texts are largely on Perseus/Sacred-Texts/Gutenberg. 207 of these already have a one-click source URL. |
| **2 — real source, no locus** | **2,492** | Obtain the cited scholarly work, find the specific page/locus, write one verified cited fact | **The expensive tail.** Only 8 of 171 secondary-scholarship sources have URLs — most are paywalled/offline. Full compliance here may **not** be achievable by automation alone; many will get a locus + "unverified" flag, or a demotion, rather than a real quote. |
| **3 — reference-only / thin** | **104** | Net-new research, or an editorial decision to merge/demote | Needs judgment, not just lookup. |

## 5. Honest verification risk

The 1,241 Tier-1 loci **look** specific and plausible, but they were AI-generated and have **never been checked**. Verifying that "*Odyssey* 10.513" actually says what the note claims **is the remediation work** — ~1,241 spot-checks minimum, plus quote extraction. Anything not verifiable against a retrievable text must be dropped or flagged, never asserted. No quotes, loci, or page numbers may be written from memory.

## 6. Effort shape (agent-workflow terms)

A compliant verify+quote agent must fetch the real text, confirm the locus, extract a verbatim excerpt, and **refuse** if it can't — so throughput is low and quality-gated.

- **Tier 1 (1,241):** the achievable, high-trust core. Roughly 150–200 gated agent-runs + a human spot-audit of a sample. This is the salvageable spine of the project.
- **Tier 2 (2,492):** partial at best without offline/paywalled source access. Expect a mix of: real quote (where a public text exists), locus-only + unverified flag, or demotion. **This is the tier that determines whether "completeness" is honestly reachable.**
- **Tier 3 (104):** manual editorial pass.
- **One-time:** schema citation layer + switch public pages to show the verified field.

## 7. Quick partial win (does NOT fix the root cause)

~1,241 entities already have better cited material in `source_note` than in the displayed `short_note`. Surfacing that field improves perceived quality for a third of the DB immediately — but it is **cosmetic** until the loci are actually verified, so it should not be mistaken for remediation.

## 8. Recommended sequence (if salvaging)

1. **Pilot (10–15 flagship entities)** — full treatment: schema citation layer + real retrieved excerpts + loci + URLs + evidence grade, published for review. Proves the standard and the per-entity cost before committing at scale.
2. **Tier 1 at scale** — gated verify+quote workflow, human-audited sample.
3. **Tier 2 triage** — decide per entity: real quote vs locus+flag vs demote. Accept that some entities will be honestly marked "attested, not yet verified to locus."
4. **Tier 3 + `associated_with` cleanup** — editorial.

If scrapping instead: the genuinely salvageable assets are the **relationship graph**, the **verified source list**, the **schema**, and the **Tier-1 spine** — these can be exported cleanly regardless.

---

## REMEDIATION PROGRESS (updated 2026-06-18)

**569 of 3,837 entities now carry verbatim primary-source citations** (75 flagged for review). Method: deterministic / name-anchored extraction from line- or section-numbered **public-domain** texts, every quote gated as a verbatim substring of the real file. Reproducible generators in `scripts/citations/`. New schema: `entity_citations` table + `v_public_entity_citations` view + `needs_review`/`review_reason`/`original_text_url`. Entity pages show the citation block; **uncited entities now display a "⚠ Legacy summary — pending citation" notice** so no AI text masquerades as verified.

Completed corpora (all public-domain, verbatim): Hesiod *Theogony* (242), Goetia/Ars Goetia (67), Budge *Papyrus of Ani* (42), Homeric Hymns (30), Pausanias (25), Herodotus (23), Irenaeus *Against Heresies* (23), KJV Bible OT+NT (60), Homer (24), Ovid *Metamorphoses* (16), Virgil (13), pilot (9).

### Why "a primary quote for every entity" is not achievable
Of the 3,268 uncited entities, **most have no quotable primary source** — they are attested only through modern secondary scholarship (the correct citation for them is a *secondary source at a page locus*, not a primary quote). The remaining **primary-quotable** clusters are blocked by specific, surmountable barriers:

| Cluster | n | Barrier | Path |
|---|---:|---|---|
| Kircher, *Oedipus Aegyptiacus* | 73 | 1652 Latin, fringe Egyptology | low priority; flag source quality |
| Avesta (Darmesteter) | 35 | sacred-texts/avesta.org block bots | archive.org OCR (flag) or Wikisource SBE |
| Faulkner BoD / Pyramid Texts | 76 | **modern translation, in copyright** | substitute PD Budge/Mercer or locus-only |
| Apollodorus *Library* | 29 | only free full text is OCR | **Perseus** (section-keyed, clean) |
| 3 Enoch, Quran, Bundahishn | 65 | text access / translation-copyright | Perseus / vetted PD editions |
| Agrippa, Ovid *Fasti*, Homer/Pausanias tails, Livy, Ps.-Dionysius | ~90 | need per-work extractor | continue PD pipeline |

### Two honest tracks remaining
1. **Primary-quotable Tier-1 tail (~370):** continue the PD pipeline + wire in Perseus (retry past HTTP 503) for the section-keyed works. No copyright issues.
2. **Tier-2 (~2,500, secondary-only):** cannot be primary-quoted; correct remediation is to formalize the existing secondary attestations into `entity_citations` rows at page-locus, graded `secondary` and flagged — *not* a verbatim primary quote.
