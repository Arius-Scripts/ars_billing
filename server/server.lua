ESX = exports["es_extended"]:getSharedObject() 
local ox_inventory = exports.ox_inventory

RegisterNetEvent("ars_billing:giveBillingItem", function(player, reason, society, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName()
    ox_inventory:AddItem(player, Config.ItemName, 1, {reason = reason, society = society, status = Config.Lang.notPaid, amount = amount, from = name, date = os.date("%x %X"), xplayer = source})
    if Config.UseDiscordLogs then
        log(GetPlayerName(source).." Created a bill of $"..amount.. " for "..GetPlayerName(player), Config.CreateBillWebhook, 5763719)
    end
end)


RegisterNetEvent("ars_billing:payBill", function(method, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local bankMoney = xPlayer.getAccount("bank").money
    local money = ox_inventory:Search(source, 'count', {'money'})

    if method == "money" then
        if money >= data.metadata.amount then
            ox_inventory:RemoveItem(source, 'money', data.metadata.amount)

            if Config.RemoveItem then
                ox_inventory:RemoveItem(source, Config.ItemName, 1, nil, data.slot)
            else
                ox_inventory:SetMetadata(source, data.slot, {status = Config.Lang.paid, amount = data.metadata.amount, date = data.metadata.date, society = data.metadata.society})
            end

            TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..data.metadata.society, function(account)
                account.addMoney(data.metadata.amount)
            end)

            TriggerClientEvent("esx:showNotification", source, Config.Lang.billPaid..data.metadata.amount)
            TriggerClientEvent("esx:showNotification", data.metadata.xplayer, Config.Lang.billPaid..data.metadata.amount)
        else
            TriggerClientEvent("esx:showNotification", source, Config.Lang.noMoney)
            TriggerClientEvent("esx:showNotification", data.metadata.xplayer, Config.Lang.xnoMoney)
        end
    elseif method == "bank" then
        if bankMoney >= data.metadata.amount then
            xPlayer.removeAccountMoney("bank", data.metadata.amount)

            if Config.RemoveItem then
                ox_inventory:RemoveItem(source, Config.ItemName, 1, nil, data.slot)
            else
                ox_inventory:SetMetadata(source, data.slot, {status = Config.Lang.paid, amount = data.metadata.amount, date = data.metadata.date, society = data.metadata.society, paidon = os.date("%x %X")})
            end
            TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..data.metadata.society, function(account)
                account.addMoney(data.metadata.amount)
            end)

            TriggerClientEvent("esx:showNotification", source, Config.Lang.billPaid..data.metadata.amount)
            TriggerClientEvent("esx:showNotification", data.metadata.xplayer, Config.Lang.billPaid..data.metadata.amount)
            if Config.UseDiscordLogs then
                log(GetPlayerName(source).." Paid the bill of $"..data.metadata.amount.." created by "..GetPlayerName(data.metadata.xplayer), Config.PayBillWebhook, 5763719)
            end
        else
            TriggerClientEvent("esx:showNotification", source, Config.Lang.noMoney)
            TriggerClientEvent("esx:showNotification", data.metadata.xplayer, Config.Lang.xnoMoney)
        end
    end
end)

function log(description,webhook,color)
    PerformHttpRequest(webhook, function()
    end, "POST", json.encode({
    embeds = {{
        author = {
            name = "Ars Logs",
            url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley",
            icon_url = "https://cdn.discordapp.com/attachments/1017732810200596500/1017737817859838002/Untitled-1.png"},
        title = "Log Ars-Billing",
        description = description,
        color = color
    }}}),{["Content-Type"] = "application/json"})
end