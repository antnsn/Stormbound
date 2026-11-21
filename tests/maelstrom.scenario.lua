--@moods: none one four five transitions combat disabled unknown errors localized unlocked options
local T = dofile(wb.dir .. "/tests/_shaman.lua")
T.shaman({})
local m = wb.mood
wb.login({ saved = { StormboundDB = { maelstrom = m ~= "disabled" } } })
wb.advance(1)
local ns = wb.ns
local card = wb.frame("StormboundMaelstromFrame")
local function set(stacks, name)
	wb.setAuras(stacks > 0 and { wb.aura(name or "Maelstrom Weapon", 408505, 30, stacks) } or {})
end
local function shown() return wb.shown("StormboundMaelstromFrame") end
local function blink()
	wb.expect("starts fully visible", card:GetAlpha(), 1)
	wb.advance(0.5)
	wb.expect("dims after half a second", card:GetAlpha(), 0.25)
	wb.advance(0.5)
	wb.expect("bright again after one second", card:GetAlpha(), 1)
end

if m == "none" then
	wb.expect("no card without stacks", shown(), false)
	wb.expect("missing aura means zero", ns.MaelstromStacks(), 0)
elseif m == "one" or m == "four" then
	local stacks = m == "one" and 1 or 4
	set(stacks)
	wb.expect("partial stacks visible", shown(), true)
	wb.expect("exact count", card.statusText:GetText(), stacks .. "/5 stacks")
	wb.advance(0.5)
	wb.expect("partial stacks do not blink", card:GetAlpha(), 1)
	wb.expect("partial stacks do not glow", card:IsGlowing(), false)
elseif m == "five" or m == "combat" then
	if m == "combat" then wb.combat(true) end
	set(5)
	wb.expect("full stacks visible, including combat", shown(), true)
	wb.expect("ready status", card.statusText:GetText(), "5/5 stacks - ready!")
	wb.expect("ready glow", card:IsGlowing(), true)
	blink()
	wb.check(not T.macroFor("Maelstrom Weapon"), "indicator does not cast or enter buff key queue")
elseif m == "transitions" then
	for stacks = 1, 5 do set(stacks); wb.expect("live stack update", ns.MaelstromStacks(), stacks) end
	wb.advance(0.5)
	wb.expect("full stack dims", card:GetAlpha(), 0.25)
	set(5)
	wb.expect("unrelated aura updates do not reset blink", card:GetAlpha(), 0.25)
	set(4)
	wb.expect("dropping below five resets opacity", card:GetAlpha(), 1)
	wb.advance(0.5)
	wb.expect("no blinking below five", card:GetAlpha(), 1)
	set(5)
	wb.advance(0.5)
	set(0)
	wb.expect("consumed stacks hide card", shown(), false)
	wb.expect("consuming stacks resets opacity", card:GetAlpha(), 1)
	set(5)
	ns.db.maelstrom = false
	ns.Refresh()
	wb.expect("disabling clears ready alert", shown(), false)
	ns.db.maelstrom = true
	ns.Refresh()
	wb.expect("reenabling picks up current buff", shown(), true)
elseif m == "disabled" then
	set(5)
	wb.expect("disabled tracker stays hidden at five", shown(), false)
	wb.expect("disabled tracker does not glow", card:IsGlowing(), false)
elseif m == "unknown" then
	set(5)
	local original, isSecret = C_UnitAuras.GetAuraDataByIndex, ns.IsSecret
	local secret = {}
	ns.IsSecret = function(value) return value == secret or isSecret(value) end
	C_UnitAuras.GetAuraDataByIndex = function() return { spellId = 408505, applications = secret } end
	ns.Refresh()
	wb.expect("secret count is unknown", ns.MaelstromStacks(), nil)
	wb.expect("secret count clears stale ready card", shown(), false)
	wb.expect("secret count resets blink", card:GetAlpha(), 1)
	C_UnitAuras.GetAuraDataByIndex = function(_, index)
		if index == 1 then return { spellId = secret, applications = 5 } end
	end
	ns.Refresh()
	wb.expect("secret identity does not claim five stacks", shown(), false)
	C_UnitAuras.GetAuraDataByIndex = function() return { spellId = 408505 } end
	ns.Refresh()
	wb.expect("missing count stays hidden", shown(), false)
	C_UnitAuras.GetAuraDataByIndex, ns.IsSecret = original, isSecret
	ns.Refresh()
	wb.expect("recovers when readable", shown(), true)
elseif m == "errors" then
	set(5)
	local original, printOriginal = C_UnitAuras.GetAuraDataByIndex, ns.Print
	local errors = 0
	ns.Print = function(message)
		if message:find("Couldn't read Maelstrom Weapon stacks", 1, true) then errors = errors + 1 end
	end
	C_UnitAuras.GetAuraDataByIndex = function() error("test aura failure") end
	ns.Refresh(); ns.Refresh()
	wb.expect("read failures clear card", shown(), false)
	wb.expect("read failure reported without spam", errors, 1)
	C_UnitAuras.GetAuraDataByIndex = original
	ns.Refresh()
	wb.expect("recovers after API error", shown(), true)
	ns.Print = printOriginal
elseif m == "localized" then
	wb.setAuras({ wb.aura("Water Shield", 408510, 600, 3), wb.aura("Arme du Maelstrom", 408505, 30, 5) })
	wb.expect("finds localized aura by confirmed ID", shown(), true)
	wb.expect("unrelated buff stacks ignored", ns.MaelstromStacks(), 5)
elseif m == "unlocked" then
	ns.db.maelstrom = false
	ns.unlocked = true
	ns.Refresh()
	wb.expect("movable preview despite disabled tracker", shown(), true)
	wb.expect("preview stack count", card.statusText:GetText(), "3/5 stacks")
	wb.advance(0.5)
	wb.expect("preview never blinks", card:GetAlpha(), 1)
	ns.unlocked = false
	ns.Refresh()
	wb.expect("locking returns to disabled state", shown(), false)
	wb.check(ns.defaults.mwPoint, "saved position available")
elseif m == "options" then
	local page, toggle
	local UI = { CONTENT_W = 538 }
	UI.NewPage = function(title)
		page = { title = title, y = -58, Add = function(self, height) self.y = self.y - height end }
		return page
	end
	UI.DBToggle = function(_, _, _, _, key) toggle = key; return {}, 40 end
	UI.Note = function() return 50 end
	ns.optionPages[5](UI)
	wb.expect("Maelstrom settings page", page.title, "Maelstrom")
	wb.expect("toggle controls tracker", toggle, "maelstrom")
	wb.expect("enabled by default", ns.defaults.maelstrom, true)
	wb.check(-page.y <= 494, "settings fit above footer")
end
