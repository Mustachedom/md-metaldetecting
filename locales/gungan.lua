local Lang = {}

Lang.Info = {
    currency = 'Gungan Gold',
    cash = 'Boga',
    bank = 'Oto Boga',
    level = 'Nub: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Nub boga wok! No detector in vehicle!',
    alreadyDetecting = 'Wok wok! You use detector now!',
    broke = 'Boga fen? No buy! You no have money!',
    noItems = 'No %s? You no have to sell!',
    noClump = 'No gloop? You no have to wash!',
}

Lang.Success = {
    foundSomething = 'WOOOSH! You find something! Gungan lucky!',
    levelUp = 'NUB WOK! You rise to level %s! The swamp cheers!',
    sold = 'You sell %s thing for Gungan Gold %s! Boga big!',
    clumpWash = 'Gloop wash! You get %s! The river sings!',
}

Lang.Progress = {
    dig = 'Diggy diggy... Gungan work hard!',
    wash = 'Splash splash... Gloop go clean!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Buy detector for Gungan Gold %s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Boga Type',
                title = 'Choose your boga — water or gold?',
            }
        },
        targ2 = {
            label = 'Sell thing',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Sell all boga',
            menuDescription = 'Gungan Gold %s each',
            header = 'Detector Sell Place'
        }
    },
    wash = {
        label = 'Wash gloop',
        icon = 'fas fa-water',
    }
}

return Lang