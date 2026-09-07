# 15 — One Chord, Three Names (Maiden Voyage sus chords)

Working folder for the blog post **"One Chord, Three Names: What Maiden Voyage Taught Me About Sus Chords"** (September 6, 2026). Published: ~8 min main post, ~12 min with the appendix.

Argument in one line: Aebersold's F#-/B, Snidero's B7sus, F# Dorian, B Mixolydian, my teacher's "E pent / A pent," and "B bebop" are all the same seven notes of E major named from different roots, because a sus chord has no third — so Mixolydian is the default over a sus, Lydian dominant is off the table, and a modal tune is a chain of short keys.

Notation in the post: alto (Eb) key throughout; every pentatonic labeled major or minor with its same-notes twin; "pent" in the pencil notes means major pentatonic (E major is the parent scale, from the four-sharp key signature).

## Files

- `x-announcement.md` — the X post: one standalone tweet and a six-tweet thread, all under 280 characters with links counted at 23. STALE: references the ~15 min version.
- `read-aloud.md` — the post with sharps, flats, and chord symbols spelled out in words, for listening via text-to-speech. STALE: written against the v0.5 full-length draft; regenerate from the published post before using.
- `agents-config-prompt.md` — the Claude Code prompt to reconcile the music-blog and publishing-bundle rules in `brando90/agents-config` with the conventions this post established.
- `PR_DESCRIPTION.md` — the pull request description used when this draft was opened.
- `CHANGELOG.md` — the draft's decisions, placeholders, open items, and version history.

## Published

- Post source: [`_posts/2026-09-06-maiden-voyage-sus-chords.md`](../../_posts/2026-09-06-maiden-voyage-sus-chords.md).
- Long cut (everything trimmed out of the post, verbatim): [Google Doc](https://docs.google.com/document/d/1ySI6iOZc4tVGSuePP5EILTYdshyR8fA0skPCuNvDme0/edit) — private to Brando's account, deliberately not linked from the published post.
- URL once live: <https://cs.stanford.edu/people/brando9/2026/09/06/maiden-voyage-sus-chords.html>
- Listed under **Music** on the blog index (auto-generated from `section: music`).
- Images: [`assets/maiden_voyage_sus_chords/`](../../assets/maiden_voyage_sus_chords/) — crops of chord symbols and pencil notes only (00 cover, 01 Snidero header, 02 Aebersold first chord, 03 Aebersold solo section, 04 Snidero appendix sentence, 06 Snidero scale page). File 05, the other teacher's Lydian-dominant notes, does not exist yet; the draft's `![...05...]` tag and its `[IMAGE TO ADD.]` caption were removed before publishing so the live page has no broken image. Re-add both when the photo exists.

## How it was written

Distilled from a conversation with Claude (Anthropic) on September 6, 2026, with the two books and pencil notes on the table; the chat link is in `preprompt.md` (private, account-gated, so it is deliberately not printed in the published post). Teacher credited: George Michael (also credited in the 2019 *Jazz Improvisation* post). The second teacher is unnamed in the post — the draft's `[TEACHER NAME]` placeholders now read "an earlier teacher"; swap in the real name when Brando supplies it.

This folder is local-only — `experiments/` is in `_config.yml`'s `exclude:` list and is never published.

- `preprompt.md` — Brando's original instruction for this task, including the source conversation link.
- The source bundle (`files (25).zip`) and its `unpacked/` copy are gitignored; every file in them is already extracted into the repo.
