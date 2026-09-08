# matt-implement

## what it does
builds decided work (ticket, spec, or conversation plan).
writes code + drives `matt-tdd` at seams + typechecks + runs `matt-code-review` + commits to current branch.
never reopens plan. zero interviews. zero new approaches. turns settled upstream work into commits.

## when to use
invoke via `/matt-implement`. zero auto-invocation (`disable-model-invocation: true`).

| work location | tool |
| --- | --- |
| tracker ticket | `/matt-implement #42` (1 ticket per session + clear context between) |
| large unsplit spec | run `matt-to-tickets` first => `/matt-implement` per ticket |
| small spec | `/matt-implement` directly |
| conversation plan (small) | `/matt-implement` in same window (declare plan source in prompt) |
| unwritten plan | run `matt-grill-with-docs` or `matt-grill-me` first |
| 1 concrete behaviour | run `matt-tdd` directly |
| already built | run `matt-code-review` directly |

## prerequisites
commits to current branch. zero branch creation. verify branch before starting.
tracker tickets require `matt-skill-setup` configuration.

## run sequence
1 run = 1 ticket = 5 beats:
1. read ticket/spec + identify seams
2. drive `matt-tdd` at pre-agreed seams (red-green slices)
3. typecheck often + run single test files
4. run full test suite once
5. run `matt-code-review` + commit to current branch

clear context => implement 1 ticket => commit => clear again.

## pre-agreed seams
seam = public boundary for observing behavior. tests live at seams.
`matt-tdd` requires confirmed seams. name seams in spec => prevents default "just write the code" fallback.

## common questions
**ticket remains open + unchecked criteria?**
expected. skill ends at commit. zero tracker integration. close ticket + check boxes manually.

**batch tickets or parallel runs?**
no. 1 invocation = 1 ticket. parallel runs in 1 checkout => git index collisions + lost stashes + wrong branches. use git worktrees for parallelism.

**open PR instead of commit?**
unsupported natively. override via prompt instruction or edit skill locally.

**`matt-code-review` cannot see changes?**
known bug. review checks `git diff <fixed-point>...HEAD`, ignoring staged/working-tree edits. workaround: commit first => review. or run `matt-code-review` in fresh session.

**high token burn (150k+)?**
ticket > context window. right-size tickets in `matt-to-tickets`. split big tickets instead of raising effort level.

**wrong issue fetched for `#2`?**
`#2` matches local lists (todos, checklists) before remote tracker. pass full URL or `owner/repo#2`.

## working state
- reads ticket/spec + states plan (zero questions asked)
- trace shows actual `matt-tdd` invocations
- typechecks + single test files run repeatedly
- reaches commit on current branch without prompting
- diff = 1 vertical slice (1 ticket scope)

## pipeline
`matt-grill-with-docs` => `matt-to-spec` => `matt-to-tickets` => `matt-implement` => `matt-code-review`

consumes `matt-to-tickets` output. drives `matt-tdd`. runs `matt-code-review`.
trusts upstream planning. badly-structured ticket => badly-structured code.
route via `matt-ask`.
