--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

RegisterNetEvent((_Prefix.."%s"):format(Events.saveData))
AddEventHandler(((_Prefix.."%s"):format(Events.saveData)), function(name, data)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if (not (name)) then
        return
    end

    if (not (data)) then
        return
    end

    if (_ClotheConfig.SQLWrapperType) == 1 then
        MySQL.Async.execute("INSERT INTO `clothes_data` (identifier, name, data) VALUES (@identifier, @name, @data)", {
            ["@identifier"] = xPlayer.identifier,
            ["@name"] = name,
            ["@data"] = json.encode(data),
        })
    end
    if (_ClotheConfig.SQLWrapperType) == 2 then
        MySQL.insert("INSERT INTO clothes_data (identifier, name, data) VALUES (?, ?, ?)", {xPlayer.identifier, name, json.encode(data)})
    end
    xPlayer.showNotification(("~b~Vêtement~s~\nVous avez ~g~enregistré~s~ une nouvelle tenue : ~y~%s"):format(name))

    if (_ServerConfig.enableLogs) then
        logs:sendToDiscord(_ServerConfig.logs.wehbook ,_ServerConfig.logs.name, nil, ("**Magasin de vêtement - Nouvelle intéraction**\n%s\nNom : %s\nID du joueur : %s\nDiscord : %s\n```› Enregistrement d'une tenue dans son dressing : %s```"):format(MESSAGE_LINE, GetPlayerName(_src), _src, PLAYER_DISCORD, name), _ServerConfig.logs.color.green)
    end

    if (_ServerConfig.enableConsoleLogs) then
        print(("^6[VETEMENT]^7 -> (^5%s^7) a enregistré une tenue dans son dressing : ^2%s^7"):format(xPlayer.getName(), name))
    end
end)