---
title: Frames and minimap
parent: Features
nav_order: 8
description: Moving and resizing every frame, the grid, and the minimap button.
---

# Frames and minimap

Put every Stormbound frame exactly where you want it, and open the options from the minimap.

## What it does

### Moving and resizing frames

- Unlocking shows **every** Stormbound frame, with sample content, so you can place frames that are normally hidden: the totem bar, the shield, Weapon imbue, totem items, Ankhs, Fish Oil, Shiny Fish Scales, Well-Rested and Well Fed cards.
- Drag a frame to move it. Frames snap to a grid around the center of your screen. Hold **Shift** while dragging to place a frame freely.
- Scroll the **mouse wheel** over a frame to make it bigger or smaller (50% to 250%).
- While unlocked, a small bar at the top of the screen sets the grid size (**-** and **+**, or the mouse wheel; hold Shift for 1 pixel steps), turns **Snap** on or off, and has a **Lock** button.
- **Reset positions** puts every frame back in its default place and size.

### Minimap button and addon menu

| Click | Does |
| --- | --- |
| Left-click | Opens the options (`/storm`). |
| Shift-click or middle-click | Unlocks the frames (and locks them again). |
| Drag | Moves the button around the minimap. |

The button works with minimap addons such as EllesmereUI, SexyMap, ElvUI, MinimapButtonBag and broker bars: they collect it like any other button. Where the game has an addon menu (the puzzle-piece button), Stormbound is listed there too, with the same clicks. The game's **Settings > AddOns** list also has a Stormbound entry with an **Open options** button.

## How to use it

1. Type `/storm unlock`, Shift-click the minimap button, or click **Unlock frames** at the bottom of the `/storm` window.
2. Drag frames into place. Scroll on a frame to resize it.
3. Click **Lock** on the bar at the top, or type `/storm lock`.
4. Made a mess? `/storm reset` (or **Reset positions** in `/storm`) puts everything back.

## Settings

In `/storm`, page **Skin**, section **General**:

| Setting | Default | What it does |
| --- | --- | --- |
| Minimap button (left-click options, shift-click unlock) | On | Shows or hides the minimap button. Also `/storm minimap`. |

The grid has no options page. Change it on the bar shown while frames are unlocked, or with `/storm grid`:

| Command | Does |
| --- | --- |
| `/storm grid` | Turns snapping on or off (on by default). |
| `/storm grid 30` | Sets the grid size (4 to 100, default 20) and turns snapping on. |

## Good to know

**Not in combat.**
Unlocking, locking, moving, resizing and resetting frames all wait until you leave combat. A drag stops when a fight starts.

**Closing the options window** locks the frames again, but only if you unlocked them with the options' own button. Frames unlocked with `/storm unlock` stay unlocked until you lock them.

**Totem buttons don't pick totems while unlocked.**
The mouse wheel over a totem button only picks its totem while the frames are locked.

**The options window** is moved by dragging its title bar, not with unlock.
