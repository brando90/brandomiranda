# RL Notation in Three Layers

A reference for reading *Which Environments Should LLMs Learn From?* against standard RL notation.

**Layer 1 — Classical policy gradient (REINFORCE).** The MDP vocabulary every RL textbook uses.
**Layer 2 — PPO / GRPO.** What modern LLM post-training adds, drops, and renames.
**Layer 3 — Your paper.** Which Layer-2 symbols you keep, which you discard, and which are new.

Read Layer 2 as a *specialization* of Layer 1, not a replacement. Read Layer 3 as Layer 2 plus a measurement apparatus that has no Layer-1 or Layer-2 counterpart.

---

## 1. Master side-by-side table

### 1.1 Environment and data generation

| Concept | Layer 1: REINFORCE | Layer 2: PPO / GRPO | Layer 3: Your paper |
|---|---|---|---|
| Environment | MDP $(\mathcal{S},\mathcal{A},P,R,d_0,\gamma)$ | Same, specialized to text | **A prompt distribution $E$.** Everything else is held fixed |
| Initial-state distribution | $d_0(s_0)$ | Prompt draw $x\sim\mathcal{D}$ | $d_{0,E}$ — the object you intervene on |
| State | $s_t$ | $s_t=(x,y_{<t})$: prompt plus tokens so far | Not written. Implicit |
| Action | $a_t\in\mathcal{A}$ | One token $y_t$ | Not written. Survives only in the phrase "generated **action** tokens" |
| Transition | $P(s_{t+1}\mid s_t,a_t)$ | Deterministic append | Deterministic append. Never varied |
| Horizon | $T$ | Response length, EOS-terminated | $\ell_{gi}$, capped at 12,288 |
| Discount | $\gamma$ | $\gamma=1$ in RLVR | Absent |

### 1.2 Trajectory, reward, return

| Concept | Layer 1 | Layer 2 | Layer 3 |
|---|---|---|---|
| Trajectory | $\tau=(s_0,a_0,r_0,\dots,s_T)$ | One response $y$ | One response. Called a *rollout* |
| Trajectory law | $p_\theta(\tau)=d_0(s_0)\prod_t\pi_\theta(a_t\mid s_t)P(s_{t+1}\mid s_t,a_t)$ | $\pi_\theta(y\mid x)=\prod_t\pi_\theta(y_t\mid x,y_{<t})$ | $p_{\theta,E}(\tau)$ — only $d_{0,E}$ changes |
| Per-step reward | $r_t=R(s_t,a_t)$ | Terminal only: $r(x,y)$ | Binary Math-Verify score $r_{gi}\in\{0,1\}$ |
| Return | $R(\tau)=\sum_t\gamma^tr_t$ | $=r(x,y)$ | $=r_{gi}$ |

### 1.3 Baseline and advantage

| Concept | Layer 1 | Layer 2 | Layer 3 |
|---|---|---|---|
| Value function | $V^\pi(s)$, $Q^\pi(s,a)$ | PPO learns a critic $V_\phi$; GRPO drops it | Absent |
| Baseline | $b(s_t)$, often $\hat V(s_t)$ | Group mean over $G$ samples | Leave-one-out group mean |
| Advantage | $A^\pi(s,a)=Q^\pi-V^\pi$ | GAE $\hat A_t^{\mathrm{GAE}(\gamma,\lambda)}$ (PPO); $\hat A_{g,i}=\frac{r_{g,i}-\mathrm{mean}(\mathbf r_g)}{\mathrm{std}(\mathbf r_g)}$ (GRPO) | $a_{gi}=r_{gi}-\frac{1}{G-1}\sum_{j\neq i}r_{gj}$ (Eq. 2). Unnormalized, no std |
| Credit assignment | Per step | Sequence-level scalar broadcast to every token | Same broadcast |

### 1.4 Objective

| Concept | Layer 1 | Layer 2 | Layer 3 |
|---|---|---|---|
| Training objective | $J(\theta)=\mathbb E_{\tau\sim p_\theta}[R(\tau)]$ | Clipped surrogate $L^{\mathrm{CLIP}}$, optionally $-\beta\,\mathbb D_{\mathrm{KL}}(\pi_\theta\Vert\pi_{\mathrm{ref}})$ | $L^{\mathrm{CLIP}}$, $\beta=0$ |
| Reported quantity | $J(\theta)$ | Training reward, sometimes held-out eval | **$U(E,N,C)$**, Eq. 1. Held-out pass@1 *minus warm start* |
| Gradient | $\mathbb E[\sum_t\nabla\log\pi_\theta(a_t\mid s_t)\Psi_t]$ | Ratio-clipped version of the same | Same, with $\Psi=a_{gi}$ |

