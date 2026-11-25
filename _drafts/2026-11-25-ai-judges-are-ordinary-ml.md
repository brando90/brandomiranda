---
layout: post
title: "AI Judges Are Ordinary ML: Fit the Distribution, Then Scale the Ratings"
date: 2026-11-25
section: meta-research
---

*Brando Miranda — November 2026 · ~7 min read*

**TL;DR.** When a task has no verifiable answer, the target for an AI judge is the distribution of expert ratings, not a single score. Once you accept that, judging is ordinary supervised learning: train with cross-entropy (CE), evaluate on held-out data with proper scores such as the ranked probability score (RPS), and treat correlation as a ranking diagnostic, because it sees only the mean rating up to level and scale. In three experiments, the CE-fit (or CE-trained) judge has lower held-out RPS than its Pearson counterpart, and it almost always has lower CE and total variation distance (TVD) too (32 of 35 cells in the homework experiment, more in the others). In the main experiment that holds even where the two have almost the same correlation. The open question is then the one every ML problem has: how does held-out error fall as we add expert ratings? I predict an ordinary power law with a floor. I have not fit it yet.

---

A common objection to training AI judges with cross-entropy is that judging is special, so ordinary ML intuitions don't apply. I think judging is not special. This post is my argument for that, in three steps, plus the numbers I have so far and the one claim I have not tested.

## Step 1: define the target first

Take a task with no verifiable answer: whether a reply is helpful, whether a proof sketch is convincing, whether two sentences contradict each other. The "correct" answer is whatever some group of experts would say. Ask ten experts and you get a distribution $p^\ast(y \mid x)$ over the rating scale.

On some items the experts agree, and the distribution is peaked. On others they split, and it is spread out. Both are properties of the item, not noise on top of it. One judge has to represent both: confident where experts agree, uncertain where they don't.

Asking for one "correct" score on an item where experts split cannot work, because no such score exists. Agree on that goal first, and everything below follows from it.

## Step 2: then it is normal ML

If the target is a distribution $p^\ast(y \mid x)$, then predicting it is supervised probabilistic prediction, and we already know the recipe.

**Train with a proper loss.** Cross-entropy is proper: its minimum is the true distribution, so a model that minimizes it with enough data converges to $p^\ast$.

**Evaluate with a proper score that fits the use.** For an ordinal scale I use RPS, the squared gap between the judge's cumulative distribution and the human one along the scale. I also report held-out CE in nats and TVD, the total variation distance between the two distributions. For all three, lower is better. Accuracy-style metrics are fine as a secondary decision metric.

**Treat correlation as a diagnostic.** The reason is a short argument. Correlation sees the judge's mean rating per item, and only up to level and scale. Any judge whose mean is $a + b \cdot (\text{human mean})$ with $b > 0$ gets correlation 1, whatever its spread or shape. A proper score is minimized only at the full human distribution, which fixes the mean and every higher moment at once. So a judge can have high correlation and still be wrong about how much the experts disagree.

Nothing here asks for a special objective for judges. That's the point.

## What I measured

I compared two versions of the same judge. CE-fit picks a small head, mapping the judge's output to a distribution over the rating scale, by minimizing CE on the human ratings used to fit. Pearson-fit picks the head by maximizing Pearson correlation on the same ratings. Same judge, same data, same budget, and I count the budget in individual human ratings, not items.

In the main experiment I used five frontier judges on five public rating sets with real expert disagreement (ChaosNLI, alphaNLI and DICES). Here is the table at 256 human ratings, averaged over the five judges. Uniform is the judge that ignores the input.

| Set | RPS CE-fit | RPS Pearson-fit | RPS uniform | TVD CE-fit | TVD Pearson-fit | Pearson r CE-fit / Pearson-fit |
|---|---|---|---|---|---|---|
| ChaosNLI SNLI | 0.115 | 0.134 | 0.196 | 0.169 | 0.235 | 0.918 / 0.913 |
| DICES-350 | 0.226 | 0.276 | 0.267 | 0.163 | 0.314 | 0.567 / 0.551 |
| DICES-990 | 0.198 | 0.261 | 0.269 | 0.138 | 0.315 | 0.707 / 0.745 |

Look at the last column. On SNLI the two correlations differ by 0.005, and on DICES-990 Pearson-fit has the higher correlation. Yet on DICES-990 the Pearson-fit judge's TVD is more than twice the CE-fit judge's, and on DICES-350 its RPS is worse than uniform's. Correlation barely separates these judges. The proper scores separate them clearly.

Over all budgets and judge-by-set cells with one rating per item, CE-fit has lower held-out RPS than Pearson-fit in 172 of 175 cells, lower CE in 175 of 175, and lower TVD in 168 of 175.

