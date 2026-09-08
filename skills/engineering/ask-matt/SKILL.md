---
name: ask-matt
description: Ask which skill or flow fits your situation. A router over the skills in this repo.
disable-model-invocation: true
---

# Ask Matt

Ask to find relevant skills.

**Flow** = path through skills. Paths use one **main flow** + two **on-ramps**. Others are standalone or vocabulary layers.

## Main flow: idea → ship

Standard route. Build new ideas.

1. **`/grill-with-docs`** sharpens idea via interview. Use inside **working directory**: retains knowledge in `CONTEXT.md` & ADRs. (Runs `/grilling` primitive. Leaves paper trail => better for repos.)
2. **Branch: answer questions in conversation?** Unanswered questions (state, logic, UI) => detour through prototype. Bridge via **`/handoff`** (prototypes need isolated directories).
   - **`/handoff`** out + open fresh session against file.
   - **`/prototype`** answers question with throwaway code.
   - **`/handoff`** back learned context + reference from idea thread.
3. **Branch: multi-session build?**
   - **Yes** => **`/to-spec`** (thread to spec) + **`/to-tickets`** (split into tracer-bullet tickets with **blocking edges**). Local tracker => `.scratch/<feature>/issues/` worked blockers-first. Real tracker => native blocking links. Unblocked tickets => kick off **`/implement`** per ticket + **`/clear` context between tickets**. Self-contained tickets => disposable context.
   - **No** => **`/implement`** in current context window.

**`/implement`** builds issues via **`/tdd`** (red-green slices). Closes via **`/code-review`** (Standards + Spec axes) before committing. Use **`/tdd`** standalone for test-first behaviors. Use **`/code-review`** standalone for branch/PR reviews.

### Context hygiene

Keep steps 1-3 in **one unbroken context window** (no compact/clear before `/to-tickets`). Grilling, spec, tickets build on shared context. Each `/implement` starts fresh.

Limit = **[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)** (~150k tokens). Pre-`/to-tickets` degraded session => `/compact` at phase boundary + continue.

## On-ramps

Starting situations merge into main flow.

- **Bugs & requests** => **`/triage`**. Moves issues through triage roles + produces agent-ready issues. **`/implement`** picks up later.
  Triage raw issues (bug reports, feature requests). `/to-tickets` output = agent-ready => **do not triage**.

- **Broken code** => **`/diagnosing-bugs`**. Solves hard bugs (intermittent flakes, regressions). Requires **tight feedback loop** (one failing command). Fixes with regression test. Post-mortem hands off to **`/improve-codebase-architecture`** for bad architecture.

- **Huge efforts (greenfield, massive features)** => **`/wayfinder`**. Navigates unclear paths. Charts **shared map** of **decision tickets**. Resolves tickets sequentially. Produces **decisions, not deliverables**. Clarifies path. Slower + denser => save for massive efforts.
  Clear map => **hands off**. Merge into main flow via **`/to-spec`** (collapses map decisions into buildable plan) + `/to-tickets` + `/implement`. Direct `/implement` loop skips collapse => use only for small efforts.

## Codebase health

Upkeep work.

- **`/improve-codebase-architecture`** finds **deepening opportunities**. Generates idea => main flow via `/grill-with-docs`. **`/codebase-design`** designs chosen candidate.

## Vocabulary underneath

Single sources of truth for vocabulary. Use directly for naming issues or let skills pull them.

- **`/domain-modeling`**: sharpens project *domain* language. Challenges fuzzy terms + resolves overloaded words + records ADRs. Active discipline for `/grill-with-docs`. Keeps `CONTEXT.md` clean.
- **`/codebase-design`**: deep-module vocabulary (module, interface, depth, seam, adapter, leverage, locality). Designs module *shape*. `/tdd` + `/improve-codebase-architecture` speak it.

## Phase boundaries

**Phase** = work chunk inside session (grilling, implementation, QA). **Boundary** options:

- **Continue**: stay put. Zero cost.
- **`/clear`**: empty window. Use when past context is irrelevant.
- **`/handoff`** writes portable markdown file. Use for **new harness**, **new directory**, **colleague**, or forking side tasks. Buys portability.
- **Subagent**: delegate scoped task to new window + return report.
- **`/compact`** compresses context + seeds fresh session. **Default** action at bottom of tree.

Read [PHASE-BOUNDARIES.md](PHASE-BOUNDARIES.md) for ordered tree. Make decision **at** boundary. Mid-phase => continue or use subagents.

## Standalone

Off main flow.

- **`/grilling`**: interview primitive. Rounds, frontier, facts = agent job. Decisions = user job. `/grill-with-docs`, `/triage`, `/wayfinder`, `/improve-codebase-architecture` use it. Use directly for unwrapped interviews.
- **`/resolving-merge-conflicts`**: resolves conflicts hunk by hunk. Resolves by **intent** (primary sources). Never runs `--abort`. Use mid-conflict.
- **`/prototype`**: throwaway program for design questions (state models, UI). Throwaway = constraint on code, not promise to destroy. Folds into real code. Kept on `prototype/<name>` branch. Use for hard design questions.
- **`/research`**: delegates reading to **background agent**. Investigates primary sources + leaves cited Markdown file. Feeds main flow via `/grill-with-docs`.
- **`/to-questionnaire`**: creates human questionnaires. Inverse of `/grill-with-docs`. Interviews you about the **send**. Output feeds `/grill-with-docs` or `/to-spec`.
- **`/wizard`**: automates human-only steps (provisioning, credentials, UI clicks). Generates interactive bash script. Captures values into `.env` & secrets. Use when human is required.
- **`/wait-what`**: re-pitches messages in plain English + `CONTEXT.md` vocabulary. Use mid-conversation.
- **`/teach`**: learn concepts over multiple sessions in stateful workspace.
- **`/writing-for-agents`**: reference for agent docs (skills, AGENTS.md).

## Precondition

**`/setup-matt-pocock-skills`**: run before first engineering flow. Configures issue tracker, triage labels, doc layout.
