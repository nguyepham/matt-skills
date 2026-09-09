---
name: matt-to-spec
description: "Turn the current conversation into a spec and publish it to the project issue tracker: no interview, just synthesis of what you've already discussed."
disable-model-invocation: true
---

Synthesize current conversation + codebase into spec. Zero interviews.
Missing tracker/triage labels => run `/matt-skill-setup`.

## Process

1. Read codebase state. Use project vocabulary. Respect relevant ADRs.
2. Sketch test seams. Existing seams > new seams. Highest possible seam. Ideal seam count = 1. Request user confirmation.
3. Write spec via template. Publish to issue tracker. Apply `ready-for-agent` label. Zero additional triage.

<spec-template>

## Problem Statement

User's problem from user perspective.

## Solution

Proposed solution from user perspective.

## User Stories

Exhaustive numbered list.
Format: `1. As an <actor>, I want a <feature>, so that <benefit>`

<user-story-example>
1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

## Implementation Decisions

- Modules modified
- Interfaces modified
- Technical clarifications
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Zero file paths. Zero code snippets.
Exception: matt-prototype snippet encoding complex decision (state machine, schema). Trim demo code.

## Testing Decisions

- Test strategy (test external behavior > implementation details)
- Target modules
- Test prior art

## Out of Scope

Explicit out-of-scope boundaries.

## Further Notes

Additional context.

</spec-template>
