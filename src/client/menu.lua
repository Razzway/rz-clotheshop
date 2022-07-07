--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

clothesAction, clothesActionIndex, isMenuOpen, outfitInfo = {"Equiper", "Renommer", "Supprimer"}, 1, false, false

local mainMenu = RageUI.CreateMenu("", "Que souhaitez-vous faire ?", 0, 0, "shopui_title_midfashion", "shopui_title_midfashion")
local myDressing = RageUI.CreateSubMenu(mainMenu, "", "Mes tenues enregistrées")
local outfitMenu = RageUI.CreateSubMenu(mainMenu, "", "Voici nos tenues pré faites")
local articlesMenu = RageUI.CreateSubMenu(mainMenu, "", "Changez de style vestimentaire")
local validChangeMenu = RageUI.CreateSubMenu(mainMenu, "", "Voulez vous enregistrer cette tenue ?")
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
mainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})
articlesMenu.EnableMouse = true
mainMenu.Closed = function()
    isMenuOpen = false
    outfitInfo = false
    Utils:KillCam()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end
myDressing.Closed = function()
    SetTimeout(10, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end
outfitMenu.Closed = function()
    SetTimeout(10, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end
articlesMenu.Closed = function()
    Utils:switchCam(false, "default")
end

function CHelper.PoolMenus:main()
    if (isMenuOpen) then
        return
    end
    isMenuOpen = true
    Utils:freezePlayer(true)
    Utils:createCam("default")
    Utils:drawAnim()
    RageUI.Visible(mainMenu, true)
    CreateThread(function()
        while (isMenuOpen) do
            Wait(0)
            RageUI.IsVisible(mainMenu, function()
                if (outfitInfo) then
                    RageUI.Info("Informations de votre tenue", {
                        ("T-shirt 1 : %s"):format(Settings.index.Tshirt), ("T-shirt 2 : %s"):format(Settings.SliderPanel.Config.Tshirt),
                        ("Torse 1 : %s"):format(Settings.index.Torso), ("Torse 2 : %s"):format(Settings.SliderPanel.Config.Torso),
                        ("Bras 1 : %s"):format(Settings.index.Arms), ("Bras 2 : %s"):format(Settings.SliderPanel.Config.Arms)
                    }, {
                        ("Sac 1 : %s"):format(Settings.index.Bags), ("Sac 2 : %s"):format(Settings.SliderPanel.Config.Bags),
                        ("Pantalon 1 : %s"):format(Settings.index.Pants), ("Pantalon 2 : %s"):format(Settings.SliderPanel.Config.Pants),
                        ("Chaussure 1 : %s"):format(Settings.index.Shoes), ("Chaussure 2 : %s"):format(Settings.SliderPanel.Config.Shoes)
                    })
                end
                RageUI.Button("Mon dressing", "Choisissez une tenue sauvegardée à porter. Vous pouvez sauvegarder des tenues en validant les changements.", {RightBadge = RageUI.BadgeStyle.PlayerIcon}, true , {onActive = function() Utils:OnRenderCam() end, onSelected = function() Razzway:refreshData() end}, myDressing)
                if (_ClotheConfig.preMadeOutfit) then
                    RageUI.Button("Tenues disponibles", "Visualisez l'ensemble des tenues que nos stylistes ont réalisés pour notre clientèle.", {RightBadge = RageUI.BadgeStyle.Spec}, true, {onActive = function() Utils:OnRenderCam() end}, outfitMenu)
                end
                RageUI.Button("Articles disponibles", "Créez votre propre style avec notre large choix de vêtements.", {RightBadge = RageUI.BadgeStyle.Star}, true, {onActive = function() Utils:OnRenderCam() end}, articlesMenu)
                RageUI.Button(('Valider les changements (%s $)'):format(_ClotheConfig.Handler.clothesPrice), nil, { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 66, 176, 245, 160 }} }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        TriggerServerEvent((_Prefix.."%s"):format(Events.saveOutfit), "clothes")
                        Wait(180)
                    end
                }, validChangeMenu)
            end)
            RageUI.IsVisible(myDressing, function()
                for _,clothes in pairs(Razzway.data) do
                    RageUI.List(("%s %s"):format(_Arrow, clothes.name), clothesAction, clothesActionIndex, nil, {RightBadge = RageUI.BadgeStyle.Clothes}, nil, {
                        onActive = function() Utils:OnRenderCam() Utils:applySkinPreview(json.decode(clothes.data)) end,
                        onListChange = function(Index, Item)
                            clothesActionIndex = Index;
                        end,
                        onSelected = function(Index, Item)
                            if clothesActionIndex == 1 then
                                CreateThread(function()
                                    TriggerEvent(_ClotheConfig.skinchangerEvent..':getSkin', function(skin)
                                        TriggerEvent(_ClotheConfig.skinchangerEvent..':loadClothes', skin, json.decode(clothes.data))
                                        Citizen.Wait(50)
                                        TriggerEvent(_ClotheConfig.skinchangerEvent..':getSkin', function(skin_)
                                            TriggerServerEvent(_ClotheConfig.skinEvent..':save', skin_)
                                        end)
                                    end)
                                end)
                                ESX.ShowNotification(("~b~Vêtement~s~\nVous avez équipé votre tenue : ~y~%s"):format(clothes.name))
                            end
                            if clothesActionIndex == 2 then
                                local newName = Utils:input("Nouveau nom à attribuer :", "",  25)
                                if newName == "" or newName == nil then
                                    ESX.ShowNotification("~r~Attention !~s~\nVous devez attitré le nouveau nom de votre tenue pour l'enregistrer.")
                                else
                                    CreateThread(function()
                                        TriggerEvent(_ClotheConfig.skinchangerEvent..':getSkin', function()
                                            Wait(25)
                                            TriggerServerEvent(((_Prefix.."%s"):format(Events.editData)), clothes.id, clothes.name, newName)
                                        end)
                                        Wait(50)
                                        RageUI.GoBack()
                                    end)
                                end
                            end
                            if Index == 3 then
                                TriggerServerEvent(((_Prefix.."%s"):format(Events.deleteData)), clothes.id, clothes.name)
                                RageUI.GoBack()
                            end
                        end
                    })
                end
            end)
            RageUI.IsVisible(outfitMenu, function()
                for _,outfit in pairs(Outfit.available) do
                    RageUI.Button(outfit.label, outfit.desc, {RightLabel = ("%s ~g~$"):format(outfit.price), LeftBadge = RageUI.BadgeStyle.Star}, true, {
                        onActive = function() Utils:OnRenderCam() Utils:applySkinSpecific(outfit)
                            RageUI.Info(outfit.label, {
                                ("T-shirt 1 : %s"):format(outfit.clothes["male"].tshirt_1), ("T-shirt 2 : %s"):format(outfit.clothes["male"].tshirt_2),
                                ("Torse 1 : %s"):format(outfit.clothes["male"].torso_1), ("Torse 2 : %s"):format(outfit.clothes["male"].torso_2),
                                ("Bras 1 : %s"):format(outfit.clothes["male"].arms), ("Bras 2 : %s"):format(outfit.clothes["male"].arms_2)
                            }, {
                                ("Sac 1 : %s"):format(outfit.clothes["male"].bags_1), ("Sac 2 : %s"):format(outfit.clothes["male"].bags_2),
                                ("Pantalon 1 : %s"):format(outfit.clothes["male"].pants_1), ("Pantalon 2 : %s"):format(outfit.clothes["male"].pants_2),
                                ("Chaussure 1 : %s"):format(outfit.clothes["male"].shoes_1), ("Chaussure 2 : %s"):format(outfit.clothes["male"].shoes_2)
                            })
                        end,
                        onSelected = function()
                            TriggerServerEvent(((_Prefix.."%s"):format(Events.buyOutfit)), outfit.price, outfit.label)
                        end
                    })
                end
            end)
            RageUI.IsVisible(articlesMenu, function()
                outfitInfo = true
                RageUI.Info("TIPS", {"→ Appuyez sur ~h~ENTRER~h~ pour choisir un numéro"}, {""})
                RageUI.SliderProgress(("%s T-shirt : %s"):format(_Arrow, Settings.index.Tshirt), Settings.index.Tshirt, Settings.maxData.Tshirt, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:switchCam(false, "tshirt_1") end,
                    onSliderChange = function(Index)
                        Settings.index.Tshirt = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'tshirt_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Tshirt then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Tshirt = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'tshirt_1', Settings.index.Tshirt)
                        end
                    end
                })
                RageUI.SliderProgress(("%s Torse : %s"):format(_Arrow, Settings.index.Torso), Settings.index.Torso, Settings.maxData.Torso, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:switchCam(false, "torso_1") end,
                    onSliderChange = function(Index)
                        Settings.index.Torso = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'torso_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Torso then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Torso = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'torso_1', Settings.index.Torso)
                        end
                    end
                })
                RageUI.SliderProgress(("%s Bras : %s"):format(_Arrow, Settings.index.Arms), Settings.index.Arms, Settings.maxData.Arms, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:switchCam(false, "arms") end,
                    onSliderChange = function(Index)
                        Settings.index.Arms = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'arms', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Arms then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Arms = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'arms', Settings.index.Arms)
                        end
                    end
                })
                RageUI.SliderProgress(("%s Sac : %s"):format(_Arrow, Settings.index.Bags), Settings.index.Bags, Settings.maxData.Bags, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:switchCam(false, "bags_1") end,
                    onSliderChange = function(Index)
                        Settings.index.Bags = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'bags_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Bags then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Bags = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'bags_1', Settings.index.Bags)
                        end
                    end
                })
                RageUI.SliderProgress(("%s Pantalon : %s"):format(_Arrow, Settings.index.Pants), Settings.index.Pants, Settings.maxData.Pants, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:switchCam(false, "pants_1") end,
                    onSliderChange = function(Index)
                        Settings.index.Pants = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'pants_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Pants then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Pants = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'pants_1', Settings.index.Pants)
                        end
                    end
                })
                RageUI.SliderProgress(("%s Chaussure : %s"):format(_Arrow, Settings.index.Shoes), Settings.index.Shoes, Settings.maxData.Shoes, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:switchCam(false, "shoes_1") end,
                    onSliderChange = function(Index)
                        Settings.index.Shoes = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'shoes_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Shoes then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Shoes = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'bags_1', Settings.index.Shoes)
                        end
                    end
                })
                -- << Variations >> --
                RageUI.SliderPanel(Settings.SliderPanel.Config.Tshirt, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedTextureVariations(PlayerPedId(), 8, Settings.index.Tshirt)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Tshirt = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'tshirt_2', Index)
                    end
                }, 1)
                RageUI.SliderPanel(Settings.SliderPanel.Config.Torso, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedTextureVariations(PlayerPedId(), 11, Settings.index.Torso)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Torso = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'torso_2', Index)
                    end
                }, 2)
                RageUI.SliderPanel(Settings.SliderPanel.Config.Arms, Settings.SliderPanel.Config.Min, "Variations", 10, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Arms = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'arms_2', Index)
                    end
                }, 3)
                RageUI.SliderPanel(Settings.SliderPanel.Config.Bags, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedTextureVariations(PlayerPedId(), 5, Settings.index.Bags)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Bags = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'bags_2', Index)
                    end
                }, 4)
                RageUI.SliderPanel(Settings.SliderPanel.Config.Pants, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedTextureVariations(PlayerPedId(), 4, Settings.index.Pants)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Pants = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'pants_2', Index)
                    end
                }, 5)
                RageUI.SliderPanel(Settings.SliderPanel.Config.Shoes, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedTextureVariations(PlayerPedId(), 6, Settings.index.Shoes)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Shoes = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'shoes_2', Index)
                    end
                }, 6)
            end)
            RageUI.IsVisible(validChangeMenu, function()
                RageUI.Button(("%s Oui"):format(_Arrow), nil, {RightBadge = RageUI.BadgeStyle.VoteTick}, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        local str = Utils:input("Spécifiez le nom de la tenue :", "", 25)
                        if str == "" or str == nil then
                            ESX.ShowNotification("~r~Attention !~s~\nVous devez attitré un nom à votre tenue pour pouvoir la sauvegarder.")
                        else
                            CreateThread(function()
                                TriggerEvent(_ClotheConfig.skinchangerEvent..':getSkin', function(saveAppearance)
                                    Wait(25)
                                    TriggerServerEvent(((_Prefix.."%s"):format(Events.saveData)), str, saveAppearance)
                                end)
                            end)
                            mainMenu.Closed()
                        end
                    end
                })
                RageUI.Button(("%s Non"):format(_Arrow), nil, {RightBadge = RageUI.BadgeStyle.VoteCross}, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        mainMenu.Closed()
                    end
                })
            end)
        end
        Utils:freezePlayer(false)
    end)
