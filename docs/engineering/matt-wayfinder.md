## What it does

`matt-wayfinder` handles multi-session [session](https://www.aihero.dev/ai-coding-dictionary/session) efforts.
known **destination** + unknown route => shared **map** of **decision tickets** in issue tracker.
resolves tickets sequentially.
plans. does not execute.
ticket = decision question. map finishes when zero decisions remain.
decision ticket > ordinary implementation [ticket](https://www.aihero.dev/ai-coding-dictionary/ticket).
cleared map => hands off. skips code generation.

## When to reach for it

invoke via `/matt-wayfinder`. [agent](https://www.aihero.dev/ai-coding-dictionary/agent) skips automatic invocation.
use for large multi-session efforts & unclear routes.
`/matt-grill-with-docs` = single-session planning. `/matt-wayfinder` = multi-session planning.

| What you have in front of you | What to run |
| --- | --- |
| well-scoped feature (single session) | [matt-grill-me](../../skills/productivity/matt-grill-me/SKILL.md) or [matt-grill-with-docs](../../skills/engineering/matt-grill-with-docs/SKILL.md) |
| greenfield project or multi-session build (unclear route) | `/matt-wayfinder` |
| decided thread | [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) |
| cleared matt-wayfinder map | [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) => [matt-to-tickets](../../skills/engineering/matt-to-tickets/SKILL.md) => [implement](../../skills/engineering/matt-implement/SKILL.md) |
| overgrown session | say "hand off to `/matt-wayfinder`" |

works on greenfield & legacy codebases. legacy codebase fog = existing state.

## Prerequisites

map & tickets live in issue tracker. requires [matt-skill-setup](../../skills/engineering/matt-skill-setup/SKILL.md) tracker wiring.
setup writes "Wayfinding operations" section. describes map, tickets, blocking edges, frontier queries.
resolves via `CLAUDE.md` / `AGENTS.md` pointer. zero tracker => fallback local markdown.
tracker UI renders frontier via blocking edges. zero native blocking => infers blockers from text. requires manual supervision.

## The map, the fog, and the frontier

**map** = single issue labelled `matt-wayfinder:map`. tickets = child issues.
map = index. tickets = store.
session loads low-resolution map. loads individual tickets on demand. prevents massive context cost.

map contents:
- **Destination**: end state. defines scope.
- **Decisions so far**: resolved tickets + links.
- **Not yet specified**: **fog of war**. unspecifiable future decisions. ticket resolution clears fog + creates specifiable tickets.
- **Out of scope**: excluded work. closes immediately. skips graduation.

**frontier** = open, unblocked, unclaimed tickets.
session assigns ticket to claim it. assignee = claim. concurrent sessions skip claimed tickets.
refer to tickets by name. skip `#42` issue numbers. legible narration.

## The four decision-ticket types

every ticket requires `matt-wayfinder:<type>` label.
**[HITL](https://www.aihero.dev/ai-coding-dictionary/human-in-the-loop)** = human interaction. **[AFK](https://www.aihero.dev/ai-coding-dictionary/afk)** = agent alone.
agent answering own [matt-grilling](https://www.aihero.dev/ai-coding-dictionary/matt-grilling) questions => broken HITL ticket.

| Type | Mode | Reach for it when | Resolved by |
| --- | --- | --- | --- |
| `matt-grilling` | HITL | default. verbal resolution. | [matt-grilling](../../skills/productivity/matt-grilling/SKILL.md) + [matt-domain-modeling](../../skills/engineering/matt-domain-modeling/SKILL.md) (fresh session) |
| `matt-prototype` | HITL | visual/behavioral resolution. | [matt-prototype](../../skills/engineering/matt-prototype/SKILL.md) + linked built artifact |
| `research` | AFK | external fact blocks decision. | [research](https://aihero.dev/skills-research) [subagent](https://www.aihero.dev/ai-coding-dictionary/subagent) (parallel `research/<name>` branch) |
| `task` | Either | manual work blocks decision (provisioning, signup, data moves). | agent alone or human checklist |

`task` executes. unblocks decision. skips product implementation.
research = sole exception to single ticket per session.

## Common questions

**How is this different from `/matt-grill-with-docs`? Which should I start with?**
session count > project size. `/matt-grill-with-docs` = single-session planning. `matt-wayfinder` = multi-session planning. single session => use matt-grilling. multi-session => use matt-wayfinder. judge session count manually.

**When it asks for the "destination", does it mean the end of this session or the end of everything?**
entire map destination. end state of map. example destinations: [spec](https://www.aihero.dev/ai-coding-dictionary/spec), locked decision, proof of concept, in-place migration.

**The map is cleared. Didn't matt-wayfinder already write the spec and make the tickets? Why do I still need `/matt-to-spec` and `/matt-to-tickets`?**
cleared map = linked decisions. linked decisions != build plan.
[matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) aggregates decisions into spec.
[matt-to-tickets](../../skills/engineering/matt-to-tickets/SKILL.md) converts spec to implementation tickets.
skipping steps discards linked detail. run abbreviated pipeline for small efforts. extra steps generate explicit spec artifact.

**My agent started writing production code in the middle of a matt-wayfinder session.**
agent overrides "plan, don't do" default via map Notes. agent owns map Notes.
read Notes on foreign maps. isolate implementation in separate sessions. treat implementation `matt-wayfinder:task` as mis-typed.

**I charted 27 tickets, and by the time I got to the thirteenth, the rest no longer made sense.**
default instinct = comprehensive planning. early assumptions invalidate late tickets (waterfall trap).
scope map to bounded destination. ship small increments.
[matt-prototype](https://www.aihero.dev/ai-coding-dictionary/prototyping) aggressively. cheap concrete artifacts clear uncertainty. "prototypemaxxing" > "planmaxxing".

**Can I work several tickets in parallel?**
blocking edges enable safe parallel work. single ticket = safer default.
parallel matt-grilling sessions lack shared [context](https://www.aihero.dev/ai-coding-dictionary/context). parallel matt-prototype agents build conflicting variations. review dependency graph before parallel work.

**Do I have to use GitHub Issues?**
any tracker works. GitHub provides native sub-issues & blocking. GitLab, Linear, Jira, local markdown work.
zero native blocking => manual dependency graph correction.
local markdown => accidental persistence in repo.

**The matt-grilling is exhausting. Every question is three paragraphs long.**
verbosity causes decision exhaustion. length obscures question rationale.
model property, not skill defect.
mitigation: lower [reasoning effort](https://www.aihero.dev/ai-coding-dictionary/effort). add plain-language instruction to global `CLAUDE.md`. requires significant user thought.

**A decision I already closed turned out to be wrong. Do I edit the old ticket or make a new one?**
explain changes to matt-wayfinder. updates map + revises affected tickets + comments on closed tickets.
mid-map scope changes work. designed-to-change maps = scoping smell.

**Where did `decision-mapping` go?**
renamed to `matt-wayfinder` in v1.1. invoke via `/matt-wayfinder`.
"decision map" = jargon + inaccurate. reframe = coherent vocabulary (destination, fog of war, frontier, map).
ticket unit retains "decision" label. prevents implementation confusion.

## It's working if

- written & agreed destination precedes ticket creation.
- open tickets = questions. "build X" tickets = mis-typed or downstream.
- tracker renders takeable tickets via native blocking.
- session resolves single ticket + posts resolution comment + closes ticket + appends *Decisions so far* link + stops.
- **Not yet specified** shrinks. graduated fog disappears.
- zero initial fog => skill stops + recommends skipping map.
- map completion yields spec. skips pull requests.

## Where it fits

`matt-wayfinder` = situational on-ramp. default = grill-led idea => ship chain.
large ideas => matt-wayfinder => [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md) (cleared map hands off).
underlying skills: [matt-grilling](../../skills/productivity/matt-grilling/SKILL.md) & [matt-domain-modeling](../../skills/engineering/matt-domain-modeling/SKILL.md) (default), [matt-prototype](../../skills/engineering/matt-prototype/SKILL.md) (visual), [research](https://aihero.dev/skills-research) (subagent).
[matt-handoff](../../skills/productivity/matt-handoff/SKILL.md) = bridge in/out. [matt-ask](../../skills/engineering/matt-ask/SKILL.md) = global router.