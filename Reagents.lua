-- Missing totem items and low spell reagents. Each consumable has its own toggle and limit.
-- Only warn for learned spells, and stay quiet in combat.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local ORDER = { "earth", "fire", "water", "air" }
local REAGENTS = {
	{ key = "ankhs", low = "ankhLow", label = "Ankhs", item = D.ankh, spell = D.reincarnation,
		spellName = "Reincarnation", name = "Ankh", point = "akPoint", icon = 136080, help = ns.Help.ankh, max = 10 },
	{ key = "fishOil", low = "fishOilLow", label = "Fish Oil", item = D.fishOil, spell = D.waterWalking,
		spellName = "Water Walking", name = "FishOil", point = "foPoint",
		icon = "Interface\\Icons\\INV_Potion_64", help = ns.Help.waterWalking, max = 20 },
	{ key = "fishScales", low = "fishScalesLow", label = "Shiny Fish Scales", item = D.fishScales, spell = D.waterBreathing,
		spellName = "Water Breathing", name = "FishScales", point = "fsPoint",
		icon = "Interface\\Icons\\INV_Misc_MonsterScales_08", help = ns.Help.waterBreathing, max = 20 },
}
ns.REAGENT_TRACKERS = REAGENTS

local function Count(id)
	local ok, n = pcall(C_Item.GetItemCount, id)
	return (ok and not ns.IsSecret(n) and n) or 0
end

-- the elements whose totems are learned but whose item isn't in the bags
function ns.MissingTotemItems()
	local out = {}
	for _, k in ipairs(ORDER) do
		local e = D.elements[k]
		if ns.ElementKnown(k) and Count(e.item) == 0 then out[#out + 1] = e.itemName end
	end
	return out
end

local function Known(id)
	local ok, k = pcall(IsPlayerSpell, id)
	return ok and not ns.IsSecret(k) and k and true or false
end

local M = {}
ns.modules[#ns.modules + 1] = M
local items
local cards = {}

function M:Update()
	if not items then return end
	if ns.unlocked then
		items:SetStatus("Air Totem"); items:Show(); items:Glow(false)
		for _, card in ipairs(cards) do
			card:SetStatus("1 left"); card:Show(); card:Glow(false)
		end
		return
	end
	local quiet = ns.InCombat()
	local missing = ns.MissingTotemItems()
	if ns.db.totemItems and #missing > 0 and not quiet then
		items:SetTitle(#missing == 1 and (missing[1] .. " missing") or "Totem items missing")
		items:SetStatus(table.concat(missing, ", "), true)
		items:Show(); items:Glow(true)
	else
		items:Glow(false); items:Hide()
	end
	for i, r in ipairs(REAGENTS) do
		local card, n = cards[i], Count(r.item)
		if ns.db[r.key] and Known(r.spell) and n <= ns.db[r.low] and not quiet then
			card:SetStatus(n == 0 and ("None left: " .. r.spellName .. " can't be used") or (n .. " left"), n == 0)
			card:Show(); card:Glow(true)
		else
			card:Glow(false); card:Hide()
		end
	end
end

function M:Init()
	items = ns.MakeCard("StormboundTotemItemsFrame")
	items:SetIcon(136232)
	items:SetTitle("Totem items missing")
	items:SetExplain(ns.Help.totemItem)
	ns.MakeMovable(items, "tiPoint"); ns.ApplyPoint(items, "tiPoint")
	for i, r in ipairs(REAGENTS) do
		local card = ns.MakeCard("Stormbound" .. r.name .. "Frame")
		card:SetIcon(r.icon)
		card:SetTitle(r.label)
		card:SetExplain(r.help)
		ns.MakeMovable(card, r.point); ns.ApplyPoint(card, r.point)
		cards[i] = card
	end
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "BAG_UPDATE_DELAYED", "SPELLS_CHANGED", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED",
		"PLAYER_ENTERING_WORLD" }) do f:RegisterEvent(e) end
	f:SetScript("OnEvent", function() M:Update() end)
	M:Update()
end
