---
layout: post
title: "Before You Build It, Ask If It Should Exist"
date: 2026-10-29
section: meta-research
---

*Brando Miranda — October 2026 · ~5 min read*

**TL;DR.** My coding agents have a bias I only noticed recently: when I hand them a research problem, they reach for building something big and complicated. I wanted to run an agent on a few tasks. The fastest path was to run it and read the output. What I got instead was a plan for a whole endpoint, and then the endpoint. In research and startups, where almost everything is uncertain, the first question is whether the thing should exist at all, so the default should be the cheapest test that answers it. Build big only after that test says yes.

---

This week I wanted a small thing. I had a handful of tasks and I wanted to know how a strong coding agent does on them. That is a small question: run the agent on the tasks, look at what comes out, write down the number.

I had told my assistant what I was after. What I got back was a design. There would be an endpoint that speaks a standard API, so that any harness could call the agent as if it were a model, and the tasks would be run through that. It was a sensible design. I might even want that endpoint some day. But I didn't need it to answer my question, and I had been waiting on the answer for a while by the time I realized what had happened. The agent I wanted to test was sitting right there. I could have just called it.

What bothers me is not that one agent made one over-engineered choice. It is that this looks like a pattern, and I think it is a bias.

## The bias

Give an agent an ambiguous research request and it drifts toward construction. A script becomes a package. A one-off comparison becomes a pipeline. A question about whether something works becomes a system that would let you ask a thousand such questions, none of which you have yet asked once.

I can guess at why. Writing code is what these models are good at, so building feels like progress to them, and a plan with many parts looks more like work than a plan with one command. A big build is also easy to defend: every piece has a reason. Nobody ever has to say "we skipped that" and be wrong about it.

For most people most of the time, this is fine. If you know what you want and you are producing a product, thoroughness is a virtue. A well-built endpoint is a good outcome.

But I do research, and I work on startup-type problems, and both are the opposite regime. Almost everything I do is high uncertainty. In that regime a big build is a bet that the thing deserves to exist, placed before you have any evidence that it does.

## Why a big build is the wrong first move under uncertainty

This is not a new idea. It is the center of the Lean Startup, Eric Ries's argument that the early job is to learn which thing is worth building rather than to build the thing well. It is the point of Steve Blank's Lean LaunchPad too: before you invest in a product, go and test the assumption it rests on. Michael Bernstein pushes the same instinct in his CS197 course at Stanford, which is where I picked up the word *vectoring*.

I wrote about two halves of this earlier this year. [Vectoring](https://brando90.github.io/brandomiranda/2026/04/16/vectoring-in-research.html) is choosing the riskiest assumption in your project, the one that, if it's false, makes everything downstream pointless. [Velocity](https://brando90.github.io/brandomiranda/2026/04/16/velocity-in-research.html) is answering that question as cheaply and quickly as you can.

What I had not said clearly enough is that the two are not separate steps to be done in order and then forgotten. With agents in the loop, velocity has to be written down as a default, because the agents will not supply it themselves. They are happy to point at the highest-risk question and then respond with a big plan to settle it.

Here is the question I should have asked my own assistant, and now ask every agent up front: *should this thing exist?* If I don't know yet, then the work is to find out, and the unit of work is the smallest test that moves my belief. For my example, the test was to run the agent on the tasks. That is the whole experiment.

## When velocity is the right call

There is a trade-off here and I don't want to pretend otherwise. Velocity-first is right when the test obviously covers the main risk. Running the real agent on the real tasks does: if it works, I know the thing I care about, and if it doesn't, I have saved myself the endpoint.

It is wrong to wave "move fast" at everything. If the cheap test doesn't actually touch the risky assumption, then going fast gets you a quick answer to the wrong question, and that is how you end up prototyping the wrong thing efficiently. So the order is: pick the riskiest question, find the cheapest test that clearly bears on it, run that, and only then decide what deserves real engineering.

Once the test has done its job and the answer is yes, go hard. Build the endpoint, make it clean, make it fast. At that point you are not guessing about whether it should exist, and being thorough is the right bias to have.

## What I changed

I now put a short rule in front of every agent that works for me on research or startup tasks:

- Start with the cheapest test that answers the main question. Run the thing before designing the thing around it.
- If something bigger is worth building, build it second, in parallel, and say so. It does not block the result I asked for.
- Say what the test does and does not cover, in one line, so I can tell whether it was the right test.

None of this is clever. It is the lean-startup instinct, written down for tools that don't have it by default. I would rather have the one-line answer sooner than a beautiful system later.

I still think the endpoint is a fine idea. I just wish I had been shown the number first.

**TLDR-end:** Agents drift toward building big, complicated things, which is the wrong first move when you don't yet know whether the thing should exist. For research and startup work, ask that question first and run the cheapest test that settles it. Go fast when that test clearly covers the main risk, and build the large version only after it says yes.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026buildorask,
  author = {Miranda, Brando},
  title  = {Before You Build It, Ask If It Should Exist},
  year   = {2026},
  month  = {October},
  howpublished = {\url{https://cs.stanford.edu/people/brando9/2026/10/29/agents-build-instead-of-test.html}},
  note   = {Blog post}
}
```

{% comment %}
Google Doc copy (private): https://docs.google.com/document/d/1XP5qVICnw2tO4-FF5iv_DLFWnzLXVAbW2achxX9jlE0/edit
{% endcomment %}
