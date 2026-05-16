# Harmonic / Aristotle Rising Mathematician Application - Brando Miranda

Status: final paste-ready draft for Brando review.

Last updated: May 16, 2026.

Track: Rising Mathematician.

## Final Recommendation

Submit the Rising Mathematician application as an individual student-builder application. Do not mention the parallel Sanmi / STAIR PI-track draft unless the form explicitly asks about a PI, research group, or related application.

The strongest story is:

> I am a Stanford CS Ph.D. student working where AI meets Lean 4, formal verification, and mathematical reasoning. I build public artifacts - VeriBench, Stanford AI for Lean, Lean tutorials, essays, talks, and code - that move AI reasoning from plausible text toward machine-checkable proof. Aristotle support would let me explore the limits of next-generation formal-reasoning models on realistic Lean workflows and share what I learn with students and the broader AI-for-math community.

This directly matches Harmonic's Rising Mathematician criteria:

- History of exploration in math or an adjacent field: Lean 4, VeriBench, Putnam-AXIOM, Pantograph, Morph Prover, formal verification.
- Demonstrated interest in the future of math and AI: research agenda centered on AI for formal mathematics and proof-carrying reasoning.
- Builds in public: Stanford AI for Lean, Learning Lean 4 playlist, public writing, open-source workflows, talks, and student mentoring.

## Copy-Paste Application

### 1. Tell us about yourself

Name: Brando Miranda

Email: brando9@stanford.edu

Personal Website: https://brando90.github.io/brandomiranda/

X Profile: https://x.com/BrandoHablando

Institution: Stanford University

Current role: 4th-year Ph.D. student in Computer Science, advised by Prof. Sanmi Koyejo in the Stanford Trustworthy AI Research group.

### 2. Which sponsorship are you applying for?

Rising Mathematician.

I am applying as an individual student researcher. I am a Stanford CS Ph.D. student rather than an undergraduate, but the Rising Mathematician track is the best fit for this application because it is centered on personal exploration, building with AI and formal verification tools, and sharing that process publicly.

### 3. Tell us more about your interest in mathematics and AI

What I find most interesting in mathematics and AI is the moment when a plausible explanation becomes a machine-checkable artifact. Lean 4's kernel gives us a standard that ordinary AI benchmarks do not: a generated theorem, proof, or verified program either checks or it does not. That is the through-line behind my current research and public work: VeriBench, Stanford AI for Lean, Lean 4 tutorials, and essays about formal methods as scalable oversight for AI agents.

My personal exploration has moved from asking whether language models can look mathematically competent to asking whether they can produce artifacts that deserve trust. I am especially interested in the interface between informal mathematical intuition, software specifications, and formal proof. In practice, this means building benchmarks and workflows where AI systems must state the right theorem, write the right code, and produce a proof that survives deterministic verification.

If selected, I would use Aristotle access and support to stress-test next-generation formal-reasoning models on realistic Lean 4 tasks: verified-code generation, theorem statement quality, proof repair, and multi-step agent workflows. I would share the lessons through Stanford AI for Lean, public write-ups, tutorial material, and open research artifacts so other students can learn from both the successes and the failure modes.

### 4. Relevant project I am most proud of

Project: VeriBench

Link: https://openreview.net/forum?id=rWkGFmnSNl

VeriBench is a Lean 4 benchmark I lead at Stanford for end-to-end formal verification of real code. It asks AI systems to generate Lean implementations, specifications, theorems, and proofs for realistic tasks drawn from Python standard-library routines, classical algorithms, and security-relevant examples inspired by MIT 6.858.

I chose VeriBench because verified software is one of the highest-leverage applications of formal methods. If AI systems are going to write code that people rely on, we should evaluate them with proof obligations that actually check, not only with final-answer benchmarks or toy programming tasks. The benchmark deliberately includes tasks where universally quantified "no failure ever" properties are exactly where formal methods shine.

The part I am proudest of is the evaluation design. Formal verification is conjunctive: the code, theorem, specification, proof, and consistency all have to line up. VeriBench captures this with SCSC, the Smooth Conjunctive Score for Code verification, a five-factor geometric mean that gives models a smooth research signal while preserving the all-or-nothing semantics of verification. One missing verification component should collapse the score, because one broken link means the artifact is not actually verified.

VeriBench received reviewer recommendation "Accept (Oral, Top 1)" at the 2nd AI for Math Workshop at ICML 2025. More importantly, it is the kind of benchmark I want the field to build more of: realistic, proof-checked, reproducible, and hard to game with plausible-looking text.

### 5. Blog post, thread, or community discussion

I would include two links if the form allows it.

First, a mathematical / conceptual post:

https://brando90.github.io/brandomiranda/2026/04/22/formal-methods-scalable-oversight.html

"Asking the Right Question: Formal Methods as Scalable Oversight" explains why I think Lean-style verification is becoming a practical oversight mechanism for AI agents. The thesis is: let the verifier check the answer; let the human check the question. As AI systems generate longer proofs, programs, and research artifacts, the human bottleneck should move from checking every generated step to checking the short, human-readable theorem statement or specification.

Second, a tool-use / build-in-public post:

https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html

"What I Learned Building a Correctness-Gated Multi-Agent Workflow for Research" describes how I use AI coding agents in daily research while making mistakes cheap to detect. The workflow uses cross-agent review, structural QA, repository rules, and Lean 4-style correctness gates. I also released the setup as an open-source documentation architecture called agents-config, because the process matters as much as the model: the right question is not only "which model is best?" but "what workflow makes mistakes visible before they compound?"

