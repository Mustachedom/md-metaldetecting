local Lang = {}

Lang.Info = {
    currency = 'XD $',
    cash = ' cwyashy ',
    bank = ' bwingky ',
    level = ' wevew: | %s | XP: %s / %s uwu ',
}

Lang.Fails = {
    inVehicle = ' nyah~ u can’t use da metal detektow in a vewhicwe, silly goose! >_< ',
    alreadyDetecting = ' owo you’we awweady using it!! stop twyin’ dat twick! *nuzzles detector* ',
    broke = ' no moneh? nyaa~ u’we pwowerwess than a baby bunny w/o a carrot!! 💔 ',
    noItems = ' no %s? pwease tell me u didn’t dig fow hours and found… nuffin’?! T_T ',
    noClump = ' no cwumps? but… but de earth is crying! *sniffles* go find moar, pwease? ',
}

Lang.Success = {
    foundSomething = ' OMOGOSH U FOUND SOMETHING!!! 🥺💖✨ *dances in sparkles* ',
    levelUp = ' WOAH!!! U WEVE WEACHED WEVEL %s!!! THE SKY IS PINK AND CANDY CANES ARE FALLING!!! 🌈🍭 ',
    sold = ' u sowd %s items fow $%s!!! U’WE A WICHED MERCHANT NOW!!! *bows with tiara* ',
    clumpWash = ' u washed a cwump an’ got %s!!! IT’S SHINING WIKE A UNICOWN’S TEARS!!! ✨🦄💧 ',
}

Lang.Progress = {
    dig = ' diggy-diggy~ *bunny hops with spade* … so much dirt… so much… *sniff* … magic… ',
    wash = ' splash-splash~ *puppy eyes* … de water’s singing… de cwump’s dreamin’… *whispers* … it’s gonna be gowld… ',
}
Lang.DrawText = {
   success = "Scanny-wanny fow metaws undew you >w<",
    fail = "Canny scan dis matewiaw ( つ﹏⊂ )",
}
Lang.Targets = {
    shops = {
        targ1 = {
            label = ' buy da metaw detektow fow $%s uwu (i’ww give u a wittle hug if u do!) 🤗 ',
            icon = 'fas fa-shopping-basket',
            input = {
                header = ' paymwent type~ ',
                title = ' choose yow paymwent… cash? cuddwes? ow a smowwy face? 😢 ',
            }
        },
        targ2 = {
            label = ' seww itemz uwu ',
            icon = 'fas fa-shopping-basket',
            sellAll = ' seww aww da thangs!! ',
            menuDescription = '$%s each — but i’ww give u 50% off if u say “pwease” uwu ',
            header = ' metaw detektow sawes!! 🐰💎🎀 ',
        }
    },
    wash = {
        label = ' wash da cwump ~*cute sparkle noises*~ ',
        icon = 'fas fa-water',
    }
}

return Lang