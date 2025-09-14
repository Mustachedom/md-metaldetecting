local detecting = false
local metalDetector = nil
local allowlist = {1288448767,1333033863, -1942898710, -1595148316,587194674,509508168, -1286696947,510490462, 1144315879, -461750719, 2128369009, 951832588, -1885547121  }

local function GetGroundHash()
	local coords = GetEntityCoords(PlayerPedId())
	local num = StartShapeTestCapsule(coords.x,coords.y,coords.z+4,coords.x,coords.y,coords.z-2.0, 1,1,PlayerPedId(),7)
	local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
	return arg5
end

local function createDetector()
	local pos = GetEntityCoords(PlayerPedId(), true)
	ps.requestModel("bostra_detector")
	metalDetector = CreateObject("bostra_detector", pos.x, pos.y, pos.z, true, true, true)
	AttachEntityToEntity(metalDetector, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005),  0.8, 0.06, 0.1, 5.0, -99.0, 56.0, true, true, false, true, 1, true)
	detecting = true
end

local function allowedGround()
	local ground = GetGroundHash()
	return ps.tableContains(allowlist, ground) or false, ground
end

local function stopDetecting()
	DetachEntity(metalDetector, true, true)
	DeleteObject(metalDetector)
	detecting = false
	metalDetector = nil
	ClearPedTasks(PlayerPedId())
	TriggerServerEvent('md-metaldetecting:server:stopDetecting')
end

local function find(ground)
	if not minigame() then
		return false
	end
	SetEntityVisible(metalDetector, false, 0)
	if not ps.progressbar(ps.lang('Progress.dig'), 8000, 'garden') then
		SetEntityVisible(metalDetector, true, 0)
		return false
	end
	SetEntityVisible(metalDetector, true, 0)
	TriggerServerEvent('md-metaldetecting:server:giveloot', ground)
	return true
end

RegisterNetEvent("md-metaldetect:client:startDetecting",function(time)
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		ps.notify(ps.lang('Fails.inVehicle'), 'error')
		TriggerServerEvent('md-fishing:server:stopFishing')
		return
	end
	if detecting then
		ps.notify(ps.lang('Fails.alreadyDetecting'), 'error')
		return
	end
	detecting = true
	createDetector()
	repeat
		local timer = time
		local groundBool, ground
		repeat
			Wait(1000)
			timer = timer - 1
			groundBool, ground = allowedGround()
		until timer == 0 or not detecting or not DoesEntityExist(metalDetector) or IsPedInAnyVehicle(PlayerPedId(), false) or not groundBool
		if not detecting then
			stopDetecting()
			return
		end
		if not DoesEntityExist(metalDetector) then
			stopDetecting()
			return
		end
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			ps.notify(ps.lang('Fails.inVehicle'), 'error')
			stopDetecting()
			return
		end
		if not groundBool then
			goto continue
		end
		ps.notify(ps.lang('Success.foundSomething'), 'success')
		Wait(1000)
		if not find(ground) then
			goto continue
		end
		::continue::
	until not detecting
end)

RegisterNetEvent("md-metaldetect:client:stopDetecting",function()
	detecting = false
	stopDetecting()
end)

local function initZones()
	local locations = ps.callback('md-metaldetecting:server:getLocs')
	for k, v in pairs (locations.shop) do
		if v.blipData and v.blipData.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
			SetBlipSprite (blip, v.blipData.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipData.scale)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, v.blipData.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipData.name)
			EndTextCommandSetBlipName(blip)
		end
		ps.requestModel(v.ped)
		local ped = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z - 1.0, v.loc.w, false, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
		ps.entityTarget(ped, {
			{
				label = ps.lang('Targets.shops.targ1.label', Config.Pricefordetector),
				icon = ps.lang('Targets.shops.targ1.icon'),
				action = function()
					local type = ps.input(ps.lang('Targets.shops.targ1.input.header'), {
						{type = 'select', options = {{label = ps.lang('Info.cash'), value = 'cash'}, {label = ps.lang('Info.bank'), value = 'bank'}}, title = ps.lang('Targets.shops.targ1.input.title'), required = true},
					})
					if not type then return end
					if type and not type[1] then
						return
					end
					TriggerServerEvent('md-metaldetecting:server:buyDetector', k, type[1])
				end
			},
			{
				label = ps.lang('Targets.shops.targ2.label'),
				icon = ps.lang('Targets.shops.targ2.icon'),
				action = function()
					local loot = ps.callback('md-metaldetecting:server:getLoot', k)
					if not loot then
						return
					end
					local menu = {}
					menu[#menu+1] = {
						title = ps.lang('Targets.shops.targ2.sellAll'),
						action = function()
							TriggerServerEvent('md-metaldetecting:server:sellLoot', k, 'all')
						end
					}
					for item, price in pairs(loot) do
						if ps.hasItem(item) then
							menu[#menu+1] = {
								title = ps.getLabel(item),
								description = ps.lang('Targets.shops.targ2.menuDescription', price),
								icon = ps.getImage(item),
								action = function()
									TriggerServerEvent('md-metaldetecting:server:sellLoot', k, item)
								end
							}
						end
					end
					ps.menu(ps.lang('Targets.shops.targ2.header'), ps.lang('Targets.shops.targ2.header'), menu)
				end
			}
		})
	end

	for k, v in pairs (locations.wash) do
		if v.blipData and v.blipData.enabled then
			local blip = AddBlipForCoord(v.loc.x, v.loc.y, v.loc.z)
			SetBlipSprite (blip, v.blipData.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipData.scale)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, v.blipData.color)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipData.name)
			EndTextCommandSetBlipName(blip)
		end
		ps.boxTarget('metalWash'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0}, {
			{
				label = ps.lang('Targets.wash.label'),
				icon = ps.lang('Targets.wash.icon'),
				action = function()
					if not minigame() then
						return
					end
					if not ps.progressbar(ps.lang('Progress.wash'), 10000, 'uncuff') then
						return
					end
					TriggerServerEvent('md-metaldetecting:server:washClump',k)
				end
			}
		})
	end
end

initZones()