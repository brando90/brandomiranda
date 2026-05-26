# Transcription: EBMs, Partition Functions, and Sequence Spaces

Source image: [images/photo-1-ebm-partition-functions.jpg](images/photo-1-ebm-partition-functions.jpg)

This is a best-effort transcription. I preserve crossed-out fragments and mark
uncertain words with `[unclear]` or `[?]`.

## Raw Transcription

Top title / framing:

- "Links [unclear] with LLMs/ARs & why EBMs."
- "-> [thm?] partition functions theorem motivates"
- "EBMs; but it doesn't explain why [unclear]"
- "Should be useful vs. ARs/LLMs."
- "[easy?] to motivate intuitively"
- "[connects?] Alpha[?]Net x0, x1, ... x_|X|-1"

Partition-function sketch:

```text
Z_theta = sum_{x in X} e^{-E_theta(x)}
```

Top-right/margin notes:

- "say X^D"
- "(1D)"
- "|X| - 1"
- "D [unclear]"
- "if E_theta(x) -> [in/out?]-function"
- "bits single units free"
- "e.g. -(x - theta)^2 / 2 sigma^2"

Energy examples:

```text
or E_theta(x) = theta^T x  ->  0 -> D
             = x^T theta
```

Examples / one-hot vectors:

```text
[0, 0, ...]
[0, 1, ...]
[0, 0, 1, ...]
```

Neural energy / matrix sketch:

```text
E_theta(x) = x^T [W^(0)]^5 W(x)
           = [ -x^T - ] [ w^(0)_... ... w^(1)_... ] [ -w^(2) ]
```

Shape notes around the neural energy sketch:

```text
1 x D
[n [unclear] x D]
[D, D]
[5?, Dout]
[D, 1]
```

Language example:

```text
eg
for language:
[
  [0, ..., 0]
  [0, 1, ...]
  [0, 0, 1, ...]
]
```

Comment:

- "* But this e.g. motivates EBMs from a partition function perspective"

Sequence length:

```text
n = batch(?) or sequence length |x|
```

Finite/discrete partition-function complexity:

```text
Z_theta = sum_{x in X} e^{-E_theta(x)}
          O(|X|^1) e.g. O(10) e^{-E_theta(x)} ops

Z_theta = sum_{x in X^N} e^{-E_theta(x)}
          => O(|X|^N) = O(D^N) = O(10^N) = O(10^?)
```

Sequence-space definition:

```text
X^N = X x X x ... x X
    = {x0, x1, ..., x_|X|-1}^D
    = X^D
```

Margin notes around sequence space:

- "X = {x0, x1, ..., x_|X|-1}"
- "set of size [unclear]"
- "reasonable with language [unclear] particles in [unclear]"
- "if they said X was 10^80? true"
- "exponential in N length of seq."

Continuous case:

```text
say X = R

Z_theta = int_{x in R^D} e^{-E_theta(x)} dx
        -> high dimensional arbitrary function
```

Question / exercise note:

- "Q: Exercise for reader (me later lol)"
- "getting X W^(? -> ?) to get us the first embedding layer"
- "embedding layer"
- "unnormalizable integral w/ + g"
- "-E_theta(x)! Crazy huh"

Normalizing-flow / integral note:

- "Give NF-Surg(?) hard to compt Z_theta"

Continuous sequence embeddings:

```text
X = X^1 x ... x X^N
  = (R^D x ... x R^D)
  = (R^D)^N
```

Annotation:

- "for embeddings of 1 token of size D & seq leg N."
- "[Gp?] Andrew Ng's notation?"

Bottom-left fragment:

```text
Z_theta = int_{seq emb} e^{-E_theta(x)} dx  <- N
```
