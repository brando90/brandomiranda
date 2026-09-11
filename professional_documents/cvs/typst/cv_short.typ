// ============================================================================
// cv_short.typ — Typst draft port of professional_documents/cvs/cv_short.tex
//
// DRAFT: the LaTeX pair (cv_long.tex / cv_short.tex) remains canonical.
// Build:  typst compile cv_short.typ
//         (or `python3 build.py` if the typst binary is not installed)
// ============================================================================

#import "cv.typ": cv, section, dated, entry, pubitem, pubnum, venues, vlink

#show: cv.with(
  name: "Brando Miranda",
  email: "brando9@stanford.edu",
  location: "Stanford, CA 94305",
  address: "Gates Bldg., 353 Jane Stanford Way",
  links: (
    ("Google Scholar", "https://scholar.google.com/citations?user=_NQJoBkAAAAJ&hl=en"),
    ("Website", "https://cs.stanford.edu/people/brando9/"),
    ("X (formerly Twitter)", "https://x.com/BrandoHablando"),
    ("LinkedIn", "https://www.linkedin.com/in/brando-miranda-40821046/"),
    ("Stanford Profile", "https://profiles.stanford.edu/brando-miranda"),
    ("MIT CBMM Profile", "https://cbmm.mit.edu/about/people/miranda"),
  ),
)

// ============================================================================
#section[Research Interests]

AI for formal mathematics --- Lean 4 theorem proving, autoformalization, and
end-to-end formal verification of software and mathematics;
contamination-resistant evaluation of LLM mathematical reasoning; data-centric
machine learning for foundation and frontier models; alternative architectures
(e.g. energy-based models) toward Artificial General Intelligence (AGI).

// ============================================================================
#section[Education]

#entry[
  #dated([*Ph.D. in Computer Science*], [2022--2026 (expected)]) \
  #dated([_Stanford University_], [GPA: 4.045/4.0]) \
  *Advisor: Prof. Sanmi Koyejo, Stanford Trustworthy AI Research Group (STAIR).*
]

#entry[
  #dated([*Master of Engineering in Electrical Engineering and Computer Science*], [2014--2016]) \
  #dated([_Massachusetts Institute of Technology_], [GPA: 4.8/5.0]) \
  *Advisor: Prof. Tomaso Poggio, Center for Brains, Minds and Machines.* \
  Thesis Title: _Function Approximation with Deep Neural and Gaussian Networks_.
]

#entry[
  #dated([*Bachelor of Science, Computer Science and Engineering*], [2010--2014]) \
  #dated([_Massachusetts Institute of Technology_], [Minors: Mathematics, Music])
]

// ============================================================================
#section[Awards & Honors]

- *Inaugural Veritas Scholar, Math Inc.* (offered, declined; 2026) --- selected for frontier work in AI-assisted formalization and verified mathematics.
- *ICML 2026 Silver Reviewer* (May 2026) --- top reviewer recognition, signed by the ICML 2026 Program Chairs.
- *Oral Recommendation (Top 1)*, 2nd AI for Math Workshop \@ ICML 2025 --- for _VeriBench: End-to-End Formal Verification Benchmark for AI Code Generation in Lean 4_ (Miranda et al.); reviewer recommendation "Accept (Oral, Top 1)".
- *Pear AI Researchers Circle* (July 2025) --- selective AI-researcher network convened by Pear VC; invited following the final round (R3) of the Pear AI Researcher Grant program.
- *ICML Workshop on Trustworthy Multi-modal Foundation Models and AI Agents (TiFA) --- Outstanding Paper Award* (July 2024) --- for "Why Has Predicting Downstream Capabilities of Frontier AI Models with Scale Remained Elusive?" (Schaeffer, Schoelkopf, Miranda, et al.).
- *NeurIPS Outstanding Main Track Paper Award* (December 2023) --- top 0.4% of NeurIPS submissions; only 2 main-track papers selected. For "Are Emergent Abilities of Large Language Models a Mirage?" (Schaeffer, Miranda, Koyejo).
- *EDGE Scholar*, Stanford University (September 2022) --- Stanford fellowship supporting first-generation / low-income PhD scholars.
- *Stanford School of Engineering Fellowship* (September 2022) --- multi-year departmental fellowship for incoming engineering PhDs.
- *Honorable Mention*, Ford Foundation Predoctoral Fellowship (2020, 2021) --- national fellowship recognizing PhD applicants with potential to diversify the U.S. professoriate.
- *Best Research Project Award*, UIUC graduate course CS 598 "Learning to Learn" (December 2020) --- course-level award for the top research project.
- *HSF Scholar*, Hispanic Scholarship Fund (2020) --- competitive national merit fellowship for Hispanic graduate students.
- *Computer Science Excellence Saburo Muroga Endowed Fellow*, UIUC (2019--2020) --- top departmental fellowship for incoming CS PhDs.
- *Most Cited Paper Certificate*, International Journal of Automation & Computing (IJAC, December 2019) --- for "Why and when can deep- but not shallow-networks avoid the curse of dimensionality: a review".
- *Sloan Scholar*, Alfred P. Sloan Foundation Minority Ph.D. (MPHD) Program (2018--2019) --- national fellowship for underrepresented STEM PhD students.
- *Grainger Engineering SURGE Fellowship*, UIUC (2018--2019) --- multi-year college-level fellowship for diverse engineering PhDs.

