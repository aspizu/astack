---
name: reddit-search
description: Search or view posts and discussion on Reddit.
---

# Search posts

Use Reddit's search RSS endpoint without authentication:

```bash
curl -fsSL --max-time 30 -A 'post-reader/1.0' \
  -G 'https://www.reddit.com/search.rss' \
  --data-urlencode 'q=subreddit:developersIndia macos' \
  --data-urlencode 'type=link' \
  --data-urlencode 'sort=relevance' \
  --data-urlencode 'limit=5'
```

# Read threads

Use Reddit's RSS endpoint to retrieve a post and comments without authentication:

```bash
curl -fsSL --max-time 30 -A 'post-reader/1.0' \
  'https://www.reddit.com/comments/POST_ID/.rss'
```

Back off before retrying; avoid rapid or parallel requests.
