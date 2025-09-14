local Lang = {}

Lang.Info = {
    currency = '₺',
    cash = 'Nakit',
    bank = 'Banka',
    level = 'Seviye: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Araç içinde metal dedektörü kullanamazsınız!',
    alreadyDetecting = 'Zaten metal dedektörünü kullanıyorsunuz!',
    broke = 'Bunu almak için yeterli paranız yok!',
    noItems = 'Satmak için hiç %s yok!',
    noClump = 'Yıkamak için hiçbir kütle yok!',
}

Lang.Success = {
    foundSomething = 'Bir şey buldunuz!',
    levelUp = '%s seviyesine ulaştınız!',
    sold = '%s adet ürünü %s₺ karşılığında sattınız',
    clumpWash = 'Bir kütle yıkanıyor ve %s elde ediliyor',
}

Lang.Progress = {
    dig = 'Buluntularınızı kazıyor!',
    wash = 'Kütlelerinizi yıkıyor!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Metal Dedektörü ' .. Lang.Info.currency .. '%s\'e Al',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Ödeme Türü',
                title = 'Ödeme Yönteminizi Seçin',
            }
        },
        targ2 = {
            label = 'Eşyaları Sat',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Hepsini Sat',
            menuDescription = Lang.Info.currency .. '%s Her Bir',
            header = 'Metal Dedektörü Satışları'
        }
    },
    wash = {
        label = 'Kütleyi Yıkama',
        icon = 'fas fa-water',
    }
}

return Lang