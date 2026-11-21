<!-- summary (CurseForge "Summary" field, at most 256 characters):
Shaman helper for WoW: Forever: a totem bar with timers, reminders for your shield and weapon imbue, warnings before totem items or Ankhs run out, and Astral Recall beside the Escape menu.
-->

# Stormbound

**The shaman helper for World of Warcraft: Forever: a totem bar, your shield and weapon imbue, reagents, and Astral Recall one Escape away.**

Stormbound gives you one button per element with the totem that stands and its time left, keeps your shield and weapon imbue up, and warns you before a missing totem item or Ankh catches you out.

**Beta:** Stormbound is new. Spell IDs come from Classic and are checked on Forever before 0.1.0; tell us what doesn't work.

## Totem bar
- **One button per element** (Earth, Fire, Water, Air) with the totem that stands and its time left.
- **Left-click** drops that element's totem again, **right-click** removes it.
- **Pick the totem** each button drops in the options or with the mouse wheel over the button, or let it drop the last one you used.

## Shield and weapon imbue
- **Lightning, Water or Earth Shield**, your pick: a card when it's missing or about to run out. Click it to cast.
- **Weapon imbue**: a card when your main hand has no imbue or it's running out. Click it to cast your best one (Windfury, Flametongue, Rockbiter), or the one you chose.

## Totem items and Ankhs
- Says when an **Earth, Fire, Water or Air Totem** item is missing (without it that element's totems can't be dropped) and when **Ankhs** run low for Reincarnation.

## Travel
- **Press Escape**: beside the game menu you get Astral Recall, Water Breathing, Water Walking and your Hearthstone.

## Also in it
- **Well Rested and Well Fed**: a countdown before they run out, with a sound if you like.
- **Explained**: hover over a card or button for a plain-word explanation of what it does and why (can be turned off).
- **Your layout**: every frame can be moved, snapped to a grid and scaled (`/storm unlock`).
- **Three skins**: the shaman look, Blizzard and Flat.
- Loads on shamans only.

## Commands
- `/storm`: open the options
- `/storm help`: list every command
- `/storm unlock`: show every frame so you can drag it into place
- `/storm lock`: lock the frames again
- `/storm reset`: put every frame back where it started
- `/storm grid [size]`: snap to a grid while moving, or set its size
- `/storm minimap`: show or hide the minimap button
- `/storm explain`: turn the plain-word explanations in tooltips on or off

## Ideas and contributions
- **Missing something?** New features are added on request: leave a comment here.
- **Feel free to contribute**: the code is on GitHub, https://github.com/antnsn/Stormbound (issues and pull requests welcome).

## The Bound family
Stormbound is one of the Bound addons, one per class, built on the same core: Lightbound (paladin), Chronobound (mage), Stormbound (shaman), Packbound (hunter), Spiritbound (priest) and Felbound (warlock). They look like their class but work the same way, so if you know one, you know them all.

## Changelog
<!-- changelog:start -->
### 0.1.0 beta 5

- **Minimap button** works with minimap addons (EllesmereUI, SexyMap, ElvUI, MinimapButtonBag, broker bars): it is a LibDBIcon button now. Its place on the minimap is kept.

### 0.1.0 beta 4

- **New icon**: hand-painted class art for the icon, the emblem and the faint crest behind the cards.

### 0.1.0 beta 3

- **New look**: a painted icon and emblem, and a faint class crest behind every card and in the corner of the options window and the travel panel (the Blizzard and Flat skins stay plain).

### 0.1.0 beta 2

- **Shield choice**: Lightning, Water or Earth Shield.
- **Totem choice** per element, in the options or with the mouse wheel over a totem button.
- Water Breathing and Water Walking beside the Escape menu.
- The imbue card is called "Weapon imbue".
- The slash command is `/storm` (`/sb` belongs to another addon).

### 0.1.0 beta 1

- First test build: totem bar with timers (click to recast, right-click to remove), Lightning Shield and weapon imbue cards (click to cast), totem item and Ankh warnings, Astral Recall and the Hearthstone beside the Escape menu, Well-Rested and Well Fed, explanations in tooltips, movable frames, Storm, Blizzard and Flat skins. Built on LibBound-1.0.
<!-- changelog:end -->
