--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

RegisterServerEvent((_Prefix.."%s"):format(Events.refreshData))
AddEventHandler(((_Prefix.."%s"):format(Events.refreshData)), function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if (_ClotheConfig.SQLWrapperType) == 1 then
        MySQL.Async.fetchAll('SELECT * FROM clothes_data WHERE identifier = @identifier', {
            ["@identifier"] = xPlayer.identifier
        }, function(result)
            TriggerClientEvent(((_Prefix.."%s"):format(Events.sendData)), _src, result)
        end)
    end
    if (_ClotheConfig.SQLWrapperType) == 2 then
        MySQL.query('SELECT * FROM clothes_data WHERE identifier = ?', {xPlayer.identifier}, function(result)
            TriggerClientEvent(((_Prefix.."%s"):format(Events.sendData)), _src, result)
        end)
    end
end)