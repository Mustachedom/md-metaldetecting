activeMetalDetectors = {} -- no touch
coolDowned = {}-- no touch
cachedSQL = {} -- no touch

----- SERIOUSLY DONT TOUCH ABOVE THIS -----
--- ILL FUCKING CRY IF YOU TOUCH IT -----
--- DO YOU WANT TO SEE A TINY MAN CRY? -----
--- BECAUSE THATS WHAT WILL HAPPEN -----
--- PLEASE DONT TOUCH IT -----
--- I MEAN IT -----
--- OKAY LAST WARNING -----
--- FUCKING LEAVE IT ALONE -----
--- OKAY BYE -----

levels = { -- time in seconds
    [0] = 55,
    [1] = 50,
    [2] = 45,
    [3] = 40,
    [4] = 35,
    [5] = 30,
    [6] = 25,
    [7] = 20,
    [8] = 15,
    [9] = 10,
    [10] = 5
}
levelUpAmount = 60 -- xp needed to level up

allowlist = { -- ground hashes that are allowed to find loot on || SHOULD MATCH line 4 client/client.lua
    1333033863, -1942898710, -1595148316, 587194674, 509508168, -1286696947, 510490462, 1144315879, -461750719, 2128369009, 951832588, -1885547121
}

rareChance = 10  -- % chance to find a rare item
loot = { -- items that can be found
    rare = { -- items that are more rare to find
        '1792coin',
        '1797coin',
        'diamondring',
        'goldbracelet',
        'golddiamondring',
        'rubyring',
        'steel',
        'metalscrap',
        'iron',
        'copper',
    },
    common = { -- items that are more common to find
        'bobbypin',
        'bottlecap',
        'clump',
        'corno',
        'toycar',
        'goldring',
        'steel',
        'metalscrap',
        'iron',
        'copper',
    }
}

locations = {
    shop = {
        {loc = vector4(-1113.45, -1689.03, 4.38, 150.53), ped = 'ig_priest', blipData = {sprite = 617, color = 5, scale = 0.7, name = "Metal Detector Shop", enabled = true}},
    },
    wash = {
        {loc = vector3(-1247.79, -1542.34, 4.3), blipData = {sprite = 318, color = 5, scale = 0.7, name = "Clump Washing", enabled = true}},
        {loc = vector3(-1250.03, -1541.78, 4.3), blipData = {sprite = 318, color = 5, scale = 0.7, name = "Clump Washing", enabled = true}},
        {loc = vector3(-1252.35, -1541.27, 4.3), blipData = {sprite = 318, color = 5, scale = 0.7, name = "Clump Washing", enabled = true}},
    }
}


SellLoot = { -- loot you can sell
    bobbypin = 25,
    bottlecap = 25,
    corno = 25,
    toycar = 25,
    goldring = 25,
    ['1792coin'] = 25,
    ['1797coin'] = 25,
    diamondring = 25,
    golddiamondring = 25,
    goldbracelet = 25,
    rubyring = 25,
}