---
layout: post
title: "How Do People Write Research Papers in the Agentic Era? I Asked My Lab"
date: 2026-06-09
section: meta-research
published: false
---

*Brando Miranda — June 2026 · ~6 min read*

**Warning: this post is a draft — content may change and errors may remain.**

**TL;DR.** I'm finishing VeriBench and I genuinely can't tell whether perfecting the prose is still worth it when many readers — human and agent — will only ever see a compressed version of the paper. So I asked my lab what they're converging to. Nobody defended the fully hand-crafted paper, and nobody defended the fully delegated one; the real disagreement is where scarce human attention should go. My synthesis after the discussion: polish what determines interpretation (title, abstract, intro, figures), verify what determines truth (claims, numbers, limitations — ideally with agents fact-checking the paper against the code), and write the body so that compression preserves the contribution. And the one rule nobody disputed: you own what you ship, no matter who drafted it.

---

I used to write papers sentence by sentence. For [Beyond Scale](https://arxiv.org/abs/2306.13840) I sat with each sentence until it felt right — sometimes pair-writing with a coauthor in the same document until a paragraph finally clicked. Those sessions are some of my fondest memories of that project.

Last week I was rereading the VeriBench draft and the old instinct wouldn't fire. My workflow has changed: the paper lives in the same GitHub repo as the code (I dropped Overleaf entirely — for me it adds friction for no benefit), the writing happens in tandem with the experiments, and agents draft large parts of it. Rereading it now, I can see the writing could be better — but honestly, marginally. Nothing is false. Nothing is hallucinated. It's a tiny bit more verbose than my favorite version, or not said exactly my way.

So what is that last afternoon of polish actually buying, when I suspect many readers will skim, or paste the PDF into an agent and read the TL;DR? I posted the question to my lab: what are people converging to?

## My opening bid: perfect the abstract, verify the rest

My position going in: perfect the title, abstract, and intro — curate every sentence there, because that's what people actually read — and hold the rest to *accurate*, not *beautiful*. Skim the technical sections for correctness. Let an agent write the appendix, then skim it so nothing is false. Spend the recovered time on the next project.

One thing I had to make explicit: for me, "perfect" does not mean "the AI didn't draft it." It means I curated each sentence. I'm a second-language English speaker; my writing taste isn't my forte, and AI drafting genuinely produces better English than I do alone. The hand-crafted-prose ideal quietly assumes a native speaker's relationship to the language.

## The purist: draft by hand, polish with AI

The first pushback, from Dan, was the purist position: if you care about the writing carrying *your* taste, the AI cannot give you the initial draft. Write it yourself, then polish with AI paragraph by paragraph. The draft is where the taste lives; polish is just sanding.

I think that's right *if* taste is what you're optimizing. It's just not my bottleneck — correctness is. I don't want a single hallucinated claim in anything I ship. Dan's (only half-joking) answer: go build the project that verifies prose sentence-by-sentence. Using Lean.

He knows my weakness. That is, more or less, [my research agenda](/2026/04/22/formal-methods-scalable-oversight.html) — and the honest state of the art is: some day. For now there is no verifier for "this paragraph faithfully describes the experiment," so the human reads most sentences. The bottleneck of writing in the agentic era isn't generation. It's verification.

## The inversion: agents as fact-checkers, not writers

Allen runs the workflow I find most interesting, because it inverts the framing. He's happy to let an agent *write* the experiment section — but the move he swears by is making the agent *read the code and fact-check the paper*. It has caught real errors, written by humans: places where the paper described what the code used to do before someone changed it, or what a coauthor remembered the code doing rather than what it does.

That failure mode — paper-code drift — is endemic and nearly invisible to human proofreading, because the prose reads fine. It's exactly the kind of cross-artifact consistency check agents do far better than we do. (My follow-up to Allen: does this mean you still write the *code* manually? Because I mostly don't anymore either — the "human-written" boundary is blurring on every artifact at once, not just prose.)

## The non-negotiable: you own what you ship

