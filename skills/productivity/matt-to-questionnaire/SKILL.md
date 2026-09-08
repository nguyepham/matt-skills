---
name: matt-to-questionnaire
description: turn unanswered decision into questionnaire for recipient.
disable-model-invocation: true
---

convert user knowledge gap => markdown questionnaire. recipient holds missing knowledge. questionnaire extracts it.

grill send, not subject. interview user about send: recipient + required output. questions target gap between recipient knowledge & user needs.

1. **recipient:** ask role, expertise, relationship. fixes tone + context depth. done when recipient + knowledge gap identified.
2. **required output:** ask specific decisions/facts user needs. done when concrete list of required outcomes exists.
3. **write questionnaire:** draft questions targeting gap. follow document structure. write to `to-questionnaire-<slug>.md` in current directory. report path. done when file exists + covers all step 2 items.

## document structure

frame as discovery questionnaire. user lacks context. recipient holds it.
order questions most-important-first. group under `##` themes if > 5 questions. use template below.

<questionnaire-template>

# <title>

**purpose:** questionnaire reason + dependent decision.

**from:** <user>, **to:** <recipient>, **usage:** <destination>

## context

1 paragraph orientation.

## how to answer

deadline + rough effort. partial answers + "I don't know" = acceptable. flag uncertainties.

## <theme>

1 `##` section per theme. questions most-important-first. 1 idea per question. add answer stub. add 1-line _why this matters_ if ambiguous.

<question-example>
### What load is the system expected to handle at launch?

_Why this matters: it decides whether we provision for burst traffic now or defer it._

>
</question-example>

## anything else?

closing catch-all.

</questionnaire-template>
