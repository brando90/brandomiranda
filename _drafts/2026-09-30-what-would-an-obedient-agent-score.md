---
layout: post
title: "What Would an Obedient Agent Score? The One Question That Would Have Caught Our Benchmark Bug"
date: 2026-09-30
section: meta-research
---

*Brando Miranda — September 2026 · ~6 min read*

**TL;DR.** Our benchmark's instructions told AI agents to leave their proofs unfinished, and our scorer gave unfinished proofs zero credit. The published numbers were nonzero anyway, and they looked perfectly sensible, because they were measuring how often each agent *disobeyed* us. One question, asked before any run, would have caught it: what does an agent that follows our instructions exactly score? I learned the habit behind that question from my friend Rylan Schaeffer's CS229 lecture on ML advice, and I should have been using it all along.

---

<!-- TODO before publishing: (1) confirm Amy Lu is happy to be named; (2) confirm the NeurIPS-submission numbers (0.237 / 0.114 / 0.282) can be public while the TMLR version is under review; (3) link the agents-config skill file once brando90/agents-config PR 63 is merged, if you want it linked. -->

In August, Amy Lu, who works with us on [VeriBench](https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/), found a bug that had been sitting in plain sight for months. The day after she reported it, I asked her the question I should have asked the day the first number came in: *why isn't this score zero?*

It should have been zero. That's the whole story, and it took me a while to see why.

## The bug, in one paragraph

VeriBench asks an agent to translate a Python program into [Lean](https://lean-lang.org), a language where you state theorems about your code and a proof checker verifies them. Lean has a keyword, `sorry`, that means "trust me, the proof goes here later." A file full of `sorry` compiles, but nothing in it is proved. When we wrote the reference solutions, we let ourselves use `sorry` as a placeholder, because the plan was to have specialized provers fill those holes in later. That convention leaked into the instructions we gave the agents being evaluated. The prompt told them, in effect, to write `theorem … := sorry` and called a compiling file a success. Meanwhile the scorer, correctly, only gave proof credit to theorems proved without `sorry`.

So the instructions and the metric pointed in opposite directions. An agent that did exactly what we asked would score zero on proofs.

## What the number actually measured

It didn't score zero. The proof numbers in the table of our NeurIPS 2026 submission were 0.237 for Codex, 0.114 for Claude Code, and 0.282 for a single-call baseline, whose one example in the prompt happened to be fully proved.

Those numbers look like agents genuinely attempting a hard task and partly succeeding. That's how we read them. What they actually measured was how often each agent ignored our instructions and proved things anyway. Stronger agents tend to disobey in exactly this way, because they can prove things. So the ranking even looked reasonable.

That's what made it dangerous. **A metric that rewards disobedience still ranks capable models first.** Nothing about the table looked wrong. You only see it if you ask what the table *should* look like.

## The question Rylan kept asking

In February 2025, Rylan gave a guest lecture in Stanford's CS229 on the ML advice he wishes everyone had ([video](https://www.youtube.com/watch?v=sl55buSIJPA&t=1015s), [slides](https://docs.google.com/presentation/d/1kTg6SSm4TRbogwz18_CtanJftYsj8Khx6W8UJQbQgYI/edit?usp=sharing)). One lesson is titled "Understand your measurements," and he puts it about as plainly as it can be put:

> "when I say understand your measurements, I mean ask yourself what is the behavior that you should expect? And then ask whether or not what comes out is what you should expect."

His example is one I know well, because Rylan, Sanmi Koyejo, and I wrote [the paper](https://arxiv.org/abs/2304.15004) behind it. Many "emergent abilities" in large language models, the sudden jumps in capability at scale, turn out to come from the metric. Score a long answer as all-or-nothing, and a model that improves smoothly at each step looks flat, flat, flat, and then suddenly competent. Pick a smooth metric, and the jump disappears.

The irony isn't lost on me. I co-wrote a paper about metrics manufacturing effects that aren't there, and then shipped a benchmark whose metric manufactured an effect that wasn't there. Knowing the lesson isn't the same as running the check.

## The prediction that catches it

Rylan's question needs one extension for agent benchmarks. When you write down what you expect, include the agent that follows your delivered instructions word for word, including every example and every "you may" clause.

Concretely, before running anything, I now want a short table for every reported metric. It predicts the score under five kinds of submission:

- **The reference solution.** It should score near the top.
- **The behavior you hope for.** A competent agent doing the task well.
- **Literal compliance.** An agent that does exactly what the prompt says, nothing more.
- **Degenerate submissions.** An empty file, a trivial theorem like `theorem t : True`, everything left as `sorry`.
- **Your baselines.**

Then two rules. If literal compliance scores below the best achievable score, your instructions and your metric disagree, and you fix that before spending a single model call. If a degenerate submission scores well, the metric is gameable, and you add a guard. For VeriBench, the literal-compliance cell reads "0, because the prompt says to use `sorry`." Writing that cell down takes a minute. Missing it cost us a corrected paper and a full rerun.

A few habits make the prediction honest. Read the prompts the harness actually sends, not the template you think it sends. Trace one example by hand from the prompt, through the agent's output file, to the scorer and the final cell of the table. Run the degenerate submissions on a handful of tasks and check they land where you said. And then look at the outputs. A few minutes reading actual files would have shown theorem after theorem ending in `sorry`, exactly as instructed.

That last one is Rylan's first lesson, and in the lecture he calls it "the fundamentally most important thing about any machine learning": look at your data.

## What we changed

We fixed the instructions, not the scorer. The scorer was right. Agents now get a prove-first policy: prove what you state, and `sorry` is an honest last resort that earns zero credit, never something we ask for. We kept the old numbers with the problem disclosed rather than quietly replacing them, and reran the agents under the corrected prompt.

I also turned Rylan's lecture into a checklist my coding agents load before they design or run any experiment. At the top is the question from this post, stated as a check: *predict what literal compliance scores; if it isn't the best achievable score, stop.* The point isn't that agents are more careful than I am. They aren't. The point is that a written check gets run every time, and a lesson I merely know doesn't.

## The question, again

I started with the question I asked Amy: why isn't this score zero? The better question, the one I want asked before the first run, is: what should this score be if the agent does exactly what we told it to?

If the answer isn't "the best possible score," you aren't measuring what you think you're measuring. It takes one line in a table to find out. Write it down before you run anything.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026obedientagent,
  author = {Miranda, Brando},
  title  = {What Would an Obedient Agent Score? The One Question That Would Have Caught Our Benchmark Bug},
  year   = {2026},
  month  = {September},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/09/30/what-would-an-obedient-agent-score.html}},
  note   = {Blog post}
}
```

## Acknowledgments

Thanks to Rylan Schaeffer, whose guest lecture on ML advice in Stanford's CS229 (February 19, 2025) is where the central question of this post comes from; the [recording](https://www.youtube.com/watch?v=sl55buSIJPA) and [slides](https://docs.google.com/presentation/d/1kTg6SSm4TRbogwz18_CtanJftYsj8Khx6W8UJQbQgYI/edit?usp=sharing) are worth your time. Thanks to Stanford CS229 for hosting the lecture. And thanks to Amy Lu for finding the bug and for asking the right question about it.
