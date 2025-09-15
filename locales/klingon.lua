local Lang = {}

Lang.Info = {
    currency = 'QaD',
    cash = 'jaj',
    bank = 'Qapla’ jaj',
    level = 'Quch: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'DaH vIghro’ qeD. SuvwI’ qetlhwI’ ghoS!',
    alreadyDetecting = 'vIghro’ DaH qeD. Qatlh!',
    broke = 'jaj bIyI’? Quch qeD! SoH be’!',
    noItems = 'jajbogh %s QaQ? DaH vIghro’ bIyI’!',
    noClump = 'jajbogh Duj QaQ? DaH vIghro’ bIyI’!',
}

Lang.Success = {
    foundSomething = 'Qapla’! DaH vIghro’ yItlh!',
    levelUp = 'Qapla’! Quch %s jajwI’!',
    sold = 'DaH %s vIghro’ yItlh QaD %s!',
    clumpWash = 'Duj qIppu’! %s jajwI’ vIyI’!',
}

Lang.Progress = {
    dig = 'QeD… yItlh… Quch…',
    wash = 'Duj… qIppu’… jaj…',
}

Lang.DrawText = {
    success = 'QeD… yItlh… Quch…',
    fail = 'Duj… qIppu’… jaj…',
}
Lang.Targets = {
    shops = {
        targ1 = {
            label = 'qetlhwI’ DaH QaD %s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'jaj DaH',
                title = 'jaj Qapla’ Qo’',
            }
        },
        targ2 = {
            label = 'vIghro’ yItlh',
            icon = 'fas fa-shopping-basket',
            sellAll = 'vIghro’ yItlh QaQ',
            menuDescription = 'QaD %s vIghro’',
            header = 'vIghro’ yItlh Qapla’'
        }
    },
    wash = {
        label = 'Duj qIppu’',
        icon = 'fas fa-water',
    }
}

return Lang