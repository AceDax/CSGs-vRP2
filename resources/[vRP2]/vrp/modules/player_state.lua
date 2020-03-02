if not vRP.modules.player_state then return end

local lang = vRP.lang

local PlayerState = class("PlayerState", vRP.Extension)

PlayerState.globalTintTable = {
	mk1 = {
		{ 1, "TINT_Green" },
		{ 2, "TINT_Gold" },
		{ 3, "TINT_Pink" },
		{ 4, "TINT_Army" },
		{ 5, "TINT_LSPD" },
		{ 6, "TINT_Orange" },
		{ 7, "TINT_Platinum" },
		{ 1, "TINT_Classic Gray" },
		{ 2, "TINT_Classic TwoTone" },
		{ 3, "TINT_Classic White" },
		{ 4, "TINT_Classic Beige" },
		{ 5, "TINT_Classic Green" },
		{ 6, "TINT_Classic Blue" },
		{ 7, "TINT_Classic Earth" },
		{ 8, "TINT_Classic Brown And Black" },
		{ 9, "TINT_Red Contrast" },
		{ 10, "TINT_Blue Contrast" },
		{ 11, "TINT_Yellow Contrast" },
		{ 12, "TINT_Orange Contrast" },
		{ 13, "TINT_Bold Pink" },
		{ 14, "TINT_Bold Purple And Yellow" },
		{ 15, "TINT_Bold Orange" },
		{ 16, "TINT_Bold Green And Purple" },
		{ 17, "TINT_Bold Red Features" },
		{ 18, "TINT_Bold Green Features" },
		{ 19, "TINT_Bold Cyan Features" },
		{ 20, "TINT_Bold Yellow Features" },
		{ 21, "TINT_Bold Red And White" },
		{ 22, "TINT_Bold Blue And White" },
		{ 23, "TINT_Metallic Gold" },
		{ 24, "TINT_Metallic Platinum" },
		{ 25, "TINT_Metallic Gray And Lilac" },
		{ 26, "TINT_Metallic Purple And Lime" },
		{ 27, "TINT_Metallic Red" },
		{ 28, "TINT_Metallic Green" },
		{ 29, "TINT_Metallic Blue" },
		{ 30, "TINT_Metallic White And Aqua" },
		{ 31, "TINT_Metallic Red And Yellow" },
  }
}
-- PRIVATE METHODS

-- MENU TINTAS
local function tinta(self)
  
  local function get_wname(weapon_id)
    local name = string.gsub(weapon_id,"WEAPON_","")
    name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
    -- lang translation support, ex: weapon.pistol = "Pistol", by default use the native name
    return lang.weapon[string.lower(name)]({}, name)
  end

  local function m_wtint_equip(menu, weapon)
    local user = menu.user
    local fullid = menu.data.tintname
    local tintindex = 0
    local citem = vRP.EXT.Inventory:computeItem("wtint|"..fullid)
    --print(citem.args[2])
    if user:tryTakeItem("wtint|"..fullid, 1) then -- give weapon body
      for k,v in pairs(PlayerState.globalTintTable.mk1) do
          if citem.args[2] == v[2] then
             tintindex = v[1]
          end
      end
      self.remote._giveWeaponTint(user.source, tintindex, weapon)
      local namount = user:getItemAmount(fullid)
      if namount > 0 then
        user:actualizeMenu()
      else
        user:closeMenu(menu)
      end
    end
  end

  vRP.EXT.GUI:registerMenuBuilder("paint", function(menu)
    menu.title = "Choose which weapon to paint"
    menu.css.header_color = "rgba(255,125,0,0.75)"
    local user = menu.user
	  local weapons = self.remote.getWeapons(user.source)
	  for k,v in pairs(weapons) do 
  		menu:addOption(get_wname(k), m_wtint_equip, "paint this gun", k)
	  end
  end)
end

local function componente(self)
  local function get_wname(weapon_id)
    local name = string.gsub(weapon_id,"WEAPON_","")
    name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
    -- lang translation support, ex: weapon.pistol = "Pistol", by default use the native name
    return lang.weapon[string.lower(name)]({}, name)
  end

  local function m_wcomp_equip(menu, weapon)
    local user = menu.user
    local fullid = menu.data.componente
    local citem = vRP.EXT.Inventory:computeItem("wcomp|"..fullid)
    --print(citem.args[2])
      local components = {}
      components[citem.args[2]] = {use = 0}
      if self.remote.giveWeaponsComponents(user.source, citem.args[2], weapon) then
        if user:tryTakeItem("wcomp|"..fullid, 1) then -- give weapon body
          local namount = user:getItemAmount(fullid)
          if namount > 0 then
            user:actualizeMenu()
          else
            user:closeMenu(menu)
          end
        else
          vRP.EXT.Base.remote._notify(user.source,"Missing component")
        end
      else
        vRP.EXT.Base.remote._notify(user.source,"Not compatible with this weapon")   
        user:closeMenu(menu)     
      end
  end

  vRP.EXT.GUI:registerMenuBuilder("component", function(menu)
    menu.title = "Choose which weapon to equip"
    menu.css.header_color = "rgba(255,125,0,0.75)"
    local user = menu.user
	  local weapons = self.remote.getWeapons(user.source)
	  for k,v in pairs(weapons) do 
		  menu:addOption(get_wname(k), m_wcomp_equip, "", k)
	  end
  end)
