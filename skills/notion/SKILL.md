---
name: notion
description: Search, read, create, and update Notion pages and lists using the ntn CLI.
---

# Notion

Use `ntn api`; authentication is managed by the CLI. Pass JSON with `-d`.
GET is the default; supplying a body implies POST. Use `-X PATCH` for updates.

```bash
ntn api ls
ntn api /v1/pages --spec
ntn api /v1/pages --docs
ntn api /v1/search -d '{"query":"Things To Buy"}'
ntn api /v1/data_sources/DATA_SOURCE_ID
ntn api /v1/data_sources/DATA_SOURCE_ID/query -d '{}'
ntn api /v1/pages/PAGE_ID/markdown
```

Search matches page and data-source titles. Query data sources for entries.
Use `--spec` or `--docs` for endpoint schemas. Paginate with `start_cursor`
from `next_cursor` while `has_more` is true.

Create entries using the data-source ID, not the database ID:

```bash
ntn api /v1/pages -d '{
  "parent":{"data_source_id":"DATA_SOURCE_ID"},
  "properties":{
    "Name":{"title":[{"text":{"content":"Item name"}}]},
    "Estimated cost":{"number":556},
    "Product link":{"url":"https://example.com/product"}
  }
}'
```
