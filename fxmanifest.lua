fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua',
    'client/animations.lua' -- THÊM DÒNG NÀY
}

server_scripts {
    'server/main.lua'
}

files {
    -- HTML/CSS/JS
    'html/index.html',
    'html/style.css',
    'html/script.js',
    
    -- HÌNH ẢNH
    'html/images/axe.png',
    'html/images/wood-chip.png',
    
    -- ÂM THANH
    'html/sounds/chop-1.mp3',
    'html/sounds/chop-2.mp3',
    
    -- MODEL RIÊU
    'stream/prop_axe_hon_01.ytyp' -- NẾU DÙNG MODEL TÙY CHỈNH
}

data_file 'DLC_ITYP_REQUEST' 'stream/prop_axe_hon_01.ytyp' -- KHAI BÁO CUSTOM MODEL

dependencies {
    'qb-core',
    'qb-target',
    'xsound' -- NẾU DÙNG HỆ THỐNG ÂM THANH NÂNG CAO
}

lua54 'yes'
