---
name: matt-codebase-design
description: Shared vocabulary for designing deep modules. Use when the user wants to design or improve a module's interface, find deepening opportunities, decide where a seam goes, make code more testable or AI-navigable, or when another skill needs the deep-module vocabulary.
---

# codebase design

design **deep modules**: high behavior / small interface + clean seam placement + interface-testable. goal = caller leverage + maintainer locality + universal testability.

## glossary

use exact terms. ban "component", "service", "API", "boundary".

**Module**: interface + implementation. scale-agnostic (function, class, package, tier-slice). _ban_: unit, component, service.

**Interface**: required caller knowledge: signature + invariants + order constraints + error modes + config + perf. _ban_: API, signature (too narrow).

**Implementation**: internal module code.
**Adapter**: concrete interface implementation at seam. _distinction_: small adapter / large implementation (Postgres repo) vs large adapter / small implementation (in-memory fake).

**Depth**: interface leverage. high behavior / small interface => deep. complex interface / simple implementation => shallow.

**Seam** _(Michael Feathers)_: location to alter behavior without editing call site = interface location. seam placement != internal logic. _ban_: boundary (DDD conflict).

**Leverage**: caller depth benefit = max capability per interface unit.

**Locality**: maintainer depth benefit = centralized changes/bugs/verification.

## deep vs shallow

**deep module** = small interface + large implementation:
- few methods + simple params
- complex logic hidden

**shallow module** = large interface + small implementation (avoid):
- many methods + complex params
- pass-through logic

interface design checks:
- reduce method count?
- simplify parameters?
- hide internal complexity?

## principles

- **interface depth > implementation depth**: deep module allows internal seams + small parts. callers see single external seam.
- **deletion test**: delete module. complexity disappears => pass-through. complexity scatters across callers => valuable module.
- **interface = test surface**: callers + tests cross identical seam. testing internal details => wrong module shape.
- **two adapters validate seams**: 1 adapter => speculative seam. 2 adapters => real seam.

## testability

good interfaces => natural tests:
1. **accept dependencies, don't create them.** injected gateway => testable. `new StripeGateway()` => hard to test.
2. **return results, don't mutate.** pure `calculateDiscount()` => testable. mutating `applyDiscount()` => hard to test.
3. **small surface area.** fewer methods/params => fewer tests + simple setup.

## relationships

- **Module** => 1 **Interface**.
- **Depth** = **Module** vs **Interface**.
- **Seam** = **Interface** location.
- **Adapter** = **Interface** implementation at **Seam**.
- **Depth** => **Leverage** (callers) + **Locality** (maintainers).

## rejected concepts

- **depth = line ratio** (Ousterhout): rejected => rewards padding. leverage preferred.
- **interface = typescript keyword / public methods**: rejected => too narrow. includes required caller facts.
- **boundary**: rejected => DDD overload. use seam/interface.

## supporting docs

- [DEEPENING.md](DEEPENING.md): dependency categories + seam discipline + replace-not-layer tests.
- [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md): parallel sub-agent design generation => compare depth/locality/seams.
