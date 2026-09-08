## What it does

`matt-prototype` writes throwaway code. answers design/state questions.
question shapes code. wrong question => pure waste.

throwaway = writing constraint. keep code. zero tests, zero error handling, zero abstractions, zero persistence.
answer folds into main. prototype parks on branch. serves as evidence.

## When to reach for it

type `/matt-prototype` or agent auto-reaches.

unsettled questions => use prototype. examples: complex state machines, unseen UI layouts.
grilling balloons on uncertainty => stop grilling & build throwaway version. look & answer.
broken existing code => use [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs). prototype explores unbuilt ideas.

[matt-wayfinder](../../skills/engineering/matt-wayfinder/SKILL.md) files prototype tickets. working ticket = this skill.

## Two branches

question dictates branch + artifacts.

- **"Logic / state model feel right?"**: single shareable HTML file. zero build & zero server. open via double-click. includes labelled state panel, free-play buttons, tabbed guided walkthroughs. domain-labelled UI => hand to designer/PM. pure logic module drives page. validated logic => lift to real code.
- **"What should this look like?"**: UI variations on one route. switch via floating bar & `?variant=` param. structural variants > color variants. render inside real page + real data.

state stays in memory. zero thinking required. full state shown after step.
hardening (tests, database, generalizations) => stops being prototype.

## Primary source

prototype leaves 2 artifacts.

**answer** (verdict + question): captured durably (commit, ADR, issue). merged to main.
**prototype** (evidence): committed to `matt-prototype/<name>` branch. never merged. issue points to branch. main stays clean. exploration stays findable.

## Common questions

**delete prototype?**
no. prose summary loses context. prototype = [primary source](https://www.aihero.dev/ai-coding-dictionary/primary-source). commit to `matt-prototype/<name>` branch. link from issue. never merge.

**terminal app?**
logic branch emits HTML file. terminal app requires cloned repo + runtime. HTML file requires double-click. designers/PMs can drive HTML file. pure logic module remains unchanged.

**agent misdirected to prototype?**
known naming issue. known design => `/matt-implement`. unresolved design question => `/matt-prototype`.

**prototype whole application?**
no. prototype = single question. full-app prototype => becomes production app. bad code reaches users. sales demo = build demo explicitly. design question = narrow prototype.

**run in own session?**
yes. prototype generates context. run elsewhere & return answer. [matt-handoff](../../skills/productivity/matt-handoff/SKILL.md) bridges sessions.

**burns tokens?**
yes if misused. wrong state model in production > prototype token spend. narrow question + short run => proportionate spend.

## It's working if

- 1-sentence question written at top.
- non-coders can drive logic demo.
- exposes idea bugs ("shouldn't be possible").
- UI variants disagree on layout/hierarchy.
- answered in 1 sitting. >1 day => question too big.
- main contains decision. issue points to prototype branch.

## Where it fits

`matt-prototype` = reach-for-it-anytime standalone. settle design question & exit.

[matt-wayfinder](../../skills/engineering/matt-wayfinder/SKILL.md) consumes it. ticket types include UI/behavior questions. prototype resolves ticket. map links prototype.

upstream: ungrillable questions from [matt-grill-me](../../skills/productivity/matt-grill-me/SKILL.md) & [matt-grill-with-docs](../../skills/engineering/matt-grill-with-docs/SKILL.md) come here.
downstream: validated model inputs to [matt-to-spec](../../skills/engineering/matt-to-spec/SKILL.md).
[matt-ask](../../skills/engineering/matt-ask/SKILL.md) routes all.
