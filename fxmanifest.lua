fx_version 'bodacious'
game 'gta5'
author 'Jules for You'
description 'Nowoczesny system powiadomień dla ESX z półprzezroczystym interfejsem.'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

client_script 'client/client.lua'
server_script 'server/server.lua'
