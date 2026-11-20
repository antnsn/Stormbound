-- The shield card (LibBound buff timer): the shield the shaman picked (Lightning, Water or Earth
-- Shield) missing or running out; click to cast it. Nothing shows while that shield isn't learned.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local SHIELDS = {
	{ key = "Lightning", list = D.lightningShield, english = "Lightning Shield", icon = 136051 },
	{ key = "Water", list = D.waterShield, english = "Water Shield", icon = 132315 },
	{ key = "Earth", list = D.earthShield, english = "Earth Shield", icon = 136089 },
}
ns.SHIELD_CHOICES = { "Lightning", "Water", "Earth" }

local function Chosen()
	for _, s in ipairs(SHIELDS) do if s.key == ns.db.shieldChoice then return s end end
	return SHIELDS[1]
end
-- the picked shield's name as the client shows it (known or not), and the spell to cast (known)
local function BuffName(s) return ns.SpellName(s.list[1]) or s.english end
function ns.ShieldSpell()
	local id = ns.BestRank(Chosen().list)
	return id and ns.SpellName(id)
end
function ns.ShieldLabel() return BuffName(Chosen()) end

ns.MakeBuffTimer({
	key = "shield", point = "lsPoint", frameName = "StormboundShieldFrame",
	label = "Shield", icon = 136051,
	title = function() return BuffName(Chosen()) end,
	names = function() return { BuffName(Chosen()) } end,
	active = function() return ns.ShieldSpell() ~= nil end,
	cast = function() return ns.ShieldSpell() end,
	explain = ns.Help.shield,
	goneText = "Missing: click to cast",
})
