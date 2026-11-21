--@moods: shaman mage
local T = dofile(wb.dir .. "/tests/_shaman.lua")
if wb.mood == "shaman" then
	T.shaman({ 324, 8017, 8071 })
	wb.login()
	wb.advance(7)
	wb.slash("/storm")
	wb.check(wb.shown("StormboundOptions"), "/storm opens the options")
	local titles = {}
	for _, p in ipairs(wb.ns.optionsState.pages) do titles[#titles + 1] = p.title end
	wb.expect("pages", table.concat(titles, ", "), "Totems, Shield & imbue, Reagents, Travel, Extras, Skin")
	wb.slash("/stormunlock")
	wb.expect("space-free alias unlocks", wb.ns.unlocked, true)
	wb.slash("/storm lock")
else
	wb.state.player.classFile, wb.state.player.class = "MAGE", "Mage"
	wb.login()
	wb.slash("/storm")
	wb.check(wb.printed("only does something on a shaman"), "a mage is told why")
	wb.check(wb.printed("%[addon%] disabled Stormbound"), "unticked for this character")
end
