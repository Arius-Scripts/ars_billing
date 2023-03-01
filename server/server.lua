ESX = exports["es_extended"]:getSharedObject() 


RegisterNetEvent("ars_billing:giveBillingItem", function(player, reason, society, amount)
    giveItem(source, player, reason, society, amount)
end)

RegisterNetEvent("ars_billing:payBill", function(method, data)
    payBill(source, method, data)
end)


lib.versionCheck('Arius-Development/ars_disassemble_weapons')