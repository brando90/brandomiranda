---
layout: post
title: "Score Matching: Training EBMs Without Ever Computing Z"
date: 2026-06-09
section: ml
---

*Brando Miranda — June 2026 · ~8 min read*

**Warning: this post is a draft — content may change and errors may remain.**

**TL;DR.** An EBM defines $p_\theta(x) = e^{-E_\theta(x)}/Z_\theta$, where $Z_\theta$ is intractable. But $Z_\theta$ is a sum over *all* configurations — it does not depend on the particular $x$ you evaluate at — so differentiating $\log p_\theta$ with respect to the **input** kills it: $\nabla_x \log p_\theta(x) = -\nabla_x E_\theta(x)$. **Score matching** turns this observation into a training principle: match the model's score $\nabla_x \log p_\theta$ to the data's score $\nabla_x \log p^*$. Because normalization removes exactly one degree of freedom, matching scores forces matching *distributions* — $Z$ never appears. The resulting loss is the **Fisher divergence** $D^{F}_{p^*}(p^* \Vert p_\theta)$, training is (any) gradient descent on it, and every choice in the update rule — SGD vs. AdamW vs. Muon vs. Shampoo — is an open experimental question for EBMs. One thing gets swept under the rug: the objective contains the *data's* score, which we don't have. Fixing that introduces a Hessian-trace term whose alleged intractability I'll interrogate in the next post.

---

## The problem: $Z$ is the enemy

