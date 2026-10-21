---
layout: post
title: "How I Do Research: Velocity, Vectoring, and Letting Agents Do the Typing"
date: 2026-10-21
section: meta-research
---

*Brando Miranda, October 2026. Draft, not published.*

**TL;DR.** Most experiments fail. That is not bad luck, it is the job. Two habits make it survivable. Velocity: try many cheap things, reuse code that already works, because my intuition is imperfect and more attempts is the only fix. Vectoring: aim those attempts at the biggest assumption in the project, the one I don't even notice I'm making, and try to break it. How do I pick that assumption? Talk to a diverse set of people, and listen to those with a track record. There is no magic bullet. And with agents around now, one more rule: let them do the typing, and keep the thinking. The example I use to practice all of this is GSM8K versus Putnam.

---

## Failure is the default

I start here because everything else depends on it. If I already knew the experiment would work, it would not be research.

Most of mine break. The code is wrong, the hypothesis is wrong, the metric is wrong, or the setup could never answer the question in the first place. That is the normal state, so I celebrate it. A failure that says "your assumption was wrong" is the cheapest information I will ever get.

One habit that helps: before I run anything, I write down what result would surprise me. If nothing could surprise me, I don't have an experiment, I have a demo.

## Velocity

My intuition about what will work is not great. Neither is yours. So I compensate by making more attempts than feels reasonable.

The tactic is boring: don't write things from scratch when someone already built and debugged them. Reuse the training loop, reuse the eval harness. An hour spent re-implementing a solved problem is an hour not spent on a new idea.

## Vectoring

Speed in the wrong direction is just a fast way to be wrong. The real risk in a project is usually an assumption I hold so deeply that I stopped seeing it. Confirmation bias protects it.

So I go after it on purpose. I don't ask "can I find evidence for X?" I ask "if X is true, how could I break it?" Test it to the point of failure. If I tried hard and it held, I learned something. If it broke, I learned more.

