--@moods: forever tbc-first tbc-second unlearned combat
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local ids = { forever = 408510, ["tbc-first"] = 24398, ["tbc-second"] = 33736, combat = 408510 }
local id = ids[wb.mood]
T.shaman(id and { id } or {})
wb.login({ saved = { StormboundDB = { shieldTrack = "Water", shieldChoice = "Water" } } })
wb.advance(7)
local ns = wb.ns
local function shown() return wb.shown("StormboundShieldFrame") end

if not id then
	wb.expect("unlearned Water Shield stays hidden", shown(), false)
	wb.expect("unlearned Water Shield cannot be cast", ns.ShieldSpell(), nil)
else
	wb.expect("known Water Shield ID recognized", ns.BestRank(ns.DATA.waterShield), id)
	wb.expect("missing Water Shield shows reminder", shown(), true)
	wb.expect("Water Shield card title", wb.frame("StormboundShieldFrame").titleText:GetText(), "Water Shield")
	wb.check(T.macroFor("Water Shield"), "Water Shield reminder can cast")

	wb.setAuras({ wb.aura("Water Shield", id, 600, 3) })
	ns.UpdateBuffTimers()
	wb.expect("active Water Shield clears reminder", shown(), false)

	wb.setAuras({ wb.aura("Water Shield", id, 45, 3) })
	ns.UpdateBuffTimers()
	wb.expect("expiring Water Shield shows countdown", shown(), true)
	wb.check(wb.frame("StormboundShieldFrame").statusText:GetText():find("left"), "time left displayed")

	wb.setAuras({})
	ns.UpdateBuffTimers()
	wb.expect("Water Shield removal restores reminder", shown(), true)

	ns.db.shieldTrack = "Any"
	ns.UpdateBuffTimers()
	wb.expect("Any recognizes Water Shield as the only learned shield", shown(), true)
	wb.setAuras({ wb.aura("Water Shield", id, 600, 3) })
	ns.UpdateBuffTimers()
	wb.expect("Water Shield satisfies Any", shown(), false)
	if wb.mood == "combat" then
		wb.setAuras({ wb.aura("Water Shield", id, 45, 3) })
		ns.UpdateBuffTimers()
		local read = ns.ReadPlayerBuffs
		ns.ReadPlayerBuffs = function() return {}, true end
		wb.combat(true)
		wb.expect("known shield countdown remains during combat restriction", shown(), true)
		wb.check(not T.macroFor("Water Shield"), "shield cast overlay hidden in combat")
		wb.advance(1)
		wb.check(wb.frame("StormboundShieldFrame").statusText:GetText():find("left"), "cached duration still counts down")
		ns.ReadPlayerBuffs = read
		wb.combat(false)
	end
end