Additional public learning resources:

- Learning Lean 4 tutorial playlist: https://www.youtube.com/playlist?list=PLB3sDpSRdrOt68MTR6kdI0Jc85Uuw1YWV
- Companion code repository: https://github.com/brando90/learning_lean/tree/main
- Stanford AI for Lean: https://www.stanfordlean.club/

### 6. Optional: resume or other information

CV (long form): https://brando90.github.io/brandomiranda/professional_documents/cvs/cv_long.pdf

CV (short form): https://brando90.github.io/brandomiranda/professional_documents/cvs/cv_short.pdf

Google Scholar: https://scholar.google.com/citations?user=_NQJoBkAAAAJ

Stanford AI for Lean: https://www.stanfordlean.club/

Personal website: https://brando90.github.io/brandomiranda/

Current role: 4th-year Stanford CS Ph.D. student advised by Prof. Sanmi Koyejo, Stanford Trustworthy AI Research (STAIR). Stanford School of Engineering Fellow; EDGE Scholar.

Selected credentials:

- Co-founder and president of Stanford AI for Lean, a student research community focused on Lean 4, AI-assisted theorem proving, formal verification, and trustworthy machine reasoning.
- First author / lead on VeriBench, an end-to-end Lean 4 benchmark for formal verification of AI-generated code; reviewer recommendation "Accept (Oral, Top 1)" at the 2nd AI for Math Workshop at ICML 2025.
- Co-first author on Putnam-AXIOM, an ICML 2025 Main Track benchmark for higher-level mathematical reasoning in LLMs.
- Co-author of Pantograph, a TACAS 2025 machine-to-machine interaction interface for Lean 4 theorem proving and proof search.
- Contributor to Morph Prover v0 7B and Moogle.ai at Morph Labs, connecting Lean proof models with search over verified Lean code.
- AAAI 2026 tutorial speaker on trustworthy machine reasoning with AI coding agents.
- ICML 2026 Silver Reviewer, a top reviewer recognition signed by the ICML Program Chairs.
- Stanford CS 197 Course Assistant for 3 quarters and Instructor of Record for the Spring offering; mentored undergraduate research projects that produced 2 workshop publications.
- Co-author of "Are Emergent Abilities of Large Language Models a Mirage?", which received the NeurIPS 2023 Outstanding Main Track Paper Award and was covered by The New York Times, Quanta Magazine, Forbes, Stanford HAI, and the 2024 Economic Report of the President.

How I share what I learn:

- I run Stanford AI for Lean and organize community learning around Lean 4, formal verification, and AI theorem proving.
- I publish public Lean tutorials, code repositories, and research-engineering workflows so other students can reproduce what I am learning.
- I write public essays on formal methods as scalable oversight, correctness-gated AI-agent workflows, and how to use AI systems without losing correctness discipline.
- I give talks on VeriBench, Lean 4, emergent abilities, and trustworthy machine reasoning, including Lawrence Livermore National Laboratory, Hong Kong Baptist University, Stanford IEEE, Prof. Azalia Mirhoseini's Stanford lab meeting, and the AAAI 2026 tutorial.

## Shorter Version If The Form Has Tight Limits

### Interest in mathematics and AI

I am interested in the moment when plausible AI reasoning becomes a machine-checkable artifact. Lean 4's kernel gives us a standard ordinary benchmarks do not: a generated theorem, proof, or verified program either checks or it does not. My current work asks whether AI systems can produce artifacts that deserve trust, not merely explanations that sound mathematical. I explore this through VeriBench, Stanford AI for Lean, public Learning Lean 4 tutorials, and writing about formal methods as scalable oversight for AI agents. With Aristotle access, I would stress-test next-generation formal-reasoning models on realistic Lean 4 workflows and share the results publicly with students and researchers.

### Project

I am most proud of VeriBench: https://openreview.net/forum?id=rWkGFmnSNl. VeriBench is a Lean 4 benchmark I lead at Stanford for end-to-end formal verification of real code. It asks AI systems to generate Lean implementations, specifications, theorems, and proofs for realistic Python, algorithmic, and security-relevant tasks. I chose it because verified software is one of the highest-leverage applications of formal methods, and progress should be measured by artifacts that actually check. Its SCSC metric captures the conjunctive nature of verification while still giving models a smooth research signal. VeriBench received "Accept (Oral, Top 1)" recommendation at the 2nd AI for Math Workshop at ICML 2025.

### Public sharing

I build in public through Stanford AI for Lean, a student research community I co-founded and run; a Learning Lean 4 YouTube tutorial playlist with companion code; public essays on formal methods and correctness-gated AI workflows; and talks at Stanford, LLNL, HKBU, Stanford IEEE, and AAAI 2026.

## Pre-Submission Checklist

- Use `x.com/BrandoHablando`, not `twitter.com`.
- Use Google Scholar ID `_NQJoBkAAAAJ`.
- Use the `professional_documents/cvs` CV URLs unless the website publishing path changes.
- Do not mention the Sanmi / STAIR PI-track application in the submitted Rising Mathematician text unless explicitly asked.
- If the form allows only one blog/community link, use the formal-methods post first.
- If the form allows one upload, use the short CV for speed and the long CV link in the text.
- If the form asks whether you are undergraduate, be direct: "I am a Stanford CS Ph.D. student applying as an individual student researcher."
