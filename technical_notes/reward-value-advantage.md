# Reward, Value, Advantage — and why ρ measures advantage, not reward

**TLDR:** Advantage is reward minus what you already expected. It is invisible to the argmin in value/policy iteration, which is why a Bertsekas-style course never names it, and load-bearing in policy gradient, where magnitude survives into the update. In the four-scale environments paper, ρ counts admitted advantage mass per generated token — not reward — and advantage is exactly zero at both ends of the difficulty range even when reward is 0.0 or 1.0.

Notes from a session on 09-20-2026.

---

## 1. Three objects, one subtraction

**Advantage is what's left of the reward after you subtract what you already expected.**

Start with what you get. For one response $y$ to prompt $x$, the verifier returns

$$
r(x,y)\in\{0,1\}.
$$

That is the reward. One number, no expectation, no policy in sight.

Now ask what you *expected* before generating. The policy is a distribution over responses, so average the reward over it:

$$
\boxed{
V^\pi(x)
\;=\;
\underbrace{\mathbb E_{y\sim\pi(\cdot\mid x)}\bigl[r(x,y)\bigr]}_{\text{average over responses my policy would write}}
\;=\;
p_x .
}
$$

**In this setup the value function is just the prompt's success probability.** Not an abstraction — $p_x$ is a number you estimate by sampling eight rollouts and counting.

Advantage is the difference:

$$
\boxed{
A^\pi(x,y)
\;=\;
\underbrace{r(x,y)}_{\text{what this response got}}
\;-\;
\underbrace{V^\pi(x)}_{\text{what I expected}}
\;=\;
r(x,y)-p_x .
}
$$

Binary reward means it takes exactly two values. For a prompt solved 25% of the time, a success scores $1-0.25=+0.75$ and a failure scores $0-0.25=-0.25$. Flip to a prompt solved 90% of the time: success is $+0.1$, failure is $-0.9$. **The rare outcome always carries the larger magnitude**, because it is the one that carries information.

The property that matters most:

$$
\mathbb E_{y\sim\pi}\bigl[A^\pi(x,y)\bigr] = \mathbb E[r] - p_x = 0 .
$$

You cannot beat your own average on average.

---

## 2. Why a classical DP course never names it

**Because value iteration only ever needs the sign of the advantage, and a sign does not need a name.**

The ECE course (Markov chains, MDPs, discounted cost, value and policy iteration, LP formulation, Q-learning, SARSA, TD(λ)) is Bertsekas lineage. There you find a policy *indirectly*: compute a value function, then read the policy off it with an argmin.

Watch the policy improvement step, in the cost convention:

$$
\mu_{k+1}(s)=\arg\min_a Q_{\mu_k}(s,a).
$$

Subtracting $J_{\mu_k}(s)$ changes nothing, because it is constant in $a$:

$$
\arg\min_a Q_{\mu_k}(s,a)
=\arg\min_a\bigl[\underbrace{Q_{\mu_k}(s,a)-J_{\mu_k}(s)}_{\text{the advantage}}\bigr].
$$

**The advantage is invisible to an argmin.** You were always allowed to subtract it, you gained nothing, so nobody wrote it down.

But the proof that policy iteration improves is entirely about this quantity. $J_{\mu_{k+1}}\le J_{\mu_k}$ holds because

$$
Q_{\mu_k}\bigl(s,\mu_{k+1}(s)\bigr)-J_{\mu_k}(s)\;\le\;0 .
$$

That is the advantage, negative, used as a proof device and left unnamed.

It appeared a second time too. The TD error from TD(λ):

$$
\delta_t=r_t+\gamma V(s_{t+1})-V(s_t),
\qquad
\boxed{\;\mathbb E[\delta_t\mid s_t,a_t]=A^\pi(s_t,a_t).\;}
$$

Every TD error ever computed was a noisy advantage sample.

**So why does it get a name in policy gradient?** Because there is no argmin. You differentiate:

$$
\nabla_\theta J
=\mathbb E\Bigl[\sum_t\nabla_\theta\log\pi_\theta(a_t\mid s_t)\,\Psi_t\Bigr],
$$

and $\Psi_t$ multiplies the gradient. **Magnitude now survives into the update.** Put $r$ in that slot and every sampled response gets pushed up, since $r\ge 0$; only relative sizes sort winners from losers. Put $r-V^\pi$ there and failures get actively pushed down.

The subtraction is free, because any action-independent baseline has zero expectation:

$$
\mathbb E_{a\sim\pi}\bigl[b(s)\nabla_\theta\log\pi_\theta(a\mid s)\bigr]
=b(s)\,\nabla_\theta\underbrace{\textstyle\sum_a\pi_\theta(a\mid s)}_{=\,1}=0 .
$$

