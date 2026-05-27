---
layout: post
title: "Autoregressive Models + LLMs Exponential Error-Compounding Argument — Is It Real or Fiction?"
date: 2026-05-26
---

*Brando Miranda — May 2026 · ~5 min read*

**TL;DR.** **[In development — not fully finished. Published as a work-in-progress while the experiment runs; the toy + VeriBench implementation lives in the appendix as a TODO.]** The **Exponential Error Compounding Argument** against autoregressive language models says that if each generated token has an independent unrecoverable error probability $e$, then the chance of producing a fully correct length-$T_y$ object is $(1 - e)^{T_y}$ — which goes to zero exponentially fast in $T_y$. This post asks whether real verifier-guided systems actually behave like that. The algebra is fine. The empirical question is whether the **independence + unrecoverable** assumption survives in trained, verifier-guided AR systems. If a recoverable-error model fits the data better than $(1 - e)^{T_y}$, the argument is not false algebraically; it is false as a model of the system we actually run.

---

## The argument has a name

The headline objection to autoregressive language models — *"errors compound, so long-form generation collapses"* — has a name worth keeping. Call it the **Exponential Error Compounding Argument**. The most-cited articulation is in [Yann LeCun, *A Path Towards Autonomous Machine Intelligence* (2022)](https://openreview.net/pdf?id=BZ5a1r-kVsf); the same shape appears in classical EBM writeups such as [LeCun et al., *A Tutorial on Energy-Based Learning* (2006)](https://yann.lecun.org/exdb/publis/pdf/lecun-06.pdf). The equation is one line:

$$
P(\text{success at length } T_y) \;=\; (1 - e)^{T_y} \;=\; \exp\!\bigl(T_y \log(1 - e)\bigr).
$$

where $T_y$ is the **output** sequence length the model is asked to generate (the prompt length $T_x$ is a separate variable that does *not* appear in the exponent). The exponential form makes the decay rate explicit: for small $e$, the half-life in $T_y$ is roughly $\log 2 / e$. At $e = 1\%$ that is about $70$ tokens; at $e = 0.1\%$ it is about $700$. Either way, the bound says that fully correct long-form generation is asymptotically impossible.

The hard part is deciding whether this equation describes autoregressive agents we actually deploy — or just a simplified blind rollout.

## The assumptions are the experiment

The bound is mathematically valid. What is contestable is the *error model* it assumes:

- Per-token error probability $e$ is **constant** across positions.
- Per-token errors are **independent**.
- Errors are **unrecoverable** — once a step is wrong, the trajectory stays off-manifold.

Drop any of these and the geometric curve loosens — often dramatically. A handwritten note I keep going back to phrases this exactly:

> *"If independence is true, this example shows — as $T_y$ gets large — is an upper bound to LeCun (but we can prob fix that)."*

That is the hinge. The point of this experiment is not to argue with $(1 - e)^{T_y}$; it is to measure whether the assumptions feeding it survive a hard verifier and a real trained model. The hypothesis under test is sharper than "are LLMs good?":

> *Do autoregressive model-plus-verifier systems behave like independent unrecoverable error processes?*

If a **recoverable-Markov** process — a 2-state chain $\{\text{on-manifold},\ \text{off-manifold}\}$ with a nonzero per-step recovery probability — fits success-vs-length curves better than the geometric model, then the right contrast is *not* AR vs. EBM. It is **AR-without-verifier vs. AR-with-verifier** (recovery changes the exponent). That is a different research program from "abandon autoregressive models."

---

## Appendix A — TODO: Implementation Plan (toy controls + VeriBench)

*This appendix records the staged plan the experiment will execute. It is **not yet done** — treat each stage as a TODO. Probe 06 in [`PROBE_SPECS.md`](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/PROBE_SPECS.md) is the canonical spec; this is the blog-side mirror.*

### Stage 1 (TODO): Toy Controls

The toy script makes the assumptions visible:

```bash
cd experiments/02_ar_pros_cons
python toy/toy_error_process.py
```

It compares three processes:

| Process | What it tests |
|---|---|
| blind AR rollout | the exact premise: independent unrecoverable errors |
| verifier resampling | a checker rejects bad local moves before they survive |
| recoverable process | the trajectory can leave and return to a valid state |

The blind rollout should match $(1 - e)^{T_y}$. If it does not, the toy is broken. The verifier and recoverable versions should deviate from the geometric curve. That deviation is the entire point.

### Stage 2 (TODO): VeriBench Split

The real-data setup starts from the local VeriBench checkout:

```bash
python -m data.setup --smoke
python -m data.setup --include-generated-agents
```

This writes deterministic train/val/test JSONL manifests under:

```text
data/splits/
```

Splits are task-level, not file-level, so generated variants of the same task do not leak across train, validation, and test. Each row records the Lean path, family, theorem count, `sorry` count, a tactic-count proxy, and source metadata.

### Stage 3 (TODO): The Key Test

For VeriBench, the important outcome is not raw token mismatch. It is verifier survival:

$$
P(\text{a consequential error survives checking, recovery, and resampling}).
$$

Probe 06 fits three models to success-vs-length curves:

1. geometric $(1 - e)^{T_y}$;
2. constant pass probability $p$;
3. recoverable Markov process with a nonzero recovery probability.

Compare by held-out log-likelihood / AIC with bootstrap CIs. The expected outcome is that the recoverable model beats the geometric model in the verifier setting — that is the "real or fiction" verdict for the Exponential Error Compounding Argument as applied to verifier-guided AR systems.

---

## Appendix B — Notation

| Symbol | Meaning |
|---|---|
| $T_y$ | Length of the **output** sequence the AR model generates (proof steps, code tokens, words, tactics). The exponent in $(1 - e)^{T_y}$ is this $T_y$. |
| $T_x$ | Length of the **input** / prompt the model conditions on. Not the primary axis of the error-compounding claim — included for symmetry; the model conditions on $T_x$ context tokens to produce $T_y$ output tokens. |
| $e$ | Per-step "unrecoverable error" probability under the geometric model: assumed independent across steps and never repaired. |
| $(1 - e)^{T_y}$ | The geometric prediction: probability that all $T_y$ output steps are simultaneously correct under the independent-unrecoverable error model. Equivalently $\exp\bigl(T_y \log(1 - e)\bigr)$. |
| $p$ | Constant pass probability — the trivial baseline that ignores length entirely. |
| recoverable-Markov | A 2-state chain $\{\text{on-manifold},\ \text{off-manifold}\}$ with a nonzero per-step recovery probability; the alternative to "errors are unrecoverable." |
| AR | Autoregressive: the factorization $p(x_{1:T_y}) = \prod_{t} p(x_t \mid x_{<t})$. |
| EBM | Energy-based model: scores configurations with $E_\theta(x)$ and normalizer $Z_\theta = \sum_x \exp(-E_\theta(x))$. |
| verifier | A hard checker (e.g., the Lean type-checker) that returns *valid / invalid* on a generated step or object, enabling recovery via backtrack / resample. |

---

## Appendix C — Draft: What Would Change My Mind (needs author review)

*This section is parked here because the author isn't sure he stands behind the phrasing yet — flagged as a draft decision rule to revisit, not a committed claim.*

If verifier-guided pass probability decays geometrically with proof/program length even after recovery, then the critique bites hard. It would mean the feedback loop is not changing the effective error process enough — and we owe a serious rethink of how recovery is structured.

If the geometric model only fits blind sampling while the recoverable model fits verifier-guided systems, then the core research question changes:

> *How do we design feedback loops that change the exponent?*

That is the experiment this folder is built to make concrete.

---

## Source Notes & References

The experiment plan, probes, and source notes for this post live in the `free-energy` experiment folder:

- [Experiment folder (`02_ar_pros_cons`)](https://github.com/brando90/free-energy/tree/main/experiments/02_ar_pros_cons)
- [Claims under test](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/CLAIMS.md) (Claim 6 is the Exponential Error Compounding Argument)
- [Probe specifications](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/PROBE_SPECS.md) (Probe 06 is the $(1-\varepsilon)^{T_y}$ test)
- [Living findings log](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/FINDINGS.md)
- [Handwritten note: the Exponential Error Compounding Argument](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/assets/handwritten_ar_pros_cons_lecun_argument.md) (transcription + image)
- [Personal notes & slides on the Exponential Error Compounding Argument (Google Doc)](https://docs.google.com/document/d/1LUfRZdK0pPhMVQTHqjy_DXdAKQWQO67fR142NSimuqg/edit?usp=sharing) — slides and personal notes generated with Claude from the handwritten page above.
- Sibling blog draft: [*Autoregressive models: pros, cons, and where EBMs fit*](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/blog/2026-05-24-autoregressive-models-pros-cons.md)

Primary technical references:

- [Yann LeCun, *A Path Towards Autonomous Machine Intelligence* (2022)](https://openreview.net/pdf?id=BZ5a1r-kVsf) — the position paper that articulates the $(1 - \varepsilon)^{T_y}$ critique of autoregressive generation and motivates EBM/JEPA alternatives.
- [LeCun, Chopra, Hadsell, Ranzato, Huang, *A Tutorial on Energy-Based Learning* (2006)](https://yann.lecun.org/exdb/publis/pdf/lecun-06.pdf) — the canonical EBM reference, including the partition-function machinery the alternative model has to deal with.
- [Yang et al., *Breaking the Softmax Bottleneck* (2017)](https://arxiv.org/abs/1711.03953) — relevant to the separate but related question of whether the AR output head, not the factorization, is what limits expressiveness.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026arerrorcompounding,
  author = {Miranda, Brando},
  title  = {Autoregressive Models + LLMs Exponential Error-Compounding Argument --- Is It Real or Fiction?},
  year   = {2026},
  month  = {May},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/05/26/ar-error-compounding-real-or-fiction.html}},
  note   = {Blog post}
}
```
