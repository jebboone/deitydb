# Contributing to DeityDB

Thank you for your interest in contributing to DeityDB.

DeityDB is a comparative database of spiritual entities across Western religious traditions. The goal is not to determine religious truth, but to document, compare, and analyze how religious entities appear, develop, and relate across traditions.

## Areas Where Help Is Needed

High-value contribution areas include:

* Primary source extraction
* Entity verification
* Relationship review
* Greek and Egyptian source refinement
* Gnostic and heresiological source expansion
* Islamic tafsir, sira, Sufi, and Shi'a source expansion
* Jewish mystical and Kabbalistic expansion
* Additional traditions and historical periods
* Documentation
* SQL optimization
* Data visualization
* Web and API development

## Data Standards

Every entity should be supported by at least one scholarly source or primary text.

Prefer primary texts whenever possible.

Preserve tradition-specific distinctions rather than collapsing entities into one generalized figure. For example, a Greek Apollo, a Roman Apollo, and a later esoteric Apollo may need to remain separate nodes if they function differently in their respective traditions.

Avoid modern occult inventions unless they are clearly identified as modern reception or modern esoteric material.

Do not add entities purely from unsourced internet lists.

## Entity Guidelines

Entities may include:

* gods
* angels
* demons
* jinn
* saints
* prophets
* imams
* heroes
* aeons
* archons
* daimones
* spirits
* monsters
* cosmological realms
* ritual categories
* personified abstractions

Not all entities are divine. DeityDB intentionally distinguishes between divine beings, holy humans, spirits, symbolic categories, and cosmological structures.

## Relationship Guidelines

Relationships should be as specific as possible.

Prefer:

* `reveals`
* `teaches`
* `transmits`
* `embodies`
* `protects`
* `dwells_in`
* `rules`
* `judges`
* `opposes`
* `member_of`

over generic `associated_with` when the evidence supports a more precise relationship.

Use `associated_with` when the relationship is real but too broad, ambiguous, or tradition-dependent to classify more narrowly.

## Source Guidelines

Strong sources include:

* primary texts
* critical editions
* scholarly translations
* peer-reviewed scholarship
* standard reference works
* reputable academic encyclopedias

Weak sources include:

* unsourced websites
* AI-generated summaries
* occult listicles
* social media posts
* modern devotional claims without historical context

## Suggested Workflow

1. Open an issue describing the proposed addition or correction.
2. Identify the relevant tradition and source.
3. Explain whether the change adds an entity, alias, relationship, source, or documentation.
4. Submit a pull request.
5. Include source notes and rationale.

## Review Priorities

Current high-priority review areas:

* Greek primary-text sourcing
* Egyptian primary-text sourcing
* Irenaeus and early Christian heresiology
* Islamic tafsir and sira expansion
* Sufi cosmology and hidden saint traditions
* Jewish mystical and Kabbalistic expansion
* Relationship refinement away from generic `associated_with`

## Tone and Scope

DeityDB is a historical and comparative research project.

It is not a devotional authority, a theological adjudicator, or a claim that all traditions are saying the same thing.

The project aims to preserve difference while making comparison possible.
