# Pre-prompt — Experiment 14: Rebuttal & AC-Comment Guide

**Origin.** Brando's NeurIPS 2026 Position Paper Track rebuttal cycle (advisor + co-author feedback
folded in). Source chat: `https://claude.ai/chat/b152028d-b27c-4f83-ac0d-4bb84a1fb2c8`.
The raw playbook Brando dictated is preserved verbatim in
[`rebuttal_playbook_source.md`](rebuttal_playbook_source.md) — treat it as the spec, not as prose to
be paraphrased away.

---

## Role

You are writing for two audiences at once from a single body of hard-won heuristics:

1. **A PhD student mid-rebuttal at 2 a.m.** — wants an ordering and a decision rule, not a taxonomy.
2. **A reader of the `htdr` position paper** — wants the same material in the register of an
   academic guide, citable, sitting alongside the paper's other craft sections.

The heuristics are Brando's, derived from one real reviewing cycle. Do not inflate them into
universal laws, and do not invent numbers, reviewer quotes, score distributions, or venue policies
that the source does not contain.

---

## Deliverables

### 1. Draft blog post — `/Users/brandomiranda/brandomiranda`

- Path: `_drafts/YYYY-MM-DD-<slug>.md`. **`_drafts/`, not `_posts/`** — the post stays unpublished
  ("private") until Brando moves it. `_drafts/` is in `_config.yml`'s `exclude:` list, so nothing
  reaches the live site.
- Obey the **canonical post header** in `CLAUDE.md`: frontmatter (`layout: post`, `title:`, `date:`,
  `section:`), then the one-line italic byline `*Brando Miranda — Month YYYY · ~X min read*`, then the
  standalone bold draft-warning line, then a single `**TL;DR.**` paragraph, then `---`, then body.
  No redundant H1. `section: meta-research` (the peer-review/how-research-works bucket).
- Run `python3 scripts/normalize_post_headers.py` from the repo root afterwards; the diff must be
  empty or intentional.
- Length: comparable to the existing meta-research posts (roughly 1,200–2,000 words). Ship the
  `## Discuss` and BibTeX-citation footer blocks the recent posts carry, with the `_drafts` date in
  the citation URL flagged as provisional.
- **The post must obey its own advice.** It is a post about not sounding machine-written; if it reads
  as machine-written it refutes itself. That means: vary sentence length, at most ~1 em-dash per
  section, no "not X, but Y", no "It is worth noting", no "Importantly/Furthermore/crucially", no
  rhythm triads, no two consecutive paragraphs opening the same way, contractions in moderation,
  concrete nouns over abstractions. Uneven is good.
- Frame it honestly: heuristics from one cycle, some of which will be wrong for other venues. Say
  which parts are Brando's opinion versus mechanics of how the process works.

### 2. Paper section — `/Users/brandomiranda/htdr`

- `htdr` is a NeurIPS position paper / research guide (Velocity-Vectoring, distilled from CS197).
  Sections are per-file `NN_name.tex`, `\input{}`-ed by `00_main.tex`. The publication lifecycle is
  already covered by §7 (writing effectively) and §8 (great research paper); the rebuttal is the
  missing step after submission.
- Add the material as its own section file following the existing numbering, and `\input` it from
  `00_main.tex` in order. Appendix placement is acceptable if the main body is too full — a short
  appendix checklist alongside the section is a good use of `98_appendix.tex`.
- Match house style exactly: **one sentence per line** in `.tex` (clean diffs), `% NN_file.tex — Title`
  header comment, `\section{...}` + `\label{sec:...}`, `\paragraph{}`/`\textbf{}` lead-ins,
  `` ``quoted'' `` LaTeX quotes, `\&` escaped, `---` for em-dashes.
- Read `~/agents-config/writing/ml_research/ml_research_writing.md` before touching `.tex`.
- Rebuild and verify: `cd ~/htdr/latex_paper && latexmk -pdf -interaction=nonstopmode 00_main.tex`.
  Confirm the PDF mtime advanced and the new section appears with a real number. No new LaTeX errors.
- Do not add fabricated citations to `references.bib`. Cite only what exists, or cite nothing.

### 3. Experiment folder — this directory

- `README.md`: what the experiment is, what was produced, where each artifact landed, how to rerun.
- `rebuttal_playbook_source.md`: the raw playbook, verbatim, as the traceable source.

---

## Git / delivery

Repo `brando90/brandomiranda` is **public**; `brando90/htdr` is **private**. Both use `main` only.

1. **brandomiranda**: branch `blog/rebuttal-playbook`, commit the draft post plus this experiment
   folder, push, open a PR with `gh pr create`. Assign **Brando** and **Sri** (Srivatsava Daruru) as
   reviewers. Sri has no GitHub handle in `~/ultimate-utils/py_src/uutils/collaborators.py` and the
   repo lists only `brando90` as a collaborator — if the API rejects the assignment, name Sri
   explicitly in the PR body as a requested reviewer and report that the GitHub-side assignment
   could not be made. Do not silently drop it.
2. **Then merge to `main` and push anyway** — the PR is for review-after-the-fact, not a gate.
3. After every push to `main`, run `scripts/deploy_stanford_cs.sh` so the Stanford CS mirror stays in
   sync. The working tree carries unrelated in-flight edits (CVs, other experiments), so deploy from
   a clean worktree of the pushed commit:
   `git worktree add --detach /tmp/bm-deploy origin/main && bash /tmp/bm-deploy/scripts/deploy_stanford_cs.sh && git worktree remove --force /tmp/bm-deploy`.
   A draft post changes no published URL, so the expectation is a no-op mirror; verify rather than
   assume.
4. **htdr**: commit the section + rebuilt PDF and push to `main`.
5. Commit only the files this task touches. Leave the pre-existing dirty CV / workspace edits alone.
6. No secrets. No API keys. Review the diff before pushing.

---

## Acceptance criteria

- [ ] Draft post exists under `_drafts/`, header matches `CLAUDE.md` canon, normalizer is a no-op.
- [ ] Post reads as human-written by its own checklist (read it aloud; count em-dashes).
- [ ] `htdr` section added, `\input`-ed, compiles, PDF mtime advanced, section number real.
- [ ] Every claim traceable to the source playbook. Nothing invented.
- [ ] PR open on `brandomiranda` with Brando + Sri named; `main` also updated and pushed.
- [ ] Stanford mirror deploy run and verified after the push.
- [ ] htdr pushed to `main`.

---

## Source material (verbatim)

See [`rebuttal_playbook_source.md`](rebuttal_playbook_source.md).
