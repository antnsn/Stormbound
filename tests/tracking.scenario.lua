--@moods: legacy anyshield specificshield shieldmissing shieldexpiring unlearned ranks mismatch anyimbue boundaries unreadable options
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local m = wb.mood
T.shaman(m == "unlearned" and { 8017 } or { 324, 24398, 974, 8017, 8024, 8033, 8232 })
local db = { shieldChoice = "Water", imbueChoice = "Rockbiter" }
if m ~= "legacy" then db.shieldTrack = "Any" end
if m == "specificshield" then db.shieldTrack = "Lightning" end
wb.login({ saved = { StormboundDB = db } })
wb.advance(7)
local ns = wb.ns
local function shieldUp(name, id, seconds)
	wb.setAuras({ wb.aura(name, id, seconds, 3) })
	ns.UpdateBuffTimers()
end
local function imbueShown() return wb.shown("StormboundImbueFrame") end
local function shieldShown() return wb.shown("StormboundShieldFrame") end

if m == "legacy" then
	wb.expect("old shield choice becomes tracked shield", ns.db.shieldTrack, "Water")
	wb.expect("old imbue behavior preserved", ns.db.imbueTrack, "Any")
	wb.expect("old cast choice preserved", ns.ImbueSpell(), "Rockbiter Weapon")
	shieldUp("Lightning Shield", 324, 600)
	wb.expect("other shield does not satisfy legacy Water choice", shieldShown(), true)
	shieldUp("Water Shield", 24398, 600)
	wb.expect("legacy Water choice satisfied", shieldShown(), false)
elseif m == "anyshield" then
	for _, s in ipairs({ { "Lightning Shield", 324 }, { "Water Shield", 24398 }, { "Earth Shield", 974 } }) do
		shieldUp(s[1], s[2], 600)
		wb.expect(s[1] .. " satisfies Any", shieldShown(), false)
		wb.expect("Any does not change click preference", ns.ShieldSpell(), "Water Shield")
	end
	wb.setAuras({ wb.aura("Lightning Shield", 324, 30, 3), wb.aura("Earth Shield", 974, 600, 3) })
	ns.UpdateBuffTimers()
	wb.expect("one expiring shield does not warn while another is fresh", shieldShown(), false)
elseif m == "specificshield" then
	shieldUp("Water Shield", 24398, 600)
	wb.expect("wrong shield leaves reminder up", shieldShown(), true)
	wb.expect("title describes tracked shield", wb.frame("StormboundShieldFrame").titleText:GetText(), "Lightning Shield")
	wb.check(T.macroFor("Water Shield"), "click still uses independent cast choice")
	shieldUp("Lightning Shield", 324, 600)
	wb.expect("tracked shield satisfies reminder", shieldShown(), false)
elseif m == "shieldmissing" then
	wb.expect("Any missing shield reminder", shieldShown(), true)
	wb.check(T.macroFor("Water Shield"), "Any casts preferred shield")
	ns.db.shieldKeep = false
	ns.UpdateBuffTimers()
	wb.expect("missing toggle still works", shieldShown(), false)
elseif m == "shieldexpiring" then
	shieldUp("Earth Shield", 974, 45)
	wb.expect("Any warns for expiring Earth Shield", shieldShown(), true)
	wb.check(wb.frame("StormboundShieldFrame").statusText:GetText():find("left"), "countdown displayed")
	wb.check(T.macroFor("Water Shield"), "countdown retains cast choice")
	shieldUp("Water Shield", 24398, 600)
	wb.expect("switching to fresh shield clears reminder", shieldShown(), false)
elseif m == "unlearned" then
	wb.expect("Any stays hidden before learning shields", shieldShown(), false)
