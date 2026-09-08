# Issue tracker: GitHub
repo uses github issues. use `gh` cli for all operations.

## Conventions
- **Create**: `gh issue create --title "..." --body "..."`. multi-line body => use heredoc.
- **Read**: `gh issue view <number> --comments`. filter comments & fetch labels via `jq`.
- **List**: `gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`. add `--label` & `--state` filters.
- **Comment**: `gh issue comment <number> --body "..."`
- **Labels**: `gh issue edit <number> --add-label "..."` or `--remove-label "..."`
- **Close**: `gh issue close <number> --comment "..."`
`gh` infers repo automatically inside clone.

## Pull requests for triage
**PRs as request surface: no.** _(`yes` => treats external PRs as feature requests. `/triage` reads flag.)_

`yes` => PRs use issue labels/states via `gh pr` equivalents:
- **Read PR**: `gh pr view <number> --comments` & `gh pr diff <number>`.
- **List external PRs**: `gh pr list --state open --json number,title,body,labels,author,authorAssociation,comments`. keep `authorAssociation` = `CONTRIBUTOR`, `FIRST_TIME_CONTRIBUTOR`, or `NONE`.
- **Update**: `gh pr comment`, `gh pr edit --add-label`/`--remove-label`, `gh pr close`.

issues + PRs share number space. bare `#42` => `gh pr view 42` fallback `gh issue view 42`.

## Skill mappings
"publish to the issue tracker" => create github issue.
"fetch the relevant ticket" => run `gh issue view <number> --comments`.

## Wayfinding operations
used by `/matt-wayfinder`. **map** = single issue. **child** = tickets.
- **Map**: single issue. labels `matt-wayfinder:map`. holds notes, decisions, fog. `gh issue create --label matt-wayfinder:map`.
- **Child ticket**: links to map via github sub-issue (`gh api`). sub-issues disabled => add child to map task list & prepend `Part of #<map>` in child body. labels `matt-wayfinder:<type>` (`research`, `matt-prototype`, `matt-grilling`, `task`). assignment => driving dev.
- **Blocking**: native issue dependencies. canonical UI-visible representation. `gh api --method POST repos/<owner>/<repo>/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>`. `<blocker-db-id>` = numeric database id (`gh api repos/<owner>/<repo>/issues/<n> --jq .id`). `issue_dependencies_summary.blocked_by` reports open blockers. dependencies disabled => fallback prepend `Blocked by: #<n>, #<n>` in child body. unblocked => all blockers closed.
- **Frontier query**: list map open children (`gh issue list --state open`). drop open blockers (`issue_dependencies_summary.blocked_by > 0` or open issue in `Blocked by` line). drop assignees. first in map order wins.
- **Claim**: `gh issue edit <n> --add-assignee @me`. session first write.
- **Resolve**: `gh issue comment <n> --body "<answer>"`. `gh issue close <n>`. append context pointer (gist + link) to map decisions.
