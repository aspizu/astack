---
name: github-actions
description: Use when dealing with GitHub actions.
---

Run `gh actions-lock` whenever you add a workflow that has uses dependencies, or add or remove uses dependencies in an existing workflow.

Verify a specific workflow

```sh
gh actions-lock .github/workflows/ci.yml
```

Read-only check for CI integration (writes nothing, exits 1 if invalid)

```sh
gh actions-lock --no-fix --json=valid,findings
```

If a local action in your checkout uses other actions, the extension reports a local-action error and writes nothing, because those actions would fail at run time without lockfile entries. To lock the local action as a same-repository reference, run:

```sh
gh actions-lock --migrate-local-actions
```

Verify lockfiles in CI, pin to the latest version after verifying its safe.

```yaml
- run: gh extension install github/gh-actions-lock --pin vX.Y.Z
- run: gh actions-lock --verify
```

actionlint could be useful.
