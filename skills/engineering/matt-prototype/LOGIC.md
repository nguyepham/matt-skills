# Logic Prototype

1 self-contained HTML file (shareable demo). drives state model via button clicks. use for business logic, state transitions, data shape. tests paper logic against real cases.

zero installation => testable by non-developers (designers, PMs, domain experts). uses domain language.

## Target

- test state machine edge cases
- validate data model limits
- feel API design before coding
- watch state change via buttons

UI questions => use [UI.md](UI.md).

## Process

### 1. Define question

write target state model + question. 1 visible paragraph at demo top. wrong question => wasted prototype. explicit question => verifiable later.

### 2. Isolate logic

put target logic in 1 `<script>` block. write pure module. liftable into real codebase. page = throwaway. module = keeper.

shape depends on question:

- **pure reducer**: `(state, action) => state`. discrete events + single value state.
- **state machine**: explicit states + transitions. tests legal actions.
- **pure functions**: plain data type. zero implicit state + direct transformations.
- **class/module**: owns ongoing internal state + clear method surface.

pick shape fitting question. keep pure. zero DOM, `document`, button handlers. page calls module. module answers.

### 3. Build HTML

1 file (HTML/CSS/JS). zero frameworks & bundlers & servers. inline code => double-click open. shareable via email.

use domain language. label buttons + state for business context.

hierarchy (top to bottom):

1. **Title + explanation**: define prototype question.
2. **Current state**: render full state as readable panel (labelled fields). update on click. highlight changes.
3. **Free-play buttons**: 1 button per action. always available. clicks dispatch actions + render state.
4. **Guided walkthroughs**: scenarios in tabs. short plain-language description + ordered buttons. steps = real buttons. start walkthrough => reset to initial state.

test awkward cases: happy path, edge case, illegal action.

clean typography + spacing + 1 accent colour. zero animations.

### 4. Share

send file. recipient clicks walkthroughs + free-play. surprises ("that shouldn't be possible") => idea bugs. add actions/scenarios if needed.

### 5. Capture

capture answer. capture prototype per [SKILL](SKILL.md). lift validated logic into real module. save HTML shell in throwaway branch.

## Anti-patterns

- **zero tests**: tests => not prototype.
- **zero real databases**: use in-memory state. specific persistence questions = exception.
- **zero generalisation**: answer 1 question.
- **zero DOM in logic**: pure module + `document` => unliftable. keep page as thin shell.
- **zero frameworks/bundlers**: dev servers => not shareable.
- **zero HTML in production**: keep logic module. discard HTML shell.
