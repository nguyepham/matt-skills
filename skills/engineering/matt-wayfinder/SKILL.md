---
name: matt-wayfinder
description: map multi-session work as decision tickets in issue tracker + resolve sequentially.
disable-model-invocation: true
---

large idea + unknown route => **shared map**.
chart map in issue tracker.
resolve **decision tickets** sequentially.
decision ticket = decision question. skips build execution.

destination defines effort scope.
name destination first.
example destinations: handoff spec, locked decision, data-structure migration.
map supports engineering, course content, general domain work.

## Plan, don't do

default mode = **planning**.
ticket resolves decision.
cleared route + zero decisions => finished map.
execution urge => map edge reached + handoff required.
override default via **Notes** section => carry execution into map.
zero override => produce decisions, zero deliverables.

## Refer by name

map & ticket = tracker issue. name = issue title.
use names in narration + Decisions-so-far.
skip bare ids, numbers, slugs.
name wraps link. id & URL ride inside name.

## The Map

map = single issue labelled `matt-wayfinder:map`. canonical artifact.
tickets = map child issues.
map = index, zero store.
map lists decisions + links tickets.
decision lives in ticket. map gists + links.

tracker defines map, child tickets, blocking, frontier queries.
zero tracker => tell user run `/matt-skill-setup`.
consult tracker doc "Wayfinding operations" section for repo syntax.
zero tracker => fallback local-markdown tracker.

### The map body

load low-resolution map once per session.
query open tickets. skip listing open tickets in map body.

```markdown
## Destination

<end state of map: spec, decision, or change. 1-2 lines.>

## Notes

<domain, skills, standing preferences>

## Decisions so far

<!-- index: 1 line per closed ticket + gist + link -->

- [<closed ticket title>](link): <one-line gist>

## Not yet specified

<!-- see "Fog of war": unspecifiable in-scope fog. graduates as frontier advances -->

## Out of scope

<!-- see "Out of scope": work beyond destination. closed + zero graduation -->
```

### Tickets

ticket = map **child issue**. tracker issue id = identity.
body size = 100K token agent session limit:

```markdown
## Question

<decision or investigation>
```

label requires `matt-wayfinder:<type>`.
type = `research`, `matt-prototype`, `matt-grilling`, `task` (see [Ticket Types](#ticket-types)).

session **claims** ticket via assignment.
assign to driving dev first.
concurrent sessions skip claimed tickets.
unassigned ticket = unclaimed.

blocking uses **native** tracker dependency.
tracker UI renders frontier visually.
native blocking => visual takeable tickets.
zero native blocking => fallback body convention.
zero blocking tickets => **unblocked** ticket.
**frontier** = open & unblocked & unclaimed child issues.

record answer on resolution (see [Work through the map](#work-through-the-map)).
skip answer in body. link created assets from issue.

## Ticket Types

**HITL** (human in the loop) or **AFK** (agent alone).
HITL ticket resolves via live exchange.
agent answering own questions => broken HITL.

- **Research** (AFK): read external docs, APIs, local knowledge bases. unblocks decision. subagent calls Skill tool `research`. use for external knowledge.
- **Prototype** (HITL): create cheap concrete artifact (outline, stub, UI/logic code). call Skill tool `matt-prototype`. link prototype as asset. use for visual/behavioral questions.
- **Grilling** (HITL): conversation default. call Skill tool twice: `matt-grilling` + `matt-domain-modeling`.
- **Task** (HITL or AFK): manual work blocking decision. provisioning, service signup, data moves. executes task, unblocks decision, skips destination delivery. agent drives AFK or hands human checklist HITL. resolution records actions + facts (credentials, URLs, row counts).

## Fog of war

incomplete map = deliberate. skip charting invisible items.
**fog of war** = future decisions awaiting open questions.
ticket resolution clears fog. specifiable fog graduates to tickets.
zero tickets => clear route.

**Not yet specified** = dim view of suspected questions. undiscovered frontier.
in-scope fog, unspecifiable tickets.
write loosely. signpost for collaborators.

**Fog or ticket?**
test: question sharpness > answer availability.

- **Ticket when** sharp question + blocked execution.
- **Not yet specified when** unsharp question. skip pre-slicing fog. frontier advances => single fog patch => multiple/zero tickets.

**Not yet specified** excludes decided items, live tickets, out-of-scope work.

## Out of scope

destination fixes scope.
work beyond destination = **out of scope**.
skip **Not yet specified**. use **Out of scope** section.
ruled-out work.

out-of-scope work skips graduation. frontier stops at destination.
redrawn destination => fresh effort.

ruling out scope = scoping act, zero route step.
ticket beyond destination => **close ticket**.
add 1 line to **Out of scope**: gist + reason + link.
skip **Decisions so far**.

## Invocation

two modes.
**resolve 1 ticket per session**. research tickets = exception.

### Chart the map

user invokes with loose idea.

1. **Name destination.** call Skill tool twice: `matt-grilling` + `matt-domain-modeling`. define spec, decision, or change. destination fixes scope.
2. **Map frontier.** grill **breadth-first**. surface open decisions + initial steps. zero fog => single-session effort => stop + ask user.
3. **Create map** (`matt-wayfinder:map` label): write Destination + Notes. skip Decisions-so-far. sketch fog in **Not yet specified**.
4. **Create specifiable tickets** as map child issues. wire blocking edges in **second pass**. sort into frontier + blocked. keep unspecifiable items in **Not yet specified**.
5. **Fire research subagents.** spin subagent per `research` ticket. call Skill tool `research`. resolve in parallel. capture findings on throwaway `research/<name>` branch + context pointer.
6. Stop. charting = 1 session. zero hand-resolutions.

### Work through the map

user invokes via map URL or number.
ticket = **optional**. zero user ticket => pick next decision.

1. Load **map**: low-res view. skip ticket bodies.
2. Choose ticket. use user ticket or first frontier ticket. **Claim it**: assign to self.
3. Resolve it. **Zoom**: fetch ticket bodies on demand. call Skill tool for `## Notes` skills. fallback: call Skill tool twice (`matt-grilling` + `matt-domain-modeling`).
4. Record resolution. post answer as **resolution comment**. **close** issue. **append context pointer** to map Decisions-so-far.
5. Add tickets (create-then-wire). graduate specifiable fog. remove graduated fog from **Not yet specified**. out-of-scope ticket => **rule out of scope**, skip resolution. invalid map parts => update or delete tickets.

users run unblocked tickets in parallel => expect concurrent tracker edits.