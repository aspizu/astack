---
name: pull-request
description: Create a Pull Request
---

Run $code-review and $glm-review in parallel sub-agents. Don't fix findings, stop instead. Run lints, checks, ... Stop immediately if failed.

After the PR is published on GitHub, when making changes, update PR title/desc if scope changed.

For UI changes, capture screenshots of the affected screens (use the browser preview or a simulator) and attach them to the PR description.
Make sure the screenshots are not low resolution.

PR descriptions should a very short paragraph, no other sections.
