---
layout: post
title: "VeriBench-DT: Adapters, Differential Testing, and Certified LLM Judges"
date: 2026-05-14
---

*Brando Miranda — May 2026 · ~6 min read*

**TL;DR.** VeriBench-DT evaluates whether an agent's Lean formalization is not just syntactically valid, but grounded in the original Python behavior, internally verified, and semantically aligned with the gold specification. The key design is a three-part score: adapters make cross-language execution comparable, differential testing checks behavioral fidelity, and a certified LLM judge handles the semantic theorem-coverage cases that symbolic tooling cannot reliably decide at benchmark scale.

---

The central problem in code-to-formal evaluation is not "does the Lean file compile?" It is "did the agent formalize the same program, and did it prove the right things about it?"

Those are different questions. A model can generate Lean that type-checks, passes its own tests, and even proves theorems, while still silently changing the behavior of the original Python. It can also produce correct-looking theorem statements that are too weak, irrelevant, or about the wrong function. VeriBench-DT is designed around closing those loopholes.

The current design has three pieces:

1. an adapter mechanism that makes Python and Lean executions comparable;
2. a differential-testing setup that empirically checks behavioral agreement across shared inputs;
3. a certified LLM judge for semantic theorem coverage, used only where exact symbolic checking is infeasible or too brittle.

The point is not to replace formal verification with fuzzing or with an LLM judge. The point is to compose the right kind of evidence at each interface.

## The adapter mechanism

Differential testing only works if the two programs can be run on the same inputs and their outputs can be compared in the same representation. That is easy when both programs are written in the same language and expose the same function signature. VeriBench-DT is harder: the source program is Python, the candidate artifact is Lean 4, and agents are free to choose slightly different internal representations.

The adapter layer is the bridge.

Each problem defines a shared I/O schema. Python values are serialized into a canonical JSON representation; Lean receives the same values through a generated wrapper; both sides emit normalized outputs. In the current benchmark scope, this is intentionally conservative: arbitrary-precision integers, booleans, strings, and lists are supported directly. Floating-point functions are excluded for now because Python and Lean can differ on NaNs, rounding, and platform-level edge cases in ways that would measure runtime disagreement rather than formalization quality.

This sounds like plumbing, but it is actually a benchmark decision. Without the adapter, an agent that writes `List Int` while the gold reference uses an array-like representation might be unfairly marked wrong even when the functional behavior is right. With the adapter, the benchmark can ask the question that matters:

> Given the same logical input, do the Python source and the agent's Lean implementation compute the same logical output?

The adapter is deliberately not a license for arbitrary interface drift. If the agent reorders arguments, renames parameters, or changes representations in a way the type-guided adapter can recover, the benchmark wraps it and proceeds. If adaptation fails, the grounding score for that problem is zero. That is the right failure mode: an artifact that cannot be connected back to the original interface is not grounded in the source program.

This also explains one of the meeting decisions: we should not spend the benchmark's complexity budget on fragile per-task adapters that force gold tests or gold theorem proofs to type-check directly against every possible agent implementation. That path creates systematic false negatives. A candidate may be behaviorally equivalent to the gold reference while using a different internal representation, and the gold theorem file may simply not type-check against it. Instead, VeriBench-DT uses the adapter where it is strongest - at the executable I/O boundary - and uses separate semantic checks for theorem coverage.

## Differential testing

The first major signal is grounding. VeriBench-DT asks whether the agent's Lean implementation agrees with the original Python program under a shared input distribution.

For a finite test budget `k`, define differential testing as:

```text
DT_k(P, Q; D) = average_i 1[Run_P(x_i) == Run_Q(x_i)], where x_i ~ D
```

`P` and `Q` are executable implementations, `D` is the task's input generator, and equality is checked after normalization through the adapter. This is empirical behavioral conformance. It is not a proof. That distinction matters.

In the metric, grounding has two factors:

```text
G1: Python implementation agrees with agent Lean implementation under random-input DT.
G2: Python's original developer tests pass on the agent Lean implementation.
```

`G1` gives breadth. It samples more behavior than the hand-written tests cover. `G2` gives depth. The original Python tests are minimal, but they often encode important boundary cases and developer intent.

Together, they prevent the classic "verified the wrong program" failure. If the agent proves something beautiful about a Lean function that does not behave like the Python function, VeriBench-DT catches it at the grounding layer.

There is a second differential-testing role in the data-quality block:

```text
D4: Python implementation agrees with gold Lean implementation under a disjoint DT suite.
```

This is not an agent score. It is a benchmark sanity check. If the human-curated Lean reference and the Python source disagree, the problem itself is noisy and should contribute less. Using a disjoint test suite avoids making the data-quality factor numerically redundant with the agent-grounding factor.

The important design point is that differential testing is used exactly where it is strong: executable behavior. It is not asked to decide whether an agent's theorem set is complete, whether a theorem is too weak, or whether two specifications are semantically equivalent in a proof-theoretic sense.

## The full score

The draft metric is a geometric mean over ten primitive factors:

```text
S = (G1 * G2 * C1 * C2 * C3 * C4 * D1 * D2 * D3 * D4)^(1/10)
```

The factors are grouped into three conceptual blocks:

```text
Grounding:
G1: Py.f == Lhat.f by cross-language differential testing.
G2: Py.T passes on Lhat.f.

Correctness:
C1: Lhat.T passes on Lhat.f.
C2: Lhat.Thms prove properties of Lhat.f.
C3: Lhat.f and L*.f are implementation-equivalent when symbolic proof is feasible.
C4: Lhat.Thms cover L*.Thms by implication, or by certified semantic judge fallback.

Data quality:
D1: L*.T passes on L*.f.
D2: L*.Thms prove properties of L*.f.
D3: Py.T passes on Py.f.
D4: Py.f == L*.f by a disjoint cross-language DT suite.
```

The product is intentional. Verification has "AND" semantics. A model should not be able to compensate for being ungrounded in the original source by writing many extra tests. A benchmark problem should not contribute full weight if the gold Lean reference disagrees with Python. A theorem set that does not imply the gold specification should not receive full credit merely because the code compiles.

At the same time, the raw ten-way product compresses dynamic range. If every factor is `0.8`, the raw product is about `0.11`, which makes a broadly competent agent look catastrophically bad. The geometric mean preserves the non-compensatory zero behavior while returning the score to the original scale: `0.8` on every factor gives an overall `0.8`.

This is the right compromise: smooth enough for leaderboard interpretation, strict enough to keep the verification semantics.

## Why the LLM judge is necessary

The uncomfortable part is `C4`.

`C4` asks whether the agent's theorem set covers the gold theorem set. This is the central trust-artifact question. We do not only want code that behaves correctly; we want the agent to discover and state the properties that make the code trustworthy.

The obvious symbolic version is implication checking:

```text
For each gold theorem G, can we prove G from the agent's theorem set?
```

When this works, it is ideal. Lean checks the proof. No judge is needed.

But as a universal benchmark mechanism, exact implication checking is brittle. Candidate and gold files may use different helper definitions, theorem decompositions, naming schemes, wrappers, or proof contexts. A good agent may split one gold theorem into several stronger lemmas. Another may prove a more general theorem that implies the gold statement only after instantiation. A third may use a different but semantically equivalent representation. In these cases, failure to type-check a cross-file implication can reflect interface mismatch rather than lack of semantic coverage.

There is also a deeper theoretical limit: theorem equivalence is not a cheap decidable operation in the general setting we care about. Asking Lean to prove every candidate-gold implication within a fixed timeout gives a useful lower bound, not a complete semantic evaluator.

That is why an LLM judge is necessary as a fallback. It can read the original Python, the agent Lean artifact, and the gold Lean artifact, then answer the semantic question the symbolic pipeline often cannot:

> Does the agent's theorem set capture the same correctness obligations as the gold theorem set, allowing for different decomposition, stronger statements, and representation choices?

This is exactly the kind of judgment humans make when reviewing formalizations. The benchmark needs a scalable proxy for that review.

## Why the LLM judge is trustworthy

The judge is not trusted by default. It is certified before deployment.

The certification protocol is deliberately falsifiable. A judge must satisfy simple properties that any reasonable theorem-quality evaluator should obey:

```text
P1: Reflexivity.
Comparing an artifact to itself should give the maximum score.

P2: Monotonicity under injected bugs.
As semantic bugs are added, scores should go down.

P3: Monotonicity under missing specifications.
As tests or theorems are removed, scores should go down.

P4: Stability under semantics-preserving rewrites and prompt rewordings.
Renaming variables, reformatting code, or using equivalent judge instructions should not materially change the score.
```

These are not vague vibes. They are executable tests. We create perturbation ladders, run the judge repeatedly, and measure whether the score moves in the correct direction using rank correlations, weak-monotonicity rates, repeat-call variance, and prompt-stability diagnostics. A judge that fails these checks is not used as a benchmark metric.

This changes the epistemic status of the LLM judge. The claim is not:

> "The model is smart, so trust it."

The claim is:

> "On this task family, under controlled perturbations, the judge behaves like a theorem-quality evaluator must behave; therefore it is a validated proxy for the semantic cases where exact proof search is infeasible."

That is the same philosophy as differential testing itself. We do not prove the Python and Lean implementations equivalent for all inputs; we collect structured evidence under a clear generator and budget. Likewise, the certified judge does not become an oracle of mathematical truth. It becomes a measured, bounded, falsifiable evaluation component.

The reporting should make this explicit. Whenever `C4` uses symbolic implication, report it as symbolic. Whenever it uses the LLM fallback, flag it and include the symbolic-only ablation. The judge is part of the measurement system, not a black box hidden behind the leaderboard.

## The benchmark philosophy

VeriBench-DT is built around a simple separation of concerns.

Use Lean where Lean is strongest: checking proofs and type-correctness.

Use differential testing where execution is strongest: comparing source and formalized behavior across shared inputs.

Use adapters where benchmarks usually fail silently: normalizing cross-language interfaces so we measure semantic disagreement rather than representation noise.

Use a certified LLM judge where human semantic review is necessary but does not scale: theorem coverage, specification relevance, and alignment between differently structured formal artifacts.

The resulting benchmark is not pretending to have a single perfect oracle. It is a conjunction of imperfect but targeted checks. Each factor answers a narrow question. The product says: a trustworthy agentic formalization must pass all of them.

That is the standard we should want. A model should not get credit merely for compiling. It should not get credit for proving the wrong theorem. It should not get credit for matching a gold file while drifting from the original Python. And it should not be punished for harmless representation choices that a thin adapter can normalize.

VeriBench-DT is the benchmark version of the engineering principle I keep coming back to: make mistakes cheap to detect, make the gates explicit, and do not ask any one tool to carry more trust than it has earned.