else
	local original = GetWeaponEnchantInfo
	local has, seconds, enchantID = true, 600, 3
	GetWeaponEnchantInfo = function() return has, seconds * 1000, 0, enchantID end
	local function update() ns.Refresh() end
	if m == "ranks" then
		local ranks = {
			Windfury = { 283, 284, 525, 1669 },
			Flametongue = { 3, 4, 5, 523, 1665, 1666 },
			Frostbrand = { 2, 12, 524, 1667, 1668 },
			Rockbiter = { 29, 6, 1, 503, 504, 683, 1663 },
		}
		for choice, ids in pairs(ranks) do
			ns.db.imbueTrack = choice
			for _, id in ipairs(ids) do
				enchantID = id
				update()
				wb.expect(choice .. " enchant " .. id .. " accepted", imbueShown(), false)
			end
		end
	elseif m == "mismatch" then
		ns.db.imbueTrack = "Windfury"
		update()
		wb.expect("Flametongue does not satisfy Windfury", imbueShown(), true)
		wb.check(wb.frame("StormboundImbueFrame").statusText:GetText():find("Different imbue", 1, true), "explains mismatch")
		wb.check(T.macroFor("Rockbiter Weapon"), "mismatch casts independent preference")
		enchantID = 99999
		update()
		wb.expect("unrelated enchant does not satisfy Windfury", imbueShown(), true)
		wb.combat(true)
		wb.expect("mismatch reminder remains in combat", imbueShown(), true)
		wb.check(not T.macroFor("Rockbiter Weapon"), "mismatch cannot be clicked in combat")
		wb.combat(false)
		update()
		wb.expect("mismatch returns after combat", imbueShown(), true)
		wb.state.slots[16] = nil
		update()
		wb.expect("no reminder without weapon", imbueShown(), false)
	elseif m == "anyimbue" then
		for _, id in ipairs({ 3, 283, 99999 }) do
			enchantID = id
			update()
			wb.expect("Any accepts enchant " .. id, imbueShown(), false)
		end
		enchantID = nil
		update()
		wb.expect("Any needs no enchant identity", imbueShown(), false)
		has = false
		update()
		wb.expect("Any warns when no enchant", imbueShown(), true)
	elseif m == "boundaries" then
		ns.db.imbueTrack = "Flametongue"
		for _, limit in ipairs({ 1, 5 }) do
			ns.db.imbueMinutes = limit
			seconds = limit * 60 + 1
			update()
			wb.expect("quiet above threshold", imbueShown(), false)
			seconds = limit * 60
			update()
			wb.expect("warn exactly at threshold", imbueShown(), true)
		end
		seconds = 0
		update()
		wb.expect("zero seconds still warns", imbueShown(), true)
		ns.db.imbue = false
		update()
		wb.expect("disabled tracker stays hidden", imbueShown(), false)
	elseif m == "unreadable" then
		ns.db.imbueTrack = "Windfury"
		enchantID = nil
		update()
		wb.expect("unavailable identity does not claim mismatch", imbueShown(), false)
		local isSecret = ns.IsSecret
		enchantID = {}
		ns.IsSecret = function(value) return value == enchantID or isSecret(value) end
		update()
		wb.expect("secret identity does not claim mismatch", imbueShown(), false)
		wb.combat(true)
		update()
		wb.expect("unreadable combat data keeps an honest indicator", imbueShown(), true)
		wb.expect("unreadable combat status", wb.frame("StormboundImbueFrame").statusText:GetText(), "Imbue data unavailable")
		wb.expect("unknown data does not glow", wb.frame("StormboundImbueFrame"):IsGlowing(), false)
		wb.combat(false)
		ns.IsSecret = isSecret
	elseif m == "options" then
		local rows = {}
		local UI = { CONTENT_W = 538 }
		UI.NewPage = function()
			return { y = -58, Add = function(self, height) self.y = self.y - height end }
		end
		UI.Section = function() return 26 end
		UI.DBToggle = function() return {}, 26 end
		UI.Slider = function() return {}, 46 end
		UI.Cycle = function(page, _, label, values, get, set)
			rows[label] = { values = values, get = get, set = set, page = page }
			return {}, 34
		end
		ns.optionPages[2](UI)
		rows["Shield to track"].set("Earth")
		rows["Imbue to track"].set("Windfury")
		wb.expect("shield settings persist", rows["Shield to track"].get(), "Earth")
		wb.expect("imbue settings persist", rows["Imbue to track"].get(), "Windfury")
		wb.expect("shield cast choice unchanged", rows["Shield to cast"].get(), "Water")
		wb.expect("imbue cast choice unchanged", rows["Imbue to cast"].get(), "Rockbiter")
		wb.expect("Any shield option", rows["Shield to track"].values[1], "Any")
		wb.expect("Any imbue option", rows["Imbue to track"].values[1], "Any")
		wb.check(-rows["Imbue to track"].page.y <= 494, "settings fit above footer")
	end
	GetWeaponEnchantInfo = original
end
