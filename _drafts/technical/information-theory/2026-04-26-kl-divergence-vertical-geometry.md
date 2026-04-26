---
layout: post
title: "KL Divergence Has Vertical Geometry: A Unified Grammar with Euclidean Distance"
date: 2026-04-26
category: technical
subcategory: information-theory
---

*Brando Miranda — April 2026*

**Reading time:** ~12 minutes.

**TL;DR.** Lock the roles: **goal** = first argument = $B$ (Euclidean) or $p^*$ (KL); **viewpoint** = second argument = $A$ (Euclidean) or $\hat{q}$ (KL). The unified grammar is *"$D(\text{goal} \,\|\, \text{viewpoint})$ = excess of the viewpoint over the goal."* In Euclidean the geometry is horizontal and the excess is signed displacement; in KL the geometry is vertical (viewpoint $\hat{q}$ sits above the floor set by goal $p^*$) and the excess is non-negative code-length surplus.

## A note about how I think (and why I'm writing this)

Before I get into the math: I know some readers will look at this post and think it's overkill — that I'm spending a thousand words to re-derive a one-line definition. That's fair. But it's also the thing I want to say up front. I am, by temperament, a foundations person. I would rather understand one definition completely than recognize a hundred superficially. When I meet a formula, my first instinct is to ask what the symbols *mean* operationally, where the asymmetries live, and whether the picture in my head actually matches the algebra on the page. If it doesn't, I keep digging until it does.

That's not just an aesthetic preference — it's the same instinct that pulls me toward the things I love most. It's why I find Lean and formal verification beautiful (the proof either checks or it doesn't; there is nowhere for a fuzzy mental model to hide). It's why I gravitate to the deep learning theorists and the ML for theorem proving crowd — they refuse to let surface fluency stand in for understanding. And it's why, when I teach dance, the class I genuinely love teaching is the beginners' class. Beginners ask the questions that the rest of us have stopped asking but probably should. Where exactly is your weight? Why does this turn happen on this beat and not the next? Foundations are where the leverage is. If the foundation is right, everything above it is cheap. If it's wrong, no amount of advanced technique on top will save you.

So this post is a worked example of that instinct. I went back to KL divergence — a thing I have used for years — because I noticed that my own mental picture didn't quite match the algebra, and that bothered me enough to redraw it. What follows is what I found.

## Setup: who is who

I'll use two consistent words throughout, **goal** and **viewpoint**, and translate them between the Euclidean and Shannon worlds.

**Euclidean / vector world:**
- $A$ = the **viewpoint** (where the stick figure stands; where we currently are).
- $B$ = the **goal** (the destination; where we want to reach).

**KL / Shannon world:**
- $\hat{q}$ = the **viewpoint** (our model; where we currently live; what we can sample from).
- $p^*$ = the **goal** (the truth; what we want to match or approximate).

| Role | Euclidean | Shannon |
|---|---|---|
| Viewpoint (where we are) | $A$ | $\hat{q}$ |
| Goal (where we want to reach) | $B$ | $p^*$ |

## 1. The Euclidean (vector) picture

Stick figure stands at $A$ (viewpoint). $B$ (goal) is off in some direction.

$$\vec{B} - \vec{A} \quad = \quad \text{"displacement from } A \text{ (viewpoint) to } B \text{ (goal)"}$$

English phrasings that all mean $\vec{B} - \vec{A}$:

- "displacement from $A$ to $B$" — $A$ (viewpoint) named first as starting point.
- "$B$ from $A$" — $B$ (goal) named first algebraically; $A$ (viewpoint) is the reference frame.
- "$B$ relative to $A$" — explicit: $A$ (viewpoint) is the reference.

Notice the wrinkle: the *English phrase* "from $A$ to $B$" puts $A$ (viewpoint) first, while the *algebra* $\vec{B} - \vec{A}$ puts $B$ (goal) first. That mismatch lives inside vector notation itself, before we even get to KL.

Operationally: $A$ (viewpoint, where we stand) plus $\Delta$ (displacement) equals $B$ (goal, destination). So $\Delta$ is the *journey to add* to reach the goal.

## 2. The Shannon / KL picture — and why it's NOT horizontal

If we naively transplant the Euclidean picture, we'd want some $\Delta$ such that:

