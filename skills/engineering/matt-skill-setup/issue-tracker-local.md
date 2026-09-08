# Issue tracker: Local Markdown
issues & specs = markdown files in `.scratch/`.

## Conventions
- **Feature directory**: `.scratch/<feature-slug>/`
- **Spec**: `.scratch/<feature-slug>/spec.md`
- **Tickets**: `.scratch/<feature-slug>/issues/<NN>-<slug>.md`. number from `01`. zero combined ticket files.
- **Triage state**: `Status:` line near top (reference `triage-labels.md` for role strings).
- **Comments**: append to bottom under `## Comments`.

## Skill mappings
"publish to the issue tracker" => create new file under `.scratch/<feature-slug>/` (create directory if missing).
"fetch the relevant ticket" => read referenced file. user passes path or issue number directly.

## Wayfinding operations
used by `/matt-wayfinder`. **map** = file. **child** = one file per ticket.
- **Map**: `.scratch/<effort>/map.md`. holds notes, decisions, fog.
- **Child ticket**: `.scratch/<effort>/issues/NN-<slug>.md`. number from `01`. body holds question. `Type:` line records `research`/`matt-prototype`/`matt-grilling`/`task`. `Status:` line records `claimed`/`resolved`.
- **Blocking**: `Blocked by: NN, NN` line near top. unblocked => all listed files `resolved`.
- **Frontier**: scan `.scratch/<effort>/issues/` for open, unblocked, unclaimed files. lowest number wins.
- **Claim**: set `Status: claimed`. save before work.
- **Resolve**: append answer under `## Answer`. set `Status: resolved`. append context pointer (gist + link) to map decisions in `map.md`.
