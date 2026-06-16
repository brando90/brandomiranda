---
layout: post
title: "Lean vs ATPs: there are things you cannot write in SMT solvers"
date: 2026-05-12
---

*Brando Miranda — May 2026*

**TL;DR.** Interactive theorem provers (ITPs) like Lean let humans — and ML models — write proofs in a high-level, structured, sketch-like style. Automated theorem provers and SMT solvers cannot. The deeper point is not just stylistic: SMT-LIB is many-sorted first-order logic, and *large classes of theorems are not even expressible* in it. That asymmetry is exactly why ITP corpora are a richer training signal for ML-based theorem proving than ATP/SMT traces, and why I think the long arc of ML-for-math runs through Lean/Isabelle and not through pure SMT-style environments.

## The exchange that started this

I sent a note to a friend a few days ago. The conversation, lightly trimmed:

> **Brando, 9:34 AM** — Good morning Leni! I wanted to motivate why one should use Lean vs traditional ATPs e.g. SMT solvers. My reason is that ITPs allow human-like level proofs more easily than ATPs (that are very low level tiny step-by-step proofs) — so ML models can't really benefit from training data to improve in TP (Theorem Proving) with smt/atp-like data/(rl) environments. E.g., one can't do high-level proof sketches like humans do in ATPs but it's more easily doable in Lean and Isabelle type ITPs. That's why it's called an ITP and not an ATP. What do you think of this motivation? Curious of your own reasons if you are open to sharing 🙂
>
> **Chrysoberyl, 9:38 AM** — there are things you cannot write in smt solvers
>
> **Brando, 9:43 AM** — one small example?

This post is my attempt to answer that "one small example" question concretely — with two Lean proofs you can run yourself — plus the broader motivation that started the thread.

## Two motivations, one direction

I went in with one argument and walked out with two. They reinforce each other.

**Motivation 1 (mine, about *style*).** ATPs and SMT solvers return verdicts (`UNSAT`) or low-level certificates — sequences of resolution steps over Skolemized clauses, or DRAT proofs, or similar. ITPs let you write proofs that read like mathematical text:

- `have` introduces a named intermediate lemma, just like a paper does.
- `calc` chains equational reasoning the way you write it on a blackboard.
- `suffices` does the "it is enough to show…" move.
- `induction`, `cases`, `intro` are the named inference rules from a first logic course.

The proof's *surface form* matches the way humans think. That is exactly the training distribution we want ML models to learn from if we want them to *reason about* mathematics rather than search for unstructured certificates. SMT proofs have very little signal about *why* a theorem is true; ITP proofs do, by construction.

