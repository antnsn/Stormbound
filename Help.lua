-- Every plain-word explanation in one place (tooltips show them while "Explain things" is on).
local _, ns = ...
if ns.disabled then return end

ns.Help = {
	shield = "Your shield stays on you for a while: Lightning Shield zaps whatever hits you, Water Shield gives mana back, Earth Shield heals when you're hit. Track one shield or Any in the options; choose the shield to cast separately.",
	imbue = "A weapon imbue charges your weapon with an element for a while: Rockbiter for threat, Flametongue for fire damage, Frostbrand to slow, Windfury for extra swings. Track one imbue or Any main-hand enchant; choose what to cast separately.",
	maelstrom = "Maelstrom Weapon builds up to five stacks. This card shows your current stacks and blinks at five, so you know the full stack is ready to use.",
	totems = "Totems are the shaman's tools: each one helps you and your group while it stands. One of each element (earth, fire, water, air) can be down at a time.",
	totemButton = "Left-click: drop the last totem of this element again. Right-click: remove it.",
	totemItem = "You need the element's totem item in your bags to drop its totems. Lost it? Ask a shaman trainer how to get a new one.",
	ankh = "Reincarnation brings you back to life where you died. It uses one Ankh, sold by reagent vendors.",
	waterWalking = "Water Walking lets you (or a friend) walk on water for 10 minutes. Uses a Fish Oil.",
	waterBreathing = "Water Breathing lets you (or a friend) breathe under water for 10 minutes. Uses a Shiny Fish Scale.",
	recall = "Astral Recall takes you to your Hearthstone's inn, like the Hearthstone itself, with its own cooldown.",
	hearthstone = "Your Hearthstone takes you back to the inn you set it to. Talk to an innkeeper to change it.",
}
