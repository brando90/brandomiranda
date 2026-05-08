---
layout: post
title: "Metallica Goes Jazz: A 2010 High School Arrangement, Reanimated by AI"
date: 2026-05-07
---

*Brando Miranda — May 2026*

**TL;DR.** In 2010, as a high schooler at Greengates, I arranged Metallica's *The Day That Never Comes* by hand for the school orchestra. Sixteen years later, I fed that same arrangement into [Suno](https://suno.com/) and asked it to recast the piece in the styles of Chet Baker, Cannonball Adderley, Charlie Parker, Joe Henderson, Stan Getz, and Sonny Rollins. [Here is the first take.](https://suno.com/s/1RTl4ch6L6LlbIFP) The point isn't novelty. The point is that AI lets you keep playing with old work in ways your past self never had the chops — or the time, or the ensemble — to attempt.

## Greengates, 2010

I was sixteen, and I wanted my school orchestra to play Metallica. Specifically *The Day That Never Comes* — the 2008 ballad off *Death Magnetic* with the long clean intro, the slow burn into distortion, and that anthemic final solo that I had been listening to on repeat. The orchestra was not a metal band. It was a school orchestra. So I sat down in Sibelius and wrote out parts: strings carrying the clean intro lines, brass and winds handling the rhythmic hits, percussion holding the long-form structure. It took weeks. I had no idea what I was doing.

I cannot overstate how primitive my workflow was. Sibelius 4. A laptop. A pirated MIDI rip of the song to reference by ear. No engraving expertise, no orchestration class, no internet community to ask. Just me, a deadline, and a stubborn belief that *this song would sound good with strings.* The PDF and the `.sib` files still exist — I keep them in [`experiments/00_metallica_goes_jazz/`](https://github.com/brando90/brandomiranda/tree/main/experiments/00_metallica_goes_jazz) on this site. The audio below is the Sibelius playback of the score. It is not a real ensemble recording. It is what 2010-me thought the arrangement should sound like, rendered by a sample library that, charitably, did its best:

<audio controls preload="none" style="width: 100%; max-width: 600px;">
  <source src="{{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes%20MP3.mp3" type="audio/mpeg">
  <source src="{{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes%20MP3.wav" type="audio/wav">
  Your browser does not support inline audio. <a href="{{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes%20MP3.mp3">Download the MP3</a>.
</audio>

The full score (PDF) is here:

<embed src="{{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes.pdf" type="application/pdf" width="100%" height="600px" style="max-width: 800px;">

If the embed does not render in your browser, [open the PDF directly]({{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes.pdf).

## Why jazz, why now

I have always loved jazz. I wrote about that [back in 2019]({{ site.baseurl }}2019/10/31/jazz-improvisation.html) — jazz and improvisation are two activities close to my heart, and the deepest skill in either is internalizing structure so completely that you can leave it on purpose without falling apart. I am confident I can *play* a Charlie Parker line — I've played *Confirmation* before. I do not have a working quintet on call. I cannot book Stan Getz for an afternoon. But the curiosity has always been there: *what would my Metallica arrangement sound like if a 1957 Blue Note session got hold of it?*

That question used to be a thought experiment. Now it is a Suno prompt.

## The prompts

I sat down and wrote six style prompts, one for each player whose voice I wanted to hear interpret the piece. The prompts live alongside the arrangement files in [`agents.md`](https://github.com/brando90/brandomiranda/blob/main/experiments/00_metallica_goes_jazz/agents.md), tuned for Suno V5 — short, era-tagged, instrument-explicit, and aggressively non-rock to keep the model from falling back on power chords. A representative one:

> Bebop, 200 BPM, virtuosic alto saxophone with rapid eighth-note runs and chromatic passing tones, walking upright bass, busy bebop drums with snare comping, piano with rootless voicings and tritone substitutions, frantic and intricate, 1940s bebop quintet.

That is the Charlie Parker prompt — the one behind the first take below. The others — Chet Baker, Cannonball, Joe Henderson, Stan Getz, Sonny Rollins — follow the same shape: subgenre, BPM, lead instrument and tone, rhythm-section behavior, mood, era. Each one is a hypothesis about how the harmonic skeleton of the song would refract through a different musical sensibility.

## First listen

The first take is [here on Suno](https://suno.com/s/1RTl4ch6L6LlbIFP). I will let you form your own opinion before I form mine for you. What I will say is that it captured something I genuinely could not have produced on my own — not in 2010, and not now. Whether it captured what I *wanted* is a different question, and that gap is exactly the interesting part. I am going to keep iterating: more prompts, more takes, more comparisons across players. This is take one of an experiment, not a finished product.

## What this is really about

I have written before that [AI is a force of nature, and the rational response is to merge with it rather than fight it]({{ site.baseurl }}2026/04/27/embrace-ai-or-be-left-behind.html). That post was about research and peer review and career stakes. This one is the lighter cousin. It is the same thesis applied to a personal artifact from sixteen years ago.

Here is the thing: if you had told sixteen-year-old me, while I was hand-engraving viola parts at midnight, that one day I would be able to type six sentences and hear what *The Day That Never Comes* sounds like in the voice of Charlie Parker, I would not have believed you. Not because the technology seemed impossible — I had no model for the technology at all — but because the *gap between intent and execution* felt like the thing that defined being an amateur. You wanted to hear it; you couldn't; that was the deal.

That deal is over. The gap between *I wonder what this would sound like* and *here is what it sounds like* has collapsed for an enormous range of creative tasks. That collapse is uncomfortable for people who built their identity inside the gap. I get it. But I would rather use the new tools to revisit old work, ask better questions, and explore the corners of my own taste that were previously gated behind skills I did not have the years to develop.

The arrangement is the same arrangement. The structure I wrote down at sixteen has not changed. What has changed is that I can now hear that structure performed by ensembles that exist only in prompt-space, and use those performances to learn something about what I was reaching for back then.

That is enough for a Wednesday afternoon.

---

*All files for this experiment (downloadable):*

- [Score — PDF]({{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes.pdf)
- [Sibelius source — `.sib`]({{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes.sib)
- [Sibelius 4 export — `.sib`]({{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes%20sibelius%204.sib)
- [Original Sibelius playback — MP3]({{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes%20MP3.mp3)
- [Original Sibelius playback — WAV (lossless)]({{ site.baseurl }}experiments/00_metallica_goes_jazz/The%20Day%20That%20Never%20Comes%20MP3.wav)
- [Suno prompts (`agents.md`) on GitHub](https://github.com/brando90/brandomiranda/blob/main/experiments/00_metallica_goes_jazz/agents.md)
- [First Suno take — Chet Baker style](https://suno.com/s/1RTl4ch6L6LlbIFP)
- [Experiment folder on GitHub](https://github.com/brando90/brandomiranda/tree/main/experiments/00_metallica_goes_jazz)

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026metallicajazz,
  author = {Miranda, Brando},
  title  = {Metallica Goes Jazz: A 2010 High School Arrangement, Reanimated by {AI}},
  year   = {2026},
  month  = {May},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/05/07/metallica-goes-jazz.html}},
  note   = {Blog post}
}
```

---

## Acknowledgments

Thanks to my friend [Audriix](https://www.audriix.com/) — a professional pop artist and songwriter based in the Bay Area — for cheering this experiment on and for the conversation that nudged me toward the next iteration of it. Go listen to her music.
