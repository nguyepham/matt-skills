# matt-skill-setup

## what it does
configures per-repo settings: issue tracker location, triage labels, domain doc paths.
records results under `docs/agents/`.
skills remain identical across repos + read `docs/agents/issue-tracker.md` at runtime. decouples skills from github.
inspects `git remote`, `CLAUDE.md`, `CONTEXT.md` => proposes config => writes files on user confirmation.

## when to use
invoke manually via `/matt-skill-setup`. zero auto-invocation.
run once per repo before running engineering skills. fixes missing trackers + unknown labels in downstream skills.

## prerequisites
writes committed markdown files to current repo:

| output | destination |
| --- | --- |
| `issue-tracker.md` | `docs/agents/` |
| `domain.md` | `docs/agents/` |
| `triage-labels.md` | `docs/agents/` (if `matt-triage` installed) |
| `## agent skills` block | existing `CLAUDE.md` or `AGENTS.md` |

repo-local configuration only. zero global state.

## 3 decisions
proposes defaults based on repo scans. skips settled choices.

| decision | proposed default | prompt condition |
| --- | --- | --- |
| **issue tracker** | match `git remote` | always prompted |
| **triage labels** | canonical set (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`) | only if `matt-triage` installed |
| **domain docs** | single-context (`CONTEXT.md` + `docs/adr/`) | prompts multi-context `CONTEXT-MAP.md` if monorepo detected |

tracker options:

| option | location | dependency |
| --- | --- | --- |
| **github** | github issues | `gh` cli |
| **gitlab** | gitlab issues | `glab` cli |
| **local markdown** | `.scratch/<feature>/` | none (supports remote-less projects) |
| **other** | user-defined | user workflow description |

github + local markdown = mutually exclusive.
"other" path writes custom workflow prose directly to `docs/agents/issue-tracker.md` (jira, linear, azure, gitea).

## common questions
**github required?**
no. ships templates for github, gitlab, local markdown, + arbitrary trackers via "other".

**re-run after skill updates?**
yes. downstream skills deviating from docs => re-run `/matt-skill-setup`.

**harness mismatch?**
edits `CLAUDE.md` if present, else `AGENTS.md`. legacy `CLAUDE.md` users => migrate `## agent skills` block to `AGENTS.md`.

**automatic label creation?**
zero remote label creation. `docs/agents/triage-labels.md` maps canonical roles to strings. create remote labels manually via tracker.

**configure behavior (tone/questions)?**
unsupported here. put behavioral overrides in `CLAUDE.md`.

**global user-level configuration?**
unsupported. every repo maintains independent `docs/agents/`.

**rationale?**
avoids duplicating issue-handling instructions across skills. output = human-editable markdown.

## working state
- `docs/agents/issue-tracker.md` + `docs/agents/domain.md` exist (+ `triage-labels.md` if `matt-triage` installed)
- `CLAUDE.md` or `AGENTS.md` contains `## agent skills` pointers
- proposed tracker matches active remote + mapped labels exist in tracker
- `/matt-to-tickets` + `/matt-triage` run without asking destination
- `SKILL.md` files remain untouched

## pipeline
1-time prerequisite for engineering flow. read by:
- `matt-triage`: reads label mappings.
- `matt-to-spec` & `matt-to-tickets`: publish to configured tracker.
- `matt-wayfinder`: reads wayfinding storage operations.
- `matt-domain-modeling`: writes domain docs matching configured layout.

route next actions via `matt-ask`.