end

local helmetMenu = RageUI.CreateMenu("", "Voici les articles disponibles", 0, 0, "shopui_title_midfashion", "shopui_title_midfashion")
helmetMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
helmetMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})
helmetMenu.EnableMouse = true
helmetMenu.Closed = function()
    isMenuOpen = false
    Utils:KillCam()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end

function CHelper.PoolMenus:helmet()
    if (isMenuOpen) then
        return
    end
    isMenuOpen = true
    RageUI.Visible(helmetMenu, true)
    Utils:freezePlayer(true)
    Utils:createCam("helmet_1")
    CreateThread(function()
        while (isMenuOpen) do
            Wait(0)
            RageUI.IsVisible(helmetMenu, function()
                RageUI.Info("TIPS", {"→ Appuyez sur ~h~ENTRER~h~ pour choisir un numéro"}, {""})
                RageUI.Line()
                RageUI.SliderProgress(("%s Casque : %s"):format(_Arrow, Settings.index.Helmet), Settings.index.Helmet, Settings.maxData.Helmet, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSliderChange = function(Index)
                        Settings.index.Helmet = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'helmet_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Helmet then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Helmet = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'helmet_1', Settings.index.Helmet)
                        end
                    end
                })
                RageUI.Button(('Valider les changements (%s$)'):format(_ClotheConfig.Handler.accessoriesPrice), nil, { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 0, 140, 0, 160 }} }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        TriggerServerEvent((_Prefix.."%s"):format(Events.saveOutfit), "accessories")
                    end
                })
                -- << Variations >> --
                RageUI.SliderPanel(Settings.SliderPanel.Config.Helmet, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, Settings.index.Helmet)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Helmet = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'helmet_2', Index)
                    end
                }, 2)
            end)
        end
        Utils:freezePlayer(false)
    end)
