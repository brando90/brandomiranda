# CBT blog: evidence volume, allegiance, and institutional bias

**Doc link:** <https://github.com/brando90/brandomiranda/blob/main/experiments/19_1st_pricinples_against_cbt/changes_due_to_bias.md>

**TLDR:** Added a section explaining why a large cognitive behavioral therapy (CBT) literature does not automatically establish superiority to other treatments or identify verbal cognitive restructuring as the active component. The revision distinguishes documented researcher-allegiance associations and publication bias from the separate, unverified claim that CBT researchers dominate peer review or guideline panels.

**Status, 11-08-2026:** Implemented in `_posts/2026-11-08-why-cbt-doesnt-make-sense-to-me.md`. The single requested Claude Fable 5.1 light quality-assurance review at maximum effort returned three minor fixes and no outstanding critical or major findings. The fixes have been reconciled; final release checks, publication, and the email asking Andrea to check the finished blog follow. The document address above remains the intended GitHub destination until pushed.

## 1. Editorial decision

The new section, **Why “so much evidence” does not settle it**, belongs after the clinical evidence and before the falsifiable prediction. This order matters: acknowledge that CBT helps before discussing reasons its reputation or evidence volume does not settle the mechanism argument.

The strongest defensible position is not “CBT is wrong despite all the evidence.” It is:

> The evidence supports benefits from CBT packages. It does not follow that CBT is universally superior, that the cognitive component is indispensable, or that its institutional standing is immune to bias. My learning-first hypothesis still has to face fair clinical tests.

The earlier learning-first revision remains intact: evolutionary ordering motivates a hypothesis rather than proving a treatment ranking; consequence learning and repetition-driven habits remain distinct; CBT's own behavioral methods are not erased. See [the main revision plan](changes_to_blog_plan.md).

## 2. Requested points and their treatment

| Point from the source notes | Action in the blog | Evidence boundary |
|---|---|---|
| “Most evidence” does not mean “best” | Separate evidence volume, package efficacy, comparative efficacy, and component mechanisms | More high-quality evidence can increase confidence; sheer volume does not measure comparative effect size |
| Bona fide therapies can have similar outcomes | Use the more recent, directly relevant Cuijpers 2023 depression review | A small advantage that is not robust across sensitivity analyses is not proof of equivalence or of equal efficacy across diagnoses |
| Researcher allegiance can affect comparisons | Define allegiance and cite Munder's overview of reviews | Association is not automatic proof of causal bias, misconduct, or a CBT-specific defect |
| Researchers may favor CBT yet CBT can retain an advantage | Include Tolin as counterevidence | Statistical adjustment does not remove every confound, but it prevents an unsupported “allegiance explains everything” conclusion |
| Publication bias can inflate apparent benefit | Use Driessen's recovery of actual unpublished trial results | Depression psychotherapies, not CBT alone; the pooled benefit remains positive; nonpublication does not identify reviewer rejection as the cause |
| CBT insiders may judge their own approach | State the institutional feedback-loop concern and attribute the committee-dominance argument to Leichsenring and colleagues | The paper is a critical review, not an independently coded panel-membership census; its authors disclose their own therapeutic commitments |
| An American Psychological Association board consists only of CBT practitioners | Do not assert it | No verified roster, orientation coding, or decision audit establishes that claim in the material checked |
| Most CBT trials are run by CBT-allegiant authors | Do not assert it as a field-wide statistic | Munder does not estimate that proportion; Tolin's study sample cannot establish it for all CBT research |
| Package efficacy does not isolate cognitive restructuring | Reconnect the section to exposure, behavioral practice, and the existing component evidence | Absence of explicit restructuring does not prove absence of cognitive change or identify habit formation as the mediator |
| CBT effects are steadily falling | Do not add the claim | The source notes already flag contested reanalyses; Cuijpers 2023 reports no reduction by publication year |
| The grievance-studies hoax demonstrates this problem | Omit the analogy | It is not evidence about CBT trials, psychotherapy journals, or guideline panels |
| What would make a fair test? | Add matched therapist expertise, preregistered outcomes, and independent investigators to the concluding proposal | Apply the same scrutiny to Brando's preferred learning-first explanation |

## 3. Checked sources and numerical scope

These are published findings, not new estimates. Digital object identifiers (DOIs) were matched to Crossref metadata. An abstract-level check is not represented as a full-text review. No new data collection, bootstrap analysis, or panel-orientation classification was performed.

### Cuijpers and colleagues, 2023: evidence volume versus superiority

