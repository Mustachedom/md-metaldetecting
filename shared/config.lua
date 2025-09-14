Config = {}
ps = exports.ps_lib:init()
ps.loadLangs('en')

Config.Pricefordetector = 500 -- how much you pay for the metal detector

Config.Minigames = {
    ps_circle =     {amount = 2,     speed = 8,},
    ps_maze =       {timelimit = 15},
    ps_scrambler =  {type = 'numeric', time = 15, mirrored = 0},
    ps_var =        {numBlocks = 5, time = 10},
    ps_thermite =   {time = 10, gridsize = 5, incorrect = 3},
    ox =            {'easy', 'easy'},   --easy medium or hard each one corresponds to how many skillchecks and the difficulty
    blcirprog =     {amount = 2,     speed = 50},       -- speed = 1-100
    blprog =        {amount = 1,     speed = 50},       -- speed = 1-100
    blkeyspam =     {amount = 1,     difficulty = 50}, -- difficulty = 1-100
    blkeycircle =   {amount = 1,     difficulty = 50, keynumbers = 3},
    blnumberslide = {amount = 1,     difficulty = 50, keynumbers = 3},
    blrapidlines =  {amount = 1,     difficulty = 50, numberofline = 3},
    blcircleshake = {amount = 1,     difficulty = 50, stages = 3},
    glpath =        {gridSize = 19,  lives = 3,     timelimit = 10000},
    glspot =        {gridSize = 6, timeLimit = 999999, charSet = "alphabet", required = 10},
    glmath =        {timeLimit = 300000},
}

Config.minigametype = 'ox' -- look above for options or choose none if you dont want any minigames