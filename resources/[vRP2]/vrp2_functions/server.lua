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
                vRP.EXT.Base.remote._playAnim(user.source,false,{task="WORLD_HUMAN_WELDING"},false)
                SetTimeout(7000, function()
                    vRP.EXT.Garage.remote._fixNearestVehicle(user.source,10)
                    vRP.EXT.Base.remote._stopAnim(user.source,false)	
                end)
			end
		else
		    vRP.EXT.Base.remote._notify(user.source,"~b~There is a mechanic online")
        end

    elseif data == "aidkit" then
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
                    if user:tryTakeItem("aidkit", 1) then
					    vRP.EXT.Base.remote._playAnim(user.source,false,{{"amb@medic@standing@kneel@idle_a","idle_a",1}},true) -- anim
                        Wait(5000)
                        vRP.EXT.Survival.remote._varyHealth(nuser.source, 100)
					    vRP.EXT.Base.remote._stopAnim(user.source,true) -- upper
						vRP.EXT.Base.remote._stopAnim(user.source,false) -- full
					end
                else
                    vRP.EXT.Base.remote._notify(user.source, "~r~This person needs to be revived first!")
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
 

    elseif data == "cigs" then
	    if not dead  then	
	
	        if user:hasPermission("!item.cigs.>0") and user:hasPermission("!item.lighter.>0") then
		        user:tryTakeItem("cigs", 1)

                vRP.EXT.Survival.remote._varyHealth(user.source, 25)
                vRP.EXT.Base.remote._notify(user.source, "~g~Smoking a cig.")

		        vRP.EXT.Base.remote._playAnim(user.source, false, {task="WORLD_HUMAN_SMOKING"}, false)
			    SetTimeout(15000, function()
			        vRP.EXT.Base.remote._stopAnim(user.source,false)
			        user:varyExp("physical", "addiction", 0.10)			
                end)
	        else
	            vRP.EXT.Base.remote._notify(user.source, "You need a Lighter and a Cigarette to smoke a cig")
            end
	    else
	        vRP.EXT.Base.remote._notify(user.source, "~r~You cannot consume while in Coma, Call EMS!")
        end	
	
    elseif data == "rolly" then
	    if not dead then	
	        if user:tryTakeItem("rolly", 1,true) and user:tryTakeItem("weed", 1,true) then 
		        user:tryTakeItem("rolly",1) user:tryTakeItem("weed",1)
		        user:tryGiveItem("joint", 1)		
	        else
	            vRP.EXT.Base.remote._notify(user.source, "You need a Rolling papers and Weed to roll a joint.")
            end
	    else
	        vRP.EXT.Base.remote._notify(user.source, "~y~Can't do much when you are in a coma!")
        end

    elseif data == "joint" or data == "weed" then
	    if not dead then	
	        if user:tryTakeItem("joint", 1,true) and user:tryTakeItem("lighter", 1,true) then
		        user:tryTakeItem("joint", 1)
                vRP.EXT.Survival.remote._varyHealth(user.source, 5)
                vRP.EXT.Base.remote._notify(user.source, "~g~Smoking a joint.")
                local seq = {
                    {"mp_player_int_uppersmoke", "mp_player_int_smoke_enter", 1}, 
                    {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, 
                    {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, 
                    {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1}, 
                    {"mp_player_int_uppersmoke", "mp_player_int_smoke_exit", 1}
                }
                vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
			    SetTimeout(3000, function()
                    self.remote.playMovement(user.source, "move_p_m_zero_slow","Male slow", true, true, false, false)
                    --self.remote.playScreenEffect(user.source, "DrugsDrivingIn", 120)
			        user:varyExp("physical", "addiction", 0.05)
			        self.remote.playerSpeed(user.source, 0.5)
                end)
                SetTimeout(3000, function()
			        self.remote.playerSpeed(user.source, 1.0)
                    self.remote.resetMovement(user.source, false)
                end)
	        else
	            vRP.EXT.Base.remote._notify(user.source, "You need to roll a joint and have a lights to smoke weed.")
            end
	    else
	        vRP.EXT.Base.remote._notify(user.source, "~y~Can't do much when you are in a coma!")
        end	
	
    elseif data == "vodka" then
	    if not dead  then	
            if user:tryTakeItem("vodka",1) then
                user:varyVital("food",30)
                user:varyVital("water",30)
  		        vRP.EXT.Survival.remote._varyHealth(user.source, 25)
			    user:closeMenus()

                vRP.EXT.Base.remote._notify(user.source, "~b~Drinking Vodka.")
                local seq = {
                    {"mp_player_intdrink","intro_bottle",1},
                    {"mp_player_intdrink","loop_bottle",1},
                    {"mp_player_intdrink","outro_bottle",1}
                }
                vRP.EXT.Base.remote._playAnim(user.source, true,seq,false)
			    SetTimeout(5000,function()
			        self.remote.playMovement(user.source,"MOVE_M@DRUNK@VERYDRUNK",true,true,false,false)
			        self.remote.playScreenEffect(user.source, "Rampage", 120)
			        self.remote.playerSpeed(user.source, 0.5)
			        user:varyExp("physical", "addiction", 0.08)
			    end)
			    SetTimeout(120000,function()
			        self.remote.playerSpeed(user.source, 1.0)
			        self.remote.resetMovement(user.source,false)
                end)
            end
	    else
	        vRP.EXT.Base.remote._notify(user.source, "~r~You cannot consume while in Coma, Call EMS!")
        end	
	
    elseif data == "meth" or data == "methpipe" then
	    if not dead  then	
	        if user:hasPermission("!item.meth.>0") and user:hasPermission("!item.lighter.>0") and user:hasPermission("!item.methpipe.>0") then 
		        user:tryTakeItem("meth",1)
		        user:closeMenus()
                vRP.EXT.Survival.remote._varyHealth(user.source, -1)
                vRP.EXT.Base.remote._notify(user.source, "~g~Smoking meth.")
                local seq = {
                    {"mp_player_intdrink","intro_bottle",1},
                    {"mp_player_intdrink","loop_bottle",1},
                    {"mp_player_intdrink","outro_bottle",1}
                }
                vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
			    SetTimeout(4000, function()
                    -- self.remote.playMovement(user.source, "FEMALE_FAST_RUNNER", true, true, false, false)
                    self.remote.playScreenEffect(user.source, "RaceTurbo", 120)
			        self.remote.playerSpeed(user.source, 1.5)
			        user:varyExp("physical", "addiction", 0.1)
                end)
                SetTimeout(120000, function()
			        self.remote.playerSpeed(user.source, 1.0)
                    self.remote.resetMovement(user.source, false)
                end)
	        else
	            vRP.EXT.Base.remote._notify(user.source, "You need a Meth pipe, Lighter and Meth to smoke meth")
            end
	    else
	        vRP.EXT.Base.remote._notify(user.source, "~r~You cannot consume while in Coma, Call EMS!")
        end	

        --------------LSD needs to be reworked--------------

    -- elseif data == "lsd" then
	--     if not dead  then	
	--         if user:hasPermission("!item.lsd.>0") then 
	--             if self.remote.notTripping(user.source) then 
	--                 user:closeMenus()
	--                 user:tryTakeItem("lsd",1)
	--                 self.remote.isTripping(user.source)	
	-- 	            TriggerClientEvent("acidtrip:startTrip", user.source)
    --                 --vRP.EXT.Survival.remote._varyHealth(user.source, 25)
    --                 vRP.EXT.Base.remote._notify(user.source, "~b~You just ate some Pure LSD-52.")
    --                 --[[  local seq = {
    --                     {"mp_player_intdrink","intro_bottle",1},
    --                     {"mp_player_intdrink","loop_bottle",1},
    --                     {"mp_player_intdrink","outro_bottle",1}
    --                 }
    --                 vRP.EXT.Base.remote._playAnim(user.source, true, seq, false)
	-- 		        SetTimeout(4000, function()
    --                     self.remote.playMovement(user.source, "move_f@scared", true, true, false, false)
    --                     self.remote.playScreenEffect(user.source, "PeyoteEndOut", 120)
    --                     self.remote.playScreenEffect(user.source, "FocusOut", 120)	
	-- 		            user:varyExp("physical", "addiction", 0.05)
    --                 end)
    --                 SetTimeout(120000, function()
    --                     self.remote.resetMovement(user.source, false)
    --                 end) ]]
	-- 	        else
	--                 vRP.EXT.Base.remote._notify(user.source, "~y~You are still under the influence of LSD.")
    --             end	
	--         else
	--             vRP.EXT.Base.remote._notify(user.source, "You need LSD to take a hit")
    --         end
	--     else
	--         vRP.EXT.Base.remote._notify(user.source, "~r~You cannot consume while in Coma, Call EMS!")
    --     end	

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