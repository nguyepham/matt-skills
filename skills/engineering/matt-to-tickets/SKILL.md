---
name: matt-to-tickets
description: Break a plan, spec, or the current conversation into a set of tracer-bullet tickets, each declaring its blocking edges, published to the configured tracker (edges as text in one file per ticket locally, or native blocking links on a real tracker).
disable-model-invocation: true
---

# To Tickets

break plan/spec/conversation into **tickets** (tracer-bullet vertical slices + blocking edges).

missing tracker/triage vocabulary => prompt user for `/matt-skill-setup`.

## Process

### 1. Gather context

use current conversation context. passed reference (spec path, issue number, URL) => fetch & read full body + comments.

### 2. Explore codebase (optional)

unexplored codebase => explore. understand current state.
ticket titles & descriptions => use project domain glossary + respect ADRs.
find prefactor opportunities. make change easy + make easy change.

### 3. Draft vertical slices

break work into **tracer bullet** tickets.

<vertical-slice-rules>

- narrow complete path through every layer (schema, API, UI, tests). vertical > horizontal slice.
- completed slice = demoable/verifiable alone.
- slice size <= single fresh context window.
- prefactor first.

</vertical-slice-rules>

assign **blocking edges** (required tickets before start). zero blockers = start immediately.

**exception: wide refactors**. wide refactor = one mechanical change (rename column, retype shared symbol) + massive blast radius. single edit breaks call sites. sequence as **expand-contract**.
1. expand: add new form beside old. zero breakage.
2. migrate: update call sites in blast-radius batches (per package, per directory). each batch = own ticket (blocked by expand). keep CI green (old form exists).
3. contract: delete old form (zero callers remain). ticket blocked by all migrate batches.
batches break CI => share integration branch. block final integrate-and-verify ticket. promise green there.

### 4. Quiz user

present proposed breakdown (numbered list). per ticket:
- **Title**: short descriptive name
- **Blocked by**: required preceding tickets
- **What it delivers**: end-to-end behavior

ask user:
- correct granularity? (too coarse/fine)
- correct blocking edges?
- merge/split tickets?

iterate => user approves breakdown.

### 5. Publish

publish approved tickets. shape depends on `/matt-skill-setup` tracker.

- **Local files** => write 1 file per ticket in `.scratch/<feature-slug>/issues/<NN>-<slug>.md`. number `01` upwards (dependency order, blockers first). "Blocked by" lists dependency numbers/titles. use `<local-ticket-template>`.
- **Real tracker (GitHub, Linear)** => publish 1 issue per ticket (dependency order, blockers first). use native blocking/sub-issue relationships. fallback: list blocking issues in "Blocked by". apply `ready-for-agent` label.

work **frontier** (tickets with zero pending blockers). linear chain => top to bottom.

preserve parent issue (zero close/modify).

<local-ticket-template>

# <NN>: <Ticket title>

**What to build:** end-to-end user-perspective behavior. skip layer-by-layer list.

**Blocked by:** gating ticket numbers/titles. fallback: "None (can start immediately)".

**Status:** ready-for-agent

- [ ] Acceptance criterion 1
- [ ] Acceptance criterion 2

</local-ticket-template>

<issue-template>

## Parent

parent issue reference. (skip if no parent).

## What to build

end-to-end user-perspective behavior. skip layer-by-layer list.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Blocked by

- gating ticket references. fallback: "None (can start immediately)".

</issue-template>

avoid file paths & code snippets (prevent stale data). exception: matt-prototype snippet (state machine, reducer, schema, type shape). inline snippet + note matt-prototype origin. trim to decisions (skip working demo).
