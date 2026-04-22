---
layout: post
title: "Asking the Right Question: Formal Methods as Scalable Oversight"
date: 2026-04-22
---

*Brando Miranda — April 2026*

A conversation broke out in my lab channel this week about whether AI coding assistants are actually helping us do better research, or just helping us feel like we are. It's a question I keep coming back to, and I want to write down where I've landed.

## The worry

A colleague laid out the concern cleanly. Long-term, he thought the usefulness of these tools splits along three axes: how much you already know, what you choose to spend their output on, and how well you parse what they produce. His sharpest observation was the third one. Models generate text faster than any human can read it. Over time that speeds up the surface and slows down the understanding. You skim, you trust, you move on. Another colleague echoed it from a different angle: he'd noticed a pattern of confidence without understanding — students sure they'd found something, unable to explain why, unable to catch errors when they appeared.

I don't think either of them is wrong. I've felt the same pull myself, and I include myself on the list of guilty parties. But I also think the picture is incomplete, because it treats "checking" as a single unstructured activity — one human eye against an avalanche of generated text. That framing makes the problem look unwinnable. It isn't, at least not in every domain.

## The structural move

In mathematics, the act of checking has a structure we don't always take advantage of. A proof of Fermat's Last Theorem is long, intricate, and beyond most of us to audit line by line. But the *statement* of Fermat's Last Theorem is short. If the theorem is written in a proof assistant like Lean, the kernel checks the proof automatically and deterministically. What a human actually has to verify is not the hundreds of pages of argument but a single claim: that the Lean statement faithfully expresses the informal theorem.

This is still not trivial — autoformalization is hard, and a wrong statement with a valid proof is worse than no proof at all. But checking a translation is dramatically cheaper than checking a proof. The complex reasoning gets offloaded to a deterministic verifier. The human is freed to do the one thing that was always ours to do: decide whether the question is the right question.

That, to me, is what scalable oversight looks like. Not a human racing a language model through a wall of text, but a human checking the short, human-readable end of an argument while a formal system checks the long, mechanical end.

## How far it goes

If you believe that most of what we care about can be expressed mathematically, a lot of oversight problems reduce to "are you asking the right question?" And here's my hot take: I think "most of what we care about" includes things people usually assume are off-limits. Love included. Probability theory is surprisingly accommodating, and I don't see a principled reason to exempt feelings, values, or relationships from formalization in some language rich enough to hold them. The claim is not that a Lean file replaces a relationship — it's that the structure of what we mean by one is not, in principle, beyond expression. That's not a small residue to be left with. What remains is the most important thing a researcher does. But it's a residue we're *equipped* to handle, because it's the part that depends on intent, taste, and knowing what you actually want rather than symbol pushing.

There are limits. A recent conversation with a friend reminded me that some true statements have no proof (Gödel, halting, diagonalization), and some things may resist formalization entirely. If reality turns out to be continuous in a way that escapes our formal systems, that residue matters. But for most of the work I do day to day, this is a theoretical ceiling, not a practical one.

## What this means for the worry

The concerns my colleagues raised don't go away under this view — they sharpen. If the human job is to ask the right question and verify the formalization, then the human has to actually understand the question and the formalization. Shallow reading is still a problem; confidence without understanding is still a problem. But the *target* of understanding shifts. I don't need to hold every line of a generated proof in my head. I need to hold the statement, the definitions, and the assumptions. That's a much smaller object, and it's the object that actually encodes what I meant.

This is why I find formal methods so generative as a research direction, and why I care about tools like Lean beyond their role in mathematics. They give us a way to scale human oversight by shrinking what humans have to oversee, without pretending we've removed humans from the loop. We haven't. We're still the ones who decide what counts as the right question. Could machines eventually learn to ask it for us? I don't want to rule it out — I've been wrong often enough about what neural networks can't do. But I suspect there's an intrinsic limit here that capability gains alone won't cross: these systems aren't running on biological neurons, they aren't human, and knowing what a human actually wants may be inseparable from being one. Wanting isn't obviously a thing you can outsource.

## The short version

Machines are getting very good at producing long arguments. Humans are not getting better at reading them. Formal verification lets us stop trying. We check the question; the kernel checks the answer. The part that's left — deciding what to ask — is the part we were always supposed to be doing anyway.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026formaloversight,
  author = {Miranda, Brando},
  title  = {Asking the Right Question: Formal Methods as Scalable Oversight},
  year   = {2026},
  month  = {April},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/04/22/formal-methods-scalable-oversight.html}},
  note   = {Blog post}
}
```
