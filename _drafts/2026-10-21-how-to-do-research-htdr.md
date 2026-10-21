---
layout: post
title: "How to Do Research: Velocity, Vectoring, and Letting Agents Do the Typing"
date: 2026-10-21
section: meta-research
---

*Brando Miranda — October 2026 · DRAFT, not published*

**TL;DR.** Research is creating knowledge when you don't know the answer, so failure is the default outcome, not the exception. Two habits make that survivable. **Velocity**: run many cheap experiments, reusing code that is already debugged, because your intuition is imperfect and the only fix is more attempts. **Vectoring**: aim those attempts at the biggest assumption in your project, the one you hold without noticing, and try to break it. In the AI-agent era, a third rule: let agents do the execution, and keep the conceptual work (what to test, what to measure, what the result means) for yourself. Below is a concrete practice exercise: does *task alignment* matter more than *task difficulty*? We frame it as GSM8K versus the Putnam exam.

---

I wrote this after onboarding a new student onto a project. The first meeting was 30 minutes, and almost none of it was about code. It was about how to think while doing research. This post turns that conversation into something you can reuse. It is a "how to do research" (HTDR) post first and a project note second.

## 1. Failure is the default state

Start here, because everything else depends on it. If you already knew the experiment would work, it wouldn't be research. Most experiments you run will fail: the code is wrong, the hypothesis is wrong, the metric is wrong, or the setup was never able to answer the question. That is the normal state of the job.

So the goal of the first month is not "get a positive result". It is to get good at failing quickly, understanding why, and writing it down. Celebrate the failure that tells you your assumption was wrong. It is the cheapest information you will ever buy.

A practical consequence: every experiment gets a one-line statement of what result would *surprise* you. If nothing could surprise you, you don't have an experiment, you have a demo.

## 2. Two vectors: velocity and vectoring

I think of research progress as a vector with two components.

**Velocity: how fast you iterate.**

- *Why:* your intuition about what will work is imperfect. Everyone's is. The way to compensate is to make more attempts per week than you think is reasonable.
- *Tactic:* do not write things from scratch when someone has already built and debugged them. Reuse existing software, existing training loops, existing evaluation harnesses. Every hour spent re-implementing a solved problem is an hour not spent on a new idea.

**Vectoring: which direction you point.**

- *Why:* speed in the wrong direction is just a fast way to be wrong. The real risk in a project is usually an assumption you hold so deeply you stopped noticing it. Confirmation bias protects those assumptions. Vectoring is the discipline of going after them on purpose.
- *Tactic:* take the biggest assumption and test it *to the point of failure*. Don't ask "can I find evidence for X?" Ask "if X is true, how could I break it?" If you tried hard to break it and couldn't, you've learned something. If it broke, you've learned more.

