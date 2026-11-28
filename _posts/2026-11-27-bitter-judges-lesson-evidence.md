---
layout: post
title: "The Bitter Judges Lesson: Learn AI Judges the Way You Learn Any Other ML Task"
date: 2026-11-27
section: ml
draft: true
permalink: /preview/0rgha01zbq/bitter-judges-lesson-evidence/
---

*Brando Miranda — November 2026 · ~14 min read*

**TL;DR.** We validate AI judges by correlation or agreement with humans, but a human rating is a distribution, and both look only at its center. I scored five frozen frontier judges on five public human-rating sets. On DICES-350, four of the five forecast the human ratings significantly worse than a table of human frequencies, although all five beat a constant guess on agreement with the human majority (80 to 82% against about 77%). On the three ChaosNLI sets none falls below the table. Correlation mostly ranks judges as a proper score does; it cannot say whether a judge beats the table. The fix is ordinary machine learning: a strictly proper score matched to the label encoding, reported as skill over that table, and calibration on held-out human ratings.

---

Somewhere along the way, we decided that AI judges are special.

We don't validate a probabilistic classifier only by asking whether its scores rise and fall with the labels. We ask whether its probabilities are good, using a score built for that. For AI judges we still reach for correlation with humans, or agreement with the majority label, to validate them and sometimes to tune them. The code, protocols and results are in the [public repository](https://github.com/brando90/judges-dont-need-psychometrics-or-corr), and the first training and scaling experiments are in a Stanford Digital Repository [technical memo](https://doi.org/10.25740/pr787bn6444).

## 1. A human rating is a draw from a distribution

