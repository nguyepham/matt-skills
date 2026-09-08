# ADR Format

ADRs live in `docs/adr/`. Sequential numbering: `0001-slug.md`, `0002-slug.md`.

Create `docs/adr/` lazily (only for first ADR).

## Template

```md
# {Short title of the decision}

{1-3 sentences: context + decision + rationale}
```

ADR = record of decision + rationale. Paragraph is sufficient. Skip unnecessary sections.

## Optional sections

Use only when adding value.

- **Status** frontmatter (`proposed | accepted | deprecated | superseded by ADR-NNNN`): useful for revisited decisions.
- **Considered Options**: use when rejected alternatives hold value.
- **Consequences**: use for non-obvious downstream effects.

## Numbering

Scan `docs/adr/` for highest number + increment by 1.

## When to offer ADR

Require all three:

1. **Hard to reverse**: high cost of change.
2. **Surprising without context**: non-obvious to future readers.
3. **Real trade-off**: genuine alternatives existed.

Easy to reverse => skip. Obvious => skip. No real alternatives => skip.

### What qualifies

- **Architectural shape.** "Monorepo." "Event-sourced write model + Postgres read model."
- **Integration patterns.** "Contexts communicate via domain events > synchronous HTTP."
- **Technology lock-in.** Database, message bus, auth provider. High swap cost => ADR.
- **Boundary & scope.** "Customer context owns Customer data + others reference by ID." Explicit rejections = valuable.
- **Deliberate deviations.** "Manual SQL > ORM because X." Surprising choices => stops accidental "fixes".
- **Invisible constraints.** "Zero AWS because compliance." "Sub-200ms response because API contract."
- **Non-obvious rejections.** "REST > GraphQL because X." Prevents future relitigation.
