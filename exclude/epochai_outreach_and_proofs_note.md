# Epoch AI Outreach and Proofs-Not-Tests Note

Drafted: May 26, 2026

## 1. Epoch AI contact / outreach note

Subject: Partnership around VeriBench: proof-based evaluation for frontier coding agents

Hi Epoch AI team,

I'm Brando Miranda, a Stanford CS Ph.D. student in Sanmi Koyejo's STAIR group working on AI for formal mathematics, Lean 4 theorem proving, autoformalization, and end-to-end formal verification of software and mathematics. I co-founded Stanford AI for Lean, and my recent work includes VeriBench, an end-to-end Lean 4 benchmark for evaluating AI-generated code with formal verification proofs.

I'm reaching out because I think VeriBench may be a useful fit for Epoch AI's evidence-grounded work on capabilities and benchmarking. VeriBench asks an AI coding agent to go from developer-written Python source to a checked Lean 4 artifact: implementation, tests, theorem statements, and proofs. The goal is to measure more than "does the generated code pass sampled tests?" We want to measure whether the model can produce machine-checkable evidence that the code satisfies an explicit specification.

The short version: I have a good benchmark, and I would love Epoch AI's partnership in understanding what would make it great and worthy of being considered by Epoch.

Why I think this is worth a conversation:

- Test-only coding benchmarks are saturating, and passing tests is a weak proxy for correctness once models learn to optimize against them.
- VeriBench evaluates the full verification chain: Lean typechecking, proof completion, and whether the generated theorem actually covers the intended gold property.
- Current frontier agents still show a large theorem-coverage gap: they can often produce Lean files that typecheck, but the theorems they state often fail to capture the reference property.
- That gap gives a concrete, measurable target for the next generation of verifiable coding agents, especially in security-sensitive and high-assurance software.

What I would value from Epoch:

- A short call to pressure-test the benchmark design, reporting, and release plan.
- Feedback on what evidence would make the benchmark credible by Epoch's standards: task provenance, anti-contamination, human review, model coverage, scoring, reproducibility, uncertainty reporting, and update cadence.
- If it clears your bar, a possible collaboration, advisory review, or path toward inclusion or coverage in Epoch's model-evaluation ecosystem.

Links:

- VeriBench preprint: https://brando90.github.io/brandomiranda/professional_documents/papers/NeurIPS_2026_VeriBench.pdf
- VeriBench at the 2nd AI for Math Workshop at ICML 2025: https://openreview.net/forum?id=rWkGFmnSNl
- My homepage / CV: https://brando90.github.io/brandomiranda/
- Related position paper: "AI Coding Benchmarks Need Proofs, Not Just Tests": https://cs.stanford.edu/~daneshva/publications/ai-coding-benchmarks-need-proofs-not-just-tests.pdf

Would someone on your evaluations or capabilities team be open to a 30-minute conversation this week or next?

Best,

Brando Miranda<br>
Ph.D. student, Stanford CS<br>
brando9@stanford.edu<br>
https://brando90.github.io/brandomiranda/

## 2. "Proofs not just tests" paper: compact paragraph / outline

### Compact paragraph

AI coding benchmarks need proofs, not just tests, because the central failure mode of frontier coding evaluation is no longer simply "can the model produce code that passes examples?" but "can we get machine-checkable evidence that the code satisfies what we meant?" Tests are useful bug-finders, but they are finite behavioral samples; they cannot certify universal semantic properties, and once leaderboards become training targets they risk rewarding test-passing code rather than correct code. The scalable-oversight move is to shrink the human job: humans audit the statement, specification, assumptions, and whether the formalization encodes the right question, while Lean checks the long mechanical proof. So the paper should argue for a category shift in frontier coding evaluation: keep tests, but make proof-carrying tasks and prover-limited rates first-class, so progress in code generation is coupled to progress in proof generation before test-only benchmarks fully saturate.

### Outline

- Core claim: Tests are necessary but not sufficient for frontier coding benchmarks. They catch many bugs, but they cannot certify correctness over all inputs, especially in domains with adversarial, rare, or high-dimensional failures.
- Structural argument: A finite test suite always leaves untested behavior. Scaling the number of tests helps locally but does not close the correctness gap; it only moves the boundary of what was sampled.
- Benchmark argument: As models saturate test-based benchmarks, the measurement signal degrades. A model that passes tests may still be wrong, and a leaderboard optimized around tests can Goodhart toward plausible code rather than semantically correct code.
- Formal-methods argument: A proof oracle changes the evaluation target. The model must supply a machine-checkable witness against an explicit specification. This does not remove humans; it moves human oversight to the specification, where the object to audit is shorter and closer to intent.
- Scalable-oversight framing: Let the verifier check the long answer; let the human check the question. The hard human task is deciding whether the formal statement captures what we actually wanted.
- Santiago / Galois hook: "You can't patch your way out of this" becomes the security version of the same thesis. If AI makes vulnerability discovery cheaper and faster, defenders should not only patch faster; they need systems and benchmarks that push toward proving whole classes of failures absent.
- Concrete agenda: Build standardized Lean 4 specification corpora, report test-pass and proof-pass together, track prover-limited rates, use proof verification as a training signal, and scale autoformalization with expert review rather than treating generated specs as automatically correct.
- Tone to preserve: This is not anti-test. It is anti-test-only. Tests remain cheap, useful, and practical; proofs are the stronger oracle needed when the claim is semantic correctness.
