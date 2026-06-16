---
layout: post
title: "Don't Watch the Spinner: How a 'Done Thinking' Notification Makes You Less Dumb"
date: 2026-06-16
description: "Brando Miranda — June 2026 · ~10 min read. Attention residue, parallel work with AI, and why the smartest workflow upgrade I made this year was a notification sound — wired across every agent I run, each one identifiable."
---

# Don't Watch the Spinner: How a "Done Thinking" Notification Makes You Less Dumb

Jun 16, 2026

*Brando Miranda — June 2026 · ~10 min read*

**TL;DR.** When you fire off a long AI task and then sit there half-watching the spinner, you pay a hidden tax: your attention is split, and split attention is dumber attention. The fix is embarrassingly simple — make the model ping your phone when it's done thinking. That one notification does two things: it lets you stop monitoring (you reclaim focus) and it lets you parallelize to the next task without fear of forgetting the first. I now have this wired across *every* agent I run — Claude, ChatGPT, Codex, OpenClaw — and, crucially, each one is identifiable, so a buzz tells me *who* finished, not just *that something* did. This isn't a gadget tip. It's the same bet I keep making — that the people who *adapt thoughtfully* to AI, down to the dumb little workflow details, will leave everyone else behind.

---

A few weeks ago I caught myself doing something stupid. I'd kicked off a long reasoning task in Claude — one of those multi-minute traces where the model is genuinely chewing on something hard — and I just... watched it. Eyes on the spinner. Not reading, not working on anything else. Waiting. Like standing in front of a microwave.

