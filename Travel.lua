-- The travel panel (LibBound) beside the game menu: Astral Recall and the Hearthstone.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")

local function Known(id)
	local ok, k = pcall(IsPlayerSpell, id)
	return ok and not ns.IsSecret(k) and k and true or false
end

-- Astral Recall, then the water spells (handy before a swim)
local ROWS = {
	{ key = "astralRecall", label = "Astral Recall", level = 30, help = "recall" },
	{ key = "waterBreathing", label = "Water Breathing", level = 22, help = "waterBreathing" },
	{ key = "waterWalking", label = "Water Walking", level = 28, help = "waterWalking" },
}
function ns.TravelRows()
	local out = {}
	for _, r in ipairs(ROWS) do
		local id = ns.DATA[r.key]
		out[#out + 1] = { spell = id, label = r.label, column = 1, known = Known(id), level = r.level,
			tip = r.label, help = ns.Help[r.help], learn = "from a shaman trainer" }
	end
	return out
end

Bound.InstallTravel(ns, {
	columns = { "SHAMAN" },
	rows = ns.TravelRows,
	hearthHelp = ns.Help.hearthstone,
})
