---
layout: post
title: "Overfitting Is Not Interpolation: Stop Confusing the Two"
date: 2026-05-04
---

<p style="text-align: right;"><em>Brando Miranda — May 2026 · 4 minute read</em></p>

**TL;DR.** Fitting your training set is not overfitting. That's *interpolation*. Overfitting is a *generalization* phenomenon: as you keep training, the gap between train loss and test loss grows, or the test loss itself starts going up. Modern deep learning, including LLMs at four to five epochs, routinely shows the opposite: zero training loss while test loss continues to drop. Calling that overfitting tells me the speaker is using a 1990s mental model on 2020s evidence.

---

This is a pet peeve that has been festering for years and I want it on the record.

People say "the model is overfitting" when what they actually mean is "the model has fit the training set." Those are different statements, and conflating them is one of the most persistent misconceptions in applied machine learning, including from people who should know better.

## Definitions, sharpened

- **Interpolation.** The model achieves zero (or near-zero) training error. It has *fit* the data. This is a statement about the training set alone.
- **Overfitting.** A *generalization* failure. The model's behavior on held-out data is worse than it should be — typically because the train–test gap is large or growing as training continues. This is a statement about the relationship between training and test performance, not about either one in isolation.

You can interpolate without overfitting. You can also overfit without interpolating, if your model is just badly regularized at low training loss. The two concepts are not coupled. They are not even the same kind of object: one is a single-distribution claim, the other is a two-distribution claim.

## What modern deep learning actually does

The reason this matters is that the classical bias–variance picture — where pushing training error to zero must hurt test error — is empirically false in the regimes deep learning operates in. Since roughly 2017, paper after paper has shown that you can drive train loss to zero and *still* see test loss continue to fall. Some references to anchor this:

- **Belkin et al., "Reconciling modern machine learning practice and the bias–variance trade-off," PNAS 2019.** ([paper](https://www.pnas.org/doi/10.1073/pnas.1903070116)) The "double descent" curve: test error goes down, up, then down *again* past the interpolation threshold.
- **Nakkiran et al., "Deep Double Descent: Where Bigger Models and More Data Hurt," ICLR 2020.** ([paper](https://arxiv.org/abs/1912.02292)) Shows the same pattern across model size and training time, including the phenomenon of *epoch-wise* double descent.
- **Zhang et al., "Understanding deep learning requires rethinking generalization," ICLR 2017.** ([paper](https://arxiv.org/abs/1611.03530)) Networks that interpolate random labels still generalize on real labels — train loss alone tells you nothing.
- **Power et al., "Grokking: Generalization beyond Overfitting on Small Algorithmic Datasets," 2022.** ([paper](https://arxiv.org/abs/2201.02177)) Train loss goes to zero, test loss is bad for a long time, and then suddenly snaps to perfect generalization. Train-zero is not the end of the story.

> TODO (refs to verify before publish): For LLMs specifically, the four-to-five-epoch claim — Muennighoff et al. *Scaling Data-Constrained Language Models* (2023) shows multi-epoch training is roughly as good as fresh data up to ~4 epochs of repetition; needs a citation pass to confirm exact phrasing for "test perplexity continues to drop past the train-loss-floor." If we cannot find a clean citation, drop to a softer claim.

## What people get wrong, in practice

The mistake usually shows up as one of three errors:

1. **"Train loss is too low, you're overfitting."** No. Train loss being low says nothing about generalization on its own. Show me the test curve.
2. **"You ran four epochs, you're overfitting."** Number of epochs is not a definition of overfitting. The definition of overfitting is a property of the test curve, not the train curve.
3. **"The model has memorized the data, so it's overfitting."** Memorization is not equivalent to overfitting. Modern models memorize *and* generalize. The relationship is more subtle than the textbook says.

The fix is small and free: when you mean "the model has fit the training set," say *interpolation* or *fit*. Reserve *overfitting* for the actual phenomenon of degraded generalization. The vocabulary is already there.

## Why I care

I care because every time someone writes "the model is overfitting" when they mean "train loss hit zero," they are quietly importing the conclusion that we should stop training. Sometimes that is right. Often it is wrong. In the LLM era, "stop training when train loss is low" would have left enormous headroom on the table. The vocabulary is a load-bearing piece of judgment, and using it wrong leads to wrong calls.

So: interpolation is when you fit the data. Overfitting is when generalization breaks. They are not the same. Please stop using them as if they are.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026overfitting,
  author = {Miranda, Brando},
  title  = {Overfitting Is Not Interpolation: Stop Confusing the Two},
  year   = {2026},
  month  = {May},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/}},
  note   = {Blog post draft}
}
```