$$\hat{q} \;+\; \Delta \;=\; p^* \quad \text{(Euclidean wishful thinking)}$$

This **fails** in Shannon's world. Why? Gibbs' inequality says:

$$H(p^*, \hat{q}) \;\ge\; H(p^*)$$

where:

- $H(p^*)$ = expected code length using the goal $p^*$'s own optimal code on the goal $p^*$'s data.
- $H(p^*, \hat{q})$ = expected code length using the viewpoint $\hat{q}$'s code on the goal $p^*$'s data.

The viewpoint $\hat{q}$ **cannot** have a smaller expected code length than the goal $p^*$ on the goal's own data. The goal $p^*$ is the *floor* — there is no "below $p^*$" in code-length space. So the picture is **vertical, not horizontal**:

```
        ┌─── H(p*, q̂)   ← viewpoint q̂'s cost (always above the floor)
        │
   Δ_KL │   = excess
        │
        └─── H(p*)       ← goal p*'s cost (the FLOOR — unbeatable)
```

The viewpoint $\hat{q}$ sits *above* the goal $p^*$ in expected-code-length space. There's no "left" or "right" of $p^*$ — only "above."

The gap is:

$$\Delta_{KL} \;=\; H(p^*, \hat{q}) \;-\; H(p^*) \;=\; D_{KL}(p^* \,\|\, \hat{q}) \;\ge\; 0$$

This is **excess** of viewpoint-cost over goal-cost, not a *journey* from $\hat{q}$ to $p^*$.

## 3. The sign / role flip

Here's the thing my hand-drawn notes kept circling around: $+\Delta$ in the Euclidean picture must actually act like a subtraction in the Shannon picture. Why?

**Euclidean.** $A$ (viewpoint) plus $\Delta$ equals $B$ (goal). $\Delta$ is *missing distance to add* to reach the goal.

**Shannon.** $H(p^*, \hat{q})$ (viewpoint's cost) minus $H(p^*)$ (goal's cost) equals $\Delta_{KL}$. $\Delta_{KL}$ is *excess cost above the floor set by the goal*.

Algebraically, both have form **(viewpoint-quantity) related to (goal-quantity) by $\Delta$**, but the operational interpretation flips:

- **Euclidean:** $\Delta$ is a **deficit** — the journey we must travel from viewpoint $A$ to reach goal $B$.
- **Shannon:** $\Delta_{KL}$ is a **surplus** — the tax the viewpoint $\hat{q}$ pays for not being the goal $p^*$.

In Euclidean, you *add* $\Delta$ to viewpoint to reach goal. In Shannon, the viewpoint $\hat{q}$ *overshoots* the goal $p^*$'s floor by $\Delta_{KL}$. Same algebra, opposite operational meaning.

## 4. The unified grammar

Now the phrasing that works in both worlds:

> **In $D(\text{first arg} \,\|\, \text{second arg})$: first arg = goal, second arg = viewpoint. The quantity is the excess of the viewpoint over the goal along the relevant axis** — position in Euclidean, expected code length in Shannon.

Check it against the actual KL convention. $D_{KL}(p^* \,\|\, \hat{q})$: first arg is $p^*$ (goal), second arg is $\hat{q}$ (viewpoint). It matches.

**In Euclidean** (goal = $B$, viewpoint = $A$):

- Excess generalizes to *signed offset*: $\vec{B} - \vec{A}$ can be any sign.
- The algebra $\vec{B} - \vec{A}$ is "goal minus viewpoint," which already matches the "first arg = goal" convention.

**In Shannon / KL** (goal = $p^*$, viewpoint = $\hat{q}$):

- Excess is literal *excess code length*: $D_{KL}(p^* \,\|\, \hat{q}) \ge 0$ always.
- The goal $p^*$ is the floor; the viewpoint $\hat{q}$ sits above it.

The unifying principle: **goal is named first because the goal is the reference against which the viewpoint's deviation is reported.** In Euclidean it's a signed deviation; in Shannon it's a non-negative excess.

## 5. Concrete reading of $D_{KL}(p^* \,\|\, \hat{q})$

Putting it all together:

