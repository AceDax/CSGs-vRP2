-- client-side vRP configuration
-- (loaded client-side)

local cfg = {}

cfg.iplload = true

-- cfg.voice_proximity = 30.0 -- default voice proximity (outside)
-- cfg.voice_proximity_vehicle = 5.0
-- cfg.voice_proximity_inside = 9.0

cfg.push_to_talk_end_delay = 500 -- milliseconds

cfg.audio_listener_rate = 15 -- audio listener position update rate

cfg.audio_listener_on_player = false -- set the listener position on the player instead of the camera

cfg.gui = {
  anchor_minimap_width = 270,
  anchor_minimap_left = 29,
  anchor_minimap_bottom = 18
}

cfg.default_menu = true -- if false, will disable the default menu

-- gui controls (see https://wiki.fivem.net/wiki/Controls)
-- recommended to keep the default values and ask players to change their keys
cfg.controls = {
  phone = {
    -- PHONE CONTROLS
    up = {3,172},
    down = {3,173},
    left = {3,174},
    right = {3,175},
    select = {3,176},
    cancel = {3,177},
    open = {3,311}, -- K, open general menu
  },
  request = {
    yes = {1,96}, -- Numbpad+
    no = {1,97} -- Numbpad-
  },
  radio = {1,288}, -- team chat (F1)
  survival = {
    leave_coma = {0, 22} -- jump
  }
}

-- disable menu if handcuffed
cfg.handcuff_disable_menu = true

-- when health is under the threshold, player is in coma
-- set to 0 to disable coma
cfg.coma_threshold = 105

-- minimum duration of the coma in minutes (can be 0)
cfg.coma_min_duration = 3

-- maximum duration of the coma in minutes
cfg.coma_max_duration = 30


-- if true, a player in coma will not be able to open the main menu
cfg.coma_disable_menu = true

-- see https://wiki.fivem.net/wiki/Screen_Effects
cfg.coma_effect = "DeathFailMPIn"

return cfg
