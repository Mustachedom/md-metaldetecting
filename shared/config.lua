Config = {}
Config.OxTarget = false -- true if you use ox target
Config.MetalDetectShop = vector4(-1113.45, -1689.03, 4.38, 150.53) -- where you buy a metal detector or sell loot founs
Config.Pricefordetector = 500 -- how much you pay for the metal detector
Config.InvWeblink = "nui://ps-inventory/html/images/"
Config.clumpwash = { -- place to wash out clumps 

vector3(-1247.79, -1542.34, 4.3),
vector3(-1250.03, -1541.78, 4.3),
vector3(-1252.35, -1541.27, 4.3),
}

---- level system rep
Config.lvl1 = 30
Config.lvl2 = 60
Config.lvl3 = 90
Config.lvl4 = 120
Config.lvl5 = 150
Config.lvl6 = 180
Config.lvl7 = 210
Config.lvl8 = 240
Config.lvl9 = 270
Config.lvl10 = 300

-- Wait Time in seconds 1000 = 1 second
Config.lvl1Wait = 30000
Config.lvl2Wait = 27000
Config.lvl3Wait = 24000
Config.lvl4Wait = 21000
Config.lvl5Wait = 18000
Config.lvl6Wait = 15000
Config.lvl7Wait = 12000
Config.lvl8Wait = 9000
Config.lvl9Wait = 7500
Config.lvl10Wait = 5000


Config.LootRare = { -- rare chance of finding these
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
}

Config.Loot = { -- more common chance
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
Config.LootSell = { -- items to be able to be sold at the sales point
    {name = "bobbypin", label = 'Bobby Pin', price = 25},
    {name = "bottlecap",label = 'Bottle Cap', price = 25},
    {name = "corno", label = 'Corno', price = 25},
    {name = "toycar", label = 'Toy Car', price = 25},
    {name = "goldring", label = 'Gold Ring', price = 25},
    {name = "1792coin", label = '1792 Coin', price = 25},
    {name = "1797coin", label = '1797 Coin', price = 25},
    {name = "diamondring", label = 'Diamond Ring', price = 25},
    {name = "golddiamondring", label = 'Gold Diamond Bracelet', price = 25},
    {name = "goldbracelet", label = 'Gold Bracelet', price = 25},
    {name = "rubyring", label = 'Ruby Ring', price = 25}, 
}