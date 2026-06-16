---
layout: post
title: "Don't Watch the Spinner: How a 'Done Thinking' Notification Makes You Less Dumb"
date: 2026-06-16
section: agentic-coding
---

*Brando Miranda — June 2026 · ~3 min read*

**TL;DR.** I set my phone to ring and buzz when the model finishes a long task. Now I fire the request, put the phone down, and get pulled back exactly when there's something to do — instead of watching the spinner and letting it fragment my attention. Tiny change, real difference.

---

A few weeks ago I caught myself watching a spinner. I'd kicked off a long reasoning task — one of those multi-minute traces where the model is actually chewing on something hard — and I just... stared at it. Not reading, not working on anything else. Waiting, like standing in front of a microwave.

I do this dozens of times a day. Most of my work runs through AI now, and the bottleneck isn't the model anymore — it's me, sitting in the gap between *I asked* and *it answered*, doing nothing with the gap.

Here's the problem with watching a spinner: you're not resting and you're not working. You're half-attending to something you can't speed up, while a little process in the back of your head nags you not to wander off in case it finishes. That split is expensive. There's a name for it — *attention residue* (Leroy, 2009): when your focus is divided, part of your mind stays stuck on the thing you're half-watching, and whatever you turn to next gets a dumber version of you. Gloria Mark clocks the recovery from a single interruption at around 23 minutes. Watching a spinner is a self-inflicted version of exactly that.

The fix is almost embarrassing: I made the model tap me on the shoulder when it's done. Send the request, **lock the phone**, walk away — and it rings and buzzes the moment it finishes. The one trick worth knowing is that the app only fires the notification when it's in the background, so locking the screen *is* the trigger; you just have to make sure the notification is actually set to make sound and vibrate, not sit there silent.

That one ping does two things, and they're worth separating. First, I can stop monitoring — the background process quietly reserving capacity for *is it done yet?* finally shuts off, and that capacity isn't small. Second, I can start the next thing without fear of dropping the first, because I'm no longer the one who has to remember to come back. The notification is. It's `async`/`await` for human attention.

I call it making myself less dumb, and I half mean it literally. I'm not smarter — I've just stopped spending scarce focus on a job a sound can do for free. And I can feel the difference, which is the part that surprised me.

None of this is really about a notification, of course. It's the same bet I keep [making](https://brando90.github.io/brandomiranda/2026/04/27/embrace-ai-or-be-left-behind.html): the people who do well with AI won't be the ones who refused it, or the ones who handed it their judgment — they'll be the ones who made a hundred small, unglamorous adjustments to keep their attention on the part that's still theirs. This is one of the small ones. It cost me five minutes.

Don't watch the spinner. Let it call you.

---

*If you'd like to cite this post:*

```bibtex
@misc{miranda2026spinner,
  author = {Miranda, Brando},
  title  = {Don't Watch the Spinner: How a 'Done Thinking' Notification Makes You Less Dumb},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/06/16/dont-watch-the-spinner.html}},
  note   = {Blog post}
}
```
