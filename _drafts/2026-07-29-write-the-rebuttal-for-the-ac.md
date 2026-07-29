---
layout: post
title: "Write the Rebuttal for the AC"
date: 2026-07-29
section: meta-research
---

*Brando Miranda — July 2026 · ~7 min read*

**Warning: this post is a draft — content may change and errors may remain.**

**TL;DR.** Reviewers mostly don't move their scores. The area chair reads every thread side by side and makes the decision. So write the rebuttal for the AC: answer the metareview first, spend what's left on the lowest score, and write the AC comment last, once you know what the reviewer threads actually say. Concede only what you've verified, concede the specific thing rather than the category, and put what survives in the same paragraph as what you gave up.

---

These are working heuristics from one reviewing cycle, the NeurIPS 2026 Position Paper Track, with a lot of correction from my advisor and co-authors folded in. Some of it is mechanics of how the process works. Some of it is my opinion, and I'll flag which is which. The section on *how* to concede got the most red ink from co-authors, and it's the part I'd hand a student first.

## The AC is the reader who matters

You can answer a weakness cleanly, get back "thanks, this addresses my concern," and watch the score sit exactly where it was. That happens a lot. Reviewers have already formed a view, they've written it down in public, and updating costs them something.

The area chair is in a different position. They have to produce a decision from the whole record: four reviews, your four responses, whatever discussion happened, and their own read of the paper. They're the only person who sees all of it at once.

Two things follow. First, answer the metareview before you're tired. If the AC flagged three concerns, those three concerns *are* the paper's weaknesses as far as the decision goes, whatever any individual reviewer chose to emphasize. Second, consistency across threads stops being good manners and becomes load-bearing. Tell R2 the effect is small and R4 that it's clear, and the AC is the reader who notices.

## Then triage by score

After the metareview, go lowest first, then the middling ones. Leave a strong accept mostly alone.

The reasoning is about what the AC is looking at. Uniform accepts are easy to defend in a committee; one strong accept next to a reject is not. A single low score forces the AC to explain themselves, and you want to make that explanation easy rather than hard.

Under-discussed corollary: a strong accept is a thing you can lose. Not by pushing back, but by conceding so thoroughly across the response that the reviewer re-reads their own score and wonders whether they were generous. Watch your concession density on the reviews that already like you.

## Whether to concede

Never concede blindly. Concede a genuine error, or a limitation the evidence really does establish. Otherwise clarify, or point at what the paper already contains, which is more often the right answer than people expect.

Before you accept a technical premise, check it. Reviewer premises can just be wrong. I've seen "you compared against a weaker baseline" where the two methods turned out to be the same algorithm under two different names. If you'd conceded that one, you'd have conceded a fact that isn't true, in writing, where the AC can read it.

Here's a case worth naming because it's easy to misread as an attack. A reviewer says your effect might be explained by some other property you didn't measure. If your paper's position is that this property should be measured and reported, the reviewer has just made your argument for you. Cite them, agree, and say what it implies for practice. An alternative explanation nobody currently reports is evidence *for* a reporting position.

When the honest answer is somewhere in the middle, refine, don't retreat. "A clear change in observed behaviour, small in magnitude" is a sentence you can defend. "We withdraw the claim" invites the AC to wonder what else is soft.

## How to concede

The wording carries as much weight as the decision, and this is where drafts go wrong.

"We concede two points outright." "We withdraw." "This was our error." Each of these hands over more than the reviewer asked for, and each makes the paper sound broken to a reader who's skimming. A co-author will object to that sentence before they've read the substance underneath it, which tells you what an AC will do with it.

Concede the specific thing, never the category:

> **Weak:** The claim is unsupported.
>
> **Better:** That word claims more than the numbers support, and we'll change it.

The second one is a wording fix with a defined scope. The first one is an admission about the paper's evidence.

Related, and worth checking line by line: don't volunteer self-criticism harsher than the reviewer's own framing. If they wrote that two constructs are "connected but not the same," that's a request for precision. It isn't an accusation of error, and you shouldn't answer it as though it were. Cut the intensifiers while you're in there. "Outright," "entirely," "completely," "we were wrong" all cost you something and buy nothing. The unmodified verb is stronger.

Don't point at your worst weakness either. Telling a reviewer "this is the sharpest gap in the paper" is a real thing people write in rebuttals, out of a sense of honesty. They already scored the paper. They don't need the help.

Two rules that do most of the work in practice:

1. **Every concession names what changes and where.** "We'll revise the phrasing in §4.2 and add the caveat to the caption of Table 3." A concession with no consequence reads as evasion, even when it's sincere.
2. **Every concession sits next to what survives it.** Same paragraph. Give up the word, then state the finding that the word was overclaiming, which is still there and still interesting.

Close the response on what stands. Not on a tally of what changed.

## Evidence

Every number should be traceable to a table, section, or line the reviewer can open. My working test: if a co-author can't find it, a reviewer definitely can't.

Prefer facts already in the submitted PDF to anything you generate during the rebuttal window. This surprised me, and then it kept being true. The best answers were usually already sitting in our own appendix tables, unread because the appendix is long and reviewers are busy. Pointing at Table 7 is stronger than running something new, and it costs an afternoon less.

