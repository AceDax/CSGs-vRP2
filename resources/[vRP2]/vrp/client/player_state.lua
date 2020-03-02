if not vRP.modules.player_state then return end

local PlayerState = class("PlayerState", vRP.Extension)

-- STATIC

PlayerState.weapon_components = {
	"COMPONENT_AT_PI_FLSH_02",
	"COMPONENT_AT_AR_FLSH",
	"COMPONENT_AT_PI_FLSH",
	"COMPONENT_AT_AR_FLSH",
	"COMPONENT_AT_PI_FLSH_03",
  "COMPONENT_AT_PI_SUPP",
	"COMPONENT_AT_PI_SUPP_02",
	"COMPONENT_AT_AR_SUPP",
	"COMPONENT_AT_AR_SUPP_02",
	"COMPONENT_AT_SR_SUPP",
  "COMPONENT_AT_SR_SUPP_03",
  "COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE",
  "COMPONENT_CARBINERIFLE_VARMOD_LUXE",
  "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE",
  "COMPONENT_MICROSMG_VARMOD_LUXE",
  "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE",
  "COMPONENT_SNIPERRIFLE_VARMOD_LUXE",
  "COMPONENT_PISTOL_VARMOD_LUXE",
  "COMPONENT_PISTOL50_VARMOD_LUXE",
  "COMPONENT_APPISTOL_VARMOD_LUXE",
  "COMPONENT_HEAVYPISTOL_VARMOD_LUXE",
  "COMPONENT_SMG_VARMOD_LUXE",
  "COMPONENT_MARKSMANRIFLE_VARMOD_LUXE",
  "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER",
  "COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER",
  "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER",
  "COMPONENT_MG_COMBATMG_LOWRIDER",
  "COMPONENT_BULLPUPRIFLE_VARMOD_LOWRIDER",
  "COMPONENT_MG_VARMOD_LOWRIDER",
  "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER",
  "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER",
  "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
  "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02",
  "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
  "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
  "COMPONENT_HEAVYSNIPER_MK2_CLIP_02",
  "COMPONENT_COMBATMG_MK2_CLIP_02",
  "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
  "COMPONENT_SMG_MK2_CLIP_02",
  "COMPONENT_PISTOL_MK2_CLIP_02",
  "COMPONENT_PISTOL_CLIP_02",
  "COMPONENT_ASSAULTSHOTGUN_CLIP_02",
  "COMPONENT_HEAVYSHOTGUN_CLIP_02",
  "COMPONENT_PISTOL50_CLIP_02",
  "COMPONENT_COMBATPISTOL_CLIP_02",
  "COMPONENT_APPISTOL_CLIP_02",
  "COMPONENT_COMBATPDW_CLIP_02",
  "COMPONENT_SNSPISTOL_CLIP_02",
  "COMPONENT_SNSPISTOL_MK2_CLIP_02",
  "COMPONENT_ASSAULTRIFLE_CLIP_02",
  "COMPONENT_COMBATMG_CLIP_02",
  "COMPONENT_MG_CLIP_02",
  "COMPONENT_ASSAULTSMG_CLIP_02",
  "COMPONENT_GUSENBERG_CLIP_02",
  "COMPONENT_MICROSMG_CLIP_02",
  "COMPONENT_BULLPUPRIFLE_CLIP_02",
  "COMPONENT_COMPACTRIFLE_CLIP_02",
  "COMPONENT_HEAVYPISTOL_CLIP_02",
  "COMPONENT_VINTAGEPISTOL_CLIP_02",
  "COMPONENT_CARBINERIFLE_CLIP_02",
  "COMPONENT_ADVANCEDRIFLE_CLIP_02",
  "COMPONENT_MARKSMANRIFLE_CLIP_02",
  "COMPONENT_SMG_CLIP_02",
  "COMPONENT_SPECIALCARBINE_CLIP_02",
  "COMPONENT_SPECIALCARBINE_CLIP_03",
  "COMPONENT_COMPACTRIFLE_CLIP_03",
  "COMPONENT_COMBATPDW_CLIP_03",
  "COMPONENT_ASSAULTRIFLE_CLIP_03",
  "COMPONENT_HEAVYSHOTGUN_CLIP_03",
  "COMPONENT_CARBINERIFLE_CLIP_03",
  "COMPONENT_SMG_CLIP_03",
  "COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER",
  "COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY",
  "COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ",
  "COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER",
  "COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY",
  "COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ",
  "COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER",
  "COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY",
  "COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ",
  "COMPONENT_PISTOL_MK2_CLIP_TRACER",
  "COMPONENT_PISTOL_MK2_CLIP_INCENDIARY",
  "COMPONENT_PISTOL_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_PISTOL_MK2_CLIP_FMJ",
  "COMPONENT_PUMPSHOTGUN_MK2_CLIP_TRACER",
  "COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY",
  "COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT",
  "COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE",
  "COMPONENT_SNSPISTOL_MK2_CLIP_TRACER",
  "COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY",
  "COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT",
  "COMPONENT_SNSPISTOL_MK2_CLIP_FMJ",
  "COMPONENT_REVOLVER_MK2_CLIP_TRACER",
  "COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY",
  "COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT",
  "COMPONENT_REVOLVER_MK2_CLIP_FMJ",
  "COMPONENT_SMG_MK2_CLIP_TRACER",
  "COMPONENT_SMG_MK2_CLIP_INCENDIARY",
  "COMPONENT_SMG_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_SMG_MK2_CLIP_FMJ",
  "COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER",
  "COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER",
  "COMPONENT_COMBATMG_MK2_CLIP_TRACER",
  "COMPONENT_HEAVYSNIPER_MK2_CLIP_TRACER",
  "COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY",
  "COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY",
  "COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY",
  "COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY",
  "COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING",
  "COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ",
  "COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ",
  "COMPONENT_COMBATMG_MK2_CLIP_FMJ",
  "COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ",
  "COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE",
  "COMPONENT_AT_PI_FLSH_02",
  "COMPONENT_AT_AR_FLSH",
  "COMPONENT_AT_PI_FLSH",
  "COMPONENT_AT_AR_FLSH",
  "COMPONENT_AT_PI_FLSH_03",
  "COMPONENT_AT_PI_SUPP",
  "COMPONENT_AT_PI_SUPP_02",
  "COMPONENT_AT_AR_SUPP",
  "COMPONENT_AT_AR_SUPP_02",
  "COMPONENT_AT_SR_SUPP",
  "COMPONENT_AT_SR_SUPP_03",
  "COMPONENT_AT_PI_COMP",
  "COMPONENT_AT_PI_COMP_02",
  "COMPONENT_AT_PI_COMP_03",
  "COMPONENT_AT_MRFL_BARREL_01",
  "COMPONENT_AT_MRFL_BARREL_02",
  "COMPONENT_AT_SR_BARREL_01",
  "COMPONENT_AT_BP_BARREL_01",
  "COMPONENT_AT_BP_BARREL_02",
  "COMPONENT_AT_SC_BARREL_01",
  "COMPONENT_AT_SC_BARREL_02",
  "COMPONENT_AT_AR_BARREL_01",
  "COMPONENT_AT_SB_BARREL_01",
  "COMPONENT_AT_CR_BARREL_01",
  "COMPONENT_AT_MG_BARREL_01",
  "COMPONENT_AT_MG_BARREL_02",
  "COMPONENT_AT_CR_BARREL_02",
  "COMPONENT_AT_SR_BARREL_02",
  "COMPONENT_AT_SB_BARREL_02",
  "COMPONENT_AT_AR_BARREL_02",
  "COMPONENT_AT_MUZZLE_01",
  "COMPONENT_AT_MUZZLE_02",
  "COMPONENT_AT_MUZZLE_03",
  "COMPONENT_AT_MUZZLE_04",
  "COMPONENT_AT_MUZZLE_05",
  "COMPONENT_AT_MUZZLE_06",
  "COMPONENT_AT_MUZZLE_07",
  "COMPONENT_AT_AR_AFGRIP",
  "COMPONENT_AT_AR_AFGRIP_02",
  "COMPONENT_AT_PI_RAIL",
  "COMPONENT_AT_SCOPE_MACRO_MK2",
  "COMPONENT_AT_PI_RAIL_02",
  "COMPONENT_AT_SIGHTS_SMG",
  "COMPONENT_AT_SIGHTS",
  "COMPONENT_AT_SCOPE_SMALL",
  "COMPONENT_AT_SCOPE_SMALL_02",
  "COMPONENT_AT_SCOPE_MACRO_02",
  "COMPONENT_AT_SCOPE_SMALL_02",
  "COMPONENT_AT_SCOPE_MACRO",
  "COMPONENT_AT_SCOPE_MEDIUM",
  "COMPONENT_AT_SCOPE_LARGE",
  "COMPONENT_AT_SCOPE_SMALL",
  "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
  "COMPONENT_AT_SCOPE_SMALL_MK2",
  "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
  "COMPONENT_AT_SCOPE_MEDIUM_MK2",
  "COMPONENT_AT_SCOPE_MAX",
  "COMPONENT_AT_SCOPE_LARGE",
  "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2",
  "COMPONENT_AT_SCOPE_LARGE_MK2",
  "COMPONENT_AT_SCOPE_NV",
  "COMPONENT_AT_SCOPE_THERMAL",
  "COMPONENT_KNUCKLE_VARMOD_PLAYER",
  "COMPONENT_KNUCKLE_VARMOD_LOVE",
  "COMPONENT_KNUCKLE_VARMOD_DOLLAR",
  "COMPONENT_KNUCKLE_VARMOD_VAGOS",
  "COMPONENT_KNUCKLE_VARMOD_HATE",
  "COMPONENT_KNUCKLE_VARMOD_DIAMOND",
  "COMPONENT_KNUCKLE_VARMOD_PIMP",
  "COMPONENT_KNUCKLE_VARMOD_KING",
  "COMPONENT_KNUCKLE_VARMOD_BALLAS",
  "COMPONENT_KNUCKLE_VARMOD_BASE",
  "COMPONENT_SWITCHBLADE_VARMOD_VAR1",
  "COMPONENT_SWITCHBLADE_VARMOD_VAR2",
  "COMPONENT_SWITCHBLADE_VARMOD_BASE",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_02",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_03",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_04",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_05",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_06",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_07",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_08",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_09",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_10",
  "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_IND_01",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_02",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_03",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_04",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_05",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_06",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_07",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_08",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_09",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_10",
  "COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_02",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_03",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_04",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_05",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_06",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_07",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_08",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_09",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_10",
  "COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01",
  "COMPONENT_REVOLVER_MK2_CAMO",
  "COMPONENT_REVOLVER_MK2_CAMO_02",
  "COMPONENT_REVOLVER_MK2_CAMO_03",
  "COMPONENT_REVOLVER_MK2_CAMO_04",
  "COMPONENT_REVOLVER_MK2_CAMO_05",
  "COMPONENT_REVOLVER_MK2_CAMO_06",
  "COMPONENT_REVOLVER_MK2_CAMO_07",
  "COMPONENT_REVOLVER_MK2_CAMO_08",
  "COMPONENT_REVOLVER_MK2_CAMO_09",
  "COMPONENT_REVOLVER_MK2_CAMO_10",
  "COMPONENT_REVOLVER_MK2_CAMO_IND_01",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_02",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_03",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_04",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_05",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_06",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_07",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_08",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_09",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_10",
  "COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01",
  "COMPONENT_PISTOL_MK2_CAMO",
  "COMPONENT_SNSPISTOL_MK2_CAMO",
  "COMPONENT_SMG_MK2_CAMO",
  "COMPONENT_CARBINERIFLE_MK2_CAMO",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO",
  "COMPONENT_COMBATMG_MK2_CAMO",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO",
  "COMPONENT_PISTOL_MK2_CAMO_02",
  "COMPONENT_SNSPISTOL_MK2_CAMO_02",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_02",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_02",
  "COMPONENT_SMG_MK2_CAMO_02",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_02",
  "COMPONENT_COMBATMG_MK2_CAMO_02",
  "COMPONENT_PISTOL_MK2_CAMO_03",
  "COMPONENT_SNSPISTOL_MK2_CAMO_03",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_03",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_03",
  "COMPONENT_SMG_MK2_CAMO_03",
  "COMPONENT_COMBATMG_MK2_CAMO_03",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_03",
  "COMPONENT_PISTOL_MK2_CAMO_04",
  "COMPONENT_SNSPISTOL_MK2_CAMO_04",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_04",
  "COMPONENT_SMG_MK2_CAMO_04",
  "COMPONENT_COMBATMG_MK2_CAMO_04",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_04",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_04",
  "COMPONENT_PISTOL_MK2_CAMO_05",
  "COMPONENT_SNSPISTOL_MK2_CAMO_05",
  "COMPONENT_SMG_MK2_CAMO_05",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_05",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_05",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_05",
  "COMPONENT_COMBATMG_MK2_CAMO_05",
  "COMPONENT_PISTOL_MK2_CAMO_06",
  "COMPONENT_SNSPISTOL_MK2_CAMO_06",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_06",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_06",
  "COMPONENT_SMG_MK2_CAMO_06",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_06",
  "COMPONENT_COMBATMG_MK2_CAMO_06",
  "COMPONENT_PISTOL_MK2_CAMO_07",
  "COMPONENT_SNSPISTOL_MK2_CAMO_07",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_07",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_07",
  "COMPONENT_COMBATMG_MK2_CAMO_07",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_07",
  "COMPONENT_SMG_MK2_CAMO_07",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_08",
  "COMPONENT_PISTOL_MK2_CAMO_08",
  "COMPONENT_SNSPISTOL_MK2_CAMO_08",
  "COMPONENT_COMBATMG_MK2_CAMO_08",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_08",
  "COMPONENT_SMG_MK2_CAMO_08",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_08",
  "COMPONENT_PISTOL_MK2_CAMO_09",
  "COMPONENT_SNSPISTOL_MK2_CAMO_09",
  "COMPONENT_COMBATMG_MK2_CAMO_09",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_09",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_09",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_09",
  "COMPONENT_SMG_MK2_CAMO_09",
  "COMPONENT_PISTOL_MK2_CAMO_10",
  "COMPONENT_SNSPISTOL_MK2_CAMO_10",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_10",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_10",
  "COMPONENT_COMBATMG_MK2_CAMO_10",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_10",
  "COMPONENT_SMG_MK2_CAMO_10",
  "COMPONENT_PISTOL_MK2_CAMO_IND_01",
  "COMPONENT_SMG_MK2_CAMO_IND_01",
  "COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01",
  "COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01",
  "COMPONENT_COMBATMG_MK2_CAMO_IND_01",
  "COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01",
  "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01"
}

