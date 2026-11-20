--@moods: low recall
local T = dofile(wb.dir .. "/tests/_shaman.lua")
T.shaman(wb.mood == "recall" and { 556 } or {})
wb.state.bags[6948] = 1
wb.login()
wb.advance(2)
wb.openGameMenu()
wb.expect("panel with the menu", wb.shown("StormboundTravel"), true)
local row = wb.ns.TravelRows()[1]
wb.expect("Astral Recall known", row.known, wb.mood == "recall")
local b = wb.frame("StormboundTravelButton1")
wb.expect("button casts it when known", b:GetAttribute("spell"), wb.mood == "recall" and 556 or nil)
if wb.mood == "low" then wb.expect("greyed with its level", b.sub:GetText(), "level 30") end
local labels = {}
for _, r in ipairs(wb.ns.TravelRows()) do labels[#labels + 1] = r.label end
wb.expect("water spells in the panel too", table.concat(labels, ", "), "Astral Recall, Water Breathing, Water Walking")
