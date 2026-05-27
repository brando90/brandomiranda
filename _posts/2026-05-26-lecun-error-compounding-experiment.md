---
layout: post
title: "Testing LeCun's Error-Compounding Argument"
date: 2026-05-26
---

*Brando Miranda — May 2026 · ~5 min read*

**TL;DR.** **[In development — not fully finished. Published as a work-in-progress while the experiment runs; numbers, plots, and conclusions may change as Stages 2–3 (VeriBench / the key test) complete.]** LeCun's critique of autoregressive language models says that if each generated token has an independent unrecoverable error probability `e`, then the chance of producing a fully correct length-`T` object is `(1 - e)^T`. This experiment asks whether real verifier-guided systems actually behave like that. The plan is to start with toy controls where the geometric curve must appear, then move to VeriBench/Lean where a hard verifier can reject, backtrack, and resample. If a recoverable-error model fits better than `(1 - e)^T`, the argument is not false algebraically; it is false as a model of the system we actually run.

---

The equation is easy:

```text
P(success at length T) = (1 - e)^T
```

The hard part is deciding whether this equation describes autoregressive agents
rather than just a simplified blind rollout.

This experiment lives in:

```text
experiments/02_ar_pros_cons
```

The hypothesis under test is not "are language models good?" It is sharper:

```text
Do autoregressive model-plus-verifier systems behave like independent
unrecoverable error processes?
```

## Stage 1: Toy Controls

The toy script makes the assumptions visible:

```bash
cd experiments/02_ar_pros_cons
python toy/toy_error_process.py
```

It compares:

| Process | What it tests |
|---|---|
| blind AR rollout | the exact LeCun premise: independent unrecoverable errors |
| verifier resampling | a checker rejects bad local moves before they survive |
| recoverable process | the trajectory can leave and return to a valid state |

The blind rollout should match `(1 - e)^T`. If it does not, the toy is broken.
The verifier and recoverable versions should deviate from the geometric curve.
That deviation is the entire point.

## Stage 2: VeriBench Split

The real-data setup starts from the local VeriBench checkout:

```bash
python -m data.setup --smoke
python -m data.setup --include-generated-agents
```

This writes deterministic train/val/test JSONL manifests under:

```text
data/splits/
```

Splits are task-level, not file-level, so generated variants of the same task do
not leak across train, validation, and test. Each row records the Lean path,
family, theorem count, `sorry` count, a tactic-count proxy, and source metadata.

## Stage 3: The Key Test

For VeriBench, the important outcome is not raw token mismatch. It is verifier
survival:

```text
P(a consequential error survives checking, recovery, and resampling)
```

Probe 06 fits three models to success-vs-length curves:

1. geometric `(1 - e)^T`;
2. constant pass probability;
3. recoverable Markov process with a nonzero recovery probability.

The result I expect is that the recoverable model beats the geometric model in
the verifier setting. If that happens, LeCun's argument remains a useful warning
about blind rollout, but not a doom theorem for AR systems with hard feedback.

## What Would Change My Mind

If VeriBench pass probability decays geometrically with proof/program length even
after verifier-guided retries, then the critique bites hard. It would mean our
feedback loop is not changing the effective error process enough.

If the geometric model only fits blind sampling while the recoverable model fits
verifier-guided systems, then the core research question changes:

```text
How do we design feedback loops that change the exponent?
```

That is the experiment I want this folder to make concrete.