I do this dozens of times a day now. Most of my research runs through AI agents: Lean proofs, autoformalization passes, [VeriBench](https://brando90.github.io/brandomiranda/veribench/blog/veribench-launch/) experiments, multi-agent jobs running in tmux on a Stanford server. The bottleneck isn't the model anymore. It's me, sitting in the gap between *I asked* and *it answered*, doing nothing useful with the gap.

So I made a change that sounds trivial and isn't: I set my agents to send a notification to my phone the moment they're done thinking. And I could feel my brain get sharper almost immediately. I want to explain why — because the *why* is more interesting than the *how*, and because it connects to a fight I keep having about whether using AI makes you sharp or soft. Then I'll give you the whole build, including the part that actually took me an afternoon of fiddling to get right.

## The spinner tax

Here's the thing about watching the spinner: you're not actually resting, and you're not actually working. You're in the worst of both — half-attending to a thing you can't speed up, while a background process in your head nags you not to wander off in case it finishes.

There's good science on what this costs. Sophie Leroy — the researcher I think a lot of people half-remember under the wrong name — named the mechanism in [2009](https://www.sciencedirect.com/science/article/abs/pii/S0749597809000399): *attention residue*. When you split attention between Task A and Task B, a chunk of your cognition stays stuck on A even while you're nominally doing B. Performance on B drops. You feel scrambled. Cal Newport popularized her work in *Deep Work*; it's the load-bearing idea under the whole "deep vs. shallow" framing.

[Gloria Mark](https://gloriamark.com/attention-span/) put a number on the recovery side. After an interruption, it takes the average knowledge worker about 23 minutes and 15 seconds to get back to the *same depth* of focus — not to merely resume the task, but to reach the same cognitive depth. Her more recent data, in her book *Attention Span*, is bleaker: average time on a single screen before we switch has collapsed to roughly 47 seconds, and we interrupt ourselves nearly as often as anyone else interrupts us.

Watching a spinner is a self-inflicted version of exactly this. You've built a little interruption machine and you're standing in front of it. The cost isn't the wait. The cost is that the wait fragments the attention you'd otherwise be spending on something hard.

## What the notification actually buys you

A "done thinking" ping fixes two distinct problems, and it's worth pulling them apart.

**First, it lets you stop monitoring.** The reason you keep glancing back is that you don't trust the spinner to tell you when it's finished. Give it a voice — a sound, a buzz — and you can fully look away. The background process that was reserving capacity for *check if it's done yet* gets to shut off. That reclaimed capacity is not small. It's the difference between thinking with your whole head and thinking with most of it.

**Second, it lets you parallelize without dropping the ball.** This is the part I underrated. Once the model can interrupt *me*, I can do what every engineer already does with slow operations: fire it off, switch context completely to the next thing, and let the callback pull me back exactly when there's something to do. It's `async`/`await` for human attention. The fear that normally stops you from starting a second task — *if I leave, I'll forget to come back* — evaporates, because you're no longer the one responsible for remembering. The notification is.

This is why I say it makes me less dumb, and I mean it almost literally. I'm not smarter in some abstract way. I've just stopped spending scarce deep-focus budget on a job a notification can do for free. And I can *feel* the difference, which is the part that surprised me.

There's a second-order win once you have more than one agent. I routinely have Claude, a Codex job, and a couple of background runs going at once. If they can all tap me on the shoulder, my desk turns into a job queue with interrupts instead of a set of tabs I have to babysit in rotation. But that only works if I can tell *which* of them just finished without unlocking the phone and going hunting — which is the part of the setup that took the most care, and which I'll get to.

## The build

Two layers, and the order matters — I had them backwards at first and burned an afternoon on it.

### Layer 1 — the source has to actually emit the alert

No phone setting can create an alert the app never sends, so start here. This is true for every agent, and each one has its own quirk:

- **Claude (app).** The thing that tripped me up for an embarrassingly long time: the Claude app's "message completion" notification only fires when Claude finished responding *in the background* — never while you're sitting in the open conversation with the screen on. That feels like a limitation; it's actually the whole point. So the working pattern for chats is: fire the request, **lock the screen or switch apps**, and let it call you.
- **ChatGPT (app).** Same idea, more channels. It posts under distinct categories — *Responses* (a reply finished, but rare, and effectively background-only, like Claude), *Tasks* (scheduled tasks, a couple a day), and *Codex Remote* (cloud Codex jobs, about one a day). Turn the ones you care about on.
- **Gemini, OpenClaw / "andClaw," and friends.** Whatever notifications the app actually posts, the same device-side treatment below applies.

The rule of thumb: **if it's an app on your phone, it lives in Layer 2's channel settings. If it's an agent in a terminal or on a server, it gets the relay** (further down).

### Layer 2 — make the alert loud on the device

A notification channel being toggled "on" does *not* mean it makes noise; you have to open the channel itself. On my Pixel, for each app's completion channel: open the channel (tap its name, **not** the on/off toggle), set it to *Default (may ring/vibrate)* — **not Silent** — pick a sound, turn on **Vibration**, turn on **Override Do Not Disturb**, and turn on **Pop on screen**. Set the app's battery to **Unrestricted** so a screen-off completion isn't delayed by Doze. Then check the obvious-in-hindsight stuff that cost me the most time: notification *volume* isn't zero, the ringer isn't on vibrate-only, and the face-down "Flip to Shhh" gesture isn't silently dropping you into Do Not Disturb.

One tell I wish I'd known: in the per-app category list, a little **bell icon** next to a category means it's set to alert. No bell usually means it's set to Silent — which is exactly the state where it shows up but never makes a sound.

### Which one just buzzed? — telling your agents apart

Here's the problem nobody warns you about: the moment four agents can all ping you, a buzz from a locked screen is ambiguous. Was that Claude? ChatGPT? A Codex job? I solved this two ways, and I'd do both.

**See it (a glance identifies the sender).** Lock-screen visibility on Pixel is a *system-wide* setting, not a per-app one — which is why I couldn't find it under the app at first. It's **Settings → Notifications → Notifications on lock screen → Show on lock screen → On**. On Android 16 the lock screen defaults to a **Compact** view that shows only the newest notification in full and shrinks the rest to a row of icons; switch it to **Full list** so multiple agents show up as labeled cards. Once notifications show, the app icon and name *are* the identifier.

Two Pixel gotchas will silently defeat all of this, and both bit me:

1. **Face Unlock → "Skip lock screen."** If it's on, the phone jumps straight past the lock screen to the home screen the instant it sees your face — so you hear the buzz, pick up the phone, and there's nothing to see. Turn it off if you want to actually land on the lock screen and read who pinged you.
2. **A leftover per-channel "Don't show on lock screen"** override on a specific app beats the global setting. If one agent never shows while the others do, that's where to look (the app's individual category → Lock screen → Show).

For privacy, you can leave **Show sensitive content** off — the app name and icon still show, only the message preview is withheld — and **Show silent notifications** off is fine, because your actual noise-makers are *alerting* channels, which always show.

**Hear it (eyes-free, which is the whole point).** Give each app a *distinct* notification sound and you'll know the agent by ear without looking at all. Practical ceiling is about three or four genuinely different tones before they blur — a bell vs. a marimba vs. a chord, not three similar dings. This is the version I reach for most, because it means I never have to break focus to glance at the phone.

### Terminal and server agents — the relay (the part I actually rely on)

For Claude Code running in tmux on a server, I don't trust any app's foreground heuristics. I route completion through [ntfy](https://ntfy.sh) so a *separate* app makes the sound — which means it fires no matter what's on screen, even with the originating app in the foreground, the one case the native setup can't cover. The bonus: **every agent can point at the same ntfy topic**, and you stamp each one with a title and an emoji tag so you still know who finished. Install the ntfy app, subscribe to a long random topic (the topic name is effectively the password), and wire each agent to it.

**Claude Code** — drop this in `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "curl -s -H 'Title: Claude done' -H 'Priority: urgent' -H 'Tags: robot' -d \"$(hostname): agent finished\" ntfy.sh/REPLACE-WITH-YOUR-RANDOM-TOPIC",
            "async": true
          }
        ]
      }
    ]
  }
}
```

`Stop` fires when the main agent finishes; add a `SubagentStop` block if you also want a ping per subagent. `async: true` keeps the `curl` from blocking Claude. (Claude Code also has a built-in Remote Control push you can flip on with `/config` → "push when Claude decides," but it routes through the Claude app and inherits the same foreground limitation, so for guaranteed delivery I prefer the hook.)

**Codex CLI** — it has its own completion hook. In `~/.codex/config.toml`, point `notify` at a tiny script; Codex runs it on `agent-turn-complete` and passes the event as a single JSON argument:

```toml
# ~/.codex/config.toml
notify = ["/home/you/bin/agent-notify.sh"]
```

```bash
#!/usr/bin/env bash
# Codex passes the event JSON as $1 if you want to parse the message
curl -s -H 'Title: Codex done' -H 'Priority: urgent' -H 'Tags: package' \
  -d "$(hostname): codex turn complete" \
  ntfy.sh/REPLACE-WITH-YOUR-RANDOM-TOPIC
```

**OpenClaw** — depends on where it runs. As a phone app (e.g. "andClaw"), it's just the Layer 2 channel setup. On a server, route its gateway/event to ntfy the same way — or simply let the underlying agent's hook fire, since OpenClaw drives Claude Code / Codex under the hood and those already ping. Same topic, different tag.

Distinguish sources with the `Title` and an emoji `Tag` per agent (🤖 Claude, 📦 Codex, …), or give each its own ntfy topic and set a per-topic sound in the ntfy app. Now one channel on my phone is the union of everything I have running, and each buzz is labeled.

### Honest caveats

The sound is rock-solid. The *vibration* I was unsure about at first — on a Pixel a single notification pulse is brief — but once the lock screen actually woke to the alert (i.e., after I killed "Skip lock screen" and set the channel to alert rather than Silent), the buzz came through strong and unmistakable. If yours is still weak, don't lean on the channel's default pulse: a MacroDroid rule ("notification from Claude → vibrate ~2s + play sound") forces a long, custom haptic.

The foreground limitation for consumer apps is real, and only the relay fully solves it. And one unrelated annoyance worth flagging: on a Pixel the **screenshot shutter has no off switch** and follows the ringer — so *don't* silence it by going to Vibrate/Silent, because that also kills your notification. Take screenshots through Gemini/Assistant ("take a screenshot") when you want them silent; that path ignores the ringer.

## "But writing is where you do your thinking"

Now the fight. Whenever I argue for leaning harder on AI, someone raises a version of Adam Grant's objection — and Grant makes it about as well as it can be made. His line, roughly, is that outsourcing most of your writing to AI is a mistake: even when the output is good, [the act of writing is where we do our best thinking](https://x.com/AdamMGrant/status/1919020621389779387), and handing it off means skipping the part where you actually develop the idea.

I want to be fair, because this is not a dumb argument. It's the Leroy/Newport point from the other direction: the friction of writing — spelling out a hunch, watching it collapse, rebuilding it — *is* cognition, not packaging. Grant is also more careful than the people who quote him. He says *most* writing, not all, and he's elsewhere pointed at evidence that AI can sharpen human creativity. On his own podcast he raised the [Doshi–Hauser study](https://www.ted.com/podcasts/rethinking-with-adam-grant/will-i-am-on-ai-and-the-future-of-creativity-transcript), where writers given AI-suggested ideas produced stories rated as more novel and interesting — with the important catch that, across many people, the stories also drifted toward each other. Individual lift, collective homogenization.

So the steelman is real: there's a kind of thinking that only happens when you do the work yourself, and you can lose it by outsourcing.

## Where it's right, and where it's too narrow

Here's where I get off the train. Grant's argument proves that *some* thinking lives in the doing. It does not prove that the doing is the *only* place thinking lives — and it quietly assumes the valuable cognition happens at the level of sentences.

For most serious work, the valuable cognition is a layer up: which problem to attack, which question is even the right one, what counts as a correct answer, where the argument is most likely to be wrong. When I hand a proof attempt or a draft to a model and get something back, I'm not skipping the thinking. I'm relocating it — from *produce the tokens* to *judge the tokens, redirect, decide what matters*. That's harder thinking, not less of it. And the notification I've been going on about is precisely what protects that layer: it stops me from spending judgment-grade attention on babysitting a spinner.

I'll go further, and I'll flag that this next part is my uncharitable read: I suspect some of the resistance from excellent writers is that it stings to discover your craft is partly automatable. I get it — I work on automating things I'm proud of being good at. But the reaction misreads what automation does to a skill like writing. It doesn't flatten the human contribution. It *amplifies* the part of it that was always the actual value: taste, judgment, the choice of what to say and why it matters. The mechanical layer gets cheaper; the discernment layer gets *more* valuable, because now it's the bottleneck.

## Taste is the hard part — maybe permanently

Which brings me to the thing I actually believe. The human edge was never breadth or output speed — I've [argued before](https://brando90.github.io/brandomiranda/2026/04/27/embrace-ai-or-be-left-behind.html) that you cannot out-execute a system trained on the written record of humanity, and you shouldn't try. The edge is taste and creativity: knowing which idea is worth having, which result is beautiful, which question opens a door. Those are exactly the things hardest to learn from data, because the training signal for "good taste" is thin, contested, and often only legible in hindsight.

Could a model learn taste anyway? Honestly — maybe. I've watched these systems do too many astonishing things to bet confidently against them, and I try to hold the question loosely. But I also think it's genuinely possible that some of it is a *fundamental* limit rather than a temporary one — that taste and creative judgment resist compression into a loss function in a way that's different in kind from "predict the next token well." I don't know. I lean toward *much harder than people think, possibly impossible to fully automate*, and I'm comfortable being wrong. Either way the strategy is the same: spend your scarce human attention on the part machines are worst at, and let them have the rest.

## The throughline

None of this is really about a notification sound. It's the same bet I keep making. AI is a [force of nature](https://brando90.github.io/brandomiranda/2026/04/27/embrace-ai-or-be-left-behind.html) — you don't get to opt out, and the only question is whether you're positioned to benefit. Positioning isn't one grand decision. It's a thousand small, thoughtful adaptations to how you actually work, and a lot of them are unglamorous. Making your agents tap you on the shoulder when they're done — and tag themselves so you know which one — is one of the unglamorous ones. It cost me an afternoon of settings-spelunking and gave me back hours of unfragmented attention and the ability to run my work in parallel instead of in series.

The people who win the next few years won't be the ones who refused the tools, and they won't be the ones who outsourced their judgment to them. They'll be the ones who figured out, in a hundred small ways, how to keep their attention on the part that's still theirs — and let the machines handle the waiting.

Don't watch the spinner. Let it call you.

---

## Appendix: the Claude Code prompt I ship these with

I write the post, then hand publishing to Claude Code. The prompt I reuse, more or less verbatim:

```
You are publishing a new post to my Jekyll blog (this repo).
The post file is already in _posts/. Do the following and stop when the build is green:

1. Read _config.yml (and any CONTRIBUTING/README) to confirm post conventions:
   permalink format, required front-matter keys, and how categories/tags are used.
2. Reconcile this post's front matter to match the other posts in _posts/
   (same keys, same date/permalink scheme).
3. Fix the self-citation URL in the BibTeX block to the real permalink
   Jekyll will generate for this post.
4. If the site has a hand-maintained index (a "Selected Writing" list, blog
   archive page, or RSS include), add this post there too.
5. Run `bundle exec jekyll build` and fix any liquid/build errors.
6. Create a branch, commit with a clear message, and open a PR
   (or push to main if that's this repo's flow). Print the PR/commit link.
```

Fitting, given the post: the thing that frees my attention is the same thing that ships the post about freeing my attention. I fire that prompt, switch to the next task, and wait for the ntfy buzz that says it's done.

---

*If you'd like to cite this post:*

```
@misc{miranda2026spinner,
  author = {Miranda, Brando},
  title  = {Don't Watch the Spinner: How a 'Done Thinking' Notification Makes You Less Dumb},
  year   = {2026},
  month  = {June},
  howpublished = {\url{https://brando90.github.io/brandomiranda/2026/06/16/dont-watch-the-spinner.html}},
  note   = {Blog post}
}
```

## Brando Miranda

- Brando Miranda
- <brando9 {at} stanford . edu>

- [brando90](https://github.com/brando90)
- [BrandoHablando](https://www.twitter.com/BrandoHablando)

The views and opinions expressed on this site are strictly those of the author and do not reflect the views or opinions of any entity I am affiliated or have been affiliated -- nor any past, present, or future clients/employers.
