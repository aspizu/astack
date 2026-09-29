---
name: glm-review
description: Run a code review with GLM 5.3 through OpenCode
---

Run the review through OpenCode with `zai-coding-plan/glm-5.3`.
Have GLM use the existing [code-review](../code-review/SKILL.md) skill.

```sh
opencode run \
  --dir /path/to/repository \
  --model zai-coding-plan/glm-5.3 \
  "<prompt>"
```

Do not dismiss the findings you think are invalid, defeats the point of using GLM.
