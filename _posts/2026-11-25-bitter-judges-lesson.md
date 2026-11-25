---
layout: post
title: "The Bitter Judges Lesson: Learn AI Judges the Way You Learn Any Other ML Task"
date: 2026-11-25
section: ml
---

*Brando Miranda — November 2026 · ~5 min read*

**TL;DR.** The AI community treats LLM-as-a-judge like a special, bespoke subfield—inventing correlation-based objectives and agonizing over human rater disagreement. We shouldn't. For subjective or unverifiable tasks, the true target is a conditional distribution $$p^{*}(y \mid x)$$ over expert ratings, not a single deterministic score. Once you accept that, AI judging reduces to ordinary probabilistic machine learning: train with a proper loss (cross-entropy), evaluate with a task-aligned proper score (like Ranked Probability Score for ordinal scales), and let the Bitter Lesson take over. Data scaling—not clever metric engineering—becomes the real open question.

---

<!-- Gemini draft conversation: https://share.gemini.google/SpUOukWs1ld2 -->

Somewhere along the way, we decided that AI judges are special.

When we train classifiers, language models, or world models, we know the playbook: define the target distribution, minimize a strictly proper loss like cross-entropy, evaluate on held-out data with a metric that reflects how the system will actually be used, and scale the data.

When we build AI judges, we suddenly throw that playbook out the window. We treat judging as a mystical corner of "scalable oversight." We reach for psychometric agreement statistics and correlation metrics—Pearson, Spearman, Kendall—both to evaluate judges and, increasingly, to tune them. And when human experts disagree on a rubric score, we panic and declare that the task has "no ground truth."

I think this framing is backwards. AI judging is not a special case of machine learning. The entire argument comes down to three steps.

## 1. Define the Target First

Before arguing about loss functions or evaluation metrics, we have to agree on what we are actually trying to fit.

For subjective or unverifiable tasks—grading open-ended reasoning, judging formal specification quality, evaluating writing—there is no single deterministic label waiting to be uncovered. People often conclude from this that there is no ground truth at all. That is wrong. Once you specify the population of experts or the rubric persona you care about, the ground truth is completely well-defined: it is the conditional distribution $$p^{*}(y \mid x)$$ over expert ratings.

Disagreement between experts is part of that target, not noise to be swept under the rug.

Notice what this does not mean. It does not mean every judgment is mushy or uninformative. Where experts agree, $$p^{*}(y \mid x)$$ is sharp, and a good judge should be confident. Where experts legitimately disagree, $$p^{*}(y \mid x)$$ has spread, and a good judge should reflect that spread.

What you cannot do is demand a "peaky," zero-variance ground truth on a task that is inherently subjective. Asking for a single deterministic score where none exists is not a hard engineering problem—it is a logical contradiction. You cannot simultaneously want your judge to capture subjective human judgment and pretend that human judgment has zero variance.

## 2. Once the Target Is a Distribution, Judging Is Ordinary Probabilistic ML

If we agree that the target is $$p^{*}(y \mid x)$$, everything else snaps back into standard machine learning.

At training time, we should use a strictly proper scoring rule—cross-entropy. We already know what cross-entropy does: in the limit of data and capacity, it recovers the true conditional distribution $$p^{*}(y \mid x)$$. Nothing about AI judges calls for a special training objective.

At held-out evaluation time, we should use a metric that actually matches the decision problem:

- If the ratings lie on an ordinal scale (say, 0 to 5), standard classification accuracy misses something important: predicting a 4 when the truth is 5 is not as wrong as predicting a 0. A proper ordinal scoring rule like the Ranked Probability Score (RPS) operates over the cumulative distribution, respecting both the ordering of how wrong you are and the full distributional spread.
- If you ultimately collapse judgments into discrete point decisions, pair that with accuracy-style metrics on the held-out set.

Where does correlation fit? Correlation belongs in the toolbox as a ranking diagnostic, not as a primary training objective or final certification metric.

Why? Because correlation is not a proper scoring rule. Take Pearson correlation: it is invariant to any positive affine transformation $$a\hat{y} + b$$ ($$a > 0$$). You can shift a judge's scores, compress its scale, or distort its uncertainty, and correlation won't blink. It cannot certify level, scale, or spread. Even worse, if you optimize a judge with correlation and evaluate it with correlation, you are grading your own blind spot—looking at a narrow summary statistic and concluding you solved the problem because both train and test ignored everything else.

## 3. The Real Pushback Isn't Philosophical — It's Sample Complexity

There are two sharp objections to this view, and both deserve to be taken seriously.

The first is statistical. Richer distributional targets carry more information than a single summary statistic, which means they can be harder to estimate from finite data. If you only have a tiny handful of human ratings, trying to fit a full conditional distribution risks fitting noise. From this angle, the probabilistic argument alone isn't enough—you have to check what happens at realistic sample sizes.

The second is practical. Most teams don't want to sample a judge multiple times per input or collect multiple human ratings per prompt. They want cheap, single-shot reliability: run the judge once, get a number, move on. Distributional matching asks you to treat both human ratings and judge outputs as distributions—and to build evaluation suites that expect variability rather than hiding it.

Here is where the hinge sits.

On the practical objection: wanting single-sample determinism doesn't make an inherently variable target deterministic. If our evaluation pipelines pretend variance isn't there, we aren't getting reliability—we are just deluding ourselves about our error bars.

On the statistical objection: it is completely fair, and it is an empirical question. For finite, low-dimensional discrete rating scales (like binary pass/fail or 0–5 rubrics), we aren't trying to do nonparametric density estimation in a thousand continuous dimensions—we are doing ordinary discrete classification. The real question is: how many ratings does it actually take for cross-entropy to beat low-data surrogates?

## 4. The Bitter Judges Lesson: Data, Not the Metric, Is the Open Question

I want to distinguish clearly between what our early evidence supports and the further bet I am making.

What we see so far: In our ongoing experiments comparing training objectives on ordinal rating data, cross-entropy fitting doesn't need massive datasets to beat correlation-style baselines—it starts pulling ahead after roughly 4 to 8 ratings and keeps improving as more ratings come in. Even at modest, realistic sample sizes, fitting the distribution directly pays off.

The further bet: If AI judging really is just ordinary probabilistic prediction, then the Bitter Lesson applies. Held-out judge loss should follow ordinary scaling laws in the number of expert ratings. (To be clear: scaling laws for judges is still a hypothesis we haven't fitted yet—it is a prediction, not a finished result.)

If that prediction holds, the burden of proof flips. Anyone arguing that we must stick with correlation heuristics or bespoke low-data surrogates now has to justify why the field is permanently trapped in the low-data regime.

Is that even true? Frontier labs routinely spend enormous budgets collecting domain-expert data for math, coding, and post-training. If expert judgment data is the bottleneck for trustworthy evaluation and scalable oversight, labs can—and will—collect it at scale.

The interesting research question stops being "what clever non-proper metric can squeeze signal out of three noisy labels?" It becomes: how does judge loss scale with expert ratings, and how should we spend a fixed rating budget—more items with fewer raters, or fewer items with deeper distributional coverage?

Stop treating AI judges like magic. Define the distribution, minimize cross-entropy, evaluate with a proper score, and scale the data.

## Citation

```bibtex
@misc{miranda2026bitterjudgeslesson,
  author       = {Miranda, Brando},
  title        = {The Bitter Judges Lesson: Learn AI Judges the Way You Learn Any Other ML Task},
  year         = {2026},
  month        = {Nov},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/11/25/bitter-judges-lesson.html}},
  note         = {Blog post}
}
```

*Opinion piece, work in progress (Nov 25, 2026).*
