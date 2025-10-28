fx_version 'bodacious'
game 'gta5'
author 'Jules for You'
description 'Nowoczesny system powiadomień dla ESX z półprzezroczystym interfejsem.'
version '1.0.0'

provides 'esx_notify'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/sound/*.mp3'
}

client_script 'client/client.lua'
server_script 'server/server.lua'

client_export 'Notify'
