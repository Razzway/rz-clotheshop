--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

RegisterNetEvent((_Prefix.."%s"):format(Events.editData))
AddEventHandler(((_Prefix.."%s"):format(Events.editData)), function(id, oldName, newName)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if (not (id)) then
        return
    end

    if (not (oldName)) then
        return
    end

    if (not (newName)) then
        return
    end

    if (_ClotheConfig.SQLWrapperType) == 1 then
        MySQL.Async.execute("UPDATE clothes_data SET name = @name WHERE id = @id", {
            ["@id"] = id,
            ["@name"] = newName,
        })
    end
    if (_ClotheConfig.SQLWrapperType) == 2 then
        MySQL.update('UPDATE clothes_data SET name = ? WHERE id = ?', {id, newName})
    end
    xPlayer.showNotification(("~b~Vêtement~s~\nVous avez attribué un nouveau nom à votre tenue : \n- ~r~%s~s~ → ~g~%s~s~"):format(oldName, newName))

    if (_ServerConfig.enableLogs) then
        logs:sendToDiscord(_ServerConfig.logs.wehbook ,_ServerConfig.logs.name, nil, ("**Magasin de vêtement - Nouvelle intéraction**\n%s\nNom : %s\nID du joueur : %s\nDiscord : %s\n```› Modification du nom de la tenue : %s -> %s```"):format(MESSAGE_LINE, GetPlayerName(_src), _src, PLAYER_DISCORD, oldName, newName), _ServerConfig.logs.color.orange)
    end

    if (_ServerConfig.enableConsoleLogs) then
        print(("^6[VETEMENT]^7 -> (^5%s^7) a modifié le nom de sa tenue : ^1%s^7 > ^2%s^7"):format(xPlayer.getName(), oldName, newName))
    end
end)