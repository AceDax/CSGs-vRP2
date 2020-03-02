
local cfg = {}

cfg.inventory_weight_per_strength = 10 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

cfg.lose_inventory_on_death = true

-- list of static chest types (map of name => {.title,.map_entity,.weight, .permissions (optional)})
-- map_entity: {ent,cfg} will fill cfg.pos, cfg.title
-- static chests are local to the server
cfg.static_chest_types = {
  ["police_seized"] = {
    title = "Seized chest",
    map_entity = {"PoI", {blip_id = 374, blip_color = 38, marker_id = 1}},
    weight = 500,
    permissions = {"police.chest_seized"}
  }
}

-- list of static chest points
cfg.static_chests = {
  {"police_seized", 478.87994384766,-989.26000976563,24.914716720581}, -- Mission Row PD
}

return cfg
