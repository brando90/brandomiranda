# Transcription: handwritten notes on RL notation (Nov 15, 2026)

Three photos: one loose sheet (photo 1, shot sideways) and one notebook page (photos 2 and 3 are the same page, two exposures). Text is transcribed as written, including shorthand. Math is in LaTeX. Readings I am unsure of are marked [?]. Margin notes and arrows are shown as `→ note`. Struck-through terms are shown with `\cancel{...}`.

---

## Photo 1 (loose sheet)

**Top line (full expansion of the trajectory probability):**

$$
P(\tau) = \underbrace{P_E(r_0, s_0 \mid s_{-1}, a_{-1})}_{\text{initial}}\, P_A(a_0 \mid s_0)\, P_E(r_1, s_1 \mid s_0, a_0)\, P_A(a_1 \mid s_1)\, P_E(r_2, s_2 \mid s_1, a_1)\, P_A(a_2 \mid s_2) \cdots P_E(r_T s_T \mid s_{T-1}, a_{T-1})
$$

Margin, top right, below the line: $\underbrace{P_A(a_T \mid s_T)}_{\text{"done"}}$

**Boxed:**

$$
P(\tau) = \prod_{t=0}^{T} P_E(r_t s_t \mid s_{t-1}, a_{t-1})\, P_A(a_t \mid s_t)
$$

where $P_E(r_0 s_0 \mid s_{-1} a_{-1})$ = initial distribution (dist), i.e. $P_E(r_0 s_0)$. If initial state has no reward (more common?), then $r_0 = 0$ always if initial dist. So $P_E(x, s_0 \mid s_{-1} a_{-1}) = 0$ (for $x \neq 0$) for most standard formulations. But to me initial starting point "should matter", so I prefer nothing [about] the initial one be special. Since where you start does matter.

**Markov / "Symmetry" / "time-invariance"** (underlined heading)

→ Recall independence:
$P(A, B \mid C) = P(A \mid C)\, P(B \mid C) \iff A \perp B \mid C$
$P(A \mid B C) = P(A \mid C) \iff A \perp B \mid C$

**Env:** what does $P_E(r_t s_t \mid s_{t-1} a_{t-1})$ mean about the symmetry of time in an MDP?

$r_t s_t \perp \text{everything else} \mid s_{t-1} a_{t-1}$
  → (pointing at $s_{t-1} a_{t-1}$) previous time step state ("location") & action.

$r_t s_t \perp r_0 s_0 a_0 \ldots r_{t-1},\ \cancel{s_{t-1} a_{t-1}},\ \cancel{r_t s_t}\ \underline{\cancel{a_t \ldots r_T s_T a_T}} \mid s_{t-1}, a_{t-1}$
  (In words: three groups are struck through and bracketed underneath: $s_{t-1} a_{t-1}$, then $r_t s_t$, then the whole future block $a_t \ldots r_T s_T a_T$.)
  → (over the struck future block) current transition doesn't depend on the future.
  → (over the struck $r_t s_t$) current state action "transition to", **does** depend on itself of course lol.

∴

**Boxed:**

$$
r_t s_t \perp r_0 s_0 a_0 \ldots r_{t-1} \mid s_{t-1} a_{t-1}
$$

→ current "arrival"/transition "ignored [?] state" is independent of everything else (before & after) given the current state (or "prev") state & action.

---

## Photos 2 and 3 (notebook page, same page)

Current state we arrived to / transitioned is independent of everything that happened previously [and in the future — inserted above the line] given the current state & action that took us to it:

i.e. **Boxed:** $P_E(r_t s_t \mid s_{t-1} a_{t-1})$ given $s_{t-1}\, a_{t-1}$, anything else on the RHS of $\mid$ doesn't affect the pdf/pmf prob of that $r_t s_t$.

(Faint pencil and bleed-through from other pages is visible below; it is not part of this note and is not transcribed.)

---

## Photo 4 (textbook page 48, Figure 3.1, with my annotations)

The printed page is Sutton and Barto, Chapter 3 (Finite Markov Decision Processes), around Figure 3.1, the agent–environment loop. Only my handwritten annotations are transcribed; the printed text is summarized.

**Top margin, pointing at the reward arrow into the agent:**
"In inference / 'rollout': it doesn't affect agent. Currently, but tbh it could! e.g. $\pi_\theta(a_t \mid s_t) \Rightarrow \pi_\theta(a_t \mid s_t, r_t)$ [Q: different formulation? not clear to me] — e.g. prompt in 'Lang[uage]'."

