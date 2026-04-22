# CLAUDE.md — Repo Conventions for Agents

This is Brando Miranda's personal site (Jekyll-based). It holds blog posts,
CVs, the landing page, and collaboration docs. The guidance below is
agent-agnostic — `agents.md` is a copy of this file so any agent (Claude,
Codex, Cursor, Gemini, etc.) picks up the same rules.

This file is excluded from Jekyll's build via `_config.yml` so it is never
published to the site. Keep it that way.

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

## Tweet drafting protocol (`exclude/tweets/`)

When the user asks for tweets / a Twitter post / "a thread" to promote a
blog post, follow this protocol. Drafts live in `exclude/tweets/` — that
folder is inside `exclude/` which Jekyll already excludes from the build,
so drafts never ship to the site.

### Where and how to save drafts

- One file per blog post: `exclude/tweets/<post-filename-without-extension>.md`.
  Example: `exclude/tweets/2026-04-22-formal-methods-scalable-oversight.md`.
- Commit drafts to the feature branch. They are reference material, not
  published content.

### What each draft file must contain

1. **Header block**: post title, full post URL, Twitter handle
   (`@BrandoHablando`), and a one-line "anchor takeaway" distilled from
   the post's TL;DR.
2. **3–4 single-tweet options**, each with a short label (e.g.
   "A — the reframe", "B — the hot take"). Each option is a full,
   copy-pasteable tweet in a fenced code block, URL included.
3. **One thread option** of 3–5 tweets, each tweet in its own code block,
   numbered `1/`…`N/`. The last tweet in the thread carries the blog URL
   and an explicit invitation to reply.
4. **A short "Notes" section** at the bottom telling the user which option
   is safest, which is spiciest, and how to sequence them (e.g. "post A
   first, reply with the thread an hour later if it's quiet").

### Voice and content rules

- **Voice matches the blog**: first person, direct, thoughtful, conversational.
  No hype, no "Just published…", no marketing adjectives. If a line sounds
  like a LinkedIn post, rewrite it.
- **Lead with a hook**: a reframe, a surprising asymmetry, a contrarian
  claim, or a concrete workflow detail. Never lead with "I wrote a new
  blog post."
- **Pull one hot take or sharp claim** from the post and let it anchor the
  invitation to discuss. If the post has a genuinely spicy line, surface it.
- **End with a discussion invitation** on at least one of the options and
  on the final tweet of any thread: "Tell me where I'm wrong", "Curious
  if others have converged here", "Would love pushback", etc. Do not
  manufacture fake humility.
- **Don't spoil the post.** Tease the structural move or the conclusion;
  leave the reader a reason to click.
- **No emojis.** No hashtags unless the user asks. Em dashes are fine —
  they match Brando's prose.
- **Length**: each tweet must fit in 280 characters. Count before shipping.
  Thread tweets should stand on their own where possible so they survive
  being quoted out of order.
- **URL placement**: single tweets end with the post URL on its own line.
  Threads put the URL on the final tweet only.

### Before returning drafts

- Check the character count of every tweet.
- Check that the post URL matches the rendered Jekyll permalink
  (`https://brando90.github.io/brandomiranda/YYYY/MM/DD/<slug>.html`).
- Confirm the hot take / anchor claim is actually in the post — don't
  invent claims Brando didn't make.

## Site layout reminders

- Default branch: `main`.
- GitHub Pages serves from `main`.
- `_drafts/` is for unpublished blog drafts (ignored by Jekyll's default build).
- `exclude/` is excluded from Jekyll via `_config.yml`; use it for
  agent-facing artifacts that should be tracked in git but not published.
- Landing page is `index.md`. Publications list lives there.
- `CLAUDE.md` and `agents.md` are agent-facing only; both are in the
  Jekyll `exclude:` list in `_config.yml`.
