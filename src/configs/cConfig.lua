--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0

---@class _ClotheConfig
_ClotheConfig = {} or {};
_ClotheConfig.getESX = "esx:getSharedObject"; --> Trigger de déclaration ESX (default : esx:getSharedObject)
_ClotheConfig.california = false --> Si vous utilisez la base california : true / Sinon : false
_ClotheConfig.showNotifEvent = "esx:showNotification" --> Trigger de notification ESX
_ClotheConfig.showAdvancedNotifEvent = "esx:showAdvancedNotification" --> Trigger de notification ESX
_ClotheConfig.skinEvent = "esx_skin" --> Trigger esx_skin
_ClotheConfig.skinchangerEvent = "skinchanger" --> Trigger skinchanger
_ClotheConfig.SQLWrapperType = 1 --> Indiquez ce que vous utilisez : mysql-async (1) / oxmysql (2)
_ClotheConfig.getAutomaticMaxValue = false --> Get automatiquement le nombre max de variation d'un composant (peut être bug) Possibilité d'indiquer le max manuellement dans settings.lua
_ClotheConfig.preMadeOutfit = true --> Activer ou non les tenues pré faites
_ClotheConfig.markerGetter = {Type = 23, Size = {0.9, 0.9, 0.9}, Color = {235, 52, 79}, Rotation = 0.0} --> https://docs.fivem.net/docs/game-references/markers/
_ClotheConfig.miniMarkerGetter = {Type = 21, Size = {0.4, 0.4, 0.4}, Color = {235, 52, 79}, Rotation = 180.0} --> https://docs.fivem.net/docs/game-references/markers/

