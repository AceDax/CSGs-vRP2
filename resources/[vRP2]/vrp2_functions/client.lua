local Functions = class("Functions", vRP.Extension)

-- MOVEMENT CLIPSET
function Functions:playMovement(clipset,blur,drunk,fade,clear)
    --request anim
    RequestAnimSet(clipset)
    while not HasAnimSetLoaded(clipset) do
      Citizen.Wait(0)
    end
    -- fade out
    if fade then
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
    end
    -- clear tasks
    if clear then
      ClearPedTasksImmediately(GetPlayerPed(-1))
    end
    -- set timecycle
    SetTimecycleModifier("spectator5")
    -- set blur
    if blur then 
      SetPedMotionBlur(GetPlayerPed(-1), true) 
    end
    -- set movement
    SetPedMovementClipset(GetPlayerPed(-1), clipset, true)
    -- set drunk
    if drunk then
      SetPedIsDrunk(GetPlayerPed(-1), true)
    end
    -- fade in
    if fade then
      DoScreenFadeIn(1000)
    end
end

-- play a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
-- duration: in seconds, if -1, will play until stopScreenEffect is called
function Functions:playScreenEffect(name, duration)
    if duration < 0 then -- loop
        StartScreenEffect(name, 0, true)
    else
        StartScreenEffect(name, 0, true)
  
        Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
            Citizen.Wait(math.floor((duration+1)*1000))
            StopScreenEffect(name)
        end)
    end
end

-- stop a screen effect
-- name, see https://wiki.fivem.net/wiki/Screen_Effects
function Functions:stopScreenEffect(name)
  StopScreenEffect(name)
end

function Functions:playerSpeed(speed)
    self.speed = not self.speed
    self.playerspeed = speed
end

function Functions:resetMovement(fade)
    -- fade
    if fade then
      DoScreenFadeOut(1000)
      Citizen.Wait(1000)
      DoScreenFadeIn(1000)
    end
    -- reset all
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
end

--LOCK PICK MENU
function Functions:lockpickVehicle(wait,any)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    if DoesEntityExist(vehicleHandle) then
        if GetVehicleDoorsLockedForPlayer(vehicleHandle,PlayerId()) or any then
            local prevObj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, GetHashKey("prop_weld_torch"), false, true, true)
            if(IsEntityAnObject(prevObj)) then
                SetEntityAsMissionEntity(prevObj)
                DeleteObject(prevObj)
            end
            self.remote._takePick()
            StartVehicleAlarm(vehicleHandle)
            TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)

            Citizen.Wait(wait*1000)
            SetVehicleDoorsLocked(vehicleHandle, 1)
            for i = 1,64 do 
                SetVehicleDoorsLockedForPlayer(vehicleHandle, GetPlayerFromServerId(i), false)
            end 
            ClearPedTasksImmediately(GetPlayerPed(-1))
        
            vRP.EXT.Base:notify("Success") 
        
        else
            vRP.EXT.Base:notify("Unlocked") 
        end
    else
        vRP.EXT.Base:notify("Not close enough") 
    end
end

function Functions:DoAcid()
  exports["acidtrip"]:DoAcid(600000)
end

-- shake game play cam
-- duration: in seconds, if -1, will play until stopShakeGameplayCam is called
function Functions:startShakeGameplayCam(type, intensity, duration)
  if duration < 0 then -- loop
    ShakeGameplayCam(type, intensity)
  else
    ShakeGameplayCam(type, intensity)

    Citizen.CreateThread(function() -- force stop the screen effect after duration+1 seconds
      Citizen.Wait(math.floor((duration+1)*1000))
      ShakeGameplayCam(type, 0.0)
    end)
  end
end

-- stop shake game play cam
function Functions:stopShakeGameplayCam(type)
  ShakeGameplayCam(type, 0.0)
end

Functions.tunnel = {}

Functions.tunnel.playMovement = Functions.playMovement
Functions.tunnel.playScreenEffect = Functions.playScreenEffect
Functions.tunnel.stopScreenEffect = Functions.stopScreenEffect
Functions.tunnel.playerSpeed = Functions.playerSpeed
Functions.tunnel.resetMovement = Functions.resetMovement
Functions.tunnel.lockpickVehicle = Functions.lockpickVehicle

Functions.tunnel.DoAcid = Functions.DoAcid

Functions.tunnel.startShakeGameplayCam = Functions.startShakeGameplayCam
Functions.tunnel.stopShakeGameplayCam = Functions.stopShakeGameplayCam

vRP:registerExtension(Functions)	