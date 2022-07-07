--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

RegisterNetEvent((_Prefix.."%s"):format(Events.deleteData))
AddEventHandler(((_Prefix.."%s"):format(Events.deleteData)), function(id, name)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if (not (id)) then
        return
    end

    if (not (name)) then
        return
    end

    if (_ClotheConfig.SQLWrapperType) == 1 then
        MySQL.Async.execute("DELETE FROM clothes_data WHERE id = @id", {
            ["@id"] = id,
        })
    end
    if (_ClotheConfig.SQLWrapperType) == 2 then
        MySQL.update('DELETE FROM clothes_data WHERE id = ?', {id})
    end
    xPlayer.showNotification(("~b~Vêtement~s~\nLa tenue ~r~%s~s~ a été supprimé de votre dressing avec succès."):format(name))

    if (_ServerConfig.enableLogs) then
        logs:sendToDiscord(_ServerConfig.logs.wehbook ,_ServerConfig.logs.name, nil, ("**Magasin de vêtement - Nouvelle intéraction**\n%s\nNom : %s\nID du joueur : %s\nDiscord : %s\n```› Supression d'une tenue de son dressing : %s (id : %s)```"):format(MESSAGE_LINE, GetPlayerName(_src), _src, PLAYER_DISCORD, name, id), _ServerConfig.logs.color.red)
    end

    if (_ServerConfig.enableConsoleLogs) then
        print(("^6[VETEMENT]^7 -> (^5%s^7) a supprimé une tenue de son dressing : ^1%s (id : %s)^7 "):format(xPlayer.getName(), name, id))
    end

end)