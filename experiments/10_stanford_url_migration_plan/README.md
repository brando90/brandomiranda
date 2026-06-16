# Experiment 10: Stanford URL Migration Plan

Status: planning note only.

Last updated: May 19, 2026.

## Goal

Move Brando's website away from the awkward public URL:

- Current: `https://cs.stanford.edu/people/brando9/`

Preferred outcome:

- Best: `https://cs.stanford.edu/people/<csid>/`
- Good: `https://<name>.stanford.edu/`
- Acceptable fallback: `https://<name>.su.domains/`

## Recommendation

First try for the CS personal-page URL: `https://cs.stanford.edu/people/<csid>/`.

It is the strongest academic signal, shortest credible Stanford-CS URL, and a known Stanford CS personal-page pattern. If CS hosting is unavailable or too painful, use Stanford Domains and request a Stanford-branded add-on domain such as `brandomiranda.stanford.edu`. Do not make `web.stanford.edu/~<sunetid>/` the primary target unless Stanford confirms it is still a good new-hosting path, because Stanford says AFS-based hosting is being sunset.

Keep GitHub as the source of truth either way.

## Options

### Option A: CS Personal Page

Target: `https://cs.stanford.edu/people/<csid>/`

How:

1. Confirm Brando has a CSID and CS AFS access.
2. Build the Jekyll site locally with `baseurl: "/people/<csid>/"` and `url: "https://cs.stanford.edu"`.
3. Copy the generated `_site/` files into the CS `~/www` directory.
4. Set the CS AFS permissions required by the CS web-page guide.
5. Keep deploying from this GitHub repo via a small script, not by editing files on the server.

Pros:

- Best-looking URL for an academic CS profile.
- Reads as Stanford CS, not a GitHub project site.
- Static Jekyll output should work once generated.

Cons:

- Requires CS account / AFS setup.
- Deployment is more manual unless scripted.
- May have less modern tooling than GitHub Pages.

### Option B: Stanford Domains + Stanford-Branded Domain

Target: `https://<name>.stanford.edu/`, subject to approval.

How:

1. Create a Stanford Domains site.
2. Request an add-on `stanford.edu` domain through Stanford Domains.
3. Build the Jekyll site with `baseurl: ""` and `url: "https://<name>.stanford.edu"`.
4. Upload the generated `_site/` output to Stanford Domains hosting.
5. Redirect or clearly point the old GitHub Pages URL to the new site.

Pros:

- Official Stanford-branded domain if approved.
- Supported UIT path for personal websites.
- More self-service than CS AFS.

Cons:

- Approval required for `<name>.stanford.edu`.
- `*.su.domains` is less prestigious than `*.stanford.edu`.
- Stanford Domains has storage / service constraints and annual affiliation checks.

### Option C: GitHub Pages With a Stanford Custom Domain

Target: `https://<name>.stanford.edu/`, hosted by GitHub Pages.

How:

1. Ask whether Stanford DNS / vanity URL policy allows pointing a Stanford subdomain at GitHub Pages.
2. If yes, configure the domain in GitHub Pages settings.
3. Add the `CNAME` file GitHub creates.
4. Change `_config.yml` to `baseurl: ""` and set `url`.
5. Use GitHub's Pages HTTPS setting after DNS propagates.

Pros:

- Least migration work if Stanford permits it.
- Keeps GitHub Pages build/deploy workflow.
- Hides the `brando90.github.io/brandomiranda` URL.

Cons:

- Stanford may not approve direct DNS to GitHub for a personal site.
- GitHub Pages custom domains are domain-based, so the current project-site `baseurl` needs adjustment.
- If Stanford only grants a redirect, users may still see the GitHub URL after landing.

### Option D: Central `web.stanford.edu`

Target: `https://web.stanford.edu/~<sunetid>/` or `https://<sunetid>.web.stanford.edu/`

Pros:

- Simple Stanford URL.
- Officially documented for full-service SUNet users.

Cons:

- Not CS-specific.
- Stanford UIT notes AFS-based hosting is being sunset, so this is risky as the new canonical home.
- The tilde URL looks less polished than a CS or clean Stanford subdomain.

## Migration Checklist

1. Pick target URL and confirm eligibility:
   - CS page: confirm CSID and AFS access.
   - Stanford Domains: confirm desired subdomain and whether `<name>.stanford.edu` is approvable.
2. Add a deployment config that can build for both old and new URLs:
   - Current GitHub Pages project URL: `baseurl: "/brandomiranda/"`
   - New root custom domain: `baseurl: ""`
   - New CS path: `baseurl: "/people/<csid>/"`
3. Build locally:
   - `bundle exec jekyll build`
4. Upload `_site/` to the selected Stanford host.
5. Test the homepage, blog archive, CV PDFs, images, and internal links.
6. Update public references:
   - CV contact / website line if present.
   - `index.md` external self-links if any absolute GitHub URLs remain.
   - Google Scholar / Semantic Scholar / OpenReview / X / LinkedIn / GitHub profile.
7. Keep the old GitHub Pages site alive for at least 6-12 months with a clear "Moved to ..." notice.
8. After search engines pick up the new URL, decide whether to leave GitHub as a mirror or redirect-only stub.

## Repo-Specific Notes

- This repo is currently a GitHub Pages project site with `baseurl: "/brandomiranda/"`.
- `experiments/` is excluded from Jekyll publishing, so this planning folder will not appear on the public site.
- There is no current `CNAME` file.
- If the new site is hosted at a domain root, most links should become easier because `baseurl` can be empty.
- If the new site is hosted under `/people/<csid>/`, keep `site.baseurl` links and build with the CS path.

## Decision

Preferred path:

1. Ask CS support whether Brando can publish a static Jekyll-generated personal site at `https://cs.stanford.edu/people/<csid>/`.
2. If yes, deploy generated `_site/` there and keep GitHub as source control.
3. If no, use Stanford Domains and request `brandomiranda.stanford.edu` or another clean Stanford-branded name.
4. Avoid making `web.stanford.edu/~<sunetid>/` the canonical URL unless the other two paths fail.

## Sources Checked

- Stanford CS personal pages: https://legacy.cs.stanford.edu/computing-guide/web-pages
- Stanford Domains service: https://uit.stanford.edu/service/sudomains
- Stanford Domains custom `stanford.edu` domain: https://domains.stanford.edu/support/getting-started/custom-stanford-domain/
- Stanford personal website options: https://uit.stanford.edu/guide/website/personal
- Basic Stanford WWW for individual users: https://uit.stanford.edu/service/web/centralhosting/howto_user
- Stanford Vanity URL service: https://uit.stanford.edu/service/vanityurl
- GitHub Pages custom domains: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
