---
layout: post
title: "Writing in the Era of Agents"
date: 2026-05-29
published: false
---

*Brando Miranda — May 2026 · ~4 min read*

**TL;DR.** Agents changed the economics of research writing. I still think papers need to be true, precise, and defensible, but I am less convinced every sentence deserves the old level of hand-polish when many readers will skim, outsource the first pass to an agent, or only read the title, abstract, and intro. My current instinct is to polish the parts that carry the argument, verify the parts that carry factual risk, and stop treating ornamental prose perfection as the bottleneck.

---

I used to write papers sentence by sentence.

Not only "write carefully," but really sit with every sentence until it felt right. I remember doing this for my Beyond Scale paper: polishing the wording, tightening the claims, sometimes pair-writing with coauthors in the same document until a paragraph finally clicked. One of my fond memories from that period is writing with Alycia, where the work was not just making the paper correct but making the prose feel like the idea had found its final form.

I still believe in that. Good writing is not decoration. Good writing is thinking made checkable.

But I am starting to wonder whether the right writing habit has changed in the era of agents.

## Writing While the Project Is Still Alive

My current workflow is different from the one I had before agents. I do not wait until the experiments are done and then migrate to Overleaf for a separate "paper writing phase." I keep the paper in the same GitHub repo as the code. I write while the experiments are running. The paper, plots, scripts, notes, and agent instructions live together.

That has made the writing process more continuous and, honestly, less sacred. The paper becomes another artifact in the research loop. Run experiment, inspect result, update figure, revise claim, ask an agent to check for inconsistencies, rewrite the intro, rerun the table, repeat. The paper is not a polished monument at the end. It is the working surface where the project explains itself.

That feels better to me. It removes friction. It makes writing part of the actual research process instead of a late-stage ceremony.

But it also changes what "done" feels like.

## The Marginal Sentence

I am finishing one of my favorite projects right now, VeriBench, and I keep rereading the draft with a strange feeling. The writing could be better. I can see the sentences I would have tightened in the old workflow. I can see places where a paragraph is a little more verbose than my favorite version would be, or where I might choose a sharper transition if I gave it another day.

At the same time, nothing is false. Nothing is hallucinated. The claims are accurate. The limitations are stated. The structure is legible. The paper says what the work does.

So what exactly is the value of perfecting the marginal sentence?

Before agents, my implicit answer was obvious: the paper is the interface. If the paper is unclear, the work is unclear. If the prose is sloppy, readers may misunderstand the contribution or lose trust. Polishing was not vanity; it was part of the intellectual work.

Now I am less sure where the threshold is. Many people will not read the full paper. Some will read only the title, abstract, intro, figures, and maybe the limitations section. Some will paste the PDF into an agent and read the agent's summary. Some reviewers may use agents to help them extract claims, compare related work, or summarize weaknesses. I do not know how common each behavior is, but I would be surprised if the old model of careful linear reading remains the default.

That creates an uncomfortable question: if the first reader is often an agent, how much time should the human author spend making every sentence beautiful?

## What Still Deserves Perfection

I do not think the answer is "stop caring about writing." That would be the wrong lesson.

The title still matters enormously. It is the handle by which the work enters memory.

The abstract still matters. It is the compressed contract with the reader: what problem, what contribution, what result, why care.

The intro still matters. It sets the frame. It decides whether the reader understands the paper as a technical artifact, a benchmark, a critique, a method, or a new research direction.

The figures and captions matter. Many readers reconstruct the whole paper from them.

The discussion and limitations matter. This is where false confidence does the most damage. If an agent-assisted workflow makes it easier to write plausible prose, then the human obligation is to make sure the boundary of the claim is real.

And factual correctness matters more than ever. No hallucinated citations. No overstated baselines. No laundering a weak result through confident language. No allowing an agent to make the work sound cleaner than it is.

That, I think, is the emerging split: polish the surfaces that determine interpretation, verify the surfaces that determine truth, and accept that not every internal paragraph needs literary perfection.

## A Possible Protocol

