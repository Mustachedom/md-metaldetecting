ps.registerCallback('md-metaldetecting:server:getLocs', function(source)
    return locations
end)

ps.registerCallback('md-metaldetecting:server:getLoot', function(source, loc)
    local src = source
    if not ps.checkDistance(src, locations['shop'][loc].loc, 5.0) then
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

ps.createUseable("metaldetector", function(source, item)
	local src = source
	local identifier = ps.getIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		coolDowned[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	else
		if cachedSQL[identifier] then
			activeMetalDetectors[identifier] = {time = getTime(cachedSQL[identifier].level)}
			TriggerClientEvent('md-metaldetect:client:startDetecting', src, activeMetalDetectors[identifier].time)
			coolDown(identifier)
			return
		end
		local levelData = MySQL.query.await("SELECT * FROM md_metaldetecting WHERE citizenid = ?", {identifier})
		if levelData and levelData[1] then
			local level = json.decode(levelData[1].level)
			activeMetalDetectors[identifier] = {time = getTime(level.level)}
			cachedSQL[identifier] = {
				level = level.level,
				xp = level.xp
			}
			TriggerClientEvent('md-metaldetect:client:startDetecting', src, activeMetalDetectors[identifier].time)
			coolDown(identifier)
		end
	end
end)

RegisterNetEvent('md-metaldetecting:server:stopDetecting', function()
	local src = source
	local identifier = ps.getIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		coolDowned[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	end
end)
ps.versionCheck('md-metaldetecting', 'https://raw.githubusercontent.com/Mustachedom/md-metaldetecting/refs/heads/ps_lib/version.txt', 'https://github.com/Mustachedom/md-metaldetecting/tree/ps_lib')
RegisterServerEvent('md-metaldetecting:server:giveloot', function(ground)
	local src = source
    local identifier = ps.getIdentifier(src)
	if not activeMetalDetectors[identifier] then return end
	if coolDowned[identifier] then return end
	if not cachedSQL[identifier] then return end
	if not ps.tableContains(allowlist, ground) then return end
	local rare, item  = math.random(1,100), nil
	if rare <= rareChance then
		item = loot.rare[math.random(1, #loot.rare)]
	else
		item = loot.common[math.random(1, #loot.common)]
	end
	if ps.addItem(src, item, 1) then
		cachedSQL[identifier].xp = cachedSQL[identifier].xp + 1
		if cachedSQL[identifier].xp >= levelUpAmount then
			if cachedSQL[identifier].level < 10 then
				cachedSQL[identifier].level = cachedSQL[identifier].level + 1
				cachedSQL[identifier].xp = 0
				activeMetalDetectors[identifier] = nil
				coolDowned[identifier] = nil
				ps.notify(src, 'you leveled up', 'success')
				MySQL.query.await('UPDATE md_metaldetecting SET level = ? WHERE citizenid = ?', {json.encode(cachedSQL[identifier]), identifier})
				TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
				return
			else
				MySQL.query.await('UPDATE md_metaldetecting SET level = ? WHERE citizenid = ?', {json.encode(cachedSQL[identifier]), identifier})
				return
			end
		end
		MySQL.query.await('UPDATE md_metaldetecting SET level = ? WHERE citizenid = ?', {json.encode(cachedSQL[identifier]), identifier})
	end
end)

RegisterNetEvent('md-metaldetecting:server:buyDetector', function(loc, type)
	local src = source
	if not ps.checkDistance(src, locations['shop'][loc].loc, 5.0) then
		return
	end
	if ps.removeMoney(src, type, Config.Pricefordetector) then
		ps.addItem(src, 'metaldetector', 1)
	else
		ps.notify(src, 'You Broke', 'error')
	end
end)

RegisterNetEvent('md-metaldetecting:server:sellLoot', function(loc, item)
	local src = source
	if not ps.checkDistance(src, locations['shop'][loc].loc, 5.0) then
		return
	end
	if item == 'all' then
		local count, total = 0, 0
		for k, v in pairs(SellLoot) do
			local amount = ps.getItemCount(src, k)
			if amount and amount > 0 then
				if ps.removeItem(src, k, amount) then
					ps.addMoney(src, 'cash', v * amount)
					count = count + amount
					total = total + (v * amount)
				end
			end
		end
		ps.notify(src, 'You sold '..count..' items for $'..total, 'success')
		return
	end
	if not SellLoot[item] then
		return
	end
	local amount = ps.getItemCount(src, item)
	if amount and amount > 0 then
		if ps.removeItem(src, item, amount) then
			ps.addMoney(src, 'cash', SellLoot[item] * amount)
			ps.notify(src, 'You sold '..amount..' '..item..' for $'..(SellLoot[item] * amount), 'success')
		end
	else
		ps.notify(src, 'You dont have any '..item, 'error')
	end
end)

local function checkSQL(source)
	local identifier = ps.getIdentifier(source)
	if cachedSQL[identifier] then return end
	local levelData = MySQL.query.await("SELECT * FROM md_metaldetecting WHERE citizenid = ?", {identifier})
	if levelData and not levelData[1] then
		MySQL.query.await('INSERT INTO md_metaldetecting (citizenid, level, name) VALUES (?, ?,?)', {ps.getIdentifier(source), json.encode({level = 0, xp = 0}), ps.getPlayerName(source)})
		cachedSQL[identifier] = {
			level = 0,
			xp = 0
		}
		return
	end
	if levelData and levelData[1] then
		local level = json.decode(levelData[1].level)
		cachedSQL[identifier] = {
			level = level.level,
			xp = level.xp
		}
		return
	end
end

local function dropPlayer(src)
	local identifier = ps.getIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	end
end

RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function() checkSQL(source) end)
AddEventHandler('esx:playerLoaded', function(source) checkSQL(source) end)
AddEventHandler('esx:playerDropped', function(source) dropPlayer(source) end)
AddEventHandler('QBCore:Server:OnPlayerUnload', function(source) dropPlayer(source) end)