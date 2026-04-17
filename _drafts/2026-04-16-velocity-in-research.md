---
layout: post
title: "Velocity in Research"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Most of my students arrive with the same complaint. Research feels slow. Weeks disappear, experiments fail, deadlines pass, and the advisor starts to look worried. I've been there myself, more than once. The instinct is to work harder — longer hours, more code, a bigger system. That instinct is almost always wrong.

What fixed it for me was rethinking what progress even means in a research project. Research is a project with high uncertainty. If you knew the answer, it wouldn't be research. And if the result of your experiment is outside your control, then "it worked" is a terrible metric for how well you're doing your job. The better metric is velocity — how quickly you're learning — and once I internalized that, the swamp stopped feeling like failure and started feeling like the actual work.

## Why progress is the wrong metric

The swamp is my shorthand for the middle of any serious project. The model won't train. The proof won't close. The engineering keeps cropping up new problems. From the outside it looks like nothing is happening, and from the inside it feels the same. If you grade yourself on whether the experiment worked, you will be miserable, because whether it worked is not something you can fully control.

Velocity flips this. Velocity is the rate at which you reduce uncertainty in the direction you chose to explore. A week where you tried five ideas and all of them failed is a high-velocity week, as long as you actually learned something from each one. A week where you wrote a thousand lines of clean code and produced zero experimental results is a low-velocity week, no matter how good the code looks.

Gowers — the mathematician — put it well. Research is an iterative process of exploration, not a linear path from idea to result. Classes trained us to put in X units of effort and get X points back. Research does not work like that. The sooner you stop pretending it does, the sooner you get unstuck.

## Vectoring sets the question, velocity answers it

Vectoring and velocity are different jobs. Vectoring is picking the most uncertain assumption in your project — the one that, if wrong, kills everything downstream. It's an abstract question: is assumption X actually valid? Is the metric the reason LLMs look like they have emergent jumps?

Velocity is what you do after vectoring. You have the question; now how do you answer it this week, with the least possible work? This separation matters because it's easy to conflate them and end up prototyping the wrong thing fast, or the right thing slowly. Pick the question first. Then sprint.

The emergence-in-LLMs paper is my favorite example. The vector was: maybe those sudden jumps in capability aren't intrinsic to scaling — maybe they're an artifact of the scoring metric. Fine. Now how do you test that as quickly as humanly possible? One line of code changes the metric from accuracy to token edit distance. Modular arithmetic instead of Persian QA, because you can generate modular arithmetic examples automatically in Python — no hiring Persian speakers, no new dataset. GPT-3.5 through the OpenAI API instead of training anything yourself, because the cluster and the GPUs and the out-of-memory errors are all someone else's problem. A plot in a week. That is velocity.

## Core versus periphery

The single most useful frame I teach is core versus periphery. The core is what you genuinely need to answer this week's question. The periphery is everything else — the user interface, the full evaluation suite, the beautiful abstractions, the secondary features — and your job is to fake it, mock it, or skip it.

Your approach should be necessarily incomplete. Run evaluations on a subset. Use a smaller dataset. If you need a theoretical result, code up a simulation first — Python is faster than math, and the simulation tells you whether the theorem is worth proving. If the question is "does this approach even work on a toy case," build the toy case in pen and paper.

This wrinkles every instinct you picked up in school. In undergrad, you finish the problem set, you submit all the parts, you get points. In research you get rewarded for answering one question well, and punished for engineering a system that never produces an experiment. Don't engineer. Answer questions. The gold is a plot you reacted to — something that interacted with reality and told you whether your hypothesis was true. Everything else is decoration.

## The v = d/t trick

Velocity is distance over time. If your velocity is low, you have two options: cover more distance, or spend less time. Covering more distance means becoming a better engineer, learning more skills, working longer hours. That helps linearly at best, and you're usually already close to your skill ceiling in the short run.

Spending less time is where the real gains are. One over t changes very quickly. When t gets small, 1/t blows up. When t goes to zero — when you simply don't do the thing — velocity goes to infinity. That is why experienced researchers don't answer every email. That is why advisors sometimes go dark. Not doing something is the fastest way to make progress on everything else.

So: lower your fidelity. Strip the periphery. Spit out the ugly draft. The first pass is not supposed to be perfect — it's supposed to exist, so you can iterate. Perfection and permanence are the enemies of the first pass.

## Habits that keep velocity up

A few practices I actually run on myself:

**Walks without headphones.** I bike to lab and code in my head on the way. On a stuck problem, I walk and don't listen to anything. The brain solves problems in the background if you stop shoving input into it.

**Present your work often.** Lab meetings, office hours, a friend in a different subfield. Other people think differently than you and will ask questions you literally cannot generate from the inside.

**Many pots, not the perfect pot.** There's an old ceramics study where one class was graded on a single perfect pot and the other on quantity. The quantity group made better pots — they iterated, got feedback, calibrated. Research is the same. Aim for many failed experiments this week, not one perfect one next month.

**Don't pivot out of the swamp.** If you switch projects because you're stuck, you'll be stuck again in the new one, because the stuckness came from doing research, not from this particular project. The only way out is to prototype faster inside the swamp.

**Write the experiment in one line when you can.** If you can reuse code from an earlier experiment by swapping a metric or a dataset, do that. If you can use an API instead of standing up infrastructure, do that. Friction is the enemy.

## Takeaways

- Redefine success as learning, not as positive results. The swamp stops being a signal you're failing and starts being a signal you're in research.
- Separate vectoring from velocity. Pick the riskiest question first; then figure out the cheapest way to answer it this week.
- Be ruthless about core versus periphery. Fake, mock, or skip everything that isn't strictly required to answer the question. Incompleteness is the point.
- Lean on 1/t. The fastest way to increase velocity is almost never doing more — it's doing less, faster, and ignoring the rest.

If you're stuck right now, walk home without your headphones and ask yourself one thing: what is the actual question this week, and what is the smallest possible experiment that would answer it? Then go do that experiment tomorrow. The rest can wait.
