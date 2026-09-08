# matt-grill-with-docs

## what it does
interviews user about plan/design until shared understanding exists. writes vocabulary + decisions to repo.
stateful. term resolves => writes to `CONTEXT.md`. decision passes gates => writes to ADR.

## when to use
invoke via `/matt-grill-with-docs`. single-session tool. start of change.

| state | tool |
| --- | --- |
| no working directory | `matt-grill-me` |
| repo + 1-session change | `matt-grill-with-docs` |
| multi-session effort | `matt-wayfinder` |
| zero docs repo + no feature | `matt-grill-with-docs` |
| blocked on human knowledge | `matt-to-questionnaire` |

## prerequisites
requires write access. creates files lazily.
requires `matt-grilling` + `matt-domain-modeling`. `matt-grill-with-docs` alone => fails.

## output
| output | destination |
| --- | --- |
| term | `CONTEXT.md` inline |
| hard trade-off decision | `docs/adr/` |
| other decisions | conversation |

`CONTEXT.md` = glossary. zero implementation details. ADRs require strict gates. conversation holds most decisions. pass conversation to `matt-to-spec`.

## common questions
**vs `/matt-wayfinder`?**
scope. 1 session => this. multi-session => `matt-wayfinder`.

**no files?**
decisions missed ADR gates. or orchestration layer bug blocked writes. check working directory.

**dumped questions + no `CONTEXT.md`?**
missing dependencies. agent guessed skill. check `matt-grilling` + `matt-domain-modeling` installation.

**lost decisions?**
decisions stay in conversation. pass session to `matt-to-spec`. re-read spec.

**repo with zero docs?**
yes. invoke + say "help document repo". pair with `matt-improve-codebase-architecture`.

**after session?**
pass to `matt-to-spec`. small change => pass to `matt-implement`.

## working state
- `CONTEXT.md` updates during session
- glossary = pure vocabulary
- agent reads codebase for facts
- few ADRs
- agent challenges existing glossary terms

## pipeline
`matt-grill-with-docs` => `matt-to-spec` => `matt-to-tickets` => `matt-implement` => `matt-code-review`