The other two experiments agree.

- **Fresh homework answers.** On 160 new homework answers with the same five judges, CE-fit has lower held-out RPS in 35 of 35 judge-by-budget cells. On CE and TVD it wins 32 of 35 each, so this one is a clean win on RPS only.
- **Trained judges.** I trained two open-weight models with LoRA, once with CE and once with Pearson correlation, on the same ratings. At the largest budget, CE-trained wins on RPS, CE and TVD in 7 of 7 panels, and the RPS gaps are significant. On DICES with the 4B model, held-out CE is 0.775 against 2.870, and RPS is 0.209 against 0.285.

**Fitting the distribution wins on the scores that measure the distribution, including where correlation says the judges are tied.**

## How many ratings does it take?

A fair worry is that higher moments need more data than the mean does, so CE might only win with more ratings than anyone has. I tested that directly. With one rating per item, CE-fit has significantly lower held-out RPS than both Pearson-fit and uniform from 4 to 8 ratings in all 25 set-by-judge cells. With five ratings per item the break-even moves to 10 to 20 ratings. Those are small numbers.

It is not a free lunch, and three results go against a simple story.

- At 4 ratings the gaps are small. On DICES-350 the CE-fit RPS of 0.268 is a tie with uniform at 0.267.
- Against the raw judge with no fit at all, CE-fit wins from 8 to 256 ratings in only 14 of 25 cells. On ChaosNLI the raw frontier judge is already strong.
- A Pearson-selected head followed by a calibration step edges out CE-fit on DICES and MNLI-m by 0.002 to 0.005 RPS at 256 ratings. Calibration is itself a fit of the distribution, so I read this as support for the argument, not against it. What matters is that something fits the distribution.

So the case is strong in these experiments and not universal. I also derived the correlation limit only for infinite data. "CE is better with limited data" is something I measured, not something I proved.

## Step 3: then scaling laws apply, and data is the open question

If judging is ordinary prediction of a distribution, I expect ordinary behavior: held-out error that falls as a power law in the number of ratings, down to a floor,

$$
\text{error}(N) \;=\; \text{floor} + a\, N^{-b}.
$$

**This is a prediction, not a result.** I have curves of RPS, CE and TVD against the number of ratings for several judges and sets, and the CE-fit curves fall as ratings grow. I have not fit the law with exponents, floors and uncertainty yet, so I can't tell you which curves flatten and where.

What would change my mind:

1. The curves bend to a high floor that more ratings do not lower. That would put judging in a permanently low-data regime, which is the claim I'd want to see argued specifically.
2. CE-fit stops beating Pearson-fit as the budget grows, which would mean the early win was a small-sample effect.
3. The break-even number of ratings grows with the size of the judge or the difficulty of the task instead of staying small.

I should be fair about one limit. Within one family of judges my data cannot separate model size from everything else, so the scaling I can claim is in the number of ratings, not in judge size.

The argument turns on what we treat as the bottleneck. If the metric was the bottleneck, we would need new theory for each new kind of judge. If data is the bottleneck, we do what we do everywhere else in ML: collect more expert ratings, fit the distribution, and measure the curve. Ratings cost money and time, but they are a budget, not a law of nature.

I think of this as the bitter lesson applied to judges. The bitter lesson in AI says that general methods that scale with compute and data beat hand-built cleverness in the long run. For judges, it says that once the target is fixed, the general recipe (fit the distribution with a proper loss, add data) should beat special-purpose metric design. That is the frame of my argument, not a result. The scaling-law prediction above is the test of it.

**Define the target as the expert distribution, fit it with cross-entropy, score it with proper scores, and spend the rating budget the way we spend compute. That is the bitter lesson, for judges.**

**TLDR-end:** The target for a judge on a subjective task is the distribution of expert ratings. Train with cross-entropy, evaluate with proper scores (RPS, CE, TVD) and keep correlation as a ranking diagnostic. CE-fit has lower held-out RPS than Pearson-fit in all three experiments, and almost always lower CE and TVD (Exp 26 homework: RPS in 35 of 35 cells, CE and TVD in 32 of 35). In the main experiment it breaks even from 4 to 8 ratings at one rating per item (10 to 20 at five per item), even where correlation is nearly tied. The bitter-lesson frame, that ordinary data scaling beats special-purpose metric design for judges, rests on a scaling law of held-out error against the number of ratings, and that law is my prediction, not yet a fit.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026judgesordinaryml,
  author = {Miranda, Brando},
  title  = {AI Judges Are Ordinary ML: Fit the Distribution, Then Scale the Ratings},
  year   = {2026},
  month  = {November},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/11/25/ai-judges-are-ordinary-ml.html}},
  note   = {Blog post}
}
```