PlayerState.weapon_types = {
  "WEAPON_BATTLEAXE",
  "WEAPON_STONE_HATCHET",
  "WEAPON_SNSPISTOL_MK2",
  "WEAPON_PISTOL_MK2",
  "WEAPON_REVOLVER_MK2",
  "WEAPON_MARKSMANRIFLE_MK2" ,
  "WEAPON_HEAVYSNIPER_MK2",
  "WEAPON_SMG_MK2",
  "WEAPON_COMBATMG_MK2",
  "WEAPON_PUMPSHOTGUN_MK2",
  "WEAPON_BULLPUPRIFLE",
  "WEAPON_BULLPUPRIFLE_MK2",
  "WEAPON_ASSAULTRIFLE_MK2",
  "WEAPON_CARBINERIFLE_MK2",
  "WEAPON_SPECIALCARBINE_MK2",
  "WEAPON_CARBINERIFLE_MK2",
  "WEAPON_FLASHBANG",
  "WEAPON_BBSHOTGUN",

  "WEAPON_BOTTLE",
  "WEAPON_ANIMAL",
  "WEAPON_KNUCKLE",
  "WEAPON_SNSPISTOL",
  "WEAPON_COUGAR",
  "WEAPON_KNIFE",
  "WEAPON_NIGHTSTICK",
  "WEAPON_HAMMER",
  "WEAPON_FLASHLIGHT",
  "WEAPON_BAT",
  "WEAPON_GOLFCLUB",
  "WEAPON_CROWBAR",
  "WEAPON_PISTOL",
  "WEAPON_COMBATPISTOL",
  "WEAPON_APPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_MICROSMG",
  "WEAPON_SMG",
  "WEAPON_ASSAULTSMG",
  "WEAPON_ASSAULTRIFLE",
  "WEAPON_CARBINERIFLE",
  "WEAPON_ADVANCEDRIFLE",
  "WEAPON_MG",
  "WEAPON_COMBATMG",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SAWNOFFSHOTGUN",
  "WEAPON_ASSAULTSHOTGUN",
  "WEAPON_BULLPUPSHOTGUN",
  "WEAPON_STUNGUN",
  "WEAPON_SNIPERRIFLE",
  "WEAPON_HEAVYSNIPER",
  "WEAPON_REMOTESNIPER",
  "WEAPON_GRENADELAUNCHER",
  "WEAPON_GRENADELAUNCHER_SMOKE",
  "WEAPON_RPG",
  "WEAPON_PASSENGER_ROCKET",
  "WEAPON_AIRSTRIKE_ROCKET",
  "WEAPON_STINGER",
  "WEAPON_MINIGUN",
  "WEAPON_GRENADE",
  "WEAPON_STICKYBOMB",
  "WEAPON_SMOKEGRENADE",
  "WEAPON_BZGAS",
  "WEAPON_MOLOTOV",
  "WEAPON_FIREEXTINGUISHER",
  "WEAPON_PETROLCAN",
  "WEAPON_DIGISCANNER",
  "WEAPON_BRIEFCASE",
  "WEAPON_BRIEFCASE_02",
  "WEAPON_BALL",
  "WEAPON_FLARE",
  "WEAPON_VEHICLE_ROCKET",
  "WEAPON_BARBED_WIRE",
  "WEAPON_DROWNING",
  "WEAPON_DROWNING_IN_VEHICLE",
  "WEAPON_BLEEDING",
  "WEAPON_ELECTRIC_FENCE",
  "WEAPON_EXPLOSION",
  "WEAPON_FALL",
  "WEAPON_HIT_BY_WATER_CANNON",
  "WEAPON_RAMMED_BY_CAR",
  "WEAPON_RUN_OVER_BY_CAR",
  "WEAPON_HELI_CRASH",
  "WEAPON_FIRE",
  "GADGET_NIGHTVISION",
  "GADGET_PARACHUTE",
  "WEAPON_HEAVYSHOTGUN",
  "WEAPON_MARKSMANRIFLE",
  "WEAPON_HOMINGLAUNCHER",
  "WEAPON_PROXMINE",
  "WEAPON_SNOWBALL",
  "WEAPON_FLAREGUN",
  "WEAPON_GARBAGEBAG",
  "WEAPON_HANDCUFFS",
  "WEAPON_HEAVYPISTOL",
  "WEAPON_COMBATPDW",
  "WEAPON_MARKSMANPISTOL",
  "WEAPON_HATCHET",
  "WEAPON_RAILGUN",
  "WEAPON_MACHETE",
  "WEAPON_MACHINEPISTOL",
  "WEAPON_AIR_DEFENCE_GUN",
  "WEAPON_SWITCHBLADE",
  "WEAPON_REVOLVER",
  "WEAPON_VINTAGEPISTOL",
  "WEAPON_DAGGER",
  "WEAPON_MUSKET",
  "WEAPON_SPECIALCARBINE",
  "WEAPON_GUSENBERG",
  "WEAPON_COMPACTRIFLE",
  "WEAPON_WRENCH",
  "WEAPON_POOLCUE",
  "WEAPON_PIPEBOMB",
  "WEAPON_DOUBLEACTION",
}

