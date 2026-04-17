---
layout: post
title: "How I Think About Evaluations"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Most bad research I see is not bad because the idea is wrong. It is bad because the evaluation cannot tell you whether the idea is right. That is a harder problem than it sounds, and it is the one I spend most of my time on — whether I am building benchmarks for mathematical reasoning, running Lean 4 agents, or advising students on their first projects. Evaluation design is the skill that separates a researcher from someone with opinions.

When a student brings me an idea, I ask about the evaluation before the method. If you cannot articulate how the idea would be tested, you have not finished articulating the idea.

## An evaluation is not separate from the idea

A common failure mode: someone says, "I have this idea, but I don't know how to evaluate it." Two things are wrong with that sentence. It implies the idea is already right — a confirmation-bias trap — and it assumes evaluation is something you bolt on at the end. Neither is correct.

If you can precisely state your thesis and your bit flip — the inversion of assumptions that makes your contribution novel — the evaluation almost falls out of the statement. The introduction of a paper contains the seed. You say, "the world believes X," then "however, we think it should be Y," and the next paragraph sketches how you plan to show it. If you cannot write that sketch, you do not yet have a research contribution. You have a vibe.

Science also requires falsifiability. There must be an experiment that could verify or falsify the claim. If nothing could falsify it, it is not science. That requirement forces you to design an evaluation that can go against you.

## Claims have structure, and structure dictates the evaluation

When I look at a thesis, I try to fit it into one of three claim structures: X is greater than Y, there exists an X, or bounding or measuring X. Each one implies a different kind of evaluation.

"X is greater than Y" means X outperforms Y on some task under some metric. The evaluation is a comparison — runtimes, accuracies, whatever the community accepts. The catch is that the metric matters enormously. I keep returning to the "Are Emergent Abilities of Large Language Models a Mirage?" paper because it makes the point sharply: change the metric from something harsh and discontinuous to something soft and continuous, and the same behavior stops looking like a step function and starts looking linear. Same data, different story. If the metric is wrong, the comparison is meaningless.

"There exists an X" is an existence claim. You thought something was impossible, and your contribution demonstrates it is possible. The example I use in class is software-defined networks — networks used to be defined statically in hardware, and the bit flip was that behaviors could be made dynamic in software. The evaluation is not a horse race. It is a demonstration that the thing can be built and behaves as claimed — that a policy change propagates across routers on the fly.

"Bounding X" shows the conditions under which an approach works or fails. Randomized minimum-cut algorithms are a nice case. The older view is that min-cut should always be correct; the bit flip is that a randomized algorithm can be much faster with a bounded probability of error. The evaluation has to be about that bound — how error scales with compute, where the method holds, where it breaks. A related example is Monte Carlo compilers: the prior view was that smart hand-tuned algorithms are needed to optimize to machine code; the flip was that random exploration, given enough compute, can produce better optimizations.

Most real papers blend these. A contribution might be X greater than Y and also a bounding claim — faster under some regime, with tolerated error. Naming the structure forces you to pick an evaluation that matches the claim.

## The four components I insist on

Once the claim is clear, I make people name four things before they touch a GPU: the dependent variable, the independent variable, the task, and the threats to validity.

The dependent variable is the outcome — the y-axis. Accuracy, cross-entropy, token edit distance, runtime, satisfaction, learning transfer. One of these should be your central outcome. Others can be auxiliary. Research is partly teaching — you are teaching yourself and the community something new — and too many outcomes muddy the takeaway.

The independent variable is what you deliberately change. Model scale, dataset size, interface, compute, formal diversity. In the Mirage paper, the x-axis was model scale; the lever that mattered was the metric itself — swapping harsh for soft changed the shape of the plot.

The task is the specific routine that manipulates the independent variable and measures the dependent one. Not "we will test on language modeling" — that is not a task. A task is "we will fix the number of training tokens and vary formal diversity, then measure downstream accuracy on GSM8K." Concrete enough that someone else could run it.

Threats to validity are the honest accounting of what could bias your results. Sampling only Stanford undergrads. Running on one cloud architecture. Letting participants always see the best interface first. Your own confirmation bias. There are three ways to handle a threat: argue it is irrelevant (with a reason, not an assertion), stratify and rerun in each condition, or randomize. Each has a cost. Arguments are cheap but weaker evidence. Stratifying burns compute — GPUs crash; the day of my evaluations lecture I was fighting uncorrectable ECC errors on a card. Randomization takes more design work up front. Writing the threats down is non-negotiable. A good paper names its own limitations before a reviewer does. That is a strength, not a weakness.

## Do not reinvent benchmarks, and do not rush to p-values

Two pieces of practical advice that save a lot of students.

First, if there is an accepted benchmark in your community — ImageNet, MMLU, GSM8K, MATH — use it. Inventing a new evaluation is itself a research contribution that deserves its own paper, because you first have to convince the community it is valid. Every new piece is another place the work can fail, so unless your bit flip *is* the evaluation, borrow an existing one. Audience matters. Write for the reviewers you will actually get.

Second, do not jump straight to statistical tests. Plot the data. Make descriptive statistics. Include error bars and confidence intervals — they give you an intuitive sense of variance and reveal outliers a mean will hide. Only after looking at the data should you reach for hypothesis tests, and then only the test whose assumptions match your setup. Categorical data gets chi-squared. Continuous data with two conditions gets a t-test. More than two, ANOVA with post-hoc tests. Each test carries assumptions; applying the wrong one is worse than not testing at all.

P-values are a community convention, not a law of nature. 0.05 is common; some fields use stricter thresholds. If you think the convention is wrong, that is itself a paper.

## What makes an evaluation trustworthy

When I ask myself whether I believe an evaluation, I run a short checklist:

- Does the evaluation design fall directly out of the thesis and the bit flip?
- Is the claim structure named — comparison, existence, or bounding?
- Are the dependent variable, independent variable, task, and threats all written down?
- Is the metric defensible, and would a different reasonable metric flip the story?
- Are the benchmarks accepted by the community, or is the new evaluation itself the contribution?
- Are limitations acknowledged inside the paper, not hidden?
- Did the authors look at the data before running statistics, and do the tests match the assumptions?

If the answers are yes, I trust the result. If any is no, I am not saying the idea is wrong — I am saying the paper has not yet shown me it is right. That is the distinction I want every student of mine to hold onto. Your job is not to prove you are smart. Your job is to convince an expert in your area, on the standards of evidence they accept, that the world is a little different than it was before you started.
