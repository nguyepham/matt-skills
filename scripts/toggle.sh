#!/bin/sh
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

FIRST=$(find "$ROOT_DIR/skills" -name SKILL.md -exec dirname {} \; 2>/dev/null | head -n 1)
[ -z "$FIRST" ] && exit 0

if [ -L ~/.claude/skills/"$(basename "$FIRST")" ]; then
    find "$ROOT_DIR/skills" -name SKILL.md -exec dirname {} \; | while read -r dir; do
        rm -f ~/.claude/skills/"$(basename "$dir")"
    done
else
    find "$ROOT_DIR/skills" -name SKILL.md -exec dirname {} \; | while read -r dir; do
        ln -sfn "$dir" ~/.claude/skills/
    done
fi