-- METHODS

function PlayerState:__construct()
  vRP.Extension.__construct(self)

  self.state_ready = false
  self.update_interval = 30
  self.mp_models = {} -- map of model hash

  -- update task
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(self.update_interval*1000)

      if self.state_ready then
        local x,y,z = vRP.EXT.Base:getPosition()

        self.remote._update({
          position = {x=x,y=y,z=z},
          heading = GetEntityHeading(GetPlayerPed(-1)),
          weapons = self:getWeapons(),
          customization = self:getCustomization(),
          health = self:getHealth(),
          armour = self:getArmour()
        })
      end
    end
  end)
end

-- WEAPONS

function getWeaponComponents(weapon)

  local components = {}
  local player = GetPlayerPed(-1)
  local weaponHash = weapon
  for k,v in pairs(PlayerState.weapon_components) do
    local componentHash = GetHashKey(v)
    if HasPedGotWeaponComponent(
      player, 
      weaponHash --[[ Hash ]], 
      componentHash --[[ Hash ]]
    ) then
    components[k] = v
    end
  end
  return components

end

-- get player weapons 
-- return map of name => {.ammo}
function PlayerState:getWeapons()
  local player = GetPlayerPed(-1)

  local ammo_types = {} -- remember ammo type to not duplicate ammo amount

  local weapons = {}
  for k,v in pairs(PlayerState.weapon_types) do
    local hash = GetHashKey(v)
    if HasPedGotWeapon(player,hash) then
      local weapon = {}
      weapons[v] = weapon

      local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, hash)
      if ammo_types[atype] == nil then
        ammo_types[atype] = true
        weapon.ammo = GetAmmoInPedWeapon(player,hash)
      else
        weapon.ammo = 0
      end
      weapon.tint = GetPedWeaponTintIndex(player, hash)
      weapon.components = getWeaponComponents(hash)
    end
  end

  return weapons
