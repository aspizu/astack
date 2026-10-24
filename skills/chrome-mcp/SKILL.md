---
name: chrome-mcp
description: Control the user's running Helium browser through chrome-devtools-mcp using mcp2cli. Use for browser interaction, screenshots, network inspection, and browser debugging.
---

# Helium through mcp2cli

Use the running Helium browser and its existing profile. Never launch a separate browser, copy the profile, or restart Helium without permission.

Reuse an existing session (`mcp2cli --session-list`), or start one:

```bash
mcp2cli \
  --mcp-stdio 'npx -y chrome-devtools-mcp@latest --auto-connect --user-data-dir=/home/aspizu/.config/net.imput.helium --no-usage-statistics --no-performance-crux' \
  --session-start chrome
```

Requires remote debugging enabled in Helium at `chrome://inspect/#remote-debugging`; the user may need to approve access. If connection fails, report it rather than launching another browser. For an existing HTTP debugging endpoint, replace `--auto-connect --user-data-dir=...` with `--browser-url URL`.

```bash
mcp2cli --session chrome --list
mcp2cli --session chrome TOOL --help
mcp2cli --session chrome list-pages
mcp2cli --session chrome take-snapshot --page-id ID
mcp2cli --session chrome click --page-id ID --uid UID
```

CLI names use kebab-case. Complex arguments accept `--stdin` JSON with the original MCP schema keys. `--json` preserves the full result envelope, including `isError`.

Filesystem access defaults to temporary directories; configure `--root PATH` or server `--workspace PATH` if needed.

Stop sessions you created when finished: `mcp2cli --session-stop chrome`. Leave pre-existing sessions and user tabs alone.
