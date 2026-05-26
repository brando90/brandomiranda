# 10 — Autoregressive LLM Pros and Cons

Status: source notes plus one consolidated blog draft. This folder is the
single repo workspace for the LeCun-style autoregressive error-compounding post;
do not create a second near-duplicate draft unless the thesis changes.

Last updated: May 24, 2026.

## TL;DR

This folder is the website-side workspace for a blog post on the honest pros and
cons of autoregressive language models. The central question is not "are AR
models good or bad?" but which objections are actually true, which are true only
under strong assumptions, and which point to a real alternative such as
energy-based modeling, verifiers, search, or adaptive computation.

## Current Draft

- Experiment-local blog draft: [`blog/2026-05-24-autoregressive-models-pros-cons.md`](blog/2026-05-24-autoregressive-models-pros-cons.md)
- Website draft copy: [`../../_drafts/2026-05-24-autoregressive-models-pros-cons.md`](../../_drafts/2026-05-24-autoregressive-models-pros-cons.md)
  - Current title: "LeCun's Error-Compounding Argument Is a Warning, Not a
    Proof"
  - Scope: concise post focused on the `(1 - epsilon)^T` argument, the real
    pros and cons of autoregressive models, why tools/verifiers change the
    effective error process, and why EBMs are tempting but not free.

Older split drafts were archived as source material:

- [`archive/2026-05-24-autoregressive-error-compounding.md`](archive/2026-05-24-autoregressive-error-compounding.md)
- [`archive/2026-05-24-ebms-partition-functions-sequences.md`](archive/2026-05-24-ebms-partition-functions-sequences.md)

## Source Notes

- AR / transformer note: [`images/photo-1-ar-transformer-pros-cons.jpg`](images/photo-1-ar-transformer-pros-cons.jpg)
- EBM / partition-function note: [`images/photo-2-ebm-partition-functions.jpg`](images/photo-2-ebm-partition-functions.jpg)
- Combined transcription: [`transcription.md`](transcription.md)
- Claude conversation reference, private/source only:
  `https://claude.ai/chat/8e0e2e24-18f9-4eff-948e-9a5340fc0fce`
- Public blog assets:
  - [`assets/autoregressive_llm_pros_cons/photo-1-ar-transformer-pros-cons.jpg`](../../assets/autoregressive_llm_pros_cons/photo-1-ar-transformer-pros-cons.jpg)
  - [`assets/autoregressive_llm_pros_cons/photo-2-ebm-partition-functions.jpg`](../../assets/autoregressive_llm_pros_cons/photo-2-ebm-partition-functions.jpg)

## Relation To `free-energy`

This folder owns the public-facing narrative and source-note preservation for
the website repo.

## Code Path

The empirical/code follow-through for this blog post lives in the separate
`free-energy` repo:

```text
/Users/brandomiranda/free-energy/experiments/02_ar_pros_cons
```

GitHub path, once pushed:

```text
https://github.com/brando90/free-energy/tree/main/experiments/02_ar_pros_cons
```

Key code/docs there:

- `README.md` — overview of the AR-claims empirical suite.
- `CLAIMS.md` — claims, layer tags, and prior strength ratings.
- `PROBE_SPECS.md` — probe definitions and expected measurements.
- `probes/` — executable probes for mechanisms such as softmax bottleneck,
  rank collapse, fixed compute, partition-removable ablations, and error
  compounding.
- `FINDINGS.md` — living results log that should feed future blog updates.
- `VERIBENCH.md` — bridge to VeriBench / Lean hard-verifier evaluation.

That experiment is the stronger version of this blog post: isolate each
mechanism, test it at the right layer, then measure whether it actually changes
downstream performance in a Lean / VeriBench-style setting with a hard verifier.
The blog should point readers to the distinction:

- This repo: handwritten notes, transcription, public assets, blog draft.
- `free-energy`: claims, probes, methodology, findings, and eventual measured
  verdicts.

## Launch Checklist

When publishing or sharing the single consolidated post, tag the VeriBench
collaborators who shaped the verifier-in-the-loop framing:

- Elyas Obbad: [`@eobbad`](https://github.com/eobbad)
- Srivatsava Daruru: [`@Srivatsava`](https://github.com/Srivatsava)
- Kirill Acharya: [`@kirillacharya`](https://github.com/kirillacharya)

Handle provenance:

- `eobbad` and `Srivatsava` appear as verified GitHub assignees in the VeriBench
  experiment docs.
- `kirillacharya` appears in VeriBench PR/branch notes and git author metadata.

## Working Claim Map

Likely real advantages of AR LLMs:

- Exact sequence likelihood is tractable because the model uses local
  normalizers over the vocabulary rather than a global partition function over
  all sequences.
- Teacher forcing gives dense supervision at every token.
- Text naturally arrives as ordered sequences, so the training interface matches
  the data format.
- Sampling is simple and streams naturally into tools, code, APIs, and human
  interfaces.
- With enough capacity, the AR factorization itself can represent any
  distribution over finite sequences; the problems are in capacity, objective,
  inference, feedback, and deployment constraints.

Likely real limitations:

- Long-horizon exactness is brittle when every consequential step has to be
  right.
- Teacher-forced training and free-running generation are different regimes.
- A bad prefix can corrupt the state future tokens condition on.
- Local next-token likelihood is not the same thing as global correctness,
  truth, proof validity, or task success.
- Fixed compute per generated token is a ceiling unless the model externalizes
  more computation through additional tokens, tools, search, or refinement.
- The softmax head, MLE objective, and local normalization introduce their own
  issues; those should not be conflated with AR factorization itself.

Likely overstated objections:

- "`(1 - epsilon)^N` proves AR models cannot work."
- Every token mismatch is a semantic error.
- Errors are independent, constant-rate, and unrecoverable.
- Tool-using agents are just a longer blind rollout.
- EBMs avoid AR's problems for free.

## Blog Thesis

Autoregressive models are not doomed by the simple error-compounding equation,
but the equation is a real warning. AR models buy tractable normalization,
scalable training, and easy streaming generation by making local decisions. That
tradeoff becomes painful when the final object needs global correctness. The
interesting research question is where to put the hard part: local prediction
plus verifiers/tools/search, or global scoring plus hard inference and partition
functions.
