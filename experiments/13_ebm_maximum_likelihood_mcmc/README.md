# 13 — Maximum Likelihood, MCMC, and Training EBMs (Part 1)

Status: source notes plus standalone blog draft (Part 1 of a 2-part tutorial).

Last updated: June 23, 2026.

## TL;DR

Train an EBM by plain maximum likelihood and watch where the cost hides. The
log-likelihood gradient splits into a **positive phase** (push energy down on
data) and a **negative phase** (push energy up on the model's own samples). The
negative phase is an expectation under $p_\theta$ — which is exactly what you
cannot sample from cheaply — and that single term is where MCMC enters the
story. Part 1 derives the gradient and isolates the MCMC tax; Part 2 will cover
the sampling machinery (Langevin, CD-$k$, persistent CD).

## Goal

Turn the two handwritten note pages into the next post in the EBM series, in the
same voice as the score-matching post. This is the *maximum-likelihood* route to
training EBMs — the contrastive-divergence path — as opposed to the
score-matching route that sidesteps $Z$ entirely.

Series so far:

1. [Why Energy-Based Models? The Toy AR-vs-EBM Argument](../../_posts/2026-06-09-why-energy-based-models-the-toy-ar-vs-ebm-argument.md)
2. [Score Matching: Training EBMs Without Ever Computing Z](../../_posts/2026-06-09-score-matching-training-ebms-without-z.md)
3. **This post** — Maximum likelihood + MCMC (Part 1).

Current draft:

- Experiment-local draft: [`blog/2026-06-23-maximum-likelihood-mcmc-ebms-part1.md`](blog/2026-06-23-maximum-likelihood-mcmc-ebms-part1.md)
- Website draft copy: [`../../_drafts/2026-06-23-maximum-likelihood-mcmc-ebms-part1.md`](../../_drafts/2026-06-23-maximum-likelihood-mcmc-ebms-part1.md)

## Source Notes

- Raw photos: [`images/photo-1-mle-gradient-derivation.jpg`](images/photo-1-mle-gradient-derivation.jpg), [`images/photo-2-mcmc-and-research-questions.jpg`](images/photo-2-mcmc-and-research-questions.jpg)
- Transcription: [`transcription.md`](transcription.md)

## Core Argument

1. MLE for an EBM: $\theta^* = \arg\max_\theta \mathbb{E}_{x\sim p^*}[\log p_\theta(x)]$.
2. **Exercise:** MLE $\iff$ minimizing $\mathrm{KL}(p^* \Vert p_\theta)$ (the gap is the constant data entropy).
3. $\log p_\theta(x) = -E_\theta(x) - \log Z_\theta$, so the gradient has a $\nabla_\theta \log Z_\theta$ term.
4. **Exercise:** $\nabla_\theta \log Z_\theta = -\mathbb{E}_{\tilde x\sim p_\theta}[\nabla_\theta E_\theta(\tilde x)]$ (chain rule; $p_\theta$ reappears).
5. Update = positive phase (data) $-$ negative phase (model samples). The
   negative phase needs samples from $p_\theta$ $\Rightarrow$ MCMC.
6. **Research questions:** do we *need* MCMC at all (sample some other way; the
   Jeff-Dean "messy distributed GD" empirics-over-theory analogy)? And the
   optimizer abstraction $\theta^{<t+1>} = H(\theta^{<t>}, F(\nabla_\theta J))$
   — sweep Muon / Shampoo / AdamW on the EBM-MLE objective.

## Color-coding convention (carried from the notes)

The post defines two callout styles once, in a `<style>` block at the top, then
reuses them:

- **Blue** — Exercises (`.exercise-box`).
- **Green** — Research Questions (`.rq-box`), matching the green pen in the notes.

## Open Questions

- Should Part 2 lead with Langevin dynamics or with vanilla CD-$k$?
- How much of the "is MCMC really needed?" RQ belongs in Part 1 vs Part 2?
- Tie the negative phase explicitly back to the AR-vs-EBM partition-function
  framing from post 1?

## TL;DR, Again

Maximum likelihood is the obvious way to train an EBM, and the gradient is
clean — until you notice the negative phase is an expectation under the model
you are still trying to learn. That term is the entire reason MCMC shows up.
Part 1 makes the term unavoidable; Part 2 pays the bill.
