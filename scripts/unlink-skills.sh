#!/bin/bash
set -e

find "$(pwd)/skills" -name SKILL.md -exec dirname {} \; | while read -r dir; do
    rm -f ~/.claude/skills/$(basename "$dir")
done
