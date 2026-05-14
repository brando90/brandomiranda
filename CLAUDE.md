# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo at a glance

Brando Miranda's personal/professional website (Jekyll, deployed at https://brando90.github.io/brandomiranda/) plus the canonical home of his academic CVs and other professional documents.

- **Website source:** Jekyll + Minima theme via `github-pages` gem (so local renders match what Pages will publish). Entry point `index.md`; posts in `_posts/`; drafts in `_drafts/`; standalone pages at root (`blog.md`, `dance.md`, `peformance-psychology.md`, `prospective-collaborations.md`).
- **Public docs:** `professional_documents/` (`cvs/`, `awards/`, `papers/`, `posters/`) — these *are* shipped to the site.
- **Local-only / excluded from publishing:** `exclude/` (incl. `cs197/` materials), `experiments/` (research scratch including Lean/ATP work), `_drafts/`, `README.md`. The exclusion list lives in `_config.yml` under `exclude:`.
- **Site `baseurl`:** `/brandomiranda/`. Local serve binds at `http://127.0.0.1:4000/brandomiranda/`.
- **`AGENTS.md`** at root is a one-page mirror pointer for non-Claude agents (Codex, Cursor). If you change the rules below, also update `AGENTS.md` so the two stay in sync.

## Commands

### Jekyll (website)

```bash
bundle                                  # install gems (first run or Gemfile change)
bundle exec jekyll serve                # local server: http://127.0.0.1:4000/brandomiranda/
```

There is no test suite. Verification = "page renders, links resolve, no 404s." For a quick build-only sanity check, push to a feature branch and let the GitHub Pages action surface errors next to the commit (per `README.md`).

### CVs (LaTeX)

Run `latexmk` **from inside `professional_documents/cvs/`** (the toolchain expects the `.tex` in cwd):

```bash
cd professional_documents/cvs
latexmk -pdf -interaction=nonstopmode cv_long.tex
latexmk -pdf -interaction=nonstopmode cv_short.tex
```

After **any** `.tex` edit, immediately rebuild the matching PDF and verify the `.pdf` mtime advanced before reporting the edit done — Brando previews the PDF live in Cursor and expects it to track the source. LaTeX aux files (`*.aux`, `*.log`, `*.fls`, `*.fdb_latexmk`, etc.) are gitignored in that dir; `.pdf` files are committed.

## Rules

### CV dual-update rule (HARD)

The repo holds two canonical CVs under `professional_documents/cvs/`:
- `cv_long.tex` / `cv_long.pdf` — full academic CV (multi-page)
- `cv_short.tex` / `cv_short.pdf` — compact version

**Whenever you edit one CV, propagate the change to the other where appropriate:**

| Change type | Long | Short |
|---|---|---|
| New award / honor | yes | yes (top of list) |
| New invited or contributed talk | yes (full detail) | yes (compact bullet) |
| New media mention | yes | yes |
| Reframed Research Summary / Interests | yes | yes (mirror, possibly trimmed) |
| New publication | yes | only if strong enough for Selected Publications |
| New advisee | yes | only if role is significant |
| Coursework, full Poster list, internship-presentation list | yes | n/a (short intentionally drops these) |

### CV style standard

For *what* to write and *how* to phrase it, read **`professional_documents/cvs/cvs_prompt.md`** — it distills the patterns from two reference Stanford-CS faculty CVs stored locally:

Reference CVs live in `professional_documents/cvs/example_cvs/`:
- `cfinn_cv.pdf` — Chelsea Finn, Stanford CS faculty (awards-heavy, deep advising tree, talks-heavy) — **structural prototype**
- `clark_b_cv.pdf` — Clark Barrett, Stanford CS faculty (formal-methods/SMT, tool-builder, deep professional service) — **structural prototype**
- `cv_eric_mitchell.pdf` — Eric Mitchell (Stanford PhD → OpenAI) — compact PhD-student CV; useful for length/density calibration, lighter on structural patterns
- `Rylan_Schaeffer_Resume_2023.pdf` — Rylan Schaeffer (Stanford PhD, same advisor as Brando) — labelled as a *Resume* (industry-job-search artifact), not a full academic CV; calibration only

For structural patterns (prestige frames on awards, advisee placements, dedicated Talks section, categorized publications), copy Finn / Barrett. Use the peer files only to calibrate compactness / density.

Highlights from that prompt that are easy to forget: every honor gets a 1-line prestige frame; every paper-tied award names the paper; categorize and number publications; every advisee gets a placement; right-aligned dates; no "Objective" / "Summary of Qualifications" / generic skills lists.

### Branch

The repo uses `main` only — `master` was retired 2026-04-22. Push CV / website changes directly to `main`.

### Jekyll URLs

Site `baseurl: /brandomiranda/`. Use either form:

- `[md](/path)` — Jekyll auto-prepends baseurl
- `{{ site.baseurl }}path` — manual, **no slash** after `baseurl`

**Never** write `{{ site.baseurl }}/path` — that produces a broken `//path` on rendered pages. The build excludes `experiments/`, `_drafts/`, `exclude/`, and `README.md` from publishing.
