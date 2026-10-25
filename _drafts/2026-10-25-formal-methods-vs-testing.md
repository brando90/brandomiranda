---
layout: post
title: "Cheaper Proofs, Cheaper Tests: Is Formal Methods a Big Business?"
date: 2026-10-25
section: ml
---

*Brando Miranda — October 2026 · ~5 min read*

**TL;DR.** Agents are making proofs cheaper, so it's tempting to bet that formal methods is about to become a big business. I'm skeptical, for two reasons. The same agents make testing cheaper too, and property-based tests get you most of the way to "this holds over an infinite set". And a proof only guarantees the theorems you wrote down; nobody can hand you an exhaustive, correct list of them, so proofs don't make bugs impossible. Which one wins in practice is an empirical question, and my current guess is that it doesn't make a business bigger than AGI.

---

Here is the hypothesis I keep coming back to: formal methods is not an easy thing to monetize, at least not compared to AGI. I want to lay out why, because the argument is as much technical as commercial.

## Agents make proofs cheaper, and tests cheaper too

It's true that agents make attacking software easier, and it's true that they're getting good at writing proofs. If you stop there, the conclusion writes itself: proofs get cheap, verified software becomes the default, and a lot of value moves to whoever sells it.

But look at what else gets cheaper. The same agents write tests, write test generators, and run far more of them than a person would. So the real comparison is not "proofs, now affordable" against "testing, as expensive as it was in 2020". It is proofs getting cheaper against testing getting cheaper.

The main selling point of a proof is that it covers an infinite set of inputs at once. Property-based testing does something close to that: you state a property, a generator samples inputs from the infinite domain, and you check the property on all of them. If sampling gets cheap enough, then for all practical purposes the two might be the same. I want to be careful with that "might". Sampling gives you evidence and a proof gives you certainty, and a bug that lives on a vanishing fraction of inputs can slip past any generator. But how much that gap matters in practice is a question about costs and bug distributions, not about principle.

## Testing can't cover everything, but neither can proving

The standard objection is that it's impossible to cover all test cases with testing, and for an infinite domain that's true. The claimed solution is proofs. Here is the part I think people don't say often enough (and that belongs in the limitations section of every formal-methods paper, mine included): for a proof to rule out bugs, you need a set of theorems that is both *sound* and *exhaustive*. Lean will check each proof you give it. It will not tell you whether you stated the right theorems, or enough of them.

So where does the list of theorems come from? From a human's intent, translated into a formal statement by a person or a model, with no mechanical way to certify that the translation captured everything you care about. A missing theorem is a bug the proof will never find. A subtly wrong one, say a statement that is vacuously true, gives you a proof of the wrong thing and a false sense of safety.

This is not a limitation of Lean, or of any particular tool, and a newer proof system doesn't escape it. It comes from the nature of the problem, and it lines up with the classical limits of logic and computation. Rice's theorem says that no general procedure can decide any non-trivial behavioral property of programs. Gödel's incompleteness theorem says that any consistent formal system strong enough to talk about arithmetic has true statements it cannot prove. Neither theorem says you can never verify a particular program against a particular specification. People do exactly that, for example for operating system kernels and compilers. What they say is that there is no general recipe that takes your program and certifies it free of bugs for everything you might care about, and that every verified result is relative to a specification and a trusted base (the proof checker, the compiler, the hardware, and the spec itself).

So the benefit people attribute to formal methods, that bugs become impossible, is not something proofs deliver by themselves. The bugs move: from the code to the list of properties.

## So it's an empirical question

Put the two sides together and you get an empirical question, not a theorem. How often do agent-written tests miss a bug that a proof would have caught, and at what cost? How often does verified code still fail because the specification had a hole? Whether formal methods is useful, and therefore whether there is a business in it, depends on those numbers, and I don't think anyone has them yet.

## Why that makes me cool on it as a business

My current hypothesis is that formal methods cannot become a business larger than AGI. If the goal is impact, which is mine, the cost-benefit tradeoff points elsewhere: toward making the models and agents themselves better, rather than toward tools that check their output after the fact. That is part of why my own work is leaning toward reinforcement learning for code.

I don't think formal methods is worthless commercially. Some people and organizations feel safer with proofs in specific applications, even in cases where good tests would have been enough, and that is a real market. As one bet inside a diversified portfolio it's a reasonable risk. But I don't think it becomes the next OpenAI or Google.

That's my view today, and I'm happy to be shown wrong by data. If you have a head-to-head comparison of agent-written tests against agent-written proofs, bugs caught per dollar, I'd love to see it.

**TLDR-end:** Cheaper proofs come bundled with cheaper tests, and property-based tests approximate proofs over infinite sets. Proofs don't remove the need to write down the right properties, so they shift bugs rather than eliminate them. Whether that adds up to a big business is empirical, and my guess is not bigger than AGI.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026proofstests,
  author = {Miranda, Brando},
  title  = {Cheaper Proofs, Cheaper Tests: Is Formal Methods a Big Business?},
  year   = {2026},
  month  = {October},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/10/25/formal-methods-vs-testing.html}},
  note   = {Blog post}
}
```
