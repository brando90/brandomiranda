---
layout: post
title: "The Bitter Judges Lesson: Learn AI Judges the Way You Learn Any Other ML Task"
date: 2026-11-27
section: ml
draft: true
permalink: /preview/0rgha01zbq/bitter-judges-lesson-evidence/
---

*Brando Miranda — November 2026 · ~13 min read*

**TL;DR.** We validate AI judges by correlation with humans, but a human rating is a distribution and correlation sees only its mean. I tested what that costs with five frozen frontier judges on five public human-rating sets. On DICES-350, four of the five judges are significantly worse than a table of human frequencies, although all five match the human majority 80–82% of the time and correlate 0.52 to 0.61 with the human mean, and two judges tied on agreement sit 0.175 apart in skill. The fix is ordinary machine learning: a strictly proper score matched to the label encoding, skill over the human base rate, and calibration on held-out human ratings.

---

Somewhere along the way, we decided that AI judges are special.

We don't validate a probabilistic classifier only by asking whether its scores rise and fall with the labels. We ask whether its probabilities are good, using a score built for that. For AI judges we still reach for correlation with humans, or agreement with the majority label, to validate them and sometimes to tune them. This post is mostly measurements, with a section on where I could be wrong. The code, frozen protocols and results are in the [public repository](https://github.com/brando90/judges-dont-need-psychometrics-or-corr), and the first training and scaling experiments are in a Stanford Digital Repository [technical memo](https://purl.stanford.edu/pr787bn6444).

## 1. A human rating is a draw from a distribution

