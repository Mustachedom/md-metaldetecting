local Lang = {}

Lang.Info = {
    currency = '€',            -- Euro symbol
    cash = 'Bargeld',
    bank = 'Bank',
    level = 'Level: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Du kannst den Metalldetektor nicht in einem Fahrzeug verwenden!',
    alreadyDetecting = 'Du verwendest bereits den Metalldetektor!',
    broke = 'Du hast nicht genug Geld, um das zu kaufen!',
    noItems = 'Du hast keine %s zum Verkauf!',
    noClump = 'Du hast keine Klumpen zum Waschen!',
}

Lang.Success = {
    foundSomething = 'Du hast etwas gefunden!',
    levelUp = 'Du hast Level %s erreicht!',
    sold = 'Du hast %s Items für ' .. Lang.Info.currency .. '%s verkauft.',
    clumpWash = 'Du hast einen Klumpen gewaschen und hast %s erhalten.',
}
Lang.DrawText = {
    success = 'Scanne nach Metallen unter dir',
    fail = 'Kann dieses Material nicht scannen',
}

Lang.Progress = {
    dig = 'Grabe deine Funde aus!',
    wash = 'Wasche deinen Klumpen!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Metalldetektor kaufen für ' .. Lang.Info.currency .. '%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Zahlungsmethode',
                title = 'Wähle deine Zahlungsart',
            }
        },
        targ2 = {
            label = 'Items verkaufen',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Alle verkaufen',
            menuDescription = Lang.Info.currency .. '%s jedes',
            header = 'Metalldetektor-Verkäufe'
        }
    },
    wash = {
        label = 'Klumpen waschen',
        icon = 'fas fa-water',
    }
}

return Lang