**Under the opening paragraph (rewards):** "doesn't go into policy / $\pi(\cdot \mid \cdot): A \times S \mapsto P$", and over the agent box "$\pi(a_t \mid s_t)$".

**On the figure:** labels added: "Current state $S_t$", "Current reward $R_t$" (its arrow into the agent is crossed out with an X), "(Current) state $S_t$" on the feedback line, "(current) action $A_t$", and "Next $R_{t+1}$". A smiley face is drawn inside the agent box.

**Large note, right of the figure:** "Q: don't get it, why do[es] it write [?] … it's clearly [?] in their f[ormulation?] …" (partly cut off).

**Right margin, boxed in blue, "MARKOV":** $P_E(r_{t+1}, s_{t+1} \mid s_t, a_t) \equiv \ldots$ (partly cut off at the page edge).

**Left margin:** "→ I personally don't like it. Whatever lol." with arrows pointing at the figure caption and at the highlighted phrase "time step later": "'next step' for action, but…" and "'current step' for Sutton, Barto".

**Printed paragraph below the figure (summarized):** at each time step the agent observes the state and picks an action from the set allowed in that state; one step later, partly because of that action, it receives a reward and lands in a new state. Highlighted/boxed: "At each time step $t$", "$A_t \in \mathcal{A}(s)$", "time step later", "new", "$S_{t+1}$", "trajectory".

**Margin by $A_t \in \mathcal{A}(s)$:** "I like this notation for Action set depending on state! $\mathcal{A}(S_t)$ or $\mathcal{A}(s)$".

**Next to the printed trajectory $S_0, A_0, R_1, S_1, A_1, R_2, \ldots$:** "I personally prefer my notation: $S_0 a_0\, S_1 a_1\, S_2 a_2$" with rewards underneath as $R(S_0, a_0)$ [labelled $R_0$], $R(S_1, a_1)$, $R(S_2, a_2)$.

---

## Photo 5 (loose sheet: returns, Sutton–Barto indexing, and the rollout diagram)

"Sequence of rewards **after** the step $t$. $P_E(r_t s_t \mid s_{t-1} a_{t-1}),\ P_A(a_t \mid s_t)$ ← **all we need!**"

Small notes: "SB/many zero" (arrow to $r_0$); "$\bar{\cdot} \equiv$ denote RV (capitals too sometimes)"; "SB/many ends the[re]" (arrow to the end of the trajectory).

$$\tau = r_0 s_0 a_0\ r_1 s_1 a_1 \ldots r_{t-1} s_{t-1} a_{t-1}\ r_t s_t a_t\ r_{t+1} s_{t+1} a_{t+1} \ldots r_{T-1} s_{T-1} a_{T-1}\ r_T s_T a_T, \qquad A_t \in \mathcal{A}(S_t)$$

$$\bar{R}_{\text{after } t} = \cancel{R_t}, R_{t+1}, R_{t+2}, \ldots, R_{T-1} R_T = R_{t+1} \cdots R_T \;\Big|\; s_t, \mathcal{A}(s)\ [?]$$

$$G_t = F(R_{t+1} \cdots R_T) = F(\text{some function of rewards after } t).$$

"So you are in current step $t$, & SB decide to 'formalize' their notation as maximizing the 'future' → sort of… cuz when you take the current action $a_t \mid s_t$, then you get a reward 'immediately', but tbf SB consider that $r_{t+1}$ as the **next** time step although it came from the **current** state-action."

"→ Book says: At each (current) time step the agent receives some representation of the environment's **state** $S_t \in \mathcal{S}$. One (time step later, [$t+1$]), as a consequence of its (current) action, receives a reward (& transitions to a new state!) $P_E(r_{t+1}, s_{t+1} \mid s_t, a_t) \cong$ [small box: Env, inputs $s_t, a_t$; outputs $r_{t+1}, s_{t+1}$]."

**Diagram, labelled "Real full pic of RL (Rollout)":** an agent circle (smiley, "Agent", $P_A(a_t \mid s_t)$) takes $s_t$ and outputs $a_t$; $a_t$ and $s_t$ go into an Env box; Env outputs $r_{t+1}$ and $s_{t+1}$ across a dashed time-step line. The reward path is dashed and runs into a cloud labelled "$\nabla_w$ / RL" next to the agent, not into the action choice.