_ClotheConfig.Handler = {
    showBlip = true, --> Afficher ou non les blips sur la carte
    showPeds = true, --> Afficher ou non les peds dans les magasins
    scenarioPed = true, --> Animation du ped
    scenarioName = "WORLD_HUMAN_STRIP_WATCH_STAND", --> https://wiki.rage.mp/index.php?title=Scenarios
    accessoriesPrice = 25, --> Prix à payer pour sauvegarder un accessoire
    clothesPrice = 150, --> Prix à payer pour sauvegarder la tenue
    positions = {
        infoBlip = { --> https://docs.fivem.net/docs/game-references/blips/
            Name = "Magasin de vêtement",
            Sprite = 73,
            Display = 4,
            Scale = 0.9,
            Color = 8,
            Range = true,
        },
        mainZone = { --> Point d'intéraction principal du magasin
            {pos = vector3(72.254, -1399.102, 28.876), pedPos = vector3(73.92, -1392.93, 29.37-1), heading = 270.87, pedModel = 's_f_y_shop_mid'}, -- 1
            {pos = vector3(-703.776, -152.258, 36.915), pedPos = vector3(-708.25, -152.93, 37.41-1), heading = 114.81, pedModel = 's_f_y_shop_mid'}, -- 2
            {pos = vector3(-167.863, -298.969, 39.233), pedPos = vector3(-164.49, -301.65, 39.73-1), heading = 250.62, pedModel = 's_f_y_shop_mid'}, -- 3
            {pos = vector3(428.694, -800.106, 28.991), pedPos = vector3(426.99, -806.19, 29.49-1), heading = 91.26, pedModel = 's_f_y_shop_mid'}, -- 4
            {pos = vector3(-829.413, -1073.710, 10.828), pedPos = vector3(-822.96, -1072.27, 11.32-1), heading = 210.29, pedModel = 's_f_y_shop_mid'}, -- 5
            {pos = vector3(-1447.797, -242.461, 49.320), pedPos = vector3(-1149.85, -239.04, 49.81-1), heading = 49.43, pedModel = 's_f_y_shop_mid'}, -- 6
            {pos = vector3(11.632, 6514.224, 31.377), pedPos = vector3(5.80, 6511.31, 31.87-1), heading = 44.85, pedModel = 's_f_y_shop_mid'}, -- 7
            {pos = vector3(123.646, -219.440, 54.057), pedPos = vector3(127.34, -223.45, 54.55-1), heading = 67.80, pedModel = 's_f_y_shop_mid'}, -- 8
            {pos = vector3(1696.291, 4829.312, 41.563), pedPos = vector3(1695.28, 4823.06, 42.06-1), heading = 98.15, pedModel = 's_f_y_shop_mid'}, -- 9
            {pos = vector3(618.093, 2759.629, 41.588), pedPos = vector3(612.98, 2761.87, 42.08-1), heading = 275.91, pedModel = 's_f_y_shop_mid'}, -- 10
            {pos = vector3(1190.550, 2713.441, 37.722), pedPos = vector3(1196.58, 2711.70, 38.22-1), heading = 180.90, pedModel = 's_f_y_shop_mid'}, -- 11
            {pos = vector3(-1193.429, -772.262, 16.824), pedPos = vector3(-1194.62, -767.37, 17.31-1), heading = 218.49, pedModel = 's_f_y_shop_mid'}, -- 12
            {pos = vector3(-3172.496, 1048.133, 20.363), pedPos = vector3(-3168.89, 1043.90, 20.86-1), heading = 64.19, pedModel = 's_f_y_shop_mid'}, -- 13
            {pos = vector3(-1108.441, 2708.923, 18.607), pedPos = vector3(-1102.46, 2711.62, 19.10-1), heading = 224.67, pedModel = 's_f_y_shop_mid'}, -- 14
        },
        glassesZone = { --> Point d'intéraction avec les lunettes
            {pos = vector3(75.80, -1391.62, 29.37)}, -- 1
            {pos = vector3(425.12, -807.48, 29.49)}, -- 4
            {pos = vector3(-820.93, -1073.09, 11.32)}, -- 5
            {pos = vector3(3.69, 6511.86, 31.87)}, -- 7
            {pos = vector3(126.28, -221.38, 54.55)}, -- 8
            {pos = vector3(1693.70, 4821.57, 42.06)}, -- 9
            {pos = vector3(614.76, 2760.28, 42.08)}, -- 10
            {pos = vector3(1197.80, 2709.84, 38.22)}, -- 11
            {pos = vector3(-1194.97, -769.65, 17.31)}, -- 12
            {pos = vector3(-3169.66, 1046.13, 20.86)}, -- 13
            {pos = vector3(-1100.23, 2711.15, 19.10)}, -- 14
        },
        helmetZone = { --> Point d'intéraction avec les casques
            {pos = vector3(81.54, -1399.92, 29.38)}, -- 1
            {pos = vector3(419.40, -798.93, 29.49)}, -- 4
            {pos = vector3(-825.42, -1082.49, 11.33)}, -- 5
            {pos = vector3(5.98, 6521.85, 31.88)}, -- 7
            {pos = vector3(130.31, -214.45, 54.55)}, -- 8
            {pos = vector3(1686.80, 4829.19, 42.06)}, -- 9
            {pos = vector3(614.12, 2752.34, 42.08)}, -- 10
            {pos = vector3(1189.55, 2704.03, 38.22)}, -- 11
            {pos = vector3(-1201.56, -773.58, 17.31)}, -- 12
            {pos = vector3(-3165.50, 1053.10, 20.86)}, -- 13
            {pos = vector3(-1102.61, 2701.16, 19.11)}, -- 14
        },
        earsZone = { --> Point d'intéraction avec les oreilles
            {pos = vector3(78.99, -1390.05, 29.37)}, -- 1
            {pos = vector3(422.24, -809.29, 29.49)}, -- 4
            {pos = vector3(-817.57, -1075.60, 11.32)}, -- 5
            {pos = vector3(0.21, 6512.86, 31.87)}, -- 7
            {pos = vector3(122.96, -211.14, 54.55)}, -- 8
            {pos = vector3(1690.91, 4819.52, 42.06)}, -- 9
            {pos = vector3(621.83, 2752.59, 42.08)}, -- 10
            {pos = vector3(1199.57, 2706.84, 38.22)}, -- 11
            {pos = vector3(-1197.64, -779.56, 17.33)}, -- 12
            {pos = vector3(-3172.58, 1056.43, 20.86)}, -- 13
            {pos = vector3(-1096.93, 2710.10, 19.10)}, -- 14
        },
        chainZone = { --> Point d'intéraction avec les chaines
            {pos = vector3(-709.02, -156.25, 37.41)}, -- 2
            {pos = vector3(-161.52, -300.24, 39.73)}, -- 3
            {pos = vector3(-1453.22, -239.23, 49.80)}, -- 6
        },
        watchesZone = { --> Point d'intéraction avec les montres & bracelets
            {pos = vector3(-712.12, -157.18, 37.41)}, -- 2
            {pos = vector3(-158.74, -301.79, 39.73)}, -- 3
            {pos = vector3(-1455.03, -236.70, 49.80)}, -- 6
        }
    },
}

---@class CHelper
CHelper = _CHelper or {};
CHelper.PoolMenus = {};
_Prefix = "rz-clotheshop"; 
_Arrow = "~c~→~s~";

---@class Events
Events = { --> Liste de tous les events 
    refreshData = ":refreshData",
    sendData = ":sendData",
    saveData = ":saveData",
    editData = ":editData",
    deleteData = ":deleteData",
    saveSkin = ":saveSkin",
    saveOutfit = ":saveOutfit",
    buyOutfit = ":buyOutfit",
}
