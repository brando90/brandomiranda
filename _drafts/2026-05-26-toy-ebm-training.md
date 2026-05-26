---
layout: post
title: "A Toy Energy-Based Model Where Training and Inference Are the Same Object"
date: 2026-05-26
---

*Brando Miranda — May 2026 · ~7 min read*

**TL;DR.** This toy experiment is the smallest version of the EBM story I want collaborators to understand before we move to Lean, VeriBench, and larger architectures. We train a conditional energy function over a tiny finite candidate space, enumerate the partition function exactly, and optimize the maximum-likelihood EBM update: lower the energy of data samples and raise the energy of model samples. Because the support is finite, the same code path used for training also gives inference: evaluate energies for every candidate, normalize or rank them, and pick the lowest-energy object. That makes the experiment a clean teaching example for Don, Elyas, Sri, and anyone else trying to separate the EBM idea from the sampling difficulties that appear later.

---

The first thing to understand about energy-based models is that the model does
not have to generate an object left to right.

An EBM assigns a scalar energy to a complete candidate. Lower energy means the
candidate is more compatible with the context. Higher energy means it is less
compatible.

In this toy experiment the context is a binary task vector `c`, the candidate is
another binary vector `x`, and the model is conditional:

```text
p_theta(x | c) = exp(-E_theta(c, x)) / Z_theta(c)
Z_theta(c) = sum_{x in X} exp(-E_theta(c, x))
```

The candidate space is deliberately tiny:

```text
X = {0, 1}^L
```

For `L = 9`, there are only `512` candidates. That is small enough to enumerate.
This is the whole point of the toy: remove the sampling problem so we can check
whether the basic EBM training update works.

## The Training Update

The exact conditional negative log-likelihood for a task `c` is:

```text
L(theta; c)
  = E_{x ~ p_star(. | c)}[E_theta(c, x)] + log Z_theta(c)
```

Taking the gradient gives the usual EBM two-phase update:

```text
grad_theta L
  = E_{p_star}[grad_theta E_theta(c, x)]
    - E_{p_theta}[grad_theta E_theta(c, x)]
```

The first term is the positive phase. It lowers the energy of true data. The
second term is the negative phase. It raises the energy of samples the current
model likes.

The handwritten note for this experiment was trying to turn exactly that update
into code:

```text
theta_{t+1} := theta_t
  - eta { grad_theta E_theta(x)
          - E_{x_tilde ~ p_theta}[grad_theta E_theta(x_tilde)] }
```

In a large EBM, the hard part is drawing `x_tilde ~ p_theta`. You need MCMC,
Langevin dynamics, contrastive divergence, or some other approximation. Here we
do not need any of that. We enumerate the whole support, compute the exact
model distribution, and compute the negative phase exactly.

That makes this a controlled unit test for the idea.

## The Synthetic Data

The hidden teacher distribution is structured but still simple. For each task
`c`, a candidate `x` gets low teacher energy if it matches several features:

- positionwise agreement between `x_i` and `c_i`;
- one-step shifted agreement between `x_i` and `c_{i-1}`;
- local smoothness in `x`;
- global parity agreement between `x` and `c`;
- endpoint agreement.

Then:

```text
p_star(x | c) proportional_to exp(-E_star(c, x) / temperature)
```

This target is useful because it is not purely local. A linear independent-token
energy can learn the easy copy signal, but it should struggle with local and
global dependencies. CNNs, ResNets, MLPs, and transformers have more room to
capture the hidden structure.

The toy is not supposed to prove that EBMs beat transformers. It is supposed to
answer a smaller question:

```text
Can a neural energy function recover a structured conditional distribution when
the partition function and negative phase are exact?
```

If the answer is no here, the larger EBM project is already in trouble. If the
answer is yes, we can move to the harder question: what happens when exact
enumeration is impossible?

## Inference Reuses Training

The useful implementation lesson is that inference does not require a separate
conceptual object.

During training, for each task `c`, the code evaluates `E_theta(c, x)` for every
candidate `x` in the support. It then builds:

```text
p_theta(x | c) = softmax_x(-E_theta(c, x))
```

At inference time, we can reuse the same scoring table. If we want a
probability distribution, normalize the negative energies. If we only need a
prediction, rank by energy:

```text
x_hat = argmin_x E_theta(c, x)
```

So in the finite-support case, training and inference are two views of the same
operation:

```text
score every candidate with the energy function
```

Training compares the learned distribution to `p_star`. Inference uses the
learned energy to choose or rank candidates.

This is why the toy is pedagogically useful. It makes the EBM promise visible
without hiding the normalizer. You can see the positive phase, the negative
phase, the partition function, and the final decision rule in one short script.

## What The Current Run Shows

The experiment reports the uniform baseline and five learned energy models:

```text
linear, mlp, cnn, resnet, transformer
```

For the real exact finite-support run, the uniform baseline has held-out
`KL(p_star || uniform) = 0.2149`.

The learned models all improve on that baseline:

```text
linear      KL = 0.1077
mlp         KL = 0.0742
cnn         KL = 0.0810
resnet      KL = 0.0741
transformer KL = 0.0894
```

The result is not a claim that this toy is hard. It is a sanity check that the
exact EBM objective is doing what it should. The nonlinear models recover the
teacher distribution better than the uniform baseline and better than the
linear model on held-out tasks.

On SNAP/H200, the same exact run passes with CUDA and writes the same result
table much faster than the local CPU run.

## Why This Matters For The Larger Project

Most EBM arguments jump too quickly from the definition to a grand claim about
better reasoning or better world models.

This toy does something more modest. It isolates the mechanics:

1. define a complete-object energy;
2. define the conditional partition function;
3. train by lowering data energy and raising model energy;
4. infer by ranking or normalizing the same energy scores.

That is the bridge from the handwritten derivation to the code. It also sets
up the next experiments.

Once `X` is too large to enumerate, we have to replace the exact negative phase
with an approximate one. That is where contrastive divergence, MCMC, Langevin
updates, or verifier-guided candidate pools enter. In Lean or VeriBench, the
candidate objects are proof attempts or tactic/program fragments rather than
binary strings. The core shape remains:

```text
E_theta(context, candidate)
```

but exact enumeration disappears.

This toy is therefore the baseline mental model. If we cannot explain this
experiment clearly, we are not ready to explain the larger EBM architecture.

## TL;DR, Again

The toy EBM experiment trains a conditional energy over a finite candidate
space where `Z_theta(c)` can be enumerated exactly. Training lowers energies on
data and raises energies under the current model; inference reuses the same
energy table to rank or normalize candidates. The current run passes and all
learned models beat the uniform baseline, making this a clean sanity check
before moving to approximate sampling, Lean, VeriBench, and larger EBMs.
