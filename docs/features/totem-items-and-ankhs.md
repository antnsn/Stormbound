---
title: Totem items and Ankhs
parent: Features
nav_order: 3
description: A card when a totem item is missing from your bags, and one when Ankhs run low for Reincarnation.
---

# Totem items and Ankhs

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

Nothing to do: both warnings are on by default. When the totem item card shows up, get the item back. Ask a shaman trainer how. When the Ankhs card shows up, buy Ankhs from a reagent vendor.

## Settings

In `/storm`, page **Totems & Ankhs**:

![The Totems & Ankhs page in the options]({{ '/screenshots/options-totems-ankhs.png' | relative_url }})

| Setting | Default | What it does |
| --- | --- | --- |
| Warn when a totem item is missing | On | The totem items card. |
| Warn when Ankhs run low | On | The Ankhs card, once you know Reincarnation. |
| Ankhs: warn at | 2 left | The card shows at this many Ankhs or fewer. 0 to 10. At 0, it shows only when you have none. |

## Good to know

**Both cards stay away in combat.**
They come back when the fight is over.

**Stormbound doesn't buy Ankhs.**
It only counts them. Buy them yourself at a reagent vendor.

**No warning for an element you haven't learned.**
Before your first Fire totem, a missing Fire Totem item is not a problem yet, so the card leaves it out.
