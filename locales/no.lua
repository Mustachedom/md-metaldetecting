local Lang = {}

Lang.Info = {
    currency = 'kr',
    cash = 'Kontanter',
    bank = 'Bank',
    level = 'Level:  | %s | XP: %s / %s',
}

Lang.DrawText = {
    success = 'Skanner etter metaller under deg',
    fail = 'Kan ikke skanne dette materialet',
}

Lang.Fails = {
    inVehicle = 'Du kan ikke bruke metallsøkeren i et kjøretøy!',
    alreadyDetecting = 'Du bruker allerede metallsøkeren!',
    broke = 'Du har ikke råd til å kjøpe dette!',
    noItems = 'Du har ingen %s å selge',
    noClump = 'Du har ingen klumper å vaske',
}

Lang.Success = {
    foundSomething = 'Du fant noe!',
    levelUp = 'Du har nådd nivå %s!',
    sold = 'Du solgte %s varer for ' .. Lang.Info.currency..'%s',
    clumpWash = 'Du vasket en klump og fikk %s'
}

Lang.Progress = {
    dig = 'Graver opp funnene dine!',
    wash = 'Vasker klumpen din!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Kjøp metallsøker for '..Lang.Info.currency..'%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Betalingstype',
                title = 'Velg betalingsmetode',
            }
        },
        targ2 = {
            label = 'Selg varer',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Selg alle',
            menuDescription = Lang.Info.currency..'%s hver',
            header = 'Metallsøker salg'
        }
    },
    wash = {
        label = 'Vask klump',
        icon = 'fas fa-water',
    }
}

return Lang
