-- Maelstrom Weapon stacks stay visible in combat when the client exposes them.
local _, ns = ...
if ns.disabled then return end

local MAX_STACKS = 5
local readError = false

-- LibBound's buff reader only returns timer fields, not stack counts.
function ns.MaelstromStacks()
	for i = 1, 40 do
		local ok, aura = pcall(C_UnitAuras.GetAuraDataByIndex, "player", i, "HELPFUL")
		if not ok then
			if not readError then ns.Print("Couldn't read Maelstrom Weapon stacks: " .. tostring(aura)) end
			readError = true
			return nil
		end
		if ns.IsSecret(aura) then return nil end
		if not aura then break end
		if ns.Clean(aura.spellId) == ns.DATA.maelstromWeapon then
			readError = false
			local stacks = ns.Clean(aura.applications)
			return type(stacks) == "number" and stacks or nil
		end
	end
	readError = false
	return 0
end

local M = {}
ns.modules[#ns.modules + 1] = M
local card
local blinking, elapsed = false, 0

local function Blink(on)
	if blinking ~= on then
		blinking, elapsed = on, 0
		card:SetAlpha(1)
	end
end

function M:Update()
	if not card then return end
	if ns.unlocked then
		Blink(false)
		card:SetStatus("3/5 stacks"); card:Show(); card:Glow(false)
		return
	end
	local stacks = ns.db.maelstrom and ns.MaelstromStacks()
	if not stacks or stacks <= 0 then
		Blink(false)
		card:Glow(false); card:Hide()
		return
	end
	local ready = stacks >= MAX_STACKS
	card:SetStatus(stacks .. "/5 stacks" .. (ready and " - ready!" or ""), ready)
	card:Show(); card:Glow(ready)
	Blink(ready)
end

function M:Init()
	card = ns.MakeCard("StormboundMaelstromFrame")
	card:SetIcon("Interface\\Icons\\Spell_Shaman_MaelstromWeapon")
	card:SetTitle("Maelstrom Weapon")
	card:SetExplain(ns.Help.maelstrom)
	ns.MakeMovable(card, "mwPoint"); ns.ApplyPoint(card, "mwPoint")
	card:SetScript("OnUpdate", function(_, delta)
		if not blinking then return end
		elapsed = (elapsed + delta) % 1
		card:SetAlpha(elapsed < 0.5 and 1 or 0.25)
	end)
	local f = CreateFrame("Frame")
	f:RegisterUnitEvent("UNIT_AURA", "player")
	for _, event in ipairs({ "PLAYER_ENTERING_WORLD", "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED" }) do
		f:RegisterEvent(event)
	end
	f:SetScript("OnEvent", function() M:Update() end)
	M:Update()
end
