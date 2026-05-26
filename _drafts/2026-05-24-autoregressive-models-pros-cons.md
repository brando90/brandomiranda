---
layout: post
title: "LeCun's Error-Compounding Argument Is a Warning, Not a Proof"
date: 2026-05-24
---

*Brando Miranda — May 2026 · ~7 min read*

**TL;DR.** The famous critique of autoregressive language models is simple: if each generated token has probability `epsilon` of making an unrecoverable mistake, then a length-`T` sequence is fully correct with probability `(1 - epsilon)^T`, which decays exponentially. The math is correct. The conclusion people often draw from it is too strong. The argument is a warning about blind long-horizon rollout, not a proof that autoregressive models are doomed or that energy-based models automatically win. Its force depends on the assumptions that errors are independent, constant-rate, and unrecoverable, which are exactly the assumptions tools, verifiers, search, and iterative correction try to break.

---

There is a clean argument against autoregressive language models that I keep coming back to.

It is often associated with Yann LeCun's criticism of autoregressive generation. The argument is not complicated, which is part of why it is useful.

This post is the human-facing entry point for the experiment suite in
`experiments/02_ar_pros_cons`. The suite's job is to separate the real
advantages of autoregressive language models from the objections that are
theorem-level, empirical-but-contingent, or merely rhetorical.

Let a model generate a sequence one token at a time. Suppose each token has probability `epsilon` of taking the generation off the manifold of correct answers. Then each token is correct with probability `1 - epsilon`. If errors are independent, and if one wrong token is unrecoverable, then the probability of generating a completely correct length-`T` sequence is:

```text
Pr[all T tokens are correct] = (1 - epsilon)^T
```

For any fixed `epsilon > 0`, this goes to zero exponentially fast as `T` grows.

That is the whole equation. It is also not the whole story.

## What The Argument Gets Right

The argument is a good warning label for long-horizon exactness.

A proof is not valid because each line looked plausible when it was generated. A program is not correct because each token had high next-token probability. A long tool-use trajectory is not successful because every intermediate command was locally reasonable. Some tasks have brittle global constraints: one bad proof step, one false lemma, one wrong state mutation, or one off-by-one error can poison the rest of the trajectory.

For these tasks, local next-token competence is not the same as global correctness.

This is the real content of the critique. Autoregressive generation commits to a prefix. Future tokens condition on that prefix. If the prefix is corrupted, the model is now predicting from a corrupted state.

So if the system is a single blind rollout, the equation captures something important:

```text
many consequential choices + no correction = fragile long-horizon behavior
```

That matters for math, code, formal proofs, agents, planning, and any setting where final correctness is all-or-nothing.

## What It Does Not Prove

The argument becomes an impossibility proof only after smuggling in strong assumptions.

**First, errors are not independent.** Real model errors depend on topic, context, prompt, difficulty, and previous state. Some regions are nearly deterministic. Others are unstable. Treating every token as the same independent coin flip is a useful back-of-the-envelope model, not a law of nature.

**Second, exact token mismatch is not always semantic failure.** Natural language has many correct continuations. A token can differ from a reference and still be a better answer. The argument is strongest when correctness is brittle and externally checkable, not when there are many acceptable completions.

**Third, errors are not always unrecoverable.** A model can say "actually" and repair a contradiction. A code agent can run tests and patch the file. A theorem-proving agent can submit a tactic, read the kernel error, and try another route. Once feedback enters the loop, the process is no longer a single blind sample.

The relevant probability is not:

```text
Pr[token is locally wrong]
```

It is closer to:

```text
Pr[a consequential error survives detection, recovery, and verification]
```

That probability can still be too high. But it is a different object.

This is why I do not read `(1 - epsilon)^T` as "autoregressive models cannot work." I read it as "unverified local rollout is not enough for long-horizon correctness."

## The Honest Pros Of Autoregressive Models

Autoregressive models won for real reasons.

The factorization is exact:

```text
p(x_1, ..., x_T) = product_t p(x_t | x_<t)
```

This is just the chain rule of probability. It is not an approximation, and it does not by itself reduce representational power. The limits live in the parameterization of the conditionals, the objective, the data, and the inference procedure.

The practical advantages are enormous:

| Advantage | Why it matters |
|---|---|
| Tractable likelihood | `log p(x) = sum_t log p(x_t | x_<t)` is exactly computable. |
| Local normalization | Each step normalizes over the vocabulary, not over all `V^T` sequences. |
| Teacher forcing | Every token gives a supervised training signal in one parallel forward/backward pass. |
| Streaming generation | The model can emit text, code, tool calls, SQL, JSON, tactics, or reasoning traces incrementally. |
| Hardware fit | Dense matrix multiplies, local softmaxes, KV caching, and batching are extremely well optimized. |

This is the bargain: autoregressive models avoid the global sequence partition function by paying a local normalization cost at each step.

For a full-sequence energy-based model, the probability would look like:

```text
p_theta(x) = exp(-E_theta(x)) / Z_theta
Z_theta = sum_{x in V^T} exp(-E_theta(x))
```

That normalizer ranges over every length-`T` sequence. In continuous embedding space, it becomes a high-dimensional integral. Unless the energy has special structure, exact normalization is not a small implementation detail. It is the hard problem.

So the pro-AR case is not hand-wavy: AR models made likelihood, training, and sampling tractable at scale.

## The Honest Cons

The cons are also real, but they hit different layers. Bundling them all under "autoregressive" makes the analysis sloppy.

