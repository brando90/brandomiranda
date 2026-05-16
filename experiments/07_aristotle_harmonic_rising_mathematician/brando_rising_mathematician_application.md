# Harmonic / Aristotle Sponsorship Application - Brando Miranda

Status: ready-to-paste draft for Brando review. Do not submit until Brando confirms final links and whether to mention the parallel Sanmi / STAIR PI-track application.

Last updated: May 15, 2026.

Track: Rising Mathematician.

## Curation TL;DR

Use the Rising Mathematician track for Brando's individual student application. The key story is:

> I am a Stanford CS Ph.D. student working at the intersection of Lean 4, formal verification, and AI evaluation. I lead VeriBench, co-founded and run Stanford AI for Lean, publish public writing about formal methods as scalable oversight, and build/share workflows for using AI agents with correctness gates. Aristotle access would let me push realistic Lean 4 verification tasks further while sharing the lessons publicly with students and researchers.

This is complementary to the Sanmi / STAIR PI-track draft in `../06_aristotle_harmonic_grant/`: Brando's application is the student-facing exploration/community application; Sanmi's is the faculty-led research-infrastructure application.

## 1. Tell Us About Yourself

Name: Brando Miranda

Email: brando9@stanford.edu

Personal Website: https://brando90.github.io/brandomiranda/

X Profile: https://x.com/BrandoHablando

Institution: Stanford University

Current role: Ph.D. student in Computer Science, advised by Prof. Sanmi Koyejo in the Stanford Trustworthy AI Research group.

## 2. Which Sponsorship Are You Applying For?

Answer: Rising Mathematician.

Optional note if the form allows clarification:

I am applying as a student researcher. I am currently a Stanford CS Ph.D. student rather than an undergraduate, but the Rising Mathematician track is the best fit for this individual application because it asks about personal exploration, project building, AI/formal-verification tool use, and sharing what I learn. A separate PI-track draft exists for Prof. Sanmi Koyejo / STAIR if Harmonic wants to support the broader research-group infrastructure around the same agenda.

## 3. Tell Us More About Your Interest In Mathematics And AI

My interest in mathematics and AI is centered on one question: when an AI system claims to have reasoned correctly, what would make that claim trustworthy?

Lean 4 is the most compelling answer I know. It lets us move from plausible explanations to machine-checkable artifacts: theorem statements, proof terms, specifications, and verified code. I am especially interested in the interface between informal mathematical intuition, software specifications, and formal proof. In practice, this means building benchmarks, workflows, and communities where AI systems must produce outputs that survive deterministic verification rather than merely look convincing.

At Stanford, I work on AI for formal mathematics, Lean 4 theorem proving, autoformalization, and end-to-end formal verification of software and mathematics. I also co-founded and serve as president of Stanford AI for Lean, a student research community focused on Lean 4, AI-assisted theorem proving, formal verification, and trustworthy machine reasoning. I have tried to make my own learning public: tutorial videos, code repositories, essays, and research artifacts that let other students get started faster.

## 4. Project Link I Am Most Proud Of

Project: VeriBench

Link: https://openreview.net/forum?id=rWkGFmnSNl

VeriBench is the Lean 4 benchmark I lead at Stanford for end-to-end formal verification of real code. The motivation is simple: if we want AI systems to generate trustworthy software, we need benchmarks where success means producing code, specifications, and proofs that actually check.

I chose VeriBench because verified software is one of the highest-leverage applications of formal methods. A proof assistant is not just a math toy; it can become a correctness layer for code that people actually rely on. That is why VeriBench includes Python standard-library routines, classical algorithms, and security-relevant examples inspired by MIT 6.858, rather than only synthetic LeetCode-style exercises. The benchmark asks models to operate across the whole verification stack: understand an informal problem, write Lean code, state the right theorem, and prove it.

The part I am proudest of is the evaluation design. Formal verification has an all-or-nothing character: if the theorem is wrong, the code is disconnected from the theorem, or the proof fails, the result should not count as verified. VeriBench captures this with SCSC, the Smooth Conjunctive Score for Code verification: a five-factor geometric mean that rewards progress across the relevant dimensions but collapses when a required verification component is missing. This gives a smoother research signal without losing the semantics of formal verification.

VeriBench was presented at the 2nd AI for Math Workshop at ICML 2025 with reviewer recommendation "Accept (Oral, Top 1)" and is part of my broader effort to make AI-for-formal-methods progress measurable, reproducible, and useful to people building real systems.

Shorter paste option:

> I am most proud of VeriBench, a Lean 4 benchmark I lead at Stanford for end-to-end formal verification of real code. It asks AI systems to generate Lean implementations, specifications, and proofs for realistic Python standard-library, algorithmic, and security-relevant tasks. I chose it because verified software is one of the highest-leverage applications of formal methods: progress should be measured by artifacts that actually check, not by plausible explanations or toy exercises. The benchmark's SCSC metric enforces the conjunctive nature of verification while still giving a smooth research signal across code, specification, theorem, proof, and consistency dimensions.

## 5. Blog Post, Thread, Or Community Discussion

