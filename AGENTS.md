# brandomiranda — Agent instructions

See `CLAUDE.md` in this repo root for the full set of conventions. The most important is:

## CV dual-update rule
The repo holds two canonical CVs in `professional_documents/cvs/`:
- `cv_long.tex` / `cv_long.pdf` (full)
- `cv_short.tex` / `cv_short.pdf` (compact)

**Whenever you edit one, also propagate the change to the other where appropriate** (new awards, talks, media, publications, advisees — yes; long-only detail sections like Coursework or full Poster lists — no). After editing any `.tex`, immediately rebuild the matching PDF with `latexmk -pdf -interaction=nonstopmode` from inside `professional_documents/cvs/`.

## CV ↔ website dual-update rule (HARD)
The website `index.md` mirrors specific CV sections: **Bio / Research Summary, Selected Publications, Media Coverage, Awards, and Talks**. **Whenever you edit any of these in a CV, also update `index.md`** (and vice versa) in the same commit. CV-only sections — Teaching, Professional Service, Posters, Professional Experience, Education, Mentoring, Coursework — do not propagate to the website. No build step is needed on the `index.md` side; the LaTeX rebuild on the CV side still applies.

## Publications categorization (HARD)
The Publications section (and cv_short's *Selected Publications*) must be split into **Refereed Publications** (peer-reviewed: conferences, journals, refereed workshops) and **Preprints and Technical Reports** (arXiv-only, model cards, not-yet-refereed). Entries listed flat (no year sub-headers — year lives in the venue line), most-recent-first, numbered via `\pubitem`. **Each paper appears exactly once** — if a paper moved venues, list it under the most prestigious with a combined venue line, never duplicate.

## Publication entry formatting (HARD)
Every publication entry: `\pubitem [\href{URL}] {Authors, \emph{Title}.}\\(\textbf{Full Conference Name (ACRONYM). YEAR})`.
- Title wrapped in `\emph{...}` (italic, scannable). NO underline — tried, found visually noisy.
- Venue: full conference name + (acronym) + year as plain sentence, whole venue line in `\textbf{}`.
- Multi-venue: bold each part separately (`\textbf{X} \& \textbf{Y}`), never half-bold.
- No trailing `--- description` text on publication entries (consistency > color commentary; descriptions belong in Research Summary). Awards section uses `---` differently (prestige frame) and is exempt.

## Chronological order — descending (HARD)
Every dated list — Publications, Preprints, Talks, Posters (if present), Awards & Honors, Media Coverage, Professional Experience, Teaching, Service — must be in **strict descending order by end-date** (newest first). Ongoing roles with "present" / "expected" sort to the top. When editing one entry, audit the whole containing section.

## Equal-contribution authorship
On equal-contribution papers (`*` markers), **Brando goes first**. Keep `*` on both names. The `(*equal contribution)` annotation sits outside `\textbf{}` / `\emph{}` — neither bold nor italic.

## Talks live only in the Talks section
Invited / contributed talks belong in **Invited & Contributed Talks**. Do not pile a talk venue into a publication's venue line — the talk is recorded separately, and mixing breaks the bolded-venue format.

## CV bottom-margin & page-break parity (HARD)
Both `cv_long.tex` and `cv_short.tex` use `\flushbottom` for flush bottom margins. To avoid splitting a publication entry across pages (title on page N, venue on page N+1):

Preamble of both CVs MUST contain:
```
\flushbottom
\widowpenalty=10000
\clubpenalty=10000
\setlength{\parskip}{0pt plus 18pt}
\setlength{\parskip}{0pt plus 6pt}
```

Every line break inside a publication / award / talk entry — between authors, title, and venue — MUST use `\\*` (page-break-forbidden), never bare `\\`.

**After every CV `.tex` edit:** rebuild the PDF, then visually verify across all pages that (a) no entry is split between pages and (b) bottom margins are flush. If broken, look for a bare `\\` (most likely) or a fixed `\vspace{Npt}` between sections (less likely) and convert to `\\*` or `\vspace{Npt plus Mpt}`. Re-render before reporting done.

For *what* to write and *how* to phrase it, the authoritative style guide is `professional_documents/cvs/cvs_prompt.md`. Reference CVs live in `professional_documents/cvs/example_cvs/` — Finn and Barrett (Stanford CS faculty) are the structural prototypes; Eric Mitchell and Rylan Schaeffer (peer PhD-student/recent-grad files) are for length/density calibration only.

## Blog post header format (HARD)

Every `_posts/*.md` post MUST start (immediately after frontmatter) with this canonical block, in this exact order:

```
*Brando Miranda — Month YYYY · ~X min read*

**TL;DR.** [single paragraph]

---

[body]
```

Rules:
- Byline is one **plain-markdown italic** line, left-aligned. No `<p style="text-align: right;">`. Month is full name (`April`, not `Apr`); read time is `~X min read` (en-dash for ranges, e.g., `~3–4 min read`).
- TL;DR paragraph starts with literal `**TL;DR.**` (period inside the bold). If no TL;DR exists, label the first body paragraph rather than omit.
- Horizontal rule `---` on its own line (blank line above + below) separates TL;DR from body — non-negotiable.
- No redundant `# Title` H1 at the top of body (Jekyll already renders the frontmatter `title`).

See `CLAUDE.md` § "Blog post header format (HARD)" for the canonical version.

Branch model: `main` only.
