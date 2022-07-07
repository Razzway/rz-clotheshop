--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_ClotheConfig.getESX, function(obj) ESX = obj end)
        Wait(10)
    end
end)