# 01 — Lean vs ATPs

Companion code for the blog post *Lean vs ATPs: there are things you cannot
write in SMT solvers* (see `_drafts/2026-05-12-lean-vs-atp.md`).

Two illustrative theorems:

- **Example A — `strict_mono_ge_id`** — `∀ f : ℕ → ℕ, (∀ n, f n < f (n+1)) → ∀ n, n ≤ f n`.
  The statement universally quantifies over a function, which standard SMT-LIB
  (many-sorted first-order logic) cannot directly express.

- **Example B — `reverse_reverse`** — `xs.reverse.reverse = xs`, proved with a
  `calc` block that reads like a textbook derivation. Provable by any decent
  ATP, but the *style* — named lemmas, `have`/`calc`/`induction` — is what
  makes ITP proofs valuable training data for ML.

Both proofs use core Lean 4 only — no Mathlib dependency, so the build is fast.

## Build

```bash
cd experiments/01_lean_vs_atp
lake build
```

Requires `elan` and Lean 4 (see `lean-toolchain`).
