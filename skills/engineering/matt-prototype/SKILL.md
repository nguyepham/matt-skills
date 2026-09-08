---
name: matt-prototype
description: Build a throwaway prototype to test a state model, logic, or UI design.
---

# Prototype

Prototype = throwaway code answering one question. Question determines shape.

## Pick branch

Infer question from prompt + surrounding code. Ask user when available.

- **Does this logic or state model feel right?** → [LOGIC.md](LOGIC.md). Build one shareable HTML file with free-play controls + tabbed walkthroughs. Exercise hard cases. Keep it usable by non-developers.
- **What should this look like?** → [UI.md](UI.md). Build radically different variants on one route. Switch via URL search param + floating bottom bar.

Wrong branch wastes prototype. Ambiguous question + unavailable user => backend module uses logic; page or component uses UI. State assumption atop prototype.

## Shared rules

1. **Mark throwaway code.** Place it beside target module or page. Use an obvious prototype name. Follow existing routing conventions; add no top-level structure.
2. **One-step startup.** UI prototype runs through one project task: `pnpm <name>`, `python <path>`, `bun <path>`, etc. Logic prototype is one double-clickable HTML file.
3. **Keep state in memory.** Persistence is opt-in. Database questions use a scratch DB or clearly named `PROTOTYPE, wipe me` file.
4. **Skip polish.** Add no tests, abstractions, or error handling beyond runnable minimum.
5. **Expose full state.** Render it after each logic action or UI variant switch.
6. **Capture results.** Apply validated decision to production code. Commit prototype to a throwaway branch outside main. Link that branch from implementation issue. Record question + verdict in issue or commit. Main keeps only validated decision.
