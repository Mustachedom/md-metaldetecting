local Lang = {}

Lang.Info = {
    currency = '$',
    cash = 'Booty',
    bank = 'Buried Treasure Chest',
    level = 'Rank: | %s | XP: %s / %s',
}

Lang.Fails = {
    inVehicle = 'Arrr! Ye cannae use the metal detector on a ship, ye landlubber!',
    alreadyDetecting = 'Ye be usin’ it already! Put it down before I make ye walk the plank!',
    broke = 'No gold? Ye’re poorer than a barnacle on a dead whale!',
    noItems = 'Ye got no %s to sell? Then ye ain’t worth the rum in me cup!',
    noClump = 'No clumps? Ye been diggin’ with yer bare hands, ya salty dog!',
}

Lang.Success = {
    foundSomething = 'YARRR! A TREASURE! THE SEA ITSELF BE GUIDIN’ YE!',
    levelUp = 'YE’VE RAISED YER RANK TO %s! THE CREW JUST BOOSED YE WITH WHISKEY!',
    sold = 'Ye sold %s items for Pieces o\' Eight %s — THAT’S A FORTUNE, YA SCURVY BASTARD!',
    clumpWash = 'Ye washed a clump an’ got %s! That’s gold, matey — or better yet… DRAGON’S TEETH!',
}

Lang.Progress = {
    dig = 'DIGGIN’ LIKE A RAT IN A BARREL! THE TREASURE BE NEAR!',
    wash = 'SCRUBBIN’ THE MUD OFF! THE SEA’S GIVIN’ UP HER SECRETS!',
}

Lang.Targets = {
    shops = {
        targ1 = {
            label = 'Buy Metal Detector fer Pieces o\' Eight %s — OR DROWN TRYIN’!',
            icon = 'fas fa-shopping-basket',
            input = {
                header = 'Payment Type',
                title = 'Gimme yer gold, silver, or a shanty song!',
            }
        },
        targ2 = {
            label = 'Sell yer Loot',
            icon = 'fas fa-shopping-basket',
            sellAll = 'Dump It All!',
            menuDescription = 'Pieces o\' Eight %s each — NO HAGGLIN’!',
            header = 'Treasure Sales — CAPTAIN’S CUT FIRST!',
        }
    },
    wash = {
        label = 'Wash the Clump — TURN DIRT INTO GOLD!',
        icon = 'fas fa-water',
    }
}

return Lang