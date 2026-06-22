---
name: figma-implement
description: Implement a Figma design (previously extracted via /figma-extract) as a component in the current repo, adapting to whatever design system the repo uses. Use when user says "/figma-implement", references a figma extract slug or .local/figma/ folder, or says "implement figma design".
---

# Figma Implement

Turn a Figma extract into a component in the current repo. Discovers the repo's design system, maps Figma tokens to it, produces a reviewable plan, and only writes code after the user approves.

Companion skill: `figma-extract` (run that first to produce the extract folder).

## Usage

- `/figma-implement <slug>` — slug can be `001`, `001-4848-51448`, or `.local/figma/001-4848-51448`
- `/figma-implement <slug-a> <slug-b>` — two extracts (mobile + desktop). Auto-detects which is which from each extract's `metadata.json` viewport.
- `/figma-implement` — prompt user for slug(s)

## Workflow

### Step 1: Resolve inputs

1. **Slug(s):** If not provided, ask. Resolve each slug to a folder under `.local/figma/`. Accept short (`001`), full (`001-4848-51448`), or path forms.
2. **Pair detection:** If two slugs given, read each `metadata.json`, determine viewport from frame width (<600 mobile, ≥900 desktop). If both same viewport, ask user.
3. **Single extract:** Ask user whether to infer responsive behaviour from the single design or treat it as a single-viewport component.

### Step 2: Discover the repo's design system

The skill must adapt to the current repo. Inspect it to build a profile before asking the user any implementation questions.

Discover:

- **Stack.** Read root `package.json` (and any workspace `package.json`s). Presence of `react-native` → React Native; otherwise assume React web.
- **Design library (DL) package(s).** Look for published DL deps in `package.json` (`@*/design-library`, `@*/ui`, `@*/design-system`, etc.) and for in-repo DLs in common locations:
  - `shared/designLibrary/`, `shared/design-library/`
  - `packages/design-system/`, `packages/ui/`, `packages/design-library/`
  - `src/components/ui/`, `src/design-system/`
  - Monorepo workspace folders matching those patterns
- **Token sources.** Tailwind configs (`tailwind.config.*`), any `colour*.js` / `color*.js` / `theme*.ts`, NativeWind config, RN theme/style files.
- **Repo-local rules.** Any of: `.claude/rules/design-system.md`, `.claude/docs/*design*.md`, `.claude/docs/*storybook*.md`, and similar. Read them into context if they exist.
- **Target app dirs.** From workspaces (`apps/*`, `packages/*`) or top-level `src/`.

Produce a mental profile: `{ stack, dls[], tokenFiles[], rulesFiles[], targets[] }`.

**Branch on what was found:**

- **Multiple DLs discovered** → **ask the user which to use**. List each with its package name + index/entry path.
- **One DL discovered** → use it. Read its main export file (index) to enumerate components.
- **No DL discovered** → **loose mode**. No strict component rules. Instead, when mapping components in Step 5, open a few sibling files in the target area and follow the patterns already in use (styling approach, layout primitives, import conventions). Note this mode clearly in `plan.md`.

### Step 3: Confirm target

Ask the user (unless obvious from context):

1. **App target** — which workspace / app dir (skip if only one target exists).
2. **Target file path** — e.g. `apps/website/components/Checkout/PriceCard.tsx`. Confirm new file vs replacing existing.

### Step 4: Read references

Read once and cache mentally:

- For each active DL: the main export/index file, then source of Typography primitives (to enumerate size/weight props) and icons (to enumerate names). In loose mode, skip — read sibling files instead.
- Discovered token files (colours, spacing, typography scale).
- Discovered rules files (repo-local rules are authoritative — follow them).

For each extract folder, read `metadata.json`, `variables.json`, `summary.md`, and `design-context.md` (the last is **reference only** — do NOT copy its arbitrary Tailwind/hex values).

### Step 5: Build mappings

**Colours.** For each unique hex:
- Exact match against discovered tokens → use that token.
- No exact match → pick closest by ΔE colour distance, note the substitution in the plan.
- No token system found → use raw hex *only if* sibling files already do so; otherwise flag as an issue.

