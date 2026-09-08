# matt-codebase-design

## what it does
defines design vocabulary: module, interface, depth, seam, adapter, leverage, locality.
bans vague substitutes (component, service, API, boundary).
sets core principles.
reference only. zero loops. zero artifacts. zero checkpoints.

## when to use
invoke via `/matt-codebase-design` or auto-load.
use for module shaping: seam placement, interface size, extraction value.

| problem | tool |
|---|---|
| module shape (interface/seam/depth) | `matt-codebase-design` |
| domain terms (account/cancellation) | `matt-domain-modeling` |
| locate redesign target | `matt-improve-codebase-architecture` |
| stress-test design | `matt-grilling` |
| test-driven implementation | `matt-tdd` |

## vocabulary
| term | definition | banned |
|---|---|---|
| **module** | interface + implementation. scale-agnostic. | unit, component, service |
| **interface** | required caller knowledge: signature, invariants, order constraints, errors, config. | API, signature |
| **depth** | interface leverage. high behavior + small interface => deep. | none |
| **seam** | location to alter behavior without editing caller. | boundary |
| **adapter** | concrete interface implementation at seam. | none |
| **leverage** | caller depth benefit. | none |
| **locality** | maintainer depth benefit. changes concentrate in 1 place. | none |

depth = leverage. line ratio rejected.

## principles
- **interface depth > implementation depth**: deep module allows small internal parts. callers see 1 seam.
- **deletion test**: delete module. complexity vanishes => pass-through. complexity scatters => valuable module.
- **interface = test surface**: callers + tests share identical seam. test internal details => wrong module shape.
- **2 adapters validate seams**: 1 adapter => speculative seam. 2 adapters => real seam.

supporting docs:
- `DEEPENING.md`: dependency categories => testing strategy across seams.
- `DESIGN-IT-TWICE.md`: parallel sub-agents generate 3+ distinct interfaces => compare depth, locality, seams.

## common questions
**build deep modules in typescript?**
skill skips import enforcement. solutions: class/iife wrapper, monorepo packages, `dependency-cruiser`.

**agent burns tokens redesigning unrequested code?**
reference lacks execution guardrails. fix: wrap under driver skill (`matt-grill-with-docs`, `matt-tdd`).

**`design-an-interface` location?**
merged into `DESIGN-IT-TWICE.md`.

**file-structure conventions?**
module shape != directory structure. strict interfaces work across any layout.

**tdd integration?**
`matt-tdd` consumes vocabulary + owns test seam. this skill owns internal shape.

**non-claude-code compatibility?**
`DESIGN-IT-TWICE.md` requires Agent tool. limited compatibility elsewhere.

**vocabulary additions?**
issues #180, #303 open. vocabulary remains minimal for consistency.

## success signals
- uses "module", "interface", "seam". drops "component", "service".
- extractions pass deletion test.
- seam proposals name 2+ adapters.
- interface specs include invariants + ordering + errors.
- triggers zero unprompted edits.

## pipeline
standalone vocabulary base.
- `matt-domain-modeling`: problem domain terms.
- `matt-improve-codebase-architecture`: identifies deepening targets.
- `matt-ask`: skill router.
