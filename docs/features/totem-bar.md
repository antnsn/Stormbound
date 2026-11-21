---
title: Totem bar
parent: Features
nav_order: 1
description: One button per element with the totem that stands and its time left. Left-click drops it, right-click removes it.
---

# Totem bar

One small bar with a button for each element: Earth, Fire, Water and Air. You see at a glance which totems stand and how long they last, and you drop or remove them with a click.

![The totem bar: Earth, Fire, Water and Air]({{ '/screenshots/frames/tbpoint.png' | relative_url }})

## What it does

- Each button has a colored edge for its element: brown Earth, orange Fire, blue Water, pale Air.
- **While a totem stands**, the button shows its icon and the time left: minutes (`4m`) above one minute, seconds below. The last 10 seconds turn orange-red.
- **When no totem stands**, the button is faded and shows what a click would drop: the totem you picked, the last one you dropped, or the element's own icon.
- **Left-click** drops that element's totem. That is the totem you picked for the button, or else the last totem of that element you dropped.
- **Right-click** removes the totem of that element.
- The button remembers any totem you drop, also from your spellbook or action bars.
- The bar shows up once you know at least one totem.

## How to use it

1. Drop a totem of each element once, from your spellbook or action bars. Each button remembers its totem.
2. From then on, left-click a button to drop that totem again. Right-click to remove it.
3. To make a button always drop the same totem, scroll the **mouse wheel** over it out of combat. It steps through **Last used** and every totem of that element you know. The tooltip shows what a click drops.
4. You can pick the same thing on the **Totems** page in `/storm`.

## Settings

In `/storm`, page **Totems**:

![The Totems page in the options]({{ '/screenshots/options-totems.png' | relative_url }})

| Setting | Default | What it does |
| --- | --- | --- |
| Show the totem bar | On | Shows or hides the bar. |
| Time left on each button | On | The timer on each button. Off leaves only the icons. |
| Earth, Fire, Water, Air | Last used | The totem each button drops: **Last used**, or one of the totems of that element you know. Left-click steps forward, right-click back. |

Under each element, a line says "No earth totem learned yet." (and so on) while you know none of that element.

## Good to know

**A button does nothing on left-click.**
It doesn't know a totem yet. Drop one of that element once from your spellbook, or pick one with the mouse wheel. The tooltip says "Drop a totem once: this button remembers it."

**In combat the buttons keep their totem.**
The game doesn't let addons change what a button casts in combat. Drop a different totem from your spellbook mid-fight and the button picks it up once combat ends. The mouse wheel also only works out of combat.

**Sometimes a button shows the icon but no timer.**
Forever hides totem details from addons at times in combat. The button then shows the totem's icon without the time.

**The bar shows or hides only out of combat.**
Turning it on or off, or learning your first totem, takes effect when the fight is over.

**A picked totem you no longer know** is ignored, and the button goes back to the last one used.

**Moving the bar.**
Unlock the frames (the **Unlock frames** button at the bottom of `/storm`) and drag it. See [Frames and minimap](frames-and-minimap.html).
