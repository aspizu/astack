---
name: pull-request
description: Create a Pull Request
---

Do a very quick code review and run lints and typecheck before, stop if failed.

If the current branch is linked to a PR, and there are dirty changes, then create a new stacked PR using gh cli 
Create a new branch using the following command if not already on a branch:

```bash
git switch -c "apz/$(cat /dev/urandom | LC_ALL=C tr -dc 'a-z0-9' | head -c 8)"
```

Create a single commit using $commit if not already.
Else, squash all commits into one single commit before pushing.