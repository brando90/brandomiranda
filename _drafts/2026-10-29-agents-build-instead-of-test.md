---
layout: post
title: "Before You Build It, Ask If It Should Exist"
date: 2026-10-29
section: meta-research
---

*Brando Miranda — October 2026 · ~3 min read*

**TL;DR.** I noticed that my coding agents lean toward building something big and complicated, and I fell for it myself: I tried to build a complicated endpoint I didn't need, instead of just calling the agent. In research and startups, where almost everything is uncertain, the first question is whether the thing should exist at all, so the default should be the fastest test that answers it. Build big only after that.

---

I noticed something about how agents work, and about how I work with them. I tried to build a complicated endpoint that I didn't need, instead of just calling the agent. The agent was right there. I could have just called it.

It is easy to read that as one bad call. I think it points at something bigger: agents seem biased toward building big, complicated things instead of actually doing the research.

## The bias

For most people that is fine, and often what they want. If you know what you need and you are building a product, a big, careful build is a good outcome.

But I do research, and I work on startup-type problems, and both are high uncertainty. In that regime, why would I build something big and complicated when I don't even know it should exist? That is the question I skipped.

## Why a big build is the wrong first move under uncertainty

This is not a new idea. It is the center of the Lean Startup, Eric Ries's argument that the early job is to learn which thing is worth building rather than to build the thing well. It is the point of Steve Blank's Lean LaunchPad too: before you invest in a product, go and test the assumption it rests on. Michael Bernstein pushes the same instinct in his CS197 course at Stanford, which is where I picked up the word *vectoring*.

I wrote about two halves of this earlier this year. [Vectoring](https://brando90.github.io/brandomiranda/2026/04/16/vectoring-in-research.html) is choosing the riskiest assumption in your project, the one that, if it's false, makes everything downstream pointless. [Velocity](https://brando90.github.io/brandomiranda/2026/04/16/velocity-in-research.html) is answering that question as cheaply and quickly as you can.

What I had not said clearly enough is that the highest-risk direction is not the only thing that matters. Velocity matters too, and with agents in the loop it has to be written down as a default, because left alone they bias toward the big build.

## When velocity wins

There is a trade-off between velocity and vectoring, and I don't want to pretend otherwise. When the test you are running obviously de-risks the main question very well, the bias should be toward velocity: go fast, and name the harness you used, at least roughly.

Fast exploration comes first, though. The first thing to settle is whether the highest-risk piece should exist in the first place, and the quickest test of that comes before any big build.

## The rule

My agents should have had this written down in their rules, and now it is:

- For research and startup work, the default is the fastest test that answers whether the thing should exist. Never a big build first.
- Once that test clearly covers the main risk, go fast, and name the harness roughly.

**TLDR-end:** Agents lean toward building big, complicated things, and so did I. When you don't yet know whether something should exist, run the fastest test that answers that before you build anything big, and once the test clearly covers the main risk, go fast.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026buildorask,
  author = {Miranda, Brando},
  title  = {Before You Build It, Ask If It Should Exist},
  year   = {2026},
  month  = {October},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/10/29/agents-build-instead-of-test.html}},
  note   = {Blog post}
}
```

{% comment %}
Google Doc copy (private): https://docs.google.com/document/d/1XP5qVICnw2tO4-FF5iv_DLFWnzLXVAbW2achxX9jlE0/edit
{% endcomment %}