// ============================================================================
#pagebreak()
#section[Selected Publications]

#set text(9.5pt)

#emph[#link("https://scholar.google.com/citations?user=_NQJoBkAAAAJ&hl=en")[Google Scholar]: full publication list.]

#block(sticky: true, above: 12pt, below: 6pt)[*Refereed Publications*]
#pubnum.update(0)

#pubitem(
  [*B. Miranda*, S. Daruru, E. S. Hersch, Z. Zhou, A. Nie, D. Amrollahi, L. Aniva, I. Mlauzi, et al.],
  [VeriBench: End-to-End Formal Verification Benchmark for AI Coding Agents in Lean 4],
  venues(
    vlink("https://cs.stanford.edu/people/brando9/professional_documents/papers/NeurIPS_2026_VeriBench.pdf", [Preprint. 2026]),
    vlink("https://colab.research.google.com/drive/1_TsBPSQTMrNK0WD2-qj5VpEYKTLuiUYc?usp=sharing", [Run Tutorial (Colab). 2026]),
    vlink("https://harborframework.com/registry", [Harbor Hub. 2026]),
    vlink("https://cs.stanford.edu/people/brando9/veribench/blog/veribench-launch/", [Blog. 2026]),
    vlink("https://openreview.net/forum?id=rWkGFmnSNl", [2nd Workshop on AI for Math at International Conference on Machine Learning (ICML). 2025]),
  ),
)

#pubitem(
  [Z. Zhou, X. Lu, C. Cao, *B. Miranda*, T. Liu, B. Han, S. Koyejo],
  [CoDaPO: Confidence and Difficulty-Adaptive Policy Optimization for LLM Reasoning],
  venues(
    [International Conference on Machine Learning (ICML), Main Track. 2026],
    [International Conference on Learning Representations (ICLR) Workshop on Lifelong Agents: Learning, Aligning, Evolving. 2026],
    [2nd Workshop on AI for Math at International Conference on Machine Learning (ICML). 2025],
  ),
  url: "https://openreview.net/forum?id=8OoZ8dnvIT",
)

#pubitem(
  [R. Schaeffer, N. Levi, *B. Miranda*, S. Koyejo],
  [Pretraining Scaling Laws for Generative Evaluations of Language Models],
  venues([International Conference on Learning Representations (ICLR), Main Track. 2026]),
  url: "https://openreview.net/forum?id=Ym33xJYINV",
)

#pubitem(
  [E. Chen, A. Gulati, *B. Miranda*, Z. Tang, S. Koyejo],
  [Rethinking LLM Judges: Chain-of-Thought and Multi-Step Pipelines for Math Grading],
  venues([International Conference on Learning Representations (ICLR) Workshop on Logical Reasoning of Large Language Models. 2026]),
  url: "https://openreview.net/forum?id=vdXPorr099",
)

