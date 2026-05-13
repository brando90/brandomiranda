# brandomiranda — Agent instructions

See `CLAUDE.md` in this repo root for the full set of conventions. The most important is:

## CV dual-update rule
The repo holds two canonical CVs in `professional_documents/cvs/`:
- `cv_long.tex` / `cv_long.pdf` (full)
- `cv_short.tex` / `cv_short.pdf` (compact)

**Whenever you edit one, also propagate the change to the other where appropriate** (new awards, talks, media, publications, advisees — yes; long-only detail sections like Coursework or full Poster lists — no). After editing any `.tex`, immediately rebuild the matching PDF with `latexmk -pdf -interaction=nonstopmode` from inside `professional_documents/cvs/`.

For *what* to write and *how* to phrase it, the authoritative style guide is `professional_documents/cvs/cvs_prompt.md`. Two reference Stanford CS faculty CVs (Chelsea Finn, Clark Barrett) are committed under `professional_documents/cvs/two_example_cvs_stanford_profs/`.

Branch model: `main` only.
