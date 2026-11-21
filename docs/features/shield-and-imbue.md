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

- Pick **Lightning**, **Water** or **Earth Shield** to track, or **Any** to accept any of those shields.
- If multiple shields are active in Any mode, the shield with the most time left satisfies the tracker.
- When it has less time left than your limit (1 minute by default), you get a warning on screen and in chat, for example `Shield: 1 min left`. Then a card counts down the time left.
- When the shield is gone, the card says **Missing: click to cast**, and you get one "Shield is gone, rebuff" warning once you are out of combat and alive.
- Click the card to cast the highest learned rank of **Shield to cast**, out of combat. This is independent of tracking.
- Nothing shows while you haven't learned the tracked shield (in Any mode, while you know no shield).

### Weapon imbue

- A card titled **Weapon imbue** when your main-hand weapon has no imbue: "Missing: click for Rockbiter Weapon" (or whichever imbue it will cast).
- Also when the imbue has less time left than your limit (1 minute by default): "0:45 left: click for ...".
- **Imbue to track** can be Windfury, Flametongue, Frostbrand or Rockbiter. Any rank counts.
- **Any** accepts any temporary main-hand enchant, including oils and sharpening stones. It is the default, preserving the previous behavior.
- A specific choice warns **Different imbue: click for ...** when another enchant is active, even if it has plenty of time left.
- Click the card to cast it, out of combat.
- **Auto** casts the best imbue you know: Windfury, then Flametongue, then Rockbiter. Frostbrand is only cast when you pick it.

![The Weapon imbue card]({{ '/screenshots/frames/impoint.png' | relative_url }})

## How to use it

1. Type `/storm` and open the **Shield & imbue** page.
2. Pick **Shield to track** and **Imbue to track**, or set either to **Any**.
3. Pick **Shield to cast** and **Imbue to cast** separately. **Auto** is also available for casting an imbue.
4. When a card shows up, click it. Or set a [buff key](buff-key.html) and press that.

## Settings

In `/storm`, page **Shield & imbue**:

![The Shield & imbue page in the options]({{ '/screenshots/options-shield-imbue.png' | relative_url }})

**Shield**

| Setting | Default | What it does |
| --- | --- | --- |
| Shield to track | Lightning | Any, Lightning, Water or Earth. Existing profiles start with their previous shield choice. |
| Shield to cast | Lightning | Lightning, Water or Earth, independently of tracking. |
| Show | On | The warning and the countdown card. Off turns the shield reminders off completely. |
| Sound | Off | Plays a sound with the warning. |
| When missing | On | Keeps the card up once the shield is gone ("Missing: click to cast"), with one rebuff warning. |
| Warn with time left | 1 min | When the warning comes. 1 to 10 minutes. |

**Weapon imbue**

| Setting | Default | What it does |
| --- | --- | --- |
| Show main-hand imbue reminders | On | Turns the imbue card on or off. |
| Imbue to track | Any | Any temporary enchant, or specifically Windfury, Flametongue, Frostbrand or Rockbiter. |
| Imbue to cast | Auto | Auto, Windfury, Flametongue, Frostbrand or Rockbiter. |
| Warn with time left | 1 min | When the card shows up before the imbue runs out. 1 to 5 minutes. |

## Good to know

**Clicking the card does nothing in combat.**
The game doesn't let addons cast for you in combat. A shield card can stay on screen during a fight, but the click works again once combat ends.

**The imbue card keeps tracking during combat.**
Missing, wrong and expiring imbues still show a reminder, but the click-to-cast button is disabled
until combat ends. If the client hides enchant data during combat, the card says **Imbue data
unavailable** rather than inventing a missing imbue. It stays away while you have no main-hand
weapon equipped.

**Shield aura access can be restricted during combat.**
The shield timer can continue from its last readable expiration time, but Stormbound cannot
detect charge loss, removal or refresh while Forever blocks aura reads. It refreshes when data
becomes readable again; there is no claim of live aura tracking while access is blocked.

**Only the main hand.**
The imbue card looks at your main-hand weapon. An off-hand imbue is not checked.

**The imbue card has no chat warning or sound.**
Only the shield warns in chat and on screen.

**You picked an imbue you don't know yet.**
The card casts what **Auto** would instead. The line under **Imbue to cast** says which spell that is.

**Tracking and casting are independent.**
With a specific tracker, normally pick the same spell to cast. Casting a different spell will not satisfy that tracker. In Any mode, your preferred cast can stay unchanged when you switch shields or enchants manually.

**Unreadable weapon enchants.**
Specific imbue tracking uses Classic temporary-enchant IDs. If the client hides or does not supply the enchant ID, the addon does not claim it is the wrong imbue. Any mode only needs the presence and remaining time.
Specific imbue IDs still need verification on Forever; Any does not depend on matching those IDs.

**Invalid saved imbue choices.**
An old or manually edited tracking choice that is not recognized is reset to Any with a chat
notification. The separate spell-to-cast preference is kept.

**Lightning Shield uses up charges.**
When the last charge is used, the shield is gone and the card says so, even if time was left.

**Right after logging in or zoning**, the shield card waits a few seconds, so it doesn't claim the shield is missing before the game has listed your buffs.