**Motivation 2 (Leni's, about *expressivity*).** Even before we argue about proof style, there are theorems you *cannot state* in standard SMT-LIB at all. SMT-LIB is many-sorted **first-order** logic over a fixed set of background theories (arithmetic, arrays, bit-vectors, datatypes, …). You cannot:

- universally quantify over functions: `∀ f : ℕ → ℕ, …`
- universally quantify over predicates: `∀ P : ℕ → Prop, …`
- define new inductive types with their induction principles
- talk about types-as-objects, propositions-as-types, or any of the dependent-type machinery that modern formalized math actually uses

A first-order language with fixed function symbols can encode *specific* facts about a specific function. It cannot encode the general statement that ranges over *every* function or *every* predicate. The induction principle for an arbitrary inductive type? Not expressible. Cantor's theorem (no surjection `ℕ → (ℕ → ℕ)`)? Not expressible. Most of category theory? Not expressible. Almost any theorem with a "for every structure" in front of it? Not expressible.

These are two different gaps — expressivity and style — and they compound. If a theorem isn't expressible, the question of proof style for it doesn't even arise.

## Example A — a theorem SMT cannot state

Here is a one-line statement that already breaks SMT-LIB's expressivity:

> For every function `f : ℕ → ℕ` such that `f n < f (n+1)` for all `n`, we have `n ≤ f n` for all `n`.

The leading `∀ f : ℕ → ℕ` is the obstacle. Standard SMT-LIB has no syntactic form for it. You can sometimes encode a *fixed* `f` by adding an uninterpreted function symbol with axioms, but you cannot get the *general* theorem ranging over *every* `f`. In Lean it is one line of signature and a short induction:

```lean
theorem strict_mono_ge_id
    (f : Nat → Nat) (hf : ∀ n, f n < f (n + 1)) :
    ∀ n, n ≤ f n := by
  intro n
  induction n with
  | zero =>
      exact Nat.zero_le _
  | succ k ih =>
      -- From `hf k` we get `f k < f (k+1)`, i.e. `f k + 1 ≤ f (k+1)`.
      -- The IH gives `k ≤ f k`, i.e. `k + 1 ≤ f k + 1`. Chain them.
      have step : f k + 1 ≤ f (k + 1) := hf k
      have ih'  : k + 1 ≤ f k + 1     := Nat.succ_le_succ ih
      exact Nat.le_trans ih' step
```

Read the proof out loud. *Induction on `n`. Base case: zero is at most anything. Inductive step: I have `k ≤ f k`, so `k+1 ≤ f k + 1`; and from the hypothesis I have `f k + 1 ≤ f (k+1)`; chain these and I'm done.* That is the proof a human would write in a margin. The Lean kernel checks it.

You cannot ask an SMT solver this question. Not "the solver times out"; the solver has no syntax to receive the question.

## Example B — a "human-readable" proof in Lean

The fact below is trivially provable by any reasonable ATP. The interesting thing is not *that* it is provable; it is *how* the proof reads.

```lean
theorem reverse_reverse {α : Type} (xs : List α) :
    xs.reverse.reverse = xs := by
  induction xs with
  | nil => rfl
  | cons h t ih =>
      calc (h :: t).reverse.reverse
          = (t.reverse ++ [h]).reverse := by
              rw [List.reverse_cons]
        _ = [h].reverse ++ t.reverse.reverse := by
              rw [List.reverse_append]
        _ = [h] ++ t.reverse.reverse := rfl
              -- `[h].reverse` is definitionally `[h]`.
        _ = [h] ++ t := by
              rw [ih]
        _ = h :: t := rfl
```

Each `calc` step is a sentence: *first apply `reverse_cons` to push the reverse through the head; then distribute the outer reverse over `++`; then collapse `[h].reverse` to `[h]` (which Lean knows by computation); then apply the inductive hypothesis; then read off the answer.* Every step is named. Every step is checkable in isolation. Every step looks like something a textbook would write.

The SMT analogue is a single opaque UNSAT. It tells you the theorem is true. It does not tell you *the proof goes by induction on the list, and the inductive step is a four-rewrite chain.* That difference is small for `reverse_reverse`. It is enormous for a real piece of mathematics.

## Why this matters for ML

The two examples above are toy. The structural argument they illustrate is not.

- **Training data.** Mathlib and the broader Lean/Isabelle/Coq corpora are full of structured, named-step proofs. Every `have`, every `calc`, every `induction` is a labeled reasoning move. An ATP/SMT corpus is mostly low-level resolution traces or unstructured proof witnesses. If you are training an LLM to *imitate mathematical reasoning*, the first corpus carries that signal; the second largely does not.
- **RL environments.** "Try a tactic, observe the new goal" is a *natural* MDP with high-information rewards (did the proof state get simpler? is a subgoal closed?). "Try a resolution step on Skolemized clauses" is a far less informative environment.
- **Verifiability with insight.** ITPs give you both a kernel check *and* a human-legible explanation. SMT gives you only the kernel check.
- **Composability with humans.** A mathematician can read a `calc` block, agree or disagree, and patch it. They cannot read an SMT proof.

This is why I keep returning to ITPs in my own research, and why I think the long arc of ML-for-math has to route through Lean-style systems even when SMT is faster on the fragments it handles.

## Counterpoint and limits

I do not want to overclaim.

- **SMT is extraordinary on its fragment.** Decidable theories with quantifier-free reasoning, linear arithmetic, bit-vectors, hardware verification — these are SMT's home turf, and there is no contest. Lean itself calls SMT-style decision procedures internally (`omega` for linear arithmetic, `polyrith` for polynomial identities, and so on). The right picture is that ITPs *subsume* and *integrate with* ATPs — not that ATPs are useless.
- **Expressivity vs. automation is a real trade-off.** Lean's logic is dependently typed and undecidable; SMT's logic is restricted *because* the restriction buys it decision procedures. You pay for the expressivity I'm celebrating with proof-search effort.
- **The training-data point is not yet a proved theorem about ML.** I believe it strongly, and the empirical record so far (DeepMind's AlphaProof on miniF2F, the recent wave of Lean-tactic LLM agents, Mathlib-conditioned models out-of-distribution) supports it. But "ITP corpora are strictly better for ML-for-math than SMT corpora" is a claim about the future of training, not a settled fact about the past.

The argument is about *general theorem proving and ML for it.* It is not an argument against SMT in the domains SMT was built for.

## Running the proofs yourself

Code lives at [`experiments/01_lean_vs_atp/`](https://github.com/brando90/brandomiranda/tree/main/experiments/01_lean_vs_atp). The whole project depends only on core Lean 4 — no Mathlib — so the build is a few seconds:

```bash
# Install elan if you don't have it: https://github.com/leanprover/elan
cd experiments/01_lean_vs_atp
lake build
```

You should see both `strict_mono_ge_id` and `reverse_reverse` type-check.

## Where I net out

Two answers to "why ITPs over ATPs," and they're complementary:

1. *Some theorems you cannot write down in SMT at all.* The universally-quantified-over-functions example above is the smallest one I can show in a blog post; the more interesting ones (Cantor, induction principles, category theory) live one layer up.
2. *Of the theorems you can write in both, the ITP proof has structure a human and an ML model can both learn from.* The SMT proof does not.

If you care about formalized mathematics — and increasingly, about training models that reason about mathematics — you are going to spend your time in Lean (or Isabelle, or Coq, or HOL). SMT is a tool you call from inside that environment, not a replacement for it.

I'd love to hear other people's framings on this — especially from anyone who works on the SMT side and thinks I've sold the trade-off too hard in one direction. The Discord thread is open.

---

*Files for this experiment:*

- [`LeanVsATP.lean` on GitHub](https://github.com/brando90/brandomiranda/blob/main/experiments/01_lean_vs_atp/LeanVsATP.lean) — both theorems, fully self-contained.
- [`README.md`](https://github.com/brando90/brandomiranda/blob/main/experiments/01_lean_vs_atp/README.md) — build instructions.
- [Experiment folder](https://github.com/brando90/brandomiranda/tree/main/experiments/01_lean_vs_atp) — `lakefile.toml`, `lean-toolchain`, everything you need to reproduce.

*Related:*

- [Asking the Right Question: Formal Methods as Scalable Oversight]({{ site.baseurl }}2026/04/22/formal-methods-scalable-oversight.html) — the broader argument for why formal methods matter in the age of AI agents.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026leanvsatp,
  author = {Miranda, Brando},
  title  = {Lean vs {ATPs}: There Are Things You Cannot Write in {SMT} Solvers},
  year   = {2026},
  month  = {May},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/05/12/lean-vs-atp.html}},
  note   = {Blog post}
}
```
