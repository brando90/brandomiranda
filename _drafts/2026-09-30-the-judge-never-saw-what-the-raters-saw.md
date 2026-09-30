---
layout: post
title: "The Judge Never Saw What the Raters Saw: Karpathy's Recipe, Applied to LLM Judges"
date: 2026-09-30
section: meta-research
---

*Brando Miranda — September 2026 · ~7 min read*

**TL;DR.** For weeks, every large language model (LLM) judge we built for VeriBench barely agreed with our human experts, and we kept tuning prompts. The cause was one line of plumbing: the judges were reading different reference files than the ones the experts had rated. Andrej Karpathy's "Recipe for Training Neural Networks" has a sanity check that catches exactly this, and three more we also skipped. Treat a judge like a network you're training: before you tune it, prove it sees what the raters saw and can copy the answer when you hand it the answer.

---

<!-- TODO before publishing: (1) confirm the VeriBench judge numbers below can be public while the TMLR version is under review; (2) add the names of the expert raters and judge-study collaborators to the acknowledgments if they want to be named; (3) link the agents-config skill file once brando90/agents-config PR 63 is merged, if you want it linked; (4) update the companion-post link if its publish date changes. -->

I've been doing research for eleven years. I still spent weeks tuning LLM judges that could never have worked, because I skipped a check that takes one command.

This post is about that check, and about the three others Karpathy lists right next to it. The companion post, [What Would an Obedient Agent Score?](/2026/09/30/what-would-an-obedient-agent-score.html), is about the same failure from a different angle: predicting what a measurement should read before trusting what it does read. That habit comes from my friend Rylan Schaeffer's CS229 lecture. This one comes from Karpathy.

## What the judge was supposed to do

