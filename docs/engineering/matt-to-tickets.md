## What it does

`matt-to-tickets` converts plan, [spec](https://www.aihero.dev/ai-coding-dictionary/spec), or conversation into **[tickets](https://www.aihero.dev/ai-coding-dictionary/ticket)**. Each ticket declares **blocking edges**: dependencies requiring completion first.

Every ticket = **tracer bullet**: narrow complete path through all layers (schema, API, UI, tests). Demoable immediately. Prevents layer-by-layer splitting. Sizes ticket for single [context window](https://www.aihero.dev/ai-coding-dictionary/context-window). [session](https://www.aihero.dev/ai-coding-dictionary/session) picks up ticket.

## When to reach for it

Invoke via `/matt-to-tickets`. [agent](https://www.aihero.dev/ai-coding-dictionary/agent) skips automatic invocation.

| State | Action |
| --- | --- |
| Spec issue + multi-session build | `/matt-to-tickets` or `/matt-to-tickets #<spec_issue>` |
| Unwritten plan in conversation | `/matt-to-tickets` |
| Single context window change | [implement](../../skills/engineering/matt-implement/SKILL.md) |
| Undecided | [matt-grill-with-docs](../../skills/engineering/matt-grill-with-docs/SKILL.md) => [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) |
| [matt-wayfinder](../../skills/engineering/matt-wayfinder/SKILL.md) map cleared | [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) => `/matt-to-tickets` |

Tickets = agent-ready. Skip [triage](../../skills/engineering/matt-triage/SKILL.md).

## Prerequisites

Configure issue tracker via [matt-skill-setup](../../skills/engineering/matt-skill-setup/SKILL.md) + triage-label vocabulary. Supports GitHub, Linear, or local markdown (`.scratch/`).

## Tracer bullets > layers

**Horizontal** slice = one layer. Fails until all layers land. **Vertical** slice (tracer bullet) = one path through all layers. Verifiable alone.

Horizontal slicing => failures + rework.

`matt-to-tickets` orders prefactoring first. Presents numbered breakdown + quiz. Approve => publish.

## Blocking edges

| Tracker | Location | Workflow |
| --- | --- | --- |
| Local markdown | `.scratch/<feature>/issues/<NN>-<slug>.md` | Top to bottom |
| GitHub/Linear | Native blocking links/sub-issues | Grab tickets with 0 blockers |

`matt-to-tickets` produces artifact. Running sessions = manual.

## Wide-refactor exception

**Wide refactor** = single mechanical change across codebase. Overrides tracer-bullet rule.

**Expand-contract** sequence:
- **Expand**: add new form beside old.
- **Migrate**: move callers in batches. Ticket per batch. Blocked by expand.
- **Contract**: delete old form. Blocked by migrate batches.

Shared integration branch + final integrate-and-verify ticket.

## Common questions

**Too many tickets for small change.**
Model defaults to atomic units. Merge via quiz step. Fits in one context window => [implement](../../skills/engineering/matt-implement/SKILL.md).

**Tickets sliced by layer.**
Quiz step check: demoable? Add "demo path" to tickets.

**Missing GitHub sub-issues.**
Known issue (#554). Wire parent links manually.

**"Blocked by" in issue body.**
Known issue (#513). `gh issue create --blocked-by 12,15` works.

**Local tickets location.**
`.scratch/<feature-slug>/issues/<NN>-<slug>.md`.

**Spec truncation.**
Avoid clear/compact between `/matt-to-spec` & `/matt-to-tickets`. Run in same context window.

**Acceptance criteria grade nothing.**
Verify failure at base commit.

**Running published tickets.**
Manual dispatch. Count 0-blocker tickets => open sessions. Close/check off tickets manually.

## Success criteria

- Demoable behaviour per ticket.
- Numbered list + "Blocked by" line before publish.
- Top ticket = 0 blockers.
- 0 file paths/line numbers in body.
- Agent-ready tickets.
- Prefactoring ordered first.

## Pipeline

```txt
matt-grill-with-docs => matt-to-spec => matt-to-tickets => implement => matt-code-review
```

Upstream = [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md). Downstream = [implement](../../skills/engineering/matt-implement/SKILL.md). Route via [matt-ask](../../skills/engineering/matt-ask/SKILL.md).
