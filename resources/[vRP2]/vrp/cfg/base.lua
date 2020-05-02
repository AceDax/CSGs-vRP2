
local cfg = {}

-- mysql credentials
cfg.db = {
  driver = "ghmattimysql",
  host = "127.0.0.1",
  database = "changeme",
  user = "changeme",
  password = "changeme"
}

cfg.server_id = "dev" -- identify the server (ex: in database)

cfg.save_interval = 30 -- seconds
cfg.whitelist = false -- enable/disable whitelist

-- delay the tunnel at loading (for weak connections)
cfg.load_duration = 1 -- seconds, player duration in loading mode at the first spawn
cfg.load_delay = 0 -- milliseconds, delay the tunnel communication when in loading mode
cfg.global_delay = 0 -- milliseconds, delay the tunnel communication when not in loading mode

cfg.ping_check_interval = 0 -- seconds, 0 to disable ping timeout
cfg.ping_timeout_misses = 10 -- number of ping miss required to reject a player

cfg.max_characters = 10 -- maximum number of characters per user
cfg.character_select_delay = 150 -- minimum number of seconds between character selects, at least 30 seconds is recommended

-- identify users only with steam or ros identifiers (solve same ip issue, recommended)
-- if enabled, steam auth should be forced in the FiveM server config
cfg.ignore_ip_identifier = true

cfg.lang = "en"

cfg.log_level = 0 -- maximum verbose level for logs, -1 may disable logs and 1000 may print all logs

return cfg
