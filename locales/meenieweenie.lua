local Lang = {}

Lang.Info = {
    currency = '$',
    cash = 'Cash',
    bank = 'Bank',
    level = 'Level: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'You’re in a car. Again? You can’t even walk and detect metal. Get out.',
    alreadyDetecting = 'You’re still holding it. You haven’t found anything in 20 minutes. Put it down.',
    broke = 'You’re broke. Like, *pathetic* broke. Go get a real job.',
    noItems = 'You don’t have any %s? Of course you don’t. You’re useless.',
    noClump = 'No clumps? Then why are you even here? You’re wasting my time.',
}

Lang.Success = {
    foundSomething = 'Wow. You found something. Took long enough.',
    levelUp = 'Congrats. You’re level %s now. Still trash.',
    sold = 'You sold %s items for $%s. Congrats on not being a total loser today.',
    clumpWash = 'You washed a clump and got %s. I guess that’s something. Barely.',
}

Lang.Progress = {
    dig = 'Digging. Slowly. Like always.',
    wash = 'Washing. With the enthusiasm of a corpse.',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Buy Metal Detector For $%s — If You Can Afford It, Which You Can’t',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Payment Type',
                title = 'Choose Your Payment Method — Cash? Credit? Begging?',
            }
        },
        targ2 = {
            label = 'Sell Items — Assuming You Have Any',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Sell All — Please',
            menuDescription = '$%s Each — Don’t Get Too Excited',
            header = 'Metal Detector Sales — Your Only Hope'
        }
    },
    wash = {
        label = 'Wash Clump — Good Luck With That',
        icon = 'fas fa-water',
    }
}

return Lang