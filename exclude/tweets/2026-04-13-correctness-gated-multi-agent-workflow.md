# Tweet drafts — "What I Learned Building a Correctness-Gated Multi-Agent Workflow for Research"

**Post URL:** https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html

**Handle:** @BrandoHablando

**Anchor takeaway:** The right question isn't "which model is best?" — it's "what process makes model mistakes cheap to detect?" Open-sourced the setup as `agents-config`.

---

## Single-tweet options

### A — The reframe (strongest default)

```
After a year of using coding agents for real research, the question that reframed everything:

Not "which model is best?" but "what process makes model mistakes cheap to detect?"

Writeup + the open-source docs setup I built:
https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html
```

### B — The concrete workflow (best for engineers)

```
My current coding-agent workflow:

- Agents in parallel (byobu + git worktrees)
- Every PR reviewed by Claude Code, Codex, Gemini
- Structural refactor pass to fight agent code rot
- Lean as ground truth where it applies

Writeup:
https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html
```

### C — Context architecture (good for the AGENTS.md crowd)

```
One monolithic CLAUDE.md / AGENTS.md gets noisy and brittle as a codebase scales.

Context architecture matters as much as model capability — still underappreciated.

Open-sourced the modular setup I use. What does yours look like?
https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html
```

### D — No-single-model-catches-everything (contrarian-ish)

```
No single model catches everything. That's why I run Claude Code, Codex, and Gemini as independent reviewers on every PR, and have the authoring agent correct until all three pass.

Ensemble > picking a favorite.

Workflow writeup:
https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html
```

---

## Thread option (5 tweets)

**1/**
```
After a year of using coding agents for serious research, the question I stopped asking is "which model is best?"

The one that made me dramatically more productive: what process makes model mistakes cheap to detect?
```

**2/**
```
Unstructured speed creates a maintenance tax. Agents are fast, but without gates the code gets verbose, quality drifts, subtle bugs compound. I stopped treating them as one-shot chat and started treating them as components in a correctness-gated process.
```

**3/**
```
In practice: multi-agent parallel execution (byobu + git worktrees), cross-agent PR review (Claude Code + Codex + Gemini — no single model catches everything), a structural refactor pass to fight agent code rot, and Lean as ground truth when it applies.
```

**4/**
```
Context architecture matters as much as model capability. A writing task shouldn't load cluster setup docs. A refactor shouldn't load unrelated project history. I open-sourced the modular docs setup I use for this:

https://github.com/brando90/agents-config
```

**5/**
```
What's next: scalable oversight without gold references. Formal certificates — monotonicity, reflexivity, stability under perturbation — to flag likely-wrong outputs before a human ever looks at them.

Full writeup:
https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html
```

---

## Notes

- **A** is the safest opener and has the clearest discussion prompt.
- **B** is the tweet most likely to get bookmarked by engineers.
- **C** pairs naturally with a reply linking `agents-config` — good as a second beat after A or B.
- **D** is punchier but narrower; use if the conversation that week is already about model comparisons.
- Thread is the strongest single artifact if you want to commit to one post.
- All single tweets and thread tweets fit under 280 characters (URLs count as 23 via t.co).
