fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'enty#8799'
description 'Suicide script'
version '1.0.0'

client_script {
    'client/*.lua'
}

server_script {
    'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua'
}

files {
    'locales/*.json'
}

dependencies {
    'ox_lib'
}