#pubitem(
  [S. Barkallah, S. Daruru, *B. Miranda*, L. Aniva, A. Nie, S. Koyejo],
  [VeriBench-FTP: A Formal Theorem Proving Benchmark in Lean 4 for Code Verification],
  venues([5th Neural Information Processing Systems (NeurIPS) Workshop on Mathematical Reasoning and AI. 2025]),
  url: "https://openreview.net/forum?id=wDjOpXKgtU",
)

#pubitem(
  [L. Aniva, C. Sun, *B. Miranda*, C. Barrett, S. Koyejo],
  [Pantograph: A machine-to-machine interaction interface for advanced theorem proving, high level reasoning, and data extraction in Lean 4],
  venues([International Conference on Tools and Algorithms for the Construction and Analysis of Systems (TACAS). 2025]),
  url: "https://link.springer.com/chapter/10.1007/978-3-031-90643-5_6",
)

#pubitem(
  [*B. Miranda*\*, A. Gulati\*, E. Chen\*, E. Xia\*, K. Fronsdal\*, B. de Moraes Dumont, S. Koyejo],
  [Putnam-AXIOM: A Functional & Static Benchmark for Measuring Higher Level Mathematical Reasoning in LLMs],
  venues(
    [International Conference on Machine Learning (ICML), Main Track. 2025],
    [Neural Information Processing Systems (NeurIPS) Workshop on Mathematics and AI (MATH-AI). 2024],
  ),
  url: "https://openreview.net/forum?id=kqj2Cn3Sxr",
  note: [\*equal contribution],
)

#pubitem(
  [R. Schaeffer, H. Schoelkopf, *B. Miranda*, G. Mukobi, V. Madan, A. Ibrahim, H. Bradley, S. Biderman, S. Koyejo],
  [Why Has Predicting Downstream Capabilities of Frontier AI Models with Scale Remained Elusive?],
  venues(
    [International Conference on Machine Learning (ICML). 2025],
    [International Conference on Machine Learning (ICML) Workshop on Trustworthy Multi-modal Foundation Models and AI Agents (TiFA). 2024],
  ),
  url: "https://arxiv.org/pdf/2406.04391",
)

#pubitem(
  [R. Schaeffer, *B. Miranda*, J. Kazdan, K. Z. Liu, A. M. Ahmed, N. Mireshghallah, S. Koyejo],
  [Causally Quantifying the Effect of Test Set Contamination on Generative Benchmarks],
  venues([Neural Information Processing Systems (NeurIPS) Workshop on Evaluating the Evolving LLM Lifecycle: Benchmarks, Emergent Abilities, and Scaling. 2025]),
  url: "https://openreview.net/forum?id=RsmjshBEDP",
)

#pubitem(
  [R. Schaeffer, J. Kazdan, Y. Denisov-Blanch, *B. Miranda*, M. Gerstgrasser, et al.],
  [Position: Machine Learning Conferences Should Establish a "Refutations and Critiques" Track],
  venues([Advances in Neural Information Processing Systems 38 (NeurIPS), Position Paper Track Oral. 2025]),
  url: "https://papers.nips.cc/paper_files/paper/2025/hash/9118ad115831e52cfeec1acd40c6e0f3-Abstract-Position_Paper_Track.html",
)

#pubitem(
  [R. Schaeffer, D. Valentine, L. Bailey, J. Chua, et al., *B. Miranda*, et al., S. Koyejo, E. Perez],
  [Failures to Find Transferable Image Jailbreaks Between Vision-Language Models],
  venues(
    [International Conference on Learning Representations (ICLR). 2024],
    [Neural Information Processing Systems (NeurIPS) Workshop on Red Teaming Generative AI. 2024],
  ),
  url: "https://openreview.net/forum?id=wvFnqVVUhN",
)

#pubitem(
  [R. Schaeffer, M. Khona, S. Chandra, M. Ostrow, *B. Miranda*, S. Koyejo],
  [Does Maximizing Neural Regression Scores Teach Us About The Brain?],
  venues([Neural Information Processing Systems (NeurIPS) Workshop on Unifying Representations in Neural Models (UniReps), 2nd Edition. 2024]),
  url: "https://openreview.net/forum?id=f6IB0WrOKS",
)

