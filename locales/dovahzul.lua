local Lang = {}

Lang.Info = {
    currency = 'Krii',
    cash = 'Zol',
    bank = 'Dovah Viik',
    level = 'Kron: | %s | Dovahkiin XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Fus Ro Dah! Krosis! Vos thu vod krii dovah.',
    alreadyDetecting = 'Vos thu',
    broke = 'Zol fen kruziin? Tii zeyn.',
    noItems = 'Zol fen %s? Do thu vahriin.',
    noClump = 'Fen drem ol vul? Do thu vahriin.',
}

Lang.Success = {
    foundSomething = 'FUS! RO! DAH! Nuzdovah!',
    levelUp = 'KRON DOVAH! Kron %s! Dovah kiin dovah.',
    sold = 'ZOL DOVAKIIN! %s vokrii Krii %s.',
    clumpWash = 'VOLUN! %s do volun.',
}

Lang.DrawText = {
    success = 'FUS... RO... DAH... ZYLAAN.',
    fail    = 'VOLUN... ZOUN... LOK.',
}
Lang.Progress = {
    dig  = 'FUS... RO... DAH... ZYLAAN.',
    wash = 'VOLUN... ZOUN... LOK.',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Dovah Viik Krii %s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Zol Fen',
                title = 'Zol Dovah Viik',
            }
        },
        targ2 = {
            label = 'Vokrii %s',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Vokrii Dovah Viik',
            menuDescription = 'Krii %s vokrii',
            header = 'Dovah Viik Vokrii',
        }
    },
    wash = {
        label = 'Volun Drem',
        icon = 'fas fa-water',
    }
}

return Lang