**This row is the most important one in the document.** $J$ is training reward on $E$. $U$ is generalization delta on a disjoint 1,000-prompt panel. They are different estimands, and §6 of your paper turns on the gap between them.

### 1.5 Optimization mechanics

| Concept | Layer 1 | Layer 2 | Layer 3 |
|---|---|---|---|
| On/off policy | Strictly on-policy, one gradient step per batch | $\pi_{\theta_{\mathrm{old}}}$ behavior policy, several epochs per batch | Two passes per batch |
| Importance ratio | Absent | $r_t(\theta)=\frac{\pi_\theta(a_t\mid s_t)}{\pi_{\theta_{\mathrm{old}}}(a_t\mid s_t)}$ | "importance correction" |
| Clipping | Absent | $\mathrm{clip}(\cdot,1-\epsilon,1+\epsilon)$; DAPO uses asymmetric $\epsilon_{\mathrm{low}},\epsilon_{\mathrm{high}}$ | Symmetric, $\epsilon=0.2$ |
| Loss aggregation | Sum over steps | GRPO: per-sequence mean; DAPO/Dr.GRPO: token-level | Token-level |
| Length/overlong handling | Absent | DAPO: overlong filtering or soft punishment | Overlong filtering. Capped responses stay in the reward baseline, get zero loss weight |
| Prompt filtering | Absent | DAPO dynamic sampling drops all-correct/all-wrong groups | **Disabled on purpose** — it would corrupt the prompt-distribution intervention |

### 1.6 Batch structure

| Concept | Layer 1 | Layer 2 | Layer 3 |
|---|---|---|---|
| Batch of trajectories | $B$ | $M$ prompts $\times$ $G$ responses, $B=MG$ | 4 prompts $\times$ 8 responses = 32 rollouts per update. Written in words, not symbols |
| Group index | Absent | $g$ | $g$ |
| Within-group index | Absent | $i$ (and $j$ for the baseline sum) | $i$, $j$ |
| Group size | Absent | $G$ | $G=8$ |

Layer 1 can enumerate trajectories with a single index because each one's baseline is independent of the others. GRPO keeps $g$ and $i$ separate because $a_{gi}$ depends on the siblings $r_{gj}$.

### 1.7 Measurement — no Layer-1 or Layer-2 counterpart

| Symbol | Meaning | Where |
|---|---|---|
| $m_{gi}\in\{0,1\}$ | Admission indicator from the loss contract | §3.2 |
| $\ell_{gi}$ | Generated length in tokens | §3.2 |
| $A_g^{\mathrm{raw}}$, $A_g^{\mathrm{adm}}$ | Absolute advantage mass, before and after admission | Eq. 4 |
| $q_{\mathrm{mixed},g}$ | $1-p_g^G-(1-p_g)^G$, probability a group has signal at all | Eq. 3 |
| $\rho(E)$ | Admitted mass per million generated tokens | Eq. 5 |
| $H(E)$ | Normalized effective prompt coverage | Eq. 6 |
| $C$ | Cumulative generated-token budget | §3.1 |
| $N$ | Parameter scale | §3.1 |
| $U(E,N,C)$ | Held-out utility | Eq. 1 |
| $s(C)=C/(C+C_0)$ | Saturating compute term | Eq. 7 |
| $\beta_0,\beta_N,\beta_C,\beta_\rho,\beta_H$ | Five fitted regression coefficients | Eq. 7 |

---

## 2. Layer 1 in full: REINFORCE

An agent in an MDP $(\mathcal S,\mathcal A,P,R,d_0,\gamma)$ samples $s_0\sim d_0$, then repeatedly draws $a_t\sim\pi_\theta(\cdot\mid s_t)$, collects $r_t$, and moves to $s_{t+1}\sim P(\cdot\mid s_t,a_t)$.

$$p_\theta(\tau)=d_0(s_0)\prod_{t=0}^{T-1}\pi_\theta(a_t\mid s_t)\,P(s_{t+1}\mid s_t,a_t),\qquad J(\theta)=\mathbb E_{\tau\sim p_\theta}[R(\tau)].$$

