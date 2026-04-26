---
layout: post
title: "Models Don't Think Like Me: Why I'm Building a Personal Concept Database"
date: 2026-04-26
---

*Brando Miranda — April 2026*

**Reading time:** ~6 minutes.

**TL;DR.** Frontier models are trained on the average of the internet, which means they explain things the average way — which is rarely the way that works for me. So I'm building one place where I write down the foundational concepts I care about *in the way I actually think about them*. Then I prompt models with that material. The bet: a model conditioned on my idiolect of thinking is more useful to me than a model conditioned on humanity's median explanation. The technical posts on this site (KL divergence, formal verification, etc.) are entries in that database as much as they are blog posts.

## The motivation

Here is the thing I keep noticing when I read explanations of concepts I already understand: most of them are subtly *wrong for me*. Not factually wrong — just shaped wrong. The author chose an analogy I don't find natural, suppressed an asymmetry I think is load-bearing, started from a starting point I would never start from, or skipped over the exact place where my younger self would have gotten stuck. The explanation is fine. It's just not mine.

For a long time I treated this as a quirk. I'd read a textbook chapter, mentally rewrite it in my head, use my version, and move on. It never occurred to me that the *rewriting* was the valuable artifact and the textbook chapter was just the trigger for it.

Then language models showed up, and the situation changed. Suddenly I had a system that could explain almost anything to me on demand — and I noticed that its explanations had the same problem as the textbook's. They were averaged. They were the median of how the internet talks about this concept. They were optimized for a generic reader who doesn't exist, which means they were not optimized for me.

That's when it clicked. I have been doing the rewriting work my whole career. I have just never been *saving it*. If I write down the foundational concepts I care about in the way I actually think about them, in one place, I get a substrate I can do two things with:

1. Read it myself when I need to remind future-me what past-me figured out.
2. Hand it to a model as context, so the model talks to me in *my* dialect of an idea instead of the median dialect.

The second one is the new thing. That's what wasn't possible five years ago.

## Why "the way I think about them" matters

I want to be careful here, because "the way I think about them" can sound like vanity. It isn't. Or at least, it doesn't have to be.

When I say I want a concept explained the way I think about it, I mean something specific. I mean: don't bury the asymmetry I find load-bearing. Don't reach for the analogy I think is misleading. Don't start from notation that obscures the operational meaning. Don't skip the step where the symbols on the page either match or fail to match the picture in my head.

Concretely: the [KL divergence post](https://brando90.github.io/brandomiranda/2026/04/26/kl-divergence-vertical-geometry.html) I wrote up alongside this one spends a thousand words insisting that the geometry of $D_{KL}(p^* \,\|\, \hat{q})$ is *vertical*, not horizontal. Most explanations don't make that distinction at all. They draw two distributions side by side and gesture at "how different they are." That picture is fine for some readers. For me it is actively misleading — it lets you believe the viewpoint distribution could be "to the left of" the goal distribution, which Gibbs forbids. Once I redrew the picture vertically (viewpoint sitting *above* the goal's floor, excess pointing *down*), every downstream thing about KL became cheaper to think about. Forward vs. reverse KL. Cross-entropy as a loss. Why entropy is a floor and not an origin. All of it.

That redrawing was not in the textbook. It was the rewriting work I've been doing in my head for years and never saving. The blog post is me saving it.

## How this changes how I use models

The workflow upgrade is small in code and large in feel.

When I want a model to help me reason about something foundational — say, derive a variational bound, debug an information-theoretic argument, sanity-check a claim about cross-entropy — I no longer want it reasoning from the median internet explanation. I want it reasoning from *my* explanation. So I attach the relevant blog post (or several) as context, and the model's outputs come back in the dialect I'm already thinking in. The asymmetries I care about get respected. The analogies I find misleading don't show up. The picture in the model's "head" matches the picture in mine, because I literally wrote the picture down.

The corollary is that I now treat my technical blog posts differently. They are not just communication artifacts for other people. They are *prompt material* for me. Every fundamental concept I write up in my own voice is a future context window I get to deploy. The audience is partly other readers, and partly future-me-plus-a-model.

This is the same instinct as the [agents-config](https://github.com/brando90/agents-config) project I've been building, just turned in a different direction. agents-config codifies how I want models to *operate* — workflow rules, QA gates, structural conventions. The concept database codifies how I want models to *understand specific ideas*. Same bet, different layer.

## Why I think this is generalizable, but not universal

I don't think everyone needs to do this. A lot of people are well-served by median explanations because they are themselves close to the median, or because the median explanation is good enough for what they need to do. That's fine.

The case for doing it is strongest for two kinds of people. First, people whose internal model of a concept differs noticeably from the standard one — researchers, theorists, people who have spent enough time in an area that they have opinions about how it should be explained. Second, people who use language models for serious work and have noticed that the model's explanations are subtly off from what they actually need. If both of those describe you, building a personal concept database is probably worth your time. If neither does, it probably isn't, and that's fine.

For me, both describe me, which is why I'm doing it.

## What this site is becoming

If you've been reading this blog, you've already seen the shift. The technical posts are getting more foundational and more first-principles — KL divergence today, probably entropy and mutual information next, eventually the formal verification stack I work in daily. The non-technical posts (this one, [the dual TLDR post](https://brando90.github.io/brandomiranda/2026/04/16/dual-tldr-top-and-end.html), the [correctness-gated workflow post](https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html)) are about the *system* that makes the technical posts useful — how I write them, why I write them, how I use them with models.

The two halves are the same project. The technical posts are the database entries. This post is the README that says why the database exists.

If you find the technical posts overkill — too much spent on a definition you already understand — that's actually the signal that I'm writing them for the right person. The right person is not necessarily you. It is the version of me that needs to think about this concept three years from now, with a model in the loop, in a dialect we both already share.

---

*Companion technical post: [KL Divergence Has Vertical Geometry: A Unified Grammar with Euclidean Distance](https://brando90.github.io/brandomiranda/2026/04/26/kl-divergence-vertical-geometry.html).*

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026personalconceptdb,
  author = {Miranda, Brando},
  title  = {Models Don't Think Like Me: Why I'm Building a Personal Concept Database},
  year   = {2026},
  month  = {April},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/04/26/personal-concept-database.html}},
  note   = {Blog post}
}
```
