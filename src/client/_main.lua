--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

local function initBlips()
    for _,clothes in pairs(_ClotheConfig.Handler.positions.mainZone) do
        local blip = AddBlipForCoord(clothes.pos)
        SetBlipSprite(blip, _ClotheConfig.Handler.positions.infoBlip.Sprite)
        SetBlipDisplay(blip, _ClotheConfig.Handler.positions.infoBlip.Display)
        SetBlipScale(blip, _ClotheConfig.Handler.positions.infoBlip.Scale)
        SetBlipColour(blip, _ClotheConfig.Handler.positions.infoBlip.Color)
        SetBlipAsShortRange(blip, _ClotheConfig.Handler.positions.infoBlip.Range)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_ClotheConfig.Handler.positions.infoBlip.Name)
        EndTextCommandSetBlipName(blip)
    end
end

local function initPeds()
    for _, ped in pairs(_ClotheConfig.Handler.positions.mainZone) do
        while (not HasModelLoaded(ped.pedModel)) do
            RequestModel(ped.pedModel)
            Wait(1)
        end
        local nwPed = CreatePed(2, GetHashKey(ped.pedModel), ped.pedPos, ped.heading, 0, 0)
        FreezeEntityPosition(nwPed, 1)
        if _ClotheConfig.Handler.scenarioPed then
            TaskStartScenarioInPlace(nwPed, _ClotheConfig.Handler.scenarioName, 0, false)
        end
        SetEntityInvincible(nwPed, true)
        SetBlockingOfNonTemporaryEvents(nwPed, 1)
    end
end


