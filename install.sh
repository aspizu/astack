#!/usr/bin/env bash
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local target="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    rm -rf "$dest.bak"
    mv "$dest" "$dest.bak"
    echo "backed up $dest to $dest.bak"
  fi
  ln -sfn "$target" "$dest"
  echo "linked $dest -> $target"
}

if command -v opencode >/dev/null 2>&1; then
  link "$REPO/SMITH.md" "$HOME/.config/opencode/AGENTS.md"
  link "$REPO/skills" "$HOME/.config/opencode/skills"
else
  echo "opencode not installed, skipping"
fi

if command -v codex >/dev/null 2>&1; then
  link "$REPO/SMITH.md" "$HOME/.codex/AGENTS.md"
  link "$REPO/skills" "$HOME/.codex/skills"
else
  echo "codex not installed, skipping"
fi

if command -v claude >/dev/null 2>&1; then
  link "$REPO/SMITH.md" "$HOME/.claude/CLAUDE.md"
  link "$REPO/skills" "$HOME/.claude/skills"
else
  echo "claude not installed, skipping"
fi
