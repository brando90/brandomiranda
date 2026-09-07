# Blog draft: One Chord, Three Names — What Maiden Voyage Taught Me About Sus Chords

**Status:** draft (the post carries the draft-warning line; keep it until the placeholders below are filled).

## What this PR adds

- `_posts/2026-09-06-maiden-voyage-sus-chords.md` — the post, `section: music`, canonical header (normalizer reports no change), ~15 min read for the main post plus a skippable appendix (A. questions and answers, B. takeaways, C. sources and BibTeX, D. the twelve playing options in detail, E. chart-by-chart details and the two-conventions caveat). A short "Notation" section fixes the conventions: everything in alto (Eb) key, every pentatonic labeled major or minor, and "pent" in the pencil notes read as major pentatonic because the four-sharp key signature makes E major the parent scale.
- `assets/maiden_voyage_sus_chords/` — six image crops of chord symbols and pencil annotations only (no full pages, no melody): `00` Aebersold Vol. 54 cover, `01` Snidero *Voyage* header with the C7sus/B7sus formulas, `02` Aebersold F#-/B with "or B7sus (E pent / A pent)", `03` Aebersold solo section with "B bebop / E pent / (B sus) A pent", `04` Snidero appendix sentence with "Q: what does this mean?", `06` Snidero scale page rows. `05` (the other teacher's Lydian-dominant notes) is still to be added.
- `experiments/15_maiden_voyage_sus_chords/` (local-only, excluded from publishing) — `README.md`, `CHANGELOG.md`, `x-announcement.md` (one tweet plus a six-tweet thread, all under 280), `read-aloud.md` (the post with notation spelled out for text-to-speech), `agents-config-prompt.md` (the Claude Code prompt to fold these conventions into agents-config), and this description.

## What the post says

Aebersold's F#-/B, Snidero's B7sus, F# Dorian, B Mixolydian, George Michael's "E pent / A pent," and "B bebop" are the same seven notes of E major named from different roots, because a sus chord has no third. Over a sus, Mixolydian is the default and Lydian dominant is off the table; the Lydian-dominant-by-default rule is about dominant chords that have a third, and one question decides it: does the chord or the key want the natural fourth? A modal tune is a chain of short keys, four bars each; the four-block practice map for alto is in the post.

## Where it came from

Distilled from a conversation with Claude (Anthropic) on Sunday, September 6, 2026 — books open (Snidero's *Jazz Conception*, Aebersold Vol. 54), pencil notes photographed, three rounds of questions (slash chords vs. sus; the teacher's pentatonic annotations vs. Snidero's Mixolydian; Lydian dominant vs. Mixolydian), then the draft, the images, the tweets, and this PR.

Conversation link: [SHAREABLE CONVERSATION LINK — paste here so this PR stays findable].

## Before merging

- [x] ~~Paste the shareable conversation link~~ — dropped: the chat URL is account-gated, so the post cites the conversation without a dead link. Kept in `preprompt.md`.
- [ ] Paste a *shareable* conversation link into the post (materials list and appendix C), `experiments/15_.../README.md`, and this description.
- [ ] Add `assets/maiden_voyage_sus_chords/05-lydian-dominant-lesson-notes.jpg`, then re-add the image tag under the Lydian-dominant section (the tag and its `[IMAGE TO ADD.]` caption were removed at publish time so the live page has no broken image).
- [x] `[TEACHER NAME]` removed — appendix C and Acknowledgments now say "an earlier teacher" / "the earlier teacher". Swap in the real name if wanted.
- [ ] Optional: tell George the post reads his "E pent" as E major pentatonic (settled by the parent-scale argument in the notation section).
- [ ] Read the post once for voice; edit lines, not structure.
- [ ] Decide whether to keep the read time at ~15 min or move "What the two charts actually say" to the appendix (saves about a minute).
- [ ] Remove the draft-warning line, then run `python3 scripts/normalize_post_headers.py` and confirm no diff.
- [ ] Post the X announcement (`experiments/15_.../x-announcement.md`) with image `02` attached; fill `[POST LINK]` and `[CONVERSATION LINK]`.
- [ ] Optional: run `experiments/15_.../agents-config-prompt.md` in the agents-config repo.

## Notes

- Copyright: book text is paraphrased (one short quote from the Snidero appendix), no melody is transcribed, and every image is a crop of a chord symbol plus handwriting.
- Read time calibration: the Metallica post is ~1,190 words at "~6 min," i.e. ~200 words per minute; the main post here is ~3,075 words.
