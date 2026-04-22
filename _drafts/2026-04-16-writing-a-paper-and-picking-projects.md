---
layout: post
title: "Writing a Paper and Picking Projects"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Two of the hardest questions in research are wildly practical: what should I work on, and how do I write it up so anyone cares? Students often treat these as separate stages — first the research, then the paper. That framing wastes a lot of time. The project you pick constrains the paper you can write, and the paper you imagine writing is the cleanest sanity check on the project.

I teach CS197 at Stanford on research methods, and I've watched a lot of smart people stall on both ends of this. Here's how I think about it — what I actually do, and what I tell my students in section.

## Write immediately — writing is thinking

The most common misunderstanding is that a paper comes at the end. Coffee, grind, experiments, impostor syndrome, then magically a PDF appears. That is not how top researchers work. Part of the research process is to start writing on day one.

Writing is thinking. It forces you to articulate the idea, name the contribution, commit to a claim. Until you try to write it down, you don't actually know what you're doing — you have a vibe. A vibe is not a paper. Drafting derisks the idea: can you state the bit flip in one sentence? Do the terms even exist yet? If not, make them up and write them down.

Apply the same iteration principles to writing that you apply to experiments. Velocity. Fast loops. In CS197 I define failure as not running experiments — not experiments that fail. The analogue for writing: not having a draft is the failure mode. An ugly draft with half the figures missing is fine. Incomplete is better than not done.

## Model papers, not blank pages

Whenever I sit down to write, I have three or four papers open. Some I keep because I love how they were written. Some are in my area and help me frame things. I call these model papers, and I steal from them shamelessly.

A research paper has too many degrees of freedom to write from scratch. The blank page is a trap. Instead, pick a paper that makes the same *type* of argument you're making — same genre — and use it as a template. Not your nearest-neighbor paper necessarily. Your nearest neighbor might be poorly written. You want a well-written paper in a similar genre.

Which genre? A few to recognize. *We solve a problem.* You articulate the problem, explain why it's hard, detail your approach, evaluate against metrics the community trusts. GPT-3's "Language Models are Few-Shot Learners" is this: it demonstrated few-shot learning out of the box and essentially absorbed the old meta-learning field. *We explain a phenomenon.* Nobody has bothered to understand X; here's a study that sheds light. "Are Emergent Abilities of Large Language Models a Mirage?" is the canonical example — it showed you can manufacture emergence by changing the metric. *We introduce a technique.* Same skeleton as solve-a-problem, but the narrative centers on a method that generalizes. "Attention Is All You Need" is this paper.

Once you've picked your model paper, reverse-outline it. How does it structure its argument into sections? What's the sub-thesis of each section? What role does each figure play? Then translate: each heading, each sub-thesis, each figure maps to an equivalent in yours. Your figures carry enormous weight — a reader should be able to jump to figure one, read the caption, and know what the paper is about. Usually two figures do the work: one for the method, one for the main result.

A few concrete writing rules I keep coming back to. Use active voice. "The researcher conducted the experiment," not "the experiment was conducted by the researcher." Research is about communicating effectively, not hiding a profound message in passive constructions for the reader to decipher. Keep sentences short where you can. Rewrite until they're clear. GPT helps — but read the output carefully, because it doesn't know your context and will silently change things you didn't want changed.

Captions deserve a specific rule. The first sentence of every caption states the main takeaway. Bold it. I learned this from a paper I kept around for years — the rapid-learning-vs-feature-reuse paper — where every caption opened with the claim ("freezing successive layers preventing inner loop adaptation does not affect accuracy, supporting feature reuse"). Don't stuff hyperparameters into captions. Keep captions self-contained but terse; reference later sections for details.

One layout trick: you don't always need a `\section` heading. If a section is short, use a bolded lead word in a paragraph (`\textbf{Hypothesis.}`) and save the space. Machine learning papers also don't need literal "Hypothesis" or "Independent Variable" section titles. Your reader knows what a hypothesis is. Don't explain the structure of the genre inside the paper.

And about appendices in ML: most people don't read them. Write one only if you have a specific purpose — preempting a likely reviewer complaint, stashing a side experiment you reference from the main body. Not as a dumping ground.

## Picking a project: riffing, then rage

Where do ideas come from? The starter recipe is what I call riffing: read a bunch of papers, pick one you like, ask how you could extend it to another domain, challenge one of its assumptions, or otherwise push on it. That's a bit flip — a small, concrete conceptual shift — and it's a reasonable first independent project because it hands you the inputs, outputs, and assumptions up front. You focus on execution.

Riffing is training wheels, not the end state. Two failure modes to avoid. First, the *Jurassic Park* problem — "you were so preoccupied with whether you could, you didn't stop to think whether you should." You fell in love with a tweak, never asked if anyone cares. That's why I tell students to articulate the project's high-level goal daily, at the top of their research journal. Write the date, the project goal, this week's vector, the task, the deliverable. If the high level doesn't survive contact with your own pen, something is off.

Second, incremental research. Tiny adjustments that don't build substantial theory. Easy to do; hard to publish in reputable venues; doesn't move the field. The cure isn't to chase moonshots — it's self-awareness. What stage are you at? Your first undergraduate project shouldn't be aiming for a Nobel. That's unpredictable anyway. Let your mentors help you calibrate.

Beyond riffing, a few project-generation strategies I actually use:

**Rage-based research.** A pattern or assumption in the field keeps bothering you until you set out to prove it wrong. The Mirage paper on emergence is a clean example — people were claiming large language models had mysteriously emergent abilities; the authors showed you could reproduce the effect just by changing the metric.

**New tools on old problems.** Large language models reopened questions in social behavior, theorem proving, data quality. You can simulate humans cheaply now. Old question, new instrument.

**Seeing a new North Star.** My own "Beyond Scale" work on the diversity coefficient is this — everyone was chasing scale; I shifted attention to data quality as the axis that mattered.

**Pulling on weird results.** A strange jump in a plot, a surprising failure mode. Follow it. Sometimes the thread leads somewhere real.

**Hunches.** Maybe a language model can autoformalize mathematical English into Lean. Maybe models can think. Try it.

Linus Pauling said if you want to have a good idea, you must have many ideas. Plot a Gaussian. Two standard deviations covers 95% of your ideas. The gold is in the last few percent — three sigma out. So you need volume. That's not a platitude; it's a budgeting fact. Generate many, iterate fast, talk to collaborators, and kill the bad ones quickly.

## People over projects

One last thing I repeat every quarter: people matter more than projects. It is very hard to predict which project will change the world. Burning bridges for a single paper is almost never worth it. Learning to work well with collaborators compounds across every future project you do. The iPhone wasn't built by one person, and neither is any research worth doing. Pick your people. Treat them well. The projects follow.

## Takeaways

- **Write from day one.** Writing is the thinking. A rough draft is a sanity check on the idea.
- **Use model papers.** Reverse-outline a well-written paper in your genre. Translate its structure into yours.
- **Active voice, bolded caption leads, no appendix dumping.** Small rules that make the paper read professionally.
- **Riff first, then rage.** Start with a bit flip you can execute. Graduate to picking problems that bother you, reopen with new tools, or redefine the North Star.
- **Volume matters.** Generate many ideas. The good one is three sigma out.
- **People first.** Projects are unpredictable. Relationships compound.