end

-- replace weapons (combination of getWeapons and giveWeapons)
-- weapons: map of name => {.ammo}
--- ammo: (optional)
-- return previous weapons
function PlayerState:replaceWeapons(weapons)
  local old_weapons = self:getWeapons()
  self:giveWeapons(weapons, true)
  return old_weapons
end

-- weapons: map of name => {.ammo}
--- ammo: (optional)
function PlayerState:giveWeapons(weapons, clear_before)
  local player = GetPlayerPed(-1)

  -- give weapons to player

  if clear_before then
    RemoveAllPedWeapons(player,true)
  end

  for k,weapon in pairs(weapons) do
    local hash = GetHashKey(k)
    local ammo = weapon.ammo or 0
    local tint = weapon.tint or 0
    local components = weapon.components or {}

    GiveWeaponToPed(player, hash, ammo, false)
    if tint > 0 then
      SetPedWeaponTintIndex(player, hash, tint)      
    end 
    if components then
      for j,l in pairs(components) do
        self:giveWeaponsComponents(l,k)
      end
    end
  end
end

function PlayerState:giveWeaponsComponents(components, weaponname)
  local player = GetPlayerPed(-1)
  -- Put weapon Components to selected weapon
    local hash = GetHashKey(weaponname)
    local hashc = GetHashKey(components)
    if DoesWeaponTakeWeaponComponent(hash,hashc) then
       GiveWeaponComponentToPed(player, hash, hashc)
       return true
    else
      return false
    end
