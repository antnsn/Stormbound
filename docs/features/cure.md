---
title: Cure
parent: Features
nav_order: 10
description: A grid of your group that shows who has Poison or a Disease you can remove, one click to remove it.
---

# Cure

See at a glance who has Poison or a Disease you can remove, and remove it with one click or one key, in combat too.

{: .note }
New and not in a CurseForge release yet. It is listed under **Unreleased** in the changelog. The same frame as Lightbound's Cleanse, shared through LibBound.

## What it does

- **Click** a cell or row: **Cure Poison** (Poison) on that player.
- **Right-click**: **Cure Disease** (Disease).
- **Grid** (the default): one small cell per group member, like Decursive. A cell lights up in the debuff's colour (green Poison, brown Disease) with its icon and stack count.
- **List**: one row per player who has something you can remove.
- **Two keys**: one for Cure Poison, one for Cure Disease. Each casts on whoever is under your mouse: a grid cell, a list row, or any raid or party frame. With nothing under the mouse, it casts on your target.
- Players out of range are dimmed. A sound plays when someone new needs it.
- An **ignore list** hides debuffs you don't want to see.
- The frame shows up once you know the spell.

## How to use it

1. Type `/storm` and open the **Cure** page.
2. Under **Keys**, click the button and press a key. Esc cancels.
3. Pick **Grid** or **List**.
4. In a fight, click a coloured cell (right-click for the second spell), or hover over a player and press your key.
5. To hide a debuff you never want to remove, type `/storm ignore` followed by its full name. The same command again removes it. `/storm ignore` on its own lists what you ignore.

## Settings

In `/storm`, page **Cure**:

| Setting | Default | What it does |
| --- | --- | --- |
| Show the cure frame | On | The grid or list. |
| Include pets | Off | Adds group pets. |
| Dim players out of range | On | |
| Sound when someone new needs it | On | |
| Show when solo | On | Just you. Off: only in a group. |
| Names in cells (26 px and up) | Off | Three letters of each name, from 26 px cells up. |
| Grid or list | Grid | Grid: a cell per group member that follows the roster in combat. List: a row per afflicted player. |
| Grid: cells per row | 5 | 1 to 10. |
| Grid: cell size | 22 px | 14 to 40 px. |
| List: rows | 5 | 1 to 10. |
| Cure Poison (key) | Not set | Cure Poison on the player under your mouse, else your target. Works in combat. |
| Cure Disease (key) | Not set | Cure Disease the same way. |

The bottom of the page lists your ignored debuffs.

## Good to know

**Does it work in combat?**
Yes. Clicking cells and the keys work in combat. The grid also follows players joining, leaving and moving between raid groups during a fight.

**Layout changes wait for the end of combat.**
Switching between grid and list, cell size, cells per row and pets change after combat.

**Combat hides debuff details on Forever.**
In the grid, the game itself draws the debuff colour and icon in each cell, so the grid keeps working in combat. The tooltip may say "Debuff details hidden right now". The **list** relies on what the addon can read, so in combat it can miss debuffs.

**Clicking a cell that isn't lit** still casts on that player. That is on purpose: in combat the addon may not see a debuff the game hides.
