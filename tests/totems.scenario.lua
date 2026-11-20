--@moods: fresh drop secret expire choice
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local m = wb.mood
T.shaman(m == "fresh" and {} or { 8071, 3599, 8075, 5730 })
if m == "secret" then wb.state.secretTotems = true end
wb.login()
wb.advance(2)
if m == "fresh" then
	wb.expect("no bar before any totem is learned", wb.shown("StormboundTotems"), false)
	return
end
wb.expect("the bar shows once totems are learned", wb.shown("StormboundTotems"), true)
local earth = wb.frame("StormboundTotem1") -- Earth is the first button
wb.expect("right-click removes", earth:GetAttribute("type2"), "destroytotem")
wb.expect("for the earth slot", earth:GetAttribute("totem-slot"), 2)
wb.expect("nothing to recast yet", earth:GetAttribute("spell1"), nil)
wb.dropTotem(2, "Stoneskin Totem", 120)
wb.advance(1)
wb.expect("remembered for left-click", earth:GetAttribute("spell1"), "Stoneskin Totem")
wb.expect("as a spell", earth:GetAttribute("type1"), "spell")
wb.expect("time left on the button", earth.timer:GetText(), "2m")
if m == "secret" then
	wb.combat(true)
	wb.dropTotem(1, "Searing Totem", 55)
	wb.advance(1)
	local fire = wb.frame("StormboundTotem2")
	wb.expect("hidden data in combat: no timer", fire.timer:GetText(), "")
	wb.expect("and the click spell waits for the fight to end", fire:GetAttribute("spell1"), nil)
	wb.state.secretTotems = false -- readable again once the fight ends (no new drop)
	wb.combat(false)
	wb.advance(1)
	wb.expect("learned once it can be read", fire:GetAttribute("spell1"), "Searing Totem")
	-- a fight starting while the bar is being dragged: no move in combat
	wb.slash("/storm unlock")
	local bar = wb.frame("StormboundTotems")
	wb.ns.BeginDrag(bar, "tbPoint")
	wb.combat(true)
	wb.advance(1)
	wb.combat(false)
	wb.slash("/storm lock")
end
if m == "expire" then
	wb.advance(115)
	wb.expect("last seconds", tonumber(earth.timer:GetText()) <= 10, true)
	wb.advance(10)
	wb.expect("gone: no timer", earth.timer:GetText(), "")
	wb.expect("faded", earth.icon.__desaturated or earth.icon:GetAlpha() < 1, true)
	wb.expect("still recasts it", earth:GetAttribute("spell1"), "Stoneskin Totem")
end

if m == "choice" then
	-- pick Strength of Earth with the mouse wheel: the button drops it instead of the last one
	earth.__scripts.OnMouseWheel(earth, -1) -- "last used" -> first known
	earth.__scripts.OnMouseWheel(earth, -1) -- -> second known
	local known = wb.ns.KnownTotems("earth")
	wb.expect("earth totems known", table.concat(known, ", "), "Stoneskin Totem, Strength of Earth Totem, Stoneclaw Totem")
	wb.expect("the wheel picks", wb.saved("StormboundDB").totemChoice.earth, "Strength of Earth Totem")
	wb.expect("the button drops the pick", earth:GetAttribute("spell1"), "Strength of Earth Totem")
	wb.dropTotem(2, "Stoneclaw Totem", 15)
	wb.advance(1)
	wb.expect("a different totem dropped by hand doesn't change the pick", earth:GetAttribute("spell1"), "Strength of Earth Totem")
	for _ = 1, 2 do earth.__scripts.OnMouseWheel(earth, -1) end -- Stoneclaw, then around to "last used"
	wb.expect("back to last used", wb.saved("StormboundDB").totemChoice.earth, nil)
	wb.expect("the button drops the last one again", earth:GetAttribute("spell1"), "Stoneclaw Totem")
	wb.combat(true)
	earth.__scripts.OnMouseWheel(earth, -1)
	wb.expect("no changes in combat", wb.saved("StormboundDB").totemChoice.earth, nil)
	wb.combat(false)
end
if m == "choice" then
	-- the options' totem list follows what is learned, without a reload
	wb.slash("/storm")
	wb.slash("/storm")
	wb.state.spells[8143] = "Tremor Totem"
	wb.fire("SPELLS_CHANGED")
	wb.slash("/storm") -- reopen
	local found = false
	for _, c in ipairs(wb.ns.optionsState.controls) do
		if c.Sync and c.GetText then
			local t = c.__text or ""
			if t:find("Last used", 1, true) or t:find("Totem", 1, true) then found = true end
		end
	end
	wb.check(found, "the totem selectors are there")
	local list = {}
	for _, n in ipairs(wb.ns.KnownTotems("earth")) do list[#list + 1] = n end
	wb.check(table.concat(list, ","):find("Tremor Totem", 1, true), "a newly learned totem is known")
end
