# 16 — Personal LinkedIn "About" (Shayna-style)

Working folder for a **personal, first-person** LinkedIn About section, to sit alongside — not replace — the third-person academic bio in [`index.md`](../../index.md) (`# Bio #` / `# Shorter Bio #`).

Status as of **September 12, 2026**: five draft directions exist, none chosen; three open questions block the final version.

## Why this folder exists

The academic bio stays as is. What is missing is a warm, first-person piece with the qualities Brando named: **fearlessness, passion, sincerity, authenticity, truth, respect for humanity, and love of AI.**

## Style model

[Shayna Cooperman](https://www.linkedin.com/in/shayna-cooperman-363503117/)'s LinkedIn About (otolaryngology resident, Stanford Medicine). Structure worth stealing:

1. **Sentence 1 names the mission and the thing being shattered** — "committed to fearlessly and passionately shattering the expectation of what it means to be…"
2. **Sentence 2–3 turn the mission outward** — the dream is to help others like her do the same, via a concrete path (training as an otolaryngologist at Stanford).
3. **Paragraph 2 is the multidimensional human** — reading, writing, dancing, volunteering; explicitly keeps a "multidisciplinary framework."
4. **Closes with a warm, direct invitation to make contact.**

Full model text is quoted in the source chat (see below); it is a third party's copy, so it is not reproduced here beyond the structural notes above.

## Files

- [`drafts.md`](drafts.md) — the five draft directions, verbatim: (1) proof, not persuasion; (2) identity-forward, the closest echo of Shayna's structure; (3) renaissance math-and-music; (4) trust as a dance; (5) short love letter.

## Source

Drafted in a claude.ai chat, **"Crafting an authentic personal bio"** — <https://claude.ai/chat/efde6e40-a0de-4222-b802-a9820df6e098> (September 12, 2026, Opus 5 Extra). Account-gated and private to Brando's account, so `drafts.md` in this folder is the copy of record. Brando's reaction: *"the suggestions sound good there."*

Prior search (2026-09-12, Claude Code) confirmed no earlier draft existed anywhere: nothing in this repo's working tree or full git history (all branches + `stash@{0}`), nothing on disk, nothing in Drive, nothing in Claude/Codex session transcripts.

## Open questions (these block the final draft)

1. **Pick a direction** — or merge; the source chat recommends **2 + 5**.
2. **The one sentence only Brando can write** — origin story, the moment this path was chosen, a mentor who mattered. Every draft is deliberately missing it; do not invent it.
3. **How forward should the Mexican identity be** — centered (draft 2), mentioned (drafts 4, 5), or left out (drafts 1, 3)? This is the biggest tonal lever.
4. **Length** — LinkedIn folds the About at ~300 characters, so the strongest line must be front-loaded.

## Fact-check against the CV and site

Checked against [`cv_long.tex`](../../professional_documents/cvs/cv_long.tex) and the site pages:

| Claim in drafts | Status |
|---|---|
| MIT minor in music (draft 3) | ✅ `cv_long.tex:152` — "Minors: Mathematics, Music" |
| Bachata / Brazilian zouk (drafts 1–5) | ✅ understated — **founder & president** of Stanford SBSBZ (200+ members, 83-video playlist, 25K+ views) and of the first bachata/zouk group at UIUC |
| Alto saxophone (drafts 3, 5) | ✅ consistent with the jazz posts (`_posts/2019-10-31-jazz-improvisation.md`, the Maiden Voyage post written in alto Eb) |
| "Founded and lead student research communities" (draft 2) | ✅ Stanford AI for Lean, co-founder & president |
| Electric cello (draft 3) | ⚠️ **unverified** — appears nowhere in the CV, `dance.md`, or any post. Confirm or cut. |
| "Watched impressive numbers evaporate under scrutiny" (draft 1) | ✅ fair — the emergent-abilities-as-mirage line of work (NeurIPS Outstanding Paper) is exactly this |

## Where the final version goes

LinkedIn About field on <https://www.linkedin.com/in/brando-miranda-40821046/>. Optionally mirrored into `index.md` as a short personal paragraph above `# Bio #` — that call is deferred until a draft is chosen.

Note: the current `professional_documents/cvs/Linkedin_Profile_may_13_2026.pdf` export shows the live LinkedIn Summary is still the old third-person, data-centric-ML framing with no Lean / VeriBench / Stanford AI for Lean — it is stale independently of this work.

This folder is local-only — `experiments/` is in `_config.yml`'s `exclude:` list and is never published.
