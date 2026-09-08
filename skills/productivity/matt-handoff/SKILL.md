---
name: matt-handoff
description: Compact conversation into matt-handoff document for next agent.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Summarize conversation into matt-handoff document. Save to OS temporary directory (skip current workspace).

Add "suggested skills" section. List skills for next agent.

Reference existing artifacts (specs, plans, ADRs, issues, commits, diffs) via path or URL. Skip duplication.

Redact sensitive information (API keys, passwords, PII).

Arguments passed => treat as next session focus & tailor document.
