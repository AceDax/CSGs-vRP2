  hatsOn = false
  currentHats = nil
  myHats = nil
  hatTexture = nil
  hatsSet = false
  noHats = false

RegisterNetEvent('hats')
AddEventHandler('hats', function()
--[[
  Sets variables for if hats are on and which hats they are
]]--
  local player = GetPlayerPed(-1)
  local currentHats = GetPedPropIndex(player, 0)
  local player = PlayerPedId()
	local dict
	local anim
  if currentHats == -1 and hatsSet == false then
    noHats = true
    hatsSet = false
  elseif currentHats ~= -1 and hatsSet == false then
    myHats = GetPedPropIndex(player, 0)
    hatTexture = GetPedPropTextureIndex(player, 0)
    noHats = false
    hatsSet = true
    hatsOn = true
  elseif currentHats == -1 and hatsSet == true then
    hatsOn = false
  elseif hatsSet == true and currentHats ~= -1 and myHats ~= currentHats then
    myHats = GetPedPropIndex(player, 0)
    hatTexture = GetPedPropTextureIndex(player, 0)
    hatsSet = true
    noHats = false
    hatsOn = true
  end 

--Takes hat off / Puts them On
if not noHats then
  hatsOn = not hatsOn
  if hatsOn then
    dict = "missheist_agency2ahelmet"
    anim = "take_off_helmet_stand"
    RequestAnimDict(dict)
    TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    SetPedPropIndex(player, 0, myHats, hatTexture, 2)
    Wait (500)
	  ClearPedSecondaryTask(player)
    ShowNotification('Hat is on')
  else
    dict = "missheist_agency2ahelmet"
    anim = "take_off_helmet_stand"
    RequestAnimDict(dict)
    TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    ClearPedProp(player, 0)
    Wait (500)
	  ClearPedSecondaryTask(player)
    ShowNotification('Hat is off')
  end
else
  ShowNotification('You are not wearing a hat')
end

end, false)

RegisterCommand('hat', function()
  TriggerEvent('hats')
end)

--Function to show the notification

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
  end

  -----------------------------------------------------------------------------------------

  glassesOn = false
  currentGlasses = nil
  myGlasses = nil
  sgTexture = nil
  glassesSet = false
  noGlasses = false

RegisterNetEvent('sung')
AddEventHandler('sung', function()
--[[
  Sets variables for if sunglasses are on and which sunglasses they are
]]--
  local player = GetPlayerPed(-1)
  local currentGlasses = GetPedPropIndex(player, 1)
  local player = PlayerPedId()
	local dict
	local anim
  if currentGlasses == -1 and glassesSet == false then
    noGlasses = true
    glassesSet = false
  elseif currentGlasses ~= -1 and glassesSet == false then
    myGlasses = GetPedPropIndex(player, 1)
    sgTexture = GetPedPropTextureIndex(player, 1)
    noGlasses = false
    glassesSet = true
    glassesOn = true
  elseif currentGlasses == -1 and glassesSet == true then
    glassesOn = false
  elseif glassesSet == true and currentGlasses ~= -1 and myGlasses ~= currentGlasses then
    myGlasses = GetPedPropIndex(player, 1)
    sgTexture = GetPedPropTextureIndex(player, 1)
    glassesSet = true
    noGlasses = false
    glassesOn = true
  end 

--Takes Glasses off / Puts them On
if not noGlasses then
  glassesOn = not glassesOn
  if glassesOn then
    dict = "clothingspecs" --anim: take_off_helmet_stand
    anim = "take_off"
    RequestAnimDict(dict)
	  TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    SetPedPropIndex(player, 1, myGlasses, sgTexture, 2)
    Wait (500)
	  ClearPedSecondaryTask(player)
    ShowNotification('Sunglasses are on')
  else
    dict = "clothingspecs" --anim: take_off_helmet_stand
    anim = "take_off"
    RequestAnimDict(dict)
	  TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    ClearPedProp(player, 1)
    Wait (500)
	  ClearPedSecondaryTask(player)
    ShowNotification('Sunglasses are off')
  end
else
  ShowNotification('You are not wearing sunglasses')
end

end, false)

RegisterCommand('sg', function()
  TriggerEvent('sung')
end)

-----------------------------------------------------------------------------------------------

maskOn = false
  currentMask = nil
  myMask = nil
  maskTexture = nil
  maskSet = false
  noMask = false

RegisterNetEvent('mask')
AddEventHandler('mask', function()
--[[
  Sets variables for if Mask are on and which mask they are
]]--
  local player = GetPlayerPed(-1)
  local currentMask = GetPedDrawableVariation(player, 1)
  local player = PlayerPedId()
	local dict
	local anim
  if currentMask == 0 and maskSet == false then
    noMask = true
    maskSet = false
  elseif currentMask ~= 0 and maskSet == false then
    myMask = GetPedDrawableVariation(player, 1)
    maskTexture = GetPedTextureVariation(player, 1)
    noMask = false
    maskSet = true
    maskOn = true
  elseif currentMask == 0 and maskSet == true then
    maskOn = false
  elseif maskSet == true and currentMask ~= 0 and myMask ~= currentMask then
    myMask = GetPedDrawableVariation(player, 1)
    maskTexture = GetPedTextureVariation(player, 1)
    maskSet = true
    noMask = false
    maskOn = true
  end 

--Takes Mask off / Puts them On
if not noMask then
  maskOn = not maskOn
  if maskOn then
    dict = "misscommon@std_take_off_masks"
    anim = "take_off_mask_ps"
    RequestAnimDict(dict)
    TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    SetPedComponentVariation(player, 1, myMask, maskTexture, 0)
    Wait (500)
	  ClearPedSecondaryTask(player)
    ShowNotification('Mask on')
  else
    dict = "missfbi4"
    anim = "takeoff_mask"
    RequestAnimDict(dict)
    TaskPlayAnim( player, dict, anim, 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    SetPedComponentVariation(player, 1, 0, 0, 0)
    Wait (500)
	  ClearPedSecondaryTask(player)
    ShowNotification('Mask off')
  end
else
  ShowNotification('You are not wearing a Mask')
end

end, false)

RegisterCommand('mask', function()
  TriggerEvent('mask')
end)