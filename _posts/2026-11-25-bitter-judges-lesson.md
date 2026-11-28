---
layout: post
title: "The Bitter Judges Lesson: Learn AI Judges the Way You Learn Any Other ML Task"
date: 2026-11-25
section: ml
---

*Brando Miranda — November 2026 · ~9 min read*

**TL;DR.** The AI community treats LLM-as-a-judge like a special, bespoke subfield—inventing correlation-based objectives, agonizing over human rater disagreement, and calling open-ended evaluation "unverifiable." I don't buy that category at all. Everything is verifiable once you define the target PMF or PDF $$p^{*}(y \mid x)$$ you are after—even a uniform distribution. Once you accept that the target is a conditional distribution over expert ratings (or any specified target) rather than a single deterministic score, AI judging reduces to ordinary probabilistic machine learning: evaluate — and, when you fit a judge, calibrate — with a strictly proper score matched to the label space (cross-entropy or Brier for categorical labels, Ranked Probability Score for ordinal scales, CRPS for continuous ones), plus a base-rate skill score against a constant forecast. Correlation stays a ranking diagnostic. Then the open question is data. Whether held-out loss follows ordinary scaling laws in the number of expert ratings is a hypothesis, not a finished result.

---

Somewhere along the way, we decided that AI judges are special.

When we train classifiers, language models, or world models, we know the playbook: define the target distribution, evaluate on held-out data with a strictly proper score that matches the label space, and scale the data. When a model needs fitting, we use a proper loss — and we say so, including when the last step is just calibration.

When we build AI judges, we suddenly throw that playbook out the window. We treat judging as a mystical corner of "scalable oversight." We reach for psychometric agreement statistics and correlation metrics—Pearson, Spearman, Kendall—both to evaluate judges and, increasingly, to tune them. And when human experts disagree on a rubric score, we panic and label the whole domain "unverifiable."

I think this framing is backwards. AI judging is not a special case of machine learning. The entire argument comes down to three steps.

## 1. Define the Target First (and Drop the "Unverifiable" Myth)

Before arguing about loss functions or evaluation metrics, we have to clear away a bad premise: I don't actually believe in "unverifiable tasks."

The field loves splitting the world into "verifiable" domains (compilers, unit tests, exact math answers) and "unverifiable" ones (open-ended reasoning, writing, formal specification quality). People see human disagreement in the second bucket and conclude there is no ground truth left to verify against.

That is a category error. There may be no single deterministic label waiting to be uncovered, but everything is still verifiable—even a uniform distribution. You just have to define the target PMF or PDF $$p^{*}(y \mid x)$$ you are after.

Once you specify the population of experts, rubric persona, or target process you care about, the ground truth is completely well-defined: it is the conditional distribution $$p^{*}(y \mid x)$$ over expert ratings (or whatever target outcomes you define). For expert ratings, that is the distribution of the rating a randomly chosen expert from that population would give this item. A deterministic verifier like a type checker isn't a different metaphysical species—it is just the degenerate special case where $$p^{*}(y \mid x)$$ puts all its mass on a single point. A high-entropy, multimodal, or even completely uniform distribution is just as verifiable: specify the distribution, draw held-out samples from it, and test whether your judge recovers it.

Disagreement between experts—or intrinsic stochasticity in the target—is part of that distribution, not noise to be swept under the rug.

Notice what this does not mean. It does not mean every judgment is mushy or uninformative. Where the target is concentrated (e.g., where experts agree), $$p^{*}(y \mid x)$$ is sharp, and a good judge should be confident. Where the target has genuine spread, $$p^{*}(y \mid x)$$ reflects it, and a good judge should match that spread.

What you cannot do is demand a "peaky," zero-variance ground truth on a task whose true distribution has spread. Asking for a single deterministic score where none exists is not a hard engineering problem—it is asking the target to be something it is not. You can still report one number when a decision needs it, such as the mean or the mode of the distribution, but that is a summary you chose, not a ground truth you found. But you cannot simultaneously want your judge to capture a genuinely stochastic target—like expert human judgment—and pretend that target has zero variance.

## 2. Once the Target Is a Distribution, Judging Is Ordinary Probabilistic ML

If we agree that the target is $$p^{*}(y \mid x)$$, everything else snaps back into standard machine learning. The thesis is not "always train with cross-entropy and always report RPS." It is: score the judge with a strictly proper rule matched to the label space, and report a skill score against the base rate.

