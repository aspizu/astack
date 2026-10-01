---
name: code-review
description: Review code.
---

If you implemented the changes being reviewed, do not review your own output. Launch a sub-agent to perform the review instead.
consider staged + unstaged diff unless specified otherwise. default to considering the current branch compared to merge base if no uncommitted changes.
Don't tell me what is good or passes, tell me what is bad or has failed.
write findings in chat, not as review comments.
number findings.
Don't recommend solutions.
keep finding issues until you find at least one.
Sort findings by difficulty to fix. Mark easiest to fix findings with (Easy)
After reporting the review findings, invoke the clean-code skill on the files covered by the diff.

Response Format:

## Problems

### [1] A switch can run the wrong case (Easy)

[src/visitor/switchcase.rs:49](/path/to/file.rs:49)

For switches with more than 25 integer cases, the generated search only checks whether the input is less than each case value. It never checks whether the input actually equals a case value.

For example, if cases include `0` and `10`, an input of `5` may run one of those cases even though neither matches.
