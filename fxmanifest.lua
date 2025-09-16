name "Bostra @ Mustache -metaldetect"
author "Bostra & Mustache_dom"
description "Metal Detecting"
fx_version "cerulean"
game "gta5"
version '2.0.0'

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

files {
	'locales/**.lua',
}

lua54 'yes'


