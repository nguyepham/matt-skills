# matt-domain-modeling

## what it does
sharpens project ubiquitous language. challenges conflicting terms. forces precise words. stress-tests relationships => exact boundaries.
writes resolved terms to `CONTEXT.md` inline.

## when to use
invoke via `/matt-domain-modeling`. auto-invocation = weak (models skip it). untouched `CONTEXT.md` after `matt-grilling` => invoke manually.

| situation | move |
| --- | --- |
| conflicting meaning | `matt-domain-modeling`: pick canonical term + list others under `_Avoid_` |
| overloaded term | `matt-domain-modeling`: split |
| hard-to-reverse choice | `matt-domain-modeling`: writes ADR |
| problematic module seam | `matt-codebase-design` |
| interrogate plan | `matt-grill-with-docs` |
| lookup term | read `CONTEXT.md` |

## prerequisites
zero setup. creates artifacts lazily.
- `CONTEXT.md`: repo root. `CONTEXT-MAP.md` exists => uses mapped `CONTEXT.md`.
- `docs/adr/`: created by first valid ADR.

## artifacts
| artifact | `CONTEXT.md` | `docs/adr/NNNN-slug.md` |
| --- | --- | --- |
| holds | terms. definition + rejected synonyms (`_Avoid_`). | decisions. context + choice + reason. |
| bar | vague term => canonical term | hard to reverse + surprising + real trade-off |
| written | inline | offered |
| skips | implementation details, spec, scratch pad | session diary |

ADR misses test => zero ADR.
`CONTEXT.md` rule = glossary only. unchecked models write specs => bloated `CONTEXT.md`.

## cross-referencing
cross-references code vs terms. surfaces contradictions. language & code must agree.
limit: scans code + committed `CONTEXT.md`/ADRs only. zero issue tracker search. workaround: add instructions to `docs/agents/domain.md`.

## common questions
**bloated `CONTEXT.md`?**
symptom of implementation details. fix: run `/matt-grill-with-docs make my CONTEXT.md more concise and remove any implementation details from it`.

**`CONTEXT.md` vs `GLOSSARY.md`?**
unsettled debate. `GLOSSARY.md` = clear intent. `CONTEXT-MAP.md` = DDD mapping. rename requires patching all skills.

**where is `/ubiquitous-language`?**
merged into `matt-domain-modeling`.

**add glossary to existing codebase?**
invoke `/matt-grill-with-docs help me scaffold my existing repo with a CONTEXT.md`.

**custom ADR format?**
unsupported cleanly. conflicting templates => override in agent docs or fork skill.

**glossary value?**
yes for upstream naming/alignment. zero value for plain prose. skip for 1-day builds.

**fixes vague prompts?**
no. skill enforces precision for understood domains. zero vocabulary manufacturing.

## working state
- interrupts mid-sentence to clarify meanings
- `CONTEXT.md` updates during conversation
- refuses weak ADRs
- defines terms + lists `_Avoid_` synonyms
- quotes code for contradictions
- `CONTEXT.md` shrinks often

## pipeline
model-invoked reference. runs underneath skills:
- `matt-grill-with-docs`: drives it
- `matt-wayfinder`: loads it for mapping
- `matt-triage`: aligns ticket terms
- `matt-improve-codebase-architecture`: crystallises decisions

closest sibling: `matt-codebase-design`. unsure => `matt-ask`.
