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
- No draft-warning banner. Published posts never carry `**Warning: this post is a draft ...**` or any variant (retired 2026-09-06); an unfinished post belongs in `_drafts/`, not live behind a disclaimer. The normalizer strips the line wherever it appears.
- TL;DR paragraph starts with literal `**TL;DR.**` (period inside the bold). If no TL;DR exists, label the first body paragraph rather than omit.
- Horizontal rule `---` on its own line (blank line above + below) separates TL;DR from body — non-negotiable.
- No redundant `# Title` H1 at the top of body (Jekyll already renders the frontmatter `title`).

See `CLAUDE.md` § "Blog post header format (HARD)" for the canonical version.

## No appendix by default (HARD)

No appendix on a post unless there's a strong specific reason. Brando, 2026-09-06: "it looks too long and Im trying to not be repetitive."

An appendix makes a tight post look sprawling, and in practice it restates the body. If material is good enough to keep, put it in the body; if not, cut it to a private doc, not to a heading at the bottom of the post. Reference tables the writer uses but readers don't (practice maps, per-block breakdowns, option inventories) are the clearest cut.

A post ends with: body, `bibtex` block, `## Acknowledgments`. See `CLAUDE.md` § "No appendix by default (HARD)".

## No sources / materials / process apparatus on blog posts (HARD)

Blog posts carry no bibliography, no materials list, no provenance note, no pointer to how the post was made. Brando, 2026-09-06: "I def don't need that type of thing ANYWHERE ever."

Never add: a sources/materials bullet list (name things in the prose instead); links to internal working folders (`experiments/`, changelogs, PR descriptions, tweet drafts, read-aloud renderings, prompt files); provenance or AI-disclosure notes ("distilled from a conversation with Claude"); defensive hedging ("crops only, not full pages", "no melody transcribed", "fair use"); or redundant links to assets already embedded in the post.

Linking to an actual creative artifact the reader would want (score PDF, audio, dataset, the code the post is about) is content, not apparatus, and stays.

A post may end with: body, the `bibtex` citation block, and `## Acknowledgments`. Nothing else. See `CLAUDE.md` § "No sources / materials / process apparatus on blog posts (HARD)".

## Blog voice: own the confusion, don't blame the source (HARD)

When a post works through something confusing, the confusion is Brando's, not the source's fault. Never frame a heading or caption as an accusation against a named author.

- Bad: `## Snidero's one confusing sentence`; good: `## The sentence that stopped me`.
- Applies to captions and body prose too — describe your own reading process, not the source's quality.
- Substantive, argued disagreement with a source is still fine; what's banned is framing ordinary personal confusion as the source's defect.

See `CLAUDE.md` § "Blog voice: own the confusion, don't blame the source (HARD)".

## Blog drafts live in `_drafts/` (HARD)

Unpublished blog posts go in `_drafts/` (filename `YYYY-MM-DD-slug.md`) — never in `exclude/` or `experiments/`. `exclude/` is for non-blog local-only material (cs197, tweet drafts, scratch notes). Preview drafts with `bundle exec jekyll serve --drafts`. Publishing = move the file to `_posts/`, update filename + frontmatter `date:` to the actual publish date, normalize the header (`python3 scripts/normalize_post_headers.py`), push to `main`.

## Tweet draft workflow

Blog-post tweet drafts live in `exclude/tweets/` as plain `.txt` files, not `.md`, so emojis and copy-paste-ready X/Twitter formatting stay literal. Keep unpublished drafts in `exclude/tweets/tweet_drafts.txt` with the next tweet at the top. When a tweet is published, move the exact posted text to `exclude/tweets/already_posted_tweets.txt` and add the X/Twitter status URL. Do not create tweet drafts under `_drafts/`, `experiments/`, or blog-post-specific folders unless explicitly asked.

## GitHub Pages ↔ Stanford mirror sync (HARD)

Every push to `main` rebuilds GitHub Pages automatically, but the Stanford mirror (https://cs.stanford.edu/people/brando9/) only updates when `scripts/deploy_stanford_cs.sh` is run. The two must **always** be in sync — no exceptions: after every push, run the deploy script and verify the changed URLs return 200 on both domains. See `CLAUDE.md` § "GitHub Pages ↔ Stanford mirror sync (HARD)".

## Math rendering (HARD)

MathJax 3 renders all math client-side; `_config.yml` MUST keep `kramdown: math_engine: mathjax` (GitHub Pages forces it anyway — any other value silently diverges local/mirror builds from the live site). Never put `<`+letter inside single-dollar inline math (`$x^{<t>}$` → raw HTML tag, broken equation on both deploys); use kramdown's inline form `$$x^{<t>}$$` instead. After any math edit: build, scan output for raw-tag leaks / leftover `$$`, and verify rendered equations on BOTH domains. See `CLAUDE.md` § "Math rendering (HARD)".

Branch model: `main` only.
