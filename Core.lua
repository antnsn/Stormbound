-- Stormbound: the Shaman addon of the Bound family, built on LibBound-1.0 (the shared core).
-- This file sets the addon up; every other file returns at once on a non-shaman (ns.disabled).
local addonName, ns = ...
local Bound = LibStub("LibBound-1.0")

-- Spells and items, lowest rank first. Classic IDs; Forever follows Classic content.
-- Checked in game before each release.
ns.DATA = {
	lightningShield = { 324, 325, 905, 945, 8134, 10431, 10432 },
	-- Water Shield also uses 408510 on Forever (confirmed from the client spellbook).
	waterShield = { 24398, 33736, 408510 },
	earthShield = { 974, 32593, 32594 },
	rockbiter = { 8017, 8018, 8019, 10399, 16314, 16315, 16316 },
	flametongue = { 8024, 8027, 8030, 16339, 16341, 16342 },
	frostbrand = { 8033, 8038, 10456, 16355, 16356 },
	windfury = { 8232, 8235, 10486, 16362 },
	astralRecall = 556,
	waterWalking = 546,
	waterBreathing = 131,
	reincarnation = 20608,
	ankh = 17030,
	-- the totem item each element needs in the bags, and the element's totems (first rank):
	-- a known one means the element is learned, and they are what a totem button can be set to
	elements = {
		earth = { item = 5175, itemName = "Earth Totem", spells = { 8071, 2484, 8075, 5730, 8143 } },
		fire = { item = 5176, itemName = "Fire Totem", spells = { 3599, 1535, 8181, 8190, 8227 } },
		water = { item = 5177, itemName = "Water Totem", spells = { 5394, 5675, 8166, 8184, 8170, 16190 } },
		air = { item = 5178, itemName = "Air Totem", spells = { 8177, 10595, 8835, 6495, 8512, 15107, 25908 } },
	},
}

ns.disabled = Bound:NewAddon(addonName, ns, {
	class = "SHAMAN",
	title = "Stormbound",
	prefix = "8fb4ff",
	db = "StormboundDB",
	slash = { "/storm", "/stormbound" },
	media = "Interface\\AddOns\\Stormbound\\Media\\",
	defaults = {
		skin = "storm",
		shield = true, shieldChoice = "Lightning", shieldMinutes = 1, shieldSound = false, shieldIcon = true, shieldKeep = true,
		lsPoint = { "CENTER", "UIParent", "CENTER", -250, 200 },
		imbue = true, imbueChoice = "Auto", imbueTrack = "Any", imbueMinutes = 1,
		imPoint = { "CENTER", "UIParent", "CENTER", -250, 140 },
		totems = true, totemTimers = true, lastTotem = {},
		totemChoice = {}, -- element -> totem name the button drops; none = the last one used
		tbPoint = { "CENTER", "UIParent", "CENTER", 0, -230 },
		totemItems = true, ankhs = true, ankhLow = 2,
		tiPoint = { "CENTER", "UIParent", "CENTER", 250, 200 },
		akPoint = { "CENTER", "UIParent", "CENTER", 250, 140 },
		travel = true,
		wrPoint = { "CENTER", "UIParent", "CENTER", 0, 320 },
		wfPoint = { "CENTER", "UIParent", "CENTER", 0, 260 },
	},
	migrate = function(db)
		-- Older profiles tracked the shield chosen for casting.
		if db.shieldTrack == nil then db.shieldTrack = db.shieldChoice end
	end,
})
