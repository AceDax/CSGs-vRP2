if not vRP.modules.edible then return end

local lang = vRP.lang
local ActionDelay = module("vrp", "lib/ActionDelay")

local Edible = class("Edible", vRP.Extension)

-- SUBCLASS

Edible.User = class("User")

function Edible.User:__construct()
  self.edible_action = ActionDelay()
end

-- PRIVATE METHODS

local function define_items(self)
  local function i_edible_name(args)
    local edible = self.edibles[args[2]]
    if edible then
      return edible.name
    else
      return "[edible|"..args[2].."]"
    end
  end

  local function i_edible_description(args)
    local edible = self.edibles[args[2]]
    if edible then
      return edible.description
    else
      return ""
    end
  end

  local function m_edible_consume(menu)
    local user = menu.user
    local fullid = menu.data.fullid

    local citem = vRP.EXT.Inventory:computeItem(fullid)
    local edible = self.edibles[citem.args[2]]
    local etype = self.types[edible.type]
    local dead = vRP.EXT.Survival.remote.isInComa(user.source)

    -- consume
    if not dead or user:hasPermission("menu.bypass") then
      if user:tryTakeItem(fullid, 1, true) then -- available check
        if user.edible_action:perform(self.cfg.action_delay) then
          user:tryTakeItem(fullid, 1, nil, true) -- consume

          -- menu update
          local namount = user:getItemAmount(fullid)
          if namount > 0 then
            user:actualizeMenu()
          else
            user:closeMenu(menu)
          end

          -- on_consume
          etype[2](user, edible)

          -- effects
          for id, value in pairs(edible.effects) do
            local effect = self.effects[id]
            if effect then
              -- on_effect
              effect(user, value)
            end
          end
        else
          vRP.EXT.Base.remote._notify(user.source, lang.common.must_wait({user.edible_action:remaining()}))
        end
      end
    else
      vRP.EXT.Base.remote._notify(user.source, "~r~You cannot Eat while in Coma, Call EMS!")
    end
  end

  local function i_edible_menu(args, menu)
    local edible = self.edibles[args[2]]
    if edible then
      local etype = self.types[edible.type]
      if etype then
        menu:addOption(etype[1], m_edible_consume)
      end
    end
  end

  local function i_edible_weight(args)
    local edible = self.edibles[args[2]]
    if edible then
      return edible.weight
    else
      return 0
    end
  end

  local function i_edible_icon(args)
    local edible = self.edibles[args[2]]
    if edible then
      return edible.icon
    else
      return "apple"
    end
  end

  vRP.EXT.Inventory:defineItem("edible", i_edible_name, i_edible_description, i_edible_menu, i_edible_weight, "edible", i_edible_icon, "yes")
end

