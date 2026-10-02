---
name: pull-request
description: Create a Pull Request
---

Run $code-review in a sub-agent. Don't fix findings, stop instead. Run lints, checks, ... Stop immediately if failed.

After the PR is created, do not commit or push unless asked to.

After the PR is published on GitHub, when making changes, update PR title/desc if scope changed.

For UI changes, capture screenshots of the affected screens and attach them to the PR description as inline base64 images.
Make sure the screenshots are not low resolution.

PR description should only include the product decisions.
