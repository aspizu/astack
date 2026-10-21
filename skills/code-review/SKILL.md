---
name: code-review
description: Review code.
---

If you implemented the changes being reviewed, do not review your own output. Launch a
sub-agent to perform the review instead. consider staged + unstaged diff unless
specified otherwise. default to considering the current branch compared to merge base if
no uncommitted changes. Don't tell me what is good or passes, tell me what is bad or has
failed. write findings in chat, not as review comments. number findings. Don't recommend
solutions. keep finding issues until you find at least one. Sort findings by difficulty
to fix. Mark easiest to fix findings with (Easy)

Response Format:

## Problems

<!-- Examples adapted from the reported discussion findings in https://github.com/aspizu/blasts/pull/10, including findings on earlier revisions. -->

### [1] Title punctuation breaks Discord links (Easy)

[src/services/syndication/discord.ts:14](src/services/syndication/discord.ts:14)

A supplied or fetched title is inserted directly into a Markdown link label. A closing
bracket in the title can break the link syntax, so the title no longer renders as the
intended clickable link.

For example, the title `The interval (0, 1]` produces
`[The interval (0, 1]](https://example.com)`.

### [2] Mastodon truncation discards emoji that fit within the limit

[src/services/syndication/mastodon.ts:22-26](src/services/syndication/mastodon.ts:22)

The truncation loop counts UTF-16 code units rather than Mastodon's grapheme clusters.
This discards valid text unnecessarily and can split combined graphemes.

For example, a text-only blast containing 500 emoji is reduced to 250 even though
Mastodon accepts all 500.

### [3] Short URLs in blast text can make Mastodon reject the post

[src/services/syndication/mastodon.ts:23](src/services/syndication/mastodon.ts:23)

Only the separate external link receives Mastodon's fixed 23-character URL adjustment.
URLs embedded in the text are counted by their JavaScript string length, so a status
that appears to fit can exceed Mastodon's limit. The blast remains saved locally, but
syndication only logs the failure.

For example, 480 ASCII letters followed by ` https://x.com` passes through at 494
characters, but Mastodon counts it as 504 and rejects the post.

### [4] Truncation can remove part of an embedded URL

[src/services/syndication/mastodon.ts:17](src/services/syndication/mastodon.ts:17)

Trailing punctuation is stripped from URL tokens even when a closing parenthesis belongs
to a balanced pair in the URL. That parenthesis is then treated as ordinary text and can
be truncated, changing the destination.

For example, 476 ASCII letters followed by
` https://en.wikipedia.org/wiki/Function_(mathematics)` loses the final `)`, even though
the complete status fits exactly within Mastodon's 500-character limit.
