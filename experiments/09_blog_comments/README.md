# Experiment 09: Blog Comments

Status: planning note only. Do not ship a native comments feature until the maintenance tradeoff feels worth it.

Last updated: May 17, 2026.

## Goal

Decide whether Brando's blog should have native comments at the bottom of posts, in addition to linking to the X/Twitter discussion thread.

Current target post:

- Blog post: https://brando90.github.io/brandomiranda/2026/04/22/formal-methods-scalable-oversight.html
- X/Twitter thread: https://x.com/BrandoHablando/status/2056074520491139400?s=20

Minimum already worth doing:

- Put the X/Twitter discussion link at the bottom of the current post.

## Recommendation

Do not build a custom comment backend. The site is static Jekyll on GitHub Pages, so native comments need an external persistence layer. The lowest-maintenance path is:

1. Keep the X/Twitter discussion link on the current post.
2. If comments still feel valuable after one or two posts, use Giscus.
3. Store comments in GitHub Discussions, not in a private database.
4. Enable comments only on selected posts first, not globally.

This gives readers a place to leave long-form comments without creating a moderation-heavy system from scratch.

## Where Comments Would Be Saved

Options:

- Giscus: saves comments as GitHub Discussions in the `brando90/brandomiranda` repo. Pros: open, GitHub-native, no ad-tech feel, works well with static sites. Cons: readers need GitHub accounts, and Brando still moderates discussions.
- Utterances: saves comments as GitHub Issues. Pros: simple. Cons: issues are a worse fit than discussions for blog comments.
- Disqus: saves comments on Disqus. Pros: common and easy. Cons: heavier third-party embed, privacy/ad-tech concerns, visually less aligned with a personal academic site.
- Staticman or custom forms: saves comments as files/PRs in the repo. Pros: owned data. Cons: much more setup and spam handling.

Preferred storage: GitHub Discussions via Giscus.

## Workload Risk

Native comments may create more work:

- Moderation for spam, low-effort comments, and argumentative threads.
- Extra GitHub notifications.
- Visual maintenance when the site theme changes.
- Another place to check in addition to X/Twitter.

Native comments may still be worth it:

- Readers who do not use X can respond.
- Technical comments can be more durable and searchable.
- GitHub Discussions fit the likely audience for Lean/formal-methods posts.

Decision rule: add native comments only if the X thread gets useful replies that would have been better preserved next to the post, or if readers ask for a non-X place to comment.

## Proposed Implementation

Phase 0: Current post only.

- Add a short `Discuss` section at the bottom of the post.
- Link to the X/Twitter thread.
- Do not enable a comment provider yet.

Phase 1: Giscus pilot on one post.

- Enable GitHub Discussions on `brando90/brandomiranda`.
- Create a `Blog comments` discussion category.
- Configure Giscus for:
  - repository: `brando90/brandomiranda`
  - mapping: `pathname`
  - reactions: enabled
  - input position: bottom
  - theme: `preferred_color_scheme`
  - language: English
- Add an include such as `_includes/comments.html`.
- Add a post frontmatter flag, for example `comments: true`.
- Render the include only when `page.comments == true`.
- Test on the formal-methods post first.

Phase 2: Decide whether to expand.

- If moderation is light and comments are useful, enable comments on future technical posts.
- If comments are noisy or duplicate X discussion, keep only the X/Twitter discussion link.

## Acceptance Criteria

For the pilot to be worth keeping:

- The post renders cleanly on desktop and mobile.
- Comments appear only on posts that opt in.
- No custom server, database, or secrets are required.
- The comment area does not dominate the citation/footer area.
- Brando has a clear moderation path through GitHub Discussions.

## Open Questions

- Should every new post get a discussion link, or only posts that are actively shared?
- Should comment links say "Discuss on X" or "Discussion" for a less platform-specific tone?
- Would GitHub-only login exclude too much of the intended audience?
- Should comments live before or after the citation block on academic-style posts?

## References

- Giscus: https://giscus.app/
- GitHub Discussions overview: https://docs.github.com/en/discussions/collaborating-with-your-community-using-discussions/about-discussions
- GitHub discussion categories: https://docs.github.com/en/discussions/managing-discussions-for-your-community/managing-categories-for-discussions
