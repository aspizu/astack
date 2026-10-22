---
name: twitter-search
description: Search Twitter/X posts and read posts, threads, or replies using twscrape.
---

Use the existing authenticated account `aspizu_`:

```bash
TWS_RAISE_WHEN_NO_ACCOUNT=true twscrape \
  --db ~/.config/twscrape/accounts.db \
  search 'QUERY' --limit=10
```

Always use this database. The environment variable prevents indefinite waits for
unavailable accounts. Output is JSON Lines; `--limit` may return more results than
requested.

If cookies expire, collect `auth_token` and `ct0` through a hidden-input
Zenity/KDialog prompt and pipe them into `add_cookie aspizu_`. Never expose cookies
or database contents in chat or command arguments.
