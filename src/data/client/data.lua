--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

---@class Razzway
Razzway = {};
Razzway.data = {};

---@type function Razzway:refreshData
function Razzway:refreshData()
    TriggerServerEvent((_Prefix.."%s"):format(Events.refreshData))
end

RegisterNetEvent((_Prefix.."%s"):format(Events.sendData))
AddEventHandler(((_Prefix.."%s"):format(Events.sendData)), function(data)
    Razzway.data = data
end)