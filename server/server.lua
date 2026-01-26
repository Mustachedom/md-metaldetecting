
local function checkDistance(src, pos, dist, event)
	local playerPos = GetEntityCoords(GetPlayerPed(src))
	local distance = #(vector3(playerPos.x, playerPos.y, playerPos.z) - vector3(pos.x, pos.y, pos.z))
	if distance >= dist then
		Bridge.Prints.Warn('FUCK FACE CHEATING')
		return false
	end
	return true
end

Bridge.Callback.Register('md-metaldetecting:server:getLocs', function(source) return locations end)

Bridge.Callback.Register('md-metaldetecting:server:getLoot', function(source, loc)
    local src = source
    if not checkDistance(src, locations['shop'][loc].loc, 5.0, 'md-metaldetecting:server:getLoot') then
        return false
    end
    return SellLoot
end)

local function getTime(level)
    return levels[level] or 55
end

local function coolDown(id)
    CreateThread(function()
        coolDowned[id] = true
        Wait(1000 * getTime(cachedSQL[id].level))
        coolDowned[id] = nil
    end)
end

local function checkSQL(source)
	local identifier = Bridge.Framework.GetPlayerIdentifier(source)
	if cachedSQL[identifier] then
		activeMetalDetectors[identifier] = {time = getTime(cachedSQL[identifier].level)}
		return
	end
	local levelData = MySQL.query.await("SELECT * FROM md_metaldetecting WHERE citizenid = ?", {identifier})
	if levelData and not levelData[1] then
		local first, last = Bridge.Framework.GetPlayerName(source)
		MySQL.query.await('INSERT INTO md_metaldetecting (citizenid, level, name) VALUES (?, ?,?)', {identifier, json.encode({level = 0, xp = 0}), first .. " " .. last})
		cachedSQL[identifier] = {
			level = 0,
			xp = 0
		}
		activeMetalDetectors[identifier] = {time = getTime(cachedSQL[identifier].level)}
		return
	end
	if levelData and levelData[1] then
		local level = json.decode(levelData[1].level)
		cachedSQL[identifier] = {
			level = level.level,
			xp = level.xp
		}
		activeMetalDetectors[identifier] = {time = getTime(cachedSQL[identifier].level)}
		return
	end
end

RegisterCommand('metaldetectLevel', function(source, args)
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if not cachedSQL[identifier] then
		local levelData = MySQL.query.await("SELECT * FROM md_metaldetecting WHERE citizenid = ?", {identifier})
		if levelData and not levelData[1] then
			local first, last = Bridge.Framework.GetPlayerName(source)
			MySQL.query.await('INSERT INTO md_metaldetecting (citizenid, level, name) VALUES (?, ?,?)', {identifier, json.encode({level = 0, xp = 0}), first .. " " .. last})
			cachedSQL[identifier] = {
				level = 0,
				xp = 0
			}
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Info.level', cachedSQL[identifier].level, cachedSQL[identifier].xp, levelUpAmount), 'success')
			return
		end
		if levelData and levelData[1] then
			local level = json.decode(levelData[1].level)
			cachedSQL[identifier] = {
				level = level.level,
				xp = level.xp
			}
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Info.level', cachedSQL[identifier].level, cachedSQL[identifier].xp, levelUpAmount), 'success')
			return
		end
	end
	Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Info.level', cachedSQL[identifier].level, cachedSQL[identifier].xp, levelUpAmount), 'success')
end, false)

local delay = {}
local function handleDelay(id)
	if delay[id] then return end
	CreateThread(function()
		delay[id] = true
		Wait(2000)
		delay[id] = nil
	end)
end

