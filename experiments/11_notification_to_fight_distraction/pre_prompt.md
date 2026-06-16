# Draft blog to fight distraction + the appendix as a seperate blog or link to .md notes on how to do it -- likely just a seperate blog post but not on my main blogs just as a sepearate link to click. Always my bibs please. 

ref: https://claude.ai/chat/800d5936-cd27-4140-849c-bbc379aaf7bc 
ref: /Users/sanmikoyejo-mba-1/brandomiranda/experiments/11_notification_to_fight_distraction/pre_prompt.md

```
# Agent task — Publish "Don't Watch the Spinner" to the Jekyll blog

**For:** Claude Code (`clauded`), run from the root of the `brando90.github.io` repo (the `brandomiranda` site).
**Input file:** `2026-06-16-dont-watch-the-spinner.md` — the finished post, shipped alongside this runbook. Jekyll date-slug naming is already correct, so don't rename it.
**Outcome:** the post is live-ready on a branch with a green build and an open PR (or pushed to `main` if that's the repo's flow).

---

## Goal

Place the finished post into the site, make its front matter and permalink consistent with the rest of the blog, update any hand-maintained index, verify the site builds, and open a PR. **Do not rewrite the post's prose, headings, or argument.**

## Confirm first — don't assume

1. This is a **Jekyll** site. Posts live in `_posts/` (verify the exact path; confirm it isn't a collection folder).
2. Read `_config.yml` for: the `permalink:` pattern, any `defaults:` that inject `layout`/`category` by path, the `markdown`/`highlighter` engine, and the plugin list (`jekyll-feed`, `jekyll-paginate`, `jekyll-seo-tag`, etc.).
3. Open the **2–3 most recent files in `_posts/`** and copy their front-matter shape exactly — the key set, ordering, quoting style, and how they use `layout` / `categories` / `tags` / `description`.

## Steps

1. **Drop the file in.** Move `2026-06-16-dont-watch-the-spinner.md` into `_posts/`. Keep the `YYYY-MM-DD-slug.md` filename.
2. **Reconcile the front matter.** Match the sibling posts: same `layout`, same key set, same `date` format. Keep the existing `title` / `date` / `description`. Add `categories` / `tags` consistent with how other posts tag (e.g. `ai`, `productivity`, `tools`) **only if** the site actually uses them. Drop any key the site doesn't use. Note the `title` contains an apostrophe and double quotes — keep it wrapped so YAML stays valid.
3. **Fix the self-citation URL.** In the BibTeX block near the bottom, set `howpublished` to the **real permalink** Jekyll will generate, derived from the `permalink:` pattern in `_config.yml` + this post's date/slug. It currently assumes `…/2026/06/16/dont-watch-the-spinner.html` — verify and correct if the pattern differs (e.g. `/:categories/:year/:month/:day/:title:output_ext` vs `/:title/`).
4. **Update indexes only if hand-maintained.** If the site has a "Selected Writing" / blog-list page, an archive page, or a manually curated RSS/Atom include, add this post in the correct spot. If those are plugin-generated (e.g. `jekyll-feed`, an auto `for post in site.posts` loop), **do nothing** — they pick it up automatically.
5. **Build & preview.** Run `bundle exec jekyll build` (or `bundle exec jekyll serve` to eyeball it locally). Fix any Liquid / YAML / build errors. The two most likely:
   - A code block containing `{{` or `{%` that the Liquid parser tries to interpret → wrap that block in `{% raw %}` … `{% endraw %}`. **Do not alter the code itself.** (The post's `ntfy` curl snippets and the `~/.claude/settings.json` JSON are the likely triggers.)
   - A front-matter quoting issue from the title's apostrophe/quotes → adjust the quoting, not the title text.
6. **Ship.** Create a branch (e.g. `post/dont-watch-the-spinner`), commit with a clear message (`Add post: Don't Watch the Spinner`), and open a PR. If the repo's flow is push-to-`main` with GitHub Pages auto-build, do that instead. **Print the PR/commit URL and the final live permalink.**

## Acceptance criteria

- `bundle exec jekyll build` exits 0.
- The post renders at the expected permalink; title, date, internal links, and external links resolve; all code blocks display intact.
- Front matter matches sibling posts; the BibTeX `howpublished` URL equals the real permalink.
- Any manually-curated index includes the post; **nothing else in the repo changed.**

## Guardrails

- Only touch: the post's **file location**, its **front matter**, the **BibTeX URL**, and **indexes**. Leave the prose, headings, and citations exactly as written.
- Do not modify `_config.yml` beyond what's strictly required to build.
- Preserve smart quotes and em dashes; don't "normalize" the title's typography.
- If unsure whether an index is auto- or hand-generated, prefer doing nothing and note it in the PR description.

---

## Copy-paste prompt (to run inline instead)

> Publish the finished post `2026-06-16-dont-watch-the-spinner.md` to this Jekyll blog. First read `_config.yml` and the 2–3 most recent files in `_posts/` to learn the permalink pattern and front-matter conventions. Move the post into `_posts/` and reconcile its front matter to match the siblings (keep the title/date/description; keep the title quoted so YAML stays valid). Fix the BibTeX `howpublished` URL to the real generated permalink. If there's a hand-maintained writing index or RSS include, add the post; if it's plugin-generated, leave it. Run `bundle exec jekyll build`, fixing any Liquid/YAML errors — wrap any code block containing `{{`/`{%` in `{% raw %}…{% endraw %}` without changing the code. Then create a branch, commit, and open a PR (or push to main if that's the flow), and print the PR link and final permalink. Do not change the post's prose.
```