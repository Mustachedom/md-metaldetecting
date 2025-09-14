local Lang = {}

Lang.Info = {
    currency = 'R$',
    cash = 'Dinheiro',
    bank = 'Banco',
    level = 'Nível: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Você não pode usar o detector de metais dentro de um veículo!',
    alreadyDetecting = 'Você já está usando o detector de metais!',
    broke = 'Você não tem dinheiro suficiente para comprar isso!',
    noItems = 'Você não tem nenhum %s para vender',
    noClump = 'Você não tem nenhum aglomerado para lavar!',
}

Lang.Success = {
    foundSomething = 'Você encontrou algo!',
    levelUp = 'Você subiu para o nível %s!',
    sold = 'Você vendeu %s itens por R$%s',
    clumpWash = 'Você lavou um aglomerado e obteve %s',
}

Lang.Progress = {
    dig = 'Escavando suas descobertas!',
    wash = 'Lavando seu aglomerado!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Comprar detector de metais por R$%s',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Tipo de pagamento',
                title = 'Escolha seu método de pagamento',
            }
        },
        targ2 = {
            label = 'Vender itens',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Vender tudo',
            menuDescription = 'R$%s cada',
            header = 'Vendas do detector de metais'
        }
    },
    wash = {
        label = 'Lavar aglomerado',
        icon = 'fas fa-water',
    }
}

return Lang