$$D_{KL}(\underbrace{p^*}_{\text{goal}} \,\|\, \underbrace{\hat{q}}_{\text{viewpoint}}) \;=\; \mathbb{E}_{p^*}[h_{\hat{q}}(X) - h_{p^*}(X)] \;=\; H(p^*, \hat{q}) - H(p^*) \;\ge\; 0$$

In English:

> *"The excess expected code length the viewpoint $\hat{q}$ pays compared to the goal $p^*$'s optimal code, averaged under the goal $p^*$."*

Every role explicit:

- $p^*$ (goal) plays three jobs: (i) the floor of expected code length, (ii) the averaging measure for the expectation, (iii) the optimal-code reference whose surprisal $h_{p^*}$ gets subtracted.
- $\hat{q}$ (viewpoint) plays one job: the code we actually use, whose surprisal $h_{\hat{q}}$ is what we pay on the goal's data.

## 6. Why the Euclidean intuition was misleading

It is tempting to draw $\hat{q}$ (viewpoint) and $p^*$ (goal) side-by-side on a horizontal axis, with $\Delta_p$ as the gap between them. That picture is **wrong for KL**, and here's exactly why.

In a horizontal Euclidean picture, the viewpoint $\hat{q}$ could in principle sit *to the left of* the goal $p^*$, meaning $\Delta < 0$ — "the viewpoint is closer to origin than the goal." That's mathematically fine in Euclidean space.

In the Shannon picture, the viewpoint $\hat{q}$ **cannot** sit "below" the goal $p^*$ in expected-code-length. The goal is the *minimum*. So the geometry has to be vertical — the viewpoint is always *above* the goal's floor, never beside or below. The "$\hat{q}$ is more efficient than $p^*$" scenario doesn't correspond to "$\hat{q}$ is to the left of $p^*$" — it corresponds to "$\hat{q}$ is *below the floor*," which is impossible.

This is exactly what the "$+\Delta_p$ must actually be a subtraction" intuition was getting at. Once the geometry is vertical (viewpoint above goal's floor), $\Delta$ has to be non-negative excess, not signed displacement.

## 7. Quick reference table

| World | Goal (1st arg) | Viewpoint (2nd arg) | Gap quantity | Sign |
|---|---|---|---|---|
| Euclidean | $B$ (destination) | $A$ (where we stand) | $\vec{B} - \vec{A}$ | Any sign |
| KL / Shannon | $p^*$ (truth, floor, measure) | $\hat{q}$ (our model) | $D_{KL}(p^* \,\|\, \hat{q})$ | $\ge 0$ |
| Cross-entropy decomp | $p^*$'s optimal cost = floor $H(p^*)$ | $\hat{q}$'s cost on $p^*$'s data = $H(p^*, \hat{q})$ | $H(p^*, \hat{q}) - H(p^*)$ | $\ge 0$ |

## Why I bothered

Going back to the framing at the top: this is a long post for what looks like a one-line definition. The reason I bothered is that the operational meaning of $D_{KL}(p^* \,\|\, \hat{q})$ is genuinely different from the operational meaning of $\vec{B} - \vec{A}$, even though the surface algebra rhymes. Confusing the two — drawing the KL picture as a horizontal gap rather than a vertical excess — makes everything downstream harder: variational bounds, the asymmetry of forward vs. reverse KL, why $H(p^*, \hat{q})$ is the loss we minimize when we don't know $H(p^*)$, why entropy is a floor and not an origin. The vertical picture makes those things almost free. The horizontal picture makes them confusing forever.

That's the foundations dividend, and it's the same dividend I keep cashing in elsewhere. In Lean, getting the definition right is the entire game — once the statement is right and the proof checks, you are *done* in a way nothing informal can match. In dance, getting weight transfer and frame right at the beginner level is what makes advanced figures feel effortless years later. In research, asking the right question — being precise about what you actually want — is most of the work. The concrete topics differ. The instinct is the same: spend disproportionate time on the foundation, because everything above it inherits its quality.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026klverticalgeometry,
  author = {Miranda, Brando},
  title  = {KL Divergence Has Vertical Geometry: A Unified Grammar with Euclidean Distance},
  year   = {2026},
  month  = {April},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/04/26/kl-divergence-vertical-geometry.html}},
  note   = {Blog post}
}
```