end

local glassesMenu = RageUI.CreateMenu("", "Voici les articles disponibles", 0, 0, "shopui_title_midfashion", "shopui_title_midfashion")
glassesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
glassesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})
glassesMenu.EnableMouse = true
glassesMenu.Closed = function()
    isMenuOpen = false
    Utils:KillCam()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end

function CHelper.PoolMenus:glasses()
    if (isMenuOpen) then
        RageUI.Visible(glassesMenu, false)
        return
    end
    isMenuOpen = true
    RageUI.Visible(glassesMenu, true)
    Utils:freezePlayer(true)
    Utils:createCam("glasses_1")
    CreateThread(function()
        while (isMenuOpen) do
            Wait(0)
            RageUI.IsVisible(glassesMenu, function()
                RageUI.Info("TIPS", {"→ Appuyez sur ~h~ENTRER~h~ pour choisir un numéro"}, {""})
                RageUI.Line()
                RageUI.SliderProgress(("%s Lunette : %s"):format(_Arrow, Settings.index.Glasses), Settings.index.Glasses, Settings.maxData.Glasses, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSliderChange = function(Index)
                        Settings.index.Glasses = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'glasses_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Glasses then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Glasses = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'glasses_1', Settings.index.Glasses)
                        end
                    end
                })
                RageUI.Button(('Valider les changements (%s$)'):format(_ClotheConfig.Handler.accessoriesPrice), nil, { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 0, 140, 0, 160 }} }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        TriggerServerEvent((_Prefix.."%s"):format(Events.saveOutfit), "accessories")
                    end
                })
                -- << Variations >> --
                RageUI.SliderPanel(Settings.SliderPanel.Config.Glasses, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, Settings.index.Glasses)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Glasses = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'glasses_2', Index)
                    end
                }, 2)
            end)
        end
        Utils:freezePlayer(false)
    end)
