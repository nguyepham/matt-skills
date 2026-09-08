# Mocking

Mock at **system boundaries** only:
- External APIs (payment, email)
- Time & randomness
- Databases & file system (prefer real test DB/FS)

Do not mock:
- Owned classes/modules
- Internal collaborators
- Controlled code

## Mockable interfaces

Design system boundaries for easy mocking.

**1. Dependency injection**
Pass dependencies. Avoid internal instantiation.

```typescript
// GOOD: Dependency injected
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// BAD: Internal instantiation
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. SDK-style interfaces > generic fetchers**
Specific functions per operation > generic fetch with conditional logic.

```typescript
// GOOD: Independently mockable
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// BAD: Conditional logic required in mock
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK approach =>
- One specific return shape per mock
- Zero conditional logic in setup
- Clear endpoint exercise mapping
- Type safety per endpoint