local function define_basics(self)
  -- food effect
  self:defineEffect("food", function(user, value)
    user:varyVital("food", value)
  end)

  -- water effect
  self:defineEffect("water", function(user, value)
    user:varyVital("water", value)
  end)

  -- health effect
  self:defineEffect("health", function(user, value)
    vRP.EXT.Survival.remote._varyHealth(user.source, value)
  end)

  -- liquid type
  local liquid_seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  self:defineType("liquid", lang.edible.liquid.action(), function(user, edible)
    vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
    vRP.EXT.Audio.remote._playAudioSource(-1, "sounds/drinking.ogg", 1, 0,0,0, 30, user.source)
    vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
  end)

  -- solid type
  local solid_seq = {
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp",1},
    {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger",1}
  }

  self:defineType("solid", lang.edible.solid.action(), function(user, edible)
    vRP.EXT.Base.remote._playAnim(user.source,true,solid_seq,false)
    vRP.EXT.Audio.remote._playAudioSource(-1, self.cfg.solid_sound, 1, 0,0,0, 30, user.source)
    vRP.EXT.Base.remote._notify(user.source, lang.edible.solid.notify({edible.name}))
  end)

  self:defineType("spicy", lang.edible.solid.action(), function(user, edible)
    vRP.EXT.Base.remote._playAnim(user.source,true,solid_seq,false)
    vRP.EXT.Audio.remote._playAudioSource(-1, self.cfg.solid_sound, 1, 0,0,0, 30, user.source)
    vRP.EXT.Base.remote._notify(user.source, lang.edible.solid.notify({edible.name}))
    SetTimeout(4000, function()
      vRP.EXT.Functions.remote.playMovement(user.source, "FEMALE_FAST_RUNNER", true, true, false, false)
      vRP.EXT.Functions.remote.playScreenEffect(user.source, "Rampage", 120)
      vRP.EXT.Base.remote.playerSpeed(user.source, 10.00)
    end)
    SetTimeout(120000, function()
      vRP.EXT.Base.remote.playerSpeed(user.source, 1.00)
      vRP.EXT.Functions.remote.resetMovement(user.source, false)
    end)
  end)

  -- drug type
  self:defineType("drug", lang.edible.drug.action(), function(user, edible)
    vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
    vRP.EXT.Audio.remote._playAudioSource(-1, self.cfg.liquid_sound, 1, 0,0,0, 30, user.source)
    vRP.EXT.Base.remote._notify(user.source, lang.edible.drug.notify({edible.name}))
  end)

  -- Cig type
  local cig_seq = {
    {"amb@world_human_smoking@male@male_a@enter", "enter", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},

    {"amb@world_human_smoking@male@male_a@idle_a", "idle_a", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_b", 1},
    {"amb@world_human_smoking@male@male_a@idle_a", "idle_c", 1},

    {"amb@world_human_smoking@male@male_a@exit", "exit", 1},
  }

  self:defineType("cig", lang.edible.cig.action(), function(user, edible)
    if user:hasPermission("!item.lighter.>0") then
      vRP.EXT.Base.remote._notify(user.source, "~g~Smoking a cigarette.")
      vRP.EXT.Base.remote._playAnim(user.source, true, cig_seq, false)
			SetTimeout(10000, function()
			  user:varyExp("physical", "nicotine_addiction", 0.10)			
      end)
    else
      vRP.EXT.Base.remote._notify(user.source, "You need a Lighter and a Cigarette to smoke")
    end
  end)

  -- weed
  local weed_seq = {
    {"amb@world_human_smoking@male@male_a@enter", "enter", 1},

    {"amb@world_human_smoking_pot@male@idle_a", "idle_a", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_b", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_c", 1},

    {"amb@world_human_smoking_pot@male@idle_a", "idle_b", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_c", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_a", 1},

    {"amb@world_human_smoking_pot@male@idle_a", "idle_c", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_a", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_b", 1},

    {"amb@world_human_smoking@male@male_a@exit", "exit", 1},
  }

  self:defineType("weed", lang.edible.weed.action(), function(user, edible)
    if user:hasPermission("!item.lighter.>0") and user:hasPermission("!item.weed.>0") then 
    user:tryTakeItem("weed",1)
    vRP.EXT.Base.remote._notify(user.source, "~g~Smoking weed.")
    vRP.EXT.Base.remote._playAnim(user.source, true, weed_seq, false)
			SetTimeout(10000, function()
        vRP.EXT.Functions.remote.playMovement(user.source, "move_p_m_zero_slow","Male slow", true, true, false, false)
        vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", 300)
      end)
      SetTimeout(300000, function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
      end)
    else
      vRP.EXT.Base.remote._notify(user.source, "You need rolling paper, Lighter and Weed to roll and smoke a joint")
    end
  end)

  -- Meth
  local meth_seq = {
    {"amb@world_human_smoking@male@male_a@enter", "enter", 1},

    {"amb@world_human_smoking_pot@male@idle_a", "idle_a", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_b", 1},
    {"amb@world_human_smoking_pot@male@idle_a", "idle_c", 1},

    {"amb@world_human_smoking@male@male_a@exit", "exit", 1},
  }

  self:defineType("meth", lang.edible.meth.action(), function(user, edible)
    if user:hasPermission("!item.lighter.>0") and user:hasPermission("!item.methpipe.>0") then 
      vRP.EXT.Base.remote._notify(user.source, "~g~Smoking meth.")
      vRP.EXT.Base.remote._playAnim(user.source, true, meth_seq, false)
			SetTimeout(4000, function()
        vRP.EXT.Functions.remote.playMovement(user.source, "FEMALE_FAST_RUNNER", true, true, false, false)
        vRP.EXT.Functions.remote.playScreenEffect(user.source, "FocusOut", 300)
			  vRP.EXT.Base.remote.playerSpeed(user.source, 15.00)
			  user:varyExp("physical", "methamphetamine_addiction", 1.5)
      end)
      SetTimeout(600000, function()
			  vRP.EXT.Base.remote.playerSpeed(user.source, 1.00)
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
      end)
	  else
	    vRP.EXT.Base.remote._notify(user.source, "You need a Meth pipe, Lighter and Meth to smoke meth")
    end
  end)

  -- lsd

  self:defineType("lsd", lang.edible.drug.action(), function(user, edible)
    vRP.EXT.Base.remote._notify(user.source, "~g~Taking LSD.")
    vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
    vRP.EXT.Functions.remote.DoAcid(user.source)
    user:varyExp("physical", "lsd_addiction", 1.5)
  end)

  -- alcohol 2
  self:defineType("alcohol", lang.edible.liquid.action(), function(user, edible)
    if user:hasPermission("!aptitude.physical.alcohol_addiction.<1") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(30000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 2, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>1") and user:hasPermission("!aptitude.physical.alcohol_addiction.<10") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(60000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 2, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>9") and user:hasPermission("!aptitude.physical.alcohol_addiction.<20") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(90000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 1.5, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>19") and user:hasPermission("!aptitude.physical.alcohol_addiction.<30") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(120000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 1.5, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>29") and user:hasPermission("!aptitude.physical.alcohol_addiction.<40") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(120000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 1.5, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>39") and user:hasPermission("!aptitude.physical.alcohol_addiction.<50") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(240000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 1.5, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>49")then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
        SetTimeout(480000, function()
          vRP.EXT.Functions.remote.playMovement(user.source, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true, true, true, false)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsDrivingIn", -1)
          vRP.EXT.Functions.remote.playScreenEffect(user.source, "DrugsMichaelAliensFight", -1)	
          vRP.EXT.Functions.remote.startShakeGameplayCam(user.source, "DRUNK_SHAKE", 1.5, -1)
          user:varyExp("physical", "alcohol_addiction", 1.5)
        end)
      end
  end)

  -- Coffee
  self:defineType("coffee", lang.edible.liquid.action(), function(user, edible)
    if user:hasPermission("!aptitude.physical.alcohol_addiction.<1") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(5000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>1") and user:hasPermission("!aptitude.physical.alcohol_addiction.<10") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(10000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>9") and user:hasPermission("!aptitude.physical.alcohol_addiction.<20") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(20000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>19") and user:hasPermission("!aptitude.physical.alcohol_addiction.<30") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(40000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>29") and user:hasPermission("!aptitude.physical.alcohol_addiction.<40") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(80000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>39") and user:hasPermission("!aptitude.physical.alcohol_addiction.<50") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(160000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    elseif user:hasPermission("!aptitude.physical.alcohol_addiction.>49") then
        vRP.EXT.Base.remote._notify(user.source, lang.edible.liquid.notify({edible.name}))
        vRP.EXT.Base.remote._playAnim(user.source,true,liquid_seq,false)
      SetTimeout(320000,function()
        vRP.EXT.Functions.remote.resetMovement(user.source, false)
        vRP.EXT.Functions.remote.stopShakeGameplayCam(user.source, "DRUNK_SHAKE")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsMichaelAliensFight")
        vRP.EXT.Functions.remote.stopScreenEffect(user.source, "DrugsDrivingIn")
      end)
    end
  end)
end

-- METHODS

function Edible:__construct()
  vRP.Extension.__construct(self)

  self.cfg = module("vrp", "cfg/edibles")

  self.types = {}
  self.effects = {}
  self.edibles = {}

  define_basics(self)

  -- load edibles
  for id, v in pairs(self.cfg.edibles) do
    self:defineEdible(id, v[1], v[2], v[3], v[4], v[5], v[6])
  end

  -- items
  define_items(self)
end

-- id: identifier (string)
-- action_name: (string)
-- on_consume(user, edible)
function Edible:defineType(id, action_name, on_consume)
  if self.types[id] then
    self:log("WARNING: re-defined type \""..id.."\"")
  end

  self.types[id] = {action_name, on_consume}
end

-- id: identifier (string)
-- on_effect(user, value)
function Edible:defineEffect(id, on_effect)
  if self.effects[id] then
    self:log("WARNING: re-defined effect \""..id.."\"")
  end

  self.effects[id] = on_effect
end

-- id: identifier (string)
-- type: edible type
-- effects: map of effect => value
-- name: (string)
-- description: (html)
-- weight
function Edible:defineEdible(id, type, effects, name, description, weight, icon)
  if self.edibles[id] then
    self:log("WARNING: re-defined edible \""..id.."\"")
  end

  self.edibles[id] = {
    type = type, 
    effects = effects, 
    name = name, 
    description = description,
    weight = weight,
    icon = icon
  }
end

function Edible:eatEdible(source, fullid)
	local user = vRP.users_by_source[source]

  local citem = vRP.EXT.Inventory:computeItem(fullid)
  local edible = self.edibles[citem.args[2]]
  local etype = self.types[edible.type]
	local dead = vRP.EXT.Survival.remote.isInComa(user.source)

  -- consume
	if not dead or user:hasPermission("menu.bypass") then
    if user:tryTakeItem(fullid, 1, true) then -- available check
      if user.edible_action:perform(self.cfg.action_delay) then
        user:tryTakeItem(fullid, 1, nil, true) -- consume

        -- menu update
        local namount = user:getItemAmount(fullid)
        if namount > 0 then
          user:actualizeMenu()
        else
          user:closeMenu(menu)
        end

        -- on_consume
        etype[2](user, edible)

        -- effects
        for id, value in pairs(edible.effects) do
          local effect = self.effects[id]
          if effect then
            -- on_effect
            effect(user, value)
          end
        end
      else
        vRP.EXT.Base.remote._notify(user.source, lang.common.must_wait({user.edible_action:remaining()}))
		  end
    end
	else
	  vRP.EXT.Base.remote._notify(user.source, "~r~You cannot Eat while in Coma, Call EMS!")
  end
end

Edible.tunnel = {}

Edible.tunnel.eatEdible = Edible.eatEdible

vRP:registerExtension(Edible)
