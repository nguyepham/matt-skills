---
name: domain-modeling
description: Build and sharpen project domain model. Use for codebase terminology, CONTEXT.md writing/editing, ADR recording/editing.
---

# Domain Modeling

Build & sharpen domain model actively. Challenge terms + invent edge cases + write glossary/decisions immediately. Active model changing > passive reading.

## File structure

Single context repos:

```
/
├── CONTEXT.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

Multi-context repos (`CONTEXT-MAP.md` at root):

```
/
├── CONTEXT-MAP.md
├── docs/
│   └── adr/                          ← system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── CONTEXT.md
│   │   └── docs/adr/                 ← context-specific decisions
│   └── billing/
│       ├── CONTEXT.md
│       └── docs/adr/
```

Create files lazily. No `CONTEXT.md` => create on first term. No `docs/adr/` => create on first ADR.

## During session

### Challenge glossary

Conflicting terms => call out. "Glossary defines X, code implies Y. Clarify."

### Sharpen fuzzy language

Vague/overloaded terms => propose precise canonical term. "Account: Customer or User? Clarify."

### Discuss concrete scenarios

Stress-test relationships with concrete scenarios. Invent edge cases => force precise boundaries.

### Cross-reference with code

Check code against user statements. Contradiction => surface it. "Code cancels entire Orders + user mentions partial cancellation. Clarify."

### Update CONTEXT.md inline

Resolved term => update `CONTEXT.md` immediately. Zero batching. Follow [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md).

`CONTEXT.md` = glossary only. Zero implementation details. Zero specs. Zero scratch pads.

### Offer ADRs sparingly

Require all three:

1. **Hard to reverse**: high cost of change.
2. **Surprising without context**: non-obvious to future readers.
3. **Real trade-off**: genuine alternatives existed.

Missing requirement => skip ADR. Follow [ADR-FORMAT.md](./ADR-FORMAT.md).
