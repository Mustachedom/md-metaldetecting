local Lang = {}

Lang.Info = {
    currency = '$',
    cash = 'Cash',
    bank = 'Bank',
    level = 'Level:  | %s | XP: %s / %s',
}

Lang.DrawText = {
    success = 'Scanning For Metals Under You',
    fail = 'Cant Scan This Material',
}

Lang.Fails = {
    inVehicle = 'You cannot use the metal detector in a vehicle!',
    alreadyDetecting = 'You are already using the metal detector!',
    broke = 'You Are Too Broke To Buy This!',
    noItems = 'You Dont Have Any %s To Sell',
    noClump = 'You Dont Have Any Clumps To Wash',
}

Lang.Success = {
    foundSomething = 'You found something!',
    levelUp = 'You leveled up to level %s!',
    sold = ' You Sold %s items for ' .. Lang.Info.currency..'%s',
    clumpWash = 'You Washed A Clump And Got %s'
}

Lang.Progress = {
    dig = 'Digging Up Your Findings!',
    wash = 'Washing Your Clump!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Buy Metal Detector For '..Lang.Info.currency..'%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Payment Type',
                title = 'Choose Your Payment Method',
            }
        },
        targ2 = {
            label = 'Sell Items',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Sell All',
            menuDescription = Lang.Info.currency..'%s Each',
            header = 'Metal Detector Sales'
        }
    },
    wash = {
        label = 'Wash Clump',
        icon = 'fas fa-water',
    }
}

return Lang