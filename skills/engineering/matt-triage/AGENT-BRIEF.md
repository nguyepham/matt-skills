# Writing Agent Briefs

Agent brief = structured comment on GitHub issue/PR at `ready-for-agent`. Authoritative specification for AFK agents. Original body = context. Agent brief = contract.

Brief defines target state. Issue => build change. PR => finish existing diff & address review points. Same principles apply.

## Principles

### Durability > precision

Codebase changes during `ready-for-agent` wait. Briefs must survive file renames & refactors.

- Describe interfaces, types & behavioral contracts.
- Name target types, function signatures & config shapes.
- Skip file paths => go stale.
- Skip line numbers.
- Avoid implementation structure assumptions.

### Behavioral > procedural

Describe target state. Skip implementation steps. Agents explore codebase & make implementation decisions.

- **Good:** "`SkillConfig` type accepts optional `schedule` field (`CronExpression`)."
- **Bad:** "Open `src/types/skill.ts` & add `schedule` field on line 42."
- **Good:** "Empty `/triage` command => show summary of issues needing attention."
- **Bad:** "Add switch statement in main handler function."

### Complete acceptance criteria

Define completion state. Require concrete testable acceptance criteria. Make criteria independently verifiable.

- **Good:** "`gh issue list --label needs-triage` => returns classified issues."
- **Bad:** "Triage works correctly."

### Explicit scope boundaries

Define out-of-scope items. Prevent gold-plating & adjacent feature assumptions.

## Template

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** one-line requirement

**Current behavior:**
Describe current state. Bug => broken behavior. Enhancement => status quo.

**Desired behavior:**
Describe target state. Specify edge cases & error conditions.

**Key interfaces:**
- `TypeName`: target change & reason
- `functionName()` return type: current vs target return type
- Config shape: required new config options

**Acceptance criteria:**
- [ ] Specific testable criterion 1
- [ ] Specific testable criterion 2
- [ ] Specific testable criterion 3

**Out of scope:**
- Excluded related changes
- Adjacent separate features
```

## Examples

### Good agent brief (bug)

```markdown
## Agent Brief

**Category:** bug
**Summary:** Skill description truncation drops mid-word, producing broken output

**Current behavior:**
When a skill description exceeds 1024 characters, it is truncated at exactly
1024 characters regardless of word boundaries. This produces descriptions
that end mid-word (e.g. "Use when the user wants to confi").

**Desired behavior:**
Truncation should break at the last word boundary before 1024 characters
and append "..." to indicate truncation.

**Key interfaces:**
- The `SkillMetadata` type's `description` field: no type change needed,
  but the validation/processing logic that populates it needs to respect
  word boundaries
- Any function that reads SKILL.md frontmatter and extracts the description

**Acceptance criteria:**
- [ ] Descriptions under 1024 chars are unchanged
- [ ] Descriptions over 1024 chars are truncated at the last word boundary
      before 1024 chars
- [ ] Truncated descriptions end with "..."
- [ ] The total length including "..." does not exceed 1024 chars

**Out of scope:**
- Changing the 1024 char limit itself
- Multi-line description support
```

### Good agent brief (enhancement)

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Add `.out-of-scope/` directory support for tracking rejected feature requests

**Current behavior:**
When a feature request is rejected, the issue is closed with a `wontfix` label
and a comment. There is no persistent record of the decision or reasoning.
Future similar requests require the maintainer to recall or search for the
prior discussion.

**Desired behavior:**
Rejected feature requests should be documented in `.out-of-scope/<concept>.md`
files that capture the decision, reasoning, and links to all issues that
requested the feature. When triaging new issues, these files should be
checked for matches.

**Key interfaces:**
- Markdown file format in `.out-of-scope/`: each file should have a
  `# Concept Name` heading, a `**Decision:**` line, a `**Reason:**` line,
  and a `**Prior requests:**` list with issue links
- The triage workflow should read all `.out-of-scope/*.md` files early
  and match incoming issues against them by concept similarity

**Acceptance criteria:**
- [ ] Closing a feature as wontfix creates/updates a file in `.out-of-scope/`
- [ ] The file includes the decision, reasoning, and link to the closed issue
- [ ] If a matching `.out-of-scope/` file already exists, the new issue is
      appended to its "Prior requests" list rather than creating a duplicate
- [ ] During triage, existing `.out-of-scope/` files are checked and surfaced
      when a new issue matches a prior rejection

**Out of scope:**
- Automated matching (human confirms the match)
- Reopening previously rejected features
- Bug reports (only enhancement rejections go to `.out-of-scope/`)
```

### Good agent brief (PR)

PR "Current behavior" = diff state. Brief = finish existing diff.

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Finish the contributor's `--json` output flag for `triage list`

**Current behavior:**
The PR adds a `--json` flag that serializes the issue list to JSON. The happy
path works and the diff matches the project's command structure. Two gaps
remain: errors are still printed as human text (not JSON), and the new flag has
no test coverage.

**Desired behavior:**
With `--json`, all output (including errors) is well-formed JSON on stdout,
and the command's exit codes are unchanged. The existing human-readable output
is untouched when the flag is absent.

**Key interfaces:**
- The command's error path should emit `{ "error": string }` under `--json`
  instead of the plain-text error
- Reuse the existing serializer the PR already added; don't introduce a second

**Acceptance criteria:**
- [ ] `triage list --json` emits valid JSON for both success and error cases
- [ ] Exit codes match the non-JSON command
- [ ] A test covers the `--json` success output and one error case
- [ ] Default (non-JSON) output is byte-for-byte unchanged

**Out of scope:**
- Adding `--json` to any other command
- Changing the JSON shape of the success payload the PR already defined
```

### Bad agent brief

```markdown
## Agent Brief

**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.

**Files to change:**
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

Bad brief traits:
- Missing category.
- Vague description.
- Hardcoded file paths & line numbers => go stale.
- Missing acceptance criteria.
- Missing scope boundaries.
- Missing current vs desired behavior.
