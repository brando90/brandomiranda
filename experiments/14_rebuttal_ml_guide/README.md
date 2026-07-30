# Experiment 14 — Rebuttal & AC-Comment Guide

Turn the rebuttal heuristics from the **NeurIPS 2026 Position Paper Track** cycle into two durable
artifacts: a blog post for the website and a section of the `htdr` position paper.

## Why

The publication lifecycle is well covered by existing material (how to pick a project, how to write
the paper, how to give the talk). The step after submission is not. Author responses are written
under time pressure, once or twice a year, with no feedback loop, which is exactly the situation
where written heuristics beat memory.

The central claim: the rebuttal's audience is the **area chair**, not the reviewer who annoyed you.

## Files

| File | What it is |
|---|---|
| `preprompt.md` | The agent prompt. Role, deliverables, house-style constraints, git/delivery steps, acceptance criteria. |
| `rebuttal_playbook_source.md` | Brando's raw dictated playbook, verbatim (typos preserved) — the traceable source for every claim downstream. |
| `README.md` | This file. |

Source chat: `https://claude.ai/chat/b152028d-b27c-4f83-ac0d-4bb84a1fb2c8`

## Outputs

| Artifact | Location |
|---|---|
| Draft blog post | `_drafts/2026-07-29-write-the-rebuttal-for-the-ac.md` (unpublished — `_drafts/` is in `_config.yml`'s `exclude:`) |
| Paper section | `~/htdr/latex_paper/23_rebuttals_and_ac_comments.tex`, `\input`-ed by `00_main.tex` as §25 |
| Paper appendix checklist | `~/htdr/latex_paper/98_appendix.tex` (`\subsection{Rebuttal Checklist}`) |

## Rerun

```bash
# 1. Re-read the prompt and the source
cat experiments/14_rebuttal_ml_guide/preprompt.md \
    experiments/14_rebuttal_ml_guide/rebuttal_playbook_source.md

# 2. Blog side — verify the draft header is canonical (normalizer covers _posts/ only,
#    so call transform() directly on the draft)
python3 -c "
import sys; sys.path.insert(0,'scripts')
from pathlib import Path
from normalize_post_headers import transform
print(transform(Path('_drafts/2026-07-29-write-the-rebuttal-for-the-ac.md')))
"   # expect (False, 'no change')

# 3. Paper side — rebuild twice and confirm the PDF mtime advanced
cd ~/htdr/latex_paper
pdflatex -interaction=nonstopmode 00_main.tex
pdflatex -interaction=nonstopmode 00_main.tex
```

## Self-check that matters here

The blog post argues that rebuttals must not read as machine-written. A post making that argument in
machine-written prose refutes itself, so the post was audited against its own list: em-dash count per
section, banned frames (`"not X, but Y"`, `"It is worth noting that"`, `"Importantly"`, `"delve"`,
`"leverage"`), uniform sentence length, and consecutive paragraphs with identical openings. The one
grep hit for banned frames is the line that *enumerates* them.

## Publishing

The post stays in `_drafts/` until Brando moves it to `_posts/`. At that point: update the filename
date and the frontmatter `date:`, fix the citation URL in the BibTeX block at the bottom, drop the
draft-warning line if the post is final, then run `python3 scripts/normalize_post_headers.py`.