| Critique | What it actually targets |
|---|---|
| `(1 - epsilon)^T` compounding | Blind long-horizon rollout without recovery. |
| Exposure bias | Training on clean prefixes, deploying on model-generated prefixes. |
| No native backtracking | Standard ancestral sampling commits to the prefix it has produced. |
| Fixed compute per token | Hard and easy steps receive similar per-token compute unless the model externalizes work into more tokens or tools. |
| Local likelihood is not correctness | MLE rewards predicting corpus tokens, not satisfying a verifier or a task objective. |
| Softmax bottleneck / local normalization issues | The parameterization of each conditional, not the chain rule itself. |
| Mode-covering under MLE | The objective: forward KL spreads mass over the data distribution, including noise. |

This distinction matters. The chain-rule factorization is lossless. The left-to-right generation procedure, the softmax head, and the MLE objective are separate commitments. Different objections hit different commitments.

## Where EBMs Enter

Energy-based models are tempting because they let us score whole objects directly:

```text
E_theta(full sequence)
```

That sounds much closer to what we want for proofs, programs, plans, and long arguments. We do not only want each next token to be plausible. We want the completed object to satisfy global constraints.

This is the positive EBM motivation:

| EBM appeal | Why it is attractive |
|---|---|
| Whole-object scoring | A proof, program, plan, or image can be judged as one configuration. |
| Inference as optimization | Search for low-energy objects instead of blindly rolling out left to right. |
| Compositionality | Energies add: `E_total = E_model + E_verifier + E_prior`. |
| Energy differences | Many decisions only need relative scores, where a partition function cancels. |

But EBMs do not escape the bill. They move it.

Autoregressive models make global normalization cheap by factorizing locally. EBMs make global compatibility natural, but inference, sampling, and normalization become difficult. If someone says EBMs solve LeCun's compounding argument, the right response is:

```text
How are you searching the sequence space, and when do you pay for Z?
```

## The Questions I Actually Care About

The Claude conversation helped me separate the slogan from the testable questions.

**What exactly is `epsilon`?** Is it token mismatch? semantic error? verifier failure? a state-changing error that survives repair? These are not the same quantity.

**Are errors independent?** Probably not. We need to measure the error process, not assume the exponent.

**Are errors unrecoverable?** In blind rollout, sometimes. In code, math, and Lean-style proof search with a verifier, often no.

**Do tools reduce raw error or surviving error?** A compiler may not make the model emit fewer bad tokens. It can make fewer bad tokens survive.

**Does the system behave like `(1 - epsilon)^T` empirically?** This is the key experiment. In a hard-verifier domain, fit the observed success-vs-length curve against a geometric model and against a recoverable-error model.

**Which layer is actually failing?** Factorization, softmax, MLE, fixed compute, missing verifier, or search? If we do not separate these, we will blame the wrong thing.

**Does an EBM help enough to justify the harder inference problem?** Whole-object scoring is conceptually appealing. The empirical question is whether the global score plus search beats local generation plus verification.

## Where I Land

LeCun's error-compounding argument is not wrong. It is just easy to overread.

It is a sharp critique of blind autoregressive rollout on brittle long-horizon tasks. It is not a proof that autoregressive models are fundamentally doomed. It is not a proof that EBMs automatically solve the problem. It is a pointer to the real engineering and scientific question:

```text
Where should the hard part live?
```

One answer is local prediction plus verifiers, tools, search, and iterative correction.

Another answer is global energies plus difficult inference and normalization.

I do not think the equation settles that choice. I think it tells us what has to be measured.

If a model-plus-agent loop still behaves like `(1 - epsilon)^T`, then the critique bites hard. If verification, search, and repair change the effective error process, then the simple argument is only a warning label.

That is already valuable. Every serious long-horizon AI system needs to answer the question the equation asks:

```text
What prevents one local mistake from becoming a global failure?
```

## Source Notes

The experiment plan, probes, and source notes for this post live in the
`free-energy` experiment folder:

- [Experiment folder](https://github.com/brando90/free-energy/tree/main/experiments/02_ar_pros_cons)
- [Claims under test](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/CLAIMS.md)
- [Probe specifications](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/PROBE_SPECS.md)
- [LeCun error-compounding experiment draft](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/blog/2026-05-26-lecun-error-compounding-experiment.md)
- [Handwritten AR/error-compounding note](https://github.com/brando90/free-energy/blob/main/experiments/02_ar_pros_cons/assets/handwritten_ar_pros_cons_lecun_argument.md)

The website-side source-note archive, including the EBM partition-function
photo used below, lives in:

- [Website AR/EBM source-note workspace](https://github.com/brando90/brandomiranda/tree/main/experiments/10_autoregressive_llm_pros_cons)

Useful technical background:

- [Yann LeCun, *A Path Towards Autonomous Machine Intelligence*](https://openreview.net/pdf?id=BZ5a1r-kVsf)
- [LeCun et al., *A Tutorial on Energy-Based Learning*](https://yann.lecun.org/exdb/publis/pdf/lecun-06.pdf)
- [Yang et al., *Breaking the Softmax Bottleneck*](https://arxiv.org/abs/1711.03953)

Photo 1, the AR/error-compounding note:

![Handwritten note on autoregressive pros and cons]({{ site.baseurl }}assets/autoregressive_llm_pros_cons/photo-1-ar-transformer-pros-cons.jpg)

Photo 2, the EBM/partition-function note:

![Handwritten note on EBM partition functions]({{ site.baseurl }}assets/autoregressive_llm_pros_cons/photo-2-ebm-partition-functions.jpg)

## TL;DR, Again

The equation `(1 - epsilon)^T` is a real warning for autoregressive systems on brittle long-horizon tasks. It says local competence is not enough. But it becomes a doom theorem only if errors are independent, constant-rate, and unrecoverable. Tools, verifiers, search, and feedback are precisely attempts to make those assumptions false. EBMs are attractive because they score whole objects, but they trade AR's rollout problem for hard inference and partition-function problems.
