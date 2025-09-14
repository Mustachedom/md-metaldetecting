local Lang = {}

Lang.Info = {
    currency = '€',
    cash = 'Efectivo',
    bank = 'Banco',
    level = 'Nivel: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'No puedes usar el detector de metales en un vehículo!',
    alreadyDetecting = '¡Ya estás usando el detector de metales!',
    broke = '¡No tienes suficiente dinero para comprar esto!',
    noItems = 'No tienes ningún %s para vender',
    noClump = 'No tienes ningún conglomerado para lavar!',
}

Lang.Success = {
    foundSomething = '¡Encontraste algo!',
    levelUp = '¡Subiste al nivel %s!',
    sold = 'Vendiste %s artículos por ' .. Lang.Info.currency .. '%s',
    clumpWash = 'Lavaste un conglomerado y obtuviste %s',
}

Lang.Progress = {
    dig = '¡Excavando tus hallazgos!',
    wash = '¡Lavando tu conglomerado!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Comprar detector de metales por ' .. Lang.Info.currency .. '%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Tipo de pago',
                title = 'Elige tu método de pago',
            }
        },
        targ2 = {
            label = 'Vender artículos',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Vender todo',
            menuDescription = Lang.Info.currency .. '%s cada uno',
            header = 'Ventas del detector de metales'
        }
    },
    wash = {
        label = 'Lavar conglomerado',
        icon = 'fas fa-water',
    }
}

return Lang