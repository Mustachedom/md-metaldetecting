local Lang = {}

Lang.Info = {
    currency = '$',
    cash = 'Ashcay',
    bank = 'Ankbay',
    level = 'EvelLay: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Ouy ayccan otu eth etalm ectorday in a ehiclevay!',
    alreadyDetecting = 'Ouy areway alreadyway usingay eth etalm ectorday!',
    broke = 'Ouy aray ootay okebray otay uybay isthay!',
    noItems = 'Ouy ontday avehay anyway %s otay ellsay',
    noClump = 'Ouy ontday avehay anyway lumpsclay otay ashway',
}

Lang.Success = {
    foundSomething = 'Ouy oundfay omethingsay!',
    levelUp = 'Ouy eveledlay upway otay evelay %s!',
    sold = ' Ouy oldsay %s itemsay orfay $%s',
    clumpWash = 'Ouy ashedway Away lumpsclay Andway Otgay %s',
}

Lang.Progress = {
    dig = 'Igginday Upway Ouryay indingsfay!',
    wash = 'Ashingway Ouryay lumpsclay!',
}
Lang.DrawText = {
    success = "Anningscay Orfay Etalsmay Underay Ouyay",
    fail = "Antcay Anscay Isthay Aterialmay",
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Uybay Etalm Ectorday Orfay $%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Aymentpay Ypetay',
                title = 'Hoosce Ouryay Aymentpay Ethodmay',
            }
        },
        targ2 = {
            label = 'Ellsay Itemsway',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Ellsay Allay',
            menuDescription = '$%s ACHay',
            header = 'Etalm Ectorday ALESSAY',
        }
    },
    wash = {
        label = 'Ashway LUMPSCLAY',
        icon = 'fas fa-water',
    }
}

return Lang