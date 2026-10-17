"""Generate the sample paths for the evidence-accumulation figure (Appendix A).

p = N(0, 1), q = N(0, 2^2), so l(x) = log p(x) - log q(x) = ln 2 - 3 x^2 / 8 and
D_KL(p || q) = ln 2 - 3/8 ~ 0.318 nats. Prints pgfplots coordinates for three
cumulative sums S_n = sum_{i<=n} l(x_i) with x_i ~ p. Standard library only.
"""
import math
import random

N_STEPS, SEEDS, EVERY = 200, (1, 7, 2026), 2

for seed in SEEDS:
    rng = random.Random(seed)
    s, pts = 0.0, ["(0,0)"]
    for n in range(1, N_STEPS + 1):
        x = rng.gauss(0.0, 1.0)
        s += math.log(2) - 3 * x * x / 8
        if n % EVERY == 0:
            pts.append(f"({n},{s:.2f})")
    print(f"% seed {seed}")
    print("\\addplot[pathstyle] coordinates {" + " ".join(pts) + "};")
