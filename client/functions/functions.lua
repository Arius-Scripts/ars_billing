function createBill()
    local closestPerson = lib.getClosestPlayer(GetEntityCoords(cache.ped), 3, false)
    local job = ESX.PlayerData.job.name
    local access = false

    for k, v in pairs(Config.AllowedJobs) do
        if job == v then
            access = true
            break
        end
    end

    if not access then return end
    if not closestPerson then return showNotification(Config.Lang.noPlayer) end

    local input = lib.inputDialog(Config.Lang.billingTitle, {
        { type = "input",    label = Config.Lang.reason, placeholder = "Reason ..." },
        { type = "number",   label = Config.Lang.amount, default = 1 },
        { type = "checkbox", label = Config.Lang.sign },
    })

    if not input then return end

    local reason = input[1]
    local amount = input[2]
    local conferm = input[3]

    if not reason then return showNotification(Config.Lang.noReason) end
    if not amount or amount < 1 then return showNotification(Config.Lang.noAmount) end
    if not conferm then return showNotification(Config.Lang.noSign) end

    local infoBox = lib.alertDialog({
        header = Config.Lang.confermBill,
        content = Config.Lang.amount ..
            ": $" .. amount .. "  \n" .. Config.Lang.reason .. ": " .. reason .. "  \n" ..
            Config.Lang.sign .. ": *𝔄𝔯𝔰-𝔟𝔦𝔩𝔩𝔦𝔫𝔤*",
        centered = false,
        cancel = true
    })

    if infoBox ~= "confirm" then return showNotification(Config.Lang.billCanceled) end

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
        })
    then
        TriggerServerEvent("ars_billing:giveBillingItem", GetPlayerServerId(closestPerson), reason, job, amount)
        showNotification(Config.Lang.billCreated .. amount)
    else
        showNotification(Config.Lang.billCanceled)
    end
end

function useBillingItem(data)
    exports.ox_inventory:useItem(data, function(data)
        local metadata = data.metadata

        if metadata.status == Config.Lang.notPaid then
            local amount = metadata.amount
            local content =
                Config.Lang.createdFrom ..
                metadata.from ..
                Config.Lang.fSociety ..
                metadata.society ..
                Config.Lang.fAmount ..
                amount ..
                Config.Lang.fReason ..
                metadata.reason ..
                Config.Lang.fDate ..
                metadata.date

            local alert = lib.alertDialog({
                header = Config.Lang.bill,
                content = content,
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
                        {
                            type = 'select',
                            label = Config.Lang.selectMethod,
                            options = {
                                { value = 'money', label = Config.Lang.payCash },
                                { value = 'bank',  label = Config.Lang.payBank },
                            }
                        },
                    })

                    if not input then return end

                    local method = input[1]

                    if not method then return showNotification(Config.Lang.noMethod) end

                    local lastConfermation = lib.alertDialog({
                        header = Config.Lang.bill,
                        content = Config.Lang.conferPayment .. amount,
                        centered = false,
                        cancel = true
                    })

                    if lastConfermation == "confirm" then
                        TriggerServerEvent("ars_billing:payBill", method, data)
                    end
                end
            else
                showNotification(Config.Lang.wrong)
            end
        else
            showNotification(Config.Lang.alreadyPaid)
        end
    end)
end

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

exports('useBillingItem', useBillingItem)



function showNotification(msg)
    ESX.ShowNotification(msg)
end
