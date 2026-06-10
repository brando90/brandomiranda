#!/usr/bin/env python3
"""Normalize blog-post headers in _posts/ to the canonical format defined in
`CLAUDE.md` § "Blog post header format (HARD)" and mirrored in `AGENTS.md`.

Canonical structure (right after Jekyll frontmatter):

    *Brando Miranda — Month YYYY · ~X min read*

    **Warning: this post is a draft — content may change and errors may remain.**

    **TL;DR.** [single paragraph]

    ---

    [body]

The Warning line is optional — present only while a published post is still
in development. Wherever it appears in the source (legacy posts had it below
the `---`, at the top of the body), it is relocated to the canonical slot
between the byline and the TL;DR.

This script is idempotent by construction: it parses the date / read-time /
TL;DR / body out of each post, discards all other pre-body chrome, and
reassembles the post from scratch in canonical form. Running it twice
produces no diff on the second run.

Usage:
    python3 scripts/normalize_post_headers.py
"""
import os
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
POSTS_DIR = REPO_ROOT / "_posts"
MONTHS = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December",
]

# Match the entire frontmatter block, non-greedy on content but with a
# tight `[ \t]*\n` line terminator so we never swallow trailing blank
# lines into the frontmatter.
FM_RE = re.compile(r"^(---[ \t]*\n.*?\n---[ \t]*\n)(.*)$", re.DOTALL)
DATE_RE = re.compile(r"^date:\s*(\d{4})-(\d{2})-(\d{2})", re.MULTILINE)

READ_TIME_RES = [
    re.compile(r"\*~?(\d+(?:[-–]\d+)?)\s*(?:min|minute)s?\s+read\*"),
    re.compile(r"(\d+(?:[-–]\d+)?)\s*(?:min|minute)s?\s+read"),
]

STRIP_RES = [
    re.compile(r"\*~?\d+(?:[-–]\d+)?\s*(?:min|minute)s?\s+read\*", re.IGNORECASE),
    re.compile(r"\*Brando Miranda[^*\n]*\*", re.IGNORECASE),
    re.compile(r"<p\s+style=\"text-align:\s*right;?\"\s*>\s*<em>[^<]*</em>\s*</p>", re.IGNORECASE),
]

TLDR_RE = re.compile(r"^\s*\*\*TL[;:]?DR\.?\*\*\s*(.*)$", re.IGNORECASE | re.DOTALL)

# Draft-status banner. Matched as a standalone line anywhere in the body and
# re-emitted in the canonical slot (between byline and TL;DR). The tail after
# "draft" is left free so small wording tweaks survive normalization.
DRAFT_WARNING_RE = re.compile(
    r"^[ \t]*(\*\*Warning: this post is a draft[^\n]*\*\*)[ \t]*$", re.MULTILINE
)


def _extract_tldr_and_body(text: str) -> tuple[str, str]:
    """Return (tldr_paragraph_without_marker, rest_of_body).

    Logic:
      - Strip any leading horizontal-rule line and surrounding blank lines.
      - Strip any leading byline-ish / read-time / HTML-byline line.
      - Repeat until none match (handles multiple legacy chrome lines).
      - Then look for a `**TL;DR.**` paragraph. If found, take that
        paragraph as the TL;DR. Otherwise treat the first non-header
        paragraph as TL;DR (auto-label).
    """
    lines = text.splitlines(keepends=False)

    def strip_leading_blanks(i: int) -> int:
        while i < len(lines) and lines[i].strip() == "":
            i += 1
        return i

    def line_is_chrome(line: str) -> bool:
        s = line.strip()
        if s == "":
            return False
        if s == "---":
            return True
        if s.startswith("<!--") and s.endswith("-->"):
            return True
        for r in STRIP_RES:
            if r.search(s):
                return True
        return False

    i = strip_leading_blanks(0)
    while i < len(lines) and line_is_chrome(lines[i]):
        i = strip_leading_blanks(i + 1)

    if i >= len(lines):
        return "", ""

    # Collect the first paragraph (until blank line) — this is the TL;DR.
    para_start = i
    while i < len(lines) and lines[i].strip() != "":
        i += 1
    first_paragraph = "\n".join(lines[para_start:i]).strip()

    m = TLDR_RE.match(first_paragraph)
    if m:
        tldr_text = m.group(1).strip()
    else:
        # If the first "paragraph" is a heading, there's no TL;DR — caller
        # should leave body as-is. Signal by returning empty TL;DR.
        if first_paragraph.lstrip().startswith("#"):
            rest = "\n".join(lines[para_start:]).strip()
            return "", rest
        tldr_text = first_paragraph

    rest_start = strip_leading_blanks(i)
    # Skip a literal `---` separator if present — we'll re-emit our own.
    if rest_start < len(lines) and lines[rest_start].strip() == "---":
        rest_start = strip_leading_blanks(rest_start + 1)
    rest = "\n".join(lines[rest_start:]).rstrip() + "\n"
    return tldr_text, rest


def transform(path: Path) -> tuple[bool, str]:
    orig = path.read_text()

    fm_m = FM_RE.match(orig)
    if not fm_m:
        return False, "no frontmatter"
    fm, body = fm_m.group(1), fm_m.group(2)

    date_m = DATE_RE.search(fm)
    if not date_m:
        return False, "no date in frontmatter"
    year, mo, _ = date_m.groups()
    mname = MONTHS[int(mo) - 1]

    read_time = None
    for r in READ_TIME_RES:
        m = r.search(body)
        if m:
            read_time = m.group(1)
            break
    if read_time is None:
        read_time = "X"

    warning = None
    wm = DRAFT_WARNING_RE.search(body)
    if wm:
        warning = wm.group(1)
        body = body[: wm.start()] + body[wm.end():]

    tldr_text, rest = _extract_tldr_and_body(body)

    parts = [fm.rstrip("\n") + "\n", "\n"]
    parts.append(f"*Brando Miranda — {mname} {year} · ~{read_time} min read*\n")
    parts.append("\n")
    if warning:
        parts.append(warning + "\n")
        parts.append("\n")
    if tldr_text:
        parts.append(f"**TL;DR.** {tldr_text}\n")
        parts.append("\n")
        parts.append("---\n")
        parts.append("\n")
    if rest:
        parts.append(rest.lstrip("\n"))

    new = "".join(parts)
    new = re.sub(r"\n{3,}", "\n\n", new).rstrip() + "\n"

    if new != orig:
        path.write_text(new)
        return True, "updated"
    return False, "no change"


def main() -> int:
    paths = sorted(POSTS_DIR.glob("*.md"))
    if not paths:
        print(f"no posts found in {POSTS_DIR}", file=sys.stderr)
        return 1
    any_changed = False
    for p in paths:
        changed, status = transform(p)
        if changed:
            any_changed = True
        print(f"{p.name:<60} {status}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
