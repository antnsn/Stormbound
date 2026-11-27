--@moods: first second none keys
-- Cure (LibBound Cleanse.lua): a group member with a debuff this class removes gets a row that
-- casts on them, a key per spell. The stand-in client has no SecureGroupHeader: the frame is the list.
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local m = wb.mood
local known = { 526, 2870 }
if m == "none" then known = {} end
T.shaman(known)
local s = wb.state
wb.login()
local G = wb.G
local bound = {}
G.SetOverrideBindingClick = function(owner, prio, key, button) bound[key] = button end
G.ClearOverrideBindings = function() bound = {} end
wb.join({ { unit = "party1", name = "Friend", classFile = "WARRIOR" } })
local second = { name = "Bad Disease", spellId = 222, dispelName = "Disease", icon = 136127 }
s.auras.party1 = { (m == "second" or m == "abolish") and second or { name = "Bad Poison", spellId = 111, dispelName = "Poison", icon = 136207 } }
wb.fire("UNIT_AURA", "party1")
wb.advance(2)
if m == "none" then
	wb.check(not wb.shown("StormboundCleanseFrame"), "no spell to remove debuffs yet: no frame")
	return
end
local row = wb.frame("StormboundCleanseRow1")
wb.check(row ~= nil and row.data ~= nil, "the afflicted member gets a row")
wb.expect("on them", row:GetAttribute("unit"), "party1")
wb.expect("left click: Cure Poison", row:GetAttribute("spell1"), "Cure Poison")
if m == "first" then
	wb.expect("as a spell", row:GetAttribute("type1"), "spell")
elseif m == "second" or m == "abolish" then
	wb.expect("right click: the Cure Disease", row:GetAttribute("spell2"), m == "abolish" and "" or "Cure Disease")
	wb.check(row.data.names[1]:find("right%-click") ~= nil, "the tooltip says right-click: " .. row.data.names[1])
elseif m == "keys" then
	wb.ns.db.clKey, wb.ns.db.clKey2 = "F", "G"
	wb.ns.ApplyCleanseKey()
	wb.expect("F: the first key", bound.F, "StormboundCleanseKeyButton")
	wb.expect("G: the second key", bound.G, "StormboundCleanseKeyButton2")
	wb.expect("which casts on the mouseover", wb.frame("StormboundCleanseKeyButton"):GetAttribute("macrotext"),
		"/cast [@mouseover,help,nodead][help,nodead] Cure Poison")
	wb.slash("/storm")
	local page
	for _, p in ipairs(wb.ns.optionsState.pages) do if p.title == "Cure" then page = p.frame end end
	wb.check(page and -page.cleanseBottom <= page:GetHeight(), "the Cure page fits: " .. tostring(page and page.cleanseBottom))
	wb.slash("/storm ignore Bad Poison")
	wb.check(wb.ns.db.clIgnore["bad poison"], "/storm ignore keeps a debuff name")
end
