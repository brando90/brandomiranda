---
layout: post
title: "What Is Research?"
date: 2026-04-16
---

*Brando Miranda — April 2026*

The first lecture I give in CS197 every year is the one I most want students to remember a decade later. Not because the logistics matter — they don't — but because the definition of research is the thing that quietly decides whether the next four years of someone's life produce a paper, a company, or a pile of code that tested nothing.

So I start with the definition, and I keep repeating it, because if a student leaves the room with only one sentence it should be this: research is a new way of thinking about a problem, under high uncertainty, that validates or falsifies an untested assumption about the world.

## A tale of three Turing Awards

Every student I teach has used ideas that won a Turing Award without knowing it. The award is the Nobel Prize of computer science, and the pattern across winners is almost always the same: somebody noticed an assumption everyone was making, flipped it, and proved the flip worked.

Hennessy and Patterson are the cleanest example. The field assumed that as computing got more powerful, processors needed to get more complex — more elaborate instruction sets, richer hardware. They said no. Computation could be built out of simpler blocks. That became RISC — the reduced instruction set computer — and it runs under almost everything you touch today.

Engelbart is the second. Computing came out of mathematics, so computers were originally conceived as functions — you feed them a batch of data, they return an answer, they grind slowly in a corner. Engelbart said computing could be a tool for thought. A mouse. Hypertext. Collaborative software. The idea that a computer is a social object — something you sit in front of and think *with* — was a bit flip. I'm delivering these lectures on a Mac that feels good to touch, and that's downstream of him.

The third is Hinton, LeCun, and Bengio. For fifty years the consensus was that neural networks didn't work. Senior figures in AI actively trashed them. Machine learning, as a discipline, was built around hand-crafted features and graphical models. The bit flip was: maybe we don't need cleverer models, we need bigger ones — more data, more compute, GPUs, distributed training — and let the network learn the features itself. Around 2010, that started smashing every benchmark in speech and vision. Now it's the substrate of the entire field.

Three different areas. Same formula. An implicit assumption, a flip, a demonstration. That's what research is.

## Research versus industry

Students ask me almost immediately whether building a startup counts as research. Usually not, and the reason is sharp.

Industry needs the idea to already exist, at least technically. You cannot build a business on something that isn't feasible to build. If you can't construct an AI agent at all, you can't sell one. So startups de-risk a different question: will people pay for this? The technical ball is already on the ground. The uncertainty lives in the customer.

Research is the opposite. The idea doesn't exist yet. The uncertainty lives in reality itself — in whether the world works the way you think it does. Companies can do research, of course. MapReduce, Spanner, and the Transformer came out of Google. But the default mode of a company is to refine an idea that's been validated; the default mode of a lab is to test one that hasn't.

The timeline matters too. The rough shape, across digital communications, computer architecture, graphics, AI, is fifteen years from university lab to ten-billion-dollar market. When you're doing research you are, quite literally, living in the future. That's the part I want students to feel, because it reframes why the work is worth doing when every individual experiment is frustrating.

## Experiments are your money

The analogy I keep coming back to — and I wish someone had told me this on day one of my own PhD — is that experiments in research are what revenue is in a startup.

A startup founder who spends a year polishing a product without ever asking whether anyone will pay for it is not de-risking the business. They're avoiding the actual question. The point of an MVP is not craftsmanship; it's a cheap instrument that tells you whether reality agrees with your hypothesis. Google Forms and a landing page beat a beautiful prototype if the beautiful prototype doesn't test the thing.

Research is the same, with reality swapped in for the customer. Your product is your idea and the code that instantiates it. Your customer is reality. Your money — your signal that you're doing it correctly — is the experiment. Not the code. Not the elegance of the implementation. The experiment.

This took me years to internalize. It is easy, especially for strong engineering students, to fall in love with the code and confuse a shipped implementation for a tested idea. If your code doesn't test your hypothesis, it didn't make you any money. That's the sentence I repeat to myself when I notice I'm over-engineering.

## Why this mindset is hard

Coursework has trained almost every student I meet to expect clearly defined problems with known answers. Research is the opposite on both axes — the problem is exploratory and the answer is unknown. If we knew the answer, it wouldn't be research.

That inversion is uncomfortable. The instinct is to wait until you understand everything before you act. The correct move is to act fast enough that you find out what you don't understand. The two skills I most want students to leave the course with are vectoring — identifying where the uncertainty actually lives — and velocity — getting feedback from reality as quickly as possible. Everything else is a consequence of those two.

It also means your measure of progress changes. The right question at the end of a week is not "did I finish" but "did I get an answer." A negative result is still an answer. A broken experiment that teaches you the hypothesis was wrong is money in the bank. A beautiful refactor that tested nothing is not.

## The shape of a research career

The other reason I tell students about the CAs' and my own paths on day one is that careers in research are messier than they look from the outside, and it helps to see that early. I did statistics for databases in undergrad at MIT, biologically plausible neural networks during my masters, deep learning theory, then what was called meta-learning, then data-centric machine learning, and now machine learning for theorem proving and mathematical reasoning. Things changed. But something was always preserved — data, statistics, learning, and eventually mathematics. For years I used math to understand machine learning. Now I'm flipping it: I want the machine learning to do the mathematics.

Every researcher I know has a story like that. The topic drifts. The method drifts. What stays is the taste — the kinds of questions that keep pulling you back. Undergraduate research is the cheapest way to find out what your taste actually is, which is most of why courses like CS197 exist.

## Takeaways

A few things I want every student to walk out with:

- **Research is a new idea under high uncertainty.** If the idea already exists, or there's no uncertainty left, it's engineering or industry — both valuable, neither research.
- **Every field-defining result is a bit flip on an untested assumption.** Hennessy and Patterson, Engelbart, Hinton and LeCun and Bengio. Same formula, three different decades.
- **Experiments are your money.** Code and prototypes are means. The only signal that you're doing research correctly is that reality is answering your questions.
- **Vectoring and velocity.** Find the real uncertainty. Get a verdict from the world as fast as you can. Everything else follows.

If a student leaves CS197 having internalized just those four, I've done my job. The papers and the talks and the summer projects are scaffolding — useful, but scaffolding. The mindset is the thing that compounds.
