---
name: setup-matt-pocock-skills
description: Configure repo for engineering skills (issue tracker, triage labels, domain docs). Run once before use.
disable-model-invocation: true
---

# Setup Matt Pocock's Skills

Scaffold per-repo configuration for engineering skills:
- **Issue tracker**: GitHub (default) or local markdown.
- **Triage labels**: 5 canonical role strings.
- **Domain docs**: `CONTEXT.md` & ADR locations + consumer rules.

Prompt-driven skill. Explore, present findings, confirm, write.

## Process

### 1. Explore

Read current repo state.
- `git remote -v` & `.git/config`: GitHub repo? Which?
- Root `AGENTS.md` & `CLAUDE.md`: Exist? `## Agent skills` section exists?
- Root `CONTEXT.md` & `CONTEXT-MAP.md`.
- `docs/adr/` & `src/*/docs/adr/`.
- `docs/agents/`: Prior output exists?
- `.scratch/`: Local-markdown convention active?
- `triage` skill installed? => runs Section B.
- Monorepo signals (`pnpm-workspace.yaml`, `package.json` workspaces, populated `packages/*`). No signals => single-context.

### 2. Present findings and ask

Summarize present & missing state. Process sections sequentially. One section, one answer.
Lead with recommended answer. Branching choice => 1-line explainer. Settled choice => skip section.

**Section A: Issue tracker.**
Default: GitHub.
`git remote` = GitHub => propose GitHub.
`git remote` = GitLab => propose GitLab.
Otherwise offer:
- **GitHub**: repo GitHub Issues (requires `gh` CLI).
- **Local markdown**: `.scratch/<feature>/` files (solo/no-remote).
- **Other**: ask user for 1-paragraph workflow description.
Record choice in `docs/agents/issue-tracker.md`. Keep "PRs as a request surface" flag off.

**Section B: Triage label vocabulary.**
`triage` skill missing => skip section.
`triage` skill installed => ask:
> Keep default triage labels? (recommended: **yes**)

User says yes => write `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`.
User says no => collect overrides. Prevent duplicate labels.

**Section C: Domain docs.**
No monorepo signals => write **single-context** (root `CONTEXT.md` + `docs/adr/`). Skip asking.
Monorepo signals => offer **multi-context** (root `CONTEXT-MAP.md` + per-context `CONTEXT.md`). Confirm choice.

### 3. Confirm and edit

Show draft:
- `## Agent skills` block for `CLAUDE.md` or `AGENTS.md`.
- `docs/agents/issue-tracker.md`.
- `docs/agents/domain.md`.
- `docs/agents/triage-labels.md` (if `triage` installed).
Allow user edits before writing.

### 4. Write

Select target file:
1. `CLAUDE.md` exists => edit it.
2. `AGENTS.md` exists => edit it.
3. Neither exists => ask user to pick.

Update existing `## Agent skills` block in-place. Preserve surrounding user edits.

```markdown
## Agent skills

### Issue tracker

[1-line summary]. See `docs/agents/issue-tracker.md`.

### Triage labels

[1-line summary]. See `docs/agents/triage-labels.md`.

### Domain docs

[1-line summary]. See `docs/agents/domain.md`.
```

`triage` missing => omit `### Triage labels` block & file.

Write docs files using seed templates:
- `issue-tracker-github.md`
- `issue-tracker-gitlab.md`
- `issue-tracker-local.md`
- `triage-labels.md` (if `triage` installed)
- `domain.md`

"Other" issue tracker => write `docs/agents/issue-tracker.md` from user description.

### 5. Done

Confirm completion. List skills using these files.
Note: users can edit `docs/agents/*.md` directly. Rerun skill only for tracker switch or fresh start.