end

function PlayerState:giveWeaponTint(tintaindex, weaponname)
  local player = GetPlayerPed(-1)
  -- Change the color selected weapon
  local hash = GetHashKey(weaponname)
  SetPedWeaponTintIndex(player, hash, tintaindex)
end

-- set player armour (0-100)
function PlayerState:setArmour(amount)
  SetPedArmour(GetPlayerPed(-1), amount)
end

function PlayerState:getArmour()
  return GetPedArmour(GetPlayerPed(-1))
end

-- amount: 100-200 ?
function PlayerState:setHealth(amount)
  SetEntityHealth(GetPlayerPed(-1), math.floor(amount))
end

function PlayerState:getHealth()
  return GetEntityHealth(GetPlayerPed(-1))
end

--[[
function tvRP.dropWeapon()
  SetPedDropsWeapon(GetPlayerPed(-1))
end
--]]

-- PLAYER CUSTOMIZATION

-- get number of drawables for a specific part
function PlayerState:getDrawables(part)
  local args = splitString(part, ":")
  local index = parseInt(args[2])

  if args[1] == "prop" then
    return GetNumberOfPedPropDrawableVariations(GetPlayerPed(-1),index)
  elseif args[1] == "drawable" then
    return GetNumberOfPedDrawableVariations(GetPlayerPed(-1),index)
  elseif args[1] == "overlay" then
    return GetNumHeadOverlayValues(index)
  end
