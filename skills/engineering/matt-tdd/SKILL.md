---
name: matt-tdd
description: Test-driven development loop (red-green-refactor) + integration tests.
---

# Test-Driven Development

TDD = red → green loop. Consult guide before & during loop.

Read `CONTEXT.md`. Match domain language. Follow ADRs.

## Good tests

Verify behavior through public interfaces. Ignore implementation details. Read like specifications ("user can checkout with valid cart"). Survive refactors.

See [tests.md](tests.md) for examples & [mocking.md](mocking.md) for mocking rules.

## Seams (where tests go)

Seam = public boundary for testing. Tests live at seams. Internal testing = forbidden.

Confirm seams with user before writing tests. Focus effort on critical paths + complex logic.

Ask: "What is the public interface? Which seams should we test?"

Unclear interface shape => call `codebase-design` skill for vocabulary (module, interface, depth, seam).

## Anti-patterns

- **Implementation-coupled**: mocks internals, tests private methods, or verifies via side channel (DB query instead of API). Refactor break without behavior change => coupled test.
- **Tautological**: assertion recomputes expected value identically to code (`expect(add(a, b)).toBe(a + b)`). Passes by construction. Use independent literal or spec value.
- **Horizontal slicing**: bulk tests first, then bulk implementation. Tests imagined behavior. Use **vertical slices**: one test → one implementation → repeat. Tests act as tracer bullets.

## Loop rules

- **Red before green.** Write failing test. Write minimal passing code. Skip speculative features.
- **One slice at a time.** One seam + one test + one minimal implementation per cycle.
- **Refactoring = separate stage.** Use `code-review` skill. Exclude from red → green cycle.
