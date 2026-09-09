## What it does

`matt-triage` processes project tracker issues. Assigns 1 category role + 1 state role per issue. Outputs agent-ready brief, reporter question, or closed issue with reason.

Target: external issues only (raw bugs, incoming feature requests, unannounced external PRs).

Skip [Tickets](https://www.aihero.dev/ai-coding-dictionary/ticket) from [matt-to-tickets](../../skills/engineering/matt-to-tickets/SKILL.md). They are agent-ready. `/triage` is for incoming issues.

Recommends category + state + codebase findings. Waits for user approval before applying changes.

## When to reach for it

Type `/triage` + plain language description. Manual invocation only. Examples: "Show me anything that needs my attention", "let's look at #42", "move #42 to ready-for-agent".

| What you have | Where to go |
| --- | --- |
| Tracker full of external reports | `/triage` |
| Rough idea, unwritten | [matt-grill-with-docs](../../skills/engineering/matt-grill-with-docs/SKILL.md) |
| Settled conversation for [spec](https://www.aihero.dev/ai-coding-dictionary/spec) | [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) |
| Spec for agent-ready tickets | [matt-to-tickets](../../skills/engineering/matt-to-tickets/SKILL.md) |
| Confirmed bug needing root cause | [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs) |

## Prerequisites

Run [matt-skill-setup](../../skills/engineering/matt-skill-setup/SKILL.md). Configures tracker + label vocabulary. Maps custom tracker labels to **canonical** roles below. Exact match => zero setup needed.

Enable external PRs in `docs/agents/issue-tracker.md`. Default: off.

## The state machine

Requires exactly 1 category role + 1 state role. Categories: `bug` or `enhancement`. States:

| State | Means |
| --- | --- |
| `needs-triage` | User evaluation needed. Default entry state. |
| `needs-info` | Waiting on reporter. Reverts to `needs-triage` on reply. |
| `ready-for-agent` | Brief attached. [AFK](https://www.aihero.dev/ai-coding-dictionary/afk) agent ready. |
| `ready-for-human` | Brief attached. Requires human judgment, access, or manual testing. |
| `wontfix` | Closed + recorded reason. |

Maintain exactly 1 state role. Keeps queries simple.

`wontfix` resolutions:

| Reason | Action |
| --- | --- |
| Already implemented | Comment with location. Close. |
| Rejected bug | Polite explanation. Close. |
| Rejected enhancement | Write `.out-of-scope/` concept file. Comment with link. Close. |

`.out-of-scope/` stores rejected **concepts** (design document format). `matt-triage` reads directory before evaluation. Concept match => surfaces old decision for confirmation. Bypasses re-litigation.

## Verify before you brief

Validates claims before [matt-grilling](https://www.aihero.dev/ai-coding-dictionary/matt-grilling).
- Bug: reproduce from steps.
- PR: checkout branch + run tests.

Outputs 1 of 3 results:
1. Confirmed + code path.
2. Failed to reproduce.
3. Insufficient detail => `needs-info`.

Runs codebase checks:
- **Redundancy**: already implemented (concept search). Hits => `wontfix`.
- **Prior rejection**: exists in `.out-of-scope/`. Hits => `wontfix`.

Goal: strong **agent brief**. Brief = contract. Original report = context.
Briefs prioritize durability > precision. Name types, signatures, contracts. Exclude file paths + line numbers. Withstands underlying code changes.

## A PR is an issue with attached code

External PRs use identical state machine. States evaluate against diff:
- `ready-for-agent`: brief attached. Agent executes next step.
- `ready-for-human`: human merge needed.

PR brief describes remaining work on diff.

Discovery lists *external* PRs only. Collaborator branches bypass triage. Explicit PR naming bypasses external filter.
Known issue: GitHub template external-PR list fails. `gh pr list` lacks `authorAssociation` ([#468](https://github.com/mattpocock/skills/issues/468)).

## Common questions

**Untriaged tickets after `/matt-to-spec` + `/matt-to-tickets`?**
Skip `/triage`. Tickets are agent-ready. `matt-to-tickets` applies `ready-for-agent` for AFK runners. Spec flow = internal work. `matt-triage` = external work.

**Relevance alongside `matt-to-spec` → `matt-to-tickets` → `matt-implement`?**
Processes inbound work only. Open-source repos + external contributors. Internal-only tracker => skip `matt-triage`.

**`gh` says `ready-for-agent` label doesn't exist?**
Known bug ([#616](https://github.com/mattpocock/skills/issues/616)). `matt-skill-setup` writes `docs/agents/triage-labels.md` but skips tracker label creation. Create 5 state + 2 category labels manually via `gh label create` or UI.

**Need blocked, deferred, or implemented states?**
Unsupported. Workarounds exist (repo-local extra labels). Adding custom states breaks skill expectations.

**Difference from `/diagnosing-bugs`?**
`matt-triage` runs shallow verification for reality check + location. Fails to reproduce => `needs-info` or `/diagnosing-bugs`. [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs) finds root cause.

**Bulk backlog processing?**
Specify "read comments per issue". Default bulk mode lists issue bodies only. Misses closure comments => generates redundant briefs.

**Support for Linear / other trackers?**
Tracker = config. Supports Linear (`linear` CLI), GitLab, local `.scratch/` markdown. Common setup: Linear for issues, GitHub for PRs. Known bug in local-markdown: duplicate acceptance criteria ([#200](https://github.com/mattpocock/skills/issues/200)).

## It's working if

- Item ends with exactly 1 category role + 1 state role.
- Recommends + waits. Zero automatic relabelling.
- Reproduces bug or tests PR before `ready-for-agent`.
- Briefs specify types + behaviors. Zero file paths + line numbers.
- Surfaces old rejections from `.out-of-scope/`. Bypasses fresh triage.
- Comments start with `> *This was generated by AI during triage.*`

## Where it fits

External on-ramp. Merges into main flow at `ready-for-agent`. [implement](../../skills/engineering/matt-implement/SKILL.md) consumes output identically to [matt-to-tickets](../../skills/engineering/matt-to-tickets/SKILL.md).

Requires sharpening => runs [matt-grilling](../../skills/productivity/matt-grilling/SKILL.md) & [matt-domain-modeling](../../skills/engineering/matt-domain-modeling/SKILL.md). Records decisions in `CONTEXT.md` + ADRs.

Unsure of lane => run [matt-ask](../../skills/engineering/matt-ask/SKILL.md).