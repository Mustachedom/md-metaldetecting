name "Bostra @ Mustache -metaldetect"
author "Bostra & Mustache_dom"
description "Metal Detecting"
fx_version "cerulean"
game "gta5"

client_scripts {
	'client/**.lua',
}

server_scripts {
    'server/**.lua',
	
}

shared_scripts {
	'@ox_lib/init.lua',
	'shared/**.lua',
}


lua54 'yes'

dependency '/assetpacks'
dependency 'bob74_ipl'
