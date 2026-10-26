// ============================================================================
// Reusable CV template — Typst port of the LaTeX preamble in cv_short.tex.
//
// The LaTeX original leans on \changemargin lists, \hfill, \nopagebreak[4] and
// hand-placed \vspace to get section rules, right-aligned dates and unsplit
// entries. Typst gives all of that as ordinary functions, so the layout rules
// live here once instead of being re-tuned per entry.
// ============================================================================

// Body text sits indented relative to the full-width section rules, matching
// the \changemargin offsets in cv_short.tex.
#let body-indent = 0.24in

#let cv(
  name: none,
  email: none,
  location: none,
  address: none,
  links: (),
  body,
) = {
  set page(
    paper: "us-letter",
    // Left margin carries the body indent; `section` pulls back out of it.
    // Side margins match the effective text width of the LaTeX original,
    // which the `fullpage` + `geometry` + `changemargin` stack widens well
    // past the article-class default.
    margin: (left: 0.5in + body-indent, right: 0.5in, top: 0.7in, bottom: 0.65in),
    numbering: none,
  )
  set text(font: "Libertinus Serif", size: 10pt, lang: "en")
  set par(justify: false, leading: 0.58em)
  // Links stay black, matching hyperref's `hidelinks` in the LaTeX CV.
  show link: it => it
  set list(marker: [•], indent: 0.6em, body-indent: 0.45em, spacing: 0.62em)

  // --- Letterhead (spans the full text width, like the section rules) -------
  pad(left: -body-indent, block(width: 100% + body-indent)[
    #grid(
      columns: (1fr, auto, 1fr),
      align: (left + horizon, center + horizon, right + horizon),
      text(9pt)[*#email* \ #location],
      text(23pt)[*#name*],
      text(9pt)[#address],
    )
    #v(4pt)
    #align(center, text(9.5pt, links.map(l => link(l.at(1))[#l.at(0)]).join[ #h(0.35em) | #h(0.35em) ]))
  ])
  v(10pt)

  body
}

// Section header: small caps + rule, glued to whatever follows.
// `sticky: true` replaces the LaTeX \nopagebreak[4] hack.
// The negative pad pulls the header back out of the body indent so the rule
// spans the full text width.
#let section(title) = pad(left: -body-indent, block(
  width: 100% + body-indent,
  breakable: false,
  sticky: true,
  above: 15pt,
  below: 7pt,
)[
  #smallcaps(text(11pt, title))
  #v(-7pt)
  #line(length: 100%, stroke: 0.5pt)
])

// A line with left content and a right-aligned (italic) date.
#let dated(left-body, date) = [#left-body #h(1fr) #emph(date)]

// Multi-line entry that may never be split across a page boundary.
// This is the structural fix for the recurring "title on page N, venue on
// page N+1" regression the LaTeX CV works around with `\\*` everywhere.
#let entry(body, space: 10pt) = block(breakable: false, below: space, body)

// Numbered publication entry. Counter resets per subsection via `pubnum.update(0)`.
#let pubnum = counter("pubnum")

#let pubitem(authors, title, venue, url: none, note: none) = block(
  breakable: false,
  below: 10pt,
)[
  #pubnum.step()
  #context [(#pubnum.display())]~#{
    let head = [#authors, #emph(title).]
    if url == none { head } else { link(url, head) }
  }
  \
  (#venue)#if note != none [ (#note)]
]

// Venue helper: every venue chunk is bold, joined by "&" — enforces the
// "bold each venue part separately, never half-bold" rule mechanically.
#let venues(..parts) = parts.pos().map(p => strong(p)).join[ & ]

// A bold venue chunk that is also a hyperlink.
#let vlink(url, body) = link(url, strong(body))
