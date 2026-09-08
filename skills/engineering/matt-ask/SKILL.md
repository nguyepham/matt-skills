---
name: matt-ask
description: Ask which skill or flow fits your situation. A router over the skills in this repo.
disable-model-invocation: true
---

# Ask Matt

Ask to find relevant skills.

**Flow** = path through skills. Paths use one **main flow** + two **on-ramps**. Others are standalone or vocabulary layers.

## Main flow: idea → ship

Standard route. Build new ideas.

1. **`/matt-grill-with-docs`** sharpens idea via interview. Use inside **working directory**: retains knowledge in `CONTEXT.md` & ADRs. (Runs `/matt-grilling` primitive. Leaves paper trail => better for repos.)
2. **Branch: answer questions in conversation?** Unanswered questions (state, logic, UI) => detour through matt-prototype. Bridge via **`/matt-handoff`** (prototypes need isolated directories).
   - **`/matt-handoff`** out + open fresh session against file.
   - **`/matt-prototype`** answers question with throwaway code.
   - **`/matt-handoff`** back learned context + reference from idea thread.
3. **Branch: multi-session build?**
   - **Yes** => **`/matt-to-spec`** (thread to spec) + **`/matt-to-tickets`** (split into tracer-bullet tickets with **blocking edges**). Local tracker => `.scratch/<feature>/issues/` worked blockers-first. Real tracker => native blocking links. Unblocked tickets => kick off **`/matt-implement`** per ticket + **`/clear` context between tickets**. Self-contained tickets => disposable context.
   - **No** => **`/matt-implement`** in current context window.

**`/matt-implement`** builds issues via **`/matt-tdd`** (red-green slices). Closes via **`/matt-code-review`** (Standards + Spec axes) before committing. Use **`/matt-tdd`** standalone for test-first behaviors. Use **`/matt-code-review`** standalone for branch/PR reviews.

### Context hygiene

Keep steps 1-3 in **one unbroken context window** (no compact/clear before `/matt-to-tickets`). Grilling, spec, tickets build on shared context. Each `/matt-implement` starts fresh.

Limit = **[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)** (~150k tokens). Pre-`/matt-to-tickets` degraded session => `/compact` at phase boundary + continue.

## On-ramps

Starting situations merge into main flow.

- **Bugs & requests** => **`/triage`**. Moves issues through triage roles + produces agent-ready issues. **`/matt-implement`** picks up later.
  Triage raw issues (bug reports, feature requests). `/matt-to-tickets` output = agent-ready => **do not triage**.

- **Broken code** => **`/diagnosing-bugs`**. Solves hard bugs (intermittent flakes, regressions). Requires **tight feedback loop** (one failing command). Fixes with regression test. Post-mortem hands off to **`/matt-improve-codebase-architecture`** for bad architecture.

- **Huge efforts (greenfield, massive features)** => **`/matt-wayfinder`**. Navigates unclear paths. Charts **shared map** of **decision tickets**. Resolves tickets sequentially. Produces **decisions, not deliverables**. Clarifies path. Slower + denser => save for massive efforts.
  Clear map => **hands off**. Merge into main flow via **`/matt-to-spec`** (collapses map decisions into buildable plan) + `/matt-to-tickets` + `/matt-implement`. Direct `/matt-implement` loop skips collapse => use only for small efforts.

## Codebase health

Upkeep work.

- **`/matt-improve-codebase-architecture`** finds **deepening opportunities**. Generates idea => main flow via `/matt-grill-with-docs`. **`/matt-codebase-design`** designs chosen candidate.

## Vocabulary underneath

Single sources of truth for vocabulary. Use directly for naming issues or let skills pull them.

- **`/matt-domain-modeling`**: sharpens project *domain* language. Challenges fuzzy terms + resolves overloaded words + records ADRs. Active discipline for `/matt-grill-with-docs`. Keeps `CONTEXT.md` clean.
- **`/matt-codebase-design`**: deep-module vocabulary (module, interface, depth, seam, adapter, leverage, locality). Designs module *shape*. `/matt-tdd` + `/matt-improve-codebase-architecture` speak it.

## Phase boundaries

**Phase** = work chunk inside session (matt-grilling, implementation, QA). **Boundary** options:

- **Continue**: stay put. Zero cost.
- **`/clear`**: empty window. Use when past context is irrelevant.
- **`/matt-handoff`** writes portable markdown file. Use for **new harness**, **new directory**, **colleague**, or forking side tasks. Buys portability.
- **Subagent**: delegate scoped task to new window + return report.
- **`/compact`** compresses context + seeds fresh session. **Default** action at bottom of tree.

Read [PHASE-BOUNDARIES.md](PHASE-BOUNDARIES.md) for ordered tree. Make decision **at** boundary. Mid-phase => continue or use subagents.

## Standalone

Off main flow.

- **`/matt-grilling`**: interview primitive. Rounds, frontier, facts = agent job. Decisions = user job. `/matt-grill-with-docs`, `/triage`, `/matt-wayfinder`, `/matt-improve-codebase-architecture` use it. Use directly for unwrapped interviews.
- **`/resolving-merge-conflicts`**: resolves conflicts hunk by hunk. Resolves by **intent** (primary sources). Never runs `--abort`. Use mid-conflict.
- **`/matt-prototype`**: throwaway program for design questions (state models, UI). Throwaway = constraint on code, not promise to destroy. Folds into real code. Kept on `matt-prototype/<name>` branch. Use for hard design questions.
- **`/research`**: delegates reading to **background agent**. Investigates primary sources + leaves cited Markdown file. Feeds main flow via `/matt-grill-with-docs`.
- **`/matt-to-questionnaire`**: creates human questionnaires. Inverse of `/matt-grill-with-docs`. Interviews you about the **send**. Output feeds `/matt-grill-with-docs` or `/matt-to-spec`.
- **`/wizard`**: automates human-only steps (provisioning, credentials, UI clicks). Generates interactive bash script. Captures values into `.env` & secrets. Use when human is required.
- **`/matt-wait-what`**: re-pitches messages in plain English + `CONTEXT.md` vocabulary. Use mid-conversation.
- **`/teach`**: learn concepts over multiple sessions in stateful workspace.
- **`/writing-for-agents`**: reference for agent docs (skills, AGENTS.md).

## Precondition

**`/matt-skill-setup`**: run before first engineering flow. Configures issue tracker, triage labels, doc layout.
