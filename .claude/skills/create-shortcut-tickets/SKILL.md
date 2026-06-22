---
name: create-shortcut-tickets
description: Creates Shortcut tickets from an Obsidian note containing a task list. Use when user says "create tickets", "make Shortcut stories", "turn this into tickets", or "/create-shortcut-tickets".
---

## What I do

I convert a structured Obsidian note (with checkbox task items) into Shortcut stories, optionally grouped under an epic. I can also upload embedded images from the vault to the relevant tickets.

## When to use me

- When you have an Obsidian note with a checklist of work items to turn into Shortcut tickets
- When you want to batch-create stories under an existing or new epic
- Invoke with `/create-shortcut-tickets [[Note Name]]` or just `/create-shortcut-tickets` and I'll ask which note

## When not to use me

- For updating existing Shortcut tickets (use the Shortcut MCP tools directly)
- For creating a single ad-hoc ticket with no source note

---

## Usage

```
/create-shortcut-tickets                          # I'll ask which note to use
/create-shortcut-tickets [[Quiz Iterations]]      # Use a specific note
```

---

## Workflow

### Step 1: Read the source note

1. Parse user input for a note name or file path
2. If not provided, use `AskUserQuestion` to ask which note to use
3. Read the note and extract:
   - Checkbox items (`- [ ] ...`) as candidate tickets
   - Nested checkboxes as sub-tasks within a ticket
   - Embedded images (`![[filename.png]]`) associated with each item
   - Any links (Figma, external URLs) to include in descriptions

### Step 2: Identify the target epic and team

1. Ask the user which Shortcut team to use (or default to a known team)
2. Ask whether to:
   - Use an existing epic (search by name with `epics-search`)
   - Create a new epic
   - Skip epic assignment
3. If creating a new epic, use `epics-create` with the team ID

### Step 3: Present the ticket plan

Before creating anything, show the user a summary table:

| # | Ticket title | Type | Has image | Sub-tasks |
|---|-------------|------|-----------|-----------|

Ask for confirmation before proceeding. Allow the user to:
- Edit ticket titles
- Remove items they don't want as tickets
- Change story types (feature/bug/chore)

### Step 4: Create the tickets

For each approved item:

1. Create the story with `stories-create`:
   - `name`: The checkbox text (cleaned up as a concise title)
   - `description`: Any additional context, nested notes, and links from the source note
   - `epic`: The epic ID from Step 2
   - `team`: The team ID from Step 2
   - `type`: Default to `feature` unless otherwise specified
2. If the item has an associated image (`![[image.png]]`):
   - Locate the image in the vault (check `assets/` directory)
   - Upload it with `stories-upload-file`
3. If the item has nested checkboxes, add them as tasks with `stories-add-task`

### Step 5: Report results

Show a summary of what was created:

| # | Ticket | Title | Image | Link |
|---|--------|-------|-------|------|

Include Shortcut URLs so the user can review.

---

## Key references

### Finding images in the vault

Obsidian embeds images as `![[filename.png]]` or `![[filename.png|size]]`. Images are stored in the `assets/` directory. Use `Glob` to find the full path:

```
Glob pattern: **/filename.png
```

### Shortcut team IDs (commonly used)

Look up teams dynamically with `teams-list` rather than hardcoding, as teams can change.

### Story creation notes

- The `team` parameter for `stories-create` requires the team UUID, not the mention name
- The `epic` parameter requires the numeric epic ID
- Stories are created in the default workflow state (usually Backlog)
