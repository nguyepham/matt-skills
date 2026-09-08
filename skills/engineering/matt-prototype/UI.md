# UI Prototype

generate radically different UI variations on 1 route. switch via floating bottom bar. user compares variants + picks winner.

logic/state questions => use [LOGIC.md](LOGIC.md).

## Target

- "what should page look like?"
- "compare dashboard options before commit."
- "try different settings layout."

vague mental mockups => use UI prototype.

## Sub-shapes

real data + real context > isolated route. default to sub-shape A. sub-shape B = last resort.

### Sub-shape A: existing page (preferred)

use existing route. gate variants via `?variant=` URL param. keep existing data fetching + auth. swap rendering only.

new sub-components (new card, new step) => use sub-shape A. mount inside host page.

### Sub-shape B: new page (last resort)

use for new top-level surfaces. zero sensible host page => use sub-shape B.

create throwaway route. follow existing routing convention. name clearly (include `matt-prototype`). use `?variant=` pattern.

empty route hides design problems. verify zero host page before choosing B.

## Process

### 1. Define plan

default = 3 variants. > 5 variants => noise.

write 1-line plan at top. example: `"3 variants of settings page. switch via ?variant= on /settings route."`

### 2. Generate variants

draft variants. match page purpose + data. use project styling system (Tailwind, MUI). export clear names (`VariantA`, `VariantB`).

variants require structural differences. different layout + hierarchy > different colours. redo similar drafts.

### 3. Wire variants

create switcher component:

```tsx
const variant = searchParams.get('variant') ?? 'A';
return (
  <>
    {variant === 'A' && <VariantA {...data} />}
    {variant === 'B' && <VariantB {...data} />}
    {variant === 'C' && <VariantC {...data} />}
    <PrototypeSwitcher variants={['A','B','C']} current={variant} />
  </>
);
```

sub-shape A: keep data fetching above switcher. swap rendered subtree.
sub-shape B: mount switcher on throwaway route.

### 4. Build floating switcher

fixed bottom-centre bar. 3 elements:

- **left arrow**: previous variant.
- **label**: current key + name (e.g. `B (Sidebar layout)`).
- **right arrow**: next variant.

behaviour:

- clicks update URL param. use framework router. ensures shareable + reload-stable state.
- keyboard arrow keys (`←`, `→`) cycle variants. ignore keys inside `<input>`, `<textarea>`, `[contenteditable]`.
- distinct visual style (high-contrast pill). separates switcher from design.
- gate behind `process.env.NODE_ENV !== 'production'`. prevents accidental prod shipping.

use 1 shared component for both sub-shapes.

### 5. Share

surface URL + variant keys. user flips variants + provides feedback (e.g. "header A + sidebar C").

### 6. Capture

record winning variant + reason. capture prototype per [SKILL](SKILL.md).

sub-shape A: fold winner into existing page.
sub-shape B: promote winner to real route.

drop losing variants + switcher from main. save full set to throwaway branch. main branch variants => codebase rot.

## Anti-patterns

- **colour/copy tweaks**: tweaks != prototypes. require structural differences.
- **shared layout code**: shared `<Header>` = okay. shared `<Layout>` = bad. allow total layout changes.
- **real mutations**: read-only prototypes > real mutations. mutate stubs instead.
- **direct prod promotion**: prototype code lacks tests + error handling. rewrite properly before merge.