#pubitem(
  [K. Chawla, A. Sahai, M. DePavia, S. Sundar, *B. Miranda*],
  [Quantifying the Importance of Data Alignment in Downstream Model Performance],
  venues([International Conference on Learning Representations (ICLR) Workshop on Data-Centric Machine Learning Research (DMLR). 2024]),
  url: "https://arxiv.org/abs/2501.08496",
)

#pubitem(
  [A. Gulati, D. Ladsaria, S. Mishra, J. Sidhu, *B. Miranda*],
  [An Evaluation Benchmark for Autoformalization in Lean4],
  venues([International Conference on Learning Representations (ICLR) Tiny Papers Track, Second Edition. 2024]),
  url: "https://arxiv.org/abs/2406.06555",
)

#pubitem(
  [R. Schaeffer, *B. Miranda*, S. Koyejo],
  [Are Emergent Abilities of Large Language Models a Mirage?],
  venues([Neural Information Processing Systems (NeurIPS), Main Track. 2023]),
  url: "https://arxiv.org/abs/2304.15004",
)

#pubitem(
  [*B. Miranda*\*, A. Lee\*, P. Yu, S. Koyejo],
  [Beyond Scale: the Diversity Coefficient as a Data Quality Metric Demonstrates LLMs are Pre-trained on Formally Diverse Data],
  venues(
    [International Conference on Machine Learning (ICML) Workshop on Data-Centric Machine Learning. 2023],
    [International Conference on Machine Learning (ICML) Workshop on Deployable Generative AI. 2023],
  ),
  url: "https://arxiv.org/abs/2306.13840",
  note: [\*equal contribution],
)

#pubitem(
  [T. Poggio, H. Mhaskar, L. Rosasco, *B. Miranda*, Q. Liao],
  [Why and when can deep-but not shallow-networks avoid the curse of dimensionality: a review],
  venues([International Journal of Automation and Computing (IJAC). 2017]),
  url: "https://link.springer.com/article/10.1007/s11633-017-1054-2",
)

#block(sticky: true, above: 14pt, below: 6pt)[*Preprints and Technical Reports*]
#pubnum.update(0)

#pubitem(
  [D. Amrollahi, M. Karimi, *B. Miranda*, L. Aniva, C. Sun, C. Barrett, S. Koyejo],
  [AI Coding Benchmarks Need Proofs, Not Just Tests],
  venues([Preprint 2026]),
  url: "https://cs.stanford.edu/~daneshva/publications/ai-coding-benchmarks-need-proofs-not-just-tests.pdf",
)

#pubitem(
  [W. Chan, M. Souliman, J. Nordhagen, *B. Miranda*, E. Obbad, S. Koyejo],
  [Lean-ing on Quality: How High-Quality Data Beats Diverse Multilingual Data in Autoformalization],
  venues([Preprint 2025, arXiv:2502.15795]),
  url: "https://arxiv.org/abs/2502.15795",
)

#pubitem(
  [E. Obbad, I. Mlauzi, *B. Miranda*, R. Schaeffer, K. Obbad, S. Bedi, S. Koyejo],
  [ZIP-FIT: Embedding-Free Data Selection via Compression-Based Alignment],
  venues([Preprint 2024, arXiv:2410.18194]),
  url: "https://arxiv.org/abs/2410.18194",
)

#set text(10pt)

// ============================================================================
#section[Research Artifacts & Systems]