end

-- get number of textures for a specific part and drawable
function PlayerState:getDrawableTextures(part,drawable)
  local args = splitString(part, ":")
  local index = parseInt(args[2])

  if args[1] == "prop" then
    return GetNumberOfPedPropTextureVariations(GetPlayerPed(-1),index,drawable)
  elseif args[1] == "drawable" then
    return GetNumberOfPedTextureVariations(GetPlayerPed(-1),index,drawable)
  end
end

-- get player skin customization
-- return custom parts
function PlayerState:getCustomization()
  local ped = GetPlayerPed(-1)

  local custom = {}

  custom.modelhash = GetEntityModel(ped)

  -- ped parts
  for i=0,20 do -- index limit to 20
    custom["drawable:"..i] = {GetPedDrawableVariation(ped,i), GetPedTextureVariation(ped,i), GetPedPaletteVariation(ped,i)}
  end

  -- props
  for i=0,10 do -- index limit to 10
    custom["prop:"..i] = {GetPedPropIndex(ped,i), math.max(GetPedPropTextureIndex(ped,i),0)}
  end

  custom.hair_color = {GetPedHairColor(ped), GetPedHairHighlightColor(ped)}

  for i=0,12 do
    local ok, index, ctype, pcolor, scolor, opacity = GetPedHeadOverlayData(ped, i)
    if ok then
      custom["overlay:"..i] = {index, pcolor, scolor, opacity}
    end
  end

  return custom