Sanmi's take set the frame the rest of the discussion sat inside. Three points. First, the top end is responsibility: you are accountable for whatever you send out, no matter how it came about. Second, respect the venue: some are now explicit about disclosure or non-use of AI writing. Third, AI prose has a recognizable style with real social costs — some readers will simply discard a paper they decide is AI-generated, and he counts himself on the liberal end of a field with strong opinions.

The venue point is no longer hypothetical: [NeurIPS 2026's Position Paper Track now requires papers be substantially human-written](https://x.com/neuripsconf/status/2061810551580217476), with AI restricted to copy-editing. Whatever you or I converge to privately, venues are starting to draw lines — and a workflow that can't adapt per-venue is a liability.

## The reframe I keep thinking about: write for faithful compression

Andrew landed somewhere subtly different from me, and I think he's onto something. Agents reduce the ROI of polishing every sentence, yes — but that doesn't license "accurate enough for an agent to summarize." The target shifts from sentence-level beauty to **robustness**: a paper that is easy for humans to read, easy for agents to summarize, and hard for either to misinterpret. Explicit claims, clean structure, well-scoped evidence, clear limitations — so that when the paper inevitably gets compressed, the compression preserves the actual contribution instead of producing a generic TL;DR.

That reframes the body sections. They don't need to be beautiful; they need to be *compression-stable*. And Kirill added the boundary condition: some things are still described better by a human with a good mental model than by an agent with the code — the parts where the insight isn't in any artifact an agent can read.

Andrew's other point stuck with me too: the few people who do still read every sentence — reviewers, close readers, the people building on your work — are disproportionately the people whose judgment matters most. Prose quality is no longer a mass-market feature. It's a feature for your most important readers.

## Where I land now

The discussion moved me from "perfect the top, skim the rest" to something more specific:

1. **Polish what determines interpretation.** Title, abstract, intro, main figures and captions — curated sentence by sentence, by me. This is unchanged.
2. **Verify what determines truth.** Claims, numbers, limitations, related-work characterizations. Slow human scrutiny, plus Allen's move: agents adversarially fact-checking the paper against the code and data, continuously, in the same repo.
3. **Write the body for faithful compression.** Explicit claims, scoped evidence, clean structure. Not beautiful — robust. Misinterpretation-resistant for humans and agents alike.
4. **Know your venue.** Disclosure norms and human-written requirements are diverging; check before you draft, not after.
5. **Own everything.** The provenance of a sentence is not an excuse for it.

Nobody in the thread defended the fully hand-crafted paper. Nobody defended the fully delegated one. The entire disagreement is about where the human attention goes — taste at the draft (Dan), verification at the artifacts (Allen), responsibility at the boundary (Sanmi), robustness in the body (Andrew).

## The question, transformed

I opened by asking whether people are converging. We are — just not on prose. We're converging on *attention allocation*: polish what determines interpretation, verify what determines truth, and let agents fill the space in between under human responsibility.

At some point in the thread the conversation drifted to the fact that I don't even hand-write my text messages anymore, and Dan asked what happens to the true Brando if everything gets buried under Claude. The answer I gave is the answer for papers too: the true version shows up where the bandwidth is highest. In person, for friends. In the title, abstract, intro, and claims, for readers. The rest was never really where I lived.

{% comment %}
Draft provenance & pre-publish checklist:
- Source: lab Discord/Slack thread, 2026-06-08/09 — raw transcript at experiments/11_how_do_ppl_write_research_papers_in_agentic_era/pre_prompt.md
  (same thread as: https://discord.com/channels/488822282664280084/489073286945308672/1509712459395629268)
- Supersedes _drafts/2026-05-29-writing-in-the-era-of-agents.md (solo-essay version written before the lab replies arrived). Merge or retire that file at publish time.
- [TODO: get consent from Dan, Allen, Sanmi, Kirill, Andrew (Zhanke) before publishing — names + paraphrases of a private lab channel. Decide first-name vs full-name per person.]
- [TODO: verify the NeurIPS 2026 Position Paper Track policy link/wording against the official blog post before publish.]
- [TODO: confirm keeping the texting/true-Brando anecdote in the close — it paraphrases a jokey private exchange.]
- [TODO: read-time estimate is ~6 min at ~1,250 words; recompute after revisions.]
{% endcomment %}
