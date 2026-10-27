# CI workflows for the site

These two files belong in `.github/workflows/`. The agent's GitHub token is not allowed to write that folder, so
someone with a normal login copies them once:

    mkdir -p .github/workflows && cp ci-workflows/site-*.yml .github/workflows/ && git add .github && git commit -m "Add site CI and uptime workflows" && git push

- `site-ci.yml`: every push and pull request builds the Stanford version and runs `scripts/check_site.py --dir _site`.
- `site-uptime.yml`: every 30 minutes `scripts/check_site.py --url https://cs.stanford.edu/people/brando9/`; a failure emails the owner and opens a "Site down" issue.

The publisher on `ilc.stanford.edu` also runs `scripts/check_site.py --dir _site` before copying, so a build that breaks links never reaches the live page.
- Publish gate: `scripts/check_site.py --dir _site` also fails when the built site holds a private-looking file (anything under professional_documents/ outside papers, posters, cvs, awards, or a name with application, letter, token, private and similar words). Private drafts live in `exclude/`, which the build skips.
