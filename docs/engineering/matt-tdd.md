## What it does

`matt-tdd` builds features/fixes test-first. loop: failing test => minimal code => next behaviour. enforces standards: good tests, locations, mocks, anti-patterns.

writes zero tests at unconfirmed seams. names public boundaries first + stops for confirmation. testing effort finite => spend on critical paths. `matt-tdd` = reference. you or `implement` run session.

## When to reach for it

run `/matt-tdd` or agent auto-triggers for test-first feature/bug. trigger phrase: "red-green-refactor". requires concrete behaviour + defined inputs/outputs.

| Situation | Skill |
| --- | --- |
| defined inputs/outputs (business logic, contract, transform, validation) | `matt-tdd` |
| unpinned behaviour | `matt-to-spec` (agrees seams first) |
| interface shape question | `matt-codebase-design` |
| spec/tickets exist + want full build | `implement` |
| config, wiring, glue, types, CRUD | N/A (issue #746. zero independent truth => tautological tests. requires human judgement) |

## Prerequisites

requires `matt-codebase-design`. `matt-tdd` uses its interface-design vocabulary. stateless (writes zero files).

## The loop & the seam

**Red-green.** failing test => minimal code. zero lookahead. zero refactor (removed June 2026. refactor belongs to `matt-code-review`).

**Vertical slice.** 1 seam + 1 test + 1 minimal implementation => repeat. first cycle = tracer bullet. horizontal slicing (batch tests first) => verifies imagined behaviour + premature commitment.

**Pre-agreed seam.** seam = public boundary. absolute rule: zero tests at unconfirmed seams. `matt-to-spec` agrees seams early. `matt-tdd` asks directly.

Anti-patterns prevented:

| Anti-pattern | Tell |
| --- | --- |
| Implementation-coupled | renaming internal function => broken test. mocked internals/call counts/db queries. |
| Tautological | expected value computed same as code. expected values require independent source (literal, example, spec). |
| Horizontal slicing | batch tests before implementation. |

mocks = external boundaries only (APIs, time, random, db/fs). zero internal mocks.

## Common questions

**Why no refactor?** removed intentionally. agents failed it. separate sessions work better. issue #589 open => "red-green-refactor" phrase stays. refactoring => `matt-code-review`.

**Which seam to pick?** issue #607. prompt lists labels only. workaround: ask agent for trade-offs before answering. `matt-to-spec` solves via up-front agreement.

**Implementation before test?** model habit overriding prompt. zero 100% compliance. strict adherence required => watch run. overall results still > manual.

**Browser/E2E tests first?** usually no. slow feedback breaks red-green value. configure `CLAUDE.md` to write them post-implementation.

**Replace `/matt-implement` or `/do-work`?** no. `/matt-tdd` = methodology. `/matt-implement` = work loop.

**Deep-modules/interface-design guidance?** moved to `matt-codebase-design` v1.0. refactoring moved to `matt-code-review`.

**Knows other tickets?** no. zero issue graph visibility (issue #129). pass spec + right-size tickets.

## It's working if

- stops + names seams + waits before test creation.
- 1 failing test => minimal code => next test. zero batches.
- test names = capabilities > internals.
- expected values = literals/spec > computed.
- renaming internals => zero test breaks.
- mocks = external boundaries only.

## Where it fits

engine inside build step:

`matt-grill-with-docs` => `matt-to-spec` => `matt-to-tickets` => `implement` => `matt-code-review`

`matt-to-spec` agrees seams. `implement` drives `matt-tdd`. `matt-code-review` checks seams + refactors. `matt-codebase-design` provides vocabulary. unsure => `matt-ask-matt`.