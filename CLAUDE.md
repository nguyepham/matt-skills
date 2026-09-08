# CLAUDE.md

This file provides guidance to Tau when working with code in this repository.

## Commands

This repository hosts agent skills (Markdown/YAML), so it does not have traditional build or test steps. Instead, skills are linked to your local instance during development.

- **Install/Link Skills locally**: `./scripts/link-skills.sh`
  Creates symlinks from `~/.claude/skills/` to the directories in `skills/`.
- **Uninstall/Unlink Skills**: `./scripts/unlink-skills.sh`
  Removes the symlinks from `~/.claude/skills/`.

## Architecture & Structure

This repository provides reusable, model-agnostic skills (slash commands and behaviors) for Tau/Claude Code. It is designed to fix common agent failure modes like misalignment, verbosity, and broken code by enforcing shared language and feedback loops.

### Directory Structure

- **`skills/`**: The core implementations.
  - **`skills/engineering/`**: Skills for daily code work (e.g., `matt-tdd`, `matt-code-review`, `matt-to-spec`).
  - **`skills/productivity/`**: Skills for general workflows (e.g., `matt-handoff`, `matt-grilling`).
  - Every skill is encapsulated in its own directory containing a **`SKILL.md`** file, which is the entry point defining the skill's trigger and prompt instructions.
  - Specialized sub-agents (if any) are defined in an `agents/` subdirectory (e.g., `agents/openai.yaml`).
- **`docs/`**: Markdown documentation explaining the usage and inner workings of each skill.
- **`CONTEXT.md`**: Defines the shared domain language (e.g., "Issue tracker", "Triage role"). Updates to project vocabulary should go here.

### Skill Design Principles

- **User-invoked vs Model-invoked**: User-invoked skills (like `/matt-ask`) act as orchestrators and are triggered manually. Model-invoked skills (like `matt-tdd`) are reusable primitives triggered automatically or manually. A user-invoked skill cannot invoke another user-invoked skill.
- **Alignment & Shared Language**: Skills like `matt-grill-with-docs` explicitly build a shared domain understanding (`CONTEXT.md` and ADRs) before coding begins to prevent misalignment and verbosity.
- **Feedback Loops**: Skills rely heavily on tools and static validation (e.g., `matt-tdd` using red-green-refactor loops) rather than blind generation to avoid architectural rot.
