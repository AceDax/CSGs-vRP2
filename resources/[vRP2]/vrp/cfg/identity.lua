
local cfg = {}

-- city hall position
cfg.city_hall = {-1043.5628662109,-2747.8525390625,21.363430023193}

-- {ent,cfg} will fill cfg.title, cfg.pos
cfg.city_hall_map_entity = {"PoI", {marker_id = 11, color = {0,255,125,125}}}

-- cost of a new identity
cfg.new_identity_cost = 100

-- phone format (max: 20 chars, use D for a random digit)
cfg.phone_format = "DDD-DDDD"
-- cfg.phone_format = "06DDDDDDDD" -- another example for cellphone in France


-- config the random name generation (first join identity)
-- (I know, it's a lot of names for a little feature)
-- (cf: http://names.mongabay.com/most_common_surnames.htm)
cfg.random_first_names = {
  "Change"
}

cfg.random_last_names = {
  "Me"
}

return cfg
