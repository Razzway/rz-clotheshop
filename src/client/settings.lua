--[[
    Copyright (c) 2022 Razzway - Tout droit réservé.
    Ce fichier a été créé pour Razzway - FiveM Store.
    Vous n'êtes pas autorisé à revendre/partager la ressource.
--]]

---@author Razzway
---@version 2.0.0

---@class Settings
Settings = {};
Settings.index = {
    Tshirt = 0,
    Torso = 0,
    Arms = 0,
    Bags = 0,
    Pants = 0,
    Shoes = 0,
    Helmet = 0,
    Glasses = 0,
    Ears = 0,
    Chain = 0,
    Watches = 0,
    Bracelets = 0,
}

if _ClotheConfig.getAutomaticMaxValue then
    Settings.maxData = { --> Automatique
        Tshirt = GetNumberOfPedDrawableVariations(PlayerPedId(), 8)-1, --> tshirt_1
        Torso = GetNumberOfPedDrawableVariations(PlayerPedId(), 11)-1, --> torso_1
        Arms = GetNumberOfPedDrawableVariations(PlayerPedId(), 3)-1, --> arms
        Bags = GetNumberOfPedDrawableVariations(PlayerPedId(), 5)-1, --> bags_1
        Pants = GetNumberOfPedDrawableVariations(PlayerPedId(), 4)-1, --> pants_1
        Shoes = GetNumberOfPedDrawableVariations(PlayerPedId(), 6)-1, --> shoes_1
        Helmet = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 0)-1, --> helmet_1
        Glasses =  GetNumberOfPedPropDrawableVariations(PlayerPedId(), 1)-1, --> glasses_1
        Ears = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 1)-1, --> ears_1
        Chain = GetNumberOfPedDrawableVariations(PlayerPedId(), 7)-1, --> chain_1
        Watches = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 6)-1, --> watches_1
        Bracelets = GetNumberOfPedPropDrawableVariations(PlayerPedId(), 7)-1, --> bracelets_1
    }
else
    Settings.maxData = { --> Manuel
        Tshirt = 183, --> tshirt_1
        Torso = 381, --> torso_1
        Arms = 195, --> arms
        Bags = 99, --> bags_1
        Pants = 137, --> pants_1
        Shoes = 101, --> shoes_1
        Helmet = 155, --> helmet_1
        Glasses = 33, --> glasses_1
        Ears = 33, --> ears_1
        Chain = 151, --> chain_1
        Watches = 40, --> watches_1
        Bracelets = 25, --> bracelets_1
    }
end

Settings.SliderPanel = {
    Config = {Min = 0, Tshirt = 0, Torso = 0, Arms = 0, Bags = 0, Pants = 0, Shoes = 0, Helmet = 0, Glasses = 0, Ears = 0, Chain  = 0, Watches = 0, Bracelets = 0, Max = 64},
    Tshirt = {Index = 1},
    Torso = {Index = 1},
    Pants = {Index = 1},
    Shoes = {Index = 1},
    Helmet = {Index = 1},
    Glasses = {Index = 1},
    Ears = {Index = 1},
    Chain = {Index = 1},
    Watches = {Index = 1},
    Bracelets = {Index = 1}
}