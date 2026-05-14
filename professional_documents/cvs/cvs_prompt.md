# Prompt: Excellent Academic CV

## Use

Given a target audience (fellowship application, faculty job, industry research role, conference reviewer profile, etc.), produce or revise an academic CV that matches the structural and stylistic standard set by strong Stanford CS faculty.

Two local PDFs serve as the prototypes — **open and skim them before writing.**
**Structural prototypes (Stanford CS faculty — copy patterns from these):**
- `example_cvs/cfinn_cv.pdf` — Chelsea Finn (Stanford CS, ML/robotics; awards-heavy, deep advising tree, talks-heavy)
- `example_cvs/clark_b_cv.pdf` — Clark Barrett (Stanford CS, formal methods/SMT; tool-builder, deep professional service)

**Peer calibration files (Stanford PhD-stage; for length/density signal, NOT structural patterns):**
- `example_cvs/cv_eric_mitchell.pdf` — Eric Mitchell (Stanford PhD → OpenAI; 3pp PhD-student CV)
- `example_cvs/Rylan_Schaeffer_Resume_2023.pdf` — Rylan Schaeffer (Stanford PhD; labelled a *Resume*, industry-job-search artifact — not a full academic CV)

When uncertain about a section's structure, density, or tone, copy these two.

---

## Core principles (the few rules that matter most)

1. **Every honor gets a 1-line prestige frame.** Don't just list "NSF CAREER Award" — add the rarity. The reader cannot be assumed to know how selective each award is.
   - Finn: `NSF CAREER Award — Supports early-career faculty who have the potential to serve as academic role models in research and education.`
   - Finn: `Schmidt Sciences AI2050 Early Career Fellow — Awarded to 19 early career researchers in AI.`
   - Finn: `ACM Doctoral Dissertation Award — Awarded to one doctoral dissertation in computer science and engineering, worldwide.`

2. **Every paper-tied award names the paper.** Connect the prize to the artifact.
   - Finn: `NeurIPS Outstanding Paper Runner Up. For "Direct Preference Optimization: Your Language Model is Secretly a Reward Model".`
   - Finn: `ICRA Best Paper Finalist. For "RoboCrowd: Scaling Robot Data Collection through Crowdsourcing".`

3. **Every advisee gets a placement.** A bare name list is wasted real estate; with placements, the list becomes mentor-pipeline impact.
   - Finn: `Eric Mitchell (now research scientist at OpenAI)`
   - Finn: `Frederik Ebert (now founder & CEO of Emancro)`
   - Finn: `Huaxiu Yao (now assistant professor at UNC)`
   - Or named-with-thesis (Barrett): `Makai Mann, "Augmenting Transition Systems for Scalable Symbolic Model Checking," Stanford, 2021.`

4. **Categorize publications.** Never one flat list. Standard splits: *Conference Publications / Journal Articles / Refereed Workshop Publications / Book Chapters / Technical Reports / Patents.* Number within each. Most-recent-first.

5. **Systems / artifacts get a section if you build software.** Tool name, URL, status.
   - Barrett: `cvc5: An open-source SMT solver. Available at http://cvc5.github.io.`
   - Barrett: `Marabou: An open-source verifier for neural networks.`

6. **Right-aligned dates** create scannability — reader can sweep the right edge for chronology.

7. **Plain text. Minimal decoration.** No colors, no boxes, no icons, no LinkedIn-style emoji, no photos. Bold/italic reserved for venue names, award names, and your own name in author lists.

8. **Active voice. No first person.** The CV is implicitly about you; "I" is noise.

---

## Recommended section order

### PhD student / postdoc (Brando's current stage)
1. Header (Name · Address · Email · Website · GitHub/Scholar links)
2. Research Summary or Research Interests (3–6 lines, audience-tunable)
3. Education
4. Coursework (drop once on faculty)
5. Research Experience
6. Publications (categorized)
7. Honors and Awards
8. Teaching
9. Invited Talks (if any)
10. Professional Activities (reviewing, PCs, organizing)
11. Industry Experience (consulting / internships, if relevant)
12. Outreach / Service / Leadership

