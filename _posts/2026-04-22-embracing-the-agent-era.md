---
layout: post
title: "Embrace the Agent Era: The New Scarce Skill Is Creativity"
date: 2026-04-22
---

*Brando Miranda — April 2026*

**TL;DR.** AI agents are not a fad to wait out — they're closer to a force of nature, and fighting them costs us more than using them. What shifts is which skills are scarce. Writing and coding are being commoditized. Creativity, concentration, taste, and the ability to verify many parallel outputs without losing the thread are the new leverage. Education and research culture should catch up rather than dig in.

I've been watching a pattern in my field — and in rooms well outside my field — where thoughtful people are slowing themselves down by treating AI agents as something to resist rather than something to learn. I understand the instinct. I share some of the concerns. But I've landed somewhere different, and I want to write down why.

## Fighting a force of nature

The first thing to say plainly: this isn't going away. The tools exist, they're getting better, and they're being adopted at a pace that no individual discipline gets to veto. Treating agents as a trend you can sit out is a category error — it's like deciding not to participate in electricity. You can hold the line for a while, but the cost compounds, and the compounding is invisible until it isn't.

I don't mean this fatalistically. I mean it structurally. When a tool meaningfully lowers the cost of doing something people already want to do, adoption is not optional at the population level. It happens. The only question is who learns to use it well, and who ends up doing more work for less return because they refused to.

The more energy we spend fighting it, the less we have for the part that actually matters: figuring out what to do with it.

## What actually changes

The easy framing is "agents automate tasks, humans still matter." That's true but not useful. The sharper question is: *which* human skills still matter, and which ones just got repriced?

A lot of what used to be a differentiator is getting commoditized. Clean prose. Competent code. Well-formatted slides. Literature summaries. First-draft proofs. These were real skills and they still are, but their price is falling, because producing them is no longer the bottleneck. If your edge was "I write clearly" or "I can implement this in a weekend," your edge is narrower than it was two years ago.

What isn't commoditized — what, if anything, is getting *more* valuable — is the stuff upstream of execution. The idea. The taste. The decision about what's worth doing. The judgment to tell a real result from a fluent-looking one.

## Why creativity is the scarce resource

Here's the argument I keep coming back to. Modern machine learning is, at its core, very good interpolation. You fit a huge function to a huge dataset and the system becomes excellent at producing things that look like the training distribution. That's not a dismissal — interpolation over the entirety of human output is genuinely powerful. But it is structurally different from novelty.

You can train a model to code well by showing it a lot of good code. You can train it to write well by showing it a lot of good writing. But how do you train a model to be *creative*? Creativity is, nearly by definition, the production of something that wasn't in the training set. The thing you'd need to imitate is the thing you're trying to generate. The target isn't there yet.

I'm not fully pessimistic here. I think with test-time compute and a good verifier, these systems can extrapolate at least a little — push a step past the training distribution and check whether the step is good. Iterate. You can plausibly inch the frontier outward that way. But this depends entirely on having a verifier that tells you when you've landed somewhere real rather than somewhere that just *looks* real. And building that verifier is the hard problem.

