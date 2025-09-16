local Lang = {}

Lang.Info = {
    currency = '€',
    cash = 'Contant',
    bank = 'Bank',
    level = 'Niveau: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Je kunt de metaaldetector niet gebruiken in een voertuig!',
    alreadyDetecting = 'Je gebruikt al de metaaldetector!',
    broke = 'Je hebt niet genoeg geld om dit te kopen!',
    noItems = 'Je hebt geen %s om te verkopen',
    noClump = 'Je hebt geen klontjes om te wassen!',
}

Lang.Success = {
    foundSomething = 'Je hebt iets gevonden!',
    levelUp = 'Je bent naar niveau %s gestegen!',
    sold = 'Je hebt %s items verkocht voor €%s',
    clumpWash = 'Je hebt een klontje gewassen en kreeg %s',
}

Lang.Progress = {
    dig = 'Bezig met graven naar je vondsten!',
    wash = 'Bezig met wassen van je klontje!',
}

Lang.DrawText = {
    success = 'Scannen naar metalen onder u',
    fail = 'Kan dit materiaal niet scannen'
}
Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Koop metaaldetector voor €%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Betaalmethode',
                title = 'Kies je betaalmethode',
            }
        },
        targ2 = {
            label = 'Items verkopen',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Alles verkopen',
            menuDescription = '€%s per stuk',
            header = 'Metaaldetector Verkopen'
        }
    },
    wash = {
        label = 'Klontje wassen',
        icon = 'fas fa-water',
    }
}

return Lang