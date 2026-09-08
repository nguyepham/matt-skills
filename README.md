# Skills For Real Engineers

Agent skills for engineering.

GSD, BMAD & Spec-Kit own process + remove control => hard bugs. These skills: small, composable, model-agnostic. Modify them.

### 1. Run `/setup-matt-pocock-skills`

Run once per repo. Configures:
- Issue tracker (GitHub, Linear, local)
- Triage labels
- Docs location

### 2. Ready.

## Why These Skills Exist

Fixes common agent failure modes.

### #1: Misalignment

Agent misunderstands goal. Solution: rigorous questions.

Use:
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md): adds domain documentation

Aligns agent + user before coding. Use for every change.

### #2: Verbosity

Agents lack domain jargon => long responses. Solution: shared language.

<details>
<summary>Example</summary>

From [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md):
- **Before**: "There's a problem when a lesson inside a section of a course is made 'real' (i.e. given a spot in the file system)"
- **After**: "There's a problem with the materialization cascade"
</details>

[`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) builds shared language. Updates `CONTEXT.md` & ADRs.
Consistent names => easier navigation + lower token cost.

### #3: Broken Code

Agent lacks feedback => bad code. Solution: static types, browser access, automated tests.

- **[`/tdd`](./skills/engineering/matt-tdd/SKILL.md)**: red-green-refactor loop. Write failing test => fix test.

### #4: Architecture Rot

Agents accelerate codebase complexity. Solution: active design.

- [`/to-spec`](./skills/engineering/to-spec/SKILL.md): queries touched modules before creating spec.
- [`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md): surveys codebase for deepening opportunities. Run frequently.

## Reference

**User-invoked**: typed manually (orchestration).
**Model-invoked**: auto-triggered or typed manually (reusable primitives).
User-invoked skill cannot invoke another user-invoked skill.

### Engineering

Daily code work.

**User-invoked**
- **[ask-matt](./skills/engineering/ask-matt/SKILL.md)**: skill router.
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)**: grilling session + domain model builder (`CONTEXT.md`, ADRs).
- **[triage](./skills/engineering/triage/SKILL.md)**: issue triage state machine.
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)**: architecture scan HTML report + grilling.
- **[setup-matt-pocock-skills](./skills/engineering/setup-matt-pocock-skills/SKILL.md)**: repo configuration.
- **[to-spec](./skills/engineering/to-spec/SKILL.md)**: conversation => tracker spec.
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)**: spec => blocking tracer-bullet tickets.
- **[implement](./skills/engineering/matt-implement/SKILL.md)**: build spec via `/tdd` + `/code-review`.
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)**: large work planning via tracker tickets.

**Model-invoked**
- **[prototype](./skills/engineering/prototype/SKILL.md)**: throwaway HTML prototypes.
- **[tdd](./skills/engineering/matt-tdd/SKILL.md)**: red-green-refactor loop.
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)**: refine `CONTEXT.md` terminology.
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)**: deep module design.
- **[code-review](./skills/engineering/code-review/SKILL.md)**: standards & spec review.

### Productivity

General workflow tools.

**User-invoked**
- **[handoff](./skills/productivity/handoff/SKILL.md)**: conversation => handoff doc.
- **[to-questionnaire](./skills/productivity/to-questionnaire/SKILL.md)**: decision => markdown questionnaire.
- **[wait-what](./skills/productivity/wait-what/SKILL.md)**: re-pitch missing context.

**Model-invoked**
- **[grilling](./skills/productivity/grilling/SKILL.md)**: base interview primitive.
