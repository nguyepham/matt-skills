---
name: matt-grilling
description: Grill user relentlessly about plans, decisions, ideas. Use for stress-testing thinking or 'grill' trigger phrases.
---

Interview user relentlessly until shared understanding. Map process as **design tree**. Decisions branch into dependent decisions.

Work tree in **rounds**. **Frontier** = decisions with settled prerequisites. Ask frontier questions immediately. Avoid guessing unheard answers. Ask full frontier per round. Number questions + provide recommended answers. Wait for user input.

Format rounds:

```
❓ **Q1** - **<question title>**: <question body + multiple choices>

➡️ <recommended answer>

---

❓ **Q2** - **<question title>**: <question body + multiple choices>

➡️ <recommended answer>
```

User answers reshape tree. Settled decisions push frontier outward + unblock dependent questions. Recompute frontier + ask next round. Dependent questions => later rounds.

Finding _facts_ = agent job. Frontier requires environment facts (filesystem, tools) => dispatch sub-agent. Zero manual fact-finding requests. Running exploration = unsettled prerequisite => downstream questions wait. Ask remaining frontier immediately. _Decisions_ = user job. Propose choices + wait.

Frontier empty => session done. Every branch visited. Zero silent assumptions. Require user confirmation before acting.
