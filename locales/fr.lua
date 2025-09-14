local Lang = {}

Lang.Info = {
    currency = '€',
    cash = 'Espèces',
    bank = 'Banque',
    level = 'Niveau : | %s | XP : %s / %s',
}

Lang.Fails = {
    inVehicle = 'Vous ne pouvez pas utiliser le détecteur de métaux dans un véhicule !',
    alreadyDetecting = 'Vous utilisez déjà le détecteur de métaux !',
    broke = 'Vous n\'avez pas assez d\'argent pour acheter cela !',
    noItems = 'Vous n\'avez aucun %s à vendre',
    noClump = 'Vous n\'avez aucun amas à laver !',
}

Lang.Success = {
    foundSomething = 'Vous avez trouvé quelque chose !',
    levelUp = 'Vous êtes passé au niveau %s !',
    sold = 'Vous avez vendu %s articles pour ' .. Lang.Info.currency .. '%s',
    clumpWash = 'Vous avez lavé un amas et obtenu %s',
}

Lang.Progress = {
    dig = 'Creusant vos découvertes !',
    wash = 'Lavant votre amas !',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Acheter un détecteur de métaux pour ' .. Lang.Info.currency .. '%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Type de paiement',
                title = 'Choisissez votre méthode de paiement',
            }
        },
        targ2 = {
            label = 'Vendre des objets',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Vendre tout',
            menuDescription = Lang.Info.currency .. '%s chaque',
            header = 'Ventes du détecteur de métaux'
        }
    },
    wash = {
        label = 'Laver l’amas',
        icon = 'fas fa-water',
    }
}

return Lang