
local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- title (optional): group display name
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(user) (called when the character spawn with the group)
--- onjoin (optional): function(user) (called when the character join the group)
--- onleave (optional): function(user) (called when the character leave the group)

function police_init(user)
  local weapons = {}
  weapons["WEAPON_STUNGUN"] = {ammo=1000}
  weapons["WEAPON_COMBATPISTOL"] = {ammo=100}
  weapons["WEAPON_NIGHTSTICK"] = {ammo=0}
  weapons["WEAPON_FLASHLIGHT"] = {ammo=0}
  
  vRP.EXT.PlayerState.remote._giveWeapons(user.source,weapons,true)
  vRP.EXT.Police.remote._setCop(user.source,true)
  vRP.EXT.PlayerState.remote._setArmour(user.source,100)
end

function police_onjoin(user)
  police_init(user)
end

function police_onleave(user)
  vRP.EXT.PlayerState.remote._giveWeapons(user.source,{},true)
  vRP.EXT.Police.remote._setCop(user.source,false)
  vRP.EXT.PlayerState.remote._setArmour(user.source,0)
  user:removeCloak()
end

function police_onspawn(user)
  police_init(user)
end

cfg.groups = {
  --==========|============|==========--
  --==========|Staff Groups|==========--
  --==========|============|==========--
  ["superadmin"] = {
    _config = {onspawn = function(user) vRP.EXT.Base.remote._notify(user.source, "You are superadmin.") end},
    "player.info",
    "player.group.add",
    "player.group.remove",
    "player.givemoney",
    "player.giveitem"
  },
  ["admin"] = {
    "player.info",
    "admin.tickets",
    "admin.announce",
    "player.list",
    "player.whitelist",
    "player.unwhitelist",
    "player.kick",
    "player.ban",
    "player.unban",
    "player.noclip",
    "player.custom_emote",
    "player.custom_model",
    "player.custom_sound",
    "player.display_custom",
    "player.coords",
    "player.tptome",
    "player.tpto"
  },
  ["god"] = {
    "admin.god" -- reset survivals/health periodically
  },
  --==========|==========|==========--
  --==========|User Group|==========--
  --==========|==========|==========--
  ["user"] = {
    "player.phone",
    "player.calladmin",
    "player.store_weapons",
    "police.seizable" -- can be seized
  },
  --==========|===================|==========--
  --==========|Whitelisting Groups|==========--
  --==========|===================|==========--
  ["police"] = { --add this group to users for whitelisted police roles. This group is used by department heads to hire and fire officers. DO NOT DELETE
    "police.whitelisted"
  },
  ["DeptHead"] = { --add this group to users for whitelisted department head roles. DO NOT DELETE
    "department.head.whitelisted"
  },
  --==========|===========|==========--
  --==========|LSPD Groups|==========--
  --==========|===========|==========--
  ["cadet"] = {
    _config = {
      title = "LSPD Cadet",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcadet.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["police1"] = {
    _config = {
      title = "Police Officer",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "officer.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle2",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["police2"] = {
    _config = {
      title = "Senior Police Officer",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "officer.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle2",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_corporal"] = {
    _config = {
      title = "LSPD Corporal",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcorp.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle2",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_sgt"] = {
    _config = {
      title = "LSPD Sergeant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdsgt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_lt"] = {
    _config = {
      title = "LSPD Lieutenant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdlt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_cpt"] = {
    _config = {
      title = "LSPD Captain",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcpt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_ltmjr"] = {
    _config = {
      title = "LSPD Lieutenant Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdltmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle3",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_mjr"] = {
    _config = {
      title = "LSPD Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_cmdr"] = {
    _config = {
      title = "LSPD Commander",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdcmdr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_asscheif"] = {
    _config = {
      title = "LSPD Assistant Chief",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lspdasscheif.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_cheif"] = {
    _config = {
      title = "LSPD Chief",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.admin",
    "police.menu",
    "police.askid",
    "lspdasscheif.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle4",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  --==========|===========|==========--
  --==========|LSSD Groups|==========--
  --==========|===========|==========--
  ["cadet2"] = {
    _config = {
      title = "LSSD Cadet",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdcadet.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["deputy1"] = {
    _config = {
      title = "Sheriff's Deputy",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "deputy.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["deputy2"] = {
    _config = {
      title = "Senior Sheriff's Deputy",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "deputy.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_corporal"] = {
    _config = {
      title = "LSSD Corporal",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdcorp.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_sgt"] = {
    _config = {
      title = "LSSD Sergeant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdsgt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_lt"] = {
    _config = {
      title = "LSSD Lieutenant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdlt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_cpt"] = {
    _config = {
      title = "LSSD Captain",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdcpt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_ltmjr"] = {
    _config = {
      title = "LSSD Lieutenant Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdltmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_mjr"] = {
    _config = {
      title = "LSSD Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_cmdr"] = {
    _config = {
      title = "LSSD Commander",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdcmdr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "police.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lspd_undersheriff"] = {
    _config = {
      title = "LSSD Undersheriff",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "lssdundersheriff.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["lssd_sheriff"] = {
    _config = {
      title = "LSSD Sheriff",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.admin",
    "police.menu",
    "police.askid",
    "lssdsheriff.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "deputy.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  --==========|===========|==========--
  --==========|SAHP Groups|==========--
  --==========|===========|==========--
  ["cadet3"] = {
    _config = {
      title = "SAHP Cadet",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpcadet.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["trooper"] = {
    _config = {
      title = "Trooper",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "trooper.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["trooper2"] = {
    _config = {
      title = "Senior Trooper",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "trooper.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_corporal"] = {
    _config = {
      title = "SAHP Corporal",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpcorp.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_sgt"] = {
    _config = {
      title = "SAHP Sergeant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpsgt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_lt"] = {
    _config = {
      title = "SAHP Lieutenant",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahplt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_cpt"] = {
    _config = {
      title = "SAHP Captain",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpcpt.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_ltmjr"] = {
    _config = {
      title = "SAHP Lieutenant Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpltmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_mjr"] = {
    _config = {
      title = "SAHP Major",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpmjr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_cmdr"] = {
    _config = {
      title = "SAHP Commander",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpcmdr.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_depdirector"] = {
    _config = {
      title = "SAHP Deputy Director",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.menu",
    "police.askid",
    "sahpdepdirector.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },
  ["sahp_director"] = {
    _config = {
      title = "SAHP Director",
      gtype = "job",
      onjoin = police_onjoin,
      onspawn = police_onspawn,
      onleave = police_onleave
    },
    "police.admin",
    "police.menu",
    "police.askid",
    "sahpdirector.cloakroom",
    "police.pc",
    "police.handcuff",
    "police.drag",
    "police.putinveh",
    "police.getoutveh",
    "police.check",
    "police.service",
    "police.wanted",
    "police.seize",
    "police.jail",
    "police.fine",
    "police.announce",
    "highway.vehicle",
    "police.chest_seized",
    "-police.seizable" -- negative permission, police can't seize itself, even if another group add the permission
  },





  ["emergency"] = {
    _config = {
      title = "Emergency",
      gtype = "job"
    },
    "emergency.revive",
    "emergency.shop",
    "emergency.service",
    "emergency.vehicle",
    "emergency.cloakroom"
  },
  ["repair"] = {
    _config = {
      title = "Repair",
      gtype = "job"
    },
    "vehicle.repair",
    "vehicle.replace",
    "repair.service"
--    "mission.repair.satellite_dishes", -- basic mission
--    "mission.repair.wind_turbines" -- basic mission
  },
  ["taxi"] = {
    _config = {
      title = "Taxi",
      gtype = "job"
    },
    "taxi.service",
    "taxi.vehicle"
  },
  ["citizen"] = {
    _config = {
      title = "Unemployed",
      gtype = "job"
    }
  }
}

-- groups are added dynamically using the API or the menu, but you can add group when a character is loaded here
-- groups for everyone
cfg.default_groups = {
  "user"
}

-- groups per user
-- map of user id => list of groups
cfg.users = {
  [1] = { -- give superadmin and admin group to the first created user in the database
    "superadmin",
    "admin"
  }
}

-- group selectors
-- _config
--- x,y,z, map_entity, permissions (optional)
---- map_entity: {ent,cfg} will fill cfg.title, cfg.pos

cfg.selectors = {
  --=====|====|=====--
  --=====|LSPD|=====--
  --=====|====|=====--
  ["Mission Row PD (Cadet)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"police.whitelisted"}, map_entity = {"PoI", {marker_id = 1}}},
    "cadet",
    "citizen"
  },
  ["Mission Row PD (Police Officer)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.1"}, map_entity = {"PoI", {marker_id = 1}}},
    "police1",
    "citizen"
  },
  ["Mission Row PD (Senior Police Officer)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.2"}, map_entity = {"PoI", {marker_id = 1}}},
    "police2",
    "citizen"
  },
  ["Mission Row PD (Corporal)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.3"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_corporal",
    "citizen"
  },
  ["Mission Row PD (Sergeant)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.4"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_sgt",
    "citizen"
  },
  ["Mission Row PD (Lieutenant)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.5"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_lt",
    "citizen"
  },
  ["Mission Row PD (Captain)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.6"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_cpt",
    "citizen"
  },
  ["Mission Row PD (Lt. Major)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.7"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_ltmjr",
    "citizen"
  },
  ["Mission Row PD (Major)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.8"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_mjr",
    "citizen"
  },
  ["Mission Row PD (Commander)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.9"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_cmdr",
    "citizen"
  },
  ["Mission Row PD (Assistant Chief)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"!aptitude.job.police.10"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_asscheif",
    "citizen"
  },
  ["Mission Row PD (Police Chief)"] = {
    _config = {x = 440.72769165039, y = -975.77941894531, z = 30.689332962036, permissions={"department.head.whitelisted"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_cheif",
    "citizen"
  },
  --=====|====|=====--
  --=====|LSSD|=====--
  --=====|====|=====--
  ["Paleto SO (Cadet)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"police.whitelisted"}, map_entity = {"PoI", {marker_id = 1}}},
    "cadet2",
    "citizen"
  },
  ["Paleto SO (Deputy)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.1"}, map_entity = {"PoI", {marker_id = 1}}},
    "deputy1",
    "citizen"
  },
  ["Paleto SO (Senior Deputy)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.2"}, map_entity = {"PoI", {marker_id = 1}}},
    "deputy2",
    "citizen"
  },
  ["Paleto SO (Corporal)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.3"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_corporal",
    "citizen"
  },
  ["Paleto SO (Sergeant)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.4"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_sgt",
    "citizen"
  },
  ["Paleto SO (Lieutenant)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.5"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_lt",
    "citizen"
  },
  ["Paleto SO (Captain)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.6"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_cpt",
    "citizen"
  },
  ["Paleto SO (Lt Major)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.7"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_ltmjr",
    "citizen"
  },
  ["Paleto SO (Major)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.8"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_mjr",
    "citizen"
  },
  ["Paleto SO (Commander)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.9"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_cmdr",
    "citizen"
  },
  ["Paleto SO (Undersheriff)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"!aptitude.job.police.10"}, map_entity = {"PoI", {marker_id = 1}}},
    "lspd_undersheriff",
    "citizen"
  },
  ["Paleto SO (Sheriff)"] = {
    _config = {x = -444.59561157227, y = 6010.6811523438, z = 31.716354370117, permissions={"department.head.whitelisted"}, map_entity = {"PoI", {marker_id = 1}}},
    "lssd_sheriff",
    "citizen"
  },
  --=====|====|=====--
  --=====|SASP|=====--
  --=====|====|=====--

  --=====|====|=====--
  --=====|SAFD|=====--
  --=====|====|=====--
  ["Emergency job"] = {
    _config = {x=-498.959716796875,y=-335.715148925781,z=34.5017547607422, map_entity = {"PoI", {marker_id = 1}}},
    "emergency",
    "citizen"
  }
}

-- identity display gtypes
-- used to display gtype groups in the identity
-- map of gtype => title
cfg.identity_gtypes = {
  job = "Job"
}

-- count display

cfg.count_display_interval = 15 -- seconds

cfg.count_display_css = [[
.div_group_count_display{
  position: absolute;
  right: 0;
  bottom: 0;
  display: flex;
  flex-direction: row;
  padding: 2px;
  padding-right: 5px;
}

.div_group_count_display > div{
  padding-left: 7px;
  color: white;
  font-weight: bold;
  line-height: 22px;
}

.div_group_count_display > div > img{
  margin-right: 2px;
  vertical-align: bottom;
}
]]

-- list of {permission, img_src}
cfg.count_display_permissions = {
  {"!group.user", "https://i.imgur.com/tQ2VHAi.png"},
  {"!group.admin", "https://i.imgur.com/cpSYyN0.png"},
  {"!group.police", "https://i.imgur.com/dygLDfC.png"},
  {"!group.emergency", "https://i.imgur.com/K5lXutO.png"},
  {"!group.repair", "https://i.imgur.com/QEjFgzM.png"},
  {"!group.taxi", "https://i.imgur.com/yY4yrZN.png"}
}

return cfg

