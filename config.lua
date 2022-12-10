Config = {}

Config.CommandName = "createbill"   -- Name of the command to open the create bill form
Config.ItemName = "fatture"         -- Name of the item to give to player
Config.RemoveItem = false           -- Remove item when bill paid
Config.MetadataOnItem = true        -- if true it will show details of the bill on item hover
Config.UseDiscordLogs = true
Config.CreateBillWebhook = "https://discord.com/api/webhooks/1051117156764504125/w7_3Kq9nIYuujfuXBl6NLYL_1mHh6SYBL9dNTng1omIaJfiCE6bgziQ9jWcRFFnjnjpi"
Config.PayBillWebhook = "https://discord.com/api/webhooks/1051117156764504125/w7_3Kq9nIYuujfuXBl6NLYL_1mHh6SYBL9dNTng1omIaJfiCE6bgziQ9jWcRFFnjnjpi"

Config.Lang = {

    mreason         = ">> Reason",
    msociety        = ">> Society",
    mfrom           = ">> From",
    mamount         = ">> Amount",
    mdate           = ">> Created On",
    mstatus         = ">> Status",
    mPaidDate       = ">> Paid On",

    billingTitle    = "Create Bill",
    reason          = "Reason",
    amount          = "Amount",
    sign            = "Sign",

    confermBill     = "Confem billing details",
    creatingBill    = "Creating bill",
    billCreated     = "Bill created for $",
    billCanceled    = "[Error] Bill creatioin canceled",
    noSign          = "[Error] Please sign the bill",
    noReason        = "[Error] Please provide a reason",
    noAmount        = "[Error] Please enter an valid amount",
    noPlayer        = "[Error] No players nearby",

    noMoney         = "[Error] You dont have enough money",
    xnoMoney         = "Client doesnt hvae enough money",
    billPaid        = "The bill has been paid for $",

    notPaid         = "Not paid",
    bill            = "Bill",

    createdFrom     = "Created From: ",
    fSociety        = "  \n  Society: ",
    fAmount         = "  \n Amount: $",
    fReason         = "  \n  Reason: ",
    fDate           = "  \n  *Stamp:* ",


    checkingDetails = "Checking details",
    paymentMethod   = "Payment Method",
    selectMethod    = "Select Method",
    payCash         = "Pay with cash",
    payBank         = "Pay with bank",
    noMethod        = "Please select a payment method",
    conferPayment   = "Conferm the payment of $",
    wrong           = "Something wrong!?",
    paid            = "Paid",
    alreadyPaid     = "This bill is already paid",
}