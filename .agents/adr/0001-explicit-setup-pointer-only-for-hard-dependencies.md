# Explicit `/setup-matt-pocock-skills` pointer only for hard dependencies

`/setup-matt-pocock-skills` seeds per-repo config (issue tracker, triage labels, domain docs).

Split skills by dependency type:

- **Hard dependency** (`to-tickets`, `to-spec`, `triage`): Include explicit pointer: _"run `/setup-matt-pocock-skills` if not"_. Missing config => wrong output.
- **Soft dependency** (`diagnose`, `tdd`, `improve-codebase-architecture`): Use vague prose ("domain glossary", "ADRs"). Missing config => functional skill + fuzzy output.

Split keeps soft-dependency skills token-light. Prevents cargo-culted pointers.