end

-- set partial customization (only what is set is changed)
-- custom: indexed customization parts ("foo:arg1:arg2...")
--- "modelhash": number, model hash
--- or "model": string, model name
--- "drawable:<index>": {drawable,texture,palette} ped components
--- "prop:<index>": {prop_index, prop_texture}
--- "hair_color": {primary, secondary}
--- "overlay:<index>": {overlay_index, primary color, secondary color, opacity}
function PlayerState:setCustomization(custom) 
  local r = async()

  Citizen.CreateThread(function() -- new thread
    if custom then
      local ped = GetPlayerPed(-1)
      local mhash = nil

      -- model
      if custom.modelhash then
        mhash = custom.modelhash
      elseif custom.model then
        mhash = GetHashKey(custom.model)
      end

      if mhash then
        local i = 0
        while not HasModelLoaded(mhash) and i < 10000 do
          RequestModel(mhash)
          Citizen.Wait(10)
        end

        if HasModelLoaded(mhash) then
          -- changing player model remove weapons, armour and health, so save it

          vRP:triggerEventSync("playerModelSave")

          local weapons = self:getWeapons()
          local armour = self:getArmour()
          local health = self:getHealth()

          SetPlayerModel(PlayerId(), mhash)

          self:giveWeapons(weapons,true)
          self:setArmour(armour)
          self:setHealth(health)

          vRP:triggerEventSync("playerModelRestore")

          SetModelAsNoLongerNeeded(mhash)
        end
      end

      ped = GetPlayerPed(-1)

      local is_mp = self.mp_models[GetEntityModel(ped)]

      if is_mp then
        -- face blend data
        local face = (custom["drawable:0"] and custom["drawable:0"][1]) or GetPedDrawableVariation(ped,0)
        SetPedHeadBlendData(ped, face, face, 0, face, face, 0, 0.5, 0.5, 0.0, false)
      end

      -- drawable, prop, overlay
      for k,v in pairs(custom) do
        local args = splitString(k, ":")
        local index = parseInt(args[2])

        if args[1] == "prop" then
          if v[1] < 0 then
            ClearPedProp(ped,index)
          else
            SetPedPropIndex(ped,index,v[1],v[2],true)
          end
        elseif args[1] == "drawable" then
          SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
        elseif args[1] == "overlay" and is_mp then
          local ctype = 0
          if index == 1 or index == 2 or index == 10 then ctype = 1
          elseif index == 5 or index == 8 then ctype = 2 end

          SetPedHeadOverlay(ped, index, v[1], v[4] or 1.0)
          SetPedHeadOverlayColor(ped, index, ctype, v[2] or 0, v[3] or 0)
        end
      end

      if custom.hair_color and is_mp then
        SetPedHairColor(ped, table.unpack(custom.hair_color))
      end
    end

    r()
  end)

  return r:wait()
