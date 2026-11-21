--@moods: low recall waters
local T = dofile(wb.dir .. "/tests/_shaman.lua")
local known = wb.mood ~= "low"
T.shaman(wb.mood == "waters" and { 556, 131, 546 } or (known and { 556 } or {}))
wb.state.bags[6948] = 1
wb.login()
wb.advance(2)
wb.openGameMenu()
wb.expect("panel with the menu", wb.shown("StormboundTravel"), true)
local row = wb.ns.TravelRows()[1]
wb.expect("Astral Recall known", row.known, known)
local b = wb.frame("StormboundTravelButton1")
wb.expect("button casts it when known", b:GetAttribute("spell"), known and 556 or nil)
if wb.mood == "low" then wb.expect("greyed with its level", b.sub:GetText(), "level 30") end
local labels = {}
for _, r in ipairs(wb.ns.TravelRows()) do labels[#labels + 1] = r.label end
wb.expect("only Astral Recall in spell rows", table.concat(labels, ", "), "Astral Recall")
wb.expect("Hearthstone stays available", wb.shown("StormboundTravelHearth"), true)
wb.expect("Hearthstone button uses the item", wb.frame("StormboundTravelHearth"):GetAttribute("item"), "item:6948")
wb.ns.db.travel = false
wb.ns.Refresh()
wb.expect("travel toggle still hides the panel", wb.shown("StormboundTravel"), false)
