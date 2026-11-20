-- shared setup for the scenarios: a shaman with the given spells known (loaded with dofile)
local M = {}
local NAMES = {
	[324] = "Lightning Shield", [325] = "Lightning Shield", [24398] = "Water Shield", [974] = "Earth Shield",
	[8017] = "Rockbiter Weapon", [8024] = "Flametongue Weapon", [8033] = "Frostbrand Weapon", [8232] = "Windfury Weapon",
	[8071] = "Stoneskin Totem", [3599] = "Searing Totem", [5394] = "Healing Stream Totem", [8177] = "Grounding Totem",
	[8075] = "Strength of Earth Totem", [5730] = "Stoneclaw Totem",
	[556] = "Astral Recall", [20608] = "Reincarnation", [429959] = "Well-Rested",
}
function M.shaman(known)
	local s = wb.state
	s.player.classFile, s.player.class, s.player.classId = "SHAMAN", "Shaman", 7
	for _, id in ipairs(known or {}) do s.spells[id] = NAMES[id] end
	s.spells[429959] = "Well-Rested"
	s.slots[16] = 1520 -- a weapon in the main hand
end
function M.macroFor(spellName)
	for _, f in ipairs(wb.frames()) do
		local m = f:GetAttribute("macrotext")
		if m and f.__shown and m:find(spellName, 1, true) then return f end
	end
end
return M
