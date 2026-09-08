# Explicit `/matt-skill-setup` pointer only for hard dependencies

`/matt-skill-setup` seeds per-repo config (issue tracker, triage labels, domain docs).

Split skills by dependency type:

- **Hard dependency** (`to-tickets`, `to-spec`, `triage`): Include explicit pointer: _"run `/matt-skill-setup` if not"_. Missing config => wrong output.
- **Soft dependency** (`diagnose`, `tdd`, `improve-codebase-architecture`): Use vague prose ("domain glossary", "ADRs"). Missing config => functional skill + fuzzy output.

Split keeps soft-dependency skills token-light. Prevents cargo-culted pointers.
