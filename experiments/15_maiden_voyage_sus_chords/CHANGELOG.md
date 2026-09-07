Maiden Voyage sus-chord blog post — draft summary and changelog

Draft: _posts/2026-09-06-maiden-voyage-sus-chords.md (v0.5, September 6, 2026)
Working title: One Chord, Three Names: What Maiden Voyage Taught Me About Sus Chords
Target: brando90.github.io/brandomiranda (Jekyll post; canonical URL under cs.stanford.edu/people/brando9/)

WHAT THE DRAFT CONTAINS

1. Main post, about 3,075 words of prose, labeled "~15 min read" at the top (site convention: byline line with month and read time, TL;DR paragraph first, horizontal rule, then sections). The read time covers the main post only; the appendix is explicitly marked as extra and skippable. Calibration: the Metallica post is about 1,190 words and labeled 6 minutes, so the site runs at roughly 200 words per minute.
2. Sections: the apparent contradiction between the Snidero and Aebersold charts; what a slash chord says (including the A/B spelling and the general X7sus rule); why the missing third makes every name fit; what the two charts actually say (tempos, key signature, the three spellings of the bridge chord); Snidero's "key of the correlating scale" sentence; Lydian dominant vs Mixolydian with the avoid-note logic, the natural-fourth test, the five-step decision procedure, and the two-conventions caveat; the twelve ways to play over B7sus in compact form; the four-block practice map with the notes that change between blocks and the practice plan; a short closing lesson.
3. A materials list (both books, the Hancock record, photo placeholders, conversation-link placeholder).
4. Appendix after a separating line, in the order requested: A) the nine questions with answers, B) thirteen takeaways, C) sources, the conversation link, and the BibTeX citation, D) the twelve options in full detail. Then Acknowledgments, matching the Metallica post.

DECISIONS TAKEN IN THIS DRAFT

0. Notation conventions, stated in the post itself (section "Notation, so nothing is ambiguous"): every note and chord symbol in alto (Eb) key, concert pitch a major sixth lower, photos as the page shows them; every pentatonic labeled major or minor with its same-notes relative twin in parentheses; "pent" in the pencil notes means major pentatonic because the four-sharp key signature makes E major the parent scale from which B Mixolydian, F# Dorian, and the pentatonics derive; each block's parent scale named (E, G, F, Ab major).
1. Completeness over brevity, per instruction: nothing from the conversation was dropped; the read time was allowed to reach the fifteen-minute ceiling.
2. Voice matched to the May 2026 Metallica post: first person, em-dashes, italics for emphasis, casual parentheticals, one-line sign-off ("That is enough for a Sunday afternoon").
3. TL;DR placed at the top of the post, because that is the site convention (the chat convention of TL;DR-last does not apply to published posts).
4. Everything stays in alto (Eb) key with one concert-pitch parenthetical, since the source charts are Eb parts.
5. Book text is paraphrased, not quoted, apart from one short phrase from the Snidero appendix; no melody is transcribed. Chord symbols and your own pencil notes are reproduced freely.
6. George Michael is named (he is credited in the 2019 Jazz Improvisation post). The Lydian-dominant teacher is left as [TEACHER NAME].
7. BibTeX key: miranda2026maidenvoyagesus. URL slug assumed: 2026/09/06/maiden-voyage-sus-chords.html.
8. A read-aloud rendering (sharps, flats, and chord symbols spelled out in words) was provided in the chat for listening while driving; it can also be stored on the site as an HTML comment or a "listen" variant if wanted.

COMPANION DELIVERABLES

