---
layout: post
title: "The Autoregressive Error-Compounding Argument Is Too Simple, But Not Wrong"
date: 2026-05-24
---

*Brando Miranda — May 2026 · ~5 min read*

**TL;DR.** The standard critique of autoregressive models is that a small per-token error rate compounds over sequence length: if each token is correct with probability `1 - epsilon`, then an entire length-`T` sequence is correct with probability `(1 - epsilon)^T`, which goes to zero exponentially fast. That argument is mathematically clean and useful. It is also too clean. Real models can recover from local mistakes, semantic correctness is not exact token matching, and agents with tools can change the effective error process. The right lesson is not "autoregressive models cannot work"; it is "long-horizon exactness needs verification, correction, and feedback, because local next-token competence alone is not enough."

---

There is a simple argument against autoregressive language models that is worth taking seriously, even if you do not buy the conclusion.

Let a model generate a sequence one token at a time. Assume each token has probability `epsilon` of being wrong, independently of the others. Then each token is correct with probability `1 - epsilon`. For a sequence of length `T`, the probability that every token is correct is:

```text
Pr[all T tokens correct] = product_t (1 - epsilon)
                          = (1 - epsilon)^T
```

For any fixed `epsilon > 0`, this goes to zero exponentially fast as `T` grows.

That is the whole argument. If the model has a 1% independent error rate per token, exact correctness across hundreds or thousands of tokens becomes unlikely. If the model has a 10% error rate, the collapse is immediate. A long enough output almost surely contains some mistake.

This is often presented as a fundamental flaw in autoregressive models. I think the more precise version is: it is a fundamental flaw in expecting local next-token accuracy, by itself, to produce long-horizon exactness.

## What The Argument Gets Right

The argument captures something real about long outputs.

Autoregressive generation is a rollout process. The model samples or chooses a token, appends it to the context, then conditions future predictions on that context. If the token is wrong in a way that matters, the model is now reasoning from a corrupted state. Future predictions may still look locally fluent, but they are fluent relative to the wrong prefix.

This is why code, math, proof search, and tool-heavy agents are harsher than casual prose. In prose, many local deviations are harmless. If a paragraph uses a slightly different word than I would have chosen, the output can still be fine. In a proof, a wrong quantifier can make the rest of the derivation meaningless. In code, one wrong variable name can break the program. In a multi-step plan, one wrong API call can poison everything downstream.

The exponential argument is not saying that the model suddenly becomes bad. It is saying that all-or-nothing success is an unforgiving metric. A per-step reliability that looks high locally can still be inadequate when the task requires every consequential step to be right.

This is the same shape as the "emergence is a metric artifact" point. Exact-match metrics compound local errors. If a model improves smoothly at the per-token level, an all-or-nothing sequence metric can still look like failure, failure, failure, then sudden success. The curve is telling you as much about the metric as about the model.

## Where The Argument Is Too Pessimistic

The clean derivation assumes independent token errors. Real language models do not satisfy that assumption.

Errors are correlated. Some contexts are easy and produce long stretches of correct output. Some contexts are hard and produce clusters of mistakes. More importantly, not every token-level mismatch is an error. There are many correct ways to write the same explanation, proof sketch, or program. Exact token identity is the wrong correctness notion for most natural-language tasks.

The argument also treats any mistake as irreversible. That is sometimes true. It is not always true. A model can contradict itself and then repair the contradiction. A code model can write a bug, run tests, inspect the failure, and patch the code. A theorem-proving agent can try a tactic, receive a kernel error, and backtrack. A search process can generate many candidate continuations and select among them.

Once correction enters the loop, the object is no longer a single blind autoregressive sample. It is a stochastic process with feedback.

The important question becomes: what is the effective probability that an unrecovered error survives to the final answer?

That probability can be much smaller than the raw probability of sampling one bad token.

## Tools Change The Process

This is where agents complicate the simple critique.

A tool can catch a class of mistakes that the model would otherwise carry forward. A compiler catches syntax and type errors. Unit tests catch behavioral errors. A Lean kernel catches invalid proofs. A calculator catches arithmetic mistakes. A web search can catch stale factual assumptions. A database constraint can catch invalid state transitions.

In the handwritten note, I wrote a margin question: how do tools change the probability of an error?

That is the right question. A tool does not make the model non-autoregressive. The model is still producing tokens. But the surrounding system changes the error dynamics. The relevant unit is no longer "one token sampled correctly." It is something like:

```text
Pr[bad intermediate state survives verification and affects the final answer]
```

That probability depends on the task, the tool, the feedback latency, the search strategy, and whether the model knows how to use the error signal.

For code, this is why pass rates improve so much with execution feedback. For formal proofs, this is why the kernel is so valuable: it is not a reward-model opinion; it is a hard checker for proof validity. The model can be locally unreliable and still become useful if the loop around it catches enough errors before they become final.

## Where EBMs Enter

Energy-based models are attractive in this conversation because they promise a different shape of judgment. Instead of committing to a sequence one token at a time, an EBM can score an entire object:

```text
E_theta(full sequence)
```

In principle, that lets the model ask whether the completed object is globally coherent. That is closer to how we want to judge proofs, plans, programs, and answers. The whole thing either satisfies the constraints or it does not.

But this is not a free fix. Scoring whole sequences introduces the partition-function and inference problems. If autoregressive models make the local decision easy and the rollout fragile, EBMs make the global score natural and the normalization/search problem hard.

So I do not read the error-compounding argument as "therefore EBMs win." I read it as "therefore local next-token prediction is an incomplete story for tasks where final correctness is brittle."

## The Better Version

The better version of the critique is:

Autoregressive models are strong local predictors. Long-horizon exact tasks require global guarantees. A long rollout of local predictions does not automatically produce a global guarantee.

That statement is hard to argue with. It also leaves room for the systems that empirically work: agents, tool loops, search, reranking, self-consistency, proof kernels, tests, verifiers, and human feedback.

The engineering problem is to make the effective error rate shrink with feedback, not to pretend the per-token error rate is zero. The scientific problem is to understand which feedback loops actually change the exponent and which ones merely hide the same compounding failure behind more tokens.

That is the part I care about. If a model writes a thousand tokens and one of them is wrong, the interesting question is not whether this violates an idealized independence assumption. The interesting question is whether the system has a way to notice, localize, and repair the wrong token before it becomes a wrong answer.

Autoregressive models are not doomed by `(1 - epsilon)^T`. But any system that ignores that equation is probably doomed by something very close to it.

## TL;DR, Again

The error-compounding argument is a real warning, not a complete impossibility
proof. Autoregressive models need feedback, tools, search, and verifiers when
the final answer must be exactly right over a long horizon.

Source note: [handwritten photo and transcription](https://github.com/brando90/brandomiranda/tree/main/experiments/10_autoregressive_llm_pros_cons).
