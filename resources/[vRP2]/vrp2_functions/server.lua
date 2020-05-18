htmlEntities = module("vrp", "lib/htmlEntities")


local lcfg = module("vrp", "cfg/base")
Luang = module("vrp", "lib/Luang")
Lang = Luang()

Lang:loadLocale(lcfg.lang, module("vrp", "cfg/lang/"..lcfg.lang) or {})
lang = Lang.lang[lcfg.lang]

local Functions = class("Functions", vRP.Extension)

function Functions:specialFunction(source, data, value)
    local user = vRP.users_by_source[source]
    local dead = vRP.EXT.Survival.remote.isInComa(user.source)

    if data == "money" then
        vRP.EXT.Money:unPack(user.source, value) 

    elseif data == "money_binder" then
        vRP.EXT.Money:bindMoney(user.source, value)


    elseif data == "repairkit" then
	    if not self:isMechAllowed() or user:hasPermission("mech.chest") then	
            if user:tryTakeItem("repairkit",1) then
                vRP.EXT.Base.remote._playAnim(user.source,false,{task="WORLD_HUMAN_WELDING"},false) --planning on changing the animation later
                SetTimeout(7000, function()
                    vRP.EXT.Garage.remote._fixNearestVehicle(user.source,10)
                    vRP.EXT.Base.remote._stopAnim(user.source,false)	
                end)
			end
		else
		    vRP.EXT.Base.remote._notify(user.source,"~b~There is a mechanic online")
        end

    elseif data == "bandage" then
        local revive_seq = {
            {"amb@medic@standing@kneel@idle_a","idle_a",1},
        }
        if user:hasPermission("ems.items") or user:hasPermission("police.askid") or user:hasPermission("admin.extras") and not dead then

            local nuser
            local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source, 10)

            if nplayer then
                nuser = vRP.users_by_source[nplayer]
            end

            if nuser then
                if not vRP.EXT.Survival.remote.isInComa(nuser.source) then
                    if user:tryTakeItem("bandage", 1) then
                        vRP.EXT.Base.remote._notify(user.source,"~g~Applying a bandage.")
					    vRP.EXT.Base.remote._playAnim(user.source,false,{{"mp_arresting", "a_uncuff",5}},true) -- anim
                        Wait(15000)
                        vRP.EXT.Survival.remote._varyHealth(nuser.source, 10)
					    vRP.EXT.Base.remote._stopAnim(user.source,true) -- upper
						vRP.EXT.Base.remote._stopAnim(user.source,false) -- full
					end
                else
                    vRP.EXT.Base.remote._notify(user.source, "~r~A bandage won't help this person.")
                end
            else
                vRP.EXT.Base.remote._notify(user.source, "~r~No Person near you.")
			end
        else
            vRP.EXT.Base.remote._notify(user.source, "~r~You currently don't have permission to use this item.")
        end

    elseif data == "medkit" then	

        local revive_seq = {
            {"amb@medic@standing@kneel@enter","enter",1},
            {"amb@medic@standing@kneel@idle_a","idle_a",1},
	        {"missheistfbi3b_ig8_2", "cpr_loop_paramedic", 6},
            {"amb@medic@standing@kneel@exit","exit",1}
        }


        if user:hasPermission("ems.items") or user:hasPermission("police.askid") or user:hasPermission("admin.extras") and not dead then
  
            local nuser
            local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source,10)
            if nplayer then 
                nuser = vRP.users_by_source[nplayer] 
            end
            if nuser then
                if vRP.EXT.Survival.remote.isInComa(nuser.source) then
	                if user:tryTakeItem("medkit",1, true) then
	                    vRP.EXT.Base.remote._notify(user.source,"Asking for consent to administer first aid...")
	                    if nuser:request("Do you want to receive first aid?", 15) then
	  
                            if user:tryTakeItem("medkit",1) then
                                vRP.EXT.Base.remote._playAnim(user.source,false,{{"amb@medic@standing@kneel@idle_a","idle_a",1}},true) -- anim
		                        Wait(500)
		                        vRP.EXT.Base.remote._playAnim(user.source, true, {{"missheistfbi3b_ig8_2", "cpr_loop_paramedic", 3}}, false)
                                SetTimeout(16000, function()
                                    vRP.EXT.Survival.remote._varyHealth(nuser.source,25) -- heal 50
			                        vRP.EXT.Base.remote._stopAnim(user.source,true) -- upper
			                        vRP.EXT.Base.remote._stopAnim(user.source,false) -- full
                                end)
                            end
                        else
                            vRP.EXT.Base.remote._notify(user.source,"~r~This person refused first aid.")
		                    vRP.EXT.Base.remote._notify(nuser.source,"~r~You refused first aid.")
                        end
	                else
                        vRP.EXT.Base.remote._notify(user.source,"~r~Missing Medkit")
	                end
                else
                    vRP.EXT.Base.remote._notify(user.source,lang.emergency.menu.revive.not_in_coma())
	            end
	        else
                vRP.EXT.Base.remote._notify(user.source,lang.common.no_player_near())
            end
	    else
            vRP.EXT.Base.remote._notify(user.source, "~r~You currently don't have permission to use this item.")
        end
 
	
    elseif data == "lockpick" then
        if user:tryTakeItem("lockpick", 1, true) or user:hasPermission("item.bypass") then
            self.remote.lockpickVehicle(user.source, 20, true)
		else
		    vRP.EXT.Base.remote._notify(user.source, "~r~No lockpick in inventory")
        end
	end
end

function Functions:isMechAllowed()
    for _, user in pairs(vRP.users) do
        if user:isReady() and user:hasPermission("mech.chest") then
            return true
		else 
			return false
        end
    end	
end	

vRP:registerExtension(Functions)