# brandomiranda — Agent instructions

This is Brando Miranda's personal/professional website (Jekyll, deployed at https://brando90.github.io/brandomiranda/) plus the canonical home of his academic CVs and other professional documents.

## Rules

### CV dual-update rule (HARD)
**Whenever you edit one CV, also propagate the change to the other if appropriate.** The repo holds two canonical CVs under `professional_documents/cvs/`:
- `cv_long.tex` / `cv_long.pdf` — full academic CV (multi-page)
- `cv_short.tex` / `cv_short.pdf` — compact 1–2pp version

Examples of "appropriate":
- A new award → add to **Awards & Honors** in both.
- A new invited talk → add to **Invited & Contributed Talks** in both (long: separate section with detail; short: compact bullet line).
- A new media mention → add to **Media Coverage** in both.
- A reframed Research Summary → mirror to Research Interests in short.
- A new publication → add to **Publications** in long; add to **Selected Publications** in short *only if* it's strong enough for the short list.
- A new advisee → add to long; only add to short if the role is significant.

Examples of "not appropriate" (long-only):
- Section like Coursework, full Poster list, Industry-internship-presentation list — these are detail the short version intentionally drops.

After every `.tex` edit, **immediately rebuild the matching PDF** with `latexmk -pdf -interaction=nonstopmode <file>.tex` from inside `professional_documents/cvs/`. Verify the `.pdf` mtime advanced before reporting the edit done.

### CV style standard
For *what* to write and *how* to phrase it, read `professional_documents/cvs/cvs_prompt.md` — it distills the patterns from two reference Stanford-CS faculty CVs (Chelsea Finn, Clark Barrett, both stored locally under `professional_documents/cvs/two_example_cvs_stanford_profs/`).

### Branch
- The repo uses `main` only. Push CV / website changes directly to `main`.

### Jekyll URLs
- Site `baseurl: /brandomiranda/`. Use `[md](/path)` form (no extra slash). The build excludes `experiments/`, `_drafts/`, and `README.md` from publishing (see `_config.yml`).
