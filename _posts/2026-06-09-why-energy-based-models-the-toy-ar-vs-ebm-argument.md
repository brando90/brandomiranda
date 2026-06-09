---
layout: post
title: "Why Energy-Based Models? The Toy AR-vs-EBM Argument"
date: 2026-06-09
section: ml
---

*Brando Miranda — June 2026 · ~6 min read*

**Warning: this post is a draft — content may change and errors may remain.**

**TL;DR.** Autoregressive models and sequence-level energy-based models owe the *same* debt — the partition function $Z$ — on different payment plans. AR pays $Z$ in $T_x$ installments of $O(V)$ each (one softmax per token); a sequence-level EBM owes one balloon payment of $O(V^{T_x})$ (a single normalization over *all* sequences). The installment plan is exactly what makes AR cheap, and the per-token factorization it requires is exactly what the error-compounding critique attacks. This post is the toy version of that tradeoff I use to explain why EBMs exist at all — plus my hypothesis for why AR works in practice anyway (frontier labs buy the error rate down with scale), and what that implies an academic lab should do instead.

---

## The autoregressive contract

An autoregressive (AR) model commits to the factorization

$$p_\theta(x) \;=\; \prod_{t=1}^{T_x} p_\theta\!\left(x^{<t>} \,\middle|\, x^{<1:t-1>}\right),$$

where $$x = (x^{<1>}, \dots, x^{<T_x>})$$ is a sequence over a vocabulary $X = \{x_1, \dots, x_V\}$ with $|X| = V$. Each conditional is a softmax:

$$p_\theta\!\left(x^{<t>} = v \,\middle|\, x^{<1:t-1>}\right) \;=\; \frac{e^{f_\theta(v;\, x^{<1:t-1>})}}{Z_\theta\!\left(x^{<1:t-1>}\right)},
\qquad
Z_\theta\!\left(x^{<1:t-1>}\right) \;=\; \sum_{v' \in X} e^{f_\theta(v';\, x^{<1:t-1>})}.$$

Concretely, the model's head emits a length-$V$ vector

$$\left[\; \frac{e^{f(v_1)}}{Z_\theta},\; \frac{e^{f(v_2)}}{Z_\theta},\; \dots,\; \frac{e^{f(v_V)}}{Z_\theta} \;\right],$$

and the normalizer $Z_\theta$ is a sum of $V$ terms. Computing this vector — and its $Z$ — costs $O(V)$ per step (suppressing hidden-dimension factors). Run it for the whole sequence and you pay

$$O(V \cdot T_x).$$

The thing that makes AR cheap is worth saying out loud: **the normalization axis is always a single token slot.** You never normalize over sequences — only over the alphabet, one position at a time.

## The energy-based contract

An energy-based model (EBM) drops the normalization requirement from the model class. You learn an *energy function*

$$E_\theta : X^{T_x} \to \mathbb{R}$$

