---
layout: post
title: "What I Learned Building a Correctness-Gated Multi-Agent Workflow for Research"
date: 2026-04-13
---

*Brando Miranda — April 2026*

**TL;DR.** The right question with AI coding agents isn't "which model is best?" — it's "what process makes model mistakes cheap to detect?" I built a modular, correctness-gated multi-agent workflow (cross-agent review, structural QA, formal verification via Lean) and published the setup as an open-source documentation architecture called [agents-config](https://github.com/brando90/agents-config).

Over the past year I've been working on a simple question: how do you use coding agents for serious work without letting them quietly degrade quality?

The question matters to me because my research sits at the intersection of AI, mathematics, and formal verification. I build tools for theorem proving in Lean 4, benchmarks for mathematical reasoning, and interfaces that let AI systems interact with proof assistants. Fluent output is not enough in that world. Proofs either check or they don't. That standard has shaped how I think about AI-assisted work more broadly.

## Why structure matters

I generate a lot of ideas. I always have. The arrival of coding agents meant I could finally act on most of them — spinning up prototypes, drafting papers, building tools — at a pace that wasn't possible before. But I noticed something quickly: the more I used agents without structure, the more time I spent cleaning up after them. Code got verbose. Quality drifted. Subtle bugs compounded. The agents were fast, but unstructured speed was creating a maintenance tax I couldn't afford.

That observation changed how I work. I stopped treating agents as one-shot chat assistants and started treating them as components in a structured, correctness-gated process.

## What I built

The result is [agents-config](https://github.com/brando90/agents-config), a public, open-source documentation architecture for multi-agent coding workflows.

The design has three layers. Agent-specific entry points (`claude.md`, `agents.md`) that just say "read the index." A shared, agent-agnostic routing table (`INDEX_RULES.md`) containing global rules and pointers. And scoped documentation organized by domain — machine configs, workflow guides, QA protocols, coding conventions — loaded only when relevant.

The key insight is that as codebases scale, one monolithic instruction file becomes noisy and brittle. A modular setup where agents only load context relevant to the current task is more maintainable and more reusable across projects. I made it public because I love sharing what I build — I put everything out there, from Lean tutorials to dance classes — and because if my setup isn't the best, I want to know. Publishing invites scrutiny, and scrutiny is how you improve.

I co-authored the repo with Claude, Codex, and Cursor. I listed all three models as co-authors in the citation without apology — not just because transparency matters, but because I think this is where the future is heading: humans choose the problems and supply the creativity; AI executes from the best available knowledge. The collaboration is genuinely complementary, and pretending otherwise helps no one. Credit also goes to [Yegor Denisov-Blanch](https://www.yegordb.com/), whose original insight about modular, agent-agnostic documentation and whose consistent, creative conversations about software engineering have shaped this workflow into what it is.

## How the workflow actually runs

In practice, my daily process has a few layers:

**Parallel execution.** I run multiple agents simultaneously in byobu sessions with git worktrees, each scoped to a different task branch. Amphetamine keeps machines alive overnight so agents run unattended. Remote access lets me babysit all of them from anywhere — checking progress, unblocking stalls, and verifying outputs from my phone or laptop regardless of which machine or GPU cluster the work is running on. I'm never not making progress — some of my best work sessions happen at the pool with a MacBook Air and a portable monitor. A good workflow is both robust enough to run from anywhere and creative enough to question where "anywhere" should be.

**Cross-agent review.** Every PR goes through a multi-agent QA pipeline — Claude Code, Codex, and Gemini each review independently, flag issues, and the authoring agent corrects until the reviewers pass it. No single model catches everything. The ensemble matters.

**Structural QA.** Recent research shows agent-generated code degrades monotonically over long trajectories — growing more verbose, less reusable, and increasingly duplicated in 80% of cases (Orlanski et al., 2026). I added a structural refactoring pass that specifically targets this erosion, codified in a reusable workflow doc.

**Formal verification.** For my theorem-proving work, Lean 4 provides a ground truth that no amount of LLM confidence can substitute. I co-authored [Pantograph](https://github.com/stanford-centaur/PyPantograph) (TACAS 2025), a machine-to-machine interface for Lean 4 that enables AI proof search via Monte Carlo Tree Search. Verification is the ceiling.

**Human judgment.** Collaborators help curate and verify pull requests. Agents draft; humans decide. The point of the whole system is not to automate judgment away — it's to make judgment cheaper and more targeted.

## What I learned

Three things.

**The main question is not "which model is best?" It's "what process makes model mistakes cheap to detect?"** That shift made me dramatically more productive. It lowered the cost of turning ideas into working prototypes — and I'm constantly thinking about how to lower the cost of oversight itself.

**Context architecture matters as much as model capability.** A writing task shouldn't load cluster setup docs. A refactor shouldn't load unrelated project history. Modular context is a multiplier.

**Rigorous work benefits from explicit gates.** Agent output should pass through scrutiny, not go straight to acceptance. In some settings that means tests and static checks. In others — especially near formal methods — it means using Lean or other verification tools as part of the loop.

## What's next: scalable oversight without gold references

The workflow above uses existing verification tools. But as AI systems generate more code and formalizations, the bottleneck shifts from generation to oversight — and the problem is the same in both domains. In formal math, Lean's kernel checks proofs trivially, but evaluating whether the *theorem statement itself* faithfully captures the intended mathematics cannot be automated with a type-checker. In code verification, the analogous risk is that models write vacuous tests (`assert True`), prove trivially true specs (`False → True`), or quietly delete the test suite to make CI pass. In both cases, the output *looks* correct to automated checks but is substantively empty. Scalable oversight without gold references is the core challenge. My current research targets this directly. I'm working on certificate-based methods that test whether an AI judge satisfies formal properties a correct evaluator *must* have — monotonicity, reflexivity, stability under perturbation — so you can detect unreliable judgments cheaply, without ground truth. This builds on complementary work from my lab on distributional reliability metrics for LLM evaluation. The plan is to integrate these signals into the agentic workflow itself: not just static checks and cross-agent review, but formal certificates that flag likely-wrong outputs before a human ever looks at them. Longer-term, I want the workflow to self-improve — rules and QA protocols that rewrite themselves based on what the gates catch, so the system compounds with every run. This idea isn't new (Garry Tan's [recent post](https://x.com/garrytan/status/2042925773300908103) on self-improving skill files describes the same pattern), but applying it with formal-verification-grade rigor is unexplored territory.

## The connection to math and formal verification

This workflow is not separate from my research interests. It's an extension of them. I care about theorem proving and verified code because they force us to take reasoning seriously. They also make it obvious that fluent output is not enough.

That's why I founded [Stanford AI for Lean](https://aiforlean.org/) — a student-led research community focused on AI-assisted theorem proving and formal verification. And it's why I think the future of AI-assisted work will belong less to people who merely use agents and more to people who learn to structure them well: modular, correctness-gated, built in public, and always subject to verification.

---

*[agents-config](https://github.com/brando90/agents-config) is open source under Apache 2.0. Contributions welcome.*

*[Stanford AI for Lean](https://aiforlean.org/) — Formalizing the future of mathematics.*

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026correctnessgated,
  author = {Miranda, Brando},
  title  = {What I Learned Building a Correctness-Gated Multi-Agent Workflow for Research},
  year   = {2026},
  month  = {April},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html}},
  note   = {Blog post}
}
```
