## md-metaldetecting


<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://cdn.discordapp.com/attachments/1164709522691076120/1185676859363557457/Discord_logo.svg.png?ex=65907aa0&is=657e05a0&hm=dd2a8924c3a3d84507747ab2bac036e5fc219c697e084c9aa13ba468ff725bde&" width="100">
  </a><br>
</div>

## Dependencies :

- [ox_lib](https://github.com/overextended/ox_lib/releases)

- [qb-core](https://github.com/qbcore-framework/qb-core)

- [qb-target](https://github.com/qbcore-framework/qb-target) or [ox_target](https://github.com/overextended/ox_target)

- [ps-ui](https://github.com/Project-Sloth/ps-ui)

## How to install like a boss

Sure! Here's your part rewritten with more sarcasm and a polished tone:

---

## For Installing on QBX Core, Get Ready to Work!

### **Step 1:** PlayerData  
- Add this line to `qbx_core/server/player.lua` (around line 612) inside your existing player data:  
```lua
    playerData.metadata.metaldetecting = playerData.metadata.metaldetecting or 0
```  
- (Yes, I know. This is the kind of thrilling coding adventure you signed up for!)

---

### **Step 2:** Pet a Cat  
- Absolutely critical. Find a cat, give it a good pet, and only then are you worthy to proceed. *(Totally forgot to mention this earlier. My bad.)*

---

### **Step 3:** Add Items  
- Copy and paste the following glorious code into `ox_inventory/data/items.lua` because, you know, magic doesn't happen on its own:  
```lua
	["golddiamondring"] = {
		label = "Gold Diamond Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "It's a gold ring with a diamond?",
		client = {
			image = "golddiamondring.png",
		}
	},

	["goldbracelet"] = {
		label = "Gold Bracelet",
		weight = 100,
		stack = true,
		close = true,
		description = "Is this bracelet real gold?",
		client = {
			image = "goldbracelet.png",
		}
	},

	["goldring"] = {
		label = "Golden Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "My precious",
		client = {
			image = "goldring.png",
		}
	},

	["rubyring"] = {
		label = "Ruby Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "It is a ruby, not a rubix",
		client = {
			image = "rubyring.png",
		}
	},

	["bottlecap"] = {
		label = "Bottle Cap",
		weight = 100,
		stack = true,
		close = true,
		description = "Stepped on a pop top",
		client = {
			image = "bottlecap.png",
		}
	},

	["corno"] = {
		label = "Corno",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "corno.png",
		}
	},

	["toycar"] = {
		label = "Toy Car",
		weight = 100,
		stack = true,
		close = true,
		description = "Don't put it in odd places",
		client = {
			image = "toycar.png",
		}
	},

	["metaldetector"] = {
		label = "Metal Detector",
		weight = 2500,
		stack = true,
		close = true,
		description = "Maybe it can find things",
		client = {
			image = "metaldetector.png",
		}
	},

	["1797coin"] = {
		label = "1797 Coin",
		weight = 100,
		stack = true,
		close = true,
		description = "Dat's old",
		client = {
			image = "1797coin.png",
		}
	},

	["bobbypin"] = {
		label = "Bobby Pin",
		weight = 100,
		stack = true,
		close = true,
		description = "Put your hair up",
		client = {
			image = "bobbypin.png",
		}
	},

	["1792coin"] = {
		label = "1792 Coin",
		weight = 100,
		stack = true,
		close = true,
		description = "Even older",
		client = {
			image = "1792coin.png",
		}
	},

	["diamondring"] = {
		label = "Diamond Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "Pretty sure some poor kid made this",
		client = {
			image = "diamondring.png",
		}
	},

	["clump"] = {
		label = "Clump",
		weight = 100,
		stack = true,
		close = true,
		description = "Not a turd",
		client = {
			image = "clump.png",
		}
	},
```

---

### **Step 4:** Find Bostra  
- Locate [Bostra](https://discord.gg/K8gbPAgJ47), fight through the broken Discord link, and tell him he’s handsome. **This step is more important than adding the item images.** Struggle as necessary.

---

### **Step 5:** Add Item Images  
- Fine, if you’re feeling productive, go ahead and dump the item images into `qb-inventory/html/images` or `ox_inventory/web/images`.

---

### **Step 6:** Install the Folder  
- Place the `bostra_metaldetector` folder into your resources folder. Yes, you’re finally done, hero.  

---


**Step 1:**

- Pet a cat, Super important.

**Step 2:**

- Add the following to `qb-core/server/player.lua` inside your existing playerdata

```lua
	PlayerData.metadata['metaldetecting'] = PlayerData.metadata['metaldetecting'] or 0
```

![](https://cdn.discordapp.com/attachments/1164709522691076120/1185708813244977295/image.png?ex=65909862&is=657e2362&hm=614ac159f3ad3f08ed7f5b3811aec2b2a405399959036d37b2783a5bb6ee7d09&)
 
**Step 3:**
Add items to your inventory you use.

`qb-core/shared/items.lua`

 ```lua
["1792coin"] 				    = {["name"] = "1792coin", 			    	["label"] = "1792 Coin", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "1792coin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Even older"},
["1797coin"] 				    = {["name"] = "1797coin", 			    	["label"] = "1797 Coin", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "1797coin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Dat's old"},
["bobbypin"] 				    = {["name"] = "bobbypin", 			    	["label"] = "Bobby Pin", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "bobbypin.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Put your hair up"},
["bottlecap"] 				    = {["name"] = "bottlecap", 			    	["label"] = "Bottle Cap", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "bottlecap.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Stepped on a pop top"},
["clump"] 				    	= {["name"] = "clump", 			    		["label"] = "Clump", 		     	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "clump.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Not a turd"},
["corno"] 				     	= {["name"] = "corno", 			    		["label"] = "Corno", 		     	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "corno.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = ""},
["diamondring"] 				= {["name"] = "diamondring", 			    ["label"] = "Diamond Ring", 		 ['weight'] = 100, 		["type"] = "item", 		["image"] = "diamondring.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Pretty sure some poor kid made this"},
["goldbracelet"] 				= {["name"] = "goldbracelet", 			    ["label"] = "Gold Bracelet", 		 ['weight'] = 100, 		["type"] = "item", 		["image"] = "goldbracelet.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Is this bracelet real gold?"},
["golddiamondring"] 			= {["name"] = "golddiamondring", 			["label"] = "Gold Diamond Ring", 	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "golddiamondring.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "It's a gold ring with a diamond?"},
["goldring"] 				    = {["name"] = "goldring", 			    	["label"] = "Golden Ring", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "goldring.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "My precious"},
["rubyring"] 				    = {["name"] = "rubyring", 			    	["label"] = "Ruby Ring", 		     ['weight'] = 100, 		["type"] = "item", 		["image"] = "rubyring.png", 			    ["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "It is a ruby, not a rubix"},
["toycar"] 				     	= {["name"] = "toycar", 			    	["label"] = "Toy Car", 		     	 ['weight'] = 100, 		["type"] = "item", 		["image"] = "toycar.png", 			    	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Don't put it in odd places"},
["metaldetector"] 				= {["name"] = "metaldetector", 			    ["label"] = "Metal Detector", 		 ['weight'] = 2500, 		["type"] = "item", 		["image"] = "metaldetector.png", 		["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,                     ["description"] = "Maybe it can find things"},
```

`ox_inventory/data/items.lua`

```lua
	["golddiamondring"] = {
		label = "Gold Diamond Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "It's a gold ring with a diamond?",
		client = {
			image = "golddiamondring.png",
		}
	},

	["goldbracelet"] = {
		label = "Gold Bracelet",
		weight = 100,
		stack = true,
		close = true,
		description = "Is this bracelet real gold?",
		client = {
			image = "goldbracelet.png",
		}
	},

	["goldring"] = {
		label = "Golden Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "My precious",
		client = {
			image = "goldring.png",
		}
	},

	["rubyring"] = {
		label = "Ruby Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "It is a ruby, not a rubix",
		client = {
			image = "rubyring.png",
		}
	},

	["bottlecap"] = {
		label = "Bottle Cap",
		weight = 100,
		stack = true,
		close = true,
		description = "Stepped on a pop top",
		client = {
			image = "bottlecap.png",
		}
	},

	["corno"] = {
		label = "Corno",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "corno.png",
		}
	},

	["toycar"] = {
		label = "Toy Car",
		weight = 100,
		stack = true,
		close = true,
		description = "Don't put it in odd places",
		client = {
			image = "toycar.png",
		}
	},

	["metaldetector"] = {
		label = "Metal Detector",
		weight = 2500,
		stack = true,
		close = true,
		description = "Maybe it can find things",
		client = {
			image = "metaldetector.png",
		}
	},

	["1797coin"] = {
		label = "1797 Coin",
		weight = 100,
		stack = true,
		close = true,
		description = "Dat's old",
		client = {
			image = "1797coin.png",
		}
	},

	["bobbypin"] = {
		label = "Bobby Pin",
		weight = 100,
		stack = true,
		close = true,
		description = "Put your hair up",
		client = {
			image = "bobbypin.png",
		}
	},

	["1792coin"] = {
		label = "1792 Coin",
		weight = 100,
		stack = true,
		close = true,
		description = "Even older",
		client = {
			image = "1792coin.png",
		}
	},

	["diamondring"] = {
		label = "Diamond Ring",
		weight = 100,
		stack = true,
		close = true,
		description = "Pretty sure some poor kid made this",
		client = {
			image = "diamondring.png",
		}
	},

	["clump"] = {
		label = "Clump",
		weight = 100,
		stack = true,
		close = true,
		description = "Not a turd",
		client = {
			image = "clump.png",
		}
	},
```

**Step 4:**

- Add items images to `qb-inventory/html/images` or `ox_inventory/web/images`

**Step 5:**

- Tell [Bostra](https://discord.gg/K8gbPAgJ47) he is handsome

**Step 6:**

- take the [bostra](https://discord.gg/K8gbPAgJ47)_metaldetector folder and place it in your resources folder
