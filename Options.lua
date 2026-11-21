-- Stormbound's option pages; LibBound adds Extras (Well Rested, Well Fed, explanations, minimap)
-- and Skin, and builds the window.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")

local function TotemPage(UI)
	local p = UI.NewPage("Totems", "One button per element: the totem that stands and its time left.")
	local W = UI.CONTENT_W
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "totems", "Show the totem bar",
		"Left-click drops the last totem of that element again, right-click removes it.")) + 6)
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "totemTimers", "Time left on each button")) + 10)
	p:Add(UI.Section(p, p.y, "What each button drops") + 2)
	for _, e in ipairs(ns.TOTEM_ELEMENTS) do
		-- the list is refilled each time the window opens (before the selector syncs), so totems
		-- learned or lost since are right
		local values = {}
		local function Fill()
			for i = #values, 1, -1 do values[i] = nil end
			values[1] = "Last used"
			for _, n in ipairs(ns.KnownTotems(e.key)) do values[#values + 1] = n end
		end
		Fill()
		UI.Syncer(Fill)
		p:Add(select(2, UI.Cycle(p, p.y, e.label, values,
			function() return ns.db.totemChoice[e.key] or "Last used" end,
			function(v) ns.db.totemChoice[e.key] = (v ~= "Last used") and v or nil end,
			function() return #values == 1 and "No " .. e.label:lower() .. " totem learned yet." or nil end)) + 2)
	end
	p:Add(6)
	p:Add(UI.Note(p, p.y, "Tip: the mouse wheel over a totem button picks its totem too. Unlock the frames (footer) to move the bar."))
end

local function ShieldPage(UI)
	local p = UI.NewPage("Shield & imbue", "Your shield and your weapon imbue. Click a card to cast (out of combat).")
	local W = UI.CONTENT_W
	p:Add(UI.Section(p, p.y - 4, "Shield"))
	p:Add(select(2, UI.Cycle(p, p.y, "Shield to track", ns.SHIELD_TRACK_CHOICES,
		function() return ns.db.shieldTrack end,
		function(v) ns.db.shieldTrack = v; ns.UpdateBuffTimers() end)) - 8)
	p:Add(select(2, UI.Cycle(p, p.y, "Shield to cast", ns.SHIELD_CHOICES,
		function() return ns.db.shieldChoice end,
		function(v) ns.db.shieldChoice = v; ns.UpdateBuffTimers() end,
		function()
			local s = ns.ShieldSpell()
			return s and ("Now: " .. s) or (ns.ShieldLabel() .. " isn't learned yet.")
		end)) + 2)
	local third = math.floor(W / 3)
	UI.DBToggle(p, 0, p.y, third, "shield", "Show")
	UI.DBToggle(p, third, p.y, third, "shieldSound", "Sound")
	UI.DBToggle(p, third * 2, p.y, third, "shieldKeep", "When missing", nil, function() ns.UpdateBuffTimers() end)
	p:Add(32)
	p:Add(select(2, UI.Slider(p, p.y, "Warn with time left", "shieldMinutes", 1, 10, 1, " min")) + 2)
	p:Add(UI.Section(p, p.y - 4, "Weapon imbue"))
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "imbue", "Show main-hand imbue reminders")))
	p:Add(select(2, UI.Cycle(p, p.y, "Imbue to track", ns.IMBUE_TRACK_CHOICES,
		function() return ns.db.imbueTrack end,
		function(v) ns.db.imbueTrack = v end)) - 8)
	p:Add(select(2, UI.Cycle(p, p.y, "Imbue to cast", ns.IMBUE_CHOICES,
		function() return ns.db.imbueChoice end,
		function(v) ns.db.imbueChoice = v end,
		function()
			local s = ns.ImbueSpell()
			return s and ("Now: " .. s) or "No imbue learned yet (Rockbiter comes at level 1)."
		end)) + 2)
	p:Add(select(2, UI.Slider(p, p.y, "Warn with time left", "imbueMinutes", 1, 5, 1, " min")) + 2)
end

local function ReagentPage(UI)
	local p = UI.NewPage("Reagents", "Choose which items to track in your bags.")
	local W = UI.CONTENT_W
	p:Add(select(2, UI.DBToggle(p, 0, p.y, W, "totemItems", "Warn when a totem item is missing",
		"Earth, Fire, Water and Air Totem: without one, that element's totems can't be dropped.")) + 8)
	for _, r in ipairs(ns.REAGENT_TRACKERS) do
		p:Add(select(2, UI.DBToggle(p, 0, p.y, W, r.key, "Track " .. r.label,
			"For " .. r.spellName .. ", once learned.")) + 6)
		p:Add(select(2, UI.Slider(p, p.y, r.label .. ": warn at", r.low, 0, r.max, 1, " left")) + 8)
	end
end

local function TravelPage(UI)
	local p = UI.NewPage("Travel", "Astral Recall and your Hearthstone beside the game menu (Escape).")
	p:Add(select(2, UI.DBToggle(p, 0, p.y, UI.CONTENT_W, "travel", "Show the travel panel when the game menu opens")) + 8)
end

ns.optionPages[#ns.optionPages + 1] = TotemPage
ns.optionPages[#ns.optionPages + 1] = ShieldPage
ns.optionPages[#ns.optionPages + 1] = ReagentPage
ns.optionPages[#ns.optionPages + 1] = TravelPage
Bound.InstallOptions(ns, { header = "Shaman helper", launcher = "Shaman helper: totems, shield, imbue, reagents." })
