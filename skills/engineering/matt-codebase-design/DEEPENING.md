# deepening

deepen shallow module clusters based on dependency types. uses [SKILL.md](SKILL.md) vocabulary.

## dependency categories

### 1. in-process
pure computation + memory state + zero I/O. always deepenable. merge modules + test direct interface. zero adapters required.

### 2. local-substitutable
local test stand-ins available (PGLite, memory-fs). deepenable via stand-in. test via internal seam. zero external interface ports.

### 3. remote but owned (ports & adapters)
owned network services (microservices, internal APIs). define port (interface) at seam. deep module owns logic. transport = injected adapter (HTTP for prod + in-memory for test).

### 4. true external (mock)
3rd-party services (Stripe, Twilio). inject port into deep module. test via mock adapter.

## seam discipline

- **two adapters validate seams**: 1 adapter => speculative seam. 2 adapters (prod + test) => real seam. ban single-adapter indirection.
- **internal vs external seams**: tests use internal seams. ban exposing internal seams in external interface.

## testing: replace > layer

- delete old shallow unit tests.
- **interface = test surface**: write new tests at deepened interface.
- assert observable outcomes > internal state.
- behavior-based tests survive internal refactors. test breaks on implementation change => tested past interface.
