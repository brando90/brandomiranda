# Claude Code prompt — reconcile music-blog and publishing-bundle rules in agents-config

Recommended: Claude Opus 5, medium effort, run as `clauded` from the agents-config repo. Docs-only repo; the risk is reconciliation quality across the routing index and scoped docs, not token volume.

```
You are working in the agents-config repo (brando90/agents-config), a three-layer, agent-agnostic documentation system: thin agent entry points (CLAUDE.md / AGENTS.md), a shared routing index (INDEX_RULES.md or INDEX.md, whichever exists), and scoped modular docs. Task: audit and complete the rules for how I write and publish blog posts on my personal site (brando90.github.io/brandomiranda, Jekyll, canonical URLs under cs.stanford.edu/people/brando9/), with special attention to music posts, so that a future agent can one-shot the entire publishing bundle for a post. Do not restructure the repo. Do not put rules in the thin entry points; put them in the scoped doc(s) and make sure the index routes to them.

Step 1 — Locate. Search the index and all docs for anything about blog posts, writing style, the personal website, social posts, X/Twitter, music, or jazz. If a sibling checkout of the website repo (brandomiranda) exists next to this one, read its CLAUDE.md "Blog post header format (HARD)" section and treat it as the authoritative header spec (front matter with layout/title/date/section, italic byline, optional draft-warning line, TL;DR paragraph, horizontal rule, no H1 in the body, normalizer at scripts/normalize_post_headers.py), but do not edit any post there. List what you found with paths.

Step 2 — Compare. Check each convention below against the existing rules and classify it as ALREADY COVERED (cite the line), NEW (add it), or CONFLICT (existing rule says something different). For conflicts, keep the existing rule in place, add the new one next to it marked "CONFLICT — Brando to resolve," and list them in the report. Never delete or silently reword an existing rule.

Conventions to encode (source: my published posts plus a working session on 2026-09-06):

Post skeleton
- Jekyll front matter: layout: post; title; date; section (ml, music, meta-research, agentic-coding) — the blog index groups by section.
- Body, immediately after the front matter: an italic byline "*Brando Miranda — Month YYYY · ~N min read*"; the optional bold draft-warning line while the post is in development; a bold "TL;DR." paragraph; a horizontal rule; then H2 sections. No H1 and no date line in the body (the layout renders them). Run scripts/normalize_post_headers.py after any post edit. The TL;DR goes at the TOP of a blog post; this is the opposite of my chat convention (TL;DR at the end of a response) and the two must not be conflated.
- Voice: first person, em-dashes in narrative prose, italics for emphasis, casual parentheticals, conviction claims, a one-line sign-off ("That is enough for a Sunday afternoon."). Collaborative refinement of my draft; no wholesale restructuring.
- Closing blocks, in order: a horizontal rule; an italic "Materials for this post:" (or "All files for this experiment (downloadable):") list linking assets via {{ site.baseurl }} and the experiments folder on GitHub; a horizontal rule; "If you'd like to cite this post:" followed by a ```bibtex block with key miranda{year}{shortslug}, howpublished = cs.stanford.edu/people/brando9/YYYY/MM/DD/slug.html, note = {Blog post}; then an H2 Acknowledgments.
- Cross-link earlier related posts (for music: 2019/10/31/jazz-improvisation.html and 2026/05/07/metallica-goes-jazz.html).
- When a post was written with an AI assistant, say so plainly in the sources section and in the announcement, and link the shareable conversation.

Length and read time
- Read time is computed over the main post only, at about 200 words per minute (calibration: the Metallica post is about 1,190 words and is labeled 6 min).
- Main post ceiling: 15 minutes. Ideal: 8 to 10. Completeness beats brevity: nothing discussed gets dropped; overflow goes to the appendix.
- Appendix: after a horizontal rule, an H2 "Appendix" marked "not counted in the read time above, and skippable," with H3 subsections in this order: A. my questions and the answers (numbered); B. summary of takeaways (numbered); C. sources, the shareable link to the conversation the post was distilled from, and the BibTeX; D. detailed extras (e.g., a full option catalog whose compact version is in the main post). Acknowledgments come after the appendix.

