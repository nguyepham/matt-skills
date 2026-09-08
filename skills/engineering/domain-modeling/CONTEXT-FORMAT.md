# CONTEXT.md Format

## Structure

```md
# {Context Name}

{1-2 sentence description: purpose + existence rationale.}

## Language

**Order**:
{1-2 sentence description}
_Avoid_: Purchase, transaction

**Invoice**:
Payment request sent to customer post-delivery.
_Avoid_: Bill, payment request

**Customer**:
Person/organization placing orders.
_Avoid_: Client, buyer, account
```

## Rules

- **Opinionated.** Select best term + list others under `_Avoid_`.
- **Tight definitions.** 1-2 sentences. Define what it IS > what it does.
- **Context-specific terms.** Exclude general programming concepts (timeouts, errors, patterns). Unique concept => include.
- **Group by subheadings.** Cluster related terms. Cohesive area => flat list.

## Single vs multi-context repos

**Single context:** `CONTEXT.md` at repo root.

**Multiple contexts:** `CONTEXT-MAP.md` at repo root. Maps contexts + locations + relationships.

```md
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md): receives & tracks orders
- [Billing](./src/billing/CONTEXT.md): generates invoices & processes payments
- [Fulfillment](./src/fulfillment/CONTEXT.md): manages warehouse & shipping

## Relationships

- **Ordering → Fulfillment**: Ordering emits `OrderPlaced` => Fulfillment consumes to pick
- **Fulfillment → Billing**: Fulfillment emits `ShipmentDispatched` => Billing consumes to invoice
- **Ordering ↔ Billing**: Shared `CustomerId` & `Money` types
```

Skill infers structure:

- `CONTEXT-MAP.md` exists => read to find contexts.
- `CONTEXT.md` only => single context.
- Neither exists => create root `CONTEXT.md` lazily on first term resolution.

Multiple contexts => infer relevant context. Unclear => ask.
