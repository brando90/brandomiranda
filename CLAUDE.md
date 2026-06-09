# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repo at a glance

Brando Miranda's personal/professional website (Jekyll, deployed at https://brando90.github.io/brandomiranda/) plus the canonical home of his academic CVs and other professional documents.

- **Website source:** Jekyll + Minima theme via `github-pages` gem (so local renders match what Pages will publish). Entry point `index.md`; posts in `_posts/`; drafts in `_drafts/`; standalone pages at root (`blog.md`, `dance.md`, `peformance-psychology.md`, `prospective-collaborations.md`).
- **Public docs:** `professional_documents/` (`cvs/`, `awards/`, `papers/`, `posters/`) — these *are* shipped to the site.
- **Local-only / excluded from publishing:** `exclude/` (incl. `cs197/` materials), `experiments/` (research scratch including Lean/ATP work), `_drafts/`, `README.md`, `CLAUDE.md`, `AGENTS.md`, `professional_documents/cvs/cvs_prompt.md`. The exclusion list lives in `_config.yml` under `exclude:`. **HARD RULE:** whenever you add a new top-level `.md` (or any `.md` in a published directory) that is repo-internal docs / agent rules / style guides / etc. — i.e. NOT meant to appear at `brando90.github.io/brandomiranda/<name>.html` — you MUST add it to `_config.yml`'s `exclude:` list in the same commit. Minima auto-publishes every `.md` it finds, including in the nav bar.
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

### CV ↔ website dual-update rule (HARD)

The website `index.md` mirrors a subset of CV sections. **Whenever you edit any of the sections listed below in `cv_long.tex` (or `cv_short.tex`), propagate the change to `index.md` in the same commit** — and vice versa. Both CV ↔ CV (long ↔ short) and CV ↔ website (CV ↔ `index.md`) propagation rules apply concurrently.

| CV section | `index.md` section | Mirror? |
|---|---|---|
| Research Summary / Interests | Bio / Shorter Bio | yes (mirror, possibly trimmed) |
| Selected Publications | `# Selected Publications` | yes (only highlight-tier papers) |
| Media Coverage | `# Media Coverage` | yes |
| Awards & Honors | `# Awards` | yes |
| Invited & Contributed Talks | `# Talks` | yes |
| Teaching, Professional Service, Posters, Professional Experience, Education, Mentoring, Coursework | n/a | CV-only — do **not** add to website |

`index.md` does not need a build step (Jekyll/GitHub Pages handles publish on push). The CV side still requires the immediate `latexmk` rebuild from inside `professional_documents/cvs/`.

### Publications categorization (HARD)

