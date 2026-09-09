# Out-of-Scope Knowledge Base

`.out-of-scope/` directory stores rejected feature requests. Provides two functions:

1. **Institutional memory**: preserves rejection reasoning.
2. **Deduplication**: surfaces previous decisions for matching issues. Bypasses re-litigation.

## Directory structure

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

Group duplicate requests. Maintain 1 file per **concept**.

## File format

Write readable design documents. Add paragraphs, code samples & examples. Clarify reasoning.

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42: "Add dark mode support"
- #87: "Night theme for accessibility"
- #134: "Dark theme option"
```

### Naming the file

Use short kebab-case names: `dark-mode.md`, `plugin-system.md`, `graphql-api.md`. Ensure recognizable filenames.

### Writing the reason

Provide substantive reasoning. Include:

- Project scope or philosophy.
- Technical constraints.
- Strategic decisions.

Ensure durable reasons. Skip temporary deferrals.

## When to check `.out-of-scope/`

Read all `.out-of-scope/` files during triage step 1.

- Evaluate new issue against existing concepts.
- Match by concept similarity ("night theme" matches `dark-mode.md`).
- Match found => surface to maintainer.

Maintainer actions:

- **Confirm**: append issue to "Prior requests" list + close issue.
- **Reconsider**: delete/update out-of-scope file + proceed with normal triage.
- **Disagree**: proceed with normal triage.

## When to write to `.out-of-scope/`

Write on **enhancement** `wontfix` rejection. Applies to issues & PRs.

Skip **already implemented** features. Prevents false deduplication rejections. Point closing comment to existing feature.

Flow:

1. Maintainer rejects feature request.
2. Check `.out-of-scope/` for matches.
3. Match exists => append issue to "Prior requests".
4. No match => create new file (concept name, decision, reason, first request).
5. Post explanation comment on issue + mention `.out-of-scope/` file.
6. Close issue with `wontfix` label.

## Updating or removing out-of-scope files

Maintainer reconsiders rejected concept:

- Delete `.out-of-scope/` file.
- Keep old issues closed (historical records).
- Proceed with normal triage for new issue.
