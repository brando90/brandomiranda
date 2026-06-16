---
layout: post
title: "What arXiv Misses: Negative Results and the Case for Joining a Lab"
date: 2026-05-04
---

*Brando Miranda — May 2026*

**TL;DR.** A friend in biology once told me the real reason you join a lab is to inherit its negative results — the experiments nobody publishes, the dead ends only the lab remembers. At the time I waved this off for CS: we have arXiv, we have GitHub, we have blogs. I was wrong. ML especially runs on a private corpus of "what didn't work at scale," and almost none of it leaves the lab Slack channel. The frontier-lab gap is, in large part, a negative-results gap. If you're choosing where to do a PhD, you're choosing whose failure history you get to inherit.

## The conversation I keep coming back to

A biology friend once explained, with more conviction than I expected, why the *lab* matters more than the *paper*. The published literature in biology, she said, is a distorted projection of what's actually known. It overweights successes, underweights failures, and almost never reports the dozen variants of an experiment that didn't pan out before the one that did. The way you learn what's real — what reagents to trust, what protocols silently break, what assays don't replicate — is by joining a lab and absorbing its institutional memory. Rotations exist for that reason as much as for any other.

I remember nodding politely and quietly thinking: *this isn't really a problem in CS*. We post code. We post arXiv preprints. The negative trials show up as ablations. Anyone with a browser can catch up.

It took me embarrassingly long to realize I was wrong.

## What ML actually withholds

Once you do ML for a while, the shape of what's *not* on arXiv becomes obvious. Off the top of my head:

- **Failed scaling runs.** A team trains a 70B model with a new architectural tweak. It diverges, or it converges to a worse loss than the baseline. Nobody writes a paper called *"Our New Idea Didn't Work."* The information stays in the team's heads and a private postmortem doc.
- **Dead ablations.** Papers report the ablations that fit the narrative. The ones where removing a component *helped* — exposing that the component was load-bearing for the wrong reason — quietly disappear.
- **Architecture variants that look right and underperform.** Most of the search space around a published architecture has been tried by *someone*. Almost none of it gets reported. You read the one configuration that won; you don't read the fifty that lost.
- **Data mixes and curation tricks.** The decision rule for what to filter out, what to upsample, what synthetic source to mix in — this is often the most consequential lever in a frontier model and almost the *least* documented externally.
- **Infra that quietly load-bears.** Optimizer state hygiene. Numerical-stability hacks. Communication-collective settings. Sometimes the reason a loss curve looked clean had nothing to do with the science.
- **Hyperparameters that don't generalize.** The published config is rarely the *general* config. It's the config that worked at the published scale and seed. The ones that didn't generalize across scales, datasets, or initializations are folklore.

None of this is captured by "we have arXiv." It isn't even captured by "we open-sourced the code." The code shows you the path that won. It does not show you the dozens of paths that didn't, why they didn't, or how the team came to suspect they wouldn't before they tried. *That* is the corpus you only learn by being there.

## The frontier-lab gap is a negative-results gap

When people say a frontier lab has a moat, they usually mean compute or data. There is a third moat that gets less airtime: a private, accumulated record of *what doesn't work at scale*. A senior researcher at a frontier lab carries a head full of priors that are completely invisible to the field. They'll tell you an idea won't work in a sentence — not because of a paper, but because two years ago someone tried something close and the run died at 30B parameters. Outside the lab, that prior is unobtainable except by reproducing the failure yourself, at cost. Which most people can't afford.

This is the part my biology friend was right about, transposed. The lab is where the negative-results corpus lives. Joining one is, in part, an inheritance event.

## Reading the literature isn't enough — and never was

I've written before about why I think reading the literature too deeply is a trap, and that you should [read just enough to find the thing that feels wrong, then go](/2026/04/16/read-literature-trust-intuitions.html). The negative-results problem sharpens that view. The literature is not just an incomplete map; it is *systematically* incomplete in a particular direction. It is heavy on the paths that worked and almost silent on the paths that didn't. If your training is reading-only, your intuition for *what won't work* will be miscalibrated, in a direction that biases you toward repeating exactly the experiments more experienced people would tell you not to run.

The remedy is partly the one I already believe in: replicate, don't just read. When you replicate, the dead ends show up whether anyone wrote them down or not. But replication has limits — you can only run so many failed experiments yourself before the GPUs and the calendar push back. The other half of the remedy is the social one: be in a place where other people's failures are spoken out loud.

## Why CS is less different than I thought

I want to push on the CS-is-different intuition I used to hold, because it has a kernel of truth that hides a larger error. Yes, CS has an open-source culture biology doesn't have. Yes, you can read code that biology can't. But:

1. **Open source is biased toward what worked.** Repos for failed experiments rarely get cleaned up and published. The selection effect is the same one that biases arXiv.
2. **Code without context underspecifies the lesson.** A repo tells you *how* something was implemented. It usually doesn't tell you *why* this version and not the other six.
3. **In ML specifically, the binding constraint is often a non-code one — data, compute, tokenization, schedule, hyperparameters at scale.** None of those are fully captured by the artifact you can read.

So the CS rebuttal I once made — *we have arXiv, we have GitHub* — was answering a different question. It was answering "can I read what's known publicly?" The biology version of the question is "can I learn what's known privately?" On that second question, CS is not as different as I thought.

## What to do about it

A few things that have changed how I work:

- **Choose the lab for the negative-results inheritance, not just the topic.** When picking advisors, collaborators, and projects, ask whose accumulated failure history you most want access to. That's a real, durable benefit, and people underweight it.
- **Replicate to feel the failure modes.** Reading gives you claims; reproducing gives you the mechanism. Very often the mechanism is the failure.
- **Share your negative results when you can.** Internal postmortems, lab Slack threads, blog posts that don't pretend the result was clean. The marginal cost is low and the externality is large.
- **Build infrastructure that captures them.** Experiment trackers, design docs, decision logs. Not for reviewers — for the next person joining the team.
- **Take folklore seriously.** When a senior researcher says "that won't work," resist the urge to discount it because there's no paper to point at. The absence of a paper is *exactly the thing being discussed.*

## The connection to scalable oversight

There is a thread that connects this post to [the formal-methods piece I wrote a few weeks ago](/2026/04/22/formal-methods-scalable-oversight.html). One reason verifiable artifacts — Lean proofs, formal specs, reproducible benchmarks under tight rubrics — matter is that they collapse part of the negative-results gap. If a claim is checkable against a verifier, "this didn't work" is a fact, not a private memory. You can publish failure honestly because the framework lets failure be unambiguous. Most of ML is not in that regime, which is part of why our negative-results problem is worse than mathematics's. But it is a direction. The more we move ML toward verifiable evaluation — and not just leaderboard chasing — the more we make negative results *publishable in a way they currently aren't*.

## Takeaways

- Joining a lab is partly an act of inheriting its negative results. CS is not exempt.
- ML in particular runs on a private corpus of "what didn't work at scale" that is invisible from outside.
- The frontier-lab gap has a negative-results component that compute and data don't fully explain.
- Reading the literature is necessary but systematically biased toward the path that worked. Replicate, join a lab, and verify — those are the corrections.
- Make your own negative results legible when you can. The next person needs them.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026negativeresults,
  author = {Miranda, Brando},
  title  = {What arXiv Misses: Negative Results and the Case for Joining a Lab},
  year   = {2026},
  month  = {May},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/05/04/negative-results-arxiv-misses.html}},
  note   = {Blog post draft}
}
```
