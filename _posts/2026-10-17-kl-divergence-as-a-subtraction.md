---
layout: post
title: "Reading KL Divergence as a Subtraction: Displacement, Asymmetry, and the Log-Likelihood View"
date: 2026-10-17
section: ml
---

*Brando Miranda — October 2026 · ~14 min read*

**TL;DR.** KL divergence gets taught with several personalities (extra bits, cross-entropy minus entropy, "relative entropy," a "divergence" that is not a distance), and for years each one felt like its own thing to me. This post builds one grammar for all of them. Start with what we trust: $$B - A$$ is the displacement of $$B$$ from $$A$$. Read $$D_{\mathrm{KL}}(p \Vert q)$$ the same way, as $$p \mathbin{-^{\mathrm{KL}}_{p}} q$$: the divergence of $$p$$ from $$q$$, with baseline $$q$$, measured on samples from $$p$$. Unroll it and it really is a subtraction: $$\mathbb{E}_{X \sim p}[\log p(X) - \log q(X)]$$, the average log-likelihood gap between the two models on $$p$$'s own data. Pointwise, that gap flips sign when you swap $$p$$ and $$q$$, exactly like $$B - A = -(A - B)$$. **All of KL's asymmetry comes from which distribution you average under**, which is why I put it in the notation. The view is not new as math (Kullback and Leibler motivated KL exactly this way in 1951), but in 14 years of ML I had never seen it taught first, and I think it should be. This is the first post in a series on thinking about ML with less arbitrariness.

---

## Why KL felt arbitrary to me

I've been doing machine learning since 2012. I have used KL divergence in losses, in bounds, in RL regularizers, in variational inference. And every time I met it, it showed up wearing a different outfit:

- the **excess bits** you pay for coding data from $$p$$ with a code built for $$q$$;
- **cross-entropy minus entropy**, $$H_p(q) - H_p(p)$$, with minus signs everywhere;
- a "**divergence**," which we are told is like a distance, except when it isn't.

Each version is correct. What bothered me is that I had to switch mental models depending on the textbook, and the signs never felt natural. I want something less arbitrary: **one notation, one picture, and every classical formula falls out of it.** That's the goal of this series, and KL is the first test case.

