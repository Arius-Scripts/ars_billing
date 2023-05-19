ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true

    if Config.MetadataOnItem then
        displayMetadata()
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('ars_billing:showNotification', function(msg)
    showNotification(msg)
end)

RegisterCommand(Config.CommandName, function()
    createBill()
end)
