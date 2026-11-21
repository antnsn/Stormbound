-- Missing totem items and low spell reagents. Each consumable has its own toggle and limit.
-- Only warn for learned spells; bag reminders remain active during combat.
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

local countErrors = {}
local function Count(id)
	local ok, n = pcall(C_Item.GetItemCount, id)
	if not ok then
		if not countErrors[id] then ns.Print("Couldn't count reagent " .. id .. ": " .. tostring(n)) end
		countErrors[id] = true
		return nil
	end
	countErrors[id] = nil
	if ns.IsSecret(n) or type(n) ~= "number" then return nil end
	return n
end

-- the elements whose totems are learned but whose item isn't in the bags
function ns.MissingTotemItems()
	local out, unknown = {}, false
	for _, k in ipairs(ORDER) do
		local e = D.elements[k]
		if ns.ElementKnown(k) then
			local n = Count(e.item)
			if n == nil then unknown = true
			elseif n == 0 then out[#out + 1] = e.itemName end
		end
	end
	return out, unknown
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
	local missing, unknown = {}, false
	if ns.db.totemItems then missing, unknown = ns.MissingTotemItems() end
	if ns.db.totemItems and (#missing > 0 or unknown) then
		items:SetTitle(#missing == 0 and "Totem items" or (#missing == 1 and (missing[1] .. " missing") or "Totem items missing"))
		local status = table.concat(missing, ", ")
		if unknown then status = #missing > 0 and (status .. "; other counts unavailable") or "Item counts unavailable" end
		items:SetStatus(status, #missing > 0)
		items:Show(); items:Glow(#missing > 0)
	else
		items:Glow(false); items:Hide()
	end
	for i, r in ipairs(REAGENTS) do
		local card = cards[i]
		local enabled = ns.db[r.key] and Known(r.spell)
		local n = enabled and Count(r.item) or nil
		if enabled and (n == nil or n <= ns.db[r.low]) then
			card:SetStatus(n == nil and "Item count unavailable"
				or (n == 0 and ("None left: " .. r.spellName .. " can't be used") or (n .. " left")), n == 0)
			card:Show(); card:Glow(n ~= nil)
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
