# CLAUDE.md — Repo Conventions for Agents

This is Brando Miranda's personal site (Jekyll-based). It holds blog posts,
CVs, the landing page, and collaboration docs. The guidance below is
agent-agnostic — `agents.md` is a copy of this file so any agent (Claude,
Codex, Cursor, Gemini, etc.) picks up the same rules.

## Blog post conventions (`_posts/`)

Every blog post MUST include:

1. **Jekyll front matter** with `layout: post`, `title`, and `date`.
2. **A `TL;DR` line right after the byline (or front matter).** One to three
   sentences stating the *actual takeaway* of the post. Do not write
   "recording of / notes from X" framing — state the meat so skimmers can
   decide whether to keep reading.
3. **A BibTeX citation block at the very end of the post**, using the
   `@misc` entry template below.

### Citation template

Append this block (inside a fenced code block) at the end of every post:

````markdown
---

*If you'd like to cite this post:*

```bibtex
@misc{miranda<YEAR><SHORTSLUG>,
  author = {Miranda, Brando},
  title  = {<Full Title of the Post>},
  year   = {<YYYY>},
  month  = {<Month name, e.g. April>},
  howpublished = {\url{https://brando90.github.io/brandomiranda/<YYYY>/<MM>/<DD>/<slug>.html}},
  note   = {Blog post}
}
```
````

Rules for the citation:
- **Citation key**: lowercase, `miranda<YEAR><shortslug>` (no spaces, no
  dashes). Example: `miranda2026formaloversight`, `miranda2019uniformstability`.
- **`title`**: exact post title, no quotes inside the braces.
- **`year`** and **`month`**: taken from the post's Jekyll date. Month in
  full English name.
- **`howpublished`**: the rendered URL. Jekyll default permalink for this
  site is `https://brando90.github.io/brandomiranda/YYYY/MM/DD/<slug>.html`
  where `<slug>` is the filename (without date prefix and without `.md`).
- **`note`**: keep as `Blog post` (or extend if the post is a paper draft,
  talk transcript, etc.).
- Every post's citation is slightly different — update every field.

### Writing style

- First person, concise, direct. The April 2026 posts in `_posts/` are
  the style reference.
- Default to no inline comments or hedging. State claims and move on.
- Do not add emojis unless explicitly asked.

## Site layout reminders

- Default branch: `main`.
- GitHub Pages serves from `main`.
- `_drafts/` is for unpublished drafts (ignored by Jekyll's default build).
- Landing page is `index.md`. Publications list lives there.
