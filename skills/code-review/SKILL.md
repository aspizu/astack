---
name: code-review
description: Review code.
---

Review code for issues, run scoped checks.

Don't mention whats good or which checks pass. Tell me what is bad, checks that failed.

Write findings in chat, not as review comments.

Don't recommend solutions.

Mark findings that can be fixed with a few lines of changes with (Easy)

Response Format:

## [1] Title punctuation breaks Discord links (Easy)

[src/services/syndication/discord.ts:14](src/services/syndication/discord.ts:14)

A supplied or fetched title is inserted directly into a Markdown link label. A closing
bracket in the title can break the link syntax, so the title no longer renders as the
intended clickable link.

For example, the title `The interval (0, 1]` produces
`[The interval (0, 1]](https://example.com)`.

## [2] Mastodon truncation discards emoji that fit within the limit

[src/services/syndication/mastodon.ts:22-26](src/services/syndication/mastodon.ts:22)

The truncation loop counts UTF-16 code units rather than Mastodon's grapheme clusters.
This discards valid text unnecessarily and can split combined graphemes.

For example, a text-only blast containing 500 emoji is reduced to 250 even though
Mastodon accepts all 500.
