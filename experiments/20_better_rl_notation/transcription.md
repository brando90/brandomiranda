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
