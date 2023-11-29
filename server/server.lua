local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("metaldetector", function(source, item)
local Player = QBCore.Functions.GetPlayer(src)
local src = source

TriggerClientEvent("md-metaldetect:client:startdetecting", src)
end)

RegisterServerEvent('md-metaldetecting:server:giveloot', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local metaldetectitem =  Config.LootRare[math.random(1, #  Config.LootRare)] 
	local metaldetectlow =  Config.Loot[math.random(1, #Config.Loot)] 
	local curRep = Player.PlayerData.metadata["metaldetecting"]
	local chance = math.random(1,100)
	if chance <= 35 then 
		Player.Functions.AddItem('clump', 1) 
		TriggerClientEvent('QBCore:Notify', src, "You Got A Clump Of Dirt!", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['clump'], "add",  1)
		Player.Functions.SetMetaData('metaldetecting',  (curRep + 1))
	elseif chance >= 36 and chance <= 85 then
		Player.Functions.AddItem(metaldetectlow, 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. metaldetectlow .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[metaldetectlow], "add",  1)
		Player.Functions.SetMetaData('metaldetecting',  (curRep + 1))
		
	else
		Player.Functions.AddItem(metaldetectitem, 1)
		TriggerClientEvent('QBCore:Notify', src, "You Got " .. metaldetectitem .. " !", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[metaldetectitem], "add",  1)
		Player.Functions.SetMetaData('metaldetecting',  (curRep + 1))
	end	
end)

RegisterServerEvent('md-metaldetecting:server:cleanclump', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local metaldetectitem =  Config.LootRare[math.random(1, #  Config.LootRare)] 
	local metaldetectlow =  Config.Loot[math.random(1, #  Config.Loot)] 
	local chance = math.random(1,100)
	print(chance)
	if chance <= 50 then 
		if Player.Functions.RemoveItem('clump', 1) then
			Player.Functions.AddItem(metaldetectlow, 1)
			TriggerClientEvent('QBCore:Notify', src, "You Got " .. metaldetectlow .. " !", "success")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[metaldetectitem], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['clump'], "remove",  1)
		end
	elseif chance >= 51 and chance <= 80 then
		if Player.Functions.RemoveItem('clump', 1) then
			Player.Functions.AddItem(metaldetectitem, 1)
			TriggerClientEvent('QBCore:Notify', src, "You Got " .. metaldetectitem .. " !", "success")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[metaldetectitem], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['clump'], "remove",  1)
		end	
	else
		if Player.Functions.RemoveItem('clump', 1) then
			TriggerClientEvent('QBCore:Notify', src, "Nothing In This Clump!", "error")
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['clump'], "remove",  1)
		end
	end	
end)

RegisterServerEvent('md-metaldetecting:server:buydetector', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveMoney('bank', Config.Pricefordetector) or Player.Functions.RemoveMoney('cash', Config.Pricefordetector) then
		Player.Functions.AddItem('metaldetector', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['metaldetector'], "add",  1)
	end
end)	

RegisterServerEvent("md-metaldetecting:server:sellloot", function(amount, item, value)
	local src = source 
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem(item, tonumber(amount)) then
		Player.Functions.AddMoney('cash', tonumber(value) * tonumber(amount)) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
	else
	TriggerClientEvent('QBCore:Notify', src, "You cant Sell More Than You Have", "error")
	end
end)