Recap from [the previous post](https://cs.stanford.edu/people/brando9/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html). An energy-based model scores whole configurations with a learned energy $E_\theta : X^{T_x} \to \mathbb{R}$, and probabilities — if you insist on them — require the partition function:

$$p_\theta(x) \;=\; \frac{e^{-E_\theta(x)}}{Z_\theta},
\qquad
Z_\theta \;=\; \sum_{\tilde x \,\in\, X^{T_x}} e^{-E_\theta(\tilde x)},$$

a sum (integral, in the continuous case) with $V^{T_x}$ terms. Maximum likelihood drags it right back in:

$$\nabla_\theta \log p_\theta(x) \;=\; -\nabla_\theta E_\theta(x) \;-\; \nabla_\theta \log Z_\theta,$$

and that second term costs you either $Z_\theta$ itself or MCMC samples from $p_\theta$ — the classical contrastive-divergence tax (Song & Kingma, 2021).

But notice what we actually *want* from an EBM: the ability to say "this $x$ is more plausible than that $\tilde x$" — to learn $E_\theta$ — **without ever computing the normalization**. The normalization is bookkeeping. Can we fit the model and skip the bookkeeping?

## One observation (a tool, not yet a method)

Look at $Z_\theta$ again. It sums $x$ *out*. Whatever number it equals, it is a **constant with respect to $x$**. Therefore:

$$\nabla_x \log p_\theta(x)
\;=\; \nabla_x \Big( -E_\theta(x) - \log Z_\theta \Big)
\;=\; -\nabla_x E_\theta(x).$$

**Differentiating with respect to the input kills the partition function.** That's the whole observation. I'm not yet claiming anything about what to do with it — think of it as a tool we just picked up.

This gradient has a name, and the name is reserved (which is why I refuse to call the energy "the score"): the **score** of a density $p$ is

$$s(x) \;:=\; \nabla_x \log p(x).$$

So the model's score is $s_\theta(x) = -\nabla_x E_\theta(x)$ — computable with one backward pass, no $Z$ — and the data's score is $s^*(x) = \nabla_x \log p^*(x)$, where I write $p^* := p_{\mathrm{data}}$ throughout.

*Fine print:* $\nabla_x$ presumes $x$ lives in a continuous space ($\mathbb{R}^D$, e.g. an embedding space). For literal token sequences the gradient is undefined and you need either a continuous relaxation or a discrete variant of what follows (ratio matching, Hyvärinen 2007; concrete score matching, Meng et al. 2022). Flagged, deferred — it's a real design decision for the Lean setting, not a footnote I get to wave away forever.

## The crazy idea: make the scores match

Here is the move. Demand that the model's score agree with the data's score *everywhere*:

$$\nabla_x \log p_\theta(x) \;\approx\; \nabla_x \log p^*(x) \qquad \forall x.$$

Geometrically: picture the two log-density surfaces over the same domain, and require their **slope fields to be identical at every point** — the surfaces are parallel everywhere.

<!-- FIGURE TODO: two parallel log-density curves, log p* and log p_theta, vertical offset C, with matching gradient arrows at several x's. -->

This looks insufficient. Two functions with identical gradients everywhere are equal only **up to a constant**:

$$\log p_\theta(x) \;=\; \log p^*(x) \;+\; C.$$

For generic functions, $C$ is a genuine leftover degree of freedom, and "parallel" $\ne$ "equal." So why would anyone expect score matching to pin down the distribution?

## Parallel ⇒ equal — but *only* for probability distributions

Because normalization already spent that degree of freedom. Intuitively: when you normalize — when you impose $\sum_x p(x) = 1$ — you remove exactly one degree of freedom from the function class. Score matching fixes the function up to exactly one degree of freedom. The two halves click.

The proof is almost embarrassing. Exponentiate the displaced-log condition and sum over $x$:

$$1 \;=\; \sum_x p_\theta(x)
\;=\; \sum_x e^{\log p^*(x) + C}
\;=\; e^{C} \sum_x e^{\log p^*(x)}
\;=\; e^{C} \cdot 1
\quad\Longrightarrow\quad C = 0.$$

If you like it even smaller: if $p_1 + p_2 = 1$ must hold, a global constant multiplying the distribution has nowhere to hide. So:

$$s_\theta(x) = s^*(x)\ \ \forall x
\quad\Longrightarrow\quad
p_\theta = p^*.$$

**Matching scores is sufficient to match distributions** — and we never touched $Z$. Note what made this work: *both* objects are probability distributions. For unnormalized functions the argument dies immediately. (Modulo the usual regularity conditions — full support and smoothness, and "everywhere" meaning $p^*$-almost everywhere; see Hyvärinen 2005, Theorem 2.)

## The dumbest norm you can think of: the Fisher divergence

A condition is not a loss. To train, we penalize the score mismatch — and we should reach for the most naive penalty available, the $L_2$ norm, averaged over the data:

$$D^{F}_{p^*}\!\left(p^* \,\Vert\, p_\theta\right)
\;:=\;
\mathbb{E}_{x \sim p^*}\!\left[\,\tfrac{1}{2}\,\big\Vert\, \nabla_x \log p_\theta(x) \;-\; \nabla_x \log p^*(x) \,\big\Vert_2^2 \,\right].$$

This object is the **Fisher divergence**, and minimizing it *is* score matching (Hyvärinen, 2005).

### A note on my notation

Standard texts write $D_F(p_{\mathrm{data}} \Vert p_\theta)$ — or hide the whole thing inside a loss symbol $\mathcal{J}(\theta)$ — and leave *implicit* that the expectation is taken under the **first** argument. That implicitness matters: the Fisher divergence is **not symmetric** (which is why it's a divergence and not a distance), and *which distribution you average under* is a modeling decision, not a typographic afterthought. So I subscript it:

$$D^{F}_{p^*}(\,\cdot\, \Vert \,\cdot\,)
\qquad \text{where the subscript names the distribution carrying the expectation.}$$

I'd write the KL divergence the same way if I could rewrite the textbooks. Slightly redundant, never ambiguous.

## Training is just descent on $D^F$

Everything after this point is ordinary deep learning. Vanilla gradient descent:

$$\theta^{<t+1>} \;:=\; \theta^{<t>} \;-\; \eta\, \nabla_\theta\, D^{F}_{p^*}\!\left(p^* \,\Vert\, p_{\theta^{<t>}}\right).$$

But it's 2026, and nobody ships raw SGD. So abstract the update rule:

$$\theta^{<t+1>} \;=\; H\!\Big(\theta^{<t>},\ F\!\big(-\eta\, \nabla_\theta D^{F}_{p^*}(p^* \Vert p_\theta)\big)\Big),$$

where $F$ transforms the raw gradient — first/second-moment estimates in Adam/AdamW (Kingma & Ba 2015; Loshchilov & Hutter 2019), Kronecker-factored preconditioning in Shampoo (Gupta et al. 2018), orthogonalized momentum in Muon (Jordan et al. 2024) — and $H$ folds the transformed step into the iterate (momentum buffers, decoupled weight decay, schedules). Plain SGD is the special case $F = \mathrm{id}$, $H = \mathrm{add}$.

Here's the part I find genuinely under-explored. The score-matching literature was largely built *before* — or in benign neglect of — the modern optimizer stack. Hyvärinen (2005) predates Adam by a decade, and the EBM-training lineage doesn't systematically sweep 2026-grade optimizers against score objectives. Every cell in $\{\text{objective: } D^F\} \times \{F:\ \text{SGD, momentum, AdamW, Shampoo, Muon}\}$ is cheap to run and, as far as I can tell, mostly unrun.

**Research questions** (tracked as issues at [github.com/brando90/free-energy](https://github.com/brando90/free-energy)):

- **RQ1 — sweep before invent.** Fix $E_\theta$, data, batch size, and step budget. Sweep $F \in \{\text{SGD, SGD+momentum, AdamW, Shampoo, Muon}\}$ on $D^{F}_{p^*}$. Does modern preconditioning change *whether/what* score matching trains — or only *how fast*?
- **RQ2 — objective × optimizer interaction.** $\nabla_\theta D^{F}$ is the gradient of a gradient mismatch: it contains mixed $\partial^2 / \partial\theta\,\partial x$ structure that plain MLE gradients don't have. Does that structure favor — or break — particular preconditioners? Is there a *bespoke* $F$ for score objectives?
- **RQ3 — then innovate.** Only after the sweep do we get to design a new $F$/$H$ for $D^F$. The baselines are the alibi for the invention.

## What I swept under the rug (next post)

Look back at the definition of $D^{F}_{p^*}$. It contains $\nabla_x \log p^*(x)$ — **the score of the data distribution**. We don't have $p^*$. We have *samples* from it.

The classical resolution (Hyvärinen, 2005) is an integration-by-parts identity that rewrites $D^F$ — up to a constant that doesn't depend on $\theta$ — purely in terms of $p_\theta$ and samples from $p^*$. The price is a new term: the **trace of the Hessian** of the model's log-density,

$$\mathrm{tr}\!\left(\nabla_x^2 \log p_\theta(x)\right) \;=\; -\,\mathrm{tr}\!\left(\nabla_x^2 E_\theta(x)\right).$$

Song & Kingma's tutorial treats this trace as *the* computational bottleneck of score matching — the thing that pushes you toward denoising score matching (Vincent, 2011) and sliced score matching (Song et al., 2019). And look: the *full* Hessian is quadratic in the dimension — clearly out. But the **trace** is a *linear* number of terms, and yet it's still declared impractical. I have questions about that claim — what exactly the per-term cost is, what 2026 autodiff and hardware change, and where the exact-vs-stochastic-estimator crossover actually sits. That's the next post.

---

## Appendix A — Notation

| Symbol | Meaning |
| --- | --- |
| $p^*$ | The data distribution; $p^* := p_{\mathrm{data}}$ (the paper's notation). |
| $E_\theta$ | Energy function; $-E_\theta(x)$ is the unnormalized confidence for configuration $x$. |
| $Z_\theta$ | Partition function $\sum_{\tilde x} e^{-E_\theta(\tilde x)}$ — constant in $x$, which is the whole trick. |
| $s(x)$ | The **score** of a density: $s(x) := \nabla_x \log p(x)$. Model: $s_\theta = -\nabla_x E_\theta$. Data: $s^* = \nabla_x \log p^*$. Note: gradient w.r.t. the *input* $x$, not the parameters $\theta$. |
| $D^{F}_{p^*}(p^* \Vert p_\theta)$ | Fisher divergence; the subscript names the distribution the expectation is taken under (it is not symmetric). |
| $$\theta^{<t>}$$ | Parameters at optimization step $t$. |
| $\eta$ | Step size. |
| $F$, $H$ | The update-rule abstraction: $F$ transforms the raw gradient (Adam moments, Shampoo/Muon preconditioning); $H$ folds the step into the iterate (momentum, weight decay, schedules). SGD: $F=\mathrm{id}$, $H=\mathrm{add}$. |

---

## References

- [Aapo Hyvärinen. *Estimation of Non-Normalized Statistical Models by Score Matching*. JMLR 6:695–709, 2005.](https://jmlr.org/papers/v6/hyvarinen05a.html)
- [Yang Song and Diederik P. Kingma. *How to Train Your Energy-Based Models*. arXiv:2101.03288, 2021.](https://arxiv.org/abs/2101.03288)
- [Pascal Vincent. *A Connection Between Score Matching and Denoising Autoencoders*. Neural Computation 23(7):1661–1674, 2011.](https://www.iro.umontreal.ca/~vincentp/Publications/smdae_techreport.pdf)
- [Yang Song, Sahaj Garg, Jiaxin Shi, and Stefano Ermon. *Sliced Score Matching: A Scalable Approach to Density and Score Estimation*. UAI, 2019.](https://arxiv.org/abs/1905.07088)
- [Aapo Hyvärinen. *Some Extensions of Score Matching*. Computational Statistics & Data Analysis 51(5):2499–2512, 2007.](https://www.cs.helsinki.fi/u/ahyvarin/papers/CSDA07.pdf)
- [Chenlin Meng, Kristy Choi, Jiaming Song, and Stefano Ermon. *Concrete Score Matching: Generalized Score Matching for Discrete Data*. NeurIPS, 2022.](https://arxiv.org/abs/2211.00802)
- [Diederik P. Kingma and Jimmy Ba. *Adam: A Method for Stochastic Optimization*. ICLR, 2015.](https://arxiv.org/abs/1412.6980)
- [Ilya Loshchilov and Frank Hutter. *Decoupled Weight Decay Regularization*. ICLR, 2019.](https://arxiv.org/abs/1711.05101)
- [Vineet Gupta, Tomer Koren, and Yoram Singer. *Shampoo: Preconditioned Stochastic Tensor Optimization*. ICML, 2018.](https://arxiv.org/abs/1802.09568)
- [Keller Jordan, Yuchen Jin, Vlado Boza, Jiacheng You, Franz Cesista, Laker Newhouse, and Jeremy Bernstein. *Muon: An Optimizer for Hidden Layers in Neural Networks*. Blog post, 2024.](https://kellerjordan.github.io/posts/muon/)
- [Brando Miranda. *Why Energy-Based Models? The Toy AR-vs-EBM Argument*. Blog post, 2026.](https://cs.stanford.edu/people/brando9/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html)

### BibTeX for the references

```bibtex
@article{hyvarinen2005estimation,
  author  = {Hyv{\"a}rinen, Aapo},
  title   = {Estimation of Non-Normalized Statistical Models by Score Matching},
  journal = {Journal of Machine Learning Research},
  volume  = {6},
  pages   = {695--709},
  year    = {2005}
}
@misc{song2021how,
  author = {Song, Yang and Kingma, Diederik P.},
  title  = {How to Train Your Energy-Based Models},
  year   = {2021},
  eprint = {2101.03288},
  archivePrefix = {arXiv}
}
@article{vincent2011connection,
  author  = {Vincent, Pascal},
  title   = {A Connection Between Score Matching and Denoising Autoencoders},
  journal = {Neural Computation},
  volume  = {23},
  number  = {7},
  pages   = {1661--1674},
  year    = {2011}
}
@inproceedings{song2019sliced,
  author    = {Song, Yang and Garg, Sahaj and Shi, Jiaxin and Ermon, Stefano},
  title     = {Sliced Score Matching: A Scalable Approach to Density and Score Estimation},
  booktitle = {UAI},
  year      = {2019}
}
@article{hyvarinen2007extensions,
  author  = {Hyv{\"a}rinen, Aapo},
  title   = {Some Extensions of Score Matching},
  journal = {Computational Statistics \& Data Analysis},
  volume  = {51},
  number  = {5},
  pages   = {2499--2512},
  year    = {2007}
}
@inproceedings{meng2022concrete,
  author    = {Meng, Chenlin and Choi, Kristy and Song, Jiaming and Ermon, Stefano},
  title     = {Concrete Score Matching: Generalized Score Matching for Discrete Data},
  booktitle = {NeurIPS},
  year      = {2022}
}
@inproceedings{kingma2015adam,
  author    = {Kingma, Diederik P. and Ba, Jimmy},
  title     = {Adam: A Method for Stochastic Optimization},
  booktitle = {ICLR},
  year      = {2015}
}
@inproceedings{loshchilov2019decoupled,
  author    = {Loshchilov, Ilya and Hutter, Frank},
  title     = {Decoupled Weight Decay Regularization},
  booktitle = {ICLR},
  year      = {2019}
}
@inproceedings{gupta2018shampoo,
  author    = {Gupta, Vineet and Koren, Tomer and Singer, Yoram},
  title     = {Shampoo: Preconditioned Stochastic Tensor Optimization},
  booktitle = {ICML},
  year      = {2018}
}
@misc{jordan2024muon,
  author = {Jordan, Keller and Jin, Yuchen and Boza, Vlado and You, Jiacheng and Cesista, Franz and Newhouse, Laker and Bernstein, Jeremy},
  title  = {Muon: An Optimizer for Hidden Layers in Neural Networks},
  year   = {2024},
  howpublished = {\url{https://kellerjordan.github.io/posts/muon/}}
}
@misc{miranda2026whyebms,
  author = {Miranda, Brando},
  title  = {Why Energy-Based Models? The Toy AR-vs-EBM Argument},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html}},
  note   = {Blog post}
}
```

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026scorematching,
  author = {Miranda, Brando},
  title  = {Score Matching: Training EBMs Without Ever Computing Z},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/06/09/score-matching-training-ebms-without-z.html}},
  note   = {Blog post}
}
```
