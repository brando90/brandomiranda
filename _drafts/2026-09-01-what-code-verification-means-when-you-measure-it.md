---
layout: post
title: "What Code Verification Means When You Have to Measure It"
date: 2026-09-01
---

*Brando Miranda — September 2026 · ~10 min read*

**TL;DR.** A benchmark is an operational definition of a capability whether or not its authors say so, so say so. "Verified" has always meant verified *relative to a specification*, and whether that specification is adequate to what a human meant is not a formal question for anyone — not for a benchmark, not for a proof assistant, not for a certification standard. VeriBench operationalizes one scoped version of code verification — verification of a Lean 4 model of Python source, by an agent, against a fixed curated reference — and it should be read as exactly that: a measurement of prerequisite capabilities, with software verification as the motivation rather than the result.

---

<!-- Generator chat: https://claude.ai/chat/f117b3ea-1128-425e-9296-c162a37350d7 -->

This post was motivated by a discussion with a formal methods expert about what [VeriBench](https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/) [8] measures. It sets out what code verification means once it has to be measured, what building a benchmark commits you to, and what VeriBench does and does not claim.

---

## Four questions a code-verification benchmark has to answer

Any benchmark that starts from source code and ends with a formal artifact has to answer four questions, and each one is fair.

1. The agent translates Python to Lean and proves theorems about the Lean. The Python is still what runs. What was verified?
2. The agent writes the specification by reading the code. If the code has a bug, the specification has the same bug and the proof goes through. Is the source even known to be correct?
3. Theorem coverage is scored by an LLM judge. An LLM is not a precise instrument for whether two pieces of formal code say the same thing; it can miss a subtle bug and penalize an equivalent rewrite. Why trust the number?
4. What can be measured now that could not be measured before, and what is known now that was not known before?

The rest of this post answers them in order, after two pieces of groundwork: what "verified" means, and what a benchmark is.

---

## Verified means verified relative to something

The standard definition of verification is short: an implementation satisfies a specification, and a checker confirms it. That is Hoare's framing from 1969 — a program is correct with respect to a precondition and a postcondition, and correctness is a theorem to be proved [1]. Three things ride along with that sentence, usually unstated. The specification was written independently of the implementation, so that it can disagree with it. The specification is meant to capture what a human intended. And the object being verified is the artifact that actually runs.

What the definition does not contain is any criterion for when a specification is *enough*. Software engineering has a name for that question. Boehm's formulation is the canonical one: verification asks "are we building the product right?" and validation asks "are we building the right product?" [2]. The IEEE standard for verification and validation draws the same line — verification checks conformance to specified requirements, validation checks fitness for intended use [3]. The second question is not a formal one. Intent is not a formal object. A specification is a human translation of intent, written by someone: a customer, a curator, a certification standard like DO-178C for airborne software [4]. Every verification claim ever made is relative to a finite, chosen specification, and the choice was made by a person.

Two consequences follow, and they pull in opposite directions.

Relative does not mean never. seL4 is verified — relative to its specification — and that is a real, achieved state whose proof effort found real bugs in the kernel [5]; CompCert is a verified compiler in the same sense, relative to the semantics of its source and target languages [6]. If "verified" is pushed to its limit, so that it means "every property the human intended, proved," then nothing has ever been verified and the word is useless. That is not a fact about formal methods; it is the reason the field defined the word the way it did.

But relative also means that the last step, from "satisfies S" to "does what was meant," is not closed by any method. Not by a proof assistant, not by a benchmark, not by a room full of humans agreeing on the specification. A complete set of true properties of a program is not even enumerable in general — that is Rice's theorem [7], and the VeriBench paper has an appendix on why the benchmark therefore never promises a complete theorem list [8]. So every honest verification claim has the same shape: *this artifact, relative to this specification, which was chosen by these people for these reasons*. The difference between a good claim and a bad one is whether that shape is written down.

---

## A benchmark is a definition, whether or not it is written down

