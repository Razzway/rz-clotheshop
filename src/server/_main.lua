--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

function _Server:getPrice(type)
    if (type) == "clothes" then
        price = _ClotheConfig.Handler.clothesPrice
        return price
    end
    if (type) == "accessories" then
        price = _ClotheConfig.Handler.accessoriesPrice
        return price
    end
end

local messages = {
    [1] = "Wouaw ! Te voilà tout frais !",
    [2] = "Cette tenue te va à ravir !",
    [3] = "Tu respires le flow !"
}

RegisterServerEvent((_Prefix.."%s"):format(Events.saveOutfit))
AddEventHandler(((_Prefix.."%s"):format(Events.saveOutfit)), function(type)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local playerAccount, sampling
    if not (_ClotheConfig.california) then playerAccount = xPlayer.getMoney() else playerAccount = xPlayer.getAccount('cash').money end

    _Server:getPrice(type)

    if (playerAccount) < 0 then
        TriggerClientEvent(((_Prefix.."%s"):format(Events.closeAll)), _src)
        return
    end

    if (not (type)) then
        return
    end

    if (type) == "clothes" then
        sampling = "nouvelle tenue"
    elseif (type) == "accessories" then
        sampling = "nouvel accessoire"
    end

    if (playerAccount) < (price) then
        TriggerClientEvent(_ClotheConfig.showNotifEvent, _src, "~r~Il semblerait que vous ne possédiez pas l'argent nécessaire.")
        TriggerClientEvent(((_Prefix.."%s"):format(Events.closeAll)), _src)
        return
    end
    if not (_ClotheConfig.california) then
        xPlayer.removeMoney(price)
    else
        xPlayer.removeAccountMoney('cash', price)
    end
    local randomDraw = math.random(1 ,3)
    local selectedMessage = messages[randomDraw]
    TriggerClientEvent(_ClotheConfig.showNotifEvent, _src, ("~g~%s $~s~ vous ont été prélevés de votre portefeuille pour l'achat de votre %s."):format(price, sampling))
    TriggerClientEvent(_ClotheConfig.showAdvancedNotifEvent, _src, "Hailey", "~p~Vendeuse", selectedMessage, "CHAR_ANTONIA", 8)
    TriggerClientEvent(((_Prefix.."%s"):format(Events.saveSkin)), _src)
    if (type) == "accessories" then
        TriggerClientEvent(((_Prefix.."%s"):format(Events.closeAll)), _src)
    end

end)

RegisterServerEvent((_Prefix.."%s"):format(Events.buyOutfit))
AddEventHandler(((_Prefix.."%s"):format(Events.buyOutfit)), function(price, name)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local playerAccount
    if not (_ClotheConfig.california) then playerAccount = xPlayer.getMoney() else playerAccount = xPlayer.getAccount('cash').money end

    if (playerAccount) < 0 then
        TriggerClientEvent(((_Prefix.."%s"):format(Events.closeAll)), _src)
        return
    end

    if (not (price)) then
        return
    end

    if (not (name)) then
        return
    end

    if (playerAccount) < (price) then
        TriggerClientEvent(_ClotheConfig.showNotifEvent, _src, "~r~Il semblerait que vous ne possédiez pas l'argent nécessaire.")
        TriggerClientEvent(((_Prefix.."%s"):format(Events.closeAll)), _src)
        return
    end
    if not (_ClotheConfig.california) then
        xPlayer.removeMoney(price)
    else
        xPlayer.removeAccountMoney('cash', price)
    end
    local randomDraw = math.random(1 ,3)
    local selectedMessage = messages[randomDraw]
    TriggerClientEvent(_ClotheConfig.showNotifEvent, _src, ("~g~%s $~s~ vous ont été prélevés de votre portefeuille pour l'achat de : ~b~%s~s~."):format(price, name))
    TriggerClientEvent(_ClotheConfig.showAdvancedNotifEvent, _src, "Hailey", "~p~Vendeuse", selectedMessage, "CHAR_ANTONIA", 8)
    TriggerClientEvent(((_Prefix.."%s"):format(Events.saveSkin)), _src)

end)