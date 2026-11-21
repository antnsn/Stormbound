--@moods: fresh missing imbued expiring choice noweapon combat
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local m = wb.mood
local known = m == "fresh" and {} or { 324, 8017, 8024 }
T.shaman(known)
if m == "noweapon" then wb.state.slots[16] = nil end
local db = {}
if m == "choice" then db.imbueChoice = "Rockbiter" end
if m == "imbued" then wb.state.auras.player = { wb.aura("Lightning Shield", 324, 600, 3) } end
wb.login({ saved = { StormboundDB = db } })
if m == "imbued" then wb.setWeaponEnchant(1800, 5) end
if m == "expiring" then wb.setWeaponEnchant(45, 5) end
wb.advance(7)
local shield, imbue = wb.shown("StormboundShieldFrame"), wb.shown("StormboundImbueFrame")
if m == "fresh" then
	wb.expect("no shield card before it is learned", shield, false)
	wb.expect("no imbue card before one is learned", imbue, false)
elseif m == "imbued" then
	wb.expect("shield up: no card", shield, false)
	wb.expect("imbue on: no card", imbue, false)
elseif m == "noweapon" then
	wb.expect("no weapon: no imbue card", imbue, false)
else
	wb.expect("shield card when missing", shield, true)
	wb.check(T.macroFor("Lightning Shield"), "clicking it casts Lightning Shield")
	wb.expect("imbue card", imbue, true)
	local want = m == "choice" and "Rockbiter Weapon" or "Flametongue Weapon" -- auto: best known
	wb.expect("titled Weapon imbue", wb.frame("StormboundImbueFrame").titleText:GetText(), "Weapon imbue")
	wb.check(wb.frame("StormboundImbueFrame").statusText:GetText():find(want, 1, true), "the status names the imbue")
	wb.check(T.macroFor(want), "and casts it")
	if m == "expiring" then
		wb.check(wb.frame("StormboundImbueFrame").statusText:GetText():find("left"), "time left shown")
	end
	if m == "combat" then
		wb.combat(true)
		wb.expect("imbue card stays visible in combat", wb.shown("StormboundImbueFrame"), true)
		wb.check(not T.macroFor("Flametongue Weapon"), "combat hides the cast overlay")
		wb.check(not wb.frame("StormboundImbueFrame").statusText:GetText():find("click", 1, true), "no combat click prompt")
		wb.setWeaponEnchant(600, 5)
		wb.expect("fresh imbue clears reminder during combat", wb.shown("StormboundImbueFrame"), false)
		wb.setWeaponEnchant(45, 5)
		wb.expect("expiring imbue tracked during combat", wb.shown("StormboundImbueFrame"), true)
		wb.combat(false)
		wb.advance(1)
		wb.expect("back after", wb.shown("StormboundImbueFrame"), true)
		wb.check(T.macroFor("Flametongue Weapon"), "clickable again after combat")
	end
end

-- the shield choice
if m == "missing" then
	wb.ns.db.shieldChoice = "Water"
	wb.ns.db.shieldTrack = "Water"
	wb.ns.UpdateBuffTimers()
	wb.advance(2)
	wb.expect("water shield not learned: no card", wb.shown("StormboundShieldFrame"), false)
	wb.state.spells[24398] = "Water Shield"
	wb.fire("SPELLS_CHANGED")
	wb.advance(2)
	wb.expect("learned: the card asks for it", wb.shown("StormboundShieldFrame"), true)
	wb.expect("named Water Shield", wb.frame("StormboundShieldFrame").titleText:GetText(), "Water Shield")
	wb.check(T.macroFor("Water Shield"), "and casts it")
	wb.setAuras({ wb.aura("Water Shield", 24398, 600, 3) })
	wb.advance(2)
	wb.expect("gone once it is up", wb.shown("StormboundShieldFrame"), false)
end