The Publications section (and cv_short's *Selected Publications*) must be split into two top-level subsections:
- **Refereed Publications** — peer-reviewed at conferences, journals, or refereed workshops.
- **Preprints and Technical Reports** — arXiv-only, model cards, blog-released artifacts, or not-yet-refereed.

Entries inside each subsection are listed flat (no year sub-headers — year lives in the venue line), most-recent-first, numbered via `\pubitem`. **Each paper appears exactly once.** If a paper moved from preprint → workshop → conference, list it ONCE under the most prestigious venue with a combined venue line (e.g., "International Conference on Machine Learning (ICML). 2025 \& NeurIPS Workshop on Mathematics and AI (MATH-AI). 2024") — never duplicate.

### Publication entry formatting (HARD)

Every publication entry follows this canonical format:

```
\pubitem [\href{URL}]
{Authors,
\emph{Title}.}
\\
(\textbf{Full Conference Name (ACRONYM). YEAR})
```

Rules:
- **Title**: wrapped in `\emph{...}` (italic). Makes the title scannable when readers skim the page. **NO underline** — was tried, found visually noisy.
- **Venue**: full conference name, acronym in parentheses, year as plain sentence (`International Conference on Machine Learning (ICML). 2025`). Whole venue line wrapped in `\textbf{}` so it stands out.
- **No trailing descriptions** on publication entries (e.g., do NOT add `--- Lean 4 autoformalization data-quality study` after the venue). Description belongs in Research Summary, not the publications list. Consistency > color commentary.
- **Multi-venue entries**: bold each venue part separately, joined by `\&` (e.g., `\textbf{ICML 2025} \& \textbf{NeurIPS Workshop ...}` — never half-bold).
- **Award annotations on a paper** (e.g., "NeurIPS Outstanding Paper Award & Oral"): include as a tail of the venue line, escape `\&` properly.

Awards section uses a different format (`\item \textbf{Award Name} (date) --- prestige frame`) — the `---` separator there is for prestige framing, not publication description, and stays.

### Chronological order — descending (HARD)

Every dated list in the CV — Publications, Preprints, Talks, Posters (if present), Awards & Honors, Media Coverage, Professional Experience, Teaching, Service — must be in **strict descending order by end-date** (newest first). Ongoing roles with "present" / "expected" sort to the top of their section. When you edit one entry, **audit the whole containing section**, not just the line you touched — chronology bugs cluster (e.g., July 2024 silently behind December 2023, NeurIPS Red Teaming Dec 2024 silently behind Stanford IEEE 2023).

### Equal-contribution authorship

When an author list contains `*` markers (equal first authors), **Brando goes first**. Keep the `*` on both names. The `(*equal contribution)` annotation goes **outside** any `\textbf{}` / `\emph{}` — it's neither bold nor italic, just a parenthetical note.

### Talks live only in the Talks section

Invited / contributed talks belong in the **Invited & Contributed Talks** section. Do not pile a talk venue ("Stanford IEEE Invited Talk 2023") into the publication venue line of the paper it was about — the talk is recorded separately, and mixing the two breaks the bolded-venue format and double-counts the talk.

### CV bottom-margin & page-break parity (HARD)

The CVs use `\flushbottom` so bottom margins stay flush across all pages. For this to work *without splitting a publication entry across pages* (title on page N, venue on page N+1 — a previously observed regression), the preamble of both `cv_long.tex` and `cv_short.tex` MUST contain exactly:

```
\flushbottom
\widowpenalty=10000
\clubpenalty=10000
\setlength{\parskip}{0pt plus 18pt}
```

and every line break inside a publication entry (between authors, title, and venue) MUST use `\\*` (page-break-forbidden) — never bare `\\`. Same applies to award/talk multi-line entries.

**After every CV `.tex` edit, before reporting the task done:**

1. Rebuild the PDF: `latexmk -pdf -interaction=nonstopmode` from inside `professional_documents/cvs/`. Confirm the `.pdf` mtime advanced.
2. Open the PDF and visually scan every page transition to verify (a) no publication / award / talk entry is split across pages, and (b) bottom margins are visually flush across pages.
3. If a split or short-page is detected, find the offending bare `\\` (most likely culprit) or fixed inter-section `\vspace{Npt}` (less common), convert to `\\*` or `\vspace{Npt plus Mpt}`, re-render, re-verify.

This is a HARD verification step; skipping it is the most common source of the recurring "uneven bottom margin" complaint.

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

### Blog drafts live in `_drafts/` (HARD)

Unpublished blog posts go in **`_drafts/`** — never in `exclude/`, `experiments/`, or anywhere else. `exclude/` is for *non-blog* local-only material (cs197 course files, tweet drafts, scratch notes); a draft blog post placed there breaks the workflow below.

- Filename: `YYYY-MM-DD-slug.md`, same as `_posts/` (date = expected/working publish date; update it at publish time).
- Preview drafts locally: `bundle exec jekyll serve --drafts` (renders drafts as if published, newest-dated first).
- **Publishing = moving the file** from `_drafts/` to `_posts/`: update the filename date and frontmatter `date:` to the actual publish date, normalize the header per "Blog post header format" below (run `python3 scripts/normalize_post_headers.py`), and push to `main`.
- Both `_drafts/` and `exclude/` are in `_config.yml`'s `exclude:` list, so neither is ever published — the split is workflow, not privacy: blog drafts in `_drafts/` so Jekyll can preview them and publishing stays a one-file move.

### Tweet draft workflow

Blog-post tweet drafts live in `exclude/tweets/` and MUST be plain `.txt` files, not `.md`, so emojis and copy-paste-ready X/Twitter formatting stay literal and the files remain obviously local-only.

- `exclude/tweets/tweet_drafts.txt` holds unpublished drafts. Keep the next tweet to post at the top.
- `exclude/tweets/already_posted_tweets.txt` holds published tweets. When Brando posts a draft, move the exact posted text out of `tweet_drafts.txt`, add it to `already_posted_tweets.txt`, and include the X/Twitter status URL.
- Do not create tweet drafts under `_drafts/`, `experiments/`, or blog-post-specific folders unless explicitly asked; `exclude/tweets/` is the canonical home.

### Jekyll URLs

Site `baseurl: /brandomiranda/`. Use either form:

- `[md](/path)` — Jekyll auto-prepends baseurl
- `{{ site.baseurl }}path` — manual, **no slash** after `baseurl`

**Never** write `{{ site.baseurl }}/path` — that produces a broken `//path` on rendered pages. The build excludes `experiments/`, `_drafts/`, `exclude/`, and `README.md` from publishing.

### Blog post header format (HARD)

Every published post in `_posts/` MUST have this canonical header structure immediately after the Jekyll frontmatter, in this exact order — no exceptions:

```markdown
---
layout: post
title: "..."
date: YYYY-MM-DD
---

*Brando Miranda — Month YYYY · ~X min read*

**TL;DR.** [single-paragraph summary, ends with a period]

---

[Body starts here]
```

Specifics:
- **Byline line** is one italic line: `*Brando Miranda — Month YYYY · ~X min read*` — left-aligned plain markdown italic (never right-aligned via `<p style="text-align: right;">`; never split across two lines). Month is full name (`April`, not `Apr`). Read time is `~X min read` (`~` prefix, `min` not `minute`); ranges use en dash (`~3–4 min read`).
- **TL;DR paragraph** starts with literal `**TL;DR.**` (note the period inside the bold). Exactly one paragraph (one blank line on each side). If a post genuinely has no TL;DR yet, label the first body paragraph with `**TL;DR.**` rather than omitting the line.
- **Horizontal rule (`---`)** on its own line separates the TL;DR from the body. This is non-negotiable — without it the TL;DR visually bleeds into the body. The rule comes after a blank line and is followed by a blank line.
- **No redundant H1.** Jekyll renders the frontmatter `title:` as the page H1. Do not repeat the title as a `# Title` heading at the top of the body.
- **No HTML byline blocks** (`<p style="text-align: right;">`, `<em>...</em>` wrappers, etc.) — use plain markdown italic only.

When editing or creating a post, normalize the header to this format. The repo ships an idempotent rewriter at `scripts/normalize_post_headers.py` — run `python3 scripts/normalize_post_headers.py` from the repo root after any post edit and verify the diff is what you intend (running twice on a canonical post produces no change).
