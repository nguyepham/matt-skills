# matt-code-review

## what it does
reviews diffs between `HEAD` & fixed points (main, commits, branches, tags) along 2 axes:
- **standards**: repo conventions match.
- **spec**: originating issue / spec requirements met.

isolated sub-agents run axes independently => zero reasoning leakage.
axes never merge. report lists worst issue per axis. refuses blended score.

## when to use
invoke via `/matt-code-review`. auto-triggers on requests to review branches, PRs, WIP changes, diffs since fixed point.

| situation | tool |
| --- | --- |
| check repo conventions + spec compliance | `matt-code-review` |
| hunt runtime bugs (null pointers, races) | built-in review |
| write new code test-first | `matt-tdd` |
| build spec end-to-end | `matt-implement` |
| drift across full codebase | `matt-improve-codebase-architecture` |
| unknown bug root cause | `diagnosing-bugs` |

fixed point required. missing ref => prompts user. bad ref or empty diff => aborts before spawn.

## prerequisites
**standards axis**: zero setup. reads repo docs (`CODING_STANDARDS.md`, `CONTRIBUTING.md`). missing docs => falls back to smell baseline.

**spec axis**: needs spec. search order:
1. commit message issue refs via `docs/agents/issue-tracker.md`
2. explicit path argument
3. spec file matching branch name in `docs/`, `specs/`, or `.scratch/`
4. user prompt

missing tracker + missing spec => skips spec sub-agent + reports "no spec available".

## the two axes
| | standards | spec |
| --- | --- | --- |
| focus | code quality | scope delivery |
| source | repo standards + smell baseline | originating issue / spec |
| reports | rule breaches + code smells | missing requirements + scope creep + wrong logic |
| citations | standards file rule or named smell + hunk | spec line number |

repo documentation > generic rules.
smell baseline uses 12 Fowler smells (Mysterious Name, Duplicated Code, Feature Envy, Data Clumps, Primitive Obsession, Repeated Switches, Shotgun Surgery, Divergent Change, Speculative Generality, Message Chains, Middle Man, Refused Bequest). smells report as heuristics + explicit refactoring moves. skips linter-enforced rules.

## common questions
**built-in `/matt-code-review` collision?**
built-in hunts bugs. this skill checks specs + standards. workaround: remove built-in skills or fork local skill.

**recursive sub-agent calls?**
sub-agents may re-invoke `/matt-code-review`. fix: append "do not invoke `/matt-code-review` or spawn agents" to briefs.

**run in authoring session?**
fresh session > authoring session. avoids confirmation bias.

**per-ticket or branch-end?**
per-ticket catches spec drift. branch-end catches cross-ticket regressions. run per-ticket + final pass at merge-base.

**trust output directly?**
verify findings. check cited rules + hunks + spec lines.

**repeated runs find new issues?**
fixes add new surface. heuristics vary. fix cited violations => stop.

**uncommitted edits?**
no. reviews `git diff <fixed-point>...HEAD`. commit changes => run review.

## working state
- refuses invalid ref or empty diff before agent spawn
- outputs separate `## standards` & `## spec` sections
- standards cites repo rule or smell + hunk
- spec quotes spec line
- reports worst issue per axis. zero merged scores
- missing spec => spec block reports "no spec available"

## pipeline
`matt-grill-with-docs` => `matt-to-spec` => `matt-to-tickets` => `matt-implement` => `matt-code-review`

- `matt-implement`: calls review before final commit.
- `matt-to-spec` & `matt-to-tickets`: supply spec.
- `matt-improve-codebase-architecture`: audits full codebase.
- `matt-ask`: routes workflow.