The policy gradient theorem gives

$$\nabla_\theta J(\theta)=\mathbb E_{\tau\sim p_\theta}\left[\sum_{t=0}^{T-1}\nabla_\theta\log\pi_\theta(a_t\mid s_t)\,\Psi_t\right].$$

$P$ and $d_0$ carry no $\theta$, so they vanish from the gradient. The choice of $\Psi_t$ is the whole design space:

| $\Psi_t$ | Name | Variance |
|---|---|---|
| $R(\tau)$ | REINFORCE | Highest |
| $G_t=\sum_{t'\ge t}\gamma^{t'-t}r_{t'}$ | Reward-to-go | Lower |
| $G_t-b(s_t)$ | REINFORCE with baseline | Lower still |
| $A^\pi(s_t,a_t)$ | Actor-critic | Lowest, but biased if the critic is wrong |

Any baseline that does not depend on $a_t$ leaves the gradient unbiased. That single fact is what licenses GRPO to replace a learned critic with a group statistic, and what licenses your leave-one-out form.

---

## 3. Layer 2: PPO, then GRPO, then RLVR

### 3.1 PPO over REINFORCE

PPO reuses a batch for several gradient steps. That makes the data off-policy relative to the current $\theta$, so it reweights by the ratio $r_t(\theta)$ and clips to bound the update:

$$L^{\mathrm{CLIP}}(\theta)=\mathbb E_t\left[\min\big(r_t(\theta)\hat A_t,\;\mathrm{clip}(r_t(\theta),1-\epsilon,1+\epsilon)\hat A_t\big)\right].$$

Advantages come from GAE, which needs a learned critic $V_\phi$.

### 3.2 The LLM specialization

Text generation collapses most of the MDP:

- $s_t=(x,y_{<t})$, $a_t=y_t$, transition is a deterministic append.
- $\gamma=1$, and reward arrives only at EOS.
- The state is fully determined by the action history, so there is no exploration of dynamics — only of token sequences.

Two views coexist in the literature. The **token-level** view treats each token as an action (this is the one that makes "generated action tokens" the literally correct name for your compute axis). The **bandit** view treats the whole response as one action, $\pi_\theta(y\mid x)$. They are consistent: $\pi_\theta(y\mid x)=\prod_t\pi_\theta(y_t\mid x,y_{<t})$.

### 3.3 GRPO over PPO

GRPO deletes the critic. For each prompt $x_g$ it samples $G$ responses and uses the group as its own baseline:

$$\hat A_{g,i}=\frac{r_{g,i}-\mathrm{mean}(\mathbf r_g)}{\mathrm{std}(\mathbf r_g)},$$

broadcast to every token of response $i$.

### 3.4 The variants your paper's contract selects

| Variant | Change | Your setting |
|---|---|---|
| Dr.GRPO | Drop std normalization and per-sequence length normalization, which bias toward easy prompts and long responses | You adopt both: unnormalized advantage, token-level loss |
| DAPO | Token-level aggregation, clip-higher, dynamic sampling, overlong handling | Token-level and overlong filtering yes; clip-higher no (symmetric 0.2); dynamic sampling **off** |
| Leave-one-out baseline (RLOO-style) | $A_i=r_i-\frac{1}{G-1}\sum_{j\neq i}r_j$ | Adopted, via the NeMo contract |
| KL-to-reference | $-\beta\,\mathbb D_{\mathrm{KL}}(\pi_\theta\Vert\pi_{\mathrm{ref}})$ | $\beta=0$, no reference model |

**Useful identity.** Leave-one-out is mean-centering with a constant rescale:

$$a_{gi}=r_{gi}-\frac{1}{G-1}\sum_{j\neq i}r_{gj}=\frac{G}{G-1}\big(r_{gi}-\bar r_g\big).$$

At $G=8$ the factor is $8/7\approx1.143$. So your Eq. 2 is the standard GRPO advantage with the std division removed and a $G/(G-1)$ gain folded in. It is not a different estimator, just an unnormalized one.

---

## 4. Layer 3: your paper

### 4.1 Where the intervention sits

You hold $\pi_0$, $P$, $R$, the trainer, $G$, decoding, the verifier, the horizon, and the eval panel fixed. **Only $d_{0,E}$ changes.**

$$p_{\theta,E}(\tau)=\underbrace{d_{0,E}(s_0)}_{\text{the intervention}}\prod_t\underbrace{\pi_\theta(a_t\mid s_t)}_{\text{token sampling}}\underbrace{P(s_{t+1}\mid s_t,a_t)}_{\text{fixed append}}.$$

The caveat that makes the paper interesting: changing $d_0$ changes which gradients you get, which changes $\theta$, which changes the whole visited state distribution. The intervention is on one term but its effect propagates. That is exactly what "policy-relative" means in your §1, and why difficulty is not a static property of a prompt.

### 4.2 What Eq. 2 does with binary rewards

Let $k$ = number of successes in a group of $G$. Then

- correct response: $a_{gi}=\dfrac{G-k}{G-1}$
- incorrect response: $a_{gi}=-\dfrac{k}{G-1}$
- group sum: zero
- raw mass: $A_g^{\mathrm{raw}}=\dfrac{2k(G-k)}{G-1}$

At $G=8$ this is triangular in $k$: zero at $k=0$ and $k=8$, maximum $32/7\approx4.57$ at $k=4$. Before admission, "mixedness" and "advantage mass" are close to the same quantity. **Admission is where they separate**, which is the premise of the ρ–H representation.

### 4.3 Why ρ is a ratio of unlike things

$$\rho(E)=\frac{10^6\sum_g A_g^{\mathrm{adm}}}{\sum_{g,i}\ell_{gi}}$$

The numerator counts **admitted** mass. The denominator counts **all** generated tokens, including capped and loss-masked ones. You are charged for tokens you cannot learn from. That asymmetry is the mechanism, not an accident of definition: ρ is a conversion efficiency, not a signal magnitude. The $10^6$ is only a unit choice (mass per million tokens).

### 4.4 What H actually is

$$H(E)=\frac{1}{|E|}\cdot\frac{\big(\sum_g A_g^{\mathrm{adm}}\big)^2}{\sum_g\big(A_g^{\mathrm{adm}}\big)^2}$$

This is an inverse participation ratio (equivalently a Hill number of order 2), normalized by the number of prompts:

- mass spread evenly over all $|E|=256$ prompts → $H=1$
- all mass on one prompt → $H=1/256$
- range $[1/|E|,\,1]$, with your convention $H=0$ when admitted mass is zero

It is **not** Shannon entropy and **not** the PPO entropy bonus, despite the letter.

### 4.5 Worked micro-example

Four prompts, $G=8$, successes $k=0,4,8,2$.

| Group | $k$ | Per-response advantage | $A_g^{\mathrm{raw}}$ |
|---|---|---|---|
| 1 | 0 | all $0$ | 0 |
| 2 | 4 | $+4/7$ / $-4/7$ | 4.571 |
| 3 | 8 | all $0$ | 0 |
| 4 | 2 | $+6/7$ (×2), $-2/7$ (×6) | 3.429 |

Total raw mass 8.00. Now suppose both correct responses in group 4 ran long and were capped, so $m=0$ for them. Admitted mass in group 4 drops to $12/7=1.714$; group 2 is untouched at 4.571. Total admitted mass 6.286.

With, say, 200k generated tokens across the 32 responses:

$$\rho=\frac{10^6\times6.286}{200{,}000}=31.4,\qquad H=\frac14\cdot\frac{6.286^2}{4.571^2+1.714^2}=\frac14(1.658)=0.414.$$

So $N_{\mathrm{eff}}=1.66$ of 4 prompts carry the update. Had those two responses been admitted, $H$ would be $0.490$. Two prompts contributed nothing before admission even touched them; admission then skewed what remained. This is the §6 story in miniature.

Note the scope: Eq. 5 and 6 sum over **all 256 prompts in a cell**, measured by the independent pre-RL $G=8$ probe. They are not computed from training batches.

### 4.6 Reading Eq. 7

$$\hat U=\beta_0+\beta_Nx_N+\beta_Cs(C)+\beta_\rho s(C)z(\log\rho)+\beta_Hs(C)z(H)$$

- $x_N=\log N$, so scale enters logarithmically.
- $s(C)=C/(C+C_0)$ saturates. $C_0$ is the half-saturation budget, fixed at 14.36651M for the 14B forecast rather than fitted.
- Both environment terms carry $s(C)$, so environment contrasts vanish at $C=0$ while $\beta_0+\beta_Nx_N$ does not. You handle this by excluding zero-budget anchors from the fit and defining $U(E,N,0)=0$ separately.
- $z(\cdot)$ standardizes within each training fold, so coefficients are not comparable across folds in raw units.
- Cell labels never enter. The labels identify variation; the coordinates do the prediction.

### 4.7 What you deliberately do not have

| Standard machinery | Status | Reason |
|---|---|---|
| Critic $V_\phi$, GAE, $\lambda$ | Absent | GRPO removes it |
| Discount $\gamma$ | Absent | Terminal reward, $\gamma=1$ |
| KL penalty $\beta$, reference model | Absent | Set to zero |
| Dynamic sampling | Disabled | It would filter the prompt distribution you are intervening on |
| Learned reward model | Absent | Math-Verify is deterministic |
| Clip-higher | Not used | Symmetric $\epsilon=0.2$ |
| $M$, $B$ as symbols | Never defined | Stated in words: "four prompts and eight responses per prompt" |
| Adaptive stopping, prompt redraw, seed replacement | None | Preregistered contract |

---

## 5. Collisions to watch

### Across layers

| Collision | Note |
|---|---|
| PPO's ratio $r_t(\theta)$ vs. reward $r_t$ vs. your $r_{gi}$ | Standard confusion in the literature. Some papers write the ratio as $\rho_t$, which then collides with your $\rho(E)$ |
| PPO's KL coefficient $\beta$ vs. your $\beta_0,\beta_N,\beta_C,\beta_\rho,\beta_H$ | Safe only because you set the KL penalty to zero |
| PPO's entropy bonus $H(\pi)$ vs. your coverage $H(E)$ | Same letter, unrelated quantity |
| $\tau$ trajectory vs. $\tau$ sampling temperature | You write temperature as 0.6 in words, so no conflict today |
| $s_t$ state vs. $s(C)$ compute term | Harmless now. Becomes a real problem if you ever add MDP notation |
| $a_t$ action vs. $a_{gi}$ advantage | **No conflict in the paper**, since $a_t$ never appears. Do *not* promote $a_{gi}$ to $A_{gi}$ — that collides with $A_g^{\mathrm{adm}}$, which is a worse clash |

### Internal to the paper

| Collision | Severity | Suggested fix |
|---|---|---|
| $N$ (parameter scale) vs. $N_{\mathrm{eff}}$ (Fig. 3 axis, never defined in text) | High | Rename the axis to $\mathrm{ESS}/\lvert E\rvert$ |
| $G=8$ training, $G=4$ and $G=1$ evaluation, all in §4 | High | Reserve $G$ for training; use pass@$k$ language for eval |
| "32 responses per update" vs. "32 training trajectories" (§4, six lines apart) | High | Write "32 RL runs" or "32 seed replicates" |
| $C$ budget vs. $c$ cost in the $q_{\mathrm{mixed}}p_{\mathrm{adm}}/c$ baseline | Low | Subscript the baseline's cost |
| "generated action tokens" with $a_t$ never defined | Medium | Define $a_t$ once, or drop "action" |

---

## 6. Open items for the draft

1. **ρ and H are never reported numerically.** They are the two central coordinates and the reader cannot see them. A 16-row table of $(\rho,H)$ per cell per scale would let a reviewer check that the cells actually separate in the coordinates you claim.
2. **Figure 3 reports a different quantity than the predictor.** The 0.60–0.70 and 0.11–0.18 figures come from the token-weighted diagnostic, not from $H$ as defined in Eq. 6. §6 says so, but the caption does not, and readers will conflate them.
3. **§5 vs. Table 2 need reconciling.** §5 says HH is best at 1.7B and 8B at the largest shared budget. Table 2 has HH at $-0.3$ and $-2.1$ at those scales at step 128, worst or near-worst. Budget-matching versus step-matching can reorder results, but a worst-to-best flip is large enough that a reviewer will ask for the matched-budget numbers explicitly.
4. **11.45 in §5, 11.4 in the abstract and §5.** Pick one and grep for the other.
5. **Cell-label mapping is counterintuitive.** LH reads "low group signal, high admission, low cost." Worth restating the mapping in the Fig. 2 caption, where readers first meet the labels.

---

*Bibliographic note: no arXiv IDs or venues appear in this document. PPO, GAE, REINFORCE, RLOO, Dr.GRPO, and DAPO are named descriptively only. Verify any reference before it enters the paper.*