Bridge.Framework.RegisterUsableItem("metaldetector", function(source, item)
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		coolDowned[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	else
		if delay[identifier] then
			return
		end
		checkSQL(src)
		coolDown(identifier)
		handleDelay(identifier)
		TriggerClientEvent('md-metaldetect:client:startDetecting', src, getTime(cachedSQL[identifier].level))
	end
end)

RegisterNetEvent('md-metaldetecting:server:stopDetecting', function()
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		coolDowned[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	end
end)


RegisterServerEvent('md-metaldetecting:server:giveloot', function(ground)
	local src = source
    local identifier = Bridge.Framework.GetPlayerIdentifier(src)

	if not activeMetalDetectors[identifier] then return end
	if coolDowned[identifier] then return end
	if not cachedSQL[identifier] then return end
	if not Bridge.Tables.TableContains(allowlist, ground) then return end

	local rare, item  = math.random(1,100), nil
	if rare <= rareChance then
		item = loot.rare[math.random(1, #loot.rare)]
	else
		item = loot.common[math.random(1, #loot.common)]
	end

	local pData = cachedSQL[identifier]
	if Bridge.Inventory.AddItem(src, item, 1) then
		pData.xp = pData.xp + 1
		if pData.xp >= levelUpAmount then
			if pData.level < 10 then
				pData.level = pData.level + 1
				pData.xp = 0
				activeMetalDetectors[identifier] = nil
				coolDowned[identifier] = nil
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Success.levelUp', pData.level), 'success')
				TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
			end
		end
		MySQL.query.await('UPDATE md_metaldetecting SET level = ? WHERE citizenid = ?', {json.encode(pData), identifier})
		coolDown(identifier)
	end
end)

RegisterNetEvent('md-metaldetecting:server:buyDetector', function(loc, type)
	local src = source
	if not checkDistance(src, locations['shop'][loc].loc, 5.0, 'md-metaldetecting:server:buyDetector') then
		return
	end
	if Bridge.Framework.RemoveAccountBalance(src, type, Config.Pricefordetector) then
		Bridge.Inventory.AddItem(src, 'metaldetector', 1)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Fails.broke'), 'error')
	end
end)

RegisterNetEvent('md-metaldetecting:server:sellLoot', function(loc, item)
	local src = source
	if not checkDistance(src, locations['shop'][loc].loc, 5.0, 'md-metaldetecting:server:sellLoot') then
		return
	end
	if item == 'all' then
		local count, total = 0, 0
		for k, v in pairs(SellLoot) do
			local amount = Bridge.Inventory.GetItemCount(src, k)
			if amount and amount > 0 then
				if Bridge.Inventory.RemoveItem(src, k, amount) then
					Bridge.Framework.AddAccountBalance(src, 'cash', v * amount)
					count = count + amount
					total = total + (v * amount)
				end
			end
		end
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Success.sold', count, total), 'success')
		return
	end
	if not SellLoot[item] then
		return
	end
	local amount = Bridge.Inventory.GetItemCount(src, item)
	if amount and amount > 0 then
		if Bridge.Inventory.RemoveItem(src, item, amount) then
			Bridge.Framework.AddAccountBalance(src, 'cash', SellLoot[item] * amount)
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Success.sold', amount, SellLoot[item] * amount), 'success')
		end
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Fails.noItems', item), 'error')
	end
end)

RegisterNetEvent('md-metaldetecting:server:washClump', function(loc)
	local src = source
	if not checkDistance(src, locations['wash'][loc].loc, 5.0, 'md-metaldetecting:server:washClump') then
		return
	end
	local maths = math.random(1,100)
	local item = nil
	if maths <= math.floor(rareChance / 2) then
		item = loot.rare[math.random(1, #loot.rare)]
	else
		item = loot.common[math.random(1, #loot.common)]
	end
	if Bridge.Inventory.RemoveItem(src, 'clump', 1) then
		if item == 'clump' then
			repeat 
				item = loot.common[math.random(1, #loot.common)]
				Wait(10)
			until item ~= 'clump'
		end
		if Bridge.Inventory.AddItem(src, item, 1) then
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Success.clumpWash', item), 'success')
		end
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Fails.noClump'), 'error')
	end
end)

local function dropPlayer(src)
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	end
end

AddEventHandler('esx:playerDropped', function(source) dropPlayer(source) end)
AddEventHandler('QBCore:Server:OnPlayerUnload', function(source) dropPlayer(source) end)

RegisterCommand('resetMetaldetector', function(source)
	local src = source
	local identifier = Bridge.Framework.GetPlayerIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		coolDowned[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	end
	Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Success.reset'), 'success')
end, false)