end

local function define_items(self)
  -- parametric weapon items
  -- give "wbody|WEAPON_PISTOL" and "wammo|WEAPON_PISTOL" to have pistol body and pistol bullets
  -- wbody|weapon
  -- wammo|weapon[|amount] (amount make it an ammo box)

  local function get_wname(weapon_id)
    local name = string.gsub(weapon_id,"WEAPON_","")
    name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
    -- lang translation support, ex: weapon.pistol = "Pistol", by default use the native name
    return lang.weapon[string.lower(name)]({}, name)
  end

  local function get_wcomp(weapon_id)

    local name = string.gsub(weapon_id,"COMPONENT_","")
    name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
    -- lang translation support, ex: weapon.pistol = "Pistol", by default use the native name
    return lang.component[string.upper(name)]({}, name)
  end

  local function get_wtint(weapon_id)

    local name = string.gsub(weapon_id,"TINT_","")
    name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
    -- lang translation support, ex: weapon.pistol = "Pistol", by default use the native name
    return lang.tint[string.lower(name)]({}, name)
  end

  -- wbody

  local function i_wbody_name(args)
    return lang.item.wbody.name({get_wname(args[2])})
  end

  local function i_wbody_desc(args)
    return lang.item.wbody.description({get_wname(args[2])})
  end

  local function m_wbody_equip(menu)
    local user = menu.user
    local fullid = menu.data.fullid
    local citem = vRP.EXT.Inventory:computeItem(fullid)

    if user:tryTakeItem(fullid, 1) then -- give weapon body
      local weapons = {}
      weapons[citem.args[2]] = {ammo = 0}
      self.remote._giveWeapons(user.source, weapons)

      local namount = user:getItemAmount(fullid)
      if namount > 0 then
        user:actualizeMenu()
      else
        user:closeMenu(menu)
      end
    end
  end

  local function i_wbody_menu(args, menu)
    menu:addOption(lang.item.wbody.equip.title(), m_wbody_equip)
  end

  vRP.EXT.Inventory:defineItem("wbody",i_wbody_name,i_wbody_desc,i_wbody_menu,0.75)

  -- wammo

  local function i_wammo_name(args)
    if args[3] then
      return lang.item.wammo.name_box({get_wname(args[2]), tonumber(args[3]) or 0})
    else
      return lang.item.wammo.name({get_wname(args[2])})
    end
  end

  local function i_wammo_desc(args)
    return lang.item.wammo.description({get_wname(args[2])})
  end

  local function m_wammo_load(menu)
    local user = menu.user
    local fullid = menu.data.fullid

    local amount = user:getItemAmount(fullid)
    local ramount = parseInt(user:prompt(lang.item.wammo.load.prompt({amount}), ""))

    local citem = vRP.EXT.Inventory:computeItem(fullid)

    local weapons = self.remote.getWeapons(user.source)
    if weapons[citem.args[2]] then -- check if the weapon is equiped
      if user:tryTakeItem(fullid, ramount) then -- give weapon ammo
        local weapons = {}
        weapons[citem.args[2]] = {ammo = ramount}
        self.remote._giveWeapons(user.source, weapons)

        local namount = user:getItemAmount(fullid)
        if namount > 0 then
          user:actualizeMenu()
        else
          user:closeMenu(menu)
        end
      end
    end
  end

  local function m_wammo_open(menu)
    local user = menu.user
    local fullid = menu.data.fullid

    local citem = vRP.EXT.Inventory:computeItem(fullid)
    local ammoid = citem.args[1].."|"..citem.args[2]
    local amount = tonumber(citem.args[3]) or 0

    if user:tryTakeItem(fullid, 1, true) and user:tryGiveItem(ammoid, amount, true) then
      user:tryTakeItem(fullid, 1)
      user:tryGiveItem(ammoid, amount)

      local namount = user:getItemAmount(fullid)
      if namount > 0 then
        user:actualizeMenu()
      else
        user:closeMenu(menu)
      end
    end
  end

  local function i_wammo_menu(args, menu)
    if args[3] then
      menu:addOption(lang.item.wammo.open.title(), m_wammo_open)
    else
      menu:addOption(lang.item.wammo.load.title(), m_wammo_load)
    end
  end

  vRP.EXT.Inventory:defineItem("wammo", i_wammo_name,i_wammo_desc,i_wammo_menu,0.01)

  -- wcomp

  local function i_wcomp_name(args)
   
    return lang.item.wcomp.name({get_wcomp(args[2])})
  end

  local function i_wcomp_desc(args)
 
    return lang.item.wcomp.description({get_wcomp(args[2])})
  end


  local function i_wcomp_menu(args, menu)
    menu:addOption(lang.item.wcomp.equip.title(), function(menu)
      menu.user:openMenu("component", {componente = args[2]})
    end)
  end

  vRP.EXT.Inventory:defineItem("wcomp",i_wcomp_name,i_wcomp_desc,i_wcomp_menu,0.75)

