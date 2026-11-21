-- Track a specific shield or any shaman shield; casting has its own preference.
local _, ns = ...
if ns.disabled then return end
local D = ns.DATA

local SHIELDS = {
	{ key = "Lightning", list = D.lightningShield, english = "Lightning Shield", icon = 136051 },
	{ key = "Water", list = D.waterShield, english = "Water Shield", icon = 132315 },
	{ key = "Earth", list = D.earthShield, english = "Earth Shield", icon = 136089 },
}
ns.SHIELD_CHOICES = { "Lightning", "Water", "Earth" }
ns.SHIELD_TRACK_CHOICES = { "Any", "Lightning", "Water", "Earth" }

local function Shield(choice)
	for _, s in ipairs(SHIELDS) do if s.key == choice then return s end end
	return SHIELDS[1]
end
-- the picked shield's name as the client shows it (known or not), and the spell to cast (known)
local function BuffName(s) return ns.SpellName(s.list[1]) or s.english end
function ns.ShieldSpell()
	local id = ns.BestRank(Shield(ns.db.shieldChoice).list)
	return id and ns.SpellName(id)
end
function ns.ShieldLabel() return BuffName(Shield(ns.db.shieldChoice)) end

local function TrackedNames()
	if ns.db.shieldTrack ~= "Any" then return { BuffName(Shield(ns.db.shieldTrack)) } end
	local names, buffs = {}, ns.ReadPlayerBuffs()
	local longest, expires
	for _, s in ipairs(SHIELDS) do
		local name = BuffName(s)
		names[#names + 1] = name
		local buff = buffs[name]
		if buff and (not longest or (buff.expires or 0) > expires) then
			longest, expires = name, buff.expires or 0
		end
	end
	-- Earth Shield can coexist with another shield; Any remains satisfied by either.
	return longest and { longest } or names
end

local function Active()
	if ns.db.shieldTrack ~= "Any" then return ns.BestRank(Shield(ns.db.shieldTrack).list) ~= nil end
	for _, s in ipairs(SHIELDS) do
		if ns.BestRank(s.list) then return true end
	end
	return false
end

ns.MakeBuffTimer({
	key = "shield", point = "lsPoint", frameName = "StormboundShieldFrame",
	label = "Shield", icon = 136051,
	title = function() return ns.db.shieldTrack == "Any" and "Any shield" or BuffName(Shield(ns.db.shieldTrack)) end,
	names = TrackedNames,
	active = Active,
	cast = function() return ns.ShieldSpell() end,
	explain = ns.Help.shield,
	goneText = "Missing: click to cast",
})