end

-- EVENT

PlayerState.event = {}

function PlayerState.event:playerDeath()
  self.state_ready = false
end

-- TUNNEL
PlayerState.tunnel = {}

function PlayerState.tunnel:setStateReady(state)
  self.state_ready = state
end

function PlayerState.tunnel:setConfig(update_interval, mp_models)
  self.update_interval = update_interval

  for _, model in pairs(mp_models) do
    local hash
    if type(model) == "string" then
      hash = GetHashKey(model)
    else
      hash = model
    end

    self.mp_models[hash] = true
  end
end

PlayerState.tunnel.getWeapons = PlayerState.getWeapons
PlayerState.tunnel.replaceWeapons = PlayerState.replaceWeapons
PlayerState.tunnel.giveWeapons = PlayerState.giveWeapons
PlayerState.tunnel.giveWeaponsComponents = PlayerState.giveWeaponsComponents
PlayerState.tunnel.giveWeaponTint = PlayerState.giveWeaponTint
PlayerState.tunnel.getWeaponComponents = PlayerState.getWeaponComponents
PlayerState.tunnel.setArmour = PlayerState.setArmour
PlayerState.tunnel.getArmour = PlayerState.getArmour
PlayerState.tunnel.setHealth = PlayerState.setHealth
PlayerState.tunnel.getHealth = PlayerState.getHealth
PlayerState.tunnel.getDrawables = PlayerState.getDrawables
PlayerState.tunnel.getDrawableTextures = PlayerState.getDrawableTextures
PlayerState.tunnel.getCustomization = PlayerState.getCustomization
PlayerState.tunnel.setCustomization = PlayerState.setCustomization

vRP:registerExtension(PlayerState)
