---
name: figma-extract
description: Extract Figma design data (tokens, metadata, screenshot, layer tree) into .local/figma/ for later implementation. Use when user says "/figma-extract", provides a Figma URL and wants to extract design tokens, or says "extract figma design".
---

# Figma Extract

Pull design data from Figma via the Figma MCP server and save it to disk for human review. **This skill makes no code changes.** It produces a reviewable artefact that the `figma-implement` skill consumes later (often in a fresh context window).

Companion skill: `figma-implement`.

## Usage

- `/figma-extract <figma-url>` — extract a Figma node
- `/figma-extract` — prompt user for the URL

## Why this is a separate skill

The official Figma MCP `get_design_context` tool returns **prescriptive** React + Tailwind code with arbitrary values like `text-[26px]` and raw hex. Treating that as final code produces wrong fonts, wrong colours, wrong spacing. The fix is to extract raw data from multiple Figma MCP tools, cross-reference them, and have a human review the extracted tokens **before** any code is written. This skill does the extraction half.

## Workflow

### Step 1: Get the Figma URL

If the user did not provide a URL, ask for it. Accept any of:

- `figma.com/design/<fileKey>/<fileName>?node-id=<nodeId>`
- `figma.com/design/<fileKey>/branch/<branchKey>/<fileName>?node-id=<nodeId>` (use `branchKey` as `fileKey`)

Convert the `node-id` query param's `-` to `:` when passing to MCP tools (e.g. `4848-51448` → `4848:51448`).

### Step 2: Pick the extract folder

1. List existing folders in `.local/figma/` (create the directory if missing).
2. Find the highest `NNN-` prefix across existing folders.
3. **If a folder ending in `-<nodeId>` already exists, stop and ask the user** whether to:
   - Overwrite that folder
   - Create a new numbered folder anyway
   - Abort
4. Otherwise the new folder is `.local/figma/<NNN+1 zero-padded to 3>-<nodeId>/` (e.g. `001-4848-51448`).

Create the folder.

### Step 3: Run the Figma MCP tools

Run each tool against the node. **If any tool fails, stop and ask the user to fix the issue** (common causes: annotations on the selection, selection too large, MCP server timeout). Do not continue with partial data silently.

| Tool | Output file |
|---|---|
| `mcp__figma__get_metadata` | `metadata.json` |
| `mcp__figma__get_variable_defs` | `variables.json` |
| `mcp__figma__get_design_context` | `design-context.md` |
| `mcp__figma__get_screenshot` | `screenshot.png` |

For `design-context.md`, prepend this header verbatim:

```markdown
> **Reference only — do not copy verbatim.** This is Figma's prescriptive React+Tailwind output. It uses arbitrary values (e.g. `text-[26px]`, raw hex) that likely violate the target project's design-system rules. The `figma-implement` skill maps these to real design-system components and tokens.
```

### Step 4: Download assets

If the Figma response references localhost image URLs, download each to `<extract-folder>/assets/` keeping the original filename.

### Step 5: Detect viewport

From `metadata.json`, read the root frame width:

- `< 600px` → `mobile`
- `≥ 900px` → `desktop`
- in between → ask the user which it is

### Step 6: Write `summary.md`

This is the human-review artefact. Write to `<extract-folder>/summary.md` with this structure:

```markdown
# Figma extract: <node name from metadata>

- Source: <original Figma URL>
- File key: <fileKey>
- Node ID: <nodeId>
- Viewport: <mobile|desktop>
- Frame size: <width>x<height>px
- Extracted: <YYYY-MM-DD HH:mm>

## Colours
| Hex | Used in | Notes |
|---|---|---|
| #0F4C81 | "Primary CTA" background | |

## Typography
| Family | Size | Weight | Line height | Used in |
|---|---|---|---|---|
| Cera | 32px | 700 | 40px | "Heading" |

## Spacing values found
- 8, 12, 16, 24, 32 px

## Layer tree
<concise tree from metadata.json — names + sizes only, max ~80 lines>

## Assets
- assets/illustration-checkout.png (320x240)

## Extraction warnings
- (note any tool oddities, truncation, missing variables)
```

### Step 7: Report

Print the extract folder path and a one-line summary. Stop. Tell the user to review `summary.md` and run `/figma-implement <slug>` when ready.

## Non-goals

- No code changes anywhere in the repo.
- No edits to design tokens, Tailwind config, design-library, or any app code.
- No commits.
- No cleanup of old `.local/figma/` folders (user handles).
- No silent fallback if MCP tools fail — always surface the error.

## Notes

- `.local/` is gitignored. Extracts persist across sessions and are safe to keep.
- Re-extracting the same node always creates a new numbered folder (after user confirms) so historical extracts remain available.
- Mobile and desktop variants of the same design should be extracted as separate runs (different node IDs). The numeric prefix preserves temporal ordering so `figma-implement` can pair them.
