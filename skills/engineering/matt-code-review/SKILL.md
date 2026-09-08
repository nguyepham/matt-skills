---
name: matt-code-review
description: Review changes since fixed point (commit, branch, tag, merge-base) along two axes. Standards axis checks repo conventions. Spec axis checks originating issue. Runs parallel sub-agents + reports side by side. Use for branch reviews, PRs, WIP changes.
---

Two-axis review of diff between `HEAD` & fixed point:

- **Standards**: matches repo documented conventions?
- **Spec**: implements originating issue/spec?

Both axes run as **parallel sub-agents**. Aggregates findings side by side.

Missing issue tracker `docs/agents/issue-tracker.md` => run `/matt-skill-setup`.

## Process

### 1. Pin fixed point

User supplies fixed point (commit SHA, branch, tag, `main`, `HEAD~5`). No fixed point => ask user.

Capture diff command: `git diff <fixed-point>...HEAD` (merge-base comparison). Capture commits: `git log <fixed-point>..HEAD --oneline`.

Confirm fixed point resolves (`git rev-parse <fixed-point>`) + non-empty diff. Bad ref/empty diff => fail early.

### 2. Identify spec source

Find originating spec in order:

1. Issue references in commit messages (`#123`, `Closes #45`, `!67`) via `docs/agents/issue-tracker.md`.
2. User-provided path.
3. Spec file under `docs/`, `specs/`, or `.scratch/` matching branch/feature.
4. Ask user. No spec => skip **Spec** sub-agent + report "no spec available".

### 3. Identify standards sources

Find repo coding standard documents (`CODING_STANDARDS.md`, `CONTRIBUTING.md`).

Standards axis applies **smell baseline** (Fowler _Refactoring_ ch.3). Two rules:

- **Repo overrides.** Documented repo standard > baseline.
- **Judgement call.** Smells = heuristics. Skip tooling-enforced rules.

Match smells against diff:

- **Mysterious Name**: unclear function/variable/type name. => rename.
- **Duplicated Code**: identical logic across hunks/files. => extract shared shape.
- **Feature Envy**: method accesses external object data excessively. => move method to data.
- **Data Clumps**: recurring param/field groups. => bundle into type.
- **Primitive Obsession**: primitives representing domain concepts. => create domain type.
- **Repeated Switches**: identical `switch`/`if` cascades across change. => use polymorphism/shared map.
- **Shotgun Surgery**: logical change scatters edits. => gather into one module.
- **Divergent Change**: module edited for unrelated reasons. => split module.
- **Speculative Generality**: unneeded abstractions/hooks. => delete.
- **Message Chains**: long `a.b().c().d()` chains. => hide behind single method.
- **Middle Man**: delegating class/function. => delete + call target directly.
- **Refused Bequest**: subclass ignores inherited behavior. => drop inheritance + use composition.

### 4. Spawn parallel sub-agents

**Standards sub-agent prompt**:

- Diff command + commit list.
- Standards-source files + **full pasted smell baseline**.
- Brief: "Report standards violations per file/hunk. Cite rule. Report baseline smells. Distinguish hard violations (repo standards) from judgement calls (baseline smells). Repo standards > baseline. Skip tooling-enforced rules. Under 400 words."

**Spec sub-agent prompt**:

- Diff command + commit list.
- Spec path or contents.
- Brief: "Report missing requirements. Report scope creep. Report wrong implementations. Quote spec lines. Under 400 words."

Missing spec => skip Spec sub-agent.

### 5. Aggregate

Output `## Standards` & `## Spec` sections. Keep separate. Do **not** merge/rerank findings.

End with one-line summary: total findings per axis + worst issue per axis. Do not pick cross-axis winner.

## Why two axes

Changes can pass one axis & fail other:

- Follows standards + wrong implementation => **Standards pass, Spec fail.**
- Right implementation + breaks conventions => **Spec pass, Standards fail.**

Separate reporting prevents masking.
