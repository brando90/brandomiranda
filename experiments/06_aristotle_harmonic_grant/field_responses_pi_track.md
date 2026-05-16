# Aristotle / Harmonic PI-Track Application Responses

Status: draft for Sanmi / STAIR review. Do not submit without Sanmi's approval and Stanford routing review.

Last updated: May 15, 2026.

## Coordination With Brando Rising Mathematician Application

There is now a separate student-track draft at `../07_aristotle_harmonic_rising_mathematician/brando_rising_mathematician_application.md`.

If both applications are submitted, the distinction should be explicit:

- This PI-track application is the lab-scale research-infrastructure proposal: faculty-led STAIR work on proof-carrying AI, benchmark engineering, Aristotle evaluation, student support, and Stanford routing/compliance.
- Brando's Rising Mathematician application is the individual student application: VeriBench, public Lean learning, Stanford AI for Lean community building, and essays/workflows about formal methods and AI agents.

If Harmonic prefers only one application, the safer combined route is this PI-track application with Brando named as student research lead.

## Recommended Project Title

Proof-Carrying AI for Mathematics and Software: Benchmarks, Agents, and Trust Boundaries in Lean

## Recommended Funding Ask

$150,000 for a 12-month PI-led research sprint, plus access to next-generation Aristotle models.

Rationale: this is large enough to support serious student research effort, benchmark engineering, compute/API usage, and a small Lean research program, while still being realistic inside a $1,000,000 sponsorship pool. If Sanmi or Stanford wants a smaller request, the clean fallback is $75,000 for a seed version. If Harmonic wants flagship PI projects, the expanded request is $250,000.

## Field 1: Tell Us About The Project

Prof. Sanmi Koyejo's Stanford Trustworthy AI Research group proposes to build proof-carrying AI infrastructure for evaluating and improving AI systems that reason in Lean. The project targets a central bottleneck in AI for mathematics and verified software: frontier models can now produce plausible mathematical arguments, code, and proof sketches, but plausibility is not trust. A proof assistant changes the standard. In Lean, an AI system must produce an artifact that passes deterministic checking against an explicit formal specification.

We will develop open benchmarks, evaluation harnesses, and agent workflows for measuring whether AI systems can generate Lean-checked mathematics and formally verified code. The project builds on Stanford-led and STAIR-adjacent work including VeriBench-DT, VeriBench-Deps, proof-based AI coding benchmarks, Stanford AI for Lean, and emerging Lean repositories in the Stanford Lean Club organization. The unifying question is: when an AI system claims to have solved a mathematical or software-correctness task, can it produce a machine-checkable certificate that survives a real verifier?

The research has three thrusts.

First, we will expand proof-based evaluation for AI coding. VeriBench-DT tests whether an agent-generated Lean formalization is behaviorally faithful to the original Python source by differential testing the Python implementation, the gold Lean reference, and the model's Lean output. This closes a failure mode we call hallucinated validity: the model can produce code and proofs that look valid while silently proving the wrong thing. We will develop the benchmark, harden the cross-language harness, and evaluate frontier proof agents on end-to-end code-to-Lean reliability.

Second, we will study repository-level autoformalization through VeriBench-Deps. Real software has dependencies: internal modules, external libraries, file systems, HTTP calls, databases, and mutable state. Agents must decide what to implement, what to axiomatize, and where the trust boundary lies. VeriBench-Deps introduces the Axiom Trust Boundary, a deterministic metric computed from Lean's `#print axioms`, and a 2x2 dependency taxonomy that predicts when an agent should prove, assume, or model IO. This lets us measure not only whether a proof checks, but what the proof actually depends on.

Third, we will use Stanford AI for Lean under STAIR as a research training and artifact-production engine. Students will work on Lean formalization tasks, proof-agent workflows, CSLib-style formal libraries, software verification, Erdős-problem formalization, and evaluation infrastructure. The goal is not a one-off demo. The goal is a reusable research ecosystem: datasets, Lean environments, proof-agent logs, metrics, technical reports, and papers that make progress in AI for formal mathematics measurable.

Sanmi is the right PI because STAIR studies trustworthy AI and AI measurement science: how to evaluate capabilities, limitations, reliability, and failure modes of AI systems. This proposal brings that measurement-science lens to formal reasoning. Brando Miranda, a Stanford CS Ph.D. student advised by Prof. Koyejo, would help lead execution, building on his work in Lean 4, autoformalization, verified code generation, contamination-resistant evaluation, and proof-based AI coding benchmarks.

## Field 2: Share A Description, Existing Website, Proposal, Or Similar

Project description and relevant public context:

- Aristotle / Harmonic sponsorship page: https://aristotle.harmonic.fun/sponsorships
- Stanford Lean Club: https://www.stanfordlean.club/
- Stanford Lean Club repositories: https://github.com/orgs/StanfordLeanClub/repositories
- VeriBench-DT: https://github.com/brando90/veribench-dt
- VeriBench-Deps: https://github.com/brando90/veribench-deps/tree/e3d26b4d8f5e88dd2a8fd2ecc290a0f0c6dd39a4
- Proof-based AI coding benchmark paper: https://cs.stanford.edu/~daneshva/publications/ai-coding-benchmarks-need-proofs-not-just-tests.pdf
- Prof. Sanmi Koyejo profile: https://profiles.stanford.edu/sanmi-koyejo
- STAIR: https://stair.cs.stanford.edu/

Short description to paste if the form prefers prose:

We are requesting support for a STAIR-led research program on proof-carrying AI: AI systems that produce Lean-checkable certificates for mathematics and software correctness. The project combines benchmark design, Lean 4 proof-agent evaluation, repository-level autoformalization, and student research infrastructure. Existing pieces include VeriBench-DT for differentially testing code-to-Lean formalizations against original Python behavior, VeriBench-Deps for measuring axiom trust boundaries in multi-file Python-to-Lean projects, and a Stanford-led position paper arguing that AI coding benchmarks need proofs, not just tests. Aristotle access would let us evaluate and improve frontier formal-reasoning systems on realistic Lean tasks rather than only final-answer math benchmarks.

## Field 3: How Much Funding Are You Requesting? How Will The Money Be Used?

We request $150,000 for a 12-month PI-led research sprint, plus access to next-generation Aristotle models.

The funding would be used for:

- Student research support for Brando Miranda and student collaborators working on Lean 4 benchmarks, proof-agent workflows, and verified-code evaluation.
- Benchmark and artifact engineering for VeriBench-DT, VeriBench-Deps, and related proof-based AI coding evaluations.
- Compute, API, and model-evaluation costs for running controlled experiments across Aristotle and other frontier proof agents.
- Lean infrastructure maintenance, including reproducible environments, proof-agent logs, dataset packaging, and deterministic evaluation scripts.
- Small STAIR / Stanford AI for Lean technical activities: focused reading groups, implementation sprints, student onboarding material, and invited technical discussions with Lean and formal-methods researchers.
- Dissemination through public technical reports, benchmark releases, and workshop or conference submissions where appropriate.

If selected, the support would be administered subject to Stanford policies and the appropriate routing mechanism. The project would not imply Stanford endorsement, exclusive access to students, control over research conclusions, or use of Stanford marks beyond what Stanford explicitly authorizes.

## Field 4: Will Aristotle Help Accelerate Your Research? How Do You Plan On Using It?

Yes. Aristotle is directly aligned with the research because the central object of study is not generic chatbot reasoning; it is AI systems that can operate in Lean and produce checkable proof artifacts.

We would use Aristotle in four concrete ways.

First, we would evaluate Aristotle on proof-carrying code tasks. In VeriBench-DT, Aristotle would be asked to translate Python programs into Lean implementations, specifications, tests, and proofs. We would then measure whether the generated Lean output agrees with the original Python behavior through differential testing, whether the theorems prove, and whether the proof artifacts are semantically connected to the source code.

Second, we would evaluate Aristotle on repository-level autoformalization. In VeriBench-Deps, Aristotle would receive multi-file Python projects with internal and external dependencies. We would measure whether it chooses the right formalization strategy: implementing internal pure dependencies, axiomatizing external pure libraries, modeling external IO with explicit boundaries, and using transition axioms for internal effectful modules. Lean's `#print axioms` would let us quantify the Axiom Trust Boundary: exactly what each proof depends on.

Third, we would use Aristotle as a proof-agent component inside reproducible Lean workflows. We want to study complete trajectories: theorem statement generation, proof search, error repair, dependency selection, axiom introduction, and final verification. This gives a much richer picture than pass/fail final answers.

Fourth, we would deploy Aristotle access in STAIR / Stanford AI for Lean research sprints, where students work on Lean formalization, software verification, CSLib-style library development, and mathematical formalization projects such as the Stanford Lean Club Erdős-problem repository. This would create a feedback loop between frontier model access and a trained student research community.

The expected output is not a private demo. It is a set of reusable benchmarks, evaluation protocols, error taxonomies, and technical results that help Harmonic and the broader research community understand where AI-assisted formal reasoning genuinely works, where it fails, and what capabilities are needed next.

## Shorter Paste Option

Prof. Sanmi Koyejo's STAIR group at Stanford proposes to build proof-carrying AI infrastructure for Lean: benchmarks, agent workflows, and evaluation metrics that test whether AI systems can produce machine-checkable mathematical and software-correctness artifacts. The project builds on VeriBench-DT, VeriBench-Deps, proof-based AI coding benchmarks, and Stanford AI for Lean. We request $150,000 over 12 months, plus access to next-generation Aristotle models, to support student research, benchmark engineering, compute/API evaluation, Lean infrastructure, and technical research sprints. Aristotle would be evaluated on realistic Lean tasks including Python-to-Lean verification, repository-level autoformalization, theorem generation, proof repair, and axiom-trust-boundary measurement via Lean's `#print axioms`.

## Cert-Judge Insertion Point

TODO after Brando shares Cert-Judge context:

- Add one paragraph connecting Cert-Judge to proof-carrying AI evaluation.
- Decide whether Cert-Judge is a workstream, a metric layer, or a related artifact.
- If Cert-Judge handles certificates beyond Lean proofs, explain how it complements Aristotle: Lean for formal proof checking, Cert-Judge for evaluating the validity, provenance, or sufficiency of broader machine-generated certificates.

## What To Verify Before Submission

- Confirm Sanmi wants to be PI and approves the exact framing.
- Confirm whether the project should be described as STAIR-led, Stanford AI for Lean under STAIR, or both.
- Confirm the exact funding amount and Stanford routing mechanism.
- Confirm whether to attach Sanmi's current CV, the older local CV PDF, or a Stanford profile link.
- Confirm whether Harmonic permits public release of model-specific evaluation results.
- Replace any private or not-yet-public project links if needed.