My tentative protocol is something like this:

1. Polish the title, abstract, intro, main figures, and captions until they feel hand-authored and durable.

2. Read the technical sections for correctness, not ego. Fix ambiguity that can change the meaning. Do not spend an afternoon replacing a merely okay sentence with a slightly more elegant one.

3. Treat the limitations, discussion, and related work as high-risk sections. These deserve slower human scrutiny because they are where rhetoric can most easily outrun evidence.

4. Use agents aggressively for consistency checks: does the abstract overclaim relative to the experiments, do the captions match the plotted quantities, do the limitations contradict the conclusion, are there undefined terms, are there missing caveats?

5. Keep the paper close to the code. If the artifact is a benchmark or system, the repo is part of the argument. A beautiful PDF attached to a disorganized artifact is not actually well written.

6. Stop when the remaining edits are mostly about making the prose sound more like my favorite version of myself.

That last one is the hard part. There is a kind of polish that improves the paper, and there is a kind of polish that preserves the author's self-image. I am trying to get better at distinguishing them.

## What I Do Not Want to Lose

The danger is that "agents will summarize it anyway" becomes an excuse for lazy writing. I do not want that.

There is a reason I loved the old pair-writing sessions. Coauthor writing is where ideas get sharper. You discover hidden disagreements. You notice that the contribution you thought was obvious is not obvious. You find the sentence that reveals the whole framing is wrong.

Agents can help with that, but they do not replace the human act of deciding what the paper is. The author still owns the taste, the claim, the standard, the evidence, and the decision to stop.

So maybe the right habit is not less writing. It is more targeted writing.

Spend the human attention where it compounds: the frame, the claims, the figures, the caveats, the parts people and agents will use to reconstruct the work. Let the rest be clear, accurate, and good enough.

I am curious where other people are converging. Are we entering a world where paper prose becomes more like code documentation: precise, searchable, agent-readable, and maintained next to the artifact? Or will the best papers still be the ones where every sentence has clearly passed through a human mind at full attention?

My current answer is unsatisfying but probably honest: the paper should be beautiful where beauty changes understanding, and merely excellent where excellence is enough.

{% comment %}
Private lab-discussion context for later revision. Keep non-rendered.

Discord thread for lab replies:
https://discord.com/channels/488822282664280084/489073286945308672/1509712459395629268

Original lab prompt:

Want to open this discussion to the lab.

As I finish one my my fav projects (bet most of you have heard of VeriBench...maybe too many times!) I wonder what the right protocol/habit is for writing in the era of agents. I now put my papers on my github repos (don't use overleaf at all; I think it adds friction for no benefit -- for me) and I do the writing in tandem with my experiments. Before agents eg for my beyon scale paper -- I crafted each sentence to perfection (sometimes even pair programming/writing with my coauthors eg I remember fondly a time I did this with alycia).

I'm reading and edit it now and I see the writing could be improve but honestly think marginally. So now I can't tell if this extra time is worth perfecting the writing or honestly moving on to the next project. Nothing is false or hallucinated. Just a tiny bit more verbose perhaps or not said my favorite way. I think my new workflow will move to only perfecting the title, abstract and intro (assuming that's what people read). And making sure nothing is false/hallucinated + the discussion/weakness section is accurate. I find it hard to motivate myself to perfect my prose as I used to when people will either  (which are asumptions of course):

1. not read it
2. dump it to an agent and only read the agent's tldr.

I'm curious what people are converging to. Are ppl converging to this?

Future notes:
- Add lab replies here as non-rendered notes before deciding whether to publish.
- If promoted to `_posts/`, remove `published: false`, revisit read time, and decide whether any private context should stay in Liquid comments.
- 2026-06-09: SUPERSEDED by _drafts/2026-06-09-how-people-write-research-papers-in-the-agentic-era.md, which integrates the lab replies (Dan, Allen, Sanmi, Kirill, Andrew) per the note above. Keep this file for reference; merge or retire it when the new draft publishes.
{% endcomment %}
