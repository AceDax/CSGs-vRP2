local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")

async(function()
  vRP.loadScript("vrp2_functions", "client")
end)