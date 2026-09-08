# Domain Docs
consumes domain documentation during codebase exploration.

## Prerequisites
Read before exploring:
- **`CONTEXT.md`** (repo root).
- **`CONTEXT-MAP.md`** (repo root). points at context-specific `CONTEXT.md` files. read relevant ones.
- **`docs/adr/`**: read relevant ADRs. multi-context repos => check `src/<context>/docs/adr/`.

missing files => proceed silently. skip missing flags. skip upfront creation. `/domain-modeling` skill creates lazily on term/decision resolution.

## File structure

Single-context repo:

```
/
├── CONTEXT.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

Multi-context repo (`CONTEXT-MAP.md` at root):

```
/
├── CONTEXT-MAP.md
├── docs/adr/                          ← system-wide decisions
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/                  ← context-specific decisions
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## Glossary vocabulary
use `CONTEXT.md` terms for domain concepts (issues, proposals, hypotheses, tests). avoid explicit synonyms.

missing concept => reconsider invented language or note gap for `/domain-modeling`.

## Flag ADR conflicts
output contradicts ADR => surface explicitly. avoid silent overrides.

> _Contradicts ADR-0007 (event-sourced orders), but worth reopening because…_
