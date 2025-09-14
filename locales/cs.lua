local Lang = {}

Lang.Info = {
    currency = 'Kč',           -- Czech koruna
    cash = 'Hotovost',
    bank = 'Banka',
    level = 'Úroveň: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Nemůžeš použít kovodetektor ve vozidle!',
    alreadyDetecting = 'Už používáš kovodetektor!',
    broke = 'Nemáš dostatek peněz na nákup tohoto předmětu!',
    noItems = 'Nemáš žádné %s k prodeji',
    noClump = 'Nemáš žádné shluky k omytí!',
}

Lang.Success = {
    foundSomething = 'Našel jsi něco!',
    levelUp = 'Dosáhl jsi úrovně %s!',
    sold = 'Prodal jsi %s kusů za ' .. Lang.Info.currency .. '%s',
    clumpWash = 'Omyl jsi shluk a získal jsi %s',
}

Lang.Progress = {
    dig = 'Vykopávám tvé nálezy!',
    wash = 'Myju tvůj shluk!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Koupit kovodetektor za ' .. Lang.Info.currency .. '%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Typ platby',
                title = 'Vyber způsob platby',
            }
        },
        targ2 = {
            label = 'Prodat předměty',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Prodat vše',
            menuDescription = Lang.Info.currency .. '%s každý',
            header = 'Prodej z kovodetektoru'
        }
    },
    wash = {
        label = 'Omyt shluku',
        icon = 'fas fa-water',
    }
}

return Lang