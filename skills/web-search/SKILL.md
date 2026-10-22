---
name: web-search
description: Perform a web search
---

# Exa Search

`POST https://api.exa.ai/search` Header: `x-api-key: $EXA_API_KEY`

If you already have URLs and only need page content, use `POST /contents` instead.

## Example

```bash
curl -sS -X POST "https://api.exa.ai/search" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $EXA_API_KEY" \
  -d '{
    "query": "AI regulation policy updates",
    "type": "auto",
    "numResults": 5,
    "category": "news",
    "includeDomains": ["reuters.com"],
    "startPublishedDate": "2025-01-01",
    "contents": {
      "highlights": true,
      "maxAgeHours": 24
    }
  }'
```

## Request parameters

| Parameter                                 | Description                                                                         |
| ----------------------------------------- | ----------------------------------------------------------------------------------- |
| `query` (required)                        | Natural-language query. Long, descriptive queries work well.                        |
| `type`                                    | `auto` (default), `fast`, `instant`, `deep-lite`, `deep`, `deep-reasoning`.         |
| `numResults`                              | Default 10, max 100.                                                                |
| `category`                                | `company`, `people`, `research paper`, `news`, `personal site`, `financial report`. |
| `includeDomains` / `excludeDomains`       | Domain, path, or wildcard lists.                                                    |
| `startPublishedDate` / `endPublishedDate` | ISO 8601 date bounds.                                                               |
| `userLocation`                            | Two-letter country code, e.g. `US`.                                                 |
| `systemPrompt`                            | Instructions for synthesis/deep search (e.g. source preferences).                   |
| `outputSchema`                            | JSON Schema for synthesized `output.content`.                                       |
| `stream`                                  | `true` for SSE (requires `outputSchema`).                                           |

### `contents` (all page-content options are nested here)

| Parameter          | Description                                                                              |
| ------------------ | ---------------------------------------------------------------------------------------- |
| `text`             | `true` or `{"maxCharacters": N}`. Full page text as markdown.                            |
| `highlights`       | `true` (preferred) or `{"query": "...", "maxCharacters": N}`. Query-relevant excerpts.   |
| `summary`          | `true` or `{"query": "...", "schema": {...}}`. Per-result LLM summary.                   |
| `maxAgeHours`      | Freshness: `0` = always live crawl, `-1` = cache only, omit = cache with crawl fallback. |
| `livecrawlTimeout` | Ms, default 10000.                                                                       |
| `subpages`         | Number of subpages to crawl per result.                                                  |
| `subpageTarget`    | String or array of terms to prioritize subpages (e.g. `["pricing"]`).                    |
| `extras.links`     | Number of links to extract per result.                                                   |

Pick one of `text`, `highlights`, or `summary` unless you truly need several.

## Search types

- `auto`: default, balanced.
- `fast` / `instant`: lowest latency (instant is fastest).
- `deep-lite` / `deep` / `deep-reasoning`: multi-step research and synthesis, with
  increasing latency and depth.

## Structured output

Add `outputSchema` (compact, shallow, arrays declare `items`). Don't include citation
fields; grounding is returned separately.

```json
{
  "query": "compare the latest frontier AI model releases",
  "type": "deep",
  "systemPrompt": "Prefer official sources.",
  "outputSchema": {
    "type": "object",
    "properties": {
      "models": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "name": { "type": "string" },
            "notable_claims": { "type": "array", "items": { "type": "string" } }
          },
          "required": ["name", "notable_claims"]
        }
      }
    },
    "required": ["models"]
  },
  "contents": { "highlights": true }
}
```

## Streaming

Send `"stream": true` with `outputSchema`, plus `curl -N` and
`Accept: text/event-stream`. Each `data:` frame is an OpenAI-style chunk; read
`choices[0].delta.content`. Without `outputSchema`, you get normal JSON.

## Response

- `results[]`: `title`, `url`, `publishedDate`, `author`, plus `text`, `highlights`,
  `summary`, `subpages`, `extras.links` if requested.
- `output.content`: synthesized result (when `outputSchema` is set).
- `output.grounding`: citations and confidence for synthesized fields.
- `requestId`, `costDollars.total`, `searchTime`.

## Pitfalls

- Nest `text`/`highlights`/`summary` under `contents`, never at top level (that shape is
  for `/contents`).
- Use `contents.text.maxCharacters`, not `tokensNum`.
- Use `contents.maxAgeHours`, not `livecrawl`.
- Don't use `useAutoprompt`, `numSentences`, or `highlightsPerUrl`.
- `company` and `people` categories don't support date filters. `people` doesn't support
  `excludeDomains`, and its `includeDomains` accepts only LinkedIn domains.
