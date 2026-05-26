# Transcription: AR Pros/Cons and EBM Partition Functions

Sources:

- Photo 1: [images/photo-1-ar-transformer-pros-cons.jpg](images/photo-1-ar-transformer-pros-cons.jpg)
- Photo 2: [images/photo-2-ebm-partition-functions.jpg](images/photo-2-ebm-partition-functions.jpg)

This is a best-effort transcription. I preserve the mathematical structure where
it is legible, mark uncertain readings with `[unclear]`, and separate literal
transcription from editorial interpretation.

## Photo 1: Pros and Cons of ARs / Transformers

### Title

```text
Pros & Cons of ARs / Transformers
```

Small annotation over `Cons` / `ARs`:

```text
are the only "real"? [unclear]
```

### Top-right margin

```text
then do tools Delta the probability epsilon of an error?
The model AR/LLM might produce output.
The output is [unclear] wrong but tools can catch it...
independence
```

Editorial reading: the margin asks how tools change the effective probability
that a generated error survives.

### Point 1

```text
-> 1) LeCun's (1 - epsilon)^N argument
      -> T_x i.e. N = T_x = seq len.
      -> detailed pros, cons, assumptions
```

### Point 2

```text
-> 2) "Advantage of EBMs" is they score an entire sequence instead of
      a per-token prediction / inference
      (PS: what about its training cost too lol).
```

### Exponential error-compounding argument

```text
-> Exponential Error Compounding Argument -> LeCun's argument
   "ARs are fundamentally flawed"
```

Nearby fragments:

```text
generated token takes you outside the manifold of "correct" answers.
e.g. writing/predicting emoji tokens [unclear]
when we are doing serious adult mathematics or wars, making [unclear]
is more reasonable (correct?)
```

Editorial reading: a single bad token can move the rollout off the manifold of
valid completions, and then future tokens are conditioned on that corrupted
prefix. The note contrasts casual text with settings where exactness matters.

### Independence assumption

```text
Assume errors are independent.
```

Indicator-variable sketch:

```text
I_t = I{ X^(<t>) = X_*^(<t>) }

I_t = {
  1 if X^(<t>) = X_*^(<t>)
  0 if [otherwise / incorrect]
}
```

There are several equivalent prefix/token notations on the page. The intended
meaning appears to be:

- `X^(<t)` or `x^(<t)` is the generated prefix up to time `t`.
- `X_*^(<t)` or `x_*^(<t)` is the correct/reference prefix.
- The indicator is 1 when the generated prefix/token is still correct.

### Per-token correctness

```text
Pr[ X^(t) = X_*^(t) ]
  = Prob. any given gen is correct
  = 1 - epsilon

Pr[ X^(t) != X_*^(t) ]
  = Prob. any given generated token is incorrect
  = epsilon
```

Right-side notes:

```text
[x0, ?, ..., x_t] one token
if pred. right token.
for length of T_x for this to basically be zero
e.g. < 0.001 = 0.1%?
human calc / numerical calls + same [unclear] right # sentences
epsilon ~= 10% or 1%
production intuition / think of envelope calculations
```

### Sequence correctness

```text
Pr[ sequence N / T_x is correct ]
  = Pr[ all are correct ]
  = Pr[ AND_{t=1}^{T_x} X^(t) = X_*^(t) ]
  = product_{t=1}^{T_x} Pr[ X^(t) = X_*^(t) ]
  = product_{t=1}^{T_x} (1 - epsilon)
  = (1 - epsilon)^{T_x}
```

### Bottom conclusion

```text
so for any fixed epsilon > 0 the probability of generating a fully correct
sequence goes to zero exponentially fast.
```

### Bottom questions / caveats

Legible fragments:

```text
Q: if this is true, then why do agents work so well? or utility?
This lemma can be useful with a thought [unclear]
```

There are several crossed-out bottom-margin fragments about whether this is
true, what it means for agents, and whether a corrected-path/manifold framing is
the right way to state the claim.

## Photo 2: EBMs, Partition Functions, and Sequence Spaces

### Top framing

Legible fragments:

```text
What [unclear] with LLMs/ARs & why EBMs.
The partition function hardness motivates EBMs,
but doesn't explain why [unclear].
Should be useful vs ARs/LLMs.
Easy to motivate intuitively.
```

Main formula:

```text
Z_theta = sum_{x in X} exp(-E_theta(x))
```

Vocabulary / space notes:

```text
say X is [unclear]
{x_0, x_1, ..., x_|X|-1}
{0, 1, 2, ..., |X|-1}
```

Editorial reading: the page starts from an EBM partition function over a finite
set and then asks what happens when the object is a sequence.

### Energy examples

Linear energy:

```text
E_theta(x) = theta^T x
           = x^T theta
```

One-hot sketches:

```text
[1, 0, 0, ...]
[0, 1, 0, ...]
[0, 0, 1, ...]
```

Neural / matrix energy sketch:

```text
E_theta(x) = x^T W^(0) ... W(x)       [partly unclear]
           = [-x^T-] [W^(0) ... W^(1)] [-w^(2)-]
```

Shape annotations around the matrix sketch:

```text
1 x D
[n or m x D] [unclear]
[D, D]
[D, 1]
```

Nearby example:

```text
eg. for language:
[
  [1, 0, ..., 0]
  [0, 1, ..., 0]
  [0, 0, 1, ...]
]
```

Comment:

```text
but this e.g. motivates EBMs from a partition function perspective
```

### Sequence length and finite discrete partition function

Sequence length note:

```text
n = batch (?) or sequence length |x|
```

One-token / finite space:

```text
Z_theta = sum_{x in X} exp(-E_theta(x))
          O(|X|^1) e.g. O(10) operations
```

Sequence space:

```text
Z_theta = sum_{x in X^N} exp(-E_theta(x))
          => O(|X|^N) = O(D^N) = O(10^N) = O(10^?)
```

Set-product notes:

```text
X^N = X x X x ... x X
    = {x_0, x_1, ..., x_|X|-1}^D
    = X^D
```

Margin notes:

```text
X = {x_0, x_1, ..., x_|X|-1}
set of size [unclear]
reasonable with language [unclear]
exponential in N length of seq.
```

### Continuous case

```text
say X = R

Z_theta = integral_{x in R^D} exp(-E_theta(x)) dx
        -> high dimensional arbitrary function
```

Question / exercise note:

```text
Q: Exercise for reader (me later lol)
getting X W^(?) to get us the first embedding layer
embedding layer
unnormalizable integral with [unclear]
-E_theta(x)! Crazy huh
```

Continuous sequence-embedding notes:

```text
X = X^1 x ... x X^N
  = (R^D x ... x R^D)
  = (R^D)^N
```

Annotation:

```text
for embeddings of 1 token of size D & seq leg N.
[Gp?] Andrew Ng's notation?
```

Bottom-left fragment:

```text
Z_theta = integral_{seq emb} exp(-E_theta(x)) dx
```

## Editorial Synthesis

The two notes are naturally one argument:

1. The AR critique says local next-token generation can compound errors over a
   long horizon: `(1 - epsilon)^T`.
2. The EBM counter-pitch says global scoring of a whole sequence is conceptually
   attractive because the completed object can be judged as one object.
3. The partition-function note explains why that counter-pitch is not free:
   exact normalization over whole sequences scales like `|V|^T` in the discrete
   case and becomes a high-dimensional integral in the continuous embedding
   case.
4. Therefore the right comparison is a tradeoff, not a slogan:
   autoregressive models make normalization and training tractable through local
   factorization; EBMs make global compatibility natural but push cost into
   inference, sampling, and normalization.
