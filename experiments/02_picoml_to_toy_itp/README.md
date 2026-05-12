# From PicoML to a Toy ITP

Self-study experiment: build a type checker for a small ML, then keep
extending the type system until what comes out the other end is a tiny
interactive theorem prover.

The starting point is **PicoML**, the teaching language used in
**CS421 (Programming Languages and Compilers)** at UIUC under Elsa Gunter.
PicoML is an ML-flavoured language with Hindley–Milner inference, sum/product
types, lists, and pattern matching. It's a clean Goldilocks language: small
enough to implement in a weekend, rich enough that every interesting
type-system idea has somewhere to land.

My own CS421 coursework — lectures, MPs, exams, and a working PicoML
interpreter — is vendored here as a git submodule:

```sh
git submodule update --init experiments/02_picoml_to_toy_itp/cs421
```

The PicoML reference implementation from the course sits at
[`cs421/mp/mp5/`](cs421/mp/mp5) (lexer, parser, type inferencer, evaluator).
The `picoml.ml` in this directory is a single-file, from-scratch rewrite —
small enough to read in one sitting — that I'll then keep extending past
where the course stops.

The endpoint is a **toy ITP** in the spirit of Lean / Coq / Agda — a few
hundred lines of code whose `check : Env -> Term -> Type -> bool` function is
literally the proof checker.

## Roadmap

| Phase | Type system                                  | Deliverable                                                              |
|------:|----------------------------------------------|--------------------------------------------------------------------------|
| 0     | STLC                                         | `picoml.ml` — STLC subset, sanity test of the substitution + unify code  |
| 1     | Hindley–Milner (`let`-polymorphism)          | `picoml.ml` (current draft) — Algorithm W, smoke tests                   |
| 2     | HM + ADTs, lists, pattern matching, records  | Full PicoML; lex + parse so you can type-check source files              |
| 3     | System F (rank-N, explicit `∀`)              | Bidirectional checker; lose principal types, gain expressiveness         |
| 4     | λΠ (dependent function types, no universes)  | First "proofs as programs" — `Id` type, `J`, `refl`                      |
| 5     | MLTT-ish core (universes, Σ, W, inductives)  | Kernel of the toy ITP                                                    |
| 6     | Tactic layer (`intro`, `apply`, `rewrite`)   | Toy ITP — write a proof of `n + 0 = n` by tactics                        |

## Why pair PicoML with a toy ITP?

- **The kernel of an ITP is a type checker.** Phases 0–2 build that muscle in a
  setting where the rules are well-understood and there's a reference
  implementation (CS421's solutions) to diff against.
- **The jump from HM to dependent types is the interesting bit** — that's
  where unification has to deal with terms, conversion enters the picture,
  and Algorithm W stops being enough. Phases 3–5 are where the learning
  happens.
- **A tactic layer on top of a checker is small.** Tactics are partial
  functions on proof states; the kernel does the validation. So once
  the checker is solid, the ITP is mostly UI.

## References

- **CS421 PicoML** — Elsa Gunter, UIUC. Course materials, MPs.
- **Pierce, *Types and Programming Languages*** — Ch. 22 (HM), Ch. 23 (System F).
- **Pierce (ed.), *Advanced Topics in TPL*** — Ch. 2 (bidirectional), Ch. 11 (dependent).
- **Nederpelt & Geuvers, *Type Theory and Formal Proof*** — λΠ and beyond.
- **Andrej Bauer's "How to implement dependent type theory"** blog series.
- **"A tutorial implementation of a dependently typed lambda calculus"** —
  Löh, McBride, Swierstra.

## Running

```sh
cd experiments/02_picoml_to_toy_itp
ocaml picoml.ml
```

Expected output is one line per test expression with its inferred type;
the polymorphic-identity test should print a type containing `'a` /
showing `id` was generalised.

## Status

- [x] Phase 1 draft: HM inferencer, ~150 LoC, smoke-tested
- [ ] Phase 2: lexer/parser + ADTs + lists
- [ ] Phase 3+: see roadmap
