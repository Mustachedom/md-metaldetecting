local Lang = {}


Lang.Info = {
    currency = '€',
    cash = 'BAGS ON DIP',      
    bank = 'CLOUD WALLET',
    level = 'LEVEL: | %s | XP: %s / %s 🌟',
}

Lang.Fails = {
    inVehicle = '🚨 NO DETEKTOR IN THE RIDE! PARK IT OR GET OUTTA THE CLUB!',
    alreadyDetecting = '🎧 YOU’RE ALREADY ON THE FREQUENCY — DON’T DOUBLE-TAP!',
    broke = '💸 BROKE AF? GO GET A JOB… OR STEAL SOME BEATS.',
    noItems = '❌ NO %s? BRO, YOU GOT ZIP. GO DIG AGAIN.',
    noClump = '🧱 NO CLUMPS? THEN WHY ARE YOU STANDING HERE LIKE A DOORSTOP?',
}


Lang.Success = {
    foundSomething = '🎉 BOOM! SOMETHING JUST HIT THE FLOOR — YOU FOUND IT! 🔍💎',
    levelUp = '🔥 LEVEL UP TO %s! THE CROWD IS SCREAMING YOUR NAME! 🎤',
    sold = '💰 YOU SOLD %s ITEMS FOR ' .. Lang.Info.currency .. '%s — THAT’S A PLATINUM TRACK! 🏆',
    clumpWash = '🌊 WASHED A CLUMP? YOU JUST UNLOCKED %s — THAT’S GOLDEN HOUR, BABY! ✨',
}

Lang.Progress = {
    dig = '⛏️ DIGGING… THE BEAT IS BUILDING… 3… 2… 1… 💥',
    wash = '💧 WASHING… THE WATER’S GLOWING… YOU CAN FEEL IT COMING… 🔮',
}

Lang.DrawText = {
    success = 'SCANNING FOR METALS UNDER YOU — STAY TUNED! 📡',
    fail = '🚫 CAN’T SCAN THIS MATERIAL — SWITCH THE FREQUENCY!',
}
Lang.Targets = {
    shops = {
        targ1 = {
            label = '🛒 BUY METAL DETECTOR FOR ' .. Lang.Info.currency .. '%s — THIS IS YOUR FIRST MIXTAPE!',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'PAYMENT MODE',
                title = 'CHOOSE YOUR CURRENCY — CASH? CRYPTO? OR JUST GOOD VIBES?',
            }
        },
        targ2 = {
            label = 'SELL THE GOODS 📀',
            icon = 'fas fa-shopping-basket',
            sellAll = 'DROP ALL THE TRACKS',
            menuDescription = Lang.Info.currency .. '%s PER PIECE — THIS IS A BANGER PRICE!',
            header = '🔥 METAL DETECTOR SALES — TOP OF THE CHARTS 🔊',
        }
    },
    wash = {
        label = '💦 WASH THE CLUMP — TURN DIRT INTO DIAMONDS',
        icon = 'fas fa-water',
    }
}

return Lang