# Model-invoked vs user-invoked

Every `SKILL.md` = skill. Invocation axis splits access.

- **User-invoked**: Human-only. Set `disable-model-invocation: true` (Claude Code) & `policy.allow_implicit_invocation: false` (`agents/openai.yaml`). Human-facing 1-line description. Strip trigger lists.
- **Model-invoked**: Model or human. Default (omit configs). Model-facing description. Keep trigger phrases. Autonomous model use => model-invoked.

Harnesses block model from user-invoked skills. User-invoked skill can call model-invoked skill. Skill cannot call user-invoked skill.

Sync `agents/openai.yaml` metadata (`interface.display_name`, `interface.short_description`, `policy.allow_implicit_invocation`) with `SKILL.md`.

Group `README.md` entries into **User-invoked** & **Model-invoked**.

## Dependencies

Express operative dependencies via Skill tool (`Call the Skill tool with "grilling"`). Drop relative file links. Drop bare `/skill` mentions. Shared reference docs live inside owning skill.

Router prose (`ask-matt`, bucket `README.md`s) keeps plain `/skill` labels.

Skill tool takes 1 skill per call. 2 skills => 2 tool calls.

Skill tool calls only model-invoked skills. User-invoked skill precondition => instruct human ("tell the user to run `/matt-skill-setup`").

## Passive vs active domain work

Reading `CONTEXT.md` = prose pointer. Active build/sharpen discipline (challenge terms, write ADRs) = `domain-modeling` skill.