1. maiden-voyage-post-x-announcement.md — the X announcement: Option A, one tweet (272 characters with the link counted as 23); Option B, a six-tweet thread (tweet 1 hook plus post link; tweets 2 to 5 the theory; tweet 6 the process note plus the conversation link). Suggested image: asset 02 (Aebersold's F#-/B with the pencil note).

PLACEHOLDERS TO FILL BEFORE PUBLISHING

1. [SHAREABLE LINK TO ADD] — the Claude conversation link (appears twice: materials list and appendix C).
2. Six image files in assets/maiden_voyage_sus_chords/ (six [IMAGE TO ADD] embeds in the post): 01 Snidero Voyage header with the C7sus/B7sus formulas; 02 Aebersold first chord F#-/B with the "or B7sus (E pent / A pent)" note; 03 Aebersold solo section, F# Dorian scale with "B bebop / E pent / (B sus) A pent"; 04 Snidero appendix paragraph with "Q: what does this mean?"; 05 the other teacher's Lydian-dominant lesson notes; 06 Snidero scale page rows (C7, C7sus, C7#11) with the "1 4 b7" note. Optional 00: the Aebersold Volume 54 cover. Crop to chord symbols and handwriting; do not post full pages or the melody.
3. [TEACHER NAME] — appears in appendix C and in Acknowledgments.
4. Front matter — confirm layout, date, and description fields match the repo's post convention; image paths assume the /brandomiranda/assets/<slug>/ pattern used by the Metallica post's audio files.

OPEN ITEMS

1. The "E pent = E major pentatonic" reading is now stated as settled by the parent-scale argument (notation section, practice paragraph, Q&A item 7); mention it to George if you want a second opinion.
2. If fifteen minutes feels long, the "What the two charts actually say" section can move to the appendix (saves about one minute) without losing content.
3. Decide whether to keep the Acknowledgments section or fold it into the materials list.

CHANGELOG

v0.5 (2026-09-06): notation conventions made explicit. New section "Notation, so nothing is ambiguous" (alto key; major/minor labels; parent scale from the four-sharp key signature); every pentatonic mention now says major or minor with its same-notes twin; blocks labeled by parent scale; Q&A 7 and the practice paragraph state "E pent" as E major pentatonic with the reasoning; takeaway 14 added. To hold the fifteen-minute read time, "What the two charts actually say" and the two-conventions caveat moved to appendix E (no content dropped). Tweets updated to say major pentatonic and alto key. Read-aloud regenerated.
v0.4 (2026-09-06): moved into the website repo on branch blog/maiden-voyage-sus-chords. Post converted to the repo's canonical header (front matter with section: music, byline, draft warning, TL;DR, rule; no H1 or date line; normalizer reports no change). Asset links switched to {{ site.baseurl }}. Five image crops added from the annotated pages (00 cover, 01, 02, 03, 04, 06); 05 pending. Appendix demoted to H2/H3. Experiments folder 15 created with the X announcement, a read-aloud rendering, the agents-config prompt, the PR description, and this changelog.
v0.3 + X announcement (2026-09-06): added the X announcement companion file (one tweet plus a six-tweet thread, all under 280 characters with links counted at 23); the post file itself is unchanged.
v0.3 (2026-09-06): image plan wired in. Six inline image embeds with alt text and italic captions at the points where each page is discussed (Snidero header and formulas; Aebersold first chord and pencil note; Aebersold solo section with George's annotations; Snidero appendix sentence; the other teacher's Lydian-dominant notes; Snidero scale page rows), all pointing to assets/maiden_voyage_sus_chords/ with numbered filenames, plus a materials-list link to the folder. No prose changed; read time unchanged.
v0.2 (2026-09-06): expanded for completeness. Restored the A/B spelling rule; added the "What the two charts actually say" section (tempos, key signature, the Bb-13 / Bb- / Bb-7/Eb variants); expanded the Lydian-dominant section (whole-step tension logic, melodic-minor parent scale, the parallel with Lydian on major seventh chords, scales for a V7 resolving to minor, the five-step procedure, the two-conventions caveat); the twelve options now appear in the main post in compact form with the detailed version as new appendix D; added the notes that change between blocks and the practice plan; Q&A item 5 now points to appendix D. Read time re-measured at about 3,075 words and set to ~15 min.
v0.1 (2026-09-06): first full draft, assembled from the three-exchange conversation (slash chords vs sus, the teacher's pentatonic annotations, Lydian dominant vs Mixolydian). Read time set from a word count at the site's apparent ~200 words per minute.

v0.6 — September 6, 2026 (published to main)
--------------------------------------------

Publish pass. Content unchanged except for the placeholder cleanup below; the draft-warning line stays, so the post is live but still marked a draft.

1. Removed the `![...]05-lydian-dominant-lesson-notes.jpg` image tag and its "[IMAGE TO ADD.]" caption from the Lydian-dominant section. The file does not exist, and a missing image renders as a broken-image icon on both deploys. The surrounding prose reads fine without it. Re-add the tag when the photo exists (see PR_DESCRIPTION.md).
2. Removed the "Photo of the lesson notes ... [TO ADD as file 05 ...]" bullet from the materials list, same reason.
3. "[SHAREABLE LINK TO ADD.]" (materials list and appendix C) removed. The conversation URL Brando has is an account-gated claude.ai chat link, not a shareable one, so it would 404 for every reader; the post now cites the conversation without a link. The private link is kept locally in experiments/15_maiden_voyage_sus_chords/preprompt.md.
4. "[TEACHER NAME]" (appendix C and Acknowledgments) replaced with "an earlier teacher" / "the earlier teacher who gave me the Lydian-dominant rule". No name was invented; swap the real one in when supplied.
5. Verification run before merge: scripts/normalize_post_headers.py reports "no change" on this post (canonical header, run twice for idempotence); a local Jekyll build renders the page with all six images resolving and no leftover bracket placeholders; the Stanford mirror was redeployed and both live URLs return 200.
6. Source bundle (files (25).zip, unpacked/) gitignored — every file in it is now extracted into the repo.

STILL OPEN

- Image 05 (the Lydian-dominant lesson notes photo).
- The second teacher's name.
- A shareable conversation link, if Brando wants one public.
- Brando's read-for-voice pass, then remove the draft-warning line and re-run the normalizer.
- Posting the X announcement (x-announcement.md) with image 02 attached.

v0.7 — September 6, 2026 (trim to ~8 min, draft banner retired)
----------------------------------------------------------------

Brando: "let's not have that [draft warning] anymore ... let's keep it 8mins and the appendix should also be shorter ... top 12 mins total. Remaining text can go in a google doc." And, separately: the heading "Snidero's one confusing sentence" "sounds like we are blaming."

1. Cut the post from 5,481 words (~17 min main + ~11 min appendix) to 2,424 words: main 1,687 (~8.4 min, byline now reads "~8 min read"), appendix 737 (~3.7 min), total ~12.1 min. The argument is intact end to end; what went was length, not structure.
2. Main post: the notation section is now one sentence; the five-case Lydian/Mixolydian procedure is gone (the one-question test stays); the compact twelve-options list and the four-block practice map moved from the body into the appendix; every remaining section was tightened line by line.
3. Appendix rebuilt as three reference sections — A. the four-block map and practice plan, B. the twelve playing options (compact), C. sources and BibTeX. The old A (nine questions), B (fourteen takeaways), D (twelve options in detail), and E (chart-by-chart) are gone from the post; E's two-conventions caveat was kept as one paragraph in the main Lydian section so the honest qualification survives.
4. Everything cut is preserved verbatim in a Google Doc, "Maiden Voyage sus chords — the long cut": https://docs.google.com/document/d/1ySI6iOZc4tVGSuePP5EILTYdshyR8fA0skPCuNvDme0/edit (private to Brando's account; not linked from the published post, since what to do with it is undecided). Nothing was rewritten or invented on the way in.
5. Draft-warning banner removed from this post AND retired as a repo convention: the rule is deleted from CLAUDE.md and AGENTS.md, scripts/normalize_post_headers.py now STRIPS the line instead of relocating it, and the line was removed from the four other published posts that carried it (velocity, vectoring, score-matching, why-EBMs) plus three files in _drafts/.
6. Heading "Snidero's one confusing sentence" renamed to "The sentence that stopped me", and its caption to "The sentence I had to sit with, and my margin note." The body now says "It took me a few readings, and the sentence is exactly right." New HARD rule in CLAUDE.md and AGENTS.md — "Blog voice: own the confusion, don't blame the source" — so this does not recur by default.

STILL OPEN (unchanged from v0.6)

- Image 05 (the Lydian-dominant lesson notes photo).
- The second teacher's name.
- A shareable conversation link, if Brando wants one public.
- What to do with the long-cut Google Doc.
- Posting the X announcement (x-announcement.md) with image 02 attached.

v0.8 — September 6, 2026 (sources / process apparatus removed)
---------------------------------------------------------------

Brando, on the appendix's source bullets: "wtf? I def don't need that type of thing ANYWHERE ever," then "I don't think this is needed either" (the four book/lesson bullets), then "nor this either" (the Claude-conversation bullet).

1. Appendix C ("Sources, and how to cite this") deleted in full — every bullet:
   - the two books and the Hancock record (all three are named in the prose where they matter),
   - the lesson-notes bullet (George is named in the prose and thanked in the Acknowledgments),
   - "Photos of my annotated pages ... crops of chord symbols and pencil notes, not full pages" (a defensive copyright hedge, plus a redundant link to photos already inline),
   - "Experiment folder on GitHub — the X announcement, a read-aloud rendering, and the changelog" (build scaffolding, not reader content),
   - "Distilled from a conversation with Claude (Anthropic) ..." (provenance / AI-disclosure note).
2. The BibTeX citation block was kept — it is a house convention on 16 of the blog's posts — and lifted out of the appendix to stand on its own between the appendix and Acknowledgments, matching the Metallica post's structure. The appendix is now A. the four-block map and B. the twelve options, both pure musical content, ~3 min.
3. Same cleanup applied to the one other post carrying the pattern: the Metallica post's bare "[Experiment folder on GitHub]" bullet is gone. Its links to real artifacts (score PDF, the two .sib files, MP3, WAV, the Suno prompts and the Suno take) all stay — those are content the reader wants, not apparatus.
4. New HARD rule in CLAUDE.md and AGENTS.md — "No sources / materials / process apparatus on blog posts" — covering bibliographies, working-folder links, provenance/AI-disclosure notes, defensive hedging, and redundant links to embedded assets. It states explicitly that links to real creative artifacts are content and stay, so the rule cannot be over-applied.

NOTE: read-aloud.md and x-announcement.md in this folder were written against the v0.5 full-length draft and are now stale — they still describe the ~15 min post with its five-section appendix. Regenerate them from the published post before using either.
