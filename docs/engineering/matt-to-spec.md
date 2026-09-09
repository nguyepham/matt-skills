## What it does

`matt-to-spec` converts conversation into **[spec](https://www.aihero.dev/ai-coding-dictionary/spec)** + publishes to issue tracker.

Zero interviews. Synthesis only (from thread, codebase, `CONTEXT.md`, ADRs). Records decisions. Zero new decisions.

## When to reach for it

Trigger: `/matt-to-spec`. Manual only.

Use case: build exceeds one [session](https://www.aihero.dev/ai-coding-dictionary/session).

| State | Action |
| --- | --- |
| Zero decisions | [matt-grill-with-docs](../../skills/engineering/matt-grill-with-docs/SKILL.md) |
| Fits one [context window](https://www.aihero.dev/ai-coding-dictionary/context-window) | `/matt-implement` |
| Spans multiple sessions | `/matt-to-spec` + `/matt-to-tickets` |
| [matt-wayfinder](../../skills/engineering/matt-wayfinder/SKILL.md) map cleared | `/matt-to-spec #<map_issue>` |

## Prerequisites

Requires tracker + triage-label vocabulary via [matt-skill-setup](../../skills/engineering/matt-skill-setup/SKILL.md).
Supports GitHub or local `.scratch/` markdown.

## Decision record

Context windows end => specs survive.

Captures [matt-grilling](https://www.aihero.dev/ai-coding-dictionary/matt-grilling) output.
Zero validation. Zero new decisions. Uses project vocabulary. New assertions = defects.

## Seams before prose

Sketches **seams** + requests user confirmation before writing.
Existing seams > new seams. Highest possible seam. Ideal seam count = 1.

[tdd](../../skills/engineering/matt-tdd/SKILL.md) requires pre-agreed seams. [matt-code-review](../../skills/engineering/matt-code-review/SKILL.md) flags unagreed seams.

## FAQ

**Where did `/to-prd` go?**
Renamed to `matt-to-spec` (v1.1). Spec = destination. Tickets = execution steps.

**Why `ready-for-agent` label?**
Label = "no further triage needed". AFK agents might process entire spec => exclude parent spec in AFK prompt or remove label post-`/matt-to-tickets`.

**Skip spec => `/matt-to-tickets`?**
Single-session work => skip spec (`/matt-implement`). Multi-session work => write spec. Tickets disappear + spec persists.

**Finished matt-wayfinder map input?**
Feed main map issue: `/matt-to-spec #<map_issue>`.

**Spec audience?**
Agent > human. Dense + reference-heavy. Review seams + out-of-scope section. Surprising spec => shallow matt-grilling.

**Update spec during implementation?**
Zero sync. Spec = snapshot. Implementation discoveries => update `CONTEXT.md` + ADRs.

**Refactors + module boundaries?**
Template targets user stories. Use implementation-decisions + testing-decisions sections. Extract ADRs via `/matt-grill-with-docs`.

**Tracker checks + ADR citations?**
Zero related-issue checks. Reads ADRs + zero citations. Search tracker manually.

**`/matt-to-tickets` truncation?**
Large specs exceed tracker limits. Run `/matt-to-spec` & `/matt-to-tickets` in same window. Zero clearing/compaction between calls.

## Success metrics

- Zero new questions.
- Proposes minimum seams before writing.
- Uses project nouns.
- Zero invented decisions.
- Explicit out-of-scope section.

## Pipeline

Multi-session build chain:
`matt-grill-with-docs` -> `matt-to-spec` -> `matt-to-tickets` -> `matt-implement` -> `matt-code-review`

Upstream: [matt-grill-with-docs](../../skills/engineering/matt-grill-with-docs/SKILL.md) (decides) or [matt-wayfinder](../../skills/engineering/matt-wayfinder/SKILL.md) (maps).
Downstream: [matt-to-tickets](../../skills/engineering/matt-to-tickets/SKILL.md) (slices).
Routing: [matt-ask](../../skills/engineering/matt-ask/SKILL.md).
