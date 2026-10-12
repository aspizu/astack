---
name: pull-request
description: Create a Pull Request
---

Never use Computer Use to create a pull request on GitHub. Use a GitHub MCP tool, the GitHub API, or the `gh` CLI instead.

Run $code-review in a sub-agent. Don't fix findings, stop instead. Run lints, checks, ... Stop immediately if failed.

After the PR is created, do not commit or push unless asked to.

After the PR is published on GitHub, when making changes, update PR title/desc if scope changed.
