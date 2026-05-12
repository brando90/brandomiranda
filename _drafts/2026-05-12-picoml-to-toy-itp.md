---
layout: post
title: "From PicoML to a Toy ITP: Demystifying Lean by Writing the Type Checker Yourself"
date: 2026-05-12
---

*Brando Miranda — May 2026*

**TL;DR.** The kernel of an interactive theorem prover like Lean 4 is, at its
heart, a type checker. If you've ever written a Hindley–Milner inferencer for
a small ML — the kind you ship as part of CS421 at UIUC — you have already
written ~70% of the conceptual machinery of an ITP. The remaining 30% is
*more* type theory, not magic: bidirectional checking, dependent function
types, universes, and a small tactic layer that turns the checker into an
interactive tool. To make this concrete, I started [a public
experiment](https://github.com/brando90/brandomiranda/tree/main/experiments/02_picoml_to_toy_itp)
that walks the path *PicoML → System F → λΠ → toy ITP*, starting from the
PicoML I wrote in CS421 in undergrad. I'm also building this in the open as
a follow-up to my earlier post on [why Lean beats SMT for ML-based theorem
proving]({{ site.baseurl }}2026/05/12/lean-vs-atp.html).

## Why I think Lean feels like magic — and isn't

When people first open Lean 4, the experience is disorienting. You type a
goal. You type `intro h`. Suddenly the goal changes. You type `apply foo`.
The goal splits. Eventually `rfl` closes it and the file is green. It feels
like a logic engine is doing something deep on your behalf.

The framing I want to push back on is: *Lean is not a search engine pretending
to prove your theorem.* Lean is a **type checker** with a tactic-shaped UI on
top. The type checker is small — the Lean 4 kernel is a few thousand lines —
and it is doing exactly one thing: deciding whether a term has a given type.
The tactic layer is a sugared way to build that term incrementally.

> A proof of `P` is a term of type `P`. Closing a goal is producing a term.
> Lean checks types. That's it.

That sounds reductive, but it's correct, and once you build a kernel like
this yourself it stops being mysterious. The goal of this post (and the
experiment) is to take you down that path concretely.

## The path

```
STLC  →  Hindley–Milner  →  System F  →  λΠ  →  MLTT-ish core  →  tactics
 ▲           ▲                                                       ▲
 │           │                                                       │
 CS421       my single-file PicoML rewrite                           toy ITP
```

Each arrow is a *type system extension*, not a paradigm shift. The
substitution / unification / context-manipulation code from the previous
phase mostly survives; what changes is what the types can express.

- **STLC**: types are `int | bool | t1 -> t2`. No polymorphism.
- **Hindley–Milner**: add type variables and `Forall (αs, t)` schemes
  introduced by `let`. This is what PicoML and OCaml/Haskell are.
- **System F**: types include `∀α. t` everywhere, not just at `let`. You can
  now type `fun id -> (id 1, id true)` as long as `id` is given a
  polymorphic type explicitly.
- **λΠ (dependent function types)**: the type of the result can mention the
  *value* of the argument. `Π (n : ℕ). Vec ℕ n` is "for every `n`, a vector
  of length `n`." This is the first system in which `theorem` actually
  means something.
- **MLTT core**: add universes (`Type 0 : Type 1 : ...`), Σ-types, inductive
  types with their eliminators, propositional equality, and you have the
  conceptual core of Lean, Coq, and Agda.
- **Tactics**: not a new logic. Tactics are *meta-level* programs that
  manipulate proof states and emit terms; the kernel re-checks them. You can
  add `intro`, `apply`, `rewrite`, `induction` in a few hundred lines.

The thing I want to emphasise is that the *kernel never gets much bigger*.
The interesting growth is in what your `infer` and `unify` functions need to
handle. Once you've done Hindley–Milner, dependent types are "just" adding
β-reduction inside unification and being careful about variable capture.

## The starting point: a 150-line HM inferencer

I have my old CS421 PicoML sitting in
[`brando90/cs421`](https://github.com/brando90/cs421) — the lexer, parser,
type inferencer and evaluator that Elsa Gunter's course walked us through.
I've vendored it as a git submodule in the experiment so the reference is
right there, but I also wrote a from-scratch single-file rewrite — small
enough to read in one sitting and to extend phase by phase.

The whole inferencer is in
[`experiments/02_picoml_to_toy_itp/picoml.ml`](https://github.com/brando90/brandomiranda/blob/main/experiments/02_picoml_to_toy_itp/picoml.ml).
The interesting pieces are:

**Substitution & unification.** A substitution is a map from type variables
to types. Composition is "apply the first to the rhs of the second, then
union." Unification is Robinson's algorithm: walk both types in parallel,
bind variables, occurs-check.

```ocaml
let rec unify (t1 : ty) (t2 : ty) : subst =
  match t1, t2 with
  | TInt, TInt | TBool, TBool       -> SMap.empty
  | TVar a, t  | t, TVar a          -> bind_var a t
  | TFun (a1, b1), TFun (a2, b2)    ->
      let s1 = unify a1 a2 in
      let s2 = unify (apply_ty s1 b1) (apply_ty s1 b2) in
      compose s2 s1
  | _ -> raise (Type_error "type mismatch")
```

**Generalisation & instantiation.** This is the whole secret of `let`-polymorphism:
at a `let`, close over the type variables that aren't pinned by the
environment, producing a `∀αs. t` *scheme*. At a use site, instantiate fresh
variables for the `αs`. That is why `let id = fun x -> x in (id 1, id true)`
type-checks but `(fun id -> (id 1, id true)) (fun x -> x)` does not.

```ocaml
let generalize env t =
  let vs = SSet.diff (ftv_ty t) (ftv_env env) in
  Forall (SSet.elements vs, t)

let instantiate (Forall (vs, t)) =
  let s = List.fold_left (fun m v -> SMap.add v (fresh ()) m) SMap.empty vs in
  apply_ty s t
```

**Algorithm W.** Inference is one function per expression form. The two
returns are "what I learned about types so far" (a substitution) and "what
type this expression has." Both are needed: the substitution flows along the
spine of the term and gets composed; the type bubbles up.

You can run it locally:

```sh
git clone https://github.com/brando90/brandomiranda
cd brandomiranda/experiments/02_picoml_to_toy_itp
ocaml picoml.ml
```

Output:

```
42                                                 : int
true                                               : bool
fun x -> x                                         : 'a1 -> 'a1
let id = fun x -> x in id 3                        : int
let id = fun x -> x in (id 1, id true) ~ poly      : int
if true then 1 else 2                              : int
fun f -> fun x -> f (f x)                          : ('a4 -> 'a4) -> 'a4 -> 'a4
```

The Church-numeral-twice example showing `('a -> 'a) -> 'a -> 'a` is the
moment HM earns its keep: no annotations, fully polymorphic, principal type
recovered for you.

## What it looks like to climb from HM to dependent types

A few concrete deltas, so the rest of the path isn't hand-waving:

**HM → System F.** Drop principal types. Switch from Algorithm W to
*bidirectional* checking: every term either *checks* against a known type or
*synthesises* one, and the two modes are mutually recursive. The win is
predictability and explicit polymorphism. You add `ΛTλ. e` (big lambda) and
`e [t]` (type application).

**System F → λΠ.** Function types become `Π (x : A). B[x]` where `B` may
mention `x`. The big change is that *types now contain terms*, so checking
"is `A1` equal to `A2`?" can require β-reducing. Unification stops being
syntactic and becomes "up to conversion." This is where you first feel the
shape of a real proof assistant.

**λΠ → MLTT core.** Add `Type i` universes so types have types. Add
inductive types (`Nat`, `List`, `Vec`, `Eq`) with their constructors and
eliminators. Add Σ-types for existentials. Once `Id A x y` (propositional
equality) is in the system, `theorem foo : x = y := refl` is just a
type-checking judgement.

**MLTT → toy ITP.** A *tactic* is a function `ProofState → ProofState ×
PartialTerm`. `intro h` strips a leading `Π` from the goal and adds `h` to
the local context. `apply f` unifies the goal with the codomain of `f`'s
type and produces new goals for each argument. `rfl` succeeds iff the two
sides of the equality reduce to the same normal form. None of these are
trusted — they emit terms, and the kernel re-checks them. You can add the
five tactics that close 90% of beginner Lean exercises in an afternoon.

## Why I'm doing this in public

Two reasons.

**One**, for myself. The fastest way I know to internalise a system is to
implement it. I have written PicoML before; I have used Lean 4; I have not
*bridged* the two in my own head with code. This experiment is that bridge.

**Two**, because I think the "Lean is magic" framing is doing damage to the
ML-for-math conversation. If you believe Lean is a black-box search engine,
RL-on-Lean looks like a wild reinforcement-learning problem. If you believe
Lean is a *type checker with a UI*, then "training a model to prove
theorems" is the much more tractable problem of *training a model to write
well-typed terms*, which is just code generation with a strong oracle. This
is the same point I made in the [Lean vs ATP post]({{ site.baseurl }}2026/05/12/lean-vs-atp.html),
but from the implementation side instead of the expressivity side.

If you have ever stared at a Lean tactic block and wondered what is really
going on underneath: this is the experiment. The first commit is a
150-line HM inferencer. The last commit, if I get there, is a proof of
`n + 0 = n` by tactics, in a system small enough to read end-to-end.

## Where to follow along

- Tracking issue:
  [brando90/brandomiranda#51](https://github.com/brando90/brandomiranda/issues/51)
- PR (Phase 1 + scaffolding):
  [brando90/brandomiranda#52](https://github.com/brando90/brandomiranda/pull/52)
- Experiment directory:
  [`experiments/02_picoml_to_toy_itp/`](https://github.com/brando90/brandomiranda/tree/main/experiments/02_picoml_to_toy_itp)
- CS421 reference (vendored submodule):
  [`brando90/cs421`](https://github.com/brando90/cs421)
- Companion post on motivation:
  [Lean vs ATPs]({{ site.baseurl }}2026/05/12/lean-vs-atp.html)

## References

- Pierce, *Types and Programming Languages* — Ch. 22 (HM), Ch. 23 (System F).
- Pierce (ed.), *Advanced Topics in TPL* — Ch. 2 (bidirectional), Ch. 11 (dependent).
- Nederpelt & Geuvers, *Type Theory and Formal Proof* — λΠ and beyond.
- Löh, McBride, Swierstra — *A Tutorial Implementation of a Dependently
  Typed Lambda Calculus*.
- Andrej Bauer — *How to Implement Dependent Type Theory* (blog series).
- Elsa Gunter — CS421 course materials, UIUC.
