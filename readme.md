## md-metaldetecting


<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://cdn.discordapp.com/attachments/1164709522691076120/1185676859363557457/Discord_logo.svg.png?ex=65907aa0&is=657e05a0&hm=dd2a8924c3a3d84507747ab2bac036e5fc219c697e084c9aa13ba468ff725bde&" width="100">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx">Mustache Scripts Discord</a><br>
</div>


## Dependencies :

- [ox_lib](https://github.com/overextended/ox_lib/releases)

- [qb-core](https://github.com/qbcore-framework/qb-core)

- [qb-target](https://github.com/qbcore-framework/qb-target) or [ox_target](https://github.com/overextended/ox_target)

- [ps-ui](https://github.com/Project-Sloth/ps-ui)

## How to install like a boss

**step 1**

- Pet a cat, Super important.

**step 2**

- Add the following to `qb-core/server/player.lua` inside your existing playerdata

```lua
	PlayerData.metadata['metaldetecting'] = PlayerData.metadata['metaldetecting'] or 0
```

![](https://cdn.discordapp.com/attachments/1164709522691076120/1185708813244977295/image.png?ex=65909862&is=657e2362&hm=614ac159f3ad3f08ed7f5b3811aec2b2a405399959036d37b2783a5bb6ee7d09&)
 
**step 3**
 
- Add the following Items to `qb-core/shared/items.lua`

 ```lua
["1792coin"] 				    = {["name"] = "1792coin", 			    	["label"] = "1792 Coin", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "1792coin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["1797coin"] 				    = {["name"] = "1797coin", 			    	["label"] = "1797 Coin", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "1797coin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["bobbypin"] 				    = {["name"] = "bobbypin", 			    	["label"] = "Bobby Pin", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "bobbypin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["bottlecap"] 				    = {["name"] = "bottlecap", 			    	["label"] = "Bottle Cap", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "bottlecap.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["clump"] 				    	= {["name"] = "clump", 			    		["label"] = "Clump", 		     	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "clump.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["corno"] 				     	= {["name"] = "corno", 			    		["label"] = "Corno", 		     	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "corno.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["diamondring"] 				= {["name"] = "diamondring", 			    ["label"] = "Diamond Ring", 		 ['weight'] = 100, 		["type"] = "item", 		["image"] = "diamondring.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["goldbracelet"] 				= {["name"] = "goldbracelet", 			    ["label"] = "Gold Bracelet", 		 ['weight'] = 100, 		["type"] = "item", 		["image"] = "goldbracelet.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["golddiamondring"] 			= {["name"] = "golddiamondring", 			["label"] = "Gold Diamond Ring", 	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "golddiamondring.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["goldring"] 				    = {["name"] = "goldring", 			    	["label"] = "Golden Ring", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "goldring.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["rubyring"] 				    = {["name"] = "rubyring", 			    	["label"] = "Ruby Ring", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "rubyring.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["toycar"] 				     	= {["name"] = "toycar", 			    	["label"] = "Toy Car", 		     	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "toycar.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["metaldetector"] 				= {["name"] = "metaldetector", 			    ["label"] = "Metal Detector", 		 ['weight'] = 100, 		["type"] = "item", 		["image"] = "leatherheadturtle.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},

```

**step 4**

- Add items images to `qb-inventory/html/images`

**step 5**

- Tell  [Bostra](https://discord.gg/K8gbPAgJ47) he is handsome again

**step 6**

- take the [bostra](https://discord.gg/K8gbPAgJ47)_metaldetecor folder and place it in your resources folder