— one scalar for the **whole sequence**. (I'd rather call $-E_\theta$ a *confidence score*; the physics name stuck, so energy it is.) For example, $x = [\text{"the"}, \text{"hat"}, \text{"hi"}, \dots]$ and $-E_\theta(x) = 0.3$. Any neural network is a legal $E_\theta$ — a two-layer MLP $-E_\theta(x) = \sigma\!\left(x^\top W^{(1)}\right) W^{(2)}$, or a full transformer. The EBM question is orthogonal to the architecture question.

Crucially, $-E_\theta(x)$ is **not a probability**. It tells you how confident the model is about $x$, with no promise that confidences sum to anything. If you insist on probabilities, you must normalize:

$$p_\theta(x) \;=\; \frac{e^{-E_\theta(x)}}{Z_\theta},
\qquad
Z_\theta \;=\; \sum_{\tilde{x} \,\in\, X^{T_x}} e^{-E_\theta(\tilde{x})}.$$

That sum runs over **every possible sequence**: $V^{T_x}$ terms. The cost is

$$O\!\left(V^{T_x}\right),$$

which is not "expensive." It is intractable, full stop.

## Same debt, different payment plans

| | normalization axis | when you pay | total cost of $Z$ |
|---|---|---|---|
| AR | the vocabulary, one slot at a time | every token | $O(V \cdot T_x)$ |
| sequence EBM | all of $X^{T_x}$, at once | once (if ever) | $O(V^{T_x})$ |

Both model classes write down $e^{\text{score}}/Z$. Neither escapes $Z$; they *defer* it differently. AR's softmax is a clever payment plan, not an exemption — a point I'll keep returning to in this series, because nearly every proposed "alternative to softmax" turns out to relocate $Z$ rather than eliminate it.

## Then why would anyone sign the expensive contract?

Because the installment plan has a hidden fee. The headline objection to AR — the [**Exponential Error Compounding Argument**](https://cs.stanford.edu/people/brando9/2026/05/26/ar-error-compounding-real-or-fiction.html) (LeCun, 2022) — goes: if each generated token independently steps off the "correct manifold" with probability $\varepsilon$, and errors are unrecoverable, then

$$\Pr\!\left[\, x^{<t>} \in \text{correct},\ \forall\, t \le T_x \,\right] \;\approx\; (1-\varepsilon)^{T_x} \;\longrightarrow\; 0$$

exponentially fast in the length of the generated object. Notice what is being blamed: the **per-token factorization** — the very design choice that made AR's $Z$ cheap. The model commits to one token at a time and, in the blind-rollout picture, never gets to revise.

A sequence-level EBM does not factorize over time. Its type signature, $X^{T_x} \to \mathbb{R}$, judges the *whole object at once*. There is no per-step commitment to compound — by construction. So the toy tradeoff is:

> **AR:** linear-cost normalization, exposure to compounding.
> **EBM:** holistic judgment, an intractable $Z$.

One more reason this framing matters to me specifically: the Lean kernel is a hand-built energy function. It maps a whole candidate proof to $\{\text{valid}, \text{invalid}\}$ — an energy of $\{0, \infty\}$ if you like. Judging complete objects rather than keystrokes is the *native* mode of formal verification, which is a large part of why Lean is my testbed for this program.

## Fine print: is the compounding argument actually true?

The algebra is one line and it is fine. The contestable part is the error model: constant $\varepsilon$, independent across steps, unrecoverable. I wrote a separate post on exactly this — [*AR Error Compounding — Real or Fiction?*](https://cs.stanford.edu/people/brando9/2026/05/26/ar-error-compounding-real-or-fiction.html) — whose punchline is that under a hard verifier with recovery (backtrack/resample), a recoverable-Markov error process can fit reality far better than the geometric one, and the right contrast becomes *AR-without-verifier vs. AR-with-verifier* rather than *AR vs. EBM*. Empirically, what does collapse with problem size is compositional depth, not raw token count (Dziri et al., 2023).

So, to be precise: treat $(1-\varepsilon)^{T_x}$ as a **motivation, not a theorem**. The error-compounding axis and the partition-function axis are *independent* claims, and conflating them is the most common confusion I see in EBM discussions. The deeper pro-EBM case lives elsewhere — inference as energy minimization against a verifier, energies composing additively, $Z$ canceling in energy *differences* — and deserves its own post.

## My hypothesis: frontier labs buy $\varepsilon$ down with scale

Here is the hypothesis I find most plausible for why AR systems work in practice despite the compounding story. Frontier labs drive $\varepsilon$ down by brute force — more data, *higher-quality* data, more compute, heavy post-training — until the usable horizon ($\sim 1/\varepsilon$ tokens) exceeds the trajectory lengths users actually need. The circumstantial evidence: in 2022 a human had to babysit essentially every model step; in 2026, multi-step agentic trajectories are routine. Nothing about the architecture changed in kind. $\varepsilon$ changed.

Two consequences for an academic lab:

1. **We cannot compete on $\varepsilon$-suppression-by-scale.** That game is won with data and dollars we don't have.
2. **The interesting question is at fixed resources.** Same model size, same data, same compute: does the EBM contract buy a better error-vs-compute frontier than the AR contract — or at minimum, a clean scientific account of the pros and cons?

And one strategic corollary: since pretrained open-weight LLMs already embody billions of dollars of $\varepsilon$-suppression, the rational first move is not to train an EBM from scratch. It is to **convert a pretrained LLM into an EBM** — keep the digested data, change the contract. That conversion problem (call it grafting) is where my group is starting.

## The catch, and the next post

To run the fixed-resources comparison we have to *train* the EBM, and the obvious objective — maximum likelihood — needs $\log Z_\theta$, the $V^{T_x}$-term monster. The escape hatch is one of my favorite observations in machine learning: $Z_\theta$ does not depend on the $x$ you evaluate at, so differentiating with respect to the **input** kills it. Building a training principle out of that observation is called **score matching**, and it's the subject of the [next post](https://cs.stanford.edu/people/brando9/2026/06/09/score-matching-training-ebms-without-z.html).

---

## Appendix A — Notation

| Symbol | Meaning |
| --- | --- |
| $X$ | The vocabulary (alphabet) $\{x_1, \dots, x_V\}$; $V = \lvert X \rvert$. |
| $x$, $$x^{<t>}$$ | A sequence $x \in X^{T_x}$ and its token at position $t$. |
| $T_x$ | Length of the modeled object $x$ (unconditional setting). In the conditional setting of [the error-compounding post](https://cs.stanford.edu/people/brando9/2026/05/26/ar-error-compounding-real-or-fiction.html), the exponent variable is the *output* length $T_y$; the prompt length never enters the exponent. |
| $\varepsilon$ | Per-step unrecoverable error probability. (Written $e$ in the earlier post; renamed here to avoid collision with the exponential base.) |
| $f_\theta(v; \cdot)$ | The AR model's logit for token $v$ given the context. |
| $E_\theta$ | Energy function $X^{T_x} \to \mathbb{R}$; $-E_\theta(x)$ is an unnormalized confidence score for the whole sequence. |
| $Z_\theta$ | Partition function. AR: $\sum_{v \in X} e^{f_\theta(v)}$ per step ($V$ terms). EBM: $\sum_{\tilde x \in X^{T_x}} e^{-E_\theta(\tilde x)}$ ($V^{T_x}$ terms). |
| AR | Autoregressive factorization $$p(x) = \prod_t p(x^{<t>} \mid x^{<1:t-1>})$$. |
| EBM | Energy-based model: scores configurations with $E_\theta(x)$; probabilities only via $e^{-E_\theta}/Z_\theta$. |

---

## References

- [Yann LeCun. *A Path Towards Autonomous Machine Intelligence*. OpenReview, 2022.](https://openreview.net/pdf?id=BZ5a1r-kVsf)
- [Yann LeCun, Sumit Chopra, Raia Hadsell, Marc'Aurelio Ranzato, and Fu Jie Huang. *A Tutorial on Energy-Based Learning*. In *Predicting Structured Data*. MIT Press, 2006.](https://yann.lecun.org/exdb/publis/pdf/lecun-06.pdf)
- [Yang Song and Diederik P. Kingma. *How to Train Your Energy-Based Models*. arXiv:2101.03288, 2021.](https://arxiv.org/abs/2101.03288)
- [Brando Miranda. *Autoregressive Models + LLMs Exponential Error-Compounding Argument — Is It Real or Fiction?* Blog post, 2026.](https://cs.stanford.edu/people/brando9/2026/05/26/ar-error-compounding-real-or-fiction.html)
- [Nouha Dziri, Ximing Lu, Melanie Sclar, et al. *Faith and Fate: Limits of Transformers on Compositionality*. NeurIPS, 2023.](https://arxiv.org/abs/2305.18654)
- [Yilun Du, Jiayuan Mao, and Joshua B. Tenenbaum. *Learning Iterative Reasoning through Energy Diffusion*. ICML, 2024.](https://arxiv.org/abs/2406.11179)
- [Alexi Gladstone, Ganesh Nanduru, Md Mofijul Islam, et al. *Energy-Based Transformers are Scalable Learners and Thinkers*. arXiv:2507.02092, 2025.](https://arxiv.org/abs/2507.02092)

### BibTeX for the references

```bibtex
@misc{lecun2022path,
  author = {LeCun, Yann},
  title  = {A Path Towards Autonomous Machine Intelligence},
  year   = {2022},
  howpublished = {\url{https://openreview.net/pdf?id=BZ5a1r-kVsf}}
}
@incollection{lecun2006tutorial,
  author = {LeCun, Yann and Chopra, Sumit and Hadsell, Raia and Ranzato, Marc'Aurelio and Huang, Fu Jie},
  title  = {A Tutorial on Energy-Based Learning},
  booktitle = {Predicting Structured Data},
  publisher = {MIT Press},
  year   = {2006}
}
@misc{song2021how,
  author = {Song, Yang and Kingma, Diederik P.},
  title  = {How to Train Your Energy-Based Models},
  year   = {2021},
  eprint = {2101.03288},
  archivePrefix = {arXiv}
}
@misc{miranda2026arerrorcompounding,
  author = {Miranda, Brando},
  title  = {Autoregressive Models + LLMs Exponential Error-Compounding Argument --- Is It Real or Fiction?},
  year   = {2026},
  month  = {May},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/05/26/ar-error-compounding-real-or-fiction.html}},
  note   = {Blog post}
}
@inproceedings{dziri2023faith,
  author = {Dziri, Nouha and Lu, Ximing and Sclar, Melanie and others},
  title  = {Faith and Fate: Limits of Transformers on Compositionality},
  booktitle = {NeurIPS},
  year   = {2023}
}
@inproceedings{du2024ired,
  author = {Du, Yilun and Mao, Jiayuan and Tenenbaum, Joshua B.},
  title  = {Learning Iterative Reasoning through Energy Diffusion},
  booktitle = {ICML},
  year   = {2024}
}
@misc{gladstone2025ebt,
  author = {Gladstone, Alexi and Nanduru, Ganesh and Islam, Md Mofijul and others},
  title  = {Energy-Based Transformers are Scalable Learners and Thinkers},
  year   = {2025},
  eprint = {2507.02092},
  archivePrefix = {arXiv}
}
```

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026whyebms,
  author = {Miranda, Brando},
  title  = {Why Energy-Based Models? The Toy AR-vs-EBM Argument},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html}},
  note   = {Blog post}
}
```
