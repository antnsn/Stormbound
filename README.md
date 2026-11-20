# Stormbound

A shaman helper for **WoW: Forever**, part of the Bound family (Lightbound for paladins,
Chronobound for mages). For shamans who play with friends, and easy for new ones.

- **Totem bar**: one button per element (Earth, Fire, Water, Air) with the totem that stands and
  its time left. Left-click drops the last totem of that element again, right-click removes it.
- **Shield**: Lightning, Water or Earth Shield, your pick: a card when it is missing or about to
  run out. Click it to cast.
- **Weapon imbue**: a card when your main hand has no imbue (or it's running out). Click it to
  cast your best one (Windfury, Flametongue, Rockbiter), or the one you pick.
- **Totem choice**: pick which totem each button drops (options, or the mouse wheel over the
  button), or let it drop the last one used.
- **Totem items and Ankhs**: says when an Earth/Fire/Water/Air Totem item is missing (without it
  that element's totems can't be dropped) and when Ankhs run low for Reincarnation.
- **Travel**: press Escape, and beside the game menu you get Astral Recall, Water Breathing,
  Water Walking and your Hearthstone.
- **Well-Rested and Well Fed** timers, plain-word explanations in tooltips, movable frames
  (`/storm unlock`), three skins (Storm, Blizzard, Flat).

Type `/storm` for the options, `/storm help` for the commands.

## Install

1. Open [Releases](https://github.com/antnsn/Stormbound/releases) and download
   `Stormbound-<version>.zip` (not the green "Code > Download ZIP" button).
2. Unzip it into `World of Warcraft/_forever_/Interface/AddOns/`, so you get `AddOns/Stormbound`.
3. Restart the game. Stormbound only loads on shamans.

## Development

Built on [LibBound](https://github.com/antnsn/LibBound), developed in the folder next to it.

```bash
tools/sync-libbound.sh
for f in *.lua; do luac5.1 -p "$f"; done
~/.luarocks/bin/luacheck .
wowbench check . && wowbench test .
wowbench pack . --set-version 0.1.0
python3 tools/make_media.py
```
