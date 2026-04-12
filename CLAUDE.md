# CLAUDE.md

## Repository Overview

This is **Brando Miranda's personal/academic website**, hosted on GitHub Pages using Jekyll. It serves as a professional portfolio, research publication showcase, collaboration recruitment page, and personal interests blog. The site owner is a PhD student in AI/ML at Stanford University.

**Live site:** `https://brando90.github.io/brandomiranda/`

## Tech Stack

- **Static site generator:** Jekyll (via the `github-pages` gem)
- **Theme:** `minima` (Jekyll's default minimal theme)
- **Hosting:** GitHub Pages (auto-builds on push to `master`)
- **Dependencies:** Managed via Bundler (`Gemfile` / `Gemfile.lock`)
- **CV source files:** LaTeX (in `cvs_tex/`)

## Directory Structure

```
brandomiranda/
├── _config.yml                  # Jekyll site configuration
├── _posts/                      # Blog posts (YYYY-MM-DD-title.md format)
├── cvs_tex/                     # LaTeX CV source files (cv_short_llm.tex, cv_long.tex)
├── exclude/                     # Content excluded from Jekyll build (awards, publications archive)
├── images/                      # Site images (profile photos, etc.)
├── non_personal_documents/      # External documents (e.g., White House report)
├── professional_documents/      # PDFs: papers, posters, certifications, CV
├── index.md                     # Main landing/about page
├── dance.md                     # Personal dance page
├── peformance-psychology.md     # Performance psychology interests (note: filename typo is intentional, do NOT rename)
├── prospective-collaborations.md # Collaboration/recruitment guidelines
├── 404.html                     # Custom 404 page
├── Gemfile                      # Active Ruby dependencies
├── Gemfile2                     # Archived/historical Gemfile (not used in builds)
└── README.md                    # Jekyll setup notes and dev documentation
```

## Local Development

```bash
# Install dependencies
bundle install

# Run local dev server
bundle exec jekyll serve
# Site available at http://127.0.0.1:4000/brandomiranda/
```

The `baseurl` is `/brandomiranda/` (configured in `_config.yml`), so all local URLs include that prefix.

## Content Conventions

### Pages

- Root-level `.md` files with YAML frontmatter (`layout: page`, `title: "..."`) become top-level site pages.
- Pages appear in the site navigation automatically via the minima theme.

### Blog Posts

- Located in `_posts/` using Jekyll's naming convention: `YYYY-MM-DD-post-title.md`
- Frontmatter uses `layout: post` with `title`, `date`, `categories`, and `comments` fields.
- Blog posts date range: October 2019 - December 2020.

### Links and References

- External links to papers, profiles, and resources are embedded inline in markdown.
- YouTube videos are embedded using raw HTML `<iframe>` tags.
- The site author's email is intentionally obfuscated as `brando9 {at} stanford . edu` to avoid spam.

### Excluded Content

The `exclude/` directory contains archived markdown files (publications, awards, preparation notes) that are explicitly excluded from the Jekyll build via `_config.yml`. These are preserved in git for reference but not rendered on the live site.

## Key Configuration (_config.yml)

- **title:** "Brando Miranda"
- **theme:** minima
- **baseurl:** "/brandomiranda/"
- **plugins:** jekyll-feed
- **exclude:** `[exclude/]`

## Common Tasks

### Adding a new page

Create a `.md` file in the repository root with frontmatter:
```yaml
---
layout: page
title: "Page Title"
---
```

### Adding a new blog post

Create a file in `_posts/` named `YYYY-MM-DD-post-title.md` with frontmatter:
```yaml
---
layout: post
title: "Post Title"
date: YYYY-MM-DD HH:MM:SS -0800
categories: category-name
comments: true
---
```

Or use: `bundle exec jekyll post "Post Title"` (requires jekyll-compose gem).

### Updating the CV

Edit LaTeX files in `cvs_tex/` (`cv_short_llm.tex` for short version, `cv_long.tex` for full version). Compiled PDFs are not stored in the repo; they are generated externally and placed in `professional_documents/` if needed.

### Adding images

Place image files in `images/` and reference them in markdown:
```markdown
![alt text](images/filename.jpg)
```

## Important Notes

- **Do NOT rename `peformance-psychology.md`** -- the typo in the filename is established and changing it would break existing URLs/links.
- **`Gemfile2` is archival** -- it is not used by Bundler. The active dependency file is `Gemfile`.
- **The `exclude/` directory** is excluded from the Jekyll build. Content placed there will not appear on the site.
- **GitHub Pages deployment** is automatic on push to `master`. No CI/CD pipeline or manual build step is needed.
- **Commit messages** in this repo tend to be descriptive sentences explaining what was changed and why.
- **The main branch is `master`** (not `main`).

## Git Workflow

- The default/production branch is `master`.
- GitHub Pages builds automatically from `master`.
- Commit messages should be descriptive and explain the purpose of the change.
- Professional documents (PDFs, images) are committed directly to the repo.

## Files to Never Commit

Per `.gitignore`:
- `_site/` (Jekyll build output)
- `.jekyll-cache/`, `.jekyll-metadata`, `.sass-cache/`
- `vendor/`
- `.DS_Store` and other macOS artifacts
- `.idea/` (JetBrains IDE config)
