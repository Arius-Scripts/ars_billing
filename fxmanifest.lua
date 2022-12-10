fx_version "cerulean"
game "gta5"
lua54 "yes"


client_scripts {"client/*.lua", "item/*.lua"}
server_scripts {'@oxmysql/lib/MySQL.lua', "server/*.lua"}

shared_scripts {"@ox_lib/init.lua", "config.lua"}
