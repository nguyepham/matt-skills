## What it does

`matt-improve-codebase-architecture` surveys codebase for deepening opportunities (shallow module => deep module). generates self-contained html report + starts matt-grilling loop.

zero code changes. outputs 1 os temp html file + conversation. refactor happens later.

filters:
1. deletion test: concentrate complexity > spread complexity.
2. active paths: biases scan toward changing code.

## When to reach for it

run `/matt-improve-codebase-architecture`. manual invocation only.

sits outside build loop. periodic work queue generator.

| Situation | Usage |
| --- | --- |
| routine upkeep | run periodically. stop structural rot. |
| before big build | point at spec. prompt: "how can we make this change easy?" |
| brownfield audit | map unstructured repo state. |
| legacy test work | find missing seams before testing. |

vs siblings:
- 1 known module => `/matt-codebase-design`.
- large effort => `/matt-wayfinder`.
- broken code => `diagnosing-bugs`.

## Prerequisites

zero setup. reads `CONTEXT.md` + `docs/adr/`. speaks domain nouns.

writes 2 places: `<tmpdir>/architecture-review-<timestamp>.html` + `CONTEXT.md`. records rejected candidates in adrs.

## Depth & report

deep module = max behaviour + min interface. shallow module = implementation leak + wide interface.

report hunts shallowness: test-only pure functions (zero locality), leaking seams, fragmented concepts. outputs deepening proposal.

candidate card: files, friction, solution, locality/leverage benefits, before/after diagram, badge.

| Badge | Meaning |
| --- | --- |
| `Strong` | passes deletion test + real friction. fix these. |
| `Worth exploring` | plausible. depends on future code. |
| `Speculative` | completeness. ignore these. |

report ends with top recommendation. awaits user choice. zero code moved.

## What happens after you pick one

chosen candidate => starts `/matt-grilling` loop. outputs decision. feed decision to `/matt-to-spec` -> `/matt-to-tickets` -> `implement`.

## Common questions

**disable grilling?**
yes. prompt: "don't grill me, just show the report". open issue: weak models skip to interview.

**unstyled html & zero diagrams?**
cdn requires network. security blocks => silent break. fix: request inline css + hand-built svg.

**batch candidates?**
1 candidate per session. prevents context window overflow. move chosen improvement to spec. queue remainder as tickets.

**how to prompt?**
name direction. target spec + prompt "how can we make this change easy?".

**large legacy codebase?**
yes. finds structure. zero shared vocabulary => run `/matt-grill-with-docs` first.

**vs `/matt-codebase-design`?**
`/matt-codebase-design` = reference vocabulary. `/matt-improve-codebase-architecture` = session driver.

**report "codebase is fine"?**
rare. framing targets findings. all `Speculative` badges => codebase is fine.

**other harnesses?**
partial. uses claude code `Agent` tool (`subagent_type=Explore`). missing tool => less thorough scan.

**typescript implementation?**
zero shipped guidance. user builds directory structure.

## It's working if

- candidates use domain concepts. order intake module > foobarhandler.
- candidates cluster in active files.
- zero code changes. 1 temp html file.
- stops after report + awaits choice.
- cards explain locality/leverage + simplified tests.
- rejected candidate => offers adr record.

## Where it fits

periodic maintenance. queues work. uses `/matt-codebase-design` vocabulary. triggers `/matt-grilling` + `/matt-domain-modeling`. outputs idea. enters build flow via `/matt-grill-with-docs` or `/matt-to-spec`. `/matt-ask` routes all.