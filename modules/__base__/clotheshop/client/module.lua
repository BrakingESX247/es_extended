-- Copyright (c) Jérémie N'gadi
--
-- All rights reserved.
--
-- Even if 'All rights reserved' is very clear :
--
--   You shall not use any piece of this software in a commercial product / service
--   You shall not resell this software
--   You shall not provide any facility to install this particular software in a commercial product / service
--   If you redistribute this software, you must link to ORIGINAL repository at https://github.com/ESX-Org/es_extended
--   This copyright should appear in every part of the project code

-- Locals
local Input = M('input')
local Interact = M('interact')
local camera = M("camera")
local utils = M('utils')
M('ui.menu')

on('ui.menu.mouseChange', function(value)
	if module.openedMenu then
		camera.setMouseIn(value)
	end
end)

-- Properties
module.Config = run('data/config.lua', {vector3 = vector3})['Config']

module.Init = function()

  module.RegisterControls()

  local translations = run('data/locales/' .. Config.Locale .. '.lua')['Translations']
  LoadLocale('clotheshop', Config.Locale, translations)

  for j, v in pairs(module.Config.Shops) do

    for k, v in pairs(v) do

      for m, n in pairs(v) do

        local key = 'clotheshop:' .. j .. ':' .. k .. ':' .. m
        print(key)

        Interact.Register({
          name = key,
          type = 'marker',
          distance = module.Config.DrawDistance,
          radius = 1.0,
          pos = n.Pos,
          heading = n.Heading,
          size = module.Config.Size.z,
          mtype = module.Config.Type,
          color = module.Config.Color,
          rotate = true,
          clothes = k,
          store = j
        })

        on('esx:interact:enter:' .. key, function(data)

          Interact.ShowHelpNotification(_U('clotheshop:press_menu', data.clothes, data.store))

          module.CurrentAction = function()
            module.openedMenu(data.store, data.clothes, data.pos, data.heading)
          end
    
          isExit = false

        end)
    
        on('esx:interact:exit:' .. key, function(data)

          module.CurrentAction = nil
          Interact.StopHelpNotification()

          isExit = true

        end)
        
      end 

    end

  end

  for k, v in pairs(module.Config.EnterOrExitShops) do
    local key = 'clotheshop:' .. k

    Interact.Register({
      name = key,
      type = 'marker',
      distance = module.Config.DrawDistance,
      radius = 2.0,
      pos = v,
      size = module.Config.Size.z,
      mtype = module.Config.Type,
      color = {r = 0, g = 0, b = 0, a = 0},
      rotate = true,
      door = k
    })

    on('esx:interact:exit:' .. key, function(data)

      module.ForceWalk()

    end)

  end

  for k,v in pairs(module.Config.EnterOrExitShops) do
    if v ~= nil then
			local blip = AddBlipForCoord(v)

			SetBlipSprite(blip, 73)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 1.0)
      SetBlipColour(blip, 47)
      SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('clotheshop:clothes'))
      EndTextCommandSetBlipName(blip)
    end
  end
end

module.openedMenu = function(store, clothes, pos, heading)
  Interact.StopHelpNotification()

  TaskGoStraightToCoord(PlayerPedId(), pos.x, pos.y, pos.z, 0.5, 2000, heading, 0)
  
  module.startcamera(SKEL_ROOT)

  local menu = Menu('clotheshop', {
    float = 'top|left',
    title = store .. ' - ' .. clothes,
    items = {
      {name = 'select', label = clothes, type = 'slider'},
      {name = 'close', label = 'Close', type = 'button'},
    }
  })

  menu:on('item.click', function(item, index)

    if item.name == 'close' then
      menu:destroy()
      module.stopanim()
      camera.stop()

      if not isExit then
        Interact.ShowHelpNotification(_U('clotheshop:press_menu', clothes, store))
        
        module.CurrentAction = function()
          module.openedMenu(store, clothes, pos)
        end

      end

    end

  end)

end

module.RegisterControls = function()
  Input.RegisterControl(Input.Groups.MOVE, Input.Controls.PICKUP)
  Input.RegisterControl(Input.Groups.MOVE, Input.Controls.REPLAY_SHOWHOTKEY)
  Input.RegisterControl(Input.Groups.MOVE, Input.Controls.SPRINT)
  Input.RegisterControl(Input.Groups.MOVE, Input.Controls.JUMP)
end

module.stopanim = function()
  local playerPed = PlayerPedId()
  ClearPedTasks(playerPed)
end

module.startcamera = function(bone)
  camera.start()

  local ped       = GetPlayerPed(-1)
  local pedCoords = GetEntityCoords(ped)
  local forward   = GetEntityForwardVector(ped)

  camera.setRadius(2.25)
  camera.setCoords(pedCoords + forward * 1.25)
  camera.setPolarAzimuthAngle(utils.math.world3DtoPolar3D(pedCoords, pedCoords + forward * 1.25))
  camera.pointToBone(bone, vector3(0.0,0.0,0.0))
end

module.ForceWalk = function()
  local playerPed = PlayerPedId()
  local interiorId = GetInteriorFromEntity(playerPed)
  
  if interiorId == 198145 or interiorId == 165633 or interiorId == 235265 or interiorId == 169217 then
    if Input.IsControlEnabled(Input.Groups.MOVE, Input.Controls.SPRINT) then
      Input.DisableControl(Input.Groups.MOVE, Input.Controls.SPRINT)
      Input.DisableControl(Input.Groups.MOVE, Input.Controls.JUMP)
    end
  
  elseif not Input.IsControlEnabled(Input.Groups.MOVE, Input.Controls.SPRINT) then
    Input.EnableControl(Input.Groups.MOVE, Input.Controls.SPRINT)
    Input.EnableControl(Input.Groups.MOVE, Input.Controls.JUMP)
    print('shift enable')
  end
end