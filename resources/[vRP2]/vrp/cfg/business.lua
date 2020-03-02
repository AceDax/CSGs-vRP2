
local cfg = {}

-- minimum capital to open a business
cfg.minimum_capital = 25000

-- capital transfer reset interval in minutes
-- default: reset every 24h
cfg.transfer_reset_interval = 24*60

-- {ent,cfg} will fill cfg.title, cfg.pos
cfg.commerce_chamber_map_entity = {"PoI", {marker_id = 1}}

-- positions of commerce chambers
cfg.commerce_chambers = {
  {279.35845947266,-286.68704223633,53.949970245361}
}

return cfg