end

local earsMenu = RageUI.CreateMenu("", "Voici les articles disponibles", 0, 0, "shopui_title_midfashion", "shopui_title_midfashion")
earsMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
earsMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})
earsMenu.EnableMouse = true
earsMenu.Closed = function()
    isMenuOpen = false
    Utils:KillCam()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end

function CHelper.PoolMenus:ears()
    if (isMenuOpen) then
        return
    end
    isMenuOpen = true
    RageUI.Visible(earsMenu, true)
    Utils:freezePlayer(true)
    Utils:createCam("ears_1")
    CreateThread(function()
        while (isMenuOpen) do
            Wait(0)
            RageUI.IsVisible(earsMenu, function()
                RageUI.Info("TIPS", {"→ Appuyez sur ~h~ENTRER~h~ pour choisir un numéro"}, {""})
                RageUI.Line()
                RageUI.SliderProgress(("%s Oreille : %s"):format(_Arrow, Settings.index.Ears), Settings.index.Ears, Settings.maxData.Ears, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSliderChange = function(Index)
                        Settings.index.Ears = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'ears_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Ears then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Ears = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'ears_1', Settings.index.Ears)
                        end
                    end
                })
                RageUI.Button(('Valider les changements (%s$)'):format(_ClotheConfig.Handler.accessoriesPrice), nil, { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 0, 140, 0, 160 }} }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        TriggerServerEvent((_Prefix.."%s"):format(Events.saveOutfit), "accessories")
                    end
                })
                -- << Variations >> --
                RageUI.SliderPanel(Settings.SliderPanel.Config.Ears, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedPropTextureVariations(PlayerPedId(), 1, Settings.index.Ears)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Ears = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'ears_2', Index)
                    end
                }, 2)
            end)
        end
        Utils:freezePlayer(false)
    end)
