# Phase boundaries

**Phase**: session work chunk (grilling, implementation, QA). Ends on completion.

**Phase boundary**: gap between phases. Place for context decisions. Mid-phase => continue or split to subagents. Mid-phase compacting => agent thread loss.

## The five options

| Option | Action |
|---|---|
| **Continue** | Stay in session. Zero context switch. |
| **`/clear`** | Empty context window. Start fresh. |
| **`/handoff`** | Write portable markdown file. Seed new session. |
| **Subagent** | Send task to isolated context. Return report. |
| **`/compact`** | Compress context. Seed fresh session with summary. |

## The tree

Evaluate top to bottom. First **yes** wins.

**1. Continue in session?**
Next phase needs **primary source** or ~150k tokens remaining (smart zone) => yes. Example: grilling -> implementation. Implementation needs verbatim reasoning. Continue costs zero + loses zero. Rule out first.

**2. Context irrelevant?**
Disposable session context => **`/clear`**. Cheapest move. Restores full window. Old session remains resumable.
Error cost: one-way. Cleared relevant context => lost reasoning.

**3. Handoff required?**
**`/handoff`** buys portability. Use cases:
- Swap **new harness** (Claude -> Codex)
- Move **new directory** or repo
- Send work to **colleague**
- Fork mid-phase side task
Zero travelling => zero handoff.

**4. AFK task?**
Tight scope + zero steering => send to **subagent**. Session remains untouched. Example: automated review. Agent reads diff + reports.

**5. Otherwise `/compact`**
Relevant context + same harness + same directory + human loop => `/compact`. Pass instruction (`/compact we're going to QA this area`). Summary retains required context.
`/compact` = default fallback. Sits bottom. Above questions > `/compact` (cheaper or precise). Premature compact => flattened decisions + confident errors.

## Primary and secondary sources

Excluding **Continue**, boundary moves convert **primary source** (raw session) to **secondary source** (summary).

| Source | Information | Noise | Headroom |
|---|---|---|---|
| Primary (Continue) | Full | High | Low |
| Secondary (`/compact`, `/handoff`) | Lossy | Low | High |

Evaluate Continue first. Accept lossiness only on negative ROI.

## Judgement calls

Subjective questions. Evaluate **in order** at boundary. Avoid mid-phase evaluation.
