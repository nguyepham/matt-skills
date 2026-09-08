# design it twice

explore alternative interfaces via parallel sub-agents (Ousterhout: first idea != best). uses [SKILL.md](SKILL.md) vocabulary.

## process

### 1. frame problem space

write user-facing explanation:
- interface constraints
- dependencies + categories ([DEEPENING.md](DEEPENING.md))
- rough code sketch (concrete constraints, not proposal)

show to user => proceed to step 2 immediately.

### 2. spawn sub-agents

spawn 3+ parallel Agent tools. require **radically different** interfaces.

provide brief: file paths, coupling, dependency category, seam logic. apply constraints:
- agent 1: minimize interface (1-3 entry points) + maximize leverage.
- agent 2: maximize flexibility (extension + use cases).
- agent 3: optimize common caller (trivial default).
- agent 4 (optional): ports & adapters for cross-seam deps.

enforce [SKILL.md](SKILL.md) + CONTEXT.md vocabulary.

agent outputs:
1. interface (types, methods, params, invariants, ordering, errors)
2. usage example
3. hidden implementation details
4. dependency strategy + adapters
5. leverage trade-offs

### 3. present & compare

present designs sequentially. compare prose: **depth** (leverage) + **locality** (change concentration) + **seam placement**.

provide opinionated recommendation + why. propose hybrid if optimal. ban menu-only presentation.