(I wrote about both separately: [Vectoring: Attack the Biggest Uncertainty First](https://brando90.github.io/brandomiranda/2026/04/16/vectoring-in-research.html) and [Velocity in Research](https://brando90.github.io/brandomiranda/2026/04/16/velocity-in-research.html).)

They work as a loop. Vectoring chooses the question, velocity answers it, and the answer tells you where to aim next.

## 3. A practice exercise: alignment versus difficulty

Here is the concrete example I gave: a real project hypothesis that is clean enough to practice vectoring on.

**The assumption.** Many people assume that how well a model does on a task is mostly about how *hard* the task is. Our working hypothesis is the opposite: **task alignment matters more than difficulty.** By alignment I mean how well the training data matches the task you test on. Difficulty may cost you training effort, but alignment is what decides test performance.

**The sharp test.** Take two datasets that differ a lot in difficulty:

- **Putnam**: a famously hard competition math exam.
- **GSM8K**: grade-school math word problems, much easier.

Now train a model *only* on the hard one (Putnam) and evaluate it on the easy one (GSM8K). If difficulty were what mattered, a model that can handle Putnam should find GSM8K trivial. If alignment is what matters, a model trained only on Putnam should do poorly on GSM8K, in the extreme case near zero, because GSM8K is not the distribution it was trained on. A near-zero result would support the claim that alignment with the training data overrides how hard the task looks.

That is vectoring in one picture: a hypothesis that can fail loudly. Notice what makes it a good test:

1. **It has a falsifier.** If the Putnam-trained model does fine on GSM8K, the hypothesis is in trouble. You know in advance what would count against you.
2. **It separates two variables.** Difficulty goes one way, alignment goes the other. That is why the pair was chosen.
3. **It is cheap to try a first version of.**

### Turning it into an experiment (the part you own)

This is where the conceptual work lives, and where a student should spend their thinking time. Before touching code, write down answers to these:

- **What exactly is "zero"?** Zero accuracy is a strong claim. Decide the threshold you'd accept as "supports the hypothesis" before you see the number, and say why.
- **What are the controls?** At minimum: the same model *before* any training (does it already solve some GSM8K?), the same model trained on GSM8K and tested on GSM8K (is the pipeline able to succeed at all?), and Putnam-train → Putnam-test.
- **What is the metric, and can it fool you?** Exact-match accuracy on a final answer compounds errors and can hide gradual progress. Look at more than one metric.
- **What else differs between the two datasets?** Format, length, answer style, tokenization. If alignment is confounded with any of these, say so, and decide which you'll hold fixed.
- **What would you conclude from each outcome?** Write down the interpretation for "zero", "some", and "high" *before* running.

Then the execution half: set up the run, train, evaluate, plot. This part you can hand to an agent (see the next section), but you review it, because a silent bug here looks exactly like an interesting result.

And expect it to fail the first time. Wrong learning rate, a broken data split, an evaluation that doesn't parse answers properly: that is the failure-as-default state from section 1, not a setback.

## 4. Use agents for execution, own the concepts

The question I get most: how do you stay productive with coding agents while still learning to do research? My answer is a split.

**You own the conceptual work:**

- designing the experiment,
- the math and the statistics,
- choosing and defending the metrics,
- deciding what the result means.

**Agents do the execution:**

- writing and debugging the code,
- hyperparameter tuning and sweeps,
- running the jobs and collecting the numbers.

The reasoning: clear thinking and statistical judgment are durable skills. Basic coding is exactly the kind of skill that may be obsolete soon. Spend your learning budget on what lasts, and your agent budget on what doesn't.

A rule of thumb: if you can't explain to a colleague, without the agent, *why* the experiment answers the question, you handed over something you should have kept.

## 5. How to start: run one experiment end to end

The best way to learn this is to do one full loop. The first assignment:

1. **Pick one experiment** from the project repo. Either the *riskiest* hypothesis (the one most likely to blow up the project) or the one you understand best or find most exciting. Starting with the one you understand builds confidence for the harder ones.
2. **Run it** and analyze the result. A failed or confusing run counts.
3. **Present it as a short slide deck**, using a research diary as the template: what I believed, what I ran, what happened, what I'll do next. The structure matters because it makes feedback easy.
4. **Share it for async review** by the end of the week.

You are being evaluated on the quality of your thinking and how clearly you report, not on whether the result was positive.

## Takeaways

- **Failure is the default.** Plan for it, learn from it, celebrate it.
- **Velocity** compensates for imperfect intuition: more attempts, reusing debugged code.
- **Vectoring** compensates for confirmation bias: find the biggest hidden assumption and try to break it.
- A good hypothesis has a **falsifier and a pre-written interpretation** for each outcome.
- **Own the concepts, delegate the execution.**
- Do one experiment end to end, then report it clearly.

---

## Appendix: notes on AI agents in the research loop

*This appendix is commentary, kept separate from the main argument.*

**What agents are good at here.** Boilerplate, glue code, debugging stack traces, launching sweeps, reformatting results into tables and plots. This is the execution half, and delegating it is how you raise velocity without learning less.

**What I don't delegate.** Choosing the question, the controls, the metric, and the interpretation. An agent will happily run an experiment that cannot answer your question, and report success.

**Where agents bite.**

- *Silent bugs look like findings.* A wrong data split or a mis-parsed answer can produce a clean, surprising plot. Read the code paths that matter, check a few raw examples by hand, and run the control that should obviously succeed.
- *Agents agree with you.* If you ask "did this confirm my hypothesis?", you tend to get a yes. Ask instead how it could be broken, which is vectoring applied to the agent's own output.
- *Fluency is not verification.* A confident write-up is not evidence. Numbers come from the logs.
- *Skills atrophy if you never practice them.* Keep doing the conceptual steps by hand at least on small problems: derive the metric, sketch the expected curve, predict the outcome before running.

**A working habit.** Before an agent runs anything, write two lines in your notes: "I expect X because Y" and "I'd be surprised by Z". Afterwards, compare. Over months this calibrates your intuition, which is the thing velocity was compensating for in the first place.

**Resources.** The private "how to do research" GitHub repo and the lecture playlist on YouTube are shared separately.
