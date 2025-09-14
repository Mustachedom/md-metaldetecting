ps.registerCallback('md-metaldetecting:server:getLocs', function(source) return locations end)

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

ps.registerCommand('metaldetectLevel', {
},function(source, args)
	local src = source
	local identifier = ps.getIdentifier(src)
	if not cachedSQL[identifier] then
		local levelData = MySQL.query.await("SELECT * FROM md_metaldetecting WHERE citizenid = ?", {identifier})
		if levelData and not levelData[1] then
			MySQL.query.await('INSERT INTO md_metaldetecting (citizenid, level, name) VALUES (?, ?,?)', {ps.getIdentifier(source), json.encode({level = 0, xp = 0}), ps.getPlayerName(source)})
			cachedSQL[identifier] = {
				level = 0,
				xp = 0
			}
			ps.notify(src, ps.lang('Info.level', cachedSQL[identifier].level, cachedSQL[identifier].xp, levelUpAmount), 'success')
			return
		end
		if levelData and levelData[1] then
			local level = json.decode(levelData[1].level)
			cachedSQL[identifier] = {
				level = level.level,
				xp = level.xp
			}
			ps.notify(src, ps.lang('Info.level', cachedSQL[identifier].level, cachedSQL[identifier].xp, levelUpAmount), 'success')
			return
		end
	end
	ps.notify(src, ps.lang('Info.level', cachedSQL[identifier].level, cachedSQL[identifier].xp, levelUpAmount), 'success')
end)
ps.createUseable("metaldetector", function(source, item)
	local src = source
	local identifier = ps.getIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		coolDowned[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	else
		checkSQL(src)
		coolDown(identifier)
		TriggerClientEvent('md-metaldetect:client:startDetecting', src, getTime(cachedSQL[identifier].level))
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
	local pData = cachedSQL[identifier]
	if ps.addItem(src, item, 1) then
		pData.xp = pData.xp + 1
		if pData.xp >= levelUpAmount then
			if pData.level < 10 then
				pData.level = pData.level + 1
				pData.xp = 0
				activeMetalDetectors[identifier] = nil
				coolDowned[identifier] = nil
				ps.notify(src, ps.lang('Success.levelUp', pData.level), 'success')
				TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
			end
		end
		MySQL.query.await('UPDATE md_metaldetecting SET level = ? WHERE citizenid = ?', {json.encode(pData), identifier})
		coolDown(identifier)
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
		ps.notify(src, ps.lang('Fails.broke'), 'error')
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
		ps.notify(src, ps.lang('Success.sold', count, total), 'success')
		return
	end
	if not SellLoot[item] then
		return
	end
	local amount = ps.getItemCount(src, item)
	if amount and amount > 0 then
		if ps.removeItem(src, item, amount) then
			ps.addMoney(src, 'cash', SellLoot[item] * amount)
			ps.notify(src, ps.lang('Success.sold', amount, SellLoot[item] * amount), 'success')
		end
	else
		ps.notify(src, ps.lang('Fails.noItems', item), 'error')
	end
end)

RegisterNetEvent('md-metaldetecting:server:washClump', function(loc)
	local src = source
	if not ps.checkDistance(src, locations['wash'][loc].loc, 5.0) then
		return
	end
	local maths = math.random(1,100)
	local item = nil
	if maths <= rareChance then
		item = loot.rare[math.random(1, #loot.rare)]
	else
		item = loot.common[math.random(1, #loot.common)]
	end
	if ps.removeItem(src, 'clump', 1) then
		if ps.addItem(src, item, 1) then
			ps.notify(src, ps.lang('Success.clumpWash', item), 'success')
		end
	else
		ps.notify(src, ps.lang('Fails.noClump'), 'error')
	end
end)

local function dropPlayer(src)
	local identifier = ps.getIdentifier(src)
	if activeMetalDetectors[identifier] then
		activeMetalDetectors[identifier] = nil
		TriggerClientEvent('md-metaldetect:client:stopDetecting', src)
	end
end

AddEventHandler('esx:playerDropped', function(source) dropPlayer(source) end)
AddEventHandler('QBCore:Server:OnPlayerUnload', function(source) dropPlayer(source) end)