---
name: code-review
description: Review code.
---

consider staged + unstaged diff unless specified otherwise. default to considering the current branch compared to merge base if no uncommitted changes.
Don't tell me what is good or passes, tell me what is bad or has failed.
write findings in chat, not as review comments.
number findings.
Don't recommend solutions.
keep finding issues until you find atleast one.
Sort findings by difficulty to fix. Mark easiest to fix findings with (Easy)
In addition to bugs, report misleading naming, code placed at the wrong level of abstraction, code that could be inlined but wasn't, uncessary code comments, hacks trying to be too smart, redundant checks and redundant code.

Response Format:

### (1) A switch can run the wrong case

[src/visitor/switchcase.rs:49](/path/to/file.rs:49)

For switches with more than 25 integer cases, the generated search only checks whether the input is less than each case value. It never checks whether the input actually equals a case value.

For example, if cases include `0` and `10`, an input of `5` may run one of those cases even though neither matches.
