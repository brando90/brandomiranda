---
layout: post
title: "Judge the Spec, Not the Proof: Why Proof-Grading Benchmarks Measure the Wrong Thing"
date: 2026-06-18
section: ml
---

*Brando Miranda — June 2026 · ~3 min read*

**TL;DR.** If a proof can be formalized, you don't need a judge for it — [Lean](https://lean-lang.org) checks it deterministically and for free. The only part that genuinely needs a judge is the part Lean *can't* check: whether the formal theorem is the theorem you actually meant. So benchmarks that grade natural-language proofs are measuring the one thing we're about to stop needing, and skipping the one thing we can't avoid.

---

There's a growing line of work on "LLM-as-a-judge" for mathematics. The most recent entry I've seen is [QEDBench](https://arxiv.org/abs/2602.20629), a genuinely careful benchmark that spends 1,000+ hours of PhD-level grading to measure how reliably frontier models grade university-level *natural-language* proofs. The findings are about what you'd expect, and worth having written down: the judges are lenient, they reward authoritative-looking LaTeX over actual correctness, and prompting doesn't fix it.

I don't want to argue with the execution. I want to argue with the premise. Here's my position, in four steps.

**1. Natural-language proofs don't need to be judged.** The entire reason we reach for an LLM judge is that a human can't audit a long argument line by line. But in mathematics, that's a *solved problem* — the moment the argument is formal.

**2. The catch is autoformalization — but only of the statement.** If we can translate the informal theorem into a faithful formal theorem, we're done with the hard part. Writing the *proof*, given the statement and an agent with tactics, is the tractable end. Writing the *statement* is the bottleneck.

**3. Then the hard reasoning goes 100% to Lean.** This is the whole argument of [an earlier post](https://cs.stanford.edu/people/brando9/2026/04/22/formal-methods-scalable-oversight.html): the kernel checks the proof, deterministically, with no human and no 1,000 hours. It isn't another model's opinion you have to trust — it's a training-independent oracle. Consensus among judges can be confidently wrong together; the kernel can't.

**4. Which leaves a judge exactly one job: did the model ask the right question?** Is the formal spec faithful to what we meant, and can the model translate between the informal and the formal? A wrong statement with a valid proof is worse than no proof at all — and *that* gap has no formal oracle. That, and only that, is where a judge is irreducible.

So when I read a benchmark that grades natural-language proofs, my honest reaction is: you've built a benchmark whose central object — *is this proof correct* — is exactly the part Lean does for free, and you've skipped the part that actually needs judging — *is this the right theorem*. QEDBench even names Lean once, in passing, as the formal route it declines on annotation-cost grounds. That decision is precisely what traps the whole effort in proof-grading and hides the measurement that matters.

The constructive version of this complaint is [VeriBench](https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/), where the headline number isn't "can a judge grade a proof" but "can an agent produce a formal theorem that actually covers the obligations." Right now the answer is mostly no. *That* is the gap worth measuring, and it's the one a judge can't be cut out of.

None of this removes the human, or the judge. It relocates them — to the short, semantically loaded end of the argument: the statement, the definitions, the assumptions. Deciding what to ask may be the part we can't outsource. Everything downstream of a faithful spec, we can.

---

## Discuss

I'll share this on X — replies, disagreements, and pointers welcome.

<!-- TODO: once posted on X, mirror the predecessor's Discuss format, e.g.: I shared this post on X/Twitter here: [discussion thread](https://x.com/BrandoHablando/status/...). -->

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026judgespec,
  author = {Miranda, Brando},
  title  = {Judge the Spec, Not the Proof: Why Proof-Grading Benchmarks Measure the Wrong Thing},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/06/18/judge-the-spec-not-the-proof.html}},
  note   = {Blog post}
}
```