end

local chainMenu = RageUI.CreateMenu("", "Voici les articles disponibles", 0, 0, "shopui_title_midfashion", "shopui_title_midfashion")
chainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
chainMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})
chainMenu.EnableMouse = true
chainMenu.Closed = function()
    isMenuOpen = false
    Utils:KillCam()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end

function CHelper.PoolMenus:chain()
    if (isMenuOpen) then
        return
    end
    isMenuOpen = true
    RageUI.Visible(chainMenu, true)
    Utils:freezePlayer(true)
    Utils:createCam("chain_1")
    CreateThread(function()
        while (isMenuOpen) do
            Wait(0)
            RageUI.IsVisible(chainMenu, function()
                RageUI.Info("TIPS", {"→ Appuyez sur ~h~ENTRER~h~ pour choisir un numéro"}, {""})
                RageUI.Line()
                RageUI.SliderProgress(("%s Chaine : %s"):format(_Arrow, Settings.index.Chain), Settings.index.Chain, Settings.maxData.Chain, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSliderChange = function(Index)
                        Settings.index.Chain = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'chain_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Chain then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Chain = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'helmet_1', Settings.index.Chain)
                        end
                    end
                })
                RageUI.Button(('Valider les changements (%s$)'):format(_ClotheConfig.Handler.accessoriesPrice), nil, { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 0, 140, 0, 160 }} }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        TriggerServerEvent((_Prefix.."%s"):format(Events.saveOutfit), "accessories")
                    end
                })
                -- << Variations >> --
                RageUI.SliderPanel(Settings.SliderPanel.Config.Chain, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedTextureVariations(PlayerPedId(), 7, Settings.index.Chain)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Chain = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'chain_2', Index)
                    end
                }, 2)
            end)
        end
        Utils:freezePlayer(false)
    end)
end

