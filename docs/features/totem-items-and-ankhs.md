---
title: Reagents
parent: Features
nav_order: 3
description: Missing totem items and selectable low-stock reminders for Ankhs, Fish Oil and Shiny Fish Scales.
---

# Reagents

A shaman needs a few items in the bags. Without an Earth, Fire, Water or Air Totem you can't drop that element's totems, and without an Ankh you can't use Reincarnation. Stormbound tells you before that catches you out.

## What it does

### Totem items

- A card when the totem item of an element is missing from your bags, for an element whose totems you know.
- With one missing, the card is titled after it, for example **Air Totem missing**. With more, it says **Totem items missing** and lists them.

![The totem items card]({{ '/screenshots/frames/tipoint.png' | relative_url }})

### Ankhs

- Once you know Reincarnation (level 30), a card titled **Ankhs** shows when you carry your limit or fewer (2 by default): "2 left".
- With none left it says, in red, "None left: Reincarnation can't be used".

![The Ankhs card]({{ '/screenshots/frames/akpoint.png' | relative_url }})

## How to use it

Totem item and Ankh warnings are on by default. When the totem item card shows up, get the item back. Ask a shaman trainer how. When the Ankhs card shows up, buy Ankhs from a reagent vendor.

### Water-spell reagents

- **Fish Oil** (item 17058) is used by **Water Walking**.
- **Shiny Fish Scales** (item 17057) are used by **Water Breathing**.
- Enable either tracker separately in **Reagents** options. Both start off.
- Each shows its own movable card when your bag count reaches its limit or lower (2 by default).
- With none left, the card names the spell that cannot be used. No reminder appears until you learn that spell.
- These reminders do not add water spells back to the Escape-menu travel panel.

## Settings

In `/storm`, page **Reagents**:

![The Totems & Ankhs page in the options]({{ '/screenshots/options-totems-ankhs.png' | relative_url }})

| Setting | Default | What it does |
| --- | --- | --- |
| Warn when a totem item is missing | On | The totem items card. |
| Track Ankhs | On | The Ankhs card, once you know Reincarnation. |
| Ankhs: warn at | 2 left | The card shows at this many Ankhs or fewer. 0 to 10. At 0, it shows only when you have none. |
| Track Fish Oil | Off | The Fish Oil card, once you know Water Walking. |
| Fish Oil: warn at | 2 left | Warn at this count or lower. 0 to 20; 0 means only when empty. |
| Track Shiny Fish Scales | Off | The Shiny Fish Scales card, once you know Water Breathing. |
| Shiny Fish Scales: warn at | 2 left | Warn at this count or lower. 0 to 20; 0 means only when empty. |

## Good to know

**All reagent cards keep tracking during combat.**
Ankhs, Fish Oil, Shiny Fish Scales and missing totem items continue to update as bag contents change.
If the client withholds an item count, its card says the count is unavailable rather than claiming
you have none.

**Stormbound doesn't buy Ankhs.**
It only counts them. Buy them yourself at a reagent vendor.

**No warning for an element you haven't learned.**
Before your first Fire totem, a missing Fire Totem item is not a problem yet, so the card leaves it out.
