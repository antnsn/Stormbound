---
title: Maelstrom Weapon
parent: Features
nav_order: 10
description: A movable Maelstrom Weapon stack counter that blinks at five stacks.
---

# Maelstrom Weapon

The card shows **1/5** through **4/5 stacks** as you build Maelstrom Weapon.
At **5 stacks**, it says **5/5 stacks - ready!** and alternates bright and dim every
half second. It stops blinking as soon as the stacks drop, and disappears when the
buff is consumed or expires.

## Settings

Open `/storm`, then **Maelstrom**. **Track Maelstrom Weapon stacks** is on by default.
Turn it off to hide the card completely.

Use `/storm unlock` to move or resize the card. The preview shows three stacks without
blinking. `/storm lock` returns it to live tracking.

## In combat

Unlike the weapon-imbue reminder, this card stays available during combat. It reads
the actual Maelstrom Weapon buff, not whether a passive spell is learned.

Forever's confirmed aura ID is **408505**. If the client hides its stack count or
omits the aura, the card hides instead of displaying stale stacks or a false ready alert.
It reappears when the aura is readable again.

The card is a visual indicator only: it does not cast a spell or join the buff-key queue.
