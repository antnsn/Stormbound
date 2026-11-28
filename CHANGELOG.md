# Changelog

## Unreleased

- **Camp Benefits** (Forever's campfire buff, new **Camp** page): a warning before it runs out, and a chat line naming the camp features you ticked that the campfire lacks (Camp Chair, First Aid Kit, Mana Well, ...). From LibBound, the same in every Bound addon.
- **Cure**: a grid of your group (or a list) that shows who has Poison or a Disease you can remove. Click a cell for Cure Poison, right-click for Cure Disease. Each has a key that casts on whoever is under your mouse, in combat too. Set it up on the new Cure page; `/storm ignore <debuff>` hides one you don't want to see. The same frame as Lightbound's Cleanse.

## 0.1.0 beta 7

- **Carrot on a Stick** (Extras page, off by default): put it on when you mount, in the trinket slot you pick, and your own trinket back when you get off. Not in instances; in combat it waits until the fight is over. From LibBound, the same as in Lightbound.
- The Extras page is tidier: the Well-Rested and Well Fed switches sit in one row each.

## 0.1.0 beta 6

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

## 0.1.0 beta 5

- **Minimap button** works with minimap addons (EllesmereUI, SexyMap, ElvUI, MinimapButtonBag, broker bars): it is a LibDBIcon button now. Its place on the minimap is kept.

## 0.1.0 beta 4

- **New icon**: hand-painted class art for the icon, the emblem and the faint crest behind the cards.

## 0.1.0 beta 3

- **New look**: a painted icon and emblem, and a faint class crest behind every card and in the corner of the options window and the travel panel (the Blizzard and Flat skins stay plain).

## 0.1.0 beta 2

- **Shield choice**: Lightning, Water or Earth Shield.
- **Totem choice** per element, in the options or with the mouse wheel over a totem button.
- Water Breathing and Water Walking beside the Escape menu.
- The imbue card is called "Weapon imbue".
- The slash command is `/storm` (`/sb` belongs to another addon).

## 0.1.0 beta 1

- First test build: totem bar with timers (click to recast, right-click to remove), Lightning Shield and weapon imbue cards (click to cast), totem item and Ankh warnings, Astral Recall and the Hearthstone beside the Escape menu, Well-Rested and Well Fed, explanations in tooltips, movable frames, Storm, Blizzard and Flat skins. Built on LibBound-1.0.
