---
layout: post
title: "A Better Notation for RL"
date: 2026-11-15
section: ml
---

*Brando Miranda — November 2026 · ~7 min read*

**TL;DR.** I write a trajectory as repeated reward, state, action blocks, $\tau = (r_0, s_0, a_0, \ldots, r_T, s_T, a_T)$. The environment emits each reward and state together, $P_E(r_t, s_t \mid s_{t-1}, a_{t-1})$, and the agent emits each action, $P_A(a_t \mid s_t)$. The probability of a trajectory is then one product with the same two factors at every step, from the first state to the last. The initial distribution is the same environment kernel with an empty previous state and action, and the episode ends when the agent takes a "done" action. Both the Markov property and time invariance can be read straight off the formula. Drawn as a picture, the formula also separates two things the usual single loop draws together: a rollout, where the reward leaves the loop, and training, where the reward changes the weights.

---

## The usual way, and what bugs me

Here is the form I see most often:

$$
P(\tau) \;=\; \rho_0(s_0) \prod_{t=0}^{T-1} \pi(a_t \mid s_t)\, P(s_{t+1} \mid s_t, a_t).
$$

It has three different shapes in one line. There is an initial distribution out front with its own symbol, a product that stops one step early, and a last state that never gets an action. Rewards sit outside the formula, as $r(s_t, a_t)$ in some books and $r_{t+1}$ in others. Each edge is its own special case, and when I code this up or map LLM training onto it, the edges are exactly where my off-by-one bugs live.

## One block per time step

I want every time step to look the same. Each step $t$ is one call to the environment followed by one call to the agent:

1. The environment returns a reward and a state together, $(r_t, s_t) \sim P_E(\cdot \mid s_{t-1}, a_{t-1})$.
2. The agent picks an action, $a_t \sim P_A(\cdot \mid s_t)$. This is the policy, usually written $\pi_\theta$.

A trajectory is these blocks laid end to end, so its probability is the blocks multiplied together:

$$
\begin{aligned}
P(\tau) \;=\; {} & P_E(r_0, s_0 \mid s_{-1}, a_{-1})\, P_A(a_0 \mid s_0) \\
& \cdot P_E(r_1, s_1 \mid s_0, a_0)\, P_A(a_1 \mid s_1) \\
& \cdots \\
& \cdot P_E(r_T, s_T \mid s_{T-1}, a_{T-1})\, P_A(a_T \mid s_T),
\end{aligned}
$$

or, compactly,

$$
P(\tau) \;=\; \prod_{t=0}^{T} P_E(r_t, s_t \mid s_{t-1}, a_{t-1})\, P_A(a_t \mid s_t).
$$

The indexing is the one Sutton and Barto use for their four-argument dynamics function, $p(s^{\prime}, r \mid s, a) = \Pr\lbrace S_t = s^{\prime}, R_t = r \mid S_{t-1} = s, A_{t-1} = a \rbrace$: the reward and the next state come out together and carry the index of the step they arrive at. All I am doing is pushing that convention to both ends of the episode.

## The first step isn't special

Set $s_{-1} = a_{-1} = \varepsilon$, an empty state and an empty action. Then

$$
P_E(r_0, s_0 \mid s_{-1}, a_{-1}) \;=\; P_E(r_0, s_0)
$$

is the initial distribution. It is the same kernel as every other step, with nothing to condition on.

Most formulations give the initial state no reward. Here that is just a special case: $r_0 = 0$ always, which means $P_E(x, s_0 \mid s_{-1}, a_{-1}) = 0$ for every $x \neq 0$. I'd rather not build that in. Where you start matters, and a reward on arrival at $s_0$ is a natural way to say so. One thing to be clear about: $r_0$ does not depend on any action, so it shifts every return by an amount the policy can't touch. It changes how good it is to start somewhere, not what you should do once you are there.

## The last step isn't special either

The episode ends when the agent acts: $a_T = \texttt{done}$. Now the final factor $P_A(a_T \mid s_T)$ exists, and the product runs all the way to $T$ with both factors at every step. For LLM agents this is not a trick. The end-of-sequence token, or the tool call that submits an answer, is literally the last action the model takes.

With every step in the same shape, the return and the value are one-liners too:

$$
R(\tau) = \sum_{t=0}^{T} \gamma^t r_t, \qquad V_E^{P_A} = \mathbb{E}_{\tau \sim P}\big[R(\tau)\big].
$$

## Two pictures instead of one

The usual picture of RL is a single loop. The agent sends an action to the environment, and the environment sends back a state and a reward, both drawn as arrows into the agent. Here is my own drawing of that loop, so I can compare against it:

{% include rl_notation/fig1_textbook_loop.svg %}

*Figure 1. The usual single loop, redrawn. The reward arrow (orange) goes into the agent.*

The reward arrow into the agent is the part I had to sit with. During a rollout the policy computes $P_A(a_t \mid s_t)$, and nothing in that factor takes $r_t$ as an input. So while the agent is acting, the reward has nowhere to go inside it. It leaves the loop and adds up into the return. If I draw only the arguments of each factor in $P(\tau)$, I get this:

{% include rl_notation/fig2_rollout.svg %}

*Figure 2. A rollout in my notation. Every arrow is an argument of a factor in $P(\tau)$. The reward goes to the return, not to the agent, and the weights don't change.*

Each arrow is one argument of one factor. $(s_{t-1}, a_{t-1})$ go into the environment, $s_t$ goes into the agent, and $r_t$ leaves the loop. The empty start and the $\texttt{done}$ action are on the picture too, so the two ends are drawn like every other step.

The reward does reach the agent during training, but through a different door. It feeds a learner, the learner computes a gradient, and the gradient changes the weights $\theta$. That happens between rollouts, not inside the choice of $a_t$:

{% include rl_notation/fig3_training.svg %}

*Figure 3. RL training. The reward is consumed by the learner, which updates $\theta$. The action is still drawn from $P_A(a_t \mid s_t)$.*

So the single loop is two systems drawn on top of each other: the policy that acts, and the learning algorithm that changes it. Putting both inside one "agent" box makes sense when the subject is learning agents, and that is the subject of the book I learned this from. For reading off the trajectory distribution, I find it clearer to keep them apart. Figure 2 is the picture of $P(\tau)$, and Figure 3 is the picture of what we do with it.

Nothing stops a policy from seeing rewards. An LLM agent can be shown the score of its last attempt in its prompt. In that case the reward is part of what the agent observes, so it belongs inside $s_t$, and the factor is still $P_A(a_t \mid s_t)$. Figure 2 doesn't change; the arrow labelled $s_t$ just carries more.

## What the formula says about time

Recall what conditional independence means:

$$
A \perp B \mid C \;\iff\; P(A, B \mid C) = P(A \mid C)\, P(B \mid C) \;\iff\; P(A \mid B, C) = P(A \mid C).
$$

Two properties sit inside the single product, and they are worth separating.

The first is the Markov property. Because $P_E$ conditions only on the previous state and action, the new reward and state ignore the rest of the past:

$$
(r_t, s_t) \perp (r_0, s_0, a_0, \ldots, r_{t-1}) \mid s_{t-1}, a_{t-1},
$$

where the past on the right-hand side excludes $s_{t-1}$ and $a_{t-1}$ themselves, since we condition on them. Equivalently, $P(r_t, s_t \mid \text{the whole history}) = P_E(r_t, s_t \mid s_{t-1}, a_{t-1})$. Once you know where you were and what you did, nothing else that happened earlier changes the distribution of where you land. The agent's side reads the same way: $a_t$ depends on the history only through $s_t$.

The second is time invariance. $P_E$ is the same function at every $t$, including $t = 0$. That is the symmetry of time in an MDP: shift the clock and the rules do not change. The two properties are separate, since a kernel could be Markov and still change with $t$, but writing one $P_E$ inside one product encodes both at once.

## Before, but not after

When I first wrote this down, I wrote that the arrival $(r_t, s_t)$ is independent of everything "before and after" given $(s_{t-1}, a_{t-1})$. The "after" half took me a second look. What I meant is right: the future is not an input to $P_E$, and $(r_t, s_t)$ is sampled before any of it exists. But the future is not conditionally independent of $(r_t, s_t)$. The next state is drawn from $P_E(\cdot \mid s_t, a_t)$, so seeing $s_{t+1}$ tells you something about $s_t$. The independence statement is about the past only, and the "future doesn't matter" intuition is really a statement about the order in which things get generated.

**TLDR-end:** Write each time step as one environment draw of $(r_t, s_t)$ and one agent draw of $a_t$. With an empty state and action before $t = 0$ and a "done" action at $t = T$, the probability of a trajectory is a single product with the same two factors everywhere, and Markov plus time invariance are both visible in it. Drawing only the arguments of each factor gives a rollout picture where the reward never enters the agent; it reaches the agent only in training, through the weight update.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026rlnotation,
  author = {Miranda, Brando},
  title  = {A Better Notation for RL},
  year   = {2026},
  month  = {November},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/11/15/a-better-notation-for-rl.html}},
  note   = {Blog post}
}
```