If the form allows one link, use the formal-methods post:

https://brando90.github.io/brandomiranda/2026/04/22/formal-methods-scalable-oversight.html

"Asking the Right Question: Formal Methods as Scalable Oversight" explains why I think formal verification is becoming a practical oversight mechanism for AI agents. The core idea is: let the verifier check the answer; let the human check the question. As AI systems produce longer proofs, code, and research artifacts, the human bottleneck should shrink from checking every generated step to checking short, human-readable formal specifications and theorem statements.

If the form allows two links, include this second one:

https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html

"What I Learned Building a Correctness-Gated Multi-Agent Workflow for Research" describes how I use AI coding agents in daily research while making model mistakes cheap to detect. The workflow uses cross-agent review, structural QA, repository rules, and Lean 4-style correctness gates. I also released the setup as an open-source documentation architecture, `agents-config`, because the process matters as much as the model: the right question is not just "which model is best?" but "what workflow makes mistakes visible before they compound?"

Additional public learning resource if useful:

- Learning Lean 4 tutorial playlist: https://www.youtube.com/playlist?list=PLB3sDpSRdrOt68MTR6kdI0Jc85Uuw1YWV
- Code repository: https://github.com/brando90/learning_lean/tree/main
- X announcement: https://x.com/BrandoHablando/status/1763698776378843495

## 6. Optional: Resume Or Other Information

CV (long form): https://brando90.github.io/brandomiranda/professional_documents/cvs/cv_long.pdf

CV (short form): https://brando90.github.io/brandomiranda/professional_documents/cvs/cv_short.pdf

Google Scholar: https://scholar.google.com/citations?user=_NQJoBkAAAAJ&hl=en

Stanford AI for Lean: https://www.stanfordlean.club/

Personal website: https://brando90.github.io/brandomiranda/

Additional context at a glance:

- Stanford CS Ph.D. student advised by Prof. Sanmi Koyejo in the Stanford Trustworthy AI Research group.
- Co-founder and president of Stanford AI for Lean, a student research community advancing AI for Lean theorem proving and formalizing mathematics.
- First author / lead on VeriBench, an end-to-end Lean 4 benchmark for formal verification of AI-generated code; presented at the 2nd AI for Math Workshop at ICML 2025 with reviewer recommendation "Accept (Oral, Top 1)."
- Contributor to Putnam-AXIOM, an ICML 2025 benchmark for higher-level mathematical reasoning in LLMs.
- Co-author of Pantograph, a TACAS 2025 machine-to-machine interaction interface for Lean 4 theorem proving and proof search.
- Contributor to Morph Prover v0 7B and Moogle.ai at Morph Labs, connecting Lean proof models with search over verified code.
- Co-author of "Are Emergent Abilities of Large Language Models a Mirage?", which received the NeurIPS 2023 Outstanding Main Track Paper Award (top 0.4%, 2 papers selected) and was covered by The New York Times, Quanta Magazine, Forbes, Stanford HAI, and the 2024 Economic Report of the President.
- Stanford School of Engineering Fellow and EDGE Scholar.

## 7. Sanmi / STAIR PI-Track Relationship

Do not paste this unless the application asks for relationship to a PI or broader project.

Brando's Rising Mathematician application and Prof. Sanmi Koyejo's PI-track application should be framed as complementary. The Rising Mathematician application is Brando's individual student application centered on learning, building, and sharing AI/formal-math tools. The PI-track application is a broader STAIR research-infrastructure proposal for proof-carrying AI: benchmarks, Lean workflows, Aristotle evaluations, student support, and public research artifacts under faculty supervision and Stanford routing.

If Harmonic prefers a single combined application, the clean fallback is to submit the PI-track application with Brando named as student research lead. If Harmonic welcomes both, Brando's application can show the student/community surface while Sanmi's application shows the lab-scale research program.

## 8. One-Paragraph Version

I am a Stanford CS Ph.D. student advised by Prof. Sanmi Koyejo, working on AI for formal mathematics, Lean 4 theorem proving, autoformalization, and verified code generation. I co-founded and serve as president of Stanford AI for Lean, and I try to make the field accessible through public writing, Lean tutorials, and open research artifacts. The project I am most proud of is VeriBench, a Lean 4 benchmark for end-to-end formal verification of real code, because it turns AI evaluation from "does this answer look plausible?" into "does this artifact actually check?" Aristotle access would let me stress-test frontier formal-reasoning systems on realistic Lean workflows and share the results with the Stanford AI for Lean community and the broader AI-for-math ecosystem.

## 9. Final Submission Checklist

- Confirm whether Harmonic wants `twitter.com` or `x.com`; current draft uses `x.com`.
- Confirm whether the form allows a Ph.D. student under Rising Mathematician. If not, route Brando through Sanmi's PI-track application.
- Confirm final date line; this draft uses May 2026.
- Confirm whether to mention the parallel PI-track application.
- Confirm which CV link to attach: long CV is strongest; short CV may be more reviewer-friendly.
- Confirm whether to include both blog posts or only one.
- Confirm whether to include Learning Lean 4 playlist as additional public-sharing evidence.