When you build a benchmark, you are answering the question "what is this capability, operationally, and how would I recognize more of it?" The dataset is the population the capability is about; the metric is what the capability consists of; the scoring script is the definition. This is an operational definition in Bridgman's sense — a concept defined by the operations that measure it [9] — and the question of whether the measurement tracks the concept it is named for is what the psychometrics literature calls construct validity [10]. Declining to write the definition down does not remove it. It moves it into the code.

The [emergent-abilities result](https://arxiv.org/abs/2304.15004) is the same lesson from another direction: whether a model appears to acquire a capability suddenly or smoothly is largely a choice of metric, so the metric *is* the claim [11]. The same holds for every coding benchmark. HumanEval defined "can write code" for a generation of models [12], and it defined it as "passes these tests," which is why [HumanEval+](https://github.com/evalplus/evalplus) [13] and [SWE-Bench Verified](https://www.swebench.com/verified.html) [14, 15] had to exist. A benchmark that scores proofs instead of tests is a different definition of correctness, and the case for that definition has been [made explicitly](https://cs.stanford.edu/~daneshva/publications/ai-coding-benchmarks-need-proofs-not-just-tests.pdf) [16].

So the discipline is: name the construct. Name the reference the comparison is made against and who chose it. Name the instrument that does the comparing and the errors it makes. Name what is assumed rather than measured. Then the reader can decide what the number means, and the number cannot be read as claiming more than it supports, because its scope is on the page.

---

## What VeriBench operationalizes

The task: given Python source with its docstring and tests, an agent must produce a Lean 4 file [17] containing an implementation, executable tests, theorems about that implementation, and proofs. The agent may use verifier feedback — call Lean, read errors, revise — inside a [Harbor](https://harborframework.com/) container that holds the source and the toolchain and nothing else. It never sees the human-curated reference.

The score is a conjunction of three checks, reported separately and combined as a geometric mean. The paper calls the composite the Smooth Conjunctive Score for Code Verification [8]; the geometric mean exists so that a zero in any component keeps the total at zero without the metric being zero everywhere.

1. **Compiles and tests pass.** The Lean file typechecks and its executable assertions hold. A kernel check.
2. **Proofs close.** The theorems the agent stated are proved about the agent's implementation, with no `sorry`. A kernel check.
3. **Theorems cover the reference.** The agent's theorems, taken together, imply the curated reference theorems. An estimate, not a kernel check, for reasons given below.

Two things are assumed rather than measured, and both are stated up front.

The source is taken as the intent. Its correctness is assumed, not measured. Detecting bugs in the source is out of scope for this version by design: the benchmark isolates one capability — formalize and prove a model of code you are handed — from a different one — discover that the code is wrong.

The reference is fixed by curation. Whether the curated theorems are *adequate* to the intent is the validation question from the previous section, and no pipeline decides it formally, so coverage is coverage of a finite reference, not a completeness claim.

The precise statement: VeriBench measures verification of a Lean model of the source, conditional on the source, relative to a curated reference. Trustworthy code, safety-critical software, and provably correct programs are the motivation, not what the number says.

---

## What if the source has a bug?

The coupling question is the sharpest of the four, and the answer is not "implementation and specification were written separately." The agent is free to derive its theorems from the code it translates, and it usually does. Implementation and specification can share a mistake.

What makes that acceptable is that the reference is fixed and hidden. The evaluation is decoupled from the agent even when the agent's own process is not. Two guards do the work.

Proofs must close about the actual implementation. So the agent's specification is satisfiable — the implementation is a model of it — and cannot be inconsistent. `False` is not provable about a program that exists.

Coverage is measured against a reference the agent never saw. A specification too weak to say anything — `myAdd a b = myAdd a b` — implies nothing about the reference and scores near zero on coverage. A specification that hides behind an unsatisfiable hypothesis is provable but says nothing about real inputs, so it does not imply the reference either. Trivial, vacuous, and hypothesis-gated specifications all land in the same place: proofs close, coverage stays low, the conjunction stays low.

What the guards do not do is decouple the reference from the *source*. The reference was drafted from the same Python: an AI first draft, then human curation against a written rubric, then Lean compilation [8]. If the Python is wrong, the reference is wrong with it. That is exactly why "the source is the intent" is an assumption of this version rather than a result, and why a benchmark that measures bug-finding needs adversarially buggy sources and intent elicited independently of the implementation. That is a different benchmark, with a different estimand.

---

## A model of the program, not the program

The Lean artifact is a model of the Python, and the link between them is established empirically — by the curation of the reference and by the judge — not formally.

This is the standard every autoformalization benchmark uses. When a model translates an informal theorem statement into Lean, nobody proves that the Lean says what the English said; a human or a judge checks it, because English has no formal semantics to prove anything against. The original autoformalization work evaluated statement fidelity by human inspection [18], and the standard benchmarks — miniF2F [19], ProofNet [20] — rely on human-curated formalizations for the same reason. Python is different in principle — it has semantics, so a formal relation to Lean is possible — but no such relation exists for the full language, and the closest industrial example is Cedar, where AWS formalized the language in Lean and used differential random testing to check that the Rust implementation matches the model [21]. So VeriBench is at the field's standard on fidelity, not below it, and the link should be labeled empirical from the first paragraph rather than the last.

It is also the one link that is missing rather than assumed. For formal methods, the gap between the model and the thing that runs is where verification efforts fail in practice. Differential testing between the Python and the Lean — shared tests, generated tests, behavioral agreement — is the next step, and it belongs in a separate paper because it changes what is being estimated.

---

## Why a prover cannot be the judge

The standard definition — implementation satisfies specification, checked by a kernel — has a hidden premise: implementation and specification share a vocabulary that humans fixed in advance. The same types, the same names, the same decomposition into lemmas. Inside a fixed formal setting that premise is free.

An end-to-end task removes it by construction. If the agent starts from Python, or from a natural-language intent, and writes whatever Lean file it wants, then it chose the representation. Its theorems and the reference will usually differ in types, names, and decomposition even when they say the same thing. A prover-based check of "the agent's theorems imply the reference" returns zero on almost every output — not because the content is wrong but because the implication cannot be stated across the vocabulary gap.

This is not hypothetical. The benchmarks that use prover-based specification checks — CLEVER [22], VERINA [23] — make them possible by fixing the Lean signatures and scaffold in advance, so the agent's output and the reference share a vocabulary. VeriSoftBench goes further and fixes the theorem statement itself, evaluating proof completion inside existing Lean repositories [24]. Those are sound designs for what they measure. They do not measure whether an agent can *choose* a formalization, because the choice was made for it. VeriBench drops that constraint on purpose — that is what makes the task realistic — and the price is that the relation between agent output and reference has to be estimated.

So theorem coverage is implication, not equivalence — an agent that proves stronger properties is not penalized — and it is estimated by an LLM judge validated against human ratings. The judge is an estimate. It is not sound. LLM judges have documented failure modes [25]; this one can accept a subtly wrong specification and penalize an equivalent rewrite. The human-agreement statistics are reported so the reader can weigh it [8], and the composite score is never called sound.

Which error is worse depends on purpose. A prover-based judge is sound but incomplete: it fails safe, and its failure hits the common case. An LLM judge is neither sound nor complete. For *ranking agents*, zeroing every representational mismatch is the worse failure, because the score stops carrying information. For *deciding whether to trust a specification*, a false accept is the worse failure, because that is the one that ships. Both judgments are correct, about different purposes. The design that respects both is: prover when the vocabularies line up, LLM when they do not, and report the fraction decided by each.

---

## What the measurement shows

Across the agentic systems, the compile-and-tests column sits near the ceiling; proof closure and theorem coverage sit far below it (current numbers are in the [launch post](https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/) and paper [8], and they move as tasks are rescored). Artifact construction, proof completion, and theorem formulation are not one capability. Without the decomposition, "formal reasoning" is one blob; with it, there are three separable bottlenecks, and the one that lags worst is stating the right claims, not proving them. That is the knowledge the instrument produces, and it is actionable: proof-repair tools should move the second column; theorem-generation training should move the third; if they do not, the decomposition is wrong.

What the measurement does not show is that higher VeriBench scores mean better real-world verification. That is a construct-validity question in the Cronbach–Meehl sense [10], and it is an experiment, not an assertion. The experiment is the one just described: intervene on one capability and check whether the predicted column moves.

---

## What VeriBench does not claim

- That the Python source is verified, or that any Python source is correct.
- That the Lean artifact is semantically equivalent to the Python, beyond the empirical fidelity checks described above.
- That the curated reference is complete, or that every reference theorem is proved (the remaining open proofs in the reference are tracked and reported alongside agent scores).
- That the theorem-coverage judge is a code-equivalence oracle, or that the composite score is sound.
- That agents which score higher are better at verifying real software. That is the open question.

---

## Principles for building a verification benchmark

1. **A benchmark is an operational definition. Write it down.** The construct, the reference, who chose it, the instrument, and its error profile belong in the first section, not the limitations.
2. **Verification is relative. Name the S.** Every claim of the form "verified" carries a specification and a chooser. Say which.
3. **Separate the mission from the claim.** The motivation can be software verification. The claim is whatever the instrument supports. Put them in different sentences.
4. **Measure links separately; combine conjunctively.** A single pass/fail hides which stage failed. Report the components; use the conjunction only to keep a zero a zero.
5. **An assumption stated is not an oversight.** "The source is the intent" and "the reference is fixed by curation" are design choices when written down and holes when discovered by the reader.
6. **Every instrument has an error profile. Choose it on purpose.** Sound-but-incomplete and neither-sound-nor-complete are different tools for different purposes. Say which purpose was chosen and why.
7. **Undecidability bounds everyone. Use it to scope, not to excuse.** No pipeline closes the intent gap and no reference is complete. That justifies coverage over completeness; it does not justify skipping the parts that are decidable.
8. **Construct validity is an experiment.** "These capabilities matter for verification" is a hypothesis. The intervention that would test it belongs in the paper, even before it has been run.

---

## Closing

Formal methods are the best scalable-oversight story available: [let the verifier check the answer and let the human check the question](https://cs.stanford.edu/people/brando9/2026/04/22/formal-methods-scalable-oversight.html). This post is the benchmark-builder's corollary. The verifier checks the artifact. The benchmark checks the agent. And the benchmark's authors owe the reader the definition they used — the construct, the reference, the instrument, the assumptions — because that definition is the only thing that says what the number means.

The long-term goal is agents that take the code people actually run and produce guarantees a checker can confirm. The route there is to measure the prerequisite capabilities precisely and to say precisely what was measured.

---

## Appendix A: Terminology

The words, as used here:

- **Intent / requirement.** What the program should do, in the head of the person who wants it. Not a formal object.
- **Formal specification.** Predicates over inputs and outputs — in VeriBench's schema, a precondition `Pre` and a postcondition `Post` — written by a human to capture the intent.
- **Theorem.** The proposition that the implementation satisfies the specification: for all admissible inputs, `Pre x → Post x (prog x)` — a Hoare triple, in effect [1].
- **Proof.** A derivation of the theorem that the Lean kernel accepts.
- **Tests.** Finite behavioral evidence: particular inputs with expected outputs. Evidence for the specification, not the specification. As Dijkstra put it, testing can show the presence of bugs, never their absence [26].

A benchmark that conflates the last four cannot say what it measured.

---

## Appendix B: The four questions, answered short

*What was verified?* A Lean model of the source, relative to a curated reference. Not the Python.

*What if the source has a bug?* Then the reference has it too. Source correctness is assumed in this version; the benchmark isolates formalization and proof from bug-finding, which needs a different benchmark with buggy sources and independently elicited intent.

*Why trust an imprecise judge?* It estimates a relation — coverage across agent-chosen representations — that a prover cannot state, it is validated against humans, and it is never called sound. Which error is preferable depends on whether the purpose is ranking agents or trusting a specification.

*What is known now?* That artifact construction, proof completion, and theorem formulation are separable bottlenecks, and that the worst one is stating the right claims. Whether that predicts real-world verification is the open experiment.

---

## References

1. C. A. R. Hoare. "An Axiomatic Basis for Computer Programming." *Communications of the ACM* 12(10):576–580, 1969. [doi:10.1145/363235.363259](https://doi.org/10.1145/363235.363259)
2. B. W. Boehm. "Verifying and Validating Software Requirements and Design Specifications." *IEEE Software* 1(1):75–88, 1984. [doi:10.1109/MS.1984.233702](https://doi.org/10.1109/MS.1984.233702)
3. IEEE Std 1012-2016. *IEEE Standard for System, Software, and Hardware Verification and Validation.* IEEE, 2017. [doi:10.1109/IEEESTD.2017.8055462](https://doi.org/10.1109/IEEESTD.2017.8055462)
4. RTCA DO-178C. *Software Considerations in Airborne Systems and Equipment Certification.* RTCA, 2011.
5. G. Klein, K. Elphinstone, G. Heiser, J. Andronick, D. Cock, P. Derrin, D. Elkaduwe, K. Engelhardt, R. Kolanski, M. Norrish, T. Sewell, H. Tuch, S. Winwood. "seL4: Formal Verification of an OS Kernel." *SOSP 2009.* [doi:10.1145/1629575.1629596](https://doi.org/10.1145/1629575.1629596)
6. X. Leroy. "Formal Verification of a Realistic Compiler." *Communications of the ACM* 52(7):107–115, 2009. [doi:10.1145/1538788.1538814](https://doi.org/10.1145/1538788.1538814)
7. H. G. Rice. "Classes of Recursively Enumerable Sets and Their Decision Problems." *Transactions of the American Mathematical Society* 74(2):358–366, 1953. [doi:10.1090/S0002-9947-1953-0053041-6](https://doi.org/10.1090/S0002-9947-1953-0053041-6)
8. B. Miranda, S. Daruru, E. S. Hersch, Z. Zhou, A. Nie, D. Amrollahi, L. Aniva, I. Mlauzi, et al. "VeriBench: End-to-End Formal Verification Benchmark for AI Coding Agents in Lean 4." Preprint, 2026. [Paper](https://cs.stanford.edu/people/brando9/professional_documents/papers/NeurIPS_2026_VeriBench.pdf) · [Launch post](https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/) · [ICML 2025 AI for Math Workshop](https://openreview.net/forum?id=rWkGFmnSNl)
9. P. W. Bridgman. *The Logic of Modern Physics.* Macmillan, 1927.
10. L. J. Cronbach and P. E. Meehl. "Construct Validity in Psychological Tests." *Psychological Bulletin* 52(4):281–302, 1955. [doi:10.1037/h0040957](https://doi.org/10.1037/h0040957)
11. R. Schaeffer, B. Miranda, S. Koyejo. "Are Emergent Abilities of Large Language Models a Mirage?" *NeurIPS 2023* (Outstanding Paper). [arXiv:2304.15004](https://arxiv.org/abs/2304.15004)
12. M. Chen et al. "Evaluating Large Language Models Trained on Code." 2021. [arXiv:2107.03374](https://arxiv.org/abs/2107.03374)
13. J. Liu, C. S. Xia, Y. Wang, L. Zhang. "Is Your Code Generated by ChatGPT Really Correct? Rigorous Evaluation of Large Language Models for Code Generation." *NeurIPS 2023.* [arXiv:2305.01210](https://arxiv.org/abs/2305.01210)
14. C. E. Jimenez, J. Yang, A. Wettig, S. Yao, K. Pei, O. Press, K. Narasimhan. "SWE-bench: Can Language Models Resolve Real-World GitHub Issues?" *ICLR 2024.* [arXiv:2310.06770](https://arxiv.org/abs/2310.06770)
15. OpenAI. "Introducing SWE-bench Verified." 2024. [openai.com](https://openai.com/index/introducing-swe-bench-verified/)
16. D. Amrollahi, M. Karimi, B. Miranda, L. Aniva, C. Sun, C. Barrett, S. Koyejo. "AI Coding Benchmarks Need Proofs, Not Just Tests." Preprint, 2026. [PDF](https://cs.stanford.edu/~daneshva/publications/ai-coding-benchmarks-need-proofs-not-just-tests.pdf)
17. L. de Moura and S. Ullrich. "The Lean 4 Theorem Prover and Programming Language." *CADE-28*, LNCS 12699, 2021. [doi:10.1007/978-3-030-79876-5_37](https://doi.org/10.1007/978-3-030-79876-5_37)
18. Y. Wu, A. Q. Jiang, W. Li, M. Rabe, C. Staats, M. Jamnik, C. Szegedy. "Autoformalization with Large Language Models." *NeurIPS 2022.* [arXiv:2205.12615](https://arxiv.org/abs/2205.12615)
19. K. Zheng, J. M. Han, S. Polu. "miniF2F: A Cross-System Benchmark for Formal Olympiad-Level Mathematics." *ICLR 2022.* [arXiv:2109.00110](https://arxiv.org/abs/2109.00110)
20. Z. Azerbayev, B. Piotrowski, H. Schoelkopf, E. W. Ayers, D. Radev, J. Avigad. "ProofNet: Autoformalizing and Formally Proving Undergraduate-Level Mathematics." 2023. [arXiv:2302.12433](https://arxiv.org/abs/2302.12433)
21. J. W. Cutler, C. Disselkoen, A. Eline, S. He, K. Headley, M. Hicks, K. Hietala, E. Ioannidis, J. Kastner, A. Mamat, D. McAdams, M. McCutchen, N. Rungta, E. Torlak, A. M. Wells. "Cedar: A New Language for Expressive, Fast, Safe, and Analyzable Authorization." *Proc. ACM Program. Lang.* 8(OOPSLA1), Article 118, 2024. [doi:10.1145/3649835](https://doi.org/10.1145/3649835)
22. A. Thakur, J. Lee, G. Tsoukalas, M. Sistla, M. Zhao, S. Zetzsche, G. Durrett, Y. Yue, S. Chaudhuri. "CLEVER: A Curated Benchmark for Formally Verified Code Generation." 2025. [arXiv:2505.13938](https://arxiv.org/abs/2505.13938)
23. Z. Ye, Z. Yan, J. He, T. Kasriel, K. Yang, D. Song. "VERINA: Benchmarking Verifiable Code Generation." 2025. [arXiv:2505.23135](https://arxiv.org/abs/2505.23135)
24. Y. Xin, Q. Chen, G. Durrett, I. Dillig. "VeriSoftBench: Repository-Scale Formal Verification Benchmarks for Lean." 2026. [arXiv:2602.18307](https://arxiv.org/abs/2602.18307)
25. L. Zheng, W.-L. Chiang, Y. Sheng, S. Zhuang, Z. Wu, Y. Zhuang, Z. Lin, Z. Li, D. Li, E. P. Xing, H. Zhang, J. E. Gonzalez, I. Stoica. "Judging LLM-as-a-Judge with MT-Bench and Chatbot Arena." *NeurIPS 2023 Datasets and Benchmarks.* [arXiv:2306.05685](https://arxiv.org/abs/2306.05685)
26. E. W. Dijkstra. "Notes on Structured Programming." In O.-J. Dahl, E. W. Dijkstra, C. A. R. Hoare, *Structured Programming*, Academic Press, 1972 (EWD249, 1970). [EWD249](https://www.cs.utexas.edu/~EWD/ewd02xx/EWD249.PDF)

---

## Discuss

I shared this post on X/Twitter here: [discussion thread](https://x.com/BrandoHablando). Replies, disagreements, pointers, and follow-up questions are welcome there.

---

*If you'd like to cite this post:*

```
@misc{miranda2026measuringverification,
  author = {Miranda, Brando},
  title  = {What Code Verification Means When You Have to Measure It},
  year   = {2026},
  month  = {September},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/09/01/what-code-verification-means-when-you-measure-it.html}},
  note   = {Blog post}
}
```
