--@moods: defaults empty stocked oil-only scales-only unlearned combat thresholds changes unlocked options
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local m = wb.mood
T.shaman(m == "unlearned" and {} or { 546, 131, 20608 })
local saved = {}
if m ~= "defaults" then
	saved.fishOil, saved.fishScales = m ~= "scales-only", m ~= "oil-only"
end
local bags = wb.state.bags
bags[17030] = 10
bags[17058], bags[17057] = m == "stocked" and 3 or 0, m == "stocked" and 3 or 0
wb.login({ saved = { StormboundDB = saved } })
wb.advance(3)
local ns = wb.ns
local function oil() return wb.shown("StormboundFishOilFrame") end
local function scales() return wb.shown("StormboundFishScalesFrame") end
local function update() wb.fire("BAG_UPDATE_DELAYED") end

if m == "defaults" then
	wb.expect("existing Ankh setting unchanged", ns.db.ankhs, true)
	wb.expect("oil opt-in", ns.db.fishOil, false)
	wb.expect("scales opt-in", ns.db.fishScales, false)
	wb.expect("no oil reminder by default", oil(), false)
	wb.expect("no scales reminder by default", scales(), false)
elseif m == "stocked" or m == "unlearned" then
	wb.expect("no oil reminder when stocked or unlearned", oil(), false)
	wb.expect("no scales reminder when stocked or unlearned", scales(), false)
elseif m == "oil-only" or m == "scales-only" then
	wb.expect("oil toggle independent", oil(), m == "oil-only")
	wb.expect("scales toggle independent", scales(), m == "scales-only")
elseif m == "empty" then
	wb.expect("oil missing", oil(), true)
	wb.expect("scales missing", scales(), true)
	wb.expect("oil title", wb.frame("StormboundFishOilFrame").titleText:GetText(), "Fish Oil")
	wb.expect("scales title", wb.frame("StormboundFishScalesFrame").titleText:GetText(), "Shiny Fish Scales")
	wb.expect("oil identifies spell", wb.frame("StormboundFishOilFrame").statusText:GetText(),
		"None left: Water Walking can't be used")
	wb.expect("scales identifies spell", wb.frame("StormboundFishScalesFrame").statusText:GetText(),
		"None left: Water Breathing can't be used")
elseif m == "combat" then
	wb.combat(true)
	wb.expect("oil quiet in combat", oil(), false)
	wb.expect("scales quiet in combat", scales(), false)
	wb.combat(false)
	wb.expect("oil returns after combat", oil(), true)
	wb.expect("scales returns after combat", scales(), true)
elseif m == "thresholds" then
	for _, limit in ipairs({ 0, 2, 20 }) do
		ns.db.fishOilLow, ns.db.fishScalesLow = limit, limit
		bags[17058], bags[17057] = limit + 1, limit + 1
		update()
		wb.expect("oil quiet above " .. limit, oil(), false)
		wb.expect("scales quiet above " .. limit, scales(), false)
		bags[17058], bags[17057] = limit, limit
		update()
		wb.expect("oil warns at " .. limit, oil(), true)
		wb.expect("scales warns at " .. limit, scales(), true)
	end
	ns.db.fishOilLow, ns.db.fishScalesLow = 0, 2
	bags[17058], bags[17057] = 1, 1
	update()
	wb.expect("oil limit independent", oil(), false)
	wb.expect("scales limit independent", scales(), true)
	wb.expect("remaining stock displayed", wb.frame("StormboundFishScalesFrame").statusText:GetText(), "1 left")
elseif m == "changes" then
	bags[17058], bags[17057] = 10, 10
	update()
	wb.expect("oil restock clears card", oil(), false)
	wb.expect("scales restock clears card", scales(), false)
	bags[17058], bags[17057] = 0, 0
	wb.state.spells[546], wb.state.spells[131] = nil, nil
	wb.fire("SPELLS_CHANGED")
	wb.expect("forgotten walking hides oil", oil(), false)
	wb.expect("forgotten breathing hides scales", scales(), false)
	wb.state.spells[546], wb.state.spells[131] = "Water Walking", "Water Breathing"
	wb.fire("SPELLS_CHANGED")
	wb.expect("learning walking enables oil", oil(), true)
	wb.expect("learning breathing enables scales", scales(), true)
	ns.db.fishOil, ns.db.fishScales = false, false
	ns.Refresh()
	wb.expect("disabling oil hides card immediately", oil(), false)
	wb.expect("disabling scales hides card immediately", scales(), false)
elseif m == "unlocked" then
	ns.db.fishOil, ns.db.fishScales = false, false
	ns.unlocked = true
	ns.Refresh()
	wb.expect("oil preview when unlocked", oil(), true)
	wb.expect("scales preview when unlocked", scales(), true)
	ns.unlocked = false
	ns.Refresh()
	wb.expect("oil preview hidden after locking", oil(), false)
	wb.expect("scales preview hidden after locking", scales(), false)
	wb.check(ns.defaults.foPoint ~= ns.defaults.fsPoint, "separate saved positions")
elseif m == "options" then
	local toggles, sliders, page = {}, {}, nil
	local UI = { CONTENT_W = 538 }
	UI.NewPage = function(title)
		page = { title = title, y = -58, Add = function(self, height) self.y = self.y - height end }
		return page
	end
	UI.DBToggle = function(_, _, _, _, key) toggles[key] = true; return {}, 40 end
	UI.Slider = function(_, _, _, key, min, max) sliders[key] = { min = min, max = max }; return {}, 46 end
	ns.optionPages[3](UI)
	wb.expect("page name", page.title, "Reagents")
	for _, key in ipairs({ "totemItems", "ankhs", "fishOil", "fishScales" }) do
		wb.check(toggles[key], "toggle for " .. key)
	end
	wb.expect("Ankh range unchanged", sliders.ankhLow.max, 10)
	for _, key in ipairs({ "fishOilLow", "fishScalesLow" }) do
		wb.expect(key .. " minimum", sliders[key].min, 0)
		wb.expect(key .. " maximum", sliders[key].max, 20)
	end
	wb.check(-page.y <= 494, "reagent controls fit above footer")
end
