# GLM-5.2 (z.ai) as a Claude Code backend — notes

**Date:** 2026-06-23
**Source:** A research group chat (3 participants; anonymized for public sharing).
**Status:** Idea / to-evaluate. Not yet tested.

> Anonymized for this public repo. A full, attributed version (with the verbatim transcript) is kept privately and is not committed.

## TL;DR
A colleague reports that **GLM-5.2** (z.ai, China) is a strong, cheap alternative to
Claude Opus that plugs directly into the **Claude Code CLI scaffold** — so all your
memories and settings carry over unchanged. They find it less lazy and more thorough
than Opus, and slightly deeper at problem-solving than Claude or Codex, though not as
good as the (now-retired) Claude Fable. They subscribe to z.ai on a "Max-like" plan and
flag a **cost hack**: z.ai's Claude-Code-integration endpoint is tied to subscription
usage (not pay-as-you-go), so it can double as a cheap endpoint for routine batch / API
data processing.

## What is GLM-5.2
- New LLM from **z.ai** (Chinese AI lab). Widely praised right now.
- Large: **~700B params** (one participant's estimate) → self-hosting generally infeasible.
- Take: *"surprisingly good (much better than Claude Opus), very cheap."* / *"Not as good as Fable but oh well."*

## Why a colleague prefers it (over Opus)
- *"Does what it says it will do, it's not lazy, and it doesn't give up."*
- Claude Opus was *"doing too much maddening hand-waving and incompleteness."*
- GLM's problem-solving seems *"marginally better and deeper than Claude or Codex"* (hadn't tested Codex extensively recently).

## How to use it
- **Subscribe** directly to z.ai, Max-like plan: <https://z.ai/model-api>
- **Claude Code integration is easy.** Router / switch libraries:
  - `claude-code-switch` — <https://github.com/foreveryh/claude-code-switch>
  - `claude-code-router` — <https://github.com/musistudio/claude-code-router>
- Integrates into the Claude Code CLI scaffold → keep all memories & settings "totally equivalently."

## The cost hack
- z.ai exposed a **special API to enable the Claude Code CLI integration**.
- That endpoint is a **free endpoint tied to your subscription usage** (NOT pay-as-you-go).
- So you can also hit it for **routine data processing / batch requests / general API tasks** → big savings.
- *"Like using an almost-Claude-Fable model for routine data-processing magic."*

## Downsides / caveats
- z.ai seems **GPU-limited**; during **peak windows they drain your usage quota faster**.
- Upside: peak windows ≈ China working hours → off-peak for US daytime users.
- One participant is considering dropping their Claude Max subscription.

## Considerations / open questions
- **ToS / acceptable-use check** — confirm z.ai permits using the CC-integration endpoint for general batch / API jobs before relying on it for data processing.
- **Data governance** — routing lab / research data through a third-party, China-hosted API; check lab / IRB data-handling constraints, especially for unpublished work.
- **CLI-scaffold fit** — GLM-via-`claude-code-router` fits a "use the CLI scaffold" philosophy; the "hit the endpoint for batch jobs" part edges toward direct-API usage — wrap it behind a self-throttling CLI layer if adopted.
- **Quality eval needed** — benchmark GLM-5.2 vs Opus / Codex on actual tasks (e.g., Lean/ATP, paper writing, agentic coding) before switching.
- **Reliability** — how stable is the free endpoint under sustained batch load? Rate limits?

## Action items
- [ ] Try GLM-5.2 via `claude-code-router` on a throwaway task; compare to Opus.
- [ ] Read z.ai pricing + ToS at <https://z.ai/model-api>.
- [ ] Decide keep-vs-drop on Claude Max after a week of side-by-side use.

---
*Generated from a group-chat discussion on 2026-06-23. Anonymized for public sharing; `make_deck.js` builds the summary slide deck.*
