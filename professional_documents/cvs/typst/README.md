# Typst CV — draft port

Experimental [Typst](https://github.com/typst/typst) port of `../cv_short.tex`.

**Status: draft.** The LaTeX pair (`../cv_long.tex`, `../cv_short.tex`) is still
canonical — the dual-update rules in `CLAUDE.md` apply to those files. Nothing
here is wired into the website or the `latexmk` workflow.

## Files

| File | What it is |
|---|---|
| `cv.typ` | Template module: page setup, section rule, right-aligned dates, unbreakable entries, publication counter |
| `cv_short.typ` | The CV content, importing `cv.typ` |
| `build.py` | Build helper (uses the `typst` CLI if present, else the `typst` Python wheel) |
| `cv_short.pdf` | Rendered output |

## Build

```bash
cd professional_documents/cvs/typst

# with the typst CLI installed (https://github.com/typst/typst — brew install typst)
typst compile cv_short.typ

# or, no system install needed:
pip install typst && python3 build.py
```

`typst watch cv_short.typ` recompiles on save (~ms), which is the main
day-to-day difference from `latexmk`.

## Verified against the LaTeX original

Text extracted from both PDFs is word-for-word identical (2358 words each; the
only diffs are line-break hyphenation artifacts in extraction). Both render to
5 pages.

## What the port changes structurally

- **Unsplittable entries are a property, not a convention.** `cv_short.tex`
  forbids page breaks inside a publication by requiring `\\*` on *every* line
  break inside *every* entry — one bare `\\` reintroduces the "title on page N,
  venue on page N+1" bug. Here `entry()` and `pubitem()` are
  `block(breakable: false, ...)`, so the guarantee is in the template and
  cannot be forgotten per-entry.
- **Section headers stick to their content** via `block(sticky: true)` instead
  of `\nopagebreak[4]`.
- **Venue formatting is enforced by `venues(..)`**, which bolds each venue chunk
  and joins with `&` — the "never half-bold a multi-venue line" rule becomes
  mechanical rather than a review checklist item.
- **Publication numbering** uses a counter reset per subsection
  (`pubnum.update(0)`), same as `\setcounter{pubnum}{0}`.

## Known gaps vs. the LaTeX version

- **No `\flushbottom` equivalent.** Typst has no stretchable vertical glue, so
  pages end where the content ends rather than being stretched to a flush
  bottom margin. The bug `\flushbottom` was guarding against (split entries) is
  handled directly by `breakable: false`, but the flush-bottom *look* is not
  reproduced.
- `cv_long.tex` is not ported yet.

## Gotcha worth knowing

A `;` immediately after a code expression is swallowed as a statement
terminator: `#link("...")[Stanford AI for Lean]; created ...` silently drops the
semicolon. Write `]\;` instead. Two occurrences in this file hit that.
