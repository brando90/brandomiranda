---
layout: post
title: "Research Contributions and Bit Flips"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Most students I meet at Stanford can code. Fewer can tell you what a research contribution actually is. That gap is the first thing I try to close in CS197, because without it the whole project collapses into a nicer-looking engineering exercise.

The frame I use is blunt: research produces novel contributions, and the most useful way to recognize novelty is to look for a **bit flip**. You articulate an assumption the field has been quietly making, and you argue the opposite. Everything else — the literature search, the related work section, the nearest-neighbor paper — is scaffolding around that single move.

## Experiments are money

One thing I repeat constantly: experiments are money. Startups don't know if they have a business until somebody pays them. Researchers don't know if they have an idea until an experiment agrees with it. If your experiments don't line up with your hypothesis, the hypothesis isn't really true yet — it's a story you're telling yourself.

I say this because I've watched students disappear into coding. Software engineering is fun and feels productive. But the output of a research project isn't a clean repo — it's a figure, a plot, a number that tells you something about the world. Code is a means. Confusing the two is one of the biggest differences between a software engineer and a research scientist, and one of the easiest ways to burn a quarter.

## What a bit flip actually is

A bit flip is an inversion of an assumption. The recipe has two steps: articulate an assumption that prior work left implicit, then argue for the opposite. If nobody has done the opposite, and doing it matters, that's a contribution.

The examples I walk through in class make this concrete:

- Network behaviors are defined in hardware, statically. **Flip:** define them in software, dynamically, so they're easier to debug. That's software-defined networking.
- A compiler should use smart algorithms to optimize into machine code. **Flip:** use randomization — Monte Carlo methods — to search optimizations. That's STOKE.
- Minimum-cut algorithms should always return the optimal answer. **Flip:** use a randomized algorithm that's much faster and tolerates a small error rate, because in practice we rarely need perfect answers. That's Karger's algorithm. (Karger was Michael Bernstein's advisor, and Michael is the professor who usually co-leads this class.)
- Build AI with hand-engineered expert features. **Flip:** learn features automatically from data. That's the deep-learning, Transformers, self-supervised wave.
- Activity tracking requires custom hardware. **Flip:** use commodity hardware — the phone already in your pocket. That's the UbiFit line of work.
- NLP models should read a sentence word by word so the model can see prior context. **Flip:** consume the whole sentence in parallel with attention. That's *Attention Is All You Need*, 2017 — and the reason BERT and GPT exist as we know them.
- Robots should look like little carts. **Flip:** humanoids are worth it for manipulation and working in human environments.

Each flip has a shape: assumption, inversion, and — crucially — a *reason it matters*. "Debuggable." "Faster." "Performs better." You can flip a million bits in any paper. Most don't matter. The discipline is noticing which assumption, once inverted, actually changes what the field can do.

None of this implies the old work was wrong. We stand on the shoulders of giants — computers rest on arithmetic, arithmetic on logic, logic on philosophy. A bit flip is a reaction to how people think about a problem today, not a dismissal of how they got there.

## Paper-level vs literature-level bit flips

Given a "nearest neighbor" paper — the one closest to your project in concept space — there are effectively infinite paper-level flips. Change the size of the pins on the haptic device. Vibrate them. Swap one component for another. Each is a bit flip. Most are incremental.

A **literature-level bit flip** is different. It's an assumption that cuts across many papers, not just one. Flipping it changes how you think about a whole class of systems. That's what you want.

The way you get there is unglamorous: read widely, talk to many researchers, go to conferences. You don't spend three months in a cave and then emerge with The Idea — that's not how it works for anyone I know. You work on a project with someone more senior, absorb the literature as you go, and ideas form from the overlap between what you're reading and what you're living. Sometimes the trigger is a class where something feels wrong and you go fix it. That's happened to me with a friend and colleague.

Pick your bit flip at the intersection of curiosity and impact. Curiosity because you need to survive the failed experiments — weeks or years of them — and if the question doesn't grip you, you won't make it. Impact because if the work matters, people will support it. Generosity and selfishness in some kind of balance.

## The literature search, in the shape of a graph

"An hour in the library saves a year on the keyboard." Not knowing prior work is how you spend six months rediscovering something from 2019.

The procedure is a graph expansion. Start with the nearest-neighbor paper. Read it closely — not every detail, but enough to understand its thesis and its own bit flip. Then expand: the three to five most important papers it cites that stay in your neighborhood, and the papers that cite *it*. Keep the ones close to your topic, prune the rest, recurse.

You stop when the marginal paper stops teaching you anything. For a PhD student, that's often 25–35 papers. For this class, aim for 15 and trust that I've seen the rest. The feel of saturation compounds — the more you know, the faster you recognize what's new.

How you read matters too. Don't try to understand every paper perfectly. Feynman reportedly read the abstract first and asked, *what did I learn?* If the answer was nothing, he moved on. I do something similar: title, abstract, first two sentences of the intro for motivation, the contributions bullets at the end of the intro, then the two key figures — method and results. That's usually enough to slot the paper into your related-work grid.

A small warning on packaging: some senior CS professors will drop a paper inside ten seconds if it's formatted badly. Your paper should look professional. It's rare that something is packaged well and also junk.

## From map to related work

Once you have your papers, build an affinity map — Post-its, Notion, whatever. One paper per note. Don't write "constitutional AI" on the note; write *LLMs can align themselves using a constitution*. The thesis, in a sentence. Bonus: write it without re-reading the paper — active recall is how you actually learn it.

Group the notes, regroup by nouns, throw out what isn't helpful, and turn each cluster's thesis into a topic sentence for a paragraph of your related work. A trick I use for every paper: write a second sentence — *"…but my paper is different because X."* That sentence stays out of the final draft, but it forces me to know exactly where my contribution lives.

Don't produce a bullet-point catalog. The related work section is a story: the literature is laid out to set up your bit flip. The final paragraph pivots — here's what prior work assumed, here's what we invert, here's why it matters.

## What I want students to walk away with

- **A contribution is a bit flip.** Name the assumption. Argue the opposite. Say why it matters.
- **Aim for the literature level, not the paper level.** Paper-level flips are infinite and mostly incremental. Literature-level flips are where real contributions live.
- **Read widely and cheaply.** Title, abstract, contributions, figures. Feel for saturation. Build a map, not a pile.
- **Experiments are money, and coding is the tax you pay to collect them.** The output you care about is a figure that tells the truth about the world.

Everything we do for the rest of the quarter — progress reports, literature reviews, related work drafts — is in service of those four sentences. The bit flip is the spine of the whole enterprise.
