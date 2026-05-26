# 08 — EBM Partition Function Motivation

Status: source notes plus standalone blog draft.

Last updated: May 24, 2026.

## TL;DR

Motivate energy-based models by starting from the partition function:
global sequence scoring is conceptually attractive, but exact normalization
is hard because the sample space grows from `|V|` to `|V|^N`, and continuous
sequence embeddings turn the normalizer into a high-dimensional integral.

## Goal

Turn the handwritten note into a clear blog argument for why EBMs are tempting
and why the partition function is the central computational obstacle. The
standalone EBM draft is now kept in this experiment folder, while broader
AR/EBM synthesis posts can cite it as background.

Current draft:

- Experiment-local draft: [`blog/2026-05-24-ebm-partition-function-motivation.md`](blog/2026-05-24-ebm-partition-function-motivation.md)
- Website draft copy: [`../../_drafts/2026-05-24-ebm-partition-function-motivation.md`](../../_drafts/2026-05-24-ebm-partition-function-motivation.md)

## Source Notes

- Raw photo: [`images/photo-1-ebm-partition-functions.jpg`](images/photo-1-ebm-partition-functions.jpg)
- Transcription: [`transcription.md`](transcription.md)

## Core Argument

1. A one-token discrete EBM has a small normalizer:
   `Z_theta = sum_{x in V} exp(-E_theta(x))`.
2. A length-`N` sequence EBM normalizes over `V^N`, so exact normalization is
   `O(|V|^N)`.
3. A continuous sequence-embedding EBM lives over `(R^D)^N`, making the
   partition function a high-dimensional integral.
4. This is the honest tradeoff: EBMs can score global coherence directly, but
   inference, normalization, and sampling become the hard part.

## Open Questions

- Should the post use `V` consistently for vocabulary and reserve `X` for the
  sample space?
- Should the post mention specific approximations such as contrastive
  divergence, score matching, or noise-contrastive estimation?
- Should the EBM motivation be tied more explicitly to proof search, agents,
  and long-horizon reasoning?

## TL;DR, Again

EBMs are appealing because they can judge a whole object at once. The catch is
that judging whole objects requires normalizing or searching over a huge space,
and the partition function is where that cost shows up.
