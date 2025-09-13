name "Bostra @ Mustache -metaldetect"
author "Bostra & Mustache_dom"
description "Metal Detecting"
fx_version "cerulean"
game "gta5"
version '1.9.9'
client_scripts {
	'client/**.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'server/**.lua',
}

shared_scripts {
	'@ox_lib/init.lua',
	'shared/**.lua',
}

lua54 'yes'