local watchesMenu = RageUI.CreateMenu("", "Voici les articles disponibles", 0, 0, "shopui_title_midfashion", "shopui_title_midfashion")
watchesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 44, 0), [2] = "Rotation Droite"})
watchesMenu:AddInstructionButton({[1] = GetControlInstructionalButton(0, 51, 0), [2] = "Rotation Gauche"})
watchesMenu.EnableMouse = true
watchesMenu.Closed = function()
    isMenuOpen = false
    Utils:KillCam()
    SetTimeout(180, function()
        ESX.TriggerServerCallback(_ClotheConfig.skinEvent..':getPlayerSkin', function(skin)
            TriggerEvent(_ClotheConfig.skinchangerEvent..':loadSkin', skin)
        end)
    end)
end

function CHelper.PoolMenus:watches()
    if (isMenuOpen) then
        return
    end
    isMenuOpen = true
    RageUI.Visible(watchesMenu, true)
    Utils:freezePlayer(true)
    Utils:createCam("watches_1")
    CreateThread(function()
        while (isMenuOpen) do
            Wait(0)
            RageUI.IsVisible(watchesMenu, function()
                RageUI.Info("TIPS", {"→ Appuyez sur ~h~ENTRER~h~ pour choisir un numéro"}, {""})
                RageUI.Line()
                RageUI.SliderProgress(("%s Montre : %s"):format(_Arrow, Settings.index.Watches), Settings.index.Watches, Settings.maxData.Watches, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSliderChange = function(Index)
                        Settings.index.Watches = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'watches_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Watches then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Watches = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'helmet_1', Settings.index.Watches)
                        end
                    end
                })
                RageUI.SliderProgress(("%s Bracelet : %s"):format(_Arrow, Settings.index.Bracelets), Settings.index.Bracelets, Settings.maxData.Bracelets, false, {
                    ProgressBackgroundColor = { R = 0, G = 0, B = 0, A = 200 },
                    ProgressColor = { R = 235, G = 52, B = 79, A = 255 },
                }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSliderChange = function(Index)
                        Settings.index.Bracelets = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'bracelets_1', Index)
                    end,
                    onSelected = function()
                        local result = Utils:input("Indiquez le numéro que vous souhaitez sélectionner :", "", 3)
                        if (not (tonumber(result))) then
                            ESX.ShowNotification('~r~Il semblerait que vous n\'avez entré aucune valeur. Assurez vous qu\'il s\'agisse bel et bien d\'un chiffre/nombre.')
                            return
                        end
                        if tonumber(result) ~= nil and tonumber(result) < -1 or tonumber(result) > Settings.maxData.Bracelets then
                            ESX.ShowNotification("~r~Il n'existe pas autant de variation pour ce composant.")
                            return
                        else
                            Settings.index.Bracelets = tonumber(result)
                            TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'helmet_1', Settings.index.Bracelets)
                        end
                    end
                })
                RageUI.Button(('Valider les changements (%s$)'):format(_ClotheConfig.Handler.accessoriesPrice), nil, { RightBadge = RageUI.BadgeStyle.Tick, Color = {BackgroundColor = { 0, 140, 0, 160 }} }, true, {
                    onActive = function() Utils:OnRenderCam() end,
                    onSelected = function()
                        TriggerServerEvent((_Prefix.."%s"):format(Events.saveOutfit), "accessories")
                    end
                })
                -- << Variations >> --
                RageUI.SliderPanel(Settings.SliderPanel.Config.Watches, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, Settings.index.Watches)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Watches = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'watches_2', Index)
                    end
                }, 2)
                RageUI.SliderPanel(Settings.SliderPanel.Config.Bracelets, Settings.SliderPanel.Config.Min, "Variations", GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, Settings.index.Bracelets)-1, {
                    onSliderChange = function(Index)
                        Settings.SliderPanel.Config.Bracelets = Index
                        TriggerEvent(_ClotheConfig.skinchangerEvent..':change', 'bracelets_2', Index)
                    end
                }, 3)
            end)
        end
        Utils:freezePlayer(false)
    end)
end