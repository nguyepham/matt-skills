---
name: matt-improve-codebase-architecture
description: Scan a codebase for deepening opportunities, present them as a visual HTML report, then grill through whichever one you pick.
disable-model-invocation: true
---

# Improve Codebase Architecture

surface architectural friction + propose deepening opportunities (shallow module => deep module). increase testability & ai navigability.

relies on domain model + shared design vocabulary:

- call `matt-codebase-design` skill for vocabulary (**module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, **locality**) & principles (deletion test, interface = test surface). use exact terms. prevent "component", "service", "API", "boundary".
- `CONTEXT.md` provides domain terms. `docs/adr/` provides prior decisions.

## Process

### 1. Explore

**scope before scan: yagni.** deepening pays off on active code. decide target before scan:

- user names target => scan target.
- zero target => run `git log --oneline`. target active code. scattered changes => widen net.

read `CONTEXT.md` + `docs/adr/`.

spawn sub-agent. explore organically. locate friction:

- fragmented concepts.
- shallow modules.
- test-only pure functions (zero **locality**).
- leaking seams.
- untestable code.

apply **deletion test** to shallow modules. delete concentrates complexity => keep candidate.

### 2. Present candidates as html report

write self-contained html file to os temp directory. resolve `$TMPDIR` (`/tmp` or `%TEMP%`). path = `<tmpdir>/architecture-review-<timestamp>.html`. open file (`xdg-open <path>`, `open <path>`, `start <path>`). print absolute path.

use tailwind cdn + mermaid cdn. mix mermaid (graphs) + hand-built css/svg (cross-sections, mass diagrams). generate custom before/after visualisations.

candidate card:

- **Files**: impacted files.
- **Problem**: architectural friction.
- **Solution**: proposed change.
- **Benefits**: **locality** + **leverage** + testability gains.
- **Before / After diagram**: side-by-side visual.
- **Badge**: `Strong`, `Worth exploring`, `Speculative`.

end report with top recommendation.

use `CONTEXT.md` domain nouns + `/matt-codebase-design` architecture nouns.

contradicts adr + real friction => add warning callout.

read `HTML-REPORT.md` for scaffold + diagrams + styling.

zero interface proposals. ask: "which of these would you like to explore?".

### 3. Grilling loop

user picks candidate => call `matt-grilling` skill. walk decision tree (constraints, dependencies, seam boundary, tests).

call `matt-domain-modeling` skill for inline updates:

- new concept => add to `CONTEXT.md`. create lazy file.
- fuzzy term => sharpen `CONTEXT.md`.
- load-bearing rejection => offer adr record. skip ephemeral reasons.
- alternative interfaces => call `matt-codebase-design` skill. run design-it-twice parallel sub-agent.