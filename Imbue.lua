-- Weapon imbue card: the tracked imbue is missing or about to run out; click casts the chosen
-- imbue (out of combat). "Auto" picks the best one known: Windfury, then Flametongue, then
-- Rockbiter (Frostbrand only when picked). Quiet in combat.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA
local Bound = LibStub("LibBound-1.0")

local CHOICES = { "Auto", "Windfury", "Flametongue", "Frostbrand", "Rockbiter" }
ns.IMBUE_CHOICES = CHOICES
ns.IMBUE_TRACK_CHOICES = { "Any", "Windfury", "Flametongue", "Frostbrand", "Rockbiter" }
local LISTS = { Windfury = D.windfury, Flametongue = D.flametongue, Frostbrand = D.frostbrand, Rockbiter = D.rockbiter }
-- SpellItemEnchantment IDs, not spell IDs: all ranks in ns.DATA.
local ENCHANTS = {
	Windfury = { 283, 284, 525, 1669 },
	Flametongue = { 3, 4, 5, 523, 1665, 1666 },
	Frostbrand = { 2, 12, 524, 1667, 1668 },
	Rockbiter = { 29, 6, 1, 503, 504, 683, 1663 },
}

-- the imbue spell to cast (name), or nil when none is known
function ns.ImbueSpell()
	local choice = ns.db.imbueChoice
	if choice ~= "Auto" and LISTS[choice] then
		local id = ns.BestRank(LISTS[choice])
		if id then return ns.SpellName(id) end
	end
	for _, k in ipairs({ "Windfury", "Flametongue", "Rockbiter" }) do
		local id = ns.BestRank(LISTS[k])
		if id then return ns.SpellName(id) end
	end
	return nil
end

-- Returns seconds left, unknown, different. Unreadable identities never claim a mismatch.
function ns.ImbueLeft()
	local ok, has, ms, _, enchantID = pcall(GetWeaponEnchantInfo)
	if not ok or ns.IsSecret(has) or ns.IsSecret(ms) then return nil, true end
	if not has then return nil end
	if ns.db.imbueTrack ~= "Any" then
		if ns.IsSecret(enchantID) or type(enchantID) ~= "number" then return nil, true end
		local matches = false
		for _, id in ipairs(ENCHANTS[ns.db.imbueTrack]) do
			if id == enchantID then matches = true; break end
		end
		if not matches then return nil, false, true end
	end
	return (ms or 0) / 1000
end

local M = {}
ns.modules[#ns.modules + 1] = M
local card, overlay

local function HasWeapon()
	local ok, id = pcall(GetInventoryItemID, "player", 16)
	return ok and not ns.IsSecret(id) and id ~= nil
end

function M:Update()
	if not card then return end
	if ns.unlocked then
		card:SetStatus("1:00 left"); card:Show(); card:Glow(false)
		if not InCombatLockdown() then overlay:Sync(nil) end
		return
	end
	local spell = ns.ImbueSpell()
	local show, status, urgent = false, nil, false
	if ns.db.imbue and spell and HasWeapon() and not ns.InCombat() then
		local left, unknown, different = ns.ImbueLeft()
		if not left and not unknown then
			show, status, urgent = true, (different and "Different imbue: click for " or "Missing: click for ") .. spell, true
		elseif left and left <= ns.db.imbueMinutes * 60 then
			show, status = true, Bound.FormatTime(left) .. " left: click for " .. spell
		end
	end
	if show then
		card:SetTitle("Weapon imbue")
		card:SetStatus(status, urgent)
		card:Show(); card:Glow(true)
	else
		card:Glow(false); card:Hide()
	end
	if not InCombatLockdown() then overlay:Sync(show and spell or nil, "player", ns.Help.imbue) end
end

function M:Init()
	card = ns.MakeCard("StormboundImbueFrame")
	card:SetIcon(136018)
	card:SetTitle("Weapon imbue")
	card:SetExplain(ns.Help.imbue)
	ns.MakeMovable(card, "imPoint")
	ns.ApplyPoint(card, "imPoint")
	overlay = ns.CastOverlay(card)
	local f = CreateFrame("Frame")
	for _, e in ipairs({ "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED", "SPELLS_CHANGED", "PLAYER_ENTERING_WORLD",
		"PLAYER_EQUIPMENT_CHANGED" }) do f:RegisterEvent(e) end
	f:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
	f:SetScript("OnEvent", function() M:Update() end)
	C_Timer.NewTicker(1, function() M:Update() end)
	M:Update()
end