[VeriBench](https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/) asks AI agents to turn Python programs into [Lean](https://lean-lang.org), including the theorems that say what the code is supposed to do. Lean checks proofs on its own. What it can't check is whether the agent stated the *right* theorems. For that we use a judge: an LLM that reads the reference theorems and the agent's theorems and scores how much of the reference the agent covered.

A judge is only useful if it agrees with people who know what they're looking at. So we had experts rate 75 agent outputs across 25 tasks, and measured agreement by rank correlation: 1 means the judge orders the outputs exactly as the experts do, 0 means no relationship. We ran four separate judge studies with different prompts, rubrics, and models. None of them got past 0.28.

## Karpathy's two warnings

Karpathy opens [the recipe](https://karpathy.github.io/2019/04/25/recipe/) with two facts about training neural networks: "Neural net training is a leaky abstraction" and "Neural net training fails silently." Both apply word for word to judges.

A judge looks like a single number, but that number depends on which files it reads, how the prompt is assembled, how the answer is parsed, which score scale is used, how repeated runs are combined, and whose ratings count as the target. Any of those can break without an error message. A broken judge doesn't crash. It returns plausible numbers.

The recipe's answer is to earn trust in the whole pipeline with cheap checks *before* doing anything clever. Here are the four we skipped, and what each would have shown.

## Check 1: look at exactly what goes in

Karpathy's version is "visualize just before the net," because what the network actually receives "is the only 'source of truth'." For a judge, that means printing the exact prompt it gets and checking every file inside it against what the human raters saw.

We didn't do this until the fifth study. When we did, it took one diff. Our judges were reading reference files from a September snapshot, while the experts had rated against the April and May versions. On 9 of the 25 tasks the reference theorems had changed in between, and 5 of the references the experts saw had still been placeholders. The judges were grading against an answer key the graders never saw.

The effect is not subtle. Split one of our saved judges by whether its reference matched, and its agreement is 0.469 on the matched items and 0.095 on the mismatched ones.

**The cheapest experiment in the whole study was a diff, and we ran it last.**

## Check 2: look at the untuned output

Karpathy's "verify loss @ init" says to check that a network's starting behavior is what you'd predict before you train it. For a judge: run the plain version and look at the histogram of its scores before any tuning.

An earlier coverage judge, the one behind our NeurIPS-era numbers, put 85–87% of its scores at exactly 0.1. Part of the reason was a loose parser that turned long prose answers into "1 out of 10." Replaying that parser on 1,185 saved responses mapped 94.3% of them to 0.1. A histogram shows that in seconds. We read the averages instead.

## Check 3: beat a dumb baseline

Karpathy also wants simple baselines and a human baseline before anything fancy. For our judge, the simplest baseline I can think of is to count the theorems: take the number of theorems the agent wrote divided by the number in the reference, capped at 1.

That one line reaches 0.543 agreement with the experts when it reads the same references they did, which beats every LLM judge from those four studies. Fed the stale snapshot the judges were reading, it falls to 0.273, right in the range the judges were stuck in. So the baseline would have flagged both problems at once: our judges were weak, and they were reading the wrong files.

If a one-line heuristic beats your judge, the heuristic is telling you something.

## Check 4: overfit one batch

This is the check I think about most, because it answers a question I kept asking and couldn't answer: *why doesn't the judge agree with the experts even on the ratings we tuned it on?*

Karpathy's instruction is to take a handful of examples and drive the error to zero: "If they do not, there is a bug somewhere and we cannot continue to the next stage." The judge version is a label-reproduction test. Put the expert's score in the prompt and ask the judge to return it. Anything short of near-perfect agreement is a pipeline bug: parsing, scale, misaligned items, truncation. Then take two or three items and tune the prompt freely until the judge matches the experts on them. If you can't, look at those items closely. You'll usually find the judge and the raters saw different things.

We never ran either version. Our "overfit" step reached 0.641 on the training ratings against a human ceiling of 0.794, which is how well one expert agrees with the other two. I can list plausible reasons for that gap. The judge only sees the training ratings through a few written rules and examples, so it has little room to memorize. The expert ratings are noisy. Integer scores create ties. The splits are small. But a list of plausible reasons is exactly what the test replaces with a measured answer.

**Before you tune a judge, prove it can copy the answer when you hand it the answer.**

## What happened once the inputs matched

Once the judge read the same files as the experts, most of the problem went away. We followed another of Karpathy's rules, "don't be a hero": instead of inventing a rubric, we started from the instructions the experts themselves had followed. That judge passed its held-out test, with a rank correlation of 0.826 on 30 test items.

The honest version is less rosy, and worth saying. When we rebuilt the judge fold by fold so that every expert rating is used for evaluation exactly once, agreement was 0.602, with a wide interval, from 0.29 to 0.83. The untuned judge that just followed the raters' instructions scored within 0.002 to 0.087 of the fully tuned one. All that prompt tuning bought very little. Reading the right files did most of the work.

One more lesson from the end of the study: high correlation isn't the same as the right level. Our judge ranks outputs well but is lenient in the middle. Outputs the experts scored as partial coverage, around 0.44 on average, come out around 0.78. Ranking and level are different questions, and you have to check both.

## Eleven years

I opened with how long I've been doing research, and I mean it as a warning, not a credential. Experience didn't make me skip fewer steps. It made me confident enough to skip them.

That's why recipes like Karpathy's are written as checklists: experts skip steps. So I turned his recipe into a checklist my coding agents load before they build, tune, or trust any LLM judge. It starts with the diff and the label-reproduction test, because those two alone would have saved us weeks. A judge that never saw what the raters saw can't agree with them, however good the prompt is.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026judgerecipe,
  author = {Miranda, Brando},
  title  = {The Judge Never Saw What the Raters Saw: Karpathy's Recipe, Applied to LLM Judges},
  year   = {2026},
  month  = {September},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/09/30/the-judge-never-saw-what-the-raters-saw.html}},
  note   = {Blog post}
}
```

## Acknowledgments

Thanks to Andrej Karpathy for "[A Recipe for Training Neural Networks](https://karpathy.github.io/2019/04/25/recipe/)," which reads just as well for judges as for networks. Thanks to Rylan Schaeffer, whose guest lecture on ML advice in Stanford's CS229 ([recording](https://www.youtube.com/watch?v=sl55buSIJPA), [slides](https://docs.google.com/presentation/d/1kTg6SSm4TRbogwz18_CtanJftYsj8Khx6W8UJQbQgYI/edit?usp=sharing)) makes the same case from the other side, "look at your data," and to Stanford CS229 for hosting it. And thanks to the experts who rated VeriBench outputs by hand [TODO: names, if they want to be named]; none of this could have been checked without them.
