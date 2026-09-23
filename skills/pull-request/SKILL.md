---
name: pull-request
description: Create a Pull Request
---

if current branch is main, consider a new PR, else consider a new stacked PR on top of current branch.

If there are uncommitted changes, use the $commit skill.

Use the $code-review skill, run lints and typecheckers, stop if failed.

Use the following command to create a new branch:

```bash
git switch -c "apz/$(cat /dev/urandom | LC_ALL=C tr -dc 'a-z0-9' | head -c 8)"
```

Squash all commits up to merge base into a single commit, then push and create PR using gh command. Use gh stack for stacked PRs.