Music-post specifics
- Everything in alto (Eb) key — every written note and chord symbol — with one concert-pitch parenthetical, since my charts are Eb parts; images stay as the page shows them.
- Pentatonics are always labeled major or minor, with the same-notes relative twin in parentheses ("A major pentatonic (F# minor pentatonic)"); a bare "pent" appears only when quoting a pencil note, and the text says which it is. Name each chord block's parent major scale (read it off the key signature) and derive the modes and pentatonics from it explicitly; state these conventions briefly in the post itself when they matter.
- Chord symbols as printed in the source (B7sus, F#-/B, Bb-13, CΔ, C7#11); the Aebersold dash means minor; note names with # and b; scale degrees spelled out in prose ("flat seven", "sharp eleven"); bar ranges as "bars 1–4"; the "pent" shorthand is fine when quoting my annotations.
- Numbered lists for option catalogs, decision procedures, and practice maps, so items can be referred to by number.
- Copyright: paraphrase book text (at most one quote under 15 words per source); never transcribe melodies or etude lines; photos are crops of chord symbols plus my handwriting, never full pages or melodies; book covers are fine for identification.
- Name teachers or collaborators only if they have already been credited publicly (George Michael, in the 2019 post); otherwise leave a [TEACHER NAME] placeholder.
- Companion read-aloud rendering: the post with sharps, flats, and chord symbols spelled out in words ("F-sharp minor over B", "B seven sus"), kept in the post's experiments folder as read-aloud.md, generated from the post source so the post stays authoritative.

Assets and placeholders
- Images and audio live in assets/<post_slug>/ with numbered, descriptive filenames (01-snidero-voyage-header-annotations.jpg), embedded inline where discussed with {{ site.baseurl }} paths, each with alt text and an italic caption, and the folder linked from the materials list. The post's working files go in experiments/<NN>_<slug>/ (next free number) with a README in the existing style: one-line argument, Files, Published, "local-only" note.
- Placeholder conventions: [TO ADD], [IMAGE TO ADD], [SHAREABLE LINK TO ADD], [CONVERSATION LINK], [POST LINK], [TEACHER NAME].

Publishing bundle (belongs in the workflow doc, not the style doc)
- Every post ships as a one-shot bundle, produced together, written to files, and also shown inline in the chat: (1) the post .md in canonical header format; (2) a paste-ready summary/changelog .md for Google Docs (what the draft contains, decisions taken, placeholders to fill, open items, a versioned changelog), which also lives in the experiments folder as CHANGELOG.md; (3) an X announcement .md with Option A, one standalone tweet, and Option B, a thread of four to six tweets; (4) the read-aloud rendering; (5) a PR_DESCRIPTION.md and a branch named blog/<slug>, pushed and opened as a PR when GitHub access is available.
- X announcement rules: every tweet under 280 characters with each URL counted as 23; same first-person voice as the post; chord symbols allowed; no hashtags; tweet 1 of the thread is the hook plus [POST LINK]; the middle tweets carry the substance so the thread stands alone; the last tweet is a process note that says the post was written with Claude and carries [CONVERSATION LINK]; suggest which asset image to attach; report the character count of each tweet.
- Re-present every deliverable file every turn, not just the changed ones.
- During the working session, each chat response ends with a running numbered list of takeaways and of my questions with answers, which become appendices A and B.
- Any coding-agent prompt comes with a recommended model and effort level, stated outside the prompt.

Step 3 — Patch. Edit or create the scoped doc(s) following the repo's existing naming and section style; if a general blog doc, a music-specific doc, and a publishing-workflow doc all make sense, keep them separate and route all of them in the index. Respect the repo's existing filename conventions (do not introduce a second spelling of CLAUDE.md or INDEX_RULES.md).

Step 4 — Report. Print: (a) the files touched with a diff; (b) the coverage classification for every convention above (ALREADY COVERED / NEW / CONFLICT); (c) the open questions. If gh is authenticated, commit on a branch named docs/music-blog-rules and open a PR with the report as the description; otherwise leave the diff uncommitted and tell me.
```
