-- Stormbound's look, "Storm": dark slate storm-cloud panels, an electric blue edge, lightning forks
-- in the corners, a cool white rim that pulses slowly like distant lightning while a card needs
-- you. LibBound derives the Blizzard and Flat skins from it. Textures: tools/make_media.py.
local _, ns = ...
if ns.disabled then return end
local Bound = LibStub("LibBound-1.0")
local F = Bound.FONTS

local storm = {
	name = "Storm",
	font = { ui = F.friz, title = F.friz, narrow = F.arialn, card = F.morpheus },
	color = {
		bg = { 0, 0, 0, 0 },
		side = { 0.02, 0.02, 0.05, 0.40 },
		header = { 0.02, 0.02, 0.05, 0.35 },
		border = { 0.38, 0.46, 0.78, 0.9 },
		hover = { 0.14, 0.16, 0.30, 1 },
		selected = { 0.12, 0.14, 0.27, 1 },
		text = { 0.91, 0.93, 1.00 },
		dim = { 0.64, 0.67, 0.78 },
		accent = { 0.62, 0.74, 1.00 },
		track = { 0.10, 0.11, 0.20, 1 },
		button = { 0.06, 0.07, 0.11, 1 },
		navGlow = { 0.50, 0.62, 1, 0.65 },
		row = { 0.08, 0.09, 0.15, 0.8 },
		rowWarn = { 0.40, 0.30, 0.05, 0.5 },
		rowBad = { 0.45, 0.08, 0.10, 0.55 },
		highlight = { 0.78, 0.84, 1, 0.08 },
		cell = { 0.09, 0.10, 0.15, 0.85 },
		cdText = { 0.88, 0.92, 1 },
		glow = { 0.60, 0.72, 1 },
		gridLine = { 0.78, 0.84, 1, 0.08 },
		gridCentre = { 0.50, 0.62, 1, 0.45 },
	},
	box = {
		backdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 14,
			insets = { left = 3, right = 3, top = 3, bottom = 3 },
		},
		bg = { 0.05, 0.06, 0.10 },
		border = { 0.55, 0.65, 1, 1 },
	},
	dialog = {
		backdrop = {
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 32, edgeSize = 32,
			insets = { left = 11, right = 11, top = 12, bottom = 11 },
		},
		outset = 10,
		border = { 0.70, 0.76, 1, 1 },
		under = { 0.03, 0.035, 0.06, 1 },
		plate = false,
	},
	tex = Bound.STOCK_TEX,
	card = {
		panel = { 0.07, 0.08, 0.12, 0.94 },
		gilt = { 0.42, 0.50, 0.86, 1 },
		giltFaint = { 0.28, 0.33, 0.58, 0.9 },
		light = { 0.78, 0.84, 1, 0.07 },
		rays = { 0.82, 0.88, 1 },
		raysFaded = { 0.56, 0.58, 0.66 },
		title = { 0.78, 0.85, 1 },
		status = { 0.86, 0.89, 0.97 },
		urgent = { 1, 0.62, 0.42 },
		glowEdge = { 0.85, 0.90, 1, 1 },
		iconEdge = { 0.62, 0.74, 1, 0.9 },
		frost = "Cloud", frostTint = { 0.62, 0.68, 0.90, 0.16 },
		crest = "Crest", crestTint = { 0.62, 0.74, 1, 0.18 },
		shards = "Fork", shardTint = { 0.86, 0.92, 1, 0.95 },
		rim = "Rim", breathe = true, breatheTime = 3.4,
		burst = false, studs = false, ring = false, round = false,
	},
	widgets = "blizzard",
}

Bound.InstallSkin(ns, {
	skins = { storm = storm },
	order = { "storm", "blizzard", "flat" },
	default = "storm",
	about = { storm = "Slate storm clouds, an electric edge and lightning in the corners." },
})
Bound.InstallBuffTimers(ns)
Bound.InstallMinimap(ns)
