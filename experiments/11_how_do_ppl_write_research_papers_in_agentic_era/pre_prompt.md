# 11_how_do_ppl_write_research_papers_in_agentic_era

ref: /Users/brandomiranda/brandomiranda/experiments/11_how_do_ppl_write_research_papers_in_agentic_era

draft a blog for this in the style of  my blog. But don't make it public yet. It's a draft


```Dan
Brando
—
9:37 AM
curious to hear your thoughts dan
Want to open this discussion to the lab. As I finish one my my fav projects (bet most of you have heard of VeriBench...maybe too many times!) I wonder what the right protocol/habit is for writing in the era of agents. I now put my papers on my github repos (don't use overleaf at all; I think it adds friction for no benefit -- for me) and I do the writing in tandem with my experiments. Before agents eg for my beyon scale paper -- I crafted each sentence to perfection (sometimes even pair programming/writing with my coauthors eg I remember fondly a time I did this with alycia). I'm reading and edit it now and I see the writing could be improve but honestly think marginally. So now I can't tell if this extra time is worth perfecting the writing or honestly moving on to the next project. Nothing is false or hallucinated. Just a tiny bit more verbose perhaps or not said my favorite way. I think my new workflow will move to only perfecting the title, abstract and intro (assuming that's what people read). And making sure nothing is false/hallucinated + the discussion/weakness section is accurate. I find it hard to motivate myself to perfect my prose as I used to when people will either (which are asumptions of course): not read it dump it to an agent and only read the agent's tldr. I'm curious what people are converging to. Are ppl converging to this?
Dan
—
9:42 AM
who is alycia
i think if you care about perfection in writing, and wanting the writing to have your personal taste, you shouldn’t use AI at all to give you the initial draft
You should write it manually, and go polish it using AI paragraph by paragraph
Brando
—
9:45 AM
personally I just don't want it to be hallucinated. I care about correctness
as a 2nd language english speaker. My writing taste isn't my forte
Dan
—
9:46 AM
Go do a project to verify correctness (no hallucination) sentence by sentence
Using Lean
Brando
—
9:47 AM
lol
I wish
some day
for now...I think I have to read most sentences...
I think I converged to
1 --> abstract perfect 2 --> intro perfect
the rest just accurate/correct
so skimming no rewriting is fine
perfect != AI doesn't draft it. It means I curate each sentence
since my english isn't great/prefect -- using AI for me personally always results in better writing
thanks for engaging!
this was helpful
Dan
—
9:50 AM
https://x.com/neuripsconf/status/2061810551580217476?s=46
NeurIPS Conference (@NeurIPSConf)
This year, the NeurIPS 2026 Position Paper Track made the decision to require that all papers be substantially human-written, with AI used for only copy-editing or similar peripheral changes to the main text!
For more details, please check our blogpost: https://t.co/wrWuMQJwrx
X•6/2/26, 7:01 AM
did u see their blog post?
Brando
—
9:50 AM
our paper is fine 
Dan
—
9:51 AM
i wasn’t saying we should be worried
their numbers were interesting
Brando
—
9:52 AM
I mean...I don't even write my texts to my gf myself...
Dan
—
9:53 AM
what happens to the true brando then
Brando
—
9:53 AM
they get it in person
Dan
—
9:53 AM
it’s getting buried under claude
Brando
—
9:53 AM
and I get laid
texting sucks
love claude
Dan
—
9:53 AM
looks like brando got laid recently
Brando
—
9:53 AM
Id use it more if I knew how
I wish
no
Dan
—
9:54 AM
Allen
ainie [GPU],  — Yesterday at 9:56 AM
I think this is quite interesting. 
I think I’m happy to let agent write experiment section
I ask agent to read my code and fact check my appendix and main paper’s experiment section
The agent found a few errors that I wrote or my coauthors wrote about how the code works
These errors happen bc we either forgot what’s in the code or just haven’t updated the paper when we changed the code
I think this is something agents can do far far better than us
Brando — Yesterday at 9:58 AM
does this mean you write code manually? Like tbh I don't much anymore
for me what I converged is similar to you I think
I perfect abstract and intro -- so I curate every sentence there; since a lot of ppl with read it + title
the rest I just skim to make sure it's accurate + ask an agent to catch the first mistakes
appendix fully written by agent but I skim that nothing is false/hallucinated ie skim
thanks for engaging!
Sanmi
sanmi
—
10:02 AM
This is fascinating. The top end for me is that you are responsible for whatever you write and send out, no matter how it came about. You should also respect the venue's wishes; some are clear about whether to disclose or not use AI for writing. One more is that AI writing tends to have a style that can be unpleasant to read, and there are some social costs to papers like that (including people ignoring papers that they decide are AI-generated) Beyond that, I am personally flexible on AI writing. I think I am on the liberal end though; most of the field seems to have strong alternative opinions
Kirill Acharya 
— Yesterday at 11:14 AM
Very interesting
I think you’re right Brando
Noticed the same
But at the same time some things could be better described by a human if he/she has a good mental model
Andrew Zhanke Zhou 
— 1:27 AM
I’m pretty sympathetic to this, but I think I land in a slightly different place. I do think agents reduce the ROI of polishing every sentence to perfection, especially in parts of the paper that are mostly mechanical. But I don’t think this means the main body can just be “accurate enough for an agent to summarize.”
My guess is the target shifts from sentence-level beauty everywhere to robustness: the paper should be easy for humans to read, easy for agents to summarize, and hard for either to misinterpret. That still requires careful human revision of the core technical sections, not just the title/abstract/intro. A good abstract is still important, but “writing for agent summarization” might mean making the whole paper have explicit claims, clean structure, well-scoped evidence, and clear limitations, so that compression preserves the real contribution rather than producing a generic TLDR.
I also still think beautiful prose matters. Maybe fewer people read every sentence, but the people who do are often the people whose judgment matters most: reviewers, close readers, future collaborators, and people trying to build on the work. So I’d probably use agents aggressively for first drafts from code/data/results, but still spend human effort on shaping the narrative, polishing the title/abstract/intro, and revising the main content so it is genuinely good for human readers.``` eg https://cs.stanford.edu/people/brando9/|
```