In my [score matching post](https://cs.stanford.edu/people/brando9/2026/06/09/score-matching-training-ebms-without-z.html) I subscripted the Fisher divergence with the distribution carrying the expectation and said I'd write the KL divergence the same way if I could rewrite the textbooks. This post does that, and it turns out the subscript is the whole story of the asymmetry.

## Start with what we trust: $$B - A$$

Two points $$A$$ and $$B$$. The vector

$$B - A$$

is the **displacement of $$B$$ from $$A$$**: start at $$A$$, travel to $$B$$. The thing you subtract is your baseline, where you start. Its length is the ordinary distance,

$$d(A, B) \;=\; \Vert B - A \Vert_2 .$$

![My first page of notes: B minus A as the displacement of B from A, going from A to B, then asking how a KL divergence between two distributions would read in the same grammar]({{ site.baseurl }}assets/kl_divergence_displacement/01-displacement-b-minus-a-and-kl.jpg)

Everything we like about distances is visible here. The length is nonnegative and zero only when $$A = B$$. It is symmetric, because $$A - B = -(B - A)$$ and the norm forgets the sign. And it obeys the triangle inequality. Hold on to the sign-flip fact: **the displacement is antisymmetric, the length is symmetric.** That split is going to explain KL.

## Distributions as points

Now take two distributions $$p$$ and $$q$$ over the same space. Think of each as a point: a vector of probabilities, one coordinate per outcome $$x$$ (infinitely many coordinates in the continuous case), normalized to sum to one. This is an analogy, not a theorem, but it suggests the question: **what is the displacement of $$p$$ from $$q$$?**

Here is the notation I'll use for the rest of the series:

$$D_{\mathrm{KL}}(p \Vert q) \;=\; D^{\,p}_{\mathrm{KL}}(p \Vert q) \;=:\; p \mathbin{-^{\mathrm{KL}}_{p}} q \;=\; \Delta^{\mathrm{KL}}_{p}(q \to p).$$

Read it out loud: **the KL divergence of $$p$$ from $$q$$, measured on samples from $$p$$.** Baseline $$q$$, destination $$p$$, just like $$B - A$$ has baseline $$A$$. The superscript says which kind of subtraction; the subscript says whose samples we average over.

I'll own a confusion here, because it's exactly the one this notation prevents. On my first pass, in blue ink in the margin of a book chapter, I drew the arrow as $$p \to q$$, as if $$p$$ were "going to" $$q$$. With the $$B - A$$ grammar it is the other way around: in $$p \mathbin{-^{\mathrm{KL}}_{p}} q$$, $$q$$ is the starting point and we are measuring how far $$p$$ sits from it. That's why I thought my blue notes were wrong.

![A later page: p minus-KL-sub-p q equals the divergence of p from q, with the triangle picture from q to p and the excess-bits reading next to it]({{ site.baseurl }}assets/kl_divergence_displacement/06-divergence-of-p-from-q.jpg)

## Unroll it: KL really is a subtraction

Write the definition out and the subtraction is sitting right there:

$$p \mathbin{-^{\mathrm{KL}}_{p}} q \;=\; \mathbb{E}_{X \sim p}\big[\, \log p(X) \;-\; \log q(X) \,\big].$$

Define the pointwise **log-likelihood displacement**

$$\ell(x) \;:=\; \log p(x) - \log q(x).$$

Then KL is just $$\mathbb{E}_p[\ell(X)]$$. As a procedure:

1. Sample $$x \sim p$$.
2. Score it under both models: $$\log p(x)$$ and $$\log q(x)$$.
3. Subtract. That's how much likelier $$p$$ makes this $$x$$ than $$q$$ does, in log units (nats with $$\ln$$, bits with $$\log_2$$).
4. Average over many samples.

So $$D_{\mathrm{KL}}(p \Vert q)$$ is **the average log-likelihood advantage that $$p$$ has over $$q$$ on $$p$$'s own data.** No minus signs to keep track of, no codes. A difference of two log-likelihoods, averaged.

![The page where it clicked: p minus-KL-sub-p q written as E_p of log p(X) minus log q(X), the triangle picture in log-likelihood space, and the recipe sample, compute log probs, compare]({{ site.baseurl }}assets/kl_divergence_displacement/05-log-likelihood-difference.jpg)

Two things are worth checking against the $$B - A$$ picture.

**Nonnegative, zero only at equality.** For a particular $$x$$, $$\ell(x)$$ can be negative: $$q$$ can like some of $$p$$'s samples more than $$p$$ does. But on average, on $$p$$'s turf, $$p$$ always wins or ties. That's Gibbs' inequality, one line of Jensen:

$$-\,\mathbb{E}_p[\ell(X)] \;=\; \mathbb{E}_p\!\left[\log \frac{q(X)}{p(X)}\right] \;\le\; \log \mathbb{E}_p\!\left[\frac{q(X)}{p(X)}\right] \;=\; \log 1 \;=\; 0,$$

with equality only when $$p = q$$ (almost everywhere).

**Sometimes it literally is a distance.** Take two Gaussians with the same variance, $$p = \mathcal{N}(\mu_p, \sigma^2)$$ and $$q = \mathcal{N}(\mu_q, \sigma^2)$$. Then

$$p \mathbin{-^{\mathrm{KL}}_{p}} q \;=\; \frac{(\mu_p - \mu_q)^2}{2\sigma^2},$$

which is **half the squared Euclidean distance between the means**, in units of $$\sigma$$. The displacement picture isn't just a mnemonic; in the simplest case it is exactly the old distance.

## Where the asymmetry lives

Here is the payoff. Swap $$p$$ and $$q$$ in the pointwise displacement and it flips sign, exactly like a vector:

$$\log q(x) - \log p(x) \;=\; -\,\ell(x).$$

So the reverse KL is

$$q \mathbin{-^{\mathrm{KL}}_{q}} p \;=\; \mathbb{E}_{X \sim q}\big[-\ell(X)\big].$$

**Same pointwise displacement, opposite sign, different averaging distribution.** In Euclidean space the norm forgets the sign and you get symmetry for free. In KL the "norm" is an average, and the average is taken under one of the two endpoints. Change the endpoint you sample from and you change the number. The asymmetry is entirely about **whose turf you sample on**, which is exactly what the subscript in $$\mathbin{-^{\mathrm{KL}}_{p}}$$ records.

A concrete case. Let $$p = \mathcal{N}(0, 1)$$ (narrow) and $$q = \mathcal{N}(0, 2^2)$$ (wide). Then

$$p \mathbin{-^{\mathrm{KL}}_{p}} q \;\approx\; 0.32 \text{ nats}, \qquad q \mathbin{-^{\mathrm{KL}}_{q}} p \;\approx\; 0.81 \text{ nats}.$$

On $$p$$'s data, the wide $$q$$ is a bit diffuse but never shocked: cheap. On $$q$$'s data, the narrow $$p$$ keeps seeing samples out in the tails that it thought were nearly impossible: expensive. This is the same fact behind "forward KL is mode-covering, reverse KL is mode-seeking," and why maximum likelihood (forward) and variational inference (reverse) behave so differently. Fit a single Gaussian $$q$$ to a two-mode $$p$$ both ways and the subscript decides everything:

![Two panels. Left: the Gaussian q that minimizes the forward KL, averaged under p, spreads out to cover both modes of p. Right: the Gaussian q that minimizes the reverse KL, averaged under q, sits on the larger mode and ignores the other]({{ site.baseurl }}assets/kl_divergence_displacement/07-forward-vs-reverse-kl.png)

Averaged under $$p$$ (left), any region where $$p$$ has mass and $$q$$ doesn't costs a huge $$\ell(x)$$, so $$q$$ stretches to cover everything. Averaged under $$q$$ (right), $$q$$ only gets scored where it puts its own samples, so it's free to ignore a whole mode. Koller and Friedman's section on M- and I-projections (Section 8.5) is the cleanest treatment of this I know.

If you want a symmetric quantity, add the two directions (Jeffreys' divergence):

$$p \mathbin{-^{\mathrm{KL}}_{p}} q \;+\; q \mathbin{-^{\mathrm{KL}}_{q}} p \;=\; \int \big(p(x) - q(x)\big)\big(\log p(x) - \log q(x)\big)\, dx .$$

I like this identity a lot: a difference in probability space times a difference in log space. Both subtractions are visible at once.

## How KL is and isn't like a distance

Putting it side by side with the thing we started from:

| | Half squared Euclidean, $$\tfrac12 \Vert B - A \Vert^2$$ | KL, $$p \mathbin{-^{\mathrm{KL}}_{p}} q$$ |
| --- | --- | --- |
| Pointwise displacement | $$B - A$$ | $$\log p(x) - \log q(x)$$ |
| Swapping the endpoints | flips the displacement's sign | flips the displacement's sign |
| Nonnegative, zero only at equality | yes | yes (Gibbs) |
| Symmetric | yes | no: the average is under one endpoint |
| Triangle inequality | no (the unsquared distance has it) | no |
| Bregman divergence generated by | $$\tfrac12 \Vert x \Vert^2$$ | negative entropy $$\sum_x p(x) \log p(x)$$ |
| Locally, near equality | itself | $$\tfrac12\, \delta^\top F(\theta)\, \delta$$, with $$F$$ the Fisher information |

The honest summary: **KL is not a distance, but it behaves like half a squared distance.** It belongs to the same family (Bregman divergences) as squared Euclidean distance. Nearby distributions see a quadratic form: $$D_{\mathrm{KL}}(p_\theta \Vert p_{\theta + \delta}) \approx \tfrac12 \delta^\top F(\theta) \delta$$, so locally it is a squared length in the Fisher metric. It even has a Pythagorean identity for projections onto nice families of distributions (Csiszár, 1975). What it gives up is symmetry, and now we know exactly why.

## Why I'd teach the log-likelihood view first

Three reasons.

**The signs make sense.** The bits view counts *cost*, so it is built from $$-\log$$ terms, and KL becomes cost minus cost with sign flips you have to babysit. The log-likelihood view counts *plausibility*: bigger is better, and KL is the plausibility gap. Same number, no babysitting.

**Maximum likelihood falls out in one line.** If $$p$$ is the data distribution and $$q_\theta$$ is your model,

$$p \mathbin{-^{\mathrm{KL}}_{p}} q_\theta \;=\; \underbrace{\mathbb{E}_p[\log p(X)]}_{\text{does not depend on } \theta} \;-\; \mathbb{E}_p[\log q_\theta(X)].$$

Minimizing over $$\theta$$ is maximizing the expected log-likelihood, and with samples you replace $$\mathbb{E}_p$$ by an average over your dataset. **Maximum likelihood is minimizing the forward KL from the data to the model.** In the displacement grammar: you are moving the baseline $$q_\theta$$ toward the data, scored on the data's own samples.

![Margin notes on a book chapter: why minimizing expected log-loss picks the true conditional, p as the reference distribution we sample from, q as the approximating distribution, and KL written as expected I(q) minus I(p)]({{ site.baseurl }}assets/kl_divergence_displacement/04-book-page-log-loss-notes.jpg)

**It connects to the rest of statistics.** $$\ell(x)$$ is the log-likelihood ratio, the central object of hypothesis testing, Bayesian evidence, importance sampling, and policy-gradient RL. Once KL is "average $$\ell$$," a lot of ML stops looking like a collection of unrelated tricks. That's Appendix A.

## Where this view came from, and why I'd never seen it

I didn't get this from a course or a textbook. I got it while working through these notes with an AI model (Gemini): I was asking about the excess-bits formula, and it rewrote KL as $$\mathbb{E}_p[\log p - \log q]$$ without my asking. It clicked immediately, and my honest reaction was: fourteen years, and nobody ever showed me it like this?

So I went looking for whether it's new. **It isn't, as math.** Kullback and Leibler (1951) introduced the quantity as "the mean information for discrimination" between two hypotheses "per observation from" one of them, which is precisely the expected log-likelihood ratio, and Kullback (1959) preferred the name *discrimination information*. Akaike (1973) built AIC on the same reading, and Wikipedia's article has a whole "statistics" interpretation along these lines. There are good blog posts that lead with it too, like Alex Etz's 2018 notes: KL is "the expected log likelihood ratio in favor of the true distribution." Statisticians have had this view for 75 years.

Then I went through my own shelf, and the formula is everywhere:

- Goodfellow, Bengio and Courville's *Deep Learning* writes it exactly as $$\mathbb{E}_{x \sim P}[\log P(x) - \log Q(x)]$$ (eq. 3.50), and then explains it as extra bits.
- MacKay's *Information Theory, Inference, and Learning Algorithms* defines relative entropy next to Gibbs' inequality (Section 2.6) and reads it as wasted bits. Much later, in the codebreaking chapter (Sections 18.3–18.4), he calls a log-likelihood ratio the "weight of evidence" and computes Turing's *expected* weight of evidence per line of text. That is a KL divergence, in decibans, without the link being drawn.
- Hogg, McKean and Craig: the proof that the true parameter eventually has the highest likelihood (Theorem 6.1.1 in the 7th edition) averages $$\log \frac{f(X_i;\theta)}{f(X_i;\theta_0)}$$ over the sample and uses Jensen to show the limit is negative. That limit is minus a KL divergence, never named.
- Wasserman's *All of Statistics* (Section 9.5) does name it, and proves maximum likelihood is consistent with exactly that average.
- Bishop's PRML (Section 1.6.1) approximates KL by a sample average of $$\ln p(x_n) - \ln q(x_n \mid \theta)$$ to show maximum likelihood is minimizing KL.
- *The Elements of Statistical Learning* names KL once, in independent component analysis (Section 14.7.2).

So the subtraction is written down in the standard books, sometimes even in its sampled form. What I could not find is any of them **leading** with it as the intuition: the headline is always bits. And I couldn't find anyone folding it into one displacement grammar where the averaging distribution is part of the notation and explains the asymmetry. That part is my framing, and it's the part I care about.

Why did it take me so long? My guess, and this is not a complaint about anyone: in a class, a talk, or a paper there's a syllabus or a page limit, and "wait, why is it a ratio? why that sign?" feels like a question you're supposed to already know the answer to. So it doesn't get asked, and nobody stops to rebuild the foundations ([I've written about that pressure before](https://cs.stanford.edu/people/brando9/2026/09/17/be-shy-but-ask-anyway.html)). I'm at a point where I'm happy to ask the basic question out loud and take the time to rebuild things. And AI changes the economics of that: a tireless sparring partner that never makes you feel slow. **A curious person who works hard with AI can now understand the foundations more deeply than any course gave them.** That's the bet behind this series.

## Appendix A: why ratios, and not differences?

![A notepad page: appendix comments, log p over q shows up in hypothesis testing and in PPO, and the question of why ratios appear instead of standard differences]({{ site.baseurl }}assets/kl_divergence_displacement/03-why-ratios-margin-note.jpg)

My note to myself was: *what is the fundamental thing going on? Why are ratios more natural than standard differences?* A few reasons, all of which are really the same reason, that $$\log p - \log q$$ is the right subtraction for probabilities:

- **Evidence multiplies.** For $$n$$ independent samples, the likelihood ratio of the whole dataset is the product of per-sample ratios, so its log is a sum: $$\sum_i \ell(x_i)$$. KL is the expected evidence per sample. Raw differences $$p(x) - q(x)$$ don't compose across independent observations at all.
- **It doesn't care about your coordinates.** Change variables $$y = g(x)$$ and both densities pick up the same Jacobian factor. In the ratio it cancels; in $$p(x) - q(x)$$ it doesn't. So KL is the same number in any parametrization of $$x$$, which is what you want from a statement about distributions rather than about coordinates.
- **Bayes is additive in log-ratios.** Posterior odds equal prior odds times the likelihood ratio, so $$\ell(x)$$ is literally how much one observation moves your log-odds toward $$p$$ (Good and Turing called it *weight of evidence*).
- **Hypothesis testing.** By the Neyman–Pearson lemma, thresholding the likelihood ratio is the most powerful test between $$p$$ and $$q$$. And by Stein's lemma, with $$n$$ samples from $$p$$ the best achievable probability of wrongly accepting $$q$$ decays like $$e^{-n D_{\mathrm{KL}}(p \Vert q)}$$. KL is the exponent of distinguishability. (Kullback and Leibler's paper is titled *On Information and Sufficiency* for a reason: the likelihood ratio is a sufficient statistic for telling $$p$$ from $$q$$.)
- **Changing measure needs a ratio.** Importance sampling: $$\mathbb{E}_p[f(X)] = \mathbb{E}_q\big[\tfrac{p(X)}{q(X)} f(X)\big]$$. This is where PPO's ratio comes from. It's $$r_t(\theta) = \pi_\theta(a_t \mid s_t) / \pi_{\theta_{\text{old}}}(a_t \mid s_t)$$, **new over old** (I always forget which way), and it reweights samples collected by the old policy. Its log is our $$\ell$$ for the two policies. The ratio is not itself a KL: averaged under the new policy, $$\log r$$ gives $$D_{\mathrm{KL}}(\pi_\theta \Vert \pi_{\text{old}})$$, and on the old policy's samples, $$\mathbb{E}_{\text{old}}[-\log r]$$ gives $$D_{\mathrm{KL}}(\pi_{\text{old}} \Vert \pi_\theta)$$, the direction TRPO constrains. PPO's clipping of $$r$$ is a cheap trust region on that same pointwise quantity.

Differences of probabilities do give you real distances, for example total variation $$\tfrac12 \sum_x \lvert p(x) - q(x) \rvert$$, and Pinsker's inequality bounds it by KL: $$\mathrm{TV}(p, q) \le \sqrt{D_{\mathrm{KL}}(p \Vert q)/2}$$. They just don't have the properties above, which is why ratios keep showing up everywhere in ML.

## Appendix B: the classical bits view, side by side

The textbook route starts from surprisal. Seeing $$x$$ with probability $$p(x)$$ costs

$$-\log_2 p(x) \text{ bits}, \qquad \text{e.g. } p(x) = 2^{-3} \;\Rightarrow\; 3 \text{ bits}.$$

Average it and you get entropy. Writing the sampling distribution as a subscript, as everywhere in this post:

$$H_p(q) \;:=\; \mathbb{E}_{X \sim p}[-\log q(X)] \quad \text{(cross-entropy)}, \qquad H_p(p) \;=\; \mathbb{E}_{X \sim p}[-\log p(X)] \quad \text{(entropy)}.$$

$$H_p(q)$$ is the expected code length when the data come from $$p$$ but your code was built for $$q$$; $$H_p(p)$$ is the best you can do. Their difference is the classical reading of KL, the **excess bits** you waste by using the wrong code:

$$p \mathbin{-^{\mathrm{KL}}_{p}} q \;=\; H_p(q) - H_p(p) \;=\; \mathbb{E}_p[-\log q(X)] - \mathbb{E}_p[-\log p(X)] \;=\; \mathbb{E}_p[\log p(X) - \log q(X)].$$

![My notes on the book page: KL as H_p(q) minus H_p(p), the excess bits of using q to encode p when sampling from p, which is also the unsymmetric difference of the log-likelihoods of p from q]({{ site.baseurl }}assets/kl_divergence_displacement/02-book-page-excess-bits.jpg)

Same number, two ways of thinking:

- **Bits view:** a difference of *costs*. Bigger is worse, so everything carries a minus sign, and you subtract the optimal cost from the suboptimal one.
- **Log-likelihood view:** a difference of *plausibilities*. Bigger is better, no minus signs, and you subtract the baseline model's log-likelihood from the true model's, on the true model's data.

The bits view is the right one when you actually care about compression. For learning, where everything we optimize is a log-likelihood anyway, I find the second one far easier to hold in my head. Use whichever builds your intuition, but know that they are the same subtraction.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026klsubtraction,
  author = {Miranda, Brando},
  title  = {Reading KL Divergence as a Subtraction: Displacement, Asymmetry, and the Log-Likelihood View},
  year   = {2026},
  month  = {October},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/10/17/kl-divergence-as-a-subtraction.html}},
  note   = {Blog post}
}
```

{% comment %}
Google Doc copy (private): https://docs.google.com/document/d/1aGqjOf5SRyY_to_oFpH2KuYY4uQtxPW6NUMGowXXVSo/edit
{% endcomment %}
