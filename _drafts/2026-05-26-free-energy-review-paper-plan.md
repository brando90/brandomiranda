---
layout: post
title: "A Review Paper Plan for Free Energy and Autoregressive Models"
date: 2026-05-26
---

*Brando Miranda — May 2026 · ~6 min read*

**TL;DR.** The Free Energy review paper should not start from the slogan that autoregressive LLMs are doomed. It should start from a cleaner audit: which parts of the AR/softmax/MLE stack are genuine advantages, which objections have theorem-level or empirical support, and which alternatives actually address those objections rather than moving the same difficulty elsewhere. The first empirical chapter is a claim-by-claim test on toy controls, VeriBench/Lean, and MNIST; EBMs, JEPA, diffusion, SSMs, and verifier-guided AR systems are then compared by where they put the hard part.

---

The review paper needs a stricter frame than "LLMs versus EBMs."

The autoregressive factorization

```text
p(x) = product_t p(x_t | x_<t)
```

is an exact chain-rule identity. It is not the part of the stack that loses
representational power. The real questions are downstream of that identity:

1. What does the softmax parameterization make easy or impossible?
2. What does maximum likelihood reward?
3. What does left-to-right inference prevent or make awkward?
4. Which failures remain after adding tools, search, and verifiers?
5. Which alternative architectures address those failures directly?

That is the review paper's organizing principle.

## Chapter 1: the honest audit of AR LLMs

The first chapter should concede the real strengths:

- exact likelihood;
- dense per-token supervision;
- parallel teacher-forced training;
- streaming generation;
- mature kernels, hardware, and serving infrastructure.

Then it should separate the objections by layer.

The softmax bottleneck is a parameterization theorem. Mode-covering is an
objective-level fact about forward KL. Rank collapse is a theorem for pure
attention, with residuals and MLPs acting as possible maskers. LeCun's
`(1-e)^T` argument is different: the algebra is true, but its force depends on
independent, constant-rate, unrecoverable errors. A Lean verifier is exactly the
kind of system component that can break unrecoverability.

So the paper should not simply repeat LeCun's claim. It should test it.

## Chapter 2: experiments before architecture replacement

The companion experiment suite starts with three empirical tiers.

First, toy controls. A blind independent-error rollout should follow the
geometric curve. If it does not, the probe is broken. A recoverable-error process
and a verifier-resampling process should not follow the same curve. That contrast
turns the slogan into a falsifiable model.

Second, VeriBench. Lean gives a hard checker, so "correct" is not a soft semantic
judgment. The key curve is success versus proof/program length under blind
sampling, retry, verifier feedback, and later trained verifier-aware systems. If
success decays geometrically even after verifier-guided recovery, LeCun's
argument bites. If a recoverable Markov model fits better, then the doom argument
is the wrong model of the system we actually run.

Third, MNIST. It is not the final vision benchmark, but it is a clean first
vision domain for order effects. Treat images as sequences under raster and
shuffled orderings, compare AR reconstruction to masked/iterative and
energy-scoring baselines, and ask whether local prediction creates measurable
global-validity failures.

## Chapter 3: alternatives as relocated costs

EBMs are attractive because they score whole configurations:

```text
p_theta(x) proportional_to exp(-E_theta(x))
```

But the partition function is the cost:

```text
Z_theta = sum_{x in V^T} exp(-E_theta(x))
```

for discrete sequences, or a high-dimensional integral for continuous
embeddings. AR models avoid this by paying local normalizers repeatedly; EBMs
avoid local commitment but inherit hard training and sampling.

JEPA moves prediction into representation space. Diffusion replaces one-shot
generation with iterative denoising. SSMs remove the attention softmax but pay
with fixed-state memory limits. Verifier-guided AR keeps the language model but
adds rejection, search, and external correctness feedback.

The review paper should compare these alternatives with one question:

```text
Which AR/LLM con does this address, and where does the hard part move?
```

That keeps the paper from becoming a list of architectures.

## The near-term deliverable

The first real result should be the LeCun test:

```text
toy controls -> VeriBench splits -> success-vs-length model comparison
```

The expected result is not guaranteed. That is why it is an experiment. But the
paper becomes much stronger if it can say:

```text
Here is the theorem-like argument, here are its assumptions, here is the toy
case where it holds, and here is what happens in a verifier-backed domain.
```

That is the standard the rest of the review should follow.