If you do run something new, label it honestly. A post hoc comparison is a sensitivity check, not a controlled experiment, and calling it the latter is the kind of thing a careful reviewer will catch and remember. State n. If your evidence is that three conditions came out in the predicted order, say that a perfect ordering of three arises by chance one time in six. Better you say it than them.

Keep association and causation apart, and when you only have association, name the design that would identify the causal claim. That reads as competence rather than hedging.

Pre-empt what a careful reviewer would find, including the outlier row in the very table you're citing. They will open the table.

Two more, both about what not to do:

- **Results, not promises.** Reviewers discount promised experiments heavily, and they're right to.
- **Don't cite your own adjacent unpublished paper.** It breaks double-blind, and it invites a critique you can't answer: why is this two papers if the load-bearing evidence lives in the other one? Eat the scope gap. It's cheaper.

## Construction

Answer the question actually asked, not the adjacent one you'd rather answer. "What's the consequence for an experimentalist?" wants concrete actions. Explaining the mechanism again is a non-answer, and a reviewer who asked a practical question notices immediately.

Follow each reviewer's own numbering, W1, W2, Q1, so every item is visibly checked off. This is partly for them and partly for the AC, who is scanning for holes.

Thank reviewers for strengths specific to their review, briefly. Generic praise of a thin review costs you credibility with the AC reading both.

When a reviewer hands you a good framing and asks you to make it explicit: take it, credit them in a clause, and add something of your own. Pure echo is a thank-you note, and it wastes the one chance you have to show the framing extends further than they suggested.

Small mechanical things that people get wrong under time pressure: third person for all self-citation, always. Don't pad to the character limit, length isn't the objective. Avoid absolutes, "solves selection bias," "isolates X," "X causes Y," "method M wins." Ask what would raise their score. Never ask for a higher score.

## Voice

This part is not optional any more. Reviewers penalize responses that read as LLM-written, and some tracks ban AI-written author responses outright. Whatever you think of that, it's the incentive you're operating under.

The target register is a tired expert writing carefully. Not a press release.

The tells, roughly in order of how loudly they announce themselves:

- Uniform sentence length. A run of same-length balanced sentences gives it away faster than any single word.
- The recurring frames: "not X, but Y", "It is worth noting that", "This is precisely why", "We would like to emphasise", "delve", "leverage", "robust" as filler.
- Em-dashes everywhere. Roughly one per section. Commas, colons, and full stops are available.
- Triads used for rhythm rather than content. "Clear, actionable, and testable" is three words doing one word's work.
- Consecutive paragraphs opening the same way. Two paragraphs starting "We agree" is a bad look.
- Symmetrical section openings. Real writing is uneven, and one section being blunter than the others reads as human.
- Abstractions where a number would do. "Table 7 gives -0.105" beats "the empirical evidence indicates."

Contractions in moderation help. A perfectly formal register from top to bottom reads as generated.

Then read it aloud. That catches more than any checklist, this one included. I wrote this post trying to follow its own rules, which was harder than expected and is probably the most useful thing in it.

## The AC comment, written last

Write it last, always. It summarizes the reviewer threads, so you can't write it before you know what those threads say.

Mirror the AC's priorities, in their order, with their numbering. If they raised three things, your comment has three parts in that sequence. Then end with an enumerated list of the manuscript changes and where each one lands. That list is the most useful paragraph in the whole rebuttal, because it's the thing the AC can point at in the decision.

## The hour before you post

Run these:

- Does every weakness and question have a visible answer?
- Is every number findable by the reviewer?
- Have I conceded anything I haven't verified?
- Is any concession worded more strongly than the reviewer's own framing?
- Would a co-author who knows the paper follow every claim?
- Does this end on what stands?

Then the mechanical pass, which has burned me: strip the LaTeX escaping, convert to markdown, check headers sit on their own line, check the character count, confirm nothing got truncated. OpenReview will happily eat your last paragraph.

## What I'm less sure about

One cycle, one track, one paper. Treat the specifics accordingly.

The claim I'd defend hardest is that the AC is the audience. The claim I'd defend least is the concession-density one, about losing a strong accept by over-conceding. I believe it, my co-authors believed it, and I have no way to show it from a single cycle. Venues differ too. Some ACs read the responses closely and some write the metareview from the score distribution, and you can't tell which you have until it's over.

What generalizes, I think, is the underlying move: stop writing to persuade the reviewer who annoyed you, and start writing for the person who has to defend a decision.

---

## Discuss

I'll share this on X — replies, disagreements, and pointers welcome.

<!-- TODO: once posted on X, add: I shared this post on X/Twitter here: [discussion thread](https://x.com/BrandoHablando/status/...). -->

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026rebuttalac,
  author = {Miranda, Brando},
  title  = {Write the Rebuttal for the AC},
  year   = {2026},
  month  = {July},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/07/29/write-the-rebuttal-for-the-ac.html}},
  note   = {Blog post}
}
```

<!-- NOTE: draft — the citation URL above assumes a 2026-07-29 publish date. Update it if the date changes when this moves from _drafts/ to _posts/. -->