- *#link("https://openreview.net/forum?id=rWkGFmnSNl")[VeriBench]* and *#link("https://openreview.net/forum?id=wDjOpXKgtU")[VeriBench-FTP]*: Lean 4 verification benchmarks for AI-generated code and theorem-proving code verification; VeriBench includes a public #link("https://colab.research.google.com/drive/1_TsBPSQTMrNK0WD2-qj5VpEYKTLuiUYc?usp=sharing")[Colab tutorial] and #link("https://harborframework.com/registry")[Harbor Hub] release
- *#link("https://github.com/brando90/veribench-dt")[VeriBench-DT]* and *#link("https://github.com/brando90/veribench-deps")[VeriBench-Deps]*: Lean 4 autoformalization benchmarks --- differential-testing trustworthiness and repository-level Python$arrow.r$Lean with the Axiom Trust Boundary metric
- *#link("https://github.com/Stanford-AI-for-LEAN-Club/lean-ebm")[lean-ebm]*: Energy-Based Models for Lean 4 theorem proving (Stanford AI for Lean Club project)
- *#link("https://openreview.net/forum?id=kqj2Cn3Sxr")[Putnam-AXIOM]* and *#link("https://huggingface.co/datasets/3ricme/Putnam-AXIOM-Grading")[Putnam-AXIOM-Grading]*: LLM mathematical reasoning benchmark and human-graded Putnam-style partial-credit benchmark
- *#link("https://link.springer.com/chapter/10.1007/978-3-031-90643-5_6")[Pantograph]*: Lean machine-to-machine theorem-proving interface
- *#link("https://huggingface.co/morph-labs/morph-prover-v0-7b")[Morph Prover v0 7b] / #link("https://www.moogle.ai/")[Moogle.ai]*: Lean 4 proof model and verified-code search engine developed with Morph Labs; designed and built the embedding-based vector database powering Moogle's semantic search over Mathlib
- *#link("https://alphaapollo.org/")[AlphaApollo]* and *#link("https://github.com/tmlr-group/AlphaDiana")[AlphaDiana]*: agentic reasoning and harness-aware evaluation systems for verifiable reasoning
- *#link("https://github.com/brando90/ultimate-utils")[ultimate-utils]*: reusable ML and research-engineering utility library

// ============================================================================
#section[Professional Experience]

#entry[
  #dated([*Stanford University* - Stanford, CA], [September 2022 -- 2026 (expected)]) \
  _Ph.D. Student in Computer Science. Advisor: Professor Sanmi Koyejo_ \
  Research in AI for formal mathematics; mentored a #link("https://www.cs.stanford.edu/bachelors/research-opportunities")[Stanford CS CURIS] intern and student collaborators on Lean 4 verification research.
]

#entry[
  #dated([*Amazon Web Services (AWS)* - Cupertino, CA], [June 2024 -- September 2024]) \
  _Applied Scientist Intern_
]

#entry[
  #dated([*Morph Labs* - Remote], [October 2023 -- December 2023]) \
  _Machine Learning Research Scientist Consultant_
]

#entry[
  #dated([*Wise Agents* - Stanford Spin-out], [2023]) \
  _AI Research Consultant_
]

#entry[
  #dated([*IBM Research* - Yorktown Heights, NY], [May 2022 -- August 2022]) \
  _Graduate Research Intern_
]

#entry[
  #dated([*University of Illinois Urbana-Champaign* - Urbana-Champaign, IL], [September 2018 -- May 2022]) \
  _Ph.D. Student in Computer Science. Advisor: Professor Sanmi Koyejo_ \
  Research on meta-learning and data diversity; mentored student collaborators on data quality and evaluation methodology.
]

#entry[
  #dated([*IBM Research* - Yorktown Heights, NY], [May 2021 -- August 2021]) \
  _Graduate Research Intern_
]

#entry[
  #dated([*MIT CBMM (Center for Brain Minds & Machines)* - Cambridge, MA], [June 2015 -- September 2018]) \
  _Research Assistant. Advisor: Professor Tomaso Poggio_ \
  Deep-learning theory research; mentored undergraduate collaborators through MIT CBMM's Engineering of Intelligence team.
]

// ============================================================================
#section[Media Coverage]

