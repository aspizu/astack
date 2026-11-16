---
name: browser-use
description: Use Helium via Chrome MCP for web browsing. Do not use T3 browser tools (`mcp__t3_code__preview_*`).
---

Only use my Helium browser for a web browser via Chrome MCP.

Prefer Chrome MCP over Computer Use to control Helium.

Don't use the built-in integrated browser.

1. Start the Chrome MCP call in `functions.exec` and use `yield_control()` so it can wait in the background.
2. Use `mcp__cua_repl.js` to inspect Helium with `app.getAXState()`. Find the current accessibility index for **Allow**.
3. Click that index with `app.click(index)`, skip if no prompt was shown.
4. Check the resulting UI state, then call `functions.wait` with the cell ID to retrieve the MCP result.
