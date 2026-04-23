---
layout: post
title: "Two TLDRs Are Better Than One: A Small Prompt-Design Fix That Matters More Than It Looks"
date: 2026-04-16
---

*Brando Miranda — April 2026*

A short post about a tiny change I made to my [agents-config](https://github.com/brando90/agents-config) rules — adding a second TLDR to the top of every agent response — and why the tiny change is actually a lesson about how position on the page interacts with chain-of-thought.

## The annoying problem

I ask every agent in my workflow to end its response with a `**TLDR:**` line. It's in the Hard Rules. The rule exists because once you run agents in parallel across byobu panes, across SSH sessions, across phone previews, you stop reading full responses — you skim. A one-line summary at the end is the thing that lets me decide, in half a second, whether to look closer.

The problem: Claude Code has a prefix-s mode that collapses the response. In collapsed view the end of the response is exactly what you don't see. So the TLDR — the entire reason the rule exists — is hidden precisely when I most want it.

Obvious fix: put the TLDR at the top.

Except that breaks the reason I put it at the bottom in the first place.

## Why putting the summary at the top is worse than it sounds

The reason I ended responses with a TLDR rather than opening with one is chain-of-thought. If the agent writes the summary *first*, the summary is generated from the prompt alone — before the model has worked through the actual problem. That summary is a prediction. It's the model's best guess at what it's about to conclude, not what it actually concluded after reasoning through the task.

The summary written *after* the response is different. By the time the model writes it, it has already produced the reasoning, caught its own mistakes in the middle of the response, narrowed down which of two approaches actually wins. The end-of-response TLDR is the COT-informed TLDR. It's the one that matches the body of the response.

If you replace the end TLDR with a top TLDR, you lose that. If you put TLDRs at *both* positions without thinking about it, the model will almost always just copy the top one to the bottom — anchoring bias is strong, and LLMs really dislike contradicting themselves inside a single response. You end up with two TLDRs that are both the *worse* TLDR.

## The fix

The rule I added is slightly weird, and the weirdness is the whole point:

> Open every response with `**TLDR-start:**` and close with `**TLDR-end:**` (1–2 sentences each). The top one is a fast preview. The bottom one is authoritative: write it **last**, from the actual response content, **ignoring what `TLDR-start` said**. If the reasoning changed your conclusion, `TLDR-end` should reflect that — divergence between the two is expected and fine.

Two things are load-bearing here. The first is renaming the labels. Calling them `TLDR-start` and `TLDR-end` — instead of two things both called `TLDR:` — gives the model permission to let them differ. A rule that says "write TLDR, then TLDR" feels like a consistency violation to satisfy. A rule that explicitly distinguishes a *preview* from an *authoritative final* is a rule the model can actually obey.

The second is the explicit instruction to ignore `TLDR-start` when writing `TLDR-end`. Without it, the anchoring effect wins: whatever the model forecasted at the top leaks into what it writes at the bottom, even after a long reasoning chain. You have to name the trap out loud.

## What this is really about

The reason I'm bothering to write this up is not the TLDR specifically. It's that this is one of a growing list of small prompt-design fixes where the *position* of a thing on the page changes the quality of the thing, not just its visibility.

Other examples from my own workflow:

- Asking an agent to list risks *before* proposing a solution produces different risks than asking it *after*. Before: cautious, abstract, generic. After: grounded in the actual proposed approach, but biased toward risks the solution already handles.
- Asking for a plan, then having the agent critique its own plan in a new section, produces better plans than asking for "a plan with caveats" in one pass.
- Putting "think step by step" at the top versus at the bottom of a prompt is not the same prompt.

All of these are the same lesson: an LLM response is not a document with a fixed meaning. It is a sequence, and what appears earlier conditions what appears later. Once you take that seriously, a rule like "always end with a TLDR" is not really a formatting preference. It is a specification of *when* you want the model to commit to its conclusion — before reasoning, or after.

## The connection to everything else

In [the workflow I wrote about last week](https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html), the headline idea was correctness gating: agents produce, gates check. Gates are the big lever. But the small lever — where on the page you ask the model to summarize, critique, or commit — is, in aggregate, doing a lot of work too. Both levers point at the same thing: the output is not just a function of the model, it is a function of the *shape* of the interaction.

Agent output gets better when the rules take the shape of reasoning seriously. Dual-position TLDR is a five-line rule. It is also a small argument for the broader bet: the structure of how you ask matters as much as what you ask.

---

*[agents-config](https://github.com/brando90/agents-config) is open source under Apache 2.0. The dual TLDR rule lives in `INDEX_RULES.md` Hard Rule 4.*
