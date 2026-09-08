# Skills For Real Engineers

Agent skills for engineering.

GSD, BMAD & Spec-Kit own process + remove control => hard bugs. These skills: small, composable, model-agnostic. Modify them.

### 1. Run `/matt-skill-setup`

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
- [`/matt-grill-with-docs`](./skills/engineering/matt-grill-with-docs/SKILL.md): adds domain documentation

Aligns agent + user before coding. Use for every change.

### #2: Verbosity

Agents lack domain jargon => long responses. Solution: shared language.

<details>
<summary>Example</summary>

From [`CONTEXT.md`](https://github.com/mattpocock/course-video-manager/blob/076a5a7a182db0fe1e62971dd7a68bcadf010f1c/CONTEXT.md):
- **Before**: "There's a problem when a lesson inside a section of a course is made 'real' (i.e. given a spot in the file system)"
- **After**: "There's a problem with the materialization cascade"
</details>

[`/matt-grill-with-docs`](./skills/engineering/matt-grill-with-docs/SKILL.md) builds shared language. Updates `CONTEXT.md` & ADRs.
Consistent names => easier navigation + lower token cost.

### #3: Broken Code

Agent lacks feedback => bad code. Solution: static types, browser access, automated tests.

- **[`/matt-tdd`](./skills/engineering/matt-tdd/SKILL.md)**: red-green-refactor loop. Write failing test => fix test.

### #4: Architecture Rot

Agents accelerate codebase complexity. Solution: active design.

- [`/matt-to-spec`](./skills/engineering/matt-to-spec/SKILL.md): queries touched modules before creating spec.
- [`/matt-improve-codebase-architecture`](./skills/engineering/matt-improve-codebase-architecture/SKILL.md): surveys codebase for deepening opportunities. Run frequently.

## Reference

**User-invoked**: typed manually (orchestration).
**Model-invoked**: auto-triggered or typed manually (reusable primitives).
User-invoked skill cannot invoke another user-invoked skill.

### Engineering

Daily code work.

**User-invoked**
- **[matt-ask](./skills/engineering/matt-ask/SKILL.md)**: skill router.
- **[matt-grill-with-docs](./skills/engineering/matt-grill-with-docs/SKILL.md)**: matt-grilling session + domain model builder (`CONTEXT.md`, ADRs).
- **[triage](./skills/engineering/triage/SKILL.md)**: issue triage state machine.
- **[matt-improve-codebase-architecture](./skills/engineering/matt-improve-codebase-architecture/SKILL.md)**: architecture scan HTML report + matt-grilling.
- **[matt-skill-setup](./skills/engineering/matt-skill-setup/SKILL.md)**: repo configuration.
- **[matt-to-spec](./skills/engineering/matt-to-spec/SKILL.md)**: conversation => tracker spec.
- **[matt-to-tickets](./skills/engineering/matt-to-tickets/SKILL.md)**: spec => blocking tracer-bullet tickets.
- **[matt-implement](./skills/engineering/matt-implement/SKILL.md)**: build spec via `/matt-tdd` + `/matt-code-review`.
- **[matt-wayfinder](./skills/engineering/matt-wayfinder/SKILL.md)**: large work planning via tracker tickets.

**Model-invoked**
- **[matt-prototype](./skills/engineering/matt-prototype/SKILL.md)**: throwaway HTML prototypes.
- **[matt-tdd](./skills/engineering/matt-tdd/SKILL.md)**: red-green-refactor loop.
- **[matt-domain-modeling](./skills/engineering/matt-domain-modeling/SKILL.md)**: refine `CONTEXT.md` terminology.
- **[matt-codebase-design](./skills/engineering/matt-codebase-design/SKILL.md)**: deep module design.
- **[matt-code-review](./skills/engineering/matt-code-review/SKILL.md)**: standards & spec review.

### Productivity

General workflow tools.

**User-invoked**
- **[matt-handoff](./skills/productivity/matt-handoff/SKILL.md)**: conversation => matt-handoff doc.
- **[matt-grill-me](./skills/productivity/matt-grill-me/SKILL.md)**: grilling conversation.
- **[matt-to-questionnaire](./skills/productivity/matt-to-questionnaire/SKILL.md)**: decision => markdown questionnaire.
- **[matt-wait-what](./skills/productivity/matt-wait-what/SKILL.md)**: re-pitch missing context.

**Model-invoked**
- **[matt-grilling](./skills/productivity/matt-grilling/SKILL.md)**: base interview primitive.