### Faculty (Barrett / Finn pattern)
1. Header
2. Positions / Appointments
3. Research Interests (Barrett: tagged keywords)
4. Education
5. Research Group / Advising (Postdocs / PhD / Graduated PhD / Masters / Undergrad / Independent — each with placements)
6. Honors and Awards (split *Personal / Systems* if you build systems — Barrett's pattern)
7. Systems Under Development (Barrett)
8. Previously Developed Systems (Barrett)
9. Publications (categorized, numbered)
10. Teaching (Instructor / TA, with terms taught)
11. Invited Talks (selected)
12. Tutorials
13. Professional Activities (Steering / Program Chair / Program Committee / Referee / Departmental)
14. Industry Experience
15. Patents

---

## Section templates with concrete examples

### Header
Minimal. Name + address + email + website. No "Objective" or "Summary of Qualifications" — those are LinkedIn artifacts and never appear in faculty CVs.

```
Chelsea Finn
353 Jane Stanford Way
Stanford, CA 94305
cbfinn@cs.stanford.edu
http://ai.stanford.edu/~cbfinn
```

### Research Interests (Barrett-style keyword line)
A single dense sentence of tagged areas — used by program committees and search engines to triage you.
```
Automated reasoning; satisfiability modulo theories (SMT); formal methods; formal verification;
verification of smart contracts; verification of neural networks; AI safety; security; hardware
design productivity and verification.
```

### Research Summary (PhD-student-style — Brando's existing pattern, audience-tunable)
3–6 sentences naming your main thread, your top 3–5 named artifacts (benchmarks, models, tools, papers), and the adjacent threads that inform the main one. Lead with the angle your audience cares about most.

### Education
Always include school, year(s), degree, advisor, thesis title. Drop GPA once past PhD admissions.

Barrett (compact):
```
Ph.D.: Stanford University, 2003, Computer Science. Advisor: David L. Dill.
Thesis Title: Checking Validity of Quantifier-Free Formulas in Combinations of First-Order Theories.
```

Finn (block):
```
University of California, Berkeley, PhD                                                 2014 – 2018
Thesis: "Learning to Learn with Gradients".
Department of Electrical Engineering and Computer Science
```

### Honors and Awards
Reverse-chronological. Year right-aligned. **1-line prestige frame** below each award the reader might not immediately recognize.

```
Schmidt Sciences AI2050 Early Career Fellow                                                   2024
Awarded to 19 early career researchers in AI.

NeurIPS Outstanding Paper Runner Up                                                           2023
For "Direct Preference Optimization: Your Language Model is Secretly a Reward Model".

ICRA Best Conference Paper                                                                    2023
For "Open X-Embodiment: Robotic Learning Datasets and RT-X".

NSF CAREER Award                                                                              2023
Supports early-career faculty who have the potential to serve as academic role models
in research and education.

ACM Doctoral Dissertation Award                                                               2019
Awarded to one doctoral dissertation in computer science and engineering, worldwide.
```

For systems/tool prizes (Barrett pattern, more compact — no separate frame line when the venue full name is enough signal):
```
Best SCP Tool Paper, International Conference on Tools and Algorithms for the Construction and
Analysis of Systems (TACAS), 2022.
CAV Award, 2021.
Test of Time Award, Conference on Logic in Computer Science (LICS), 2021.
```

**Frame test:** if a reader outside your sub-field might not know how prestigious it is, frame it. NSF CAREER → frame. NeurIPS Outstanding → frame. Generic departmental scholarship → frame or drop.

### Advising / Research Group
Tier the list, give placements, name names.

Finn style (placements as parenthetical):
```
PhD research:
Frederik Ebert (now founder & CEO of Emancro)
Tianhe Yu (now research scientist at Google Brain)
Eric Mitchell (now research scientist at OpenAI)
Annie Xie (now research scientist at Google DeepMind)
```

Barrett style (graduated with thesis title):
```
Graduated Ph.D. Students:
  • Makai Mann, "Augmenting Transition Systems for Scalable Symbolic Model Checking," Stanford, 2021.
  • Andres Nötzli, "Towards Better Simplifications in SMT Solvers with Applications in String Solving,"
    Stanford, 2021.
```

Rule: if graduated, the placement (or thesis) is the line's payload. Bare names without placements waste a line.

### Publications
Numbered, categorized, most-recent-first inside each block. Format: `(N) Authors. Title. Venue, Year.` For papers with awards or press, add a short note.

```
Conference Publications
  (1) Matan Ostrovsky, Clark Barrett, and Guy Katz. An abstraction-refinement approach to verifying
      convolutional neural networks. In CAV 2024.
  (2) ...

Journal Articles
  (1) ...
```

For named papers with media coverage, follow the title with the recognition:
```
(N) R. Schaeffer, B. Miranda, S. Koyejo. Are Emergent Abilities of Large Language Models a Mirage?
    NeurIPS 2023 Outstanding Main Track Paper & Oral.
    Featured in: New York Times, Quanta Magazine, Forbes, Stanford HAI.
    Cited in the 2024 Economic Report of the President.
```

### Teaching
Split into Instructor and Teaching Assistant. Format: `<Course code> <course name>                              <Terms>`. For multi-term courses, stack terms with hanging-indent continuation.

```
Instructor
Stanford CS330: Deep Multi-Task and Meta Learning                    Fall 2019, Fall 2020, Fall 2021
                                                                              Fall 2022, Fall 2023
Stanford CS224R: Deep Reinforcement Learning                         Spring 2023, Spring 2025

Teaching Assistant
Berkeley CS188 Introduction to Artificial Intelligence                                Spring 2015
```

### Invited Talks (selected)
Title (no italics needed) on its own line, then venue + month/year. For repeat talks group under one title:

```
Generality and Dexterity in Robot Learning.
Massachusetts Institute of Technology. October 2023.
Boston Dynamics AI Institute. October 2023.
Bay Area Robotics Symposium. October 2023.

Why Robots Should Learn in the Real World.
International Conference on Robotics and Automation (ICRA) Keynote. May 2023.
```

Flag *keynote*, *plenary*, *distinguished seminar* when applicable — those carry weight.

### Professional Activities
Subsections in this order: Steering Committee / Program Chair / Program Committee / Referee / Departmental Service / Other.

Format: venue full name + acronym, year(s), role.
```
Steering Committee
  FMCAD: Conference on Formal Methods in Computer-Aided Design, 2019-present.
  SMT: International Workshop on Satisfiability Modulo Theories, 2009-2012, 2014-2018.

Program Committees
  CAV: International Conference on Computer Aided Verification, 2006, 2008, 2009, 2016, 2018, 2021.
  CADE: Conference on Automated Deduction, 2017, 2019.
```

For reviewer recognitions (Brando: ICML 2026 Silver Reviewer), add the recognition inline:
```
ICML 2026 (International Conference on Machine Learning) reviewer — Silver Reviewer designation
(top reviewer recognition).
```

### Industry Experience
For each role: company, dates, title, host (if visiting/consulting), 1-line scope.
```
Amazon, 2023 – present. Amazon Scholar (Robert Jones, host). Consulting on uses and applications of
automated reasoning tools.

Google, 2015 – 2017. Visiting Scientist (Domagoj Babic, host). Using SMT to find security
vulnerabilities.
```

---

## What to drop / avoid

- **Skills sections that list "Python, C++, Git, LaTeX".** At PhD-and-above level, programming literacy is assumed. Keep ONLY domain-specific tools that signal expertise (Lean 4, Coq, CUDA kernels, SMT solvers, formal-methods stack).
- **Photos, age, marital status, national ID.** None of those appear on faculty CVs in this culture.
- **"Objective" or "Summary of Qualifications" paragraphs.** LinkedIn artifact. Replace with Research Summary / Research Interests.
- **Long job descriptions for positions older than 5 years.** Collapse to 1 line.
- **Bullet hierarchies more than 2 deep.** If you're nesting three levels, you're losing the reader.
- **Bold/italic everywhere.** Reserve for venue names, award names, and your own name in author lists.
- **Color, borders, icons, decorative dividers.**
- **Inconsistent date formats.** Pick one (`Sept. 2022`, `September 2022`, or `2022–2026`) and stick to it across the whole document.
- **Hyperlinked everything in print PDFs.** Hyperlink only what truly serves the reader (paper arXiv link, project site, video). Avoid hyperlinking the institution name on every line.

---

## Audience-tailoring (use sparingly, never via multi-file forks)

For a specific application (fellowship / faculty / industry research), you MAY:
1. Reorder Coursework so the most audience-relevant courses are top-left (most prominent in a multi-column block).
2. Lead Research Experience bullets with the most audience-relevant work; keep the others, just demote.
3. Add or rewrite the Research Summary to lead with the audience's language.

You MUST NOT:
1. Maintain multiple CV variants by file-suffix (`_harmonic`, `_llm`, `_industry`). Variants drift; recruiters notice. Keep one canonical CV per length (`cv_long.tex`, `cv_short.tex`) and reorder in place.
2. Hide truthful but less-relevant content. **Reorder, don't omit** — except for items that have become structurally irrelevant (e.g., dropped courses that lost a row).

---

## Tone in prose lines (Research Summary, bullet items, etc.)

- Active voice. Past tense for completed work; present for ongoing.
- "Lead/co-lead on Lean 4 benchmarks: Putnam-AXIOM (ICML 2025), VeriBench (ICML AI4Math 2025)..." beats "I was the lead author on a paper called Putnam-AXIOM which..."
- No first person. No "I". The CV is implicitly about you.
- Name your artifacts as objects: `\textit{Putnam-AXIOM}`, `\textit{Moogle.ai}`, `\textit{Morph Prover v0-7B}`. They live in the reader's head longer than verbs.
- Lead each bullet with the strongest noun: an artifact name, a venue, a number, a recognition.

---

## Final pre-submission checklist

- [ ] Every award has a 1-line prestige frame OR is universally famous (NeurIPS Best Paper, Turing Award level).
- [ ] Every paper-tied award names the paper.
- [ ] Every advisee has a placement (or is current).
- [ ] Publications are categorized and numbered.
- [ ] Dates are right-aligned and the format is consistent throughout.
- [ ] No "I" / no "objective" / no skills-soup.
- [ ] First page communicates *what you do and why it matters* (Research Summary / Research Interests).
- [ ] If a venue cap exists (fellowship: 2–10 pp; industry: 1–2 pp), the doc fits within it. Faculty CVs have no cap.
- [ ] PDF regenerated from `.tex`; mtime of PDF > mtime of .tex.

---

## Dual-CV update rule (this repo)

This repo keeps **two canonical CVs in parallel**: `cv_long.tex` / `cv_long.pdf` (full) and `cv_short.tex` / `cv_short.pdf` (compact). The dual-update rule:

> Whenever you edit one CV, propagate the change to the other **where appropriate**.

| Change type | Long | Short |
|---|---|---|
| New award / honor | yes | yes (top of list) |
| New invited or contributed talk | yes (dedicated Talks section, full title) | yes (compact bullet) |
| New media mention | yes | yes |
| New advisee | yes | only if role is significant |
| New publication | yes (Publications) | only if strong enough for Selected Publications |
| Reframed Research Summary / Research Interests | yes | yes (mirror, possibly trimmed) |
| Coursework reorder | yes | n/a (short has no Coursework) |
| Full poster list, internship presentations | yes | n/a |

After every `.tex` edit, **immediately** rebuild the matching PDF and commit both.

This rule is also enforced in `CLAUDE.md` and `AGENTS.md` at the repo root.

## Local files and toolchain

- **Canonical sources:** `cv_long.tex` / `cv_long.pdf` (long), `cv_short.tex` / `cv_short.pdf` (short). Both in this directory.
- **Reference PDFs:** `example_cvs/cfinn_cv.pdf`, `example_cvs/clark_b_cv.pdf` (structural prototypes); `example_cvs/cv_eric_mitchell.pdf`, `example_cvs/Rylan_Schaeffer_Resume_2023.pdf` (peer calibration).
- **Build:** `latexmk -pdf -interaction=nonstopmode cv_long.tex` (or `cv_short.tex`) from inside this directory. Aux files (`.aux`, `.log`, `.out`, `.toc`, `.fls`, `.fdb_latexmk`, `.synctex.gz`) are gitignored; `.pdf` is committed.
- **Rule:** every `.tex` edit triggers an immediate rebuild — the Cursor preview should always reflect the latest source.
