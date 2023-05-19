ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent("ars_billing:giveBillingItem", function(player, reason, society, amount)
    giveItem(source, player, reason, society, amount)
end)

RegisterNetEvent("ars_billing:payBill", function(method, data)
    payBill(source, method, data)
end)


lib.versionCheck('Arius-Development/ars_billing')

if not Config.CanDropItem then
    exports.ox_inventory:registerHook('swapItems', function(payload)
        local fromInventory = payload.fromInventory
        local toInventory   = payload.toInventory
        local canDrop       = not string.find(toInventory, "drop")

        if not canDrop then return false end
    end, {})
end