- *Hacker News / Y Combinator (January 2025)*: #link("https://news.ycombinator.com/item?id=42565606")[_Putnam-AXIOM_ benchmark posted on Hacker News] --- front-page attention on Y Combinator's tech-news forum
- *Aran Komatsuzaki / \@arankomatsuzaki on X (June 2024)*: #link("https://x.com/arankomatsuzaki/status/1799976398331011173")[shared the downstream-capabilities paper on X] to his AI-research audience
- *AIhub (April 2024)*: #link("https://aihub.org/2024/04/25/are-emergent-abilities-of-large-language-models-a-mirage-interview-with-brando-miranda/")[interview with Brando Miranda] on the NeurIPS Outstanding Paper Award-winning emergent-abilities paper
- *American Scientist (March--April 2024)*: #link("https://www.americanscientist.org/article/an-education-in-irrationality")["Is There an AI Metrics Mirage?"]
- *White House Economic Report of the President (March 2024)*: cited Miranda et al.'s work on emergent abilities in the White House's annual economic-policy report
- *Andrew Ng (March 2024)*: Endorsed the emergent-abilities paper as evidence for smooth, predictable AGI development
- *Quanta Magazine (February 2024)*: "How Quickly Do Large Language Models Learn Unexpected Skills?"
- *Stanford AI Lab Blog (ICML 2023)*: #link("https://ai.stanford.edu/blog/icml-2023/")[featured the _Beyond Scale_ and _Is Pre-training Truly Better Than Meta-Learning?_ papers]
- *AK / \@\_akhaliq on X (June 2023)*: #link("https://x.com/_akhaliq/status/1673507375515594766")[shared the _Beyond Scale_ paper on X] to a large AI-research audience (68.9K views)
- *The New York Times (June 2023)*: "Silicon Valley Confronts the Idea That the 'Singularity' Is Here"
- *The Register (May 2023)*: #link("https://www.theregister.com/software/2023/05/16/llm-emergent-behavior-written-off-as-a-mirage-by-study/655184")["LLM emergent behavior written off as 'a mirage' by study"]
- *Stanford Institute for Human-Centered Artificial Intelligence (HAI) (May 2023)*: #link("https://hai.stanford.edu/news/ais-ostensible-emergent-abilities-are-mirage")["AI's Ostensible Emergent Abilities Are a Mirage"]
- *Y Combinator News (May 2023)*: #link("https://news.ycombinator.com/item?id=35768824")["Are emergent abilities of large language models a mirage?"]
- *Forbes (May 2023)*: "AI 'Emergent Abilities' Are A Mirage, Says AI Researcher"
- *Vice / Motherboard (May 2023)*: #link("https://www.vice.com/en/article/scary-emergent-ai-abilities-are-just-a-mirage-produced-by-researchers-stanford-study-says/")["Scary 'Emergent' AI Abilities Are Just a 'Mirage' Produced by Researchers, Stanford Study Says"]
- *Additional coverage*: Medium, Hacker News, NeurIPS blog, Reddit, and other community discussions

// ============================================================================
#section[Invited & Contributed Talks]

- *Applications of Trustworthy Machine Reasoning with AI Coding Agents* -- #link("https://trustworthy-machine-reasoning.github.io/")[AAAI 2026 Tutorial] "Trustworthy Machine Reasoning with Foundation Models" (Part IV, 50 min), Singapore, January 2026
- *Emergent Abilities in Large Language Models: Mirage or an Elusive Predictive Frontier?* -- #link("https://docs.google.com/presentation/d/1J29Rt6C7g8uh6aWUJUIUtuZHdU0ihrWMi8C66XJn9jw/edit?usp=sharing")[Hong Kong Baptist University, Department of Computer Science Seminar], Hong Kong, January 2026
- *Applications of Trustworthy Machine Reasoning with AI Coding Agents* -- #link("https://docs.google.com/presentation/d/1oHnxUTewe0k9h-SL8RExViJVOUcEPnWmPD_VbD4EzJ0/edit?usp=sharing")[Hong Kong Baptist University, Department of Computer Science Seminar], invited, January 2026
- *VeriBench: End-to-End Formal Verification Benchmark for AI Code Generation in Lean 4* -- #link("https://docs.google.com/presentation/d/11w7Q9wbfimfs0e87XuLagkhj7Q1lk8Wq-ASM-xJVHdg/edit?usp=sharing")[Lawrence Livermore National Laboratory Reading Group], invited, July 2025
- *Intro to Lean 4, VeriBench, and Trustworthy Testing with Theorems* -- #link("https://docs.google.com/presentation/d/1KRBym-sOORaxszOJQHdD4u80wAl7jHy8Pda0KAcdeZw/edit?usp=sharing")[Prof. Azalia Mirhoseini's Lab Meeting, Stanford], invited, 2025
- *Are Emergent Abilities of Large Language Models a Mirage? --- Why Has Predicting Downstream Capabilities Remained Elusive?* -- #link("https://docs.google.com/presentation/d/1cr_X6jzZxShHMUVjzHAkitCnPZCbBfyxxxgZg8S90SI/edit?usp=sharing")[Lawrence Livermore National Laboratory], invited talk, 2025
- *Are Emergent Abilities of Large Language Models a Mirage?* -- #link("https://docs.google.com/presentation/d/1k-yCVLob1eSyg71jT-k2w2mi--gkTQGAK_H2x3sPqpA/edit?usp=sharing")[Stanford IEEE Invited Talk], Stanford, CA, 2023
- *Emergent Abilities of Large Language Models* -- #link("https://docs.google.com/presentation/d/1UDqPg06xQKga1oWSEMS2jyzignQwkot6ZbjQMhdZngs/edit?usp=sharing")[Amazon Research], invited talk, 2023
- *The Curse of Low Task Diversity: On the Failure of Transfer Learning to Outperform MAML* -- #link("https://neurips.cc/virtual/2022/63778")[NeurIPS Meta-Learning Workshop, Contributed Talk]\; #link("https://docs.google.com/presentation/d/1nY39x8u8j7k6KpOhD6Vqto78YzLOwyR9B24kuoHJijY/edit?usp=sharing")[slides], New Orleans, LA, December 2022

