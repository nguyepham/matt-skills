# CLAUDE.md

This file provides guidance to Tau when working with code in this repository.

## Overview
This repository contains a collection of composable, model-agnostic agent skills for engineering tasks (like TDD, code review, documentation generation, and domain modeling).

## Architecture & Structure
- **`skills/`**: Contains the various agent skills.
  - **`skills/engineering/`**: Engineering-specific skills.
    - **User-invoked skills**: Orchestration tools manually triggered by the user (e.g., `ask-matt`, `grill-with-docs`, `triage`, `improve-codebase-architecture`, `setup-matt-pocock-skills`, `to-spec`, `to-tickets`, `implement`, `wayfinder`). User-invoked skills cannot invoke other user-invoked skills.
    - **Model-invoked skills**: Reusable primitives automatically triggered or typed manually (e.g., `prototype`, `tdd`, `domain-modeling`, `codebase-design`, `code-review`).
  - **`skills/productivity/`**: General workflow tools (e.g., `handoff`, `to-questionnaire`, `wait-what`, `grilling`).
- **`.agents/`**: Contains ADRs and documentation about the agents.
- **`CONTEXT.md`**: Contains shared domain language and terminology. Keep this updated to ensure consistent naming and understanding across the codebase.

## Workflow & Guidelines
- **Setup**: Run `/setup-matt-pocock-skills` once per repository to configure issue tracking, triage labels, and docs location.
- **Alignment**: Use `/grill-with-docs` before starting work to build shared language and ensure alignment between the agent and the user.
- **Development**:
  - Prefer the red-green-refactor loop using `/tdd`. Write failing tests before fixing code.
  - Active design is encouraged. Run `/improve-codebase-architecture` frequently and use `/to-spec` before implementing large changes.
- **Terminology**: Always use the domain jargon established in `CONTEXT.md` to maintain consistency and reduce token costs.