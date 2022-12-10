function useBillingItem(data)
    exports.ox_inventory:useItem(data, function(data)
        local metadata = data.metadata

        if metadata.status == Config.Lang.notPaid then
            amount = metadata.amount
            local alert = lib.alertDialog({
                header = Config.Lang.bill,
                content = Config.Lang.createdFrom..metadata.from..Config.Lang.fSociety..metadata.society..Config.Lang.fAmount..amount..Config.Lang.fReason..metadata.reason..Config.Lang.fDate..metadata.date,
                centered = false,
                cancel = true
            })

            if alert == "confirm" then
                if lib.progressBar({
                    duration = 2000,
                    label = Config.Lang.checkingDetails,
                    useWhileDead = false,
                    allowCuffed = false,
                    allowFalling = false,
                    canCancel = true,
                    disable = {
                        mouse = true,
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
                    local input = lib.inputDialog(Config.Lang.paymentMethod, {
                        { type = 'select', label = Config.Lang.selectMethod, options = {
                            { value = 'money', label = Config.Lang.payCash},
                            { value = 'bank', label = Config.Lang.payBank},
                        }},
                    })
                    local method = input[1]
                    
                    if not method then return ESX.ShowNotification(Config.Lang.noMethod) end

                    local lastConfermation = lib.alertDialog({
                        header = Config.Lang.bill,
                        content = Config.Lang.conferPayment..amount,
                        centered = false,
                        cancel = true
                    })

                    if lastConfermation == "confirm" then
                        TriggerServerEvent("ars_billing:payBill", method, data)
                    end
                end
            else
                ESX.ShowNotification(Config.Lang.wrong)
            end
        else
            ESX.ShowNotification(Config.Lang.alreadyPaid)
        end
    end)
end

exports('useBillingItem', useBillingItem)
