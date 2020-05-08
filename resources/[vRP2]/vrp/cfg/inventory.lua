
local cfg = {}

cfg.inventory_weight_per_strength = 10 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

cfg.lose_inventory_on_death = true

-- list of static chest types (map of name => {.title,.map_entity,.weight, .permissions (optional)})
-- map_entity: {ent,cfg} will fill cfg.pos, cfg.title
-- static chests are local to the server
cfg.static_chest_types = {
  ["police_seized"] = {
    title = "Seized chest",
    map_entity = {"PoI", {marker_id = 1}},
    weight = 500,
    permissions = {"police.chest_seized"}
  }
}

-- list of static chest points
cfg.static_chests = {
  {"police_seized", 478.75317382813,-989.27679443359,24.914684295654}, -- Mission Row PD
  {"police_seized", -441.8440246582,5987.5805664063,31.716188430786}, -- Paleto SO
}

return cfg
