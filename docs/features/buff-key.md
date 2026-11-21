---
title: Buff key
parent: Features
nav_order: 4
description: One key that casts what the shield and weapon imbue cards ask for.
---

# Buff key

Press one key, out of combat, and Stormbound casts what the top card asks for: your shield, then your weapon imbue. No need to aim at the card.

## What it does

- Each press casts **one** spell: the first thing a card asks for.
- The order is: the [shield card](shield-and-imbue.html#shield) first, then the [Weapon imbue card](shield-and-imbue.html#weapon-imbue).
- A card asks for a cast only while it shows up: the shield when it is about to run out or is gone (with **When missing** on), the imbue when it is missing or about to run out.
- When nothing is needed, a press says "nothing to buff right now." in chat.

The key is shared by every Bound addon. For classes with a group buff it also buffs the group. Shamans have no group buff, so in Stormbound it only casts what the cards ask for.

## How to use it

1. Type `/storm` and open the **Extras** page.
2. Under **Buff key**, click the button next to **Key**, then press the key you want (for example Shift-Q). Esc cancels.
3. Out of combat, press it when a shield or imbue card shows up.

![The Extras page with the buff key]({{ '/screenshots/options-extras.png' | relative_url }})

## Settings

In `/storm`, page **Extras**, section **Buff key**:

| Setting | Default | What it does |
| --- | --- | --- |
| Key | Not set | The key itself. **Clear** removes it. |

When the shield or imbue card shows up is set on the **Shield & imbue** page. See [Shield and weapon imbue](shield-and-imbue.html#settings).

## Good to know

**Does it work in combat?**
No. The game does not let addons cast for you in combat, so the key does nothing until combat ends.

**It doesn't drop totems.**
Totems are on the [totem bar](totem-bar.html), not on the buff key.

**Setting the key in combat** isn't possible: the button says "leave combat first."