I argue elsewhere, in my post on [formal methods as scalable oversight](https://brando90.github.io/brandomiranda/2026/04/22/formal-methods-scalable-oversight.html), that the verifier may in the end need to be human — or at least grounded in something human — because values, intent, and "is this actually what we wanted?" are tied to being the kind of creature that wants things. Machines are not intrinsically human. Whether they can ever be true verifiers of what humans care about is, to me, genuinely unsettled. Until it's settled, the human sits in the loop at the one place that matters most: the question.

So creativity is scarce on two fronts. It's hard to train directly. And it's the part that decides whether any of this effort is pointed at something worth doing.

## The false dichotomy of "just prompting"

A common pushback is that working with agents is just "prompting" — as if it reduces to typing a sentence and accepting whatever comes back. That's not what working with agents actually looks like at scale, and the dichotomy misses an entire new skill stack.

Try running ten ideas at once. Really ten, across separate branches, with agents doing real work in each. The skill isn't prompting. The skills are:

- Holding ten coherent threads in your head without collapsing them into mush.
- Knowing *which* part of each output to read carefully and which to skim — because you cannot read it all, and pretending you can is how errors slip through.
- Designing your checks so that verifying a subset gives you real confidence about the whole.
- Noticing, fast, when an agent has drifted and cutting the branch before it metastasizes.
- Keeping taste sharp enough to reject fluent-but-wrong work that a tired human would accept.

My own tactic, for what it's worth: I ask Claude Code and Codex for a TL;DR at the top and bottom of every response, plus a short snippet — maybe 45 lines — of the core output. I read those three things first. Depending on what I see, I go deep or I don't. That habit alone has done more for my throughput than any model upgrade. I wrote more about the full workflow in [my post on the correctness-gated multi-agent setup](https://brando90.github.io/brandomiranda/2026/04/13/correctness-gated-multi-agent-workflow.html).

None of that is "just prompting." It's closer to running a small research group where every member is fast, literal, and occasionally confidently wrong. That is a real skill, it's learnable, and it's not the same skill set that won the previous era.

## Execution is cheap, so creativity compounds

Here's the part I find genuinely exciting. When execution was expensive, ideas were rationed by who could implement them. The best idea in the room often lost to the most buildable one. That ceiling is lifting. If you can spin up five prototypes in a week instead of five in a year, the person who generates more good ideas wins by a much larger margin than they used to.

This is why I think the creative end of any field is about to get more valuable, not less. The bottleneck moves upstream. The people who benefit most are the ones who had surplus ideas sitting on the shelf because they didn't have time to build them. They do now.

The flip side is honest too: if your value was mostly in the execution layer, the ground is moving. That's uncomfortable, but it's information. It tells you where to invest.

## Be creative about how you work, not just what you work on

Something I don't see discussed enough: the agent era also reshapes *where* and *how* creative work happens, not only what gets produced. When execution used to require a big machine, a specific desk, and a full engineering environment, your body had to be there too. That tethered creativity to the place where the work could physically run.

It doesn't anymore. I bought a MacBook Air and a couple of portable monitors, and now I can direct a handful of agents from almost anywhere — a lounger at the pool, a bench on a walk, a café in a town I don't live in. The heavy lifting runs on a remote machine; what I carry is the part that actually needs me: taste, direction, judgment on the outputs. The rest of it is coordination.

What I didn't expect is how much this changes the quality of the ideas. Nature, movement, and variety are some of the best creativity inducers we know of, and for most of my career they were in direct tension with "getting work done." You could walk, or you could execute, not both. Now I can take the walk *and* have real work advance while I'm on it. The creative front end and the execution back end decouple, and the front end gets to live in the environments that actually make it better.

So when I say creativity is the scarce resource, I don't just mean creativity about ideas. I mean creativity about the shape of the working day — where you are, what you're looking at, what rhythm you're on, what loop you've set up between your mind and the agents doing the typing. Being creative about your process is itself a large source of leverage now, and it was much harder to pull off before.

## Education and writing have to change

If writing is commoditized, "can you write a coherent five-paragraph essay" stops measuring what it used to measure. That was always a proxy for clear thinking, and the proxy just got leaky. Leaning harder on it — more essays, stricter formatting, policing the tools — doesn't fix the measurement, it just makes the proxy noisier.

The real target was always the thinking. Curricula built around "produce the artifact" need to shift toward "produce the artifact *and* show me you can interrogate it, improve it, notice what's wrong with it, and defend why it's the right artifact to have produced." The artifact is cheap now. The reasoning around the artifact is what we should be grading.

The same goes for coding education, and honestly for a lot of research training. The point was never to produce students who type fast. The point was to produce students who *think*. The best teachers have always known this. The rest of the system has some catching up to do.

## What remains for humans

I don't want to pretend the transition is painless. Skills that were hard to build are being repriced; that's a real cost to real people. But the response to "the landscape shifted" is not "let's pretend it didn't." It's to figure out where the leverage went and move there.

My honest read: the leverage moved to creativity, concentration, memory, taste, and the ability to verify at scale without losing rigor. A researcher in this era wins by having more good ideas, running more of them in parallel without getting confused, and knowing — precisely — which outputs to trust and which to interrogate. Creativity picks the question. Focus and discipline keep the parallel work coherent. Verification, ideally backed by something formal, catches the mistakes.

That's a better job than the one it replaced. It's also harder, in the ways that actually matter. Embrace it.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026agentera,
  author = {Miranda, Brando},
  title  = {Embrace the Agent Era: The New Scarce Skill Is Creativity},
  year   = {2026},
  month  = {April},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/04/22/embracing-the-agent-era.html}},
  note   = {Blog post}
}
```
