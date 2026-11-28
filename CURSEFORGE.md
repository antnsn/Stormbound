<!-- summary (CurseForge "Summary" field, at most 256 characters):
Shaman helper for WoW: Forever: a totem bar with one button per element and its time left (click to drop, right-click to remove), one-click cards for your shield and weapon imbue, totem item and Ankh warnings, Astral Recall beside the Escape menu.
-->

# Stormbound

**The shaman helper for World of Warcraft: Forever: a totem bar, your shield and weapon imbue, reagents, and Astral Recall one Escape away.**

Stormbound gives you one button per element with the totem that stands and its time left, keeps your shield and weapon imbue up, and warns you before a missing totem item or Ankh catches you out.

**Full guide with screenshots:** https://antnsn.github.io/Stormbound/

## Totem bar
- **One button per element** (Earth, Fire, Water, Air) with the totem that stands and its time left.
- **Left-click** drops that element's totem again, **right-click** removes it.
- **Pick the totem** each button drops in the options or with the mouse wheel over the button, or let it drop the last one you used.

## Shield and weapon imbue
- **Lightning, Water or Earth Shield**, your pick: a card when it's missing or about to run out. Click it to cast.
- **Weapon imbue**: a card when your main hand has no imbue or it's running out. Click it to cast your best one (Windfury, Flametongue, Rockbiter), or the one you chose.

## Reagents
- Says when an **Earth, Fire, Water or Air Totem** item is missing (without it that element's totems can't be dropped) and when **Ankhs** run low for Reincarnation.
- In **Reagents** options, choose whether to track Ankhs, **Fish Oil** for Water Walking, and **Shiny Fish Scales** for Water Breathing. Each has its own low-stock limit; the two water-spell reminders start turned off.

## Cure
- A **grid of your group** that lights up when someone has Poison or a Disease you can remove: click for Cure Poison, right-click for Cure Disease. Works in combat.
- A key for each that casts on whoever is under your mouse, in any raid frame too.

## Travel
- **Press Escape**: beside the game menu you get Astral Recall, Water Breathing, Water Walking and your Hearthstone.

## Also in it
- **Buff key** (Extras page): out of combat, each press casts the next thing a card asks for.
- **Well Rested and Well Fed**: a countdown before they run out, with a sound if you like.
- **Camp Benefits**: a countdown before the campfire buff runs out, and which ticked camp features it lacks.
- **Carrot on a Stick** (Extras page, off by default): worn while you ride, in the trinket slot you pick; your own trinket goes back on when you get off. Not in instances, and never in combat.
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
- **Want a Bound addon for another class?** The shared core, LibBound, has a guide and API reference: https://antnsn.github.io/LibBound/

## The Bound family
Stormbound is one of the Bound addons, one per class, built on the same core: Lightbound (paladin), Chronobound (mage), Stormbound (shaman), Packbound (hunter), Spiritbound (priest), Felbound (warlock), Dreambound (druid), Ragebound (warrior) and Shadowbound (rogue). They look like their class but work the same way, so if you know one, you know them all.

## Changelog
<!-- changelog:start -->
### 0.1.0

- **The Cure frame stays out of the way**: it only shows in combat, or when someone has a debuff you can remove (not in town while nobody needs it). Untick **Only in combat or when someone needs it** on the Cure page to keep it up.
- **Camp Benefits** (Forever's campfire buff, new **Camp** page): a warning before it runs out, and a chat line naming the camp features you ticked that the campfire lacks (Camp Chair, First Aid Kit, Mana Well, ...). From LibBound, the same in every Bound addon.
- **Cure**: a grid of your group (or a list) that shows who has Poison or a Disease you can remove. Click a cell for Cure Poison, right-click for Cure Disease. Each has a key that casts on whoever is under your mouse, in combat too. Set it up on the new Cure page; `/storm ignore <debuff>` hides one you don't want to see. The same frame as Lightbound's Cleanse.

### 0.1.0 beta 7

- **Carrot on a Stick** (Extras page, off by default): put it on when you mount, in the trinket slot you pick, and your own trinket back when you get off. Not in instances; in combat it waits until the fight is over. From LibBound, the same as in Lightbound.
- The Extras page is tidier: the Well-Rested and Well Fed switches sit in one row each.

### 0.1.0 beta 6

- Reset invalid saved imbue-tracking choices to Any with a notification instead of failing.
- Keep reagent and weapon-imbue reminders active during combat; clicking to cast still requires
  leaving combat. Unreadable item or imbue data is labeled unavailable instead of guessed.
- Defer Maelstrom stack tracking because Forever blocks access to its aura during combat.
- Add optional Fish Oil (Water Walking) and Shiny Fish Scales (Water Breathing) reminders.
  The Reagents options page has separate toggles and low-stock limits for these items and Ankhs.
- Separate **Shield to track** and **Imbue to track** settings from the spells the cards cast.
- Track a specific shield or imbue, or choose **Any** to accept any shaman shield or main-hand
  temporary weapon enchant. Specific imbue tracking warns when a different enchant is active.
- Existing shield and cast preferences are kept; weapon tracking still defaults to Any.
- Recognize Forever's Water Shield spell (408510), so its missing-shield reminder and click-to-cast work.
- Built on the latest LibBound, the shared core of the Bound addons, with its small fixes. Published on CurseForge straight from GitHub now.

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
