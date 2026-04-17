---
layout: post
title: "Tips for Giving Research Talks"
date: 2026-04-16
---

*Brando Miranda — April 2026*

Most bad research talks are not bad because the research is bad. They are bad because the speaker forgot that a talk is a teaching act, not a status update. You are not there to prove you worked hard. You are there to move one idea from your head into fifty heads at once, cleanly, in finite time.

I give talks often — to my lab, at conferences, to people who could have a Turing Award on their shelf — and I teach CS197 at Stanford, where students practice this early. What follows is the short list that, applied, will make your next talk noticeably better than your last one.

## A talk is an opportunity, not a reward

A lot of students treat a talk as a tax they pay for getting a paper accepted, or as a thing the advisor made them do. That framing sabotages the whole exercise.

A talk is an opportunity. You give talks so that smart people can tell you what is wrong with your work — the unknown unknowns, the holes you cannot see after staring at the problem for ten hours a day. It is another form of de-risking. You also give them so people remember you, so collaborations form, so the impact of your work grows nonlinearly. In my advisor's lab, we do not avoid lab meeting talks. We compete to give them.

Now flip it around. One hour times fifty people is fifty hours of human time, gone. If I walk into lecture unprepared, I am wasting the time of a roomful of people who were good enough to get into Stanford. If I give a sloppy talk at NeurIPS, that number is ten thousand. That should sober you up before opening Keynote.

## Know who you are talking to

Before any slide gets made, identify your audience. Everything in the talk has to be understandable by them — if it is not, why are you saying it?

The trap is assuming your audience thinks about your problem as much as you do. They do not. Even experts in your subfield are not spending sixty or eighty hours a week on your specific question. Treat them like motivated students seeing this for the first time. Empathy is the load-bearing skill. You do not give the same talk to high schoolers, to VCs, and to a Turing Award winner. Same content, three different talks. If you have not decided which one you are giving, you are already in trouble.

## Every sentence matters — and the story is not your story

There are two stories you could tell. One is what you learned — the finding, the bit flip, the result that changes how a reader should think. The other is how you personally got there — the bugs, the refactors, the Huber loss you did not understand at first, the six nested for-loops you wrote at 2 a.m.

Your audience does not care about the second. They care about the first. Every sentence has to earn its place against one question: does this help the listener understand what I learned? If not, cut it.

This is why generic intros are so bad. "LLMs have been shown to be good at X" — everyone in the room already knows. "Our outline: introduction, related work, method, results, analysis" — that is a table of contents, not a hook. A good intro sets up the bit flip. It tells the audience what they currently believe, makes them aware there is something they do not know, and promises to teach it.

Motivate with a real question. Why build huge general models for every task when we could build a small model that continuously re-adapts — say, a traffic camera that only needs to detect what is at this intersection, right now? That framing sets up the contribution. The answer — you do not need all the training data, just a small amount of the most recent data — now has a place to land.

## Set up the problem. Show, do not tell.

Early in the talk, state the inputs, outputs, and constraints. Your contribution is a system that meets *those* goals under *those* constraints. Without the frame, the audience cannot judge whether your solution is good.

Then, wherever you can, show instead of tell. A figure beats a paragraph. A video beats a figure. If you try to describe "turning videos of tennis matches into controllable video game characters" in words, the audience has to reconstruct six ambiguous nouns in their head. Show the clip. Done.

If your system fails under bad lighting, do not write a sentence about it. Put two pictures side by side — one lit well, one lit badly — and the problem is immediate. The audience cannot help noticing. That is the goal at all times: the point should be obvious. If they have to think too hard, they will drift, and they will wonder what is for dinner and how the dog is doing.

## Surprises are bad (the narrative kind)

You want to surprise your audience with *results*. You do not want to surprise them with *structure*. If slide ten suddenly has a picture of Pikachu and nobody knows why, you have lost them.

The fix: always say where you are going and why, before you say what you did. Why before what. If you introduce new complexity — a new term, metric, or step — motivate it first. "Now that we have a cost metric, we need a method to minimize it." The audience nods along.

The flow should be so obvious you could give the talk without slides and it would still make sense. Practice out loud. If you keep forgetting what comes next, that is not a memory problem. Your talk is not structured the way a human mind expects. Rewrite it.

## Explain every figure. One point per slide. Titles carry the talk.

When you put up a plot, treat the audience as if they have never seen a bar graph. Read the title. Name the x-axis. Name the y-axis. Say why the y-axis goes from 2 to 14. Explain the colors. Explain the little monster icon in the corner. It will feel slow — two, three, even five minutes on one figure — and that slowness is correct.

One point per slide. If you paste a twelve-row, eight-column table straight from the paper, you are asking the audience to do visual archaeology in real time. Sometimes giving a good talk means redoing your figures. Do it anyway.

And use your slide titles. If someone reads only the titles of your deck, top to bottom, they should get the whole story. Titles should be direct claims — "Our batch simulator is orders of magnitude faster than the original" — not labels like "Results." Pair that with section slides and the story almost tells itself.

## Close with the future. Handle questions with humility.

End on a forward note. Do not say "next I will generalize my method" — obvious and boring. Say what bigger thing this work is one step toward. "A real-time micro-rendering pipeline is not far away." You inspire, and you leave the audience with a place to put your work in their head.

Finally, questions. Do not be defensive. The whole point is feedback. If someone says your work is unclear, they are almost certainly right — you have been inside this problem for a hundred hours a week, they have had twenty minutes. If it was not clear, it is your fault, not theirs. You chose the audience. You designed the talk. Take the note, say thank you, and learn.

## Takeaways

- A talk is an opportunity for feedback, not a reward.
- Tell the research story, not the debugging story.
- Show before you tell; explain every figure in full.
- One point per slide; titles should read like a summary of the talk.
- Surprise the audience with the result, not the structure.
- In Q&A, the audience is always right. If they did not get it, you did not teach it.

Simple principles, applied consistently, make technical communication efficient and rigorous. Take pride in the craft. Do it well and the work compounds for years.
