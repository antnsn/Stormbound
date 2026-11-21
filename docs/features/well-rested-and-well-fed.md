---
title: Well-Rested and Well Fed
parent: Features
nav_order: 6
description: A warning and a countdown before Well-Rested or Well Fed runs out.
---

# Well-Rested and Well Fed

On Forever, Well-Rested (the Cozy Sleeping Bag buff) and Well Fed both give more experience. Stormbound tells you before they run out.

## What it does

- A warning on screen, in chat and with a sound when **Well-Rested** or **Well Fed** is about to run out.
- After the warning, a card counts down the time left.
- Well Fed also tells you when it is gone.
- Optionally, a card stays up after the buff is gone ("Buff has run out"), with one rebuff warning.

![The Well-Rested card]({{ '/screenshots/frames/wrpoint.png' | relative_url }})
![The Well Fed card]({{ '/screenshots/frames/wfpoint.png' | relative_url }})

## How to use it

Nothing to do: both are on by default. To change when they warn, open `/storm`, page **Extras**. Click **Test** next to a section to see and hear its warning.

## Settings

In `/storm`, page **Extras**, sections **Well-Rested** and **Well Fed**. Both have the same settings:

![The Extras page in the options]({{ '/screenshots/options-extras.png' | relative_url }})

| Setting | Default | What it does |
| --- | --- | --- |
| Warn | On | The warning, and everything else in the section. |
| Sound | On | Plays a sound with the warning. |
| Countdown card | On | The card that counts down after the warning. |
| Keep following it after it's gone (rebuff warning) | Off | Keeps a card up once the buff is gone, with one rebuff warning. |
| Warn with time left | 5 min (Well-Rested), 3 min (Well Fed) | When the warning comes. 1 to 30 minutes. |

## Good to know

**The rebuff warning waits** until you are out of combat and alive.

**Right after logging in or zoning**, the cards wait a few seconds, so they don't claim a buff is gone before the game has listed your buffs.
