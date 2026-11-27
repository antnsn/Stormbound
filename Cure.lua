-- Cure (LibBound Cleanse.lua): group members carrying a debuff you can remove, one click each
-- (Cure Poison on a click and Cure Disease on a right-click), plus a mouseover key for each. The frame, the options page and
-- `/storm ignore` are LibBound's.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")
local D = ns.DATA

Bound.InstallCleanse(ns, {
	title = "Cure",
	page = false, -- Options.lua puts it after its own pages
	buttons = {
		{ list = D.curePoison, types = { Poison = true } },
		{ list = D.cureDisease, types = { Disease = true } },
	},
})
