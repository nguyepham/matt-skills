# Issue tracker: GitLab
repo uses gitlab issues. use `glab` cli for all operations.

## Conventions
- **Create**: `glab issue create --title "..." --description "..."`. multi-line description => use heredoc or `--description -`.
- **Read**: `glab issue view <number> --comments`. machine-readable => use `-F json`.
- **List**: `glab issue list -F json`. add `--label` filters.
- **Comment (Note)**: `glab issue note <number> --message "..."`.
- **Labels**: `glab issue update <number> --label "..."` or `--unlabel "..."`. comma-separate multiple labels.
- **Close**: `glab issue close <number>`. post explanation note first.
- **Merge requests**: PRs = MRs. use `glab mr create`, `glab mr view`, `glab mr note`. replace `pr` with `mr`, `comment`/`--body` with `note`/`--message`.
`glab` infers repo automatically inside clone.

## Merge requests for triage
**MRs as request surface: no.** _(`yes` => treats external MRs as feature requests. `/triage` reads flag.)_

`yes` => MRs use issue labels/states via `glab mr` equivalents:
- **Read MR**: `glab mr view <number> --comments` & `glab mr diff <number>`.
- **List external MRs**: `glab mr list -F json`. keep MRs by non-members (contributors, zero maintainer work).
- **Update**: `glab mr note`, `glab mr update --label`/`--unlabel`, `glab mr close`.

issues + MRs number separately. `#42` unambiguous per surface.

## Skill mappings
"publish to the issue tracker" => create gitlab issue.
"fetch the relevant ticket" => run `glab issue view <number> --comments`.

## Wayfinding operations
used by `/wayfinder`. **map** = single issue. **child** = tickets.
- **Map**: single issue. labels `wayfinder:map`. holds notes, decisions, fog. `glab issue create --label wayfinder:map`. (native epics work on supported tiers).
- **Child ticket**: prepend `Part of #<map>` in description. labels `wayfinder:<type>` (`research`, `prototype`, `grilling`, `task`). assignment => driving dev.
- **Blocking**: native blocking link. canonical UI-visible representation. add via `/blocked_by #<n>` quick action note (`glab issue note <child> --message "/blocked_by #<blocker>"`). free tier / unavailable => fallback prepend `Blocked by: #<n>, #<n>` in description. unblocked => all blockers closed.
- **Frontier query**: `glab issue list -F json` scoped to map children. drop open blockers (native `blocked_by` link to open issue via `glab api projects/:id/issues/:iid/links` or open issue in `Blocked by` line). drop assignees. first in map order wins.
- **Claim**: `glab issue update <n> --assignee @me`. session first write.
- **Resolve**: `glab issue note <n> --message "<answer>"`. `glab issue close <n>`. append context pointer (gist + link) to map decisions.