The distribution depends on the item, the rater pool and the rubric: $$p^{*}(y \mid x, \text{pool}, \text{rubric})$$. [Pavlick and Kwiatkowski (2019)](https://aclanthology.org/Q19-1043/) showed for textual inference that many disagreements persist as ratings are added, so they are not just annotation noise, and [Plank (2022)](https://aclanthology.org/2022.emnlp-main.731/) made the broader case for label variation. That target is theirs, not mine.

Once the target is a distribution, grading a judge is the ordinary problem of scoring a probabilistic forecast, and the label encoding picks the score:

1. **Binary label:** cross-entropy or the Brier score (squared error of the probabilities).
2. **Unordered categories** (entailment, neutral, contradiction): one-hot cross-entropy or the multiclass Brier score. The ranked probability score does not apply, because there is no order to respect.
3. **Finite ordinal scale** (1 to 5, or never, sometimes, always): the ranked probability score (RPS), the Brier score summed over the cumulative thresholds, alongside cross-entropy. Normalized RPS divides it by one less than the number of levels, so it runs from 0 to 1.
4. **Continuous rating:** the continuous ranked probability score or the log density.

Each is strictly proper: in expectation, only the true distribution earns the best score, which is the property correlation lacks. Whether a scale is ordinal only decides which proper score fits, not whether to use one.

I report skill over the human base rate, $$\text{skill} = 1 - S(\text{judge}) / S(\text{base rate})$$, where the base rate is a constant forecast: the histogram of other items' human ratings. Zero means no better than that table of frequencies, and negative means worse. A judge's proper score on each held-out rating is an unbiased estimate of its true risk, even with one held-out rating per item (machine-checked in Lean 4 for finite rating scales). The skill ratio is consistent, not exactly unbiased.

## 2. Is correlation really the default?

Before arguing against a ruler, I checked whether people use it. I ran a literature census of 53 sources, chosen on purpose, so the counts describe this set, not the field. Its design was committed before I coded anything; changes made during coding, such as two added coded fields, are logged as deviations. Forty of the sources are LLM-era papers that validate a judge against human labels:

1. 16 lead with a correlation: 12 of 14 graded-score papers (short of my pre-set bar for calling it the standard there) and 4 of 6 leaderboard-validation papers.
2. None of the 20 pairwise-preference, frontier-lab and retrieval or annotation papers does; 19 lead with accuracy, agreement, kappa or F1.
3. Of the 25 that select, tune or train a judge on human data, 9 say they maximized agreement or correlation, and 4 correlation alone, a count too small to lean on.
4. One of the 40 uses a proper score, a Brier score on pairwise system rankings, and none scores an item's human rating distribution.

So in this set, correlation leads for graded scores and leaderboards, agreement leads elsewhere, and both summarize the center of the distribution. Some papers already work with distributions instead. [Elangovan et al. (2024)](https://arxiv.org/abs/2410.03775) stratify by human uncertainty; [Guerdan et al. (2025)](https://arxiv.org/abs/2503.05965) show that forced-choice validation can select judges up to 31% worse than their response-set method; [Wang, Zhang and Choi (2025)](https://arxiv.org/abs/2503.03064) find that the mean of a judge's own distribution over verdicts beats its most likely verdict; and [Lyu, Do and Pergola (2026)](https://arxiv.org/abs/2610.37868) steer frozen judges toward human rating distributions, training with RPS on ordinal labels and cross-entropy on nominal ones. I am arguing for making that the default.

## 3. What correlation cannot see

Ten raters score an answer on a 0 to 5 scale: five say 0 and five say 4, so the mean is 2. Judge A reports that split. Judge B says "2, with certainty." Put this item in any test set and anything that sees a judge only through its mean ties them: Pearson, Spearman, Kendall, or squared error against the panel mean. Proper scores do not: the Brier score is 0.5 for A and 2.0 for B, and the RPS is 1.0 against 2.0, or 0.2 against 0.4 once normalized.

The toy generalizes. Squared correlation is one minus the mean squared error of the best straight-line fit of the rating on the judge's score, over the variance of the rating. So correlation is blind to a judge's level and scale, and to anything its score leaves out, such as how much the raters disagree.

It can also point the wrong way. Take a judge that, for each item, draws a rating from the true human distribution, independently of the human it is compared with, on items that differ in mean and where raters sometimes disagree. Its correlation with a human rating is $$\rho = \operatorname{Var}(\mu(X)) / \operatorname{Var}(Y)$$, the share of rating variance the input explains. Collapse it to the conditional mean $$\mu(X)$$, deleting the spread, and its squared correlation is $$\rho$$, so its correlation is $$\sqrt{\rho}$$: with $$\rho = 0.5$$ the honest judge scores 0.5 and the collapsed one 0.71. Correlation rewards a judge for forgetting that humans disagree.

I checked these in exact rational arithmetic on about two thousand random finite distributions, and the comparison of $$\sqrt{\rho}$$ with $$\rho$$ is machine-checked in Lean 4 for finite joint laws. None of it is new: [Murphy (1988)](https://doi.org/10/fc7mxd) decomposed mean-square-error skill scores into a correlation term and bias terms, and [Kumar and Hoerling (2000)](https://doi.org/10/fwhknx) showed that for a perfect model the ensemble mean outscores a single member.

## 4. Real judges, real human ratings

Each of five frozen frontier judges (GPT-6 Astra, Claude Opus 5.5, Kimi K3, GLM 5.3, DeepSeek V4.1 Flash) was asked, at temperature 0 and one call per item, for the share of human raters who would choose each label. I scored them on five public multi-annotator sets: [ChaosNLI](https://aclanthology.org/2020.emnlp-main.734/) (SNLI, MNLI and αNLI, with 100 human labels per item) and [DICES](https://arxiv.org/abs/2306.11247), where raters say whether a chatbot's last reply is unsafe (No, Unsure or Yes), with 123 raters on each of 350 conversations in the public release (DICES-350) and about 70 per item on 400 items of DICES-990. Invalid answers (0 to 6% of DICES-350 items per judge) count as a uniform forecast. Each experiment's protocol was committed before its analysis, intervals resample items, and pairwise p-values are Holm-adjusted.

The clearest result is on DICES-350. Four of the five judges are significantly worse than the human base rate, with skill from −0.177 to −0.096 and every interval below zero; on DICES-990 three are also significantly below it, and on the three ChaosNLI sets none is. This comparison is descriptive, not one of my pre-committed hypotheses, and an earlier experiment had already scored the same forecasts. Yet all five judges agree with the human majority rating 80 to 82% of the time, a few points above the roughly 77% that always answering No reaches, their Pearson correlation with the human mean rating is 0.52 to 0.61, and even Cohen's kappa, which corrects for chance, is positive for all five (0.26 to 0.40). None of these scores the probabilities, so none flags the failure.

It is a calibration failure, and a map cross-fitted on the human ratings of the other items repairs it: all five judges end up above the base rate, at +0.053 to +0.071. That repair needs human ratings. With only 25 held-out ratings, one per item, all five DICES-350 judges are below the base rate after calibration, and about 100 are needed before every judge on every set is above it (means over 50 random draws).

[![Two dot plots of five frontier judges on DICES-350. On the left, top-1 agreement with the human majority rating lies between 80 and 82 percent for all five, above a dashed line at about 77 percent for a constant forecast that always answers No. On the right, skill over the human base rate runs from minus 0.177 to plus 0.033, with four of the five below zero.]({{ site.baseurl }}assets/bitter_judges_evidence/dices350_agreement_vs_skill.png)]({{ site.baseurl }}assets/bitter_judges_evidence/dices350_agreement_vs_skill.png)

*Five frozen frontier judges on DICES-350. Left: top-1 agreement with the human majority rating; the dashed line marks always answering No. Right: normalized-RPS skill over the human base rate with 95% item-clustered bootstrap intervals; zero is the base rate.*

Agreement also misses differences between judges. GPT-6 Astra and Claude Opus 5.5 are tied on agreement with the human majority (Astra minus Opus +0.001, 95% interval −0.022 to +0.023), yet Astra's skill is 0.175 lower (0.152 to 0.200). Of the ten judge pairs, none differs significantly in agreement and eight differ in skill, seven at 0.025, the smallest Holm-adjusted p that 4,000 draws allow across all 50 comparisons, and one just under 0.05.

The result I expected and did not get is a rank reversal. My primary hypothesis, committed before the analysis, was that Pearson would significantly reverse the order of two judges that a proper score separates. It did not: 0 of 50 pair-by-dataset comparisons among the five frontier judges. A second panel that adds three small open-weight judge configurations cannot reach significance at the protocol's 4,000 draws, because with 140 comparisons the smallest Holm-adjusted p is 0.07, so its zero says nothing. A 20,000-draw rerun outside the protocol finds one there, between two readouts of the same small model on MNLI, one invalid on about half the items (Holm-adjusted p of 0.040), and none among the frontier judges.

Point estimates do disagree with the proper score in 6 of the 50 comparisons for Pearson, 10 for Spearman and 12 for agreement, but only two are significant, both Spearman. On SNLI and MNLI, Spearman prefers GPT-6 Astra to GLM 5.3 by 0.021 and 0.034 while Brier skill prefers GLM 5.3 by 0.039 and 0.098 (Holm-adjusted p of 0.025 and 0.042, the larger of the two tests in each), and neither survives calibration. So correlation mostly orders these judges fine; it cannot say whether any beats the base rate, or by how much.

Is that an artifact of the score I picked? I repeated the analysis under Brier, cross-entropy and normalized RPS, as a robustness check and not a fresh test, since I had seen the matched-rule DICES-350 result before committing its protocol. Four of the five judges are significantly below the base rate on DICES-350 under each rule (Holm-adjusted over 75 cells; Brier and cross-entropy ignore label order), and judges rank similarly across rules (Kendall's tau-b 0.6 to 1.0 on every set). The rule matters on unordered MNLI labels, where RPS does not apply: normalized RPS puts all five judges significantly above the base rate, against three under Brier and two under cross-entropy.

## 5. Is correlation a bad thing to train on?

To find out, I fit a Pearson-trained head and a cross-entropy-trained head on 16 views of seven rating sets from four public datasets (POPQUORN, SummEval, DICES-990 and ChaosNLI), re-binned to two, three or five rating levels and scored by normalized RPS (one view is unordered). Both are linear models on 24 principal components of hashed text features, with the same data and ridge penalty. On POPQUORN offensiveness at two levels, a constant forecast scores a held-out test normalized RPS of 0.116 (range 0 to 1, lower is better), the cross-entropy-trained head 0.115, and the Pearson-trained head 0.243, a raw gap of 0.128. That the cross-entropy-trained head wins on a proper score is expected, since it was trained on one; the size and source of the gap are what matter. Across views, the Pearson-trained head's skill over the base rate is below zero on 15 of 16.

Almost all of that gap is calibration, not ranking: after one validation-fitted calibration map per head, the largest gap is 0.0024 (mean over five split seeds). Calibration has two costs. It needs held-out human ratings: with 25, the calibrated Pearson-trained head is still worse than the cross-entropy-trained head used without any calibration, on all 16 views, and the gap falls to 0.0024 or less only after 100 to 200 ratings in 15 of them. And the map does not travel far. For frozen frontier judges, a map fitted on other rating sets and applied to a new one reopens the proper-score gap in 52 of 80 cases and leaves the judge significantly worse than uncalibrated in 33, mostly when moved between the inference and safety sets, though all 10 transfers between the two DICES rater pools hold. For the linear heads, the gap reopens in all 16 leave-one-dataset-out views. So I would not rule out training on correlation, but selecting by correlation still obliges you to calibrate on human ratings, a step correlation cannot check.

## 6. Where a judge fails, and how many ratings it takes to know

One skill number hides where a judge breaks. Sort items into five equal groups by human agreement (the entropy of one random half of the ratings, with skill scored on the other half). The best judge scores higher in the highest-agreement fifth than in the lowest in all 15 set-by-rule cells (9 matched to the label encoding), as expected, since contested items leave less room to beat the base rate. The sign is what matters: on DICES-350 under normalized RPS, Claude Opus 5.5 scores +0.254 in the highest-agreement fifth and −0.072 in the lowest.

With 400 items and one rating each, two judges must differ by 0.034 to 0.065 in Brier score on ChaosNLI, or 0.014 to 0.025 in normalized RPS on DICES, before a paired test at 5% has 80% power, and only 18 of the 50 judge-pair comparisons here clear that bar.

## 7. The scaling bet, held as a hypothesis

The bitter-lesson bet is that judging is ordinary probabilistic prediction, so held-out judge loss should follow ordinary scaling laws in the number of human ratings, and the metric argument becomes a budgeting question. The first look is encouraging, not conclusive. A saturating power law fits the cross-entropy-trained learning curve in 9 of 11 panels (five rating sets scored by frozen frontier judges, plus six LoRA fine-tunes) and the Pearson-trained curve in 1 of 11. Three of the nine are four-point fits (6 of 11 if only fits with more than four budgets count), budgets stop at 256 to 2,048 ratings, and the floors are extrapolations.

## 8. What I am not claiming, and what would change my mind

1. Correlation is not useless: it ranked these judges much as a proper score did, and it remains a good diagnostic.
2. The human distribution defines the target; it does not certify quality, and it depends on the rater pool. I found no detectable pool dependence in judge scores or orderings (0 of 30 score differences and 0 of 60 interaction cells significant), but the tests have little power.
3. This is five frontier judges, five public sets and verbalized probabilities at temperature 0, so it does not speak for every judge or task. The training heads are small linear models on hashed text: on 4 of 16 views even the cross-entropy-trained head does not beat a constant forecast, and on the others its skill peaks at 0.071.

What would change my mind: a wider panel of rating sets on which frontier judges, used as given, are significantly below the base rate in fewer than one judge-set cell in ten (here 7 of 25); a correlation-trained head that, calibrated on 25 ratings, matches the cross-entropy-trained head used as trained; or learning curves where the proper-loss fits stop following a power law as panels are added, or the Pearson-trained fits start to.

## 9. What I would do

1. Get a probability for every label (ask for it, read the token probabilities, or sample several times), then use the proper score that matches how the label is encoded.
2. Report skill over the human base rate with item-clustered intervals, overall and by human-agreement stratum.
3. Keep correlation and agreement as diagnostics, and select and certify with the proper score on the held-out human ratings that calibration needs anyway.
4. Calibrate on held-out human ratings (100 to 200 if you can) before trusting a judge, and again when the data or rubric changes.
5. Say how many items and ratings you had: 400 items with one rating each cannot separate close judges.

Stop treating AI judges as special. Define the distribution, evaluate with a strictly proper score matched to the label encoding, calibrate or train with a proper loss, and scale the human ratings.

---

*If you'd like to cite this post:*

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
