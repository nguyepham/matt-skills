#!/bin/bash
set -e

mkdir -p ~/.claude/skills
find "$(pwd)/skills" -name SKILL.md -exec dirname {} \; | xargs -I {} ln -sfn {} ~/.claude/skills/