[Cognitive behavior therapy vs. control conditions, other psychotherapies, pharmacotherapies and combined treatment for depression](https://doi.org/10.1002/wps.21069).

- **Access:** Indexed abstract checked. Full-text requests through Europe PMC and the National Center for Biotechnology Information's text service did not yield a usable full text in this check.
- **Overall scope:** 409 trials, 518 comparisons, 52,702 patients. These are the entire review's counts, not the denominator for the head-to-head psychotherapy contrast.
- **Versus control conditions:** Hedges' *g*, a standardized treatment difference, **0.79 [0.70, 0.89]**, with the authors' 95% confidence interval. Controls included care as usual and waitlist, not exclusively credible active therapies.
- **Versus other psychotherapies:** **0.06 [0.00, 0.12]**, reported as statistically significant in the main analysis but nonsignificant in most sensitivity analyses. The rounded lower bound should not be used to reverse the authors' stated significance result. The checked abstract does not give the exact p-value or the comparison-specific study and patient counts; the blog quotes neither a numeric contrast nor those denominators.
- **Use:** A large evidence base and strong control-condition effects do not establish a clear, general comparative advantage. Do not describe this as an equivalence trial.

### Munder and colleagues, 2013: researcher allegiance

[Researcher allegiance in psychotherapy outcome research: An overview of reviews](https://doi.org/10.1016/j.cpr.2013.02.002).

- **Access:** Indexed abstract checked.
- **Scope:** 30 meta-analyses; the authors report controlling overlap of primary studies.
- **Association:** Mean correlation **r = .262**, reported **p = .002** from a random-effects meta-meta-analysis of the allegiance–outcome association. The checked abstract does not provide the confidence interval or a complete test-statistic specification; none is reconstructed. Between-review heterogeneity was reported as **I² = 28.98%**.
- **Important qualification:** Allegiance toward the allegiance-bias hypothesis itself moderated the association. Scrutiny applies to critics too.
- **Use:** The blog reports the direction and scope, not a falsely precise causal estimate. This source does not count CBT-allegiant reviewers, guideline-panel members, or the proportion of all CBT trials run by CBT enthusiasts.

### Tolin, 2010: counterevidence to an all-bias explanation

[Is cognitive-behavioral therapy more effective than other therapies? A meta-analytic review](https://doi.org/10.1016/j.cpr.2010.05.003).

- **Access:** Indexed abstract checked.
- **Scope:** 28 articles representing 26 studies, 1,981 participants; comparisons retained treatments judged bona fide. The abstract says investigators' allegiance was obtained by contacting principal investigators.
- **Finding:** CBT outperformed psychodynamic therapy, but not interpersonal or supportive therapies, at post-treatment and follow-up. The abstract also reports a significant CBT advantage after controlling for allegiance ratings; superiority was evident only among patients with anxiety or depressive disorders.
- **Limit:** The abstract does not give the numeric adjusted estimate, its confidence interval, or exact p-value. The blog does not manufacture them or interpret this as universal CBT superiority. Statistical adjustment is not an experimental manipulation of allegiance.

### Driessen and colleagues, 2015: actual unpublished trials

[Does Publication Bias Inflate the Apparent Efficacy of Psychological Treatment for Major Depressive Disorder?](https://doi.org/10.1371/journal.pone.0137864).

- **Access:** Full-text methods, results, and Table 2 checked.
- **Scope:** Grants funded by the United States National Institutes of Health during 1972–2008. Of **55 grants that started trials**, **13 (23.6%)** did not produce publications. Two additional funded trials never started and were excluded from that denominator. Original data were obtained for 11 of the 13 unpublished studies, not all 13.
- **Psychotherapy versus control subset:** Published studies, **20**, **1,767 participants**, *g* **0.52 [0.37, 0.68]**; unpublished studies, **6**, **336 participants**, *g* **0.20 [−0.11, 0.51]**; combined, **26**, **2,103 participants**, *g* **0.39 [0.08, 0.70]**. Participant totals are the sums of the treatment and comparator counts in Table 2, not counts for all grant-funded comparisons.
- **Interpretation:** The combined point estimate was **25% lower** than the published-only estimate. The published-versus-unpublished subgroup comparison had **Q = 3.34**, one degree of freedom, **p = .07**; it should not be described as a statistically significant subgroup difference. The combined benefit against zero was reported with **Z = 2.47, p < .05**. These are different tests.
- **Limit:** Treatments included more than CBT; outcome-reporting bias could not be quantified. The result does not show that journal reviewers caused nonpublication: the paper's reasons-for-non-publication section reports that of the 13 unpublished studies only 2 were submitted for review (neither was accepted), 6 were never submitted, and for 5 it was unclear whether submission was attempted; the authors describe non-submission by investigators as the more common proximal cause. The blog now states this breakdown rather than a generic point about unsubmitted studies, and still does not turn the reduction into a CBT-specific correction factor.

### Leichsenring and colleagues, 2018: institutional concern, not a verified census

[“Gold Standards,” Plurality and Monocultures: The Need for Diversity in Psychotherapy](https://doi.org/10.3389/fpsyt.2018.00159).

- **Access:** Full text checked, including Introduction, Conclusions, and conflict-of-interest statement.
- **What it says:** The authors describe the American Psychological Association's Division 12 task force as primarily representing CBT researchers and later argue that many review, funding, and guideline committees are dominated by CBT researchers.
- **What it does not supply:** A systematically sampled and independently coded roster analysis establishing the broad committee claim, or a causal estimate of how committee composition changes recommendations. A statement in this paper is not proof that every member of an unspecified “APA board” practices CBT.
- **Competing commitments:** Several authors disclose psychodynamic practice, training, teaching, or publications; some also disclose training in CBT or other approaches. The blog notes this without treating their interests as a refutation.
- **Use:** Attribute the argument and retain the concern as a question to investigate. Do not repeat its committee, funding, or academic-chair percentages as independently verified measurements.

### Source-note leads not carried over as blog statistics

- **Cuijpers 2010:** [DOI](https://doi.org/10.1192/bjp.bp.109.066001), Crossref metadata and indexed abstract checked. The abstract reports **117 trials, 175 comparisons**, with the pooled psychotherapy effect reduced from **0.67 to 0.42** by a statistical publication-bias adjustment imputing 51 studies. The raw notes' **0.69 to 0.49** CBT-specific pair was not verified from that abstract; it may refer to a subgroup and is not declared false merely because it differs from the pooled result. Neither pair is imported as a universal CBT correction. Driessen is used in the blog because it recovered actual unpublished results rather than relying only on funnel-plot imputation.
- **Wampold 1997:** [DOI](https://doi.org/10.1037/0033-2909.122.3.203) verified against Crossref. No matching abstract was returned by the scoped Europe PMC query. The raw notes' approximate upper-bound difference is not repeated. The more recent Cuijpers review addresses the comparison without importing an unverified historical number or claiming that all treatments are equal.
- **Luborsky 1999:** [DOI](https://doi.org/10.1093/clipsy.6.1.95) and bibliographic identity verified against Crossref. No numeric finding is attributed to this paper without a checked abstract or full text; Munder supplies the reviewed allegiance finding.

## 4. Institutional evidence gap and what would close it

A targeted check attempted the official Division 12 treatment registry and its interpersonal- and psychodynamic-treatment pages; each returned an access-denied response. The American Psychological Association depression-guideline PDF address returned a small HTML response rather than the document. These responses provide no evidence about membership or treatment orientation. The full Leichsenring article and the indexed Tolin criteria metadata were also checked; neither substitutes for the missing roster audit.

A defensible audit would name a specific organization, committee, date, and recommendation process; collect its complete roster; code therapeutic commitments from direct professional records with room for multiple orientations; report disagreements and missing data; and examine decisions using stated criteria. Proving biased recommendations would additionally require evidence about how those decisions depart from the underlying evidence, not just a count of members' interests. This further study is not represented as completed or necessary to publish the narrower, qualified argument.

## 5. Review and publication checklist

- [x] Add the evidence-volume, allegiance, publication-bias, and institutional-concern section.
- [x] Include favorable CBT evidence and distinguish package effects from component mechanisms.
- [x] Preserve the learning-first argument, fair-test prediction, and Andrea acknowledgment.
- [x] Leave both raw source conversations unchanged and locally excluded from Git publication.
- [x] Complete the single requested independent light review of the expanded post and both change notes; resolve findings.
- [ ] Rerun citation, spelling, header, build, internal-link, and rendered-privacy checks on the final files.
- [ ] Inspect the staged diff, commit and push the public post and notes, and verify the live article.
- [ ] Email Andrea the finished link for her check, with delivery verification and the required private copies to Brando.

**TLDR-end:** [CBT blog: bias revision] The new section challenges the inference from evidence volume to superiority or cognitive-mechanism necessity. It treats allegiance and missing publications as evidence to scrutinize, not proof that CBT is ineffective or that its reviewers have been shown to control the field.