-- wtint

  local function i_wtint_name(args)
  
    return lang.item.wtint.name({get_wtint(args[2])})
  end

  local function i_wtint_desc(args)
 
    return lang.item.wtint.description({get_wtint(args[2])})
  end

  local function i_wtint_menu(args, menu)
  	
  	 menu:addOption(lang.item.wtint.equip.title(), function(menu)
      menu.user:openMenu("paint", {tintname = args[2]})
    end)
  end

  vRP.EXT.Inventory:defineItem("wtint",i_wtint_name,i_wtint_desc,i_wtint_menu,0.75)

end

-- PRIVATE METHODS

-- menu: admin
local function menu_admin(self)
  local function m_model(menu)
    local user = menu.user

    if user:hasPermission("player.custom_model") then
      local model = user:prompt(lang.admin.custom_model.prompt(),"")
      local hash = tonumber(model)
      local custom = {}
      if hash then
        custom.modelhash = hash
      else
        custom.model = model
      end

      self.remote._setCustomization(user.source, custom)
    end
  end

  vRP.EXT.GUI:registerMenuBuilder("admin", function(menu)
    local user = menu.user

    if user:hasPermission("player.custom_model") then
      menu:addOption(lang.admin.custom_model.title(), m_model)
    end
  end)
end

-- METHODS

function PlayerState:__construct()
  vRP.Extension.__construct(self)

  self.cfg = module("vrp", "cfg/player_state")

  menu_admin(self)
  tinta(self)
  componente(self)

  -- items
  define_items(self)
end

-- EVENT

PlayerState.event = {}

function PlayerState.event:playerSpawn(user, first_spawn)
  if first_spawn then
    self.remote._setConfig(user.source, self.cfg.update_interval, self.cfg.mp_models)
  end
  self.remote._setStateReady(user.source, false)

  -- default customization
  if not user.cdata.state.customization then
    user.cdata.state.customization = self.cfg.default_customization
  end

  -- default position
  if not user.cdata.state.position and self.cfg.spawn_enabled then
    local x = self.cfg.spawn_position[1]+math.random()*self.cfg.spawn_radius*2-self.cfg.spawn_radius
    local y = self.cfg.spawn_position[2]+math.random()*self.cfg.spawn_radius*2-self.cfg.spawn_radius
    local z = self.cfg.spawn_position[3]
    user.cdata.state.position = {x=x,y=y,z=z}
  end

  if user.cdata.state.position then -- teleport to saved pos
    vRP.EXT.Base.remote.teleport(user.source,user.cdata.state.position.x,user.cdata.state.position.y,user.cdata.state.position.z, user.cdata.state.heading)
  end

  if user.cdata.state.customization then -- customization
    self.remote.setCustomization(user.source,user.cdata.state.customization) 
  end

  -- weapons
  self.remote.giveWeapons(user.source,user.cdata.state.weapons or {},true)

  if user.cdata.state.health then -- health
    self.remote.setHealth(user.source,user.cdata.state.health)
  end

  if user.cdata.state.armour then -- armour
    self.remote.setArmour(user.source,user.cdata.state.armour)
  end

  self.remote._setStateReady(user.source, true)

  vRP:triggerEvent("playerStateLoaded", user)
end

function PlayerState.event:playerDeath(user)
  user.cdata.state.position = nil
  user.cdata.state.heading = nil
  user.cdata.state.weapons = nil
  user.cdata.state.health = nil
  user.cdata.state.armour = nil
end

function PlayerState.event:characterLoad(user)
  if not user.cdata.state then
    user.cdata.state = {}
  end
end

function PlayerState.event:characterUnload(user)
  self.remote._setStateReady(user.source, false)
end

-- TUNNEL
PlayerState.tunnel = {}

function PlayerState.tunnel:update(state)
  local user = vRP.users_by_source[source]
  if user and user:isReady() then
    for k,v in pairs(state) do
      user.cdata.state[k] = v
    end

    vRP:triggerEvent("playerStateUpdate", user, state)
  end
end

vRP:registerExtension(PlayerState)
