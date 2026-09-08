# matt-ask

## what it does
routes user across repo skills.
evaluates user situation (unstarted idea, incoming bug pile, long session) => names fitting skill/flow + human decision points.
recommends + stops. zero execution. zero specs. zero file reads. names next slash command.

## when to use
invoke via `/matt-ask`. zero auto-invocation.

| situation | output |
| --- | --- |
| idea without start | main flow head + skip-spec size check |
| incoming external bugs | `matt-triage` on-ramp |
| ambiguous skill choice | concrete differentiator (`matt-grill-with-docs` > `matt-grill-me` for repos) |
| long session context | phase boundary decision tree |
| pre-selected skill | redundant. invoke skill directly. |

## prerequisites
requires target skills pre-installed. covers repo skills only.
tracker-dependent routes (`matt-triage`, `matt-to-spec`, `matt-to-tickets`, `implement`) require issue tracker config via `matt-skill-setup`.

## flows
organizes skills into paths:
- **main flow (idea => ship)**: grill => spec => tickets => implement => review.
- **branches**: `matt-prototype` detour. spec/tickets split.
- **on-ramps**: merges external work onto main flow (bugs, big efforts).
- **standalones**: isolated tasks (`matt-prototype`, `matt-to-questionnaire`, merge conflicts).
- **vocabulary layer**: underlying reference layer (`matt-codebase-design`, `matt-domain-modeling`).

## phase boundaries
phase = session work block. context decisions happen exclusively at boundaries.

| option | when to use |
| --- | --- |
| **continue** | next phase requires verbatim prior context. |
| **`/clear`** | disposable prior context. cheap + irreversible. |
| **`matt-handoff`** | cross-boundary transport (new directory/harness/collaborator). |
| **subagent** | scoped task runs parallel. |
| **`/compact`** | fallback default. |

`matt-handoff` buys portability. `/compact` sits at bottom => evaluate cheaper options first.

## common questions
**flat skill list?**
static sequence fails branches. real flows depend on codebase state + scope.

**missing skills reported?**
skills setting `disable-model-invocation: true` hide from agent prompt lists. verify via `.claude-plugin/plugin.json`. run slash commands directly.

**inaccurate skill summaries?**
router summarizes without reading individual `SKILL.md` files. prompt router to inspect target `SKILL.md` for load-bearing facts.

**routing external/custom skills?**
unsupported. map = fixed to repo skills.

**editing `SKILL.md`?**
updates overwrite plugin files. place customizations in `CLAUDE.md` or prompts.

## working state
- names next slash command + halts execution
- includes context boundary actions + review checkpoints
- contrasts overlapping skills via concrete criteria
- matches specific user context > generic flows

## pipeline
standalone router. sits outside execution chains. routes to entries like `matt-grill-with-docs` or `matt-triage`.
`SKILL.md` > router claims.