---
name: raindrop
description: Search, save, update, and organize Raindrop.io bookmarks through its REST API. Use for Raindrop collections, tags, notes, highlights, and bulk bookmark operations.
---

API base: `https://api.raindrop.io/rest/v1`.

Authenticate only with `Authorization: Bearer $RAINDROP_ACCESS_TOKEN`. If the token
is missing or invalid, ask the user to supply a valid one. Do not use Chrome MCP.

## Collections and lookup

Fetch both `/collections` and `/collections/childrens` to resolve collection names
to numeric IDs. The spelling `childrens` is intentional. Parent references use
`parent["$id"]`; use the hierarchy to distinguish duplicate collection names.

| Method | Path | Returns |
| --- | --- | --- |
| GET | `/collections` | Root collections in `.items` |
| GET | `/collections/childrens` | All nested collections in `.items` |
| GET | `/collection/{id}` | Collection in `.item` |
| GET | `/user/stats` | System collection counts in `.items` |
| GET | `/raindrop/{id}` | Bookmark, including notes and highlights, in `.item` |
| GET | `/tags` | All tags and counts in `.items` |
| GET | `/tags/{collectionId}` | Tags within a collection |
| GET | `/highlights` | Paginated highlights in `.items` |
| GET | `/highlights/{collectionId}` | Paginated highlights within a collection |

System collection IDs: `0` = all bookmarks except Trash (listing/search only),
`-1` = Unsorted, `-99` = Trash.

## Search and pagination

`GET /raindrops/{collectionId}` lists or searches bookmarks.

| Parameter | Behavior |
| --- | --- |
| `search` | Omit to list everything; filters below |
| `page` | Zero-based |
| `perpage` | Maximum 50 for bookmarks and highlights |
| `nested` | `true` includes descendant collections |
| `sort` | `-created` (default), `created`, `title`, `-title`, `domain`, `-domain`, `-sort`, or `score` (search only) |

Continue pagination until `.items` is empty or shorter than `perpage`.

Search supports words, `"exact phrases"`, `#tag`, `#"multi-word tag"`, `-#tag`,
`type:article`, `title:word`, `link:word`, `note:word`, `created:2024-01`,
`notag:true`, and `match:OR`.

## Bookmarks and highlights

`POST /raindrop` requires `link`. Bookmark and collection IDs are integers;
collection references use `{"$id":12345}`.

```json
{"link":"https://example.com/article","collection":{"$id":-1},"pleaseParse":{}}
```

Optional fields: `title`, `excerpt`, `note`, `tags` (string array), and `important`
(favorite boolean). `pleaseParse: {}` requests asynchronous metadata parsing, so
metadata may be absent from the immediate response.

`PUT /raindrop/{id}` updates the supplied fields:

| Change | JSON body |
| --- | --- |
| Rename | `{"title":"New title"}` |
| Set note | `{"note":"Reading notes"}` |
| Favorite | `{"important":true}` |
| Move | `{"collection":{"$id":12345}}` |
| Replace tags | `{"tags":["reference","reading"]}` |
| Add highlight | `{"highlights":[{"text":"Quoted passage","color":"yellow","note":"My note"}]}` |
| Edit highlight | `{"highlights":[{"_id":"HIGHLIGHT_ID","note":"Updated note"}]}` |
| Remove highlight | `{"highlights":[{"_id":"HIGHLIGHT_ID","text":""}]}` |

Single-bookmark tag updates replace the full array. To add tags, merge them with
the existing tags first. Highlight edits require the existing highlight `_id`.

`DELETE /raindrop/{id}` moves the bookmark to Trash; deleting it again while in
Trash permanently removes it.

## Collection and tag writes

Keep collections private unless the user requests publication.

| Method | Path | JSON body / behavior |
| --- | --- | --- |
| POST | `/collection` | `{"title":"Reading","public":false}`; add `"parent":{"$id":12345}` for a child |
| PUT | `/collection/{id}` | `{"title":"New name"}` or `{"parent":{"$id":12345}}` |
| DELETE | `/collection/{id}` | Deletes the collection and descendants; moves their bookmarks to Trash |
| PUT | `/tags/{collectionId}` | `{"tags":["old"],"replace":"new"}` renames a tag; multiple old tags merge into the replacement |
| DELETE | `/tags/{collectionId}` | `{"tags":["obsolete"]}` removes tags from bookmarks, not the bookmarks |

Tag writes without `/{collectionId}` affect the entire library; use only for an
explicitly requested library-wide change.

## Bulk bookmarks

| Method | Path | JSON body / behavior |
| --- | --- | --- |
| POST | `/raindrops` | `{"items":[...]}` creates up to 100 bookmarks per request |
| PUT | `/raindrops/{collectionId}` | `{"ids":[111,222],"tags":["reference"]}` appends tags |
| PUT | `/raindrops/{collectionId}` | `{"ids":[111,222],"collection":{"$id":12345}}` moves bookmarks |
| DELETE | `/raindrops/{collectionId}` | `{"ids":[111,222]}` moves bookmarks to Trash; permanent when collection is `-99` |

Bulk update/delete does not support collection `0`; group bookmarks by their
actual source collection. Bulk `tags: []` clears all tags.

Always supply `ids` for selected-item writes. Omitting both `ids` and `search`
can affect the whole collection. Preview the affected scope before bulk changes.
Permanent deletion, including emptying Trash with `DELETE /collection/-99`,
requires explicit user authorization.

## Responses and limits

Responses contain `result` plus `item`, `items`, or `user`; API errors may include
`error` and `errorMessage`.

The documented OAuth request limit is 120 per minute per user. On HTTP 429,
`X-RateLimit-Reset` gives the reset time as UTC epoch seconds.

For uploads, exports, sharing, or unlisted parameters, consult the official
[documentation index](https://developer.raindrop.io/llms.txt). Documentation pages
are available as Markdown by appending `.md` to their URLs. Additional search
operators are in the [filters documentation](https://help.raindrop.io/filters.md).
