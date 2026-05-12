# 03 — Unary Nats

Lean 4 worked example: define the unary natural numbers from scratch
(Peano-style `zero` / `succ`), define addition two ways (recurse on
the left or right argument), and prove basic identities.

Source material:

- Gist: <https://gist.github.com/brando90/ed63fd474647825881987baaa1f26ead>
- Tutorial video: <https://www.youtube.com/watch?v=ZVaWw2LfH78&list=PLB3sDpSRdrOt68MTR6kdI0Jc85Uuw1YWV&index=2&t=11s>

## Build

```bash
cd experiments/03_unary_nats
lake build
```

Requires `elan` and Lean 4 (see `lean-toolchain`). No Mathlib dependency.

## What's in `UnaryNats.lean`

- `inductive UnaryNat` with constructors `zero` and `succ`
- `add_left` — addition by recursion on the *first* argument
- `add_right` — addition by recursion on the *second* argument
- `infixl:65 "+" => add_left` — local `+` notation
- Theorems:
  - `add_zero_is_zero : zero + zero = zero`
  - `zero_add_n_eq_n  : ∀ n, zero + n = n` (proved by `rfl` — holds by computation)
  - `n_add_zero_eq_n  : ∀ n, n + zero = n` (proved by induction — does *not* hold by computation)