The two work as a loop. Vectoring picks the question, velocity answers it, and the answer tells me where to aim next. (I wrote about each separately: [Vectoring](https://brando90.github.io/brandomiranda/2026/04/16/vectoring-in-research.html) and [Velocity](https://brando90.github.io/brandomiranda/2026/04/16/velocity-in-research.html).)

### How do you choose what to aim at?

Laolu asked the obvious follow-up. If vectoring means aiming at the riskiest hypothesis, how do you choose which hypothesis to work on and de-risk in the first place? How do you train your vectoring?

Honest answer: there is no formula. I lean on two things.

**1. Talk to a diverse set of people.** Choosing a direction is an exploration problem, the same as in RL. When you are very uncertain, exploiting your current best guess is how you get stuck, and the more uncertain you are, the more diversity pays. The assumption you can't see is, by definition, invisible to you, so you need people who don't share it. I should have said this in the meeting.

**2. Weight advice by track record.** If someone has a history of getting things right, listen harder to their hypotheses and advice. That is how society allocates resources too: funding goes to the PI who has been right before. A track record is evidence, so the thoughts of more experienced researchers are a cheap way to prune the list.

**No magic bullets.** Those are the only two ways I know. If there were a trick, we would all be using it. You will still pick wrong sometimes, and that is what velocity is for.

## A practice exercise: GSM8K versus Putnam

Here is a real hypothesis that is clean enough to practice on.

Most people assume how well a model does on a task is mostly about how hard the task is. Our working bet is the opposite: **task alignment matters more than difficulty.** Alignment means how well the training data matches what you test on. Difficulty can cost you training effort, but alignment is what decides test performance.

The sharp test: take two datasets that differ a lot in difficulty. Putnam is a famously hard competition exam. GSM8K is grade-school word problems. Train a model only on the hard one, then test it on the easy one.

If difficulty is what matters, a model that handles Putnam should find GSM8K trivial. If alignment is what matters, it should do badly on GSM8K, in the extreme near zero, because that is not what it was trained on. A near-zero result would say that alignment with the training data overrides how hard the task looks.

I like this as an exercise because it is vectoring in one picture. It can fail loudly, so I know in advance what would count against me. It pulls the two variables apart, which is why the pair was picked. And a first version is cheap.

### The part you own

This is where the thinking time goes, and it happens before any code. Write down:

- **What exactly is "zero"?** Zero accuracy is a strong claim. Decide the threshold that would support the hypothesis before seeing the number, and say why.
- **What are the controls?** At least: the same model before any training, the same model trained and tested on GSM8K (can the pipeline succeed at all?), and Putnam to Putnam.
- **Can the metric fool me?** Exact match on a final answer compounds errors and can hide gradual progress. Look at more than one.
- **What else differs between the datasets?** Format, length, answer style, tokenization. If alignment is tangled up with any of these, say so.
- **What do I conclude from "zero", "some" and "high"?** Write it down before running.

Then the execution: set up the run, train, evaluate, plot. An agent can do that, and I still review it, because a silent bug looks exactly like an interesting result.

And expect it to break the first time. Bad learning rate, broken split, an eval that doesn't parse answers. That is section one, not a setback.

## Agents do the execution, I own the concepts

People ask how I stay productive with coding agents and still learn. My answer is a split.

I own the conceptual work: the experiment design, the math, the statistics, the metrics, and what a result means. Agents get the low-level work: writing and debugging code, hyperparameter tuning, running jobs and collecting numbers.

The reason is simple. Clear thinking and statistical judgment are durable. Basic coding is exactly the kind of skill that may be obsolete soon. So I spend my learning budget on what lasts and my agent budget on what doesn't.

A test I use: if I can't explain to a colleague, without the agent, why the experiment answers the question, I handed over something I should have kept.

## The practical checklist

This is the quick recipe I would hand to someone starting out. It is also the first assignment.

1. **Pick one experiment from the project repo.** Either the riskiest hypothesis, or the one you understand best. Starting with the one you understand builds confidence for the harder ones.
2. **Write what would surprise you before you run it.**
3. **Run it, and let an agent do the typing.** Then read the parts that matter yourself.
4. **A failed or confusing run counts.** Write down why.
5. **Present it as a short slide deck, using a research diary as the template:** what I believed, what I ran, what happened, what I do next. The structure makes feedback easy.
6. **Share it for async review by the end of the week.**

You are judged on the quality of your thinking and how clearly you report it, not on whether the result was positive.

## Where I land

Research is making a lot of cheap attempts, pointed at the thing most likely to prove you wrong, and being honest about what came out. Failure is the default, so get good at it. Keep the thinking, hand off the typing, and write down what you expected before you look.

---

## Appendix: notes on AI agents in the research loop

*Commentary, kept apart from the main argument.*

**What agents are good at here.** Boilerplate, glue code, debugging stack traces, launching sweeps, turning results into tables and plots. That is the execution half, and delegating it raises velocity without costing me the learning.

**What I don't delegate.** The question, the controls, the metric and the interpretation. An agent will happily run an experiment that cannot answer your question and report success.

**Where they bite.**

- *Silent bugs look like findings.* A wrong split or a mis-parsed answer can give a clean, surprising plot. Read the code paths that matter, check a few raw examples by hand, and run the control that should obviously succeed.
- *Agents tend to agree with you.* Ask "did this confirm my hypothesis?" and you often get a yes. Ask how it could be broken instead. That is vectoring applied to the agent's own output.
- *Fluent is not verified.* A confident write-up is not evidence. The numbers come from the logs.
- *Skills fade if you never use them.* Keep doing the conceptual steps by hand on small problems: derive the metric, sketch the curve you expect, predict the outcome before running.

**A working habit.** Before an agent runs anything, write two lines: "I expect X because Y" and "I'd be surprised by Z". Afterwards, compare. Over months that calibrates your intuition, which is what velocity was compensating for in the first place.

**Resources.** The private "how to do research" GitHub repo and the lecture playlist on YouTube are shared separately.
