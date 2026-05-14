# brandomiranda — Agent instructions

See `CLAUDE.md` in this repo root for the full set of conventions. The most important is:

## CV dual-update rule
The repo holds two canonical CVs in `professional_documents/cvs/`:
- `cv_long.tex` / `cv_long.pdf` (full)
- `cv_short.tex` / `cv_short.pdf` (compact)

**Whenever you edit one, also propagate the change to the other where appropriate** (new awards, talks, media, publications, advisees — yes; long-only detail sections like Coursework or full Poster lists — no). After editing any `.tex`, immediately rebuild the matching PDF with `latexmk -pdf -interaction=nonstopmode` from inside `professional_documents/cvs/`.

## CV ↔ website dual-update rule (HARD)
The website `index.md` mirrors specific CV sections: **Bio / Research Summary, Selected Publications, Media Coverage, Awards, and Talks**. **Whenever you edit any of these in a CV, also update `index.md`** (and vice versa) in the same commit. CV-only sections — Teaching, Professional Service, Posters, Professional Experience, Education, Mentoring, Coursework — do not propagate to the website. No build step is needed on the `index.md` side; the LaTeX rebuild on the CV side still applies.

## Publications categorization (HARD)
The Publications section (and cv_short's *Selected Publications*) must be split into **Refereed Publications** (peer-reviewed: conferences, journals, refereed workshops) and **Preprints and Technical Reports** (arXiv-only, model cards, not-yet-refereed). Within each subsection, group by year, most-recent-first. **Each paper appears exactly once** — if a paper moved venues, list it under the most prestigious with a combined venue line, never duplicate.

For *what* to write and *how* to phrase it, the authoritative style guide is `professional_documents/cvs/cvs_prompt.md`. Reference CVs live in `professional_documents/cvs/example_cvs/` — Finn and Barrett (Stanford CS faculty) are the structural prototypes; Eric Mitchell and Rylan Schaeffer (peer PhD-student/recent-grad files) are for length/density calibration only.

Branch model: `main` only.
