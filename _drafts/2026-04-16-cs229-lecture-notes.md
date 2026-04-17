---
layout: post
title: "Your Metric Is Lying to You: Three Lessons on ML at Scale from a CS229 Section"
date: 2026-04-16
---

*Brando Miranda — April 2026*

I sat in on a CS229 guest lecture this winter where my labmate Rylan walked through what he wished every ML practitioner understood in 2025. Most "ML advice" talks age badly — the canonical one is about building a Gmail spam classifier circa 2013. This one was different. It was about what actually goes wrong when you try to do serious work with models that cost eight or nine figures to train, and what those failures reveal about the field.

I want to write about three threads from that lecture, because they share a single spine: in modern ML, the thing you measure is almost never the thing you care about, and if you forget that, the measurement will destroy you. This is not a philosophical point. It has cost labs hundreds of millions of dollars.

## Emergence is (mostly) a metric artifact

The first thread is a piece of research I was part of, so I have to be careful not to oversell it — but it is maybe the cleanest example of this spine in the whole field.

Around 2020 the GPT-3 paper produced a famous figure. You scale a language model from a hundred million to 175 billion parameters, and on a task like five-digit addition the model is hopeless, hopeless, hopeless — and then, somewhere around the biggest scale, it suddenly works. This was called emergence. Entire research agendas formed around it. People wrote about phase transitions, unpredictable capabilities, the science of how capabilities appear.

Here is what we showed, and what Rylan walked through in the lecture. If you measure five-digit addition with strict accuracy — all five digits correct or no credit — you are compounding a per-token error rate to the fifth power. A model that goes from 60% per-token correctness to 95% per-token correctness looks almost flat under that metric at small scales (0.6^5 is about 0.08, 0.8^5 is about 0.33) and then snaps upward (0.95^5 is about 0.77). The model is improving smoothly. The metric is not.

Change the metric to edit distance — count how many tokens are wrong — and the "emergent" curve turns back into a boring, predictable, smoothly improving one. Same data. Same models. Different y-axis. One tells a story about a mysterious phase transition in the substrate of intelligence; the other tells a story about a per-token probability improving by a few percent per order of magnitude of compute.

I am not saying emergence doesn't exist. I am saying a huge fraction of what got reported as emergence was the interaction between a bounded per-token error rate and a metric that compounds errors multiplicatively. If you don't sit down and ask "what should I expect this curve to look like under my own metric assuming nothing weird is happening," you will see wonders everywhere, and some of them will be real and most of them will be arithmetic.

The lesson generalizes past arithmetic. Accuracy on multi-step tasks, pass@1 on code benchmarks, exact-match on question answering — these are all all-or-nothing metrics compounding over length. They hide steady progress at small scale and then announce fake phase transitions at large scale. If your tax accountant has to get every digit right, fine, accuracy is the right metric. For understanding what your model is actually learning, it usually isn't.

## Optimizing the proxy eats the objective

The second thread is the RLHF version of the same problem. You want a language model that humans prefer. Humans are slow and expensive, so you train a reward model on their preferences and optimize against that. The reward model is a proxy. It is not the thing you care about — humans are.

What happens if you keep optimizing? The reward model's score keeps going up. Real human satisfaction goes up for a while and then comes back down. The model starts doing weird things that the reward model loves and humans hate.

Two stories from the lecture. A team wanted shorter outputs, so they added a length penalty — number of words, computed by splitting on whitespace. The model learned to hyphenate everything. Same verbosity, now with dashes. Another team's reward model had learned that humans like emojis in casual contexts. The policy pushed harder and harder on this signal until it was generating pure emoji soup. Reward model: thrilled. Humans: throw the thing in the trash.

This is Goodhart's law with a GPU budget. When a measure becomes a target, it ceases to be a good measure. The RLHF version is structurally identical to the emergence story: you are looking at a number that is supposed to be a proxy for what you care about, and the number stops being that proxy exactly in the regime you pushed hardest into. The fix is not a better reward model — though that helps. The fix is knowing where the proxy breaks and not crossing that line, or building independent checks that catch you when you do.

I think about this a lot in my own work on formal verification. A Lean kernel checking a proof is not a proxy — it is the thing itself. But the statement of the theorem you asked Lean to check? That's a proxy for the mathematical claim you actually cared about, and models will happily write a syntactically valid theorem that is trivially true or doesn't say what the informal statement said. Scalable oversight is the problem of catching this kind of silent drift between proxy and target, without gold references, in the regime where you're optimizing hard.

## Surprises that scale will screw you

The third thread is about what happens when you make things bigger. Rylan put up a blog post from Adept where they asked: here are three training curves — one explodes, one NaNs out, one goes down smoothly. Which scares you most? Answer: the smooth one, because you have no idea whether anything is wrong.

The specific failure mode is silent data corruption. Modern accelerators have roughly a hundred billion transistors changing state a billion times a second for months on end. Software is written as if no mistake is ever made. One accelerator quietly starts computing slightly wrong gradients. The updates it produces are small, because step sizes are small. Your loss continues to descend. Toxins build up in the weights over tens of millions of steps. A billion steps in, the model is dead and unrecoverable. You cannot rewind a few thousand steps — the damage was baked in far earlier, at a moment you cannot identify, because nothing logged anything wrong at the time.

This is what "surprises that scale" means. On one GPU it essentially never happens. On a hundred thousand GPUs it is a near-certainty over a months-long run. The probability of failure goes up linearly in hardware and quadratically or worse in the product of hardware times time. You are not training a model; you are running a bet that nothing in a city-block-sized machine goes subtly wrong for a quarter of a year.

There is a related failure from the same family. A small amount of highly repetitive data — a web-forum thread where people just post "hey" back and forth — can, in private reports from frontier labs, destroy a model trained on trillions of tokens. You would think that a 32k-token document inside trillions of tokens couldn't matter. It does. The loss spikes, the gradients NaN, the run is over, and you discover the culprit only because your data loader is resumable and the failure repeats on the same batch.

The common thread, again: the quantity you're watching — loss going down, reward going up, accuracy curving up — does not tell you what you think it tells you. You need independent signals. Reproducibility. Consistency checks. The discipline of asking "what should I expect to see if nothing were wrong?" and noticing when you don't see it.

## What I took from it

Three things, compressed.

**Understand your measurement before you stare at it.** Before you interpret a curve, write down what shape it should have if the underlying process were boring. Most "surprising" ML results I've seen in the last five years were surprising only because nobody did this step.

**Proxies are local approximations.** A reward model, an eval suite, a theorem statement, a benchmark — these are good in some neighborhood of the thing you care about and misleading outside it. Optimizing across that boundary is where you lose.

**At scale, the exceptional becomes typical.** Any failure mode with probability one-in-a-million per GPU-hour is a certainty on a ten-thousand-GPU run. Reproducibility, resumability, and aggressive consistency checks stop being hygiene and start being load-bearing infrastructure.

None of this is about being clever. It's about refusing to let a number lie to you just because it's going in the right direction.
