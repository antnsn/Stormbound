---
title: Shield and weapon imbue
parent: Features
nav_order: 2
description: Cards when your shield or main-hand weapon imbue is missing or about to run out. Click to cast.
---

# Shield and weapon imbue

Two cards that keep your shield and your weapon imbue up. They show up when one is missing or about to run out, and a click on the card casts it.

![The shield card with its countdown]({{ '/screenshots/frames/lspoint.png' | relative_url }})

## What it does

### Shield

- You pick the shield to keep up: **Lightning Shield**, **Water Shield** or **Earth Shield**.
- When it has less time left than your limit (1 minute by default), you get a warning on screen and in chat, for example `Shield: 1 min left`. Then a card counts down the time left.
- When the shield is gone, the card says **Missing: click to cast**, and you get one "Shield is gone, rebuff" warning once you are out of combat and alive.
- Click the card to cast your highest rank of the shield, out of combat.
- Nothing shows while you haven't learned the shield you picked.

### Weapon imbue

- A card titled **Weapon imbue** when your main-hand weapon has no imbue: "Missing: click for Rockbiter Weapon" (or whichever imbue it will cast).
- Also when the imbue has less time left than your limit (1 minute by default): "0:45 left: click for ...".
- Click the card to cast it, out of combat.
- **Auto** casts the best imbue you know: Windfury, then Flametongue, then Rockbiter. Frostbrand is only cast when you pick it.

![The Weapon imbue card]({{ '/screenshots/frames/impoint.png' | relative_url }})

## How to use it

1. Type `/storm` and open the **Shield & imbue** page.
2. Click **Shield to keep up** to pick your shield. The line under it says which spell it will cast, or that you haven't learned it yet.
3. Leave **Imbue to cast** on **Auto**, or pick one.
4. When a card shows up, click it. Or set a [buff key](buff-key.html) and press that.

## Settings

In `/storm`, page **Shield & imbue**:

![The Shield & imbue page in the options]({{ '/screenshots/options-shield-imbue.png' | relative_url }})

**Shield**

| Setting | Default | What it does |
| --- | --- | --- |
| Shield to keep up | Lightning | Lightning, Water or Earth. |
| Show | On | The warning and the countdown card. Off turns the shield reminders off completely. |
| Sound | Off | Plays a sound with the warning. |
| When missing | On | Keeps the card up once the shield is gone ("Missing: click to cast"), with one rebuff warning. |
| Warn with time left | 1 min | When the warning comes. 1 to 10 minutes. |

**Weapon imbue**

| Setting | Default | What it does |
| --- | --- | --- |
| Show when your main hand has no imbue | On | Turns the imbue card on or off. |
| Imbue to cast | Auto | Auto, Windfury, Flametongue, Frostbrand or Rockbiter. |
| Warn with time left | 1 min | When the card shows up before the imbue runs out. 1 to 5 minutes. |

## Good to know

**Clicking the card does nothing in combat.**
The game doesn't let addons cast for you in combat. A shield card can stay on screen during a fight, but the click works again once combat ends.

**The imbue card stays away in combat.**
It also stays away while you have no main-hand weapon equipped.

**Only the main hand.**
The imbue card looks at your main-hand weapon. An off-hand imbue is not checked.

**The imbue card has no chat warning or sound.**
Only the shield warns in chat and on screen.

**You picked an imbue you don't know yet.**
The card casts what **Auto** would instead. The line under **Imbue to cast** says which spell that is.

**Lightning Shield uses up charges.**
When the last charge is used, the shield is gone and the card says so, even if time was left.

**Right after logging in or zoning**, the shield card waits a few seconds, so it doesn't claim the shield is missing before the game has listed your buffs.
