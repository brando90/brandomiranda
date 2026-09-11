---
layout: post
title: "Maximum Likelihood for EBMs: Where MCMC Comes From (Part 1)"
date: 2026-06-23
section: ml
---

*Brando Miranda — June 2026 · ~9 min read*

**Warning: this post is a draft — content may change and errors may remain.**

**TL;DR.** Score matching ([last post](https://cs.stanford.edu/people/brando9/2026/06/09/score-matching-training-ebms-without-z.html)) trains an EBM by never touching $Z$. This post takes the *other* road — plain maximum likelihood — and follows it until the bill arrives. The MLE gradient of an EBM splits into two pieces: a **positive phase** that pushes energy *down* on real data, and a **negative phase** that pushes energy *up* on the model's own samples. The positive phase is one backward pass. The negative phase is an expectation under $p_\theta$ — the very distribution you can't sample from cheaply, because sampling needs $Z$. That single term is the entire reason **MCMC** shows up in EBM training. I derive the split, mark the spot where MCMC becomes unavoidable, and then question whether it's *actually* unavoidable — plus the same optimizer-abstraction research question from the score-matching post, now pointed at the MLE objective. Part 2 is the sampling machinery itself.

---

<style>
/* ── Callout color coding for this tutorial series ───────────────────────────
   One place, two styles. Blue = Exercise, Green = Research Question.
   Green matches the green pen I use to flag research questions in my notes. */
.exercise-box {
  border-left: 4px solid #1565c0;
  background: #e9f1fb;
  padding: 0.7em 1.1em;
  margin: 1.3em 0;
  border-radius: 4px;
}
.rq-box {
  border-left: 4px solid #2e7d32;
  background: #e9f5ec;
  padding: 0.7em 1.1em;
  margin: 1.3em 0;
  border-radius: 4px;
}
.callout-label { font-variant: small-caps; letter-spacing: 0.04em; }
</style>

A note on the boxes below before we start. Throughout this series I flag two
kinds of side-quests, and I color-code them the way I do in my own notebook:

- <span style="color:#1565c0;">**Blue — Exercises.**</span> Things you (or I,
  later) should actually work out by hand. Do them; they're short.
- <span style="color:#2e7d32;">**Green — Research Questions.**</span> Things I
  genuinely don't know the answer to and think are worth a real experiment.
  Green is the pen I reach for in my notes when something smells like a paper.

## The goal: maximum likelihood of the model

Recap from the [score-matching post](https://cs.stanford.edu/people/brando9/2026/06/09/score-matching-training-ebms-without-z.html) and the [AR-vs-EBM post](https://cs.stanford.edu/people/brando9/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html). An energy-based model assigns a scalar energy $E_\theta : X^{T_x} \to \mathbb{R}$ to a whole configuration, and turns it into a density only through the partition function:

$$p_\theta(x) \;=\; \frac{e^{-E_\theta(x)}}{Z_\theta},
\qquad
Z_\theta \;=\; \sum_{\tilde x \,\in\, X^{T_x}} e^{-E_\theta(\tilde x)},$$

where I write $p^* := p_{\mathrm{data}}$ throughout. Lower energy means higher confidence; $Z_\theta$ is the bookkeeping that makes the whole thing sum to one, and it costs $O(V^{T_x})$ in the discrete case — exponential in sequence length — or a high-dimensional integral in the continuous case.

The most obvious training principle in all of statistics is maximum likelihood: pick the parameters that make the observed data most probable under the model.

$$\theta^* \;=\; \arg\max_\theta\; \mathbb{E}_{x \sim p^*}\!\left[\log p_\theta(x)\right].$$

Before differentiating anything, it's worth knowing *what* this objective secretly is.

<div class="exercise-box" markdown="1">
<span class="callout-label">Exercise 1.</span> Show that maximizing the expected log-likelihood is equivalent to **minimizing $\mathrm{KL}(p^* \Vert p_\theta)$**, and explain the intuition.

*Hint:* expand $\mathrm{KL}(p^* \Vert p_\theta) = \mathbb{E}_{x\sim p^*}[\log p^*(x)] - \mathbb{E}_{x\sim p^*}[\log p_\theta(x)]$. The first term is $-H(p^*)$, the (negative) entropy of the data — **constant in $\theta$**. So $\arg\max_\theta \mathbb{E}_{p^*}[\log p_\theta] = \arg\min_\theta \mathrm{KL}(p^* \Vert p_\theta)$. The intuition: MLE doesn't just "fit the data," it pulls the *whole model distribution* toward the data distribution in the KL sense — and, like the Fisher divergence from last post, the KL here is the asymmetric one averaged under $p^*$ (it's forgiving where data is rare, strict where data is common).
</div>

## Since $\theta$ is what we optimize, do gradient ascent

$\theta$ is the thing we control, so — exactly as in the score-matching post — we hand the objective to gradient descent / autodiff (GD/AD). Writing the objective as $J(\theta; \hat p^*) := \mathbb{E}_{x\sim p^*}[\log p_\theta(x)]$ (a function of $\theta$, estimated from a finite, possibly partial dataset $\hat p^*$), vanilla gradient *ascent* is

$$\theta^{<t+1>} \;:=\; \theta^{<t>} \;+\; \eta\, \nabla_\theta\, \mathbb{E}_{x \sim p^*}\!\left[\log p_\theta(x)\right].$$

Now substitute $\log p_\theta(x) = -E_\theta(x) - \log Z_\theta$ and push the gradient inside:

$$\nabla_\theta \log p_\theta(x)
\;=\;
-\,\nabla_\theta E_\theta(x) \;-\; \nabla_\theta \log Z_\theta.$$

The first term is harmless — one backward pass through the energy network. The whole story is in the second term.

## The negative phase: $\nabla_\theta \log Z_\theta$ is an expectation under the model

Here is the identity that does all the work. Differentiate $\log Z_\theta$ and watch $p_\theta$ reappear out of nowhere:

$$\nabla_\theta \log Z_\theta
\;=\; \frac{\nabla_\theta Z_\theta}{Z_\theta}
\;=\; \frac{1}{Z_\theta} \sum_{\tilde x} \nabla_\theta\, e^{-E_\theta(\tilde x)}
\;=\; \frac{1}{Z_\theta} \sum_{\tilde x} e^{-E_\theta(\tilde x)}\big(-\nabla_\theta E_\theta(\tilde x)\big)
\;=\; -\sum_{\tilde x} p_\theta(\tilde x)\, \nabla_\theta E_\theta(\tilde x),$$

because $e^{-E_\theta(\tilde x)}/Z_\theta$ is *exactly* $p_\theta(\tilde x)$. So

$$\boxed{\;\nabla_\theta \log Z_\theta \;=\; -\,\mathbb{E}_{\tilde x \sim p_\theta}\!\left[\nabla_\theta E_\theta(\tilde x)\right].\;}$$

<div class="exercise-box" markdown="1">
<span class="callout-label">Exercise 2.</span> Fill in every step of the box above. *Hints:* chain rule on $e^{-E_\theta}$; the only non-obvious move is recognizing $e^{-E_\theta(\tilde x)}/Z_\theta = p_\theta(\tilde x)$, which is where the model distribution "implicitly" re-enters. Then ask yourself: why is it *clean* that the derivative of the log-normalizer is an expectation of the energy gradient under the model? (This is the standard exponential-family identity — $\nabla \log Z$ is the expected sufficient statistic.)
</div>

Putting both terms together, the maximum-likelihood gradient ascent update for an EBM is

$$\theta^{<t+1>} \;:=\; \theta^{<t>} \;+\; \eta\Big(\;
\underbrace{-\,\mathbb{E}_{x \sim p^*}\!\left[\nabla_\theta E_\theta(x)\right]}_{\text{positive phase — data}}
\;+\;
\underbrace{\mathbb{E}_{\tilde x \sim p_\theta}\!\left[\nabla_\theta E_\theta(\tilde x)\right]}_{\text{negative phase — model samples}}
\;\Big).$$

Read the two phases physically:

- **Positive phase** ($-\mathbb{E}_{p^*}[\nabla_\theta E_\theta]$): step in the direction that *lowers* energy on real data. Pull the data down into the energy wells.
- **Negative phase** ($+\mathbb{E}_{p_\theta}[\nabla_\theta E_\theta]$): step in the direction that *raises* energy on samples drawn from the model itself. Push the model's own fantasies — wherever it currently puts mass — back up.

At the optimum the two expectations cancel: the model's samples are indistinguishable from data, so there's nothing left to push around. It's a beautifully symmetric, contrastive picture (Hinton, 2002).

*(A sign-bookkeeping note: I wrote log-likelihood **ascent**, so the positive phase carries the minus sign. If you instead minimize the negative log-likelihood — what an optimizer's `loss.backward()` actually sees — both signs flip and the data term becomes the one you descend on. My handwritten notes wrote the gradient with the opposite global sign; the physics is identical, only the convention differs. Pick one and hold it.)*

## Where MCMC enters — and the question of whether it has to

Stare at the negative phase. It is an expectation **under $p_\theta$**. To estimate it, you need *samples from the model* — and sampling from $p_\theta = e^{-E_\theta}/Z_\theta$ is precisely the thing the partition function makes hard. You're back to $Z$, just wearing a different coat.

The classical answer is to approximate the negative phase with **Markov-chain Monte Carlo**: run a chain whose stationary distribution is $p_\theta$ (Langevin dynamics, Gibbs, …), grab a few samples, and use them as a stochastic estimate of $\mathbb{E}_{p_\theta}[\nabla_\theta E_\theta]$. That's the entire mechanism behind contrastive divergence and friends — and it's the subject of Part 2.

But "classical answer" is not the same as "necessary," and this is exactly the kind of place I think you should stop and poke at the foundations.

<div class="exercise-box" markdown="1">
<span class="callout-label">Exercise 3.</span> Convince yourself *why* MCMC shows up here specifically. The deep-learning book (Goodfellow, Bengio & Courville, Ch. 18) frames it through **undirected models**: an EBM is undirected, so there's no ancestral-sampling order — no clean $p(a \mid b)$ then $p(b \mid a)$ factorization to sample from directly, the way an autoregressive model has. Work out why that lack of a directed factorization is what forces you into an iterative sampler for the negative phase, and contrast it with how the AR model from [post 1](https://cs.stanford.edu/people/brando9/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html) dodges the whole problem (it pays $Z$ per token instead).
</div>

<div class="rq-box" markdown="1">
<span class="callout-label">Research Question 1.</span> **Do we actually need MCMC to estimate the negative phase — or any "proper" sampler at all?**

The negative phase needs *some* estimate of $\mathbb{E}_{p_\theta}[\nabla_\theta E_\theta]$. MCMC is the textbook-correct way to get it, but it's slow, finicky to mix, and the theory that says "you must equilibrate the chain" is exactly the kind of restrictive theory that empirics sometimes route around. So: question the foundation and try things anyway. Can a deliberately *wrong*, cheap, "messy" sampler — short non-equilibrated chains, learned samplers, replay buffers, amortized proposals — give a negative-phase estimate good enough to train competitive EBMs, judged by **evals**, not by mixing guarantees?

My intuition pump here is Jeff Dean's distributed deep learning (DistBelief; Dean et al., 2012): asynchronous, "messy" parameter updates that violate the clean synchronous-SGD story on paper, yet work *better* in practice at scale. The lesson I keep relearning is that in ML, empirical results plus honest evaluation often beat an overly restrictive theoretical purity argument. The negative phase smells like another instance: maybe approximate-but-cheap beats correct-but-unmixable. **Worth a real benchmark.** (Tracked alongside the score-matching RQs at [github.com/brando90/free-energy](https://github.com/brando90/free-energy).)
</div>

## The optimizer is also a free variable

Everything above is written as vanilla gradient ascent, but — as in the score-matching post — it's 2026 and nobody ships raw SGD. Abstract the update rule:

$$\theta^{<t+1>} \;=\; H\!\Big(\theta^{<t>},\ F\!\big(\nabla_\theta\, J(\theta; \hat p^*)\big)\Big),$$

where $F$ transforms the raw gradient (Adam moments, Shampoo's Kronecker-factored preconditioning, Muon's orthogonalized momentum) and $H$ folds the transformed step into the iterate (momentum buffers, weight decay, schedules). Plain SGD is $F = \mathrm{id}$, $H = \mathrm{add}$.

<div class="rq-box" markdown="1">
<span class="callout-label">Research Question 2.</span> **Which optimizer $(F, H)$ is right for the EBM maximum-likelihood objective?**

The MLE gradient is unusual: it's a *difference of two noisy expectations* (positive minus negative phase), and the negative phase is itself an MCMC estimate with its own bias and variance. In 2026 we have a zoo of optimizers — AdamW, Shampoo, Muon, and more. Fix $E_\theta$, the data, the sampler, and the step budget; sweep $F \in \{\text{SGD}, \text{momentum}, \text{AdamW}, \text{Shampoo}, \text{Muon}\}$ on this objective. Does modern preconditioning help a *contrastive* gradient — where the signal is a near-cancellation of two large terms — or does it amplify the negative-phase noise? Is there a *bespoke* $(F, H)$ for objectives whose gradient is a difference of expectations? **Sweep before you invent**; only then design a new one. (This is the same RQ as the score-matching post, now pointed at the MLE objective — I want the head-to-head.)
</div>

## What's next (Part 2)

We've done the easy and honest half: maximum likelihood gives a clean, contrastive gradient, and the *only* hard piece is estimating the negative phase $\mathbb{E}_{p_\theta}[\nabla_\theta E_\theta]$ — which needs samples from the model, which needs MCMC (or a good enough impostor, per RQ1).

Part 2 pays that bill. We'll actually build the sampler: Langevin dynamics as a score-driven MCMC chain (and the lovely fact that $\nabla_x \log p_\theta = -\nabla_x E_\theta$ — the same input-gradient trick from the score-matching post — is *all* Langevin needs, so $Z$ stays gone), then contrastive divergence (CD-$k$), persistent CD, and where the bias of short non-equilibrated chains actually bites. That's also where RQ1 gets its first experiment.

*To be continued — Part 2.*

---

## Appendix A — Notation

| Symbol | Meaning |
| --- | --- |
| $p^*$ | Data distribution; $p^* := p_{\mathrm{data}}$. |
| $\hat p^*$ | The finite-sample (empirical) estimate of $p^*$ we actually optimize against. |
| $E_\theta$ | Energy function; $-E_\theta(x)$ is the unnormalized confidence for configuration $x$. |
| $Z_\theta$ | Partition function $\sum_{\tilde x} e^{-E_\theta(\tilde x)}$. |
| $p_\theta$ | Model density $e^{-E_\theta}/Z_\theta$. |
| Positive phase | $-\mathbb{E}_{x\sim p^*}[\nabla_\theta E_\theta(x)]$ — lowers energy on data. |
| Negative phase | $+\mathbb{E}_{\tilde x\sim p_\theta}[\nabla_\theta E_\theta(\tilde x)]$ — raises energy on model samples; needs MCMC. |
| $$\theta^{<t>}$$ | Parameters at optimization step $t$. |
| $\eta$ | Step size. |
| $F$, $H$ | Update-rule abstraction: $F$ transforms the raw gradient; $H$ folds the step into the iterate. SGD: $F=\mathrm{id}$, $H=\mathrm{add}$. |

---

## References

- [Ian Goodfellow, Yoshua Bengio, and Aaron Courville. *Deep Learning*, Ch. 18 (Confronting the Partition Function). MIT Press, 2016.](https://www.deeplearningbook.org/)
- [Geoffrey E. Hinton. *Training Products of Experts by Minimizing Contrastive Divergence*. Neural Computation 14(8):1771–1800, 2002.](https://www.cs.toronto.edu/~hinton/absps/nccd.pdf)
- [Tijmen Tieleman. *Training Restricted Boltzmann Machines using Approximations to the Likelihood Gradient* (Persistent CD). ICML, 2008.](https://www.cs.toronto.edu/~tijmen/pcd/pcd.pdf)
- [Max Welling and Yee Whye Teh. *Bayesian Learning via Stochastic Gradient Langevin Dynamics*. ICML, 2011.](https://www.stats.ox.ac.uk/~teh/research/compstats/WelTeh2011a.pdf)
- [Yang Song and Diederik P. Kingma. *How to Train Your Energy-Based Models*. arXiv:2101.03288, 2021.](https://arxiv.org/abs/2101.03288)
- [Jeffrey Dean et al. *Large Scale Distributed Deep Networks* (DistBelief). NeurIPS, 2012.](https://papers.nips.cc/paper/2012/hash/6aca97005c68f1206823815f66102863-Abstract.html)
- [Vineet Gupta, Tomer Koren, and Yoram Singer. *Shampoo: Preconditioned Stochastic Tensor Optimization*. ICML, 2018.](https://arxiv.org/abs/1802.09568)
- [Keller Jordan et al. *Muon: An Optimizer for Hidden Layers in Neural Networks*. Blog post, 2024.](https://kellerjordan.github.io/posts/muon/)
- [Brando Miranda. *Score Matching: Training EBMs Without Ever Computing Z*. Blog post, 2026.](https://cs.stanford.edu/people/brando9/2026/06/09/score-matching-training-ebms-without-z.html)
- [Brando Miranda. *Why Energy-Based Models? The Toy AR-vs-EBM Argument*. Blog post, 2026.](https://cs.stanford.edu/people/brando9/2026/06/09/why-energy-based-models-the-toy-ar-vs-ebm-argument.html)

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026mlemcmcebm,
  author = {Miranda, Brando},
  title  = {Maximum Likelihood for EBMs: Where MCMC Comes From (Part 1)},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/06/23/maximum-likelihood-mcmc-ebms-part1.html}},
  note   = {Blog post}
}
```
