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

function displayMetadata()
    exports.ox_inventory:displayMetadata({
        reason  = Config.Lang.mreason,
        society = Config.Lang.msociety,
        from    = Config.Lang.mfrom,
        amount  = Config.Lang.mamount,
        date    = Config.Lang.mdate,
        status  = Config.Lang.mstatus,
        paidon  = Config.Lang.mPaidDate,
    })
end

RegisterCommand(Config.CommandName, function()
    local closestPerson = lib.getClosestPlayer(GetEntityCoords(cache.ped), 3, false)
    local job = ESX.PlayerData.job.name

    if job == "unemployed" then return end
    if not closestPerson then return ESX.ShowNotification(Config.Lang.noPlayer) end

    local input = lib.inputDialog(Config.Lang.billingTitle, {
        { type = "input", label = Config.Lang.reason, placeholder = "Reason ..." },
        { type = "number", label = Config.Lang.amount, default = 1 },
        { type = "checkbox", label = Config.Lang.sign},
    })

    if input then
        reason = input[1]
        amount = input[2]
        conferm = input[3]

        if not reason then return ESX.ShowNotification(Config.Lang.noReason) end
        if not amount or amount < 1 then return ESX.ShowNotification(Config.Lang.noAmount) end
        if not conferm then return ESX.ShowNotification(Config.Lang.noSign) end

        local infoBox = lib.alertDialog({
            header = Config.Lang.confermBill,
            content = Config.Lang.amount..": $"..amount.."  \n"..Config.Lang.reason..": "..reason.."  \n"..Config.Lang.sign..": *𝔄𝔯𝔰-𝔟𝔦𝔩𝔩𝔦𝔫𝔤*",
            centered = false,
            cancel = true
        })

        if infoBox ~= "confirm" then return ESX.ShowNotification(Config.Lang.billCanceled) end

        if lib.progressBar({
            duration = 2000,
            label = Config.Lang.creatingBill,
            useWhileDead = false,
            allowCuffed = false,
            allowFalling = false,
            canCancel = true,
            disable = {
                car = true,
            },
            anim = {
                dict = 'missfam4',
                clip = 'base' 
            },
            prop = {
                model = `p_amb_clipboard_01`,
                pos = vec3(0.03, 0.03, 0.02),
                rot = vec3(0.0, 0.0, -1.5) 
            },
        }) then 
            TriggerServerEvent("ars_billing:giveBillingItem", GetPlayerServerId(closestPerson), reason, job, amount)
            ESX.ShowNotification(Config.Lang.billCreated..amount)
        else 
            ESX.ShowNotification(Config.Lang.billCanceled)
        end
        
    end
end)

