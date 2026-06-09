---
layout: post
title: "Autoregressive Models + LLMs Exponential Error-Compounding Argument — Is It Real or Fiction?"
date: 2026-05-26
section: ml
---

*Brando Miranda — May 2026 · ~3 min read*

**TL;DR.** The **Exponential Error Compounding Argument** against autoregressive language models says that if each generated token has an independent unrecoverable error probability $e$, then the chance of producing a fully correct length-$T_y$ object is $(1 - e)^{T_y}$ — which goes to zero exponentially fast in $T_y$. This post asks whether real verifier-guided systems actually behave like that. The algebra is fine. The empirical question is whether the **independence + unrecoverable** assumption survives in trained, verifier-guided AR systems. If a recoverable-error model fits the data better than $(1 - e)^{T_y}$, the argument is not false algebraically; it is false as a model of the system we actually run.

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

## Appendix A — Notation

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

## References

- [Yann LeCun. *A Path Towards Autonomous Machine Intelligence*. OpenReview, 2022.](https://openreview.net/pdf?id=BZ5a1r-kVsf)
- [Yann LeCun, Sumit Chopra, Raia Hadsell, Marc'Aurelio Ranzato, and Fu Jie Huang. *A Tutorial on Energy-Based Learning*. In *Predicting Structured Data*. MIT Press, 2006.](https://yann.lecun.org/exdb/publis/pdf/lecun-06.pdf)
- [Zhilin Yang, Zihang Dai, Ruslan Salakhutdinov, and William W. Cohen. *Breaking the Softmax Bottleneck: A High-Rank RNN Language Model*. arXiv:1711.03953, 2017.](https://arxiv.org/abs/1711.03953)

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
