# Rebuttal Playbook — source (verbatim)

Dictated by Brando from the NeurIPS 2026 Position Paper Track cycle, incorporating advisor and
co-author feedback. Source chat: `https://claude.ai/chat/b152028d-b27c-4f83-ac0d-4bb84a1fb2c8`.
Preserved as-is (including original typos) so downstream artifacts stay traceable.

---

Rebuttal Playbook
Heuristics for writing conference author responses. Derived from the NeurIPS 2026 Position Paper Track cycle, incorporating advisor and co-author feedback.

Priority
Address the AC metareview first. It is the biggest lever: reviewers rarely revise scores, while ACs weigh the record holistically. Rebuttals are effectively written for the AC.
Then bias effort by score: lowest first, then the middling ones. Leave a strong accept mostly alone. Uniform accepts beat one strong accept plus a reject, and a low score makes the AC's job hard.
Write the AC comment last — it summarizes the reviewer threads. Mirror the AC's priorities in their order and numbering. End with an enumerated list of manuscript changes and their locations.
Stance — whether to concede
Never concede blindly. Concede only genuine errors or limitations the evidence establishes. Otherwise clarify, or point to what the paper already contains.
Before conceding a technical premise, verify it. Reviewer premises can be factually wrong — e.g. "weaker baseline" when the two methods are the same thing under different names.
When a reviewer names another unmeasured property as an alternative explanation, that is evidence for a reporting position, not against it.
Prefer calibrated refinement over dramatic retreat: "a clear change in observed behaviour, small in magnitude" rather than "we withdraw the claim."
Watch concession density with already-positive reviewers. A strong accept is lost by conceding so thoroughly the reviewer re-reads their own score, not by pushing back.
Stance — how to concede
The wording matters as much as the decision. "We concede two points outright", "we withdraw", "this is our error" give away more than the reviewer asked and make the paper sound broken. A co-author reading it will object before reaching the substance.
Concede the specific thing, never the category: "the word claims more than the numbers support, and we will change it" — not "the claim is unsupported."
Never volunteer self-criticism harsher than the reviewer's own framing. If they say two constructs are "connected but not the same", that is a precision request, not an accusation of error.
Cut intensifiers on concessions entirely: "outright", "without qualification", "entirely", "completely", "we were wrong". The unmodified verb is stronger and costs less.
Don't tell a reviewer where your worst weakness is ("this is the sharpest gap in the paper"). They scored it already; they don't need help.
Every concession states what changes and where in the manuscript. A concession without a consequence reads as evasion.
Pair every concession with what survives it, in the same section. Concede the wording, then state the finding that is unaffected.
Close on what survives, not on a tally of what changed.
Evidence
Every number traceable to a table, section, or line the reviewer can open. If a co-author cannot place it, neither can a reviewer.
Prefer facts already in the submitted PDF over anything generated during the rebuttal window. The best answers are often already in your own appendix tables.
Label post hoc comparisons as sensitivity checks, not controlled experiments. State n, and the exact p of a small ordering (a perfect ordering of three arises by chance at one in six).
Distinguish association from causation, and name the design that would identify it.
Pre-empt what a careful reviewer would find — including outlier rows in the very table you are citing — rather than letting them find it.
Results, not promises. Reviewers discount promised experiments heavily.
Do not cite your own adjacent unpublished or parallel paper. It breaks double-blind and invites a thin-slicing critique ("why is this two papers if the load-bearing evidence lives elsewhere"). Eat the scope gap instead.
Construction
Answer the question actually asked, not the adjacent one. "What is the consequence for an experimentalist?" needs concrete actions, not a mechanism.
Follow each reviewer's own weakness and question order (W1, W2, Q1...) so every item is visibly checked off.
Thank for strengths specific to that review, concisely. Generic praise of a thin review costs credibility.
When a reviewer supplies a good framing and asks you to make it explicit: adopt it, credit it in a clause, and add something of your own. Pure echo is a thank-you note.
Third person for all self-citation, always.
Don't pad to the character limit. Length is not the objective.
Avoid absolutes: "solves selection bias", "isolates X", "X causes Y", "method M wins".
Keep numbers and claims consistent across all threads. The AC is the one reader who sees them side by side.
Ask what would raise their score. Never ask for a higher score.
Voice — must not read as machine-written
Reviewers penalise LLM-sounding rebuttals, and some tracks ban AI-written author responses outright. Target: a tired expert writing carefully, not a press release.
Vary sentence length deliberately. A run of same-length balanced sentences is the strongest tell.
Cut the recurring frames: "not X, but Y", "It is worth noting that", "This is precisely why", "We would like to emphasise", "Importantly", "Furthermore", "delve", "leverage", "robust" as filler, "crucially".
Limit em-dashes to roughly one per section. Prefer commas, colons, or a full stop.
Cut triads used for rhythm rather than content ("clear, actionable, and testable").
Don't open consecutive paragraphs the same way ("We agree...", "We agree...").
Avoid symmetrical section openings. Real writers are uneven; one section being blunter than the others reads as human.
Concrete nouns and specific numbers over abstractions. "Table 7 gives -0.105" beats "the empirical evidence indicates".
Contractions in moderation help. A perfectly formal register throughout reads as generated.
Read it aloud before posting.
Sanity checks before posting
Does every weakness and question in the review have a visible answer?
Is every number in this response findable by the reviewer?
Have I conceded anything I have not verified?
Is any concession worded more strongly than the reviewer's own framing?
Would a co-author who knows the paper follow every claim?
Does this response end on what stands?
Strip LaTeX escaping, convert to markdown, check headers sit on their own line, check the character count, confirm nothing was truncated.
