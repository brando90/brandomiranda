---
layout: post
title: "Vectoring: Attack the Biggest Uncertainty First"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Most research advice I got early on was useless because it assumed I already knew what to work on. The hardest part of a research project is not executing a plan — it is choosing what to attack next when everything is uncertain and nothing is proven. The single most important technique I teach in CS197 for this is what Michael Bernstein calls **vectoring**: identify the direction of biggest uncertainty in your project, and reduce it first.

This is one of two skills that separate researchers who ship from researchers who flounder. The other is velocity — the speed at which you reduce risk once you have picked a direction. They operate in a tight loop. Pick the wrong vector and velocity does not save you; move too slowly on the right vector and the project dies anyway. Today I want to focus on the picking.

## Research is not a project spec

The cartoon version of research — have an idea, build it, publish — is a lie. Papers read that way because papers are written to communicate a finished result. The process that produced them looked nothing like the abstract. It looked like things on fire, an ostrich running loose, and somebody yelling about what they just learned.

The trap is treating a research goal like a homework set or a project spec. You take the concept, break it into parts — build the model, collect the data, write the proof, design the interface — and execute all of them in parallel. You spend weeks perfecting something before you know whether the core idea works at all. When the fatal flaw shows up — and it always shows up — you have built a pile of scaffolding around an assumption that was never tested. That is what I mean when I say do not build your life on a lie.

Research is iterative exploration, not a linear path from idea to result. Your currency is experiments, not effort. A startup's cash is the paying customer. A researcher's cash is reality coming back and telling you whether your hypothesis survives.

## The vectoring heuristic, stated cleanly

Here is the rule. **Pick the single dimension where, if you are wrong, the whole project falls apart — and reduce the uncertainty there first, as fast as you can, using the cheapest experiment that actually answers the question.**

That sentence does a lot of work. Three parts:

1. **One dimension.** Not five. The more dimensions you try to optimize at once, the harder gradient descent becomes — on neural nets and on careers. Pick one.
2. **Biggest risk, most essential assumption.** If the vector you chose turned out false, would the project die? If not, you picked wrong.
3. **Cheapest experiment that answers it.** The point is not rigor for its own sake. The point is to learn. If you can answer the question with a manual check of thirty data points in thirty minutes, do that before you train a classifier.

The output of a vectoring decision is a clear split between **core** and **periphery**. The core is what you attack. The periphery — infrastructure, polish, anything not testing the central assumption — gets scaffolded with the laziest thing that works. Reuse code. Draw the interface on paper. Hand-label ten examples. The periphery exists to let the core experiment run.

## A walkthrough: emergent abilities in LLMs

The cleanest example I teach is the *Mirage* paper — the one arguing that "emergent abilities" of large language models are not a fundamental property of scale but an artifact of how we measure.

The prior belief everyone held was that as you scaled model size, certain capabilities appeared as sharp, unpredictable jumps. The authors had a hunch this was wrong. Their hypothesis: the jumps are caused by other factors — the scoring metric, the size of the test set, or the sparse sampling of model scales on the x-axis.

Three candidate vectors. All important. All unknown. Which one do you pick?

- **Vector A: the scoring metric.** Change the last layer of evaluation — from exact string match to something smoother like token edit distance or average accuracy.
- **Vector B: the test set size.** If your benchmark has three examples and the model is small, the probability it gets anything right is near zero, which looks like a sudden jump when scale finally clears the threshold. Testing this means building bigger benchmarks — in something like Persian-language QA, hiring speakers, writing questions, validating them.
- **Vector C: sparse sampling of model scales.** Add more points on the x-axis, especially at the large end. Training one foundation model costs at least a million dollars.

Vector A wins. Not because it is the most important in isolation — all three matter — but because it is the one you can reduce *now*, cheaply, without new data and without a compute budget the size of a small country. You change one layer in the evaluation pipeline. That is it. And if the emergent jumps vanish when the metric changes, you have already learned the headline result of the paper.

This is the coupling between vectoring and velocity. Sometimes the right vector is not literally the biggest risk — it is the biggest risk *you can actually attack this week*. Creativity in choosing a vector often means finding the version of the question that a one-week experiment can answer.

## Another walkthrough: trolling on the internet

A non-ML example, because vectoring generalizes. The common assumption is that online trolling is driven by a small number of antisocial users. The hypothesis a team explored: normal people also troll, when triggered. The dataset was roughly 16 million CNN comments with moderator flags.

Candidate vectors:

- Check a subset of the data manually — read thirty flagged comments and see what kind of person left them.
- Train a classifier to predict who will troll, then compare weights on personal history versus post context.
- Analyze whether the same person trolls more on angry topics than boring ones.

The right first vector is the manual check. Thirty minutes of reading gives you direct evidence for the central question: do normal-looking accounts troll when the thread is heated? Training a classifier is expensive and one layer removed from the hypothesis. The topic-comparison analysis is indirect. Reading the data is direct, cheap, and targets the main claim. This is also what good ML researchers do constantly — they read their data and model outputs, especially when things break.

## Assumption mapping and how to scope a vector

When I am stuck choosing, I draw the assumption map on paper. X-axis: known to unknown. Y-axis: unimportant to important. Every open question goes on the grid. The target quadrant is upper-right: important and unknown. Revisit this map weekly. I have friends in biology who pipetted for a month before looking up and asking *why am I doing this*. Writing is the cheapest form of articulation I know, and articulation forces the question to the surface.

A good vector is achievable in a one-to-two-week sprint. "Can normal people be responsible for trolling online" is not a vector — that is the whole project. "Can normal people be responsible for trolling on CNN.com in flagged comments under politically charged articles" is closer. If a week of focused work cannot give you a preliminary answer, you just restated the project. Scope harder.

One trick I use on myself: put the result on a calendar as if I have to present it to my advisor next week. Often I do. Sometimes I play advisor to myself. Either way, the deadline forces creativity about what can be cut.

## Takeaways

- **Research is not a project spec.** Do not execute in parallel across every dimension. You will perfect the wrong thing.
- **Vector, then velocity.** Identify the single biggest uncertainty whose failure would kill the project. Reduce it with the cheapest experiment that actually answers the question.
- **Core versus periphery.** Scaffold everything that is not the core experiment. Reuse code. Draw on paper. Hand-label thirty examples.
- **Iterate honestly.** When a vector resolves, new unknowns appear — that is the job. Reprioritize. Unexpected results are a gift, not a failure.

Iteration beats planning. Hemingway, Picasso, every researcher I admire — all wrong on the first try. Assume you will be too, and make your first try cheap.
