---
layout: post
title: "Arguing a Research Project"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Most early-stage research projects don't fail because the idea is bad. They fail because the person running the project can't explain, in a minute, why the problem matters and why their approach is different. If you can't argue for your project, you probably don't understand it yet — and neither will anyone else.

This is the lecture I give in CS197 on how to argue for a research project. The mechanics of the argument end up being the same mechanics as writing a good introduction, and the same mechanics as writing a good abstract. One discipline, three artifacts.

## The bit flip is the spine, and the intro is its six sentences

In the previous lecture I introduced the idea of a bit flip: pick an assumption every prior paper has quietly agreed on, and flip it. The bit is the 0. The flip is the 1. Your novelty lives in that transition. The literature search — the iterative expansion of related work out from the most relevant papers — exists to prove two things at once: that the bit really is what the field believes, and that nobody has flipped it yet.

The argument built on that bit flip has two halves: the problem (why we care) and the solution (why your approach is creative and correct). The introduction is where you make that argument. It isn't a tour. By the time a reviewer finishes the intro they've usually made a tentative accept/reject decision and will read the rest of the paper hunting for evidence. A casual reader will either keep going or put the paper down. Treat those first paragraphs as the whole paper in miniature.

I structure every intro the same way, in six topic sentences — one per paragraph:

1. **Problem motivation.** State the main problem and why anyone should care.
2. **Set up the bit.** Summarize related work *in service of* your bit flip — not a laundry list.
3. **Flip the bit.** Announce the new idea.
4. **Instantiate the bit flip.** Make the idea concrete enough that a reader can picture the system or the experiment.
5. **Evaluation.** Convince an expert, using standard tools of the field, that your flip is actually correct.
6. **Implications.** If you're right, how does the field look different?

Those six sentences are the outline. Each one becomes the thesis of its paragraph, and the paragraph exists only to prove that thesis. Don't stray. One bit flip per paper.

One rule I repeat in class because students forget it constantly: every claim gets a citation. Every time you state that a problem exists, every time you characterize what prior work has done, every time you say something like "deep learning has made enormous progress" — cite it. A bold claim with a citation becomes trustworthy. A bold claim without one is a vibe.

## A worked example: emergence as a mirage

I lean on one of my own papers in lecture because I know the argument cold. The bit in the literature was this: as models get larger, new abilities emerge — sharp, unpredictable jumps where a capability suddenly appears. A Nobel laureate physicist had written "more is different" about complex systems decades earlier, and the machine learning community had picked up the same language for large language models like GPT and PaLM. The motivation is real: if models can silently acquire dangerous capabilities at scale, that's an alignment problem.

Our flip was: maybe emergence isn't a property of the model at all. Maybe it's an artifact of the evaluation metric. The word we used, deliberately, was "alternative explanation." A trick I learned from reading Nature abstracts is that the flip almost always arrives with a "however" — search for the word and you'll find the pivot. We instantiated the flip with a simple mathematical model and three experiments: we reproduced the reported jumps on the InstructGPT / GPT-3 family, we meta-analyzed past results and showed the jumps softened under different metrics, and we *induced* never-before-seen emergent abilities on vision tasks by picking a discontinuous metric. The implication was direct: if you swap a nonlinear, discontinuous metric for a linear, continuous one, the jump disappears and you see a smooth predictable curve.

The name helped. We called it Mirage. A mirage at a distance looks like water; when you get close it crystallizes into something else. The main figure was on page three: emergent-looking jump on the left, straight line on the right, caption in bold explaining exactly what you were supposed to learn from the picture. That figure *is* the bit flip.

## Pick a genre, and pick a safe one

Papers come in genres. New problem, old solution. Old problem, new solution. And the dangerous one: new problem, new solution. I tell students to avoid the third. The more novel things you pile into one paper, the more independent claims a reviewer has to be convinced of, and the more branches on which your paper can fail. Two new things means two chances to lose the room.

Old ideas come with warrants. A warrant is a free pass — prior work has already earned the legitimacy, so you don't have to. Visual question answering is a legitimate task. P-values and t-tests are legitimate tools. Transformers are a legitimate architecture for NLP. If you borrow a warrant, use it. Pair a warranted problem with a new method, or a warranted method with a new problem. That's how you make one move at a time.

The joke example I use: automatic sorting of socks with a new futuristic machine. New problem, new solution. Funny, and almost impossible to get anyone to take seriously.

## The abstract is six sentences, rewritten forever

The abstract is often the only thing anyone reads. The title might be the only thing *before* that. So the abstract has to do the intro's work in about six sentences: state the problem, give a mini background that motivates it, set up the bit, flip it with a "however," state the approach and key result, and close with the broader implication. It's the intro's outline collapsed into one paragraph.

Rewrite every sentence many, many times. The long exchange I have with my adviser on every paper is exactly this: he suggests an edit, I rewrite the whole thing, he suggests another. That's the process. Titles are the same — be honest, capture what you did and why it matters, and make it memorable. You're writing for humans, and memorable catches the brain.

## What I want you to walk away with

- **Argue, don't summarize.** An intro is a case for two things: the problem is important, and your approach is creative and correct.
- **The bit flip is the spine.** Name the assumption. Flip it. Make it concrete. Evaluate it with standard tools. Say what changes if you're right.
- **Six sentences, then paragraphs.** Write the outline as six topic sentences before you write anything else. Each paragraph proves one.
- **Cite every claim. Keep one move per paper. Rewrite the abstract until it hurts.**

If you can't do this in a minute to a partner — and in my class you literally turn to your partner and try — you don't understand your own project yet. That's fine. It means the writing is still doing its job: forcing you to figure out what you're actually doing, and why anyone else should care.
