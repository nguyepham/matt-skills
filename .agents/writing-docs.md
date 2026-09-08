# Writing docs pages

Promoted skills (`engineering/` & `productivity/`) => human-facing docs page at `docs/<bucket>/<skill-name>.md`. URL = `https://aihero.dev/skills-<skill-name>`.
Unpromoted skills (`misc/`, `in-progress/`, `deprecated/`) => zero docs page.

Docs page relieves cognitive load. Orients reader. Acts as router node.

Skill add/rename/change => create or sync docs page. Rename => move docs file. Change bucket => move docs file.

Links must use absolute URLs (`https://aihero.dev/skills-<name>` or full GitHub URL). Zero relative repo links.

Zero H1. Slug provides title.

## Page structure

Follow template order. Fixed frame (`## What it does`, `## When to reach for it`, `## Where it fits`) = mandatory. Include `## Prerequisites` & substance sections conditionally.

Page carries zero install commands. UI widget renders install commands.

<page-template>

## What it does

1-2 paragraphs. State job + defining constraint. Zero labeled asides.

## When to reach for it

- **Invocation mode**: State model-invoked or user-invoked.
- **Trigger boundary**: "Reach for this when...".

## Prerequisites

Optional. State required workspace, prior setup, or tooling. Stateless skill => omit section.

## <free-form middle>

1-3 short sections. Use skill vocabulary. Surface leading word.

## Common questions

Observed questions > invented questions. Search wiki (`wiki/audience/`), repo issues, `CHANGELOG.md`. Order by frequency. Zero questions => omit section.

## It's working if

Observable signals. Checkable without opening `SKILL.md`. Vague signals => omit section.

## Where it fits

Mandatory.
- **Role**: State chain step, run-once setup, periodic maintenance, or standalone.
- **Neighbors**: Link 1-2 sibling skills.
- **Map**: Link to [ask-matt](https://aihero.dev/skills-ask-matt).

</page-template>

## Conventions

- Explain why. Omit process.
- Omit author names. State facts directly. Quote users anonymously.
- Use skill leading words.
- Use AI Coding Dictionary terms. Link first use to `https://www.aihero.dev/ai-coding-dictionary/<slug>`. Zero links in headings/code.
- Format branches as tables or lists. Zero paragraph branches.
- Keep page low-load.

## Done when

- Page exists at `docs/<bucket>/<name>.md`.
- Zero source links & zero install commands.
- `## What it does` states defining constraint clearly.
- Page quotes zero authors.
- `## When to reach for it` states invocation mode & trigger boundary.
- `## Where it fits` names role & links to `ask-matt`.
- `## Prerequisites` appears only for stateful skills.
- Middle surfaces leading word.
- Dictionary terms use exact spelling & absolute link on first use.
- Branches use tables or lists.
- `## Common questions` matches issue/wiki evidence.
- `## It's working if` bullets offer observable signals.
- Template section order preserved.
- Links resolve & use absolute URLs.
