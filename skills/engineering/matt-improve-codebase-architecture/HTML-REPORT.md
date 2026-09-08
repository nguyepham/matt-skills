# HTML Report Format

render architectural review in single os temp html file. cdn tailwind + mermaid. mermaid => graphs. div + svg => editorial visuals (mass diagrams, cross-sections). mix both. prevent generic look.

## Scaffold

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review for {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      /* small custom layer for things Tailwind doesn't cover cleanly:
         dashed seam lines, hand-drawn-feeling arrow heads, etc. */
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## Header

repo name, date, compact legend. solid box = module, dashed line = seam, red arrow = leakage, thick dark box = deep module. zero intro. start candidates.

## Candidate card

diagrams > prose. prose = sparse, plain, `/matt-codebase-design` glossary terms.

each candidate = 1 `<article>`:

- **Title**: short, names deepening.
- **Badge row**: recommendation strength (`Strong` = emerald, `Worth exploring` = amber, `Speculative` = slate) + dependency tag (`in-process`, `local-substitutable`, `ports & adapters`, `mock`).
- **Files**: monospaced list, `font-mono text-sm`.
- **Before / After diagram**: centrepiece. 2 columns side-by-side.
- **Problem**: 1 sentence. pain point.
- **Solution**: 1 sentence. change.
- **Wins**: bullets, ≤6 words. use glossary.
- **ADR callout**: 1 line, amber box.

zero explanation paragraphs. confusing diagram => redraw diagram.

## Diagram patterns

mix patterns.

### Mermaid graph

use `flowchart` or `graph` for call flow. wrap in tailwind card. classDef leak = red. classDef deep = dark.

```html
<div class="rounded-lg border border-slate-200 bg-white p-4">
  <pre class="mermaid">
    flowchart LR
      A[OrderHandler] --> B[OrderValidator]
      B --> C[OrderRepo]
      C -.leak.-> D[PricingClient]
      classDef leak stroke:#dc2626,stroke-width:2px;
      class C,D leak
  </pre>
</div>
```

### Hand-built boxes-and-arrows

mermaid fails layout => divs + inline svg `<line>` or `<path>`. use for thick-bordered deep module with faded internals.

### Cross-section

stack horizontal bands (`h-12 border-l-4`). before: thin layers. after: 1 thick band.

### Mass diagram

2 rectangles per module: interface + implementation. shallow = equal height. deep = short interface + tall implementation.

### Call-graph collapse

before: nested boxes tree. after: 1 box, faded internal calls.

## Style guidance

- lean editorial. generous whitespace. optional serif headings (`font-serif`).
- accent colour (emerald or indigo) + red (leakage) + amber (warnings).
- ~320px diagram height. prevent scrolling.
- `text-xs uppercase tracking-wider` module labels.
- 2 scripts: tailwind cdn + mermaid esm. static report. zero interactivity.

## Top recommendation section

1 large card. candidate name, 1 sentence rationale, anchor link.

## Tone

plain english + `/matt-codebase-design` terms.

**Use exactly:** module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

**Never substitute:** component, service, unit (for module). API, signature (for interface). boundary (for seam). layer, wrapper (for module).

**Phrasings:**

- "order intake module is shallow: interface nearly matches implementation."
- "pricing leaks across seam."
- "deepen: 1 interface, 1 place to test."
- "2 adapters justify seam: http in prod, in-memory in tests."

**Wins bullets** use glossary: *"locality: bugs concentrate in 1 module"*, *"leverage: 1 interface, N call sites"*, *"interface shrinks; implementation absorbs wrappers"*. prevent *"easier to maintain"*, *"cleaner code"*.

zero hedging. sentence -> bullet. unneeded bullet -> delete. missing term -> use glossary.