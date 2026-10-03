# Transcription: Maximum Likelihood, MCMC, and Training EBMs

Source images (note order = derivation order):

- Page 1: [images/photo-1-mle-gradient-derivation.jpg](images/photo-1-mle-gradient-derivation.jpg)
- Page 2: [images/photo-2-mcmc-and-research-questions.jpg](images/photo-2-mcmc-and-research-questions.jpg)

Best-effort transcription. Crossed-out fragments preserved; uncertain words
marked `[unclear]` or `[?]`. Green-pen highlights in the original are noted
inline because they encode the exercise / research-question color coding.

## Page 1 — goal, partition-function cost, MLE gradient

Top framing:

- "goal: maximize likelihood of model"
- (1) `theta* = argmax_theta  E_{x ~ p* = p_data}[ log p_theta(x) ]`
- right margin: "E_theta(x) usual bounded-above notation", "EBM/EBT for FNNs [unclear]"
- `p_theta(x) = e^{-E_theta(x)} / ( sum_x e^{-E_theta(x)} ) = e^{-E_theta(x)} / Z_theta`

Note on the normalizer:

```text
Z_theta = sum_{x in X} e^{-E_theta(x)}
```

- annotation: "(theta, p_hat*) hard term", "indep of x / normalizer"
- "by X = X^D ... (D = 2)"
- "X = some alphabet V (|X| >= 64?) ... I (usually) like [this]"
- "Ex: expand wrt continuous though ... is this code? when you discretize"
- `so Z_theta => t_theta ker ~ O(|X|^D)`  "(unless some factorizable ~ Error?)"
- "e^{-E_theta(x)} : 2 (comput hours?)"
- "even if we ... O(|X|) ... then ... exponential"
- "(ok but isn't relevant get big)"

Exercise (green underline on "Exercise"):

- "**Exercise:** Show it's [the] equivalent to some opt wrt KL div & explain
  intuition."

Optimization setup:

- "Since theta is ur opt we can do (2) GD/AD."
- `theta^{<t+1>} := theta^{<t>} + eta * grad_theta log p_theta(theta, p_hat*)`
  with note "objective a" / `grad_theta J_theta(theta, p_hat*)`
- "so dum [our eyes?] 'usually' of objective (= MLE, max likelihood most
  likely) given p_hat* (unknown) or a partial data..."

Gradient derivation (left margin is dense / partly `[unclear]`):

```text
theta^{<t+1>} := theta^{<t>} + eta * grad_theta { E_{x~p*}[ log p_theta(x) ] }      <- p_hat*(x)
              := theta^{<t>} + eta * E_{x~p*}[ grad_theta ( -E_theta(x) - log Z_theta ) ]
              =  theta^{<t>} + eta * E_{x~p*}[ -grad_theta E_theta(x) ]   ... w/ grad_theta log Z_theta ?
```

- "So let ... to zero", "our [exp?]"

## Page 2 — the negative phase, MCMC, research questions

Top (continues the update; the second term is circled and labelled):

```text
theta^{<t+1>} := theta^{<t>}
               + eta * E_{x~p*}[ grad_theta E_theta(x) ]
               - E_{x~p_theta(x)}[ grad_theta E_theta(x) ]      <- "simple model BBM is" (circled A)
```

- arrow + "Ex derivation. hints: chain rule, (implicit diff?)"

Exercise (MCMC necessity):

- "but I think more importantly is to question **if this is really needed**.
  eg. MCMC. Why is [it] actually needed? DL book says the undirectedness
  `p(a|b)`, `p(b|a)` type argument? Tbh another good **Exercise**:"

Research Q (green underline on "Research Q"):

- "but **Research Q:** Can we do something different to sample? Not use MCMC or
  anything? Question the foundations & try it out anyway. Like [to] Jeff Dean's
  distributed messy update (GD) / distributed GD as an example of how ML
  research intuition seems to work better + evals (& empirics) to set results
  vs overly restrictive 'theory' [argument]."

RQ (boxed in green) — optimizer abstraction:

```text
RQ:  theta^{<t+1>} := H( theta^{<t>} + eta * F( grad_theta J(theta, p_hat*) ) )     (circled B)
```

- "in 2026 we have so many optimizers. Muon, Shampoo, etc. Can we try em all &
  see if it helps?"

Sticky note:

- "Continue blog here"

## Color-coding legend (from the original notes)

- **Exercise** — underlined; rendered in the blog as the blue exercise callout.
- **Research Q / RQ** — green underline / green box; rendered as the green
  research-question callout.
