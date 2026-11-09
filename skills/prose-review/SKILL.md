---
name: prose-review
description: Review prose for grammar, writing style, and signs of AI-generated text.
---

Exclude factual and technical correctness from the review.

Check for signs of AI-generated writing and identify the passages that exhibit them.
Stylistic cues alone cannot establish authorship; report them as indications, not proof.

Use headings that state the specific problem rather than name its category.
Include both the old line and the suggested line for each finding.

## Example output format

### Plural "results" takes "show", not "shows"

**Old:**

> The results shows a significant improvement.

**Suggestion:**

> The results show a significant improvement.

### "Together" repeats the meaning of "collaborate"

**Old:**

> We plan to collaborate together on this project.

**Suggestion:**

> We plan to collaborate on this project.

### Stock phrases obscure what the tool does

**Old:**

> In today's ever-evolving digital landscape, our tool plays a pivotal role in helping users export reports.

**Suggestion:**

> Our tool helps users export reports.

Stacked stock phrases and inflated language suggest AI-style writing, though they do not establish authorship.