CreateThread(function()
    if (_ClotheConfig.Handler.showBlip) then initBlips() end
    if (_ClotheConfig.Handler.showPeds) then initPeds() end
    while (true) do
        local interval = 750

        for _,v in pairs(_ClotheConfig.Handler.positions.mainZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 15.0 then
                interval = 0
                DrawMarker(1, interactionPos.x, interactionPos.y, interactionPos.z-0.9, 0, 0, 0, _ClotheConfig.markerGetter.Rotation, nil, nil, 2.5, 2.5, 0.9, _ClotheConfig.markerGetter.Color[1], _ClotheConfig.markerGetter.Color[2], _ClotheConfig.markerGetter.Color[3], 270, 0, 1, 0, 0, nil, nil, 0)
            end
            if #(pCoords-interactionPos) < 2.0 then
                ESX.ShowHelpNotification("∑ ~b~Magasin de vêtements~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(0, 54) then
                    Utils:loadSkin()
                    Razzway:refreshData()
                    CHelper.PoolMenus:main()
                end
            end
        end

        for _,v in pairs(_ClotheConfig.Handler.positions.glassesZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_ClotheConfig.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _ClotheConfig.miniMarkerGetter.Rotation, nil, nil, _ClotheConfig.miniMarkerGetter.Size[1], _ClotheConfig.miniMarkerGetter.Size[2], _ClotheConfig.miniMarkerGetter.Size[3], _ClotheConfig.miniMarkerGetter.Color[1], _ClotheConfig.miniMarkerGetter.Color[2], _ClotheConfig.miniMarkerGetter.Color[3], 270, 1, 0, 0, 2)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("∑ ~b~Magasin de vêtements - Lunettes~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(0, 54) then
                    Utils:loadSkin()
                    CHelper.PoolMenus:glasses()
                end
            end
        end

        for _,v in pairs(_ClotheConfig.Handler.positions.helmetZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_ClotheConfig.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _ClotheConfig.miniMarkerGetter.Rotation, nil, nil, _ClotheConfig.miniMarkerGetter.Size[1], _ClotheConfig.miniMarkerGetter.Size[2], _ClotheConfig.miniMarkerGetter.Size[3], _ClotheConfig.miniMarkerGetter.Color[1], _ClotheConfig.miniMarkerGetter.Color[2], _ClotheConfig.miniMarkerGetter.Color[3], 270, 1, 0, 0, 2)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("∑ ~b~Magasin de vêtements - Casques~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(0, 54) then
                    Utils:loadSkin()
                    CHelper.PoolMenus:helmet()
                end
            end
        end

        for _,v in pairs(_ClotheConfig.Handler.positions.earsZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_ClotheConfig.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _ClotheConfig.miniMarkerGetter.Rotation, nil, nil, _ClotheConfig.miniMarkerGetter.Size[1], _ClotheConfig.miniMarkerGetter.Size[2], _ClotheConfig.miniMarkerGetter.Size[3], _ClotheConfig.miniMarkerGetter.Color[1], _ClotheConfig.miniMarkerGetter.Color[2], _ClotheConfig.miniMarkerGetter.Color[3], 270, 1, 0, 0, 2)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("∑ ~b~Magasin de vêtements - Oreilles~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(0, 54) then
                    Utils:loadSkin()
                    CHelper.PoolMenus:ears()
                end
            end
        end

        for _,v in pairs(_ClotheConfig.Handler.positions.chainZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_ClotheConfig.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _ClotheConfig.miniMarkerGetter.Rotation, nil, nil, _ClotheConfig.miniMarkerGetter.Size[1], _ClotheConfig.miniMarkerGetter.Size[2], _ClotheConfig.miniMarkerGetter.Size[3], _ClotheConfig.miniMarkerGetter.Color[1], _ClotheConfig.miniMarkerGetter.Color[2], _ClotheConfig.miniMarkerGetter.Color[3], 270, 1, 0, 0, 2)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("∑ ~b~Magasin de vêtements - Chaines~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(0, 54) then
                    Utils:loadSkin()
                    CHelper.PoolMenus:chain()
                end
            end
        end

        for _,v in pairs(_ClotheConfig.Handler.positions.watchesZone) do
            local pCoords, interactionPos = GetEntityCoords(PlayerPedId()), v.pos
            if #(pCoords-interactionPos) < 10.0 then
                interval = 0
                DrawMarker(_ClotheConfig.miniMarkerGetter.Type, interactionPos.x, interactionPos.y, interactionPos.z-0.4, 0, 0, 0, _ClotheConfig.miniMarkerGetter.Rotation, nil, nil, _ClotheConfig.miniMarkerGetter.Size[1], _ClotheConfig.miniMarkerGetter.Size[2], _ClotheConfig.miniMarkerGetter.Size[3], _ClotheConfig.miniMarkerGetter.Color[1], _ClotheConfig.miniMarkerGetter.Color[2], _ClotheConfig.miniMarkerGetter.Color[3], 270, 1, 0, 0, 2)
            end
            if #(pCoords-interactionPos) < 1.0 then
                ESX.ShowHelpNotification("∑ ~b~Magasin de vêtements - Montres~s~ \nAppuyez sur ~INPUT_CONTEXT~ pour intéragir.")
                if IsControlJustReleased(0, 54) then
                    Utils:loadSkin()
                    CHelper.PoolMenus:watches()
                end
            end
        end

        Wait(interval)
    end
end)

RegisterNetEvent((_Prefix.."%s"):format(Events.saveSkin))
AddEventHandler(((_Prefix.."%s"):format(Events.saveSkin)), function()
    TriggerEvent(_ClotheConfig.skinchangerEvent..':getSkin', function(skin)
        TriggerServerEvent(_ClotheConfig.skinEvent..':save', skin)
    end)
end)

RegisterNetEvent((_Prefix.."%s"):format(Events.closeAll))
AddEventHandler(((_Prefix.."%s"):format(Events.closeAll)), function()
    isMenuOpen = false
    Utils:KillCam()
    RageUI.CloseAll()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end)

-- << Crédits >> --

VERSION = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

print(
        "^0======================================================================^7\n" ..
        ("^0[^1Script^0]^7 :^0 ^6%s^7\n"):format(GetCurrentResourceName()) ..
        "^0[^4Author^0]^7 :^0 ^2Razzway^7\n" ..
        ("^0[^3Version^0]^7 :^0 ^0%s^7\n"):format(VERSION) ..
        "^0[^2Download^0]^7 :^0 ^5https://discord.gg/EtWdxsCv94^7\n" ..
        "^0======================================================================^7"
)