Same expected gradient, much lower variance. In dynamic programming the subtraction is worthless; in policy gradient it is the difference between learning and not.

---

## 3. Equation 2 is this, with the siblings as the critic

There is no critic in the contract, so estimate $V^\pi(x_g)=p_{x_g}$ from the other seven rollouts:

$$
\boxed{
a_{gi}=r_{gi}-\underbrace{\frac{1}{G-1}\sum_{j\ne i}r_{gj}}_{\widehat{V^\pi}(x_g)\ \text{from siblings}} .
}
$$

**Leave-one-out is not a style choice.** The unbiasedness proof needs the baseline independent of the action taken; including $r_{gi}$ in its own baseline breaks it. The price is a constant gain:

$$
a_{gi}=\frac{G}{G-1}\bigl(r_{gi}-\bar r_g\bigr),
\qquad \tfrac{8}{7}\approx 1.143 .
$$

So the contract is standard GRPO mean-centering, minus the std division, times 8/7. It is not a new estimator, and a reviewer who spots the identity should not be left thinking it is.

---

## 4. Why this decides everything in the environments paper

**The quantity that drives learning is advantage, and advantage is zero at both ends of the difficulty range even though reward is not.**

With $k$ successes in a group of eight, correct responses get $\frac{8-k}{7}$, incorrect get $-\frac{k}{7}$, and the total absolute mass is

$$
A_g^{\mathrm{raw}}=\frac{2k(G-k)}{G-1}.
$$

Verified numerically against the per-response values:

| k (successes) | mean reward | A(+) | A(−) | A_raw |
|---|---|---|---|---|
| 0 | 0.000 | — | 0.000 | **0.000** |
| 1 | 0.125 | 1.000 | −0.143 | 2.000 |
| 2 | 0.250 | 0.857 | −0.286 | 3.429 |
| 3 | 0.375 | 0.714 | −0.429 | 4.286 |
| 4 | 0.500 | 0.571 | −0.571 | **4.571** |
| 5 | 0.625 | 0.429 | −0.714 | 4.286 |
| 6 | 0.750 | 0.286 | −0.857 | 3.429 |
| 7 | 0.875 | 0.143 | −1.000 | 2.000 |
| 8 | 1.000 | 0.000 | — | **0.000** |

Read the two ends. At $k=8$ the reward is a perfect 1.0 and the advantage mass is exactly zero. At $k=0$ the reward is 0.0 and the mass is also exactly zero. **A prompt the model always solves and a prompt it never solves are indistinguishable to the gradient.** Reward and learning signal are not the same quantity, and the gap between them is the advantage.

That is the foundation under the measurement apparatus:

$$
\rho(E)=\frac{10^6\sum_g A_g^{\mathrm{adm}}}{\sum_{g,i}\ell_{gi}}
$$

**ρ counts advantage mass, not reward.** Numerator: admitted mass, the part that can actually move parameters. Denominator: every token generated, including capped and masked ones that were paid for and learned nothing from. ρ is a conversion efficiency — advantage per token of spend.

This is what licenses the §6 sentence that training reward alone omits signal survival and concentration. Reward can look excellent while $A^{\mathrm{raw}}$ sits at zero. And $q_{\mathrm{mixed},g}=1-p_g^G-(1-p_g)^G$ is exactly the probability that a group escapes those two dead ends.

**Caveat worth carrying into the draft.** Before admission, $A_g^{\mathrm{raw}}$ is a deterministic function of $k$, so mixedness and advantage mass are nearly the same thing. Admission ($m_{gi}$) is the only place they come apart. That is the load-bearing justification for the ρ–H representation over raw mixedness, and it is currently implicit rather than stated.

---

## 5. Connection to CoDaPO

The advantage contraction result in that paper is the $k\to 8$ column of the table above: as $\bar r\uparrow 1$, positive advantages collapse toward zero. Their difficulty weight $V_d(d)=1-4(d-\tfrac12)^2$ peaks at $d=\tfrac12$, which is $k=4$, which is the row where $A_g^{\mathrm{raw}}$ maxes at 4.571.

**Both papers found the same peak from opposite directions** — CoDaPO reweights training toward it, the environments paper measures how much of it an environment supplies before training starts.

---

**TL;DR:** Reward is what you got; value is what you expected; advantage is the gap. Dynamic programming hides it because argmin is shift-invariant, policy gradient needs it because magnitude enters the update. Equation 2 is a leave-one-out advantage with the sibling rollouts standing in for the critic. ρ measures advantage mass per generated token, which is why a high-reward environment can still supply no learning signal at all.
