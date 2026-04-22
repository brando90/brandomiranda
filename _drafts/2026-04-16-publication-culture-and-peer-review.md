---
layout: post
title: "Publication Culture and Peer Review"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Every researcher I know has a story about reviewer two. Mine are not especially dramatic, but they were formative — the rejections taught me more about the field than most acceptances did. This is a piece about what peer review actually is, what it fails at, and how to keep working when the system decides, for a moment, that your work does not count.

I teach this to CS197 students at the end of the quarter on purpose. By that point they have written a paper and iterated on feedback. The next thing they need to understand is what happens once the paper leaves their hands — and why the people judging it are fallible humans, not oracles.

## What peer review is actually for

Peer review has two jobs, not one. The obvious job is correctness — does the paper prove what it claims to prove, do the experiments support the conclusion, is the math right. The less obvious job is contribution. In CS theory, for example, most submitted papers are correct. The proofs check. So the interesting question a top conference has to answer is not "is this true?" but "is this one of the important true things?" Researchers are buried under a pile of facts about the world, and part of what top venues do is decide which facts deserve attention.

That framing matters because it tells you what a good review actually is. A good review is not a correctness audit. It is a judgment about impact and contribution, grounded in expertise.

The venues themselves sort by that function. NeurIPS, ICML, ICLR, AAAI, CVPR, AITP — those are the headline conferences in my corner of the field. Then there are venues explicitly designed to be less hypey and more discussion-oriented: DMLR (Data-Centric Machine Learning Research) and TMLR come to mind. Journals and conference-journal hybrids sit in there too. And then non-archival venues — workshops, posters, demos, arXiv — which exist for feedback and exposure without burning the publication. "Archival" means you only get to publish the result once. That word does real work.

My standing advice: submit to a workshop first, then to a real conference. You get feedback earlier, you get your work seen earlier, and sometimes a stranger tells you something you could not have known sitting alone with your draft. Publish soon, publish often, talk to people. Reality is the best reviewer, but only humans can tell you what is impactful.

## How the sausage gets made

A paper's life goes: write, pick a venue, submit, get reviewed, rebut or revise, accept or reject. Inside that loop, there is a committee structure that almost nobody outside academia understands. An area chair at the top recruits associate chairs who recruit reviewers — often by email, often through a chain of prior collaborators. You get three reviewers if you are normal, four if you are lucky or unlucky, depending on how you feel about more feedback.

Reviewing is double-blind. You anonymize your name, your affiliation, and anything that would let a reviewer guess who you are. Anything that leaks identity is a red flag. The point is that the paper is judged on content, not reputation, and that there is no room for retaliation. Egos out, science in. I recommend treating that seriously even when you think the anonymization is theater.

The process has known failure modes. NeurIPS 2021 ran an experiment where 10% of papers were reviewed by two parallel committees. 51% of those papers got different decisions between the two committees. Think about that number. Half the time, the accept/reject verdict is a coin flip between two reasonable panels of experts. Acceptance rates hover around 25% — NeurIPS was about 26% one recent year — and best paper awards are under 1%. The noise floor is enormous.

Thomas Mikolov received a Test of Time Award at NeurIPS for word2vec, a paper that was rejected at the first ICLR in 2013 despite a roughly 70% acceptance rate. SVMs were rejected. Deep learning was rejected for three decades before it turned into the thing entire companies are built on. Reviewers cannot reliably predict what will matter. Nobody can. That is not a flaw to fix; it is a property of the problem.

## Reviewer two and how not to be one

"Reviewer two" is the half-joking name for the reviewer who always has a bone to pick — unreasonably negative, trying to sink the paper, nitpicking without engaging with the contribution. The bad way to review is to read the paper, collect a list of objections, and convert the list into a score. That produces reviews that are technically correct and substantively useless.

The right way is three steps. First, identify what the paper is trying to achieve — its bit-flip, its novel claim — even if the authors did not articulate it well. Second, ask whether the paper achieved that goal. Third, ask how it could have achieved it better. Offer constructive critiques grounded in the paper's own thesis. If the goal is ill-formed, the execution is a secondary matter.

There is an older rule from Daniel Dennett that I think about a lot: before you criticize someone's work, reexpress their position so clearly and so vividly that they say "thanks, I wish I thought of putting it that way." Steel-man the paper before you take a swing at it. List the points you agree with. Mention what you learned. Only then earn the right to a word of rebuttal.

I also try to write reviews that help the author actually publish somewhere, eventually. Their career depends on it. If I think the paper is wrong or weak, I say so directly, but I write the review as if the goal is to make the paper better — because usually it is going to exist in the record either way, and I would rather it be correct.

One more thing I look for: a discussion section with real limitations, pros and cons, and nuance. Papers without that section get flagged by me every time. Not having it is a tell.

## How to survive rejection

My first paper got flat-out rejected. Everyone's first paper gets rejected. It hurts. I recommend treating it the way you would treat dating rejection — as resilience training, not as a referendum on your worth. The Kubler-Ross stages apply more than you would think: denial, anger, bargaining, depression, acceptance. Naming the emotion is how you stop being swallowed by it. You are not a robot. Process the feeling however you process feelings. Then get back to work.

Two practical points. First, read between the lines on rebuttals. In my experience, once a reviewer has decided, they rarely change their mind. Do not sink a week into a rebuttal unless you sense a reviewer who is genuinely open — rare, but real. If something is unethical or clearly wrong, escalate to the AC.

Second, sort bad reviews into two buckets. "They don't get it" reviews — the reviewer engaged with the wrong aspect of your paper — usually mean your title, abstract, or framing attracted the wrong audience, or your writing did not transmit the idea. That is a problem you can fix. "They get it" reviews — incisive, cutting down your core assumptions — are painful but high-signal. Take them at face value. They are the fastest way to a better paper.

I have had papers rejected that later became widely cited after another iteration. Rejection is often the best outcome. You would rather get rejected, iterate, and have real impact than squeak into a conference and be forgotten.

## What I want you to take from this

A few things I have converged on after years of this.

Peer review is noisy, biased, and imperfect — and still one of the best mechanisms we have for sorting contribution from correctness-theater. Trust the process loosely. Do not build your identity on it.

Your job as an author is to make the good reviewers' job easy. Write the thesis clearly. Cite the people who should be cited. Include limitations. Do not let the paper go over the margin — I know professors who will put a paper down for that alone, and honestly it is not crazy. If your presentation is sloppy, why should anyone trust the contents.

Your job as a reviewer is to steel-man before you strike. Identify the goal, evaluate the execution against that goal, suggest how it could have been better. Write the review that would help you if you received it.

And collect failures. Your CV of failures will be longer than your CV. That is a feature, not a bug — it means you tried more things, and trying more things is the only reliable way to find the rare things that matter.

Rejection is good. Keep iterating.