A human rating is not a fixed number attached to an answer. It is a draw from a distribution that depends on the item, the rater pool and the rubric: $$p^{*}(y \mid c, \text{pool}, \text{rubric})$$. [Pavlick and Kwiatkowski (2019)](https://aclanthology.org/Q19-1043/) showed for textual inference that many disagreements persist as ratings are added, so they are not just annotation noise, and [Plank (2022)](https://aclanthology.org/2022.emnlp-main.731/) made the broader case for label variation. That target is theirs, not mine.

Once the target is a distribution, grading a judge is the ordinary problem of scoring a probabilistic forecast, and the label encoding picks the score:

1. **Binary label:** cross-entropy or the Brier score.
2. **Unordered categories** (entailment, neutral, contradiction): one-hot cross-entropy or the multiclass Brier score. The ranked probability score does not apply, because there is no order to respect.
3. **Finite ordinal scale** (1 to 5, or No, Unsure, Yes): the ranked probability score (RPS), the Brier score on the cumulative distribution divided by one less than the number of levels, alongside cross-entropy.
4. **Continuous rating:** the continuous ranked probability score or the log density.

Each is strictly proper, so the true distribution is the unique best forecast, and that is all the argument needs. Whether a scale is ordinal only decides which proper score fits, not whether to use one, and a categorical rubric is as gradable as a 0–5 one.

I report skill over the human base rate, $$\text{skill} = 1 - S(\text{judge}) / S(\text{base rate})$$, where the base rate is a constant forecast: the histogram of other items' human ratings. Zero means no better than that table of frequencies, and negative means worse. A judge's proper score on each held-out rating is an unbiased estimate of its true risk, even with one held-out rating per item.

## 2. Is correlation really the default?

Before breaking a ruler, I checked whether people use it. I ran a literature census whose groups, quotas and coding scheme were committed before I coded the first source. The 53 sources were chosen on purpose, not at random, so the counts describe this set, not the field. Of the 40 that validate an LLM judge against human labels, 16 lead with a correlation: 12 of 14 graded-score papers and 4 of 6 leaderboard-validation papers. None of the 20 pairwise-preference, frontier-lab and retrieval or annotation sources does, and 19 of them lead with accuracy, agreement, kappa or F1. Of the 25 that select, tune or train a judge on human data, 9 say they maximized agreement or correlation with human labels, and 4 correlation alone. One of the 40 scores the human rating distribution with a proper rule, at the system level only.

So in this set correlation leads for graded scores and leaderboards, agreement leads elsewhere, and both summarize the center of the distribution. A growing set of papers already works with distributions instead. [Elangovan et al.](https://arxiv.org/abs/2410.03775) stratify by human uncertainty, [Guerdan et al.](https://arxiv.org/abs/2503.05965) show that forced-choice validation can select judges up to 31% worse than their response-set method, [Chen et al.](https://arxiv.org/abs/2505.12301) align judges to human rating distributions, [Li et al.](https://arxiv.org/abs/2510.00263) calibrate judges to preference distributions, [Wang, Zhang and Choi](https://arxiv.org/abs/2503.03064) show that the mean of a judge's own judgment distribution beats its single most likely verdict, and [Lyu, Do and Pergola](https://arxiv.org/abs/2610.37868) train with RPS on ordinal labels and cross-entropy on nominal ones. I am arguing for making that the default.

## 3. What correlation cannot see

Here is the smallest example I know. Ten raters score an answer on a 0 to 5 scale: five say 0 and five say 4, so the mean is 2. Judge A reports that split. Judge B says "2, with certainty." Anything that sees a judge only through its mean cannot tell them apart: Pearson, Spearman, Kendall, or squared error against the panel mean. Proper scores can. The Brier score is 0.5 for A and 2.0 for B, and the RPS is 1.0 against 2.0, or 0.2 against 0.4 once normalized.

This is not an artifact of the toy. Squared correlation is one minus the squared error of the best affine refit of the rating on the judge's score, divided by the variance of the rating, so any positive affine rescaling of a judge leaves it unchanged and it ignores everything beyond the score.

It can also point the wrong way. Take a judge that draws, for each item, a rating from the true human distribution, independently of the human it is compared with. Its correlation with a human rating is $$\rho = \operatorname{Var}(\mu(X)) / \operatorname{Var}(Y)$$, the share of rating variance the input explains. Collapse it to the conditional mean $$\mu(X)$$, deleting the spread, and its squared correlation is $$\rho$$, so its correlation is $$\sqrt{\rho}$$: with $$\rho = 0.5$$ the honest judge scores 0.5 and the collapsed one 0.71. Correlation rewards a judge for forgetting that humans disagree.

I checked these in exact rational arithmetic on about two thousand random finite distributions, and the comparison of $$\sqrt{\rho}$$ with $$\rho$$ is machine-checked in Lean 4 for finite joint laws. None of it is new. [Murphy (1988)](https://doi.org/10/fc7mxd) decomposed mean-square-error skill scores into a correlation term and bias terms, and [Kumar and Hoerling (2000)](https://www.psl.noaa.gov/psd1/pubs/2000/details/kumar_02abs.html) showed that for a perfect model the ensemble mean outscores a single member. I only restate it for LLM judges, one label encoding at a time.

## 4. Real judges, real human ratings

Five frozen frontier judges (GPT-6 Astra, Claude Opus 5.5, Kimi K3, GLM 5.3, DeepSeek V4.1 Flash) each wrote a probability for every rating label of every item, at temperature 0, one call per item. I scored them on five public multi-annotator sets: [ChaosNLI](https://aclanthology.org/2020.emnlp-main.734/) (SNLI, MNLI and αNLI, with 100 human labels per item) and [DICES](https://arxiv.org/abs/2306.11247), where raters say whether a chatbot's last reply is unsafe (No, Unsure or Yes), with 123 raters on each of 350 conversations (DICES-350) and 69 to 76 per item on 400 items of DICES-990. Invalid answers (0 to 6% of DICES-350 items per judge) count as a uniform forecast. Protocols were committed before the analysis, intervals resample items, and p-values are Holm-adjusted.

The result that stopped me is on DICES-350. Four of the five judges are significantly worse than the human base rate, with skill from −0.177 to −0.096 and every interval below zero. Yet all five judges agree with the human majority rating 80 to 82% of the time, and their Pearson correlation with the human mean rating is 0.52 to 0.61. They usually pick the majority rating, track the human mean respectably, and still forecast the human rating distribution worse than a constant table of human frequencies. That is a calibration failure, and a small calibration map fitted on other items' human ratings repairs it: all five judges end up above the base rate, at +0.053 to +0.071. Neither correlation nor agreement is measured against the base rate, so neither can flag it.

![Two dot plots of five frontier judges on DICES-350. On the left, top-1 agreement with the human majority rating lies between 80 and 82 percent for all five. On the right, skill over the human base rate runs from minus 0.177 to plus 0.033, with four of the five below zero.]({{ site.baseurl }}assets/bitter_judges_evidence/dices350_agreement_vs_skill.png)

*Five frozen frontier judges on DICES-350. Left: top-1 agreement with the human majority rating. Right: normalized-RPS skill over the human base rate with 95% item-clustered bootstrap intervals; zero is a constant forecast of the human frequencies.*

Agreement cannot see the gap either. For GPT-6 Astra minus Claude Opus 5.5, top-1 agreement differs by +0.001 (95% interval −0.022 to +0.023) and skill by −0.175 (−0.200 to −0.152). Across the ten pairs of judges on this set, none differs significantly in top-1 agreement and eight differ significantly in skill, seven at a Holm-adjusted p of 0.025 and one just under 0.05.

The result I expected and did not get is a rank reversal. My frozen primary hypothesis was that Pearson would significantly reverse the order of two judges that a proper score separates. It did not: 0 of 50 pair-by-dataset comparisons among the five frontier judges, and 0 of 140 with three small open-weight judge configurations added. A 20,000-draw rerun outside the frozen protocol finds one Pearson reversal among the 140, between two readouts of the same small open-weight model on MNLI (Holm-adjusted p 0.040), and still none among the frontier judges.

Point estimates do disagree with the proper score in 6 of the 50 comparisons for Pearson, 10 for Spearman and 12 for top-1 agreement, but only two are significant, both Spearman. On SNLI and MNLI, Spearman prefers GPT-6 Astra to GLM 5.3 by 0.021 and 0.034 while Brier skill prefers GLM 5.3 by 0.039 and 0.098 (Holm-adjusted p of 0.025 and 0.042), and neither survives calibration. So correlation mostly orders these judges fine, and it cannot say whether any of them beats the base rate, or by how much.

Is that an artifact of the score I picked? I repeated the analysis under Brier, cross-entropy and normalized RPS, as a robustness check, not a fresh test, since I had seen the matched-rule DICES-350 result before freezing its protocol. Four of the five judges are significantly below the base rate on DICES-350 under each rule, and judges rank similarly across rules (Kendall's tau-b of 0.6 to 1.0 on every set). The rule matters where the encoding list says it should: on unordered MNLI labels normalized RPS is generous, putting all five judges significantly above the base rate against three under Brier and two under cross-entropy.

## 5. Is correlation a bad thing to train on?

To test it, I trained a Pearson-trained and a cross-entropy-trained head on 16 views of seven public rating sets (among them POPQUORN, SummEval, DICES-990 and ChaosNLI), re-binned to two, three or five rating levels. Both are linear models on 24 hashed text features, with the same data and ridge penalty. The raw gap is large. On POPQUORN offensiveness at two levels, a constant forecast scores a held-out test normalized RPS of 0.116 (range 0 to 1, lower is better), the cross-entropy-trained head 0.115, and the Pearson-trained head 0.243. Across views the raw gap reaches 0.128, and the Pearson-trained head's skill over the base rate is below zero on 15 of 16 views.

Almost all of that gap is calibration, not ranking. After one validation-fitted calibration map per head, the largest gap is 0.0024 (mean over five split seeds), so the two heads differ mainly in calibration, the one thing correlation cannot see. Calibration has two costs. It needs held-out human ratings: with 25, the calibrated Pearson-trained head is still worse on all 16 views, by 0.0097 to 0.0225, and the gap falls to 0.0024 or less only after 50 ratings in one view and 100 to 200 in the other 15. And the map does not travel: moved to another rating set or rubric, it reopens the proper-score gap in 53 of 82 judge-by-shift cases and leaves the judge significantly worse than uncalibrated in 33. So I would not say never train on correlation. I would say that selecting by correlation obliges you to calibrate on human ratings anyway, a step correlation cannot tell you is needed, and the proper score is the metric that shows when you have not.

## 6. Where a judge fails, and how many ratings it takes to know

One skill number hides where a judge breaks. Sort items into five equal groups by human agreement (the entropy of one random half of the ratings, with skill scored on the other half). The best judge's skill in the highest-agreement fifth beats its skill in the lowest-agreement fifth in 15 of 15 dataset-by-rule cells. On DICES-350 under normalized RPS, Claude Opus 5.5 scores +0.254 in the highest-agreement fifth and −0.072 in the lowest.

Report how many ratings it took. With 400 items and one rating each, two judges must differ by 0.034 to 0.065 in Brier score on ChaosNLI, or 0.014 to 0.025 in normalized RPS on DICES, before a paired test at 5% has 80% power to see it, and only 18 of the 50 judge-pair comparisons here clear that bar.

## 7. The scaling bet, held as a hypothesis

If judging is ordinary probabilistic prediction, held-out judge loss should follow ordinary scaling laws in the number of human ratings, and the metric argument becomes a budgeting question. The first look is encouraging and not conclusive. A saturating power law fits the cross-entropy-trained learning curve in 9 of 11 panels (five rating sets scored by frozen frontier judges, plus six LoRA fine-tunes) and the Pearson-trained curve in 1 of 11. Three of the nine are four-point fits (6 of 11 if only fits with more than four budgets count), the largest budgets are 256, 1,024 and 2,048 ratings, and the floors are extrapolations. It fails if proper-loss curves stop following a power law as panels are added, or if the Pearson-trained curves start to.

## 8. What I am not claiming, and what would change my mind

1. Correlation is not useless; it is a good diagnostic. A Pearson-selected G-Eval judge ranks the 16 SummEval systems at Spearman 0.877, and a four-bin calibrator lowers that to 0.835, a 0.042 difference within noise (95% interval over the 40 test documents −0.049 to +0.114).
2. The human distribution defines the target. It does not certify quality, and it depends on the rater pool. I found no rater-pool dependence in judge scores or orderings (0 of 30 score differences and 0 of 60 interaction cells significant), but the tests have little power.
3. This is five frontier judges, five public sets and verbalized probabilities at temperature 0, so it says nothing about every judge or task. The training heads are linear models on frozen text features, and on 4 of 16 views even the cross-entropy-trained head does not beat a constant forecast.
4. The identities are classical, the target is Pavlick and Kwiatkowski's and Plank's, and the literature census describes 40 sources I chose on purpose, not the field.

What would change my mind: new human-rating sets where frontier judges, used as given, rarely fall below the human base rate; a correlation-trained head that matches the cross-entropy-trained one after calibrating on 25 ratings; or proper-loss learning curves that stop following a power law as panels are added.

## 9. What I would do

1. Name how the label is encoded, then use the proper score that matches it.
2. Report skill over the human base rate with item-clustered intervals, overall and by human-agreement stratum.
3. Keep correlation and agreement as diagnostics, not as the selection rule or the certificate.
4. Calibrate on held-out human ratings (100 to 200 if you can) before trusting a judge, and again when the data or rubric changes.
5. Say how many items and ratings you had: 400 items with one rating each cannot separate close judges.

Stop treating AI judges like magic. Define the distribution, evaluate with a strictly proper score matched to the label space, calibrate or train with a proper loss, and scale the data and compute.

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