- **Categorical or binary labels.** Use cross-entropy or Brier.
- **Ordinal scales** (say, 0 to 5). Use the Ranked Probability Score (RPS), which operates over the cumulative distribution and charges you by distance: predicting a 4 when the truth is 5 is not as wrong as predicting a 0. Ordinary classification accuracy misses that. Accuracy against a majority label is proper but not strictly proper: any forecast that puts the most mass on the right class gets the same score, however confident or hedged it is.
- **Continuous targets.** Use the continuous ranked probability score (CRPS).

Pair the proper score with a **base-rate skill score** — how much you beat a constant forecast of the label frequencies — so a "good" number is not just a lucky base rate. Accuracy-style metrics can stay in the table as familiar diagnostics.

This is not a new idea. Li et al. (Findings of EMNLP 2026) calibrate autoraters to preference distributions with proper scoring rules, and Lyu et al. align frozen judges to human rating distributions with RPS for ordinal labels and cross-entropy for nominal ones. The point is to use that toolkit, not to treat it as our invention.

Where does correlation fit? Correlation belongs in the toolbox as a ranking diagnostic, not as a primary training objective or final certification metric.

Why? Because correlation is not a proper scoring rule. Take Pearson correlation: it is invariant to any positive affine transformation $$a\hat{y} + b$$ ($$a > 0$$). You can shift a judge's scores, compress its scale, or distort its uncertainty, and correlation won't blink. It cannot certify level, scale, or spread. Even worse, if you optimize a judge with correlation and evaluate it with correlation, you are grading your own blind spot—looking at a narrow summary statistic and concluding you solved the problem because both train and test ignored everything else.

When you do fit or calibrate a judge, use a proper loss. Cross-entropy is strictly proper: in the limit of data and capacity, it recovers $$p^{*}(y \mid x)$$. In practice the judge's output becomes a distribution in one of a few ways: read the probabilities it puts on each rating, sample it several times, or fit a small head on top of its score. But training is secondary to evaluation. In our experiments, almost all of the raw gap between a cross-entropy head and a Pearson head is calibration. In Experiment 41, the raw CE-minus-Pearson gap reaches 0.1282 in normalized RPS; after a validation-fitted calibration step the remaining difference is at most 0.0024. Pearson can also win at very small budgets, around two labels. If a Pearson-trained judge only works once you bolt on a proper calibration step, say so and do that step on purpose. That is the point — not that ranking-based training is worthless.

## 3. The Real Pushback Isn't Philosophical — It's Sample Complexity

There are two sharp objections to this view, and both deserve to be taken seriously.

The first is statistical. Richer distributional targets carry more information than a single summary statistic, which means they can be harder to estimate from finite data. If you only have a tiny handful of target samples or human ratings, trying to fit a full conditional distribution risks fitting noise. From this angle, the probabilistic argument alone isn't enough—you have to check what happens at realistic sample sizes.

The second is practical. Most teams don't want to sample a judge multiple times per input or collect multiple target ratings per prompt. They want cheap, single-shot reliability: run the judge once, get a number, move on. Distributional matching asks you to treat both the target and the judge outputs as distributions—and to build evaluation suites that expect variability rather than hiding it.

One thing softens the statistical worry: you never estimate $$p^{*}(y \mid x)$$ item by item. The model shares strength across items, so even one or two ratings per item add up to a usable training set.

Here is where the hinge sits.

On the practical objection: wanting single-sample determinism doesn't make an inherently variable target deterministic. If our evaluation pipelines pretend variance isn't there, we aren't getting reliability—we are just deluding ourselves about our error bars.

On the statistical objection: it is completely fair, and it is an empirical question. For finite, low-dimensional discrete rating scales (like binary pass/fail or 0–5 rubrics), we aren't trying to do nonparametric density estimation in a thousand continuous dimensions—we are doing ordinary discrete classification. The real question is not "does a proper score beat correlation in the abstract?" It is: at realistic sample sizes, when does a proper fit, or even just a proper calibration step, pull ahead of an uncalibrated correlation baseline?

## 4. The Bitter Judges Lesson: Data, Not the Metric, Is the Open Question

I want to distinguish clearly between what our early evidence supports and the further bet I am making.