// ============================================================================
#section[Teaching Experience]

#entry[
  #dated([*Stanford University*], [2023 -- 2024]) \
  _Course Assistant (3 quarters) & Instructor of Record (Spring)_
  - CS 197 _How to Do CS Research_ with Prof. Michael Bernstein --- TA'd 3 quarters; *Instructor of Record* for the Spring offering
  - Mentored undergraduate research that produced *2 workshop publications* (including ICML workshop tracks)
]

#entry[
  #dated([*University of Illinois Urbana-Champaign*], [August 2020 -- December 2020]) \
  _Graduate Teaching Assistant_
  - CS 446 Machine Learning
  - Designed problem sets and exams; held weekly office hours
]

#entry[
  #dated([*Massachusetts Institute of Technology*], [2014--2016]) \
  _Graduate Teaching Assistant_
  - Statistical Learning Theory & Applications (9.520/6.860); Introduction to Machine Learning (6.036)
  - Introduction to Algorithms (6.006); Design & Analysis of Algorithms (6.046)
]

// ============================================================================
#section[Leadership & Service]

#entry[
  #dated([*Research Mentorship*], [2016 -- Present])
  - Mentored undergraduate and graduate students at Stanford, UIUC, and MIT CBMM, including a #link("https://www.cs.stanford.edu/bachelors/research-opportunities")[Stanford CS CURIS] intern
  - Led research teams on data quality metrics, meta-learning, and formal reasoning
]

#entry[
  #dated([*Academic Service*], [2018 -- Present])
  - Co-founder and president of #link("https://www.stanfordlean.club/")[Stanford AI for Lean]\; created public #link("https://www.youtube.com/playlist?list=PLB3sDpSRdrOt68MTR6kdI0Jc85Uuw1YWV")[Learning Lean 4 tutorial videos] with a companion #link("https://github.com/brando90/learning_lean/tree/main")[code repository]
  - Reviewer for NeurIPS 2026, ICLR 2026, ICML 2026 (*Silver Reviewer* -- top reviewer recognition), TMLR 2026, ICLR 2025, ICML 2025 AI4MATH Workshop, ICLR 2024 DMLR Workshop, NeurIPS 2023 MATH-AI Workshop, ICLR 2020, JMLR 2018
  - Graduate advisor for Latinos in Computer Science (LCS) at UIUC
  - Founded "Stanford Bachata Sensual & Brazilian Zouk" and "UIUC Bachata Sensual & Zouk" official student organizations; Stanford group has an #link("https://www.youtube.com/playlist?list=PLB3sDpSRdrOt6iKyPucMJAwbwW2YtMs3V")[83-video YouTube lesson playlist] with 25K+ total video views and #link("https://www.instagram.com/stanford_bachata_sensual_zouk/")[Instagram]
  - Undergraduate and outreach research mentorship through #link("https://www.cs.stanford.edu/bachelors/research-opportunities")[Stanford CS CURIS] (Summer 2025), DREU at UIUC, UROP at MIT, and MIT CBMM's Engineering of Intelligence Team
]
