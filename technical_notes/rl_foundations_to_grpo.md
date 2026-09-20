# From classical policy gradients to GRPO

**Advantage is derived from rewards: it compares an action's expected return with the return the current policy normally achieves from the same state.** The underlying objective is still expected cumulative reward.

## 1. Translate the classical notation

The [ECE 586 notes](https://katselis.web.engr.illinois.edu/Scribing.html) use a cost-minimization presentation in [Lecture 9](https://katselis.web.engr.illinois.edu/ECE586/Lecture9.pdf). Here we use reward maximization.

| Classical course notation | Notation in these notes | Meaning |
|---|---|---|
| $x_k$ | $s_t$ | State |
| $u_k$ | $a_t$ | Action |
| $P_{ij}(u)$ | $P_E(s'\mid s,a)$ | Environment transition distribution |
| $\alpha$ | $\gamma$ | Discount factor |
| Cost $c(x,u)$ | Reward $r=-c$ | Immediate feedback; minimizing cost corresponds to maximizing its negative |
| $J_\pi(x)$, expected cost from a state | $V^{\pi,E}(s)$, expected reward return from a state | Value of following a policy |

Our scalar $J(\theta;E)$ below is the policy's objective averaged over initial states. It is different from using $J_\pi(x)$ for the value of one state.

## 2. Trajectories include policy and environment randomness

A finite episode has trajectory

$$
\tau=(s_0,a_0,s_1,a_1,\ldots,s_{T-1},a_{T-1},s_T).
$$

For a fixed environment $E$ and policy $\pi_\theta$,

$$
\boxed{
p_{\theta,E}(\tau)
=
d_{0,E}(s_0)
\prod_{t=0}^{T-1}
\pi_\theta(a_t\mid s_t)
P_E(s_{t+1}\mid s_t,a_t).
}
$$

The initial-state distribution $d_{0,E}$, policy $\pi_\theta$, and transitions $P_E$ all contribute randomness. Writing “$\tau\sim\pi_\theta$” is shorthand that suppresses the environment; it does not mean the environment is deterministic.

For these equations, take the reward to be $r_t=R_E(s_t,a_t,s_{t+1})$. If rewards have additional randomness, introduce a joint environment kernel $K_E(s',r\mid s,a)$ and use reward-augmented trajectories:

$$
p_{\theta,E}(\tau,r_{0:T-1})
=
d_{0,E}(s_0)
\prod_t \pi_\theta(a_t\mid s_t)
K_E(s_{t+1},r_t\mid s_t,a_t).
$$

## 3. Why rewards can be written as R(s), R(s,a), or R(s,a,s')

These notations encode different dependencies or different levels of averaging:

- $R_E(s,a,s')$: reward depends on the transition.
- $R_E(s,a)$: reward depends only on the state and action, or denotes the expected transition reward.
- $R_E(s)$: reward depends only on the state.

When $R_E(s,a,s')$ is a conditional expected reward,

$$
\overline R_E(s,a)
=
\sum_{s'}P_E(s'\mid s,a)R_E(s,a,s').
$$

If we also average over the action distribution,

$$
\overline R_{\pi,E}(s)
=
\sum_a \pi(a\mid s)\overline R_E(s,a).
$$

That last quantity generally depends on the policy. An intrinsically state-only reward $R_E(s)$ need not. Averaging the reward preserves its conditional mean; it does not preserve every feature of its random distribution.

Use lowercase $r_t$ for the realized reward and uppercase $R_t$ for the return below. The subscript distinguishes the return from the reward function $R_E(\cdot)$.

## 4. Reward, return, value, action value, and advantage

The return from time $t$ is

$$
R_t=\sum_{k=t}^{T-1}\gamma^{k-t}r_k.
$$

We reserve $G$ for the number of responses in a GRPO group, rather than also using $G_t$ for return.

$$
\boxed{
J(\theta;E)
=
\mathbb E_{\tau\sim p_{\theta,E}}[R_0].
}
$$

Reward noise, when present, is also included in this expectation.

The finite-horizon value functions are

$$
V_t^{\pi,E}(s)
=
\mathbb E_{\pi,P_E}[R_t\mid s_t=s],
$$

$$
Q_t^{\pi,E}(s,a)
=
\mathbb E_{\pi,P_E}[R_t\mid s_t=s,\ a_t=a].
$$

In $Q$, the first action is fixed; subsequent actions follow $\pi$. Both expectations also include reward randomness when applicable. The time index matters in a finite-horizon task; it can instead be incorporated into the state.

$$
\boxed{
A_t^{\pi,E}(s,a)
=
\underbrace{Q_t^{\pi,E}(s,a)}_{\text{return expected after choosing }a}
-
\underbrace{V_t^{\pi,E}(s)}_{\text{return normally expected here}}.
}
$$

The baseline is the policy's average action value:

$$
V_t^{\pi,E}(s)
=
\sum_a\pi(a\mid s)Q_t^{\pi,E}(s,a).
$$

| Quantity | Interpretation |
|---|---|
| $r_t$ | Reward received at this step |
| $R_t$ | Discounted rewards accumulated from this step onward |
| $V_t^{\pi,E}(s)$ | Expected return from the state |
| $Q_t^{\pi,E}(s,a)$ | Expected return after choosing this action first |
| $A_t^{\pi,E}(s,a)$ | Expected return relative to the policy's average at this state |

**Example.** A one-step task offers rewards 8 and 10. If the policy chooses each with probability one half, $V=9$. Their advantages are $8-9=-1$ and $10-9=+1$. A positive reward can have negative advantage: it was worse than the policy's usual outcome.

Advantage is classical RL terminology, already explicit in [Sutton et al. (1999)](https://proceedings.neurips.cc/paper/1999/hash/464d828b85b0bed98e80ade0a5c43b0f-Abstract.html). Learning Bellman equations and Q-learning does not require naming $Q-V$ separately.

## 5. REINFORCE is stochastic gradient ascent on expected return

[Williams (1992)](https://doi.org/10.1007/BF00992696) introduced the REINFORCE family of gradient-following algorithms.

Assume the environment's initial-state distribution, dynamics, and reward mechanism do not depend directly on $\theta$. Then

$$
\nabla_\theta\log p_{\theta,E}(\tau)
=
\sum_t\nabla_\theta\log\pi_\theta(a_t\mid s_t).
$$

Environment terms disappear from this derivative because they are fixed with respect to $\theta$. They remain in the distribution over which we take expectations.

The likelihood-ratio identity gives

$$
\nabla_\theta J(\theta;E)
=
\mathbb E_{\tau\sim p_{\theta,E}}
\left[
R_0\sum_t\nabla_\theta\log\pi_\theta(a_t\mid s_t)
\right].
$$

Past rewards have zero expected contribution to a later action's score-function term, so the reward-to-go form is

$$
\boxed{
\nabla_\theta J(\theta;E)
=
\mathbb E_{\tau\sim p_{\theta,E}}
\left[
\sum_{t=0}^{T-1}
\gamma^t R_t
\nabla_\theta\log\pi_\theta(a_t\mid s_t)
\right].
}
$$

For one sampled episode, the Monte Carlo update is

$$
\boxed{
\theta^+
=
\theta+
\eta\sum_t\gamma^tR_t
\nabla_\theta\log\pi_\theta(a_t\mid s_t).
}
$$

This is ascent because rewards are maximized. Equivalently, minimize the negative objective with SGD. The outer $\gamma^t$ is required for the stated discounted start-state objective; when $\gamma=1$, it is one.

## 6. A baseline changes the estimator without changing the objective

For a baseline $b_t(s)$ independent of the sampled action,

$$
\mathbb E_{a\sim\pi_\theta(\cdot\mid s)}
\left[
b_t(s)\nabla_\theta\log\pi_\theta(a\mid s)
\right]
=
b_t(s)\nabla_\theta\sum_a\pi_\theta(a\mid s)
=0.
$$

Consequently, the update

$$
\boxed{
\theta^+
=
\theta+
\eta\sum_t\gamma^t
\bigl(R_t-b_t(s_t)\bigr)
\nabla_\theta\log\pi_\theta(a_t\mid s_t)
}
$$

has the same expected policy gradient under on-policy sampling. Treat the baseline as fixed when computing this actor update, even if it is estimated by another network.

A suitable baseline can reduce variance; an arbitrary baseline does not automatically do so. With the exact value function,

$$
\widehat A_t=R_t-V_t^{\pi,E}(s_t),
\qquad
\mathbb E_{\pi,P_E}[\widehat A_t\mid s_t=s,a_t=a]
=
A_t^{\pi,E}(s,a).
$$

The exact advantage compares expectations. This Monte Carlo estimator compares a realized return with an expected return.

## 7. Map a language-model response to the same MDP

For question $q$ and generated response $o=(o_0,\ldots,o_{T-1})$,

$$
\boxed{
s_t=(q,o_{<t}),
\qquad
a_t=o_t,
\qquad
\pi_\theta(a_t\mid s_t)
=
f_\theta(o_t\mid q,o_{<t}).
}
$$

One action is **one token**. The entire response is a rollout. In text-only generation the transition appends that token:

$$
P_E\bigl((q,o_{\le t})\mid(q,o_{<t}),o_t\bigr)=1.
$$

The initial prompt and token choices are random even though this transition is deterministic. Tool-using environments can add stochastic external transitions.

In outcome-reward reasoning tasks, intermediate rewards may be zero, with a final verifier reward at termination. With $\gamma=1$, that terminal reward is the return from every preceding token.

The $a$ in a dataset pair $(q,a)$ may denote the ground-truth answer. It is not our action $a_t$.

## 8. The three policies have different jobs

| Policy | Paper notation | Job | Changes while optimizing a collected batch? |
|---|---|---|---|
| Current | $f_\theta=\pi_\theta$ | Policy being improved | Yes |
| Behavior | $f_{\mathrm{old}}=\pi_{\mathrm{old}}$ | Generates the training rollouts | No |
| Reference | $f_{\mathrm{ref}}=\pi_{\mathrm{ref}}$ | Anchor for KL regularization | No |

At collection time, copy the current policy to the behavior policy:

$$
\pi_{\mathrm{old}}\leftarrow\pi_\theta.
$$

Collect data from $p_{\mathrm{old},E}$. Subsequent updates change $\pi_\theta$, while the recorded behavior probabilities remain fixed. The current and behavior policies therefore start equal and then diverge.

The token ratio is

$$
\boxed{
w_{i,t}(\theta)
=
\frac{\pi_\theta(a_{i,t}\mid s_{i,t})}
{\pi_{\mathrm{old}}(a_{i,t}\mid s_{i,t})}.
}
$$

Both probabilities concern the same sampled action and state. We use $w$ here to avoid confusing the ratio with the environment paper's signal-density coordinate $\rho$.

The separate reference comparison is

$$
D_{\mathrm{KL}}
\left(
\pi_\theta(\cdot\mid s)
\,\Vert\,
\pi_{\mathrm{ref}}(\cdot\mid s)
\right).
$$

The reference does not have to be the behavior policy. Its refresh schedule is an implementation choice, not determined by the word “reference.”

## 9. PPO and GRPO share a clipped policy surrogate

[PPO](https://arxiv.org/abs/1707.06347) permits repeated optimization on collected samples using a surrogate objective. Its clipped policy term is

$$
L^{\mathrm{clip}}(\theta)
=
\widehat{\mathbb E}_{\text{samples from }\pi_{\mathrm{old}},E}
\left[
\min\left(
w_t(\theta)\widehat A_t,\,
\operatorname{clip}(w_t(\theta),1-\epsilon,1+\epsilon)\widehat A_t
\right)
\right].
$$

The actor takes gradient-ascent steps on this surrogate. Common PPO implementations estimate advantages using a learned value function. A critic loss and entropy terms may also be present.

Clipping limits the surrogate's incentive for certain probability changes. It is not a hard guarantee that every ratio stays inside $[1-\epsilon,1+\epsilon]$.

[DeepSeekMath](https://arxiv.org/abs/2402.03300) introduced GRPO, which obtains relative scores from groups of responses instead of learning a separate value model. For a question $q$, sample $G$ responses and compute

$$
\bar r_q=\frac1G\sum_{i=1}^G r_{q,i},
\qquad
\boxed{
\widehat A_{q,i}
=
\frac{r_{q,i}-\bar r_q}{s_q+\delta},
}
$$

where $s_q$ is the within-group reward standard deviation and $\delta>0$ is a numerical stabilizer. Exact standard-deviation conventions vary by implementation.

For outcome supervision, this response-level score weights the response's token terms. With binary rewards $1,1,0,0$, the centered rewards are $0.5,0.5,-0.5,-0.5$ before division by the standard deviation.

A schematic standard-GRPO objective is

$$
L_{\mathrm{GRPO}}(\theta)
=
\mathbb E_{\substack{q\sim D_E\\o_1,\ldots,o_G\sim\pi_{\mathrm{old}}(\cdot\mid q)}}
\left[
\frac1G\sum_i\frac1{T_i}\sum_t
\left\{
\min\left(
w_{i,t}\widehat A_i,\,
\operatorname{clip}(w_{i,t},1-\epsilon,1+\epsilon)\widehat A_i
\right)
-\beta\,\mathcal K_{i,t}(\theta)
\right\}
\right].
$$

Here $\mathcal K$ denotes the chosen KL-to-reference penalty or estimator. Token/response normalization and the KL estimator must be checked in the actual trainer.

$$
\theta^+=\theta+\eta\nabla_\theta L_{\mathrm{GRPO}}(\theta).
$$

GRPO's finite-group standardized score is not literally the exact token-state quantity $Q^\pi-V^\pi$. Including the sampled response in the group mean, dividing by a sample standard deviation, and clipping the ratio require separate analysis; the action-independent-baseline proof alone does not establish that the whole GRPO update is an unbiased vanilla policy-gradient estimator.

## 10. Batch size and group size are different axes

Let $B_{\mathrm{prompt}}$ be the number of questions in a batch and $G$ the responses sampled per question:

$$
N_{\mathrm{rollout}}=B_{\mathrm{prompt}}G.
$$

A batch can contain many groups. A “group” is the set of responses compared for one question. In CoDaPO's algorithm, $B$ denotes a question batch; in other descriptions a batch size may count complete rollouts. Always check the definition.

## 11. Reading-specific connections

### CoDaPO

In the supplied *CoDaPO: Confidence and Difficulty-Adaptive Policy Optimization for LLM Reasoning* PDF, Section 2 introduces current, behavior, and reference policies for standard GRPO.

Section 4.2 removes the reference KL penalty for CoDaPO itself. The method still needs the current and behavior policies. Algorithm 1 uses the behavior snapshot for both the initial and resampled rollouts, then updates the current policy.

The method weights questions using confidence and empirical difficulty and allocates additional samples to selected questions. These details are separate from the basic definition of advantage.

### Environment-utility paper: cells

In the supplied *Which Environments Should LLMs Learn From? Predicting RL Utility Across Four Scales* draft, Section 4 constructs a $2\times2$ design at each model scale.

| Cell | Group-signal availability | Admission/cost profile |
|---|---|---|
| HH | High | Higher admission, lower cost |
| HL | High | Lower admission, higher cost |
| LH | Low | Higher admission, lower cost |
| LL | Low | Lower admission, higher cost |

A **cell** is one of these experimental combinations, instantiated as a prompt set. The draft uses four disjoint sets of 256 prompts at each scale, constructed relative to that scale's starting policy.

The factorial design supports contrasts along the two manipulated factors. Admission and response cost are coupled within the second factor, so it does not separately identify their causal effects. Balancing observed prompt attributes helps interpretation but does not by itself eliminate every possible confound.

### Environment-utility paper: advantage and admission

This draft's trainer uses an **unnormalized leave-one-out** score, not standard GRPO's within-group z-score:

$$
\boxed{
\widehat A_{g,i}^{\mathrm{LOO}}
=
r_{g,i}
-
\frac{1}{G-1}\sum_{j\ne i}r_{g,j}.
}
$$

Here $g$ indexes a prompt group, $i$ a response, and $G=8$ in the draft's training setup. All-success and all-failure groups have zero score.

Admission means eligibility for a direct policy-loss contribution under the fixed trainer rules:

$$
m_{g,i}
=
\begin{cases}
1 & \text{response is admitted to the policy loss},\\
0 & \text{response is masked out of the policy loss}.
\end{cases}
$$

Schematically, the policy contribution becomes

$$
m_{g,i}
\min\left(
w_{g,i,t}\widehat A_{g,i}^{\mathrm{LOO}},\,
\operatorname{clip}(w_{g,i,t},1-\epsilon,1+\epsilon)
\widehat A_{g,i}^{\mathrm{LOO}}
\right),
$$

with token weighting and normalization supplied by the actual implementation.

**Admission and reward are distinct.** In this draft, capped responses have zero direct policy-loss weight, but remain in the group reward baseline and in the generated-token budget. A masked response can therefore influence other responses' scores indirectly.

Section 3.2 defines admitted absolute advantage mass and its density:

$$
M_g=\sum_i m_{g,i}\left|\widehat A_{g,i}^{\mathrm{LOO}}\right|,
\qquad
\boxed{
\rho(E)=10^6\frac{\sum_g M_g}{\sum_{g,i}\ell_{g,i}}.
}
$$

Here $\ell_{g,i}$ counts generated tokens, including masked responses. Using $M_g$ instead of the paper's $A_g^{\mathrm{adm}}$ avoids confusing mass with the classical advantage function.

For $n$ measured prompts, effective coverage is

$$
\boxed{
H(E)=\frac{(\sum_gM_g)^2}{n\sum_gM_g^2},
}
$$

with $H=0$ when total admitted mass is zero.

$\rho$ measures admitted scalar advantage mass per million generated tokens. $H$ measures how broadly that mass is distributed across prompts. Neither is a parameter-gradient norm.

**TL;DR:** Reward is immediate feedback; return accumulates rewards; advantage compares an action's expected return with the policy's usual return. REINFORCE estimates the gradient of expected return. PPO adds a clipped surrogate for collected data; GRPO obtains relative response scores from groups. The behavior policy generates data, the current policy learns, and a separate reference may anchor KL regularization. In the environment paper, cells are controlled prompt sets and admission determines which sampled responses directly enter the policy loss.
