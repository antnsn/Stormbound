-- luacheck config: run "luacheck ." from this folder (Lua 5.1, like the WoW client).
-- The real API list is wowbench's (wowbench check .); this one only lists what Chronobound uses.
std = "lua51"
max_line_length = false
ignore = { "212", "432" }
exclude_files = { "Libs/", "tests/", "tools/" }
read_globals = {
	"C_Item", "C_Spell", "C_UnitAuras", "CreateFrame", "GameMenuFrame", "GameTooltip", "GetBindLocation", "HideUIPanel",
	"AIR_TOTEM_SLOT", "EARTH_TOTEM_SLOT", "FIRE_TOTEM_SLOT", "WATER_TOTEM_SLOT", "GetTotemInfo", "GetWeaponEnchantInfo", "GetInventoryItemID", "GetTime", "C_Timer", "InCombatLockdown", "IsPlayerSpell", "LibStub", "UIParent",
}
