---
name: clean-code
description: Audit code cleanliness. Use when asked to check code quality, cleanliness, tidiness, or hygiene on files or a directory, as opposed to reviewing a diff for bugs.
---

If you implemented the changes being audited, do not audit your own output. Launch a sub-agent to perform the audit instead.
consider staged + unstaged diff unless specified otherwise. default to considering the current branch compared to merge base if no uncommitted changes.
Don't tell me what is good, tell me what is bad. write findings in chat, not as review comments. number findings.

# Response Format:

## Nitpicks

### [1] useKeyboardEvent mixes adapter and logic (Easy)

[src/visitor/switchcase.rs:49](/path/to/file.rs:49)

`useKeyboardEvent` adapts the `addEventListener` and `removeEventListener` API to useEffect, which should be separated out into its own abstraction, while only leaving the keyboard key checking logic here.

# What is unclean code:

Functions, methods, getters, ... that are only used once.

Misleading variable, function, method, ... names.

Mixing levels of abstraction. This is very important.

# Levels of Abstractions:

1. Language/Library/Framework/Operating System provided abstractions.

2. Adapters that translate between flavours of API.

3. Custom re-usable abstractions that the framework-level does not provide.

4. Business logic.

type 4 abstractions should most likely never be re-usable or customizable.