What we see so far: In our ongoing experiments comparing fitting objectives on ordinal rating data, a cross-entropy head starts pulling ahead of an uncalibrated Pearson head after roughly 4 to 8 total ratings (one rating per item, frozen frontier judges with a small calibration head, scored by held-out ranked probability score) and keeps improving as more ratings come in. That comparison is to uncalibrated Pearson and to a uniform forecast — not a claim that the training objective has to be cross-entropy from the first step. As noted above, once you add a calibration step, most of the gap closes. Even at modest, realistic sample sizes, *fitting the distribution* pays off; the last step that does that fitting can be training or calibration. The full experiments are in a technical memo, [Learn Judges Like Any Other Model: Cross-Entropy, Not Correlation, for Predicting Human Rating Distributions](https://doi.org/10.25740/pr787bn6444) (Stanford Digital Repository, November 25, 2026). The code, data and every number in it are in the [working repo](https://github.com/brando90/judges-dont-need-psychometrics-or-corr).

The further bet is a hypothesis, not a result: if AI judging really is just ordinary probabilistic prediction, then the Bitter Lesson applies, and held-out judge loss should follow ordinary scaling laws in the number of expert ratings (or target samples). We have a first look at that hypothesis, not a finished scaling law. The memo fits a saturating power law to our own learning curves on five public rating sets and two model families. The law fits the cross-entropy-trained curve in 9 of 11 panels, with median exponents of 0.66 on ranked probability score and 0.82 on cross-entropy in the frozen-judge cells where the floor can be identified, and it fits the correlation-trained curve in 1 of 11. Our largest budgets are a few hundred to about two thousand ratings, so the floors are extrapolations.

If that hypothesis holds, the burden of proof flips. Anyone arguing that we must stick with correlation heuristics or bespoke low-data surrogates now has to justify why the field is permanently trapped in the low-data regime.

There is a reason to expect this, and it is not a compute argument. The Bitter Lesson says that methods which keep improving as you scale beat hand-built cleverness. Here the thing you scale is expert ratings, not FLOPs. Correlation only sees the conditional mean of the ratings, so extra ratings can sharpen that one number and nothing else; it has no way to turn them into a better spread or shape. A proper loss has the whole distribution as its minimum, so every extra rating still has something left to teach it — including, in the experiments above, a cheap calibration step on a correlation-trained score.

Is that even true? Frontier labs routinely spend enormous budgets collecting domain-expert data for math, coding, and post-training. If expert judgment data—or any other target evaluation distribution—is the bottleneck for trustworthy evaluation and scalable oversight, labs can and will collect it at scale.

The interesting research question stops being "what clever non-proper metric can squeeze signal out of three noisy labels?" It becomes: how does judge loss scale with target rating data, and how should we spend a fixed labeling budget—more items with fewer samples, or fewer items with deeper distributional coverage?

Stop treating AI judges like magic. Define the distribution, evaluate with a strictly proper score matched to the label space, calibrate or train with a proper loss, and scale the data and compute.

## Appendix: Mathematical & Practical Notes

Same claims as the essay, written as identities. The prompt is $$c$$. The judge's score is a draw $$X \sim \hat{q}(\cdot \mid c)$$ and the human's score is a draw $$Y \sim p^{*}(\cdot \mid c)$$. Standardize them by their unconditional mean and standard deviation:

$$z_X = (X - \mu_X)/\sigma_X, \qquad z_Y = (Y - \mu_Y)/\sigma_Y.$$

The squared distance between the two conditional distributions on a prompt is

$$D_B(p^{*} \Vert \hat{q}) = \sum_y \big(p^{*}(y \mid c) - \hat{q}(y \mid c)\big)^2.$$

### A.1 Correlation $$\neq$$ Brier — Even on Binary Labels

Pearson correlation standardizes both scores before it compares them. Whenever both have positive variance,

$$\mathbb{E}[(z_X - z_Y)^2] = 2\big(1 - \operatorname{Corr}(X, Y)\big).$$

Squared error keeps the mean gap and the scale gap:

$$\mathbb{E}[(X - Y)^2] = (\mu_X - \mu_Y)^2 + (\sigma_X - \sigma_Y)^2 + 2\sigma_X\sigma_Y\big(1 - \operatorname{Corr}(X, Y)\big).$$

On a binary label $$Y \in \{0,1\}$$, that second line is the Brier score. A Bernoulli distribution is its mean, so there is no moment gap between the scalar mean and the PMF: scalar $$L_2$$ and Brier are the same number. Correlation still misses calibration, Brier, and cross-entropy, because a positive affine map leaves it unchanged,

$$\operatorname{Corr}(aX + b, Y) = \operatorname{Corr}(X, Y), \qquad a > 0.$$

Shift the judge, or squash its range, and the correlation holds still. Every proper score moves.

On an ordinal $$0$$–$$5$$ scale the mean is coarser than the PMF. A panel in consensus on $$2$$ and a panel split $$50/50$$ on $$\{0, 4\}$$ share the mean $$2.0$$. Anything that only sees means, correlation included, treats those two targets as one.

### A.2 Strict Anti-Properness for Sampled Judges (squared form $$\rho^{2} < \rho$$)

Condition on the prompt and draw the judge and the human independently, $$X \perp Y \mid c$$. Let $$\mu_Y(c) = \mathbb{E}[Y \mid c]$$. Suppose humans disagree on some prompts, $$\mathbb{E}[\operatorname{Var}(Y \mid c)] > 0$$, and prompts vary, $$\operatorname{Var}(\mu_Y(c)) > 0$$.

If the judge matches the truth, $$\hat{q} = p^{*}$$, independence removes the conditional covariance. Correlation only sees the share of $$\operatorname{Var}(Y)$$ that lives in the conditional mean:

$$\operatorname{Corr}(X_{p^{*}}, Y) = \frac{\operatorname{Var}(\mu_Y(c))}{\operatorname{Var}(Y)} \in (0, 1).$$

Call this value $$\rho$$. Now collapse the judge onto a zero-variance affine copy of that mean, $$X_\delta = a\mu_Y(c) + b$$ with $$a > 0$$. The copy is the wrong distribution wherever the human has spread, and it is miscalibrated whenever $$a \neq 1$$ or $$b \neq 0$$. Correlation scores the whole family the same way, and the identity that is checked formally is the squared form

$$\operatorname{Corr}(X_\delta, Y)^{2} = \operatorname{Corr}(X_{p^{*}}, Y) = \rho.$$

If $$\rho_\delta = \operatorname{Corr}(X_\delta, Y)$$ denotes the collapsed-judge correlation, then $$\rho_\delta^{2} = \rho$$, and $$\rho_\delta^{2} < \rho_\delta$$ whenever $$\rho_\delta \in (0, 1)$$. Taking the positive square root is the same fact written as $$\sqrt{\rho} > \rho$$. When within-prompt disagreement and across-prompt variation of the mean split $$\operatorname{Var}(Y)$$ evenly, $$\rho = 0.50$$: the exact distribution $$p^{*}$$ scores $$0.50$$, and a miscalibrated collapsed judge scores about $$0.707$$. So on a finite discrete rating set, as the number of prompts $$N \to \infty$$, maximizing correlation moves away from $$p^{*}$$. A strictly proper score is minimized at $$p^{*}$$, and only there.

### A.3 Single-Forward-Pass Logit Readout

A distributional judge is cheap when the ratings are a handful of tokens. Here they are `0` through `5`. One forward pass returns a logit for each of them. Normalize those logits and the six probabilities are the full predictive distribution $$\hat{q}(\cdot \mid c)$$. Sampling the judge at inference time is optional.

### A.4 Unbiased Proper Evaluation Even at $$k = 1$$ Held-Out Rater per Item

One held-out human rating per test item is enough to score that distribution. Let $$L(\hat{q}(c), y)$$ be a proper scoring rule—cross-entropy, Brier, ranked probability score, or CRPS, according to the label space—and let item $$c$$ carry $$k_c$$ held-out ratings $$y_{c,j}$$. The average over individual ratings,

$$\widehat{R}(\hat{q}) = \frac{1}{\lvert D_{\text{test}}\rvert} \sum_{c \in D_{\text{test}}} \frac{1}{k_c} \sum_{j=1}^{k_c} L\big(\hat{q}(c), y_{c,j}\big),$$

is an unbiased estimator of the risk $$\mathbb{E}_{c,\, Y \sim p^{*}(\cdot \mid c)}\big[L(\hat{q}(c), Y)\big]$$ at every finite $$k_c$$, including $$k_c = 1$$. Each held-out rating is already one draw from $$p^{*}(\cdot \mid c)$$, and the average is linear.

The plug-in distance estimates a different quantity, and at finite $$k_c$$ it is biased. Replace $$p^{*}$$ with the empirical frequencies $$\hat{p}_{\text{test}}$$ built from those ratings, and $$D_B(\hat{p}_{\text{test}} \Vert \hat{q})$$ sits above $$D_B(p^{*} \Vert \hat{q})$$ by

$$\frac{1}{k_c}\big(1 - \Vert p^{*}(c)\Vert_2^2\big).$$

More raters on the same item are what shrink that gap. The per-rating average $$\widehat{R}$$ stays unbiased with a single rater.

### A.5 Correlation Saturation, Scaling Laws, and Label Dollars

Correlation is a property of the conditional mean. Once the judge has the ranking of $$\mu_Y(c)$$, further ratings only polish that one number, and the correlation curve flattens. A proper loss is fit to the whole distribution, so a rating that leaves the mean alone can still correct the spread, and the loss still moves. Judge building is then a dollar question: the next dollar can buy another expert rating, which a proper score can still learn from, or another round of hand-tuning a correlation prompt that has already taken everything correlation is able to take. Whether those proper-score curves follow ordinary scaling laws is the hypothesis in section 4, not a settled result.

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
