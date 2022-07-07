fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

version '2.0.0'
author 'Razzway'
description 'PowerFull & Optimized Clotheshop in RageUI'

shared_scripts {
    'src/configs/cConfig.lua',
}

client_scripts {
    'src/utils.lua',

    'src/libs/RageUI//RMenu.lua',
    'src/libs/RageUI//menu/RageUI.lua',
    'src/libs/RageUI//menu/Menu.lua',
    'src/libs/RageUI//menu/MenuController.lua',
    'src/libs/RageUI//components/*.lua',
    'src/libs/RageUI//menu/elements/*.lua',
    'src/libs/RageUI//menu/items/*.lua',
    'src/libs/RageUI//menu/panels/*.lua',
    'src/libs/RageUI/menu/windows/*.lua',

    'src/data/client/*.lua',
    'src/client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',

    'src/configs/sConfig.lua',
    'src/data/server/*.lua',
    'src/server/*.lua',
}