**Typography.** For each text node:
- Map family + size + weight + line-height to closest DL Typography primitive + props. In loose mode, match sibling-file patterns (e.g. existing RN `<Text>` with StyleSheet).
- Note any non-exact matches in the plan.

**Icons.** For each icon node:
- Exact name match against DL icons → use it.
- No match → placeholder from DL, add plan entry: "icon `<figma-name>` missing — user to export from Figma and add to DL".
- No DL → inline the SVG if small, or flag as "asset to add" and reference a placeholder.

**Components.** For each significant Figma node:
- Exact match against DL exports → use it.
- Similar match with unsupported variant → flag in plan, ask user: (a) add variant to DL, (b) inline a custom component, (c) use closest existing variant and accept the deviation.
- No match → inline-implement. In loose mode this is the default.

### Step 6: Write `plan.md`

Write to `<first-extract-folder>/plan.md`:

```markdown
# Implementation Plan

## Target
- Stack: <react-web|react-native>
- Design system mode: <DL: @foo/design-library | loose (follow repo patterns)>
- App: <workspace or — >
- File: <path>
- New file: <yes|no>
- Desktop extract: <slug or — >
- Mobile extract: <slug or — >

## Discovered references
- DL: <package + index path, or "none">
- Tokens: <file paths>
- Rules files read: <paths or "none">

## Component mapping
| Figma node | Target component | Notes |
|---|---|---|

## Token mapping (colours)
| Figma hex | Token | Match |
|---|---|---|

## Typography mapping
| Figma | Target | Match |
|---|---|---|

## Icons
- <figma-name>: <mapping or PLACEHOLDER note>

## New DL components proposed (require explicit approval)
- (none)  — OR list each with rationale

## Issues requiring user decision
1. ...

## Assets to copy
- assets/<file> → <target public/asset path>
```

### Step 7: Get user approval

Print the plan path, summarise the issues-requiring-decision list, and **stop**. Wait for the user to say "go" or edit `plan.md` directly. If edited, re-read before continuing.

### Step 8: Implement

Only after explicit approval:

1. Write the component at the target path. Apply any rules from discovered rules files without exception.
2. In **DL mode**: use DL components, token classes/variables, DL icons, DL helpers (e.g. `cx()` if exported). No raw hex, no `style` props unless DL rules allow, no `className` overrides on DL components unless rules allow.
3. In **loose mode**: match the sibling-file patterns you inspected in Step 2. Stay consistent with existing styling approach (Tailwind / StyleSheet / CSS modules / etc.).
4. Use language conventions from the repo (quote style, `FC` vs function components, import order, etc.). Grep existing files if unsure.
5. Move assets from the extract folder to the target asset dir as listed in the plan.
6. **If user approved DL additions:** create component files in the DL per that DL's existing structure (look at a sibling component for reference). Add the export to the DL's index.
7. Run the repo's typecheck for the affected workspace. Discover the command from `package.json` scripts (look for `typescript:*`, `typecheck:*`, `tsc`, etc.). Fix any errors.

### Step 9: Validation (optional, requires user)

Tell the user:

> Validation needs the dev server running locally. Start the relevant dev server and tell me the URL where this component renders. Or skip and review manually.

If user provides a URL:

1. Use the browser MCP (`mcp__playwright__browser_navigate` + `mcp__playwright__browser_take_screenshot`, or chrome-devtools equivalent) to open and capture the page.
2. Compare visually against the extract's `screenshot.png`. Report differences in plain text. **Do not auto-iterate** — surface the diff and let the user decide what to fix.

## Non-goals

- No commits.
- No starting dev servers.
- No edits to token files, design library, or repo config without explicit user approval per change.
- No DL additions without explicit user approval per component.
- No cleanup of `.local/figma/` (user handles).
- No auto-iteration on visual diffs.
- No responsive code synthesis from a single extract without user consent.

## Notes

- `design-context.md` from the extract is **reference only**. Its arbitrary Tailwind values and inline hex codes likely violate repo rules. Use it to understand layout structure, not to copy values.
- This skill typically runs in a fresh context window after the user has reviewed the extract. All needed context lives in the extract folder + what discovery surfaces.
- If the existing component being replaced has tests, run them after implementation and report failures (do not auto-fix).
- Discovery is best-effort. If something important is ambiguous, ask the user rather than guessing.
